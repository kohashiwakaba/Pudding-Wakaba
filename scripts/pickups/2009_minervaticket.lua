function wakaba:UseCard_MinervaTicket(_, player, flags)
	player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.MINERVA_AURA)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_MinervaTicket, wakaba.Enums.Cards.CARD_MINERVA_TICKET)