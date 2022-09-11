wakaba.CARD_MINERVA_TICKET = Isaac.GetCardIdByName("Minerva Ticket")

function wakaba:UseCard_MinervaTicket(_, player, flags)
	player:GetEffects():AddCollectibleEffect(wakaba.COLLECTIBLE_MINERVA_AURA)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_MinervaTicket, wakaba.CARD_MINERVA_TICKET)

-- TODO: reenable this when Tsukasa unlockables are complete
--[[ function wakaba:GetCard_ReturnToken(rng, currentCard, playing, runes, onlyRunes)
	if not onlyRunes and currentCard == wakaba.CARD_RETURN_TOKEN then
		if wakaba.state.unlock.returncard < 1 then
			return Game():GetItemPool():GetCard(rng:Next(), playing, runes, onlyRunes)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_CARD, wakaba.GetCard_ReturnToken) ]]