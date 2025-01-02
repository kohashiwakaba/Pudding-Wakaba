return {
	---- GENERAL ----
	w_EasterDmg = {
		str = "%s%.2f%% damage per Easter Coin",
		addPlus = true,
		category = "wakabaGlobal", sort = 3901
	},
	shieldChance = {
		str = "%.2f%% chance to recieve Holy Card shield on hit",
		category = "wakabaGlobal", sort = 3902
	},
	cloverChestChance = {
		str = "%s%.2f%% chance to spawn Clover chest",
		addPlus = true,
		category = "wakabaGlobal", sort = 3903
	},
	wakabaCloverChestRange = {
		str = "%s%.2f range when opening Clover Chest",
		addPlus = true,
		category = "wakabaGlobal", sort = 3904
	},
	pendantMinLuck = {
		str = "%s%.2f minimum luck for Wakaba's Pendant",
		addPlus = true,
		category = "wakabaGlobal", sort = 3905
	},
	wakabaLeafTear = {
		str = {
			"Tearing Clover Leaf:",
			"    Negates a hit that would've killed you, if you have more than 0 luck",
			"    Negating a hit reduces 20, or 20%% of current luck, higher value prioritized",
			"    Reduced luck this way ignores Wakaba's Pendant",
			"    Does not work if player has Rock Bottom",
		},
		category = "wakabaGlobal", sort = 3906
	},
	wakabaFreeClover = {
		str = {
			"Cloverfest:",
			"    Clover chest can be appeared regardless of unlock",
			"    If already unlocked, Clover chest can be opened without using keys",
		},
		category = "wakabaGlobal", sort = 3907
	},
	wakabaIsSmart = {
		str = {
			"Wakaba-chan is no longer baka:",
			"    Perfection appears 1 floor earlier at the beginning",
			"    If Good Girl is allocated as Wakaba, +3 minimum luck for Wakaba's Pendant instead",
		},
		category = "wakabaGlobal", sort = 3908
	},
	wakabaWildCard = {
		str = {
			"The Wild Card:",
			"    Spawns a Wild Card at the start of a floor",
		},
		category = "wakabaGlobal", sort = 3909
	},
	unknownBookmarkTears = {
		str = "%s%.2f tears for the current room when you use an Unknown Bookmark.",
		addPlus = true,
		category = "wakabaGlobal", sort = 3910
	},
	libraryDamage = {
		str = "%s%.2f increased damage when entering Library.",
		addPlus = true,
		category = "wakabaGlobal", sort = 3911
	},
	libraryReveal = {
		str = "%d%% chance to reveal the library's location if it's present on the floor",
		category = "wakabaGlobal", sort = 3912
	},
	tsukasaRaid = {
		str = {
			"RAID:",
			"    +0.001 Damage per Global SP (Caps at +2)",
			"    +0.001 Tears per Respec (Caps at +2)",
		},
		category = "wakabaGlobal", sort = 3913
	},
	tsukasaIntervention = {
		str = {
			"Intervention:",
			"    Reduce charge time for Beetlejuice",
			"    Reduce Concentration time",
		},
		category = "wakabaGlobal", sort = 3914
	},
	tsukasaMagnetObols = {
		str = {
			"Magnetic Obols:",
			"    Arcane Obols and Astral Weapons are automatically collected",
		},
		category = "wakabaGlobal", sort = 3915
	},
	lunarRange = {
		str = "%s%.2f range when Lunar gauge is active",
		addPlus = true,
		category = "wakabaGlobal", sort = 3916
	},
	starAllstatsPerc = {
		str = "%s%.2f all stats if starmight is over 1000",
		addPlus = true,
		category = "wakabaGlobal", sort = 3917
	},
	starReq = {
		str = "-%d starmight requirements for all stats",
		category = "wakabaGlobal", sort = 3918
	},
	lunarProtection = {
		str = "-%.2f%% Lunar Gauge reduction",
		category = "wakabaGlobal", sort = 3919
	},
	---- WAKABA'S TREE SPECIAL ----
	wakabaGudGirl = {
		str = {
			"Good Girl:",
			"    Wakaba starts with Wakaba's Pendant",
			"    Perfection trinket no longer spawns",
		},
		category = "charTree", sort = 4002
	},
	wakabaJaebol = {
		str = {
			"Daughter of the Rich:",
			"    Wakaba Can get all selection items",
		},
		category = "charTree", sort = 4004
	},
	wakabaUniformCharge = {
		str = {
			"Joshikousei:",
			"    Wakaba's Uniform no longer consumes charge",
		},
		category = "charTree", sort = 4006
	},
	wakabaBirthright = {
		str = {
			"Impure Girl:",
			"    Begin the game with Birthright as Wakaba",
			"    All Boss items are replaced with Devil deals",
		},
		category = "charTree", sort = 4007
	},
	---- WAKABA'S TREE NORMAL  ----
	wakabaDevilChance = {
		str = "%.2f%% extra chance to spawn a devil/angel room as Wakaba",
		category = "charTree", sort = 4032
	},
	wakabaLuckyPennyChance = {
		str = "%.2f%% extra chance to replace penny drops with a lucky penny as Wakaba",
		category = "charTree", sort = 4033
	},
	wakabaDamageLuck = {
		str = "%s%.2f%% damage every 1 luck as Wakaba",
		addPlus = true,
		category = "charTree", sort = 4034
	},
	wakabaShieldChance = {
		str = "%.2f%% extra chance to recieve Holy Card shield on hit as Wakaba",
		category = "charTree", sort = 4035
	},
	wakabaCloverChestChance = {
		str = "%s%.2f%% extra chance to spawn Clover chest as Wakaba",
		addPlus = true,
		category = "charTree", sort = 4036
	},
	wakabaUniformSlot = {
		str = "%s%d Wakaba's Uniform slot",
		addPlus = true,
		category = "charTree", sort = 4037
	},
	---- SHIORI'S TREE SPECIAL ----
	shioriTaste = {
		str = {
			"Taste of Shiori:",
			"    %s%d Shiori's available book slot",
		},
		addPlus = true,
		category = "charTree", sort = 4061
	},
	shioriKnowledge = {
		str = {
			"Knowledge is power:",
			"    +5% damage up per enteing special rooms",
			"    Resets every floor",
		},
		addPlus = true,
		category = "charTree", sort = 4062
	},
	shioriGoldenKey = {
		str = {
			"Regulation:",
			"    All battery pickups are replaced to Golden keys",
		},
		category = "charTree", sort = 4063
	},
	shioriAssistant = {
		str = {
			"Library Assistant:",
			"    Unknown Bookmark can be appeared regardless of unlock",
			"    If already unlocked, Unknown Bookmark effect is fixed rather than selected from 5 random books",
		},
		addPlus = true,
		category = "charTree", sort = 4064
	},
	shioriSatyr = {
		str = {
			"Curse of Satyr:",
			"    Books from Shiori's book pool no longer require keys and can be used anytime",
			"    Using a book randomly shuffles Shiori's book pool",
			"    Using Purifier does not trigger shuffle",
		},
		addPlus = true,
		category = "charTree", sort = 4065
	},
	shioriPurify = {
		str = {
			"Purifier:",
			"    Purifier is allocated and be is always available for Shiori",
			"    Purifier dissolve pedestal into keys",
			"    Curse of Satyr reduces number of keys",
		},
		addPlus = true,
		category = "charTree", sort = 4066
	},
	shioriGod = {
		str = {
			"Become Goddess:",
			"    Starts with GodHead",
			"    -75% Damage",
		},
		category = "charTree", sort = 4067
	},
	---- SHIORI'S TREE NORMAL  ----
	shioriKeyRange = {
		str = "%s%.2f%% range when collecting a key. Resets every floor.",
		addPlus = true,
		category = "charTree", sort = 4093
	},
	shioriSecondaryLuck = {
		str = "%s%.2f%% luck when secondary effect of Book of Shiori changes. Resets every floor.",
		addPlus = true,
		category = "charTree", sort = 4093
	},
	shioriExtraKeyDrop = {
		str = "%s%.2f%% chance to gain an additional key when clearing a room",
		addPlus = true,
		category = "charTree", sort = 4093
	},
	shioriRoomKeyDamage = {
		str = "%s%.2f damage for the current room per key consumed",
		addPlus = true,
		category = "charTree", sort = 4094
	},
	shioriUnknownBookmarkTears = {
		str = "%s%.2f tears for the current room when you use an Unknown Bookmark.",
		addPlus = true,
		category = "charTree", sort = 4094
	},
	shioriCardFloorDamage = {
		str = "%s%.2f%% increased damage for the current floor when you use a card, up to a total 15%.",
		addPlus = true,
		category = "charTree", sort = 4094
	},
	shioriLibraryDamage = {
		str = "%s%.2f increased damage when entering Library.",
		addPlus = true,
		category = "charTree", sort = 4094
	},
	---- TSUKASA'S TREE SPECIAL ----
	tsukasaDannaSama = {
		str = {
			"Her only husband Nasa:",
			"    Starts with Nasa Lover, regardless of unlock",
		},
		category = "charTree", sort = 4120
	},
	tsukasaServerOffline = {
		str = {
			"Server Offline:",
			"    +150% Damage",
			"    Starts with Luna.",
			"    Lunar Stone no longer revives Tsukasa.",
			"    +100% extra Damage if Lunar Acceleration is allocated."
		},
		category = "charTree", sort = 4122
	},
	tsukasaConcentration = {
		str = {
			"Mind Control:",
			"    Allows full use of Concentration as Tsukasa",
			"    No longer requires room clear on multiple usage",
			"    Concentration limit is increased to 300",
		},
		category = "charTree", sort = 4124
	},
	tsukasaLuna = {
		str = {
			"Crack in the Sky:",
			"    Luna lights appear at special rooms",
			"    (except Boss, Dungeon)",
			"    -50%% tears for Luna",
		},
		category = "charTree", sort = 4125
	},
	tsukasaAcceleration = {
		str = {
			"Lunar Acceleration:",
			"    Lunar Stone is always active",
			"    Stat bonus from Lunar Stone is doubled",
			"    Lunar gauge reduction is tripled",
		},
		category = "charTree", sort = 4125
	},
	---- TSUKASA'S TREE NORMAL  ----
	tsukasaLunarRange = {
		str = "%s%.2f range when Lunar gauge is active",
		addPlus = true,
		category = "charTree", sort = 4151
	},
	tsukasaRevivalRespec = {
		str = {
			"%.2f%% chance for gain Respec point on revival. Once per floor.",
			"Above 100%% total chance, roll for multiple Respec points",
		},
		category = "charTree", sort = 4152
	},
	tsukasaStarAllstatsPerc = {
		str = "%s%.2f all stats if starmight is over 1000",
		addPlus = true,
		category = "charTree", sort = 4153
	},
	tsukasaStarReq = {
		str = "-%d starmight requirements for all stats",
		category = "charTree", sort = 4154
	},
	tsukasaSoulRecover = {
		str = "%.2f%% Lunar gauge recover when picking up Soul Hearts",
		category = "charTree", sort = 4155
	},
	tsukasaOrbitalRevenge = {
		str = "%.2f%% chance to shoot orbiting tear when damaged",
		category = "charTree", sort = 4156
	},
	tsukasaLunarProtection = {
		str = "-%.2f%% Lunar Gauge reduction",
		category = "charTree", sort = 4157
	},
	---- RICHER'S TREE SPECIAL ----
	richerTaste = {
		str = {
			"Taste of Richer:",
			"    Sweets Catalog allows select weapon to use instead of random weapon",
		},
		category = "charTree", sort = 4181
	},
	richerBestFriend = {
		str = {
			"Richer's Best Friend:",
			"    Starts with Maid Duet",
		},
		category = "charTree", sort = 4182
	},
	richerUbercharge = {
		str = {
			"UberCharge:",
			"    Grants electric tears when Rabbit Ribbon's charge is 16 or higher",
		},
		category = "charTree", sort = 4183
	},
	richerSweetRecipe = {
		str = {
			"Sweet Recipe:",
			"    Spawns Richer type locust on room clear",
		},
		category = "charTree", sort = 4184
	},
	---- RICHER'S TREE NORMAL  ----
	richerSpeed = {
		str = "%s%.2f speed",
		addPlus = true,
		category = "charTree", sort = 4211
	},
	richerRabbitChargeGain = {
		str = "%.2f%% chance to gain additional Rabbit Ribbon charge",
		addPlus = true,
		category = "charTree", sort = 4212
	},
	richerRabbitChargeUse = {
		str = "%.2f%% chance to preserve Rabbit Ribbon charge when transfering to actives",
		addPlus = true,
		category = "charTree", sort = 4213
	},
	richerRabbitChargeDmg = {
		str = "%s%.2f damage when transfering Rabbit Ribbon charge to actives",
		addPlus = true,
		category = "charTree", sort = 4214
	},
	---- RIRA'S TREE SPECIAL ----
	riraTaste = {
		str = {
			"Taste of Rira:",
			"    Starts with innate Bunny Parfait effect, regardless of unlock",
			"    This Bunny Parfait does not have revival",
		},
		category = "charTree", sort = 4241
	},
	RiraEasterEgg = {
		str = {
			"Easter:",
			"    Easter Egg coins appear regardless of unlock",
		},
		category = "charTree", sort = 4242
	},
	RiraSchoolMizugi = {
		str = {
			"Blue Swimsuit:",
			"    All enemies are permanently wet on water rooms",
		},
		category = "charTree", sort = 4243
	},
	RiraHazukashi = {
		str = {
			"Rira-chan is too embarrased:",
			"    speed is fixed to 2.25 on cleared rooms",
		},
		category = "charTree", sort = 4244
	},
	RiraEasterFuse = {
		str = {
			"Fused with Easter Egg:",
			"    Getting 10+ Easter Egg coins grants Homing Tears",
		},
		category = "charTree", sort = 4244
	},
	---- RIRA'S TREE NORMAL  ----
	riraTears = {
		str = "%s%.2f tears",
		addPlus = true,
		category = "charTree", sort = 4271
	},
	riraWetChance = {
		str = "%s%.2f%% chance shoot wet tears",
		addPlus = true,
		category = "charTree", sort = 4272
	},
	riraWetExtraDamage = {
		str = "%s%.2f%% extra damage to wet enemies",
		addPlus = true,
		category = "charTree", sort = 4273
	},
	riraWetSpeed = {
		str = "%s%.2f speed when killing wet enemies. Resets every floor",
		addPlus = true,
		category = "charTree", sort = 4274
	},
	riraChimakiDmg = {
		str = "%s%.2f%% Chimaki damage",
		addPlus = true,
		category = "charTree", sort = 4275
	},
	riraEasterDmg = {
		str = "%s%.2f%% damage per Easter Coin as Rira and Chimaki",
		addPlus = true,
		category = "charTree", sort = 4276
	},
}