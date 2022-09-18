wakaba.Enums = {}

wakaba.Enums.Players = {
  WAKABA = Isaac.GetPlayerTypeByName("Wakaba", false),
  WAKABA_B = Isaac.GetPlayerTypeByName("WakabaB", true),
  SHIORI = Isaac.GetPlayerTypeByName("Shiori", false),
  SHIORI_B = Isaac.GetPlayerTypeByName("ShioriB", true),
  TSUKASA = Isaac.GetPlayerTypeByName("Tsukasa", false),
  TSUKASA_B = Isaac.GetPlayerTypeByName("TsukasaB", true),
  --RICHER = Isaac.GetPlayerTypeByName("Richer", false),
  --RICHER_B = Isaac.GetPlayerTypeByName("RicherB", true),
}

wakaba.Enums.Collectibles = {
  -- Core items
  WAKABAS_BLESSING = Isaac.GetItemIdByName("Wakaba's Blessing"),
  WAKABAS_NEMESIS = Isaac.GetItemIdByName("Wakaba's Nemesis"),
  WAKABA_DUALITY = Isaac.GetItemIdByName("Wakaba Duality"),
  BOOK_OF_SHIORI = Isaac.GetItemIdByName("Book of Shiori"),
  BOOK_OF_CONQUEST = Isaac.GetItemIdByName("Book of Conquest"),
  MINERVA_AURA = Isaac.GetItemIdByName("Minerva's Aura"),
  LUNAR_STONE = Isaac.GetItemIdByName("Lunar Stone"),
  ELIXIR_OF_LIFE = Isaac.GetItemIdByName("Elixir of Life"),
  FLASH_SHIFT = Isaac.GetItemIdByName("Flash Shift"),
  CONCENTRATION = Isaac.GetItemIdByName("Concentration"),
  RABBIT_RIBBON = Isaac.GetItemIdByName("Rabbit Ribbon"),

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

  -- Wakaba items
  EATHEART = Isaac.GetItemIdByName("Eat Heart"),
  EATHEART_WAKABA = Isaac.GetItemIdByName("Eat Heart"),
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
  HYDRA = Isaac.GetItemIdByName("Hydra"),
  RED_CORRUPTION = Isaac.GetItemIdByName("Red Corruption"),
  PLASMA_BEAM = Isaac.GetItemIdByName("Plasma Beam"),

  -- Richer items
  WINTER_ALBIREO = Isaac.GetItemIdByName("The Winter Albireo"),
  CARAMELLA_PANCAKE = Isaac.GetItemIdByName("Caramella Pancake"),
  _3D_PRINTER = Isaac.GetItemIdByName("3D Printer"),
  VENOM_INCANTATION = Isaac.GetItemIdByName("Venom Incantation"),
  FIREFLY_LIGHTER = Isaac.GetItemIdByName("Firefly Lighter"),
  DOUBLE_INVADER = Isaac.GetItemIdByName("Double Invader"),
  ANTI_BALANCE = Isaac.GetItemIdByName("Anti Balance"),
  SWEETS_CATALOG = Isaac.GetItemIdByName("Sweets Catalog"),
  MAID_OF_PAIN = Isaac.GetItemIdByName("Maid of Pain"),
  RICHERS_RECIPE = Isaac.GetItemIdByName("Richer's Recipe"),
  CHIERI = Isaac.GetItemIdByName("Chieri"),
  LIL_RICHER = Isaac.GetItemIdByName("Lil Richer"),
  LIL_RIRA = Isaac.GetItemIdByName("Lil Rira"),
  BLACK_RIBBON = Isaac.GetItemIdByName("Black Ribbon"),
  WATER_FLAME = Isaac.GetItemIdByName("Water Flame"),

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
  EDEN_STICKY_NOTE = Isaac.GetItemIdByName("Eden's Sticky Note"),

}

wakaba.Enums.Familiars = {
  PLUMY = Isaac.GetEntityVariantByName("Plumy"),
  LIL_WAKABA = Isaac.GetEntityVariantByName("Lil Wakaba"),
  LIL_MOE = Isaac.GetEntityVariantByName("Lil Moe"),
  LIL_SHIVA = Isaac.GetEntityVariantByName("Lil Shiva"),
  MURASAME = Isaac.GetEntityVariantByName("Murasame"),
  LIL_NASA = Isaac.GetEntityVariantByName("Lil Nasa"),
  --LIL_RICHER = Isaac.GetEntityVariantByName("Lil Richer"),
  --LIL_RIRA = Isaac.GetEntityVariantByName("Lil Rira"),
  --BLACK_RIBBON = Isaac.GetEntityVariantByName("Black Ribbon Particle"),
  --CHIERI = Isaac.GetEntityVariantByName("Chieri"),

}

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

}

wakaba.Enums.Effects = {
  POWER_BOMB = Isaac.GetEntityVariantByName("Wakaba Power Bomb Explosion"),

}

wakaba.Enums.Pickups = {
  CLOVER_CHEST = Isaac.GetEntityVariantByName("Clover Chest"),

}

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

}

wakaba.Enums.Pills = {
  DAMAGE_MULTIPLIER_UP = Isaac.GetPillEffectByName("Damage Multiplier Up"),
  DAMAGE_MULTIPLIER_DOWN = Isaac.GetPillEffectByName("Damage Multiplier Down"),
  ALL_STATS_UP = Isaac.GetPillEffectByName("All Stats Up"),
  ALL_STATS_DOWN = Isaac.GetPillEffectByName("All Stats Down"),
  TROLLED = Isaac.GetPillEffectByName("Trolled!"),
  TO_THE_START = Isaac.GetPillEffectByName("To the Start!"),
  EXPLOSIVE_DIARRHEA_2 = Isaac.GetPillEffectByName("Explosive Diarrhea 2!"),
  EXPLOSIVE_DIARRHEA_2_NOT = Isaac.GetPillEffectByName("Explosive Diarrhea 2?"),
  SOCIAL_DISTANCE = Isaac.GetPillEffectByName("Social Distance"),
  DUALITY_ORDERS = Isaac.GetPillEffectByName("Duality Orders"),
  FLAME_PRINCESS = Isaac.GetPillEffectByName("Flame Princess!"),
  FIREY_TOUCH = Isaac.GetPillEffectByName("Firey Touch"),
  PRIEST_BLESSING = Isaac.GetPillEffectByName("Priest's Blessing"),
  UNHOLY_CURSE = Isaac.GetPillEffectByName("Unholy Curse"),
}

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