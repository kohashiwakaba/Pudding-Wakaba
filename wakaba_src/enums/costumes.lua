
wakaba.COSTUME_WAKABA = Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2")
wakaba.COSTUME_NOT_WAKABA = Isaac.GetCostumeIdByPath("gfx/characters/character_not_wakaba.anm2")

wakaba.COSTUME_WAKABA_B = Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_b.anm2")

wakaba.COSTUME_SHIORI = Isaac.GetCostumeIdByPath("gfx/characters/character_shiori.anm2")

wakaba.COSTUME_SHIORI_B = Isaac.GetCostumeIdByPath("gfx/characters/character_shiori_b.anm2")
wakaba.COSTUME_SHIORI_B_BODY = Isaac.GetCostumeIdByPath("gfx/characters/character_shiori_b_body.anm2")

wakaba.COSTUME_TSUKASA = Isaac.GetCostumeIdByPath("gfx/characters/character_tsukasa.anm2")
wakaba.COSTUME_TSUKASA_B = Isaac.GetCostumeIdByPath("gfx/characters/character_tsukasa_b.anm2")

wakaba.cpManagedPlayerType = {
  [wakaba.Enums.Players.WAKABA] = {sheetName = "wakaba", flightSheetName = "wakaba", flightID = 67, extraNullID = NullItemID.ID_JACOB},
  [wakaba.Enums.Players.WAKABA_B] = {sheetName = "wakabab", flightSheetName = "wakabab", flightID = 40, extraNullID = NullItemID.ID_JACOB},
  [wakaba.Enums.Players.SHIORI] = {sheetName = "shiori", flightSheetName = "shiori", flightID = 67, extraNullID = NullItemID.ID_JACOB},
  [wakaba.Enums.Players.SHIORI_B] = {sheetName = "shiorib", flightSheetName = "shiorib", flightID = wakaba.COSTUME_SHIORI_B_BODY, extraNullID = NullItemID.ID_JACOB},
  [wakaba.Enums.Players.TSUKASA] = {sheetName = "tsukasa", flightSheetName = "tsukasa", flightID = 67, extraNullID = NullItemID.ID_JACOB},
  [wakaba.Enums.Players.TSUKASA_B] = {sheetName = "tsukasab", flightSheetName = "tsukasab", flightID = 67, extraNullID = NullItemID.ID_JACOB},
  [wakaba.Enums.Players.RICHER] = {sheetName = "richer", flightSheetName = "richer", flightID = 67, extraNullID = NullItemID.ID_JACOB},
  [wakaba.Enums.Players.RICHER_B] = {sheetName = "richerb", flightSheetName = "richerb", flightID = 67, extraNullID = NullItemID.ID_JACOB},
  [wakaba.Enums.Players.RIRA] = {sheetName = "rira", flightSheetName = "rira", flightID = 67, extraNullID = NullItemID.ID_JACOB},
  [wakaba.Enums.Players.RIRA_B] = {sheetName = "rirab", flightSheetName = "rirab", flightID = 67, extraNullID = NullItemID.ID_JACOB},
}

wakaba.costumeCollectibleWhiteList = {
  [wakaba.Enums.Collectibles.SYRUP] = true,
}
wakaba.costumeNullWhiteList = {
}


