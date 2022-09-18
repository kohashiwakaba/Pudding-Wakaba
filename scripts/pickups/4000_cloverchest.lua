
wakaba.ChestSubType = {
  CLOSED = 1,
  OPEN = 0
}


function wakaba:manageCloverChests()
  local haspp = false
  
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i-1)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY) then
      haspp = true
      break
    end
  end
  local entities = Isaac.FindByType(5, wakaba.Enums.Pickups.CLOVER_CHEST, -1)
  for i, entity in ipairs(entities) do
    if entity.SubType == wakaba.ChestSubType.OPEN then
      entity:Remove()
    end
  end
  local pedestals = Isaac.FindByType(5, 100, -1)
  for i, entity in ipairs(pedestals) do
    if wakaba:has_value(wakaba.state.cloverchestpedestals, entity.InitSeed) then
      entity:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png") 
      if haspp then
        entity:GetSprite():SetOverlayFrame("Alternates", 16)
      else
        entity:GetSprite():SetOverlayFrame("Alternates", 10)
      end
      entity:GetSprite():LoadGraphics()
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.manageCloverChests)

function wakaba:NewLevel_ResetCloverChestData()
  wakaba.state.unlockedcloverchests = {}
  wakaba.state.cloverchestpedestals = {}
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_ResetCloverChestData)


function wakaba:ReplaceChests(pickup)
  local stage = wakaba.G:GetLevel():GetStage()
  wakaba.ItemRNG:SetSeed(pickup.DropSeed, 0)
  if wakaba.state.unlock.cloverchest > 0 
  and stage ~= LevelStage.STAGE6 
  and wakaba.ItemRNG:RandomFloat() < 0.05 
  and wakaba.G:GetRoom():GetType() ~= RoomType.ROOM_CHALLENGE then
    pickup:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.CLOSED)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.ReplaceChests, PickupVariant.PICKUP_CHEST)

function wakaba:ReplaceCloverChests(pickup)
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i-1)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY) then
      pickup:GetSprite():ReplaceSpritesheet(0, "gfx/cloverchest_pp.png") 
      pickup:GetSprite():LoadGraphics()
      break
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.ReplaceCloverChests, wakaba.Enums.Pickups.CLOVER_CHEST)

function wakaba:UpdateChests(pickup)
  if pickup:GetSprite():IsEventTriggered("DropSound") then
    SFXManager():Play(SoundEffect.SOUND_CHEST_DROP)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.UpdateChests, PickupVariant.PICKUP_CHEST)

function wakaba:spawnCloverChestReward(chest)
  local haspp = false
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i-1)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY) then
      haspp = true
      break
    end
  end
  -- 15% chance to spawn pedestal item
  if wakaba.RNG:RandomFloat() < 0.15 and wakaba:GetCurrentDimension() ~= 2 then
    local candidates = wakaba:GetCandidatesByCacheFlag(CacheFlag.CACHE_LUCK)
    local entry = wakaba.RNG:RandomInt(#candidates) + 1
    local item = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, candidates[entry], chest.Position, Vector.Zero, nil):ToPickup()
    item:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png") 
    if haspp then
      item:GetSprite():SetOverlayFrame("Alternates", 16)
    else
      item:GetSprite():SetOverlayFrame("Alternates", 10)
    end
    item:GetSprite():LoadGraphics()
    table.insert(wakaba.state.cloverchestpedestals, item.InitSeed)
    item.Wait = 10
    --local new = chest:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.OPEN)
    --new.Visible = false
    --new.EntityCollisionClass = 0
    chest:Remove()
  elseif wakaba.G:GetLevel():GetAbsoluteStage() == LevelStage.STAGE6 then
    local item = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, chest.Position, Vector.Zero, nil):ToPickup()
    item:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png") 
    if haspp then
      item:GetSprite():SetOverlayFrame("Alternates", 16)
    else
      item:GetSprite():SetOverlayFrame("Alternates", 10)
    end
    item:GetSprite():LoadGraphics()
    table.insert(wakaba.state.cloverchestpedestals, item.InitSeed)
    item.Wait = 10
    --local new = chest:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.OPEN)
    --new.Visible = false
    --new.EntityCollisionClass = 0
    chest:Remove()
  else
    -- 2 normal pickups
    for i=1,2 do
      local roll = wakaba.RNG:RandomFloat()
      if roll < 0.25 then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 0, chest.Position, wakaba.RandomVelocity(), nil)
      elseif roll < 0.5 then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, chest.Position, wakaba.RandomVelocity(), nil)
      elseif roll < 0.75 then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, chest.Position, wakaba.RandomVelocity(), nil)
      else
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 0, chest.Position, wakaba.RandomVelocity(), nil)
      end
    end

    -- 1 "lucky" option
    roll = wakaba.RNG:RandomFloat()
    if roll < 0.5 then
      Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_LUCKYPENNY, chest.Position, wakaba.RandomVelocity(), nil)
      Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_LUCKYPENNY, chest.Position, wakaba.RandomVelocity(), nil)
    else
      Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, chest.Position, wakaba.RandomVelocity(), nil)
    end 
  end
end

function wakaba:openCloverChest(player, pickup)
  
  local numRewards = 1
  if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KEY) then
    numRewards = numRewards * 2
  end
  if player:HasTrinket(wakaba.Enums.Trinkets.CLOVER) then
    numRewards = numRewards * 2
  end
  if player:HasTrinket(TrinketType.TRINKET_POKER_CHIP) then
    if wakaba.RNG:RandomFloat() < 0.5 then
      numRewards = 0
    else
      numRewards = numRewards * 2
    end
  end
  for i=1,numRewards do
    wakaba:spawnCloverChestReward(pickup)
  end
end

function wakaba:PickupCollision_CloverChest(pickup, collider, low)
  if pickup.SubType == wakaba.ChestSubType.CLOSED and collider.Type == EntityType.ENTITY_PLAYER then
    local player = collider:ToPlayer()
    if --[[ pickup:TryOpenChest(player) ]] player:HasGoldenKey() or player:GetNumKeys() > 0 
    or (player:HasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY) and player:GetNumCoins() > 0) then
      if not player:HasGoldenKey() then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY) then
          player:AddCoins(-1)
        else
          player:AddKeys(-1)
        end
      end
      pickup.Touched = true
    
      pickup:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.OPEN)
      SFXManager():Play(SoundEffect.SOUND_CHEST_OPEN)
      SFXManager():Play(SoundEffect.SOUND_UNLOCK00)
      wakaba:openCloverChest(player, pickup)
    end
  end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PickupCollision_CloverChest, wakaba.Enums.Pickups.CLOVER_CHEST)

function wakaba:TearUpdate_CloverChest(tear)
	local ents = Isaac.FindInRadius(tear.Position, 12)
	for i, entity in ipairs(ents) do
    if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == wakaba.Enums.Pickups.CLOVER_CHEST and entity.SubType == wakaba.ChestSubType.CLOSED then
      entity = entity:ToPickup()
      entity.Touched = true
    
      entity:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.OPEN)
      SFXManager():Play(SoundEffect.SOUND_CHEST_OPEN)
      SFXManager():Play(SoundEffect.SOUND_UNLOCK00)
  
      local spawner = tear.SpawnerEntity
      if spawner and spawner:ToPlayer() then
        wakaba:openCloverChest(spawner:ToPlayer(), entity)
      else
        wakaba:openCloverChest(Isaac.GetPlayer(), entity)
      end
    end
  end
end


wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_CloverChest, TearVariant.KEY)
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_CloverChest, TearVariant.KEY_BLOOD)