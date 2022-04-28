wakaba.COLLECTIBLE_SYRUP = Isaac.GetItemIdByName("Syrup")

function wakaba:Cache_Syrup(player, cacheFlag)
	if player:HasCollectible(wakaba.COLLECTIBLE_SYRUP) then
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed * 0.9
		end
    if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING then
      player.CanFly = true
    end
    if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
      player.TearRange = player.TearRange + (40 * 3)
    end
	end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Syrup)