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

function wakaba:PlayerUpdate_SuccubusBlanket(player)
	if not canActivateSuccubusBlanket(player) then return end
	if player.FrameCount % 5 == 0 then
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_SuccubusBlanket)