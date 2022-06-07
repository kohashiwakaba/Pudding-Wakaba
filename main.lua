--StartDebug()
-- Pudding and Wakaba is Repentance only.
if not REPENTANCE then
	print("Pudding and Wakaba is Repentance only. If this message pops up even in Repentance, check other mods that modify repentance variable.")
	Isaac.DebugString("Pudding and Wakaba is Repentance only. If this message pops up even in Repentance, check other mods that modify repentance variable.") 
	return 
end
wakaba = RegisterMod("Pudding and Wakaba", 1)
if EIDKR then
	local printCounter = 600
	local krfont = Font()
	krfont:Load("font/cjk/lanapixel.fnt")
	wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, function()
		printCounter = printCounter - 1
		if printCounter > 0 then
			krfont:DrawStringScaledUTF8("Pudding & Wakaba 모드는 External Item Descriptions(원본 설명모드)가 필요합니다.", 10, 220, 1, 1, KColor(1, 1, 1, 1), 0, false)
			krfont:DrawStringScaledUTF8("자세한 내용 및 설정방법은 한글 설명모드 페이지의 설명을 참고해주세요.", 10, 240, 1, 1, KColor(1, 1, 1, 1), 0, false)
		end
	end)
	wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
		printCounter = 600
	end)
	return 
end

include("scripts.filepathhelper")
include('scripts.achievement_display_api')
wakaba.f = Font() -- init font object
wakaba.f:Load("font/pftempestasevencondensed.fnt") -- load a font into the font object
wakaba.cf = Font() -- init font object
wakaba.cf:Load("font/luaminioutlined.fnt") -- load a font into the font object
wakaba.pickupdisplaySptite = Sprite()
wakaba.pickupdisplaySptite:Load("gfx/ui/wakaba/hudpickups.anm2", true)
wakaba.MiniMapAPISprite = Sprite()
wakaba.MiniMapAPISprite:Load("gfx/ui/wakaba/minimapapi.anm2", true)

-- costume protector WIP
local costumeProtector = include("scripts/characterCostumeProtector.lua")
costumeProtector:Init(wakaba)

--__wakaba = true
--wakabaMCM = nil
local debug_text = ""
local json = require("json")
--[[
local _, err = pcall(require, "scripts.completionnotes")
err = tostring(err)
if not string.match(err, "attempt to call a nil value %(method 'ForceError'%)") then
	if string.match(err, "true") then
		err = "Error: require passed in completionnotes"
	end
	Isaac.DebugString(err)
	print(err)
end
]]

-- Made this one to make randomized tear effects
function wakaba.TEARFLAG(x)
	return x >= 64 and BitSet128(0,1<<(x-64)) or BitSet128(1<<x,0)
end

function wakaba:deepcopy(orig, copies)
	copies = copies or {}
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
			if copies[orig] then
					copy = copies[orig]
			else
					copy = {}
					copies[orig] = copy
					for orig_key, orig_value in next, orig, nil do
							copy[wakaba:deepcopy(orig_key, copies)] = wakaba:deepcopy(orig_value, copies)
					end
					setmetatable(copy, wakaba:deepcopy(getmetatable(orig), copies))
			end
	else -- number, string, boolean, etc
			copy = orig
	end
	return copy
end

wakaba.version = "v98a Tsukasa 2022.05.30"
wakaba.intversion = 9801

wakaba.modpath = FilepathHelper.GetCurrentModPath()
wakaba.itemConfig = Isaac.GetItemConfig()

wakaba.eidmain = false
wakaba.rerollcooltime = 0
wakaba.hasdreams = false

wakaba.costumecooldown = 600
wakaba.costumecurrframe = 0

wakaba.ponycooldown = 720

wakaba.fullreroll = false
wakaba.pedestalreroll = false

wakaba.wispupdaterequired = false
wakaba.unlockdisplaytimer = -(30*30)

wakaba.roomoverride = {
	devilroom = -4100,
	angelroom = -4101,
}

wakaba.sprites = {}

-- Plz fix this Edmund.
--wakaba.nepuSND = Isaac.GetSoundIdByName("wakaba_nepu")

-- EID extended description. for eidappend.lua
wakaba.descriptions = wakaba.descriptions or {}
wakaba.encyclopediadesc = wakaba.encyclopediadesc or {}
wakaba.eidunlockstr = ""


wakaba.eidextradesc = {}
wakaba.eidextradesc.bettervoiding = {}

wakaba.curses = {
	CURSE_OF_FLAMES = 1 << (Isaac.GetCurseIdByName("Curse of Flames!") - 1),
	CURSE_OF_SATYR = 1 << (Isaac.GetCurseIdByName("Curse of Satyr!") - 1),
}

wakaba.challenges = {
  CHALLENGE_ELEC = Isaac.GetChallengeIdByName("Electric Disorder"), --w01
  CHALLENGE_PLUM = Isaac.GetChallengeIdByName("Berry Best Friend"), --w02
  CHALLENGE_PULL = Isaac.GetChallengeIdByName("Pull and Pull"), --w03
  CHALLENGE_MINE = Isaac.GetChallengeIdByName("Mine stuff"), --w04
  CHALLENGE_GUPP = Isaac.GetChallengeIdByName("Black neko dreams"), --w05
  CHALLENGE_DOPP = Isaac.GetChallengeIdByName("Doppelganger"), --w06
  CHALLENGE_DELI = Isaac.GetChallengeIdByName("Delirium"), --w07
  CHALLENGE_SIST = Isaac.GetChallengeIdByName("Sisters from Beyond"), --w08
  CHALLENGE_DRAW = Isaac.GetChallengeIdByName("Draw Five"), --w09
  CHALLENGE_HUSH = Isaac.GetChallengeIdByName("Rush Rush Hush"), --w10
  CHALLENGE_APPL = Isaac.GetChallengeIdByName("Apollyon Crisis"), --w11
  CHALLENGE_BIKE = Isaac.GetChallengeIdByName("Delivery System"), --w12
  CHALLENGE_CALC = Isaac.GetChallengeIdByName("Calculation"), --w13
  CHALLENGE_HOLD = Isaac.GetChallengeIdByName("Hold Me"), --w14
	
  CHALLENGE_RAND = Isaac.GetChallengeIdByName("Hyper Random"), --w98
  CHALLENGE_DRMS = Isaac.GetChallengeIdByName("True Purist Girl"), --w99
  CHALLENGE_SLNT = Isaac.GetChallengeIdByName("Pure Delirium vs Silence"), --wb1
}

wakaba.soulflag = {
	SOUL_OF_WAKABA_BLESSING = 1,
	SOUL_OF_WAKABA_NEMESIS = 1 << 1,
	SOUL_OF_SHIORI = 1 << 2,
}

wakaba.useflag = {
	USE_UNIFORM = 1 << 11, -- Same as USE_ECHO_CHAMBER
}

wakaba.bookstate = {
	BOOKSHELF_SHIORI = 1,
	BOOKSHELF_UNKNOWN_BOOKMARK = 2,
	BOOKSHELF_HARD_BOOK = 3,
	BOOKSHELF_SHIORI_DROP = 4,
	BOOKSHELF_SOUL_OF_SHIORI = 5,
	BOOKSHELF_PURE_SHIORI = 6,
	BOOKSHELF_AKASIC_RECORDS = 6,
}

wakaba.dashflags = {
	FLASH_SHIFT = 1,
	FLASH_SHIFT_TSUKASA_B = 1 << 1,
	MURASAME = 1 << 2,
}

wakaba.pickupSpriteIndex = {
	["COIN"] = 0,
	["KEY"] = 1,
	["BOMB"] = 2,
	["GOLDEN_KEY"] = 3,
	["HARD_MODE"] = 4,
	["NO_TROPHY"] = 5,
	["GOLDEN_BOMB"] = 6,
	["GREED_MODE"] = 7,
	["DONATION_JAM"] = 9,
	["FINISH"] = 10,
	["GREEDIER_MODE"] = 11,
	["SOUL_HEART"] = 12,
	["BLACK_HEART"] = 13,
	["GIGA_BOMB"] = 14,
	["RED_HEART"] = 15,
	["POOP"] = 16,
	["BROKEN"] = 17,
	["CONQUEST"] = 18,
}

