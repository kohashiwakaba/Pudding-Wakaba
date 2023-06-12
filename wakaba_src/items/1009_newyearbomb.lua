function wakaba:NewYearBombDamage(source, target, data, newDamage, newFlags, isAlreadyIgnoredArmor)
	local returndata = {}
	local num = 0
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		num = num + player:GetCollectibleNum(wakaba.Enums.Collectibles.NEW_YEAR_BOMB) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.NEW_YEAR_BOMB)
	end
	print(num, newDamage)
	if num > 0 then
		if isAlreadyIgnoredArmor then
			returndata.newDamage = newDamage * (2 ^ num)
		end
		returndata.sendNewDamage = true
		returndata.newFlags = newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR
		SFXManager():Play(SoundEffect.SOUND_BONE_SNAP)
	end
	return returndata
end


function wakaba:PreUseItem_Hold_NewYearBomb(item, rng, player, flag, slot, varData)
	if player:HasCollectible(wakaba.Enums.Collectibles.NEW_YEAR_BOMB) and player:GetPoopMana() >= 3 then
		player:UsePoopSpell(PoopSpellType.SPELL_BOMB)
		player:AddPoopMana(-3)
		return true
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.PreUseItem_Hold_NewYearBomb, CollectibleType.COLLECTIBLE_HOLD)