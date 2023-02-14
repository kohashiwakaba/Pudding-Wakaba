
local playerType = wakaba.Enums.Players.RICHER_B
local removed = false
local isRicherContinue = true
local isc = require("wakaba_src.libs.isaacscript-common")

wakaba.TotalWisps = {}
local totalwisps = wakaba.TotalWisps

--[[ wakaba.TaintedRicherSelectionSprite=Sprite()
wakaba.TaintedRicherSelectionSprite:Load("gfx/ui/wakaba/ui_richer_b.anm2",true)
wakaba.TaintedRicherSelectionSprite:SetFrame("HUD",0) ]]

---@param player EntityPlayer
local function getRenderList(player)
	local renderList = {}
	local playerIndex = isc:getPlayerIndex(player)
	local limit = 6
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
	if #renderList < 6 then
		for i = 1, 6 - #renderList do
			table.insert(renderList, 0)
		end
	end
	return renderList
end

function wakaba:Render_WaterFlame()
	if (ModConfigMenu and ModConfigMenu.IsVisible)
	or not wakaba.G:GetHUD():IsVisible()
	or wakaba.G:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD) then
		return
	end

	for i = 0, Game():GetNumPlayers() - 1 do
		local player=Game():GetPlayer(i)
		if player:GetPlayerType() ~= playerType then goto skipWFRender end
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
			local offset=Vector(45,40) + ScreenHelper.GetScreenTopLeft(Options.HUDOffset*10)
			spr_table[i]:Render(offset + Vector(12*(i-1), 0),Vector(0,0),Vector(0,0))

		end

		::skipWFRender::
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_WaterFlame)

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
		if #wisps ~= #current.list then
			current.list = wisps
			changed = true
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

--[[ function wakaba:RicherTakeDmg(entity, amount, flag, source, countdownFrames)

end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.RicherTakeDmg) ]]


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
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, RicherChar.TEARS)
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
