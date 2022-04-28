
wakaba.PILL_DAMAGE_MULTIPLIER_UP = Isaac.GetPillEffectByName("Damage Multiplier Up")
wakaba.PILL_DAMAGE_MULTIPLIER_DOWN = Isaac.GetPillEffectByName("Damage Multiplier Down")
wakaba.PILL_ALL_STATS_UP = Isaac.GetPillEffectByName("All Stats Up")
wakaba.PILL_ALL_STATS_DOWN = Isaac.GetPillEffectByName("All Stats Down")
wakaba.PILL_TROLLED = Isaac.GetPillEffectByName("Trolled!")
wakaba.PILL_TO_THE_START = Isaac.GetPillEffectByName("To the Start!")
wakaba.PILL_EXPLOSIVE_DIARRHEA_2 = Isaac.GetPillEffectByName("Explosive Diarrhea 2!")
wakaba.PILL_EXPLOSIVE_DIARRHEA_2_NOT = Isaac.GetPillEffectByName("Explosive Diarrhea 2?")
wakaba.PILL_SOCIAL_DISTANCE = Isaac.GetPillEffectByName("Social Distance")
wakaba.PILL_DUALITY_ORDERS = Isaac.GetPillEffectByName("Duality Orders")
wakaba.PILL_FLAME_PRINCESS = Isaac.GetPillEffectByName("Flame Princess!")
wakaba.PILL_FIREY_TOUCH = Isaac.GetPillEffectByName("Firey Touch")
wakaba.PILL_PRIEST_BLESSING = Isaac.GetPillEffectByName("Priest's Blessing")
wakaba.PILL_UNHOLY_CURSE = Isaac.GetPillEffectByName("Unholy Curse")

wakaba.minpillno = wakaba.PILL_DAMAGE_MULTIPLIER_UP
wakaba.maxpillno = wakaba.PILL_UNHOLY_CURSE

local convertPHD = {
  [wakaba.PILL_DAMAGE_MULTIPLIER_UP] = -1,
  [wakaba.PILL_DAMAGE_MULTIPLIER_DOWN] = wakaba.PILL_DAMAGE_MULTIPLIER_UP,
  [wakaba.PILL_ALL_STATS_UP] = -1,
  [wakaba.PILL_ALL_STATS_DOWN] = wakaba.PILL_ALL_STATS_UP,
  [wakaba.PILL_TO_THE_START] = -1,
  [wakaba.PILL_TROLLED] = wakaba.PILL_TO_THE_START,
  [wakaba.PILL_EXPLOSIVE_DIARRHEA_2] = -1,
  [wakaba.PILL_EXPLOSIVE_DIARRHEA_2_NOT] = wakaba.PILL_EXPLOSIVE_DIARRHEA_2,
  [wakaba.PILL_DUALITY_ORDERS] = -1,
  [wakaba.PILL_SOCIAL_DISTANCE] = wakaba.PILL_DUALITY_ORDERS,
  [wakaba.PILL_FLAME_PRINCESS] = -1,
  [wakaba.PILL_FIREY_TOUCH] = wakaba.PILL_FLAME_PRINCESS,
  [wakaba.PILL_PRIEST_BLESSING] = -1,
  [wakaba.PILL_UNHOLY_CURSE] = wakaba.PILL_PRIEST_BLESSING,
}
local convertFalsePHD = {
  [wakaba.PILL_DAMAGE_MULTIPLIER_UP] = wakaba.PILL_DAMAGE_MULTIPLIER_DOWN,
  [wakaba.PILL_DAMAGE_MULTIPLIER_DOWN] = -1,
  [wakaba.PILL_ALL_STATS_UP] = wakaba.PILL_ALL_STATS_DOWN,
  [wakaba.PILL_ALL_STATS_DOWN] = -1,
  [wakaba.PILL_TROLLED] = -1,
  [wakaba.PILL_TO_THE_START] = -1,
  [wakaba.PILL_EXPLOSIVE_DIARRHEA_2] = wakaba.PILL_EXPLOSIVE_DIARRHEA_2_NOT,
  [wakaba.PILL_DUALITY_ORDERS] = wakaba.PILL_SOCIAL_DISTANCE,
  [wakaba.PILL_SOCIAL_DISTANCE] = -1,
  [wakaba.PILL_FLAME_PRINCESS] = wakaba.PILL_FIREY_TOUCH,
  [wakaba.PILL_FIREY_TOUCH] = -1,
  [wakaba.PILL_PRIEST_BLESSING] = wakaba.PILL_UNHOLY_CURSE,
  [wakaba.PILL_UNHOLY_CURSE] = -1,
}
local pillClass = {
  [wakaba.PILL_DAMAGE_MULTIPLIER_DOWN] = -3,
  [wakaba.PILL_ALL_STATS_DOWN] = -3,
  [wakaba.PILL_TROLLED] = -3,
  [wakaba.PILL_SOCIAL_DISTANCE] = -2,
  [wakaba.PILL_FIREY_TOUCH] = -2,
  [wakaba.PILL_UNHOLY_CURSE] = -3,
}

