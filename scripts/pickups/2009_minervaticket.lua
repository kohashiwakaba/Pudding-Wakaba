wakaba.CARD_MINERVA_TICKET = Isaac.GetCardIdByName("Minerva Ticket")

function wakaba:UseCard_MinervaTicket(_, player, flags)
	player:GetEffects():AddCollectibleEffect(wakaba.COLLECTIBLE_MINERVA_AURA)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_MinervaTicket, wakaba.CARD_MINERVA_TICKET)