-- Reserved for popup image
wakaba.achievementsprite = {
	dcupicecream = "gfx/ui/achievement_wakaba/achievement_dcupicecream.png",
	secretcard = "gfx/ui/achievement_wakaba/achievement_secretcard.png",
	pendant = "gfx/ui/achievement_wakaba/achievement_pendant.png",
	clover = "gfx/ui/achievement_wakaba/achievement_clover.png",
	counter = "gfx/ui/achievement_wakaba/achievement_counter.png",
	newyearbomb = "gfx/ui/achievement_wakaba/achievement_newyearbomb.png",
	dreamcard = "gfx/ui/achievement_wakaba/achievement_dreamcard.png",
	donationcard = "gfx/ui/achievement_wakaba/achievement_donationcard.png",
	whitejoker = "gfx/ui/achievement_wakaba/achievement_whitejoker.png",
	revengefruit = "gfx/ui/achievement_wakaba/achievement_revengefruit.png",
	uniform = "gfx/ui/achievement_wakaba/achievement_uniform.png",
	brimstonedetonator = "gfx/ui/achievement_wakaba/achievement_brimstonedetonator.png",
	colorjoker = "gfx/ui/achievement_wakaba/achievement_colorjoker.png",
	cranecard = "gfx/ui/achievement_wakaba/achievement_cranecard.png",
	confessionalcard = "gfx/ui/achievement_wakaba/achievement_confessionalcard.png",
	returnpostage = "gfx/ui/achievement_wakaba/achievement_returnpostage.png",
	
	blessing = "gfx/ui/achievement_wakaba/achievement_blessing.png",
	
	blackjoker = "gfx/ui/achievement_wakaba/achievement_blackjoker.png", -- Ultra Greedier
	cloverchest = "gfx/ui/achievement_wakaba/achievement_cloverchest.png", -- Mega Satan
	eatheart = "gfx/ui/achievement_wakaba/achievement_eatheart.png", -- Delirium
	bitcoin = "gfx/ui/achievement_wakaba/achievement_bitcoin.png", -- Mother
	nemesis = "gfx/ui/achievement_wakaba/achievement_nemesis.png", -- The Beast
	
	wakabasoul = "gfx/ui/achievement_wakaba/achievement_wakabasoul.png",
	bookofforgotten = "gfx/ui/achievement_wakaba/achievement_bookofforgotten.png",

	-- Shiori Unlocks
	hardbook = "gfx/ui/achievement_wakaba/achievement_hardbook.png", -- Mom's Heart Hard
	shiorid6plus = "gfx/ui/achievement_wakaba/achievement_shiorid6plus.png", -- Isaac
	bookoffocus = "gfx/ui/achievement_wakaba/achievement_bookoffocus.png", --Satan
	deckofrunes = "gfx/ui/achievement_wakaba/achievement_deckofrunes.png", -- ???
	grimreaperdefender = "gfx/ui/achievement_wakaba/achievement_grimreaperdefender.png", -- The Lamb
	unknownbookmark = "gfx/ui/achievement_wakaba/achievement_unknownbookmark.png", -- Boss Rush
	bookoffallen = "gfx/ui/achievement_wakaba/achievement_bookoffallen.png", -- 
	bookofgatling = "gfx/ui/achievement_wakaba/achievement_bookoftrauma.png", -- Hush
	magnetheaven = "gfx/ui/achievement_wakaba/achievement_magnetheaven.png", -- Ultra Greed
	determinationribbon = "gfx/ui/achievement_wakaba/achievement_determinationribbon.png", -- Ultra Greedier
	bookofsilence = "gfx/ui/achievement_wakaba/achievement_bookofsilence.png", -- Delirium
	bookoftheking = "gfx/ui/achievement_wakaba/achievement_vintagethreat.png", -- Mother
	bookofthegod = "gfx/ui/achievement_wakaba/achievement_bookofthegod.png", --The Beast
	
	bookofshiori = "gfx/ui/achievement_wakaba/achievement_bookofshiori.png",
	
	-- Tainted Shiori Unlocks
	queenofspades = "gfx/ui/achievement_wakaba/achievement_queenofspades.png", -- Ultra Greedier
	librarycard = "gfx/ui/achievement_wakaba/achievement_anotherfortunemachine.png", -- Mega Satan
	bookofconquest = "gfx/ui/achievement_wakaba/achievement_bookofconquest.png", -- Delirium
	ringofjupiter = "gfx/ui/achievement_wakaba/achievement_ringofjupiter.png", -- Mother
	minervaaura = "gfx/ui/achievement_wakaba/achievement_minervaaura.png", -- The Beast

	shiorisoul = "gfx/ui/achievement_wakaba/achievement_shiorisoul.png",
	bookmarkbag = "gfx/ui/achievement_wakaba/achievement_bookmarkbag.png",

	taintedtsukasa = "gfx/ui/achievement_wakaba/achievement_taintedtsukasa.png",

	
	eyeofclock = "gfx/ui/achievement_wakaba/achievement_eyeofclock.png", --01w
	plumy = "gfx/ui/achievement_wakaba/achievement_plumy.png", --02w
	--ultrablackhole = false, --03w
	delimiter = "gfx/ui/achievement_wakaba/achievement_delimiter.png", -- 04w
	nekodoll = "gfx/ui/achievement_wakaba/achievement_nekofigure.png", --05w
	microdoppelganger = "gfx/ui/achievement_wakaba/achievement_microdoppelganger.png", --06w
	delirium = "gfx/ui/achievement_wakaba/achievement_dimensioncutter.png", --07w
	lilwakaba = "gfx/ui/achievement_wakaba/achievement_lilwakaba.png", --08w
	lostuniform = "gfx/ui/achievement_wakaba/achievement_lostuniform.png", --09w
	executioner = "gfx/ui/achievement_wakaba/achievement_executioner.png", -- 10w
	apollyoncrisis = "gfx/ui/achievement_wakaba/achievement_apollyoncrisis.png", -- 11w
	deliverysystem = "gfx/ui/achievement_wakaba/achievement_isekaidefinition.png", -- 12w
	calculation = "gfx/ui/achievement_wakaba/achievement_balance.png", -- 13w
	lilmao = "gfx/ui/achievement_wakaba/achievement_lilmao.png", -- 13w
	
	edensticky = "gfx/ui/achievement_wakaba/achievement_edensticky.png", -- 99w
	doubledreams = "gfx/ui/achievement_wakaba/achievement_doubledreams.png", -- 99w
}

wakaba.VoidFlags = {
	NONE = 0,
	VOID = 1,
	RKEY = 1<<1,
	CONTINUE = 1<<2,
	PIECES = 1<<3,
}

wakaba.shiorimodes = {
	["SHIORI_LIBRARIAN"] = 0,
	["SHIORI_COLLECTOR"] = 1,
	["SHIORI_AKASIC_RECORDS"] = 2,
	["SHIORI_PURE_BODY"] = 3,
	["SHIORI_CURSE_OF_SATYR"] = 4,
	["NUM_SHIORI_MAX"] = 4,
}

wakaba.shiorimodestrings = {
	[wakaba.shiorimodes.SHIORI_LIBRARIAN] = {name = "Librarian", configdesc = "Shiori starts with most books",},
	[wakaba.shiorimodes.SHIORI_COLLECTOR] = {name = "Collector", configdesc = "Shiori starts with a random book, and must be collected manually. Most book actives will be moved into pocket slot automatically",},
	[wakaba.shiorimodes.SHIORI_AKASIC_RECORDS] = {name = "Akasic Records", configdesc = "Shiori can use only 3 books per floor(Default)",},
	[wakaba.shiorimodes.SHIORI_PURE_BODY] = {name = "Pure Body", configdesc = "Shiori starts with most books, but cannot collect any collectibles. Touching the collectible will dissolved into keys",},
	--[wakaba.shiorimodes.SHIORI_MINERVA] = {name = "Minerva?", configdesc = "Unimplemented",},
	[wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR] = {name = "Curse of Saytr", configdesc = "Shiori cannot switch books manually, books will be randomized on active item usage.",},
}


wakaba.wikidesc = {}
wakaba.adjustedwikidesc = {}
wakaba.krwikidesc = {}

-- Persistent Settings - ForceVoid
--[[
	mom - Drop The Fool/Telepills after beating Mom.
	beast - Drop Bring me there trinket at starting room of Mines II/Mausoelum I
	keypiece - Drop Key Pieces after beating Chest/Dark Room
	knifepiece - Drop Knife Pieces after beating Mom in Mausoleum/Gehenna II

	crackedkey - Drop Cracked Key at the Start room in Home

	isaacsatan, bblamb, megasatan, mother, delirium
	0 : nothing, 1 : to spawn void portal, 2 : to spawn R Key
]]
wakaba.forcevoiddefaults = {
	beast = 0,
	mom = 0,
	keypiece = 1,
	knifepiece = 0,
	crackedkey = 0,

	isaacsatan = 0,
	bblamb = 0,
	megasatan = 0,
	mother = 0,
	delirium = 0,

	ignoretmtrainer = false,
}

wakaba.optiondefaults = {
	nepu = true,
	fortunereplacechance = 10,

	-- Reroll function threshold. Change this value if getting items are too laggy.
	rerolltreasurethreshold = 120,
	rerollbreakfastthreshold = 160,

	-- HUD for Pudding and Wakaba items options
	uniformalpha = 20,
	uniformscale = 100,

	-- Starting items control options
	lostuniform = true,
	edensticky = true,

	-- Costume Protector
	cp_wakaba = true,
	cp_wakaba_b = true,
	cp_shiori = true,
	cp_shiori_b = true,
	cp_tsukasa = true,
	cp_tsukasa_b = true,

	-- Shiori options
	shiorimodes = wakaba.shiorimodes.SHIORI_AKASIC_RECORDS,
	shioridreams = false,
	shiorikeychance = 50,
	shioribombchance = 50,
	shioriakasicbooks = 3,
	shioriakasicminquality = 0,
	shioriakasicmaxquality = 4,

	-- Tsukasa options
	concentrationkeyboard = Keyboard.KEY_LEFT_CONTROL,
	concentrationcontroller = (Controller and Controller.BUMPER_RIGHT) or ButtonAction.ACTION_DROP,
	lunarpercent = true,
	leftchargebardigits = true,

	mindonationcount = 5,

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
	stackablewoodencross = 0,

	-- Dogma/Beast Blanket options
	dogmablanket = true,
	beastblanket = true,

	-- Dead Wisp Notification options
	deadwispnotif = false,
	deadwispnotifsound = false,
	
	-- Inventory Descriptions options
	listoffset = 200,
	listkey = Keyboard.KEY_F5,
	idleicon = 0,
	selicon = 17,
	lemegetonicon = 18,
	q0icon = 20,
	q1icon = 21,
	q2icon = 22,
	q3icon = 23,
	q4icon = 24,
	invplayerinfos = true,
	invcurses = true,
	invcollectibles = true,
	invactives = true,
	invtrinkets = true,
	invpocketitems = true,

}


