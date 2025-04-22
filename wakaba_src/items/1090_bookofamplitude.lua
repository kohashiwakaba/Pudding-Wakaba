--[[
	Book of Amplitude (증폭의 책) - 액티브(Active) - 1 room
	소지 중일 때 방 입장 시마다 아래 효과 중 하나를 번갈아가며 적용
	- 이동속도 +0.15
	- 연사 + 1
	- 공격력 + 2
	- 행운 + 2
	사용 시 차례를 다음 차례로 변경
 ]]
local isc = _wakaba.isc

---@param player EntityPlayer
function wakaba:PostGetCollectible_BookOfAmplitude(player, item)
	local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE)
	local stat = rng:RandomInt(4)
	wakaba:initPlayerDataEntry(player, "ampstat", stat)
	player:AddCacheFlags(CacheFlag.CACHE_SPEED | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_LUCK)
	player:EvaluateItems()
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_BookOfAmplitude, wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE)

function wakaba:NewRoom_BookOfAmplitude()
	if wakaba.G:GetRoom():IsFirstVisit() then
		wakaba:ForAllPlayers(function (player)---@param player EntityPlayer
			if player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE) then
				wakaba:addPlayerDataCounter(player, "ampstat", 1)
				player:AddCacheFlags(CacheFlag.CACHE_SPEED | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_LUCK)
				player:EvaluateItems()
			end
		end)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_BookOfAmplitude)


function wakaba:ItemUse_BookOfAmplitude(item, rng, player, useFlags, activeSlot, varData)
	if useFlags & UseFlag.USE_CARBATTERY > 0 then return end

	wakaba:getPlayerDataEntry(player, "ampstat", 0)
	SFXManager():Play(wakaba.Enums.SoundEffects.AEION_CHARGE)
	wakaba:addPlayerDataCounter(player, "ampstat", 1)
	player:AddCacheFlags(CacheFlag.CACHE_SPEED | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_LUCK)
	player:EvaluateItems()
	if useFlags & UseFlag.USE_NOANIM == 0 then
		local animToShow = (player:GetShootingInput():Length() > 0.1) and "HideItem" or "UseItem"
		player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE, animToShow, "PlayerPickup")
	end

	return {
		Discharge = true,
		Remove = false,
		ShowAnim = false,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfAmplitude, wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE)

---@param player EntityPlayer
---@param cacheFlag CacheFlag
function wakaba:Cache_BookOfAmplitude(player, cacheFlag)
	local ampStat = wakaba:getPlayerDataEntry(player, "ampstat")
	if player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE) and ampStat then
		ampStat = ampStat % 4
		local mult = 1
		mult = wakaba:IsGoldenItem(wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE, player) and mult + 1 or mult
		mult = player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY) and mult + 1 or mult
		if ampStat == 2 then
			if cacheFlag == CacheFlag.CACHE_SPEED then
				player.MoveSpeed = player.MoveSpeed + (0.15 * mult)
			end
		elseif ampStat == 1 then
			if cacheFlag == CacheFlag.CACHE_FIREDELAY then
				player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (1 * mult * wakaba:getEstimatedTearsMult(player, false, true)))
			end
		elseif ampStat == 0 then
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + (2 * mult * wakaba:getEstimatedDamageMult(player))
			end
		elseif ampStat == 3 then
			if cacheFlag == CacheFlag.CACHE_LUCK then
				player.Luck = player.Luck + (2 * mult)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_BookOfAmplitude)