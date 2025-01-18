
---@class WakabaOptions
local config = {
	allowlockeditems = true,
	balancemode = wakaba.Enums.BalanceModes.WAKABA,
	extendquality = true,
	extendvanillaquality = false,

	exl = Keyboard.KEY_LEFT_BRACKET,
	exr = Keyboard.KEY_RIGHT_BRACKET,

	gdkey = Keyboard.KEY_6,
	gpkey = Keyboard.KEY_7,

	kud_wafu = false,
	fortunereplacechance = 10,

	-- Reroll function threshold. Change this value if getting items are too laggy.
	rerolltreasurethreshold = 120,
	rerollbreakfastthreshold = 160,

	-- HUD for Pudding and Wakaba items options
	uniformalpha = 20,
	uniformscale = 100,

	-- Starting items control options
	richersweetscatalog = true,
	lostuniform = true,
	edensticky = true,

	-- Costume Protector
	cp_wakaba = true,

	-- Custom sounds
	customhitsound = true,
	customhitsoundprof = -1,
	customitemsound = true,
	customsoundvolume = 5,

	-- Wakaba options
	cloverchestchance = 5,
	taintedcloverchestchance = 5,

	-- Shiori options
	vintagetriggerkey = Keyboard.KEY_9,

	valutchance = 10,

	-- Tsukasa options
	concentrationkeyboard = Keyboard.KEY_LEFT_CONTROL,
	concentrationcontroller = (Controller and Controller.BUMPER_RIGHT) or ButtonAction.ACTION_DROP,
	lunarpercent = true,
	leftchargebardigits = true,
	legacyplasmabeam = false,
	flashshifthearts = false,
	phantomcloakhearts = false,

	eastereggchance = 2,

	-- Richer options
	lilricherautocharge = true,
	lilrichertriggerkey = Keyboard.KEY_5,
	alwaysdoubleinvader = false,

	crystalrestockchance = 10,

	-- Rira options
	rirastatswap = false,
	chimakisound = true,
	maidtriggerkey = Keyboard.KEY_7,
	lilriraautosteal = true,
	lilriratriggerkey = Keyboard.KEY_6,
	rabbeywardrender = true,
	rirafullpica = false,

	-- Wakaba Duality options
	blessnemesisindexed = false,
	blessnemesisqualityignore = false,
	startingroomindexed = false,
	firsttreasureroomindexed = false,

	-- Curse of Flames options
	flamesoverride = false,
	flamescurserate = 0,

	-- Curse of Vampire options
	--flamesoverride = false,
	--flamescurserate = 0,

	--[[
	Stackable Holy Mantle options
	-1 : Disabled
	 0 : Infinite
	 any number beyond 0 : maximum number of stack
	 ]]
	stackablemantle = 0,
	stackableblanket = 0,
	stackableblessing = 0,
	stackableholycard = 5,

	-- Dogma/Beast Blanket options
	dogmablanket = true,
	beastblanket = true,
	rotgutblanket = true,

	-- Dead Wisp Notification options
	deadwispnotif = false,
	deadwispnotifsound = false,

	-- Inventory Descriptions options
	listoffset = 200,
	listkey = Keyboard.KEY_F5,
	switchkey = Keyboard.KEY_F6,
	idleicon = 0,
	selicon = 17,
	lemegetonicon = 18,
	q0icon = 20,
	q1icon = 21,
	q2icon = 22,
	q3icon = 23,
	q4icon = 24,
	q5icon = 25,
	q6icon = 26,
	invplayerinfos = true,
	invcurses = true,
	invcollectibles = true,
	invactives = true,
	invtrinkets = true,
	invpocketitems = true,
	invlistmode = "list",
	invgridcolumn = 6,
	invpassivehistory = false,
	invinitcursor = "character",
	listdimmeralpha = 0.5,

	-- Found HUD options
	hudhitcounter = 1, -- hit counter - 0: false, 1: penaties only, 2: all
	hudroomnumber = 0, -- room no - 0: false, 1: no. only, 2:detailed, 3:combined with name
	hudroomname = 0, -- room name - 0: false, 1: name scroll, 2: full name, 3:detailed
	hudroomdiff = 0, -- room difficulty - 0: false, 1: diff only, 2:detailed
	hudroomweight = 0, -- room weight - 0: false, 1: weight only, 2:detailed

}
return config