wakaba.KeyboardToString = {}

for key,num in pairs(Keyboard) do

	local keyString = key
	
	local keyStart, keyEnd = string.find(keyString, "KEY_")
	keyString = string.sub(keyString, keyEnd+1, string.len(keyString))
	
	keyString = string.gsub(keyString, "_", " ")
	
	wakaba.KeyboardToString[num] = keyString
	
end

-- Persistent Settings - Unlocks
wakaba.unlocks = {
	-- Wakaba Unlocks
	dcupicecream = 0, --Satan
	secretcard = 0, -- Ultra Greed
	pendant = 0, -- ???
	clover = 0, -- Mom's Heart Hard
	counter = 0, -- Isaac
	returnpostage = 0, --The Beast
	donationcard = 0, -- Boss Rush
	whitejoker = 0, -- 
	revengefruit = 0, --
	wakabauniform = 0, -- Delirium
	colorjoker = 0, -- 
	cranecard = 0, -- Ultra Greedier
	confessionalcard = 0, -- Mother
	
	blessing = false,
	
	-- Tainted Wakaba Unlocks
	taintedwakabamomsheart = 0,
	blackjoker = 0, -- Ultra Greedier
	wakabasoul1 = 0, -- Boss Rush
	wakabasoul2 = 0, -- Hush
	bookofforgotten1 = 0, -- 4 Bosses
	bookofforgotten2 = 0, -- 4 Bosses
	bookofforgotten3 = 0, -- 4 Bosses
	bookofforgotten4 = 0, -- 4 Bosses
	cloverchest = 0, -- Mega Satan
	eatheart = 0, -- Delirium
	bitcoin = 0, -- Mother
	nemesis = 0, -- The Beast
	
	wakabasoul = false,
	bookofforgotten = false,

	-- Shiori Unlocks
	hardbook = 0, -- Mom's Heart Hard
	shiorid6plus = 0, -- Isaac
	bookoffocus = 0, --Satan
	deckofrunes = 0, -- ???
	grimreaperdefender = 0, -- The Lamb
	unknownbookmark = 0, -- Boss Rush
	bookoffallen = 0, -- 
	bookofgatling = 0, -- Hush
	magnetheaven = 0, -- Ultra Greed
	determinationribbon = 0, -- Ultra Greedier
	bookofsilence = 0, -- Delirium
	bookoftheking = 0, -- Mother
	bookofthegod = 0, --The Beast
	
	bookofshiori = false,
	
	-- Tainted Shiori Unlocks
	taintedshiorimomsheart = 0,
	queenofspades = 0, -- Ultra Greedier
	shiorisoul1 = 0, -- Boss Rush
	shiorisoul2 = 0, -- Hush
	bookmarkbag1 = 0, -- 4 Bosses
	bookmarkbag2 = 0, -- 4 Bosses
	bookmarkbag3 = 0, -- 4 Bosses
	bookmarkbag4 = 0, -- 4 Bosses
	librarycard = 0, -- Mega Satan
	bookofconquest = 0, -- Delirium
	ringofjupiter = 0, -- Mother
	minervaaura = 0, -- The Beast

	shiorisoul = false,
	bookmarkbag = false,

	-- Tsukasa Unlocks
	murasame = 0, -- Mom's Heart Hard
	nasalover = 0, -- Isaac
	beetlejuice = 0, -- Satan
	totalcorruption = 0, -- ???
	powerbomb = 0, -- The Lamb
	concentration = 0, -- Boss Rush
	rangesystem = 0, -- Hush
	newyearbomb = 0, -- Delirium
	beam = 0, -- Mega Satan
	arcanecrystal = 0, -- Ultra Greed
	questionblock = 0, -- Ultra Greedier
	phantomcloak = 0, -- Mother
	hydra = 0, -- The Beast

	lunarstone = false,
	taintedtsukasa = false, -- Tainted Tsukasa


	
	-- Tainted Tsukasa Unlocks
	taintedtsukasamomsheart = 0,
	isaaccartridge1 = 0, -- Isaac
	isaaccartridge2 = 0, -- Satan
	isaaccartridge3 = 0, -- ???
	isaaccartridge4 = 0, -- The Lamb
	tsukasasoul1 = 0, -- Boss Rush
	tsukasasoul2 = 0, -- Hush
	flashshift = 0, -- Delirium
	maplesyrup = 0, -- Mega Satan
	returncard = 0, -- Ultra Greedier
	sirenbadge = 0, -- Mother
	elixiroflife = 0, -- The Beast
	
	isaaccartridge = false,
	tsukasasoul = false,
	
	--Challenge Unlocks
	eyeofclock = false, --01w Eye of Clock
	plumy = false, --02w Plumy
	ultrablackhole = false, --03w
	delimiter = false, --04w Delimiter
	nekodoll = false, --05w Neko Figure
	microdoppelganger = false, --06w Micro Doppelganger
	delirium = false, -- 07w Dimension CUtter
	lilwakaba = false, --08w Lil Wakaba
	lostuniform = false, --09w T.Lost Starts with Wakaba's Uniform
	executioner = false,--10w Executioner
	apollyoncrisis = false,--11w Apollyon Crisis
	deliverysystem = false,--12w Isekai Definition
	calculation = false,--13w Calculation
	lilmao = false,--14w Hold Me!

	edensticky = false,--98w T.Eden Starts with Sticky Note
	doubledreams = false, -- 99w Wakaba's Double Dreams
}

wakaba.defaultunlocks = wakaba:deepcopy(wakaba.unlocks)
if not wakaba.state then
	wakaba.state = {
		hasbless = false,
		hasnemesis = false,
		eatheartused = false,

		savedtimecounter = 0,

		satanwisp = 0,
		isbossopened = false,
		spent = false,
		blessing = {},
		nemesis = {},
		wakabaangelshops = {},
		wakabadevilshops = {},
		dicecount = 12,
		saved = false,
		eatheartcharges = 24,
		angelchance = 0,
		dreampool = ItemPoolType.POOL_NULL,
		dreamroom = RoomType.ROOM_TREASURE,
		randtainted = false,
		allowactives = true,
		rerollloopcount = 0,
		shioridropped = {},
		--- DonationCard
		silverchance = 65,
		vipchance = 65,
		nojam = false,
		totalNumCoinsDonated = 0,
		minDonationLimit = 0,
		revengecount = 7,
		--- Setting Below, Run Period Upper
		forcevoid = wakaba.forcevoiddefaults,
		options = wakaba.optiondefaults,
		currentalpha = 0,
		--wakabaoptions = wakaba.wakabaoptiondefaults,
		pog = true,
		--- Unlock State
		unlock = wakaba.unlocks,
		
		storedplayers = 0,
		playersavedata = {},
		dss_menu = {},
		pendingunlock = {},

		unlockedcloverchests = {},
		cloverchestpedestals = {},
		anotherfortunerolled = {},
		anotherfortunepedestals = {},
		-- Shiori modes
		currentshiorimode = wakaba.shiorimodes.SHIORI_AKASIC_RECORDS,

		-- Murasame Boss encounters
		murasamebosses = {},

	}	
end
--Settings Here. Modify this area to change settings

--start from new Game()
if not wakaba.defaultstate then
	wakaba.defaultstate = wakaba:deepcopy(wakaba.state)
