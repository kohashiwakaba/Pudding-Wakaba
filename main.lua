
-- Pudding and Wakaba is Repentance only.
if not REPENTANCE then
	print("Pudding and Wakaba is Repentance only. If this message pops up even in Repentance, check other mods that modify repentance variable.")
	Isaac.DebugString("Pudding and Wakaba is Repentance only. If this message pops up even in Repentance, check other mods that modify repentance variable.")
	return
end
_wakaba = RegisterMod("Pudding and Wakaba", 1)
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




local isc = require("wakaba_src.libs.isaacscript-common")
local iFeatures = {
	isc.ISCFeature.SAVE_DATA_MANAGER,
	--isc.ISCFeature.PICKUP_INDEX_CREATION,
	--isc.ISCFeature.PLAYER_INVENTORY,
	isc.ISCFeature.CHARACTER_HEALTH_CONVERSION,
	isc.ISCFeature.TAINTED_LAZARUS_PLAYERS,
	isc.ISCFeature.NO_SIREN_STEAL,
	isc.ISCFeature.MODDED_ELEMENT_SETS,
}
if REPENTOGON then
	iFeatures = {
		isc.ISCFeature.SAVE_DATA_MANAGER,
		isc.ISCFeature.TAINTED_LAZARUS_PLAYERS,
		isc.ISCFeature.NO_SIREN_STEAL,
		isc.ISCFeature.MODDED_ELEMENT_SETS,
	}
end
wakaba = isc:upgradeMod(_wakaba, iFeatures) ---@class Mod

include('wakaba_flags')
include('wakaba_src.debug_area')

--include("wakaba_src.libs.filepathhelper")
include('wakaba_src.libs.screenhelper')
include("wakaba_src.enums.constants")
include("wakaba_src.libs.retribution_utils")
include('wakaba_src.libs.achievement_display_api') -- TODO move to non-repengoton area if finished
if not REPENTOGON then
	include("wakaba_src.libs.pause_screen_completion_marks_api")
	--require("wakaba_src.libs.item_display_library")
	PauseScreenCompletionMarksAPI:SetShader("wakaba_ChallengeDest_DummyShader")
end

---@type Game
wakaba.G = Game() -- Cache game object
---@type Font
wakaba.f = Font() -- init font object
wakaba.f:Load("font/pftempestasevencondensed.fnt") -- load a font into the font object
---@type Font
wakaba.cf = Font() -- init font object
wakaba.cf:Load("font/luaminioutlined.fnt") -- load a font into the font object
---@type Sprite
wakaba.pickupdisplaySptite = Sprite()
wakaba.pickupdisplaySptite:Load("gfx/ui/wakaba/hudpickups.anm2", true)
---@type Sprite
wakaba.MiniMapAPISprite = Sprite()
wakaba.MiniMapAPISprite:Load("gfx/ui/wakaba/minimapapi.anm2", true)
---@type Sprite
wakaba.globalHUDSprite = Sprite()
wakaba.globalHUDSprite:Load("gfx/ui/wakaba/hudstats2.anm2", true)

-- Hidden Item Manager
wakaba.HiddenItemManager = include("wakaba_src.libs.hidden_item_manager"):Init(wakaba)

-- costume protector WIP
local costumeProtector = include("wakaba_src.libs.characterCostumeProtector")
costumeProtector:Init(wakaba)

--__wakaba = true
--wakabaMCM = nil
local json = require("json")

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

local function GetCurrentModPath()
	--use some very hacky trickery to get the path to this mod
	local _, err = pcall(require, "")
	local _, basePathStart = string.find(err, "no file '", 1)
	local _, modPathStart = string.find(err, "no file '", basePathStart)
	local modPathEnd, _ = string.find(err, ".lua'", modPathStart)
	local modPath = string.sub(err, modPathStart+1, modPathEnd-1)
	modPath = string.gsub(modPath, "\\", "/")
	modPath = string.gsub(modPath, "//", "/")
	modPath = string.gsub(modPath, ":/", ":\\")

	return modPath
end

-- Current version from Pudding & Wakaba mod
wakaba.version = "v111a Richer 2024.03.09"
wakaba.intversion = 11101

wakaba.modpath = GetCurrentModPath()

wakaba.rerollcooltime = 0
wakaba.hasdreams = false

wakaba.costumecooldown = 600
wakaba.costumecurrframe = 0

wakaba.fullreroll = false
wakaba.pedestalreroll = false

wakaba.unlockdisplaytimer = -(30*30)

wakaba.playerstats = {}

wakaba.roomoverride = {
	devilroom = -4100,
	angelroom = -4101,
}

wakaba.sprites = {}
wakaba.RGB = {
	R = 255,
	G = 0,
	B = 0,
}

-- EID extended description. for eidappend.lua
wakaba.descriptions = wakaba.descriptions or {}
wakaba.encyclopediadesc = wakaba.encyclopediadesc or {}
wakaba.eidunlockstr = ""


wakaba.eidextradesc = {}
wakaba.eidextradesc.bettervoiding = {}

include("wakaba_src.wakaba_deadseascrolls.wakabadss")
--include("wakaba_src.wakaba_deadseascrolls.dss_characters")
include("wakaba_src.wakaba_deadseascrolls.dss_credits")
include("wakaba_src.wakaba_deadseascrolls.changelogs")


