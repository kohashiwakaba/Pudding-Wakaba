function wakaba:Cache_DoubleInvader(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_INVADER) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (1.5 + player:GetCollectibleNum(wakaba.Enums.Collectibles.DOUBLE_INVADER))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_DoubleInvader)