local function hasPHD(player)
  if player:HasCollectible(CollectibleType.COLLECTIBLE_PHD)
  or player:HasCollectible(CollectibleType.COLLECTIBLE_VIRGO)
  or player:HasCollectible(CollectibleType.COLLECTIBLE_LUCKY_FOOT)
  then
    return true
  else
    return false
  end
end

local function hasFalsePHD(player)
  if player:HasCollectible(CollectibleType.COLLECTIBLE_FALSE_PHD)
  then
    return true
  else
    return false
  end
end

function wakaba:IsPlayerUsingHorsePill(player, useFlags)
  local pillColour = player:GetPill(0)

  local holdingHorsePill = pillColour & PillColor.PILL_GIANT_FLAG > 0
  local proccedByEchoChamber = useFlags & (1 << 11) > 0 -- idk why this useflag isn't enumerated

  return holdingHorsePill and not proccedByEchoChamber
end

function wakaba:getPillEffect(pillEffect, pillColor)
  local phd = false
  local fhd = false
  local estdamage = 3.5
  for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
    if hasPHD(player) then phd = true; estdamage = player.Damage end
    if hasFalsePHD(player) then fhd = true end
    if pillEffect == wakaba.PILL_SOCIAL_DISTANCE 
    and Game():IsGreedMode() then
      return wakaba.PILL_ALL_STATS_UP
    end
    if pillEffect == wakaba.PILL_FIREY_TOUCH then
      if wakaba.state.options.flamescurserate == 0 then
        return wakaba.PILL_EXPLOSIVE_DIARRHEA_2
      end
    end
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Wakaba", false) then
      if pillEffect == PillEffect.PILLEFFECT_LUCK_DOWN then
        if fhd then
          return PillEffect.PILLEFFECT_SPEED_DOWN
        else
          return PillEffect.PILLEFFECT_LUCK_UP
        end
      elseif pillEffect == PillEffect.PILLEFFECT_SPEED_UP then
        if phd then
          return PillEffect.PILLEFFECT_LUCK_UP
        else
          return PillEffect.PILLEFFECT_SPEED_DOWN
        end
      end
    elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) then
      if pillEffect == PillEffect.PILLEFFECT_LUCK_UP then
        if phd then
          return wakaba.PILL_DAMAGE_MULTIPLIER_UP
        else
          return PillEffect.PILLEFFECT_LUCK_DOWN
        end
      end
    elseif player:GetPlayerType() == 21 then
      if pillEffect == wakaba.PILL_FLAME_PRINCESS then
		  	pillEffect = convertFalsePHD[pillEffect]
      end
    elseif player:GetPlayerType() == 30 then
      if pillEffect == wakaba.PILL_FLAME_PRINCESS then
		  	pillEffect = convertFalsePHD[pillEffect]
      end
    end
  end
	if phd and not fhd then
    if convertPHD[pillEffect] ~= nil then
		  if convertPHD[pillEffect] ~= -1 then
		  	pillEffect = convertPHD[pillEffect]
		  end
    end
  elseif not phd and fhd then
    if convertFalsePHD[pillEffect] ~= nil then
		  if convertFalsePHD[pillEffect] ~= -1 then
		  	pillEffect = convertFalsePHD[pillEffect]
		  end
    end
  end
  return pillEffect
