local ffReplaced = false
function wakaba:GameStart_FiendFolioCompat()
	if FiendFolio and not ffReplaced then
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
		table.insert(FiendFolio.ReferenceItems.Trinkets, {ID = wakaba.Enums.Trinkets.KUROMI_CARD, Reference = "Onegai My Melody"})
		
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

end