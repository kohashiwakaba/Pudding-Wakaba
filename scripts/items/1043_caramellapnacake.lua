wakaba.COLLECTIBLE_CARAMELLA_PANCAKE = Isaac.GetItemIdByName("Caramella Pancake")

function wakaba:Cache_Pancake(player, cacheFlag)
	if player:HasCollectible(wakaba.COLLECTIBLE_CARAMELLA_PANCAKE) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (1 * player:GetCollectibleNum(wakaba.COLLECTIBLE_CARAMELLA_PANCAKE))
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + (1 * player:GetCollectibleNum(wakaba.COLLECTIBLE_CARAMELLA_PANCAKE))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_Pancake)











