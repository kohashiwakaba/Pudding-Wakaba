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
	SHIORI = Isaac.GetPlayerTypeByName("Shiori", false),
	SHIORI_B = Isaac.GetPlayerTypeByName("ShioriB", true),
	TSUKASA = Isaac.GetPlayerTypeByName("Tsukasa", false),
	TSUKASA_B = Isaac.GetPlayerTypeByName("TsukasaB", true),
	RICHER = Isaac.GetPlayerTypeByName("Richer", false),
	RICHER_B = Isaac.GetPlayerTypeByName("RicherB", true),
	RIRA = Isaac.GetPlayerTypeByName("Rira", false),
	RIRA_B = Isaac.GetPlayerTypeByName("RiraB", true),

	WAKABA_T = Isaac.GetPlayerTypeByName("WakabaT", false),
	SHIORI_T = Isaac.GetPlayerTypeByName("ShioriT", false),
	TSUKASA_T = Isaac.GetPlayerTypeByName("TsukasaT", false),
	RICHER_T = Isaac.GetPlayerTypeByName("RicherT", false),
	RIRA_T = Isaac.GetPlayerTypeByName("RiraT", false),

	-- Challenge exclusive characters
	SHIMA = Isaac.GetPlayerTypeByName("Shima", false),
	CECILIA = Isaac.GetPlayerTypeByName("Cecilia", false), -- not final, can be changed
	ANNA = Isaac.GetPlayerTypeByName("Anna", false),
	CIEL = Isaac.GetPlayerTypeByName("Ciel", false),
	KORON = Isaac.GetPlayerTypeByName("Koron", false),
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
	BOOK_OF_SHIORI_FLOOR = Isaac.GetItemIdByName("Shiori's Red Bookmark"),
	BOOK_OF_SHIORI_ROOM = Isaac.GetItemIdByName("Shiori's Blue Bookmark"),
	BOOK_OF_SHIORI_MISC = Isaac.GetItemIdByName("Shiori's Yellow Bookmark"),
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
	RIRAS_BRA = Isaac.GetItemIdByName("Rira's Bra"),
	RICHERS_BRA = Isaac.GetItemIdByName("Richer's Bra"),
	KANAE_LENS = Isaac.GetItemIdByName("Kanae Lens"),
	BOOK_OF_AMPLITUDE = Isaac.GetItemIdByName("Book of Amplitude"),
	CLEAR_FILE = Isaac.GetItemIdByName("Clear File"),

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

	NORNIR = Isaac.GetItemIdByName("Nornir"),
	LAMP_GRIMORE = Isaac.GetItemIdByName("Lamp Grimore"),
	ETOILIUM = Isaac.GetItemIdByName("Etoilium"),

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
	NEW_YEAR_EVE_BOMB = Isaac.GetItemIdByName("New Year's Eve Bomb"),
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
	RED_CORRUPTION = Isaac.GetItemIdByName("Red Corruption"),
	PLASMA_BEAM = Isaac.GetItemIdByName("Plasma Beam"),
	LUNAR_DAMOCLES = Isaac.GetItemIdByName("Lunar Damocles"),
	EASTER_EGG = Isaac.GetItemIdByName("Easter Egg"),

	-- Richer items
	WINTER_ALBIREO = Isaac.GetItemIdByName("The Winter Albireo"),
	_3D_PRINTER = Isaac.GetItemIdByName("3D Printer"),
	VENOM_INCANTATION = Isaac.GetItemIdByName("Venom Incantation"),
	FIREFLY_LIGHTER = Isaac.GetItemIdByName("Firefly Lighter"),
	DOUBLE_INVADER = Isaac.GetItemIdByName("Double Invader"),
	ANTI_BALANCE = Isaac.GetItemIdByName("Anti Balance"),
	BUNNY_PARFAIT = Isaac.GetItemIdByName("Bunny Parfait"),
	RICHERS_UNIFORM = Isaac.GetItemIdByName("Richer's Uniform"),
	PRESTIGE_PASS = Isaac.GetItemIdByName("Prestige Pass"),
	CUNNING_PAPER = Isaac.GetItemIdByName("Cunning Paper"),
	LIL_RICHER = Isaac.GetItemIdByName("Lil Richer"),
	SELF_BURNING = Isaac.GetItemIdByName("Self Burning"),
	WATER_FLAME = Isaac.GetItemIdByName("Water-Flame"),
	TRIAL_STEW = Isaac.GetItemIdByName("Trial Stew"),

	-- Rira items
	BLACK_BEAN_MOCHI = Isaac.GetItemIdByName("Black Bean Mochi"),
	RIRAS_SWIMSUIT = Isaac.GetItemIdByName("Rira's Swimsuit"),
	SAKURA_MONT_BLANC = Isaac.GetItemIdByName("Sakura Mont Blanc"),
	NERF_GUN = Isaac.GetItemIdByName("Nerf Gun"),
	RIRAS_BENTO = Isaac.GetItemIdByName("Rira's Bento"),
	CHEWY_ROLLY_CAKE = Isaac.GetItemIdByName("Chewy Rolly Cake"),
	RIRAS_COAT = Isaac.GetItemIdByName("Rira's Coat"),
	CARAMELLA_PANCAKE = Isaac.GetItemIdByName("Caramella Pancake"),
	SECRET_DOOR = Isaac.GetItemIdByName("Secret Door"),
	RIRAS_BANDAGE = Isaac.GetItemIdByName("Rira's Bandage"),
	RIRAS_UNIFORM = Isaac.GetItemIdByName("Rira's Uniform"),
	POW_BLOCK = Isaac.GetItemIdByName("POW Block"),
	MOD_BLOCK = Isaac.GetItemIdByName("MOd Block"),
	CHIMAKI = Isaac.GetItemIdByName("Chimaki"),
	LIL_RIRA = Isaac.GetItemIdByName("Lil Rira"),
	SAKURA_CAPSULE = Isaac.GetItemIdByName("Sakura Capsule"),
	MAID_DUET = Isaac.GetItemIdByName("Maid Duet"),
	CLEANER = Isaac.GetItemIdByName("Dual Cleaner"),

	RABBEY_WARD = Isaac.GetItemIdByName("Rabbey Ward"),
	BROKEN_TOOLBOX = Isaac.GetItemIdByName("Broken Toolbox"),
	AZURE_RIR = Isaac.GetItemIdByName("Azure Rir"),

	-- Tainted Items
	SUCCUBUS_BLANKET = Isaac.GetItemIdByName("Succubus Blanket"),
	MINT_CHOCO_ICECREAM = Isaac.GetItemIdByName("Mint Chocolate Ice-cream"),
	WAKABAS_HAIRPIN = Isaac.GetItemIdByName("Wakaba's Hairpin"),

	-- Challenge items
	PLUMY = Isaac.GetItemIdByName("Plumy"),
	EYE_OF_CLOCK = Isaac.GetItemIdByName("Eye of Clock"),
	APOLLYON_CRISIS = Isaac.GetItemIdByName("Apollyon Crisis"),
	NEKO_FIGURE = Isaac.GetItemIdByName("Neko Figure"),
	LIL_MAO = Isaac.GetItemIdByName("Lil Mao"),
	ISEKAI_DEFINITION = Isaac.GetItemIdByName("Isekai Definition"),
	BALANCE = Isaac.GetItemIdByName("Balance ecnalaB"),
	RICHERS_FLIPPER = Isaac.GetItemIdByName("Richer's Flipper"),
	RICHERS_NECKLACE = Isaac.GetItemIdByName("Richer's Necklace"),
	CROSS_BOMB = Isaac.GetItemIdByName("Cross Bomb"),
	GOOMBELLA = Isaac.GetItemIdByName("Goombella"),
	BUBBLE_BOMBS = Isaac.GetItemIdByName("Bubble Bombs"),
	CLOVER_SHARD = Isaac.GetItemIdByName("Clover Shard"),
	DOUBLE_DREAMS = Isaac.GetItemIdByName("Wakaba's Double Dreams"),

	-- Misc items
	EDEN_STICKY_NOTE = Isaac.GetItemIdByName("Eden's Sticky Note"),
	WAKABAS_CURFEW = Isaac.GetItemIdByName("Wakaba's 6'o Clock Curfew"),
	WAKABAS_CURFEW2 = Isaac.GetItemIdByName("Wakaba's 9'o Clock Curfew"),
	KYOUTAROU_LOVER = Isaac.GetItemIdByName("Kyoutarou Lover"),
	ANNA_RIBBON_0 = Isaac.GetItemIdByName("Anna Ribbon"),
	ANNA_RIBBON_1 = Isaac.GetItemIdByName("Anna Ribbon "),
	ANNA_RIBBON_2 = Isaac.GetItemIdByName("Anna Ribbon  "),
	ANNA_RIBBON_3 = Isaac.GetItemIdByName("Anna Ribbon   "),
	ANNA_RIBBON_4 = Isaac.GetItemIdByName("Anna Ribbon    "),

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
	LIL_RICHER = Isaac.GetEntityVariantByName("Lil Richer"),
	LIL_RIRA = Isaac.GetEntityVariantByName("Lil Rira"),
	CHIMAKI = Isaac.GetEntityVariantByName("Chimaki"),
	LIL_KYOUTAROU = Isaac.GetEntityVariantByName("Lil Kyoutarou"),
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
	KUROMI_CARD = Isaac.GetTrinketIdByName("Kuromi Card"),
	ETERNITY_COOKIE = Isaac.GetTrinketIdByName("Eternity Cookie"),
	REPORT_CARD = Isaac.GetTrinketIdByName("Richer's Report Card"),
	RABBIT_PILLOW = Isaac.GetTrinketIdByName("Rabbit Pillow"),
	SIGIL_OF_WAKABA = Isaac.GetTrinketIdByName("Sigil of Wakaba"),
	SIGIL_OF_KAGUYA = Isaac.GetTrinketIdByName("Sigil of Kaguya"),
	CANDY_OF_RICHER = Isaac.GetTrinketIdByName("Candy of Richer"),
	CANDY_OF_RIRA = Isaac.GetTrinketIdByName("Candy of Rira"),
	CANDY_OF_CIEL = Isaac.GetTrinketIdByName("Candy of Ciel"),
	CANDY_OF_KORON = Isaac.GetTrinketIdByName("Candy of Koron"),
	CARAMELLA_CANDY_BAG = Isaac.GetTrinketIdByName("Caramella Candy Bag"),
	PINK_FORK = Isaac.GetTrinketIdByName("Pink Fork"),

	HIGHEST_ID = Isaac.GetTrinketIdByName("Sigil of Kaguya"),

	-- Cursed Trinkets
	CORRUPTED_CLOVER = Isaac.GetTrinketIdByName("Corrupted Clover"),
	DARK_PENDANT = Isaac.GetTrinketIdByName("Dark Pendant"),
	BROKEN_NECKLACE = Isaac.GetTrinketIdByName("Broken Necklace"),
	LEAF_NEEDLE = Isaac.GetTrinketIdByName("Leaf Needle"),
	RICHERS_HAIR = Isaac.GetTrinketIdByName("Richer's Hair"),
	RIRAS_HAIR = Isaac.GetTrinketIdByName("Rira's Hair"),
	SPY_EYE = Isaac.GetTrinketIdByName("Spy Eye"),
	FADED_MARK = Isaac.GetTrinketIdByName("Faded Mark"),
	NEVERLASTING_BUNNY = Isaac.GetTrinketIdByName("Neverlasting Bunny"),
	RIBBON_CAGE = Isaac.GetTrinketIdByName("Ribbon Cage"),
	RIRAS_WORST_NIGHTMARE = Isaac.GetTrinketIdByName("Rira's Worst Nightmare"),
	MASKED_SHOVEL = Isaac.GetTrinketIdByName("Masked Shovel"),
	BROKEN_WATCH_2 = Isaac.GetTrinketIdByName("Broken Watch 2"),
	ROUND_AND_ROUND = Isaac.GetTrinketIdByName("Round and Round"),
	GEHENNA_ROCK = Isaac.GetTrinketIdByName("Gehenna Rock"),
	BROKEN_MURASAME = Isaac.GetTrinketIdByName("Broken Murasame"),
	LUNATIC_CRYSTAL = Isaac.GetTrinketIdByName("Lunatic Crystal"),
	TORN_PAPER_2 = Isaac.GetTrinketIdByName("Torn Paper 2"),
	MINI_TORIZO = Isaac.GetTrinketIdByName("Mini Torizo"),
	GRENADE_D20 = Isaac.GetTrinketIdByName("Grenade D20"),
	WAKABA_SIREN = Isaac.GetTrinketIdByName("Wakaba Siren"),
}

