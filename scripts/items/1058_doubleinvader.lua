wakaba.COLLECTIBLE_DOUBLE_INVADER = Isaac.GetItemIdByName("Double Invader")

function wakaba:Cache_DoubleInvader(player, cacheFlag)
	if player:HasCollectible(wakaba.COLLECTIBLE_DOUBLE_INVADER) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (3 + player:GetCollectibleNum(wakaba.COLLECTIBLE_DOUBLE_INVADER))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_DoubleInvader)