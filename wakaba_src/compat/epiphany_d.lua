
local isc = _wakaba.isc

local throwingBagSynergyLinks = {
	["book_bagged"] = {
		wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN,
		wakaba.Enums.Collectibles.BOOK_OF_SILENCE,
		wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN,
		wakaba.Enums.Collectibles.BOOK_OF_TRAUMA,
		wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER,
		wakaba.Enums.Collectibles.ISEKAI_DEFINITION,
		wakaba.Enums.Collectibles.MICRO_DOPPELGANGER,
		wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY,
	},
	["angel_bagged"] = {
		wakaba.Enums.Collectibles.WAKABAS_BLESSING,
		wakaba.Enums.Collectibles.MINERVA_AURA,
	},
	["devil_bagged"] = {
		wakaba.Enums.Collectibles.WAKABAS_NEMESIS,
	},
	["boss_bagged"] = {
		wakaba.Enums.Collectibles.WAKABAS_NEMESIS,
		wakaba.Enums.Collectibles.NEKO_FIGURE,
		wakaba.Enums.Collectibles.D_CUP_ICECREAM,
		wakaba.Enums.Collectibles.EXECUTIONER,
		wakaba.Enums.Collectibles.NEW_YEAR_BOMB,
		wakaba.Enums.Collectibles.BOOK_OF_FOCUS,
		wakaba.Enums.Collectibles.ADVANCED_CRYSTAL,
	},
	["generic_milk_bagged"] = {
		wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD,
	},
	["charm_bagged"] = {
		wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD,
		wakaba.Enums.Collectibles.RETURN_POSTAGE,
		wakaba.Enums.Collectibles.BOOK_OF_CONQUEST,
		wakaba.Enums.Collectibles.RICHERS_UNIFORM,
	},
	["luck_bagged"] = {
		wakaba.Enums.Collectibles.WAKABAS_PENDANT,
	},
	["flies_bagged"] = {
		wakaba.Enums.Collectibles.PLUMY,
	},
	["golden_bagged"] = {
		wakaba.Enums.Collectibles.SECRET_CARD,
	},
	["brimstone_bagged"] = {
		wakaba.Enums.Collectibles.REVENGE_FRUIT,
		wakaba.Enums.Collectibles.LIL_MAO,
	},
	["death_certificate_bagged"] = {
		wakaba.Enums.Collectibles.EATHEART,
		wakaba.Enums.Collectibles.DOUBLE_DREAMS,
	},
	--[[ ["dice_bagged"] = {
		wakaba.Enums.Collectibles.D6_PLUS,
		wakaba.Enums.Collectibles.D6_CHAOS,
	}, ]]
	["explorer_bagged"] = {
		wakaba.Enums.Collectibles.RED_CORRUPTION,
	},
	["medical_bagged"] = {
		wakaba.Enums.Collectibles.BOOK_OF_CONQUEST,
		wakaba.Enums.Collectibles.MINERVA_AURA,
	},
	["bone_bagged"] = {
		wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN,
	},
	["mystic_bagged"] = {
		wakaba.Enums.Collectibles.UNIFORM,
		wakaba.Enums.Collectibles.BOTTLE_OF_RUNES,
		wakaba.Enums.Collectibles.LUNAR_STONE,
		wakaba.Enums.Collectibles.WATER_FLAME,
	},
	["techx_bagged"] = {
		wakaba.Enums.Collectibles.EYE_OF_CLOCK,
		wakaba.Enums.Collectibles.LIL_WAKABA,
		wakaba.Enums.Collectibles.COUNTER,
	},
	["lost_contact_bagged"] = {
		wakaba.Enums.Collectibles.COUNTER,
		wakaba.Enums.Collectibles.BOOK_OF_SILENCE,
	},
	["fruitcake_bagged"] = {
		wakaba.Enums.Collectibles.LIL_MOE,
		wakaba.Enums.Collectibles.SWEETS_CATALOG,
		wakaba.Enums.Collectibles.RIRAS_BRA,
	},
	["playdoughcookie_bagged"] = {
		wakaba.Enums.Collectibles.LIL_MOE,
		wakaba.Enums.Collectibles.SWEETS_CATALOG,
		wakaba.Enums.Collectibles.RIRAS_BRA,
	},
	["damocles_bagged"] = {
		wakaba.Enums.Collectibles.VINTAGE_THREAT,
	},
	["godhead_bagged"] = {
		wakaba.Enums.Collectibles.BOOK_OF_THE_GOD,
		wakaba.Enums.Collectibles.MYSTIC_CRYSTAL,
	},
	["devil_bagged"] = {
		wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN,
	},
	["purgatory_bagged"] = {
		wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN,
	},
	["homing_bagged"] = {
		wakaba.Enums.Collectibles.MINERVA_AURA,
		wakaba.Enums.Collectibles.ARCANE_CRYSTAL,
		wakaba.Enums.Collectibles.PRESTIGE_PASS,
	},
	["lachryphagy_bagged"] = {
		wakaba.Enums.Collectibles.LIL_SHIVA,
	},
	["guppy_bagged"] = {
		wakaba.Enums.Collectibles.NEKO_FIGURE,
	},
	["blackhole_bagged"] = {
		wakaba.Enums.Collectibles.WINTER_ALBIREO,
	},
	["glitched_bagged"] = {
		wakaba.Enums.Collectibles.D6_CHAOS,
	},
	["echo_chamber_bagged"] = {
		wakaba.Enums.Collectibles.DEJA_VU,
	},
	["tool_bagged"] = {
		wakaba.Enums.Collectibles.BALANCE,
	},
	["lunch_bagged"] = {
		wakaba.Enums.Collectibles.MOE_MUFFIN,
	},
	["battery_bagged"] = {
		wakaba.Enums.Collectibles.CONCENTRATION,
		wakaba.Enums.Collectibles.RABBIT_RIBBON,
	},
	["drug_bagged"] = {
		wakaba.Enums.Collectibles.BEETLEJUICE,
		wakaba.Enums.Collectibles.ANTI_BALANCE,
	},
	["fire_bagged"] = {
		wakaba.Enums.Collectibles.MAGMA_BLADE,
		wakaba.Enums.Collectibles.SELF_BURNING,
	},
	["piercing_bagged"] = {
		wakaba.Enums.Collectibles.MAGMA_BLADE,
	},
	--[[ ["sanctum_spiritus_bagged"] = {
		wakaba.Enums.Collectibles.MINERVA_AURA,
		wakaba.Enums.Collectibles.MURASAME,
	}, ]]
	["moms_knife_bagged"] = {
		wakaba.Enums.Collectibles.MURASAME,
	},
	["jacob_bagged"] = {
		wakaba.Enums.Collectibles.NASA_LOVER,
	},
	["confusion_bagged"] = {
		wakaba.Enums.Collectibles.PHANTOM_CLOAK,
	},
	["poison_bagged"] = {
		wakaba.Enums.Collectibles.LUNAR_STONE,
		wakaba.Enums.Collectibles.CLENSING_FOAM,
	},
	["fate_bagged"] = {
		wakaba.Enums.Collectibles.JAR_OF_CLOVER,
		wakaba.Enums.Collectibles.SEE_DES_BISCHOFS,
		wakaba.Enums.Collectibles.BUNNY_PARFAIT,
	},
	["bait_bagged"] = {
		wakaba.Enums.Collectibles.WATER_FLAME,
	},
	["tough_bagged"] = {
		wakaba.Enums.Collectibles.CRISIS_BOOST,
	},
	["spirit_bagged"] = {
		wakaba.Enums.Collectibles.ONSEN_TOWEL,
	},
	["paper_bagged"] = {
		wakaba.Enums.Collectibles.CUNNING_PAPER,
	},
	["curse_of_tower_bagged"] = {
		wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2,
	},
	["techzero_bagged"] = {
		wakaba.Enums.Collectibles.RICHERS_NECKLACE,
	},
}

