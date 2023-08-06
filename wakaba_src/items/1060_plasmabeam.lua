function wakaba:PlasmaBeamDamage(source, target, data, newDamage, newFlags, isAlreadyLaser)
	local returndata = {}
	local num = 0
	if target.Type ~= EntityType.ENTITY_FIREPLACE then
		for i = 0, wakaba.G:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			num = num + player:GetCollectibleNum(wakaba.Enums.Collectibles.PLASMA_BEAM) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.PLASMA_BEAM)
		end
		if num > 0 then
			returndata.newDamage = newDamage * (1.25 ^ num)
			returndata.sendNewDamage = true
			returndata.newFlags = newFlags | DamageFlag.DAMAGE_LASER
			if isAlreadyLaser then
				returndata.newFlags = returndata.newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR
			end
			SFXManager():Play(SoundEffect.SOUND_REDLIGHTNING_ZAP_WEAK)
		end
	end
	return returndata
end