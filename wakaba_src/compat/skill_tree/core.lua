local pa = false

local modifiers = include("wakaba_src.compat.skill_tree.modifier_descriptions")
local sprite_ids = include("wakaba_src.compat.skill_tree.sprite_ids")
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
  "345": "{\"pos\":[0,0],\"type\":5009,\"size\":\"Large\",\"name\":\"Tree of Wakaba\",\"description\":[\"+0.05 all stats\"],\"modifiers\":{\"allstatsPerc\":0.05},\"adjacent\":[346],\"alwaysAvailable\":true,\"customID\":\"w_wakaba_0000\"}",
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
  "368": "{\"pos\":[0,-10],\"type\":5002,\"size\":\"Large\",\"name\":\"Pendant Luck\",\"description\":[\"+0.5 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.5},\"adjacent\":[354,525,644,604,558,665],\"customID\":\"w_wakaba_0003\"}",
  "387": "{\"pos\":[-1,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[674,388]}",
  "388": "{\"pos\":[-2,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[387,389]}",
  "389": "{\"pos\":[-3,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[388,390]}",
  "390": "{\"pos\":[-4,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[389,391]}",
  "391": "{\"pos\":[-5,-30],\"type\":19,\"size\":\"Small\",\"name\":\"Luck\",\"description\":[\"+0.05 luck\"],\"modifiers\":{\"luck\":0.05},\"adjacent\":[390,392]}",
  "392": "{\"pos\":[-6,-30],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[391,393],\"customID\":\"w_wakaba_0001\"}",
  "393": "{\"pos\":[-7,-31],\"type\":5001,\"size\":\"Med\",\"name\":\"Pendant Luck\",\"description\":[\"+0.2 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.2},\"adjacent\":[392,394],\"customID\":\"w_wakaba_0002\"}",
  "394": "{\"pos\":[-8,-32],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[393,420],\"customID\":\"w_wakaba_0001\"}",
  "396": "{\"pos\":[-8,-34],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[420,397],\"customID\":\"w_wakaba_0001\"}",
  "397": "{\"pos\":[-7,-35],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[396,398],\"customID\":\"w_wakaba_0001\"}",
  "398": "{\"pos\":[-6,-35],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[397,399],\"customID\":\"w_wakaba_0001\"}",
  "399": "{\"pos\":[-5,-36],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[398,401],\"customID\":\"w_wakaba_0001\"}",
  "401": "{\"pos\":[-5,-37],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[399,402],\"customID\":\"w_wakaba_0001\"}",
  "402": "{\"pos\":[-4,-38],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[401,421],\"customID\":\"w_wakaba_0001\"}",
  "404": "{\"pos\":[-2,-38],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[421,405],\"customID\":\"w_wakaba_0001\"}",
  "405": "{\"pos\":[-1,-37],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[404,422],\"customID\":\"w_wakaba_0001\"}",
  "407": "{\"pos\":[-1,-35],\"type\":5001,\"size\":\"Med\",\"name\":\"Pendant Luck\",\"description\":[\"+0.2 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.2},\"adjacent\":[422,423],\"customID\":\"w_wakaba_0002\"}",
  "409": "{\"pos\":[-1,-33],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[423,410],\"customID\":\"w_wakaba_0001\"}",
  "410": "{\"pos\":[-2,-32],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[409,416],\"customID\":\"w_wakaba_0001\"}",
  "413": "{\"pos\":[-4,-32],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[416,415],\"customID\":\"w_wakaba_0001\"}",
  "415": "{\"pos\":[-5,-33],\"type\":5002,\"size\":\"Large\",\"name\":\"Pendant Luck\",\"description\":[\"+0.5 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.5},\"adjacent\":[413,417],\"customID\":\"w_wakaba_0003\"}",
  "416": "{\"pos\":[-3,-32],\"type\":5001,\"size\":\"Med\",\"name\":\"Pendant Luck\",\"description\":[\"+0.2 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.2},\"adjacent\":[410,413],\"customID\":\"w_wakaba_0002\"}",
  "417": "{\"pos\":[-4,-34],\"type\":5000,\"size\":\"Small\",\"name\":\"Pendant Luck\",\"description\":[\"+0.05 min luck for Wakaba's Pendant\"],\"modifiers\":{\"pendantMinLuck\":0.05},\"adjacent\":[415,620],\"customID\":\"w_wakaba_0001\"}",
  "420": "{\"pos\":[-8,-33],\"type\":302,\"size\":\"Small\",\"name\":\"Secret Room Floor Luck\",\"description\":[\"+0.1 luck for the current floor when first entering a secret or super secret room.\"],\"modifiers\":{\"secretRoomFloorLuck\":0.1},\"adjacent\":[394,396]}",
  "421": "{\"pos\":[-3,-38],\"type\":302,\"size\":\"Small\",\"name\":\"Secret Room Floor Luck\",\"description\":[\"+0.1 luck for the current floor when first entering a secret or super secret room.\"],\"modifiers\":{\"secretRoomFloorLuck\":0.1},\"adjacent\":[402,404]}",
  "422": "{\"pos\":[-1,-36],\"type\":302,\"size\":\"Small\",\"name\":\"Secret Room Floor Luck\",\"description\":[\"+0.1 luck for the current floor when first entering a secret or super secret room.\"],\"modifiers\":{\"secretRoomFloorLuck\":0.1},\"adjacent\":[405,407]}",
  "423": "{\"pos\":[-1,-34],\"type\":302,\"size\":\"Small\",\"name\":\"Secret Room Floor Luck\",\"description\":[\"+0.1 luck for the current floor when first entering a secret or super secret room.\"],\"modifiers\":{\"secretRoomFloorLuck\":0.1},\"adjacent\":[407,409]}",
  "425": "{\"pos\":[1,-30],\"type\":5004,\"size\":\"Med\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{},\"adjacent\":[674,426],\"customID\":\"w_wakaba_0005\"}",
  "426": "{\"pos\":[1,-31],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[425,427]}",
  "427": "{\"pos\":[1,-32],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[426,428]}",
  "428": "{\"pos\":[1,-33],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[427,429]}",
  "429": "{\"pos\":[1,-34],\"type\":22,\"size\":\"Small\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+0.25% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":0.25},\"adjacent\":[428,676]}",
  "453": "{\"pos\":[1,-28],\"type\":5008,\"size\":\"Large\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"1% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":1},\"adjacent\":[674,454],\"customID\":\"w_wakaba_0009\"}",
  "454": "{\"pos\":[2,-28],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[453,455]}",
  "455": "{\"pos\":[3,-28],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[454,456]}",
  "456": "{\"pos\":[4,-28],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[455,457]}",
  "457": "{\"pos\":[5,-28],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[456,458]}",
  "458": "{\"pos\":[6,-28],\"type\":5006,\"size\":\"Small\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.2},\"adjacent\":[457,459],\"customID\":\"w_wakaba_0007\"}",
  "459": "{\"pos\":[7,-27],\"type\":5007,\"size\":\"Med\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.5},\"adjacent\":[458,460],\"customID\":\"w_wakaba_0008\"}",
  "460": "{\"pos\":[8,-26],\"type\":5006,\"size\":\"Small\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.2},\"adjacent\":[459,461],\"customID\":\"w_wakaba_0007\"}",
  "461": "{\"pos\":[8,-25],\"type\":301,\"size\":\"Small\",\"name\":\"Pill Floor Luck\",\"description\":[\"1% increased luck for the current floor when you consume a pill\"],\"modifiers\":{\"pillFloorLuck\":1},\"adjacent\":[460,462]}",
  "462": "{\"pos\":[8,-24],\"type\":5006,\"size\":\"Small\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.2},\"adjacent\":[461,467],\"customID\":\"w_wakaba_0007\"}",
  "467": "{\"pos\":[7,-23],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[462,468]}",
  "468": "{\"pos\":[6,-23],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[467,469]}",
  "469": "{\"pos\":[5,-22],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[468,470]}",
  "470": "{\"pos\":[5,-21],\"type\":299,\"size\":\"Small\",\"name\":\"Lucky Pennies\",\"description\":[\"0.15% chance to replace penny drops with a lucky penny.\"],\"modifiers\":{\"luckyPennyChance\":0.15},\"adjacent\":[469,475]}",
  "475": "{\"pos\":[4,-20],\"type\":5006,\"size\":\"Small\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.2},\"adjacent\":[470,477],\"customID\":\"w_wakaba_0007\"}",
  "477": "{\"pos\":[3,-20],\"type\":5007,\"size\":\"Med\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.5},\"adjacent\":[475,478],\"customID\":\"w_wakaba_0008\"}",
  "478": "{\"pos\":[2,-20],\"type\":5006,\"size\":\"Small\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.2},\"adjacent\":[477,479],\"customID\":\"w_wakaba_0007\"}",
  "479": "{\"pos\":[1,-21],\"type\":5006,\"size\":\"Small\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.2},\"adjacent\":[478,480],\"customID\":\"w_wakaba_0007\"}",
  "480": "{\"pos\":[1,-22],\"type\":5007,\"size\":\"Med\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.5},\"adjacent\":[479,481],\"customID\":\"w_wakaba_0008\"}",
  "481": "{\"pos\":[1,-23],\"type\":5008,\"size\":\"Large\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"1% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":1},\"adjacent\":[480,482],\"customID\":\"w_wakaba_0009\"}",
  "482": "{\"pos\":[1,-24],\"type\":5007,\"size\":\"Med\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.5},\"adjacent\":[481,483],\"customID\":\"w_wakaba_0008\"}",
  "483": "{\"pos\":[1,-25],\"type\":5006,\"size\":\"Small\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.2},\"adjacent\":[482,484],\"customID\":\"w_wakaba_0007\"}",
  "484": "{\"pos\":[2,-26],\"type\":5006,\"size\":\"Small\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.2},\"adjacent\":[483,485],\"customID\":\"w_wakaba_0007\"}",
  "485": "{\"pos\":[3,-26],\"type\":5007,\"size\":\"Med\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.5},\"adjacent\":[484,486],\"customID\":\"w_wakaba_0008\"}",
  "486": "{\"pos\":[4,-26],\"type\":5006,\"size\":\"Small\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.2% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.2},\"adjacent\":[485,487],\"customID\":\"w_wakaba_0007\"}",
  "487": "{\"pos\":[5,-25],\"type\":5008,\"size\":\"Large\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"1% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":1},\"adjacent\":[486,675],\"customID\":\"w_wakaba_0009\"}",
  "491": "{\"pos\":[5,-32],\"type\":5032,\"size\":\"Large\",\"name\":\"Daughter of the Rich\",\"description\":[\"Wakaba Can get all selection items\"],\"modifiers\":{\"wakabaJaebol\":true},\"adjacent\":[621],\"customID\":\"w_wakaba_1003\"}",
  "492": "{\"pos\":[-3,-34],\"type\":5030,\"size\":\"Large\",\"name\":\"Good Girl\",\"description\":[\"Wakaba starts with Wakaba's Pendant\"],\"modifiers\":{\"wakabaGudGirl\":true},\"adjacent\":[620],\"customID\":\"w_wakaba_1001\"}",
  "493": "{\"pos\":[-5,-26],\"type\":5034,\"size\":\"Large\",\"name\":\"Tearing Clover Leaf\",\"description\":[\"Negates a hit that would've killed you, if you have more than 0 luck.\",\"Negating a hit reduces 20, or 20% of current luck, higher value prioritized.\",\"Reduced luck this way ignores Wakaba's Pendant\",\"Does not work if player has Rock Bottom.\"],\"modifiers\":{\"wakabaLeafTear\":true},\"adjacent\":[619],\"customID\":\"w_wakaba_1005\"}",
  "494": "{\"pos\":[-1,-28],\"type\":5015,\"size\":\"Large\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"5% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":5},\"adjacent\":[674,495],\"customID\":\"w_wakaba_0016\"}",
  "495": "{\"pos\":[-1,-27],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[494,496],\"customID\":\"w_global_0004\"}",
  "496": "{\"pos\":[-1,-26],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[495,497],\"customID\":\"w_global_0004\"}",
  "497": "{\"pos\":[-1,-25],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[496,498],\"customID\":\"w_global_0004\"}",
  "498": "{\"pos\":[-1,-24],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[497,499],\"customID\":\"w_global_0004\"}",
  "499": "{\"pos\":[-1,-23],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[498,500],\"customID\":\"w_wakaba_0014\"}",
  "500": "{\"pos\":[-2,-22],\"type\":5014,\"size\":\"Med\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":1},\"adjacent\":[499,501],\"customID\":\"w_wakaba_0015\"}",
  "501": "{\"pos\":[-3,-21],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[500,503],\"customID\":\"w_wakaba_0014\"}",
  "503": "{\"pos\":[-4,-21],\"type\":5044,\"size\":\"Med\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.2% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.2},\"adjacent\":[501,504],\"customID\":\"w_global_0005\"}",
  "504": "{\"pos\":[-5,-21],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[503,505],\"customID\":\"w_wakaba_0014\"}",
  "505": "{\"pos\":[-6,-22],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[504,506],\"customID\":\"w_wakaba_0014\"}",
  "506": "{\"pos\":[-6,-23],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[505,507],\"customID\":\"w_global_0004\"}",
  "507": "{\"pos\":[-7,-24],\"type\":5043,\"size\":\"Small\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.1},\"adjacent\":[506,508],\"customID\":\"w_global_0004\"}",
  "508": "{\"pos\":[-8,-24],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[507,509],\"customID\":\"w_wakaba_0014\"}",
  "509": "{\"pos\":[-9,-25],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[508,511],\"customID\":\"w_wakaba_0014\"}",
  "511": "{\"pos\":[-9,-26],\"type\":5014,\"size\":\"Med\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":1},\"adjacent\":[509,512],\"customID\":\"w_wakaba_0015\"}",
  "512": "{\"pos\":[-9,-27],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[511,513],\"customID\":\"w_wakaba_0014\"}",
  "513": "{\"pos\":[-8,-28],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[512,514],\"customID\":\"w_wakaba_0014\"}",
  "514": "{\"pos\":[-7,-28],\"type\":5044,\"size\":\"Med\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.2% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.2},\"adjacent\":[513,515],\"customID\":\"w_global_0005\"}",
  "515": "{\"pos\":[-6,-28],\"type\":5045,\"size\":\"Large\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.5% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.5},\"adjacent\":[514,516],\"customID\":\"w_global_0006\"}",
  "516": "{\"pos\":[-5,-28],\"type\":5044,\"size\":\"Med\",\"name\":\"Holy Shield on hit\",\"description\":[\"0.2% chance to recieve Holy shield on hit\"],\"modifiers\":{\"shieldChance\":0.2},\"adjacent\":[515,517],\"customID\":\"w_global_0005\"}",
  "517": "{\"pos\":[-4,-28],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[516,518],\"customID\":\"w_wakaba_0014\"}",
  "518": "{\"pos\":[-3,-27],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[517,519],\"customID\":\"w_wakaba_0014\"}",
  "519": "{\"pos\":[-3,-26],\"type\":5014,\"size\":\"Med\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"1% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":1},\"adjacent\":[518,520],\"customID\":\"w_wakaba_0015\"}",
  "520": "{\"pos\":[-3,-25],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[519,521],\"customID\":\"w_wakaba_0014\"}",
  "521": "{\"pos\":[-4,-24],\"type\":5015,\"size\":\"Large\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"5% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":5},\"adjacent\":[520,522],\"customID\":\"w_wakaba_0016\"}",
  "522": "{\"pos\":[-5,-25],\"type\":5013,\"size\":\"Small\",\"name\":\"Wakaba Holy Shield on hit\",\"description\":[\"0.4% chance to recieve Holy shield on hit\"],\"modifiers\":{\"wakabaShieldChance\":0.4},\"adjacent\":[521,619],\"customID\":\"w_wakaba_0014\"}",
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
  "582": "{\"pos\":[-10,-5],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[544],\"customID\":\"w_wakaba_0013\"}",
  "583": "{\"pos\":[10,-7],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[566],\"customID\":\"w_wakaba_0013\"}",
  "584": "{\"pos\":[15,-21],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[633],\"customID\":\"w_wakaba_0013\"}",
  "585": "{\"pos\":[-15,-22],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[603],\"customID\":\"w_wakaba_0013\"}",
  "586": "{\"pos\":[-15,-11],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[639],\"customID\":\"w_wakaba_0013\"}",
  "587": "{\"pos\":[-13,-16],\"type\":5035,\"size\":\"Large\",\"name\":\"Cloverfest\",\"description\":[\"Clover chest can be appeared regardless of unlock.\",\"Clover chest can be opened without using keys.\"],\"modifiers\":{\"wakabaFreeClover\":true},\"adjacent\":[654,635,598],\"customID\":\"w_wakaba_1006\"}",
  "588": "{\"pos\":[11,-14],\"type\":5031,\"size\":\"Large\",\"name\":\"Wakaba-chan is no longer baka\",\"description\":[\"Wakaba Starts with Perfection\"],\"modifiers\":{\"wakabaIsSmart\":true},\"adjacent\":[612,622,613],\"customID\":\"w_wakaba_1002\"}",
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
  "618": "{\"pos\":[3,-23],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[524,675],\"customID\":\"w_wakaba_0013\"}",
  "619": "{\"pos\":[-6,-26],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[522,493],\"customID\":\"w_wakaba_0013\"}",
  "620": "{\"pos\":[-3,-35],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[417,492],\"customID\":\"w_wakaba_0013\"}",
  "621": "{\"pos\":[6,-32],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[116,491],\"customID\":\"w_wakaba_0013\"}",
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
  "635": "{\"pos\":[-14,-16],\"type\":5016,\"size\":\"Small\",\"name\":\"Wakaba Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[587,636],\"customID\":\"w_wakaba_0017\"}",
  "636": "{\"pos\":[-15,-15],\"type\":5016,\"size\":\"Small\",\"name\":\"Wakaba Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[635,637,640],\"customID\":\"w_wakaba_0017\"}",
  "637": "{\"pos\":[-15,-14],\"type\":5016,\"size\":\"Small\",\"name\":\"Wakaba Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[636,638,642],\"customID\":\"w_wakaba_0017\"}",
  "638": "{\"pos\":[-15,-13],\"type\":5016,\"size\":\"Small\",\"name\":\"Wakaba Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[637,639],\"customID\":\"w_wakaba_0017\"}",
  "639": "{\"pos\":[-15,-12],\"type\":5016,\"size\":\"Small\",\"name\":\"Wakaba Clover Chest Chance\",\"description\":[\"1% chance to spawn Clover chest\"],\"modifiers\":{\"wakabaCloverChestChance\":1},\"adjacent\":[638,586],\"customID\":\"w_wakaba_0017\"}",
  "640": "{\"pos\":[-16,-14],\"type\":5020,\"size\":\"Small\",\"name\":\"Wakaba Clover Chest Range\",\"description\":[\"+0.2 range when opening Clover Chest. Resets every floor.\"],\"modifiers\":{\"wakabaCloverChestRange\":0.2},\"adjacent\":[636,641],\"customID\":\"w_wakaba_0021\"}",
  "641": "{\"pos\":[-17,-13],\"type\":5021,\"size\":\"Med\",\"name\":\"Wakaba Clover Chest Range\",\"description\":[\"+0.5 range when opening Clover Chest. Resets every floor.\"],\"modifiers\":{\"wakabaCloverChestRange\":0.5},\"adjacent\":[640],\"customID\":\"w_wakaba_0022\"}",
  "642": "{\"pos\":[-16,-13],\"type\":5020,\"size\":\"Small\",\"name\":\"Wakaba Clover Chest Range\",\"description\":[\"+0.2 range when opening Clover Chest. Resets every floor.\"],\"modifiers\":{\"wakabaCloverChestRange\":0.2},\"adjacent\":[637,643],\"customID\":\"w_wakaba_0021\"}",
  "643": "{\"pos\":[-16,-12],\"type\":5021,\"size\":\"Med\",\"name\":\"Wakaba Clover Chest Range\",\"description\":[\"+0.5 range when opening Clover Chest. Resets every floor.\"],\"modifiers\":{\"wakabaCloverChestRange\":0.5},\"adjacent\":[642],\"customID\":\"w_wakaba_0022\"}",
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
  "655": "{\"pos\":[8,-7],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[566,565],\"customID\":\"w_wakaba_0011\"}",
  "656": "{\"pos\":[9,-5],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[565,657],\"customID\":\"w_wakaba_0011\"}",
  "657": "{\"pos\":[10,-4],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[656,658],\"customID\":\"w_wakaba_0011\"}",
  "658": "{\"pos\":[11,-4],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[657,659,660],\"customID\":\"w_wakaba_0011\"}",
  "659": "{\"pos\":[12,-3],\"type\":5011,\"size\":\"Med\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.04% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.04},\"adjacent\":[658],\"customID\":\"w_wakaba_0012\"}",
  "660": "{\"pos\":[13,-4],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[658,661],\"customID\":\"w_wakaba_0011\"}",
  "661": "{\"pos\":[14,-5],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[660,662],\"customID\":\"w_wakaba_0011\"}",
  "662": "{\"pos\":[15,-5],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[661,663],\"customID\":\"w_wakaba_0011\"}",
  "663": "{\"pos\":[16,-6],\"type\":5011,\"size\":\"Med\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.04% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.04},\"adjacent\":[662,664,697],\"customID\":\"w_wakaba_0012\"}",
  "664": "{\"pos\":[16,-7],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[663],\"customID\":\"w_wakaba_0013\"}",
  "665": "{\"pos\":[0,-12],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[368,666],\"customID\":\"w_wakaba_0011\"}",
  "666": "{\"pos\":[0,-14],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[665,667],\"customID\":\"w_wakaba_0011\"}",
  "667": "{\"pos\":[0,-16],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[666,668],\"customID\":\"w_wakaba_0011\"}",
  "668": "{\"pos\":[0,-18],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[667,669],\"customID\":\"w_wakaba_0011\"}",
  "669": "{\"pos\":[0,-20],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[668,670],\"customID\":\"w_wakaba_0011\"}",
  "670": "{\"pos\":[0,-22],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[669,671],\"customID\":\"w_wakaba_0011\"}",
  "671": "{\"pos\":[0,-24],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[670,672],\"customID\":\"w_wakaba_0011\"}",
  "672": "{\"pos\":[0,-26],\"type\":5010,\"size\":\"Small\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.01% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.01},\"adjacent\":[671,673],\"customID\":\"w_wakaba_0011\"}",
  "673": "{\"pos\":[0,-27],\"type\":5011,\"size\":\"Med\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.04% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.04},\"adjacent\":[672,674],\"customID\":\"w_wakaba_0012\"}",
  "674": "{\"pos\":[0,-29],\"type\":5012,\"size\":\"Large\",\"name\":\"Wakaba Damage to Luck\",\"description\":[\"0.1% damage every 1 luck\"],\"modifiers\":{\"wakabaDamageLuck\":0.1},\"adjacent\":[673,387,425,453,494],\"customID\":\"w_wakaba_0013\"}",
  "675": "{\"pos\":[4,-24],\"type\":5007,\"size\":\"Med\",\"name\":\"Wakaba Lucky Pennies\",\"description\":[\"0.5% extra chance to replace penny drops with a lucky penny as Wakaba\"],\"modifiers\":{\"pendantMinLuckyPennyChance\":0.5},\"adjacent\":[487,618],\"customID\":\"w_wakaba_0008\"}",
  "676": "{\"pos\":[1,-35],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[429,688],\"customID\":\"w_wakaba_0004\"}",
  "678": "{\"pos\":[3,-37],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[688,689],\"customID\":\"w_wakaba_0004\"}",
  "679": "{\"pos\":[5,-37],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[689,680],\"customID\":\"w_wakaba_0004\"}",
  "680": "{\"pos\":[6,-36],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[679,681],\"customID\":\"w_wakaba_0004\"}",
  "681": "{\"pos\":[6,-35],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[680,682],\"customID\":\"w_wakaba_0004\"}",
  "682": "{\"pos\":[7,-34],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[681,683],\"customID\":\"w_wakaba_0004\"}",
  "683": "{\"pos\":[8,-34],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[682,684],\"customID\":\"w_wakaba_0004\"}",
  "684": "{\"pos\":[9,-33],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[683,690],\"customID\":\"w_wakaba_0004\"}",
  "685": "{\"pos\":[9,-31],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[690,686],\"customID\":\"w_wakaba_0004\"}",
  "686": "{\"pos\":[8,-30],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[685,691],\"customID\":\"w_wakaba_0004\"}",
  "687": "{\"pos\":[4,-30],\"type\":5003,\"size\":\"Small\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":1},\"adjacent\":[692,112],\"customID\":\"w_wakaba_0004\"}",
  "688": "{\"pos\":[2,-36],\"type\":5004,\"size\":\"Med\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[676,678],\"customID\":\"w_wakaba_0005\"}",
  "689": "{\"pos\":[4,-37],\"type\":5004,\"size\":\"Med\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[678,679],\"customID\":\"w_wakaba_0005\"}",
  "690": "{\"pos\":[9,-32],\"type\":5004,\"size\":\"Med\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[684,685],\"customID\":\"w_wakaba_0005\"}",
  "691": "{\"pos\":[7,-30],\"type\":5004,\"size\":\"Med\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[686,695],\"customID\":\"w_wakaba_0005\"}",
  "692": "{\"pos\":[5,-30],\"type\":5004,\"size\":\"Med\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+2% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":2},\"adjacent\":[695,687],\"customID\":\"w_wakaba_0005\"}",
  "693": "{\"pos\":[3,-32],\"type\":28,\"size\":\"Med\",\"name\":\"Devil/Angel Rooms\",\"description\":[\"+1% chance for the devil/angel room to show up\"],\"modifiers\":{\"devilChance\":1},\"adjacent\":[112,114]}",
  "694": "{\"pos\":[4,-34],\"type\":5005,\"size\":\"Large\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+5% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":5},\"adjacent\":[114,116],\"customID\":\"w_wakaba_0006\"}",
  "695": "{\"pos\":[6,-30],\"type\":5005,\"size\":\"Large\",\"name\":\"Wakaba Devil/Angel Rooms\",\"description\":[\"+5% chance for the devil/angel room to show up\"],\"modifiers\":{\"wakabaDevilChance\":5},\"adjacent\":[691,692],\"customID\":\"w_wakaba_0006\"}",
  "697": "{\"pos\":[17,-5],\"type\":5037,\"size\":\"Large\",\"name\":\"Impure Girl\",\"description\":[\"Begin the game with Birthright\",\"All Boss items are replaced with Devil deals\"],\"modifiers\":{\"wakabaBirthright\":true},\"adjacent\":[663],\"customID\":\"w_wakaba_1008\"}"
}
]])
	end

	do -- NODES SHIORI
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

		wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function(_, player)
			if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
				if wakaba:extraVal("wakabaIsSmart") then
					player:AddTrinket(TrinketType.TRINKET_PERFECTION)
				end
				if wakaba:extraVal("wakabaBirthright") then
					player:AddCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
				end
			end
		end, 0)
		wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function(_)
      local room = wakaba.G:GetRoom()
			for num = 1, wakaba.G:GetNumPlayers() do
				local player = wakaba.G:GetPlayer(num - 1)
				wakaba:removePlayerDataEntry(player, "CloverChestRange")
			end
			if wakaba:extraVal("wakabaWildCard") then
        local pos = room:GetGridPosition(102)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_WILD, room:FindFreePickupSpawnPosition(pos, 40), Vector.Zero, nil)
			end
		end)

		---@param player EntityPlayer
		---@param cacheFlag CacheFlag
		wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function (_, player, cacheFlag)
			if cacheFlag == CacheFlag.CACHE_RANGE then
				local range = wakaba:getPlayerDataEntry(player, "CloverChestRange", 0)
				if range > 0 then
					player.TearRange = player.TearRange + (range * 40)
				end
			end
		end)
		wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010722, function (_, player, cacheFlag)
			if cacheFlag == CacheFlag.CACHE_SPEED then
				if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
					if wakaba:extraVal("wakabaGudGirl") then
						player.MoveSpeed = player.MoveSpeed * 0.9
					end
				end
			end
			if cacheFlag == CacheFlag.CACHE_LUCK then
				if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
					if wakaba:extraVal("wakabaGudGirl") then
						player.Luck = player.Luck * 1.5
					end
				end
			end
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
					local mult = math.max(wakaba:extraVal("wakabaDamageLuck", 0), 0)
					local luck = player.Luck
					player.Damage = player.Damage * (1 + (luck * (mult / 100)))
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
		wakaba:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, -1000, function(_, target, damage, flag, source)
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
						--string = string .. " : "..current.."/"..nextLevel.." ("..  (math.ceil(barPercent * ind * 100) / ind)  .."%)"
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
						--string = string .. " : "..current.."/"..nextLevel.." ("..  (math.ceil(barPercent * ind * 100) / ind)  .."%)"
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