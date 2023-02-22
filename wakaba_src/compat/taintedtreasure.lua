local ttReplaced = false
function wakaba:GameStart_TaintedTreasureCompat()
	if TaintedTreasure then
		local mod = TaintedTreasure
		if not ttReplaced then
			mod:AddTaintedTreasure(wakaba.Enums.Collectibles.WAKABAS_BLESSING, wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
		end
	end
	ttReplaced = true
end