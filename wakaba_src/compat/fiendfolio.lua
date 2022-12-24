local ffReplaced = false
function wakaba:GameStart_FiendFolioCompat()
  if FiendFolio and not ffReplaced then
    FiendFolio.RockTrinkets[wakaba.Enums.Trinkets.BRING_ME_THERE] = -2
    FiendFolio.GolemTrinketWhitelist[wakaba.Enums.Trinkets.BRING_ME_THERE] = 1
--[[ 
    wakaba.CatalogItems["FF_FIEND"] = {
      Weight = 1,
      Items = {
        FiendFolio.ITEM.COLLECTIBLE.PYROMANCY,
        FiendFolio.ITEM.COLLECTIBLE.FIENDS_HORN,
        FiendFolio.ITEM.COLLECTIBLE.IMP_SODA,
      },
      Reserve = 1,
      RicherRecipe = true,
    }
    wakaba.CatalogItems["FF_PAJAMA"] = {
      Weight = 1,
      Items = {
        FiendFolio.ITEM.COLLECTIBLE.HYPNO_RING,
        FiendFolio.ITEM.COLLECTIBLE.SMASH_TROPHY,
      },
      Reserve = 3,
      RicherRecipe = true,
    }
    wakaba.CatalogItems["FF_FIREMANIAC"] = {
      Weight = 1,
      Items = {
        FiendFolio.ITEM.COLLECTIBLE.WHITE_PEPPER,
        CollectibleType.COLLECTIBLE_GHOST_PEPPER,
        CollectibleType.COLLECTIBLE_BIRDS_EYE,
      },
      Reserve = 1,
      RicherRecipe = true,
    }
 ]]
    ffReplaced = true
  end

end