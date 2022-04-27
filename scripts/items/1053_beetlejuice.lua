wakaba.COLLECTIBLE_BEETLEJUICE = Isaac.GetItemIdByName("Beetlejuice")
wakaba.COLLECTIBLE_BEETLEJUICE_CARD = Isaac.GetItemIdByName("Capsule Beetlejuice")
wakaba.COLLECTIBLE_BEETLEJUICE_PILL = Isaac.GetItemIdByName("Pocket Beetlejuice")

function wakaba:ItemUse_Beetlejuice(item, rng, player, useFlags, activeSlot, varData)
	pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
  local discharge = true

  local pickups = Isaac.FindInRadius(wakaba:GetGridCenter(), 1000, EntityPartition.PICKUP)
  for _, pickup in pairs(pickups) do
    pickup = pickup:ToPickup()
    if item == wakaba.COLLECTIBLE_BEETLEJUICE or item == wakaba.COLLECTIBLE_BEETLEJUICE_CARD then
      if pickup.Variant == PickupVariant.PICKUP_PILL then
        pickup:Morph(5, PickupVariant.PICKUP_TAROTCARD, -1, false, false, true)
      end
    end
    if item == wakaba.COLLECTIBLE_BEETLEJUICE or item == wakaba.COLLECTIBLE_BEETLEJUICE_PILL then
      if pickup.Variant == PickupVariant.PICKUP_TAROTCARD then
        pickup:Morph(5, PickupVariant.PICKUP_PILL, -1, false, false, true)
      end
    end
    if item == wakaba.COLLECTIBLE_BEETLEJUICE then
      if pickup.Variant == PickupVariant.PICKUP_HEART then
        pickup:Morph(5, PickupVariant.PICKUP_COIN, CoinSubType.COIN_STICKYNICKEL, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_COIN then
        pickup:Morph(5, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ROTTEN, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_KEY then
        pickup:Morph(5, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDENTROLL, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_BOMB then
        pickup:Morph(5, PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_CHEST then
        pickup:Morph(5, PickupVariant.PICKUP_SPIKEDCHEST, 1, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_BOMBCHEST then
        pickup:Morph(5, PickupVariant.PICKUP_ETERNALCHEST, 1, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_SPIKEDCHEST or pickup.Variant == PickupVariant.PICKUP_MIMICCHEST then
        pickup:Morph(5, PickupVariant.PICKUP_CHEST, 1, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_ETERNALCHEST then
        pickup:Morph(5, PickupVariant.PICKUP_MEGACHEST, 1, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_OLDCHEST then
        pickup:Morph(5, PickupVariant.PICKUP_LOCKEDCHEST, 1, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_WOODENCHEST then
        pickup:Morph(5, PickupVariant.PICKUP_HAUNTEDCHEST, 1, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_MEGACHEST then
        pickup:Morph(5, PickupVariant.PICKUP_BED, 1, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_LOCKEDCHEST then
        pickup:Morph(5, PickupVariant.PICKUP_ETERNALCHEST, 1, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_GRAB_BAG then
        pickup:Morph(5, PickupVariant.PICKUP_ETERNALCHEST, 1, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY then
        pickup:Morph(5, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MEGA, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_REDCHEST then
        pickup:Morph(EntityType.ENTITY_FALLEN, 1, 0, false, false, true)
      elseif pickup.Variant == PickupVariant.PICKUP_BED then
        pickup:Morph(5, PickupVariant.PICKUP_BED, 0, false, false, true)
      end
    end
  end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(item, "UseItem", "PlayerPickup")
	end
  return {Discharge = discharge}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Beetlejuice, wakaba.COLLECTIBLE_BEETLEJUICE)
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Beetlejuice, wakaba.COLLECTIBLE_BEETLEJUICE_CARD)
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Beetlejuice, wakaba.COLLECTIBLE_BEETLEJUICE_PILL)