end
--[[
wakaba.defaultstate = {
	spent = false,
	blessing = {},
	nemesis = {},
	dicecount = 12,
	saved = false,
	eatheartcharges = 24,
	angelchance = 0,
	dreampool = ItemPoolType.POOL_NULL,
	dreamroom = RoomType.ROOM_TREASURE,
	randtainted = false,
	allowactives = true,
	--- DonationCard
	silverchance = 65,
	vipchance = 65,
	totalNumCoinsDonated = 0,
	minDonationLimit = 0,
	revengecount = 7,
	--- Setting Below, Run Period Upper
	forcevoid = wakaba.forcevoiddefaults,
	options = wakaba.optiondefaults,
	--wakabaoptions = wakaba.wakabaoptiondefaults,
	pog = true,
	--- Unlock State
	unlock = wakaba.unlocks,
	
	storedplayers = 0,
	indexes = {},
	playersavedata = {},
}
]]
function wakaba:CheckWakabaChecklist()
	local haspending = false
	local pending
	if wakaba.state.unlock.blessing == false
	and wakaba.state.unlock.clover >= 2 -- Mom's Heart
	and wakaba.state.unlock.counter >= 2 -- Isaac
	and wakaba.state.unlock.dcupicecream >= 2 -- Satan
	and wakaba.state.unlock.pendant >= 2 -- ???
	and wakaba.state.unlock.revengefruit >= 2 -- The Lamb
	and wakaba.state.unlock.whitejoker >= 2 -- Mega Satan
	and wakaba.state.unlock.donationcard >= 2 -- Boss Rush
	and wakaba.state.unlock.colorjoker >= 2 -- Hush
	and wakaba.state.unlock.wakabauniform >= 2 -- Delirium
	and wakaba.state.unlock.confessionalcard >= 2 -- Mother
	and wakaba.state.unlock.returnpostage >= 2 -- The Beast
	and wakaba.state.unlock.secretcard >= 2 -- Ultra Greed
	and wakaba.state.unlock.cranecard >= 2 -- Ultra Greedier
	then
		wakaba.state.unlock.blessing = true
		if #wakaba.state.pendingunlock > 0 then
			table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.blessing)
		else
			CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.blessing)
		end
	end
	if wakaba.state.unlock.wakabasoul == false
	and wakaba.state.unlock.wakabasoul1 > 0
	and wakaba.state.unlock.wakabasoul2 > 0
	then
		wakaba.state.unlock.wakabasoul = true
		CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.wakabasoul)
	end
	if wakaba.state.unlock.bookofforgotten == false
	and wakaba.state.unlock.bookofforgotten1 > 0
	and wakaba.state.unlock.bookofforgotten2 > 0
	and wakaba.state.unlock.bookofforgotten3 > 0
	and wakaba.state.unlock.bookofforgotten4 > 0
	then
		wakaba.state.unlock.bookofforgotten = true
		CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookofforgotten)
	end
	
	if wakaba.state.unlock.bookofshiori == false
	and wakaba.state.unlock.hardbook >= 2 -- Mom's Heart
	and wakaba.state.unlock.shiorid6plus >= 2 -- Isaac
	and wakaba.state.unlock.bookoffocus >= 2 -- Satan
	and wakaba.state.unlock.deckofrunes >= 2 -- ???
	and wakaba.state.unlock.grimreaperdefender >= 2 -- The Lamb
	and wakaba.state.unlock.bookoffallen >= 2 -- Mega Satan
	and wakaba.state.unlock.unknownbookmark >= 2 -- Boss Rush
	and wakaba.state.unlock.bookofgatling >= 2 -- Hush
	and wakaba.state.unlock.bookofsilence >= 2 -- Delirium
	and wakaba.state.unlock.bookoftheking >= 2 -- Mother
	and wakaba.state.unlock.bookofthegod >= 2 -- The Beast
	and wakaba.state.unlock.magnetheaven >= 2 -- Ultra Greed
	and wakaba.state.unlock.determinationribbon >= 2 -- Ultra Greedier
	then
		wakaba.state.unlock.bookofshiori = true
		if #wakaba.state.pendingunlock > 0 then
			table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.bookofshiori)
		else
			CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookofshiori)
		end
	end
	
	if wakaba.state.unlock.shiorisoul == false
	and wakaba.state.unlock.shiorisoul1 > 0
	and wakaba.state.unlock.shiorisoul2 > 0
	then
		wakaba.state.unlock.shiorisoul = true
		CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.shiorisoul)
	end
	if wakaba.state.unlock.bookmarkbag == false
	and wakaba.state.unlock.bookmarkbag1 > 0
	and wakaba.state.unlock.bookmarkbag2 > 0
	and wakaba.state.unlock.bookmarkbag3 > 0
	and wakaba.state.unlock.bookmarkbag4 > 0
	then
		wakaba.state.unlock.bookmarkbag = true
		CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookmarkbag)
	end
	
	
	if wakaba.state.unlock.lunarstone == false
	and wakaba.state.unlock.murasame >= 2 -- Mom's Heart
	and wakaba.state.unlock.nasalover >= 2 -- Isaac
	and wakaba.state.unlock.beetlejuice >= 2 -- Satan
	and wakaba.state.unlock.totalcorruption >= 2 -- ???
	and wakaba.state.unlock.powerbomb >= 2 -- The Lamb
	and wakaba.state.unlock.beam >= 2 -- Mega Satan
	and wakaba.state.unlock.concentration >= 2 -- Boss Rush
	and wakaba.state.unlock.rangesystem >= 2 -- Hush
	and wakaba.state.unlock.newyearbomb >= 2 -- Delirium
	and wakaba.state.unlock.phantomcloak >= 2 -- Mother
	and wakaba.state.unlock.hydra >= 2 -- The Beast
	and wakaba.state.unlock.arcanecrystal >= 2 -- Ultra Greed
	and wakaba.state.unlock.questionblock >= 2 -- Ultra Greedier
	then
		wakaba.state.unlock.lunarstone = true
		if #wakaba.state.pendingunlock > 0 then
			--table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.lunarstone)
		else
			--CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.lunarstone)
		end
	end
	
	if wakaba.state.unlock.tsukasasoul == false
	and wakaba.state.unlock.tsukasasoul1 > 0
	and wakaba.state.unlock.tsukasasoul2 > 0
	then
		wakaba.state.unlock.tsukasasoul = true
		--CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.tsukasasoul)
	end
	if wakaba.state.unlock.isaaccartridge == false
	and wakaba.state.unlock.isaaccartridge1 > 0
	and wakaba.state.unlock.isaaccartridge2 > 0
	and wakaba.state.unlock.isaaccartridge3 > 0
	and wakaba.state.unlock.isaaccartridge4 > 0
	then
		wakaba.state.unlock.isaaccartridge = true
		--CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.isaaccartridge)
	end

	wakaba:SaveData(json.encode(wakaba.state))
end

--resetSettings (planned)
wakaba.defaultsettings = {

}

--Global Functions and variables

local HUD = Game():GetHUD()
wakaba.RNG = RNG()
wakaba.ItemRNG = RNG()
wakaba.PickupRNG = RNG()
wakaba.ItemConfig = Isaac.GetItemConfig()

function wakaba:has_value (tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

function wakaba:InsertBlessing(id)
	if not wakaba:has_value(wakaba.state.blessing, id) then
		table.insert(wakaba.state.blessing, id)
	end
end
function wakaba:InsertNemesis(id)
	if not wakaba:has_value(wakaba.state.nemesis, id) then
		table.insert(wakaba.state.nemesis, id)
	end
end

function wakaba:GetScreenSize()
    local room = Game():GetRoom()
    local pos = room:WorldToScreenPosition(Vector(0,0)) - room:GetRenderScrollOffset() - Game().ScreenShakeOffset
    
    local rx = pos.X + 60 * 26 / 40
    local ry = pos.Y + 140 * (26 / 40)
    
    return Vector(rx*2 + 13*26, ry*2 + 7*26)
end
function wakaba:GetScreenCenter()
    return wakaba:GetScreenSize()/2
end
function wakaba:GetGridCenter() --returns Vector
	local room = Game():GetRoom()
	
	local topleft = room:GetTopLeftPos()
	local bottomright = room:GetBottomRightPos()
	local topright = Vector(bottomright.X, topleft.Y)
	local bottomleft = Vector(topleft.X, bottomright.Y)
	
	local centerX = topleft.X + ((bottomright.X - topleft.X) / 2)
	local centerY = topleft.Y + ((bottomright.Y - topleft.Y) / 2)
	return Vector(centerX, centerY)
end

--A Tears Up function by Kilburn and Dead
function wakaba:TearsUp(firedelay, val, ignoreNegative)
	if val < 0 then
		return firedelay - val
	else
		local currentTears = 30 / (firedelay + 1)
		local newTears = ignoreNegative and (currentTears + val) or math.max(currentTears + val, 0.1)
		return math.max((30 / newTears) - 1, -0.75)
	end
end

function wakaba:GetMaxCollectibleID()
	return Isaac.GetItemConfig():GetCollectibles().Size -1
end

function wakaba:WhitelistTag(tag)
	local items = Game():GetItemPool()
	local itemID = 0
	local maxID = wakaba:GetMaxCollectibleID()
  local lastItem = Isaac.GetItemConfig():GetCollectible(itemID)
  repeat
    itemID = itemID + 1
    lastItem = Isaac.GetItemConfig():GetCollectible(itemID)
		if lastItem ~= nil and not lastItem:HasTags(tag) then
			--Isaac.ConsoleOutput("Removed : "..itemID.."/"..maxID.. "\n")
			Game():GetItemPool():RemoveCollectible(itemID)
		end
  until itemID > maxID
end

function wakaba:BlacklistTag(tag)
	local items = Game():GetItemPool()
	local itemID = 0
	local maxID = wakaba:GetMaxCollectibleID()
  local lastItem = Isaac.GetItemConfig():GetCollectible(itemID)
  repeat
    itemID = itemID + 1
    lastItem = Isaac.GetItemConfig():GetCollectible(itemID)
		if lastItem ~= nil and lastItem:HasTags(tag) then
			--Isaac.ConsoleOutput("Removed : "..itemID.."/"..maxID.. "\n")
			Game():GetItemPool():RemoveCollectible(itemID)
		end
  until itemID > maxID
end


function wakaba:PostWakabaRender()
	--check for costume update
	if wakaba.costumecurrframe > 0 then
		wakaba.costumecurrframe = wakaba.costumecurrframe - 1
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.PostWakabaRender)

