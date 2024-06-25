
wakaba.curseAnimFrames = {
	[wakaba.curses.CURSE_OF_FLAMES] = 0,
	[wakaba.curses.CURSE_OF_SATYR] = 1,
	[wakaba.curses.CURSE_OF_SNIPER] = 2,
	[wakaba.curses.CURSE_OF_AMNESIA] = 3,
	[wakaba.curses.CURSE_OF_FAIRY] = 4,
	[wakaba.curses.CURSE_OF_MAGICAL_GIRL] = 5,
}

if MinimapAPI then
	--Curse of Flames render
	MinimapAPI:AddMapFlag(
	  "CurseOfFlames",
	  function()
			return wakaba.curses.CURSE_OF_FLAMES > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_FLAMES == wakaba.curses.CURSE_OF_FLAMES
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_FLAMES]
	)
	--Curse of Satyr render
	MinimapAPI:AddMapFlag(
	  "CurseOfSatyr",
	  function()
			return wakaba.curses.CURSE_OF_SATYR > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_SATYR == wakaba.curses.CURSE_OF_SATYR
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_SATYR]
	)
	--Curse of Sniper render
	MinimapAPI:AddMapFlag(
	  "CurseOfSniper",
	  function()
			return wakaba.curses.CURSE_OF_SNIPER > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_SNIPER == wakaba.curses.CURSE_OF_SNIPER
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_SNIPER]
	)
	--Curse of Amnesia render
	MinimapAPI:AddMapFlag(
	  "CurseOfAmnesia",
	  function()
			return wakaba.curses.CURSE_OF_AMNESIA > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_AMNESIA == wakaba.curses.CURSE_OF_AMNESIA
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_AMNESIA]
	)
	--Curse of Fairy render
	MinimapAPI:AddMapFlag(
	  "CurseOfFairy",
	  function()
			return wakaba.curses.CURSE_OF_FAIRY > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_FAIRY == wakaba.curses.CURSE_OF_FAIRY
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_FAIRY]
	)
	--Curse of Magical Girl render
	MinimapAPI:AddMapFlag(
	  "CurseOfMagicalGirl",
	  function()
			return wakaba.curses.CURSE_OF_MAGICAL_GIRL > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_MAGICAL_GIRL == wakaba.curses.CURSE_OF_MAGICAL_GIRL
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_MAGICAL_GIRL]
	)

	MinimapAPI:AddIcon("wakaba_RicherPlanetariumIcon", wakaba.MiniMapAPISprite, "Rooms", 0)

	MinimapAPI:AddIcon("wakaba_CloverChestIcon", wakaba.MiniMapAPISprite, "Extra", 0)
	MinimapAPI:AddIcon("wakaba_ShioriValutIcon", wakaba.MiniMapAPISprite, "Extra", 1)
	MinimapAPI:AddIcon("wakaba_EasterCoinIcon", wakaba.MiniMapAPISprite, "Extra", 2)

	MinimapAPI:AddIcon("wakaba_CrystalRestockIcon", wakaba.MiniMapAPISprite, "Extra", 3)
	MinimapAPI:AddIcon("wakaba_CrystalRestockIcon_Red", wakaba.MiniMapAPISprite, "Extra", 4)
	MinimapAPI:AddIcon("wakaba_CrystalRestockIcon_Green", wakaba.MiniMapAPISprite, "Extra", 5)
	MinimapAPI:AddIcon("wakaba_CrystalRestockIcon_Richer", wakaba.MiniMapAPISprite, "Extra", 6)
	MinimapAPI:AddIcon("wakaba_CrystalRestockIcon_Rira", wakaba.MiniMapAPISprite, "Extra", 7)
	MinimapAPI:AddIcon("wakaba_CrystalRestockIcon_Yellow", wakaba.MiniMapAPISprite, "Extra", 8)

	MinimapAPI:AddIcon("wakaba_SilverCardIcon", wakaba.MiniMapAPISprite, "Cards", 0)
	MinimapAPI:AddIcon("wakaba_CraneCardIcon", wakaba.MiniMapAPISprite, "Cards", 1)
	MinimapAPI:AddIcon("wakaba_GoldCardIcon", wakaba.MiniMapAPISprite, "Cards", 2)
	MinimapAPI:AddIcon("wakaba_ConfessionalCardIcon", wakaba.MiniMapAPISprite, "Cards", 3)
	MinimapAPI:AddIcon("wakaba_UnknownBookmarkIcon", wakaba.MiniMapAPISprite, "Cards", 4)
	MinimapAPI:AddIcon("wakaba_DreamCardIcon", wakaba.MiniMapAPISprite, "Cards", 5)
	MinimapAPI:AddIcon("wakaba_WakabaTicketIcon", wakaba.MiniMapAPISprite, "Cards", 6)

	MinimapAPI:AddIcon("wakaba_SoulofWakabaIcon", wakaba.MiniMapAPISprite, "Runes", 0)
	MinimapAPI:AddIcon("wakaba_SoulofWakaba2Icon", wakaba.MiniMapAPISprite, "Runes", 1)
	MinimapAPI:AddIcon("wakaba_SoulofShioriIcon", wakaba.MiniMapAPISprite, "Runes", 2)
	MinimapAPI:AddIcon("wakaba_SoulofTsukasaIcon", wakaba.MiniMapAPISprite, "Runes", 3)
	MinimapAPI:AddIcon("wakaba_SoulofRicherIcon", wakaba.MiniMapAPISprite, "Runes", 4)
	MinimapAPI:AddIcon("wakaba_SoulofRiraIcon", wakaba.MiniMapAPISprite, "Runes", 5)

	MinimapAPI:AddIcon("wakaba_ReturnTokenIcon", wakaba.MiniMapAPISprite, "Objects", 0)

	--Clover Chest render
	MinimapAPI:AddPickup("CloverChest", "wakaba_CloverChestIcon", 5, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.CLOSED, MinimapAPI.PickupChestNotCollected, "chests", 7450)
	--Shiori Valut render
	MinimapAPI:AddPickup("ShioriValut", "wakaba_ShioriValutIcon", 6, wakaba.Enums.Slots.SHIORI_VALUT, wakaba.ChestSubType.CLOSED, function(p) return not p:GetSprite():IsPlaying("Death") end, "slots", 1500)
	--Easter Coin render
	MinimapAPI:AddPickup("EasterCoin", "wakaba_EasterCoinIcon", 5, PickupVariant.PICKUP_COIN, wakaba.Enums.Coins.EASTER_EGG, MinimapAPI.PickupNotCollected, "coins", 4100)
	--Crystal Restock render
	MinimapAPI:AddPickup("wakaba_CrystalRestock", "wakaba_CrystalRestockIcon", 6, wakaba.Enums.Slots.CRYSTAL_RESTOCK, wakaba.Enums.CrystalRestockSubType.NORMAL, function(p) return not p:GetSprite():IsPlaying("Death") end, "slots", 1600)
	MinimapAPI:AddPickup("wakaba_CrystalRestock_Red", "wakaba_CrystalRestockIcon_Red", 6, wakaba.Enums.Slots.CRYSTAL_RESTOCK, wakaba.Enums.CrystalRestockSubType.RED, function(p) return not p:GetSprite():IsPlaying("Death") end, "slots", 1600)
	MinimapAPI:AddPickup("wakaba_CrystalRestock_Green", "wakaba_CrystalRestockIcon_Green", 6, wakaba.Enums.Slots.CRYSTAL_RESTOCK, wakaba.Enums.CrystalRestockSubType.GREEN, function(p) return not p:GetSprite():IsPlaying("Death") end, "slots", 1600)
	MinimapAPI:AddPickup("wakaba_CrystalRestock_Richer", "wakaba_CrystalRestockIcon_Richer", 6, wakaba.Enums.Slots.CRYSTAL_RESTOCK, wakaba.Enums.CrystalRestockSubType.RICHER, function(p) return not p:GetSprite():IsPlaying("Death") end, "slots", 1600)
	MinimapAPI:AddPickup("wakaba_CrystalRestock_Rira", "wakaba_CrystalRestockIcon_Rira", 6, wakaba.Enums.Slots.CRYSTAL_RESTOCK, wakaba.Enums.CrystalRestockSubType.RIRA, function(p) return not p:GetSprite():IsPlaying("Death") end, "slots", 1600)
	MinimapAPI:AddPickup("wakaba_CrystalRestock_Yellow", "wakaba_CrystalRestockIcon_Yellow", 6, wakaba.Enums.Slots.CRYSTAL_RESTOCK, wakaba.Enums.CrystalRestockSubType.YELLOW, function(p) return not p:GetSprite():IsPlaying("Death") end, "slots", 1600)

	MinimapAPI:AddPickup("wakaba_DreamCard", "wakaba_DreamCardIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_DREAM_CARD, MinimapAPI.PickupNotCollected, "cards", 9050)
	MinimapAPI:AddPickup("wakaba_MinervaTicket", "wakaba_WakabaTicketIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_MINERVA_TICKET, MinimapAPI.PickupNotCollected, "cards", 9050)
	MinimapAPI:AddPickup("wakaba_RicherTicket", "wakaba_WakabaTicketIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_RICHER_TICKET, MinimapAPI.PickupNotCollected, "cards", 9050)
	MinimapAPI:AddPickup("wakaba_RiraTicket", "wakaba_WakabaTicketIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_RIRA_TICKET, MinimapAPI.PickupNotCollected, "cards", 9050)
	MinimapAPI:AddPickup("wakaba_ValutTicket", "wakaba_WakabaTicketIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_VALUT_RIFT, MinimapAPI.PickupNotCollected, "cards", 9050)
	MinimapAPI:AddPickup("wakaba_TrialStew", "wakaba_WakabaTicketIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_TRIAL_STEW, MinimapAPI.PickupNotCollected, "cards", 9050)
	MinimapAPI:AddPickup("wakaba_CraneCard", "wakaba_CraneCardIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_CRANE_CARD, MinimapAPI.PickupNotCollected, "cards", 9050)
	MinimapAPI:AddPickup("wakaba_UnknownBookmark", "wakaba_UnknownBookmarkIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK, MinimapAPI.PickupNotCollected, "cards", 9050)
	MinimapAPI:AddPickup("wakaba_ConfessionalCard", "wakaba_ConfessionalCardIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD, MinimapAPI.PickupNotCollected, "cards", 9050)

	MinimapAPI:AddPickup("wakaba_SoulofWakaba", "wakaba_SoulofWakabaIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.SOUL_WAKABA, MinimapAPI.PickupNotCollected, "runes", 10050)
	MinimapAPI:AddPickup("wakaba_SoulofWakaba2", "wakaba_SoulofWakaba2Icon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.SOUL_WAKABA2, MinimapAPI.PickupNotCollected, "runes", 10050)
	MinimapAPI:AddPickup("wakaba_SoulofShiori", "wakaba_SoulofShioriIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.SOUL_SHIORI, MinimapAPI.PickupNotCollected, "runes", 10050)
	MinimapAPI:AddPickup("wakaba_SoulofTsukasa", "wakaba_SoulofTsukasaIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.SOUL_TSUKASA, MinimapAPI.PickupNotCollected, "runes", 10050)
	MinimapAPI:AddPickup("wakaba_SoulofRicher", "wakaba_SoulofRicherIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.SOUL_RICHER, MinimapAPI.PickupNotCollected, "runes", 10050)
	MinimapAPI:AddPickup("wakaba_SoulofRira", "wakaba_SoulofRiraIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.SOUL_RIRA, MinimapAPI.PickupNotCollected, "runes", 10050)

	MinimapAPI:AddPickup("wakaba_ReturnToken", "wakaba_ReturnTokenIcon", 5, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_RETURN_TOKEN, MinimapAPI.PickupNotCollected, "cards", 9050)

end