function wakaba:Cache_Pancake(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.CARAMELLO_PANCAKE) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (1 * player:GetCollectibleNum(wakaba.Enums.Collectibles.CARAMELLO_PANCAKE))
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + (1 * player:GetCollectibleNum(wakaba.Enums.Collectibles.CARAMELLO_PANCAKE))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_Pancake)











