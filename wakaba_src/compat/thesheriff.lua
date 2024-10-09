
wakaba:RegisterPatch(0, "Sheriff", function() return (Sheriff ~= nil) end, function()
	do
		wakaba:BulkAppend(wakaba.Weights.ShioriValut, {
			{Sheriff.Items.SpiritOfTheWest.ID, 1.00},
		})
		wakaba:BulkAppend(wakaba.Weights.CloverChest, {
			{Sheriff.Items.MOAB.ID, 0.10},
			{Sheriff.Items.LightningRod.ID, 0.20},
		})
	end
end)