
local vexq = CollectibleType
local wexq = wakaba.Enums.Collectibles
-- 확장 퀄리티
wakaba.Enums.ExtendQuality = {
	[wexq.EXECUTIONER] = 5,
	[wexq.DOUBLE_DREAMS] = 6,
	[wexq.APOLLYON_CRISIS] = 5,
	[wexq.NEKO_FIGURE] = 5,
	[wexq.WINTER_ALBIREO] = 5,
	[wexq.CONCENTRATION] = 5,
	[wexq.MURASAME] = 5,
	[wexq.RED_CORRUPTION] = 5,
	[wexq.CARAMELLA_PANCAKE] = 5,
	[wexq.CHIMAKI] = 5,
	[wexq.PRESTIGE_PASS] = 6,
	[wexq.MAID_DUET] = 6,
	[wexq.WAKABAS_BLESSING] = 5,
	[wexq.WAKABAS_NEMESIS] = 5,
	[wexq.WAKABA_DUALITY] = 6,
}

wakaba.Enums.ExtendQualityVanilla = {
  -- Q0
  [vexq.COLLECTIBLE_BOOK_OF_SECRETS] = 3,
  [vexq.COLLECTIBLE_PLUM_FLUTE] = 1,

  -- Q1
  [vexq.COLLECTIBLE_COMPASS] = 2,
  [vexq.COLLECTIBLE_TREASURE_MAP] = 2,
  [vexq.COLLECTIBLE_MOMS_EYE] = 0,
  [vexq.COLLECTIBLE_LOKIS_HORNS] = 0,
  [vexq.COLLECTIBLE_NOTCHED_AXE] = 2,
  [vexq.COLLECTIBLE_TELEPATHY_BOOK] = 2,
  --[vexq.COLLECTIBLE_MEGA_BEAN] = 3,
  [vexq.COLLECTIBLE_TELEKINESIS] = 2,
  [vexq.COLLECTIBLE_ALMOND_MILK] = 0,
  [vexq.COLLECTIBLE_EVIL_CHARM] = 2,
  [vexq.COLLECTIBLE_CRACKED_ORB] = 2,

  -- Q2
  [vexq.COLLECTIBLE_STEAM_SALE] = 3,
  [vexq.COLLECTIBLE_SKELETON_KEY] = 3,
  [vexq.COLLECTIBLE_LUCKY_FOOT] = 3,
  [vexq.COLLECTIBLE_BATTERY] = 3,
  [vexq.COLLECTIBLE_PHD] = 3,
  [vexq.COLLECTIBLE_XRAY_VISION] = 4,
  [vexq.COLLECTIBLE_SPELUNKER_HAT] = 3,
  [vexq.COLLECTIBLE_LITTLE_STEVEN] = 3,
  [vexq.COLLECTIBLE_9_VOLT] = 3,
  [vexq.COLLECTIBLE_SHARP_PLUG] = 4,
  [vexq.COLLECTIBLE_CHEMICAL_PEEL] = 1,
  [vexq.COLLECTIBLE_LOST_CONTACT] = 3,
  [vexq.COLLECTIBLE_GIMPY] = 3,
  [vexq.COLLECTIBLE_BFFS] = 3,
  [vexq.COLLECTIBLE_HIVE_MIND] = 3,
  [vexq.COLLECTIBLE_STARTER_DECK] = 4,
  [vexq.COLLECTIBLE_FIRE_MIND] = 1,
  [vexq.COLLECTIBLE_CAINS_OTHER_EYE] = 3,
  [vexq.COLLECTIBLE_NEGATIVE] = 3,
  [vexq.COLLECTIBLE_BOMBER_BOY] = 1,
  [vexq.COLLECTIBLE_CRACK_JACKS] = 1,
  [vexq.COLLECTIBLE_CONTINUUM] = 3,
  [vexq.COLLECTIBLE_NUMBER_TWO] = 1,
  [vexq.COLLECTIBLE_DEEP_POCKETS] = 3,
  [vexq.COLLECTIBLE_HEAD_OF_THE_KEEPER] = 3,
  [vexq.COLLECTIBLE_EYE_OF_GREED] = 1,
  [vexq.COLLECTIBLE_KIDNEY_STONE] = 0,
  [vexq.COLLECTIBLE_CONTAGION] = 1,
  [vexq.COLLECTIBLE_LIL_MONSTRO] = 1,
  [vexq.COLLECTIBLE_ACID_BABY] = 1,
  [vexq.COLLECTIBLE_YO_LISTEN] = 3,
  [vexq.COLLECTIBLE_SACK_OF_SACKS] = 3,
  [vexq.COLLECTIBLE_MERCURIUS] = 3,
  [vexq.COLLECTIBLE_SOL] = 3,
  [vexq.COLLECTIBLE_GUPPYS_EYE] = 3,
  [vexq.COLLECTIBLE_OPTIONS] = 4,
  [vexq.COLLECTIBLE_HUNGRY_SOUL] = 3,

  -- Q3
  [vexq.COLLECTIBLE_SPOON_BENDER] = 4,
  [vexq.COLLECTIBLE_BOOK_OF_REVELATIONS] = 2,
  [vexq.COLLECTIBLE_EUCHARIST] = 4,
  [vexq.COLLECTIBLE_MIND] = 4,
  [vexq.COLLECTIBLE_SCHOOLBAG] = 4,
  [vexq.COLLECTIBLE_BRITTLE_BONES] = 4,
  [vexq.COLLECTIBLE_SAUSAGE] = 4,
  [vexq.COLLECTIBLE_TRACTOR_BEAM] = 2,
  [vexq.COLLECTIBLE_CAR_BATTERY] = 2,
  [vexq.COLLECTIBLE_LIL_DUMPY] = 4,

  -- Q4
  [vexq.COLLECTIBLE_SACRED_HEART] = 5,
  [vexq.COLLECTIBLE_STOP_WATCH] = 5,
  [vexq.COLLECTIBLE_DEATH_CERTIFICATE] = 6,
  [vexq.COLLECTIBLE_C_SECTION] = 5,
  [vexq.COLLECTIBLE_SACRED_ORB] = 5,
}

wakaba.savedQuality = {}

if REPENTANCE_PLUS then

end