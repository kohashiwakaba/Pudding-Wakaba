



--Identificaiton of special damage types, referenced from Rep+ code--

function wakaba:isSelfDamage(damageFlags, data)
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


function wakaba:AlterPlayerDamage_HitCounter(entity, amount, flags, source, countdown)
	local Source = source.Entity
	local player = entity:ToPlayer()
	if player then
		if flags & (DamageFlag.DAMAGE_FAKE | DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_NO_PENALTIES) == 0 then
			wakaba.isTakingPenaltyDamage = true
		end
		wakaba.isTakingDamage = true
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, -40000, wakaba.AlterPlayerDamage_HitCounter)
function wakaba:PostTakeDamage_HitCounter(player, amount, flags, source, cooldown)
	if wakaba.isTakingPenaltyDamage then
		wakaba.runstate.hitcounterpenalty = (wakaba.runstate.hitcounterpenalty or 0) + 1
	end
	if wakaba.isTakingDamage then
		wakaba.runstate.hitcounter = (wakaba.runstate.hitcounter or 0) + 1
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_HitCounter)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 0, function(_)
	if wakaba.state.options.hudhitcounter > 0 then
		local totalHitCounter = wakaba.runstate.hitcounter or 0
		local penaltyHitCounter = wakaba.runstate.hitcounterpenalty or 0
		if wakaba.state.options.hudhitcounter == 1 then
			wakaba.globalHUDSprite:SetFrame("HitCounter", 0)
			local tab = {
				Sprite = wakaba.globalHUDSprite,
				Text = penaltyHitCounter,
			}
			return tab
		elseif wakaba.state.options.hudhitcounter == 2 then
			wakaba.globalHUDSprite:SetFrame("HitCounter", 0)
			local tab = {
				Sprite = wakaba.globalHUDSprite,
				Text = totalHitCounter,
			}
			return tab
		end
	end
end)