--[[
wakaba.Enums.Trackers = {
	WOMB = Isaac.GetTrinketIdByName("WAKABA_WOMB_TRACKER"), -- Determine achievements
	HUSH = Isaac.GetTrinketIdByName("WAKABA_HUSH_TRACKER"), -- Determine overall Void Portals
	DELIRIUM = Isaac.GetTrinketIdByName("WAKABA_DELIRIUM_TRACKER"), -- Determine Delirium beaten
	DADS_KEY = Isaac.GetTrinketIdByName("WAKABA_DADS_KEY_TRACKER"), -- Determine Mega Satan
	MEGA_SATAN = Isaac.GetTrinketIdByName("WAKABA_MEGA_SATAN_TRACKER"), -- Determine Apollyon
	SECRET_EXIT = Isaac.GetTrinketIdByName("WAKABA_SECRET_EXIT_TRACKER"), -- Determine Mother
	JACOB_ESAU = Isaac.GetTrinketIdByName("WAKABA_JACOB_ESAU_TRACKER"), -- Determine Beast
	RED_KEY = Isaac.GetTrinketIdByName("WAKABA_RED_KEY_TRACKER"), -- Determine Cracked Key
	BEAST = Isaac.GetTrinketIdByName("WAKABA_BEAST_TRACKER"), -- Determine Beast Beaten

	LUCKY_PENNY = Isaac.GetTrinketIdByName("WAKABA_LUCKY_PENNY_TRACKER"),
	GOLDEN_PENNY = Isaac.GetTrinketIdByName("WAKABA_GOLDEN_PENNY_TRACKER"),
	GOLDEN_BOMB = Isaac.GetTrinketIdByName("WAKABA_GOLDEN_BOMB_TRACKER"),
}
 ]]

-- 와카바 모드 특수효과
wakaba.Enums.Effects = {
	POWER_BOMB = Isaac.GetEntityVariantByName("Wakaba Power Bomb Explosion"),
	MURASAME_SHIFT = Isaac.GetEntityVariantByName("Murasame Shift Effect"),
	--MAGMA_BLADE = Isaac.GetEntityVariantByName("Magma Blade Effect"),

}

-- 와카바 모드 기타 픽업
wakaba.Enums.Pickups = {
	CLOVER_CHEST = Isaac.GetEntityVariantByName("Clover Chest"),

	WAKABA_ITEM_SPAWNER = Isaac.GetEntityVariantByName("Wakaba Item Spawner"),
	WAKABA_TRINKET_SPAWNER = Isaac.GetEntityVariantByName("Wakaba Trinket Spawner"),
	WAKABA_TICKET_SPAWNER = Isaac.GetEntityVariantByName("Wakaba Ticket Spawner"),

	WINTER_ALBIREO_EXTRA_SPAWNER = Isaac.GetEntityVariantByName("Wakaba Winter Albireo Extra Spawner"),
}

-- 와카바 모드 특수 장애물
wakaba.Enums.GridVars = {
	--[[
		Question Block
	 ]]
	QUESTION_BLOCK = 1983,
	--[[
		Bocchi the Rock
	 ]]
	BOCCHI_THE_ROCK = 221,
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
	SOUL_RICHER = Isaac.GetCardIdByName("Soul of Richer"),
	SOUL_RIRA = Isaac.GetCardIdByName("Soul of Rira"),
	CARD_VALUT_RIFT = Isaac.GetCardIdByName("wakaba_Valut Rift"),
	CARD_TRIAL_STEW = Isaac.GetCardIdByName("wakaba_Trial Stew"),
	CARD_RICHER_TICKET = Isaac.GetCardIdByName("wakaba_Richer Ticket"),
	CARD_RIRA_TICKET = Isaac.GetCardIdByName("wakaba_Rira Ticket"),
	CARD_FLIP = Isaac.GetCardIdByName("wakaba_Flip"),

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
	PRIEST_BLESSING = Isaac.GetPillEffectByName("Priest's Blessing"),
	UNHOLY_CURSE = Isaac.GetPillEffectByName("Unholy Curse"),
	HEAVY_MASCARA = Isaac.GetPillEffectByName("Heavy Mascara"),
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
	CHIMAKI_MAIN = Isaac.GetSoundIdByName("chimaki_main"),
	CHIMAKI_KYUU = Isaac.GetSoundIdByName("chimaki_rand"),
	CHIMAKI_TRIPLE = Isaac.GetSoundIdByName("chimaki_triple"),
	CHIMAKI_HURT = Isaac.GetSoundIdByName("chimaki_hurt"),
	CHIMAKI_KYUU_QUESTION = Isaac.GetSoundIdByName("chimaki_question"),

	RICHER_HURT = Isaac.GetSoundIdByName("richer_hurt"),
	RICHER_DEATH = Isaac.GetSoundIdByName("richer_death"),

	RICHER_ITEM_RABBIT_RIBBON = Isaac.GetSoundIdByName("richer_item_rabbitribbon"),
	RICHER_ITEM_CARAMELLA_PANCAKE = Isaac.GetSoundIdByName("richer_item_caramellapancake"),
	RICHER_ITEM_SWEETS_CATALOG = Isaac.GetSoundIdByName("richer_item_sweetscatalog"),
	RICHER_ITEM_RICHER_UNIFORM = Isaac.GetSoundIdByName("richer_item_richeruniform"),
	RICHER_HAZUKASHI_STRONG = Isaac.GetSoundIdByName("richer_hazukashi_strong"),
	RICHER_ITEM_LIL_RICHER = Isaac.GetSoundIdByName("richer_item_lilricher"),

	RIRA_HURT = Isaac.GetSoundIdByName("rira_hurt"),
	RIRA_DEATH = Isaac.GetSoundIdByName("rira_death"),

	RIRA_ITEM_RIRA_UNIFORM = Isaac.GetSoundIdByName("rira_item_rirauniform"),
	RIRA_ITEM_RIRA_SWIMSUIT = Isaac.GetSoundIdByName("rira_item_riraswimsuit"),
	RIRA_HAZUKASHI_STRONG = Isaac.GetSoundIdByName("rira_hazukashi_strong"),
}

-- 와카바 모드 거지/슬롯류 : SlotVariant 위치에 사용
wakaba.Enums.Slots = {
	SHIORI_VALUT = Isaac.GetEntityVariantByName("Shiori Valut"),
	CRYSTAL_RESTOCK = Isaac.GetEntityVariantByName("Richer's Crystal Restock"),
	RABBEY_WARD = Isaac.GetEntityVariantByName("Rira's Rabbey Ward"),
	--SHRINE_BEGGAR = Isaac.GetEntityVariantByName("Shrine Beggar")
}

wakaba.Enums.ShioriValutSubType = {
	SHIORI = 0,
	BOOKS = 1,
}