local richer_saved_recipies = {
	-- persistent : used by wakaba.state
	persistent = {
		intversion = 0,

		achievementPopupShown = false,
		isbossopened = false,
		saved = false,
		rerollloopcount = 0,
		--- DonationCard
		silverchance = 65,
		vipchance = 65,
		--- Setting Below, Run Period Upper
		forcevoid = {
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
		},
		--wakabaoptions = wakaba.wakabaoptiondefaults,
		pog = true,
		--- Unlock State
		unlock = {
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
			bookoftrauma = 0, -- Hush
			magnetheaven = 0, -- Ultra Greed
			determinationribbon = 0, -- Ultra Greedier
			bookofsilence = 0, -- Delirium
			vintagethreat = 0, -- Mother
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
			shiorivalut = 0, -- Mega Satan
			bookofconquest = 0, -- Delirium
			ringofjupiter = 0, -- Mother
			minervaaura = 0, -- The Beast

			shiorisoul = false,
			bookmarkbag = false,

			-- Tsukasa Unlocks
			murasame = 0, -- Mom's Heart Hard
			nasalover = 0, -- Isaac
			beetlejuice = 0, -- Satan
			redcorruption = 0, -- ???
			powerbomb = 0, -- The Lamb
			concentration = 0, -- Boss Rush
			rangeos = 0, -- Hush
			newyearbomb = 0, -- Delirium
			plasmabeam = 0, -- Mega Satan
			arcanecrystal = 0, -- Ultra Greed
			questionblock = 0, -- Ultra Greedier
			phantomcloak = 0, -- Mother
			magmablade = 0, -- The Beast

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
			easteregg = 0, -- Mega Satan
			returntoken = 0, -- Ultra Greedier
			sirenbadge = 0, -- Mother
			elixiroflife = 0, -- The Beast

			isaaccartridge = false,
			tsukasasoul = false,

			-- Richer Unlocks
			fireflylighter = 0,
			sweetscatalog = 0,
			antibalance = 0,
			doubleinvader = 0,
			venomincantation = 0,
			printer = 0,
			bunnyparfait = 0,
			richeruniform = 0,
			prestigepass = 0,
			clensingfoam = 0,
			lilricher = 0,
			cunningpaper = 0,
			selfburning = 0,

			rabbitribbon = false,
			taintedricher = false, -- Tainted Richer

			-- Tainted Richer Unlocks
			taintedrichermomsheart = 0,
			starreversal1 = 0, -- Isaac
			starreversal2 = 0, -- Satan
			starreversal3 = 0, -- ???
			starreversal4 = 0, -- The Lamb
			richersoul1 = 0, -- Boss Rush
			richersoul2 = 0, -- Hush
			waterflame = 0, -- Delirium
			crystalrestock = 0, -- Mega Satan
			trialstew = 0, -- Ultra Greedier
			eternitycookie = 0, -- Mother
			winteralbireo = 0, -- The Beast

			starreversal = false,
			richersoul = false,

			--Rira Unlocks
			blackbeanmochi 			= 0,
			nerfgun 						= 0,
			sakuramontblanc 		= 0,
			riraswimsuit 				= 0,
			chewyrollycake 			= 0,
			caramellapancake 		= 0,
			rirauniform 				= 0,
			rirabandage 				= 0,
			rirabento 					= 0,
			sakuracapsule 			= 0,
			maidduet 						= 0,
			rabbitpillow 				= 0,
			lilrira 						= 0,

			chimaki = false,
			taintedrira = false, -- Tainted Rira


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
			richerflipper = false,--15w Even or Odd
			richernecklace = false,--16w Runaway Pheromones
			crossbomb = false,--17w The floor is LAVA
			goombella = false,--18w Universe of Goom

			edensticky = false,--98w T.Eden Starts with Sticky Note
			doubledreams = false, -- 99w Wakaba's Double Dreams
		},

		storedplayers = 0,
		playersavedata = {},
		dss_menu = {},
		pendingunlock = {},

	},
	run = {
		lockedcharacter = false,
		savedtimecounter = 0,
		hasbless = false,
		hasnemesis = false,
		eatheartused = false,
		spent = false,
		nemesis = {},
		currentalpha = 0,
		angelchance = 0,
		dreampool = ItemPoolType.POOL_NULL,
		dreamroom = RoomType.ROOM_TREASURE,
		revengecount = 7,
		randtainted = false,
		-- Murasame Boss encounters
		murasamebosses = {},

		HIDDEN_ITEM_DATA = {},

		-- Shiori modes
		currentshiorimode = wakaba.shiorimodes.SHIORI_AKASIC_RECORDS,
		shioridropped = {},
		cachedmaijimabooks = {},
		persistentPickupData = {},

		storedplayers = 0,
		playersavedata = {

		},

		rerollquality = {},
		pendingCurseImmunityCount = 0,
	},
	level = {
		wakabaangelshops = {},
		wakabadevilshops = {},

	},
	room = {
		allowactives = true,

	},
}
richer_saved_recipies.persistent.options = include("wakaba_config") ---@type WakabaOptions

wakaba:saveDataManager("Pudding and Wakaba", richer_saved_recipies)

wakaba.state = richer_saved_recipies.persistent
wakaba.runstate = richer_saved_recipies.run
wakaba.levelstate = richer_saved_recipies.level
wakaba.roomstate = richer_saved_recipies.room

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
}

