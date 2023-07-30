



--Identificaiton of special damage types, referenced from Rep+ code--

local function isSelfDamage(damageFlags, data)
	local selfDamageFlags = {
		['IVBag'] = DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_IV_BAG,
		['Confessional'] = DamageFlag.DAMAGE_RED_HEARTS,
		['DemonBeggar'] = DamageFlag.DAMAGE_RED_HEARTS,
		['BloodDonationMachine'] = DamageFlag.DAMAGE_RED_HEARTS,
		['HellGame'] = DamageFlag.DAMAGE_RED_HEARTS,
		['CurseRoom'] = DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_CURSED_DOOR,
		['MausoleumDoor'] = DamageFlag.DAMAGE_SPIKES | DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_NO_MODIFIERS,
		['SacrificeRoom'] = DamageFlag.DAMAGE_SPIKES | DamageFlag.DAMAGE_NO_PENALTIES,
		['SpikedChest'] = DamageFlag.DAMAGE_CHEST | DamageFlag.DAMAGE_NO_PENALTIES,
		['BadTrip'] = DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_NO_PENALTIES
	}

	for source, flags in pairs(selfDamageFlags) do
		if damageFlags & flags == flags then
			return true
		end
	end
	return false
end


function wakaba:TakeDamage_HitCounter(entity, amount, flags, source, countdown)
	local Source = source.Entity
	local player = entity:ToPlayer()
	if player then
		if flags & DamageFlag.DAMAGE_FAKE ~= DamageFlag.DAMAGE_FAKE and not isSelfDamage(flags) then
			wakaba.runstate.hitcounterpenalty = (wakaba.runstate.hitcounterpenalty or 0) + 1
		end
		wakaba.runstate.hitcounter = (wakaba.runstate.hitcounter or 0) + 1
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, 41017020, wakaba.TakeDamage_HitCounter)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 0, function(_)
	if true then
		local totalHitCounter = wakaba.runstate.hitcounter or 0
		local penaltyHitCounter = wakaba.runstate.hitcounterpenalty or 0
		wakaba.globalHUDSprite:SetFrame("HitCounter", 0)
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = penaltyHitCounter,
		}
		return tab
	end
end)