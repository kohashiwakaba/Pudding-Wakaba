
wakaba:RegisterPatch(0, "LNF", function() return (LNF ~= nil) end, function()
	do
		-- Robot/T.Robot + Q5/6 fix
		if not LNFResources.TRQSItems[7] then LNFResources.TRQSItems[7] = {} end
		if not LNFResources.QSItemsSummonable[7] then LNFResources.QSItemsSummonable[7] = {} end
	end
	do
		--LNF:AddWorkshopSalvageBlacklist(wakaba.Enums.Collectibles.WAKABA_DUALITY)
		LNF:AddItemToIsaacToysBlacklist(wakaba.Enums.Collectibles.WAKABA_DUALITY)
	end
	do
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.WAKABA, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_LUCKYPENNY)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.SHIORI, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 0)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.SHIORI, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.TSUKASA, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLENDED)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.RICHER, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_NORMAL)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.RIRA, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, wakaba.Enums.Coins.EASTER_EGG)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.ANNA, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0)

		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.WAKABA_B, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.SHIORI_B, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 0)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.SHIORI_B, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_VALUT_RIFT)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.TSUKASA_B, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.RICHER_B, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_NORMAL)
		LNF:AddQuestionnaireDrop(wakaba.Enums.Players.RIRA_B, EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL)
	end
end)