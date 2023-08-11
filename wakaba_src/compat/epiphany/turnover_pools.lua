local pools = {}

pools["WINTER_ALBIREO_TREASURE"] = {
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, 	  							minTier = 0, maxTier = 3 }},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK, 							minTier = 2, maxTier = 5 }},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, 								minTier = 2, maxTier = 5, }, Weight = 0.06},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, 								minTier = 2, maxTier = 5, }, Weight = 0.03},
  {{ PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL,	      							minTier = 0, maxTier = 3 }},
  {{ PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK,	  							minTier = 2, maxTier = 5 }},
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
  {{ PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY,							minTier = 3, maxTier = 5, }, Weight = 0.8}
  {{ PickupVariant.PICKUP_TRINKET,	Get.GetGoldTrinket, 							minTier = 4, maxTier = 5 }, Weight = 0.02},
}

pools["WINTER_ALBIREO_PLANETARIUM"] = {
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, 	  							minTier = 0, maxTier = 3 }},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK, 							minTier = 2, maxTier = 4 }},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, 								minTier = 2, maxTier = 5, }, Weight = 0.06},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, 								minTier = 2, maxTier = 5, }, Weight = 0.03},
  {{ PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL,	      							minTier = 0, maxTier = 3 }},
  {{ PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK,	  							minTier = 2, maxTier = 4 }},
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
  {{ PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY,							minTier = 3, maxTier = 5, }, Weight = 0.8}
  {{ PickupVariant.PICKUP_TRINKET,	Get.GetGoldTrinket, 							minTier = 4, maxTier = 5 }, Weight = 0.02},
}

pools["WINTER_ALBIREO_SECRET"] = {
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

pools["WINTER_ALBIREO_DEVIL"] = {
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK, 							minTier = 0, maxTier = 4 }},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, 								minTier = 2, maxTier = 4, }, Weight = 0.06},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, 								minTier = 2, maxTier = 5, }, Weight = 0.03},
  {{ PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK,	  							minTier = 0, maxTier = 4 }},
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
  {{ PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY,							minTier = 3, maxTier = 5, }, Weight = 0.8}
  {{ PickupVariant.PICKUP_TRINKET,	Get.GetGoldTrinket, 							minTier = 4, maxTier = 5 }, Weight = 0.1},
}

pools["WINTER_ALBIREO_ANGEL"] = {
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK, 							minTier = 0, maxTier = 4 }},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, 								minTier = 2, maxTier = 4, }, Weight = 0.06},
  {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, 								minTier = 2, maxTier = 5, }, Weight = 0.03},
  {{ PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK,	  							minTier = 0, maxTier = 4 }},
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

return pools