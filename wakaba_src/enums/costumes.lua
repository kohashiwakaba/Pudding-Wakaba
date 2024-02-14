
wakaba.COSTUME_WAKABA = Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2")
wakaba.COSTUME_NOT_WAKABA = Isaac.GetCostumeIdByPath("gfx/characters/character_not_wakaba.anm2")

wakaba.COSTUME_WAKABA_B = Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_b.anm2")

wakaba.COSTUME_SHIORI = Isaac.GetCostumeIdByPath("gfx/characters/character_shiori.anm2")

wakaba.COSTUME_SHIORI_B = Isaac.GetCostumeIdByPath("gfx/characters/character_shiori_b.anm2")
wakaba.COSTUME_SHIORI_B_BODY = Isaac.GetCostumeIdByPath("gfx/characters/character_shiori_b_body.anm2")

wakaba.COSTUME_TSUKASA = Isaac.GetCostumeIdByPath("gfx/characters/character_tsukasa.anm2")
wakaba.COSTUME_TSUKASA_B = Isaac.GetCostumeIdByPath("gfx/characters/character_tsukasa_b.anm2")

wakaba.cpmanagedplayertype = {
  wakaba.Enums.Players.WAKABA,
  wakaba.Enums.Players.WAKABA_B,
  wakaba.Enums.Players.SHIORI,
  wakaba.Enums.Players.SHIORI_B,
  wakaba.Enums.Players.TSUKASA,
  wakaba.Enums.Players.TSUKASA_B,
}

wakaba.costumeCollectibleWhiteList = {
  [CollectibleType.COLLECTIBLE_PONY] = true,
  [CollectibleType.COLLECTIBLE_WHITE_PONY] = true,
  [wakaba.Enums.Collectibles.SYRUP] = true,
  [CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS] = true,
  [CollectibleType.COLLECTIBLE_TOOTH_AND_NAIL] = true,
  [CollectibleType.COLLECTIBLE_C_SECTION] = true,
  --[CollectibleType.COLLECTIBLE_MEGA_MUSH] = false,
}
wakaba.costumeNullWhiteList = {
  [NullItemID.ID_STATUE] = true,
  [NullItemID.ID_BLINDFOLD] = true,
  [NullItemID.ID_PURITY_GLOW] = true,
  [NullItemID.ID_BOOKWORM] = true,
  [NullItemID.ID_BATWING_WINGS] = true,
  [NullItemID.ID_TOOTH_AND_NAIL] = true,
  [NullItemID.ID_REVERSE_CHARIOT_ALT] = true,
  [NullItemID.ID_LUNA] = true,
  [NullItemID.ID_LOST_CURSE] = true,
}


