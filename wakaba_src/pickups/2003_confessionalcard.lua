function wakaba:onUseCard2003(_, player, flags)
	local newMachinePos = wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 45, true)
	local machineVariant = 17
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, newMachinePos, Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_SLOT, machineVariant, 0, newMachinePos, Vector(0,0), nil)
	SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2003, wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD)