-- 크리스탈 리스톡 타입
wakaba.Enums.CrystalRestockSubType = {
	NORMAL = 0, -- 일반형 (3회)
	RED = 1, -- 빨간색 (4회)
	GREEN = 2, -- 초록색 (2회)
	PRESTIGE = 3, -- Prestige Pass 아이템으로 소환 (2회)
	RICHER = 3, -- 리셰 타입, PRESTIGE 값과 동일 (2회)
	RIRA = 4, -- 리라 타입 (5회)
	YELLOW = 5, -- 노란색 (5회)
}

-- 크리스탈 리스톡 타입, 값은 리롤 가능 횟수
wakaba.Enums.CrystalRestockTypes = {
	[wakaba.Enums.CrystalRestockSubType.NORMAL] = 3,
	[wakaba.Enums.CrystalRestockSubType.RED] = 4,
	[wakaba.Enums.CrystalRestockSubType.GREEN] = 2,
	[wakaba.Enums.CrystalRestockSubType.PRESTIGE] = 2,
	[wakaba.Enums.CrystalRestockSubType.RIRA] = 5,
	[wakaba.Enums.CrystalRestockSubType.YELLOW] = 5,
}

wakaba.Enums.RicherUniformMode = {
	NULL = RoomType.ROOM_NULL,
	DEFAULT = RoomType.ROOM_DEFAULT,
	SHOP = RoomType.ROOM_SHOP,
	ERROR = RoomType.ROOM_ERROR,
	TREASURE = RoomType.ROOM_TREASURE,
	BOSS = RoomType.ROOM_BOSS,
	MINIBOSS = RoomType.ROOM_MINIBOSS,
	SECRET = RoomType.ROOM_SECRET,
	SUPERSECRET = RoomType.ROOM_SUPERSECRET,
	ARCADE = RoomType.ROOM_ARCADE,
	CURSE = RoomType.ROOM_CURSE,
	CHALLENGE = RoomType.ROOM_CHALLENGE,
	LIBRARY = RoomType.ROOM_LIBRARY,
	SACRIFICE = RoomType.ROOM_SACRIFICE,
	DEVIL = RoomType.ROOM_DEVIL,
	ANGEL = RoomType.ROOM_ANGEL,
	DUNGEON = RoomType.ROOM_DUNGEON,
	BOSSRUSH = RoomType.ROOM_BOSSRUSH,
	ISAACS = RoomType.ROOM_ISAACS,
	BARREN = RoomType.ROOM_BARREN,
	CHEST = RoomType.ROOM_CHEST,
	DICE = RoomType.ROOM_DICE,
	BLACK_MARKET = RoomType.ROOM_BLACK_MARKET,
	GREED_EXIT = RoomType.ROOM_GREED_EXIT,
	PLANETARIUM = RoomType.ROOM_PLANETARIUM,
	BLUE = RoomType.ROOM_BLUE,
	ULTRASECRET = RoomType.ROOM_ULTRASECRET,
	START_ROOM = 30,
	BEAST = 31,
	OBSERVERATORY = 32,
	TAINTED_TREASURE = 33,
	ABANDONED_PLANETARIUM = 34,
	HEAVEN_CHALLENGE = 35,
}

-- 와카바 특수 자폭파리 타입
---@class WakabaFlySubType
wakaba.Enums.Flies = {
	RICHER = 401, -- 리셰, 일반형
	RIRA = 402, -- 리라, 레이저형
	CIEL = 403, -- 시엘, 폭발형
	KORON = 404, -- 코론,
}

wakaba.Enums.FlyDamageMult = {
	[wakaba.Enums.Flies.RICHER] = 3,
	[wakaba.Enums.Flies.RIRA] = 1,
	[wakaba.Enums.Flies.CIEL] = 5,
	[wakaba.Enums.Flies.KORON] = 1.5,
}

wakaba.Spawner = {}
wakaba.Spawner.PocketItemLookup = {
	[1] = wakaba.Enums.Cards.CARD_MINERVA_TICKET,
	[2] = wakaba.Enums.Cards.CARD_CRANE_CARD,
	[3] = wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,
	[4] = wakaba.Enums.Cards.CARD_DREAM_CARD,
	[5] = wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK,
	[6] = wakaba.Enums.Cards.CARD_VALUT_RIFT,
	[7] = wakaba.Enums.Cards.CARD_TRIAL_STEW,
}

wakaba.Magnet = {}
wakaba.Magnet.PB = {
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_COIN end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_BOMB end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_KEY end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_HEART end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_CHEST end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_ETERNALCHEST end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_GRAB_BAG end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_LOCKEDCHEST end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_MIMICCHEST end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_OLDCHEST end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_PILL end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_POOP end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_REDCHEST end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_SPIKEDCHEST end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_TAROTCARD end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_TRINKET end,
	function(pickup) return pickup.Variant == PickupVariant.PICKUP_WOODENCHEST end,
}

wakaba.RoomTypes = {
	WINTER_ALBIREO = 0,
}

-- 행운 관련 상수
wakaba.Enums.Chances = {

	LUCK_TYPE_SCALE = 1, -- 럭비례 : 비례형
	LUCK_TYPE_REVERSE = 2, -- 럭비례 : 반비례형

	AURORA_DEFAULT = 6.66, -- 오로라 : 동전을 이스터에그로 바꿀 기본 확률
	AURORA_LUCK = 1, -- 오로라 : 럭 1당 동전을 이스터에그로 바꿀 추가 확률
	AURORA_MAX = 100, -- 오로라 : 동전을 이스터에그로 바꿀 최대 확률

	AQUA_TRINKET_DEFAULT = 0.05,
	AQUA_TRINKET_LUCK = 0.05,
	AQUA_TRINKET_MAX = 1,
}

wakaba.Enums.Constants = {
	WAKABA_UNIFORM_MAX_SLOTS = 3, --와카바의 교복 최대 슬롯 수

	CLOVER_CHEST_SPAWN_CHANCE = 0.05, -- 클로버 상자 소환 확률 (일반 상자 교체)
	CLOVER_CHEST_COLLECTIBLE_CHANCE = 0.15, -- 클로버 상자 아이템 드랍 확률

	STACK_STRENGTH_SUPER = 2.0, -- 중첩 효과 극강
	STACK_STRENGTH_HIGH = 1.0, -- 중첩 효과 강
	STACK_STRENGTH_MEDIUM = 0.5, -- 중첩 효과 중
	STACK_STRENGTH_LOW = 0.25, -- 중첩 효과 약
	STACK_STRENGTH_MIN = 0.1, -- 중첩 효과 미약
	STACK_STRENGTH_NONE = -1, -- 중첩 효과 없음

	PONY_COOLDOWN = 720, -- 러쉬 챌린지 화이트 포니 쿨타임
	MAX_TRAUMA_COUNT = 7, -- 트라우마 책 최대 폭발 수
	FALLEN_AFTER_TIMER = 10, -- 부활 후 타락책 유령 지속시간
	FALLEN_AFTER_BASE_COUNT = 10, -- 부활 후 타락책 유령 소환 수
	FALLEN_AFTER_DMG_THRESHOLD = 5,
	FALLEN_BEFORE_BASE_COUNT = 3, -- 부활 전 타락책 유령 소환 수

	MAX_CONCENTRATION_SPEED_THRESHOLD = 120, -- 추가 집중 시간 패널티 상한 스택
	MAX_CONCENTRATION_COUNT_TSUKASA = 60, -- 집중 스택 최대 제한 수 (츠카사)
	MAX_CONCENTRATION_COUNT = 300, -- 집중 스택 최대 제한 수

	RED_CORRUPTION_BASE_CHANCE = 0.46, -- 적색 감염 레드방 생성 기본 확률
	RED_CORRUPTION_PAR_LUCK = 29, -- 적색 감염 레드방 100% 확률 행운 수치

	ELIXIR_MAX_COOLDOWN = 16, -- 생명의 비약 반칸 회복 당 프레임 수
	ELIXIR_MAX_COOLDOWN_DMG = 50, -- 생명의 비약 피격 직후 회복에 필요한 프레임 수
	ELIXIR_MAX_COOLDOWN_KEEPER = 360, -- 생명의 비약 피격 직후 회복에 필요한 프레임 수 (키퍼, 로스트)

	SOUL_OF_TSUKASA_MINIMUM_TIMER = 30 * 60 * 10, -- 츠카사의 영혼 최소 보존 시간
	SOUL_OF_TSUKASA_EXTEND_TIMER = 30 * 60 * 5, -- 츠카사의 영혼 중복 사용 시 추가 제공 최소 시간

	RABBIT_RIBBON_BASIC_CHARGES = 12, -- 토끼 리본 기본 보존 충전량
	RABBIT_RIBBON_EXTRA_CHARGES = 4, -- 토끼 리본 중첩 당 추가 보존 충전량

	RABBIT_RIBBON_BASIC_CHARGES_LUNATIC = 4, -- 토끼 리본 기본 보존 충전량
	RABBIT_RIBBON_EXTRA_CHARGES_LUNATIC = 2, -- 토끼 리본 중첩 당 추가 보존 충전량

	LIL_RICHER_BASIC_CHARGES = 8, -- 리틀 리셰 기본 보존 충전량
	LIL_RICHER_EXTRA_CHARGES = 4, -- 리틀 리셰 중첩 당 추가 보존 충전량
	LIL_RICHER_BASIC_DMG = 1, -- 리틀 리셰 기본 눈물 배수
	LIL_RICHER_BASIC_COOLDOWN = 36, -- 리틀 리셰 눈물 쿨타임(프레임)

	LIL_RICHER_BASIC_CHARGES_LUNATIC = 3, -- 리틀 리셰 기본 보존 충전량
	LIL_RICHER_EXTRA_CHARGES_LUNATIC = 1, -- 리틀 리셰 중첩 당 추가 보존 충전량

	SELF_BURNING_DAMAGE_TIMER = 300, -- 셀프 버닝 체력 차감 쿨타임

	RICHER_B_HUD_LIMIT = 6, -- 알트 리셰 표시 아이템 수
	RICHER_B_HUD_OFFSET = 20, -- 알트 리셰 HUD 오프셋 (EID 지원용)

	SOUL_OF_RICHER_WISP_COUNT = 6,
	SOUL_OF_RICHER_WISP_COUNT_CLEAR_RUNE = 3,

	SOUL_OF_RIRA_AQUA_TRINKET_COUNT = 3,
	SOUL_OF_RIRA_AQUA_TRINKET_COUNT_CLEAR_RUNE = 1,

	REPORT_CARD_BASE_LUCK = 0,
	REPORT_CARD_EXTRA_LUCK = 5,

	RIRA_BANDAGE_BASE = 4,
	RIRA_BANDAGE_EXTRA = 2,

	RABBEY_WARD_RADIUS = 3, -- 토끼 와드 맵 밝히는 반경
	RABBEY_WARD_EXTRA_RADIUS = 1, -- 토끼 와드 맵 밝히는 추가 반경

	MAGNET_HEAVEN_TIMER = 150,

	MAX_ISEKAI_CLOTS = 10, -- 이세계 정의서 소환 제한
	MAX_ISEKAI_CLOTS_LUNATIC = 4, -- 이세계 정의서 소환 제한
	ISEKAI_CERTIFICATE_CHANCE = 50, -- 이세계 사증 이스터에그 확률 (0.1% 단위)
	ISEKAI_SHIORI_BONUS = 400, -- 이세계 사증 시오리 확률 보너스
	ISEKAI_OVER_CLOT_BONUS = 250, -- 이세계 사증 최대 소환 확률 보너스

	DIMENSION_CUTTER_RATE = 15, -- 차원검 장신구 델리 보스 소환 확률
	DIMENSION_CUTTER_GREED_MIN_RATE = 5, -- 차원검 장신구 델리 보스 소환 확률 (그리드 최소)
	DIMENSION_CUTTER_GREED_LUCK_RATE = 2, -- 차원검 장신구 델리 보스 소환 확률 (그리드 럭 1당 추가 확률)
	DIMENSION_CUTTER_GREED_MAX_RATE = 25, -- 차원검 장신구 델리 보스 소환 확률 (그리드 최대)

	SSRC_ALLOW_FLAMES = 8, -- 초민감 리셰 챌린지 최대 흡수 제한
}

