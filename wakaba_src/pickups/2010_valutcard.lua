
function wakaba:UseCard_ValutRift(_, player, flags)
	local newMachinePos = wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 45, true)
	local machineVariant = wakaba.Enums.Slots.SHIORI_VALUT
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, newMachinePos, Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_SLOT, machineVariant, 0, newMachinePos, Vector(0,0), nil)
	SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_ValutRift, wakaba.Enums.Cards.CARD_VALUT_RIFT)
