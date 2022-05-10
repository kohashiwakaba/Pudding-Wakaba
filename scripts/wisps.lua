

function wakaba:TakeDamage_Wisps(wisp, amount, flags, source, cooldown)
  if wisp.Variant ~= FamiliarVariant.WISP then return end
  if wisp.SubType == wakaba.COLLECTIBLE_EATHEART then
    return false
  elseif wisp.SubType == wakaba.COLLECTIBLE_BOOK_OF_SILENCE then
  elseif wisp.SubType == wakaba.COLLECTIBLE_BOOK_OF_CONQUEST then
    return false
  elseif wisp.SubType == wakaba.COLLECTIBLE_BOOK_OF_THE_FALLEN then
    return false
  elseif wisp.SubType == wakaba.COLLECTIBLE_QUESTION_BLOCK then
    return false
  elseif wisp.SubType == wakaba.COLLECTIBLE_BALANCE then
    if wisp:ToFamiliar() and wisp:ToFamiliar().Player then
      local player = wisp:ToFamiliar().Player
      if player:GetNumBombs() == player:GetNumKeys() then
        return false
      end
    end
  end
  if wisp:ToFamiliar() and wisp:ToFamiliar().Player then
    local player = wisp:ToFamiliar().Player
    -- Counter
    if player:GetData().wakabacountertimer and player:GetData().wakabacountertimer > 0 then
      return false
    end
    -- Wakaba's Uniform
    if player:HasCollectible(wakaba.COLLECTIBLE_UNIFORM) then
      return false
    end
    -- Flash Shift
    
  end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_Wisps, EntityType.ENTITY_FAMILIAR)

function wakaba:wispDeathCheck(wisp)
  if wisp:ToFamiliar() and wisp:ToFamiliar().Player then
    local player = wisp:ToFamiliar().Player
    if wisp.Variant == FamiliarVariant.WISP then
      if wisp.SubType == wakaba.COLLECTIBLE_BOOK_OF_FORGOTTEN then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BONE, wisp.Position, Vector.Zero, nil)
      elseif wisp.SubType == wakaba.COLLECTIBLE_DECK_OF_RUNES then
				local selected = Game():GetItemPool():GetCard(player:GetCollectibleRNG(wakaba.COLLECTIBLE_DECK_OF_RUNES):Next(), false, true, true)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, selected, wisp.Position, Vector.Zero, nil)
      elseif wisp.SubType == wakaba.COLLECTIBLE_MICRO_DOPPELGANGER then
        player:AddMinisaac(player.Position)
        player:AddMinisaac(player.Position)
      elseif wisp.SubType == wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
      elseif wisp.SubType == wakaba.COLLECTIBLE_ISEKAI_DEFINITION then
        local clot = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY, 3, wisp.Position, Vector.Zero, player):ToFamiliar()
      elseif wisp.SubType == wakaba.COLLECTIBLE_MAIJIMA_MYTHOLOGY then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.CARD_UNKNOWN_BOOKMARK, wisp.Position, Vector.Zero, nil)
      elseif wisp.SubType == wakaba.COLLECTIBLE_3D_PRINTER then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, 0, wisp.Position, Vector.Zero, nil)
      end
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, wakaba.wispDeathCheck, EntityType.ENTITY_FAMILIAR)