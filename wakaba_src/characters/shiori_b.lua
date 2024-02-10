

local playerType = wakaba.Enums.Players.SHIORI_B
local removed = false
local collectibleCount
local costumeEquipped
local isShioriContinue = true
local iskeyinit = false
local isc = require("wakaba_src.libs.isaacscript-common")
if not REPENTOGON then
	wakaba:registerCharacterHealthConversion(wakaba.Enums.Players.SHIORI_B, isc.HeartSubType.SOUL)
end

function wakaba:GetShioriCostume_b(player, ignorecooldown)
	if ignorecooldown or wakaba.costumecurrframe == 0 then
		wakaba.costumecurrframe = wakaba.costumecooldown
		player:AddNullCostume(wakaba.COSTUME_SHIORI_B)
		player:AddNullCostume(wakaba.COSTUME_SHIORI_B_BODY)
	end
end

--[[ if Poglite then
	local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakaba_pog.anm2")
	Poglite:AddPogCostume("ShioriPog",playerType,pogCostume)
end ]]

--Costume currently not working in Knife Piece 2 area. Needs to be fixed.
function wakaba:PostShioriUpdate_b()

end
--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostShioriUpdate_b)

function wakaba:PostGetCollectible_Shiori_b(player, item)
	if not player or player:GetPlayerType() ~= wakaba.Enums.Players.SHIORI_B then return end
	player:AddSoulHearts(player:GetSoulHearts() * -1)
	player:AddMaxHearts(2)
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_Shiori_b, CollectibleType.COLLECTIBLE_DEAD_CAT)

local ShioriChar_b = {
	DAMAGE = 0.2,
	SPEED = 0.0,
	SHOTSPEED = 1.0,
	TEARRANGE = -20,
	TEARS = 0.27,
	LUCK = 1,
	FLYING = true,
	TEARFLAG = TearFlags.TEAR_TURN_HORIZONTAL,
	TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)	-- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}

function wakaba:onShioriCache_b(player, cacheFlag)
	if player:GetPlayerType() == playerType then
		local additional = 0
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			additional = wakaba.fcount
		end
		wakaba:GetShioriCostume_b(player)
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = (player.Damage + (additional * 0.2)) * ShioriChar_b.DAMAGE + 0.3
		end
		if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed * ShioriChar_b.SHOTSPEED + (additional * 0.02)
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
				player.TearRange = player.TearRange + ShioriChar_b.TEARRANGE + (additional * 0.05)
		end
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + ShioriChar_b.SPEED + (additional * 0.04)
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + ShioriChar_b.LUCK + (additional * 0.25)
		end
		if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and ShioriChar_b.FLYING then
			player.CanFly = true
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (ShioriChar_b.TEARS * wakaba:getEstimatedTearsMult(player)))
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (additional * 0.06 * wakaba:getEstimatedTearsMult(player)))
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | ShioriChar_b.TEARFLAG
		end
		if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
			player.TearColor = ShioriChar_b.TEARCOLOR
		end
	else
		player:TryRemoveNullCostume(wakaba.COSTUME_SHIORI_B)
	end

end

wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010720, wakaba.onShioriCache_b)

function wakaba:AfterShioriInit_b(player)
	local player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		local data = player:GetData()
		data.wakaba = data.wakaba or {}
		data.wakaba.bookindex = data.wakaba.bookindex or 1
		data.wakaba.currdamage = data.wakaba.currdamage or 0
		data.wakaba.enemieskilled = data.wakaba.enemieskilled or 0
		data.wakaba.nextshioriflag = data.wakaba.nextshioriflag or 0
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST, ActiveSlot.SLOT_POCKET, false)
		wakaba.Log("Adding bookmakrs")
		if not player:HasCollectible(wakaba.SHIORI_BOOKMARK) then player:AddCollectible(wakaba.SHIORI_BOOKMARK) end
		if not player:HasCollectible(wakaba.SHIORI_BOOKMARK2) then player:AddCollectible(wakaba.SHIORI_BOOKMARK2) end
		if not player:HasCollectible(wakaba.SHIORI_BOOKMARK3) then player:AddCollectible(wakaba.SHIORI_BOOKMARK3) end

		if not player:HasTrinket(TrinketType.TRINKET_OLD_CAPACITOR, false) then
			player:AddTrinket(TrinketType.TRINKET_OLD_CAPACITOR)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM, -1)
		end
		if wakaba.G:IsGreedMode() and not player:HasTrinket(TrinketType.TRINKET_FLAT_PENNY, false) then
			player:AddTrinket(TrinketType.TRINKET_FLAT_PENNY)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM, -1)
		end


		if wakaba.state.options.cp_wakaba then
			player:EvaluateItems()
			--player:ClearCostumes()
		else
			wakaba:GetShioriCostume_b(player)
		end


	end
end

function wakaba:PostShioriInit_b(player)
	if player:GetPlayerType() == playerType then
		wakaba:GetShioriCostume_b(player)
	end
	if not isShioriContinue then
		wakaba:AfterShioriInit_b(player)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostShioriInit_b)

function wakaba:ShioriInit_b(continue)
	if (not continue) then
		isShioriContinue = false
		wakaba:AfterShioriInit_b()
	end

	if Poglite then
		if wakaba.state.pog ~= nil then
			if wakaba.state.pog then
				-- Shiori POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/shiorisosig.anm2")
				Poglite:AddPogCostume("MinervaPog",playerType,pogCostume)
			else
				-- Origin POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/shioripog.anm2")
				Poglite:AddPogCostume("MinervaPog",playerType,pogCostume)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.ShioriInit_b)

function wakaba:ShioriExit_b()
	isShioriContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.ShioriExit_b)





