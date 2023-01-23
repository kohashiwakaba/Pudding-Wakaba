wakaba.Enums = {}

-- 모드 밸런스 옵션
wakaba.Enums.BalanceModes = {
	WAKABA = 1, -- 와카바 모드 : 컨셉 중시, 밸런스 비중시
	REVERSE = 2, -- 리버스 모드 : 밸런스 중시, 모드 옵션 무시
	HY_REPAIR = 3, -- 리페어 싱글 : 리페어 모드 연계, 밸런스 중시
	HY_REPAIR_VS = 4, -- 리페어 대결 : 리페어 모드 연계, 대결 중시
}

--플레이어 타입
wakaba.Enums.Players = {
	WAKABA = Isaac.GetPlayerTypeByName("Wakaba", false),
	WAKABA_B = Isaac.GetPlayerTypeByName("WakabaB", true),
	--WAKABA_T = Isaac.GetPlayerTypeByName("WakabaT", false),
	SHIORI = Isaac.GetPlayerTypeByName("Shiori", false),
	SHIORI_B = Isaac.GetPlayerTypeByName("ShioriB", true),
	TSUKASA = Isaac.GetPlayerTypeByName("Tsukasa", false),
	TSUKASA_B = Isaac.GetPlayerTypeByName("TsukasaB", true),
	RICHER = Isaac.GetPlayerTypeByName("Richer", false),
	RICHER_B = Isaac.GetPlayerTypeByName("RicherB", true),
}

