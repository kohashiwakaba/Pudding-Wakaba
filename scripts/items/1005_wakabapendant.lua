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
			if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
				player.Luck = player.Luck + (0.35 * pendantcnt * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT))
				if wakaba:HasBless(player) then
					player.Luck = player.Luck + (0.15 * pendantcnt * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT))
					if player.Luck < 10 then
						player.Luck = 10
					end
				else
					if player.Luck < 7 then
						player.Luck = 7
					end
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.cacheUpdate23)








