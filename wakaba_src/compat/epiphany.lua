
local isc = require("wakaba_src.libs.isaacscript-common")

-- INITIALIZE EPIPHANY MENU CHARACTER
function wakaba:Epiphany_AddTarnishedDatas()
	-- DO NOT RUN IF THE API IS NOT LOADED
	if Epiphany and Epiphany.API then
		
		--[[ 
		-- Was trying to add TR Wakaba, but no time sadly
		Epiphany.API.AddCharacter({
			charName = "WakabaT", --Internal character name (REQUIRED)
			charID = wakaba.Enums.Players.WAKABA_T, -- Character ID (REQUIRED)
			charStats = wakaba.playerstats.WAKABA_T, -- Stat array
			costume = "gfx/characters/character_wakaba_t.anm2", -- Main costume (REQUIRED)
			--extraCostume = {Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_t_extra.anm2")}, -- Extra costume (e.g. Maggy's Hair)
			menuGraphics = "gfx/ui/menu_wakaba.anm2", -- Character menu graphics (portrait, text) (REQUIRED)
			coopMenuSprite = "gfx/ui/Coop/coop_menu_wakaba.anm2", -- Co-op menu icon (REQUIRED)
			pocketItem = CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE, -- Pocket active
			pocketItemPersistent = true, -- Should the pocket active always be re-given when not present? (false is vanilla behaviour)
			unlockChecker = function() 
				--return wakaba.state.unlock.trwakaba
				return true 
			end, -- function that returns whether the character is unlocked. Defaults to always returning true.
			floorTutorial = "gfx/grid/tutorial_wakaba.anm2"
		})
	 ]]
		wakaba:Epiphany_AddThrowingBagSynergies()

		Epiphany.API:AddSlotsToSlotGroup("Slots", wakaba.Enums.Slots.SHIORI_VALUT)
		Epiphany.API:AddSlotsToSlotGroup("ArcadeBeggars", wakaba.Enums.Slots.SHIORI_VALUT)

		Epiphany.API:AddCardsToCardGroup("NormalCard", {
			[wakaba.Enums.Cards.CARD_CRANE_CARD] = 1,
			[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = 1,
			[wakaba.Enums.Cards.CARD_VALUT_RIFT] = 1,
			[wakaba.Enums.Cards.CARD_TRIAL_STEW] = 1,
		})

		Epiphany.API:AddCardsToCardGroup("PlayingCard", {
			[wakaba.Enums.Cards.CARD_BLACK_JOKER] = 1,
			[wakaba.Enums.Cards.CARD_WHITE_JOKER] = 1,
			[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = 1,
			[wakaba.Enums.Cards.CARD_COLOR_JOKER] = 1,
		})

		Epiphany.API:AddCardsToCardGroup("Soul", {
			[wakaba.Enums.Cards.SOUL_SHIORI] = 1,
			[wakaba.Enums.Cards.SOUL_WAKABA] = 1,
			[wakaba.Enums.Cards.SOUL_WAKABA2] = 1,
			[wakaba.Enums.Cards.SOUL_TSUKASA] = 0.5,
		})

		Epiphany.API:AddCardsToCardGroup("Holy", {
			[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = 1,
			[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = 1,
			[wakaba.Enums.Cards.CARD_DREAM_CARD] = 1,
		})

		Epiphany.API:AddCardsToCardGroup("DiceCapsules", {
			[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = 0.2,
		})
	--[[ 
		Epiphany.API:AddTurnoverShop({
			Name = "WAKABA_TURNOVER",		 -- shop name, is used internally
			Checker = function ()			-- takes 0 arguments, return true if this shop pool should be used
				return isc:anyPlayerIs(wakaba.Enums.Players.WAKABA)
			end,
			{
				--ShopKeeperPosition = Vector(320,180), -- optional, defaults to Vector(320, 200)
				SetUpPrice = 35,											-- optional, defaults to 10

				-- tables at numeric indexes starting from 0 are shop tiers
				-- it's possible to have any amount of shop tiers, as long as their indexes are sequential
				[0] =
				{
					SetUpPrice = 5, -- optional, overrides SetUpPrice in outer scope

					-- first index is always position, second is the item type
					-- pickups are chosen from PickupPool table
					{Vector(280, 320), ShopItemType.Pickup},

					-- collectibles are picked from current room's item pool
					-- unless a getter function is specified at index [3]
					{Vector(360, 320), ShopItemType.Collectible},
					{Vector(360, 360), ShopItemType.Collectible, function (itemPoolType, rng)
						local itemID = rng:RandomInt(CollectibleType.NUM_COLLECTIBLES) + 1
						return itemID
					end},

					-- slots are picked from Slots SlotGroup
					-- unless a getter function is specified at index [3]
					{Vector(360, 400), ShopItemType.Slot},
					{Vector(360, 440), ShopItemType.Slot, function (rng)
						local slotID = rng:RandomInt(9) + 1
						return slotID
					end},

					-- restock machine only spawns if turnover is used by TR Keeper with Birthright
					{Vector(360, 400), ShopItemType.RestockMachine}
				},
				[1] =
				{
					-- ...
				},
				-- PICKUP POOL ENTRY INFO
				-- [1] =
				-- {
				--		[1]				- Pickup variant
				--		[2]				- Pickup subtype
				--										 * may be an int or a function
				--									* that takes 0 arguments and returns the subtype
				--
				--		minTier - Lowest tier at which a pickup can appear
				--		maxTier - Highest tier at which a pickup can appear
				-- },
				-- Weight	- Pickup's weight
				--								* Higher weight pickups are more likely to spawn
				--								* Pickup's weight is reduced by 4 times for the current shop tier when it spawns
				--
				-- Pickup variant/subtype are required
				-- minTier, maxTier are optional, checks for them pass by default
				-- Weight is optional and defaults to 1.0
				PickupPool =
				{			
					{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL,																	 minTier = 0, maxTier = 3 }},
					{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK,														 minTier = 2, maxTier = 4 }},
					{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA,																		 minTier = 2, maxTier = 4 },	Weight = 0.06},
					{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN,																	 minTier = 2, maxTier = 4 },	Weight = 0.03},
					{{ PickupVariant.PICKUP_KEY,	KeySubType.KEY_NORMAL,																	minTier = 0, maxTier = 3 }},
				}
			}
		})
	 ]]	 
		wakaba:RemoveCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.Epiphany_AddTarnishedDatas)
	end
	if LibraryExpanded then
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID0, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID1, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID2, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID3, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID4, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.KINDLING_BOOK.ID2, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.ELECTROMAGNETISM_EXPLAINED.ID, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.CURSED_BOOK.ID, wakaba.bookstate.BOOKSHELF_SHIORI)
		--wakaba:BlacklistBook(LibraryExpanded.Item.CERTIFICATE.ID, wakaba.bookstate.BOOKSHELF_SHIORI)

		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID0, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID1, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID2, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID3, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID4, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		wakaba:BlacklistBook(LibraryExpanded.Item.KINDLING_BOOK.ID2, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID0, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID1, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID2, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID3, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID4, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(LibraryExpanded.Item.KINDLING_BOOK.ID2, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(LibraryExpanded.Item.ELECTROMAGNETISM_EXPLAINED.ID, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		wakaba:BlacklistBook(LibraryExpanded.Item.CURSED_BOOK.ID, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		--wakaba:BlacklistBook(LibraryExpanded.Item.CERTIFICATE.ID, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID0, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID1, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID2, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID3, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.BLANK_BOOK.ID4, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.KINDLING_BOOK.ID2, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.ELECTROMAGNETISM_EXPLAINED.ID, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		wakaba:BlacklistBook(LibraryExpanded.Item.CURSED_BOOK.ID, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
		--wakaba:BlacklistBook(LibraryExpanded.Item.CERTIFICATE.ID, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
	end
end

function wakaba:Epiphany_AddThrowingBagSynergies()
end


















wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.Epiphany_AddTarnishedDatas)