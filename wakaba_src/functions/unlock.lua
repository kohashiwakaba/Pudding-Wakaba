-- main unlock related functions mixed from Fiend Folio, Retribution

local game = Game()
local isc = _wakaba.isc

local playertype_cache =  wakaba.CACHED_PLAYERTYPE_CACHE or {}
wakaba.CACHED_PLAYERTYPE_CACHE = playertype_cache

local unlocksHolder = {}
local unlocksHolder2 = {}

local DifficultyToCompletionMap = {
	[Difficulty.DIFFICULTY_NORMAL]	 = 1,
	[Difficulty.DIFFICULTY_HARD]	 = 2,
	[Difficulty.DIFFICULTY_GREED]	 = 1,
	[Difficulty.DIFFICULTY_GREEDIER] = 2,
}

local BossID = { -- Only the relevant ones
	MOM 		= 6,
	HEART 		= 8,
	SATAN 		= 24,
	IT_LIVES	= 25,
	ISAAC		= 39,
	BLUE_BABY	= 40,
	LAMB		= 54,
	MEGA_SATAN	= 55,
	GREED		= 62,
	HUSH		= 63,
	DELIRIUM	= 70,
	GREEDIER	= 71,
	MOTHER		= 88,
	MAUS_HEART	= 90,
	BEAST		= 100,
}

local noteLayer = {
	DELI 	= 0,
	HEART	= 1,
	ISAAC	= 2,
	SATAN	= 3,
	RUSH 	= 4,
	BBABY 	= 5,
	LAMB 	= 6,
	MEGA 	= 7,
	GREED 	= 8,
	HUSH 	= 9,
	MOTHER 	= 10,
	BEAST 	= 11,
}

local associationToValueMap = {
	Heart 		= "heart",
	Isaac 		= "isaac",
	BlueBaby 	= "bbaby",
	Satan 		= "satan",
	Lamb		= "lamb",
	BossRush 	= "rush",
	Hush 		= "hush",
	Delirium 	= "deli",
	MegaSatan 	= "mega",
	Mother		= "mother",
	Beast		= "beast",
	Greed 		= "greed",
	Greedier 	= "greed",
}

local associationTestValue = {
	Heart 		= 2,
	Isaac 		= 1,
	BlueBaby 	= 1,
	Satan 		= 1,
	Lamb		= 1,
	BossRush 	= 1,
	Hush 		= 1,
	Delirium 	= 1,
	MegaSatan 	= 1,
	Mother 		= 1,
	Beast 		= 1,
	Greed 		= 1,
	Greedier 	= 2,
}

local achievementGfxRoot = "gfx/ui/achievement/"
function wakaba:TryPlayAchievementPaper(entry, completionType)
	if REPENTOGON then
	else
		local gfxLocation = achievementGfxRoot..wakaba.achievementsprite[entry]
		if #wakaba.state.pendingunlock > 0 or completionType == "Beast" or completionType == "MegaSatan" then
			table.insert(wakaba.state.pendingunlock, gfxLocation)
		else
			CCO.AchievementDisplayAPI.PlayAchievement(gfxLocation)
		end
	end
end

