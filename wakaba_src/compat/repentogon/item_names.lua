

wakaba:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, function()

	for i, func in ipairs(wakaba.Blacklists.NameLocalization) do
		if func() then
			return wakaba:RegisterLegacyItemNames()
		end
	end
	wakaba:RegisterBirthrightLegacyItemNames()

	local languageMap = wakaba.LanguageMap
	local descTable = wakaba.descriptions[languageMap[Options.Language]]
	if not descTable then return end

	-- Birthright
	if descTable.birthright then
		for _, playerType in pairs(wakaba.Enums.Players) do
			local pConfig = EntityConfig.GetPlayer(playerType)
			if pConfig and descTable.birthright[playerType] then
				-- TODO : Insert Birthright desc here
			end
		end
	end

	-- Collectible
	if descTable.collectibles then
		for _, itemID in pairs(wakaba.Enums.Collectibles) do
			local config = Isaac.GetItemConfig()
			local item = config:GetCollectible(itemID)
			if itemID and item and descTable.collectibles[itemID] then
				item.Name = descTable.collectibles[itemID].itemName or item.Name
				item.Description = descTable.collectibles[itemID].queueDesc or item.Description
			end
		end
	end

	-- Trinket
	if descTable.trinkets then
		for _, itemID in pairs(wakaba.Enums.Trinkets) do
			local config = Isaac.GetItemConfig()
			local item = config:GetTrinket(itemID)
			if itemID and item and descTable.trinkets[itemID] then
				item.Name = descTable.trinkets[itemID].itemName or item.Name
				item.Description = descTable.trinkets[itemID].queueDesc or item.Description
			end
		end
	end

	-- Cards
	if descTable.cards then
		for _, itemID in pairs(wakaba.Enums.Cards) do
			local config = Isaac.GetItemConfig()
			local item = config:GetCard(itemID)
			if itemID and item and descTable.cards[itemID] then
				item.Name = descTable.cards[itemID].itemName or item.Name
				item.Description = descTable.cards[itemID].queueDesc or item.Description
			end
		end
	end

	-- Pills
	if descTable.pills then
		for _, itemID in pairs(wakaba.Enums.Pills) do
			local config = Isaac.GetItemConfig()
			local item = config:GetPillEffect(itemID)
			if itemID and item and descTable.pills[itemID] then
				item.Name = descTable.pills[itemID].itemName or item.Name
				--item.Description = descTable.pills[itemID].queueDesc or item.Description
			end
		end
	end
end)