wakaba:RegisterPatch(REPENTOGON and 0 or 1, "Epiphany_7", function() return (Epiphany and Epiphany.API ~= nil and tonumber(Epiphany.WAVE_NUMBER) >= 7) end, function()
	local Mod = Epiphany
	local api = Mod.API
	local KEEPER = Mod.Character.KEEPER

	do

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

		-- Shiori Blighted Dice
		wakaba:AddCallback(wakaba.Callback.EVALUATE_SHIORI_CHARGE, function(_, player, slot, item, keys, charge, conf, origin)
			local pData = player:GetData()
			if item == Mod.Item.BLIGHTED_DICE.ID2 and not pData.ESSENCE_FROM_BLIGHTED_DICE then
				if origin >= Epiphany.Item.BLIGHTED_DICE.MAX_CHARGE2 then
					player:AddKeys(origin)
					return true
				end
			end
		end)

--[[
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

		wakaba:BulkAppend(wakaba.CustomPool.CloverChest, {
			{Epiphany.Item.DEBUG.ID, 1.00},
			{Epiphany.Item.EMPTY_DECK.ID, 1.00},
			{Epiphany.Item.WARM_COAT.ID, 1.00},
			{Epiphany.Item.BROKEN_HALO.ID, 1.00},
			{Epiphany.Item.KINS_CURSE.ID, 1.00},
			{Epiphany.Item.COIN_CASE.ID, 1.00},
		})
		wakaba:BulkAppend(wakaba.CustomPool.ShioriValut, {
			{Epiphany.Item.D5.ID, 1.00},
			{Epiphany.Item.CHANCE_CUBE.ID, 1.00},
			{Epiphany.Item.DIVINE_REMNANTS.ID, 0.20},
		})

		-- TR Eden Blacklist
		api:AddItemsToEdenBlackList(
			-- Items that combine into single quest item
			wakaba.Enums.Collectibles.WAKABAS_BLESSING,
			wakaba.Enums.Collectibles.WAKABAS_NEMESIS,
			-- Items whose effect persists after losing them
			-- Items that just removing Blind curse are not added, it's just intended ;)
			wakaba.Enums.Collectibles.MURASAME, -- Devil/Angel chance modifier lasts entire floor
			wakaba.Enums.Collectibles.BOOK_OF_SHIORI, -- Tear effect lasts entire run unless player uses Soul of Shiori
			wakaba.Enums.Collectibles.RED_CORRUPTION, -- Compass effect lasts entire floor
			wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2, -- Golden Bomb lasts entire floor
			wakaba.Enums.Collectibles.DOUBLE_INVADER, -- Disables Devil/Angel rooms for entire floor on non-RGON
			wakaba.Enums.Collectibles.DOUBLE_DREAMS, -- Disables Devil/Angel rooms for entire floor on non-RGON
			-- Items considered too confusing on a constantly rerolling character
			wakaba.Enums.Collectibles.UNIFORM,
			wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, -- Constant health refill
			wakaba.Enums.Collectibles.QUESTION_BLOCK,
			wakaba.Enums.Collectibles.LIL_RIRA,
			wakaba.Enums.Collectibles.MAID_DUET, -- Both for glitched item and TR Eden, and TR Eden can't use this item anyways
			-- Items that can't be filled, or has no effect before they get rerolled away
			wakaba.Enums.Collectibles.EATHEART, -- Requires 7500 dmg, and can't be debugged
			wakaba.Enums.Collectibles.SECRET_CARD, -- Useless when given for 1 room
			wakaba.Enums.Collectibles.WINTER_ALBIREO, -- Useless when given for 1 room
			wakaba.Enums.Collectibles.DEJA_VU, -- Useless when given for 1 room
			wakaba.Enums.Collectibles.RIRAS_BANDAGE, -- Useless when given for 1 room
			-- Items that revive the player as another character
			wakaba.Enums.Collectibles.VINTAGE_THREAT, -- Tainted Shiori
			wakaba.Enums.Collectibles.SEE_DES_BISCHOFS, -- Tainted Tsukasa
			wakaba.Enums.Collectibles.JAR_OF_CLOVER, -- Wakaba
			wakaba.Enums.Collectibles.BUNNY_PARFAIT, -- Rira
			wakaba.Enums.Collectibles.CARAMELLA_PANCAKE, -- Richer
			-- Strong item pool modifiers
			wakaba.Enums.Collectibles.RIRAS_BENTO,
			-- Bomb modifiers
			wakaba.Enums.Collectibles.NEW_YEAR_BOMB,
			wakaba.Enums.Collectibles.CROSS_BOMB,
			wakaba.Enums.Collectibles.BUBBLE_BOMBS,
			-- Items that give soul or black hearts
			wakaba.Enums.Collectibles.ONSEN_TOWEL,
			wakaba.Enums.Collectibles.SUCCUBUS_BLANKET,
			wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM,
			-- Items considered too bad for the run as a whole
			wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN -- Must NOT lose the active
		)

		-- TR Lost Blacklist
		api:AddItemsToLostBlackList(
			wakaba.Enums.Collectibles.UNIFORM,
			wakaba.Enums.Collectibles.RICHERS_UNIFORM,
			wakaba.Enums.Collectibles.RICHERS_BRA,
			wakaba.Enums.Collectibles.BOOK_OF_SILENCE,
			wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER,
			wakaba.Enums.Collectibles.MINERVA_AURA,
			wakaba.Enums.Collectibles.CONCENTRATION,
			wakaba.Enums.Collectibles.SELF_BURNING,
			wakaba.Enums.Collectibles.WATER_FLAME,
			wakaba.Enums.Collectibles.ONSEN_TOWEL,
			wakaba.Enums.Collectibles.SECRET_DOOR,
			wakaba.Enums.Collectibles.RIRAS_COAT,
			wakaba.Enums.Collectibles.RIRAS_BENTO,
			wakaba.Enums.Collectibles.RIRAS_UNIFORM,
			wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, -- Constant health refill
			wakaba.Enums.Collectibles.FLASH_SHIFT,
			wakaba.Enums.Collectibles.VINTAGE_THREAT, -- Tainted Shiori
			wakaba.Enums.Collectibles.SEE_DES_BISCHOFS, -- Tainted Tsukasa
			wakaba.Enums.Collectibles.JAR_OF_CLOVER, -- Wakaba
			wakaba.Enums.Collectibles.BUNNY_PARFAIT, -- Rira
			wakaba.Enums.Collectibles.CARAMELLA_PANCAKE, -- Richer
			wakaba.Enums.Collectibles.LIL_RICHER,
			wakaba.Enums.Collectibles.LIL_RIRA,
			wakaba.Enums.Collectibles.WAKABAS_BLESSING,
			wakaba.Enums.Collectibles.WAKABAS_NEMESIS
		)
		wakaba.Blacklists.InnateRevivals[Mod.PlayerType.LOST] = true

		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.ISAAC] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.MAGDALENE] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.CAIN] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.JUDAS1] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.JUDAS2] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.JUDAS] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.JUDAS4] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.JUDAS5] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.SAMSON] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.EDEN] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.LOST] = true
		wakaba.Blacklists.MaidDuetPlayers[Mod.PlayerType.KEEPER] = true

		wakaba.Blacklists.MaidDuetCharges[Mod.Item.BLIGHTED_DICE.ID] = true
		wakaba.Blacklists.MaidDuetCharges[Mod.Item.BLIGHTED_DICE.ID2] = true

		-- prevents "item pool does not exist" warning
		Mod.CustomItemPools.RicherShopPool_Treasure = {} -- Richer's Planetarium shop - Odd floors
		Mod.CustomItemPools.RicherShopPool_Planetarium = {} -- Richer's Planetarium shop - Even floors
		Mod.CustomItemPools.RicherShopPool_Secret = {} -- Richer's Planetarium shop - Hush floor
		Mod.CustomItemPools.RicherShopPool_Devil = {} -- Richer's Planetarium shop - Sheol
		Mod.CustomItemPools.RicherShopPool_Angel = {} -- Richer's Planetarium shop - Cathedral
		Mod.CardGroups.RicherTicket = {} -- Pudding & Wakaba cards for Epiphany card group
		Mod.SlotGroups.CrystalRestock = {} -- Crystal Restocks for Turnover

		-- Epiphany Turnover Shop pools
		api:AddItemsToCustomPool("VaultShop",
			{V = wakaba.Enums.Collectibles.SECRET_CARD}
		)
		api:AddItemsToCustomPool("DiceShop",
			{V = wakaba.Enums.Collectibles.SECRET_CARD}
		)
		api:AddItemsToCustomPool("BedroomShop",
			{V = wakaba.Enums.Collectibles.SECRET_CARD}
		)
		api:AddItemsToCustomPool("SacRoomShop",
			{V = wakaba.Enums.Collectibles.SECRET_CARD}
		)

		-- Epiphany Beggar/slots pools
		api:AddItemsToCustomPool("PainPool",
			{V = wakaba.Enums.Collectibles.BOOK_OF_TRAUMA},
			{V = wakaba.Enums.Collectibles.RIRAS_BANDAGE}
		)
		api:AddItemsToCustomPool("ConverterBeggarPool",
			{V = wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN},
			{V = wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, Weight = 0.1}
		)
		api:AddItemsToCustomPool("GlitchSlotPool",
			{V = wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, Weight = 0.1}
		)

		-- Epiphany Surprise box Won items pools
		api:AddItemsToCustomPool("SurpriseBox_Heart",
			{V = wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN},
			{V = wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER, Weight = 0.1},
			{V = wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, Weight = 0.1}
		)
		api:AddItemsToCustomPool("SurpriseBox_Coin",
			{V = wakaba.Enums.Collectibles.SECRET_CARD}
		)
		api:AddItemsToCustomPool("SurpriseBox_Bomb",
			{V = wakaba.Enums.Collectibles.BOOK_OF_TRAUMA},
			{V = wakaba.Enums.Collectibles.POW_BLOCK},
			{V = wakaba.Enums.Collectibles.MOD_BLOCK},
			{V = wakaba.Enums.Collectibles.POWER_BOMB, Weight = 0.5},
			{V = wakaba.Enums.Collectibles.NEW_YEAR_EVE_BOMB, Weight = 0.5}
		)
		api:AddItemsToCustomPool("SurpriseBox_Battery",
			{V = wakaba.Enums.Collectibles.RABBIT_RIBBON, Weight = 0.2},
			{V = wakaba.Enums.Collectibles.LIL_RICHER, Weight = 0.4}
		)
		api:AddItemsToCustomPool("SurpriseBox_Pill",
			{V = wakaba.Enums.Collectibles.BEETLEJUICE},
			{V = wakaba.Enums.Collectibles.ANTI_BALANCE}
		)

		api:AddSlotsToSlotGroup("Slots", {V = wakaba.Enums.Slots.SHIORI_VALUT})

		api:AddSlotsToSlotGroup("CrystalRestock", {V = wakaba.Enums.Slots.CRYSTAL_RESTOCK})

		api:AddCardsToCardGroup("Tarot",
			{V = wakaba.Enums.Cards.CARD_CRANE_CARD},
			{V = wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD},
			{V = wakaba.Enums.Cards.CARD_VALUT_RIFT},
			{V = wakaba.Enums.Cards.CARD_MINERVA_TICKET},
			{V = wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK},
			{V = wakaba.Enums.Cards.CARD_TRIAL_STEW},
			{V = wakaba.Enums.Cards.CARD_RICHER_TICKET},
			{V = wakaba.Enums.Cards.CARD_RIRA_TICKET}
		)

		api:AddCardsToCardGroup("Suit",
			{V = wakaba.Enums.Cards.CARD_BLACK_JOKER},
			{V = wakaba.Enums.Cards.CARD_WHITE_JOKER},
			{V = wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES},
			{V = wakaba.Enums.Cards.CARD_COLOR_JOKER}
		)

		api:AddCardsToCardGroup("Soul",
			{V = wakaba.Enums.Cards.SOUL_SHIORI},
			{V = wakaba.Enums.Cards.SOUL_WAKABA},
			{V = wakaba.Enums.Cards.SOUL_WAKABA2},
			{V = wakaba.Enums.Cards.SOUL_TSUKASA, Weight = 0.5},
			{V = wakaba.Enums.Cards.SOUL_RICHER, Weight = 0.5},
			{V = wakaba.Enums.Cards.SOUL_RIRA, Weight = 0.5}
		)

		api:AddCardsToCardGroup("Holy",
			{V = wakaba.Enums.Cards.CARD_MINERVA_TICKET},
			{V = wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD},
			{V = wakaba.Enums.Cards.CARD_DREAM_CARD}
		)

		api:AddCardsToCardGroup("DiceCapsule",
			{V = wakaba.Enums.Cards.CARD_RETURN_TOKEN, Weight = 0.05}
		)

		api:AddCardsToCardGroup("Object",
			{V = wakaba.Enums.Cards.CARD_RETURN_TOKEN, Weight = 0.2}
		)

		api:AddCardsToCardGroup("RicherTicket",
			{V = wakaba.Enums.Cards.CARD_CRANE_CARD},
			{V = wakaba.Enums.Cards.CARD_BLACK_JOKER},
			{V = wakaba.Enums.Cards.CARD_COLOR_JOKER},
			{V = wakaba.Enums.Cards.CARD_WHITE_JOKER},
			{V = wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD},
			{V = wakaba.Enums.Cards.CARD_DREAM_CARD, Weight = 0.5},
			{V = wakaba.Enums.Cards.CARD_MINERVA_TICKET},
			{V = wakaba.Enums.Cards.CARD_RICHER_TICKET},
			{V = wakaba.Enums.Cards.CARD_RIRA_TICKET},
			{V = wakaba.Enums.Cards.CARD_TRIAL_STEW},
			{V = wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK},
			{V = wakaba.Enums.Cards.CARD_VALUT_RIFT, Weight = 0.2},
			{V = wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES, Weight = 0.2},
			{V = wakaba.Enums.Cards.CARD_FLIP}
		)

		-- Blacklist items to check within Use Item func, will be used inside same use function instead
		api:BlacklistGoldActive(wakaba.Enums.Collectibles.SHIFTER)
		api:BlacklistGoldActive(wakaba.Enums.Collectibles.SHIFTER_PASSIVE)

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
		wakaba:DictionaryBulkAppend(KEEPER.CollectibleSpawnedPickups, {
			[wakaba.Enums.Collectibles.BEETLEJUICE] = {
				{ PickupVariant.PICKUP_PILL, 1 },
			},
		})

		--#region Multitool
		---@param chest EntityPickup
		function wakaba:UseMultitool_WakabaChests(player, chest)
			if chest.Variant == wakaba.Enums.Pickups.CLOVER_CHEST and chest.SubType > 0 and chest:GetSprite():IsPlaying("Idle") then

				chest.Touched = true
				chest:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.OPEN, false, true)
				wakaba:openCloverChest(player, chest)
				return true
			end
		end

		Mod:AddExtraCallback(Epiphany.ExtraCallbacks.PRE_MULTITOOL_OPEN_CHEST, wakaba.UseMultitool_WakabaChests)
		--#endregion
	end

	-- 임시
	do
		wakaba.__bombItems[Mod.Item.ZIP_BOMBS.ID] = 1
	end

	do
		local ShopItemType = Mod.Item.TURNOVER.ShopItemType
		local Get = Mod.PickupGetter
		local Groups = Mod.GROUP_ENUM

		--Cards
		local Rune =				 {"Rune"}
		local Soul =				 {"Soul"}
		local Holy = 				 {"Holy"}
		local Essence = 			 {"Essence"}
		--Hearts
		local HeartsAll = 			 {"Red", "Rotten","Black", "Soul","Eternal","Special","Bone", "Greedy"}
		local Red = 				 {"Red", "Rotten", "Special"}
		local Angel = 				 {"Soul", "Eternal"}
		local Devil = 				 {"Black", "Bone"}

		local turnover_layouts = {}

		turnover_layouts["WAKABA_WINTER_ALBIREO_TREASURE"] =	{
			SetUpPrice = 20,
			[0] = {
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
			},
			[1] = {
				{ Vector(240, 320), ShopItemType.Pickup },
				{ Vector(320, 320), ShopItemType.Collectible },
				{ Vector(400, 320), ShopItemType.Pickup },
			},
			[2] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[3] = {
				{ Vector(200, 320), ShopItemType.Collectible },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[4] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[5] = {
				{ Vector(240, 240), ShopItemType.Collectible },
				{ Vector(400, 240), ShopItemType.Collectible },
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
				{ Vector(450, 170), ShopItemType.RestockMachine },
			},
		}

		turnover_layouts["WAKABA_WINTER_ALBIREO_PLANETARIUM"] =	{
			SetUpPrice = 20,
			[0] = {
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
			},
			[1] = {
				{ Vector(240, 320), ShopItemType.Pickup },
				{ Vector(320, 320), ShopItemType.Collectible },
				{ Vector(400, 320), ShopItemType.Pickup },
			},
			[2] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[3] = {
				{ Vector(200, 320), ShopItemType.Collectible },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[4] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[5] = {
				{ Vector(240, 240), ShopItemType.Collectible },
				{ Vector(400, 240), ShopItemType.Collectible },
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
				{ Vector(450, 170), ShopItemType.RestockMachine },
			},
		}

		turnover_layouts["WAKABA_WINTER_ALBIREO_SECRET"] =	{
			SetUpPrice = 20,
			[0] = {
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
			},
			[1] = {
				{ Vector(240, 320), ShopItemType.Pickup },
				{ Vector(320, 320), ShopItemType.Collectible },
				{ Vector(400, 320), ShopItemType.Pickup },
			},
			[2] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[3] = {
				{ Vector(200, 320), ShopItemType.Collectible },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[4] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[5] = {
				{ Vector(240, 240), ShopItemType.Collectible },
				{ Vector(400, 240), ShopItemType.Collectible },
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
				{ Vector(450, 170), ShopItemType.RestockMachine },
			},
		}

		turnover_layouts["WAKABA_WINTER_ALBIREO_DEVIL"] =	{
			SetUpPrice = 20,
			[0] = {
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
			},
			[1] = {
				{ Vector(240, 320), ShopItemType.Pickup },
				{ Vector(320, 320), ShopItemType.Collectible },
				{ Vector(400, 320), ShopItemType.Pickup },
			},
			[2] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[3] = {
				{ Vector(200, 320), ShopItemType.Collectible },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[4] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[5] = {
				{ Vector(240, 240), ShopItemType.Collectible },
				{ Vector(400, 240), ShopItemType.Collectible },
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
				{ Vector(450, 170), ShopItemType.RestockMachine },
			},
		}

		turnover_layouts["WAKABA_WINTER_ALBIREO_ANGEL"] =	{
			SetUpPrice = 20,
			[0] = {
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
			},
			[1] = {
				{ Vector(240, 320), ShopItemType.Pickup },
				{ Vector(320, 320), ShopItemType.Collectible },
				{ Vector(400, 320), ShopItemType.Pickup },
			},
			[2] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[3] = {
				{ Vector(200, 320), ShopItemType.Collectible },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[4] = {
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
			},
			[5] = {
				{ Vector(240, 240), ShopItemType.Collectible },
				{ Vector(400, 240), ShopItemType.Collectible },
				{ Vector(200, 320), ShopItemType.Pickup },
				{ Vector(280, 320), ShopItemType.Pickup },
				{ Vector(360, 320), ShopItemType.Pickup },
				{ Vector(440, 320), ShopItemType.Pickup },
				{ Vector(450, 170), ShopItemType.RestockMachine },
			},
		}

		local turnover_pools = {}

		turnover_pools["WAKABA_WINTER_ALBIREO_TREASURE"] = {
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, 									minTier = 0, maxTier = 3 }},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK, 							minTier = 2, maxTier = 5 }},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, 								minTier = 2, maxTier = 5, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, 								minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL,											minTier = 0, maxTier = 3 }},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK,									minTier = 2, maxTier = 5 }},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_CHARGED, 								minTier = 1, maxTier = 3 }},
			{{ PickupVariant.PICKUP_KEY, Mod.Pickup.MULTITOOL.ID, 								minTier = 2, maxTier = 5, }, Weight = 0.06}, --multitool
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_GOLDEN,									minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MICRO,					minTier = 1, maxTier = 2 }},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_NORMAL,					minTier = 3, maxTier = 5 }},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MEGA,					minTier = 2, maxTier = 5, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_GOLDEN,					minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 1, maxTier = 4, }, Weight = 0.2},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 2, maxTier = 5, }, Weight = 1},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.TarotPlaying),	 		minTier = 1, maxTier = 2 }}, -- only normal and playing cards
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.TarotPlayingReverse),	minTier = 3, maxTier = 4 }},
			{{ PickupVariant.PICKUP_PILL, 0, 													minTier = 1, maxTier = 4 }},
			{{ PickupVariant.PICKUP_PILL, Get.GetHorsePill,										minTier = 2, maxTier = 5, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_PILL, PillColor.PILL_GOLD, 									minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Rune),						minTier = 0, maxTier = 3}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.RuneSoul),				minTier = 2, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.PlayingReverse),		minTier = 1, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Soul),						minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Essence, Rune),				minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY,							minTier = 3, maxTier = 5, }, Weight = 0.8},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetGoldTrinket, 							minTier = 4, maxTier = 5 }, Weight = 0.02},
		}

		turnover_pools["WAKABA_WINTER_ALBIREO_PLANETARIUM"] = {
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, 									minTier = 0, maxTier = 3 }},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK, 							minTier = 2, maxTier = 4 }},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, 								minTier = 2, maxTier = 5, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, 								minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL,											minTier = 0, maxTier = 3 }},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK,									minTier = 2, maxTier = 4 }},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_CHARGED, 								minTier = 1, maxTier = 3 }},
			{{ PickupVariant.PICKUP_KEY, Mod.Pickup.MULTITOOL.ID, 								minTier = 2, maxTier = 5, }, Weight = 0.06}, --multitool
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_GOLDEN,									minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MICRO,					minTier = 1, maxTier = 2 }},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_NORMAL,					minTier = 3, maxTier = 4 }},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MEGA,					minTier = 2, maxTier = 5, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_GOLDEN,					minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 1, maxTier = 4, }, Weight = 0.2},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 2, maxTier = 5, }, Weight = 1},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.TarotPlaying),	 		minTier = 1, maxTier = 2 }}, -- only normal and playing cards
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.TarotPlayingReverse),	minTier = 3, maxTier = 5 }},
			{{ PickupVariant.PICKUP_PILL, 0, 													minTier = 1, maxTier = 4 }},
			{{ PickupVariant.PICKUP_PILL, Get.GetHorsePill,										minTier = 2, maxTier = 5, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_PILL, PillColor.PILL_GOLD, 									minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Rune),						minTier = 0, maxTier = 3}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.RuneSoul),				minTier = 2, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.PlayingReverse),		minTier = 1, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Soul),						minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Essence, Rune),				minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY,							minTier = 3, maxTier = 5, }, Weight = 0.8},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetGoldTrinket, 							minTier = 4, maxTier = 5 }, Weight = 0.02},
		}

		turnover_pools["WAKABA_WINTER_ALBIREO_SECRET"] = {
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, 								minTier = 0, maxTier = 5, }, Weight = 0.5},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, 								minTier = 2, maxTier = 5, }, Weight = 0.2},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_CHARGED, 								minTier = 0, maxTier = 5 }},
			{{ PickupVariant.PICKUP_KEY, Mod.Pickup.MULTITOOL.ID, 								minTier = 2, maxTier = 5, }, Weight = 0.4}, --multitool
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_GOLDEN,									minTier = 2, maxTier = 5, }},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MEGA,					minTier = 0, maxTier = 5, }},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_GOLDEN,					minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 1, maxTier = 4, }, Weight = 0.2},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 2, maxTier = 4, }, Weight = 1},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.TarotPlaying),	 		minTier = 1, maxTier = 2 }}, -- only normal and playing cards
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.TarotPlayingReverse),	minTier = 3, maxTier = 4 }},
			{{ PickupVariant.PICKUP_PILL, Get.GetHorsePill,										minTier = 0, maxTier = 5 }, Weight = 0.3},
			{{ PickupVariant.PICKUP_PILL, PillColor.PILL_GOLD, 									minTier = 2, maxTier = 5, }, Weight = 0.1},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Rune),						minTier = 0, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.RuneSoul),				minTier = 2, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.PlayingReverse),		minTier = 1, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Soul),						minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Essence, Rune),				minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetGoldTrinket, 							minTier = 4, maxTier = 5 }, Weight = 0.1},
		}

		turnover_pools["WAKABA_WINTER_ALBIREO_DEVIL"] = {
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK, 							minTier = 0, maxTier = 4 }},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, 								minTier = 2, maxTier = 4, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, 								minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK,									minTier = 0, maxTier = 4 }},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_CHARGED, 								minTier = 1, maxTier = 5 }},
			{{ PickupVariant.PICKUP_KEY, Mod.Pickup.MULTITOOL.ID, 								minTier = 2, maxTier = 5, }, Weight = 0.1}, --multitool
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_NORMAL,					minTier = 1, maxTier = 4 }},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MEGA,					minTier = 2, maxTier = 5, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_GOLDEN,					minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 1, maxTier = 4, }, Weight = 0.2},
			{{ PickupVariant.PICKUP_PILL, Get.GetHorsePill,										minTier = 0, maxTier = 5, }, Weight = 0.4},
			{{ PickupVariant.PICKUP_PILL, PillColor.PILL_GOLD, 									minTier = 4, maxTier = 5, }, Weight = 0.1},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.CardRune),				minTier = 0, maxTier = 5, }, Weight = 0.5}, -- include runes
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.Playing),				minTier = 0, maxTier = 1, }, Weight = 0.6},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.PlayingReverse),		minTier = 1, maxTier = 4, }, Weight = 0.4},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.ReversedRune),			minTier = 2, maxTier = 4, }, Weight = 0.8},
			{{ PickupVariant.PICKUP_GRAB_BAG, SackSubType.SACK_NORMAL,							minTier = 0, maxTier = 4,}},
			{{ PickupVariant.PICKUP_HEART, Get.MakeHeartGetter(Devil), 							minTier = 0, maxTier = 4 }},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Rune),						minTier = 0, maxTier = 3}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.RuneSoul),				minTier = 2, maxTier = 4}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.PlayingReverse),		minTier = 1, maxTier = 4}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Soul),						minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Essence, Rune),				minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY,							minTier = 3, maxTier = 5, }, Weight = 0.8},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetGoldTrinket, 							minTier = 4, maxTier = 5 }, Weight = 0.1},
		}

		turnover_pools["WAKABA_WINTER_ALBIREO_ANGEL"] = {
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK, 							minTier = 0, maxTier = 4 }},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, 								minTier = 2, maxTier = 4, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, 								minTier = 2, maxTier = 5, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK,									minTier = 0, maxTier = 4 }},
			{{ PickupVariant.PICKUP_KEY, KeySubType.KEY_CHARGED, 								minTier = 1, maxTier = 5 }},
			{{ PickupVariant.PICKUP_KEY, Mod.Pickup.MULTITOOL.ID, 								minTier = 2, maxTier = 5, }, Weight = 0.1}, --multitool
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_NORMAL,					minTier = 3, maxTier = 4 }},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MEGA,					minTier = 2, maxTier = 4, }, Weight = 0.06},
			{{ PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_GOLDEN,					minTier = 2, maxTier = 4, }, Weight = 0.03},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 1, maxTier = 4, }, Weight = 0.2},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 2, maxTier = 4, }, Weight = 1},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.TarotPlaying),	 		minTier = 1, maxTier = 2 }}, -- only normal and playing cards
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.TarotPlayingReverse),	minTier = 3, maxTier = 4 }},
			{{ PickupVariant.PICKUP_PILL, Get.GetHorsePill,										minTier = 0, maxTier = 5, }, Weight = 0.4},
			{{ PickupVariant.PICKUP_PILL, PillColor.PILL_GOLD, 									minTier = 4, maxTier = 5, }, Weight = 0.1},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Rune),						minTier = 0, maxTier = 3}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.RuneSoul),				minTier = 2, maxTier = 4}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Groups.PlayingReverse),		minTier = 1, maxTier = 4}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Soul),						minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Essence, Rune),				minTier = 5, maxTier = 5}},
			{{ PickupVariant.PICKUP_HEART, Get.MakeHeartGetter(Angel), 							minTier = 1, maxTier = 5 }},
			{{ PickupVariant.PICKUP_HEART, Get.MakeHeartGetter(Angel), 							minTier = 1, maxTier = 5 }}, --we do this to have a chance of 2 different hearts
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetTrinket, 								minTier = 0, maxTier = 2, }, Weight = 0.1},
			{{ PickupVariant.PICKUP_TAROTCARD, Get.MakeCardGetter(Holy, Rune),					minTier = 3, maxTier = 5 }},
			{{ PickupVariant.PICKUP_TAROTCARD, Card.CARD_HOLY,							minTier = 0, maxTier = 5, }, Weight = 2},
			{{ PickupVariant.PICKUP_TRINKET,	Get.GetGoldTrinket, 							minTier = 4, maxTier = 5 }, Weight = 0.1},
		}

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
			Name = "WAKABA_WINTER_ALBIREO_TREASURE",
			Checker = function()
				return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_TREASURE
			end,
			ShopLayout = turnover_layouts["WAKABA_WINTER_ALBIREO_TREASURE"],
			PickupPool = turnover_pools["WAKABA_WINTER_ALBIREO_TREASURE"],
		})

		api:AddTurnoverShop({
			Name = "WAKABA_WINTER_ALBIREO_PLANETARIUM",
			Checker = function()
				return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_PLANETARIUM
			end,
			ShopLayout = turnover_layouts["WAKABA_WINTER_ALBIREO_PLANETARIUM"],
			PickupPool = turnover_pools["WAKABA_WINTER_ALBIREO_PLANETARIUM"],
		})

		api:AddTurnoverShop({
			Name = "WAKABA_WINTER_ALBIREO_SECRET",
			Checker = function()
				return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_SECRET
			end,
			ShopLayout = turnover_layouts["WAKABA_WINTER_ALBIREO_SECRET"],
			PickupPool = turnover_pools["WAKABA_WINTER_ALBIREO_SECRET"],
		})

		api:AddTurnoverShop({
			Name = "WAKABA_WINTER_ALBIREO_DEVIL",
			Checker = function()
				return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_DEVIL
			end,
			ShopLayout = turnover_layouts["WAKABA_WINTER_ALBIREO_DEVIL"],
			PickupPool = turnover_pools["WAKABA_WINTER_ALBIREO_DEVIL"],
		})

		api:AddTurnoverShop({
			Name = "WAKABA_WINTER_ALBIREO_ANGEL",
			Checker = function()
				return wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) == RoomType.ROOM_ANGEL
			end,
			ShopLayout = turnover_layouts["WAKABA_WINTER_ALBIREO_ANGEL"],
			PickupPool = turnover_pools["WAKABA_WINTER_ALBIREO_ANGEL"],
		})
		local TURNOVER = Mod.Item.TURNOVER
		TURNOVER.ExtraRoomTypePools[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_TREASURE] = ItemPoolType.POOL_TREASURE
		TURNOVER.ExtraRoomTypePools[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_PLANETARIUM] = ItemPoolType.POOL_PLANETARIUM
		TURNOVER.ExtraRoomTypePools[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_SECRET] = ItemPoolType.POOL_SECRET
		TURNOVER.ExtraRoomTypePools[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_DEVIL] = ItemPoolType.POOL_DEVIL
		TURNOVER.ExtraRoomTypePools[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_ANGEL] = ItemPoolType.POOL_ANGEL

		TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_TREASURE] = "Planetarium0"
		TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_PLANETARIUM] = "Planetarium0"
		TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_SECRET] = "Planetarium0"
		TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_DEVIL] = "Planetarium0"
		TURNOVER.RoomToShopkeeperAnimName[TURNOVER.ExtraRoomTypes.WAKABA_WINTER_ALBIREO_ANGEL] = "Planetarium0"

		Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
			if wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO) and Game():GetRoom():IsFirstVisit() and wakaba:GameHasPlayerType(Mod.PlayerType.KEEPER) then
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
	end

	do
		-- Golden Item descriptions for EID
		if EID then
			EID:addDescriptionModifier("Wakaba_Epiphany Golden Actives", function(descObj)
				return descObj.ObjType == 5
				and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE
				and descObj.ObjSubType > 0
				and wakaba:isActiveItem(descObj.ObjSubType)
				and (wakaba:IsGoldenItem(descObj.ObjSubType) or (Epiphany.IsGoldenPedestal ~= nil and descObj.Entity and Epiphany:IsGoldenPedestal(descObj.Entity)))
			end, function(descObj)
				local wakabaBuff = wakaba:getWakabaDesc("epiphany_golden", descObj.ObjSubType)
				if wakabaBuff then
					local desc = wakabaBuff.description
					if wakabaBuff.isReplace then
						descObj.Description = desc
					else
						EID:appendToDescription(descObj, "#{{GoldenItem}} ".. desc .. "{{CR}}")
					end
				end
				return descObj
			end)
		end
	end
end)
