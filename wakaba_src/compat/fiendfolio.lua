
wakaba:RegisterPatch(0, "FiendFolio", function() return (FiendFolio ~= nil) end, function()
	do
		wakaba:BlacklistUniform("card", FiendFolio.ITEM.CARD.CHRISTMAS_CRACKER)
		wakaba:BlacklistUniform("card", FiendFolio.ITEM.CARD.POT_OF_GREED)
		wakaba:BlacklistUniform("card", FiendFolio.ITEM.CARD.SMALL_CONTRABAND)

		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.EMPTY_BOOK, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6, wakaba.bookstate.BOOKSHELF_SHIORI)

		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)

		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.EMPTY_BOOK, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)

		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.EMPTY_BOOK, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)

		wakaba.Blacklists.MaidDuet[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1] = true
		wakaba.Blacklists.MaidDuet[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_2] = true
		wakaba.Blacklists.MaidDuet[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_3] = true
		wakaba.Blacklists.MaidDuet[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_4] = true
		wakaba.Blacklists.MaidDuet[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_5] = true
		wakaba.Blacklists.MaidDuet[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_6] = true
		wakaba.Blacklists.MaidDuet[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_8] = true
		wakaba.Blacklists.MaidDuet[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_12] = true

		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.EXTRA_VESSEL] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.HALF_VESSEL] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.FULL_VESSEL] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.MOLTEN_PENNY] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.IOU] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.ETERNAL_CAR_BATTERY] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.LOCKED_SHACKLE] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.FROG_PUPPET] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.TATTERED_FROG_PUPPET] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.CURSED_URN] = true
		wakaba.Blacklists.Pica2[FiendFolio.ITEM.TRINKET.SHATTERED_CURSED_URN] = true

		FiendFolio.RockTrinkets[wakaba.Enums.Trinkets.BRING_ME_THERE] = -2
		FiendFolio.GolemTrinketWhitelist[wakaba.Enums.Trinkets.BRING_ME_THERE] = 1

		table.insert(FiendFolio.ReferenceItems.Actives, {ID = wakaba.Enums.Collectibles.BOOK_OF_CONQUEST, Reference = "The World Only God Knows"})
		table.insert(FiendFolio.ReferenceItems.Actives, {ID = wakaba.Enums.Collectibles.FLASH_SHIFT, Reference = "Metroid"})
		table.insert(FiendFolio.ReferenceItems.Actives, {ID = wakaba.Enums.Collectibles.CONCENTRATION, Reference = "Metroid"})
		table.insert(FiendFolio.ReferenceItems.Actives, {ID = wakaba.Enums.Collectibles.BOOK_OF_TRAUMA, Reference = "Murdoc"})
		table.insert(FiendFolio.ReferenceItems.Actives, {ID = wakaba.Enums.Collectibles.MURASAME, Reference = "Senren * Banka"})
		table.insert(FiendFolio.ReferenceItems.Actives, {ID = wakaba.Enums.Collectibles.SYRUP, Reference = "Bofuri: I Don't Want to Get Hurt, So I'll Max Out My Defense"})
		table.insert(FiendFolio.ReferenceItems.Actives, {ID = wakaba.Enums.Collectibles.POWER_BOMB, Reference = "Metroid"})
		table.insert(FiendFolio.ReferenceItems.Actives, {ID = wakaba.Enums.Collectibles.PHANTOM_CLOAK, Reference = "Metroid"})
		table.insert(FiendFolio.ReferenceItems.Actives, {ID = wakaba.Enums.Collectibles.QUESTION_BLOCK, Reference = "Super Mario"})

		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.LUNAR_STONE, Reference = "Tonikaku Kawaii"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, Reference = "Tonikaku Kawaii"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.RABBIT_RIBBON, Reference = "Love's Sweet Garnish"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.WINTER_ALBIREO, Reference = "A Sky Full of Stars"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.D_CUP_ICECREAM, Reference = "Wakaba Girl"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD, Reference = "Wakaba Girl"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.WAKABAS_PENDANT, Reference = "Wakaba Girl"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.NEW_YEAR_BOMB, Reference = "Mother"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.VINTAGE_THREAT, Reference = "The World Only God Knows"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.MOE_MUFFIN, Reference = "Wakaba Girl"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.NASA_LOVER, Reference = "Tonikaku Kawaii"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.PLASMA_BEAM, Reference = "Metroid"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.MAGMA_BLADE, Reference = "Mega Man X6"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.RED_CORRUPTION, Reference = "Metroid", Partial = true})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.CLENSING_FOAM, Reference = "Bloons TD 5"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.VENOM_INCANTATION, Reference = "Bofuri: I Don't Want to Get Hurt, So I'll Max Out My Defense"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.DOUBLE_INVADER, Reference = "Bofuri: I Don't Want to Get Hurt, So I'll Max Out My Defense"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.CRISIS_BOOST, Reference = "Rabi Ribi"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.PRESTIGE_PASS, Reference = "EZ2ON : Reboot R", Partial = true})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.CARAMELLA_PANCAKE, Reference = "Love's Sweet Garnish"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.EASTER_EGG, Reference = "Rabi Ribi"})
		table.insert(FiendFolio.ReferenceItems.Passives, {ID = wakaba.Enums.Collectibles.TRIAL_STEW, Reference = "Paper Mario: The Thousand Year Door"})

		table.insert(FiendFolio.ReferenceItems.Trinkets, {ID = wakaba.Enums.Trinkets.BITCOIN, Reference = "Memes"})
		table.insert(FiendFolio.ReferenceItems.Trinkets, {ID = wakaba.Enums.Trinkets.DETERMINATION_RIBBON, Reference = "UNDERTALE", Partial = true})
		table.insert(FiendFolio.ReferenceItems.Trinkets, {ID = wakaba.Enums.Trinkets.RING_OF_JUPITER, Reference = "The World Only God Knows"})
		table.insert(FiendFolio.ReferenceItems.Trinkets, {ID = wakaba.Enums.Trinkets.RANGE_OS, Reference = "Last Origin"})
		table.insert(FiendFolio.ReferenceItems.Trinkets, {ID = wakaba.Enums.Trinkets.MISTAKE, Reference = "Paper Mario"})
		--table.insert(FiendFolio.ReferenceItems.Trinkets, {ID = wakaba.Enums.Trinkets.KUROMI_CARD, Reference = "Onegai My Melody"})

		table.insert(wakaba.PostageRemovalEntities, {160, 451})

		wakaba:addSilenceTarget("FF_Fire", 1000, 7005)
		wakaba:addSilenceTarget("FF_Spider", 85, 962)
		wakaba:addSilenceTarget("FF_Bubble", 150, 1)
		wakaba:addSilenceTarget("FF_Stinger", 150, 6)
		wakaba:addSilenceTarget("FF_Spore", 150, 15)

		FiendFolio:AddStackableItems({
			wakaba.Enums.Collectibles.MINERVA_AURA,
			wakaba.Enums.Collectibles.LUNAR_STONE,
			wakaba.Enums.Collectibles.RABBIT_RIBBON,
			wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD,
			wakaba.Enums.Collectibles.LIL_MOE,
			wakaba.Enums.Collectibles.LIL_SHIVA,
			wakaba.Enums.Collectibles.MOE_MUFFIN,
			wakaba.Enums.Collectibles.SEE_DES_BISCHOFS,
			wakaba.Enums.Collectibles.JAR_OF_CLOVER,
			wakaba.Enums.Collectibles.CRISIS_BOOST,
			wakaba.Enums.Collectibles.ONSEN_TOWEL,
			wakaba.Enums.Collectibles.D_CUP_ICECREAM,
			wakaba.Enums.Collectibles.WAKABAS_PENDANT,
			wakaba.Enums.Collectibles.SECRET_CARD,
			wakaba.Enums.Collectibles.LIL_WAKABA,
			wakaba.Enums.Collectibles.PRESTIGE_PASS,
			wakaba.Enums.Collectibles.DOUBLE_INVADER,
			wakaba.Enums.Collectibles.PLUMY,
			wakaba.Enums.Collectibles.EYE_OF_CLOCK,
			wakaba.Enums.Collectibles.NEKO_FIGURE,
		})

		FiendFolio.AddItemsToContrabandPool({

		})

		wakaba:BulkAppend(wakaba.Weights.CloverChest, {
			{FiendFolio.ITEM.COLLECTIBLE.STORE_WHISTLE, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.PINHEAD, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.IMP_SODA, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.BEGINNERS_LUCK, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.DICHROMATIC_BUTTERFLY, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.CHIRUMIRU, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.GOLEMS_ORB, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.LEFTOVER_TAKEOUT, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.GORGON, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.CLEAR_CASE, 0.50},
			{FiendFolio.ITEM.COLLECTIBLE.PRANK_COOKIE, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.RUBBER_BULLETS, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.SECRET_STASH, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_4, 0.20},
			{FiendFolio.ITEM.COLLECTIBLE.BRIDGE_BOMBS, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.LAWN_DARTS, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.TOY_PIANO, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.MODEL_ROCKET, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.WRONG_WARP, 0.20},
			{FiendFolio.ITEM.COLLECTIBLE.GOLDEN_PLUM_FLUTE, 0.10},
			{FiendFolio.ITEM.COLLECTIBLE.EXCELSIOR, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.PENNY_ROLL, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.AZURITE_SPINDOWN, 0.50},
			{FiendFolio.ITEM.COLLECTIBLE.DEVILS_DAGGER, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.DAZZLING_SLOT, 0.10},
			{FiendFolio.ITEM.COLLECTIBLE.RAT_POISON, 0.05},
			{FiendFolio.ITEM.COLLECTIBLE.BOX_TOP, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.BOTTLE_OF_WATER, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.LOADED_D6, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.ERRORS_CRAZY_SLOTS, 0.50},
		})
		wakaba:BulkAppend(wakaba.Weights.ShioriValut, {
			{FiendFolio.ITEM.COLLECTIBLE.MAMA_SPOOTER, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.GOLEMS_ORB, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.CHIRUMIRU, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.PEACH_CREEP, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.OPHIUCHUS, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.CETUS, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.DEIMOS, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.PET_ROCK, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.CLEAR_CASE, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.WHITE_PEPPER, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.MUSCA, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.PAGE_OF_VIRTUES, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.ROBOBABY3, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.SNOW_GLOBE, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.NYX, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.TELEBOMBS, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.SPINDLE, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.AZURITE_SPINDOWN, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.D3, 1.00},
			{FiendFolio.ITEM.COLLECTIBLE.BOTTLE_OF_WATER, 1.00},
		})

		--[[ wakaba:addSilenceTarget("FF_Waiting_spider", 150, 10)
		wakaba:addSilenceTarget("FF_Waiting_worm", 150, 16) ]]

--[[
		wakaba.CatalogItems["FF_FIEND"] = {
			Weight = 1,
			Items = {
				FiendFolio.ITEM.COLLECTIBLE.PYROMANCY,
				FiendFolio.ITEM.COLLECTIBLE.FIENDS_HORN,
				FiendFolio.ITEM.COLLECTIBLE.IMP_SODA,
			},
			Reserve = 1,
			RicherRecipe = true,
		}
		wakaba.CatalogItems["FF_PAJAMA"] = {
			Weight = 1,
			Items = {
				FiendFolio.ITEM.COLLECTIBLE.HYPNO_RING,
				FiendFolio.ITEM.COLLECTIBLE.SMASH_TROPHY,
			},
			Reserve = 3,
			RicherRecipe = true,
		}
		wakaba.CatalogItems["FF_FIREMANIAC"] = {
			Weight = 1,
			Items = {
				FiendFolio.ITEM.COLLECTIBLE.WHITE_PEPPER,
				CollectibleType.COLLECTIBLE_GHOST_PEPPER,
				CollectibleType.COLLECTIBLE_BIRDS_EYE,
			},
			Reserve = 1,
			RicherRecipe = true,
		}
 ]]
		ffReplaced = true
	end
end)