-- 와카바 모드 아이템
wakaba.Enums.Collectibles = {
	-- Core items
	WAKABAS_BLESSING = Isaac.GetItemIdByName("Wakaba's Blessing"),
	WAKABAS_NEMESIS = Isaac.GetItemIdByName("Wakaba's Nemesis"),
	WAKABA_DUALITY = Isaac.GetItemIdByName("Wakaba Duality"),
	EATHEART = Isaac.GetItemIdByName("Eat Heart"),
	EATHEART_WAKABA = Isaac.GetItemIdByName("Eat Heart"),
	BOOK_OF_SHIORI = Isaac.GetItemIdByName("Book of Shiori"),
	BOOK_OF_CONQUEST = Isaac.GetItemIdByName("Book of Conquest"),
	MINERVA_AURA = Isaac.GetItemIdByName("Minerva's Aura"),
	LUNAR_STONE = Isaac.GetItemIdByName("Lunar Stone"),
	ELIXIR_OF_LIFE = Isaac.GetItemIdByName("Elixir of Life"),
	FLASH_SHIFT = Isaac.GetItemIdByName("Flash Shift"),
	CONCENTRATION = Isaac.GetItemIdByName("Concentration"),
	RABBIT_RIBBON = Isaac.GetItemIdByName("Rabbit Ribbon"),
	SWEETS_CATALOG = Isaac.GetItemIdByName("Sweets Catalog"),

	-- Regular items
	MYSTERIOUS_GAME_CD = Isaac.GetItemIdByName("Mysterious game CD"),
	D6_PLUS = Isaac.GetItemIdByName("D6 Plus"),
	D6_CHAOS = Isaac.GetItemIdByName("D6 Chaos"),
	LIL_MOE = Isaac.GetItemIdByName("Lil Moe"),
	MAIJIMA_MYTHOLOGY = Isaac.GetItemIdByName("Maijima Mythology"),
	LIL_SHIVA = Isaac.GetItemIdByName("Lil Shiva"),
	DEJA_VU = Isaac.GetItemIdByName("Deja Vu"),
	MOE_MUFFIN = Isaac.GetItemIdByName("Moe's Muffin"),
	SYRUP = Isaac.GetItemIdByName("Syrup"),
	CLENSING_FOAM = Isaac.GetItemIdByName("Clensing Foam"),
	CURSE_OF_THE_TOWER_2 = Isaac.GetItemIdByName("Curse of The Tower 2"),
	SEE_DES_BISCHOFS = Isaac.GetItemIdByName("See des Bischofs"),
	JAR_OF_CLOVER = Isaac.GetItemIdByName("Jar of Clover"),
	CRISIS_BOOST = Isaac.GetItemIdByName("Crisis Boost"),
	ONSEN_TOWEL = Isaac.GetItemIdByName("Onsen Towel"),

	-- Wakaba items
	BOOK_OF_FORGOTTEN = Isaac.GetItemIdByName("Book of Forgotten"),
	D_CUP_ICECREAM = Isaac.GetItemIdByName("D-Cup Ice Cream"),
	WAKABAS_PENDANT = Isaac.GetItemIdByName("Wakaba's Pendant"),
	SECRET_CARD = Isaac.GetItemIdByName("Secret Card"),
	EXECUTIONER = Isaac.GetItemIdByName("Executioner"),
	REVENGE_FRUIT = Isaac.GetItemIdByName("Revenge Fruit"),
	UNIFORM = Isaac.GetItemIdByName("Wakaba's Uniform"),
	LIL_WAKABA = Isaac.GetItemIdByName("Lil Wakaba"),
	COUNTER = Isaac.GetItemIdByName("Counter"),
	RETURN_POSTAGE = Isaac.GetItemIdByName("Return Postage"),
	PRESTIGE_PASS = Isaac.GetItemIdByName("Prestige Pass"),
	--HEALTH_REVERSAL = Isaac.GetItemIdByName("Health Reversal"),

	-- Shiori items
	BOOK_OF_FOCUS = Isaac.GetItemIdByName("Book of Focus"),
	DECK_OF_RUNES = Isaac.GetItemIdByName("Shiori's Bottle of Runes"),
	MICRO_DOPPELGANGER = Isaac.GetItemIdByName("Micro Doppelganger"),
	BOOK_OF_SILENCE = Isaac.GetItemIdByName("Book of Silence"),
	VINTAGE_THREAT = Isaac.GetItemIdByName("Vintage Threat"),
	BOOK_OF_THE_GOD = Isaac.GetItemIdByName("Book of The God"),
	GRIMREAPER_DEFENDER = Isaac.GetItemIdByName("Grimreaper Defender"),
	BOOK_OF_TRAUMA = Isaac.GetItemIdByName("Book of Trauma"),
	BOOK_OF_THE_FALLEN = Isaac.GetItemIdByName("Book of The Fallen"),

	-- Tsukasa items
	NEW_YEAR_BOMB = Isaac.GetItemIdByName("New Year's Eve Bomb"),
	MURASAME = Isaac.GetItemIdByName("Murasame"),
	NASA_LOVER = Isaac.GetItemIdByName("Nasa Lover"),
	ARCANE_CRYSTAL = Isaac.GetItemIdByName("Arcane Crystal"),
	ADVANCED_CRYSTAL = Isaac.GetItemIdByName("Advanced Crystal"),
	MYSTIC_CRYSTAL = Isaac.GetItemIdByName("Mystic Crystal"),
	POWER_BOMB = Isaac.GetItemIdByName("Power Bomb"),
	PHANTOM_CLOAK = Isaac.GetItemIdByName("Phantom Cloak"),
	QUESTION_BLOCK = Isaac.GetItemIdByName("Question Block"),
	BEETLEJUICE = Isaac.GetItemIdByName("Beetlejuice"),
	MAGMA_BLADE = Isaac.GetItemIdByName("Magma Blade"),
	--HYDRA = Isaac.GetItemIdByName("Hydra"),
	RED_CORRUPTION = Isaac.GetItemIdByName("Red Corruption"),
	PLASMA_BEAM = Isaac.GetItemIdByName("Plasma Beam"),
	LUNAR_DAMOCLES = Isaac.GetItemIdByName("Lunar Damocles"),
	EASTER_EGG = Isaac.GetItemIdByName("Easter Egg"),

	-- Richer items
	WINTER_ALBIREO = Isaac.GetItemIdByName("The Winter Albireo"),
	CARAMELLO_PANCAKE = Isaac.GetItemIdByName("Caramello Pancake"),
	_3D_PRINTER = Isaac.GetItemIdByName("3D Printer"),
	VENOM_INCANTATION = Isaac.GetItemIdByName("Venom Incantation"),
	FIREFLY_LIGHTER = Isaac.GetItemIdByName("Firefly Lighter"),
	DOUBLE_INVADER = Isaac.GetItemIdByName("Double Invader"),
	ANTI_BALANCE = Isaac.GetItemIdByName("Anti Balance"),
	RICHERS_UNIFORM = Isaac.GetItemIdByName("Richer's Uniform"),
	CHIERI = Isaac.GetItemIdByName("Chieri"),
	CUNNING_PAPER = Isaac.GetItemIdByName("Cunning Paper"),
	LIL_RICHER = Isaac.GetItemIdByName("Lil Richer"),
	LIL_RIRA = Isaac.GetItemIdByName("Lil Rira"),
	BLACK_RIBBON = Isaac.GetItemIdByName("Black Ribbon"),
	WATER_FLAME = Isaac.GetItemIdByName("Water Flame"),
	TRIAL_STEW = Isaac.GetItemIdByName("Trial Stew"),

	-- Challenge items
	PLUMY = Isaac.GetItemIdByName("Plumy"),
	EYE_OF_CLOCK = Isaac.GetItemIdByName("Eye of Clock"),
	APOLLYON_CRISIS = Isaac.GetItemIdByName("Apollyon Crisis"),
	NEKO_FIGURE = Isaac.GetItemIdByName("Neko Figure"),
	LIL_MAO = Isaac.GetItemIdByName("Lil Mao"),
	ISEKAI_DEFINITION = Isaac.GetItemIdByName("Isekai Definition"),
	BALANCE = Isaac.GetItemIdByName("Balance ecnalaB"),
	CLOVER_SHARD = Isaac.GetItemIdByName("Clover Shard"),
	DOUBLE_DREAMS = Isaac.GetItemIdByName("Wakaba's Double Dreams"),

	-- Misc items
	EDEN_STICKY_NOTE = Isaac.GetItemIdByName("Eden's Sticky Note"),
	WAKABAS_CURFEW = Isaac.GetItemIdByName("Wakaba's 6'o Clock Curfew"),
	WAKABAS_CURFEW2 = Isaac.GetItemIdByName("Wakaba's 9'o Clock Curfew"),

}