wakaba.optiondefaults = include("wakaba_config") ---@type WakabaOptions


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
	bookoftrauma = 0, -- Hush
	magnetheaven = 0, -- Ultra Greed
	determinationribbon = 0, -- Ultra Greedier
	bookofsilence = 0, -- Delirium
	vintagethreat = 0, -- Mother
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
	shiorivalut = 0, -- Mega Satan
	bookofconquest = 0, -- Delirium
	ringofjupiter = 0, -- Mother
	minervaaura = 0, -- The Beast

	shiorisoul = false,
	bookmarkbag = false,

	-- Tsukasa Unlocks
	murasame = 0, -- Mom's Heart Hard
	nasalover = 0, -- Isaac
	beetlejuice = 0, -- Satan
	redcorruption = 0, -- ???
	powerbomb = 0, -- The Lamb
	concentration = 0, -- Boss Rush
	rangeos = 0, -- Hush
	newyearbomb = 0, -- Delirium
	plasmabeam = 0, -- Mega Satan
	arcanecrystal = 0, -- Ultra Greed
	questionblock = 0, -- Ultra Greedier
	phantomcloak = 0, -- Mother
	magmablade = 0, -- The Beast

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
	returntoken = 0, -- Ultra Greedier
	sirenbadge = 0, -- Mother
	elixiroflife = 0, -- The Beast

	isaaccartridge = false,
	tsukasasoul = false,

	-- Richer Unlocks
	fireflylighter = 0,
	sweetscatalog = 0,
	antibalance = 0,
	doubleinvader = 0,
	venomincantation = 0,
	printer = 0,
	bunnyparfait = 0,
	richeruniform = 0,
	prestigepass = 0,
	clensingfoam = 0,
	lilricher = 0,
	cunningpaper = 0,
	selfburning = 0,

	rabbitribbon = false,
	taintedricher = false, -- Tainted Richer

	-- Tainted Richer Unlocks
	taintedrichermomsheart = 0,
	starreversal1 = 0, -- Isaac
	starreversal2 = 0, -- Satan
	starreversal3 = 0, -- ???
	starreversal4 = 0, -- The Lamb
	richersoul1 = 0, -- Boss Rush
	richersoul2 = 0, -- Hush
	waterflame = 0, -- Delirium
	crystalrestock = 0, -- Mega Satan
	trialstew = 0, -- Ultra Greedier
	eternitycookie = 0, -- Mother
	winteralbireo = 0, -- The Beast

	starreversal = false,
	richersoul = false,

	--Rira Unlocks
	blackbeanmochi = 0,
	nerfgun = 0,
	sakuramontblanc = 0,
	riraswimsuit = 0,
	chewyrollycake = 0,
	caramellapancake = 0,
	rirauniform = 0,
	rirabandage = 0,
	rirabento = 0,
	sakuracapsule = 0,
	maidduet = 0,
	rabbitpillow = 0,
	lilrira = 0,

	chimaki = false,
	taintedrira = false, -- Tainted Rira

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
	richerflipper = false,--15w Even or Odd
	richernecklace = false,--16w Runaway Pheromones
	crossbomb = false,--17w The floor is LAVA
	goombella = false,--18w Universe of Goom

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

		anotherfortunerolled = {},
		anotherfortunepedestals = {},
		-- Shiori modes
		currentshiorimode = wakaba.shiorimodes.SHIORI_AKASIC_RECORDS,

		-- Murasame Boss encounters
		murasamebosses = {},

		HIDDEN_ITEM_DATA = {},

	}
end
--Settings Here. Modify this area to change settings

--start from new wakaba.G
if not wakaba.defaultstate then
	wakaba.defaultstate = wakaba:deepcopy(wakaba.state)
end

--resetSettings (planned)
wakaba.defaultsettings = {

}

--Global Functions and variables

local HUD = wakaba.G:GetHUD()
wakaba.RNG = RNG()
wakaba.ItemRNG = RNG()
wakaba.PickupRNG = RNG()
wakaba.ItemConfig = Isaac.GetItemConfig()

--[[
	Taken from Community Remix, This is needed to prevent infinite freeze from getting familiar priority.
	Callback created from base modRef(_wakaba) instead of UpgradedModRef(wakaba) just in case
]]
if REPENTOGON then
	_wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, function(_, f)
		if not f.Parent then
			if f.Player then
				f.Parent = f.Player
			end
		end
	end)
end

function wakaba:has_value (tab, val)
	if tab == nil then return false end
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

function wakaba:GetScreenSize()
		local room = wakaba.G:GetRoom()
		local pos = room:WorldToScreenPosition(Vector(0,0)) - room:GetRenderScrollOffset() - wakaba.G.ScreenShakeOffset

		local rx = pos.X + 60 * 26 / 40
		local ry = pos.Y + 140 * (26 / 40)

		return Vector(rx*2 + 13*26, ry*2 + 7*26)
end
function wakaba:GetScreenCenter()
		return wakaba:GetScreenSize()/2
end
function wakaba:GetGridCenter() --returns Vector
	local room = wakaba.G:GetRoom()

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

function wakaba:getTearsStat(firedelay)
	return 30 / (firedelay + 1)
end

function wakaba:getFireDelay(tearsStat)
	return math.max((30 / tearsStat) - 1, -0.75)
end

function wakaba:GetMaxCollectibleID()
	return Isaac.GetItemConfig():GetCollectibles().Size -1
end

function wakaba:WhitelistTag(tag)
	local items = wakaba.G:GetItemPool()
	local itemID = 0
	local maxID = wakaba:GetMaxCollectibleID()
	local lastItem = Isaac.GetItemConfig():GetCollectible(itemID)
	repeat
		itemID = itemID + 1
		lastItem = Isaac.GetItemConfig():GetCollectible(itemID)
		if lastItem ~= nil and not lastItem:HasTags(tag) then
			--Isaac.ConsoleOutput("Removed : "..itemID.."/"..maxID.. "\n")
			wakaba.G:GetItemPool():RemoveCollectible(itemID)
		end
	until itemID > maxID
end

function wakaba:BlacklistTag(tag)
	local items = wakaba.G:GetItemPool()
	local itemID = 0
	local maxID = wakaba:GetMaxCollectibleID()
	local lastItem = Isaac.GetItemConfig():GetCollectible(itemID)
	repeat
		itemID = itemID + 1
		lastItem = Isaac.GetItemConfig():GetCollectible(itemID)
		if lastItem ~= nil and lastItem:HasTags(tag) then
			--Isaac.ConsoleOutput("Removed : "..itemID.."/"..maxID.. "\n")
			wakaba.G:GetItemPool():RemoveCollectible(itemID)
		end
	until itemID > maxID
end


function wakaba:PostWakabaRender()
	--check for costume update
	if wakaba.costumecurrframe > 0 then
		wakaba.costumecurrframe = wakaba.costumecurrframe - 1
	end
	wakaba:Render_RGB()
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.PostWakabaRender)

--reset currframe when use an active item
function wakaba.ItemUseCostumeReset()
	wakaba.costumecurrframe = 0
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUseCostumeReset)

