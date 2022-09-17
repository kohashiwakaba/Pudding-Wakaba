local roomWispTypes = {
  wakaba.Enums.Collectibles.COUNTER,

}

function wakaba:HasWisp(player, collectibleType)
  if not player then return end
  local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, collectibleType, false, false)
  for i, wisp in ipairs(wisps) do
    if wisp:ToFamiliar() and GetPtrHash(wisp:ToFamiliar().Player) == GetPtrHash(player) then
      return wisp:ToFamiliar()
    end
  end
end

function wakaba:TakeDamage_Wisps(wisp, amount, flags, source, cooldown)
  if wisp.Variant ~= FamiliarVariant.WISP then return end
  if wisp.SubType == wakaba.Enums.Collectibles.EATHEART then
    return false
  elseif wisp.SubType == wakaba.Enums.Collectibles.COUNTER then
    return false
  elseif wisp.SubType == wakaba.Enums.Collectibles.BOOK_OF_SILENCE then
  elseif wisp.SubType == wakaba.Enums.Collectibles.BOOK_OF_CONQUEST then
    return false
  elseif wisp.SubType == wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN then
    return false
  elseif wisp.SubType == wakaba.Enums.Collectibles.QUESTION_BLOCK then
    return false
  elseif wisp.SubType == wakaba.Enums.Collectibles.BALANCE then
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
    if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM) then
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
      if wisp.SubType == wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BONE, wisp.Position, Vector.Zero, nil)
      elseif wisp.SubType == wakaba.Enums.Collectibles.DECK_OF_RUNES then
				local selected = Game():GetItemPool():GetCard(player:GetCollectibleRNG(wakaba.Enums.Collectibles.DECK_OF_RUNES):Next(), false, true, true)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, selected, wisp.Position, Vector.Zero, nil)
      elseif wisp.SubType == wakaba.Enums.Collectibles.MICRO_DOPPELGANGER then
        player:AddMinisaac(player.Position)
        player:AddMinisaac(player.Position)
      elseif wisp.SubType == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
      elseif wisp.SubType == wakaba.Enums.Collectibles.ISEKAI_DEFINITION then
        local clot = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY, 3, wisp.Position, Vector.Zero, player):ToFamiliar()
      elseif wisp.SubType == wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK, wisp.Position, Vector.Zero, nil)
      elseif wisp.SubType == wakaba.Enums.Collectibles._3D_PRINTER then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, 0, wisp.Position, Vector.Zero, nil)
      end
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, wakaba.wispDeathCheck, EntityType.ENTITY_FAMILIAR)

function wakaba:FamiliarUpdate_Wisps(familiar)
  if familiar.SubType == wakaba.Enums.Collectibles.BOOK_OF_SILENCE then
    local famloc = familiar.Position
    local projectiles = Isaac.FindInRadius(famloc, 60, EntityPartition.BULLET)
    for i, entity in ipairs(projectiles) do
      if not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
        entity:Remove()
      end
    end

  end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_Wisps, FamiliarVariant.WISP)

function wakaba:NewRoom_Wisps()
  for _, wispType in ipairs(roomWispTypes) do
    local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, wispType)
    for _, wisp in ipairs(wisps) do
      wisp:Remove()
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Wisps)