
wakaba.Status.RegisterStatusEffect(
	"wakaba_PLASMA_CACHE"
	, nil
	, nil
	, nil
	, true
)

---@param ent Entity
---@param statusEffect StatusFlag
---@param statusEffectData StatusEffectData
function wakaba:Status_PostAddEffect_PlasmaBeam(ent, statusEffect)
	local statusData = wakaba.Status:GetStatusEffectData(ent, statusEffect)
	statusData.Countdown = 210
	local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BRIMSTONE_BALL, 0, ent.Position, Vector.Zero, statusData.Source.Entity):ToEffect()
	effect.CollisionDamage = 2
	effect.Timeout = 60
end
wakaba.Status.Callbacks.AddCallback(wakaba.Status.Callbacks.ID.POST_ADD_ENTITY_STATUS_EFFECT, wakaba.Status_PostAddEffect_PlasmaBeam, wakaba.Status.StatusFlag.wakaba_PLASMA_CACHE)

function wakaba:PlasmaBeamDamage(source, target, data, newDamage, newFlags, isAlreadyLaser)
	local returndata = {}
	local num = 0
	if target.Type ~= EntityType.ENTITY_FIREPLACE then
		local spawnerPlayer
		for i = 0, wakaba.G:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local nNum = player:GetCollectibleNum(wakaba.Enums.Collectibles.PLASMA_BEAM) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.PLASMA_BEAM)
			if nNum > 0 then
				spawnerPlayer = player
			end
			num = num + nNum
		end
		if num > 0 then
			returndata.newDamage = newDamage * (1 + (0.25 ^ num))
			returndata.sendNewDamage = true
			returndata.newFlags = newFlags | DamageFlag.DAMAGE_LASER
			if isAlreadyLaser then
				if wakaba:IsLunatic() then
					returndata.newDamage = newDamage * 1.15
				else
					returndata.newFlags = newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR
				end
			end
			SFXManager():Play(SoundEffect.SOUND_REDLIGHTNING_ZAP_WEAK)
			if not wakaba:IsLunatic() and not wakaba.Status:HasStatusEffect(target, wakaba.Status.StatusFlag.wakaba_PLASMA_CACHE) then
				wakaba.Status:AddStatusEffect(target, wakaba.Status.StatusFlag.wakaba_PLASMA_CACHE, 210, EntityRef(spawnerPlayer))
			end
		end
	end
	return returndata
end