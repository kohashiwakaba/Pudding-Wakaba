

function wakaba:Cache_CrisisBoost(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.CRISIS_BOOST) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.CRISIS_BOOST) then
		local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.CRISIS_BOOST) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.CRISIS_BOOST)
		local currHearts = player:GetHearts() + player:GetSoulHearts()
		local bonus = math.max(math.min(0, (26 - currHearts) / 18), 1.5)
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + ((1 + bonus) * count)
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 1.0 * count)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_CrisisBoost)


