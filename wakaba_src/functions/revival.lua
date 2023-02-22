local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:IsLost(player)
  if player:GetPlayerType() == PlayerType.PLAYER_THELOST then return true end
  if player:GetPlayerType() == PlayerType.PLAYER_THELOST_B then return true end
  if player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B then return true end
  if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B then return true end
  if player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) then return true end
end

function wakaba:HasCard(player, card)
	for i = 0, 3 do
		if player:GetCard(i) == card then return true end
	end
	return false
end

function wakaba:CanRevive(player)
  if not player then return false end
  if player:WillPlayerRevive() then 
		if not (not wakaba:HasCard(player, Card.CARD_SOUL_LAZARUS) and player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)) then return false end
		--return false 
	end
  if player:GetBabySkin() == BabySubType.BABY_FOUND_SOUL then return false end
  local data = player:GetData()
  if player:GetData().wakaba.vintagethreat then return false end
  if wakaba:hasLunarStone(player, true) and data.wakaba.lunargauge and data.wakaba.lunargauge > 0 then
    return {ID = wakaba.Enums.Collectibles.LUNAR_STONE, PostRevival = function() wakaba:AfterRevival_LunarStone(player) end}
  elseif wakaba:HasWisp(player, wakaba.Enums.Collectibles.QUESTION_BLOCK) then
    return {ID = wakaba.Enums.Collectibles.QUESTION_BLOCK, PostRevival = function() wakaba:AfterRevival_QuestionBlock(player) end}
  elseif wakaba:HasWisp(player, wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER) then
    return {ID = wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER, PostRevival = function() wakaba:AfterRevival_GrimreaperDefender(player) end}
  elseif player:HasCollectible(wakaba.Enums.Collectibles.SEE_DES_BISCHOFS) then
    return {ID = wakaba.Enums.Collectibles.SEE_DES_BISCHOFS, PostRevival = function() wakaba:AfterRevival_LakeOfBishop(player) end}
  elseif player:HasCollectible(wakaba.Enums.Collectibles.JAR_OF_CLOVER) then
    return {ID = wakaba.Enums.Collectibles.JAR_OF_CLOVER, PostRevival = function() wakaba:AfterRevival_JarOfClover(player) end}
  elseif player:HasCollectible(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE) then
    return {ID = wakaba.Enums.Collectibles.CARAMELLA_PANCAKE, PostRevival = function() wakaba:AfterRevival_CaramellaPancake(player) end}
  elseif player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_THE_GOD) then
    return {ID = wakaba.Enums.Collectibles.BOOK_OF_THE_GOD, PostRevival = function() wakaba:AfterRevival_BookOfTheGod(player) end}
  elseif player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN) and not player:GetData().wakaba.shioridevil then
    return {ID = wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN, PostRevival = function() wakaba:AfterRevival_BookOfTheFallen(player) end}
  elseif player:HasCollectible(wakaba.Enums.Collectibles.VINTAGE_THREAT) and not player:GetData().wakaba.vintagethreat then
    return {ID = wakaba.Enums.Collectibles.VINTAGE_THREAT, PostRevival = function() wakaba:AfterRevival_VintageThreat(player) end, CurrentRoom = true}
  end
  return false
end




