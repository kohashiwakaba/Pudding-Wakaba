wakaba.COLLECTIBLE_CLOVER_SHARD = Isaac.GetItemIdByName("Clover Shard")

function wakaba:Cache_CloverShard(player, cacheFlag)
	if player:HasCollectible(wakaba.COLLECTIBLE_CLOVER_SHARD) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (1.11 * player:GetCollectibleNum(wakaba.COLLECTIBLE_CLOVER_SHARD))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_CloverShard)











