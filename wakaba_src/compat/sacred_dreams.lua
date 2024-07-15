
wakaba:RegisterPatch(0, "SacredDreams", function() return (SacredDreams ~= nil) end, function()
	wakaba.Blacklists.MaidDuetCharges[SDMod.Item.SAND_POUCH] = true
	wakaba.Blacklists.MaidDuetCharges[SDMod.Item.DER_SANDMANN_B] = true

	wakaba.Blacklists.MaidDuetPlayers[SDMod.PlayerType.PLAYER_GUARD] = true
end)