wakaba.Colors = {

	NERF_WEAPON_COLOR = Color(0.5, 0.1, 0.8, 1),
	NERF_LASER_COLOR = Color(0.5, 0.1, 0.8, 1, 0.5, 0.1, 0.8),

	STATIC_WEAPON_COLOR = Color(0.5, 0.1, 0.8, 1),
	STATIC_LASER_COLOR = Color(0.5, 0.1, 0.8, 1, 0.5, 0.1, 0.8),

	AQUA_ENTITY_COLOR = Color(0.5, 0.52, 0.75, 1),
	AQUA_WEAPON_COLOR = Color(0.5, 0.66, 1, 1),
	AQUA_FART_COLOR = Color(0.7, 0.7, 0.7, 1, 0, 0, 0.5),
	AQUA_LASER_COLOR = Color(0.5, 0.7, 0.8, 1, 0.5, 0.7, 0.8),

	FLOOD_ENTITY_COLOR = Color(0.8, 0.5, 0.9, 1),
	FLOOD_WEAPON_COLOR = Color(0.5, 0.1, 0.8, 1),
	FLOOD_LASER_COLOR = Color(0.5, 0.1, 0.8, 1, 0.5, 0.1, 0.8),

	ZIPPED_ENTITY_COLOR = Color(0.7, 0.4, 0.5, 1),
	ZIPPED_WEAPON_COLOR = Color(0.7, 0.4, 0.5, 1),
	ZIPPED_LASER_COLOR = Color(0.7, 0.4, 0.5, 1, 0.7, 0.4, 0.5),

	EXECUTE_ENTITY_COLOR = Color(0.7, 0.4, 0.5, 1),
	EXECUTE_WEAPON_COLOR = Color(0.7, 0.4, 0.5, 1),
	EXECUTE_LASER_COLOR = Color(0.7, 0.4, 0.5, 1, 0.7, 0.4, 0.5),
}

wakaba.ValidCustomStat = {
	"damage",
	"tears",
	"range",
	"luck",
	"speed",
	"shotspeed",
	"hairpinluck",
	"falsedamage",
	"damagemult",
	"tearsmult",
	"rangemult",
	"luckmult",
	"speedmult",
	"shotspeedmult",
}

wakaba.GoldenTrinketData = {
	[wakaba.Enums.Trinkets.BRING_ME_THERE] = 1.5,
	[wakaba.Enums.Trinkets.CLOVER] = {t={0.3, 2}, append = true},
	[wakaba.Enums.Trinkets.HARD_BOOK] = {mult=3, findReplace = true},
	[wakaba.Enums.Trinkets.DETERMINATION_RIBBON] = {t={2}, mults={0.5}},
	[wakaba.Enums.Trinkets.RING_OF_JUPITER] = 9999,
	[wakaba.Enums.Trinkets.DIMENSION_CUTTER] = 1,
	--[wakaba.Enums.Trinkets.DELIMITER] = 1,
	[wakaba.Enums.Trinkets.RANGE_OS] = 1,
	[wakaba.Enums.Trinkets.STAR_REVERSAL] = {goldenOnly = true, mult=2, findReplace = true},
	[wakaba.Enums.Trinkets.AURORA_GEM] = 6.66,
	[wakaba.Enums.Trinkets.MISTAKE] = {t={100,185}},
	[wakaba.Enums.Trinkets.KUROMI_CARD] = {t={90}, mults={8/9,7/9}},
	[wakaba.Enums.Trinkets.ETERNITY_COOKIE] = {append = true},
	[wakaba.Enums.Trinkets.MAGNET_HEAVEN] = {append = true},
	[wakaba.Enums.Trinkets.REPORT_CARD] = 5,
	[wakaba.Enums.Trinkets.CANDY_OF_RICHER] = {findReplace = true},
	[wakaba.Enums.Trinkets.CANDY_OF_RIRA] = {findReplace = true},
	[wakaba.Enums.Trinkets.CANDY_OF_CIEL] = {findReplace = true},
	[wakaba.Enums.Trinkets.CANDY_OF_KORON] = {findReplace = true},
}

wakaba.RoomIDs = {
	-- Treasure Rooms given by Rabbit Ribbon
	MIN_RABBEY_TREASURE_ROOM_ID = 41000,
	MAX_RABBEY_TREASURE_ROOM_ID = 41036,

	-- Shops given by Rabbit Ribbon
	MIN_RABBEY_SHOP_ROOM_ID = 41003,
	MAX_RABBEY_SHOP_ROOM_ID = 41005,

	-- Libraries given by Book of Shiori
	MIN_SHIORI_LIBRARY_ROOM_ID = 41000,
	MAX_SHIORI_LIBRARY_ROOM_ID = 41021,

	-- Angel rooms replaced by Wakaba Rooms

	-- Planetariums replaced by Duet Rooms
	MIN_DUET_ROOM_ID = 41701,
	MAX_DUET_ROOM_ID = 41701,

	--[[
		Planetariums replaced by Richer Rooms
		Subtype 41 : normal
		Subtype 42 : double
	]]
	MIN_RICHER_ROOM_ID = 41001,
	MAX_RICHER_ROOM_ID = 41031,

	--[[
		Dice Rooms replaced by Rira Rooms
		Subtype 41 : normal
		Subtype 42 : double
	]]
	MIN_RIRA_ROOM_ID = 41201,
	MAX_RIRA_ROOM_ID = 41201,
}

