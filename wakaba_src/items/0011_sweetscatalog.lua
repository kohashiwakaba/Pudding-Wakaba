wakaba.CatalogItems = {
	["TEMP"] = {
		Weight = 0, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_C_SECTION,
		},
		MainItem = CollectibleType.COLLECTIBLE_C_SECTION,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = false,
	},
	["KNIFE"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_MOMS_KNIFE,
		},
		MainItem = CollectibleType.COLLECTIBLE_MOMS_KNIFE,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["SPIRIT"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_SPIRIT_SWORD,
		},
		MainItem = CollectibleType.COLLECTIBLE_SPIRIT_SWORD,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["BRIM"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_BRIMSTONE,
			CollectibleType.COLLECTIBLE_BRIMSTONE,
		},
		MainItem = CollectibleType.COLLECTIBLE_BRIMSTONE,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["TECH"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_TECHNOLOGY,
		},
		MainItem = CollectibleType.COLLECTIBLE_TECHNOLOGY,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["FETUS"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_DR_FETUS,
		},
		MainItem = CollectibleType.COLLECTIBLE_DR_FETUS,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["EPIC"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_EPIC_FETUS,
		},
		MainItem = CollectibleType.COLLECTIBLE_EPIC_FETUS,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["SECTION"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_C_SECTION,
		},
		MainItem = CollectibleType.COLLECTIBLE_C_SECTION,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["RING"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_TECH_X,
		},
		MainItem = CollectibleType.COLLECTIBLE_TECH_X,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
}

function wakaba:ItemUse_SweetsCatalog(_, rng, player, useFlags, activeSlot, varData)

	-- get random 
	local catalog = wakaba.CatalogItems
	local totalweight = 0
	local tempCatalog = {}
	for k, v in pairs(catalog) do
		if v.Weight then
			v.Name = k
			totalweight = totalweight + v.Weight
			v.Range = totalweight
			table.insert(tempCatalog, v)
		end
	end

	local chosenVal = ""
	local prevRange = 0
	local val = rng:RandomFloat() * totalweight
	for i, v in ipairs(tempCatalog) do
		--print("calculating:",prevRange,"[",val,"]",v.Range,"/",totalweight,"max",v.Name)
		if val >= prevRange and val < v.Range then
			chosenVal = v.Name

			--print(chosenVal.." chosen, ranged", prevRange, "to", v.Range, "val:", val)
			break
		end
		prevRange = v.Range
	end
	--print("chosenVal:",chosenVal)

	local previewItem = wakaba.Enums.Collectibles.SWEETS_CATALOG

	if wakaba.CatalogItems[chosenVal] then
		previewItem = wakaba.CatalogItems[chosenVal].MainItem
		--print("CatalogItems found for:",chosenVal)
		wakaba.HiddenItemManager:Add(player, 1, -1, 1, "RICHER_CATALOG")
		if wakaba.HiddenItemManager:GetStacks(player, "RICHER_CATALOG") then
			wakaba.HiddenItemManager:RemoveAll(player, "RICHER_CATALOG")
		end
		if player:GetPlayerType() == wakaba.Enums.Players.RICHER and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			--wakaba.HiddenItemManager:Add(player, 1, -1, 1, "RICHER_CATALOG")
			for i, itemID in ipairs(wakaba.CatalogItems[chosenVal].Items) do
				wakaba.HiddenItemManager:Add(player, itemID, -1, 1, "RICHER_CATALOG")
			end
		else
			for i, itemID in ipairs(wakaba.CatalogItems[chosenVal].Items) do
				wakaba.HiddenItemManager:AddForRoom(player, itemID, -1, 1, "RICHER_CATALOG")
			end
		end
	end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(previewItem or wakaba.Enums.Collectibles.SWEETS_CATALOG, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_SweetsCatalog, wakaba.Enums.Collectibles.SWEETS_CATALOG)