wakaba.Blacklists.FlagLock = {}
wakaba.Blacklists.FlagLock.collectible = {
	[wakaba.Enums.Collectibles.MAGMA_BLADE] = function()
		return not REPENTOGON
	end,
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = function()
		return not REPENTOGON
	end,
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = function()
		return not REPENTOGON
	end,
	[wakaba.Enums.Collectibles.RETURN_POSTAGE] = function()
		return wakaba:IsLunatic()
	end,
	[wakaba.Enums.Collectibles.DOUBLE_INVADER] = function()
		return wakaba:IsLunatic()
	end,
	[wakaba.Enums.Collectibles.RIRAS_COAT] = function()
		return wakaba:IsLunatic() and not REPENTOGON
	end,
	[wakaba.Enums.Collectibles.COUNTER] = function()
		return wakaba:IsLunatic() and not REPENTOGON
	end,
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = function()
		return wakaba:IsLunatic() and not REPENTOGON
	end,
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = function()
		return wakaba:IsLunatic() and not REPENTOGON
	end,
	[wakaba.Enums.Collectibles.RICHERS_UNIFORM] = function()
		return wakaba:IsLunatic() and not REPENTOGON
	end,
	[wakaba.Enums.Collectibles.VINTAGE_THREAT] = function()
		return not wakaba.Flags.stackableDamocles
	end,
}
wakaba.Blacklists.FlagLock.trinket = {
	[wakaba.Enums.Trinkets.BITCOIN] = function()
		return wakaba:IsLunatic()
	end,
	[wakaba.Enums.Trinkets.PINK_FORK] = function()
		return not REPENTOGON
	end,
}
wakaba.Blacklists.FlagLock.card = {
	[wakaba.Enums.Cards.SOUL_TSUKASA] = function()
		return not wakaba.Flags.stackableDamocles
	end,
	[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = function()
		return wakaba:IsLunatic()
	end,
}

---@type table
wakaba.UnlockTables = {
	[wakaba.Enums.Players.WAKABA] = {
		Heart 		= {"clover", "trinket", 		wakaba.Enums.Trinkets.CLOVER,		function() wakaba:TryPlayAchievementPaper("clover", "Boss") end},
		Isaac 		= {"counter", "collectible",	wakaba.Enums.Collectibles.COUNTER,		function() wakaba:TryPlayAchievementPaper("counter", "Boss") end},
		BlueBaby 	= {"pendant", "collectible",	wakaba.Enums.Collectibles.WAKABAS_PENDANT,		function() wakaba:TryPlayAchievementPaper("pendant", "Boss") end},
		Satan 		= {"dcupicecream", "collectible",	wakaba.Enums.Collectibles.D_CUP_ICECREAM,		function() wakaba:TryPlayAchievementPaper("dcupicecream", "Boss") end},
		Lamb		= {"revengefruit", "collectible",	wakaba.Enums.Collectibles.REVENGE_FRUIT,				function() wakaba:TryPlayAchievementPaper("revengefruit", "Boss") end},
		BossRush	= {"donationcard", "card",	wakaba.Enums.Cards.CARD_DREAM_CARD,				function() wakaba:TryPlayAchievementPaper("dreamcard", "Boss") end},
		Hush		= {"colorjoker", "card",	wakaba.Enums.Cards.CARD_COLOR_JOKER,		function() wakaba:TryPlayAchievementPaper("colorjoker", "Boss") end},
		Delirium	= {"wakabauniform", "collectible",	wakaba.Enums.Collectibles.UNIFORM,				function() wakaba:TryPlayAchievementPaper("uniform", "Boss") end},
		MegaSatan	= {"whitejoker", "card",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() wakaba:TryPlayAchievementPaper("whitejoker", "MegaSatan") end},
		Mother		= {"confessionalcard", "card",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() wakaba:TryPlayAchievementPaper("confessionalcard", "Boss") end},
		Beast		= {"returnpostage", "collectible",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() wakaba:TryPlayAchievementPaper("returnpostage", "Beast") end},
		Greed		= {"secretcard", "collectible",	wakaba.Enums.Collectibles.SECRET_CARD,	function() wakaba:TryPlayAchievementPaper("secretcard", "Boss") end},
		Greedier	= {"cranecard", "card",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() wakaba:TryPlayAchievementPaper("cranecard", "Boss") end},

		All 		= {"blessing", "collectible",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() wakaba:TryPlayAchievementPaper("blessing", "Boss") end},
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		istainted = true,
		Heart 		= {"taintedwakabamomsheart"},
		Quartet 		= {"bookofforgotten", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN,	function() wakaba:TryPlayAchievementPaper("bookofforgotten", "Boss") end},
		Duet 		= {"wakabasoul", "card",	wakaba.Enums.Cards.SOUL_WAKABA,	function() wakaba:TryPlayAchievementPaper("wakabasoul", "Boss") end},
		Delirium	= {"eatheart", "collectible",	wakaba.Enums.Collectibles.EATHEART,				function() wakaba:TryPlayAchievementPaper("eatheart", "Boss") end},
		MegaSatan	= {"cloverchest", "null",		nil,			function() wakaba:TryPlayAchievementPaper("cloverchest", "MegaSatan") end},
		Mother		= {"bitcoin", "trinket",	wakaba.Enums.Trinkets.BITCOIN,			function() wakaba:TryPlayAchievementPaper("bitcoin", "Boss") end},
		Beast		= {"nemesis", "collectible",	wakaba.Enums.Collectibles.WAKABAS_NEMESIS,		function() wakaba:TryPlayAchievementPaper("nemesis", "Beast") end},
		Greedier	= {"blackjoker", "card",		wakaba.Enums.Cards.CARD_BLACK_JOKER,			function() wakaba:TryPlayAchievementPaper("blackjoker", "Boss") end},
	},
	[wakaba.Enums.Players.SHIORI] = {
		Heart 		= {"hardbook", "trinket", 		wakaba.Enums.Trinkets.HARD_BOOK,		function() wakaba:TryPlayAchievementPaper("hardbook", "Boss") end},
		Isaac 		= {"shiorid6plus", "null",	nil,		function() wakaba:TryPlayAchievementPaper("shiorid6plus", "Boss") end},
		BlueBaby 	= {"deckofrunes", "collectible",	wakaba.Enums.Collectibles.BOTTLE_OF_RUNES,		function() wakaba:TryPlayAchievementPaper("deckofrunes", "Boss") end},
		Satan 		= {"bookoffocus", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_FOCUS,		function() wakaba:TryPlayAchievementPaper("bookoffocus", "Boss") end},
		Lamb		= {"grimreaperdefender", "collectible",	wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER,				function() wakaba:TryPlayAchievementPaper("grimreaperdefender", "Boss") end},
		BossRush	= {"unknownbookmark", "card",	wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK,				function() wakaba:TryPlayAchievementPaper("unknownbookmark", "Boss") end},
		Hush		= {"bookoftrauma", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_TRAUMA,		function() wakaba:TryPlayAchievementPaper("bookoftrauma", "Boss") end},
		Delirium	= {"bookofsilence", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_SILENCE,				function() wakaba:TryPlayAchievementPaper("bookofsilence", "Boss") end},
		MegaSatan	= {"bookoffallen", "collectible",		wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN,			function() wakaba:TryPlayAchievementPaper("bookoffallen", "MegaSatan") end},
		Mother		= {"vintagethreat", "collectible",	wakaba.Enums.Collectibles.VINTAGE_THREAT,			function() wakaba:TryPlayAchievementPaper("vintagethreat", "Boss") end},
		Beast		= {"bookofthegod", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_THE_GOD,		function() wakaba:TryPlayAchievementPaper("bookofthegod", "Beast") end},
		Greed		= {"magnetheaven", "trinket",	wakaba.Enums.Trinkets.MAGNET_HEAVEN,	function() wakaba:TryPlayAchievementPaper("magnetheaven", "Boss") end},
		Greedier	= {"determinationribbon", "trinket",		wakaba.Enums.Trinkets.DETERMINATION_RIBBON,			function() wakaba:TryPlayAchievementPaper("determinationribbon", "Boss") end},

		All 		= {"bookofshiori", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_SHIORI,	function() wakaba:TryPlayAchievementPaper("bookofshiori", "Boss") end},
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		istainted = true,
		Heart 		= {"taintedshiorimomsheart"},
		Quartet 		= {"bookmarkbag", "trinket",	wakaba.Enums.Trinkets.BOOKMARK_BAG,	function() wakaba:TryPlayAchievementPaper("bookmarkbag", "Boss") end},
		Duet 		= {"shiorisoul", "card",	wakaba.Enums.Cards.SOUL_SHIORI,	function() wakaba:TryPlayAchievementPaper("shiorisoul", "Boss") end},
		Delirium	= {"bookofconquest", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_CONQUEST,				function() wakaba:TryPlayAchievementPaper("bookofconquest", "Boss") end},
		MegaSatan	= {"shiorivalut", "card",		wakaba.Enums.Cards.CARD_VALUT_RIFT,			function() wakaba:TryPlayAchievementPaper("anotherfortunemachine", "MegaSatan") end},
		Mother		= {"ringofjupiter", "trinket",	wakaba.Enums.Trinkets.RING_OF_JUPITER,			function() wakaba:TryPlayAchievementPaper("ringofjupiter", "Boss") end},
		Beast		= {"minervaaura", "collectible",	wakaba.Enums.Collectibles.MINERVA_AURA,		function() wakaba:TryPlayAchievementPaper("minervaaura", "Beast") end},
		Greedier	= {"queenofspades", "card",		wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES,			function() wakaba:TryPlayAchievementPaper("queenofspades", "Boss") end},
	},
	[wakaba.Enums.Players.TSUKASA] = {
		Heart 		= {"murasame", "collectible", 		wakaba.Enums.Collectibles.MURASAME,		function() wakaba:TryPlayAchievementPaper("murasame", "Boss") end},
		Isaac 		= {"nasalover", "collectible",	wakaba.Enums.Collectibles.NASA_LOVER,		function() wakaba:TryPlayAchievementPaper("nasalover", "Boss") end},
		BlueBaby 	= {"redcorruption", "collectible",	wakaba.Enums.Collectibles.RED_CORRUPTION,		function() wakaba:TryPlayAchievementPaper("totalcorruption", "Boss") end},
		Satan 		= {"beetlejuice", "collectible",	wakaba.Enums.Collectibles.BEETLEJUICE,		function() wakaba:TryPlayAchievementPaper("beetlejuice", "Boss") end},
		Lamb		= {"powerbomb", "collectible",	wakaba.Enums.Collectibles.POWER_BOMB,				function() wakaba:TryPlayAchievementPaper("powerbomb", "Boss") end},
		BossRush	= {"concentration", "collectible",	wakaba.Enums.Collectibles.CONCENTRATION,				function() wakaba:TryPlayAchievementPaper("concentration", "Boss") end},
		Hush		= {"rangeos", "trinket",	wakaba.Enums.Trinkets.RANGE_OS,		function() wakaba:TryPlayAchievementPaper("rangeos", "Boss") end},
		Delirium	= {"newyearbomb", "collectible",	wakaba.Enums.Collectibles.NEW_YEAR_EVE_BOMB,				function() wakaba:TryPlayAchievementPaper("newyearbomb", "Boss") end},
		MegaSatan	= {"plasmabeam", "collectible",		wakaba.Enums.Collectibles.PLASMA_BEAM,			function() wakaba:TryPlayAchievementPaper("plasmabeam", "MegaSatan") end},
		Mother		= {"phantomcloak", "collectible",	wakaba.Enums.Collectibles.PHANTOM_CLOAK,			function() wakaba:TryPlayAchievementPaper("phantomcloak", "Boss") end},
		Beast		= {"magmablade", "collectible",	wakaba.Enums.Collectibles.MAGMA_BLADE,		function() wakaba:TryPlayAchievementPaper("magmablade", "Beast") end},
		Greed		= {"arcanecrystal", "collectible",	wakaba.Enums.Collectibles.ARCANE_CRYSTAL,	function() wakaba:TryPlayAchievementPaper("arcanecrystal", "Boss") end},
		Greedier	= {"questionblock", "collectible",		wakaba.Enums.Collectibles.QUESTION_BLOCK,			function() wakaba:TryPlayAchievementPaper("questionblock", "Boss") end},

		All 		= {"lunarstone", "collectible",	wakaba.Enums.Collectibles.LUNAR_STONE,	function() wakaba:TryPlayAchievementPaper("lunarstone", "Boss") end},
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		istainted = true,
		Heart 		= {"taintedtsukasamomsheart"},
		Quartet 		= {"isaaccartridge", "trinket",	wakaba.Enums.Trinkets.ISAAC_CARTRIDGE,	function() wakaba:TryPlayAchievementPaper("isaaccartridge", "Boss") end},
		Duet 		= {"tsukasasoul", "card",	wakaba.Enums.Cards.SOUL_TSUKASA,	function() wakaba:TryPlayAchievementPaper("tsukasasoul", "Boss") end},
		Delirium	= {"flashshift", "collectible",	wakaba.Enums.Collectibles.FLASH_SHIFT,				function() wakaba:TryPlayAchievementPaper("flashshift", "Boss") end},
		MegaSatan	= {"easteregg", "trinket",		wakaba.Enums.Trinkets.AURORA_GEM,			function() wakaba:TryPlayAchievementPaper("easteregg", "MegaSatan") end},
		Mother		= {"sirenbadge", "trinket",	wakaba.Enums.Trinkets.SIREN_BADGE,			function() wakaba:TryPlayAchievementPaper("sirenbadge", "Boss") end},
		Beast		= {"elixiroflife", "collectible",	wakaba.Enums.Collectibles.ELIXIR_OF_LIFE,		function() wakaba:TryPlayAchievementPaper("elixiroflife", "Beast") end},
		Greedier	= {"returntoken", "card",		wakaba.Enums.Cards.CARD_RETURN_TOKEN,			function() wakaba:TryPlayAchievementPaper("returntoken", "Boss") end},
	},
	[wakaba.Enums.Players.RICHER] = {
		Heart 		= {"fireflylighter", "collectible", 		wakaba.Enums.Collectibles.FIREFLY_LIGHTER,		function() wakaba:TryPlayAchievementPaper("fireflylighter", "Boss") end},
		Isaac 		= {"sweetscatalog", "collectible",	wakaba.Enums.Collectibles.SWEETS_CATALOG,		function() wakaba:TryPlayAchievementPaper("sweetscatalog", "Boss") end},
		BlueBaby 	= {"doubleinvader", "collectible",	wakaba.Enums.Collectibles.DOUBLE_INVADER,		function() wakaba:TryPlayAchievementPaper("doubleinvader", "Boss") end},
		Satan 		= {"antibalance", "collectible",	wakaba.Enums.Collectibles.ANTI_BALANCE,		function() wakaba:TryPlayAchievementPaper("antibalance", "Boss") end},
		Lamb		= {"venomincantation", "collectible",	wakaba.Enums.Collectibles.VENOM_INCANTATION,				function() wakaba:TryPlayAchievementPaper("venomincantation", "Boss") end},
		BossRush	= {"bunnyparfait", "collectible",	wakaba.Enums.Collectibles.BUNNY_PARFAIT,				function() wakaba:TryPlayAchievementPaper("bunnyparfait", "Boss") end},
		Hush		= {"richeruniform", "collectible",	wakaba.Enums.Collectibles.RICHERS_UNIFORM,		function() wakaba:TryPlayAchievementPaper("richeruniform", "Boss") end},
		Delirium	= {"prestigepass", "collectible",	wakaba.Enums.Collectibles.PRESTIGE_PASS,				function() wakaba:TryPlayAchievementPaper("prestigepass", "Boss") end},
		MegaSatan	= {"printer", "collectible",		wakaba.Enums.Collectibles._3D_PRINTER,			function() wakaba:TryPlayAchievementPaper("3dprinter", "MegaSatan") end},
		Mother		= {"cunningpaper", "collectible",	wakaba.Enums.Collectibles.CUNNING_PAPER,			function() wakaba:TryPlayAchievementPaper("cunningpaper", "Boss") end},
		Beast		= {"selfburning", "collectible",	wakaba.Enums.Collectibles.SELF_BURNING,		function() wakaba:TryPlayAchievementPaper("selfburning", "Beast") end},
		Greed		= {"clensingfoam", "collectible",	wakaba.Enums.Collectibles.CLENSING_FOAM,	function() wakaba:TryPlayAchievementPaper("clensingfoam", "Boss") end},
		Greedier	= {"lilricher", "collectible",		wakaba.Enums.Collectibles.LIL_RICHER,			function() wakaba:TryPlayAchievementPaper("lilricher", "Boss") end},

		All 		= {"rabbitribbon", "collectible",	wakaba.Enums.Collectibles.RABBIT_RIBBON,	function() wakaba:TryPlayAchievementPaper("rabbitribbon", "Boss") end},
	},
	[wakaba.Enums.Players.RICHER_B] = {
		istainted = true,
		Heart 		= {"taintedrichermomsheart"},
		Quartet 		= {"starreversal", "trinket",	wakaba.Enums.Trinkets.STAR_REVERSAL,	function() wakaba:TryPlayAchievementPaper("starreversal", "Boss") end},
		Duet 		= {"richersoul", "card",	wakaba.Enums.Cards.SOUL_RICHER,	function() wakaba:TryPlayAchievementPaper("richersoul", "Boss") end},
		Delirium	= {"waterflame", "collectible",	wakaba.Enums.Collectibles.WATER_FLAME,				function() wakaba:TryPlayAchievementPaper("waterflame", "Boss") end},
		MegaSatan	= {"crystalrestock", "null",		nil,			function() wakaba:TryPlayAchievementPaper("crystalrestock", "MegaSatan") end},
		Mother		= {"eternitycookie", "trinket",	wakaba.Enums.Trinkets.ETERNITY_COOKIE,			function() wakaba:TryPlayAchievementPaper("eternitycookie", "Boss") end},
		Beast		= {"winteralbireo", "collectible",	wakaba.Enums.Collectibles.WINTER_ALBIREO,		function() wakaba:TryPlayAchievementPaper("winteralbireo", "Beast") end},
		Greedier	= {"trialstew", "card",		wakaba.Enums.Cards.CARD_TRIAL_STEW,			function() wakaba:TryPlayAchievementPaper("trialstew", "Boss") end},
	},
	[wakaba.Enums.Players.RIRA] = {
		Heart 		= {"blackbeanmochi", "collectible", 		wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI,		function() wakaba:TryPlayAchievementPaper("blackbeanmochi", "Boss") end},
		Isaac 		= {"nerfgun", "collectible",	wakaba.Enums.Collectibles.NERF_GUN,		function() wakaba:TryPlayAchievementPaper("nerfgun", "Boss") end},
		BlueBaby 	= {"sakuramontblanc", "collectible",	wakaba.Enums.Collectibles.SAKURA_MONT_BLANC,		function() wakaba:TryPlayAchievementPaper("sakuramontblanc", "Boss") end},
		Satan 		= {"riraswimsuit", "collectible",	wakaba.Enums.Collectibles.RIRAS_SWIMSUIT,		function() wakaba:TryPlayAchievementPaper("riraswimsuit", "Boss") end},
		Lamb		= {"chewyrollycake", "collectible",	wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE,				function() wakaba:TryPlayAchievementPaper("chewyrollycake", "Boss") end},
		BossRush	= {"caramellapancake", "collectible",	wakaba.Enums.Collectibles.CARAMELLA_PANCAKE,				function() wakaba:TryPlayAchievementPaper("caramellapancake", "Boss") end},
		Hush		= {"rirauniform", "collectible",	wakaba.Enums.Collectibles.RIRAS_UNIFORM,		function() wakaba:TryPlayAchievementPaper("rirauniform", "Boss") end},
		Delirium	= {"rirabandage", "collectible",	wakaba.Enums.Collectibles.RIRAS_BANDAGE,				function() wakaba:TryPlayAchievementPaper("rirabandage", "Boss") end},
		MegaSatan	= {"rirabento", "collectible",		wakaba.Enums.Collectibles.RIRAS_BENTO,			function() wakaba:TryPlayAchievementPaper("rirabento", "MegaSatan") end},
		Mother		= {"sakuracapsule", "collectible",	wakaba.Enums.Collectibles.SAKURA_CAPSULE,			function() wakaba:TryPlayAchievementPaper("sakuracapsule", "Boss") end},
		Beast		= {"maidduet", "collectible",	wakaba.Enums.Collectibles.MAID_DUET,		function() wakaba:TryPlayAchievementPaper("maidduet", "Beast") end},
		Greed		= {"rabbitpillow", "trinket",	wakaba.Enums.Trinkets.RABBIT_PILLOW,	function() wakaba:TryPlayAchievementPaper("rabbitpillow", "Boss") end},
		Greedier	= {"lilrira", "collectible",		wakaba.Enums.Collectibles.LIL_RIRA,			function() wakaba:TryPlayAchievementPaper("lilrira", "Boss") end},

		All 		= {"chimaki", "collectible",	wakaba.Enums.Collectibles.CHIMAKI,	function() wakaba:TryPlayAchievementPaper("chimaki", "Boss") end},
	},
	[wakaba.Enums.Players.RIRA_B] = {
		istainted = true,
		Heart 		= {"taintedriramomsheart"},
		Quartet 		= {"caramellacandybag", "trinket",	wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG,	function() wakaba:TryPlayAchievementPaper("caramellacandybag", "Boss") end},
		Duet 		= {"rirasoul", "card",	wakaba.Enums.Cards.SOUL_RICHER,	function() wakaba:TryPlayAchievementPaper("rirasoul", "Boss") end},
		Delirium	= {"rabbeyward", "collectible",	wakaba.Enums.Collectibles.WATER_FLAME,				function() wakaba:TryPlayAchievementPaper("rabbeyward", "Boss") end},
		MegaSatan	= {"aquatrinket", "null",		nil,			function() wakaba:TryPlayAchievementPaper("aquatrinket", "MegaSatan") end},
		Mother		= {"pinkfork", "trinket",	wakaba.Enums.Trinkets.PINK_FORK,			function() wakaba:TryPlayAchievementPaper("pinkfork", "Boss") end},
		Beast		= {"azurerir", "collectible",	wakaba.Enums.Collectibles.AZURE_RIR,		function() wakaba:TryPlayAchievementPaper("azurerir", "Beast") end},
		Greedier	= {"flipcard", "card",		wakaba.Enums.Cards.CARD_FLIP,			function() wakaba:TryPlayAchievementPaper("flipcard", "Boss") end},
	},
	[-999] = {
		[wakaba.challenges.CHALLENGE_ELEC] = {"eyeofclock", "collectible",	wakaba.Enums.Collectibles.EYE_OF_CLOCK,	function() wakaba:TryPlayAchievementPaper("eyeofclock", "Boss") end, function(boss) return boss == BossID.MOM end},
		[wakaba.challenges.CHALLENGE_PLUM] = {"plumy", "collectible",	wakaba.Enums.Collectibles.PLUMY,	function() wakaba:TryPlayAchievementPaper("plumy", "Boss") end, function(boss) return boss == BossID.HUSH end},
		--[wakaba.challenges.CHALLENGE_PULL] = {"wakabaorgel", "collectible",	wakaba.Enums.Collectibles.EYE_OF_CLOCK,	function() wakaba:TryPlayAchievementPaper("blank", "Boss") end, function(boss) return boss == BossID.MOM},
		[wakaba.challenges.CHALLENGE_MINE] = {"delimiter", "trinket",	wakaba.Enums.Trinkets.DELIMITER,	function() wakaba:TryPlayAchievementPaper("delimiter", "Boss") end, function(boss) return boss == BossID.HEART or boss == BossID.IT_LIVES end},
		[wakaba.challenges.CHALLENGE_GUPP] = {"nekodoll", "collectible",	wakaba.Enums.Collectibles.NEKO_FIGURE,	function() wakaba:TryPlayAchievementPaper("nekofigure", "Boss") end, function(boss) return boss == BossID.MOTHER end},
		[wakaba.challenges.CHALLENGE_DOPP] = {"microdoppelganger", "collectible",	wakaba.Enums.Collectibles.MICRO_DOPPELGANGER,	function() wakaba:TryPlayAchievementPaper("microdoppelganger", "Boss") end, function(boss) return boss == BossID.HUSH end},
		[wakaba.challenges.CHALLENGE_DELI] = {"delirium", "trinket",	wakaba.Enums.Trinkets.DIMENSION_CUTTER,	function() wakaba:TryPlayAchievementPaper("dimensioncutter", "Boss") end, function(boss) return boss == BossID.DELIRIUM end},
		[wakaba.challenges.CHALLENGE_SIST] = {"lilwakaba", "collectible",	wakaba.Enums.Collectibles.LIL_WAKABA,	function() wakaba:TryPlayAchievementPaper("lilwakaba", "Boss") end, function(boss) return boss == BossID.LAMB end},
		[wakaba.challenges.CHALLENGE_DRAW] = {"lostuniform", "null",	nil,	function() wakaba:TryPlayAchievementPaper("lostuniform", "Boss") end, function(boss) return boss == BossID.BLUE_BABY end},
		[wakaba.challenges.CHALLENGE_HUSH] = {"executioner", "collectible",	wakaba.Enums.Collectibles.EXECUTIONER,	function() wakaba:TryPlayAchievementPaper("executioner", "Boss") end, function(boss) return boss == BossID.HUSH end},
		[wakaba.challenges.CHALLENGE_APPL] = {"apollyoncrisis", "collectible",	wakaba.Enums.Collectibles.APOLLYON_CRISIS,	function() wakaba:TryPlayAchievementPaper("apollyoncrisis", "Boss") end, function(boss) return boss == BossID.LAMB end},
		[wakaba.challenges.CHALLENGE_BIKE] = {"deliverysystem", "collectible",	wakaba.Enums.Collectibles.ISEKAI_DEFINITION,	function() wakaba:TryPlayAchievementPaper("isekaidefinition", "Boss") end, function(boss) return boss == BossID.DELIRIUM end},
		[wakaba.challenges.CHALLENGE_CALC] = {"calculation", "collectible",	wakaba.Enums.Collectibles.BALANCE,	function() wakaba:TryPlayAchievementPaper("balance", "Boss") end, function(boss) return boss == BossID.MEGA_SATAN end},
		[wakaba.challenges.CHALLENGE_HOLD] = {"lilmao", "collectible",	wakaba.Enums.Collectibles.LIL_MAO,	function() wakaba:TryPlayAchievementPaper("lilmao", "Boss") end, function(boss) return boss == BossID.MOTHER end},
		[wakaba.challenges.CHALLENGE_EVEN] = {"richerflipper", "collectible",	wakaba.Enums.Collectibles.RICHERS_FLIPPER,	function() wakaba:TryPlayAchievementPaper("richerflipper", "Boss") end, function(boss) return boss == BossID.MOTHER end},
		[wakaba.challenges.CHALLENGE_RNPR] = {"richernecklace", "collectible",	wakaba.Enums.Collectibles.RICHERS_NECKLACE,	function() wakaba:TryPlayAchievementPaper("richernecklace", "Boss") end, function(boss) return boss == BossID.DELIRIUM end},
		[wakaba.challenges.CHALLENGE_LAVA] = {"crossbomb", "collectible",	wakaba.Enums.Collectibles.CROSS_BOMB,	function() wakaba:TryPlayAchievementPaper("crossbomb", "Boss") end, function(boss) return boss == BossID.LAMB end},
		[wakaba.challenges.CHALLENGE_RAND] = {"edensticky", "collectible",	wakaba.Enums.Collectibles.STICKY_NOTE,	function() wakaba:TryPlayAchievementPaper("edensticky", "Boss") end, function(boss) return boss == BossID.DELIRIUM end},
		[wakaba.challenges.CHALLENGE_DRMS] = {"doubledreams", "collectible",	wakaba.Enums.Collectibles.DOUBLE_DREAMS,	function() wakaba:TryPlayAchievementPaper("doubledreams", "Boss") end, function(boss) return boss == BossID.BEAST end},
	}
}

wakaba.LinkedCompletionUnlocks = {
	{wakaba.Enums.Cards.SOUL_WAKABA2, "card", wakaba.Enums.Cards.SOUL_WAKABA, "card"},
	{wakaba.Enums.Collectibles.ADVANCED_CRYSTAL, "collectible", wakaba.Enums.Collectibles.ARCANE_CRYSTAL, "collectible"},
	{wakaba.Enums.Collectibles.MYSTIC_CRYSTAL, "collectible", wakaba.Enums.Collectibles.ARCANE_CRYSTAL, "collectible"},
	{wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE, "trinket", wakaba.Enums.Trinkets.ISAAC_CARTRIDGE, "trinket"},
	{wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE, "trinket", wakaba.Enums.Trinkets.ISAAC_CARTRIDGE, "trinket"},
	{wakaba.Enums.Trinkets.CANDY_OF_RICHER, "trinket", wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG, "trinket"},
	{wakaba.Enums.Trinkets.CANDY_OF_RIRA, "trinket", wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG, "trinket"},
	{wakaba.Enums.Trinkets.CANDY_OF_CIEL, "trinket", wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG, "trinket"},
	{wakaba.Enums.Trinkets.CANDY_OF_KORON, "trinket", wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG, "trinket"},
}

function wakaba:CanRunUnlockAchievements(forceNew) -- Made in conjunction with Thicco Catto
	if wakaba.CurrentRunCanGrantUnlocks ~= nil and not forceNew then return wakaba.CurrentRunCanGrantUnlocks end

	local machine = Isaac.Spawn(6, 11, 0, Vector.Zero, Vector.Zero, nil)
	wakaba.CurrentRunCanGrantUnlocks = machine:Exists()
	machine:Remove()

	return wakaba.CurrentRunCanGrantUnlocks
end

function wakaba:GetUnlockValuesFromBoss(playerType, bossName)
	local unlocksTable = wakaba.UnlockTables[playerType]
	local value = unlocksTable[bossName] and unlocksTable[bossName][1] or ""
	if bossName == "Isaac" then
		value = (unlocksTable["Quartet"] and (unlocksTable["Quartet"][1] .. "1")) or value
	elseif bossName == "Satan" then
		value = (unlocksTable["Quartet"] and (unlocksTable["Quartet"][1] .. "2")) or value
	elseif bossName == "BlueBaby" then
		value = (unlocksTable["Quartet"] and (unlocksTable["Quartet"][1] .. "3")) or value
	elseif bossName == "Lamb" then
		value = (unlocksTable["Quartet"] and (unlocksTable["Quartet"][1] .. "4")) or value
	elseif bossName == "BossRush" then
		value = (unlocksTable["Duet"] and (unlocksTable["Duet"][1] .. "1")) or value
	elseif bossName == "Hush" then
		value = (unlocksTable["Duet"] and (unlocksTable["Duet"][1] .. "2")) or value
	elseif bossName == "Greed" and unlocksTable.istainted then
		value = (unlocksTable["Greedier"] and (unlocksTable["Greedier"][1])) or value
	end
	return wakaba.state.unlock[value] or 0
end

function wakaba:GetCompletionNoteLayerDataFromPlayerType(playerType)
	local dataset = wakaba.UnlockTables[playerType]
	return {
		[noteLayer.DELI] 	= wakaba:GetUnlockValuesFromBoss(playerType, "Delirium") + (dataset.istainted and 3 or 0),
		[noteLayer.HEART] 	= wakaba:GetUnlockValuesFromBoss(playerType, "Heart"),
		[noteLayer.ISAAC] 	= wakaba:GetUnlockValuesFromBoss(playerType, "Isaac"),
		[noteLayer.SATAN] 	= wakaba:GetUnlockValuesFromBoss(playerType, "Satan"),
		[noteLayer.RUSH] 	= wakaba:GetUnlockValuesFromBoss(playerType, "BossRush"),
		[noteLayer.BBABY] 	= wakaba:GetUnlockValuesFromBoss(playerType, "BlueBaby"),
		[noteLayer.LAMB] 	= wakaba:GetUnlockValuesFromBoss(playerType, "Lamb"),
		[noteLayer.MEGA] 	= wakaba:GetUnlockValuesFromBoss(playerType, "MegaSatan"),
		[noteLayer.GREED] 	= wakaba:GetUnlockValuesFromBoss(playerType, "Greed"),
		[noteLayer.HUSH] 	= wakaba:GetUnlockValuesFromBoss(playerType, "Hush"),
		[noteLayer.MOTHER] 	= wakaba:GetUnlockValuesFromBoss(playerType, "Mother"),
		[noteLayer.BEAST] 	= wakaba:GetUnlockValuesFromBoss(playerType, "Beast"),
	}
end

function wakaba:GetUnlocksTemplate(playerType)
	local dataset = wakaba:GetCompletionNoteLayerDataFromPlayerType(playerType)
	return {
		MomsHeart = {Unlock = false, Hard = false},
		Isaac = {Unlock = false, Hard = false},
		Satan = {Unlock = false, Hard = false},
		BlueBaby = {Unlock = false, Hard = false},
		Lamb = {Unlock = false, Hard = false},
		BossRush = {Unlock = false, Hard = false},
		Hush = {Unlock = false, Hard = false},
		MegaSatan = {Unlock = false, Hard = false},
		Delirium = {Unlock = false, Hard = false},
		Mother = {Unlock = false, Hard = false},
		Beast = {Unlock = false, Hard = false},
		GreedMode = {Unlock = false, Hard = false},
	}
end

local translationTable = {
	Heart = "MomsHeart",
	Satan = "Satan",
	Isaac = "Isaac",
	BlueBaby = "BlueBaby",
	Lamb = "Lamb",
	BossRush = "BossRush",
	Hush = "Hush",
	MegaSatan = "MegaSatan",
	Delirium = "Delirium",
	Mother = "Mother",
	Beast = "Beast",
	Greed = "GreedMode",
}

function wakaba:GetEncyPaper(playerType)
	local dataset = wakaba:GetCompletionNoteLayerDataFromPlayerType(playerType)
	local UnlockTables = {}
	for ep, enc in pairs(translationTable) do
		local mark = wakaba:GetUnlockValuesFromBoss(playerType, ep)
		UnlockTables[enc] = {
			Unlock = (mark > 0 and true or false),
			Hard = (mark > 1 and true or false),
		}
	end
	return UnlockTables
end

function wakaba:GetUnlockMeta(playerType, unlockType)
	if wakaba.UnlockTables[playerType] then
		local unlockCheckStr = ""
		local unlockTable = wakaba.UnlockTables[playerType]
		local metaTable
		if unlockTable.istainted then
			if unlockType == "BossRush" then
				unlockCheckStr = unlockTable.Duet[1].."1"
				metaTable = unlockTable.Duet
			elseif unlockType == "Hush" then
				unlockCheckStr = unlockTable.Duet[1].."2"
				metaTable = unlockTable.Duet
			elseif unlockType == "Isaac" then
				unlockCheckStr = unlockTable.Quartet[1].."1"
				metaTable = unlockTable.Quartet
			elseif unlockType == "Satan" then
				unlockCheckStr = unlockTable.Quartet[1].."2"
				metaTable = unlockTable.Quartet
			elseif unlockType == "BlueBaby" then
				unlockCheckStr = unlockTable.Quartet[1].."3"
				metaTable = unlockTable.Quartet
			elseif unlockType == "Lamb" then
				unlockCheckStr = unlockTable.Quartet[1].."4"
				metaTable = unlockTable.Quartet
			elseif unlockTable[unlockType] then
				unlockCheckStr = unlockTable[unlockType][1]
				metaTable = unlockTable[unlockType]
			end
		elseif unlockTable[unlockType] then
			unlockCheckStr = unlockTable[unlockType][1]
			metaTable = unlockTable[unlockType]
		end
		if unlockCheckStr ~= "" then
			return unlockCheckStr, metaTable
		end
	end
end

function wakaba:GetUnlockEntry(playerType, unlockType)
	local unlockCheckStr, meta = wakaba:GetUnlockMeta(playerType, unlockType)
	return unlockCheckStr
end

function wakaba:IsCompletionItemUnlockedTemp(itemID, typeString, pricise)
	typeString = typeString or "collectible"
	local flagBlacklist = wakaba.Blacklists.FlagLock[typeString] and wakaba.Blacklists.FlagLock[typeString][itemID]
	if flagBlacklist and type(flagBlacklist) == "function" and flagBlacklist() then
		wakaba.Log(typeString, itemID, "Blacklisted by flag")
		return false
	end
	if (not wakaba.state.achievementPopupShown or wakaba.state.options.allowlockeditems) and not pricise then
		return true
	end
	for _, linkedTable in ipairs(wakaba.LinkedCompletionUnlocks) do
		if linkedTable[1] == itemID and linkedTable[2] == typeString and linkedTable[3] ~= nil then
			itemID = linkedTable[3]
			typeString = linkedTable[4]
			break
		end
	end
	--print("trying to find :", itemID, typeString)
	for playerType, unlocksTable in pairs(wakaba.UnlockTables) do
		for k, v in pairs(unlocksTable) do
			if type(v) == "table" then
				if v[2] ~= nil and v[2] == typeString then
					if v[3] == itemID then
						--print("found key :", v[1])
						local unlockStateVal = wakaba.state.unlock[v[1]]
						if type(unlockStateVal) == "boolean" then
							return unlockStateVal
						elseif type(unlockStateVal) == "number" then
							return unlockStateVal > 0
						end
					end
				end
			end
		end
	end
	return true
end

function wakaba:IsEntryUnlocked(entryName, precise)
	if wakaba.state.options.allowlockeditems and not precise then
		return true
	end
	if not entryName then
		return false
	end
	local unlockStateVal = wakaba.state.unlock[entryName]
	if type(unlockStateVal) == "boolean" then
		return unlockStateVal
	elseif type(unlockStateVal) == "number" then
		return unlockStateVal > 0
	end
	return false
end

local function HasPlayerAchievedQuartetTemp(playerType)
	local unlockTable = wakaba.UnlockTables[playerType]
	if not unlockTable then
		return
	end
	local unlockCheckStr = unlockTable.Quartet[1]

	return (
		wakaba.state.unlock[unlockCheckStr.."1"] >= 1 and
		wakaba.state.unlock[unlockCheckStr.."2"] >= 1 and
		wakaba.state.unlock[unlockCheckStr.."3"] >= 1 and
		wakaba.state.unlock[unlockCheckStr.."4"] >= 1
	)
end

local function HasPlayerAchievedDuetTemp(playerType)
	local unlockTable = wakaba.UnlockTables[playerType]
	if not unlockTable then
		return
	end
	local unlockCheckStr = unlockTable.Duet[1]

	return (
		wakaba.state.unlock[unlockCheckStr.."1"] >= 1 and
		wakaba.state.unlock[unlockCheckStr.."2"] >= 1
	)
end

local function TestUnlock(playerType, unlockType)
	if unlockType == "All" then
		local allHard = true

		for key, value in pairs(wakaba.UnlockTables[playerType]) do
			if type(value) == "table" then
				if type(wakaba.state.unlock[value[1]]) == "number" then
					if wakaba.state.unlock[value[1]] < 2 then
						allHard = false
						break
					end
				end
			end
		end

		return allHard
	elseif unlockType == "Quartet" then
		return HasPlayerAchievedQuartetTemp(playerType)
	elseif unlockType == "Duet" then
		return HasPlayerAchievedDuetTemp(playerType)
	else
		return wakaba.state.unlock[wakaba.UnlockTables[playerType][unlockType][1]] >= associationTestValue[unlockType]
	end
end

local function CheckOnCompletionFunctions(playerKey, unlockKey, newValue, skipAll)
	if unlocksHolder[playerKey] and unlocksHolder[playerKey][unlockKey] then
		if unlockKey ~= "All" and wakaba.state.completion[playerKey][associationToValueMap[unlockKey]] < associationTestValue[unlockKey] and newValue >= associationTestValue[unlockKey] then
			if unlocksHolder[playerKey][unlockKey] then
				unlocksHolder[playerKey][unlockKey][4]()
			end
		end

		if unlockKey ~= "Greed" and not skipAll then
			local allHard = true
			local oldAllHard

			for key, value in pairs(wakaba.state.completion[playerKey]) do
				if type(value) == "number" then
					local num = value
					if num < 2 then
						oldAllHard = false
					end

					if key == associationToValueMap[unlockKey] then
						num = newValue
					end

					if num < 2 then
						allHard = false
						break
					end
				end
			end

			if allHard and not oldAllHard and unlocksHolder[playerKey].All then
				unlocksHolder[playerKey].All[4]()
			end
		end
	end
end

function wakaba:UnlockWithPopupsTemp(playerType, bossEntry, newValue, shouldShowPopup)
	local unlockTable = wakaba.UnlockTables[playerType]
	if not unlockTable then
		return
	end
	local unlockKeyToCheck = bossEntry
	local skipAll = false
	local unlockKeyAppend = ""
	if unlockTable.istainted then
		if bossEntry == "Isaac" then
			unlockKeyToCheck = "Quartet"
			unlockKeyAppend = "1"
		elseif bossEntry == "Satan" then
			unlockKeyToCheck = "Quartet"
			unlockKeyAppend = "2"
		elseif bossEntry == "BlueBaby" then
			unlockKeyToCheck = "Quartet"
			unlockKeyAppend = "3"
		elseif bossEntry == "Lamb" then
			unlockKeyToCheck = "Quartet"
			unlockKeyAppend = "4"
		elseif bossEntry == "BossRush" then
			unlockKeyToCheck = "Duet"
			unlockKeyAppend = "1"
		elseif bossEntry == "Hush" then
			unlockKeyToCheck = "Duet"
			unlockKeyAppend = "2"
		end
	end
	local unlockKey = unlockTable[unlockKeyToCheck][1]
	if wakaba.state.unlock[unlockKey..unlockKeyAppend] < associationTestValue[bossEntry] and newValue >= associationTestValue[bossEntry] then
		if unlockTable[unlockKeyToCheck][4] and shouldShowPopup then
			unlockTable[unlockKeyToCheck][4]()
		end
	end

	if unlockKey ~= "Greed" and not skipAll then
		local allHard = true
		local oldAllHard = TestUnlock(playerType, "All")
		--print("allHard", allHard)
		--print("oldAllHard", oldAllHard)

		for key, valTable in pairs(unlockTable) do
			if type(valTable) == "table" then
				local value = wakaba.state.unlock[valTable[1]]
				if type(value) == "number" then
					local num = value
					if num < 2 then
						--print("old detected:", key, num)
						oldAllHard = false
					end
					--print("-------:", key, unlockKeyToCheck)

					if key == unlockKeyToCheck then
						num = newValue
					end

					--[[ if key == associationToValueMap[bossEntry] then
						num = newValue
					end ]]

					if num < 2 then
						--print("detected:", key, num)
						allHard = false
						break
					end
				end
			end
		end
		--print("final:", allHard, not oldAllHard, unlockTable.All)

		if allHard and not oldAllHard and unlockTable.All then
			if shouldShowPopup then
				unlockTable.All[4]()
			end
			return "All"
		end
	end

end

function wakaba:TestAchievement(id)
	CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite[id])
