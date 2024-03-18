wakaba.Callback.MOD_NAME_TRANSLATE_BLACKLIST = "WakabaCallbacks.MOD_NAME_TRANSLATE_BLACKLIST"

local function isNameEnglish()
	local item = wakaba.Enums.Collectibles.WAKABA_DUALITY
	local config = Isaac.GetItemConfig():GetCollectible(item)

	return config.Name == "Wakaba Duality"
end

wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	local shouldBlacklisted = Isaac.RunCallback(wakaba.Callback.MOD_NAME_TRANSLATE_BLACKLIST)
	local isEnglishName = isNameEnglish()

	if shouldBlacklisted and not isEnglishName then
		wakaba:ConvertItemNameLocalization("en")
	elseif not shouldBlacklisted and isEnglishName then
		wakaba:ConvertItemNameLocalization()
	end
end)

function wakaba:ConvertItemNameLocalization(forceLang)
	local languageMap = wakaba.LanguageMap
	local descTable = wakaba.descriptions[languageMap[forceLang] or languageMap[Options.Language]]
	local descTableEng = wakaba.descriptions["en_us"]
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
				if descTableEng.collectibles[itemID] and not descTableEng.collectibles[itemID].queueDesc then
					descTableEng.collectibles[itemID].queueDesc = item.Description..""
				end
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
				if descTableEng.trinkets[itemID] and not descTableEng.trinkets[itemID].queueDesc then
					descTableEng.trinkets[itemID].queueDesc = item.Description..""
				end
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
				if descTableEng.cards[itemID] and not descTableEng.cards[itemID].queueDesc then
					descTableEng.cards[itemID].queueDesc = item.Description..""
				end
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
end

wakaba:AddCallback(wakaba.Callback.MOD_NAME_TRANSLATE_BLACKLIST, function()
	if DaRules then
		local g = DaRules.G()
		if g.minipoprulesopen or g.poprulesopen then return true end
	end
	if Encyclopedia then
		if DeadSeaScrollsMenu.OpenedMenu and DeadSeaScrollsMenu.OpenedMenu.Name == "Encyclopedia" then -- TODO do not return true if wakaba dss is open
			--return true
		end
	end
end)

wakaba:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, function()
	if DaRules then
		-- Da Rules does not have global check whether Da Rules window is open or not, so need to override function
		-- poprulesopen variable is local. that's reason
		local g = DaRules.G()
		local oldClose = DaRules.ClosePopRules
		DaRules.ClosePopRules = function(real)
			g.poprulesopen = false
			return oldClose(real)
		end

		local oldOpen = DaRules.OpenPopRules
		DaRules.OpenPopRules = function(force)
			if (DRLevel:GetStartingRoomIndex() == DRRoomDesc.SafeGridIndex) or force then
				g.poprulesopen = true
			else
				g.poprulesopen = false
			end
			return oldOpen(force)
		end
	end
end)