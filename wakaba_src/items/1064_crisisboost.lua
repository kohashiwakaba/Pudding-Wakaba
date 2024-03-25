

function wakaba:Cache_CrisisBoost(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.CRISIS_BOOST) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.CRISIS_BOOST) then
		local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.CRISIS_BOOST) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.CRISIS_BOOST)
		local currHearts = player:GetHearts() + player:GetSoulHearts() + player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
		local bonus = math.min(math.max(0, (26 - currHearts) / 16), 1.5) * 0.3
		if currHearts == 1 then bonus = 1 end
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * ((1 + bonus) * count)
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 1.0 * count * wakaba:getEstimatedTearsMult(player))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_CrisisBoost)


function wakaba:PlayerUpdate_CrisisBoost(player)
	if player:HasCollectible(wakaba.Enums.Collectibles.CRISIS_BOOST) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.CRISIS_BOOST) then
		if player.FrameCount % 5 == 0 then
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
			player:EvaluateItems()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_CrisisBoost)
