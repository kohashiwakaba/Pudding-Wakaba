function wakaba:cacheUpdate23(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_PENDANT) then
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) then
			if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + (4 * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT))
			end
		else
			local pendantcnt = 0
			if player:GetData().wakaba and player:GetData().wakaba.PendantCandidates then
				pendantcnt = #player:GetData().wakaba.PendantCandidates
			end
			if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + (1 * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT))
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.cacheUpdate23)








