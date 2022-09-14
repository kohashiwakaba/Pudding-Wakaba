local ffReplaced = false
function wakaba:GameStart_FiendFolioCompat()
  if FiendFolio and not ffReplaced then
    FiendFolio.RockTrinkets[wakaba.BRING_ME_THERE] = -2
    FiendFolio.GolemTrinketWhitelist[wakaba.BRING_ME_THERE] = 1

    ffReplaced = true
  end

end