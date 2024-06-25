function wakaba:Cache_NekoFigure(player, cacheFlag)
	local num = player:GetCollectibleNum(wakaba.Enums.Collectibles.NEKO_FIGURE) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.NEKO_FIGURE)
	if num > 0 then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (1 + (0.1 * (num - 2)))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_NekoFigure)

function wakaba:NekoFigureDamage(source, target, data, newDamage, newFlags)
	local returndata = {}
	local num = 0
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		num = num + player:GetCollectibleNum(wakaba.Enums.Collectibles.NEKO_FIGURE) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.NEKO_FIGURE)
	end
	if not wakaba:IsLunatic() and num > 0 then
		returndata.sendNewDamage = true
		returndata.newFlags = newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR
	end
	return returndata
end