end

local function TryUnlock(playerType, unlockType, value, shouldShowPopup)
	local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
	local oldValue = wakaba.state.unlock[saveEntry]
	if value > oldValue then
		wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
	end

	wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
end

local validPlayerCheck = {
	wakaba.Enums.Players.WAKABA,
	wakaba.Enums.Players.WAKABA_B,
	wakaba.Enums.Players.SHIORI,
	wakaba.Enums.Players.SHIORI_B,
	wakaba.Enums.Players.TSUKASA,
	wakaba.Enums.Players.TSUKASA_B,
	wakaba.Enums.Players.RICHER,
	wakaba.Enums.Players.RICHER_B,
	wakaba.Enums.Players.RIRA,
	wakaba.Enums.Players.RIRA_B,
	--wakaba.Enums.Players.WAKABA_T,
	--wakaba.Enums.Players.SHIORI_T,
	--wakaba.Enums.Players.TSUKASA_T,
	--wakaba.Enums.Players.RICHER_T,
	--wakaba.Enums.Players.RIRA_T,
}
wakaba.PlayersToCheckMarks = validPlayerCheck

function wakaba:UnlockCheck(rng, spawnPosition)
	local playersToCheck = {}

	wakaba:ForAllPlayers(function(player)
		if wakaba:has_value(validPlayerCheck, player:GetPlayerType()) then
			if not wakaba:has_value(playersToCheck, player:GetPlayerType()) then
				table.insert(playersToCheck, player:GetPlayerType())
			end
		end
	end)

	local shouldShowPopup = Options.DisplayPopups and not wakaba.state.options.allowlockeditems
	local value = DifficultyToCompletionMap[wakaba.G.Difficulty]

	local level = wakaba.G:GetLevel()
	local currentStage = level:GetAbsoluteStage()
	local currentStageType = level:GetStageType()
	local difficulty = wakaba.G.Difficulty
	local room = wakaba.G:GetRoom()
	local type1 = room:GetType()
	local boss = room:GetBossID()

	-- normal unlock moved to wakaba:Repentogon_TryUnlock
	if not REPENTOGON and wakaba.G.Challenge == Challenge.CHALLENGE_NULL and wakaba.G:GetVictoryLap() <= 0 then
		for _, playerType in ipairs(playersToCheck) do
			local pendingUnlockEntry = nil
			local taintedCompletion = wakaba.UnlockTables[playerType].istainted ~= nil

			if type1 == RoomType.ROOM_DUNGEON and currentStage == 13 and level:GetCurrentRoomDesc().Data.Variant == 666 then
				local unlockType = "Beast"
				local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
				local oldValue = wakaba.state.unlock[saveEntry]
				if value > oldValue then
					pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
				end

				wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
			elseif type1 == RoomType.ROOM_BOSSRUSH then
				local unlockType = "BossRush"
				local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
				local oldValue = wakaba.state.unlock[saveEntry]
				local wasDuetAchieved = taintedCompletion and HasPlayerAchievedDuetTemp(playerType)

				if value > oldValue and not taintedCompletion then
					pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
				end

				wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
				local isDuetAchieved = taintedCompletion and HasPlayerAchievedDuetTemp(playerType)
				if isDuetAchieved and not wasDuetAchieved then
					if shouldShowPopup then
						wakaba.UnlockTables[playerType].Duet[4]()
					end
					pendingUnlockEntry = "Duet"
				end
			elseif type1 == RoomType.ROOM_BOSS then
				if currentStage == LevelStage.STAGE7 then -- Void
					if boss == BossID.DELIRIUM then
						local unlockType = "Delirium"
						local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
						local oldValue = wakaba.state.unlock[saveEntry]
						if value > oldValue then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
					end
				else
					if boss == BossID.HEART or boss == BossID.IT_LIVES or boss == BossID.MAUS_HEART then
						local unlockType = "Heart"
						local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
						local oldValue = wakaba.state.unlock[saveEntry]
						if value > oldValue and not taintedCompletion then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
					elseif boss == BossID.ISAAC then
						local unlockType = "Isaac"
						local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
						local oldValue = wakaba.state.unlock[saveEntry]
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartetTemp(playerType)

						if value > oldValue and not taintedCompletion then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartetTemp(playerType)
						if isQuartetAchieved and not wasQuartetAchieved then
							if shouldShowPopup then
								wakaba.UnlockTables[playerType].Quartet[4]()
							end
							pendingUnlockEntry = "Quartet"
						end
					elseif boss == BossID.BLUE_BABY then
						local unlockType = "BlueBaby"
						local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
						local oldValue = wakaba.state.unlock[saveEntry]
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartetTemp(playerType)

						if value > oldValue and not taintedCompletion then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
						local oldValue = wakaba.state.unlock[saveEntry]
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartetTemp(playerType)
						if isQuartetAchieved and not wasQuartetAchieved then
							if shouldShowPopup then
								wakaba.UnlockTables[playerType].Quartet[4]()
							end
							pendingUnlockEntry = "Quartet"
						end
					elseif boss == BossID.SATAN then
						local unlockType = "Satan"
						local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
						local oldValue = wakaba.state.unlock[saveEntry]
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartetTemp(playerType)

						if value > oldValue and not taintedCompletion then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartetTemp(playerType)
						if isQuartetAchieved and not wasQuartetAchieved then
							if shouldShowPopup then
								wakaba.UnlockTables[playerType].Quartet[4]()
							end
							pendingUnlockEntry = "Quartet"
						end
					elseif boss == BossID.LAMB then
						local unlockType = "Lamb"
						local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
						local oldValue = wakaba.state.unlock[saveEntry]
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartetTemp(playerType)

						if value > oldValue and not taintedCompletion then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartetTemp(playerType)
						if isQuartetAchieved and not wasQuartetAchieved then
							if shouldShowPopup then
								wakaba.UnlockTables[playerType].Quartet[4]()
							end
							pendingUnlockEntry = "Quartet"
						end
					elseif boss == BossID.HUSH then
						local unlockType = "Hush"
						local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
						local oldValue = wakaba.state.unlock[saveEntry]
						local wasDuetAchieved = taintedCompletion and HasPlayerAchievedDuetTemp(playerType)

						if value > oldValue and not taintedCompletion then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
						local isDuetAchieved = taintedCompletion and HasPlayerAchievedDuetTemp(playerType)
						if isDuetAchieved and not wasDuetAchieved then
							if shouldShowPopup then
								wakaba.UnlockTables[playerType].Duet[4]()
							end
							pendingUnlockEntry = "Duet"
						end
					elseif boss == BossID.MEGA_SATAN then
						local unlockType = "MegaSatan"
						local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
						local oldValue = wakaba.state.unlock[saveEntry]
						if value > oldValue then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
					elseif boss == BossID.GREED or boss == BossID.GREEDIER then
						if not taintedCompletion then
							local unlockType = "Greed"
							local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
							local oldValue = wakaba.state.unlock[saveEntry]
							if value > oldValue then
								wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
							end

							wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
						end

						local unlockType2 = "Greedier"
						local saveEntry2 = wakaba:GetUnlockEntry(playerType, unlockType2)
						local oldValue2 = wakaba.state.unlock[saveEntry2]
						if value > oldValue2 then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType2, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry2] = math.max(oldValue2, value)
					elseif boss == BossID.MOTHER then
						local unlockType = "Mother"
						local saveEntry = wakaba:GetUnlockEntry(playerType, unlockType)
						local oldValue = wakaba.state.unlock[saveEntry]
						if value > oldValue then
							pendingUnlockEntry = wakaba:UnlockWithPopupsTemp(playerType, unlockType, value, shouldShowPopup)
						end

						wakaba.state.unlock[saveEntry] = math.max(oldValue, value)
					end
				end
			end
			if pendingUnlockEntry then
				local saveEntry = wakaba:GetUnlockEntry(playerType, pendingUnlockEntry)
				wakaba.state.unlock[saveEntry] = true
			end
		end
	elseif wakaba.G.Challenge >= wakaba.challenges.CHALLENGE_ELEC then
		local unlocksTable = wakaba.UnlockTables[-999]
		if unlocksTable[wakaba.G.Challenge] then
			local unlockTableEntry = unlocksTable[wakaba.G.Challenge]
			if type1 == RoomType.ROOM_DUNGEON and currentStage == 13 and level:GetCurrentRoomDesc().Data.Variant == 666 and unlockTableEntry[5](BossID.BEAST) then
				if wakaba.state.unlock[unlockTableEntry[1]] == false then
					wakaba.state.unlock[unlockTableEntry[1]] = true
					if REPENTOGON then
						wakaba.state.unlock.sync_repentogon = false
					elseif shouldShowPopup then
						unlockTableEntry[4]()
					end
				end
			elseif type1 == RoomType.ROOM_BOSS and unlockTableEntry[5](boss) then
				if wakaba.state.unlock[unlockTableEntry[1]] == false then
					wakaba.state.unlock[unlockTableEntry[1]] = true
					if REPENTOGON then
						wakaba.state.unlock.sync_repentogon = false
					elseif shouldShowPopup then
						unlockTableEntry[4]()
					end
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.UnlockCheck)

