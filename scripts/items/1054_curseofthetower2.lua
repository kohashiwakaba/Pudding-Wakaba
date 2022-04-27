wakaba.COLLECTIBLE_CURSE_OF_THE_TOWER_2 = Isaac.GetItemIdByName("Curse of The Tower 2")
local hastower = false


function wakaba:Update_CurseOfTower2()
  hastower = false
  for num = 1, Game():GetNumPlayers() do
    local player = Game():GetPlayer(num - 1)
    if player:HasCollectible(wakaba.COLLECTIBLE_CURSE_OF_THE_TOWER_2) then
      hastower = true
    end
  end
end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_CurseOfTower2)

function wakaba:PickupSelect_CurseOfTower2(pickup)
  if not hastower then return end
  local variant = pickup.Variant
  local subtype = pickup.SubType
  local savedpos = pickup.Position + Vector.Zero
  local savedvel = pickup.Velocity + Vector.Zero
  local spawnent = 5
  local spawnvar = nil
  local spawnsub = 0
  if variant == PickupVariant.PICKUP_PILL and subtype ~= PillColor.PILL_GOLD then
    spawnvar = variant
    spawnsub = PillColor.PILL_GOLD
  elseif variant == PickupVariant.PICKUP_TAROTCARD 
  and Isaac.GetCardIdByName("Golden Card") > -1
  and subtype ~= Isaac.GetCardIdByName("Golden Card") then
    spawnvar = variant
    spawnsub = Isaac.GetCardIdByName("Golden Card")
  --[[ elseif variant == PickupVariant.PICKUP_HEART and subtype ~= HeartSubType.HEART_GOLDEN then
    spawnvar = variant
    spawnsub = HeartSubType.HEART_GOLDEN
  elseif variant == PickupVariant.PICKUP_COIN and subtype ~= CoinSubType.COIN_GOLDEN then
    spawnvar = variant
    spawnsub = CoinSubType.COIN_GOLDEN ]]
  elseif variant == PickupVariant.PICKUP_KEY and subtype ~= KeySubType.KEY_GOLDEN then
   spawnvar = variant
   spawnsub = KeySubType.KEY_GOLDEN
  elseif variant == PickupVariant.PICKUP_LIL_BATTERY and subtype ~= BatterySubType.BATTERY_GOLDEN then
   spawnvar = variant
   spawnsub = BatterySubType.BATTERY_GOLDEN
  elseif variant == PickupVariant.PICKUP_TRINKET and subtype < TrinketType.TRINKET_GOLDEN_FLAG then
    spawnvar = variant
    spawnsub = subtype | TrinketType.TRINKET_GOLDEN_FLAG
  elseif variant == PickupVariant.PICKUP_BOMB then
    if subtype == BombSubType.BOMB_TROLL then
      spawnvar = variant
      spawnsub = BombSubType.BOMB_GOLDENTROLL
    elseif subtype == BombSubType.BOMB_SUPERTROLL then
      if Isaac.GetEntityVariantByName("Golden Megatroll Bomb") > -1
      then
        spawnent = 4
        spawnvar = Isaac.GetEntityVariantByName("Golden Megatroll Bomb")
      else
        spawnvar = variant
        spawnsub = BombSubType.BOMB_GOLDENTROLL
      end
    elseif subtype ~= BombSubType.BOMB_GOLDEN then
      spawnvar = variant
      spawnsub = BombSubType.BOMB_GOLDEN
    end
  end
  if spawnvar then
    if spawnent == 5 then
      local newpickup = pickup:Morph(spawnent, spawnvar, spawnsub, true, true, true)
    else
      pickup:Remove()
      Isaac.Spawn(spawnent, spawnvar, spawnsub, savedpos, savedvel, nil)
    end
  end

end

wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PickupSelect_CurseOfTower2)


function wakaba:EntitySelect_CurseOfTower2(entitybomb)
  if not hastower then return end

  local variant = entitybomb.Variant
  local subtype = entitybomb.SubType
  local savedpos = entitybomb.Position + Vector.Zero
  local savedvel = entitybomb.Velocity + Vector.Zero
  local spawnent = 4
  local spawnvar = nil
  local spawnsub = 0
  local spent = entitybomb.SpawnerEntity

  if variant == BombVariant.BOMB_TROLL then
    spawnvar = BombVariant.BOMB_GOLDENTROLL
  elseif variant == BombVariant.BOMB_SUPERTROLL
  and Isaac.GetEntityVariantByName("Golden Megatroll Bomb") > -1
  then
    spawnvar = Isaac.GetEntityVariantByName("Golden Megatroll Bomb")
  end
  if spawnvar then
    entitybomb:Remove()
    Isaac.Spawn(spawnent, spawnvar, spawnsub, savedpos, savedvel, spent)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_BOMB_INIT, wakaba.EntitySelect_CurseOfTower2)