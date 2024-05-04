local ttReplaced = false
function wakaba:GameStart_SDCompat()
	wakaba.Blacklists.MaidDuetCharges[SDMod.Item.SAND_POUCH] = true
	wakaba.Blacklists.MaidDuetCharges[SDMod.Item.DER_SANDMANN_B] = true

	wakaba.Blacklists.MaidDuetPlayers[SDMod.PlayerType.PLAYER_GUARD] = true

	ttReplaced = true
end
