function wakaba:cacheUpdate24(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.D_CUP_ICECREAM) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_SPEED then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BINGE_EATER) then
				player.MoveSpeed = player.MoveSpeed - (0.04 * player:GetCollectibleNum(wakaba.Enums.Collectibles.D_CUP_ICECREAM))
			end
		end
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = (player.Damage + (0.3 * player:GetCollectibleNum(wakaba.Enums.Collectibles.D_CUP_ICECREAM))) * 1.8
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BINGE_EATER) then
				player.Damage = player.Damage + (1 * player:GetCollectibleNum(wakaba.Enums.Collectibles.D_CUP_ICECREAM))
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.cacheUpdate24)











