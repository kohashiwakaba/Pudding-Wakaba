
local isc = require("wakaba_src.libs.isaacscript-common")

local turnover_layouts = include("wakaba_src.compat.epiphany.turnover_layouts")
local turnover_pools = include("wakaba_src.compat.epiphany.turnover_pools")

-- INITIALIZE EPIPHANY MENU CHARACTER
function wakaba:Epiphany_AddTarnishedDatas()
	-- DO NOT RUN IF THE API IS NOT LOADED
	if Epiphany and Epiphany.API then
		local Mod = Epiphany
		local api = Mod.API
		local KEEPER = Mod.Character.KEEPER

		if not ffReplaced then

			-- Cache unlock check
			-- Wakaba Duality is considered as the last item from Pudding & Wakaba, which is fixed between updates.
			Mod.UnlockChecker:AddModdedItems("wakaba", wakaba.Enums.Collectibles.WAKABAS_BLESSING, wakaba.Enums.Collectibles.WAKABA_DUALITY, function(item_id)
				-- Pudding & Wakaba double checks item unlocks : at the starting of each run, and item pool's GetCollectibles function.
				return wakaba:IsCompletionItemUnlockedTemp(item_id)
			end)
			Mod:AddExtraCallback(Mod.ExtraCallbacks.PRE_UNLOCK_CACHE, function(cardUnlocks)
				for _, card in pairs(wakaba.Enums.Cards) do
					cardUnlocks.Cards[card] = wakaba:IsCompletionItemUnlockedTemp(card, "card")
				end
			end)

			-- TR characters for Pudding & Wakaba not available yet, just for reserve
			api.AddCharacter({
				charName = "WAKABA", --Internal character name (REQUIRED)
				charID = wakaba.Enums.Players.WAKABA_T, -- Character ID (REQUIRED)
				charStats = wakaba.playerstats.WAKABA_T, -- Stat array
				costume = "gfx/characters/character_wakaba_t.anm2", -- Main costume (REQUIRED)
				--extraCostume = {Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_t_extra.anm2")}, -- Extra costume (e.g. Maggy's Hair)
				menuGraphics = "gfx/ui/wakaba_epiphany_menu_wakaba.anm2", -- Character menu graphics (portrait, text) (REQUIRED)
				coopMenuSprite = "gfx/ui/wakaba_epiphany_coop_wakaba.anm2", -- Co-op menu icon (REQUIRED)
				pocketItem = CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE, -- Pocket active
				pocketItemPersistent = true, -- Should the pocket active always be re-given when not present? (false is vanilla behaviour)
				unlockChecker = function()
					--return wakaba.state.unlock.trwakaba
					return false
				end, -- function that returns whether the character is unlocked. Defaults to always returning true.
				floorTutorial = "gfx/ui/wakaba/tutorial_placeholder.anm2"
			})
			api.AddCharacter({
				charName = "SHIORI", --Internal character name (REQUIRED)
				charID = wakaba.Enums.Players.SHIORI_T, -- Character ID (REQUIRED)
				charStats = wakaba.playerstats.SHIORI_T, -- Stat array
				costume = "gfx/characters/character_shiori_t.anm2", -- Main costume (REQUIRED)
				--extraCostume = {Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_t_extra.anm2")}, -- Extra costume (e.g. Maggy's Hair)
				menuGraphics = "gfx/ui/wakaba_epiphany_menu_shiori.anm2", -- Character menu graphics (portrait, text) (REQUIRED)
				coopMenuSprite = "gfx/ui/wakaba_epiphany_coop_shiori.anm2", -- Co-op menu icon (REQUIRED)
				pocketItem = CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE, -- Pocket active
				pocketItemPersistent = true, -- Should the pocket active always be re-given when not present? (false is vanilla behaviour)
				unlockChecker = function()
					--return wakaba.state.unlock.trwakaba
					return false
				end, -- function that returns whether the character is unlocked. Defaults to always returning true.
				floorTutorial = "gfx/ui/wakaba/tutorial_placeholder.anm2"
			})
			api.AddCharacter({
				charName = "TSUKASA", --Internal character name (REQUIRED)
				charID = wakaba.Enums.Players.TSUKASA_T, -- Character ID (REQUIRED)
				charStats = wakaba.playerstats.TSUKASA_T, -- Stat array
				costume = "gfx/characters/character_tsukasa_t.anm2", -- Main costume (REQUIRED)
				--extraCostume = {Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_t_extra.anm2")}, -- Extra costume (e.g. Maggy's Hair)
				menuGraphics = "gfx/ui/wakaba_epiphany_menu_tsukasa.anm2", -- Character menu graphics (portrait, text) (REQUIRED)
				coopMenuSprite = "gfx/ui/wakaba_epiphany_coop_tsukasa.anm2", -- Co-op menu icon (REQUIRED)
				pocketItem = CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE, -- Pocket active
				pocketItemPersistent = true, -- Should the pocket active always be re-given when not present? (false is vanilla behaviour)
				unlockChecker = function()
					--return wakaba.state.unlock.trwakaba
					return false
				end, -- function that returns whether the character is unlocked. Defaults to always returning true.
				floorTutorial = "gfx/ui/wakaba/tutorial_placeholder.anm2"
			})
			api.AddCharacter({
				charName = "RICHER", --Internal character name (REQUIRED)
				charID = wakaba.Enums.Players.RICHER_T, -- Character ID (REQUIRED)
				charStats = wakaba.playerstats.RICHER_T, -- Stat array
				costume = "gfx/characters/character_richer_t.anm2", -- Main costume (REQUIRED)
				--extraCostume = {Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_t_extra.anm2")}, -- Extra costume (e.g. Maggy's Hair)
				menuGraphics = "gfx/ui/wakaba_epiphany_menu_richer.anm2", -- Character menu graphics (portrait, text) (REQUIRED)
				coopMenuSprite = "gfx/ui/wakaba_epiphany_coop_richer.anm2", -- Co-op menu icon (REQUIRED)
				pocketItem = CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE, -- Pocket active
				pocketItemPersistent = true, -- Should the pocket active always be re-given when not present? (false is vanilla behaviour)
				unlockChecker = function()
					--return wakaba.state.unlock.trwakaba
					return false
				end, -- function that returns whether the character is unlocked. Defaults to always returning true.
				floorTutorial = "gfx/ui/wakaba/tutorial_placeholder.anm2"
			})
	--[[
			api.AddCharacter({
				charName = "RIRA", --Internal character name (REQUIRED)
				charID = wakaba.Enums.Players.RIRA_T, -- Character ID (REQUIRED)
				charStats = wakaba.playerstats.RIRA_T, -- Stat array
				costume = "gfx/characters/character_rira_t.anm2", -- Main costume (REQUIRED)
				--extraCostume = {Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_t_extra.anm2")}, -- Extra costume (e.g. Maggy's Hair)
				menuGraphics = "gfx/ui/wakaba/menu_placeholder.anm2", -- Character menu graphics (portrait, text) (REQUIRED)
				coopMenuSprite = "gfx/ui/wakaba/coop_menu_placeholder.anm2", -- Co-op menu icon (REQUIRED)
				pocketItem = CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE, -- Pocket active
				pocketItemPersistent = true, -- Should the pocket active always be re-given when not present? (false is vanilla behaviour)
				unlockChecker = function()
					--return wakaba.state.unlock.trwakaba
					return false
				end, -- function that returns whether the character is unlocked. Defaults to always returning true.
				floorTutorial = "gfx/ui/wakaba/tutorial_placeholder.anm2"
			})
			]]

			wakaba:Epiphany_AddThrowingBagSynergies()

			-- prevents "item pool does not exist" warning
			Mod.CustomItemPools.RicherShopPool_Treasure = {} -- Richer's Planetarium shop - Odd floors
			Mod.CustomItemPools.RicherShopPool_Planetarium = {} -- Richer's Planetarium shop - Even floors
			Mod.CustomItemPools.RicherShopPool_Secret = {} -- Richer's Planetarium shop - Hush floor
			Mod.CustomItemPools.RicherShopPool_Devil = {} -- Richer's Planetarium shop - Sheol
			Mod.CustomItemPools.RicherShopPool_Angel = {} -- Richer's Planetarium shop - Cathedral
			Mod.CardGroups.RicherTicket = {} -- Pudding & Wakaba cards for Epiphany card group
			Mod.SlotGroups.CrystalRestock = {} -- Crystal Restocks for Turnover

			-- Epiphany Turnover Shop pools
			api:AddItemsToCustomPool("VaultShop", {
				wakaba.Enums.Collectibles.SECRET_CARD,
			})
			api:AddItemsToCustomPool("DiceShop", {
				wakaba.Enums.Collectibles.SECRET_CARD,
			})
			api:AddItemsToCustomPool("BedroomShop", {
				wakaba.Enums.Collectibles.SECRET_CARD,
			})
			api:AddItemsToCustomPool("SacRoomShop", {
				wakaba.Enums.Collectibles.SECRET_CARD,
			})

			-- Epiphany Beggar/slots pools
			api:AddItemsToCustomPool("PainPool", {
				wakaba.Enums.Collectibles.BOOK_OF_TRAUMA,
			})
			api:AddItemsToCustomPool("ConverterBeggarPool", {
				wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN,
				{wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, Weight = 0.1},
			})
			api:AddItemsToCustomPool("GlitchSlotPool", {
				{wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, Weight = 0.1},
			})

			-- Epiphany Surprise box Won items pools
			api:AddItemsToCustomPool("SurpriseBox_Heart", {
				wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN,
				{wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER, Weight = 0.1},
				{wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, Weight = 0.1},
			})
			api:AddItemsToCustomPool("SurpriseBox_Coin", {
				wakaba.Enums.Collectibles.SECRET_CARD,
			})
			api:AddItemsToCustomPool("SurpriseBox_Bomb", {
				wakaba.Enums.Collectibles.BOOK_OF_TRAUMA,
				wakaba.Enums.Collectibles.POW_BLOCK,
				wakaba.Enums.Collectibles.MOD_BLOCK,
				{wakaba.Enums.Collectibles.POWER_BOMB, Weight = 0.5},
				{wakaba.Enums.Collectibles.NEW_YEAR_EVE_BOMB, Weight = 0.5},
			})
			api:AddItemsToCustomPool("SurpriseBox_Battery", {
				{wakaba.Enums.Collectibles.RABBIT_RIBBON, Weight = 0.2},
				{wakaba.Enums.Collectibles.LIL_RICHER, Weight = 0.4},
			})
			api:AddItemsToCustomPool("SurpriseBox_Pill", {
				wakaba.Enums.Collectibles.BEETLEJUICE,
				wakaba.Enums.Collectibles.ANTI_BALANCE,
			})

			api:AddSlotsToSlotGroup("Slots", wakaba.Enums.Slots.SHIORI_VALUT)

			api:AddSlotsToSlotGroup("CrystalRestock", wakaba.Enums.Slots.CRYSTAL_RESTOCK)

			api:AddCardsToCardGroup("Tarot", {
				[wakaba.Enums.Cards.CARD_CRANE_CARD] = 1,
				[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = 1,
				[wakaba.Enums.Cards.CARD_VALUT_RIFT] = 1,
				[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = 1,
				[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = 1,
				[wakaba.Enums.Cards.CARD_TRIAL_STEW] = 1,
			})

			api:AddCardsToCardGroup("Suit", {
				[wakaba.Enums.Cards.CARD_BLACK_JOKER] = 1,
				[wakaba.Enums.Cards.CARD_WHITE_JOKER] = 1,
				[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = 1,
				[wakaba.Enums.Cards.CARD_COLOR_JOKER] = 1,
			})

			api:AddCardsToCardGroup("Soul", {
				[wakaba.Enums.Cards.SOUL_SHIORI] = 1,
				[wakaba.Enums.Cards.SOUL_WAKABA] = 1,
				[wakaba.Enums.Cards.SOUL_WAKABA2] = 1,
				[wakaba.Enums.Cards.SOUL_TSUKASA] = 0.5,
			})

			api:AddCardsToCardGroup("Holy", {
				[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = 1,
				[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = 1,
				[wakaba.Enums.Cards.CARD_DREAM_CARD] = 1,
			})

			api:AddCardsToCardGroup("DiceCapsule", {
				[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = 0.05,
			})

			api:AddCardsToCardGroup("Object", {
				[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = 0.2,
			})

			api:AddCardsToCardGroup("RicherTicket", {
				[wakaba.Enums.Cards.CARD_CRANE_CARD] = 1,
				[wakaba.Enums.Cards.CARD_BLACK_JOKER] = 1,
				[wakaba.Enums.Cards.CARD_COLOR_JOKER] = 1,
				[wakaba.Enums.Cards.CARD_WHITE_JOKER] = 1,
				[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = 1,
				[wakaba.Enums.Cards.CARD_DREAM_CARD] = 0.5,
				[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = 1,
				[wakaba.Enums.Cards.CARD_TRIAL_STEW] = 1,
				[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = 1,
				[wakaba.Enums.Cards.CARD_VALUT_RIFT] = 0.2,
				[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = 0.2,
			})

			-- Blacklist items to check within Use Item func, will be used inside same use function instead
			api:BlacklistGoldActive(wakaba.Enums.Collectibles.D6_CHAOS)
			api:BlacklistGoldActive(wakaba.Enums.Collectibles.BOOK_OF_TRAUMA)
			api:BlacklistGoldActive(wakaba.Enums.Collectibles.RICHERS_FLIPPER)
			api:BlacklistGoldActive(wakaba.Enums.Collectibles._3D_PRINTER)
			api:BlacklistGoldActive(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)
			api:BlacklistGoldActive(wakaba.Enums.Collectibles.BALANCE)
			api:BlacklistGoldActive(wakaba.Enums.Collectibles.BEETLEJUICE)

			-- Whitelist Keeper pickups
			wakaba:DictionaryBulkAppend(KEEPER.DisallowedPickUpVariants[100], {
				[wakaba.Enums.Collectibles.SECRET_CARD] = 1,
			})
			wakaba:DictionaryBulkAppend(KEEPER.DisallowedPickUpVariants[350], {
				[wakaba.Enums.Trinkets.BRING_ME_THERE] = 1,
				[wakaba.Enums.Trinkets.BITCOIN] = 1,
			})
			wakaba:DictionaryBulkAppend(KEEPER.DisallowedPickUpVariants, {
				[wakaba.Enums.Pickups.CLOVER_CHEST] = 0,
			})

			--#region Multitool
			local multitool = Mod.Pickup.MULTITOOL.ChestOpenFunctions

			wakaba:DictionaryBulkAppend(multitool, {
				[wakaba.Enums.Pickups.CLOVER_CHEST] = function (chest)

				end,
			})

			--#endregion

			local ShopItemType = Mod.Item.TURNOVER.ShopItemType
			local Get = Mod.PickupGetter
			local Groups = Mod.GROUP_ENUM
			local extraSlotLayout_WinterAlbireo = {
				[-1] = { Vector(80, 0), ShopItemType.Slot , Get.MakeSlotGetter({ "CrystalRestock" }) }, -- default crystal restock position
				[41007] = { Vector(80, 0), ShopItemType.Slot , Get.MakeSlotGetter({ "CrystalRestock" }) }, -- Rira level
				[41009] = { Vector(320, 240), ShopItemType.Slot , Get.MakeSlotGetter({ "CrystalRestock" }) }, -- center position
				[41010] = { Vector(400, 0), ShopItemType.Slot , Get.MakeSlotGetter({ "CrystalRestock" }) }, -- right position
				[41011] = { Vector(400, 0), ShopItemType.Slot , Get.MakeSlotGetter({ "CrystalRestock" }) }, -- right position
				[41017] = { Vector(320, 80), ShopItemType.Slot , Get.MakeSlotGetter({ "CrystalRestock" }) }, -- center position
				[41026] = { Vector(400, 0), ShopItemType.Slot , Get.MakeSlotGetter({ "CrystalRestock" }) }, -- right position
			}

			function Get.GetWinterAlbireoTreasureItem(_, rng)
				return Get.GetItem("RicherShopPool_Treasure", rng)
			end
			function Get.GetWinterAlbireoPlanetariumItem(_, rng)
				return Get.GetItem("RicherShopPool_Planetarium", rng)
			end
			function Get.GetWinterAlbireoSecretItem(_, rng)
				return Get.GetItem("RicherShopPool_Secret", rng)
			end
			function Get.GetWinterAlbireoDevilItem(_, rng)
				return Get.GetItem("RicherShopPool_Devil", rng)
			end
			function Get.GetWinterAlbireoAngelItem(_, rng)
				return Get.GetItem("RicherShopPool_Angel", rng)
			end

			api:AddTurnoverShop({
				Name = "WINTER_ALBIREO_TREASURE",
				Checker = function()
					return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_PLANETARIUM
				end,
				ShopLayout = turnover_layouts["WINTER_ALBIREO_TREASURE"],
				PickupPool = turnover_pools["WINTER_ALBIREO_TREASURE"],
			})

			api:AddTurnoverShop({
				Name = "WINTER_ALBIREO_PLANETARIUM",
				Checker = function()
					return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_PLANETARIUM
				end,
				ShopLayout = turnover_layouts["WINTER_ALBIREO_PLANETARIUM"],
				PickupPool = turnover_pools["WINTER_ALBIREO_PLANETARIUM"],
			})

			api:AddTurnoverShop({
				Name = "WINTER_ALBIREO_SECRET",
				Checker = function()
					return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_SECRET
				end,
				ShopLayout = turnover_layouts["WINTER_ALBIREO_SECRET"],
				PickupPool = turnover_pools["WINTER_ALBIREO_SECRET"],
			})

			api:AddTurnoverShop({
				Name = "WINTER_ALBIREO_DEVIL",
				Checker = function()
					return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_DEVIL
				end,
				ShopLayout = turnover_layouts["WINTER_ALBIREO_DEVIL"],
				PickupPool = turnover_pools["WINTER_ALBIREO_DEVIL"],
			})

			api:AddTurnoverShop({
				Name = "WINTER_ALBIREO_ANGEL",
				Checker = function()
					return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_ANGEL
				end,
				ShopLayout = turnover_layouts["WINTER_ALBIREO_ANGEL"],
				PickupPool = turnover_pools["WINTER_ALBIREO_ANGEL"],
			})
			local TURNOVER = Mod.Item.TURNOVER
			TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WINTER_ALBIREO_TREASURE] = "Planetarium0"
			TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WINTER_ALBIREO_PLANETARIUM] = "Planetarium0"
			TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WINTER_ALBIREO_SECRET] = "Planetarium0"
			TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WINTER_ALBIREO_DEVIL] = "Planetarium0"
			TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WINTER_ALBIREO_ANGEL] = "Planetarium0"

			Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
				if wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) and Game():GetRoom():IsFirstVisit() and IsPlayerPresent(Mod.PlayerType["KEEPER"]) then
					for _, ent in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
						local pickup = ent:ToPickup()
						pickup.ShopItemId = -1
						pickup.Price = 20
					end
				end
			end)

			local function Turnover_WinterAlbireoSlots(layout, tier, room)
				local roomDesc = Game():GetLevel():GetCurrentRoomDesc()
				if wakaba:IsValidWakabaRoom(roomDesc, wakaba.RoomTypes.WINTER_ALBIREO) then
					local extra = extraSlotLayout_WinterAlbireo[roomDesc.Variant] or extraSlotLayout_WinterAlbireo[-1]
					layout[#layout + 1] = extra
				end
				return layout
			end
			Epiphany:AddExtraCallback(Epiphany.ExtraCallbacks.TURNOVER_GET_LAYOUT_INFO, Turnover_WinterAlbireoSlots)

			local function Turnover_WinterAlbireoCoins(pool, tier, _)
				local roomDesc = Game():GetLevel():GetCurrentRoomDesc()
				if wakaba:IsValidWakabaRoom(roomDesc, wakaba.RoomTypes.WINTER_ALBIREO) and wakaba.state.unlock.easteregg then
					pool[#pool + 1] = {{ PickupVariant.PICKUP_COIN, wakaba.Enums.Coins.EASTER_EGG,}, Weight = 10e9, WeightDecreaseFactor = 0}
					pool[#pool + 1] = {{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter({"RicherTicket"}), 		minTier = 1, maxTier = 5 }}
					return pool
				end
			end
			Epiphany:AddExtraCallback(Epiphany.ExtraCallbacks.TURNOVER_GET_PICKUP_POOL, Turnover_WinterAlbireoCoins)











			-- Golden Item descriptions for EID
			if EID then
				EID:addDescriptionModifier("Wakaba_Epiphany Golden Actives", function(descObj)
					return descObj.ObjType == 5
					and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE
					and descObj.ObjSubType > 0
					and wakaba:isActiveItem(descObj.ObjSubType)
					and wakaba:IsGoldenItem(descObj.ObjSubType)
				end, function(descObj)
					local wakabaBuff = wakaba:getWakabaDesc("epiphany_golden", descObj.ObjSubType)
					if wakabaBuff then
						local desc = wakabaBuff.description
						if wakabaBuff.isReplace then
							descObj.Description = desc
						else
							EID:appendToDescription(descObj, "#".. desc .. "{{CR}}")
						end
					end
					return descObj
				end)
			end
			ffReplaced = true
		end

	--[[
		api:AddTurnoverShop({
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

function wakaba:IsGoldenItem(itemID)
	if not (Epiphany and Epiphany.API) then return false end
	return Epiphany.Pickup.GOLDEN_ITEM:IsGoldenItem(itemID)
end

















wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.Epiphany_AddTarnishedDatas)