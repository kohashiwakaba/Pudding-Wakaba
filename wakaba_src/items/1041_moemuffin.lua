function wakaba:Cache_MoeMuffin(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.MOE_MUFFIN) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (1.5 * player:GetCollectibleNum(wakaba.Enums.Collectibles.MOE_MUFFIN) * wakaba:getEstimatedDamageMult(player))
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (60 * player:GetCollectibleNum(wakaba.Enums.Collectibles.MOE_MUFFIN))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_MoeMuffin)











