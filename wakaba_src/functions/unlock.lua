local game = Game()
local isc = require("wakaba_src.libs.isaacscript-common")

wakaba.UnlockTables = {
	[wakaba.Enums.Players.WAKABA] = {
		Heart 		= {"clover", "trinket", 		wakaba.Enums.Trinkets.CLOVER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_clover.png") end},
		Isaac 		= {"counter", "collectible",	wakaba.Enums.Collectibles.COUNTER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_counter.png") end},
		BlueBaby 	= {"pendant", "collectible",	wakaba.Enums.Collectibles.WAKABAS_PENDANT,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_pendant.png") end},
		Satan 		= {"dcupicecream", "collectible",	wakaba.Enums.Collectibles.D_CUP_ICECREAM,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_dcupicecream.png") end},
		Lamb		= {"revengefruit", "collectible",	wakaba.Enums.Collectibles.REVENGE_FRUIT,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_revengefruit.png") end},
		BossRush	= {"donationcard", "card",	wakaba.Enums.Cards.CARD_DREAM_CARD,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_dreamcard.png") end},
		Hush		= {"colorjoker", "card",	wakaba.Enums.Cards.CARD_COLOR_JOKER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_colorjoker.png") end},
		Delirium	= {"wakabauniform", "collectible",	wakaba.Enums.Collectibles.UNIFORM,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_uniform.png") end},
		MegaSatan	= {"whitejoker", "card",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_whitejoker.png") end},
		Mother		= {"confessionalcard", "card",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_confessionalcard.png") end},
		Beast		= {"returnpostage", "collectible",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_returnpostage.png") end},
		Greed		= {"secretcard", "collectible",	wakaba.Enums.Collectibles.SECRET_CARD,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_secretcard.png") end},
		Greedier	= {"cranecard", "card",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_cranecard.png") end},

		All 		= {"blessing", "collectible",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blessing.png") end},
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		istainted = true,
		Heart 		= {"taintedwakabamomsheart"},
		Quartet 		= {"bookofforgotten", "collectible",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_bookofforgotten.png") end},
		Duet 		= {"wakabasoul", "collectible",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_wakabasoul.png") end},
		Delirium	= {"eatheart", "collectible",	wakaba.Enums.Collectibles.UNIFORM,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_eatheart.png") end},
		MegaSatan	= {"cloverchest", "null",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_cloverchest.png") end},
		Mother		= {"bitcoin", "trinket",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_bitcoin.png") end},
		Beast		= {"nemesis", "collectible",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_nemesis.png") end},
		Greedier	= {"blackjoker", "card",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blackjoker.png") end},
	},
	[wakaba.Enums.Players.SHIORI] = {
		Heart 		= {"hardbook", "trinket", 		wakaba.Enums.Trinkets.CLOVER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_hardbook.png") end},
		Isaac 		= {"shiorid6plus", "null",	wakaba.Enums.Collectibles.COUNTER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_shiorid6plus.png") end},
		BlueBaby 	= {"deckofrunes", "collectible",	wakaba.Enums.Collectibles.WAKABAS_PENDANT,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_deckofrunes.png") end},
		Satan 		= {"bookoffocus", "collectible",	wakaba.Enums.Collectibles.D_CUP_ICECREAM,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_bookoffocus.png") end},
		Lamb		= {"grimreaperdefender", "collectible",	wakaba.Enums.Collectibles.REVENGE_FRUIT,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_grimreaperdefender.png") end},
		BossRush	= {"unknownbookmark", "card",	wakaba.Enums.Cards.CARD_DREAM_CARD,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_unknownbookmark.png") end},
		Hush		= {"bookoftrauma", "collectible",	wakaba.Enums.Cards.CARD_COLOR_JOKER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_bookoftrauma.png") end},
		Delirium	= {"bookofsilence", "collectible",	wakaba.Enums.Collectibles.UNIFORM,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_bookofsilence.png") end},
		MegaSatan	= {"bookoffallen", "collectible",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_bookoffallen.png") end},
		Mother		= {"vintagethreat", "collectible",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_vintagethreat.png") end},
		Beast		= {"bookofthegod", "collectible",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_bookofthegod.png") end},
		Greed		= {"magnetheaven", "trinket",	wakaba.Enums.Collectibles.SECRET_CARD,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_magnetheaven.png") end},
		Greedier	= {"determinationribbon", "trinket",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_determinationribbon.png") end},

		All 		= {"bookofshiori", "collectible",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_bookofshiori.png") end},
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		istainted = true,
		Heart 		= {"taintedshiorimomsheart"},
		Quartet 		= {"bookmarkbag", "trinket",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_bookmarkbag.png") end},
		Duet 		= {"shiorisoul", "card",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_shiorisoul.png") end},
		Delirium	= {"bookofconquest", "collectible",	wakaba.Enums.Collectibles.UNIFORM,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_bookofconquest.png") end},
		MegaSatan	= {"shiorivalut", "null",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_anotherfortunemachine.png") end},
		Mother		= {"ringofjupiter", "trinket",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_ringofjupiter.png") end},
		Beast		= {"minervaaura", "collectible",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_minervaaura.png") end},
		Greedier	= {"queenofspades", "card",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_queenofspades.png") end},
	},
	[wakaba.Enums.Players.TSUKASA] = {
		Heart 		= {"murasame", "collectible", 		wakaba.Enums.Trinkets.CLOVER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_murasame.png") end},
		Isaac 		= {"nasalover", "collectible",	wakaba.Enums.Collectibles.COUNTER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_nasalover.png") end},
		BlueBaby 	= {"redcorruption", "collectible",	wakaba.Enums.Collectibles.WAKABAS_PENDANT,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_totalcorruption.png") end},
		Satan 		= {"beetlejuice", "collectible",	wakaba.Enums.Collectibles.D_CUP_ICECREAM,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_beetlejuice.png") end},
		Lamb		= {"powerbomb", "collectible",	wakaba.Enums.Collectibles.REVENGE_FRUIT,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_powerbomb.png") end},
		BossRush	= {"concentration", "collectible",	wakaba.Enums.Cards.CARD_DREAM_CARD,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_concentration.png") end},
		Hush		= {"rangeos", "trinket",	wakaba.Enums.Cards.CARD_COLOR_JOKER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_rangeos.png") end},
		Delirium	= {"newyearbomb", "collectible",	wakaba.Enums.Collectibles.UNIFORM,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_newyearbomb.png") end},
		MegaSatan	= {"plasmabeam", "collectible",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_plasmabeam.png") end},
		Mother		= {"phantomcloak", "collectible",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_phantomcloak.png") end},
		Beast		= {"magmablade", "collectible",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_magmablade.png") end},
		Greed		= {"arcanecrystal", "collectible",	wakaba.Enums.Collectibles.SECRET_CARD,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_arcanecrystal.png") end},
		Greedier	= {"questionblock", "collectible",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_questionblock.png") end},

		All 		= {"lunarstone", "collectible",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_lunarstone.png") end},
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		istainted = true,
		Heart 		= {"taintedtsukasamomsheart"},
		Quartet 		= {"isaaccartridge", "trinket",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_isaaccartridge.png") end},
		Duet 		= {"tsukasasoul", "card",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_tsukasasoul.png") end},
		Delirium	= {"flashshift", "collectible",	wakaba.Enums.Collectibles.UNIFORM,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_flashshift.png") end},
		MegaSatan	= {"easteregg", "null",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_easteregg.png") end},
		Mother		= {"sirenbadge", "trinket",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_sirenbadge.png") end},
		Beast		= {"elixiroflife", "collectible",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_elixiroflife.png") end},
		Greedier	= {"returntoken", "card",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_returntoken.png") end},
	},
	[wakaba.Enums.Players.RICHER] = {
		Heart 		= {"fireflylighter", "null", 		wakaba.Enums.Trinkets.CLOVER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Isaac 		= {"sweetscatalog", "null",	wakaba.Enums.Collectibles.COUNTER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		BlueBaby 	= {"doubleinvader", "null",	wakaba.Enums.Collectibles.WAKABAS_PENDANT,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Satan 		= {"antibalance", "null",	wakaba.Enums.Collectibles.D_CUP_ICECREAM,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Lamb		= {"venomincantation", "null",	wakaba.Enums.Collectibles.REVENGE_FRUIT,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		BossRush	= {"caramellopancake", "null",	wakaba.Enums.Cards.CARD_DREAM_CARD,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Hush		= {"richeruniform", "null",	wakaba.Enums.Cards.CARD_COLOR_JOKER,		function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Delirium	= {"prestigepass", "null",	wakaba.Enums.Collectibles.UNIFORM,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		MegaSatan	= {"printer", "null",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_blank.png") end},
		Mother		= {"cunningpaper", "null",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Beast		= {"blackribbon", "null",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_blank.png") end},
		Greed		= {"chimaki", "null",	wakaba.Enums.Collectibles.SECRET_CARD,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Greedier	= {"lilricher", "null",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},

		All 		= {"rabbitribbon", "null",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
	},
	[wakaba.Enums.Players.RICHER_B] = {
		istainted = true,
		Heart 		= {"taintedrichermomsheart"},
		Quartet 		= {"starreversal", "null",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Duet 		= {"richersoul", "null",	wakaba.Enums.Collectibles.WAKABAS_BLESSING,	function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Delirium	= {"waterflame", "null",	wakaba.Enums.Collectibles.UNIFORM,				function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		MegaSatan	= {"spirititems", "null",		wakaba.Enums.Cards.CARD_WHITE_JOKER,			function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_blank.png") end},
		Mother		= {"mistake", "null",	wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
		Beast		= {"winteralbireo", "null",	wakaba.Enums.Collectibles.RETURN_POSTAGE,		function() table.insert(wakaba.state.pendingunlock, "gfx/ui/achievement/achievement_blank.png") end},
		Greedier	= {"trialstew", "null",		wakaba.Enums.Cards.CARD_CRANE_CARD,			function() CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement/achievement_blank.png") end},
	},
}

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
























-- from retribution
--[[ 
function wakaba.GetCompletionNoteLayerDataFromPlayerType(playerType)
	if wakaba.state and wakaba.state.completion then
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
	else
		return {
			[noteLayer.DELI] 	= 0,
			[noteLayer.HEART] 	= 0,
			[noteLayer.ISAAC] 	= 0,
			[noteLayer.SATAN] 	= 0,
			[noteLayer.RUSH] 	= 0,
			[noteLayer.BBABY] 	= 0,
			[noteLayer.LAMB] 	= 0,
			[noteLayer.MEGA] 	= 0,
			[noteLayer.GREED] 	= 0,
			[noteLayer.HUSH] 	= 0,
			[noteLayer.MOTHER] 	= 0,
			[noteLayer.BEAST] 	= 0,
		}
	end
end
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
  return true
end










for _, playerType in pairs(wakaba.Enums.Players) do
	PauseScreenCompletionMarksAPI:AddModCharacterCallback(playerType, function()
		return wakaba:GetCompletionNoteLayerDataFromPlayerType(playerType)
	end)
end