end
wakaba:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, wakaba.getPillEffect) 

function wakaba:PlayerUpdate_Pills(player)

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Pills)

function wakaba:useWakabaPill(pillEffect, player, useFlags)
  local isHorse = wakaba:IsPlayerUsingHorsePill(player, useFlags)
  local multiplier = 1
  if isHorse then
    multiplier = 2
  end
  --print(isHorse)
  if wakaba:getstoredindex(player) ~= nil then
    if pillEffect == wakaba.PILL_DAMAGE_MULTIPLIER_UP then
      player:GetData().wakaba.statmultiplier.damage = player:GetData().wakaba.statmultiplier.damage + (0.08 * multiplier)
      player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
      player:EvaluateItems()
      player:AnimateHappy()
      SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
    elseif pillEffect == wakaba.PILL_DAMAGE_MULTIPLIER_DOWN then
      player:GetData().wakaba.statmultiplier.damage = player:GetData().wakaba.statmultiplier.damage - (0.02 * multiplier)
      player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
      player:EvaluateItems()
      player:AnimateSad()
    elseif pillEffect == wakaba.PILL_ALL_STATS_UP then
      player:GetData().wakaba.statmodify.damage = player:GetData().wakaba.statmodify.damage + (0.25 * multiplier)
      player:GetData().wakaba.statmodify.tears = player:GetData().wakaba.statmodify.tears + (0.2 * multiplier)
      player:GetData().wakaba.statmodify.range = player:GetData().wakaba.statmodify.range + (0.4 * multiplier)
      player:GetData().wakaba.statmodify.luck = player:GetData().wakaba.statmodify.luck + (1 * multiplier)
      player:GetData().wakaba.statmodify.speed = player:GetData().wakaba.statmodify.speed + (0.12 * multiplier)
      player:GetData().wakaba.statmodify.shotspeed = player:GetData().wakaba.statmodify.shotspeed + (0.08 * multiplier)
      player:AddCacheFlags(CacheFlag.CACHE_ALL)
      player:EvaluateItems()
      player:AnimateHappy()
      SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
    elseif pillEffect == wakaba.PILL_ALL_STATS_DOWN then
      player:GetData().wakaba.statmodify.damage = player:GetData().wakaba.statmodify.damage - (0.1 * multiplier)
      player:GetData().wakaba.statmodify.tears = player:GetData().wakaba.statmodify.tears - (0.08 * multiplier)
      player:GetData().wakaba.statmodify.range = player:GetData().wakaba.statmodify.range - (0.25 * multiplier)
      player:GetData().wakaba.statmodify.luck = player:GetData().wakaba.statmodify.luck - (1 * multiplier)
      player:GetData().wakaba.statmodify.speed = player:GetData().wakaba.statmodify.speed - (0.09 * multiplier)
      player:GetData().wakaba.statmodify.shotspeed = player:GetData().wakaba.statmodify.shotspeed - (0.06 * multiplier)
      player:AddCacheFlags(CacheFlag.CACHE_ALL)
      player:EvaluateItems()
      player:AnimateSad()
    elseif pillEffect == wakaba.PILL_TROLLED then
      local hasBeast = wakaba:HasBeast()
      if hasBeast then
        for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_BEAST, -1, -1, false, false)) do
          entity.HitPoints = entity.MaxHitPoints
        end
        player:AnimateSad()
      elseif Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE8 or Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE4_3 then
        player.AddCollectible(player, CollectibleType.COLLECTIBLE_TMTRAINER)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(player.Position, 32), Vector(0,0), nil)
        if isHorse then
          Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(player.Position, 64), Vector(0,0), nil)
        end
        player.RemoveCollectible(player, CollectibleType.COLLECTIBLE_TMTRAINER)
        player:AnimateSad()
      else
        Game():StartRoomTransition(-2,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
        if isHorse then
          player:AddBrokenHearts(-1)
        end
      end
    elseif pillEffect == wakaba.PILL_TO_THE_START then
      local hasBeast = wakaba:HasBeast()
      if hasBeast then
        for i = 1, Game():GetNumPlayers() do
	      	local player = Isaac.GetPlayer(i - 1)
          player:AddHearts(24)
          player:AddSoulHearts(24)
        end
        player:AnimateHappy()
        SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
      else
        if isHorse then
          if player:CanPickRedHearts() then
            player:AddHearts(2)
          else
            player:AddSoulHearts(2)
          end
          player:AddBrokenHearts(-1)
        end
        Game():StartRoomTransition(Game():GetLevel():GetStartingRoomIndex(),Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
      end
    elseif pillEffect == wakaba.PILL_EXPLOSIVE_DIARRHEA_2_NOT then
      player:UseCard(Card.CARD_SOUL_AZAZEL, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
    elseif pillEffect == wakaba.PILL_EXPLOSIVE_DIARRHEA_2 then
      wakaba:GetPlayerEntityData(player)
      player:GetData().wakaba.trollbrimstonecounter = player:GetPillRNG(wakaba.PILL_EXPLOSIVE_DIARRHEA_2):RandomInt(100)
      Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ENEMY_BRIMSTONE_SWIRL, 0, player.Position, Vector.Zero, nil)
      if isHorse then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_HEAD_OF_KRAMPUS, UseFlag.USE_NOANIM | UseFlag.USE_VOID)
      end
      player:AnimateSad()
    elseif pillEffect == wakaba.PILL_DUALITY_ORDERS then


      if isHorse then
        Game():SetLastDevilRoomStage(-1)
      end
    elseif pillEffect == wakaba.PILL_SOCIAL_DISTANCE then
      Game():GetLevel():DisableDevilRoom()
      if isHorse then
        Game():SetLastDevilRoomStage(Game():GetLevel():GetAbsoluteStage())
      end
      player:AnimateSad()
    elseif pillEffect == wakaba.PILL_FLAME_PRINCESS then
      local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, -1, false, false)
      local haswisp = false
      local wispcnt = 0
      for i, e in ipairs(wisps) do
        if e.SpawnerEntity.Index == player.Index then
          if wispcnt * 2 > multiplier * #wisps then break end
          haswisp = true
          e.HitPoints = e.MaxHitPoints
          if isHorse then
            e.HitPoints = e.MaxHitPoints * 3
          end
        end
      end
      local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
      for i, e in ipairs(wisps) do
        if e.SpawnerEntity.Index == player.Index then
          haswisp = true
          local item = e.SubType
          local config = Isaac.GetItemConfig():GetCollectible(item)
          if config and (config.Type == ItemType.ITEM_PASSIVE or config.Type == ItemType.ITEM_FAMILIAR) then
            e:Kill()
            player:AddCollectible(item)
            if isHorse then
              player:AddCollectible(item)
            end
          else
            e.HitPoints = e.MaxHitPoints
            if isHorse then
              e.HitPoints = e.MaxHitPoints * 3
            end
          end
        else
          e.HitPoints = e.MaxHitPoints
        end
      end
      if not haswisp then
        local familiar = player:AddWisp(0, player.Position, true, false)
				familiar.Parent = collider
				familiar.Player = player
				familiar.CollisionDamage = familiar.CollisionDamage * 12
				familiar.MaxHitPoints = familiar.MaxHitPoints * 12
				familiar.HitPoints = familiar.MaxHitPoints
        if isHorse then
          familiar.MaxHitPoints = familiar.MaxHitPoints * 2
          familiar.HitPoints = familiar.MaxHitPoints
        end
      end

      player:AnimateHappy()
      SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
    elseif pillEffect == wakaba.PILL_FIREY_TOUCH then
      Game():GetLevel():AddCurse(wakaba.curses.CURSE_OF_FLAMES)
      local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, -1, false, false)
      for i, e in ipairs(wisps) do
        if e.SpawnerEntity.Index == player.Index then
          e.HitPoints = e.MaxHitPoints
          if isHorse then
            e.HitPoints = e.MaxHitPoints * 3
          end
        end
      end
      local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
      for i, e in ipairs(wisps) do
        if e.SpawnerEntity.Index == player.Index then
          e.HitPoints = e.MaxHitPoints
          if isHorse then
            e.HitPoints = e.MaxHitPoints * 3
          end
        end
      end
      player:AnimateSad()
    elseif pillEffect == wakaba.PILL_PRIEST_BLESSING then
      player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER)
      if multiplier == 2 then
        player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER)
      end
      player:AnimateHappy()
      SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
    elseif pillEffect == wakaba.PILL_UNHOLY_CURSE then
      if player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) > 0 then
        if multiplier == 2 and player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) > 1 then
          player:TakeDamage(1, DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(player), 0)
        end
        player:TakeDamage(1, DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(player), 0)
      end
      player:AnimateSad()
    end
    
    if pillClass[pillEffect] then
      if pillClass[pillEffect] == -3 then
        player:GetData().wakaba.statmodify.falsedamage = player:GetData().wakaba.statmodify.falsedamage + (0.6 * multiplier)
      elseif pillClass[pillEffect] == -2 or pillClass[pillEffect] == -1 then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_FALSE_PHD) then
          Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
          if isHorse then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
          end
        end
      end
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_USE_PILL, wakaba.useWakabaPill) 

