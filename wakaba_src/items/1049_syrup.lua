function wakaba:Cache_Syrup(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.SYRUP) then
		local isGolden = wakaba:IsGoldenItem(wakaba.Enums.Collectibles.SYRUP)
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (1.25 * wakaba:getEstimatedDamageMult(player))
		end
		if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING then
			player.CanFly = true
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (40 * 3)
		end
		if isGolden then
			if cacheFlag == CacheFlag.CACHE_TEARFLAG then
				player.TearFlags = player.TearFlags | TearFlags.TEAR_SPECTRAL
			end
		else
			if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
				player.MoveSpeed = player.MoveSpeed * 0.9
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Syrup)