-- 와카바 모드 패밀리어 : FamiliarVariant 위치에서 사용
wakaba.Enums.Familiars = {
	PLUMY = Isaac.GetEntityVariantByName("Plumy"),
	LIL_WAKABA = Isaac.GetEntityVariantByName("Lil Wakaba"),
	LIL_MOE = Isaac.GetEntityVariantByName("Lil Moe"),
	LIL_SHIVA = Isaac.GetEntityVariantByName("Lil Shiva"),
	MURASAME = Isaac.GetEntityVariantByName("Murasame"),
	LIL_NASA = Isaac.GetEntityVariantByName("Lil Nasa"),
	LUNAR_DAMOCLES = Isaac.GetEntityVariantByName("Lunar Damocles"),
	EASTER_EGG = Isaac.GetEntityVariantByName("Easter Egg Orbital"),
	--LIL_RICHER = Isaac.GetEntityVariantByName("Lil Richer"),
	--LIL_RIRA = Isaac.GetEntityVariantByName("Lil Rira"),
	--BLACK_RIBBON = Isaac.GetEntityVariantByName("Black Ribbon Particle"),
	--CHIERI = Isaac.GetEntityVariantByName("Chieri"),

}

-- 와카바 모드 장신구
wakaba.Enums.Trinkets = {
	BRING_ME_THERE = Isaac.GetTrinketIdByName("Bring me there"),
	BITCOIN = Isaac.GetTrinketIdByName("Bitcoin II"),
	CLOVER = Isaac.GetTrinketIdByName("Clover"),
	MAGNET_HEAVEN = Isaac.GetTrinketIdByName("Magnet Heaven"),
	HARD_BOOK = Isaac.GetTrinketIdByName("Hard Book"),
	DETERMINATION_RIBBON = Isaac.GetTrinketIdByName("Determination Ribbon"),
	BOOKMARK_BAG = Isaac.GetTrinketIdByName("Bookmark Bag"),
	RING_OF_JUPITER = Isaac.GetTrinketIdByName("Ring of Jupiter"),
	DIMENSION_CUTTER = Isaac.GetTrinketIdByName("Dimension Cutter"),
	DELIMITER = Isaac.GetTrinketIdByName("Delimiter"),
	RANGE_OS = Isaac.GetTrinketIdByName("Range OS"),
	SIREN_BADGE = Isaac.GetTrinketIdByName("Siren's Badge"),
	ISAAC_CARTRIDGE = Isaac.GetTrinketIdByName("Isaac Cartridge"),
	AFTERBIRTH_CARTRIDGE = Isaac.GetTrinketIdByName("Afterbirth Cartridge"),
	REPENTANCE_CARTRIDGE = Isaac.GetTrinketIdByName("Repentance Cartridge"),
	STAR_REVERSAL = Isaac.GetTrinketIdByName("Star Reversal"),
	AURORA_GEM = Isaac.GetTrinketIdByName("Aurora Gem"),
	MISTAKE = Isaac.GetTrinketIdByName("Mistake"),

}