--[[
	Get Offset by Peachee
	@param {int} notches - the number of notches filled in on hud offset (default inwakaba.G is between 0-10)
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
	local game = wakaba.G
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	local CurStage = level:GetAbsoluteStage()
	local CurRoom = level:GetCurrentRoomIndex()
	if room:IsFirstVisit() and isc:inStartingRoom() then
		if #wakaba.state.pendingunlock > 0 then
			activePendingPapers = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.activePapers)

if not REPENTOGON then
	function wakaba:PostUpdate_Global()
		--wakaba.runstate.HIDDEN_ITEM_DATA = wakaba.HiddenItemManager:GetSaveData()
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
	wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostUpdate_Global)
end

--Scripts
--APIs, Wakaba's Blessing, Nemesis must be loaded first due to item usages
--스크립트 로딩
--API, 축복, 시련 아이템은 가장 먼저 로딩

include('wakaba_src.damocles_api')

include('wakaba_src.enums.players')
include('wakaba_src.enums.costumes')
include('wakaba_src.enums.wakabachargebar')
include('wakaba_src.datas.tearflags_wakaba')

local renderActive = include("wakaba_src.functions.render_active_base")

wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, renderActive.OnRender)
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, renderActive.OnUpdate)
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, renderActive.ResetOnGameStart)

wakaba:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, function(_, shaderName)
	if shaderName == "wakaba_ChallengeDest_DummyShader" and wakaba.G:GetHUD():IsVisible() then
		renderActive:OnGetShaderParams()
	end
end)

function wakaba:addActiveRender(tab)
	return renderActive:Add(tab)
end

function wakaba:getAllMainPlayers()
	return renderActive:GetAllMainPlayers()
end

function wakaba:getIndexedPlayers()
	return renderActive:GetIndexedPlayers()
end

function wakaba:getIndexedPlayer(i)
	return renderActive:GetIndexedPlayer(i)
end

include('wakaba_src.functions.callbacks_wakaba')
include('wakaba_src.libs.retribution_status')
include('wakaba_src.libs.revel_utils')
include('wakaba_src.functions.hudstats')
include('wakaba_src.functions.hit_counter')
include('wakaba_src.functions.room_name_display')
include('wakaba_src.functions.isc_roomgen')
include('wakaba_src.functions.spawner')
include('wakaba_src.functions.custom_item_sound')
include('wakaba_src.functions.custom_hurt_sound')
include('wakaba_src.functions.custom_pedestals')

include('wakaba_src.items.0000_blessing')
include('wakaba_src.items.0001_bookofshiori')
include('wakaba_src.items.0003_bookofconquest')
include('wakaba_src.items.0004_minerva')
include('wakaba_src.items.0005_winteralbireo')
include('wakaba_src.items.0006_lunarstone')
include('wakaba_src.items.0007_elixiroflife')
include('wakaba_src.items.0008_flashshift')
include('wakaba_src.items.0009_concentration')
include('wakaba_src.items.0010_rabbitribbon')
include('wakaba_src.items.0011_sweetscatalog')
--include('wakaba_src.items.0011_sweetscatalog_ancient')
--include('wakaba_src.items.0011_sweetscatalog_premium')
include('wakaba_src.items.0012_waterflame')
include('wakaba_src.items.0013_chimaki')
include('wakaba_src.items.0014_riraswimsuit')
include('wakaba_src.items.1084_nerfgun')
include('wakaba_src.items.0015_brokentoolbox')
--include('wakaba_src.items.0016_rabbeyward')
include('wakaba_src.items.1001_eatheart')

include('wakaba_src.items.1002_bookofforgotten')
include('wakaba_src.items.1003_dcupicecream')
include('wakaba_src.items.1003b_mintchocoicecream')
include('wakaba_src.items.1004_gamecd')
include('wakaba_src.items.1005_wakabapendant')
include('wakaba_src.items.1006_secretcard')
include('wakaba_src.items.1007_plumy')
include('wakaba_src.items.1008_executioner')
include('wakaba_src.items.1009_newyearbomb')
--include('wakaba_src.items.1010_newyearbomb')
include('wakaba_src.items.1011_revengefruit')
include('wakaba_src.items.1012_uniform')
include('wakaba_src.items.1015_eyeofclock')
include('wakaba_src.items.1016_lilwakaba')
include('wakaba_src.items.1017_counter')
include('wakaba_src.items.1018_returnpostage')
include('wakaba_src.items.1019_d6plus')
include('wakaba_src.items.1020_lilmoe')
include('wakaba_src.items.1023_bookoffocus')
include('wakaba_src.items.1024_deckofrunes')
include('wakaba_src.items.1025_microdoppelganger')
include('wakaba_src.items.1026_bookofsilence')
include('wakaba_src.items.1027_vintagethreat')
include('wakaba_src.items.1028_bookofthegod')
include('wakaba_src.items.1029_grimreaperdefender')
include('wakaba_src.items.1030_bookoftrauma')
include('wakaba_src.items.1031_bookofthefallen')
include('wakaba_src.items.1032_maijimamythology')
include('wakaba_src.items.1033_apollyoncrisis')
include('wakaba_src.items.1034_lilshiva')
include('wakaba_src.items.1035_nekofigure')
include('wakaba_src.items.1036_dejavu')
include('wakaba_src.items.1038_lilmao')
include('wakaba_src.items.1039_isekaidefinition')
include('wakaba_src.items.1040_balance')
include('wakaba_src.items.1041_moemuffin')
include('wakaba_src.items.1044_clovershard')