function wakaba:onPillCache(player, cacheFlag)
  local sti = player:GetData().wakaba
  if sti and sti.statmodify then
    if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
      player.Damage = player.Damage + sti.statmodify.damage
      if player:HasCollectible(CollectibleType.COLLECTIBLE_FALSE_PHD) then
        player.Damage = player.Damage + sti.statmodify.falsedamage
      end
      player.Damage = player.Damage * (1 + sti.statmultiplier.damage)
    end
    if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
      player.ShotSpeed = player.ShotSpeed + sti.statmodify.shotspeed
    end
    if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
      player.TearRange = player.TearRange + (sti.statmodify.range * 40)
    end
    if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
      player.MoveSpeed = player.MoveSpeed + sti.statmodify.speed
    end
    if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
      player.Luck = player.Luck + sti.statmodify.luck
    end
    if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
      player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, sti.statmodify.tears)
    end
  end
	
end
 
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onPillCache)


--Updates the Passive Effects

function wakaba:onPillUpdate(player)
  wakaba:GetPlayerEntityData(player)
  player:GetData().wakaba.trollbrimstonecounter = player:GetData().wakaba.trollbrimstonecounter or -1
  if player:GetData().wakaba.trollbrimstonecounter > -1 then
    player:GetData().wakaba.trollbrimstonecounter = player:GetData().wakaba.trollbrimstonecounter - 1
    if player:GetData().wakaba.trollbrimstonecounter == 0 then
      Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ENEMY_BRIMSTONE_SWIRL, 0, player.Position, Vector.Zero, nil)
    end
  end
end

wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.onPillUpdate)



function wakaba:PlayerInit_Pills(player)
	if player:GetPlayerType() == PlayerType.PLAYER_THELOST_B then
    local pool = Game():GetItemPool()
    local hasPriest = false
    for i = 1, 13 do
      if pool:GetPillEffect(i) == wakaba.PILL_PRIEST_BLESSING then
        pool:IdentifyPill(i)
        hasPriest = true
      end
    end
    if not hasPriest then
      local pill = pool:ForceAddPillEffect(wakaba.PILL_PRIEST_BLESSING)
      pool:IdentifyPill(pill)
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PlayerInit_Pills, 0)