-- 와카바 모드 특수효과
wakaba.Enums.Effects = {
	POWER_BOMB = Isaac.GetEntityVariantByName("Wakaba Power Bomb Explosion"),
	MURASAME_SHIFT = Isaac.GetEntityVariantByName("Murasame Shift Effect"),
	--MAGMA_BLADE = Isaac.GetEntityVariantByName("Magma Blade Effect"),

}

-- 와카바 모드 기타 픽업
wakaba.Enums.Pickups = {
	CLOVER_CHEST = Isaac.GetEntityVariantByName("Clover Chest"),

}

-- 와카바 모드 코인 타입 : CoinSubType 위치에 사용
wakaba.Enums.Coins = {
	EASTER_EGG = 401,
}

-- 와카바 모드 카드/룬/영혼석
wakaba.Enums.Cards = {
	CARD_CRANE_CARD = Isaac.GetCardIdByName("wakaba_Crane Card"),
	CARD_CONFESSIONAL_CARD = Isaac.GetCardIdByName("wakaba_Confessional Card"),
	CARD_BLACK_JOKER = Isaac.GetCardIdByName("wakaba_Black Joker"),
	CARD_WHITE_JOKER = Isaac.GetCardIdByName("wakaba_White Joker"),
	CARD_COLOR_JOKER = Isaac.GetCardIdByName("wakaba_Color Joker"),
	CARD_DREAM_CARD = Isaac.GetCardIdByName("Wakaba's Dream Card"),
	CARD_UNKNOWN_BOOKMARK = Isaac.GetCardIdByName("wakaba_Unknown Bookmark"),
	CARD_QUEEN_OF_SPADES = Isaac.GetCardIdByName("wakaba_Queen of Spades"),
	CARD_RETURN_TOKEN = Isaac.GetCardIdByName("Return Token"),
	CARD_MINERVA_TICKET = Isaac.GetCardIdByName("Minerva Ticket"),
	SOUL_WAKABA = Isaac.GetCardIdByName("Soul of Wakaba"),
	SOUL_WAKABA2 = Isaac.GetCardIdByName("Soul of Wakaba?"),
	SOUL_SHIORI = Isaac.GetCardIdByName("Soul of Shiori"),
	SOUL_TSUKASA = Isaac.GetCardIdByName("Soul of Tsukasa"),
	CARD_VALUT_RIFT = Isaac.GetCardIdByName("wakaba_Valut Rift"),
	CARD_TRIAL_STEW = Isaac.GetCardIdByName("wakaba_Trial Stew"),

}

-- 와카바 모드 알약효과
wakaba.Enums.Pills = {
	DAMAGE_MULTIPLIER_UP = Isaac.GetPillEffectByName("Damage Multiplier Up"),
	DAMAGE_MULTIPLIER_DOWN = Isaac.GetPillEffectByName("Damage Multiplier Down"),
	ALL_STATS_UP = Isaac.GetPillEffectByName("All Stats Up"),
	ALL_STATS_DOWN = Isaac.GetPillEffectByName("All Stats Down"),
	TROLLED = Isaac.GetPillEffectByName("Trolled!"),
	TO_THE_START = Isaac.GetPillEffectByName("To the Start!"),
	EXPLOSIVE_DIARRHEA_2 = Isaac.GetPillEffectByName("Explosive Diarrhea 2!"),
	EXPLOSIVE_DIARRHEA_2_NOT = Isaac.GetPillEffectByName("Hellish Vomit"),
	SOCIAL_DISTANCE = Isaac.GetPillEffectByName("Social Distance"),
	DUALITY_ORDERS = Isaac.GetPillEffectByName("Duality Orders"),
	FLAME_PRINCESS = Isaac.GetPillEffectByName("Flame Princess!"),
	FIREY_TOUCH = Isaac.GetPillEffectByName("Firey Touch"),
	PRIEST_BLESSING = Isaac.GetPillEffectByName("Priest's Blessing"),
	UNHOLY_CURSE = Isaac.GetPillEffectByName("Unholy Curse"),
}

