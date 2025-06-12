local isc = _wakaba.isc

local function canActivateSuccubusBlanket(player)
	return player:HasCollectible(wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)	or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)
end

local function getSuccubusBlanketMultiplier(player)
	return player:GetCollectibleNum(wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)	+ player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)
end

function wakaba:Cache_SuccubusBlanket(player, cacheFlag)
	if canActivateSuccubusBlanket(player) then
		local num = getSuccubusBlanketMultiplier(player)
		local blackHearts = isc:getPlayerBlackHearts(player)
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (0.25 * blackHearts * num * wakaba:getEstimatedDamageMult(player))
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_SuccubusBlanket)