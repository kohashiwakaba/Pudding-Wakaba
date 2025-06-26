
-- Pudding and Wakaba is Repentance only.
if not (REPENTANCE or REPENTANCE_PLUS) then
	print("Pudding and Wakaba is Repentance only. If this message pops up even in Repentance, check other mods that modify repentance variable.")
	Isaac.DebugString("Pudding and Wakaba is Repentance only. If this message pops up even in Repentance, check other mods that modify repentance variable.")
	return
end
if REPENTANCE_PLUS then REPENTANCE = true end
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




_wakaba.isc = require("wakaba_src.libs.isaacscript-common")
local isc = _wakaba.isc
local iFeatures = {
	isc.ISCFeature.SAVE_DATA_MANAGER,
	--isc.ISCFeature.PICKUP_INDEX_CREATION,
	--isc.ISCFeature.PLAYER_INVENTORY,
	isc.ISCFeature.CHARACTER_HEALTH_CONVERSION,
	isc.ISCFeature.TAINTED_LAZARUS_PLAYERS,
	isc.ISCFeature.NO_SIREN_STEAL,
	isc.ISCFeature.MODDED_ELEMENT_SETS,
	isc.ISCFeature.START_AMBUSH,
}
if REPENTOGON then
	iFeatures = {
		isc.ISCFeature.SAVE_DATA_MANAGER,
		isc.ISCFeature.MODDED_ELEMENT_SETS,
	}
end
wakaba = isc:upgradeMod(_wakaba, iFeatures) ---@class wakaba: ModReference

include('wakaba_flags')
include('wakaba_src.debug_area')

--include("wakaba_src.libs.filepathhelper")
include('wakaba_src.libs.hud_helper')
include('wakaba_src.libs.status_effect_library')
include('wakaba_src.libs.screenhelper')
include("wakaba_src.enums.constants")
include("wakaba_src.libs.retribution_utils")
if not REPENTOGON then
	include('wakaba_src.libs.achievement_display_api')
	include("wakaba_src.libs.pause_screen_completion_marks_api")
	--require("wakaba_src.libs.item_display_library")
	PauseScreenCompletionMarksAPI:SetShader("wakaba_ChallengeDest_DummyShader")
end

---@type Game
wakaba.G = Game() -- Cache game object
---@type Level
wakaba.L = function() return wakaba.G:GetLevel() end -- Cache level object
---@type Room
wakaba.R = function() return wakaba.G:GetRoom() end -- Cache room object
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
---@type Sprite
wakaba.WakabaHealthSprite = Sprite()
wakaba.WakabaHealthSprite:Load("gfx/ui/wakaba/ui_hearts_wakaba.anm2", true)

wakaba.Status = StatusEffectLibrary
include('wakaba_src.libs.status_effect_library_append')

function wakaba:isRepPlus()
	return FontRenderSettings ~= nil
end

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
wakaba.version = "v132b 2025.06.26"
wakaba.intversion = 13202

wakaba.modpath = GetCurrentModPath()

wakaba.rerollcooltime = 0
wakaba.hasdreams = false

wakaba.costumecooldown = 600
wakaba.costumecurrframe = 0

wakaba._keyPressFrame = 0

wakaba.fullreroll = false
wakaba.pedestalreroll = false
wakaba.spindownreroll = 0

wakaba.unlockdisplaytimer = -(30*30)

wakaba.playerstats = {}

wakaba.sprites = {}
include('wakaba_src.rgb')

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

			-- Tainted Rira Unlocks
			taintedriramomsheart = 0,
			caramellacandybag1 = 0, -- Isaac
			caramellacandybag2 = 0, -- Satan
			caramellacandybag3 = 0, -- ???
			caramellacandybag4 = 0, -- The Lamb
			rirasoul1 = 0, -- Boss Rush
			rirasoul2 = 0, -- Hush
			rabbeyward = 0, -- Delirium
			aquatrinket = 0, -- Mega Satan
			flipcard = 0, -- Ultra Greedier
			pinkfork = 0, -- Mother
			azurerir = 0, -- The Beast

			caramellacandybag = false,
			rirasoul = false,

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

		bossdestlock = false,
		damoclesstart = nil,
		bossdest = nil,
		startquality = nil,
		bossdesthealth = nil,
		bossdesthealthamount = nil,
		bossdestlunatic = nil,

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

	-- Tainted Rira Unlocks
	taintedriramomsheart = 0,
	caramellacandybag1 = 0, -- Isaac
	caramellacandybag2 = 0, -- Satan
	caramellacandybag3 = 0, -- ???
	caramellacandybag4 = 0, -- The Lamb
	rirasoul1 = 0, -- Boss Rush
	rirasoul2 = 0, -- Hush
	rabbeyward = 0, -- Delirium
	aquatrinket = 0, -- Mega Satan
	flipcard = 0, -- Ultra Greedier
	pinkfork = 0, -- Mother
	azurerir = 0, -- The Beast

	caramellacandybag = false,
	rirasoul = false,

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
--start from new wakaba.G
if not wakaba.defaultstate then
	wakaba.defaultstate = wakaba:deepcopy(wakaba.state)
