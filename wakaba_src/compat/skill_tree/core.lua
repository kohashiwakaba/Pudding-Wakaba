wakaba._sktval = "gfx/ui/wakaba/skilltree/tree_nodes"
wakaba._sktreplace = false
local modifiers = include("wakaba_src.compat.skill_tree.modifier_descriptions")
wakaba:RegisterPatch(0, "PST", function() return (PST ~= nil) end, function()
	do
		local itemConfig = Isaac.GetItemConfig()
		for _, itemID in pairs(wakaba.Enums.Collectibles) do
			local c = itemConfig:GetCollectible(itemID)
			if c then
				local h = c.AddMaxHearts
				if h and h > 0 then
					PST.heartUpItems[itemID] = h
				end
			end
		end
	end

	do
		for node, val in pairs(modifiers) do
			PST.treeModDescriptions[node] = val
		end
	end

	do
		PST.charNames[1 + wakaba.Enums.Players.WAKABA] = "Wakaba"
		PST.charNames[1 + wakaba.Enums.Players.SHIORI] = "Shiori"
		PST.charNames[1 + wakaba.Enums.Players.TSUKASA] = "Tsukasa"
		PST.charNames[1 + wakaba.Enums.Players.RICHER] = "Richer"
		PST.charNames[1 + wakaba.Enums.Players.RIRA] = "Rira"

		PST.charNames[1 + wakaba.Enums.Players.WAKABA_B] = "T. Wakaba"
		PST.charNames[1 + wakaba.Enums.Players.SHIORI_B] = "T. Shiori"
		PST.charNames[1 + wakaba.Enums.Players.TSUKASA_B] = "T. Tsukasa"
		PST.charNames[1 + wakaba.Enums.Players.RICHER_B] = "T. Richer"
		PST.charNames[1 + wakaba.Enums.Players.RIRA_B] = "T. Rira"
	end

	-- TODO add support if custom nodes are possible

	do -- NODES WAKABA
		-- PST.SkillTreesAPI.AddCharacterTree("Wakaba", ...)
		--[[
		for nodeID, node in pairs(PST.trees["Wakaba"]) do
			node.sprite = Sprite("gfx/ui/wakaba/skilltree/tree_nodes.anm2", true)
			node.sprite:ReplaceSpritesheet(0, "gfx/ui/wakaba/skilltree/tree_nodes.png", true)
		end
		 ]]
	end

	do -- NODES SHIORI
	end

	do -- NODES TSUKASA
	end

	do -- NODES RICHER
	end

	do -- NODES RIRA
	end
end)