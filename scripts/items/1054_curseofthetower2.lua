local hastower = false
local haspb = false
local rolledPickup = {
  PickupVariant.PICKUP_COIN,
  PickupVariant.PICKUP_GRAB_BAG,
  PickupVariant.PICKUP_HEART,
  PickupVariant.PICKUP_KEY,
  PickupVariant.PICKUP_LIL_BATTERY,
  PickupVariant.PICKUP_PILL,
  PickupVariant.PICKUP_TAROTCARD,
  PickupVariant.PICKUP_TRINKET,
}

function wakaba:Update_CurseOfTower2()
  hastower = false
  haspb = false
  for num = 1, Game():GetNumPlayers() do
    local player = Game():GetPlayer(num - 1)
    if player:HasCollectible(wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2) then
      hastower = true
      if not player:HasGoldenBomb() then
        player:AddGoldenBomb()
      end
    end
    if player:HasCollectible(wakaba.Enums.Collectibles.POWER_BOMB) then
      haspb = true
    end
  end
end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_CurseOfTower2)

function wakaba:PickupSelect_CurseOfTower2(pickup)
  if not hastower or haspb then return end
  local variant = pickup.Variant
  local subtype = pickup.SubType
  local savedpos = pickup.Position + Vector.Zero
  local savedvel = pickup.Velocity + Vector.Zero
  local spawnent = 5
  local spawnvar = nil
  local spawnsub = 0
  if variant == PickupVariant.PICKUP_BOMB then
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
      local rng = RNG()
      rng:SetSeed(pickup.InitSeed, 35)
      spawnvar = rolledPickup[rng:RandomInt(#rolledPickup) + 1]
      spawnsub = 0
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

function wakaba:TakeDamage_CurseOfTower2(entity, amount, flags, source, cooldown)
	local player = entity:ToPlayer()
	if player then
		if player:HasCollectible(wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2) 
    and flags & DamageFlag.DAMAGE_RED_HEARTS ~= DamageFlag.DAMAGE_RED_HEARTS
    and flags & DamageFlag.DAMAGE_NO_PENALTIES ~= DamageFlag.DAMAGE_NO_PENALTIES then
      wakaba:RegisterHeart(player)
			--[[ if flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION then
				entity:ToPlayer():SetMinDamageCooldown(1)
				return false
			end
			if flags & DamageFlag.DAMAGE_CRUSH == DamageFlag.DAMAGE_CRUSH then
				entity:ToPlayer():SetMinDamageCooldown(1)
				return false
			end ]]
      --Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_GOLDENTROLL, 0, wakaba:RandomNearbyPosition(entity), Vector.Zero, nil)
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_CurseOfTower2, EntityType.ENTITY_PLAYER)