include('wakaba_src.items.1042_murasame')
include('wakaba_src.items.1043_caramellapancake')
include('wakaba_src.items.1045_nasalover')
include('wakaba_src.items.1046_crystals')
include('wakaba_src.items.1047_3dprinter')
include('wakaba_src.items.1048_powerbomb')
include('wakaba_src.items.1049_syrup')
include('wakaba_src.items.1050_phantomcloak')
include('wakaba_src.items.1051_questionblock')
include('wakaba_src.items.1052_clensingfoam')
include('wakaba_src.items.1053_beetlejuice')
include('wakaba_src.items.1054_curseofthetower2')
--include('wakaba_src.items.1055_magmablade')
include('wakaba_src.items.1056_venomincantation')
include('wakaba_src.items.1057_fireflylighter')
include('wakaba_src.items.1058_doubleinvader')
include('wakaba_src.items.1059_redcorruption')
include('wakaba_src.items.1060_plasmabeam')
include('wakaba_src.items.1061_antibalance')
include('wakaba_src.items.1062_lakeofbishop')
include('wakaba_src.items.1063_prestigepass')
include('wakaba_src.items.1064_crisisboost')
include('wakaba_src.items.1065_easteregg')
include('wakaba_src.items.1066_richeruniform')
include('wakaba_src.items.1067_magmablade')
include('wakaba_src.items.1068_onsentowel')
include('wakaba_src.items.1068b_succubusblanket')
include('wakaba_src.items.1069_cunningpaper')
include('wakaba_src.items.1070_lilricher')
include('wakaba_src.items.1071_richerflipper')
include('wakaba_src.items.1075_powblock')
include('wakaba_src.items.1076_selfburning')

include('wakaba_src.items.1077_rirabra')
include('wakaba_src.items.1078_secretdoor')
include('wakaba_src.items.1079_bunnyparfait')
include('wakaba_src.items.1081_lilrira')
include('wakaba_src.items.1082_blackbeanmochi')
include('wakaba_src.items.1083_sakuramontblanc')
include('wakaba_src.items.1085_rirabento')
include('wakaba_src.items.1086_richernecklace')
include('wakaba_src.items.1087_riracoat')
include('wakaba_src.items.1088_rirabandage')
include('wakaba_src.items.1089_kanaelens')
include('wakaba_src.items.1091_sakuracapsule')
include('wakaba_src.items.1092_chewyrollycake')
include('wakaba_src.items.1093_maidduet')
include('wakaba_src.items.1095_rirauniform')
include('wakaba_src.items.1100_richerbra')

include('wakaba_src.pickups.2005_dreamcard')
include('wakaba_src.items.1200_doubledreams')
include('wakaba_src.items.1201_edenstickynote')

--include('wakaba_src.pickups.2001_donationcard')
include('wakaba_src.pickups.2002_cranecard')
include('wakaba_src.pickups.2003_confessionalcard')
include('wakaba_src.pickups.2004_jokers')
include('wakaba_src.pickups.2006_unknownbookmark')
include('wakaba_src.pickups.2007_queenofspades')
include('wakaba_src.pickups.2008_returntoken')
include('wakaba_src.pickups.2009_minervaticket')
include('wakaba_src.pickups.2010_valutcard')
include('wakaba_src.pickups.2011_trialstew')
include('wakaba_src.pickups.2012_richerticket')
include('wakaba_src.pickups.2013_riraticket')
include('wakaba_src.pickups.2100_pills')
include('wakaba_src.pickups.2501_wakabasoul')
include('wakaba_src.pickups.2502_shiorisoul')
include('wakaba_src.pickups.2503_tsukasasoul')
include('wakaba_src.pickups.2504_richersoul')

include('wakaba_src.items.3000_notepathfinder')
include('wakaba_src.items.3001_bitcoin')
include('wakaba_src.items.3002_clover')
include('wakaba_src.items.3003_magnetheaven')
include('wakaba_src.items.3004_hardbook')
include('wakaba_src.items.3005_determinationribbon')
include('wakaba_src.items.3006_bookmarkbag')
include('wakaba_src.items.3007_ringofjupiter')
include('wakaba_src.items.3008_dimensioncutter')
include('wakaba_src.items.3009_delimiter')
include('wakaba_src.items.3010_rangeos')
include('wakaba_src.items.3011_sirenbadge')
include('wakaba_src.items.3012_isaaccartridge')
include('wakaba_src.items.3013_starreversal')
include('wakaba_src.items.3014_auroragem')
include('wakaba_src.items.3015_mistake')
include('wakaba_src.items.3016_kuromicard')
include('wakaba_src.items.3017_eternitycookie')
include('wakaba_src.items.3018_richerreportcard')

-- Tarnished unlock trinkets
include('wakaba_src.items.3203_sigilofkaguya')

include('wakaba_src.pickups.4000_cloverchest')

include('wakaba_src.entities.anotherfortune')
include('wakaba_src.entities.crystalrestock')

include('wakaba_src.characters.locked')
include('wakaba_src.characters.wakaba')
include('wakaba_src.characters.wakaba_b')
--include('wakaba_src.characters.wakaba_t')
include('wakaba_src.characters.shiori')
include('wakaba_src.characters.shiori_b')
include('wakaba_src.characters.tsukasa')
include('wakaba_src.characters.tsukasa_b')
include('wakaba_src.characters.richer')
include('wakaba_src.characters.richer_b')
include('wakaba_src.characters.rira')
include('wakaba_src.common')

include('wakaba_src.items.0002_bookofshiori_func')

include('wakaba_src.functions.charge_richer')
include('wakaba_src.functions.unlock_old')
include('wakaba_src.functions.aqua_trinkets')
include('wakaba_src.functions.unlock')
--include('wakaba_src.functions.charge')
include('wakaba_src.functions.revival')
include('wakaba_src.functions.revival2')
include('wakaba_src.functions.hidden_items')
include('wakaba_src.functions.fireclub')
include('wakaba_src.functions.take_damage_npc')
include('wakaba_src.functions.important_stats')

--include('challenges')
include('wakaba_src.challenges.core')
include('wakaba_src.curses')

include('wakaba_src.descriptions.en_us')
include('wakaba_src.descriptions.ko_kr')
include('wakaba_src.descriptions.zh_cn')
include('wakaba_src.eidappend')
include('wakaba_src.uniqueitems')

include('wakaba_src.rgb')
include('wakaba_src.devilangel')
include('wakaba_src.encyclopedia')
include('wakaba_src.rerollcheck')
include('wakaba_src.rerollcheck_pool')
include('wakaba_src.functions.item_pool_wakaba')
include('wakaba_src.wardrobeplus')
include('wakaba_src.stackablemantle')
include('wakaba_src.deadwispnotif')
include('wakaba_src.inventorydesc')
include('wakaba_src.minimapi')
include('wakaba_src.challenges_dest')
include('wakaba_src.wisps')
include('wakaba_src.config')
include('wakaba_src.console_commands')

