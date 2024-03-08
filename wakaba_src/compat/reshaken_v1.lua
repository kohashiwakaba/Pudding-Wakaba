if not MilkshakeVol1 then return end
local replaced = false
local m = MilkshakeVol1
local ma = MilkshakeVol1.API
function wakaba:GameStart_ReshakenCompat()

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

	-- Glass trinkets for Spirit Kiln
	ma:AddGlassTrinkets(wakaba.Enums.Trinkets.AURORA_GEM, function () return wakaba:IsEntryUnlocked("easteregg") end)
	ma:AddGlassTrinkets(wakaba.Enums.Trinkets.STAR_REVERSAL, function () return wakaba:IsEntryUnlocked("starreversal") end)

end