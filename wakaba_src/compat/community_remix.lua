
wakaba:RegisterPatch(0, "communityRemix", function() return (communityRemix ~= nil) end, function()
	do
		wakaba:BulkAppend(wakaba.CustomPool.ShioriValut, {
			{communityRemix.CollectibleType.COLLECTIBLE_CHILLY_BEAN, 1.00},
			{communityRemix.CollectibleType.COLLECTIBLE_CRYOBOMBS, 1.00},
			{communityRemix.CollectibleType.COLLECTIBLE_THE_HIVE, 1.00},
			{communityRemix.CollectibleType.COLLECTIBLE_OPHIUCHUS, 1.00},
			{communityRemix.CollectibleType.COLLECTIBLE_BLUE_WAFFLE, 1.00},
			{communityRemix.CollectibleType.COLLECTIBLE_GEODE, 1.00},
			{communityRemix.CollectibleType.COLLECTIBLE_CONQUEROR_BABY, 1.00},
			{communityRemix.CollectibleType.COLLECTIBLE_TOOTHPASTE, 1.00},
			{communityRemix.CollectibleType.COLLECTIBLE_POWER_BALL, 1.00},
			--{communityRemix.CollectibleType.COLLECTIBLE_CHAKRAM, 1.00},
		})
		wakaba:BulkAppend(wakaba.CustomPool.CloverChest, {
			{Sheriff.Items.MOAB.ID, 0.10},
			{Sheriff.Items.LightningRod.ID, 0.20},
		})
	end
end)