include('wakaba_src.compat.fiendfolio')
include('wakaba_src.compat.retribution')
include('wakaba_src.compat.epiphany')
include('wakaba_src.compat.samael')
include('wakaba_src.compat.taintedtreasure')
include('wakaba_src.compat.thefuture')
include('wakaba_src.compat.stageapi')

if REPENTOGON then
	include('wakaba_src.compat.repentogon.core')
	include('wakaba_src.compat.repentogon.item_names')
	include('wakaba_src.compat.repentogon.item_additions')
	include('wakaba_src.compat.repentogon.achievements')
	--include('wakaba_src.compat.repentogon.imgui')
end

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
	wakaba.RNG:SetSeed(wakaba.G:GetSeeds():GetStartSeed(), 35)
	--Isaac.DebugString(wakaba.state)
	if wakaba:HasData() then
		--Isaac.DebugString(wakaba:LoadData())
		--wakaba.state = json.decode(wakaba:LoadData())
		--wakaba:reinitStates()
	end
	--wakaba.runstate.HIDDEN_ITEM_DATA = {}
	if (not continue) then
		-- Starting new run

		--wakaba.runstate.HIDDEN_ITEM_DATA = {}
		--wakaba.runstate.storedplayers = 0
		--wakaba.runstate.playersavedata = {}

		-- Removing locked items
		if wakaba.state.achievementPopupShown then
			wakaba:LockItems()
		end

		wakaba.runstate.currentshiorimode = wakaba.state.options.shiorimodes

		-- Caching Books for Maijima
		local tempMaijimaBooks = wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		local maijimaBooksToAdd = {}
		local maijimaRng = RNG()
		maijimaRng:SetSeed(wakaba.G:GetSeeds():GetStartSeed(), 35)
		for i = 0, 4 do
			local index = maijimaRng:RandomInt(#tempMaijimaBooks) + 1
			table.insert(maijimaBooksToAdd, tempMaijimaBooks[index])
			table.remove(tempMaijimaBooks, index)
		end
		wakaba.runstate.cachedmaijimabooks = maijimaBooksToAdd

		if not wakaba.state.achievementPopupShown then
			DeadSeaScrollsMenu.QueueMenuOpen("Pudding n wakaba", "unlockspopup", 1, true)
			wakaba.showPersistentUnlockText = true
		end

	else
		--wakaba.HiddenItemManager:LoadData(wakaba.runstate.HIDDEN_ITEM_DATA)
		wakaba.state.saved = true
		local tempplayerdatas = wakaba.runstate.playersavedata
		local reservedplayerdatas = {}

		for i = 1, wakaba.G:GetNumPlayers() do
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
		wakaba.runstate.playersavedata = reservedplayerdatas
		--wakaba:LoadHiddenItemData()
		wakaba:ResetWispStatus()
	end
	-- Run this whether continue or not
	if EID then
		wakaba:UpdateWakabaDescriptions()
		--wakaba:UpdateWakabaEncyclopediaDescriptions()
	end
	if FiendFolio then
		wakaba:GameStart_FiendFolioCompat()
	end

	if Retribution then
		wakaba:GameStart_RetributionCompat()
	end

	if SamaelMod then
		wakaba:GameStart_SamaelCompat()
	end

	if TaintedTreasure then
		wakaba:GameStart_TaintedTreasureCompat()
	end

	if TheFuture then
		wakaba:GameStart_TheFutureCompat()
	end

	wakaba:setFamiliarNoSirenSteal(wakaba.Enums.Familiars.LUNAR_DAMOCLES)
	wakaba:setFamiliarNoSirenSteal(wakaba.Enums.Familiars.MURASAME)
	wakaba:updateHUDPosition()
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
		local tempstate = json.decode(wakaba:LoadData())
		if tempstate ~= nil then
			-- Importing from old saves
			if wakaba.state.intversion >= 10000 then
				return
			end

			wakaba.state.intversion = 10000

			for k, v in pairs(wakaba.state) do
				if tempstate[k] == nil
				or type(tempstate[k]) ~= type(wakaba.state[k]) then
					--wakaba.Log("resetting state value :", k)
					wakaba.Log("[wakaba]resetting state value : ".. k)
					tempstate[k] = wakaba.state[k]
				end
			end

		if tempstate.unlock ~= nil then
			for k, v in pairs(wakaba.state.unlock) do
				if tempstate.unlock[k] == nil then
					tempstate.unlock[k] = wakaba.unlocks[k]
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
					--wakaba.Log("resetting options :", k)
					wakaba.Log("[wakaba]resetting options : ".. k)
					tempstate.options[k] = wakaba.state.options[k]
				end
			end
			wakaba.state.options = tempstate.options
		end

		wakaba.state.indexes = nil -- no longer used anymore
		end

	end
end

function wakaba:luamodInit()
	if wakaba:HasData() then
		wakaba:LoadData()
		--Isaac.DebugString(wakaba:LoadData())

		wakaba:reinitStates()
	end
end


function wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if data.wakaba == nil then
		data.wakaba = {
			hash = phash,
			sindex = wakaba.runstate.storedplayers,
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
				hairpinluck = 0,
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
			shioribuffs = {

			},
			shiorifloorbuffs = {

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
		wakaba.runstate.storedplayers = 0

		if wakaba.G:GetFrameCount() == 0 then
			--print("Game Started")
			wakaba.runstate.playersavedata = {}
		else
			--print("Continue")
		end
	end

	wakaba.runstate.storedplayers = wakaba.runstate.storedplayers + 1
	--print(wakaba.runstate.storedplayers, #wakaba.runstate.playersavedata)

	if wakaba.runstate.storedplayers - 1 == #wakaba.runstate.playersavedata then
		-- run player init code
		-- Persistent Player Data
		player:GetData().wakaba = {
			hash = phash,
			hashindex = phash,
			sindex = wakaba.runstate.storedplayers,
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
		wakaba.runstate.playersavedata[wakaba.runstate.storedplayers] = {
			hashindex = phash,
			index = wakaba.runstate.storedplayers,
		}
		--print("assign")
	end
	player:GetData().wakaba_lhash = phash
	wakaba.Log("Wakaba - Persistent Data registered.")

	if wakaba.G.TimeCounter == 0 then
		if wakaba.state.unlock.edensticky and wakaba.state.options.edensticky and wakaba.G.Challenge == Challenge.CHALLENGE_NULL and player:GetPlayerType() == 30 then
			player:SetPocketActiveItem(wakaba.Enums.Collectibles.EDEN_STICKY_NOTE, ActiveSlot.SLOT_POCKET, false)
		elseif wakaba.state.unlock.lostuniform and wakaba.state.options.lostuniform and wakaba.G.Challenge == Challenge.CHALLENGE_NULL and player:GetPlayerType() == 31 then
			player:AddCollectible(wakaba.Enums.Collectibles.UNIFORM, 0, false, ActiveSlot.SLOT_PRIMARY, 0)
		end
	end
	if wakaba.state.options.cp_wakaba then
		for playerType, entries in pairs(wakaba.cpManagedPlayerType) do
			costumeProtector:AddPlayer(
				player,
				playerType,
				"gfx/characters/costumes/character_"..entries.sheetName..".png",
				entries.flightID or 67, --A separate costume that is added for all cases that you ever gain flight.
				"gfx/characters/costumes/character_"..entries.flightSheetName..".png", --Your character's spritesheet, but customized to have your flight costume.
				entries.extraNullID or NullItemID.ID_JACOB --Your character's additional costume. Hair, ears, whatever.
			)
			costumeProtector:ItemCostumeWhitelist(playerType, wakaba.costumeCollectibleWhiteList)
			costumeProtector:NullItemIDWhitelist(playerType, wakaba.costumeNullWhiteList)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostGlobalPlayerInit)

local changeCostume = false
--[[
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
 ]]
local function CostumeUpdate_wakaba(player)
	changeCostume = true
	--print("reset costume")
end
--costumeProtector.AddCallback("MC_POST_COSTUME_RESET", CostumeUpdate_wakaba)


function wakaba:getcurrentindex(player)
	for num = 0, wakaba.G:GetNumPlayers()-1 do
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

function wakaba:save(shouldSave)
	if shouldSave then
		--wakaba.Log("Wakaba - Data Saving start")
		wakaba.runstate.saved = true
		wakaba.state.intversion = wakaba.intversion
		wakaba.runstate.savedtimecounter = wakaba.G:GetFrameCount()
		--wakaba.runstate.playersavedata = {}
		local reservedplayersavedata = {}

		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			--[[ local playerdata = player:GetData().wakaba
			local playerindex = player:GetData().wakaba_cindex
			if playerdata then
			end ]]
			local playerdata = player:GetData().wakaba
			local sti = player:GetData().wakaba.sindex
			if sti ~= nil then
				table.insert(reservedplayersavedata, playerdata)
				--wakaba.Log("- Saving player data : ".. json.encode(playerdata))
			end
		end
		wakaba.runstate.playersavedata = reservedplayersavedata
		--wakaba:SaveData(json.encode(wakaba.state))
		--wakaba.Log("Wakaba - Data Saving end")
		wakaba:SaveHiddenItemData()
		wakaba:saveDataManagerSave()
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
	wakaba.Log("[wakaba]Cheating Wakaba unlocks complete.")
	--wakaba:save(true)
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
	wakaba.Log("[wakaba]Cheating Tainted Wakaba unlocks complete.")
	--wakaba:save(true)
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
	wakaba.state.unlock.bookoftrauma = 2 -- Hush
	wakaba.state.unlock.magnetheaven = 2 -- Ultra Greed
	wakaba.state.unlock.determinationribbon = 2 -- Ultra Greedier
	wakaba.state.unlock.bookofsilence = 2 -- Delirium
	wakaba.state.unlock.vintagethreat = 2 -- Mother
	wakaba.state.unlock.bookofthegod = 2 --The Beast
	wakaba.state.unlock.bookofshiori = true

	print("Cheating Shiori unlocks complete.")
	wakaba.Log("[wakaba]Cheating Shiori unlocks complete.")
	--wakaba:save(true)
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
	wakaba.state.unlock.shiorivalut = 2 -- Mega Satan
	wakaba.state.unlock.bookofconquest = 2 -- Delirium
	wakaba.state.unlock.ringofjupiter = 2 -- Mother
	wakaba.state.unlock.minervaaura = 2 -- The Beast
	wakaba.state.unlock.shiorisoul = true
	wakaba.state.unlock.bookmarkbag = true

	print("Cheating Tainted Shiori unlocks complete.")
	wakaba.Log("[wakaba]Cheating Tainted Shiori unlocks complete.")
	--wakaba:save(true)
end

function wakaba:unlockTsukasa(bool)
	bool = bool or true
	wakaba.state.unlock.murasame = 2 -- Mom's Heart Hard
	wakaba.state.unlock.nasalover = 2 -- Isaac
	wakaba.state.unlock.beetlejuice = 2 --Satan
	wakaba.state.unlock.redcorruption = 2 -- ???
	wakaba.state.unlock.powerbomb = 2 -- The Lamb
	wakaba.state.unlock.concentration = 2 -- Boss Rush
	wakaba.state.unlock.plasmabeam = 2 --
	wakaba.state.unlock.rangeos = 2 -- Hush
	wakaba.state.unlock.arcanecrystal = 2 -- Ultra Greed
	wakaba.state.unlock.questionblock = 2 -- Ultra Greedier
	wakaba.state.unlock.newyearbomb = 2 -- Delirium
	wakaba.state.unlock.phantomcloak = 2 -- Mother
	wakaba.state.unlock.magmablade = 2 --The Beast
	wakaba.state.unlock.lunarstone = true

	wakaba.state.unlock.taintedtsukasa = true

	print("Cheating Tsukasa unlocks complete.")
	wakaba.Log("[wakaba]Cheating Tsukasa unlocks complete.")
	--wakaba:save(true)
end

function wakaba:unlockTaintedTsukasa(bool)
	bool = bool or true
	wakaba.state.unlock.taintedtsukasamomsheart = 2
	wakaba.state.unlock.returntoken = 2 -- Ultra Greedier
	wakaba.state.unlock.tsukasasoul1 = 2 -- Boss Rush
	wakaba.state.unlock.tsukasasoul2 = 2 -- Hush
	wakaba.state.unlock.isaaccartridge1 = 2 -- 4 Bosses
	wakaba.state.unlock.isaaccartridge2 = 2 -- 4 Bosses
	wakaba.state.unlock.isaaccartridge3 = 2 -- 4 Bosses
	wakaba.state.unlock.isaaccartridge4 = 2 -- 4 Bosses
	wakaba.state.unlock.easteregg = 2 -- Mega Satan
	wakaba.state.unlock.flashshift = 2 -- Delirium
	wakaba.state.unlock.sirenbadge = 2 -- Mother
	wakaba.state.unlock.elixiroflife = 2 -- The Beast
	wakaba.state.unlock.tsukasasoul = true
	wakaba.state.unlock.isaaccartridge = true

	print("Cheating Tainted Tsukasa unlocks complete.")
	wakaba.Log("[wakaba]Cheating Tainted Tsukasa unlocks complete.")
	--wakaba:save(true)
end

function wakaba:unlockRicher(bool)
	bool = bool or true
	wakaba.state.unlock.fireflylighter = 2 -- Mom's Heart Hard
	wakaba.state.unlock.sweetscatalog = 2 -- Isaac
	wakaba.state.unlock.antibalance = 2 --Satan
	wakaba.state.unlock.doubleinvader = 2 -- ???
	wakaba.state.unlock.venomincantation = 2 -- The Lamb
	wakaba.state.unlock.bunnyparfait = 2 -- Boss Rush
	wakaba.state.unlock.printer = 2 --
	wakaba.state.unlock.richeruniform = 2 -- Hush
	wakaba.state.unlock.clensingfoam = 2 -- Ultra Greed
	wakaba.state.unlock.lilricher = 2 -- Ultra Greedier
	wakaba.state.unlock.prestigepass = 2 -- Delirium
	wakaba.state.unlock.cunningpaper = 2 -- Mother
	wakaba.state.unlock.selfburning = 2 --The Beast
	wakaba.state.unlock.rabbitribbon = true

	wakaba.state.unlock.taintedricher = true

	print("Cheating Richer unlocks complete.")
	wakaba.Log("[wakaba]Cheating Richer unlocks complete.")
	--wakaba:save(true)
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
	wakaba.state.unlock.lilmao = true--14w Hold Me
	wakaba.state.unlock.richerflipper = true--15w Even or Odd
	wakaba.state.unlock.richernecklace = true--16w Runaway Pheromones
	wakaba.state.unlock.edensticky = true--98w T.Eden Starts with Sticky Note
	wakaba.state.unlock.doubledreams = true -- 99w Wakaba's Double Dreams

	print("Cheating Challenge unlocks complete.")
	wakaba.Log("[wakaba]Cheating Challenge unlocks complete.")
	--wakaba:save(true)
end

--storedplayers = 0,
--playersavedata = {},


wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.init)

include('wakaba_src.characters.not_wakaba')


function wakaba:OnGameExit(shouldSave)
	wakaba.Log("exit")

	for num = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(num - 1)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.pendingmantlestack = true
		--print("Game Continue")
		--print(player:GetData().wakaba.pendingmantlestack)
		--player:GetData().wakaba.istransition = true
	end

	--local hiddenItemData = wakaba.HiddenItemManager:GetSaveData()
	--hidden_item_datas.run.HIDDEN_ITEM_DATA = hiddenItemData

	wakaba:save(shouldSave)
end

wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.OnGameExit)


-- TestFuncs
--[[ local function CountBits(mask)
	local count = 0
	while mask ~= 0 do
		count = count + 1
		mask = mask & mask - 1
	end

	return count
end

function wakaba:Test_CardUse(cardID, playerWhoUsedItem, useFlags)
	print(cardID, CountBits(useFlags))
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.Test_CardUse) ]]

function wakaba:RandomInt(min, max, customRNG) --This and GetRandomElem were written by Guwahavel (hi)
	local rand = customRNG or wakaba.RNG
	if not max then
			max = min
			min = 0
	end
	if min > max then
			local temp = min
			min = max
			max = temp
	end
	return min + (rand:RandomInt(max - min + 1))
end

function wakaba:GetRandomElem(table, customRNG)
	if table and #table > 0 then
	local index = wakaba:RandomInt(1, #table, customRNG)
			return table[index], index
	end
end



local function runUpdates(tab) --This is from Fiend Folio
	for i = #tab, 1, -1 do
			local f = tab[i]
			f.Delay = f.Delay - 1
			if f.Delay <= 0 then
					f.Func()
					table.remove(tab, i)
			end
	end
end

wakaba.delayedFuncs = {}

---Scheduled update from Fiend Folio
---@param foo function
---@param delay int
---@param callback function
function wakaba:scheduleForUpdate(foo, delay, callback)
	callback = callback or ModCallbacks.MC_POST_UPDATE
	if not wakaba.delayedFuncs[callback] then
			wakaba.delayedFuncs[callback] = {}
			wakaba:AddCallback(callback, function()
					runUpdates(wakaba.delayedFuncs[callback])
			end)
	end

	table.insert(wakaba.delayedFuncs[callback], { Func = foo, Delay = delay })
end

---Shuffle sorting from table
---@param tbl table
---@return table
function wakaba:Shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = wakaba:RandomInt(1, i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end




print("Pudding and Wakaba", wakaba.version, "load complete.")
--wakaba:luamodInit()














--Isaac.GetPlayer():GetTearHitParams(WeaponType.WEAPON_BONE, 2, 1, Isaac.GetPlayer())