end

--Global Functions and variables

local HUD = wakaba.G:GetHUD()
wakaba.RNG = RNG()
wakaba.ItemRNG = RNG()
wakaba.PickupRNG = RNG()
wakaba.ItemConfig = Isaac.GetItemConfig()

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
if wakaba.Flags.stackableDamocles then
	include('wakaba_src.damocles_api')
end

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

do -- Core loader
	include('wakaba_src.functions.callbacks_wakaba')
	include('wakaba_src.functions.secondary_player_data')
	include('wakaba_src.libs.revel_utils')
	include('wakaba_src.functions.hudstats')
	include('wakaba_src.functions.hit_counter')
	include('wakaba_src.functions.room_name_display')
	include('wakaba_src.functions.enhanced_boss_dest')
	include('wakaba_src.functions.isc_roomgen')
	include('wakaba_src.functions.spawner')
	include('wakaba_src.functions.custom_item_sound')
	include('wakaba_src.functions.custom_hurt_sound')
	include('wakaba_src.functions.custom_pedestals')
end

do -- Items loader
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
	include('wakaba_src.items.0016_rabbeyward')
	include('wakaba_src.items.0018_azurerir')
	include('wakaba_src.items.1001_eatheart')
	include('wakaba_src.items.0035_kyoulover')
	include('wakaba_src.items.0036_purifier')
	include('wakaba_src.items.0037_shifter')

	include('wakaba_src.items.1002_bookofforgotten')
	include('wakaba_src.items.1003_dcupicecream')
	include('wakaba_src.items.1003b_mintchocoicecream')
	include('wakaba_src.items.1004_gamecd')
	include('wakaba_src.items.1005_wakabapendant')
	include('wakaba_src.items.1005b_wakabahairpin')
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
	include('wakaba_src.items.1090_bookofamplitude')
	include('wakaba_src.items.1091_sakuracapsule')
	include('wakaba_src.items.1092_chewyrollycake')
	include('wakaba_src.items.1093_maidduet')
	include('wakaba_src.items.1094_crossbomb')
	include('wakaba_src.items.1095_rirauniform')
	include('wakaba_src.items.1100_richerbra')
	include('wakaba_src.items.1102_bubblebombs')
	include('wakaba_src.items.1107_clearfile')

	include('wakaba_src.pickups.2005_dreamcard')
	include('wakaba_src.items.1200_doubledreams')
	include('wakaba_src.items.1201_edenstickynote')
end

do -- Consumables loader

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
include('wakaba_src.pickups.2015_flipcard')
include('wakaba_src.pickups.2100_pills')
include('wakaba_src.pickups.2501_wakabasoul')
include('wakaba_src.pickups.2502_shiorisoul')
include('wakaba_src.pickups.2503_tsukasasoul')
include('wakaba_src.pickups.2504_richersoul')
include('wakaba_src.pickups.2505_rirasoul')
end

do -- Trinkets loader

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
	include('wakaba_src.items.3021_caramellacandies')
	include('wakaba_src.items.3022_pinkfork')

	include('wakaba_src.items.3300_cursed_trinkets')
end

do -- Tarnished unlock trinkets
	include('wakaba_src.items.3203_sigilofkaguya')
end

do -- Extra entities loader
	include('wakaba_src.pickups.4000_cloverchest')

	include('wakaba_src.entities.anotherfortune')
	include('wakaba_src.entities.crystalrestock')
end

do -- Characters loader
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
	include('wakaba_src.characters.rira_b')
	include('wakaba_src.characters.anna')
end

do -- Core functions loader
	include('wakaba_src.common')

	include('wakaba_src.items.0002_bookofshiori_func')

	include('wakaba_src.entities.effects')
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
	include('wakaba_src.functions.inventory_descriptions')

	--include('challenges')
	include('wakaba_src.challenges.core')
	include('wakaba_src.curses')
end

do -- EID loader
	include('wakaba_src.descriptions.en_us')
	include('wakaba_src.descriptions.ko_kr')
	include('wakaba_src.descriptions.zh_cn')
	include('wakaba_src.descriptions.conditionals')
	include('wakaba_src.eidappend')
	include('wakaba_src.eidreminder')
	include('wakaba_src.uniqueitems')