wakaba.ManaOffsets = {
	[1] = {
		Offset = Vector(45, 40),
		AnchorOffset = function()
			return ScreenHelper.GetScreenTopLeft(Options.HUDOffset*10)
		end,
		Direction = Direction.RIGHT,
	},
	[2] = {
		Offset = Vector(-88, 62),
		AnchorOffset = function()
			return ScreenHelper.GetScreenTopRight(Options.HUDOffset*10)
		end,
		Direction = Direction.LEFT,
	},
	[3] = {
		Offset = Vector(45, -40),
		AnchorOffset = function()
			return ScreenHelper.GetScreenBottomLeft(Options.HUDOffset*10)
		end,
		Direction = Direction.RIGHT,
	},
	[4] = {
		Offset = Vector(-80, -40),
		AnchorOffset = function()
			return ScreenHelper.GetScreenBottomRight(Options.HUDOffset*10)
		end,
		Direction = Direction.LEFT,
	},
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
	FlashMurasameKnife = {
		--knifeGfx = "gfx/wakaba_magmablade.anm2",
		knifeVariant = 2,
		knifeSubType = 4,
		sizeMulti = 1.8,
		collisionMulti = 1.8,
		tearFlags = TearFlags.TEAR_ACID,
	},
	FlashMurasameSpirit = {
		--knifeGfx = "gfx/wakaba_magmablade.anm2",
		knifeVariant = 10,
		knifeSubType = 4,
		sizeMulti = 2.5,
		collisionMulti = 2.5,
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

wakaba.Blacklists = {}
wakaba.Blacklists.Uniform = {}
wakaba.Blacklists.Uniform.Cards = {
	Card.CARD_ANCIENT_RECALL,
	Card.CARD_WILD,
	Card.CARD_QUESTIONMARK,
	wakaba.Enums.Cards.CARD_COLOR_JOKER,
}
wakaba.Blacklists.Uniform.PillEffect = {
	PillEffect.PILLEFFECT_VURP,
}
wakaba.Blacklists.Uniform.PillColor = {
	PillColor.PILL_GOLD,
}
wakaba.Blacklists.AquaTrinkets = {
	TrinketType.TRINKET_PERFECTION,
}

wakaba.Blacklists.FullReroll = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = true,
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = true,
	[wakaba.Enums.Collectibles.RICHERS_BRA] = true,
	[wakaba.Enums.Collectibles.MINERVA_AURA] = true,
}

wakaba.Blacklists.GambleRun = {
	[CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS] = true,
	[CollectibleType.COLLECTIBLE_DAMOCLES] = true,
	[CollectibleType.COLLECTIBLE_ETERNAL_D6] = true,
	[CollectibleType.COLLECTIBLE_CROOKED_PENNY] = true,
	[CollectibleType.COLLECTIBLE_TMTRAINER] = true,
	[CollectibleType.COLLECTIBLE_EVERYTHING_JAR] = true,
	[CollectibleType.COLLECTIBLE_GLITCHED_CROWN] = true,
	[CollectibleType.COLLECTIBLE_BINGE_EATER] = true,
	[CollectibleType.COLLECTIBLE_MOVING_BOX] = true,
	[CollectibleType.COLLECTIBLE_VOID] = true,
	[wakaba.Enums.Collectibles.EATHEART] = true,
	[wakaba.Enums.Collectibles.RICHERS_UNIFORM] = true,
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = true,
}

wakaba.Weights = {}
wakaba.Weights.LilMoeTearFlags = {
	{TearFlags.TEAR_NORMAL, 00.00}, -- example
	{TearFlags.TEAR_SPECTRAL, 01.00},
	{TearFlags.TEAR_PIERCING, 01.00},
	{TearFlags.TEAR_SLOW, 01.00},
	{TearFlags.TEAR_POISON, 01.00},
	{TearFlags.TEAR_FREEZE, 01.00},
	{TearFlags.TEAR_SPLIT, 01.00},
	{TearFlags.TEAR_GROW, 01.00},
	{TearFlags.TEAR_BOOMERANG, 01.00},
	{TearFlags.TEAR_PERSISTENT, 01.00},
	{TearFlags.TEAR_WIGGLE, 01.00},
	{TearFlags.TEAR_MULLIGAN, 01.00},
	{TearFlags.TEAR_CHARM, 01.00},
	--{TearFlags.TEAR_CONFUSION, 01.00},
	{TearFlags.TEAR_PERMANENT_CONFUSION, 01.00},
	{TearFlags.TEAR_QUADSPLIT, 01.00},
	{TearFlags.TEAR_BOUNCE, 01.00},
	{TearFlags.TEAR_FEAR, 01.00},
	{TearFlags.TEAR_PULSE, 01.00},
	{TearFlags.TEAR_GLOW, 01.00},
	{TearFlags.TEAR_MYSTERIOUS_LIQUID_CREEP, 01.00},
	{TearFlags.TEAR_SHIELDED, 01.00},
	{TearFlags.TEAR_CONTINUUM, 01.00},
	{TearFlags.TEAR_LIGHT_FROM_HEAVEN, 01.00},
	{TearFlags.TEAR_GREED_COIN, 01.00},
	{TearFlags.TEAR_BONE, 01.00},
	{TearFlags.TEAR_NEEDLE, 01.00},
	{TearFlags.TEAR_JACOBS, 01.00},
	{TearFlags.TEAR_POP, 01.00},
	{TearFlags.TEAR_ABSORB, 01.00},
	{TearFlags.TEAR_LASERSHOT, 01.00},
	{TearFlags.TEAR_HYDROBOUNCE, 01.00},
	{TearFlags.TEAR_BURSTSPLIT, 01.00},
	{TearFlags.TEAR_CREEP_TRAIL, 01.00},
	{TearFlags.TEAR_ICE, 01.00},
	{TearFlags.TEAR_MAGNETIZE, 01.00},
	{TearFlags.TEAR_BAIT, 01.00},
	{TearFlags.TEAR_BACKSTAB, 01.00},

	{TearFlags.TEAR_HP_DROP, 00.50},
	{TearFlags.TEAR_BLACK_HP_DROP, 00.50},
	{TearFlags.TEAR_COIN_DROP, 00.50},
	{TearFlags.TEAR_BOOGER, 00.50},
	{TearFlags.TEAR_EGG, 00.50},
	{TearFlags.TEAR_MIDAS, 00.50},
	{TearFlags.TEAR_HORN, 00.50},
	{TearFlags.TEAR_COIN_DROP_DEATH, 00.50},
	{TearFlags.TEAR_SPORE, 00.50},
	{TearFlags.TEAR_CARD_DROP_DEATH, 00.50},
	{TearFlags.TEAR_RUNE_DROP_DEATH, 00.50},
}
wakaba.Weights.LilMoeTearVariants = {
	{TearVariant.BLUE, 00.00}, -- example

	{TearVariant.BLUE, 13.00},

	{TearVariant.BLOOD, 01.00},
	{TearVariant.TOOTH, 01.00},
	{TearVariant.METALLIC, 01.00},
	{TearVariant.DARK_MATTER, 01.00},
	{TearVariant.MYSTERIOUS, 01.00},
	{TearVariant.SCHYTHE, 01.00},
	{TearVariant.LOST_CONTACT, 01.00},
	{TearVariant.DIAMOND, 01.00},
	{TearVariant.COIN, 01.00},
	{TearVariant.MULTIDIMENSIONAL, 01.00},
	{TearVariant.RAZOR, 01.00},
	{TearVariant.BONE, 01.00},
	{TearVariant.BLACK_TOOTH, 01.00},
	{TearVariant.NEEDLE, 01.00},
	{TearVariant.BELIAL, 01.00},
	{TearVariant.HUNGRY, 01.00},
	{TearVariant.ICE, 01.00},
	{TearVariant.KEY, 01.00},
	{TearVariant.KEY_BLOOD, 01.00},
	{TearVariant.SWORD_BEAM, 01.00},
	{TearVariant.SPORE, 01.00},
	{TearVariant.TECH_SWORD_BEAM, 01.00},
}

-- Clover Chest entries. Contains the mod dev's favorite
wakaba.Weights.CloverChest = {
	--{CollectibleType.COLLECTIBLE_BIBLE, 1.00},
	{CollectibleType.COLLECTIBLE_SPOON_BENDER, 1.00},
	{CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM, 0.10},
	{CollectibleType.COLLECTIBLE_COMPASS, 1.00},
	{CollectibleType.COLLECTIBLE_TREASURE_MAP, 1.00},
	{CollectibleType.COLLECTIBLE_BLUE_MAP, 1.00},
	{CollectibleType.COLLECTIBLE_LUCKY_FOOT, 1.00},
	{CollectibleType.COLLECTIBLE_PHD, 1.00},
	{CollectibleType.COLLECTIBLE_XRAY_VISION, 1.00},
	{CollectibleType.COLLECTIBLE_SPELUNKER_HAT, 1.00},
	{CollectibleType.COLLECTIBLE_MOMS_KEY, 1.00},
	{CollectibleType.COLLECTIBLE_HUMBLEING_BUNDLE, 1.00},
	{CollectibleType.COLLECTIBLE_FANNY_PACK, 1.00},
	{CollectibleType.COLLECTIBLE_GNAWED_LEAF, 1.00},
	{CollectibleType.COLLECTIBLE_PIGGY_BANK, 1.00},
	{CollectibleType.COLLECTIBLE_STOP_WATCH, 1.00},
	{CollectibleType.COLLECTIBLE_STARTER_DECK, 1.00},
	{CollectibleType.COLLECTIBLE_LITTLE_BAGGY, 1.00},
	{CollectibleType.COLLECTIBLE_BROKEN_WATCH, 1.00},
	{CollectibleType.COLLECTIBLE_MAGIC_FINGERS, 1.00},
	{CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS, 1.00},
	{CollectibleType.COLLECTIBLE_LIL_CHEST, 1.00},
	{CollectibleType.COLLECTIBLE_EDENS_BLESSING, 1.00},
	{CollectibleType.COLLECTIBLE_D7, 1.00},
	{CollectibleType.COLLECTIBLE_DOG_TOOTH, 1.00},
	{CollectibleType.COLLECTIBLE_TAROT_CLOTH, 1.00},
	{CollectibleType.COLLECTIBLE_DADS_LOST_COIN, 1.00},
	{CollectibleType.COLLECTIBLE_D1, 1.00},
	{CollectibleType.COLLECTIBLE_SMELTER, 1.00},
	{CollectibleType.COLLECTIBLE_DULL_RAZOR, 1.00},
	{CollectibleType.COLLECTIBLE_POTATO_PEELER, 1.00},
	{CollectibleType.COLLECTIBLE_YO_LISTEN, 1.00},
	{CollectibleType.COLLECTIBLE_MOVING_BOX, 1.00},
	{CollectibleType.COLLECTIBLE_MR_ME, 1.00},
	{CollectibleType.COLLECTIBLE_SCHOOLBAG, 1.00},
	{CollectibleType.COLLECTIBLE_MARBLES, 1.00},
	{CollectibleType.COLLECTIBLE_ROCK_BOTTOM, 1.00},
	{CollectibleType.COLLECTIBLE_BIRTHRIGHT, 0.50},
	{CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE, 0.10},
	{CollectibleType.COLLECTIBLE_EVIL_CHARM, 1.00},
	{CollectibleType.COLLECTIBLE_FALSE_PHD, 1.00},
	{CollectibleType.COLLECTIBLE_CARD_READING, 1.00},
	{CollectibleType.COLLECTIBLE_GUPPYS_EYE, 1.00},
	{CollectibleType.COLLECTIBLE_SAUSAGE, 0.80},
	{CollectibleType.COLLECTIBLE_OPTIONS, 1.00},
	{CollectibleType.COLLECTIBLE_THERES_OPTIONS, 1.00},
	{CollectibleType.COLLECTIBLE_MORE_OPTIONS, 1.00},
	{CollectibleType.COLLECTIBLE_CRACKED_ORB, 1.00},
	{CollectibleType.COLLECTIBLE_ECHO_CHAMBER, 1.00},

	{wakaba.Enums.Collectibles.WAKABAS_BLESSING, 0.10},
	{wakaba.Enums.Collectibles.WAKABAS_NEMESIS, 0.10},
	{wakaba.Enums.Collectibles._3D_PRINTER, 1.00},
	{wakaba.Enums.Collectibles.ANTI_BALANCE, 1.00},
	{wakaba.Enums.Collectibles.BEETLEJUICE, 1.00},
	{wakaba.Enums.Collectibles.CONCENTRATION, 1.00},
	{wakaba.Enums.Collectibles.CUNNING_PAPER, 1.00},
	{wakaba.Enums.Collectibles.FIREFLY_LIGHTER, 1.00},
	{wakaba.Enums.Collectibles.FLASH_SHIFT, 1.00},
	{wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD, 1.00},
	{wakaba.Enums.Collectibles.JAR_OF_CLOVER, 0.50},
	{wakaba.Enums.Collectibles.PLUMY, 1.00},
	{wakaba.Enums.Collectibles.PRESTIGE_PASS, 0.10},
	{wakaba.Enums.Collectibles.RABBIT_RIBBON, 1.00},
	{wakaba.Enums.Collectibles.RED_CORRUPTION, 1.00},
	{wakaba.Enums.Collectibles.RICHERS_UNIFORM, 1.00},
	{wakaba.Enums.Collectibles.UNIFORM, 1.00},
	{wakaba.Enums.Collectibles.SECRET_DOOR, 1.00},
}

-- Shiori Valut items. Contains items with blue collectible image.
wakaba.Weights.ShioriValut = {
	{CollectibleType.COLLECTIBLE_INNER_EYE, 1.00},
	{CollectibleType.COLLECTIBLE_TELEPORT, 1.00},
	{CollectibleType.COLLECTIBLE_MINI_MUSH, 1.00},
	{CollectibleType.COLLECTIBLE_FOREVER_ALONE, 1.00},
	{CollectibleType.COLLECTIBLE_RELIC, 1.00},
	{CollectibleType.COLLECTIBLE_BOMB_BAG, 1.00},
	{CollectibleType.COLLECTIBLE_MULLIGAN, 1.00},
	{CollectibleType.COLLECTIBLE_CRYSTAL_BALL, 1.00},
	{CollectibleType.COLLECTIBLE_CANDLE, 1.00},
	{CollectibleType.COLLECTIBLE_POLYPHEMUS, 1.00},
	{CollectibleType.COLLECTIBLE_HOLY_WATER, 1.00},
	{CollectibleType.COLLECTIBLE_FATE, 1.00},
	{CollectibleType.COLLECTIBLE_SPIDERBABY, 1.00},
	{CollectibleType.COLLECTIBLE_ANTI_GRAVITY, 1.00},
	{CollectibleType.COLLECTIBLE_STOP_WATCH, 1.00},
	{CollectibleType.COLLECTIBLE_TRINITY_SHIELD, 1.00},
	{CollectibleType.COLLECTIBLE_BLUE_MAP, 1.00},
	{CollectibleType.COLLECTIBLE_HIVE_MIND, 1.00},
	{CollectibleType.COLLECTIBLE_SISSY_LONGLEGS, 1.00},
	{CollectibleType.COLLECTIBLE_CONVERTER, 1.00},
	{CollectibleType.COLLECTIBLE_BLUE_BOX, 1.00},
	{CollectibleType.COLLECTIBLE_TAURUS, 1.00},
	{CollectibleType.COLLECTIBLE_ARIES, 1.00},
	{CollectibleType.COLLECTIBLE_CANCER, 1.00},
	{CollectibleType.COLLECTIBLE_LEO, 1.00},
	{CollectibleType.COLLECTIBLE_VIRGO, 1.00},
	{CollectibleType.COLLECTIBLE_LIBRA, 1.00},
	{CollectibleType.COLLECTIBLE_SCORPIO, 1.00},
	{CollectibleType.COLLECTIBLE_SAGITTARIUS, 1.00},
	{CollectibleType.COLLECTIBLE_CAPRICORN, 1.00},
	{CollectibleType.COLLECTIBLE_AQUARIUS, 1.00},
	{CollectibleType.COLLECTIBLE_PISCES, 1.00},
	{CollectibleType.COLLECTIBLE_HOLY_MANTLE, 1.00},
	{CollectibleType.COLLECTIBLE_GEMINI, 1.00},
	{CollectibleType.COLLECTIBLE_BLUE_BABYS_ONLY_FRIEND, 1.00},
	{CollectibleType.COLLECTIBLE_ISAACS_TEARS, 1.00},
	{CollectibleType.COLLECTIBLE_BREATH_OF_LIFE, 1.00},
	{CollectibleType.COLLECTIBLE_SOUL, 1.00},
	{CollectibleType.COLLECTIBLE_BROKEN_WATCH, 1.00},
	{CollectibleType.COLLECTIBLE_BOOMERANG, 1.00},
	{CollectibleType.COLLECTIBLE_BLUE_CAP, 1.00},
	{CollectibleType.COLLECTIBLE_FATES_REWARD, 1.00},
	{CollectibleType.COLLECTIBLE_EPIPHORA, 1.00},
	{CollectibleType.COLLECTIBLE_HOLY_LIGHT, 1.00},
	{CollectibleType.COLLECTIBLE_PUPULA_DUPLEX, 1.00},
	{CollectibleType.COLLECTIBLE_TEAR_DETONATOR, 1.00},
	{CollectibleType.COLLECTIBLE_D12, 1.00},
	{CollectibleType.COLLECTIBLE_SERAPHIM, 1.00},
	{CollectibleType.COLLECTIBLE_TRACTOR_BEAM, 1.00},
	{CollectibleType.COLLECTIBLE_EVIL_EYE, 1.00},
	{CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT, 1.00},
	{CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, 1.00},
	{CollectibleType.COLLECTIBLE_NIGHT_LIGHT, 1.00},
	{CollectibleType.COLLECTIBLE_PJS, 1.00},
	{CollectibleType.COLLECTIBLE_PAPA_FLY, 1.00},
	{CollectibleType.COLLECTIBLE_BINKY, 1.00},
	{CollectibleType.COLLECTIBLE_PARASITOID, 1.00},
	{CollectibleType.COLLECTIBLE_GLYPH_OF_BALANCE, 1.00},
	{CollectibleType.COLLECTIBLE_HUSHY, 1.00},
	{CollectibleType.COLLECTIBLE_KING_BABY, 1.00},
	{CollectibleType.COLLECTIBLE_EDENS_SOUL, 1.00},
	{CollectibleType.COLLECTIBLE_JACOBS_LADDER, 1.00},
	{CollectibleType.COLLECTIBLE_SHARP_STRAW, 1.00},
	{CollectibleType.COLLECTIBLE_TELEKINESIS, 1.00},
	{CollectibleType.COLLECTIBLE_TECHNOLOGY_ZERO, 1.00},
	{CollectibleType.COLLECTIBLE_LACHRYPHAGY, 1.00},
	{CollectibleType.COLLECTIBLE_BLANKET, 1.00},
	{CollectibleType.COLLECTIBLE_HALLOWED_GROUND, 1.00},
	{CollectibleType.COLLECTIBLE_120_VOLT, 1.00},
	{CollectibleType.COLLECTIBLE_ALMOND_MILK, 1.00},
	{CollectibleType.COLLECTIBLE_ROCK_BOTTOM, 1.00},
	{CollectibleType.COLLECTIBLE_SOCKS, 1.00},
	{CollectibleType.COLLECTIBLE_DREAM_CATCHER, 1.00},
	{CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES, 1.00},
	{CollectibleType.COLLECTIBLE_SOL, 1.00},
	{CollectibleType.COLLECTIBLE_LUNA, 1.00},
	{CollectibleType.COLLECTIBLE_MERCURIUS, 1.00},
	{CollectibleType.COLLECTIBLE_VENUS, 1.00},
	{CollectibleType.COLLECTIBLE_TERRA, 1.00},
	{CollectibleType.COLLECTIBLE_MARS, 1.00},
	{CollectibleType.COLLECTIBLE_JUPITER, 1.00},
	{CollectibleType.COLLECTIBLE_SATURNUS, 1.00},
	{CollectibleType.COLLECTIBLE_URANUS, 1.00},
	{CollectibleType.COLLECTIBLE_NEPTUNUS, 1.00},
	{CollectibleType.COLLECTIBLE_PLUTO, 1.00},
	{CollectibleType.COLLECTIBLE_EYE_DROPS, 1.00},
	{CollectibleType.COLLECTIBLE_FREEZER_BABY, 1.00},
	{CollectibleType.COLLECTIBLE_GENESIS, 1.00},
	{CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE, 1.00},
	{CollectibleType.COLLECTIBLE_EVIL_CHARM, 1.00},
	{CollectibleType.COLLECTIBLE_STAR_OF_BETHLEHEM, 1.00},
	{CollectibleType.COLLECTIBLE_CUBE_BABY, 1.00},
	{CollectibleType.COLLECTIBLE_REDEMPTION, 1.00},
	{CollectibleType.COLLECTIBLE_SPIRIT_SHACKLES, 1.00},
	{CollectibleType.COLLECTIBLE_SOUL_LOCKET, 1.00},
	{CollectibleType.COLLECTIBLE_SALVATION, 1.00},
	{CollectibleType.COLLECTIBLE_GLASS_EYE, 1.00},

	{wakaba.Enums.Collectibles.BOOK_OF_SHIORI, 1.00},
	{wakaba.Enums.Collectibles.BOOK_OF_THE_GOD, 1.00},
	{wakaba.Enums.Collectibles.D6_PLUS, 1.00},
	{wakaba.Enums.Collectibles.D_CUP_ICECREAM, 1.00},
	{wakaba.Enums.Collectibles.FIREFLY_LIGHTER, 1.00},
	{wakaba.Enums.Collectibles.ISEKAI_DEFINITION, 1.00},
	{wakaba.Enums.Collectibles.SEE_DES_BISCHOFS, 1.00},
	{wakaba.Enums.Collectibles.LIL_SHIVA, 1.00},
	{wakaba.Enums.Collectibles.LUNAR_STONE, 1.00},
	{wakaba.Enums.Collectibles.MINERVA_AURA, 1.00},
	{wakaba.Enums.Collectibles.PHANTOM_CLOAK, 1.00},
	{wakaba.Enums.Collectibles.PRESTIGE_PASS, 1.00},
	{wakaba.Enums.Collectibles.RICHERS_UNIFORM, 1.00},
	{wakaba.Enums.Collectibles.SECRET_DOOR, 1.00},
	{wakaba.Enums.Collectibles.UNIFORM, 1.00},
	{wakaba.Enums.Collectibles.SECRET_CARD, 1.00},
	{wakaba.Enums.Collectibles.WINTER_ALBIREO, 1.00},
}

wakaba.Checks = {}
wakaba.Checks.VanillaStatusEffects = {
	EntityFlag.FLAG_FREEZE,
	EntityFlag.FLAG_POISON,
	EntityFlag.FLAG_SLOW,
	EntityFlag.FLAG_CHARM,
	EntityFlag.FLAG_CONFUSION,
	EntityFlag.FLAG_MIDAS_FREEZE,
	EntityFlag.FLAG_FEAR,
	EntityFlag.FLAG_BURN,
	EntityFlag.FLAG_SHRINK,
	EntityFlag.FLAG_CONTAGIOUS,
	EntityFlag.FLAG_BLEED_OUT,
	EntityFlag.FLAG_ICE,
	EntityFlag.FLAG_MAGNETIZED,
	EntityFlag.FLAG_BAITED,
	EntityFlag.FLAG_WEAKNESS,
	EntityFlag.FLAG_BRIMSTONE_MARKED,
}

wakaba.VanillaPoolDatas = {
	[-1] = {Icon = "{{TreasureRoom}}", StringID = "Default", DoubleDreams = "doubledreams"},
	[0] = {Icon = "{{TreasureRoom}}", StringID = "Treasure", DoubleDreams = "00_treasure"},
	[1] = {Icon = "{{Shop}}", StringID = "Shop", DoubleDreams = "01_shop"},
	[2] = {Icon = "{{BossRoom}}", StringID = "Boss", DoubleDreams = "02_boss"},
	[3] = {Icon = "{{DevilRoom}}", StringID = "Devil", DoubleDreams = "03_devil"},
	[4] = {Icon = "{{AngelRoom}}", StringID = "Angel", DoubleDreams = "04_angel"},
	[5] = {Icon = "{{SecretRoom}}", StringID = "Secret", DoubleDreams = "05_secret"},
	[6] = {Icon = "{{Library}}", StringID = "Library", DoubleDreams = "06_library"},
	[7] = {Icon = "{{Beggar}}{{MiniBossRoom}}", StringID = "ShellGame", DoubleDreams = "doubledreams"},
	[8] = {Icon = "{{GoldenChest}}", StringID = "GoldenChest", DoubleDreams = "08_goldenchest"},
	[9] = {Icon = "{{RedChest}}", StringID = "RedChest", DoubleDreams = "09_redchest"},
	[10] = {Icon = "{{Beggar}}", StringID = "Beggar", DoubleDreams = "doubledreams"},
	[11] = {Icon = "{{DemonBeggar}}", StringID = "DemonBeggar", DoubleDreams = "doubledreams"},
	[12] = {Icon = "{{CurseRoom}}", StringID = "Curse", DoubleDreams = "12_curse"},
	[13] = {Icon = "{{KeyBeggar}}", StringID = "KeyMaster", DoubleDreams = "doubledreams"},
	[14] = {Icon = "{{BatteryBeggar}}", StringID = "BatteryBum", DoubleDreams = "doubledreams"},
	[15] = {Icon = "{{MomBossSmall}}", StringID = "MomChest", DoubleDreams = "doubledreams"},
	[16] = {Icon = "{{GreedModeSmall}}{{TreasureRoom}}", StringID = "GreedTreasure", DoubleDreams = "doubledreams"},
	[17] = {Icon = "{{GreedModeSmall}}{{BossRoom}}", StringID = "GreedBoss", DoubleDreams = "doubledreams"},
	[18] = {Icon = "{{GreedModeSmall}}{{Shop}}", StringID = "GreedShop", DoubleDreams = "doubledreams"},
	[19] = {Icon = "{{GreedModeSmall}}{{DevilRoom}}", StringID = "GreedDevil", DoubleDreams = "doubledreams"},
	[20] = {Icon = "{{GreedModeSmall}}{{AngelRoom}}", StringID = "GreedAngel", DoubleDreams = "doubledreams"},
	[21] = {Icon = "{{GreedModeSmall}}{{CurseRoom}}", StringID = "GreedCurse", DoubleDreams = "doubledreams"},
	[22] = {Icon = "{{GreedModeSmall}}{{SecretRoom}}", StringID = "GreedSecret", DoubleDreams = "doubledreams"},
	[23] = {Icon = "{{CraneGame}}", StringID = "CraneGame", DoubleDreams = "23_cranegame"},
	[24] = {Icon = "{{UltraSecretRoom}}", StringID = "UltraSecret", DoubleDreams = "24_ultrasecret"},
	[25] = {Icon = "{{BombBeggar}}", StringID = "BombBum", DoubleDreams = "doubledreams"},
	[26] = {Icon = "{{Planetarium}}", StringID = "Planetarium", DoubleDreams = "26_planetarium"},
	[27] = {Icon = "{{DirtyChest}}", StringID = "OldChest", DoubleDreams = "doubledreams"},
	[28] = {Icon = "{{Shop}}", StringID = "BabyShop", DoubleDreams = "28_babyshop"},
	[29] = {Icon = "{{WoodenChest}}", StringID = "WoodenChest", DoubleDreams = "doubledreams"},
	[30] = {Icon = "{{RottenBeggar}}", StringID = "RottenBeggar", DoubleDreams = "doubledreams"},
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
	CHALLENGE_EVEN = Isaac.GetChallengeIdByName("[w15] Even or Odd"), --w15
	CHALLENGE_RNPR = Isaac.GetChallengeIdByName("[w16] Runaway Pheromones"), --w16
	CHALLENGE_LAVA = Isaac.GetChallengeIdByName("[w17] The Floor is Lava"), --w17
	--CHALLENGE_GOOM = Isaac.GetChallengeIdByName("[w18] Universe of Goom"), --w18

	CHALLENGE_RAND = Isaac.GetChallengeIdByName("[w98] Hyper Random"), --w98
	CHALLENGE_DRMS = Isaac.GetChallengeIdByName("[w99] True Purist Girl"), --w99
	CHALLENGE_SLNT = Isaac.GetChallengeIdByName("[wb1] Pure Delirium vs Silence"), --wb1
	CHALLENGE_SSRC = Isaac.GetChallengeIdByName("[wb2] Super Sensitive Richer-chan"), --wb2
	CHALLENGE_MELT = Isaac.GetChallengeIdByName("[wb3] Melting Pika Run 2"), --wb3
	CHALLENGE_ANNA = Isaac.GetChallengeIdByName("[wb4] The Maze In My Heart"), --wb4
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

wakaba.KnifeVariant = {
	MOMS_KNIFE 		= 0,
	BONE_CLUB 		= 1,
	BONE_SCYTHE 	= 2,
	DONKEY_JAWBONE 	= 3,
	BAG_OF_CRAFTING = 4,
	SUMPTORIUM 		= 5,
	NOTCHED_AXE	 	= 9,
	SPIRIT_SWORD 	= 10,
	TECH_SWORD 		= 11,
}

wakaba.FIRST_WAKABA_ITEM = wakaba.Enums.Collectibles.WAKABAS_BLESSING
wakaba.LAST_WAKABA_ITEM = wakaba.Enums.Collectibles.WAKABA_DUALITY
wakaba.FIRST_WAKABA_TRINKET = wakaba.Enums.Trinkets.CLOVER
wakaba.LAST_WAKABA_TRINKET = wakaba.Enums.Trinkets.KUROMI_CARD

-- Reserved for popup image
wakaba.achievementsprite = {
	dcupicecream = "gfx/ui/achievement/achievement_wakaba_dcupicecream.png",
	secretcard = "gfx/ui/achievement/achievement_wakaba_secretcard.png",
	pendant = "gfx/ui/achievement/achievement_wakaba_pendant.png",
	clover = "gfx/ui/achievement/achievement_wakaba_clover.png",
	counter = "gfx/ui/achievement/achievement_wakaba_counter.png",
	newyearbomb = "gfx/ui/achievement/achievement_wakaba_newyearbomb.png",
	dreamcard = "gfx/ui/achievement/achievement_wakaba_dreamcard.png",
	donationcard = "gfx/ui/achievement/achievement_wakaba_donationcard.png",
	whitejoker = "gfx/ui/achievement/achievement_wakaba_whitejoker.png",
	revengefruit = "gfx/ui/achievement/achievement_wakaba_revengefruit.png",
	uniform = "gfx/ui/achievement/achievement_wakaba_uniform.png",
	brimstonedetonator = "gfx/ui/achievement/achievement_wakaba_brimstonedetonator.png",
	colorjoker = "gfx/ui/achievement/achievement_wakaba_colorjoker.png",
	cranecard = "gfx/ui/achievement/achievement_wakaba_cranecard.png",
	confessionalcard = "gfx/ui/achievement/achievement_wakaba_confessionalcard.png",
	returnpostage = "gfx/ui/achievement/achievement_wakaba_returnpostage.png",

	blessing = "gfx/ui/achievement/achievement_wakaba_blessing.png",

	blackjoker = "gfx/ui/achievement/achievement_wakaba_blackjoker.png", -- Ultra Greedier
	cloverchest = "gfx/ui/achievement/achievement_wakaba_cloverchest.png", -- Mega Satan
	eatheart = "gfx/ui/achievement/achievement_wakaba_eatheart.png", -- Delirium
	bitcoin = "gfx/ui/achievement/achievement_wakaba_bitcoin.png", -- Mother
	nemesis = "gfx/ui/achievement/achievement_wakaba_nemesis.png", -- The Beast

	wakabasoul = "gfx/ui/achievement/achievement_wakaba_wakabasoul.png",
	bookofforgotten = "gfx/ui/achievement/achievement_wakaba_bookofforgotten.png",

	-- Shiori Unlocks
	hardbook = "gfx/ui/achievement/achievement_wakaba_hardbook.png", -- Mom's Heart Hard
	shiorid6plus = "gfx/ui/achievement/achievement_wakaba_shiorid6plus.png", -- Isaac
	bookoffocus = "gfx/ui/achievement/achievement_wakaba_bookoffocus.png", --Satan
	deckofrunes = "gfx/ui/achievement/achievement_wakaba_deckofrunes.png", -- ???
	grimreaperdefender = "gfx/ui/achievement/achievement_wakaba_grimreaperdefender.png", -- The Lamb
	unknownbookmark = "gfx/ui/achievement/achievement_wakaba_unknownbookmark.png", -- Boss Rush
	bookoffallen = "gfx/ui/achievement/achievement_wakaba_bookoffallen.png", --
	bookoftrauma = "gfx/ui/achievement/achievement_wakaba_bookoftrauma.png", -- Hush
	magnetheaven = "gfx/ui/achievement/achievement_wakaba_magnetheaven.png", -- Ultra Greed
	determinationribbon = "gfx/ui/achievement/achievement_wakaba_determinationribbon.png", -- Ultra Greedier
	bookofsilence = "gfx/ui/achievement/achievement_wakaba_bookofsilence.png", -- Delirium
	vintagethreat = "gfx/ui/achievement/achievement_wakaba_vintagethreat.png", -- Mother
	bookofthegod = "gfx/ui/achievement/achievement_wakaba_bookofthegod.png", --The Beast

	bookofshiori = "gfx/ui/achievement/achievement_wakaba_bookofshiori.png",

	-- Tainted Shiori Unlocks
	queenofspades = "gfx/ui/achievement/achievement_wakaba_queenofspades.png", -- Ultra Greedier
	shiorivalut = "gfx/ui/achievement/achievement_wakaba_anotherfortunemachine.png", -- Mega Satan
	bookofconquest = "gfx/ui/achievement/achievement_wakaba_bookofconquest.png", -- Delirium
	ringofjupiter = "gfx/ui/achievement/achievement_wakaba_ringofjupiter.png", -- Mother
	minervaaura = "gfx/ui/achievement/achievement_wakaba_minervaaura.png", -- The Beast

	shiorisoul = "gfx/ui/achievement/achievement_wakaba_shiorisoul.png",
	bookmarkbag = "gfx/ui/achievement/achievement_wakaba_bookmarkbag.png",

	-- Tsukasa Unlocks

	murasame = "gfx/ui/achievement/achievement_wakaba_murasame.png", -- Mom's Heart Hard
	nasalover = "gfx/ui/achievement/achievement_wakaba_nasalover.png", -- Isaac
	beetlejuice = "gfx/ui/achievement/achievement_wakaba_beetlejuice.png", --Satan
	redcorruption = "gfx/ui/achievement/achievement_wakaba_redcorruption.png", -- ???
	powerbomb = "gfx/ui/achievement/achievement_wakaba_powerbomb.png", -- The Lamb
	concentration = "gfx/ui/achievement/achievement_wakaba_concentration.png", -- Boss Rush
	plasmabeam = "gfx/ui/achievement/achievement_wakaba_plasmabeam.png", --
	rangeos = "gfx/ui/achievement/achievement_wakaba_rangeos.png", -- Hush
	arcanecrystal = "gfx/ui/achievement/achievement_wakaba_arcanecrystal.png", -- Ultra Greed
	questionblock = "gfx/ui/achievement/achievement_wakaba_questionblock.png", -- Ultra Greedier
	newyearbomb = "gfx/ui/achievement/achievement_wakaba_newyearbomb.png", -- Delirium
	phantomcloak = "gfx/ui/achievement/achievement_wakaba_phantomcloak.png", -- Mother
	magmablade = "gfx/ui/achievement/achievement_wakaba_magmablade.png", --The Beast

	lunarstone = "gfx/ui/achievement/achievement_wakaba_lunarstone.png",

	taintedtsukasa = "gfx/ui/achievement/achievement_wakaba_taintedtsukasa.png",

	-- Tainted Tsukasa Unlocks
	returntoken = "gfx/ui/achievement/achievement_wakaba_returntoken.png", -- Ultra Greedier
	easteregg = "gfx/ui/achievement/achievement_wakaba_easteregg.png", -- Mega Satan
	flashshift = "gfx/ui/achievement/achievement_wakaba_flashshift.png", -- Delirium
	sirenbadge = "gfx/ui/achievement/achievement_wakaba_sirenbadge.png", -- Mother
	elixiroflife = "gfx/ui/achievement/achievement_wakaba_elixiroflife.png", -- The Beast

	tsukasasoul = "gfx/ui/achievement/achievement_wakaba_tsukasasoul.png",
	isaaccartridge = "gfx/ui/achievement/achievement_wakaba_isaaccartridge.png",


	-- Richer Unlocks
	fireflylighter = "gfx/ui/achievement/achievement_wakaba_fireflylighter.png",
	sweetscatalog = "gfx/ui/achievement/achievement_wakaba_sweetscatalog.png",
	antibalance = "gfx/ui/achievement/achievement_wakaba_antibalance.png",
	doubleinvader = "gfx/ui/achievement/achievement_wakaba_doubleinvader.png",
	venomincantation = "gfx/ui/achievement/achievement_wakaba_venomincantation.png",
	printer = "gfx/ui/achievement/achievement_wakaba_3dprinter.png",
	bunnyparfait = "gfx/ui/achievement/achievement_wakaba_bunnyparfait.png",
	richeruniform = "gfx/ui/achievement/achievement_wakaba_richeruniform.png",
	prestigepass = "gfx/ui/achievement/achievement_wakaba_prestigepass.png",
	clensingfoam = "gfx/ui/achievement/achievement_wakaba_clensingfoam.png",
	lilricher = "gfx/ui/achievement/achievement_wakaba_lilricher.png",
	cunningpaper = "gfx/ui/achievement/achievement_wakaba_cunningpaper.png",
	selfburning = "gfx/ui/achievement/achievement_wakaba_selfburning.png",

	rabbitribbon = "gfx/ui/achievement/achievement_wakaba_rabbitribbon.png",
	taintedricher = "gfx/ui/achievement/achievement_wakaba_taintedricher.png", -- Tainted Richer




	eyeofclock = "gfx/ui/achievement/achievement_wakaba_eyeofclock.png", --01w
	plumy = "gfx/ui/achievement/achievement_wakaba_plumy.png", --02w
	--ultrablackhole = false, --03w
	delimiter = "gfx/ui/achievement/achievement_wakaba_delimiter.png", -- 04w
	nekodoll = "gfx/ui/achievement/achievement_wakaba_nekofigure.png", --05w
	microdoppelganger = "gfx/ui/achievement/achievement_wakaba_microdoppelganger.png", --06w
	delirium = "gfx/ui/achievement/achievement_wakaba_dimensioncutter.png", --07w
	lilwakaba = "gfx/ui/achievement/achievement_wakaba_lilwakaba.png", --08w
	lostuniform = "gfx/ui/achievement/achievement_wakaba_lostuniform.png", --09w
	executioner = "gfx/ui/achievement/achievement_wakaba_executioner.png", -- 10w
	apollyoncrisis = "gfx/ui/achievement/achievement_wakaba_apollyoncrisis.png", -- 11w
	deliverysystem = "gfx/ui/achievement/achievement_wakaba_isekaidefinition.png", -- 12w
	calculation = "gfx/ui/achievement/achievement_wakaba_balance.png", -- 13w
	lilmao = "gfx/ui/achievement/achievement_wakaba_lilmao.png", -- 14w
	richerflipper = "gfx/ui/achievement/achievement_wakaba_richerflipper.png", -- 15w

	edensticky = "gfx/ui/achievement/achievement_wakaba_edensticky.png", -- 99w
	doubledreams = "gfx/ui/achievement/achievement_wakaba_doubledreams.png", -- 99w
}

wakaba.Enums.UniqueItemsAppend = {
	"Wakaba",
	"Shiori",
	"Tsukasa",
	"Richer",
	"Rira",
}
wakaba.Enums.UniqueItemsAppendTainted = {
	"Wakaba",
	"Shiori",
	"Tsukasa",
	"Richer",
	"Rira",
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
