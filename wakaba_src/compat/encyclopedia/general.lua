if Encyclopedia then
	wakaba.encyclopediadesc.desc.disabled_items = {
		Isaac.GetItemIdByName("Wakaba's 9'o Clock Curfew"),
		Isaac.GetItemIdByName("Shiori's Red Bookmark"),
		Isaac.GetItemIdByName("Shiori's Blue Bookmark"),
		Isaac.GetItemIdByName("Shiori's Yellow Bookmark"),
		Isaac.GetItemIdByName("Lunar Damocles"),
		Isaac.GetItemIdByName("Lil Rira"),
		Isaac.GetItemIdByName("Trial Stew"),
		Isaac.GetItemIdByName("Broken Toolbox"),
		Isaac.GetItemIdByName("Rira's Coat"),
		Isaac.GetItemIdByName("Rira's Bento"),
		Isaac.GetItemIdByName("Chewy Rolly Cake"),
		Isaac.GetItemIdByName("Clover Shard"),
	}
	wakaba.encyclopediadesc.desc.priority_collectibles = {
		wakaba.Enums.Collectibles.WAKABAS_BLESSING,
		wakaba.Enums.Collectibles.WAKABAS_NEMESIS,
		wakaba.Enums.Collectibles.EATHEART,
		wakaba.Enums.Collectibles.WAKABA_DUALITY,
		wakaba.Enums.Collectibles.BOOK_OF_SHIORI,
		wakaba.Enums.Collectibles.BOOK_OF_CONQUEST,
		wakaba.Enums.Collectibles.MINERVA_AURA,
		wakaba.Enums.Collectibles.LUNAR_STONE,
		wakaba.Enums.Collectibles.CONCENTRATION,
		wakaba.Enums.Collectibles.MURASAME,
		wakaba.Enums.Collectibles.ELIXIR_OF_LIFE,
		wakaba.Enums.Collectibles.FLASH_SHIFT,
		wakaba.Enums.Collectibles.RABBIT_RIBBON,
		wakaba.Enums.Collectibles.SWEETS_CATALOG,
		wakaba.Enums.Collectibles.WINTER_ALBIREO,
		wakaba.Enums.Collectibles.WATER_FLAME,
		wakaba.Enums.Collectibles.CHIMAKI,
		wakaba.Enums.Collectibles.NERF_GUN,
	}
	wakaba.encyclopediadesc.custom_pools = {}

	function wakaba:RegisterCustomEncyPool(poolName, wakabaWeightName, anm2)
		anm2 = anm2 or "gfx/ui/epiphany_custom_icons.anm2"
		Encyclopedia.ItemPools[poolName] = Encyclopedia.GetItemPoolIdByName(poolName)
		local s = Encyclopedia.RegisterSprite(anm2, epiphPool, 0)
		Encyclopedia.AddItemPoolSprite(Encyclopedia.ItemPools[poolName], s)
		wakaba.encyclopediadesc.custom_pools[wakabaWeightName] = poolName
	end

	wakaba:RegisterCustomEncyPool("POOL_CLOVER_CHEST", "CloverChest")
	wakaba:RegisterCustomEncyPool("POOL_SHIORI_VALUT", "ShioriValut")

	for _, itemID in pairs(wakaba.encyclopediadesc.desc.priority_collectibles) do
		wakaba:AddEncyCollectibleEntry(itemID)
	end

	for _, itemID in pairs(wakaba.Enums.Collectibles) do
		if not wakaba:has_value(wakaba.encyclopediadesc.desc.disabled_items, itemID) and not wakaba:has_value(wakaba.encyclopediadesc.desc.priority_collectibles, itemID) then
			wakaba:AddEncyCollectibleEntry(itemID)
		end
	end

	function wakaba:AddEncyCollectibleEntry(itemID)

	end

end