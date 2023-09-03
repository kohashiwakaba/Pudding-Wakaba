-- main unlock related functions mixed from Fiend Folio, Retribution

local game = Game()
local isc = require("wakaba_src.libs.isaacscript-common")

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

local function TryPlayAchievementPaper(sprite)
	if #wakaba.state.pendingunlock > 0 then
		table.insert(wakaba.state.pendingunlock, sprite)
	else
		CCO.AchievementDisplayAPI.PlayAchievement(sprite)
	end
end

---@type table
wakaba.UnlockTables = {
	[wakaba.Enums.Players.WAKABA] = {
		Heart 		= {"clover", "trinket", 		wakaba.Enums.Trinkets.CLOVER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_clover.png") end},
		Isaac 		= {"counter", "collectible",	wakaba.Enums.Collectibles.COUNTER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_counter.png") end},
		BlueBaby 	= {"pendant", "collectible",	wakaba.Enums.Collectibles.WAKABAS_PENDANT,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_pendant.png") end},
		Satan 		= {"dcupicecream", "collectible",	wakaba.Enums.Collectibles.D_CUP_ICECREAM,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_dcupicecream.png") end},
		Lamb		= {"revengefruit", "collectible",	wakaba.Enums.Collectibles.REVENGE_FRUIT,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_revengefruit.png") end},
		BossRush	= {"donationcard", "card",	wakaba.Enums.Cards.CARD_DREAM_CARD,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_dreamcard.png") end},
		Hush		= {"colorjoker", "card",	wakaba.Enums.Cards.CARD_COLOR_JOKER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_colorjoker.png") end},
		Delirium	= {"wakabauniform", "collectible",	wakaba.Enums.Collectibles.UNIFORM,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_uniform.png") end},
		MegaSatan	= {"whitejoker", "card",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_whitejoker.png") end},
		Mother		= {"confessionalcard", "card",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_confessionalcard.png") end},
		Beast		= {"returnpostage", "collectible",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_returnpostage.png") end},
		Greed		= {"secretcard", "collectible",	wakaba.Enums.Collectibles.SECRET_CARD,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_secretcard.png") end},
		Greedier	= {"cranecard", "card",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_cranecard.png") end},

		All 		= {"blessing", "collectible",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() TryPlayAchievementPaper("gfx/ui/achievement_wakaba/achievement_blessing.png") end},
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		istainted = true,
		Heart 		= {"taintedwakabamomsheart"},
		Quartet 		= {"bookofforgotten", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_bookofforgotten.png") end},
		Duet 		= {"wakabasoul", "card",	wakaba.Enums.Cards.SOUL_WAKABA,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_wakabasoul.png") end},
		Delirium	= {"eatheart", "collectible",	wakaba.Enums.Collectibles.EATHEART,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_eatheart.png") end},
		MegaSatan	= {"cloverchest", "null",		nil,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_cloverchest.png") end},
		Mother		= {"bitcoin", "trinket",	wakaba.Enums.Trinkets.BITCOIN,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_bitcoin.png") end},
		Beast		= {"nemesis", "collectible",	wakaba.Enums.Collectibles.WAKABAS_NEMESIS,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_nemesis.png") end},
		Greedier	= {"blackjoker", "card",		wakaba.Enums.Cards.CARD_BLACK_JOKER,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_blackjoker.png") end},
	},
	[wakaba.Enums.Players.SHIORI] = {
		Heart 		= {"hardbook", "trinket", 		wakaba.Enums.Trinkets.HARD_BOOK,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_hardbook.png") end},
		Isaac 		= {"shiorid6plus", "null",	nil,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_shiorid6plus.png") end},
		BlueBaby 	= {"deckofrunes", "collectible",	wakaba.Enums.Collectibles.BOTTLE_OF_RUNES,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_deckofrunes.png") end},
		Satan 		= {"bookoffocus", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_FOCUS,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_bookoffocus.png") end},
		Lamb		= {"grimreaperdefender", "collectible",	wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_grimreaperdefender.png") end},
		BossRush	= {"unknownbookmark", "card",	wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_unknownbookmark.png") end},
		Hush		= {"bookoftrauma", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_TRAUMA,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_bookoftrauma.png") end},
		Delirium	= {"bookofsilence", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_SILENCE,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_bookofsilence.png") end},
		MegaSatan	= {"bookoffallen", "collectible",		wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_bookoffallen.png") end},
		Mother		= {"vintagethreat", "collectible",	wakaba.Enums.Collectibles.VINTAGE_THREAT,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_vintagethreat.png") end},
		Beast		= {"bookofthegod", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_THE_GOD,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_bookofthegod.png") end},
		Greed		= {"magnetheaven", "trinket",	wakaba.Enums.Trinkets.MAGNET_HEAVEN,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_magnetheaven.png") end},
		Greedier	= {"determinationribbon", "trinket",		wakaba.Enums.Trinkets.DETERMINATION_RIBBON,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_determinationribbon.png") end},

		All 		= {"bookofshiori", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_SHIORI,	function() TryPlayAchievementPaper("gfx/ui/achievement_wakaba/achievement_bookofshiori.png") end},
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		istainted = true,
		Heart 		= {"taintedshiorimomsheart"},
		Quartet 		= {"bookmarkbag", "trinket",	wakaba.Enums.Trinkets.BOOKMARK_BAG,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_bookmarkbag.png") end},
		Duet 		= {"shiorisoul", "card",	wakaba.Enums.Cards.SOUL_SHIORI,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_shiorisoul.png") end},
		Delirium	= {"bookofconquest", "collectible",	wakaba.Enums.Collectibles.BOOK_OF_CONQUEST,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_bookofconquest.png") end},
		MegaSatan	= {"shiorivalut", "null",		nil,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_anotherfortunemachine.png") end},
		Mother		= {"ringofjupiter", "trinket",	wakaba.Enums.Trinkets.RING_OF_JUPITER,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_ringofjupiter.png") end},
		Beast		= {"minervaaura", "collectible",	wakaba.Enums.Collectibles.MINERVA_AURA,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_minervaaura.png") end},
		Greedier	= {"queenofspades", "card",		wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_queenofspades.png") end},
	},
	[wakaba.Enums.Players.TSUKASA] = {
		Heart 		= {"murasame", "collectible", 		wakaba.Enums.Collectibles.MURASAME,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_murasame.png") end},
		Isaac 		= {"nasalover", "collectible",	wakaba.Enums.Collectibles.NASA_LOVER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_nasalover.png") end},
		BlueBaby 	= {"redcorruption", "collectible",	wakaba.Enums.Collectibles.RED_CORRUPTION,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_totalcorruption.png") end},
		Satan 		= {"beetlejuice", "collectible",	wakaba.Enums.Collectibles.BEETLEJUICE,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_beetlejuice.png") end},
		Lamb		= {"powerbomb", "collectible",	wakaba.Enums.Collectibles.POWER_BOMB,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_powerbomb.png") end},
		BossRush	= {"concentration", "collectible",	wakaba.Enums.Collectibles.CONCENTRATION,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_concentration.png") end},
		Hush		= {"rangeos", "trinket",	wakaba.Enums.Trinkets.RANGE_OS,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_rangeos.png") end},
		Delirium	= {"newyearbomb", "collectible",	wakaba.Enums.Collectibles.NEW_YEAR_EVE_BOMB,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_newyearbomb.png") end},
		MegaSatan	= {"plasmabeam", "collectible",		wakaba.Enums.Collectibles.PLASMA_BEAM,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_plasmabeam.png") end},
		Mother		= {"phantomcloak", "collectible",	wakaba.Enums.Collectibles.PHANTOM_CLOAK,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_phantomcloak.png") end},
		Beast		= {"magmablade", "collectible",	wakaba.Enums.Collectibles.MAGMA_BLADE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_magmablade.png") end},
		Greed		= {"arcanecrystal", "collectible",	wakaba.Enums.Collectibles.ARCANE_CRYSTAL,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_arcanecrystal.png") end},
		Greedier	= {"questionblock", "collectible",		wakaba.Enums.Collectibles.QUESTION_BLOCK,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_questionblock.png") end},

		All 		= {"lunarstone", "collectible",	wakaba.Enums.Collectibles.LUNAR_STONE,	function() TryPlayAchievementPaper("gfx/ui/achievement_wakaba/achievement_lunarstone.png") end},
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		istainted = true,
		Heart 		= {"taintedtsukasamomsheart"},
		Quartet 		= {"isaaccartridge", "trinket",	wakaba.Enums.Trinkets.ISAAC_CARTRIDGE,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_isaaccartridge.png") end},
		Duet 		= {"tsukasasoul", "card",	wakaba.Enums.Cards.SOUL_TSUKASA,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_tsukasasoul.png") end},
		Delirium	= {"flashshift", "collectible",	wakaba.Enums.Collectibles.FLASH_SHIFT,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_flashshift.png") end},
		MegaSatan	= {"easteregg", "trinket",		wakaba.Enums.Trinkets.AURORA_GEM,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_easteregg.png") end},
		Mother		= {"sirenbadge", "trinket",	wakaba.Enums.Trinkets.SIREN_BADGE,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_sirenbadge.png") end},
		Beast		= {"elixiroflife", "collectible",	wakaba.Enums.Collectibles.ELIXIR_OF_LIFE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_elixiroflife.png") end},
		Greedier	= {"returntoken", "card",		wakaba.Enums.Cards.CARD_RETURN_TOKEN,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_returntoken.png") end},
	},
	[wakaba.Enums.Players.RICHER] = {
		Heart 		= {"fireflylighter", "collectible", 		wakaba.Enums.Collectibles.FIREFLY_LIGHTER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_fireflylighter.png") end},
		Isaac 		= {"sweetscatalog", "collectible",	wakaba.Enums.Collectibles.SWEETS_CATALOG,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_sweetscatalog.png") end},
		BlueBaby 	= {"doubleinvader", "collectible",	wakaba.Enums.Collectibles.DOUBLE_INVADER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_doubleinvader.png") end},
		Satan 		= {"antibalance", "collectible",	wakaba.Enums.Collectibles.ANTI_BALANCE,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_antibalance.png") end},
		Lamb		= {"venomincantation", "collectible",	wakaba.Enums.Collectibles.VENOM_INCANTATION,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_venomincantation.png") end},
		BossRush	= {"bunnyparfait", "collectible",	wakaba.Enums.Collectibles.BUNNY_PARFAIT,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_bunnyparfait.png") end},
		Hush		= {"richeruniform", "collectible",	wakaba.Enums.Collectibles.RICHERS_UNIFORM,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_richeruniform.png") end},
		Delirium	= {"prestigepass", "collectible",	wakaba.Enums.Collectibles.PRESTIGE_PASS,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_prestigepass.png") end},
		MegaSatan	= {"printer", "collectible",		wakaba.Enums.Collectibles._3D_PRINTER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_printer.png") end},
		Mother		= {"cunningpaper", "collectible",	wakaba.Enums.Collectibles.CUNNING_PAPER,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_cunningpaper.png") end},
		Beast		= {"selfburning", "collectible",	wakaba.Enums.Collectibles.SELF_BURNING,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_selfburning.png") end},
		Greed		= {"clensingfoam", "collectible",	wakaba.Enums.Collectibles.CLENSING_FOAM,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_clensingfoam.png") end},
		Greedier	= {"lilricher", "collectible",		wakaba.Enums.Collectibles.LIL_RICHER,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_lilricher.png") end},

		All 		= {"rabbitribbon", "collectible",	wakaba.Enums.Collectibles.RABBIT_RIBBON,	function() TryPlayAchievementPaper("gfx/ui/achievement_wakaba/achievement_blank.png") end},
	},
	[wakaba.Enums.Players.RICHER_B] = {
		istainted = true,
		Heart 		= {"taintedrichermomsheart"},
		Quartet 		= {"starreversal", "trinket",	wakaba.Enums.Trinkets.STAR_REVERSAL,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_starreversal.png") end},
		Duet 		= {"richersoul", "card",	wakaba.Enums.Cards.SOUL_RICHER,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_richersoul.png") end},
		Delirium	= {"waterflame", "collectible",	wakaba.Enums.Collectibles.WATER_FLAME,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_waterflame.png") end},
		MegaSatan	= {"crystalrestock", "null",		nil,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_crystalrestock.png") end},
		Mother		= {"eternitycookie", "trinket",	wakaba.Enums.Trinkets.ETERNITY_COOKIE,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_eternitycookie.png") end},
		Beast		= {"winteralbireo", "collectible",	wakaba.Enums.Collectibles.WINTER_ALBIREO,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_winteralbireo.png") end},
		Greedier	= {"trialstew", "card",		wakaba.Enums.Cards.CARD_TRIAL_STEW,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_trialstew.png") end},
	},
	[-999] = {
		[wakaba.challenges.CHALLENGE_ELEC] = {"eyeofclock", "collectible",	wakaba.Enums.Collectibles.EYE_OF_CLOCK,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_eyeofclock.png") end, BossID.MOM},
		[wakaba.challenges.CHALLENGE_PLUM] = {"plumy", "collectible",	wakaba.Enums.Collectibles.PLUMY,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_plumy.png") end, BossID.HUSH},
		--[wakaba.challenges.CHALLENGE_PULL] = {"eyeofclock", "collectible",	wakaba.Enums.Collectibles.EYE_OF_CLOCK,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_blank.png") end, BossID.MOM},
		[wakaba.challenges.CHALLENGE_MINE] = {"delimiter", "trinket",	wakaba.Enums.Trinkets.DELIMITER,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_delimiter.png") end, BossID.HEART},
		[wakaba.challenges.CHALLENGE_GUPP] = {"nekodoll", "collectible",	wakaba.Enums.Collectibles.NEKO_FIGURE,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_nekofigure.png") end, BossID.MOTHER},
		[wakaba.challenges.CHALLENGE_DOPP] = {"microdoppelganger", "collectible",	wakaba.Enums.Collectibles.MICRO_DOPPELGANGER,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_microdoppelganger.png") end, BossID.HUSH},
		[wakaba.challenges.CHALLENGE_DELI] = {"delirium", "trinket",	wakaba.Enums.Trinkets.DIMENSION_CUTTER,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_dimensioncutter.png") end, BossID.DELIRIUM},
		[wakaba.challenges.CHALLENGE_SIST] = {"lilwakaba", "collectible",	wakaba.Enums.Collectibles.LIL_WAKABA,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_lilwakaba.png") end, BossID.LAMB},
		[wakaba.challenges.CHALLENGE_DRAW] = {"lostuniform", "null",	nil,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_lostuniform.png") end}, BossID.BLUE_BABY,
		[wakaba.challenges.CHALLENGE_HUSH] = {"executioner", "collectible",	wakaba.Enums.Collectibles.EXECUTIONER,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_executioner.png") end, BossID.HUSH},
		[wakaba.challenges.CHALLENGE_APPL] = {"apollyoncrisis", "collectible",	wakaba.Enums.Collectibles.APOLLYON_CRISIS,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_apollyoncrisis.png") end, BossID.LAMB},
		[wakaba.challenges.CHALLENGE_BIKE] = {"deliverysystem", "collectible",	wakaba.Enums.Collectibles.ISEKAI_DEFINITION,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_isekaidefinition.png") end, BossID.DELIRIUM},
		[wakaba.challenges.CHALLENGE_CALC] = {"calculation", "collectible",	wakaba.Enums.Collectibles.BALANCE,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_balance.png") end, BossID.MEGA_SATAN},
		[wakaba.challenges.CHALLENGE_HOLD] = {"lilmao", "collectible",	wakaba.Enums.Collectibles.LIL_MAO,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_lilmao.png") end, BossID.MOTHER},
		[wakaba.challenges.CHALLENGE_EVEN] = {"richerflipper", "collectible",	wakaba.Enums.Collectibles.RICHERS_FLIPPER,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_richerflipper.png") end, BossID.MOTHER},
		[wakaba.challenges.CHALLENGE_RNPR] = {"richernecklace", "collectible",	wakaba.Enums.Collectibles.RICHERS_NECKLACE,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_richernecklace.png") end, BossID.DELIRIUM},
		[wakaba.challenges.CHALLENGE_RAND] = {"edensticky", "collectible",	wakaba.Enums.Collectibles.EDEN_STICKY_NOTE,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_edensticky.png") end, BossID.DELIRIUM},
		[wakaba.challenges.CHALLENGE_DRMS] = {"doubledreams", "collectible",	wakaba.Enums.Collectibles.DOUBLE_DREAMS,	function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement_wakaba/achievement_doubledreams.png") end, BossID.BEAST},
	}
}

wakaba.LinkedCompletionUnlocks = {
	{wakaba.Enums.Cards.SOUL_WAKABA2, "card", wakaba.Enums.Cards.SOUL_WAKABA, "card"},
	{wakaba.Enums.Collectibles.ADVANCED_CRYSTAL, "collectible", wakaba.Enums.Collectibles.ARCANE_CRYSTAL, "collectible"},
	{wakaba.Enums.Collectibles.MYSTIC_CRYSTAL, "collectible", wakaba.Enums.Collectibles.ARCANE_CRYSTAL, "collectible"},
	{wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE, "trinket", wakaba.Enums.Trinkets.ISAAC_CARTRIDGE, "trinket"},
	{wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE, "trinket", wakaba.Enums.Trinkets.ISAAC_CARTRIDGE, "trinket"},
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

function wakaba:GetUnlockEntry(playerType, unlockType)
	if wakaba.UnlockTables[playerType] then
		local unlockCheckStr = ""
		local unlockTable = wakaba.UnlockTables[playerType]
		if unlockTable.istainted then
			if unlockType == "BossRush" then
				unlockCheckStr = unlockTable.Duet[1].."1"
			elseif unlockType == "Hush" then
				unlockCheckStr = unlockTable.Duet[1].."2"
			elseif unlockType == "Isaac" then
				unlockCheckStr = unlockTable.Quartet[1].."1"
			elseif unlockType == "Satan" then
				unlockCheckStr = unlockTable.Quartet[1].."2"
			elseif unlockType == "BlueBaby" then
				unlockCheckStr = unlockTable.Quartet[1].."3"
			elseif unlockType == "Lamb" then
				unlockCheckStr = unlockTable.Quartet[1].."4"
			else
				unlockCheckStr = unlockTable[unlockType][1]
			end
		else
			unlockCheckStr = unlockTable[unlockType][1]
		end
		return unlockCheckStr
	end
end

function wakaba:IsCompletionItemUnlockedTemp(itemID, typeString)
	typeString = typeString or "collectible"
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


		for key, valTable in pairs(unlockTable) do
			if type(valTable) == "table" then
				local value = wakaba.state.unlock[valTable[1]]
				if type(value) == "number" then
					local num = value
					if num < 2 then
						oldAllHard = false
					end

					if key == associationToValueMap[bossEntry] then
						num = newValue
					end

					if num < 2 then
						allHard = false
						break
					end
				end
			end
		end

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
	--wakaba.Enums.Players.RIRA,
	--wakaba.Enums.Players.RIRA_B,
	--wakaba.Enums.Players.WAKABA_T,
	--wakaba.Enums.Players.SHIORI_T,
	--wakaba.Enums.Players.TSUKASA_T,
	--wakaba.Enums.Players.RICHER_T,
	--wakaba.Enums.Players.RIRA_T,
}
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

	if wakaba.G.Challenge == Challenge.CHALLENGE_NULL and wakaba.G:GetVictoryLap() <= 0 then
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
			if type1 == RoomType.ROOM_DUNGEON and currentStage == 13 and level:GetCurrentRoomDesc().Data.Variant == 666 and unlockTableEntry[5] == BossID.BEAST then
				if wakaba.state.unlock[unlockTableEntry[1]] == false then
					wakaba.state.unlock[unlockTableEntry[1]] = true
					if shouldShowPopup then
						unlockTableEntry[4]()
					end
				end
			elseif type1 == RoomType.ROOM_BOSS and unlockTableEntry[5] == boss then
				if wakaba.state.unlock[unlockTableEntry[1]] == false then
					wakaba.state.unlock[unlockTableEntry[1]] = true
					if shouldShowPopup then
						unlockTableEntry[4]()
					end
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.UnlockCheck)


--[[
function wakaba:GetCompletionNoteLayerDataFromPlayerType(playerType)
	for key, dataset in pairs(wakaba.state.completion) do
		if playertype_cache[key] == playerType then
			return {
				[noteLayer.DELI] 	= dataset.deli + (dataset.istainted and 3 or 0),
				[noteLayer.HEART] 	= dataset.heart,
				[noteLayer.ISAAC] 	= dataset.isaac,
				[noteLayer.SATAN] 	= dataset.satan,
				[noteLayer.RUSH] 	= dataset.rush,
				[noteLayer.BBABY] 	= dataset.bbaby,
				[noteLayer.LAMB] 	= dataset.lamb,
				[noteLayer.MEGA] 	= dataset.mega,
				[noteLayer.GREED] 	= dataset.greed,
				[noteLayer.HUSH] 	= dataset.hush,
				[noteLayer.MOTHER] 	= dataset.mother,
				[noteLayer.BEAST] 	= dataset.beast,
			}
		end
	end
end
 ]]
--[[
function wakaba:InitCharacterCompletion(playername, tainted, forceTaintedCompletion)
	local lookup = string.lower(playername)
	if tainted then lookup = lookup .. "B" end

	forceTaintedCompletion = forceTaintedCompletion ~= nil and forceTaintedCompletion or tainted
	wakaba.state.completion = wakaba.state.completion or {}

	playertype_cache[lookup] = Isaac.GetPlayerTypeByName(playername, tainted)

	if not wakaba.state.completion[lookup] then
		wakaba.state.completion[lookup] = {
			lookupstr	= lookup,
			istainted	= forceTaintedCompletion,

			heart	= 0,
			isaac	= 0,
			bbaby	= 0,
			satan	= 0,
			lamb	= 0,
			rush	= 0,
			hush	= 0,
			deli	= 0,
			mega	= 0,
			greed	= 0,
			mother	= 0,
			beast	= 0,
		}
	end
end

function wakaba:AssociateCompletionUnlocks(playerType, unlockset)
	for key, value in pairs(playertype_cache) do
		if value == playerType then
			unlocksHolder[key] = unlockset
		end
	end
end

function wakaba:AssociateItemWithTest(unlockType, itemID, conditionFunction)
	table.insert(unlocksHolder2, {
		Type = unlockType,
		ID = itemID,
		Check = conditionFunction,
	})
end


function wakaba:InitCharacterCompletionMarks()
	wakaba:InitCharacterCompletion("Wakaba", false)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.WAKABA, wakaba.UnlockTables[wakaba.Enums.Players.WAKABA])

	wakaba:InitCharacterCompletion("Wakaba", true)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.WAKABA_B, wakaba.UnlockTables[wakaba.Enums.Players.WAKABA_B])

	wakaba:InitCharacterCompletion("Shiori", false)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.SHIORI, wakaba.UnlockTables[wakaba.Enums.Players.SHIORI])

	wakaba:InitCharacterCompletion("Shiori", true)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.SHIORI_B, wakaba.UnlockTables[wakaba.Enums.Players.SHIORI_B])

	wakaba:InitCharacterCompletion("Tsukasa", false)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.TSUKASA, wakaba.UnlockTables[wakaba.Enums.Players.TSUKASA])

	wakaba:InitCharacterCompletion("Tsukasa", true)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.TSUKASA_B, wakaba.UnlockTables[wakaba.Enums.Players.TSUKASA_B])

	wakaba:InitCharacterCompletion("Richer", false)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.RICHER, wakaba.UnlockTables[wakaba.Enums.Players.RICHER])

	wakaba:InitCharacterCompletion("Richer", true)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.RICHER_B, wakaba.UnlockTables[wakaba.Enums.Players.RICHER_B])
end
 ]]

--[[

local function HasPlayerAchievedQuartet(playerKey)
	return (
		wakaba.state.completion[playerKey].isaac >= 1 and
		wakaba.state.completion[playerKey].bbaby >= 1 and
		wakaba.state.completion[playerKey].satan >= 1 and
		wakaba.state.completion[playerKey].lamb >= 1
	)
end

local function HasPlayerAchievedDuet(playerKey)
	return (
		wakaba.state.completion[playerKey].rush >= 1 and
		wakaba.state.completion[playerKey].hush >= 1
	)
end

local function TestUnlock(playerKey, unlockType)
	if unlockType == "All" then
		local allHard = true

		for key, value in pairs(wakaba.state.completion[playerKey]) do
			if type(value) == "number" then
				if value < 2 then
					allHard = false
					break
				end
			end
		end

		return allHard
	elseif unlockType == "Quartet" then
		return HasPlayerAchievedQuartet(playerKey)
	elseif unlockType == "Duet" then
		return HasPlayerAchievedDuet(playerKey)
	else
		return wakaba.state.completion[playerKey][associationToValueMap[unlockType] ] >= associationTestValue[unlockType]
	end
end
 ]]
--[[
function wakaba.IsCompletionMarkUnlocked(playerKey, unlockType)
	return TestUnlock(string.lower(playerKey), unlockType)
end

function wakaba.IsCompletionItemUnlocked(itemID)
	for _, data in pairs(unlocksHolder2) do
		if data.Type == "collectible" and data.ID == itemID and data.Check() then
			return true
		end
	end

	for playerKey, dataset in pairs(unlocksHolder) do
		for unlockType, unlockData in pairs(dataset) do
			if unlockData[1] == "collectible" and unlockData[2] == itemID then
				return TestUnlock(playerKey, unlockType)
			end
		end
	end

	return true
end

function wakaba.IsCompletionTrinketUnlocked(trinketID)
	for _, data in pairs(unlocksHolder2) do
		if data.Type == "trinket" and data.ID == trinketID and data.Check() then
			return true
		end
	end

	for playerKey, dataset in pairs(unlocksHolder) do
		for unlockType, unlockData in pairs(dataset) do
			if unlockData[1] == "trinket" and unlockData[2] == trinketID then
				return TestUnlock(playerKey, unlockType)
			end
		end
	end

	return true
end

function wakaba.RemoveLockedItemsAndTrinkets()
	local itempool = game:GetItemPool()

	for playerKey, dataset in pairs(unlocksHolder) do
		for unlockType, unlockData in pairs(dataset) do
			if unlockData[1] == "collectible" then
				if not TestUnlock(playerKey, unlockType) then
					itempool:RemoveCollectible(unlockData[2])
				end
			elseif unlockData[1] == "trinket" then
				if not TestUnlock(playerKey, unlockType) then
					itempool:RemoveTrinket(unlockData[2])
				end
			end
		end
	end

	for _, data in pairs(unlocksHolder2) do
		if not data.Check() then
			if data.Type == "collectible" then
				itempool:RemoveCollectible(data.ID)
			elseif data.Type == "trinket" then
				itempool:RemoveTrinket(data.ID)
			end
		end
	end
end

function wakaba.RemoveLockedTrinkets()
	local itempool = game:GetItemPool()

	for playerKey, dataset in pairs(unlocksHolder) do
		for unlockType, unlockData in pairs(dataset) do
			if unlockData[1] == "trinket" then
				if not TestUnlock(playerKey, unlockType) then
					itempool:RemoveTrinket(unlockData[2])
				end
			end
		end
	end

	for _, data in pairs(unlocksHolder2) do
		if not data.Check() then
			if data.Type == "trinket" then
				itempool:RemoveTrinket(data.ID)
			end
		end
	end
end

 ]]


--[[
local antiRecursion = false
wakaba:AddCallback(ModCallbacks.MC_GET_TRINKET, function(_, trinket, rng)
	if not antiRecursion and not wakaba.IsCompletionTrinketUnlocked(trinket) then
		antiRecursion = true

		wakaba.RemoveLockedTrinkets()

		local itempool = game:GetItemPool()
		local new = itempool:GetTrinket()

		antiRecursion = false

		return new
	end
end)

]]
--[[
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, function()
	if wakaba:CanRunUnlockAchievements() then
		local room = game:GetRoom()
		local roomtype = room:GetType()

		local value = DifficultyToCompletionMap[game.Difficulty]
		local checkTables = {}

		for _, data in pairs(wakaba.state.completion) do
			if playertype_cache[data.lookupstr] == Isaac.GetPlayer():GetPlayerType() then
				table.insert(checkTables, data)
			end
		end

		for _, check in ipairs(checkTables) do
			if isc:inBeastRoom() then
				if value > check.beast then
					CheckOnCompletionFunctions(check.lookupstr, "Beast", value, check.istainted)
				end

				check.beast = math.max(check.beast, value)
			elseif roomtype == RoomType.ROOM_BOSS then
				local boss = room:GetBossID()

				local playerKey = check.lookupstr
				local taintedCompletion = check.istainted

				if game:GetLevel():GetStage() == LevelStage.STAGE7 then -- Void

					if boss == BossID.DELIRIUM then
						if value > check.deli then
							CheckOnCompletionFunctions(playerKey, "Delirium", value, taintedCompletion)
						end

						check.deli = math.max(check.deli, value)
					end
				else
					if boss == BossID.HEART or boss == BossID.IT_LIVES or boss == BossID.MAUS_HEART then
						if value > check.heart and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Heart", value)
						end

						check.heart = math.max(check.heart, value)
					elseif boss == BossID.ISAAC then
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)

						if value > check.isaac and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Isaac", value)
						end

						check.isaac = math.max(check.isaac, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)
						if isQuartetAchieved and not wasQuartetAchieved then
							unlocksHolder[playerKey].Quartet[4]()
						end
					elseif boss == BossID.BLUE_BABY then
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)

						if value > check.bbaby and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "BlueBaby", value)
						end

						check.bbaby = math.max(check.bbaby, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)
						if isQuartetAchieved and not wasQuartetAchieved then
							unlocksHolder[playerKey].Quartet[4]()
						end
					elseif boss == BossID.SATAN then
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)

						if value > check.satan and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Satan", value)
						end

						check.satan = math.max(check.satan, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)
						if isQuartetAchieved and not wasQuartetAchieved then
							unlocksHolder[playerKey].Quartet[4]()
						end
					elseif boss == BossID.LAMB then
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)

						if value > check.lamb and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Lamb", value)
						end

						check.lamb = math.max(check.lamb, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)
						if isQuartetAchieved and not wasQuartetAchieved then
							unlocksHolder[playerKey].Quartet[4]()
						end
					elseif boss == BossID.HUSH then
						local wasDuetAchieved = taintedCompletion and HasPlayerAchievedDuet(playerKey)

						if value > check.hush and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Hush", value)
						end

						check.hush = math.max(check.hush, value)
						local isDuetAchieved = taintedCompletion and HasPlayerAchievedDuet(playerKey)
						if isDuetAchieved and not wasDuetAchieved then
							unlocksHolder[playerKey].Duet[4]()
						end
					elseif boss == BossID.MEGA_SATAN then
						if value > check.mega then
							CheckOnCompletionFunctions(playerKey, "MegaSatan", value, taintedCompletion)
						end

						check.mega = math.max(check.mega, value)
					elseif boss == BossID.GREED or boss == BossID.GREEDIER then
						if value > check.greed then
							if not check.istainted then
								CheckOnCompletionFunctions(playerKey, "Greed", value)
							end
							CheckOnCompletionFunctions(playerKey, "Greedier", value, taintedCompletion)
						end

						check.greed = math.max(check.greed, value)
					elseif boss == BossID.MOTHER then
						if value > check.mother then
							CheckOnCompletionFunctions(playerKey, "Mother", value, taintedCompletion)
						end

						check.mother = math.max(check.mother, value)
					end
				end
			elseif roomtype == RoomType.ROOM_BOSSRUSH then
				local wasDuetAchieved = check.istainted and HasPlayerAchievedDuet(check.lookupstr)

				if value > check.rush and not check.istainted then
					CheckOnCompletionFunctions(check.lookupstr, "BossRush", value)
				end

				check.rush = math.max(check.rush, value)
				local isDuetAchieved = check.istainted and HasPlayerAchievedDuet(check.lookupstr)
				if isDuetAchieved and not wasDuetAchieved then
					unlocksHolder[playerKey].Duet[4]()
				end
			end
		end
	end
end)

 ]]
























function wakaba:LockItems()
  for i = wakaba.FIRST_WAKABA_ITEM, wakaba.LAST_WAKABA_ITEM do
    local isUnlocked = wakaba:unlockCheck(i)
    if not isUnlocked then
      Isaac.DebugString("[wakaba]Item ID ".. i .. " Not unlocked! removing from the pools...")
      wakaba.G:GetItemPool():RemoveCollectible(i)
    end
    if EID then
      EID.itemUnlockStates[i] = isUnlocked
    end
  end

	for i = wakaba.FIRST_WAKABA_TRINKET, wakaba.LAST_WAKABA_TRINKET do
		if not wakaba:trinketUnlockCheck(i) then
			Isaac.DebugString("[wakaba]Trinket ID ".. i .. " Not unlocked! removing from the pools...")
			wakaba.G:GetItemPool():RemoveCollectible(i)
		end
	end

end

function wakaba.UniversalRemoveItemFromPools(item)
	--wakaba.RemoveItemFromCustomItemPools(item)

	local itempool = game:GetItemPool()
	itempool:RemoveCollectible(item)
end

function wakaba.UniversalRemoveTrinketFromPools(trinket)
	--wakaba.RemoveTrinketFromCustomItemPools(trinket)

	local itempool = game:GetItemPool()
	itempool:RemoveTrinket(trinket)
end

local unlockTypeToRemoveFunction = {
	collectible	= wakaba.UniversalRemoveItemFromPools,
	trinket		= wakaba.UniversalRemoveTrinketFromPools,
}

function wakaba:IsWakabaCharacterUnlocked(player)
  player = player or Isaac.GetPlayer()
  local type = player:GetPlayerType()
  if type == wakaba.Enums.Players.TSUKASA_B and not wakaba.state.unlock.taintedtsukasa then return false end
  if type == wakaba.Enums.Players.RICHER_B and not wakaba.state.unlock.taintedricher then return false end
  return true
end










for _, playerType in pairs(wakaba.Enums.Players) do
	PauseScreenCompletionMarksAPI:AddModCharacterCallback(playerType, function()
		return wakaba:GetCompletionNoteLayerDataFromPlayerType(playerType)
	end)
end