function wakaba:LockItems()
  for i = wakaba.FIRST_WAKABA_ITEM, wakaba.LAST_WAKABA_ITEM do
    local isUnlocked = wakaba:unlockCheck(i)
    if not isUnlocked then
      wakaba.Log("Item ID ".. i .. " Not unlocked! removing from the pools...")
      wakaba.G:GetItemPool():RemoveCollectible(i)
    end
    if EID then
      EID.itemUnlockStates[i] = isUnlocked
    end
  end

	for i = wakaba.FIRST_WAKABA_TRINKET, wakaba.LAST_WAKABA_TRINKET do
		if not wakaba:trinketUnlockCheck(i) then
			wakaba.Log("Trinket ID ".. i .. " Not unlocked! removing from the pools...")
			wakaba.G:GetItemPool():RemoveCollectible(i)
		end
	end

end

function wakaba.UniversalRemoveItemFromAllPools(item)
	wakaba:RemoveItemFromCustomItemPools(item)

	local itempool = wakaba.G:GetItemPool()
	itempool:RemoveCollectible(item)
end

function wakaba.UniversalRemoveTrinketFromPools(trinket)
	--wakaba.RemoveTrinketFromCustomItemPools(trinket)

	local itempool = game:GetItemPool()
	itempool:RemoveTrinket(trinket)