function wakaba:IsPlayerDying(player)
  return player:GetSprite():GetAnimation():sub(-#"Death") == "Death" --does their current animation end with "Death"?
end
function wakaba:IsPlayerDuringRevival(player)
  return player:GetSprite():GetAnimation():find("^Pickup") --does their current animation start with "Pickup"?
end

function wakaba:IsHeartEmpty(player)
  if player:GetHearts() == 0 and player:GetSoulHearts() == 0 and player:GetBoneHearts() == 0 then
    return true
  end
end

function wakaba:isMausoleumDoor(damageflag)
	if not damageflag then return false end
	
	if damageflag & DamageFlag.DAMAGE_SPIKES == DamageFlag.DAMAGE_SPIKES
	and damageflag & DamageFlag.DAMAGE_INVINCIBLE == DamageFlag.DAMAGE_INVINCIBLE
	and damageflag & DamageFlag.DAMAGE_NO_MODIFIERS == DamageFlag.DAMAGE_NO_MODIFIERS
	and damageflag & DamageFlag.DAMAGE_NO_PENALTIES == DamageFlag.DAMAGE_NO_PENALTIES
	then
		local isBossRoom = wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSS
		local stage = wakaba.G:GetLevel():GetAbsoluteStage()
		local isRepentance = (wakaba.G:GetLevel():GetStageType() == StageType.STAGETYPE_REPENTANCE or wakaba.G:GetLevel():GetStageType() == StageType.STAGETYPE_REPENTANCE_B)
		if isBossRoom then
			if (stage == LevelStage.STAGE2_2 and isRepentance)
      or (stage == LevelStage.STAGE2_1 and isRepentance)
			or (stage == LevelStage.STAGE3_1 and not isRepentance)
			then
				return true
			end
		else
			return false
		end
	else
		return false
	end
end

function wakaba:IsSacrificeRoomSpikes(flag)
  return (wakaba.G:GetRoom():GetType() == RoomType.ROOM_SACRIFICE and flag & DamageFlag.DAMAGE_SPIKES == DamageFlag.DAMAGE_SPIKES)
end
--[[ 
function wakaba:PlayDeathAnimationWithRevival(player, itemID, currentroom)
  currentroom = currentroom or false
  wakaba:GetPlayerEntityData(player)
  local data = player:GetData()
  player.Velocity = Vector.Zero
  player.ControlsEnabled = false
  data.wakaba.reviveanim = itemID
  data.wakaba.revivecurrentroom = currentroom
end
 ]]
 --[[ 
function wakaba:AddPostRevive(player, func)
  wakaba:GetPlayerEntityData(player)
  player:GetData().wakaba.postrevivefunction = func
end
 ]]
 --[[ 
function wakaba:UseItem_Revival(usedItem, rng, player, flags, slot, vardata)
  local revivaldata = wakaba:CanRevive(player) or wakaba:CanRevive(player:GetOtherTwin())
  if not revivaldata then return end
  if usedItem == CollectibleType.COLLECTIBLE_BIBLE then
    local level = wakaba.G:GetLevel()
    local room = wakaba.G:GetRoom()
    if room and room:GetBossID() == 24 then
      if not player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
        player:GetEffects():AddNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
      end
      wakaba:PlayDeathAnimationWithRevival(player, revivaldata.ID)
      wakaba:AddPostRevive(player, revivaldata.PostRevival)
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.UseItem_Revival)
 ]]