-- 와카바 모드 사운드
wakaba.Enums.SoundEffects = {
	AEION_CHARGE = Isaac.GetSoundIdByName("aeion_charged"), 
	POWER_BOMB_EXPLOSION = Isaac.GetSoundIdByName("pb_explosion"),
	POWER_BOMB_CHARGE = Isaac.GetSoundIdByName("pb_charge"),
	POWER_BOMB_LOOP = Isaac.GetSoundIdByName("pb_loop"),
	POWER_BOMB_AFTER_EXPLOSION_1 = Isaac.GetSoundIdByName("pb_after_explosion1"),
	POWER_BOMB_AFTER_EXPLOSION_2 = Isaac.GetSoundIdByName("pb_after_explosion2"),
	POWER_BOMB_AFTER_EXPLOSION_3 = Isaac.GetSoundIdByName("pb_after_explosion3"),
	POWER_BOMB_AFTER_EXPLOSION_4 = Isaac.GetSoundIdByName("pb_after_explosion4"),
	POWER_BOMB_AFTER_EXPLOSION_5 = Isaac.GetSoundIdByName("pb_after_explosion5"),
}

-- 와카바 모드 거지/슬롯류 : SlotVariant 위치에 사용
wakaba.Enums.Slots = {
	SHIORI_VALUT = Isaac.GetEntityVariantByName("Shiori Valut"),
	--SHRINE_BEGGAR = Isaac.GetEntityVariantByName("Shrine Beggar")
}

-- 행운 관련 상수
wakaba.Enums.Chances = {

	LUCK_TYPE_SCALE = 1, -- 럭비례 : 비례형
	LUCK_TYPE_REVERSE = 2, -- 럭비례 : 반비례형

	AURORA_DEFAULT = 6.66, -- 오로라 : 동전을 이스터에그로 바꿀 기본 확률
	AURORA_LUCK = 1, -- 오로라 : 럭 1당 동전을 이스터에그로 바꿀 추가 확률
	AURORA_MAX = 100, -- 오로라 : 동전을 이스터에그로 바꿀 최대 확률
}

wakaba.Enums.Constants = {
	PONY_COOLDOWN = 720, -- 러쉬 챌린지 화이트 포니 쿨타임
	MAX_TRAUMA_COUNT = 7, -- 트라우마 책 최대 폭발 수
	DIMENSION_CUTTER_RATE = 15,
	DIMENSION_CUTTER_GREED_MIN_RATE = 5,
	DIMENSION_CUTTER_GREED_LUCK_RATE = 2,
	DIMENSION_CUTTER_GREED_MAX_RATE = 25,
}

-- 시오리/알트시오리 배터리 획득 시 충전량
wakaba.Enums.ShioriBatteries = {
	[BatterySubType.BATTERY_NORMAL] = 3,
	[BatterySubType.BATTERY_MICRO] = 1,
	[BatterySubType.BATTERY_MEGA] = 5,
	[BatterySubType.BATTERY_GOLDEN] = 10,
}

wakaba.ClubOptions = {
	General = {
		--knifeGfx = "",
		knifeVariant = 11,
		knifeSubType = 4,
	},
	FlashMurasame = {
		--knifeGfx = "gfx/wakaba_magmablade.anm2",
		knifeVariant = 9,
		knifeSubType = 4,
		sizeMulti = 1.2,
		collisionMulti = 1.2,
		tearFlags = TearFlags.TEAR_ACID,
	},
	MagmaBlade = {
		knifeGfx = "gfx/wakaba_magmablade.anm2",
		knifeVariant = 2,
		knifeSubType = 4,
		sizeMulti = 1.5,
		collisionMulti = 2,
		tearFlags = TearFlags.TEAR_BURN | TearFlags.TEAR_ACID,
	},
}












wakaba.curses = {
	CURSE_OF_FLAMES = 1 << (Isaac.GetCurseIdByName("Curse of Flames!") - 1),
	CURSE_OF_SATYR = 1 << (Isaac.GetCurseIdByName("Curse of Satyr!") - 1),
	CURSE_OF_SNIPER = 1 << (Isaac.GetCurseIdByName("Curse of Sniper!") - 1),
	CURSE_OF_FAIRY = 1 << (Isaac.GetCurseIdByName("Curse of Fairy!") - 1),
	CURSE_OF_AMNESIA = 1 << (Isaac.GetCurseIdByName("Curse of Amnesia!") - 1),
	CURSE_OF_MAGICAL_GIRL = 1 << (Isaac.GetCurseIdByName("Curse of Magical Girl!") - 1),
}

