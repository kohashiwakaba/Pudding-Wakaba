local ttReplaced = false
function wakaba:GameStart_TaintedTreasureCompat()
	if TaintedTreasure then
		local mod = TaintedTreasure
		if not ttReplaced then
			mod:AddTaintedTreasure(wakaba.Enums.Collectibles.WAKABAS_BLESSING, wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
			mod:AddTaintedTreasure(wakaba.Enums.Collectibles.BOOK_OF_SHIORI, wakaba.Enums.Collectibles.MINERVA_AURA)
			mod:AddTaintedTreasure(wakaba.Enums.Collectibles.LUNAR_STONE, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE)

			mod:AddTaintedTreasure(wakaba.Enums.Collectibles.D_CUP_ICECREAM, wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM)
			mod:AddTaintedTreasure(wakaba.Enums.Collectibles.ONSEN_TOWEL, wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)
			--mod:AddTaintedTreasure(wakaba.Enums.Collectibles.REVENGE_FRUIT, wakaba.Enums.Collectibles.ZIPPED_FRUIT)
			mod:AddTaintedTreasure(wakaba.Enums.Collectibles.WAKABAS_PENDANT, wakaba.Enums.Collectibles.WAKABAS_HAIRPIN)
		end
	end
	ttReplaced = true
end