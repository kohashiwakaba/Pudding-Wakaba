
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_LAVA
local tp = wakaba.Enums.Players.RIRA
wakaba.ChallengeParams.TargetCharacters[c] = tp

local offset = 0

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_TheFloorIsLava(player)
	if wakaba.G.Challenge ~= c then return end
	wakaba:scheduleForUpdate(function ()
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_HOW_TO_JUMP, ActiveSlot.SLOT_POCKET, true)
		player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
		player:EvaluateItems()
	end, 0)
	--player:RemoveCollectible(wakaba.Enums.Collectibles.NERF_GUN, false, ActiveSlot.SLOT_POCKET, true)
	player:AddCollectible(wakaba.Enums.Collectibles.EASTER_EGG)
	--player:AddCollectible(wakaba.Enums.Collectibles.EASTER_EGG)
	--player:AddCollectible(wakaba.Enums.Collectibles.EASTER_EGG)
	--player:AddCollectible(wakaba.Enums.Collectibles.EASTER_EGG)
	--player:AddCollectible(wakaba.Enums.Collectibles.EASTER_EGG)
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_PLAYER_INIT, CallbackPriority.LATE, wakaba.Challenge_PlayerInit_TheFloorIsLava)

---@type Font
local font = wakaba.f
local text = ""
local trs = 0

function wakaba:Challenge_Render_TheFloorIsLava()
	if wakaba.G.Challenge ~= c then return end
	local width = Isaac.GetScreenWidth() / 2
	local height = Isaac.GetScreenHeight() / 2
	trs = trs - 0.0375
	local textWidth = font:GetStringWidthUTF8(text)
	font:DrawStringScaledUTF8(text, width - textWidth * 4, height - font:GetBaselineHeight() * 8, 8, 8, KColor(1,1,1,trs), 0, true)
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Challenge_Render_TheFloorIsLava)

function wakaba:Challenge_Update_TheFloorIsLava()
	if wakaba.G.Challenge ~= c then return end
	local game = wakaba.G
	local room = wakaba.G:GetRoom()
	local counter = game.TimeCounter
	local roam = counter % 300
	if roam == 150 then
		text = "5"
		trs = 0.5
	elseif roam == 180 then
		text = "4"
		trs = 0.5
	elseif roam == 210 then
		text = "3"
		trs = 0.5
	elseif roam == 240 then
		text = "2"
		trs = 0.5
	elseif roam == 270 then
		text = "1"
		trs = 0.5
	elseif roam == 0 and counter > 0 and (counter - offset > 60) then
		wakaba:ForAllPlayers(function (player)
			for i = 0, 7 do
				local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FIRE_WAVE, 0, player.Position, Vector.Zero, nil):ToEffect()
				effect.Rotation = i * 45
			end
		end)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Challenge_Update_TheFloorIsLava)

function wakaba:UseItem_Challenge_TheFloorIsLava(_, rng, player, flags, slot, vardata)
	if wakaba.G.Challenge == c then
		player:SetMinDamageCooldown(60)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_Challenge_TheFloorIsLava, CollectibleType.COLLECTIBLE_HOW_TO_JUMP)

function wakaba:Challenge_GameStart_TheFloorIsLava(continue)
	if wakaba.G.Challenge ~= c then return end
	local player = Isaac.GetPlayer()
	if continue then
		offset = wakaba.G.TimeCounter
	else
		wakaba.G:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC)
		wakaba.G:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_HOT_BOMBS)
		wakaba.G:GetItemPool():RemoveCollectible(wakaba.Enums.Collectibles.MAID_DUET)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.Challenge_GameStart_TheFloorIsLava)

---@param player EntityPlayer
function wakaba:Challenge_Cache_TheFloorIsLava(player, cacheFlag)
	if wakaba.G.Challenge == c then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 3
		end
		if cacheFlag == CacheFlag.CACHE_FLYING then
			player.CanFly = false
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 40000000, wakaba.Challenge_Cache_TheFloorIsLava)