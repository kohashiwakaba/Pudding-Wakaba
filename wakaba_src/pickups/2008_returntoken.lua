function wakaba:UseCard_ReturnToken(_, player, flags)
	player:UseCard(Card.CARD_REVERSE_FOOL, UseFlag.USE_MIMIC | UseFlag.USE_NOHUD | UseFlag.USE_NOANNOUNCER | UseFlag.USE_CARBATTERY | UseFlag.USE_NOANIM)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_R_KEY, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
	wakaba.G.TimeCounter = 30
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_ReturnToken, wakaba.Enums.Cards.CARD_RETURN_TOKEN)
