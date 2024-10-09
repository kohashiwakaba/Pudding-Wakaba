
wakaba:RegisterPatch(0, "Retribution", function() return (Retribution ~= nil) end, function()
	do
		local mod = Retribution

		wakaba:BulkAppend(wakaba.Weights.CloverChest, {
			{Retribution.Item.BLACK_BOX, 1.00},
			{Retribution.Item.FALSE_IDOL, 1.00},
			{Retribution.Item.SCULPTING_CLAY, 1.00},
			{Retribution.Item.SHATTERED_DICE, 1.00},
			{Retribution.Item.MEAT_GRINDER, 1.00},
			{Retribution.Item.MOONLIT_MIRROR, 1.00},
			{Retribution.Item.GACHA_GO, 1.00},
			{Retribution.Item.CADUCEUS, 1.00},
			{Retribution.Item.CELESTIAL_BERRY, 1.00},
			{Retribution.Item.CHIMERISM, 1.00},
			{Retribution.Item.DEFIBRILLATOR, 1.00},
			{Retribution.Item.EFFIGY, 1.00},
			{Retribution.Item.ETERNAL_BOMBS, 1.00},
			{Retribution.Item.EVES_NAIL_POLISH, 1.00},
			{Retribution.Item.KAPALA, 1.00},
			{Retribution.Item.LAUGHING_GAS, 1.00},
			{Retribution.Item.MOXIES_HEAD, 1.00},
			{Retribution.Item.RAPTURE, 1.00},
			{Retribution.Item.REWARDS_CARD, 1.00},
			{Retribution.Item.ROLL_FILM, 1.00},
			{Retribution.Item.SMOOTH_STONE, 1.00},
			{Retribution.Item.TOOL, 1.00},
			{Retribution.Item.TITHE, 1.00},
			{Retribution.Item.TOY_DRUM, 1.00},
			{Retribution.Item.WAX_WING, 1.00},
			{Retribution.Item.CARAPACE, 1.00},
			{Retribution.Item.EYE_OF_BALOR, 1.00},
			{Retribution.Item.KOMPU_GACHA, 1.00},
			{Retribution.Item.MULTI_CAPSULE, 1.00},
			{Retribution.Item.HEARTBROKER, 1.00},
			{Retribution.Item.RED_CHAIN, 1.00},
			{Retribution.Item.TECHNOLOGY_OMICRON, 1.00},
		})
		wakaba:BulkAppend(wakaba.Weights.ShioriValut, {
			{Retribution.ITEMS.BAPTISMAL_FONT, 1.00},
			{Retribution.ITEMS.BOOK_OF_MORMON, 1.00},
			{Retribution.ITEMS.FALSE_IDOL, 1.00},
			{Retribution.ITEMS.LIFEBLOOD_SYRINGE, 1.00},
			{Retribution.ITEMS.BYGONE_ARM, 1.00},
			{Retribution.ITEMS.FRIENDLY_MONSTER, 1.00},
			{Retribution.ITEMS.HYPEROPIA, 1.00},
			{Retribution.ITEMS.RAPTURE, 1.00},
			{Retribution.ITEMS.SUNKEN_FLY, 1.00},
			{Retribution.ITEMS.CARAPACE, 1.00},
			{Retribution.ITEMS.POLARIS, 1.00},
		})

		-- Ret - Everlasting Pills
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.TROLLED)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.TO_THE_START)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.SOCIAL_DISTANCE)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.DUALITY_ORDERS)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.PRIEST_BLESSING)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.UNHOLY_CURSE)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.HEAVY_MASCARA)

		-- Ret - Neverlasting Pills
		table.insert(mod.NeverlastingPills, wakaba.Enums.Pills.ALL_STATS_DOWN)
		table.insert(mod.NeverlastingPills, wakaba.Enums.Pills.ALL_STATS_UP)
		table.insert(mod.NeverlastingPills, wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN)
		table.insert(mod.NeverlastingPills, wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP)

		-- PHD map
		wakaba:DictionaryBulkAppend(mod.PhdEffectMap, {
			[wakaba.Enums.Pills.TROLLED] = wakaba.Enums.Pills.TO_THE_START,
			[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT,
			[wakaba.Enums.Pills.SOCIAL_DISTANCE] = wakaba.Enums.Pills.DUALITY_ORDERS,
			[wakaba.Enums.Pills.UNHOLY_CURSE] = wakaba.Enums.Pills.PRIEST_BLESSING,
			[wakaba.Enums.Pills.ALL_STATS_DOWN] = wakaba.Enums.Pills.ALL_STATS_UP,
			[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP,
			[wakaba.Enums.Pills.HEAVY_MASCARA] = PillEffect.PILLEFFECT_SUNSHINE,
		})

		wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, -20000, function(_)
			if mod.savedata.icarusCurseIndicator % 2 == 0 then
				local player = Isaac.GetPlayer()
				if player:GetPlayerType() == mod.PLAYER_TYPE.ICARUS then
					return {Skip = true}
				end
			end
		end)

		wakaba:BulkAppend(wakaba.Blacklists.AquaTrinkets, mod.CursedTrinketPool)

		local cursedTrinkets = {
			[wakaba.Enums.Trinkets.CORRUPTED_CLOVER] = 7,
			[wakaba.Enums.Trinkets.DARK_PENDANT] = 5,
			[wakaba.Enums.Trinkets.BROKEN_NECKLACE] = 10,
			[wakaba.Enums.Trinkets.LEAF_NEEDLE] = 7,
			[wakaba.Enums.Trinkets.RICHERS_HAIR] = 10,
			[wakaba.Enums.Trinkets.RIRAS_HAIR] = 10,
			[wakaba.Enums.Trinkets.SPY_EYE] = 5,
			[wakaba.Enums.Trinkets.FADED_MARK] = 5,
			[wakaba.Enums.Trinkets.NEVERLASTING_BUNNY] = 5,
			[wakaba.Enums.Trinkets.RIBBON_CAGE] = 7,
			[wakaba.Enums.Trinkets.RIRAS_WORST_NIGHTMARE] = 10,
			[wakaba.Enums.Trinkets.MASKED_SHOVEL] = 7,
			[wakaba.Enums.Trinkets.BROKEN_WATCH_2] = 5,
			[wakaba.Enums.Trinkets.ROUND_AND_ROUND] = 5,
			[wakaba.Enums.Trinkets.GEHENNA_ROCK] = 7,
			[wakaba.Enums.Trinkets.BROKEN_MURASAME] = 7,
			[wakaba.Enums.Trinkets.LUNATIC_CRYSTAL] = 5,
			[wakaba.Enums.Trinkets.TORN_PAPER_2] = 10,
			[wakaba.Enums.Trinkets.MINI_TORIZO] = 10,
			[wakaba.Enums.Trinkets.GRENADE_D20] = 7,
			[wakaba.Enums.Trinkets.WAKABA_SIREN] = 3,
		}
		for trinketID, baseSellValue in pairs(cursedTrinkets) do
			--mod.AddCursedTrinket(trinketID, baseSellValue)
		end
		local trinketsToCurse = {
			[wakaba.Enums.Trinkets.FADED_MARK] = wakaba.curses.CURSE_OF_SNIPER,
			[wakaba.Enums.Trinkets.NEVERLASTING_BUNNY] = wakaba.curses.CURSE_OF_AMNESIA,
			[wakaba.Enums.Trinkets.RIBBON_CAGE] = wakaba.curses.CURSE_OF_FAIRY,
			[Retribution.Trinket.BLOWN_FUSE] = wakaba.curses.CURSE_OF_SNIPER,
			[Retribution.Trinket.IMPISH_MAIZE] = wakaba.curses.CURSE_OF_AMNESIA,
			[Retribution.Trinket.FADED_MAP] = wakaba.curses.CURSE_OF_FAIRY,
			[Retribution.Trinket.DEAD_CANARY] = wakaba.curses.CURSE_OF_MAGICAL_GIRL,
		}

		for trinket, curse in pairs(trinketsToCurse) do

			wakaba:AddCallback(mod.Callback.GET_CURSED_TRINKET, function()
				if not mod.AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) then
					local level = wakaba.G:GetLevel()
					level:AddCurse(curse)
				end
			end, trinket)

			wakaba:AddCallback(mod.Callback.SELL_CURSED_TRINKET, function(_, player)
				local level = wakaba.G:GetLevel()
				level:RemoveCurses(curse)
			end, trinket)
		end

		wakaba:AddCallback(mod.Callback.GET_CURSED_TRINKET, function()
			wakaba.G:GetLevel():DisableDevilRoom()
		end, wakaba.Enums.Trinkets.BROKEN_MURASAME)
	end
end)