function wakaba:PlayerUpdate_Revival(player)
  wakaba:GetPlayerEntityData(player)
  local data = player:GetData()
  if wakaba:IsHeartDifferent(player) then
    local damageTriggered = data.wakaba.damageTriggered
    wakaba:RemoveRegisteredHeart(player)
		if damageTriggered[wakaba.Enums.Collectibles.LUNAR_STONE] then
			--data.wakaba.lunargauge = data.wakaba.lunargauge or 1000000
			data.wakaba.lunargauge = data.wakaba.lunargauge - 40000
			data.wakaba.lunarregenrate = data.wakaba.lunarregenrate or 0
			if data.wakaba.lunarregenrate >= 0 then
				data.wakaba.lunarregenrate = -25
			else
				data.wakaba.lunarregenrate = data.wakaba.lunarregenrate - 5
			end
			SFXManager():Play(SoundEffect.SOUND_GLASS_BREAK, 2, 0, false, 1)
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		end
    if damageTriggered[wakaba.Enums.Collectibles.EATHEART] then
      wakaba:ChargeEatHeart(player, 1, "PlayerDamage")
    end
    if damageTriggered[wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2] then
      Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_GOLDENTROLL, 0, wakaba:RandomNearbyPosition(player), Vector.Zero, nil)
    end
    if damageTriggered[wakaba.Enums.Collectibles.LUNAR_DAMOCLES] then
      if not player:HasCurseMistEffect() then
        data.wakaba.lunardamotriggered = true
      end
    end
    if damageTriggered[wakaba.Enums.Trinkets.MISTAKE + 65535] then
			wakaba:Trigger_Mistake(player)
    end
    data.wakaba.damageTriggered = {}
  end
  --[[ 
  local revivaldata = wakaba:CanRevive(player) or wakaba:CanRevive(player:GetOtherTwin())
  data.wakaba.checkForDevilDealRevive = data.wakaba.checkForDevilDealRevive or false
  if revivaldata and wakaba:IsHeartEmpty(player) and not player:IsItemQueueEmpty() then
    data.wakaba.checkForDevilDealRevive = true
    if not player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
      player:GetEffects():AddNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
    end
  end
  if data.wakaba.checkForDevilDealRevive and player:IsItemQueueEmpty() then
    if not wakaba:IsHeartEmpty(player) and player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
      player:GetEffects():RemoveNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
    elseif revivaldata then
      wakaba:PlayDeathAnimationWithRevival(player, revivaldata.ID)
      wakaba:AddPostRevive(player, revivaldata.PostRevival)
    end
    data.wakaba.checkForDevilDealRevive = nil
  end

  if revivaldata and wakaba:IsPlayerDying(player) then
    if not player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
      player:GetEffects():AddNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
    end
    if not player:WillPlayerRevive() then
      if player:GetOtherTwin() and wakaba:IsPlayerDying(player:GetOtherTwin()) then
        if not player:GetOtherTwin():GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
          player:GetOtherTwin():GetEffects():AddNullEffect(NullItemID.ID_LAZAUS_SOUL_REVIVE)
          player:GetOtherTwin():SetMinDamageCooldown(180)
        end
      end
      wakaba:PlayDeathAnimationWithRevival(player, revivaldata.ID)
      if revivaldata.PostRevival then
        wakaba:AddPostRevive(player, revivaldata.PostRevival)
      end
    end
  end

  if data.wakaba.revivefinished and wakaba:IsPlayerDying(player) then
    player:GetSprite():SetLastFrame()
    player:StopExtraAnimation()
  elseif data.wakaba.revivefinished and player:AreControlsEnabled() then
    player:AnimateCollectible(data.wakaba.reviveanim)
    player:SetMinDamageCooldown(180)
    data.wakaba.reviveanim = nil
    data.wakaba.revivefinished = nil
    data.wakaba.revivecurrentroom = nil
    player.ControlsEnabled = true
    if data.wakaba.postrevivefunction then -- moved here to handle delay
      data.wakaba.postrevivefunction(player)
      data.wakaba.postrevivefunction = nil
    end
    if data.wakaba.reviveasjudas then
      player:ChangePlayerType(PlayerType.PLAYER_BLACKJUDAS)
    end
    if player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
      player:GetEffects():RemoveNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
    end
  elseif data.wakaba.reviveanim then
    player.Velocity = Vector.Zero
    if player:IsDead() and player:GetSprite():IsFinished(player:GetSprite():GetAnimation()) then 
      if not data.wakaba.revivecurrentroom and not wakaba:HasBeast() then

        local level = wakaba.G:GetLevel()
        local room = wakaba.G:GetRoom()
  
        local enterDoorIndex = level.EnterDoor
        if enterDoorIndex == -1 or room:GetDoor(enterDoorIndex) == nil or level:GetCurrentRoomIndex() == level:GetPreviousRoomIndex() then
          if level:GetCurrentRoomIndex() == level:GetPreviousRoomIndex() then
            wakaba.G:StartRoomTransition(level:GetCurrentRoomIndex(), Direction.NO_DIRECTION, RoomTransitionAnim.ANKH)
          elseif room:GetDoor(enterDoorIndex) ~= nil then
            --print("try1")
            local enterDoor = room:GetDoor(enterDoorIndex)
            local targetRoomDirection = enterDoor.Direction
            wakaba.G:StartRoomTransition(level:GetPreviousRoomIndex(), targetRoomDirection, RoomTransitionAnim.ANKH)
          else
            wakaba.G:StartRoomTransition(level:GetPreviousRoomIndex(), Direction.NO_DIRECTION, RoomTransitionAnim.ANKH)
          end
        else
          local enterDoor = room:GetDoor(enterDoorIndex)
          local targetRoomIndex = enterDoor.TargetRoomIndex
          local targetRoomDirection = enterDoor.Direction
  
          level.LeaveDoor = -1 -- api why
          wakaba.G:StartRoomTransition(targetRoomIndex, targetRoomDirection, RoomTransitionAnim.ANKH)
        end
      else
        player.ControlsEnabled = true
      end
      data.wakaba.revivefinished = true
    end
  elseif wakaba:IsPlayerDuringRevival(player) and player:GetSprite():IsFinished(player:GetSprite():GetAnimation()) then
    if player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
      player:GetEffects():RemoveNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
    end
  end
 ]]
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Revival)


