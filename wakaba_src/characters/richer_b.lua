
local playerType = wakaba.Enums.Players.RICHER_B
local removed = false
local isRicherContinue = true
local isc = _wakaba.isc
if not REPENTOGON then
	wakaba:registerCharacterHealthConversion(wakaba.Enums.Players.RICHER_B, isc.HeartSubType.SOUL)
end

function wakaba:PostGetCollectible_Richer_b(player, item)
	if not player or player:GetPlayerType() ~= wakaba.Enums.Players.RICHER_B then return end
	player:AddSoulHearts(player:GetSoulHearts() * -1)
	player:AddMaxHearts(2)
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_Richer_b, CollectibleType.COLLECTIBLE_DEAD_CAT)

wakaba.TotalWisps = {}
local totalwisps = wakaba.TotalWisps
local hudLimit = wakaba.Enums.Constants.RICHER_B_HUD_LIMIT

--[[ wakaba.TaintedRicherSelectionSprite=Sprite()
wakaba.TaintedRicherSelectionSprite:Load("gfx/ui/wakaba/ui_richer_b.anm2",true)
wakaba.TaintedRicherSelectionSprite:SetFrame("HUD",0) ]]

local forceReset = false
function wakaba:ResetWispStatus()
	wakaba.TotalWisps = {}
	totalwisps = wakaba.TotalWisps
	forceReset = true
end

---@param player EntityPlayer
local function getRenderList(player)
	local renderList = {}
	local playerIndex = isc:getPlayerIndex(player)
	local limit = hudLimit
	if totalwisps[playerIndex] then
		local current = totalwisps[playerIndex]
		local list = current.list
		local index = current.index
		local tmp_index = index
		local empty = 0
		if #list < limit then
			empty = #list - limit
			limit = #list
		end
		while limit > 0 do
			if tmp_index > #list then
				tmp_index = 1
			end
			table.insert(renderList, list[tmp_index].SubType)
			tmp_index = tmp_index + 1
			limit = limit - 1
		end
	end
	if #renderList < hudLimit then
		for i = 1, hudLimit - #renderList do
			table.insert(renderList, 0)
		end
	end
	return renderList
end

_wakaba.tricher_yoffset = 30

-- Register HUD Helper for Tainted Richer
HudHelper.RegisterHUDElement({
	Name = "wakaba_TRicher",
	Priority = HudHelper.Priority.HIGHEST,
	XPadding = -4,
	YPadding = 0,
	---@param player EntityPlayer
	---@param playerHUDIndex integer
	---@param hudLayout HUDLayout
	---@param position Vector
	Condition = function(player, playerHUDIndex, hudLayout, position)
		return player:GetPlayerType() == playerType
	end,
	---@param player EntityPlayer
	---@param playerHUDIndex integer
	---@param hudLayout HUDLayout
	---@param position Vector
	OnRender = function(player, playerHUDIndex, hudLayout, position)
		local playerIndex = isc:getPlayerIndex(player)
		local list = getRenderList(player)
		local spr_table = {}
		for i, id in ipairs(list) do
			spr_table[i] = Sprite()
			spr_table[i]:Load("gfx/ui/wakaba/ui_richer_b.anm2",true)
			if id and id ~= 0 and Isaac.GetItemConfig():GetCollectible(id) then
				spr_table[i]:ReplaceSpritesheet(2, Isaac.GetItemConfig():GetCollectible(id).GfxFileName)
				spr_table[i]:LoadGraphics()
			end
			if i == 1 then
				spr_table[i]:SetFrame("Idle",0)
			else
				spr_table[i]:SetFrame("Idle",1)
			end
			spr_table[i]:Render(position + Vector(12*(i-1), 0),Vector(0,0),Vector(0,0))
		end
	end,
	--PreRenderCallback = true
}, HudHelper.HUDType.EXTRA)


function wakaba:Render_WaterFlame()
	if (ModConfigMenu and ModConfigMenu.IsVisible)
	or not wakaba.G:GetHUD():IsVisible()
	or wakaba.G:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD) then
		return
	end

	for i, player in ipairs(wakaba:getAllMainPlayers()) do
		--local player=Game():GetPlayer(i)
		if player:GetPlayerType() ~= playerType then goto skipWFRender end
		local playerIndex = isc:getPlayerIndex(player)
		local list = getRenderList(player)
		local offset = wakaba.ManaOffsets[i]
		local spr_table = {}
		for i, id in ipairs(list) do
			spr_table[i] = Sprite()
			spr_table[i]:Load("gfx/ui/wakaba/ui_richer_b.anm2",true)
			if id and id ~= 0 and Isaac.GetItemConfig():GetCollectible(id) then
				spr_table[i]:ReplaceSpritesheet(2, Isaac.GetItemConfig():GetCollectible(id).GfxFileName)
				spr_table[i]:LoadGraphics()
			end
			if i == 1 then
				spr_table[i]:SetFrame("Idle",0)
			else
				spr_table[i]:SetFrame("Idle",1)
			end
			local position= offset.Offset + offset.AnchorOffset() + wakaba.G.ScreenShakeOffset
			if offset.Direction == Direction.RIGHT then
				spr_table[i]:Render(position + Vector(12*(i-1), 0),Vector(0,0),Vector(0,0))
			elseif offset.Direction == Direction.LEFT then
				spr_table[i]:Render(position - Vector(12*(i-1), 0),Vector(0,0),Vector(0,0))
			end

		end

		::skipWFRender::
	end

end
--wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_WaterFlame)

---@param player EntityPlayer
local function GetVisibleWisps(player)
	local itemWisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP)
	local visibleWisps = {}

	for _, wisp in pairs(itemWisps) do
		if wisp.Visible and GetPtrHash(wisp:ToFamiliar().Player) == GetPtrHash(player) then
			table.insert(visibleWisps, wisp)
		end
	end

	return visibleWisps
