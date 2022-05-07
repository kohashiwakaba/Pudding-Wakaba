

function wakaba:wispDeathCheck(wisp)
  if wisp:ToFamiliar() and wisp:ToFamiliar().Player then
    local player = wisp:ToFamiliar().Player
    if wisp.Variant == FamiliarVariant.WISP then
      if wisp.SubType == wakaba.COLLECTIBLE_DECK_OF_RUNES then
				local selected = Game():GetItemPool():GetCard(player:GetCollectibleRNG(wakaba.COLLECTIBLE_DECK_OF_RUNES):Next(), false, true, true)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, selected, wisp.Position, Vector.Zero, nil)
      elseif wisp.SubType == wakaba.COLLECTIBLE_MICRO_DOPPELGANGER then
        player:AddMinisaac(player.Position)
        player:AddMinisaac(player.Position)
      elseif wisp.SubType == wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
      elseif wisp.SubType == wakaba.COLLECTIBLE_ISEKAI_DEFINITION then
        local clot = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY, 3, wisp.Position, Vector.Zero, player):ToFamiliar()
      end
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, wakaba.wispDeathCheck, EntityType.ENTITY_FAMILIAR)