--reset currframe when use an active item
function wakaba.ItemUseCostumeReset()
  wakaba.costumecurrframe = 0
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUseCostumeReset)

--[[
	Get Offset by Peachee
  @param {int} notches - the number of notches filled in on hud offset (default inGame() is between 0-10)
  @param {float} x - original x coordinate
  @param {float} y - original y coordinate
  @param {string} anchor - the anchoring position of the element: "topleft", "topright", "bottomleft", "bottomright" IE. stats are "topleft", minimap is "topright"
]]
function wakaba.hudoffset(notches, x, y, anchor)
	local xoffset = (notches*2)
	local yoffset = ((1/8)*(10*notches+(-1)^notches+7))
	if anchor == "topleft" then
			xoffset = x+xoffset
			yoffset = y+yoffset
	elseif anchor == "topright" then
			xoffset = x-xoffset
			yoffset = y+yoffset
	elseif anchor == "bottomleft" then
			xoffset = x+xoffset
			yoffset = y-yoffset
	elseif anchor == "bottomright" then
			xoffset = x-xoffset
			yoffset = y-yoffset
	else
			error("invalid anchor provided. Must be one of wakaba.f: \"topleft\", \"topright\", \"bottomleft\", \"bottomright\"", 2)
	end
	return xoffset, yoffset
end


local activePendingPapers = false

function wakaba:activePapers()
  local game = Game()
  local room = Game():GetRoom()
  local level = Game():GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
  local StartingRoom = 84
	if room:IsFirstVisit() and CurRoom == StartingRoom then
		if #wakaba.state.pendingunlock > 0 then
			activePendingPapers = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.activePapers)

function wakaba:playPendingPaper()
	if activePendingPapers == true then
		if #wakaba.state.pendingunlock > 0 then
			for i = 1, #wakaba.state.pendingunlock do
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.state.pendingunlock[i])
			end
			wakaba.state.pendingunlock = {}
		end
		activePendingPapers = false
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.playPendingPaper)

--Scripts
--APIs, Wakaba's Blessing, Nemesis must be loaded first due to item usages
--스크립트 로딩
--API, 축복, 시련 아이템은 가장 먼저 로딩

include('wakaba_reserved_enums')
include('scripts.damocles_api')

include('scripts.enums.players')
include('scripts.enums.costumes')
include('scripts.enums.wakabachargebar')

include('scripts.items.0000_blessing')
include('scripts.items.0001_bookofshiori')
include('scripts.items.0003_bookofconquest')
include('scripts.items.0004_minerva')
include('scripts.items.0006_lunarstone')
include('scripts.items.0007_elixiroflife')
include('scripts.items.0008_flashshift')
include('scripts.items.0009_concentration')
include('scripts.items.1001_eatheart')

include('scripts.items.1002_bookofforgotten')
include('scripts.items.1003_dcupicecream')
include('scripts.items.1004_gamecd')
include('scripts.items.1005_wakabapendant')
include('scripts.items.1006_secretcard')
include('scripts.items.1007_plumy')
include('scripts.items.1008_executioner')
include('scripts.items.1009_newyearbomb')
--include('scripts.items.1010_newyearbomb')
include('scripts.items.1011_revengefruit')
include('scripts.items.1012_uniform')
include('scripts.items.1015_eyeofclock')
include('scripts.items.1016_lilwakaba')
include('scripts.items.1017_counter')
include('scripts.items.1018_returnpostage')
include('scripts.items.1019_d6plus')
include('scripts.items.1020_lilmoe')
include('scripts.items.1023_bookoffocus')
include('scripts.items.1024_deckofrunes')
include('scripts.items.1025_microdoppelganger')
include('scripts.items.1026_bookofsilence')
include('scripts.items.1027_vintagethreat')
include('scripts.items.1028_bookofthegod')
include('scripts.items.1029_grimreaperdefender')
include('scripts.items.1030_bookoftrauma')
include('scripts.items.1031_bookofthefallen')
include('scripts.items.1032_maijimamythology')
include('scripts.items.1033_apollyoncrisis')
include('scripts.items.1034_lilshiva')
include('scripts.items.1035_nekofigure')
include('scripts.items.1036_dejavu')
include('scripts.items.1038_lilmao')
include('scripts.items.1039_isekaidefinition')
include('scripts.items.1040_balance')
include('scripts.items.1041_moemuffin')
include('scripts.items.1044_clovershard')


include('scripts.items.1042_murasame')
include('scripts.items.1045_nasalover')
include('scripts.items.1046_crystals')
include('scripts.items.1047_3dprinter')
include('scripts.items.1048_powerbomb')
include('scripts.items.1049_syrup')
include('scripts.items.1050_phantomcloak')
include('scripts.items.1051_questionblock')
include('scripts.items.1052_clensingfoam')
include('scripts.items.1053_beetlejuice')
include('scripts.items.1054_curseofthetower2')
include('scripts.items.1056_venomincantation')
include('scripts.items.1057_fireflylighter')
include('scripts.items.1058_doubleinvader')

include('scripts.pickups.2005_dreamcard')
include('scripts.items.1200_doubledreams')
include('scripts.items.1201_edenstickynote')

--include('scripts.pickups.2001_donationcard')
include('scripts.pickups.2002_cranecard')
include('scripts.pickups.2003_confessionalcard')
include('scripts.pickups.2004_jokers')
include('scripts.pickups.2006_unknownbookmark')
include('scripts.pickups.2007_queenofspades')
include('scripts.pickups.2008_returntoken')
include('scripts.pickups.2100_pills')
include('scripts.pickups.2501_wakabasoul')
include('scripts.pickups.2502_shiorisoul')

include('scripts.items.3000_notepathfinder')
include('scripts.items.3001_bitcoin')
include('scripts.items.3002_clover')
include('scripts.items.3003_magnetheaven')
include('scripts.items.3004_hardbook')
include('scripts.items.3005_determinationribbon')
include('scripts.items.3006_bookmarkbag')
include('scripts.items.3007_ringofjupiter')
include('scripts.items.3008_dimensioncutter')
include('scripts.items.3009_delimiter')
include('scripts.items.3010_rangeos')
include('scripts.items.3011_sirenbadge')

include('scripts.pickups.4000_cloverchest')

include('scripts.entities.anotherfortune')

include('scripts.characters.wakaba')
include('scripts.characters.wakaba_b')
include('scripts.characters.shiori')
include('scripts.characters.shiori_b')
include('scripts.characters.tsukasa')
include('scripts.characters.tsukasa_b')
include('scripts.common')

include('scripts.items.0002_bookofshiori_func')

include('scripts.functions.charge')
include('scripts.functions.revival')

include('challenges')
include('scripts.curses')


include('scripts.descriptions.en_us')
include('scripts.descriptions.ko_kr')
include('scripts.eidappend')


include('scripts.devilangel')
include('scripts.encyclopedia')
include('scripts.rerollcheck')
include('scripts.wardrobeplus')
include('scripts.stackablemantle')
include('scripts.deadwispnotif')
include('scripts.inventorydesc')
include('scripts.minimapi')
include('scripts.wisps')
include('scripts.config')
include('scripts.console_commands')

--require 'monster'


-- This must be call very last
function wakaba:TakeDmg_VintageThreat(entity, amount, flag, source, countdownFrames)
	if entity.Type == EntityType.ENTITY_PLAYER
	and not (flag & DamageFlag.DAMAGE_NO_PENALTIES == DamageFlag.DAMAGE_NO_PENALTIES or flag & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS)
	then
		local player = entity:ToPlayer()
		--Double check just in case
		if not player:GetData().wakaba or (flag & DamageFlag.DAMAGE_NO_PENALTIES == DamageFlag.DAMAGE_NO_PENALTIES or flag & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS) then return end
		if player:GetData().wakaba.vintagethreat then
			--print(flag)
			player:GetData().wakaba.vintagekill = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_VintageThreat)

--init 맨 마지막에 발동

