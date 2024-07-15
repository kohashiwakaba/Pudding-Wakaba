
wakaba:RegisterPatch(0, "MilkshakeVol1", function() return (MilkshakeVol1 and MilkshakeVol1.API ~= nil) end, function()
	do
		local m = MilkshakeVol1
		local ma = MilkshakeVol1.API
	
		wakaba:BlacklistBook(MilkshakeVol1.enums.Collectibles.LEVITICUS, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(MilkshakeVol1.enums.Collectibles.LEVITICUS, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		wakaba:BlacklistBook(MilkshakeVol1.enums.Collectibles.LEVITICUS, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
	
		-- Condictivity orb reward for Shiori's valut
		-- Condictivity orb reward for Crystal Restock
		-- Condictivity orb reward for Cleaner
	
		-- Glass Pool items
	
		-- Soulstones for Spirit Kiln
		ma:AddSoulStone(wakaba.Enums.Cards.SOUL_WAKABA, function() return wakaba:IsCompletionItemUnlockedTemp(wakaba.Enums.Cards.SOUL_WAKABA, "card") end)
		ma:AddSoulStone(wakaba.Enums.Cards.SOUL_WAKABA2, function() return wakaba:IsCompletionItemUnlockedTemp(wakaba.Enums.Cards.SOUL_WAKABA, "card") end)
		ma:AddSoulStone(wakaba.Enums.Cards.SOUL_SHIORI, function() return wakaba:IsCompletionItemUnlockedTemp(wakaba.Enums.Cards.SOUL_SHIORI, "card") end)
		ma:AddSoulStone(wakaba.Enums.Cards.SOUL_TSUKASA, function() return wakaba:IsCompletionItemUnlockedTemp(wakaba.Enums.Cards.SOUL_TSUKASA, "card") end)
		ma:AddSoulStone(wakaba.Enums.Cards.SOUL_RICHER, function() return wakaba:IsCompletionItemUnlockedTemp(wakaba.Enums.Cards.SOUL_RICHER, "card") end)
		ma:AddSoulStone(wakaba.Enums.Cards.SOUL_RIRA, function() return wakaba:IsCompletionItemUnlockedTemp(wakaba.Enums.Cards.SOUL_RIRA, "card") end)
	
		-- Glass trinkets for Spirit Kiln
		ma:AddGlassTrinkets(wakaba.Enums.Trinkets.AURORA_GEM, function () return wakaba:IsEntryUnlocked("easteregg") end)
		ma:AddGlassTrinkets(wakaba.Enums.Trinkets.STAR_REVERSAL, function () return wakaba:IsEntryUnlocked("starreversal") end)
	end
end)