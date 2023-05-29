function wakaba:cacheUpdate23(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_PENDANT) then
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) then
			if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + (4 * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT) * wakaba:getEstimatedDamageMult(player))
			end
		else
			if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + (1 * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT) * wakaba:getEstimatedDamageMult(player))
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.cacheUpdate23)








