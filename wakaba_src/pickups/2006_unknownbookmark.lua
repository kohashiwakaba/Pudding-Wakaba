function wakaba:onUseCard2006(_, player, flags)
	local books = wakaba.runstate.cachedmaijimabooks
	if books then
		local subrandom = 1
		if not (wakaba:IsEntryUnlocked("unknownbookmark") and wakaba:extraVal("shioriAssistant")) then
			subrandom = player:GetCardRNG(wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK):RandomInt(#books) + 1
		end
		local selected = books[subrandom]
		if selected == wakaba.Enums.Collectibles.DOUBLE_DREAMS then
			player:UseCard(wakaba.Enums.Cards.CARD_DREAM_CARD, 0 | UseFlag.USE_NOHUD)
		else
			player:UseActiveItem(selected, UseFlag.USE_VOID, -1)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2006, wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK)
