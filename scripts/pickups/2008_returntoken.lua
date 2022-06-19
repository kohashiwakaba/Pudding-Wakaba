wakaba.CARD_RETURN_TOKEN = Isaac.GetCardIdByName("Return Token")

function wakaba:UseCard_ReturnToken(_, player, flags)
	player:UseCard(Card.CARD_REVERSE_FOOL, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_R_KEY, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
	Game().TimeCounter = 0
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_ReturnToken, wakaba.CARD_RETURN_TOKEN)

-- TODO: reenable this when Tsukasa unlockables are complete
--[[ function wakaba:GetCard_ReturnToken(rng, currentCard, playing, runes, onlyRunes)
	if not onlyRunes and currentCard == wakaba.CARD_RETURN_TOKEN then
		if wakaba.state.unlock.returncard < 1 then
			return Game():GetItemPool():GetCard(rng:Next(), playing, runes, onlyRunes)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_CARD, wakaba.GetCard_ReturnToken) ]]