function wakaba:init(continue)
	wakaba.eidHideInBattle = EID.Config["HideInBattle"]
	wakaba.RNG:SetSeed(Game():GetSeeds():GetStartSeed(), 35)
  --Isaac.DebugString(wakaba.state)
  if wakaba:HasData() then
		Isaac.DebugString(wakaba:LoadData())
		wakaba.state = json.decode(wakaba:LoadData())
		wakaba:reinitStates()
  end
  if (not continue) then
		-- Starting new run
		wakaba.state.saved = false
    wakaba.state.savedtimecounter = 0
    wakaba.state.spent = wakaba.defaultstate.spent
    wakaba.state.blessing = wakaba.defaultstate.blessing
    wakaba.state.nemesis = wakaba.defaultstate.nemesis
    wakaba.state.dicecount = wakaba.defaultstate.dicecount
    wakaba.state.eatheartcharges = wakaba.defaultstate.eatHeartCharges
    wakaba.state.nojam = wakaba.defaultstate.nojam
		wakaba.state.hasnemesis = false
		wakaba.state.hasbless = false
		wakaba.state.eatheartused = false
    wakaba.state.totalNumCoinsDonated = wakaba.defaultstate.totalNumCoinsDonated
    wakaba.state.minDonationLimit = wakaba.defaultstate.minDonationLimit
    wakaba.state.angelchance = 0
		wakaba.state.dreampool = ItemPoolType.POOL_NULL
		wakaba.state.dreamroom = RoomType.ROOM_TREASURE
		wakaba.state.revengecount = 7
		wakaba.state.randtainted = false
		wakaba.state.allowactives = true
    wakaba.state.shioridropped = wakaba.defaultstate.shioridropped
    wakaba.state.satanwisp = wakaba.defaultstate.satanwisp
		wakaba.state.wakabaangelshops = {}
		wakaba.state.wakabadevilshops = {}
		wakaba.state.unlockedcloverchests = {}
		wakaba.state.cloverchestpedestals = {}
		wakaba.state.anotherfortunepedestals = {}
		wakaba.state.murasamebosses = {}
		wakaba.state.currentshiorimode = wakaba.state.options.shiorimodes
		--wakaba.state.storedplayers = 0
		--wakaba.state.playersavedata = {}

		-- Removing locked items
		for i = wakaba.COLLECTIBLE_WAKABAS_BLESSING, Isaac.GetItemConfig():GetCollectibles().Size -1 do
			local isUnlocked = wakaba:unlockCheck(i)
			if not isUnlocked then
				Isaac.DebugString("[wakaba]Item ID ".. i .. " Not unlocked! removing from the pools...")
				Game():GetItemPool():RemoveCollectible(i)
			end
			if EID then
				EID.itemUnlockStates[i] = isUnlocked
			end
		end
		-- Removing locked trinkets(doesn't work)
		--[[ for i = wakaba.TRINKET_CLOVER, Isaac.GetItemConfig():GetTrinkets().Size -1 do
			if not wakaba:trinketUnlockCheck(i) then
				Isaac.DebugString("[wakaba]Trinket ID ".. i .. " Not unlocked! removing from the pools...")
				Game():GetItemPool():RemoveCollectible(i)
			end
		end ]]
	else
		wakaba.state.saved = true
		local tempplayerdatas = wakaba.state.playersavedata
		local reservedplayerdatas = {}

		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			for i = 1, #tempplayerdatas do
				--print(tempplayerdatas[i].hash , player:GetData().wakaba_lhash)
				if wakaba:getstoredhash(player) == tempplayerdatas[i].hash 
        or player:GetData().wakaba_lhash == tempplayerdatas[i].hash then
					player:GetData().wakaba = tempplayerdatas[i]
					table.insert(reservedplayerdatas, tempplayerdatas[i])
          player:AddCacheFlags(CacheFlag.CACHE_ALL)
          player:EvaluateItems()
					break
				end
			end
		end
		wakaba.state.playersavedata = reservedplayerdatas
  end
	-- Run this whether continue or not
	if EID then
		wakaba:UpdateWakabaDescriptions()
		--wakaba:UpdateWakabaEncyclopediaDescriptions()
	end
	wakaba.wispupdaterequired = true
end


function wakaba:getUnlockState()
  if wakaba:HasData() then
		local tempstate = json.decode(wakaba:LoadData())
		if tempstate.unlock ~= nil then
			for k, v in pairs(wakaba.state.unlock) do
				if tempstate.unlock[k] == nil then
					tempstate.unlock[k] = wakaba.unlocks[k]
				end
			end
			wakaba.state.unlock = tempstate.unlock
		end
		if tempstate.options ~= nil then
			for k, v in pairs(wakaba.state.options) do
				if tempstate.options[k] == nil then
					tempstate.options[k] = wakaba.defaultstate.options[k]
				end
			end
			wakaba.state.options = tempstate.options
		end
	end

end

function wakaba:reinitStates()
  if wakaba:HasData() then
		local isUnlocked = "Unlocked = "
		local isHardUnlocked = "Hard Unlocked = "
		local isBoolUnlocked = "Boolean Unlocked = "
		local isNotUnlocked = "Not Unlocked = "

		local tempstate = json.decode(wakaba:LoadData())
		if tempstate ~= nil then
			for k, v in pairs(wakaba.state) do
				if tempstate[k] == nil or type(tempstate[k]) ~= "table" then
					--print("[wakaba]resetting state value :", k)
					Isaac.DebugString("[wakaba]resetting state value : ".. k)
					tempstate[k] = wakaba.defaultstate[k]
				end
			end
		end
		if tempstate.unlock ~= nil then
			for k, v in pairs(wakaba.state.unlock) do
				if tempstate.unlock[k] == nil then
					tempstate.unlock[k] = wakaba.unlocks[k]
				end
				if type(tempstate.unlock[k]) == "number" and tempstate.unlock[k] == 0 then
					isNotUnlocked = isNotUnlocked .. " " .. k
				elseif type(tempstate.unlock[k]) == "number" and tempstate.unlock[k] == 1 then
					isUnlocked = isUnlocked .. " " .. k
				elseif type(tempstate.unlock[k]) == "number" and tempstate.unlock[k] == 2 then
					isHardUnlocked = isHardUnlocked .. " " .. k
				elseif type(tempstate.unlock[k]) == "boolean" and tempstate.unlock[k] == true then
					isBoolUnlocked = isBoolUnlocked .. " " .. k
				elseif type(tempstate.unlock[k]) == "boolean" and tempstate.unlock[k] == false then
					isNotUnlocked = isNotUnlocked .. " " .. k
				end
			end
			wakaba.state.unlock = tempstate.unlock
		end
		if tempstate.forcevoid ~= nil and type(tempstate.forcevoid) == "boolean" then
			wakaba.state.forcevoid = wakaba.forcevoiddefaults
		elseif tempstate.forcevoid ~= nil then
			for k, v in pairs(wakaba.forcevoiddefaults) do
				if tempstate.forcevoid[k] == nil or type(tempstate.forcevoid[k]) == "boolean" then
					tempstate.forcevoid[k] = wakaba.forcevoiddefaults[k]
				end
			end
			wakaba.state.forcevoid = tempstate.forcevoid
		end
		if tempstate.options ~= nil then
			for k, v in pairs(wakaba.optiondefaults) do
				if tempstate.options[k] == nil then
					--print("[wakaba]resetting options :", k)
					Isaac.DebugString("[wakaba]resetting options : ".. k)
					tempstate.options[k] = wakaba.optiondefaults[k]
				end
			end
			wakaba.state.options = tempstate.options
		end

		wakaba.state.indexes = nil -- no longer used anymore

	end
end

function wakaba:luamodInit()
  if wakaba:HasData() then
		Isaac.DebugString(wakaba:LoadData())

		wakaba:reinitStates()
	else
		wakaba.state = wakaba:deepcopy(wakaba.defaultstate)
		wakaba.state.unlock = wakaba:deepcopy(wakaba.defaultunlocks)
  end
end

function wakaba:GetEntityData(entity)
end

function wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if data.wakaba == nil then
		data.wakaba = {
			hash = phash,
			sindex = wakaba.state.storedplayers,
			uniform = {-- Wakaba's Uniform
				cursor = 1,
				items = {
					[1] = {type = nil, cardpill = nil},
					[2] = {type = nil, cardpill = nil},
					[3] = {type = nil, cardpill = nil},
					[4] = {type = nil, cardpill = nil},
					[5] = {type = nil, cardpill = nil},
				}
			},
			statmodify = {
				damage = 0,
				falsedamage = 0,
				tears = 0,
				range = 0,
				luck = 0,
				speed = 0,
				shotspeed = 0,
			},
			statmultiplier = {
				damage = 0,
				tears = 0,
				range = 0,
				luck = 0,
				speed = 0,
				shotspeed = 0,
			},
		}
	end
	return data.wakaba
end

function wakaba:PostGlobalPlayerInit(player)
	wakaba:luamodInit() -- MC_POST_GAME_STARTED calls later than here. Init Loadfile from here to preserve unlock status
  local TotPlayers = #Isaac.FindByType(EntityType.ENTITY_PLAYER)
	local phash = wakaba:getstoredhash(player)
	--print(phash)
  
  if TotPlayers == 0 then
    wakaba.state.storedplayers = 0
    
    if Game():GetFrameCount() == 0 then
      --print("Game Started")
			wakaba.state.playersavedata = {}
    else
      --print("Continue")
    end
  end
  
  wakaba.state.storedplayers = wakaba.state.storedplayers + 1
	print(wakaba.state.storedplayers, #wakaba.state.playersavedata)

  if wakaba.state.storedplayers - 1 == #wakaba.state.playersavedata then
    -- run player init code
		-- Persistent Player Data
		player:GetData().wakaba = {
			hash = phash,
			hashindex = phash,
			sindex = wakaba.state.storedplayers,
			uniform = {-- Wakaba's Uniform
				cursor = 1,
				items = {
					[1] = {type = nil, cardpill = nil},
					[2] = {type = nil, cardpill = nil},
					[3] = {type = nil, cardpill = nil},
					[4] = {type = nil, cardpill = nil},
					[5] = {type = nil, cardpill = nil},
				}
			},
			statmodify = {
				damage = 0,
				falsedamage = 0,
				tears = 0,
				range = 0,
				luck = 0,
				speed = 0,
				shotspeed = 0,
			},
			statmultiplier = {
				damage = 0,
				tears = 0,
				range = 0,
				luck = 0,
				speed = 0,
				shotspeed = 0,
			},
		}
    wakaba.state.playersavedata[wakaba.state.storedplayers] = {
			hashindex = phash,
			index = wakaba.state.storedplayers,
    }
		print("assign")
  end
	player:GetData().wakaba_lhash = phash
	Isaac.DebugString("[wakaba]Wakaba - Persistent Data registered.")

	if Game().TimeCounter == 0 then
		if wakaba.state.unlock.edensticky and wakaba.state.options.edensticky and Game().Challenge == Challenge.CHALLENGE_NULL and player:GetPlayerType() == 30 then
			player:SetPocketActiveItem(wakaba.COLLECTIBLE_EDEN_STICKY_NOTE, ActiveSlot.SLOT_POCKET, false)
		elseif wakaba.state.unlock.lostuniform and wakaba.state.options.lostuniform and Game().Challenge == Challenge.CHALLENGE_NULL and player:GetPlayerType() == 31 then
			player:AddCollectible(wakaba.COLLECTIBLE_UNIFORM, 0, false, ActiveSlot.SLOT_PRIMARY, 0)
		end
	end


  costumeProtector:AddPlayer(
    player,
    wakaba.PLAYER_WAKABA,
    "gfx/characters/costumes/character_wakaba.png",
    67, --A separate costume that is added for all cases that you ever gain flight.
    "gfx/characters/costumes/character_wakaba.png", --Your character's spritesheet, but customized to have your flight costume.
    wakaba.COSTUME_WAKABA --Your character's additional costume. Hair, ears, whatever.
  )
  costumeProtector:ItemCostumeWhitelist(wakaba.PLAYER_WAKABA, wakaba.costumeCollectibleWhiteList)
  costumeProtector:NullItemIDWhitelist(wakaba.PLAYER_WAKABA, wakaba.costumeNullWhiteList)

  costumeProtector:AddPlayer(
    player,
    wakaba.PLAYER_WAKABA_B,
    "gfx/characters/costumes/character_wakabab.png",
    40, --A separate costume that is added for all cases that you ever gain flight.
    "gfx/characters/costumes/character_wakabab.png", --Your character's spritesheet, but customized to have your flight costume.
    wakaba.COSTUME_WAKABA_B --Your character's additional costume. Hair, ears, whatever.
  )
  costumeProtector:ItemCostumeWhitelist(wakaba.PLAYER_WAKABA_B, wakaba.costumeCollectibleWhiteList)
  costumeProtector:NullItemIDWhitelist(wakaba.PLAYER_WAKABA_B, wakaba.costumeNullWhiteList)

  costumeProtector:AddPlayer(
    player,
    wakaba.PLAYER_SHIORI,
    "gfx/characters/costumes/character_shiori.png",
    67, --A separate costume that is added for all cases that you ever gain flight.
    "gfx/characters/costumes/character_shiori.png", --Your character's spritesheet, but customized to have your flight costume.
    wakaba.COSTUME_SHIORI --Your character's additional costume. Hair, ears, whatever.
  )
  costumeProtector:ItemCostumeWhitelist(wakaba.PLAYER_SHIORI, wakaba.costumeCollectibleWhiteList)
  costumeProtector:NullItemIDWhitelist(wakaba.PLAYER_SHIORI, wakaba.costumeNullWhiteList)
  costumeProtector:AddPlayer(
    player,
    wakaba.PLAYER_SHIORI_B,
    "gfx/characters/costumes/character_shiorib.png",
    wakaba.COSTUME_SHIORI_B_BODY, --A separate costume that is added for all cases that you ever gain flight.
    "gfx/characters/costumes/character_shiorib.png", --Your character's spritesheet, but customized to have your flight costume.
    wakaba.COSTUME_SHIORI_B --Your character's additional costume. Hair, ears, whatever.
  )
  costumeProtector:ItemCostumeWhitelist(wakaba.PLAYER_SHIORI_B, wakaba.costumeCollectibleWhiteList)
  costumeProtector:NullItemIDWhitelist(wakaba.PLAYER_SHIORI_B, wakaba.costumeNullWhiteList)

  
  costumeProtector:AddPlayer(
    player,
    wakaba.PLAYER_TSUKASA,
    "gfx/characters/costumes/character_tsukasa.png",
    67, --A separate costume that is added for all cases that you ever gain flight.
    "gfx/characters/costumes/character_tsukasa.png", --Your character's spritesheet, but customized to have your flight costume.
    wakaba.COSTUME_TSUKASA --Your character's additional costume. Hair, ears, whatever.
  )
  costumeProtector:ItemCostumeWhitelist(wakaba.PLAYER_TSUKASA, wakaba.costumeCollectibleWhiteList)
  costumeProtector:NullItemIDWhitelist(wakaba.PLAYER_TSUKASA, wakaba.costumeNullWhiteList)

  costumeProtector:AddPlayer(
    player,
    wakaba.PLAYER_TSUKASA_B,
    "gfx/characters/costumes/character_tsukasab.png",
    67, --A separate costume that is added for all cases that you ever gain flight.
    "gfx/characters/costumes/character_tsukasab.png", --Your character's spritesheet, but customized to have your flight costume.
    wakaba.COSTUME_TSUKASA_B --Your character's additional costume. Hair, ears, whatever.
  )
  costumeProtector:ItemCostumeWhitelist(wakaba.PLAYER_TSUKASA_B, wakaba.costumeCollectibleWhiteList)
  costumeProtector:NullItemIDWhitelist(wakaba.PLAYER_TSUKASA_B, wakaba.costumeNullWhiteList)
	--print(player:GetPlayerType(), #costumeProtector.PlayerNullItemCostumeWhitelist[player:GetPlayerType()], costumeProtector.PlayerNullItemCostumeWhitelist[player:GetPlayerType()][CollectibleType.COLLECTIBLE_LUNA])
	
	--wakaba:save(true)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostGlobalPlayerInit)

local changeCostume = false

function wakaba:PlayerUpdate_Costume(player)
	if wakaba:has_value(wakaba.cpmanagedplayertype, player:GetPlayerType()) then
		local mmcount = player:GetData().wakaba.megamush or 0
		local megamush = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_MEGA_MUSH)
		if mmcount ~= megamush then
			if megamush > 0 then
				wakaba.costumeCollectibleWhiteList[CollectibleType.COLLECTIBLE_MEGA_MUSH] = true
				costumeProtector:ItemCostumeWhitelist(player:GetPlayerType(), wakaba.costumeCollectibleWhiteList)
			else
				wakaba.costumeCollectibleWhiteList[CollectibleType.COLLECTIBLE_MEGA_MUSH] = false
				costumeProtector:ItemCostumeWhitelist(player:GetPlayerType(), wakaba.costumeCollectibleWhiteList)
			end
			player:GetData().wakaba.megamush = megamush
			costumeProtector:ResetPlayerCostumes(player)
		end
		if changeCostume then
			--player:ClearCostumes()
			changeCostume = false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Costume)

