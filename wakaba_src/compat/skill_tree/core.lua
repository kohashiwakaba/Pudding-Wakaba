local pa = false
local pstFirstLevel = false

local modifiers = include("wakaba_src.compat.skill_tree.modifier_descriptions")
local sprite_ids = include("wakaba_src.compat.skill_tree.sprite_ids")
local global_nodes = include("wakaba_src.compat.skill_tree.global_nodes")
wakaba.PSTSprite = Sprite("gfx/ui/wakaba/skilltree/wakaba_nodes.anm2", true)
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
		PST.SkillTreesAPI.AddModifierCategory("wakabaGlobal", "Pudding & Wakaba additions", KColor(200, 30, 240, 1))
	end

	do
		for node, val in pairs(modifiers) do
			PST.SkillTreesAPI.AddModifierDescription(
				node,
				val.category,
				val.str,
				val.addPlus,
				val.sort
			)
		end
		wakaba:AddCallback(wakaba.Callback.EXTRA_VALUE, function(_, key, default)
			return PST.SkillTreesAPI.GetSnapshotMod(key, default)
		end, node)
	end

	do
		for _, identifier in pairs(sprite_ids) do
			PST.SkillTreesAPI.InitCustomNodeImage(identifier, wakaba.PSTSprite)
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

		PST.charNames[1 + wakaba.Enums.Players.ANNA] = "Anna"
	end

	do
		table.insert(wakaba.Blacklists.AquaTrinkets, Isaac.GetTrinketIdByName("Azure Starcursed Jewel"))
		table.insert(wakaba.Blacklists.AquaTrinkets, Isaac.GetTrinketIdByName("Crimson Starcursed Jewel"))
		table.insert(wakaba.Blacklists.AquaTrinkets, Isaac.GetTrinketIdByName("Viridian Starcursed Jewel"))
		table.insert(wakaba.Blacklists.AquaTrinkets, Isaac.GetTrinketIdByName("Ancient Starcursed Jewel"))
	end

	function wakaba:PreLoad_PST(saveslot, isSlotSelected, rawSlot)

		if not isSlotSelected then return end

		do -- NODES WAKABA
		PST.SkillTreesAPI.AddCharacterTree("Wakaba", false, [[
	{
	"112": "{\"pos\":[3,-31],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[687,693]}",
	"114": "{\"pos\":[3,-33],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[693,694]}",
	"116": "{\"pos\":[5,-33],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[621,694]}",
	"276": "{\"pos\":[-16,-18],\"type\":33,\"size\":\"Small\",\"name\":\"Mapping Chance\",\"description\":[\"+1% chance for the map to be revealed upon entering a floor\",\"Works from the second floor onwards\"],\"modifiers\":{\"mapChance\":1},\"adjacent\":[600]}",
	"278": "{\"pos\":[-16,-19],\"type\":33,\"size\":\"Small\",\"name\":\"Mapping Chance\",\"description\":[\"+1% chance for the map to be revealed upon entering a floor\",\"Works from the second floor onwards\"],\"modifiers\":{\"mapChance\":1},\"adjacent\":[601]}",
	"280": "{\"pos\":[-16,-20],\"type\":33,\"size\":\"Small\",\"name\":\"Mapping Chance\",\"description\":[\"+1% chance for the map to be revealed upon entering a floor\",\"Works from the second floor onwards\"],\"modifiers\":{\"mapChance\":1},\"adjacent\":[602]}",
	"282": "{\"pos\":[-16,-21],\"type\":33,\"size\":\"Small\",\"name\":\"Mapping Chance\",\"description\":[\"+1% chance for the map to be revealed upon entering a floor\",\"Works from the second floor onwards\"],\"modifiers\":{\"mapChance\":1},\"adjacent\":[603]}",
	"345": "{\"pos\":[0,0],\"type\":5009,\"size\":\"Large\",\"name\":\"Tree of Wakaba\",\"description\":[\"+0.05 all stats\",\"All nodes from this tree except stats will impact all characters unless specified for Wakaba\"],\"modifiers\":{\"allstatsPerc\":0.05},\"adjacent\":[346],\"alwaysAvailable\":true,\"customID\":\"w_wakaba_0000\"}",
	"346": "{\"pos\":[0,-1],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[345,347,355]}",
	"347": "{\"pos\":[0,-2],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[346,348,358]}",
	"348": "{\"pos\":[0,-3],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[347,350,361]}",
	"350": "{\"pos\":[0,-4],\"type\":25,\"size\":\"Med\",\"name\":\"Luck\",\"description\":[\"+0.15 luck\"],\"modifiers\":{\"luck\":0.15},\"adjacent\":[348,351,364]}",
	"351": "{\"pos\":[0,-5],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[350,352,362]}",
	"352": "{\"pos\":[0,-6],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[351,353,365]}",
	"353": "{\"pos\":[0,-7],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[352,354]}",
	"354": "{\"pos\":[0,-8],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[353,368]}",
	"355": "{\"pos\":[-2,-3],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[346]}",
	"356": "{\"pos\":[-3,-5],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[361]}",
	"357": "{\"pos\":[-4,-7],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[363]}",
	"358": "{\"pos\":[2,-4],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[347]}",
	"359": "{\"pos\":[3,-6],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[364]}",
	"360": "{\"pos\":[4,-8],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[366]}",
	"361": "{\"pos\":[-2,-5],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[348,356]}",
	"362": "{\"pos\":[-2,-7],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[351,363]}",
	"363": "{\"pos\":[-3,-7],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[362,357]}",
	"364": "{\"pos\":[2,-6],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[350,359]}",
	"365": "{\"pos\":[2,-8],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[352,366]}",
	"366": "{\"pos\":[3,-8],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[365,360]}",
	"368": "{\"pos\":[0,-10],\"type\":5002,\"size\":\"Large\",\"name\":\"Pendant Luck\",\"description\":[\"+0.5 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.5},\"adjacent\":[354,525,644,604,558,665],\"customID\":\"w_wakaba_0003\"}",
	"387": "{\"pos\":[-1,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[674,388]}",
	"388": "{\"pos\":[-2,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[387,389]}",
	"389": "{\"pos\":[-3,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[388,390]}",
	"390": "{\"pos\":[-4,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[389,391]}",
	"391": "{\"pos\":[-5,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[390,392]}",
	"392": "{\"pos\":[-6,-30],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[391,393],\"customID\":\"w_wakaba_0001\"}",
	"393": "{\"pos\":[-7,-31],\"type\":5001,\"size\":\"Med\",\"name\":\"Pendant Luck\",\"description\":[\"+0.2 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.2},\"adjacent\":[392,394],\"customID\":\"w_wakaba_0002\"}",
	"394": "{\"pos\":[-8,-32],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[393,420],\"customID\":\"w_wakaba_0001\"}",
	"396": "{\"pos\":[-8,-34],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[420,397],\"customID\":\"w_wakaba_0001\"}",
	"397": "{\"pos\":[-7,-35],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[396,398],\"customID\":\"w_wakaba_0001\"}",
	"398": "{\"pos\":[-6,-35],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[397,399],\"customID\":\"w_wakaba_0001\"}",
	"399": "{\"pos\":[-5,-36],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[398,401],\"customID\":\"w_wakaba_0001\"}",
	"401": "{\"pos\":[-5,-37],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[399,402],\"customID\":\"w_wakaba_0001\"}",
	"402": "{\"pos\":[-4,-38],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[401,421],\"customID\":\"w_wakaba_0001\"}",
	"404": "{\"pos\":[-2,-38],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[421,405],\"customID\":\"w_wakaba_0001\"}",
	"405": "{\"pos\":[-1,-37],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[404,422],\"customID\":\"w_wakaba_0001\"}",
	"407": "{\"pos\":[-1,-35],\"type\":5001,\"size\":\"Med\",\"name\":\"Pendant Luck\",\"description\":[\"+0.2 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.2},\"adjacent\":[422,423],\"customID\":\"w_wakaba_0002\"}",
	"409": "{\"pos\":[-1,-33],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[423,410],\"customID\":\"w_wakaba_0001\"}",
	"410": "{\"pos\":[-2,-32],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[409,416],\"customID\":\"w_wakaba_0001\"}",
	"413": "{\"pos\":[-4,-32],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[416,415],\"customID\":\"w_wakaba_0001\"}",
	"415": "{\"pos\":[-5,-33],\"type\":5002,\"size\":\"Large\",\"name\":\"Pendant Luck\",\"description\":[\"+0.5 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.5},\"adjacent\":[413,417],\"customID\":\"w_wakaba_0003\"}",
	"416": "{\"pos\":[-3,-32],\"type\":5001,\"size\":\"Med\",\"name\":\"Pendant Luck\",\"description\":[\"+0.2 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.2},\"adjacent\":[410,413],\"customID\":\"w_wakaba_0002\"}",
	"417": "{\"pos\":[-4,-34],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 minimum luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[415,620],\"customID\":\"w_wakaba_0001\"}",
	"420": "{\"pos\":[-8,-33],\"type\":302,\"size\":\"Small\",\"name\":\"Secret Room Floor Luck\",\"description\":[\"+0.1 luck for the current floor when first entering a secret or super secret room.\"],\"modifiers\":{\"secretRoomFloorLuck\":0.1},\"adjacent\":[394,396]}",
	"421": "{\"pos\":[-3,-38],\"type\":302,\"size\":\"Small\",\"name\":\"Secret Room Floor Luck\",\"description\":[\"+0.1 luck for the current floor when first entering a secret or super secret room.\"],\"modifiers\":{\"secretRoomFloorLuck\":0.1},\"adjacent\":[402,404]}",
	"422": "{\"pos\":[-1,-36],\"type\":302,\"size\":\"Small\",\"name\":\"Secret Room Floor Luck\",\"description\":[\"+0.1 luck for the current floor when first entering a secret or super secret room.\"],\"modifiers\":{\"secretRoomFloorLuck\":0.1},\"adjacent\":[405,407]}",
	"423": "{\"pos\":[-1,-34],\"type\":302,\"size\":\"Small\",\"name\":\"Secret Room Floor Luck\",\"description\":[\"+0.1 luck for the current floor when first entering a secret or super secret room.\"],\"modifiers\":{\"secretRoomFloorLuck\":0.1},\"adjacent\":[407,409]}",
	"425": "{\"pos\":[1,-30],\"type\":5004,\"size\":\"Med\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{},\"adjacent\":[674,426],\"customID\":\"w_wakaba_0005\"}",
	"426": "{\"pos\":[1,-31],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[425,427]}",
	"427": "{\"pos\":[1,-32],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[426,428]}",
	"428": "{\"pos\":[1,-33],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[427,429]}",
	"429": "{\"pos\":[1,-34],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[428,676]}",
	"453": "{\"pos\":[1,-28],\"type\":5008,\"size\":\"Large\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"1% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":1},\"adjacent\":[674,454],\"customID\":\"w_wakaba_0009\"}",
	"454": "{\"pos\":[2,-28],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[453,455]}",
	"455": "{\"pos\":[3,-28],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[454,456]}",
	"456": "{\"pos\":[4,-28],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[455,457]}",
	"457": "{\"pos\":[5,-28],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[456,458]}",
	"458": "{\"pos\":[6,-28],\"type\":5006,\"size\":\"Small\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.2},\"adjacent\":[457,459],\"customID\":\"w_wakaba_0007\"}",
	"459": "{\"pos\":[7,-27],\"type\":5007,\"size\":\"Med\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.5},\"adjacent\":[458,460],\"customID\":\"w_wakaba_0008\"}",
	"460": "{\"pos\":[8,-26],\"type\":5006,\"size\":\"Small\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.2},\"adjacent\":[459,461],\"customID\":\"w_wakaba_0007\"}",
	"461": "{\"pos\":[8,-25],\"type\":301,\"size\":\"Small\",\"name\":\"Pill Floor Luck\",\"description\":[\"1% increased luck for the current floor when you consume a pill\"],\"modifiers\":{\"pillFloorLuck\":1},\"adjacent\":[460,462]}",
	"462": "{\"pos\":[8,-24],\"type\":5006,\"size\":\"Small\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.2},\"adjacent\":[461,467],\"customID\":\"w_wakaba_0007\"}",
	"467": "{\"pos\":[7,-23],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[462,468]}",
	"468": "{\"pos\":[6,-23],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[467,469]}",
	"469": "{\"pos\":[5,-22],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[468,470]}",
	"470": "{\"pos\":[5,-21],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[469,475]}",
	"475": "{\"pos\":[4,-20],\"type\":5006,\"size\":\"Small\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.2},\"adjacent\":[470,477],\"customID\":\"w_wakaba_0007\"}",
	"477": "{\"pos\":[3,-20],\"type\":5007,\"size\":\"Med\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.5},\"adjacent\":[475,478],\"customID\":\"w_wakaba_0008\"}",
	"478": "{\"pos\":[2,-20],\"type\":5006,\"size\":\"Small\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.2},\"adjacent\":[477,479],\"customID\":\"w_wakaba_0007\"}",
	"479": "{\"pos\":[1,-21],\"type\":5006,\"size\":\"Small\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.2},\"adjacent\":[478,480],\"customID\":\"w_wakaba_0007\"}",
	"480": "{\"pos\":[1,-22],\"type\":5007,\"size\":\"Med\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.5},\"adjacent\":[479,481],\"customID\":\"w_wakaba_0008\"}",
	"481": "{\"pos\":[1,-23],\"type\":5008,\"size\":\"Large\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"1% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":1},\"adjacent\":[480,482],\"customID\":\"w_wakaba_0009\"}",
	"482": "{\"pos\":[1,-24],\"type\":5007,\"size\":\"Med\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.5},\"adjacent\":[481,483],\"customID\":\"w_wakaba_0008\"}",
	"483": "{\"pos\":[1,-25],\"type\":5006,\"size\":\"Small\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.2},\"adjacent\":[482,484],\"customID\":\"w_wakaba_0007\"}",
	"484": "{\"pos\":[2,-26],\"type\":5006,\"size\":\"Small\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.2},\"adjacent\":[483,485],\"customID\":\"w_wakaba_0007\"}",
	"485": "{\"pos\":[3,-26],\"type\":5007,\"size\":\"Med\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.5},\"adjacent\":[484,486],\"customID\":\"w_wakaba_0008\"}",
	"486": "{\"pos\":[4,-26],\"type\":5006,\"size\":\"Small\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.2},\"adjacent\":[485,487],\"customID\":\"w_wakaba_0007\"}",
	"487": "{\"pos\":[5,-25],\"type\":5008,\"size\":\"Large\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"1% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":1},\"adjacent\":[486,675],\"customID\":\"w_wakaba_0009\"}",
	"491": "{\"pos\":[5,-32],\"type\":5032,\"size\":\"Large\",\"name\":\"[Wakaba] Daughter of the Rich\",\"description\":[\"Can get all selection items\"],\"modifiers\":{\"wakabaJaebol\":true},\"adjacent\":[621],\"customID\":\"w_wakaba_1003\"}",
	"492": "{\"pos\":[-3,-34],\"type\":5030,\"size\":\"Large\",\"name\":\"[Wakaba] Good Girl\",\"description\":[\"Starts with Wakaba's Pendant\",\"Perfection no longer spawns\"],\"modifiers\":{\"wakabaGudGirl\":true},\"adjacent\":[620],\"customID\":\"w_wakaba_1001\"}",
	"493": "{\"pos\":[-5,-26],\"type\":5034,\"size\":\"Large\",\"name\":\"Tearing Clover Leaf\",\"description\":[\"Negates a hit that would've killed you, if you have more than 0 luck.\",\"Negating a hit reduces 20, or 20% of current luck, higher value prioritized.\",\"Reduced luck this way ignores Wakaba's Pendant\",\"Does not work if player has Rock Bottom.\"],\"modifiers\":{\"wakabaLeafTear\":true},\"adjacent\":[619],\"customID\":\"w_wakaba_1005\"}",
	"494": "{\"pos\":[-1,-28],\"type\":5015,\"size\":\"Large\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"5% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":5},\"adjacent\":[674,495],\"customID\":\"w_wakaba_0016\"}",
	"495": "{\"pos\":[-1,-27],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[494,496],\"customID\":\"w_global_0004\"}",
	"496": "{\"pos\":[-1,-26],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[495,497],\"customID\":\"w_global_0004\"}",
	"497": "{\"pos\":[-1,-25],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[496,498],\"customID\":\"w_global_0004\"}",
	"498": "{\"pos\":[-1,-24],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[497,499],\"customID\":\"w_global_0004\"}",
	"499": "{\"pos\":[-1,-23],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[498,500],\"customID\":\"w_wakaba_0014\"}",
	"500": "{\"pos\":[-2,-22],\"type\":5014,\"size\":\"Med\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":1},\"adjacent\":[499,501],\"customID\":\"w_wakaba_0015\"}",
	"501": "{\"pos\":[-3,-21],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[500,503],\"customID\":\"w_wakaba_0014\"}",
	"503": "{\"pos\":[-4,-21],\"type\":5044,\"size\":\"Med\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.2% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.2},\"adjacent\":[501,504],\"customID\":\"w_global_0005\"}",
	"504": "{\"pos\":[-5,-21],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[503,505],\"customID\":\"w_wakaba_0014\"}",
	"505": "{\"pos\":[-6,-22],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[504,506],\"customID\":\"w_wakaba_0014\"}",
	"506": "{\"pos\":[-6,-23],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[505,507],\"customID\":\"w_global_0004\"}",
	"507": "{\"pos\":[-7,-24],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[506,508],\"customID\":\"w_global_0004\"}",
	"508": "{\"pos\":[-8,-24],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[507,509],\"customID\":\"w_wakaba_0014\"}",
	"509": "{\"pos\":[-9,-25],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[508,511],\"customID\":\"w_wakaba_0014\"}",
	"511": "{\"pos\":[-9,-26],\"type\":5014,\"size\":\"Med\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":1},\"adjacent\":[509,512],\"customID\":\"w_wakaba_0015\"}",
	"512": "{\"pos\":[-9,-27],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[511,513],\"customID\":\"w_wakaba_0014\"}",
	"513": "{\"pos\":[-8,-28],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[512,514],\"customID\":\"w_wakaba_0014\"}",
	"514": "{\"pos\":[-7,-28],\"type\":5044,\"size\":\"Med\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.2% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.2},\"adjacent\":[513,515],\"customID\":\"w_global_0005\"}",
	"515": "{\"pos\":[-6,-28],\"type\":5045,\"size\":\"Large\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.5% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.5},\"adjacent\":[514,516],\"customID\":\"w_global_0006\"}",
	"516": "{\"pos\":[-5,-28],\"type\":5044,\"size\":\"Med\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.2% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.2},\"adjacent\":[515,517],\"customID\":\"w_global_0005\"}",
	"517": "{\"pos\":[-4,-28],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[516,518],\"customID\":\"w_wakaba_0014\"}",
	"518": "{\"pos\":[-3,-27],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[517,519],\"customID\":\"w_wakaba_0014\"}",
	"519": "{\"pos\":[-3,-26],\"type\":5014,\"size\":\"Med\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":1},\"adjacent\":[518,520],\"customID\":\"w_wakaba_0015\"}",
	"520": "{\"pos\":[-3,-25],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[519,521],\"customID\":\"w_wakaba_0014\"}",
	"521": "{\"pos\":[-4,-24],\"type\":5015,\"size\":\"Large\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"5% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":5},\"adjacent\":[520,522],\"customID\":\"w_wakaba_0016\"}",
	"522": "{\"pos\":[-5,-25],\"type\":5013,\"size\":\"Small\",\"name\":\"[Wakaba] Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[521,619],\"customID\":\"w_wakaba_0014\"}",
	"524": "{\"pos\":[3,-24],\"type\":5033,\"size\":\"Large\",\"name\":\"The Wild Card\",\"description\":[\"Spawns a Wild Card at the start of a floor.\"],\"modifiers\":{\"wakabaWildCard\":true},\"adjacent\":[618],\"customID\":\"w_wakaba_1004\"}",
	"525": "{\"pos\":[-2,-10],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[368,526]}",
	"526": "{\"pos\":[-3,-10],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[525,527]}",
	"527": "{\"pos\":[-4,-10],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[526,528]}",
	"528": "{\"pos\":[-5,-10],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[527,529]}",
	"529": "{\"pos\":[-6,-10],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[528,530]}",
	"530": "{\"pos\":[-7,-9],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[529,531]}",
	"531": "{\"pos\":[-8,-9],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[530,532]}",
	"532": "{\"pos\":[-9,-8],\"type\":8,\"size\":\"Med\",\"name\":\"Respec Chance\",\"description\":[\"+30% chance to gain a respec point\",\"when completing a floor.\"],\"modifiers\":{\"respecChance\":30},\"adjacent\":[531,539,545]}",
	"539": "{\"pos\":[-10,-8],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[532,540]}",
	"540": "{\"pos\":[-11,-8],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[539,541]}",
	"541": "{\"pos\":[-12,-7],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[540,542]}",
	"542": "{\"pos\":[-12,-6],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[541,543]}",
	"543": "{\"pos\":[-11,-5],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[542,544]}",
	"544": "{\"pos\":[-11,-4],\"type\":30,\"size\":\"Med\",\"name\":\"Damage\",\"description\":[\"+0.05 damage\"],\"modifiers\":{\"damage\":0.05},\"adjacent\":[543,582,551]}",
	"545": "{\"pos\":[-8,-7],\"type\":21,\"size\":\"Small\",\"name\":\"Shot Speed\",\"description\":[\"+0.01 shot speed\"],\"modifiers\":{\"shotSpeed\":0.01},\"adjacent\":[532,546]}",
	"546": "{\"pos\":[-8,-6],\"type\":21,\"size\":\"Small\",\"name\":\"Shot Speed\",\"description\":[\"+0.01 shot speed\"],\"modifiers\":{\"shotSpeed\":0.01},\"adjacent\":[545,547]}",
	"547": "{\"pos\":[-7,-5],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[546,548]}",
	"548": "{\"pos\":[-7,-4],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[547,549]}",
	"549": "{\"pos\":[-8,-3],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[548,550]}",
	"550": "{\"pos\":[-9,-3],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[549,551]}",
	"551": "{\"pos\":[-10,-4],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[550,544]}",
	"558": "{\"pos\":[2,-10],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[368,559]}",
	"559": "{\"pos\":[3,-10],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[558,560]}",
	"560": "{\"pos\":[4,-10],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[559,561]}",
	"561": "{\"pos\":[5,-10],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[560,562]}",
	"562": "{\"pos\":[6,-10],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[561,563]}",
	"563": "{\"pos\":[7,-9],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[562,564]}",
	"564": "{\"pos\":[8,-9],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[563,566]}",
	"565": "{\"pos\":[8,-6],\"type\":8,\"size\":\"Med\",\"name\":\"Respec Chance\",\"description\":[\"+30% chance to gain a respec point\",\"when completing a floor.\"],\"modifiers\":{\"respecChance\":30},\"adjacent\":[655,567,656]}",
	"566": "{\"pos\":[9,-8],\"type\":41,\"size\":\"Med\",\"name\":\"Good Deeds\",\"description\":[\"Helping any type of beggar grants +0.02 luck\"],\"modifiers\":{\"beggarLuck\":0.02},\"adjacent\":[564,583,655]}",
	"567": "{\"pos\":[7,-5],\"type\":332,\"size\":\"Small\",\"name\":\"Boss Challenge Room Unlock\",\"description\":[\"When entering a floor, +7% chance to unlock its boss challenge room regardless of hearts,\",\"if it's present.\"],\"modifiers\":{\"bossChallengeUnlock\":7},\"adjacent\":[565,568]}",
	"568": "{\"pos\":[6,-4],\"type\":332,\"size\":\"Small\",\"name\":\"Boss Challenge Room Unlock\",\"description\":[\"When entering a floor, +7% chance to unlock its boss challenge room regardless of hearts,\",\"if it's present.\"],\"modifiers\":{\"bossChallengeUnlock\":7},\"adjacent\":[567,569]}",
	"569": "{\"pos\":[6,-3],\"type\":332,\"size\":\"Small\",\"name\":\"Boss Challenge Room Unlock\",\"description\":[\"When entering a floor, +7% chance to unlock its boss challenge room regardless of hearts,\",\"if it's present.\"],\"modifiers\":{\"bossChallengeUnlock\":7},\"adjacent\":[568,570]}",
	"570": "{\"pos\":[7,-3],\"type\":332,\"size\":\"Small\",\"name\":\"Boss Challenge Room Unlock\",\"description\":[\"When entering a floor, +7% chance to unlock its boss challenge room regardless of hearts,\",\"if it's present.\"],\"modifiers\":{\"bossChallengeUnlock\":7},\"adjacent\":[569,571]}",
	"571": "{\"pos\":[7,-2],\"type\":333,\"size\":\"Med\",\"name\":\"Boss Challenge Room Unlock\",\"description\":[\"When entering a floor, +20% chance to unlock its boss challenge room regardless of hearts,\",\"if it's present.\"],\"modifiers\":{\"bossChallengeUnlock\":20},\"adjacent\":[570]}",
	"582": "{\"pos\":[-10,-5],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[544],\"customID\":\"w_wakaba_0013\"}",
	"583": "{\"pos\":[10,-7],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[566],\"customID\":\"w_wakaba_0013\"}",
	"584": "{\"pos\":[15,-21],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[633,698],\"customID\":\"w_wakaba_0013\"}",
	"585": "{\"pos\":[-15,-22],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[603,699],\"customID\":\"w_wakaba_0013\"}",
	"586": "{\"pos\":[-15,-11],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[639],\"customID\":\"w_wakaba_0013\"}",
	"587": "{\"pos\":[-13,-16],\"type\":5035,\"size\":\"Large\",\"name\":\"Cloverfest\",\"description\":[\"Clover chest can be appeared regardless of unlock.\",\"If already unlocked, Clover chest can be opened without using keys.\"],\"modifiers\":{\"wakabaFreeClover\":true},\"adjacent\":[654,635,598],\"customID\":\"w_wakaba_1006\"}",
	"588": "{\"pos\":[11,-14],\"type\":5031,\"size\":\"Large\",\"name\":\"Wakaba-chan is no longer baka\",\"description\":[\"Perfection appears 1 floor earlier at the beginning\",\"If Good Girl is allocated as Wakaba, +3 minimum luck for Wakaba's Pendant instead\"],\"modifiers\":{\"wakabaIsSmart\":true},\"adjacent\":[612,622,613],\"customID\":\"w_wakaba_1002\"}",
	"595": "{\"pos\":[14,-18],\"type\":336,\"size\":\"Small\",\"name\":\"Shop Saving\",\"description\":[\"When first entering a shop, +4% chance to reduce a random item's price\",\"by 2-4 coins.\"],\"modifiers\":{\"shopSaving\":4},\"adjacent\":[617,596]}",
	"596": "{\"pos\":[14,-19],\"type\":336,\"size\":\"Small\",\"name\":\"Shop Saving\",\"description\":[\"When first entering a shop, +4% chance to reduce a random item's price\",\"by 2-4 coins.\"],\"modifiers\":{\"shopSaving\":4},\"adjacent\":[595,597]}",
	"597": "{\"pos\":[14,-20],\"type\":336,\"size\":\"Small\",\"name\":\"Shop Saving\",\"description\":[\"When first entering a shop, +4% chance to reduce a random item's price\",\"by 2-4 coins.\"],\"modifiers\":{\"shopSaving\":4},\"adjacent\":[596]}",
	"598": "{\"pos\":[-13,-17],\"type\":5040,\"size\":\"Small\",\"name\":\"Clover Chest Chance\",\"description\":[\"0.2% chance to spawn Clover chest\"],\"modifiers\":{\"cloverChestChance\":0.2},\"adjacent\":[587,599],\"customID\":\"w_global_0001\"}",
	"599": "{\"pos\":[-14,-18],\"type\":5041,\"size\":\"Med\",\"name\":\"Clover Chest Chance\",\"description\":[\"0.5% chance to spawn Clover chest\"],\"modifiers\":{\"cloverChestChance\":0.5},\"adjacent\":[598,600],\"customID\":\"w_global_0002\"}",
	"600": "{\"pos\":[-15,-18],\"type\":5040,\"size\":\"Small\",\"name\":\"Clover Chest Chance\",\"description\":[\"0.2% chance to spawn Clover chest\"],\"modifiers\":{\"cloverChestChance\":0.2},\"adjacent\":[599,276,601],\"customID\":\"w_global_0001\"}",
	"601": "{\"pos\":[-15,-19],\"type\":5040,\"size\":\"Small\",\"name\":\"Clover Chest Chance\",\"description\":[\"0.2% chance to spawn Clover chest\"],\"modifiers\":{\"cloverChestChance\":0.2},\"adjacent\":[600,278,602],\"customID\":\"w_global_0001\"}",
	"602": "{\"pos\":[-15,-20],\"type\":5040,\"size\":\"Small\",\"name\":\"Clover Chest Chance\",\"description\":[\"0.2% chance to spawn Clover chest\"],\"modifiers\":{\"cloverChestChance\":0.2},\"adjacent\":[601,280,603],\"customID\":\"w_global_0001\"}",
	"603": "{\"pos\":[-15,-21],\"type\":5040,\"size\":\"Small\",\"name\":\"Clover Chest Chance\",\"description\":[\"0.2% chance to spawn Clover chest\"],\"modifiers\":{\"cloverChestChance\":0.2},\"adjacent\":[602,282,585],\"customID\":\"w_global_0001\"}",
	"604": "{\"pos\":[2,-12],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[368,605]}",
	"605": "{\"pos\":[3,-13],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[604,606]}",
	"606": "{\"pos\":[4,-14],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[605,607]}",
	"607": "{\"pos\":[5,-14],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[606,608]}",
	"608": "{\"pos\":[6,-14],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[607,609]}",
	"609": "{\"pos\":[7,-14],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[608,610]}",
	"610": "{\"pos\":[8,-13],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[609,611]}",
	"611": "{\"pos\":[9,-13],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[610,612]}",
	"612": "{\"pos\":[10,-13],\"type\":36,\"size\":\"Med\",\"name\":\"Coin Dupe Chance\",\"description\":[\"+1% chance for coin pickups to grant an additional coin\"],\"modifiers\":{\"coinDupe\":1},\"adjacent\":[611,588]}",
	"613": "{\"pos\":[12,-15],\"type\":35,\"size\":\"Small\",\"name\":\"Coin Dupe Chance\",\"description\":[\"+0.5% chance for coin pickups to grant an additional coin\"],\"modifiers\":{\"coinDupe\":0.5},\"adjacent\":[588,615,614]}",
	"614": "{\"pos\":[12,-16],\"type\":36,\"size\":\"Med\",\"name\":\"Coin Dupe Chance\",\"description\":[\"+1% chance for coin pickups to grant an additional coin\"],\"modifiers\":{\"coinDupe\":1},\"adjacent\":[613]}",
	"615": "{\"pos\":[13,-15],\"type\":35,\"size\":\"Small\",\"name\":\"Coin Dupe Chance\",\"description\":[\"+0.5% chance for coin pickups to grant an additional coin\"],\"modifiers\":{\"coinDupe\":0.5},\"adjacent\":[613,616]}",
	"616": "{\"pos\":[13,-17],\"type\":35,\"size\":\"Small\",\"name\":\"Coin Dupe Chance\",\"description\":[\"+0.5% chance for coin pickups to grant an additional coin\"],\"modifiers\":{\"coinDupe\":0.5},\"adjacent\":[615,617]}",
	"617": "{\"pos\":[14,-17],\"type\":36,\"size\":\"Med\",\"name\":\"Coin Dupe Chance\",\"description\":[\"+1% chance for coin pickups to grant an additional coin\"],\"modifiers\":{\"coinDupe\":1},\"adjacent\":[616,595,631]}",
	"618": "{\"pos\":[3,-23],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[524,675],\"customID\":\"w_wakaba_0013\"}",
	"619": "{\"pos\":[-6,-26],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[522,493],\"customID\":\"w_wakaba_0013\"}",
	"620": "{\"pos\":[-3,-35],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[417,492],\"customID\":\"w_wakaba_0013\"}",
	"621": "{\"pos\":[6,-32],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[116,491],\"customID\":\"w_wakaba_0013\"}",
	"622": "{\"pos\":[12,-13],\"type\":317,\"size\":\"Small\",\"name\":\"Less Shot Speed\",\"description\":[\"-0.02 shot speed\"],\"modifiers\":{\"shotSpeed\":-0.02},\"adjacent\":[588,623,630]}",
	"623": "{\"pos\":[13,-12],\"type\":317,\"size\":\"Small\",\"name\":\"Less Shot Speed\",\"description\":[\"-0.02 shot speed\"],\"modifiers\":{\"shotSpeed\":-0.02},\"adjacent\":[622,624,627,629]}",
	"624": "{\"pos\":[14,-11],\"type\":317,\"size\":\"Small\",\"name\":\"Less Shot Speed\",\"description\":[\"-0.02 shot speed\"],\"modifiers\":{\"shotSpeed\":-0.02},\"adjacent\":[623,625]}",
	"625": "{\"pos\":[13,-10],\"type\":317,\"size\":\"Small\",\"name\":\"Less Shot Speed\",\"description\":[\"-0.02 shot speed\"],\"modifiers\":{\"shotSpeed\":-0.02},\"adjacent\":[624,626]}",
	"626": "{\"pos\":[12,-9],\"type\":317,\"size\":\"Small\",\"name\":\"Less Shot Speed\",\"description\":[\"-0.02 shot speed\"],\"modifiers\":{\"shotSpeed\":-0.02},\"adjacent\":[625]}",
	"627": "{\"pos\":[13,-11],\"type\":317,\"size\":\"Small\",\"name\":\"Less Shot Speed\",\"description\":[\"-0.02 shot speed\"],\"modifiers\":{\"shotSpeed\":-0.02},\"adjacent\":[623,628]}",
	"628": "{\"pos\":[12,-10],\"type\":317,\"size\":\"Small\",\"name\":\"Less Shot Speed\",\"description\":[\"-0.02 shot speed\"],\"modifiers\":{\"shotSpeed\":-0.02},\"adjacent\":[627]}",
	"629": "{\"pos\":[12,-11],\"type\":317,\"size\":\"Small\",\"name\":\"Less Shot Speed\",\"description\":[\"-0.02 shot speed\"],\"modifiers\":{\"shotSpeed\":-0.02},\"adjacent\":[623]}",
	"630": "{\"pos\":[12,-12],\"type\":317,\"size\":\"Small\",\"name\":\"Less Shot Speed\",\"description\":[\"-0.02 shot speed\"],\"modifiers\":{\"shotSpeed\":-0.02},\"adjacent\":[622]}",
	"631": "{\"pos\":[15,-17],\"type\":300,\"size\":\"Small\",\"name\":\"Card Floor Luck\",\"description\":[\"1% increased luck for the current floor when you use a card.\"],\"modifiers\":{\"cardFloorLuck\":1},\"adjacent\":[617,632]}",
	"632": "{\"pos\":[15,-18],\"type\":301,\"size\":\"Small\",\"name\":\"Pill Floor Luck\",\"description\":[\"1% increased luck for the current floor when you consume a pill\"],\"modifiers\":{\"pillFloorLuck\":1},\"adjacent\":[631,634]}",
	"633": "{\"pos\":[15,-20],\"type\":301,\"size\":\"Small\",\"name\":\"Pill Floor Luck\",\"description\":[\"1% increased luck for the current floor when you consume a pill\"],\"modifiers\":{\"pillFloorLuck\":1},\"adjacent\":[634,584]}",
	"634": "{\"pos\":[15,-19],\"type\":300,\"size\":\"Small\",\"name\":\"Card Floor Luck\",\"description\":[\"1% increased luck for the current floor when you use a card.\"],\"modifiers\":{\"cardFloorLuck\":1},\"adjacent\":[632,633]}",
	"635": "{\"pos\":[-14,-16],\"type\":5016,\"size\":\"Small\",\"name\":\"[Wakaba] Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[587,636],\"customID\":\"w_wakaba_0017\"}",
	"636": "{\"pos\":[-15,-15],\"type\":5016,\"size\":\"Small\",\"name\":\"[Wakaba] Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[635,637,640],\"customID\":\"w_wakaba_0017\"}",
	"637": "{\"pos\":[-15,-14],\"type\":5016,\"size\":\"Small\",\"name\":\"[Wakaba] Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[636,638,642],\"customID\":\"w_wakaba_0017\"}",
	"638": "{\"pos\":[-15,-13],\"type\":5016,\"size\":\"Small\",\"name\":\"[Wakaba] Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[637,639],\"customID\":\"w_wakaba_0017\"}",
	"639": "{\"pos\":[-15,-12],\"type\":5016,\"size\":\"Small\",\"name\":\"[Wakaba] Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[638,586],\"customID\":\"w_wakaba_0017\"}",
	"640": "{\"pos\":[-16,-14],\"type\":5020,\"size\":\"Small\",\"name\":\"Clover Chest Range\",\"description\":[\"+0.2 range when opening Clover Chest. Resets every floor.\"],\"modifiers\":{\"wakabaCloverChestRange\":0.2},\"adjacent\":[636,641],\"customID\":\"w_wakaba_0021\"}",
	"641": "{\"pos\":[-17,-13],\"type\":5021,\"size\":\"Med\",\"name\":\"Clover Chest Range\",\"description\":[\"+0.5 range when opening Clover Chest. Resets every floor.\"],\"modifiers\":{\"wakabaCloverChestRange\":0.5},\"adjacent\":[640],\"customID\":\"w_wakaba_0022\"}",
	"642": "{\"pos\":[-16,-13],\"type\":5020,\"size\":\"Small\",\"name\":\"Clover Chest Range\",\"description\":[\"+0.2 range when opening Clover Chest. Resets every floor.\"],\"modifiers\":{\"wakabaCloverChestRange\":0.2},\"adjacent\":[637,643],\"customID\":\"w_wakaba_0021\"}",
	"643": "{\"pos\":[-16,-12],\"type\":5021,\"size\":\"Med\",\"name\":\"Clover Chest Range\",\"description\":[\"+0.5 range when opening Clover Chest. Resets every floor.\"],\"modifiers\":{\"wakabaCloverChestRange\":0.5},\"adjacent\":[642],\"customID\":\"w_wakaba_0022\"}",
	"644": "{\"pos\":[-2,-12],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[368,645]}",
	"645": "{\"pos\":[-3,-13],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[644,646]}",
	"646": "{\"pos\":[-4,-14],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[645,647]}",
	"647": "{\"pos\":[-5,-14],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[646,648]}",
	"648": "{\"pos\":[-6,-14],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[647,649]}",
	"649": "{\"pos\":[-7,-14],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[648,650]}",
	"650": "{\"pos\":[-8,-13],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[649,651]}",
	"651": "{\"pos\":[-9,-13],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[650,652]}",
	"652": "{\"pos\":[-10,-13],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[651,653]}",
	"653": "{\"pos\":[-11,-14],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[652,654]}",
	"654": "{\"pos\":[-12,-15],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[653,587]}",
	"655": "{\"pos\":[8,-7],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[566,565],\"customID\":\"w_wakaba_0011\"}",
	"656": "{\"pos\":[9,-5],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[565,657],\"customID\":\"w_wakaba_0011\"}",
	"657": "{\"pos\":[10,-4],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[656,658],\"customID\":\"w_wakaba_0011\"}",
	"658": "{\"pos\":[11,-4],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[657,659,660],\"customID\":\"w_wakaba_0011\"}",
	"659": "{\"pos\":[12,-3],\"type\":5011,\"size\":\"Med\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.04% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.04},\"adjacent\":[658],\"customID\":\"w_wakaba_0012\"}",
	"660": "{\"pos\":[13,-4],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[658,661],\"customID\":\"w_wakaba_0011\"}",
	"661": "{\"pos\":[14,-5],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[660,662],\"customID\":\"w_wakaba_0011\"}",
	"662": "{\"pos\":[15,-5],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[661,663],\"customID\":\"w_wakaba_0011\"}",
	"663": "{\"pos\":[16,-6],\"type\":5011,\"size\":\"Med\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.04% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.04},\"adjacent\":[662,664,697],\"customID\":\"w_wakaba_0012\"}",
	"664": "{\"pos\":[16,-7],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[663],\"customID\":\"w_wakaba_0013\"}",
	"665": "{\"pos\":[0,-12],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[368,666],\"customID\":\"w_wakaba_0011\"}",
	"666": "{\"pos\":[0,-14],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[665,667],\"customID\":\"w_wakaba_0011\"}",
	"667": "{\"pos\":[0,-16],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[666,668],\"customID\":\"w_wakaba_0011\"}",
	"668": "{\"pos\":[0,-18],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[667,669],\"customID\":\"w_wakaba_0011\"}",
	"669": "{\"pos\":[0,-20],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[668,670],\"customID\":\"w_wakaba_0011\"}",
	"670": "{\"pos\":[0,-22],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[669,671],\"customID\":\"w_wakaba_0011\"}",
	"671": "{\"pos\":[0,-24],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[670,672],\"customID\":\"w_wakaba_0011\"}",
	"672": "{\"pos\":[0,-26],\"type\":5010,\"size\":\"Small\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[671,673],\"customID\":\"w_wakaba_0011\"}",
	"673": "{\"pos\":[0,-27],\"type\":5011,\"size\":\"Med\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.04% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.04},\"adjacent\":[672,674],\"customID\":\"w_wakaba_0012\"}",
	"674": "{\"pos\":[0,-29],\"type\":5012,\"size\":\"Large\",\"name\":\"[Wakaba] Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[673,387,425,453,494],\"customID\":\"w_wakaba_0013\"}",
	"675": "{\"pos\":[4,-24],\"type\":5007,\"size\":\"Med\",\"name\":\"[Wakaba] Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"wakabaLuckyPennyChance\":0.5},\"adjacent\":[487,618],\"customID\":\"w_wakaba_0008\"}",
	"676": "{\"pos\":[1,-35],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[429,688],\"customID\":\"w_wakaba_0004\"}",
	"678": "{\"pos\":[3,-37],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[688,689],\"customID\":\"w_wakaba_0004\"}",
	"679": "{\"pos\":[5,-37],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[689,680],\"customID\":\"w_wakaba_0004\"}",
	"680": "{\"pos\":[6,-36],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[679,681],\"customID\":\"w_wakaba_0004\"}",
	"681": "{\"pos\":[6,-35],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[680,682],\"customID\":\"w_wakaba_0004\"}",
	"682": "{\"pos\":[7,-34],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[681,683],\"customID\":\"w_wakaba_0004\"}",
	"683": "{\"pos\":[8,-34],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[682,684],\"customID\":\"w_wakaba_0004\"}",
	"684": "{\"pos\":[9,-33],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[683,690],\"customID\":\"w_wakaba_0004\"}",
	"685": "{\"pos\":[9,-31],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[690,686],\"customID\":\"w_wakaba_0004\"}",
	"686": "{\"pos\":[8,-30],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[685,691],\"customID\":\"w_wakaba_0004\"}",
	"687": "{\"pos\":[4,-30],\"type\":5003,\"size\":\"Small\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[692,112],\"customID\":\"w_wakaba_0004\"}",
	"688": "{\"pos\":[2,-36],\"type\":5004,\"size\":\"Med\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[676,678],\"customID\":\"w_wakaba_0005\"}",
	"689": "{\"pos\":[4,-37],\"type\":5004,\"size\":\"Med\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[678,679],\"customID\":\"w_wakaba_0005\"}",
	"690": "{\"pos\":[9,-32],\"type\":5004,\"size\":\"Med\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[684,685],\"customID\":\"w_wakaba_0005\"}",
	"691": "{\"pos\":[7,-30],\"type\":5004,\"size\":\"Med\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[686,695],\"customID\":\"w_wakaba_0005\"}",
	"692": "{\"pos\":[5,-30],\"type\":5004,\"size\":\"Med\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[695,687],\"customID\":\"w_wakaba_0005\"}",
	"693": "{\"pos\":[3,-32],\"type\":28,\"size\":\"Med\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":1},\"adjacent\":[112,114]}",
	"694": "{\"pos\":[4,-34],\"type\":5005,\"size\":\"Large\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+5% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":5},\"adjacent\":[114,116],\"customID\":\"w_wakaba_0006\"}",
	"695": "{\"pos\":[6,-30],\"type\":5005,\"size\":\"Large\",\"name\":\"[Wakaba] Devil/Angel Rooms\",\"description\":[\"+5% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":5},\"adjacent\":[691,692],\"customID\":\"w_wakaba_0006\"}",
	"697": "{\"pos\":[17,-5],\"type\":5037,\"size\":\"Large\",\"name\":\"[Wakaba] Impure Girl\",\"description\":[\"Begin the game with Birthright as Wakaba\",\"All Boss items are replaced with Devil deals\"],\"modifiers\":{\"wakabaBirthright\":true},\"adjacent\":[663],\"customID\":\"w_wakaba_1008\"}",
	"698": "{\"pos\":[15,-22],\"type\":5036,\"size\":\"Large\",\"name\":\"Extra Uniform Slot\",\"description\":[\"+1 Wakaba's Uniform slot\"],\"modifiers\":{\"wakabaUniformSlot\":1},\"adjacent\":[584],\"customID\":\"w_wakaba_1007\"}",
	"699": "{\"pos\":[-15,-23],\"type\":5036,\"size\":\"Large\",\"name\":\"Extra Uniform Slot\",\"description\":[\"+1 Wakaba's Uniform slot\"],\"modifiers\":{\"wakabaUniformSlot\":1},\"adjacent\":[585],\"customID\":\"w_wakaba_1007\"}"
}
]])
		end

		do -- NODES SHIORI
		PST.SkillTreesAPI.AddCharacterTree("Shiori", false, [[
{
  "1": "{\"pos\":[0,0],\"type\":5055,\"size\":\"Large\",\"name\":\"Tree of Shiori\",\"description\":[\"+0.05 all stats\",\"All nodes from this tree except stats will impact all characters unless specified for Shiori\"],\"modifiers\":{\"allstatsPerc\":0.05},\"adjacent\":[117,2,7,64,66],\"alwaysAvailable\":true,\"customID\":\"w_shiori_0000\"}",
  "2": "{\"pos\":[-1,-1],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[1,3]}",
  "3": "{\"pos\":[-2,-2],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[2,4]}",
  "4": "{\"pos\":[-3,-3],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[3,5,96]}",
  "5": "{\"pos\":[-4,-4],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[4,6]}",
  "6": "{\"pos\":[-5,-5],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[5,12]}",
  "7": "{\"pos\":[1,-1],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[1,8]}",
  "8": "{\"pos\":[2,-2],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[7,9]}",
  "9": "{\"pos\":[3,-3],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[8,10,98]}",
  "10": "{\"pos\":[4,-4],\"type\":0,\"size\":\"Small\",\"name\":\"XP gain\",\"description\":[\"+1% XP gain\"],\"modifiers\":{\"xpgain\":1},\"adjacent\":[9,11]}",
  "11": "{\"pos\":[5,-5],\"type\":1,\"size\":\"Med\",\"name\":\"XP gain\",\"description\":[\"+4% XP gain\"],\"modifiers\":{\"xpgain\":4},\"adjacent\":[10,14]}",
  "12": "{\"pos\":[-5,-6],\"type\":21,\"size\":\"Small\",\"name\":\"Shot Speed\",\"description\":[\"+0.01 shot speed\"],\"modifiers\":{\"shotSpeed\":0.01},\"adjacent\":[6,13]}",
  "13": "{\"pos\":[-5,-7],\"type\":21,\"size\":\"Small\",\"name\":\"Shot Speed\",\"description\":[\"+0.01 shot speed\"],\"modifiers\":{\"shotSpeed\":0.01},\"adjacent\":[12,16]}",
  "14": "{\"pos\":[5,-6],\"type\":21,\"size\":\"Small\",\"name\":\"Shot Speed\",\"description\":[\"+0.01 shot speed\"],\"modifiers\":{\"shotSpeed\":0.01},\"adjacent\":[11,15]}",
  "15": "{\"pos\":[5,-7],\"type\":21,\"size\":\"Small\",\"name\":\"Shot Speed\",\"description\":[\"+0.01 shot speed\"],\"modifiers\":{\"shotSpeed\":0.01},\"adjacent\":[14,18]}",
  "16": "{\"pos\":[-5,-8],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[13,17,51]}",
  "17": "{\"pos\":[-4,-9],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[16,20]}",
  "18": "{\"pos\":[5,-8],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[15,19,53]}",
  "19": "{\"pos\":[4,-9],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[18,23]}",
  "20": "{\"pos\":[-3,-9],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[17,21]}",
  "21": "{\"pos\":[-2,-9],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[20,25]}",
  "23": "{\"pos\":[3,-9],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[19,24]}",
  "24": "{\"pos\":[2,-9],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[23,26]}",
  "25": "{\"pos\":[-1,-9],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[21,27]}",
  "26": "{\"pos\":[1,-9],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[24,27]}",
  "27": "{\"pos\":[0,-9],\"type\":5079,\"size\":\"Large\",\"name\":\"Library Assistant\",\"description\":[\"Unknown Bookmark can be appeared regardless of unlock\",\"If already unlocked, Unknown Bookmark effect is fixed rather than selected from 5 random books\"],\"modifiers\":{\"shioriAssistant\":true},\"adjacent\":[25,26,28],\"customID\":\"w_shiori_1004\"}",
  "28": "{\"pos\":[0,-8],\"type\":5059,\"size\":\"Small\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.02 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.02},\"adjacent\":[27,29],\"customID\":\"w_shiori_0014\"}",
  "29": "{\"pos\":[0,-7],\"type\":5059,\"size\":\"Small\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.02 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.02},\"adjacent\":[28,31,34],\"customID\":\"w_shiori_0014\"}",
  "31": "{\"pos\":[-1,-7],\"type\":5059,\"size\":\"Small\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.02 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.02},\"adjacent\":[29,32],\"customID\":\"w_shiori_0014\"}",
  "32": "{\"pos\":[-2,-7],\"type\":5059,\"size\":\"Small\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.02 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.02},\"adjacent\":[31,33],\"customID\":\"w_shiori_0014\"}",
  "33": "{\"pos\":[-3,-7],\"type\":5060,\"size\":\"Med\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.05 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.05},\"adjacent\":[32,37],\"customID\":\"w_shiori_0015\"}",
  "34": "{\"pos\":[1,-7],\"type\":5059,\"size\":\"Small\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.02 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.02},\"adjacent\":[29,35],\"customID\":\"w_shiori_0014\"}",
  "35": "{\"pos\":[2,-7],\"type\":5059,\"size\":\"Small\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.02 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.02},\"adjacent\":[34,36],\"customID\":\"w_shiori_0014\"}",
  "36": "{\"pos\":[3,-7],\"type\":5060,\"size\":\"Med\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.05 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.05},\"adjacent\":[35,38],\"customID\":\"w_shiori_0015\"}",
  "37": "{\"pos\":[-3,-6],\"type\":5086,\"size\":\"Small\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.01 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.01},\"adjacent\":[33,39],\"customID\":\"w_global_0041\"}",
  "38": "{\"pos\":[3,-6],\"type\":5086,\"size\":\"Small\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.01 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.01},\"adjacent\":[36,40],\"customID\":\"w_global_0041\"}",
  "39": "{\"pos\":[-3,-5],\"type\":5086,\"size\":\"Small\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.01 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.01},\"adjacent\":[37,41],\"customID\":\"w_global_0041\"}",
  "40": "{\"pos\":[3,-5],\"type\":5086,\"size\":\"Small\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.01 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.01},\"adjacent\":[38,42],\"customID\":\"w_global_0041\"}",
  "41": "{\"pos\":[-2,-4],\"type\":5086,\"size\":\"Small\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.01 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.01},\"adjacent\":[39,43],\"customID\":\"w_global_0041\"}",
  "42": "{\"pos\":[2,-4],\"type\":5086,\"size\":\"Small\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.01 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.01},\"adjacent\":[40,44],\"customID\":\"w_global_0041\"}",
  "43": "{\"pos\":[-1,-3],\"type\":5086,\"size\":\"Small\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.01 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.01},\"adjacent\":[41,45],\"customID\":\"w_global_0041\"}",
  "44": "{\"pos\":[1,-3],\"type\":5086,\"size\":\"Small\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.01 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.01},\"adjacent\":[42,45],\"customID\":\"w_global_0041\"}",
  "45": "{\"pos\":[0,-2],\"type\":5087,\"size\":\"Med\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.02 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.02},\"adjacent\":[43,44,46],\"customID\":\"w_global_0042\"}",
  "46": "{\"pos\":[0,-3],\"type\":5059,\"size\":\"Small\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.02 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.02},\"adjacent\":[45,47],\"customID\":\"w_shiori_0014\"}",
  "47": "{\"pos\":[0,-4],\"type\":5059,\"size\":\"Small\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.02 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.02},\"adjacent\":[46,50,48,49],\"customID\":\"w_shiori_0014\"}",
  "48": "{\"pos\":[0,-5],\"type\":5076,\"size\":\"Large\",\"name\":\"[Shiori] Taste of Shiori\",\"description\":[\"+1 Shiori's available book slot\"],\"modifiers\":{\"shioriTaste\":1},\"adjacent\":[47],\"customID\":\"w_shiori_1001\"}",
  "49": "{\"pos\":[1,-5],\"type\":5088,\"size\":\"Large\",\"name\":\"Bookmark Tears\",\"description\":[\"+0.05 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"unknownBookmarkTears\":0.05},\"adjacent\":[47],\"customID\":\"w_global_0043\"}",
  "50": "{\"pos\":[-1,-5],\"type\":5061,\"size\":\"Large\",\"name\":\"[Shiori] Bookmark Tears\",\"description\":[\"+0.1 tears for the current room when you use an Unknown Bookmark.\"],\"modifiers\":{\"shioriUnknownBookmarkTears\":0.1},\"adjacent\":[47],\"customID\":\"w_shiori_0016\"}",
  "51": "{\"pos\":[-6,-7],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[16,52],\"customID\":\"w_shiori_0004\"}",
  "52": "{\"pos\":[-7,-6],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[51,103],\"customID\":\"w_shiori_0004\"}",
  "53": "{\"pos\":[6,-7],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[18,54],\"customID\":\"w_shiori_0004\"}",
  "54": "{\"pos\":[7,-6],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[53,104],\"customID\":\"w_shiori_0004\"}",
  "64": "{\"pos\":[-1,1],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[1,65]}",
  "65": "{\"pos\":[-2,2],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[64,68]}",
  "66": "{\"pos\":[1,1],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[1,67]}",
  "67": "{\"pos\":[2,2],\"type\":20,\"size\":\"Small\",\"name\":\"Range\",\"description\":[\"+0.02 range\"],\"modifiers\":{\"range\":0.02},\"adjacent\":[66,70]}",
  "68": "{\"pos\":[-2,3],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[65,69]}",
  "69": "{\"pos\":[-2,4],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[68,73]}",
  "70": "{\"pos\":[2,3],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[67,71]}",
  "71": "{\"pos\":[2,4],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[70,75]}",
  "73": "{\"pos\":[-2,5],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[69,74]}",
  "74": "{\"pos\":[-2,6],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[73,77]}",
  "75": "{\"pos\":[2,5],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[71,76]}",
  "76": "{\"pos\":[2,6],\"type\":23,\"size\":\"Small\",\"name\":\"Speed\",\"description\":[\"+0.01 speed\"],\"modifiers\":{\"speed\":0.01},\"adjacent\":[75,79]}",
  "77": "{\"pos\":[-2,7],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[74,78]}",
  "78": "{\"pos\":[-2,8],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[77,81]}",
  "79": "{\"pos\":[2,7],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[76,80]}",
  "80": "{\"pos\":[2,8],\"type\":24,\"size\":\"Small\",\"name\":\"Damage\",\"description\":[\"+0.01 damage\"],\"modifiers\":{\"damage\":0.01},\"adjacent\":[79,83]}",
  "81": "{\"pos\":[-2,9],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[78,82]}",
  "82": "{\"pos\":[-2,10],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[81,86]}",
  "83": "{\"pos\":[2,9],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[80,84]}",
  "84": "{\"pos\":[2,10],\"type\":31,\"size\":\"Small\",\"name\":\"Tears\",\"description\":[\"+0.01 tears\"],\"modifiers\":{\"tears\":0.01},\"adjacent\":[83,87]}",
  "86": "{\"pos\":[-2,11],\"type\":5048,\"size\":\"Large\",\"name\":\"[Shiori] Key Collect Range\",\"description\":[\"+0.1 range when collecting a key. Resets every floor.\"],\"modifiers\":{\"shioriKeyRange\":0.1},\"adjacent\":[82,88],\"customID\":\"w_shiori_0003\"}",
  "87": "{\"pos\":[2,11],\"type\":5048,\"size\":\"Large\",\"name\":\"[Shiori] Key Collect Range\",\"description\":[\"+0.1 range when collecting a key. Resets every floor.\"],\"modifiers\":{\"shioriKeyRange\":0.1},\"adjacent\":[84,90],\"customID\":\"w_shiori_0003\"}",
  "88": "{\"pos\":[-3,12],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[86,89],\"customID\":\"w_shiori_0011\"}",
  "89": "{\"pos\":[-3,13],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[88,92],\"customID\":\"w_shiori_0011\"}",
  "90": "{\"pos\":[3,12],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[87,91],\"customID\":\"w_shiori_0011\"}",
  "91": "{\"pos\":[3,13],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[90,94],\"customID\":\"w_shiori_0011\"}",
  "92": "{\"pos\":[-4,14],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[89,93],\"customID\":\"w_shiori_0011\"}",
  "93": "{\"pos\":[-4,15],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[92,220],\"customID\":\"w_shiori_0011\"}",
  "94": "{\"pos\":[4,14],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[91,95],\"customID\":\"w_shiori_0011\"}",
  "95": "{\"pos\":[4,15],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[94,218],\"customID\":\"w_shiori_0011\"}",
  "96": "{\"pos\":[-4,-2],\"type\":33,\"size\":\"Small\",\"name\":\"Mapping Chance\",\"description\":[\"+1% chance for the map to be revealed upon entering a floor\",\"Works from the second floor onwards\"],\"modifiers\":{\"mapChance\":1},\"adjacent\":[4,97]}",
  "97": "{\"pos\":[-5,-1],\"type\":33,\"size\":\"Small\",\"name\":\"Mapping Chance\",\"description\":[\"+1% chance for the map to be revealed upon entering a floor\",\"Works from the second floor onwards\"],\"modifiers\":{\"mapChance\":1},\"adjacent\":[96,100]}",
  "98": "{\"pos\":[4,-2],\"type\":33,\"size\":\"Small\",\"name\":\"Mapping Chance\",\"description\":[\"+1% chance for the map to be revealed upon entering a floor\",\"Works from the second floor onwards\"],\"modifiers\":{\"mapChance\":1},\"adjacent\":[9,99]}",
  "99": "{\"pos\":[5,-1],\"type\":33,\"size\":\"Small\",\"name\":\"Mapping Chance\",\"description\":[\"+1% chance for the map to be revealed upon entering a floor\",\"Works from the second floor onwards\"],\"modifiers\":{\"mapChance\":1},\"adjacent\":[98,101]}",
  "100": "{\"pos\":[-6,0],\"type\":5068,\"size\":\"Large\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.25 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.25},\"adjacent\":[97,222,161],\"customID\":\"w_shiori_0023\"}",
  "101": "{\"pos\":[6,0],\"type\":5068,\"size\":\"Large\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.25 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.25},\"adjacent\":[99,223,139],\"customID\":\"w_shiori_0023\"}",
  "103": "{\"pos\":[-7,-5],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[52,105],\"customID\":\"w_shiori_0004\"}",
  "104": "{\"pos\":[7,-5],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[54,107],\"customID\":\"w_shiori_0004\"}",
  "105": "{\"pos\":[-8,-4],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[103,106],\"customID\":\"w_shiori_0004\"}",
  "106": "{\"pos\":[-8,-3],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[105,109],\"customID\":\"w_shiori_0004\"}",
  "107": "{\"pos\":[8,-4],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[104,108],\"customID\":\"w_shiori_0004\"}",
  "108": "{\"pos\":[8,-3],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[107,110],\"customID\":\"w_shiori_0004\"}",
  "109": "{\"pos\":[-9,-2],\"type\":5058,\"size\":\"Large\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.1 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.1},\"adjacent\":[106,225,213,170],\"customID\":\"w_shiori_0013\"}",
  "110": "{\"pos\":[9,-2],\"type\":5058,\"size\":\"Large\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.1 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.1},\"adjacent\":[108,224,215,149],\"customID\":\"w_shiori_0013\"}",
  "111": "{\"pos\":[-6,10],\"type\":5081,\"size\":\"Large\",\"name\":\"[Shiori] Purifier\",\"description\":[\"Purifier is allocated and be is always available for Shiori.\",\"Purifier dissolve pedestal into keys.\",\"Curse of Satyr reduces number of keys.\"],\"modifiers\":{\"shioriPurify\":true},\"adjacent\":[169,197],\"customID\":\"w_shiori_1006\"}",
  "112": "{\"pos\":[6,10],\"type\":5078,\"size\":\"Large\",\"name\":\"[Shiori] Regulation\",\"description\":[\"All battery pickups are replaced to Golden keys\"],\"modifiers\":{\"shioriGoldenKey\":true},\"adjacent\":[148,195],\"customID\":\"w_shiori_1003\"}",
  "113": "{\"pos\":[-9,8],\"type\":5077,\"size\":\"Large\",\"name\":\"[Shiori] Knowledge is Power\",\"description\":[\"+5% damage up per enteing special rooms\",\"Resets every floor\"],\"modifiers\":{\"shioriKnowledge\":true},\"adjacent\":[178,182],\"customID\":\"w_shiori_1002\"}",
  "114": "{\"pos\":[9,8],\"type\":5082,\"size\":\"Large\",\"name\":\"[Shiori] Goddess\",\"description\":[\"Starts with Godhead.\",\"-75% Damage\"],\"modifiers\":{\"shioriGod\":true},\"adjacent\":[160,186],\"customID\":\"w_shiori_1007\"}",
  "115": "{\"pos\":[-6,18],\"type\":5076,\"size\":\"Large\",\"name\":\"[Shiori] Taste of Shiori\",\"description\":[\"+1 Shiori's available book slot\"],\"modifiers\":{\"shioriTaste\":1},\"adjacent\":[200,221],\"customID\":\"w_shiori_1001\"}",
  "116": "{\"pos\":[6,18],\"type\":5076,\"size\":\"Large\",\"name\":\"[Shiori] Taste of Shiori\",\"description\":[\"+1 Shiori's available book slot\"],\"modifiers\":{\"shioriTaste\":1},\"adjacent\":[202,219],\"customID\":\"w_shiori_1001\"}",
  "117": "{\"pos\":[0,1],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[1,118]}",
  "118": "{\"pos\":[0,2],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[117,119]}",
  "119": "{\"pos\":[0,3],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[118,120]}",
  "120": "{\"pos\":[0,4],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[119,122]}",
  "122": "{\"pos\":[0,5],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[120,123]}",
  "123": "{\"pos\":[0,6],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[122,124]}",
  "124": "{\"pos\":[0,7],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[123,125]}",
  "125": "{\"pos\":[0,8],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[124,126]}",
  "126": "{\"pos\":[0,9],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[125,127]}",
  "127": "{\"pos\":[0,10],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[126,128]}",
  "128": "{\"pos\":[0,11],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[127,129]}",
  "129": "{\"pos\":[0,12],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[128,130]}",
  "130": "{\"pos\":[0,13],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[129,131]}",
  "131": "{\"pos\":[0,14],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[130,132]}",
  "132": "{\"pos\":[0,15],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[131,133]}",
  "133": "{\"pos\":[0,16],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[132,134]}",
  "134": "{\"pos\":[0,17],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[133,135]}",
  "135": "{\"pos\":[0,18],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[134,136]}",
  "136": "{\"pos\":[0,19],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[135,137]}",
  "137": "{\"pos\":[0,20],\"type\":44,\"size\":\"Small\",\"name\":\"Luck Down\",\"description\":[\"-0.03 luck\"],\"modifiers\":{\"luck\":-0.03},\"adjacent\":[136,138]}",
  "138": "{\"pos\":[0,21],\"type\":5080,\"size\":\"Large\",\"name\":\"[Shiori] Curse of Satyr\",\"description\":[\"Books from Shiori's book pool no longer require keys and can be used anytime.\",\"Using a book randomly shuffles Shiori's book pool.\",\"Using Purifier does not trigger shuffle.\"],\"modifiers\":{\"shioriSatyr\":true},\"adjacent\":[137,217],\"customID\":\"w_shiori_1005\"}",
  "139": "{\"pos\":[6,1],\"type\":5052,\"size\":\"Small\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.1% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.1},\"adjacent\":[101,140],\"customID\":\"w_shiori_0007\"}",
  "140": "{\"pos\":[6,2],\"type\":5052,\"size\":\"Small\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.1% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.1},\"adjacent\":[139,142],\"customID\":\"w_shiori_0007\"}",
  "142": "{\"pos\":[6,3],\"type\":5052,\"size\":\"Small\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.1% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.1},\"adjacent\":[140,143],\"customID\":\"w_shiori_0007\"}",
  "143": "{\"pos\":[6,4],\"type\":5052,\"size\":\"Small\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.1% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.1},\"adjacent\":[142,144],\"customID\":\"w_shiori_0007\"}",
  "144": "{\"pos\":[6,5],\"type\":5053,\"size\":\"Med\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.2% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.2},\"adjacent\":[143,205,145],\"customID\":\"w_shiori_0008\"}",
  "145": "{\"pos\":[6,6],\"type\":5052,\"size\":\"Small\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.1% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.1},\"adjacent\":[144,146],\"customID\":\"w_shiori_0007\"}",
  "146": "{\"pos\":[6,7],\"type\":5052,\"size\":\"Small\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.1% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.1},\"adjacent\":[145,147],\"customID\":\"w_shiori_0007\"}",
  "147": "{\"pos\":[6,8],\"type\":5052,\"size\":\"Small\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.1% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.1},\"adjacent\":[146,148],\"customID\":\"w_shiori_0007\"}",
  "148": "{\"pos\":[6,9],\"type\":5052,\"size\":\"Small\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.1% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.1},\"adjacent\":[147,229,112],\"customID\":\"w_shiori_0007\"}",
  "149": "{\"pos\":[9,-1],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[110,150],\"customID\":\"w_shiori_0011\"}",
  "150": "{\"pos\":[9,0],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[149,152],\"customID\":\"w_shiori_0011\"}",
  "152": "{\"pos\":[9,1],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[150,153],\"customID\":\"w_shiori_0011\"}",
  "153": "{\"pos\":[9,2],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[152,154],\"customID\":\"w_shiori_0011\"}",
  "154": "{\"pos\":[9,3],\"type\":5057,\"size\":\"Med\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.05 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.05},\"adjacent\":[153,209,156],\"customID\":\"w_shiori_0012\"}",
  "156": "{\"pos\":[9,4],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[154,158],\"customID\":\"w_shiori_0011\"}",
  "158": "{\"pos\":[9,5],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[156,159],\"customID\":\"w_shiori_0011\"}",
  "159": "{\"pos\":[9,6],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[158,160],\"customID\":\"w_shiori_0011\"}",
  "160": "{\"pos\":[9,7],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[159,114,227],\"customID\":\"w_shiori_0011\"}",
  "161": "{\"pos\":[-6,1],\"type\":5062,\"size\":\"Small\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.2},\"adjacent\":[100,162],\"customID\":\"w_shiori_0017\"}",
  "162": "{\"pos\":[-6,2],\"type\":5062,\"size\":\"Small\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.2},\"adjacent\":[161,163],\"customID\":\"w_shiori_0017\"}",
  "163": "{\"pos\":[-6,3],\"type\":5062,\"size\":\"Small\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.2},\"adjacent\":[162,164],\"customID\":\"w_shiori_0017\"}",
  "164": "{\"pos\":[-6,4],\"type\":5062,\"size\":\"Small\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.2},\"adjacent\":[163,165],\"customID\":\"w_shiori_0017\"}",
  "165": "{\"pos\":[-6,5],\"type\":5063,\"size\":\"Med\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.4% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.4},\"adjacent\":[164,203,166],\"customID\":\"w_shiori_0018\"}",
  "166": "{\"pos\":[-6,6],\"type\":5062,\"size\":\"Small\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.2},\"adjacent\":[165,167],\"customID\":\"w_shiori_0017\"}",
  "167": "{\"pos\":[-6,7],\"type\":5062,\"size\":\"Small\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.2},\"adjacent\":[166,168],\"customID\":\"w_shiori_0017\"}",
  "168": "{\"pos\":[-6,8],\"type\":5062,\"size\":\"Small\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.2},\"adjacent\":[167,169],\"customID\":\"w_shiori_0017\"}",
  "169": "{\"pos\":[-6,9],\"type\":5062,\"size\":\"Small\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.2},\"adjacent\":[168,228,111],\"customID\":\"w_shiori_0017\"}",
  "170": "{\"pos\":[-9,-1],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[109,171],\"customID\":\"w_shiori_0004\"}",
  "171": "{\"pos\":[-9,0],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[170,172],\"customID\":\"w_shiori_0004\"}",
  "172": "{\"pos\":[-9,1],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[171,173],\"customID\":\"w_shiori_0004\"}",
  "173": "{\"pos\":[-9,2],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[172,174],\"customID\":\"w_shiori_0004\"}",
  "174": "{\"pos\":[-9,3],\"type\":5050,\"size\":\"Med\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.04 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.04},\"adjacent\":[173,211,175],\"customID\":\"w_shiori_0005\"}",
  "175": "{\"pos\":[-9,4],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[174,176],\"customID\":\"w_shiori_0004\"}",
  "176": "{\"pos\":[-9,5],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[175,177],\"customID\":\"w_shiori_0004\"}",
  "177": "{\"pos\":[-9,6],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[176,178],\"customID\":\"w_shiori_0004\"}",
  "178": "{\"pos\":[-9,7],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[177,113,226],\"customID\":\"w_shiori_0004\"}",
  "180": "{\"pos\":[-6,13],\"type\":5051,\"size\":\"Large\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.1 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.1},\"adjacent\":[185,193,198],\"customID\":\"w_shiori_0006\"}",
  "181": "{\"pos\":[6,13],\"type\":5058,\"size\":\"Large\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.1 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.1},\"adjacent\":[189,194,196],\"customID\":\"w_shiori_0013\"}",
  "182": "{\"pos\":[-8,9],\"type\":5066,\"size\":\"Small\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.05 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.05},\"adjacent\":[226,113,183],\"customID\":\"w_shiori_0021\"}",
  "183": "{\"pos\":[-8,10],\"type\":5066,\"size\":\"Small\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.05 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.05},\"adjacent\":[182,184],\"customID\":\"w_shiori_0021\"}",
  "184": "{\"pos\":[-7,11],\"type\":5066,\"size\":\"Small\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.05 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.05},\"adjacent\":[183,185],\"customID\":\"w_shiori_0021\"}",
  "185": "{\"pos\":[-7,12],\"type\":5066,\"size\":\"Small\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.05 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.05},\"adjacent\":[184,180],\"customID\":\"w_shiori_0021\"}",
  "186": "{\"pos\":[8,9],\"type\":5066,\"size\":\"Small\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.05 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.05},\"adjacent\":[114,227,187],\"customID\":\"w_shiori_0021\"}",
  "187": "{\"pos\":[8,10],\"type\":5066,\"size\":\"Small\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.05 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.05},\"adjacent\":[186,188],\"customID\":\"w_shiori_0021\"}",
  "188": "{\"pos\":[7,11],\"type\":5066,\"size\":\"Small\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.05 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.05},\"adjacent\":[187,189],\"customID\":\"w_shiori_0021\"}",
  "189": "{\"pos\":[7,12],\"type\":5066,\"size\":\"Small\",\"name\":\"[Shiori] Library Damage\",\"description\":[\"+0.05 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.05},\"adjacent\":[188,181],\"customID\":\"w_shiori_0021\"}",
  "191": "{\"pos\":[-6,15],\"type\":5064,\"size\":\"Large\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":1},\"adjacent\":[193,199],\"customID\":\"w_shiori_0019\"}",
  "192": "{\"pos\":[6,15],\"type\":5054,\"size\":\"Large\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.5% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.5},\"adjacent\":[194,201],\"customID\":\"w_shiori_0009\"}",
  "193": "{\"pos\":[-6,14],\"type\":5089,\"size\":\"Small\",\"name\":\"Library Damage\",\"description\":[\"+0.04 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.04},\"adjacent\":[180,191],\"customID\":\"w_global_0044\"}",
  "194": "{\"pos\":[6,14],\"type\":5089,\"size\":\"Small\",\"name\":\"Library Damage\",\"description\":[\"+0.04 damage when entering Library.\"],\"modifiers\":{\"shioriLibraryDamage\":0.04},\"adjacent\":[181,192],\"customID\":\"w_global_0044\"}",
  "195": "{\"pos\":[6,11],\"type\":37,\"size\":\"Small\",\"name\":\"Key Dupe Chance\",\"description\":[\"+0.25% chance for key pickups to grant an additional key\"],\"modifiers\":{\"keyDupe\":0.25},\"adjacent\":[229,112,196]}",
  "196": "{\"pos\":[6,12],\"type\":37,\"size\":\"Small\",\"name\":\"Key Dupe Chance\",\"description\":[\"+0.25% chance for key pickups to grant an additional key\"],\"modifiers\":{\"keyDupe\":0.25},\"adjacent\":[195,181]}",
  "197": "{\"pos\":[-6,11],\"type\":5046,\"size\":\"Small\",\"name\":\"[Shiori] Key Collect Range\",\"description\":[\"+0.01 range when collecting a key. Resets every floor.\"],\"modifiers\":{\"shioriKeyRange\":0.01},\"adjacent\":[228,111,198],\"customID\":\"w_shiori_0001\"}",
  "198": "{\"pos\":[-6,12],\"type\":5046,\"size\":\"Small\",\"name\":\"[Shiori] Key Collect Range\",\"description\":[\"+0.01 range when collecting a key. Resets every floor.\"],\"modifiers\":{\"shioriKeyRange\":0.01},\"adjacent\":[197,180],\"customID\":\"w_shiori_0001\"}",
  "199": "{\"pos\":[-6,16],\"type\":5047,\"size\":\"Med\",\"name\":\"[Shiori] Key Collect Range\",\"description\":[\"+0.04 range when collecting a key. Resets every floor.\"],\"modifiers\":{\"shioriKeyRange\":0.04},\"adjacent\":[191,200],\"customID\":\"w_shiori_0002\"}",
  "200": "{\"pos\":[-6,17],\"type\":5047,\"size\":\"Med\",\"name\":\"[Shiori] Key Collect Range\",\"description\":[\"+0.04 range when collecting a key. Resets every floor.\"],\"modifiers\":{\"shioriKeyRange\":0.04},\"adjacent\":[199,115],\"customID\":\"w_shiori_0002\"}",
  "201": "{\"pos\":[6,16],\"type\":5047,\"size\":\"Med\",\"name\":\"[Shiori] Key Collect Range\",\"description\":[\"+0.04 range when collecting a key. Resets every floor.\"],\"modifiers\":{\"shioriKeyRange\":0.04},\"adjacent\":[192,202],\"customID\":\"w_shiori_0002\"}",
  "202": "{\"pos\":[6,17],\"type\":5047,\"size\":\"Med\",\"name\":\"[Shiori] Key Collect Range\",\"description\":[\"+0.04 range when collecting a key. Resets every floor.\"],\"modifiers\":{\"shioriKeyRange\":0.04},\"adjacent\":[201,116],\"customID\":\"w_shiori_0002\"}",
  "203": "{\"pos\":[-5,6],\"type\":5062,\"size\":\"Small\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+0.2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":0.2},\"adjacent\":[165,204],\"customID\":\"w_shiori_0017\"}",
  "204": "{\"pos\":[-4,7],\"type\":5064,\"size\":\"Large\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":1},\"adjacent\":[203],\"customID\":\"w_shiori_0019\"}",
  "205": "{\"pos\":[5,6],\"type\":5052,\"size\":\"Small\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.1% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.1},\"adjacent\":[144,206],\"customID\":\"w_shiori_0007\"}",
  "206": "{\"pos\":[4,7],\"type\":5054,\"size\":\"Large\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.5% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.5},\"adjacent\":[205],\"customID\":\"w_shiori_0009\"}",
  "209": "{\"pos\":[10,4],\"type\":5056,\"size\":\"Small\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.02 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.02},\"adjacent\":[154,210],\"customID\":\"w_shiori_0011\"}",
  "210": "{\"pos\":[11,5],\"type\":5058,\"size\":\"Large\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.1 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.1},\"adjacent\":[209],\"customID\":\"w_shiori_0013\"}",
  "211": "{\"pos\":[-10,4],\"type\":5049,\"size\":\"Small\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.01 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.01},\"adjacent\":[174,212],\"customID\":\"w_shiori_0004\"}",
  "212": "{\"pos\":[-11,5],\"type\":5051,\"size\":\"Large\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.1 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.1},\"adjacent\":[211],\"customID\":\"w_shiori_0006\"}",
  "213": "{\"pos\":[-10,-1],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[109,214]}",
  "214": "{\"pos\":[-11,0],\"type\":28,\"size\":\"Med\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":1},\"adjacent\":[213]}",
  "215": "{\"pos\":[10,-1],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[110,216]}",
  "216": "{\"pos\":[11,0],\"type\":28,\"size\":\"Med\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":1},\"adjacent\":[215]}",
  "217": "{\"pos\":[0,22],\"type\":5076,\"size\":\"Large\",\"name\":\"[Shiori] Taste of Shiori\",\"description\":[\"+1 Shiori's available book slot\"],\"modifiers\":{\"shioriTaste\":1},\"adjacent\":[138],\"customID\":\"w_shiori_1001\"}",
  "218": "{\"pos\":[5,16],\"type\":5092,\"size\":\"Small\",\"name\":\"Library Reveal\",\"description\":[\"8% chance to reveal the library's location if it's present on a floor.\"],\"modifiers\":{\"libraryReveal\":8},\"adjacent\":[95,219],\"customID\":\"w_global_0047\"}",
  "219": "{\"pos\":[5,17],\"type\":5092,\"size\":\"Small\",\"name\":\"Library Reveal\",\"description\":[\"8% chance to reveal the library's location if it's present on a floor.\"],\"modifiers\":{\"libraryReveal\":8},\"adjacent\":[218,116],\"customID\":\"w_global_0047\"}",
  "220": "{\"pos\":[-5,16],\"type\":5092,\"size\":\"Small\",\"name\":\"Library Reveal\",\"description\":[\"8% chance to reveal the library's location if it's present on a floor.\"],\"modifiers\":{\"libraryReveal\":8},\"adjacent\":[93,221],\"customID\":\"w_global_0047\"}",
  "221": "{\"pos\":[-5,17],\"type\":5092,\"size\":\"Small\",\"name\":\"Library Reveal\",\"description\":[\"8% chance to reveal the library's location if it's present on a floor.\"],\"modifiers\":{\"libraryReveal\":8},\"adjacent\":[220,115],\"customID\":\"w_global_0047\"}",
  "222": "{\"pos\":[-7,-1],\"type\":5092,\"size\":\"Small\",\"name\":\"Library Reveal\",\"description\":[\"8% chance to reveal the library's location if it's present on a floor.\"],\"modifiers\":{\"libraryReveal\":8},\"adjacent\":[100],\"customID\":\"w_global_0047\"}",
  "223": "{\"pos\":[7,-1],\"type\":5092,\"size\":\"Small\",\"name\":\"Library Reveal\",\"description\":[\"8% chance to reveal the library's location if it's present on a floor.\"],\"modifiers\":{\"libraryReveal\":8},\"adjacent\":[101],\"customID\":\"w_global_0047\"}",
  "224": "{\"pos\":[10,-3],\"type\":5092,\"size\":\"Small\",\"name\":\"Library Reveal\",\"description\":[\"8% chance to reveal the library's location if it's present on a floor.\"],\"modifiers\":{\"libraryReveal\":8},\"adjacent\":[110],\"customID\":\"w_global_0047\"}",
  "225": "{\"pos\":[-10,-3],\"type\":5092,\"size\":\"Small\",\"name\":\"Library Reveal\",\"description\":[\"8% chance to reveal the library's location if it's present on a floor.\"],\"modifiers\":{\"libraryReveal\":8},\"adjacent\":[109],\"customID\":\"w_global_0047\"}",
  "226": "{\"pos\":[-8,8],\"type\":5051,\"size\":\"Large\",\"name\":\"[Shiori] Book Effect Luck\",\"description\":[\"+0.1 luck when secondary effect of Book of Shiori changes. Resets every floor.\"],\"modifiers\":{\"shioriSecondaryLuck\":0.1},\"adjacent\":[178,182],\"customID\":\"w_shiori_0006\"}",
  "227": "{\"pos\":[8,8],\"type\":5058,\"size\":\"Large\",\"name\":\"[Shiori] Key Use Damage\",\"description\":[\"+0.1 damage for the current room per key consumed.\"],\"modifiers\":{\"shioriRoomKeyDamage\":0.1},\"adjacent\":[160,186],\"customID\":\"w_shiori_0013\"}",
  "228": "{\"pos\":[-5,10],\"type\":5064,\"size\":\"Large\",\"name\":\"[Shiori] Card Use Damage\",\"description\":[\"+2% damage for the current floor when you use a card, up to a total 15%.\"],\"modifiers\":{\"shioriCardFloorDamage\":1},\"adjacent\":[169,197],\"customID\":\"w_shiori_0019\"}",
  "229": "{\"pos\":[5,10],\"type\":5054,\"size\":\"Large\",\"name\":\"[Shiori] Room Clear Extra Key\",\"description\":[\"+0.5% chance to gain an additional key when clearing a room\"],\"modifiers\":{\"shioriExtraKeyDrop\":0.5},\"adjacent\":[148,195],\"customID\":\"w_shiori_0009\"}"
}
]])
		end

		do -- NODES TSUKASA
		end

		do -- NODES RICHER
		end

		do -- NODES RIRA

		end

		wakaba:RemoveCallback(ModCallbacks.MC_POST_SAVESLOT_LOAD, wakaba.PreLoad_PST)
	end

	do -- CALLBACKS

		wakaba:AddPriorityCallback(ModCallbacks.MC_POST_SAVESLOT_LOAD, CallbackPriority.LATE, wakaba.PreLoad_PST)

		wakaba:AddCallback(wakaba.Callback.MAX_UNIFORM_SLOTS, function(_, player, originalMax)
			return originalMax + wakaba:extraVal("wakabaUniformSlot", 0)
		end)

		wakaba:AddCallback(wakaba.Callback.MAX_SHIORI_SLOTS, function(_, player, originalMax)
			return originalMax + wakaba:extraVal("shioriTaste", 0)
		end)

		wakaba._pstFloorFirst = false
		function wakaba:Update_PST()
			if wakaba._pstFloorFirst then
				wakaba._pstFloorFirst = false

				-- Mod: chance to reveal the library's location if it is present (Shiori's Tree)
				local tmpMod = wakaba:extraVal("libraryReveal", 0)
				local level = wakaba.L
				local rng = RNG(level:GetDungeonPlacementSeed())
				if tmpMod > 0 and 100 * rng:PhantomFloat() < tmpMod then
					local libraryIdx = level:QueryRoomTypeIndex(RoomType.ROOM_LIBRARY, false, RNG())
					local libraryRoom = level:GetRoomByIdx(libraryIdx)
					if libraryRoom and libraryRoom.Data.Type == RoomType.ROOM_LIBRARY then
						libraryRoom.DisplayFlags = 1 << 2
						level:UpdateVisibility()
					end
				end
			end
		end
		wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_PST)

		function wakaba:NewLevel_PST()
			if not pstFirstLevel and wakaba.G:GetFrameCount() == 0 then
				return
			end
			local room = wakaba.G:GetRoom()
			for num = 1, wakaba.G:GetNumPlayers() do
				local player = wakaba.G:GetPlayer(num - 1)
				wakaba:removePlayerDataEntry(player, "CloverChestRange")
				wakaba:removePlayerDataEntry(player, "shioriKeyRange")
				wakaba:removePlayerDataEntry(player, "shioriSecondaryLuck")
				wakaba:removePlayerDataEntry(player, "shioriCardFloorDamage")
				wakaba:removePlayerDataEntry(player, "shioriKnowledgeDamage")
				player:AddCacheFlags(CacheFlag.CACHE_ALL, true)
			end
			if wakaba:extraVal("wakabaWildCard") then
				local pos = room:GetGridPosition(102)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_WILD, room:FindFreePickupSpawnPosition(pos, 40), Vector.Zero, nil)
			end
			wakaba._pstFloorFirst = true
		end
		wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_PST)

		wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function(_)
			local room = wakaba.R
			for num = 1, wakaba.G:GetNumPlayers() do
				local player = wakaba.G:GetPlayer(num - 1)
				if room:IsFirstVisit() then
					if room:GetType() == RoomType.ROOM_LIBRARY then
						local libdmg = wakaba:extraVal("libraryDamage", 0)
						local slibdmg = wakaba:extraVal("shioriLibraryDamage", 0)
						if libdmg + slibdmg ~= 0 then
							wakaba:initPlayerDataEntry(player, "libraryDamage", 0)
							wakaba:addPlayerDataCounter(player, "libraryDamage", libdmg + slibdmg)
						end
					end
					if room:GetType() ~= RoomType.ROOM_DEFAULT then
						if wakaba:extraVal("shioriKnowledge") then
							wakaba:initPlayerDataEntry(player, "shioriKnowledgeDamage", 0)
							wakaba:addPlayerDataCounter(player, "shioriKnowledgeDamage", 5)
						end
					end
				end
				wakaba:removePlayerDataEntry(player, "shioriRoomKeyDamage")
				wakaba:removePlayerDataEntry(player, "unknownBookmarkTears")
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY, true)
			end
		end)

		wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, function(_, pickup, collider, low, forced)
			if pickup:GetSprite():GetAnimation() ~= "Collect" and not forced then return end
			local player = collider:ToPlayer()
			local variant = pickup.Variant
			local subtype = pickup.SubType
			if player ~= nil and (not pickup:IsShopItem() or forced) then
        if variant == PickupVariant.PICKUP_KEY then
					if player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
						local tmpRange = wakaba:extraVal("shioriKeyRange", 0)
						if tmpRange ~= 0 then
							wakaba:initPlayerDataEntry(player, "shioriKeyRange", 0)
							wakaba:addPlayerDataCounter(player, "shioriKeyRange", tmpRange)
							--wakaba:addCustomStat(player, "luck", luckToSub * -1)
							player:AddCacheFlags(CacheFlag.CACHE_RANGE, true)
						end
					end
				end
			end
		end)

		wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function(_)
			pstFirstLevel = false
		end)

		wakaba:AddCallback(wakaba.Callback.POST_CHANGE_SHIORI_EFFECT, function(_, nextFlag, rng, player, useflag, slot, vardata, prevFlag)
			if wakaba:extraVal("shioriSecondaryLuck") and prevFlag ~= nextFlag then
				local tmpLuck = wakaba:extraVal("shioriSecondaryLuck", 0)
				if tmpLuck ~= 0 then
					wakaba:initPlayerDataEntry(player, "shioriSecondaryLuck", 0)
					wakaba:addPlayerDataCounter(player, "shioriSecondaryLuck", tmpLuck)
					--wakaba:addCustomStat(player, "luck", luckToSub * -1)
					player:AddCacheFlags(CacheFlag.CACHE_LUCK, true)
				end
			end
		end)

		wakaba:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, CallbackPriority.LATE, function(_, isContinued)
			if isContinued then
				return
			end
			local treeActive = not PST.modData.treeDisabled and ((not PST.config.treeOnChallenges and Isaac.GetChallenge() == 0) or PST.config.treeOnChallenges)
			if treeActive then
				local treesToCheck = {
					wakaba.Enums.Players.WAKABA,
				}
				for _, char in ipairs(treesToCheck) do
					if char ~= PST.selectedMenuChar then
						local currentChar = PST.charNames[1 + char]
						if currentChar and PST.trees[currentChar] then
							for nodeID, node in pairs(PST.trees[currentChar]) do
								if PST:isNodeAllocated(currentChar, nodeID) then
									local shouldAdd = false
									for name, val in pairs(node.modifiers) do
										if wakaba:has_value(global_nodes, name) then
											shouldAdd = true
										end
									end
									if shouldAdd then
										PST:addModifiers(node.modifiers, true)
									end
								end
							end
						end
					end
				end
			end

			local player = Isaac.GetPlayer()
			local playerTwin = player:GetOtherTwin()
			local itemPool = Game():GetItemPool()
			if wakaba:extraVal("wakabaIsSmart") then
				wakaba.G:AddStageWithoutDamage()
			end

			if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
				if wakaba:extraVal("wakabaBirthright") then
					player:AddCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
				end
				if wakaba:extraVal("wakabaGudGirl") then
					player:AddCollectible(wakaba.Enums.Collectibles.WAKABAS_PENDANT)
					wakaba.G:SetStateFlag(GameStateFlag.STATE_PERFECTION_SPAWNED, true)
				end
			elseif player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
				wakaba:resetShioriBookPool(player, true, wakaba.L:GetDungeonPlacementSeed())
			end
			pstFirstLevel = true
			wakaba:NewLevel_PST()
		end)

		---@param player EntityPlayer
		---@param cacheFlag CacheFlag
		wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function (_, player, cacheFlag)
			if cacheFlag == CacheFlag.CACHE_RANGE then
				local range = 0
				range = range + wakaba:getPlayerDataEntry(player, "CloverChestRange", 0)
				range = range + wakaba:getPlayerDataEntry(player, "shioriKeyRange", 0)
				if range > 0 then
					player.TearRange = player.TearRange + (range * 40)
				end
			end
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				local damage = 0
				damage = damage + wakaba:getPlayerDataEntry(player, "shioriRoomKeyDamage", 0)
				damage = damage + wakaba:getPlayerDataEntry(player, "libraryDamage", 0)
				player.Damage = player.Damage + (damage * wakaba:getEstimatedDamageMult(player))
			end
			if cacheFlag == CacheFlag.CACHE_LUCK then
				if player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
					local luck = 0
					luck = luck + wakaba:getPlayerDataEntry(player, "shioriSecondaryLuck", 0)
					if luck > 0 then
						--player.Luck = player.Luck + luck
					end
				end
			end
		end)
		wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010722, function (_, player, cacheFlag)
			if cacheFlag == CacheFlag.CACHE_SPEED then
				if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
					if wakaba:extraVal("wakabaGudGirl") then
						--player.MoveSpeed = player.MoveSpeed * 0.9
					end
				end
			end
			if cacheFlag == CacheFlag.CACHE_LUCK then
				if player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
					local mult = math.max(wakaba:getPlayerDataEntry(player, "shioriSecondaryLuck", 0), 0)
					player.Luck = player.Luck * (1 + (mult / 100))
				end
			end
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
					local mult = math.max(wakaba:extraVal("wakabaDamageLuck", 0), 0)
					local luck = player.Luck
					player.Damage = player.Damage * (1 + (luck * (mult / 100)))
				end
				do
					local mult = math.min(wakaba:getPlayerDataEntry(player, "shioriCardFloorDamage", 0), 15)
					player.Damage = player.Damage * (1 + (mult / 100))
				end
				do
					local mult = math.max(wakaba:getPlayerDataEntry(player, "shioriKnowledgeDamage", 0), 0)
					player.Damage = player.Damage * (1 + ( mult / 100))
				end
				if player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
					if wakaba:extraVal("shioriGod") then
						player.Damage = player.Damage * 0.25
					end
				end
			end
			if cacheFlag == CacheFlag.CACHE_TEARFLAG then
				if player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
					if wakaba:extraVal("shioriGod") then
						player.TearFlags = player.TearFlags | TearFlags.TEAR_GLOW | TearFlags.TEAR_HOMING
					end
				end
			end
		end)
		wakaba:AddCallback(ModCallbacks.MC_PRE_DEVIL_APPLY_ITEMS, function(_, chance)
			local addChance = 0
			for num = 1, wakaba.G:GetNumPlayers() do
				local player = wakaba.G:GetPlayer(num - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
					addChance = addChance + (wakaba:extraVal("wakabaDevilChance", 0) / 100)
				end
			end
			return chance + addChance
		end)

		wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR, function(_, player)
			if player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
				if wakaba:extraVal("shioriExtraKeyDrop", 0) then
					local extraChance = wakaba:extraVal("shioriExtraKeyDrop", 0) / 100
					local rng = RNG(wakaba.R:GetAwardSeed())
					local result = rng:PhantomFloat()
					if result < extraChance then
						player:AddKeys(1)
					end
				end
			end
		end)

		wakaba:AddCallback(ModCallbacks.MC_USE_CARD, function(_, card, player, useFlag)
			if card == wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK then
				local tears = wakaba:extraVal("unknownBookmarkTears", 0)
				local stears = wakaba:extraVal("shioriUnknownBookmarkTears", 0)
				if tears + stears ~= 0 then
					wakaba:initPlayerDataEntry(player, "unknownBookmarkTears", 0)
					wakaba:addPlayerDataCounter(player, "unknownBookmarkTears", tears + stears)
					--wakaba:addCustomStat(player, "luck", luckToSub * -1)
					player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY, true)
				end
			end
			local damage = wakaba:extraVal("shioriCardFloorDamage", 0)
			if damage ~= 0 then
				wakaba:initPlayerDataEntry(player, "shioriCardFloorDamage", 0)
				wakaba:addPlayerDataCounter(player, "shioriCardFloorDamage", damage)
				--wakaba:addCustomStat(player, "luck", luckToSub * -1)
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE, true)
			end
		end)

		wakaba:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CallbackPriority.LATE, function(_, target, damage, flag, source)
			local player = target:ToPlayer()
			local room = wakaba.G:GetRoom()

			-- Player gets hit
			if player then
				if wakaba:extraVal("wakabaLeafTear") and wakaba:WillDamageBeFatal(player, damage, flag) and not player:HasCollectible(CollectibleType.COLLECTIBLE_ROCK_BOTTOM) then
					if player.Luck > 0 then
						local luckToSub = math.max(20, player.Luck * 0.2)
						wakaba:initPlayerDataEntry(player, "leafTearLuck", 0)
						wakaba:addPlayerDataCounter(player, "leafTearLuck", luckToSub * -1)
						player:AddCacheFlags(CacheFlag.CACHE_LUCK, true)
						SFXManager():Play(SoundEffect.SOUND_HOLY_MANTLE)
						return { Damage = 0 }
					end
				end
			end
		end)
		wakaba:AddCallback(ModCallbacks.MC_POST_ENTITY_TAKE_DMG, function(_, target, damage, flag, source)
			local player = target:ToPlayer() ---@type EntityPlayer
			local room = wakaba.G:GetRoom()

			-- Player gets hit
			if player then

				do -- Take Damage Shield (Wakaba's Tree)
					local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.WAKABAS_BLESSING)
					local shieldChance = wakaba:extraVal("shieldChance", 0) / 100
					if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
						shieldChance = shieldChance + (wakaba:extraVal("wakabaShieldChance", 0) / 100)
					end
					local res = rng:RandomFloat()
					wakaba.FLog("PST", "on-hit shield res:", res, "chance:", shieldChance)
					if res < shieldChance then
						player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
					end
				end
			end
		end)

		wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 3, function(_)
			if wakaba:getOptionValue("hudpst") then -- -1, 0, 1, 2
				wakaba.globalHUDSprite:RemoveOverlay()
				wakaba.globalHUDSprite:SetFrame("PST", 0)
				local room = Game():GetRoom()
				local loc = wakaba:getOptionValue("hud_pst")
				local expType = wakaba:getOptionValue("hudpst")
				local frame = 0
				local charData = PST:getCurrentCharData()
				if charData then
					local name = PST:getCurrentCharName()
					local level = charData.level
					local current = charData.xp + (PST.modData.xpObtained or 0)
					local nextLevel = charData.xpRequired
					local barPercent = math.min(1, current / math.max(1, nextLevel))
					local string = name .. " Lv." .. level
					if expType >= 0 then
						local ind = 10 ^ expType
						--string = string .. " : "..current.."/"..nextLevel.." ("..	(math.ceil(barPercent * ind * 100) / ind)	.."%)"
						string = string .. " : " .. (math.ceil(barPercent * ind * 100) / ind) .."%"
					end

					local tab = {
						Sprite = wakaba.globalHUDSprite,
						Text = string,
						Location = loc,
						SpriteOptions = {
							Anim = "PST",
							Frame = frame,
						},
					}
					return tab
				end
			end
		end)

		wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 4, function(_)
			if wakaba:getOptionValue("hudpstg") then -- -1, 0, 1, 2
				wakaba.globalHUDSprite:RemoveOverlay()
				wakaba.globalHUDSprite:SetFrame("PST", 1)
				local room = Game():GetRoom()
				local loc = wakaba:getOptionValue("hud_pstg")
				local expType = wakaba:getOptionValue("hudpstg")
				local frame = 1
				local charData = PST.modData
				if charData then
					local level = charData.level
					local current = charData.xp + (charData.xpObtained or 0)
					local nextLevel = charData.xpRequired
					local barPercent = math.min(1, current / math.max(1, nextLevel))
					local string = "Global Lv." .. level
					if expType >= 0 then
						local ind = 10 ^ expType
						--string = string .. " : "..current.."/"..nextLevel.." ("..	(math.ceil(barPercent * ind * 100) / ind)	.."%)"
						string = string.. " : " .. (math.ceil(barPercent * ind * 100) / ind) .."%"
					end

					local tab = {
						Sprite = wakaba.globalHUDSprite,
						Text = string,
						Location = loc,
						SpriteOptions = {
							Anim = "PST",
							Frame = frame,
						},
					}
					return tab
				end
			end
		end)
	end
end)