wakaba.challenges = {
	CHALLENGE_ELEC = Isaac.GetChallengeIdByName("[w01] Electric Disorder"), --w01
	CHALLENGE_PLUM = Isaac.GetChallengeIdByName("[w02] Berry Best Friend"), --w02
	CHALLENGE_PULL = Isaac.GetChallengeIdByName("[w03] Pull and Pull"), --w03
	CHALLENGE_MINE = Isaac.GetChallengeIdByName("[w04] Mine stuff"), --w04
	CHALLENGE_GUPP = Isaac.GetChallengeIdByName("[w05] Black neko dreams"), --w05
	CHALLENGE_DOPP = Isaac.GetChallengeIdByName("[w06] Doppelganger"), --w06
	CHALLENGE_DELI = Isaac.GetChallengeIdByName("[w07] Delirium"), --w07
	CHALLENGE_SIST = Isaac.GetChallengeIdByName("[w08] Sisters from Beyond"), --w08
	CHALLENGE_DRAW = Isaac.GetChallengeIdByName("[w09] Draw Five"), --w09
	CHALLENGE_HUSH = Isaac.GetChallengeIdByName("[w10] Rush Rush Hush"), --w10
	CHALLENGE_APPL = Isaac.GetChallengeIdByName("[w11] Apollyon Crisis"), --w11
	CHALLENGE_BIKE = Isaac.GetChallengeIdByName("[w12] Delivery System"), --w12
	CHALLENGE_CALC = Isaac.GetChallengeIdByName("[w13] Calculation"), --w13
	CHALLENGE_HOLD = Isaac.GetChallengeIdByName("[w14] Hold Me"), --w14
	
	CHALLENGE_RAND = Isaac.GetChallengeIdByName("[w98] Hyper Random"), --w98
	CHALLENGE_DRMS = Isaac.GetChallengeIdByName("[w99] True Purist Girl"), --w99
	CHALLENGE_SLNT = Isaac.GetChallengeIdByName("[wb1] Pure Delirium vs Silence"), --wb1
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

wakaba.FIRST_WAKABA_ITEM = wakaba.Enums.Collectibles.WAKABAS_BLESSING
wakaba.LAST_WAKABA_ITEM = wakaba.Enums.Collectibles.CUNNING_PAPER
wakaba.FIRST_WAKABA_TRINKET = wakaba.Enums.Trinkets.CLOVER
wakaba.LAST_WAKABA_TRINKET = wakaba.Enums.Trinkets.MISTAKE

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
	bookoftrauma = "gfx/ui/achievement_wakaba/achievement_bookoftrauma.png", -- Hush
	magnetheaven = "gfx/ui/achievement_wakaba/achievement_magnetheaven.png", -- Ultra Greed
	determinationribbon = "gfx/ui/achievement_wakaba/achievement_determinationribbon.png", -- Ultra Greedier
	bookofsilence = "gfx/ui/achievement_wakaba/achievement_bookofsilence.png", -- Delirium
	vintagethreat = "gfx/ui/achievement_wakaba/achievement_vintagethreat.png", -- Mother
	bookofthegod = "gfx/ui/achievement_wakaba/achievement_bookofthegod.png", --The Beast
	
	bookofshiori = "gfx/ui/achievement_wakaba/achievement_bookofshiori.png",
	
	-- Tainted Shiori Unlocks
	queenofspades = "gfx/ui/achievement_wakaba/achievement_queenofspades.png", -- Ultra Greedier
	shiorivalut = "gfx/ui/achievement_wakaba/achievement_anotherfortunemachine.png", -- Mega Satan
	bookofconquest = "gfx/ui/achievement_wakaba/achievement_bookofconquest.png", -- Delirium
	ringofjupiter = "gfx/ui/achievement_wakaba/achievement_ringofjupiter.png", -- Mother
	minervaaura = "gfx/ui/achievement_wakaba/achievement_minervaaura.png", -- The Beast

	shiorisoul = "gfx/ui/achievement_wakaba/achievement_shiorisoul.png",
	bookmarkbag = "gfx/ui/achievement_wakaba/achievement_bookmarkbag.png",

	-- Tsukasa Unlocks
	
	murasame = "gfx/ui/achievement_wakaba/achievement_murasame.png", -- Mom's Heart Hard
	nasalover = "gfx/ui/achievement_wakaba/achievement_nasalover.png", -- Isaac
	beetlejuice = "gfx/ui/achievement_wakaba/achievement_beetlejuice.png", --Satan
	redcorruption = "gfx/ui/achievement_wakaba/achievement_redcorruption.png", -- ???
	powerbomb = "gfx/ui/achievement_wakaba/achievement_powerbomb.png", -- The Lamb
	concentration = "gfx/ui/achievement_wakaba/achievement_concentration.png", -- Boss Rush
	plasmabeam = "gfx/ui/achievement_wakaba/achievement_plasmabeam.png", -- 
	rangeos = "gfx/ui/achievement_wakaba/achievement_rangeos.png", -- Hush
	arcanecrystal = "gfx/ui/achievement_wakaba/achievement_arcanecrystal.png", -- Ultra Greed
	questionblock = "gfx/ui/achievement_wakaba/achievement_questionblock.png", -- Ultra Greedier
	newyearbomb = "gfx/ui/achievement_wakaba/achievement_newyearbomb.png", -- Delirium
	phantomcloak = "gfx/ui/achievement_wakaba/achievement_phantomcloak.png", -- Mother
	magmablade = "gfx/ui/achievement_wakaba/achievement_magmablade.png", --The Beast

	lunarstone = "gfx/ui/achievement_wakaba/achievement_lunarstone.png",

	taintedtsukasa = "gfx/ui/achievement_wakaba/achievement_taintedtsukasa.png",

	-- Tainted Tsukasa Unlocks
	returntoken = "gfx/ui/achievement_wakaba/achievement_returntoken.png", -- Ultra Greedier
	easteregg = "gfx/ui/achievement_wakaba/achievement_easteregg.png", -- Mega Satan
	flashshift = "gfx/ui/achievement_wakaba/achievement_flashshift.png", -- Delirium
	sirenbadge = "gfx/ui/achievement_wakaba/achievement_sirenbadge.png", -- Mother
	elixiroflife = "gfx/ui/achievement_wakaba/achievement_elixiroflife.png", -- The Beast

	tsukasasoul = "gfx/ui/achievement_wakaba/achievement_tsukasasoul.png",
	isaaccartridge = "gfx/ui/achievement_wakaba/achievement_isaaccartridge.png",
	
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
	[wakaba.shiorimodes.SHIORI_LIBRARIAN] = {
		name = "Librarian", 
		configdesc = "Shiori starts with most books",
		dssdesc1 = "shiori starts with most books",
	},
	[wakaba.shiorimodes.SHIORI_COLLECTOR] = {
		name = "Collector", 
		configdesc = "Shiori starts with a random book, and must be collected manually. Most book actives will be moved into pocket slot automatically",
		dssdesc1 = "shiori starts with a random book,",
		dssdesc2 = "and must be collected manually.",
		dssdesc3 = "most book actives will be moved",
		dssdesc4 = "into pocket slot automatically",
	},
	[wakaba.shiorimodes.SHIORI_AKASIC_RECORDS] = {
		name = "Akasic Records", 
		configdesc = "Shiori can use only 3 books per floor(Default)",
		dssdesc1 = "shiori can use only 3 books",
		dssdesc2 = "per floor(default)",
	},
	[wakaba.shiorimodes.SHIORI_PURE_BODY] = {
		name = "Pure Body", 
		configdesc = "Shiori starts with most books, but cannot collect any collectibles. Touching the collectible will dissolved into keys",
		dssdesc1 = "shiori starts with most books,",
		dssdesc2 = "but cannot collect any collectibles",
		dssdesc3 = "touching the collectible",
		dssdesc4 = "will dissolved into keys",
	},
	--[wakaba.shiorimodes.SHIORI_MINERVA] = {name = "Minerva?", configdesc = "Unimplemented",},
	[wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR] = {
		name = "Curse of Saytr", 
		configdesc = "Shiori cannot switch books manually, books will be randomized on active item usage.",
		dssdesc1 = "shiori cannot switch books manually",
		dssdesc2 = "books will be randomized",
		dssdesc3 = "on active item usage",
	},
}

wakaba.shiorimodestringsdss = {}

for i = 0, #wakaba.shiorimodestrings do
	wakaba.shiorimodestringsdss[i+1] = wakaba.shiorimodestrings[i].name:lower()
end