local function CostumeUpdate_wakaba(player)
	changeCostume = true
	--print("reset costume")
end
costumeProtector.AddCallback("MC_POST_COSTUME_RESET", CostumeUpdate_wakaba)


function wakaba:getcurrentindex(player)
	for num = 0, Game():GetNumPlayers()-1 do
		if GetPtrHash(player) == GetPtrHash(Isaac.GetPlayer(num)) then 
			return num + 1
		end
	end
end

function wakaba:getstoredindex(player)
	if not player then return end
	if player:GetData().wakaba and player:GetData().wakaba.sindex then 
		return player:GetData().wakaba.sindex
	end
  return false
end

function wakaba:getstoredhash(player)
	player = player or player:ToPlayer()
	local playerType = player:GetPlayerType()
	local refItem = CollectibleType.COLLECTIBLE_SAD_ONION
	if playerType == PlayerType.PLAYER_LAZARUS2_B then refItem = CollectibleType.COLLECTIBLE_INNER_EYE end
  local collectibleRNG = player:GetCollectibleRNG(refItem)
  local seed = collectibleRNG:GetSeed()
  local seedString = tostring(seed)

	return seedString
end

--no empty pedestals code from Nato Potato. Only active when potatopack2 is not active
if potatopack2 == nil then
	function wakaba:removePedestal(pickup)
		local hasflip = false
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if player:HasCollectible(CollectibleType.COLLECTIBLE_FLIP) then
				hasflip = true
			end
		end
		if not hasflip and pickup.SubType == 0 then
			pickup:Remove()
		end
	end
	--wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE , wakaba.removePedestal, 100);
end



function wakaba:save(shouldSave)
	if shouldSave then
		Isaac.DebugString("[wakaba]Wakaba - Data Saving start")
		wakaba.state.saved = true
		wakaba.state.intversion = wakaba.intversion
		wakaba.state.savedtimecounter = Game():GetFrameCount()
		--wakaba.state.playersavedata = {}
		local reservedplayersavedata = {}

		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			--[[ local playerdata = player:GetData().wakaba
			local playerindex = player:GetData().wakaba_cindex
			if playerdata then
			end ]]
			local playerdata = player:GetData().wakaba
			local sti = player:GetData().wakaba.sindex
			if sti ~= nil then
				table.insert(reservedplayersavedata, playerdata)
				Isaac.DebugString("[wakaba] - Saving player data : ".. json.encode(playerdata))

			end
		end
		wakaba.state.playersavedata = reservedplayersavedata
    wakaba:SaveData(json.encode(wakaba.state))
		Isaac.DebugString("[wakaba]Wakaba - Data Saving end")
	end
