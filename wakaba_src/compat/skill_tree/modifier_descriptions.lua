return {
	---- GENERAL ----
	w_EasterDmg = {
		str = "%s%.2f%% damage per Easter Coin",
		addPlus = true,
		category = "condStats", sort = 3991
	},
	---- WAKABA'S TREE SPECIAL ----
	wakabaGudGirl = {
		str = {
			"Good Girl:",
			"    +50%% luck",
			"    -10%% speed"
		},
		category = "charTree", sort = 4002
	},
	wakabaIsSmart = {
		str = {
			"Wakaba-chan is no longer baka:",
			"    Starts with Perfection",
		},
		category = "charTree", sort = 4003
	},
	wakabaJaebol = {
		str = {
			"Daughter of the Rich:",
			"    Can get all selection items",
		},
		category = "charTree", sort = 4004
	},
	wakabaWildCard = {
		str = {
			"The Wild Card:",
			"    Spawns a Wild Card at the start of a floor",
			"    Doesn't apply to first floor",
		},
		category = "charTree", sort = 4005
	},
	wakabaLeafTear = {
		str = {
			"Tearing Clover Leaf:",
			"    Negates a hit that would've killed you, if you have more than 0 luck",
			"    Negating a hit reduces 20, or 20% of current luck, higher value prioritized",
		},
		category = "charTree", sort = 4006
	},
	wakabaFreeClover = {
		str = {
			"Cloverfest:",
			"    Clover chest can be appeared regardless of unlock",
			"    Clover chest can be opened without using keys",
		},
		category = "charTree", sort = 4007
	},
	---- WAKABA'S TREE NORMAL  ----
	wakabaLuck = {
		str = "%s%.2f%% luck",
		addPlus = true,
		category = "charTree", sort = 4031
	},
	wakabaDevilChance = {
		str = "%.2f%% extra chance to spawn a devil/angel room",
		category = "charTree", sort = 4032
	},
	wakabaLuckyPennyChance = {
		str = "%.2f%% chance to replace penny drops with a lucky penny",
		category = "charTree", sort = 4033
	},
	wakabaDamageLuck = {
		str = "%s%.2f%% damage every 1 luck",
		addPlus = true,
		category = "charTree", sort = 4034
	},
	wakabaShieldChance = {
		str = "%.2f%% chance to recieve Holy Card shield on hit",
		category = "charTree", sort = 4035
	},
	wakabaCloverChestChance = {
		str = "%s%.2f%% chance to spawn Clover chest",
		addPlus = true,
		category = "charTree", sort = 4036
	},
	wakabaCloverChestRange = {
		str = "%s%.2f% range when opening Clover Chest",
		addPlus = true,
		category = "charTree", sort = 4037
	},
	---- SHIORI'S TREE SPECIAL ----
	shioriGoldenKey = {
		str = {
			"Regulation:",
			"    All battery pickups are replaced to Golden keys",
		},
		category = "charTree", sort = 4061
	},
	---- SHIORI'S TREE NORMAL  ----
	shioriExtraBooks = {
		str = "%s%d book capacity per floor",
		addPlus = true,
		category = "charTree", sort = 4092
	},
	shioriExtraKeyDrop = {
		str = "%s%.2f%% chance to gain an additional key on room clear",
		addPlus = true,
		category = "charTree", sort = 4093
	},
	shioriRoomKeyDamage = {
		str = "%s%s%.2f damage for the current room when a key is consumed",
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
			"    Lunar Stone no longer gives revival",
			"    Negates a hit that would've killed you, if you have more than 20%%p of your Lunar gauge",
			"    Negating a hit reduces fixed 20%%p of your Lunar Stone gauge"
		},
		category = "charTree", sort = 4122
	},
	tsukasaRaid = {
		str = {
			"RAID:",
			"    +1%% damage, +0.5%% speed per respec points",
		},
		category = "charTree", sort = 4123
	},
	tsukasaConcentration = {
		str = {
			"Mind Control:",
			"    Allows full use of Concentration",
			"    No longer requires room clear on multiple usage",
			"    Concentration limit is increased to 300",
		},
		category = "charTree", sort = 4124
	},
	---- TSUKASA'S TREE NORMAL  ----
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