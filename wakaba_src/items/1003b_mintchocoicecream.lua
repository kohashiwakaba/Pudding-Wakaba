function wakaba:cacheUpdate24(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM) then
		local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM)
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			local oldTears = wakaba:getTearsStat(player.MaxFireDelay)
			player.MaxFireDelay = wakaba:getFireDelay(oldTears * 2)
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 0.2 * (count - 1))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.cacheUpdate24)











