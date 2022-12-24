local animation = "gfx/cranecarddrop.anm2"
local CraneCardChance = wakaba.state.silverchance

local usedCardInThisRoom = false
local player


function wakaba:onUseCard2002(_, player, flags)
	local newMachinePos = wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true)
	local machineVariant = 16
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, newMachinePos, Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_SLOT, machineVariant, 0, newMachinePos, Vector(0,0), nil)
	SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2002, wakaba.Enums.Cards.CARD_CRANE_CARD)

