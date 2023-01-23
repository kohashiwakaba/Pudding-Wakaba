local ffReplaced = false
function wakaba:GameStart_FiendFolioCompat()
	if FiendFolio and not ffReplaced then
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
		wakaba:addSilenceTarget("FF_Fire", 1000, 7005)
		wakaba:addSilenceTarget("FF_Spider", 85, 962)
		wakaba:addSilenceTarget("FF_Bubble", 150, 1)
		wakaba:addSilenceTarget("FF_Stinger", 150, 6)
		wakaba:addSilenceTarget("FF_Spore", 150, 15)

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