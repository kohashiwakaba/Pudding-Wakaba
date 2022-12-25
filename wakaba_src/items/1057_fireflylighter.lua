
function wakaba:PlayerUpdate_FireflyLighter(player)
	if player:HasCollectible(wakaba.Enums.Collectibles.FIREFLY_LIGHTER) then
		local level = wakaba.G:GetLevel()
		local currentRoomDesc = level:GetRoomByIdx(level:GetCurrentRoomIndex())
		if currentRoomDesc.NoReward then
			currentRoomDesc.NoReward = false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_FireflyLighter)

function wakaba:Cache_FireflyLighter(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.FIREFLY_LIGHTER) then
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + (1 * player:GetCollectibleNum(wakaba.Enums.Collectibles.FIREFLY_LIGHTER))
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (80 * player:GetCollectibleNum(wakaba.Enums.Collectibles.FIREFLY_LIGHTER))
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_FireflyLighter)