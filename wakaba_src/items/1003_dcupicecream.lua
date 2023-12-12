function wakaba:Cache_DCupIcecream(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.D_CUP_ICECREAM) then
		if cacheFlag == CacheFlag.CACHE_SPEED then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BINGE_EATER) then
				player.MoveSpeed = player.MoveSpeed - (0.04 * player:GetCollectibleNum(wakaba.Enums.Collectibles.D_CUP_ICECREAM))
			end
		end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = (player.Damage + (0.3 * player:GetCollectibleNum(wakaba.Enums.Collectibles.D_CUP_ICECREAM) * wakaba:getEstimatedDamageMult(player))) * 1.8
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BINGE_EATER) then
				player.Damage = player.Damage + (1 * player:GetCollectibleNum(wakaba.Enums.Collectibles.D_CUP_ICECREAM) * wakaba:getEstimatedDamageMult(player))
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_DCupIcecream)