end

function wakaba:unlockWakaba(bool)
	bool = bool or true
	wakaba.state.unlock.dcupicecream = 2 --Satan
	wakaba.state.unlock.secretcard = 2 -- Ultra Greed
	wakaba.state.unlock.pendant = 2 -- ???
	wakaba.state.unlock.clover = 2 -- Mom's Heart Hard
	wakaba.state.unlock.counter = 2 -- Isaac
	wakaba.state.unlock.returnpostage = 2 --The Beast
	wakaba.state.unlock.donationcard = 2 -- Boss Rush
	wakaba.state.unlock.whitejoker = 2 -- 
	wakaba.state.unlock.revengefruit = 2 --
	wakaba.state.unlock.wakabauniform = 2 -- Delirium
	wakaba.state.unlock.colorjoker = 2 -- 
	wakaba.state.unlock.cranecard = 2 -- Ultra Greedier
	wakaba.state.unlock.confessionalcard = 2 -- Mother
	wakaba.state.unlock.blessing = true
	
	print("Cheating Wakaba unlocks complete.")
	Isaac.DebugString("[wakaba]Cheating Wakaba unlocks complete.")
	wakaba:save(true)
end

function wakaba:unlockTaintedWakaba(bool)
	bool = bool or true
	wakaba.state.unlock.taintedwakabamomsheart = 2
	wakaba.state.unlock.blackjoker = 2 -- Ultra Greedier
	wakaba.state.unlock.wakabasoul1 = 2 -- Boss Rush
	wakaba.state.unlock.wakabasoul2 = 2 -- Hush
	wakaba.state.unlock.bookofforgotten1 = 2 -- 4 Bosses
	wakaba.state.unlock.bookofforgotten2 = 2 -- 4 Bosses
	wakaba.state.unlock.bookofforgotten3 = 2 -- 4 Bosses
	wakaba.state.unlock.bookofforgotten4 = 2 -- 4 Bosses
	wakaba.state.unlock.cloverchest = 2 -- Mega Satan
	wakaba.state.unlock.eatheart = 2 -- Delirium
	wakaba.state.unlock.bitcoin = 2 -- Mother
	wakaba.state.unlock.nemesis = 2 -- The Beast
	wakaba.state.unlock.wakabasoul = true
	wakaba.state.unlock.bookofforgotten = true

	print("Cheating Tainted Wakaba unlocks complete.")
	Isaac.DebugString("[wakaba]Cheating Tainted Wakaba unlocks complete.")
	wakaba:save(true)
end

function wakaba:unlockShiori(bool)
	bool = bool or true
	wakaba.state.unlock.hardbook = 2 -- Mom's Heart Hard
	wakaba.state.unlock.shiorid6plus = 2 -- Isaac
	wakaba.state.unlock.bookoffocus = 2 --Satan
	wakaba.state.unlock.deckofrunes = 2 -- ???
	wakaba.state.unlock.grimreaperdefender = 2 -- The Lamb
	wakaba.state.unlock.unknownbookmark = 2 -- Boss Rush
	wakaba.state.unlock.bookoffallen = 2 -- 
	wakaba.state.unlock.bookofgatling = 2 -- Hush
	wakaba.state.unlock.magnetheaven = 2 -- Ultra Greed
	wakaba.state.unlock.determinationribbon = 2 -- Ultra Greedier
	wakaba.state.unlock.bookofsilence = 2 -- Delirium
	wakaba.state.unlock.bookoftheking = 2 -- Mother
	wakaba.state.unlock.bookofthegod = 2 --The Beast
	wakaba.state.unlock.bookofshiori = true

	print("Cheating Shiori unlocks complete.")
	Isaac.DebugString("[wakaba]Cheating Shiori unlocks complete.")
	wakaba:save(true)
end

function wakaba:unlockTaintedShiori(bool)
	bool = bool or true
	wakaba.state.unlock.taintedshiorimomsheart = 2
	wakaba.state.unlock.queenofspades = 2 -- Ultra Greedier
	wakaba.state.unlock.shiorisoul1 = 2 -- Boss Rush
	wakaba.state.unlock.shiorisoul2 = 2 -- Hush
	wakaba.state.unlock.bookmarkbag1 = 2 -- 4 Bosses
	wakaba.state.unlock.bookmarkbag2 = 2 -- 4 Bosses
	wakaba.state.unlock.bookmarkbag3 = 2 -- 4 Bosses
	wakaba.state.unlock.bookmarkbag4 = 2 -- 4 Bosses
	wakaba.state.unlock.librarycard = 2 -- Mega Satan
	wakaba.state.unlock.bookofconquest = 2 -- Delirium
	wakaba.state.unlock.ringofjupiter = 2 -- Mother
	wakaba.state.unlock.minervaaura = 2 -- The Beast
	wakaba.state.unlock.shiorisoul = true
	wakaba.state.unlock.bookmarkbag = true

	print("Cheating Tainted Shiori unlocks complete.")
	Isaac.DebugString("[wakaba]Cheating Tainted Shiori unlocks complete.")
	wakaba:save(true)
end

function wakaba:unlockTsukasa(bool)
	bool = bool or true
	wakaba.state.unlock.murasame = 2 -- Mom's Heart Hard
	wakaba.state.unlock.nasalover = 2 -- Isaac
	wakaba.state.unlock.beetlejuice = 2 --Satan
	wakaba.state.unlock.totalcorruption = 2 -- ???
	wakaba.state.unlock.powerbomb = 2 -- The Lamb
	wakaba.state.unlock.concentration = 2 -- Boss Rush
	wakaba.state.unlock.beam = 2 -- 
	wakaba.state.unlock.rangesystem = 2 -- Hush
	wakaba.state.unlock.arcanecrystal = 2 -- Ultra Greed
	wakaba.state.unlock.questionblock = 2 -- Ultra Greedier
	wakaba.state.unlock.newyearbomb = 2 -- Delirium
	wakaba.state.unlock.phantomcloak = 2 -- Mother
	wakaba.state.unlock.hydra = 2 --The Beast
	wakaba.state.unlock.lunarstone = true

	print("Cheating Tsukasa unlocks complete.")
	Isaac.DebugString("[wakaba]Cheating Tsukasa unlocks complete.")
	wakaba:save(true)
end

function wakaba:unlockChallenge(bool)
	bool = bool or true
	wakaba.state.unlock.eyeofclock = true --01w Eye of Clock
	wakaba.state.unlock.plumy = true --02w Plumy
	wakaba.state.unlock.ultrablackhole = true --03w
	wakaba.state.unlock.delimiter = true --04w Delimiter
	wakaba.state.unlock.nekodoll = true --05w Neko Figure
	wakaba.state.unlock.microdoppelganger = true --06w Micro Doppelganger
	wakaba.state.unlock.delirium = true -- 07w Dimension CUtter
	wakaba.state.unlock.lilwakaba = true --08w Lil Wakaba
	wakaba.state.unlock.lostuniform = true --09w T.Lost Starts with Wakaba's Uniform
	wakaba.state.unlock.executioner = true--10w Executioner
	wakaba.state.unlock.apollyoncrisis = true--11w Apollyon Crisis
	wakaba.state.unlock.deliverysystem = true--12w Isekai Definition
	wakaba.state.unlock.calculation = true--13w Calculation
	wakaba.state.unlock.lilmao = true--13w Calculation
	wakaba.state.unlock.edensticky = true--98w T.Eden Starts with Sticky Note
	wakaba.state.unlock.doubledreams = true -- 99w Wakaba's Double Dreams

	print("Cheating Challenge unlocks complete.")
	Isaac.DebugString("[wakaba]Cheating Challenge unlocks complete.")
	wakaba:save(true)
end

--storedplayers = 0,
--playersavedata = {},


wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.init)

include('scripts.characters.not_wakaba')


function wakaba:OnGameExit(shouldSave)
	if Game():GetLevel():GetCurrentRoomIndex() == GridRooms.ROOM_DEBUG_IDX then
		Game():StartRoomTransition(Game():GetLevel():GetStartingRoomIndex(),Direction.NO_DIRECTION,RoomTransitionAnim.FADE,nil,-1)
		--Game():GetLevel():ChangeRoom(Game():GetLevel():GetStartingRoomIndex(), -1)
	end
	
	for num = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(num - 1)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.pendingmantlestack = true
		--print("Game Continue")
		--print(player:GetData().wakaba.pendingmantlestack)
		--player:GetData().wakaba.istransition = true
	end
	wakaba:save(shouldSave)
end

wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.OnGameExit)

print("Pudding and Wakaba", wakaba.version, "load complete.")
--wakaba:luamodInit()















--Isaac.GetPlayer():GetTearHitParams(WeaponType.WEAPON_BONE, 2, 1, Isaac.GetPlayer())