end

---@param initSeed integer
local function TrackInitSeed(initSeed)

end

---@param player EntityPlayer
function wakaba:PlayerUpdate_Richer_b(player)
	if player:GetPlayerType() == playerType then
		local playerIndex = isc:getPlayerIndex(player)
		totalwisps[playerIndex] = totalwisps[playerIndex] or {}
		local current = totalwisps[playerIndex]
		local wisps = GetVisibleWisps(player)
		local changed = false
		current.list = current.list or {}
		current.index = current.index or 1
		if (#wisps ~= #current.list) or forceReset then
			current.list = wisps
			changed = true
			forceReset = false
		end
		if #current.list > 0 then
			if Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex) then
				if Input.IsActionPressed(ButtonAction.ACTION_MAP, player.ControllerIndex) then
					current.index = current.index - 1
				else
					current.index = current.index + 1
				end
			end
			if current.index > #current.list then
				current.index = 1
			elseif current.index <= 0 then
				current.index = #current.list
			end
		else
			current.index = 1
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Richer_b)

local RicherChar = {
		DAMAGE = 0.75,
		SPEED = 0.1,
		SHOTSPEED = 1.0,
		TEARRANGE = 40 * 0,
		TEARS = 0.6,
		LUCK = -1,
		FLYING = false,
		TEARFLAG = TearFlags.TEAR_NORMAL,
		TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)	-- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}

function wakaba:onRicherCache_b(player, cacheFlag)
	if player:GetPlayerType() == playerType then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * RicherChar.DAMAGE
		end
		if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed * RicherChar.SHOTSPEED
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + RicherChar.TEARRANGE
		end
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + RicherChar.SPEED
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + RicherChar.LUCK
		end
		if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and RicherChar.FLYING then
			player.CanFly = true
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (RicherChar.TEARS * wakaba:getEstimatedTearsMult(player)))
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | RicherChar.TEARFLAG
		end
		if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
			--player.TearColor = RicherChar.TEARCOLOR
		end
	end

end

wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010720, wakaba.onRicherCache_b)

---@param player EntityPlayer
function wakaba:AfterRicherInit_b(player)
	--print("Richer event passed")
	player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.WATER_FLAME, ActiveSlot.SLOT_POCKET, true)
	end

	--[[ if Poglite then
		if wakaba.state.pog ~= nil then
			if wakaba.state.pog then
				-- Richer POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakabapog.anm2")
				Poglite:AddPogCostume("RicherPog",playerType,pogCostume)
			else
				-- Origin POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakabapog.anm2")
				Poglite:AddPogCostume("RicherPog",playerType,pogCostume)
			end
		end
	end ]]
end

---@param pickup EntityPickup
function wakaba:isTaintedRicherNearby(pickup)
	local players = Isaac.FindInRadius(pickup.Position, 120, EntityPartition.PLAYER)
	for i, entity in ipairs(players) do
		if entity:ToPlayer() and entity:ToPlayer():GetPlayerType() == wakaba.Enums.Players.RICHER_B then
			return pickup.Position:Distance(entity.Position)
		end
	end
end

function wakaba:shouldConvertedForTaintedRicher(pickup)
	if pickup.SubType <= 0 then return false end
	local itemID = pickup.SubType
	local itemConfig = Isaac.GetItemConfig():GetCollectible(itemID)
	if not itemConfig then return false end
	return itemConfig:IsCollectible() and itemConfig:HasTags(ItemConfig.TAG_SUMMONABLE)
end

local rr, gg, bb = 1.0, 1.0, 1.0
local rt = 1.0
local rc = 1.0
local rb = 1.0
function wakaba:PickupRender_TaintedRicher(pickup, offset)
	local pickupData = pickup:GetData()
	if isc:inDeathCertificateArea() or isc:inGenesisRoom() then return end

	local dist = wakaba:isTaintedRicherNearby(pickup)
	local sprite = pickup:GetSprite()
	if wakaba:shouldConvertedForTaintedRicher(pickup) and dist then
		if not pickupData.wakaba_tempTint then
			pickupData.wakaba_tempTint = sprite.Color
		end
		local strength = ((math.max(130 - dist, 0)) / 100)
		local tcolor = Color(1, 1, 1, 1, 0, 0, 0.2 * strength)
		tcolor:SetColorize(rc*2, rc, rb*3+0.8, (rc-0.2) * strength)
		local ntcolor = Color.Lerp(tcolor, tcolor, 0.5)
		rt = 1 - (math.sin(Game():GetFrameCount() / 6)/10)-0.1
		rc = 1 - (math.sin(Game():GetFrameCount() / 6)/5)-0.2
		rb = 1 - math.sin(Game():GetFrameCount() / 6)
		ntcolor.A = rt

		sprite.Color = ntcolor
	else
		if pickupData.wakaba_tempTint then
			local oldColor = pickupData.wakaba_tempTint
			local newColor = Color(oldColor.R, oldColor.G, oldColor.B, oldColor.A, oldColor.RO, oldColor.GO, oldColor.BO)
			newColor:Reset()
			sprite.Color = newColor
			pickupData.wakaba_tempTint = nil
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, wakaba.PickupRender_TaintedRicher, PickupVariant.PICKUP_COLLECTIBLE)



function wakaba:PostRicherInit_b(player)
	if not isRicherContinue then
		wakaba:AfterRicherInit_b(player)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostRicherInit_b)

function wakaba:RicherInit_b(continue)
	if (not continue) then
		isRicherContinue = false
		wakaba:AfterRicherInit_b()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.RicherInit_b)

function wakaba:RicherExit_b()
	isRicherContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.RicherExit_b)
