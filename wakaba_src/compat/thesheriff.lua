
wakaba:RegisterPatch(0, "Sheriff", function() return (Sheriff ~= nil) end, function()
	do
		wakaba:BulkAppend(wakaba.Weights.ShioriValut, {
			{Sheriff.Items.SpiritOfTheWest.ID, 1.00},
		})
		wakaba:BulkAppend(wakaba.Weights.CloverChest, {
			{Sheriff.Items.MOAB.ID, 0.10},
			{Sheriff.Items.LightningRod.ID, 0.20},
		})

		wakaba:AddCallback(wakaba.Callback.WAKABA_COLLECTIBLE_REROLL, function(_, rerollProps, selected, selectedItemConf, itemPoolType, decrease, seed, isCustom)
			if isCustom and (selected >= Isaac.GetItemIdByName("Quick Draw") and selected <= Isaac.GetItemIdByName("Spirit of the West")) then
				if not UnlockAPI.Library:IsCollectibleUnlocked(selected) then
					return true
				end
			end
		end)
	end
end)