end

do -- Extra functions loader

	include('wakaba_src.devilangel')
	include('wakaba_src.encyclopedia')
	include('wakaba_src.rerollcheck')
	include('wakaba_src.rerollcheck_blacklist')
	include('wakaba_src.functions.item_pool_wakaba')
	include('wakaba_src.wardrobeplus')
	include('wakaba_src.stackablemantle')
	include('wakaba_src.deadwispnotif')
	--include('wakaba_src.inventorydesc')
	include('wakaba_src.minimapi')
	include('wakaba_src.challenges_dest')
	include('wakaba_src.wisps')
	include('wakaba_src.config')
	include('wakaba_src.console_commands')
end

do -- Compatibility loader
	include('wakaba_src.compat_manager')
end

if REPENTOGON then -- REPENTOGON loader
	include('wakaba_src.compat.repentogon.core')
	include('wakaba_src.compat.repentogon.item_names')
	include('wakaba_src.compat.repentogon.item_additions')
	include('wakaba_src.compat.repentogon.achievements')
	include('wakaba_src.compat.repentogon.revivals')
	include('wakaba_src.compat.repentogon.difflib')
	--include('wakaba_src.compat.repentogon.main_menu')
	--include('wakaba_src.compat.repentogon.imgui')
	if _DISCORDRPC then
		include('wakaba_src.compat.repentogon.discord_rich_presence')
	end
end

-- This must be call very last
function wakaba:TakeDmg_VintageThreat(entity, amount, flag, source, countdownFrames)
	if entity.Type == EntityType.ENTITY_PLAYER
	and flag & (DamageFlag.DAMAGE_CURSED_DOOR | DamageFlag.DAMAGE_FAKE) == 0
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
--wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_VintageThreat)

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

		-- Caching Books for Maijima
		local tempMaijimaBooks = wakaba:getBooks(player, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
		local maijimaBooksToAdd = {}
		local maijimaRng = RNG()
		maijimaRng:SetSeed(wakaba.G:GetSeeds():GetStartSeed(), 35)
		for i = 0, 7 do
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

	-- TODO make compat manager
	if EID then
		wakaba:UpdateWakabaDescriptions()
		--wakaba:UpdateWakabaEncyclopediaDescriptions()
	end

	if not REPENTOGON then
		wakaba:setFamiliarNoSirenSteal(wakaba.Enums.Familiars.LUNAR_DAMOCLES)
		wakaba:setFamiliarNoSirenSteal(wakaba.Enums.Familiars.MURASAME)
	end
	wakaba._keyPressFrame = wakaba.G:GetFrameCount()
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
				damagemult = 0,
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
			player:SetPocketActiveItem(wakaba.Enums.Collectibles.STICKY_NOTE, ActiveSlot.SLOT_POCKET, false)
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

costumeProtector.AddCallback("MC_POST_COSTUME_RESET", function(player)
	if wakaba.G:GetSeeds():HasSeedEffect(SeedEffect.SEED_CHRISTMAS) then
		player:AddNullCostume(NullItemID.ID_CHRISTMAS)
	end
end)

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

local hasShownStartWarning = false
local skipWarning = false
if EID then
	local shouldShowWarning = {}
	if not REPENTOGON then
		--table.insert(shouldShowWarning, "WakabaRGONWarningText")
	end
	if not wakaba.Flags.stackableDamocles then
		table.insert(shouldShowWarning, "WakabaDamoclesWarningText")
	end

	function wakaba:Render_WakabaFlagsWarning()
		if skipWarning then
			wakaba:RemoveCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_WakabaFlagsWarning)
		end
		if #shouldShowWarning > 0 and wakaba.G:GetFrameCount() < 10*30 then
			local player = Isaac.GetPlayer()
			local title = EID:getDescriptionEntry("WakabaGlobalWarningTitle")
			local desc = ""
			for i, entry in ipairs(shouldShowWarning) do
				desc = desc .. "#" .. EID:getDescriptionEntry(shouldShowWarning[i])
			end
			local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
			--demoDescObj.Icon = "{{Player"..wakaba.Enums.Players.RICHER_B.."}}"
			demoDescObj.Name = title or ""
			demoDescObj.Description = desc or ""
			EID:displayPermanentText(demoDescObj, "WakabaGlobalWarningTitle")
			hasShownStartWarning = true
		elseif hasShownStartWarning then
			EID:hidePermanentText()
			skipWarning = true
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_WakabaFlagsWarning)
end



print("Pudding and Wakaba", wakaba.version, "load complete.")