function wakaba:TakeDmg_Revival(entity, amount, flag, source, countdown)
	local playerData = wakaba:GetPlayerEntityData(entity:ToPlayer())

  wakaba:TakeDamage_CurseOfTower2(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_EatHeart(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_LunarStone(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_Concentration(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_Elixir(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_LunarDamocles(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_Mistake(entity, amount, flag, source, countdown)
--[[ 
  if source.Type == EntityType.ENTITY_FAMILIAR and source.Variant == FamiliarVariant.DAMOCLES then
    local revivaldata = wakaba:CanRevive(player)
    if revivaldata then
      wakaba:PlayDeathAnimationWithRevival(player, revivaldata.ID, revivaldata.CurrentRoom)
      wakaba:AddPostRevive(player, revivaldata.PostRevival)
      player:GetEffects():AddNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
    end
  end
 ]]

end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_Revival, EntityType.ENTITY_PLAYER)

function wakaba:detectPlanC(useditem, rng, player, useflag, slot, vardata)
	if wakaba:HasJudasBr(player) then
    wakaba:GetPlayerEntityData(player)
    player:GetData().wakaba.reviveasjudas = true
  end
end
--wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.detectPlanC, CollectibleType.COLLECTIBLE_PLAN_C)

-- CustomHealthAPI Why..
function wakaba:detectPotatoPeeler(useditem, rng, player, useflag, slot, vardata)
	if CustomHealthAPI and not (isc:hasLostCurse(player) or player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B) then
    wakaba:GetPlayerEntityData(player)
    local data = player:GetData()
    if player:GetEffectiveMaxHearts() <= 2 and player:GetSoulHearts() == 0 then
      local revivaldata = wakaba:CanRevive(player)
      if revivaldata then
        wakaba:PlayDeathAnimationWithRevival(player, revivaldata.ID, revivaldata.CurrentRoom)
        wakaba:AddPostRevive(player, revivaldata.PostRevival)
        player:GetEffects():AddNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
      end
    elseif player:GetEffectiveMaxHearts() > 2 then
      player:AddMaxHearts(2)
      player:AddHearts(2)
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.detectPotatoPeeler, CollectibleType.COLLECTIBLE_POTATO_PEELER)

if DetailedRespawnGlobalAPI then
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Lunar Stone",
    itemId = wakaba.Enums.Collectibles.LUNAR_STONE,
    condition = function(self, player)
      local canRevive = wakaba:CanRevive(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.LUNAR_STONE
    end,
    additionalText = "xInf",
  }, DetailedRespawnGlobalAPI.RespawnPosition.Last)
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Question Block Wisp",
    itemId = wakaba.Enums.Collectibles.QUESTION_BLOCK,
    condition = function(_, player)
      local canRevive = wakaba:CanRevive(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.QUESTION_BLOCK
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Lunar Stone"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Grimreaper Defender Wisp",
    itemId = wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER,
    condition = function(_, player)
      local canRevive = wakaba:CanRevive(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Question Block Wisp"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Book of the God",
    itemId = wakaba.Enums.Collectibles.BOOK_OF_THE_GOD,
    condition = function(_, player)
      local canRevive = wakaba:CanRevive(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.BOOK_OF_THE_GOD or player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_THE_GOD)
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Grimreaper Defender Wisp"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "See Des Bischofs",
    itemId = wakaba.Enums.Collectibles.SEE_DES_BISCHOFS,
    condition = function(_, player)
      local canRevive = wakaba:CanRevive(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.SEE_DES_BISCHOFS or player:HasCollectible(wakaba.Enums.Collectibles.SEE_DES_BISCHOFS)
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Book of the God"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Jar of Clover",
    itemId = wakaba.Enums.Collectibles.JAR_OF_CLOVER,
    condition = function(_, player)
      local canRevive = wakaba:CanRevive(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.JAR_OF_CLOVER or player:HasCollectible(wakaba.Enums.Collectibles.JAR_OF_CLOVER)
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("See Des Bischofs"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Caramella Pancake",
    itemId = wakaba.Enums.Collectibles.CARAMELLA_PANCAKE,
    condition = function(_, player)
      local canRevive = wakaba:CanRevive(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.CARAMELLA_PANCAKE or player:HasCollectible(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE)
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Jar of Clover"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Book of the Fallen",
    itemId = wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN,
    condition = function(_, player)
      local canRevive = wakaba:CanRevive(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN or player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN)
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Caramella Pancake"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Vintage Threat",
    itemId = wakaba.Enums.Collectibles.VINTAGE_THREAT,
    condition = function(_, player)
      local canRevive = wakaba:CanRevive(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.VINTAGE_THREAT or player:HasCollectible(wakaba.Enums.Collectibles.VINTAGE_THREAT)
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Book of the Fallen"))
end



-- Barebone function by Mr.SeemsGood
--[[ 
local function isPlayerDying(player)
  if player:GetBabySkin() == BabySubType.BABY_FOUND_SOUL then return end
  -- and by 'dying' I (unfortunately) mean 'playing death animation'
  local sprite = player:GetSprite()
  
  return (sprite:IsPlaying("Death") and sprite:GetFrame() > 50) or
  (sprite:IsPlaying("LostDeath") and sprite:GetFrame() > 30)
end

local function reviveWithTwin(player)
  -- allows you to revive the player, give them short i-v frames, and revive their twin (e.g. Esau or Tainted Soul)
  player:Revive()
  player:SetMinDamageCooldown(40)
  if player:GetOtherTwin() then
      player:GetOtherTwin():Revive()
      player:GetOtherTwin():SetMinDamageCooldown(40)
  end
end

-- run these on MC_POST_UPDATE, MC_POST_PLAYER_UPDATE or MC_POST_PEFFECT_UPDATE
 ]]

 function wakaba:PostPlayerFatalDamage(player)
  wakaba:GetPlayerEntityData(player)
  local data = player:GetData()
  if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER) then
    isc:useActiveItemTemp(player, CollectibleType.COLLECTIBLE_DULL_RAZOR)
    return false
  elseif player:HasTrinket(wakaba.Enums.Trinkets.DETERMINATION_RIBBON) then
    if player:GetTrinketMultiplier(wakaba.Enums.Trinkets.DETERMINATION_RIBBON) < 5 then
      local chance = player:GetTrinketRNG(wakaba.Enums.Trinkets.DETERMINATION_RIBBON):RandomInt(1000000)
      local threshold = 20000
      if wakaba.G.Difficulty == Difficulty.DIFFICULTY_NORMAL or wakaba.G.Difficulty == Difficulty.DIFFICULTY_GREED then
        threshold = threshold / 4
      end
      if player:GetTrinketMultiplier(wakaba.Enums.Trinkets.DETERMINATION_RIBBON) > 0 then
        threshold = threshold / player:GetTrinketMultiplier(wakaba.Enums.Trinkets.DETERMINATION_RIBBON)
      end
      --print(chance, threshold)
      if chance < threshold then
        --player:DropTrinket(player.Position, false)
        player:TryRemoveTrinket(wakaba.Enums.Trinkets.DETERMINATION_RIBBON)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.Enums.Trinkets.DETERMINATION_RIBBON, wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, nil)
        player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
      end
    end
    isc:useActiveItemTemp(player, CollectibleType.COLLECTIBLE_DULL_RAZOR)
    return false
  elseif data.wakaba.shioriangel and not (player:HasCollectible(CollectibleType.COLLECTIBLE_HEARTBREAK) or isc:willReviveFromSpiritShackles(player)) then 
    --print("data.wakaba.shioriangel")
    isc:useActiveItemTemp(player, CollectibleType.COLLECTIBLE_DULL_RAZOR)
    player:AddBrokenHearts(1)
    return false
  end
  return true
end
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_PLAYER_FATAL_DAMAGE, wakaba.PostPlayerFatalDamage)