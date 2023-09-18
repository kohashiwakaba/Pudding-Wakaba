
wakaba:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, function(_, entype, var, subtype, grindex, seed)
  if var == wakaba.Enums.Pickups.WAKABA_ITEM_SPAWNER then
    if subtype == 1024 then
      return {5, 100, wakaba.Enums.Collectibles.WAKABA_DUALITY}
    elseif subtype == 1023 then
      return {5, 100, wakaba.Enums.Collectibles.CLOVER_SHARD}
    elseif subtype == 0 then
      local itemConfig = Isaac.GetItemConfig()
      local rng = RNG()
      rng:SetSeed(seed, 41)

      repeat
        subtype = rng:RandomInt(wakaba.Enums.Collectibles.WAKABA_DUALITY - wakaba.Enums.Collectibles.WAKABAS_BLESSING + 1) + 1
      until
        not itemConfig:GetCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING + subtype - 1).Hidden
        and wakaba:IsCompletionItemUnlockedTemp(wakaba.Enums.Collectibles.WAKABAS_BLESSING + subtype - 1, "collectible")
    end
    return {5, 100, wakaba.Enums.Collectibles.WAKABAS_BLESSING + subtype - 1}
  elseif var == wakaba.Enums.Pickups.WAKABA_TRINKET_SPAWNER then
    if subtype == 0 then
      local itemConfig = Isaac.GetItemConfig()
      local rng = RNG()
      rng:SetSeed(seed, 41)

      repeat
        subtype = rng:RandomInt(wakaba.Enums.Trinkets.HIGHEST_ID - wakaba.Enums.Trinkets.BRING_ME_THERE + 1) + 1
      until
        not itemConfig:GetTrinket(wakaba.Enums.Trinkets.BRING_ME_THERE + subtype - 1).Hidden
        and wakaba:IsCompletionItemUnlockedTemp(wakaba.Enums.Trinkets.BRING_ME_THERE + subtype - 1, "trinket")
    end
    return {5, 350, wakaba.Enums.Trinkets.BRING_ME_THERE + subtype - 1}
  elseif var == wakaba.Enums.Pickups.WAKABA_TICKET_SPAWNER then
    if wakaba.Spawner.PocketItemLookup[subtype] then
      return {5, 300, wakaba.Spawner.PocketItemLookup[subtype]}
    else
      local rng = RNG()
      rng:SetSeed(seed, 41)
      subtype = rng:RandomInt(#wakaba.Spawner.PocketItemLookup)

      return {5, 300, wakaba.Spawner.PocketItemLookup[subtype]}
    end
  end
end, EntityType.ENTITY_PICKUP)

wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, function(_, pickup)
  if pickup.SubType == 1024 then
    pickup:Morph(5, 100, wakaba.Enums.Collectibles.WAKABA_DUALITY)
    return
  elseif pickup.SubType == 1023 then
    pickup:Morph(5, 100, wakaba.Enums.Collectibles.CLOVER_SHARD)
    return
  end
	if pickup.SubType == 0 then
		local itemConfig = Isaac.GetItemConfig()
		local rng = RNG()
		rng:SetSeed(pickup.InitSeed, 41)

		repeat
			pickup.SubType = rng:RandomInt(wakaba.Enums.Collectibles.WAKABA_DUALITY - wakaba.Enums.Collectibles.WAKABAS_BLESSING + 1) + 1
		until not itemConfig:GetCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING + pickup.SubType - 1).Hidden
	end

	pickup:Morph(5, 100, wakaba.Enums.Collectibles.WAKABAS_BLESSING + pickup.SubType - 1)
	wakaba.UniversalRemoveItemFromPools(wakaba.Enums.Collectibles.WAKABAS_BLESSING + pickup.SubType - 1)
end, wakaba.Enums.Pickups.WAKABA_ITEM_SPAWNER)

wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, function(_, pickup)
	if pickup.SubType == 0 then
		local itemConfig = Isaac.GetItemConfig()
		local rng = RNG()
		rng:SetSeed(pickup.InitSeed, 41)

		repeat
			pickup.SubType = rng:RandomInt(wakaba.Enums.Trinkets.HIGHEST_ID - wakaba.Enums.Trinkets.BRING_ME_THERE + 1) + 1
		until not itemConfig:GetTrinket(wakaba.Enums.Trinkets.BRING_ME_THERE + pickup.SubType - 1).Hidden
	end

	pickup:Morph(5, 350, wakaba.Enums.Trinkets.BRING_ME_THERE + pickup.SubType - 1)
	wakaba.UniversalRemoveTrinketFromPools(wakaba.Enums.Trinkets.BRING_ME_THERE + pickup.SubType - 1)
end, wakaba.Enums.Pickups.WAKABA_TRINKET_SPAWNER)

wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, function(_, pickup)
	if wakaba.Spawner.PocketItemLookup[pickup.SubType] then
		pickup:Morph(5, 300, wakaba.Spawner.PocketItemLookup[pickup.SubType], true)
	else
		pickup:Remove()
	end
end, wakaba.Enums.Pickups.WAKABA_TICKET_SPAWNER)