end

local unlockTypeToRemoveFunction = {
	collectible	= wakaba.UniversalRemoveItemFromAllPools,
	trinket		= wakaba.UniversalRemoveTrinketFromPools,
}

function wakaba:IsWakabaCharacterUnlocked(player)
  player = player or Isaac.GetPlayer()
  local type = player:GetPlayerType()
  if type == wakaba.Enums.Players.TSUKASA_B and not wakaba.state.unlock.taintedtsukasa then return false end
  if type == wakaba.Enums.Players.RICHER_B and not wakaba.state.unlock.taintedricher then return false end
  return true
end

function wakaba:UnlockEntry(entry)
end

function wakaba:Update_FlagBan()
	if not wakaba.spindownreroll or wakaba.spindownreroll == 0 then return end
	local room = wakaba.G:GetRoom()
	local pedestals = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1)
	for _, pedestal in ipairs(pedestals) do
		local pickup = pedestal:ToPickup()
		local itemID = pickup.SubType

		local flagBlacklist = wakaba.Blacklists.FlagLock.collectible[itemID]
		if flagBlacklist and type(flagBlacklist) == "function" and flagBlacklist() then
			wakaba.Log(typeString, itemID, "Blacklisted by flag")
			wakaba:shiftItem(pickup, wakaba.spindownreroll, 1, true)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_FlagBan)

function wakaba:PickupInit_FlagBan(pickup)
	if not isc:inDeathCertificateArea() then return end
	if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
		local itemID = pickup.SubType

		local flagBlacklist = wakaba.Blacklists.FlagLock.collectible[itemID]
		if flagBlacklist and type(flagBlacklist) == "function" and flagBlacklist() then
			wakaba.Log(typeString, itemID, "Blacklisted by flag")
			pickup:Remove()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PickupInit_FlagBan)




if not REPENTOGON then
	for _, playerType in pairs(wakaba.Enums.Players) do
		if wakaba:has_value(validPlayerCheck, playerType) then
			wakaba.Log("Adding custom pause screen completion mark callbacks for", playerType)
			PauseScreenCompletionMarksAPI:AddModCharacterCallback(playerType, function()
				return wakaba:GetCompletionNoteLayerDataFromPlayerType(playerType)
			end)
		end
	end
end