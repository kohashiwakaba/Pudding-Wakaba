
function wakaba:NekoFigureDamage(source, target, data, newDamage, newFlags)
	local returndata = {}
	local num = 0
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		num = num + player:GetCollectibleNum(wakaba.Enums.Collectibles.NEKO_FIGURE) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.NEKO_FIGURE)
	end
	if num > 0 then
		returndata.sendNewDamage = true
		if wakaba:IsLunatic() then
			returndata.newDamage = newDamage * 1.15
		else
			returndata.newFlags = newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR
		end
	end
	return returndata
end