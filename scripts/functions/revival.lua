
function wakaba:IsLost(player)
  if player:GetPlayerType() == PlayerType.PLAYER_THELOST then return true end
  if player:GetPlayerType() == PlayerType.PLAYER_THELOST_B then return true end
  if player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B then return true end
  if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B then return true end
  if player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) then return true end
end

function wakaba:CanRevive(player)
  if player:GetBabySkin() == BabySubType.BABY_FOUND_SOUL then return false end
  local data = player:GetData()
  if wakaba:hasLunarStone(player, true) and data.wakaba.lunargauge and data.wakaba.lunargauge > 0 then
    return {ID = wakaba.COLLECTIBLE_LUNAR_STONE}
  elseif wakaba:HasWisp(player, wakaba.COLLECTIBLE_QUESTION_BLOCK) then
    return {ID = wakaba.COLLECTIBLE_QUESTION_BLOCK, PostRevival = wakaba:AfterRevival_QuestionBlock(player)}
  elseif wakaba:HasWisp(player, wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER) then
    return {ID = wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER, PostRevival = wakaba:AfterRevival_GrimreaperDefender(player)}
  elseif player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_THE_GOD) and not data.wakaba.shioriangel then
    return {ID = wakaba.COLLECTIBLE_BOOK_OF_THE_GOD, PostRevival = wakaba:AfterRevival_BookOfTheGod(player)}
  elseif player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_THE_FALLEN) and not player:GetData().wakaba.shioridevil then
    return {ID = wakaba.COLLECTIBLE_BOOK_OF_THE_FALLEN, PostRevival = wakaba:AfterRevival_BookOfTheFallen(player)}
  elseif player:HasCollectible(wakaba.COLLECTIBLE_VINTAGE_THREAT) and not player:GetData().wakaba.vintagethreat then
    return {ID = wakaba.COLLECTIBLE_VINTAGE_THREAT, PostRevival = wakaba:AfterRevival_VintageThreat(player)}
  end
  return false
end

function wakaba:IsFatalDamage(player, amount)
  local heartTypes = 0
  local maxamount = 0
  if player:WillPlayerRevive() then
    return false
  end
  if player:HasMortalDamage() then
    return true
  end
  if wakaba:IsLost(player) then
    return true
  end
  if player:GetHearts() > 0 then
    maxamount = player:GetHearts() - player:GetRottenHearts()
    heartTypes = heartTypes + 1
  end
  if player:GetSoulHearts() > 0 then
    maxamount = (player:GetSoulHearts() > maxamount and player:GetSoulHearts()) or maxamount
    heartTypes = heartTypes + 1
  end
  if player:GetBoneHearts() > 0 then
    maxamount = (player:GetBoneHearts() > maxamount and player:GetBoneHearts()) or maxamount
    heartTypes = heartTypes + 1
  end
  if heartTypes ~= 1 then
    return false
  end
  if not maxamount or (maxamount <= amount) then
    return true
  end
  return false
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
		local isBossRoom = Game():GetRoom():GetType() == RoomType.ROOM_BOSS
		local stage = Game():GetLevel():GetAbsoluteStage()
		local isRepentance = (Game():GetLevel():GetStageType() == StageType.STAGETYPE_REPENTANCE or Game():GetLevel():GetStageType() == StageType.STAGETYPE_REPENTANCE_B)
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
  return (Game():GetRoom():GetType() == RoomType.ROOM_SACRIFICE and flag & DamageFlag.DAMAGE_SPIKES == DamageFlag.DAMAGE_SPIKES)
end

function wakaba:PlayDeathAnimationWithRevival(player, itemID, currentroom)
  --print("PlayDeathAnimationWithRevival")
  currentroom = currentroom or false
  wakaba:GetPlayerEntityData(player)
  local data = player:GetData()
  --player:StopExtraAnimation()
  if wakaba:IsLost(player) then
    player:PlayExtraAnimation("LostDeath")
  else
    player:PlayExtraAnimation("Death")
  end
  SFXManager():Play(SoundEffect.SOUND_DEATH_BURST_SMALL)
  SFXManager():Play(SoundEffect.SOUND_ISAACDIES)
  player:SetMinDamageCooldown(180)
  player.Velocity = Vector.Zero
  player.ControlsEnabled = false
  data.wakaba.reviveanim = itemID
  data.wakaba.revivecurrentroom = currentroom
end

function wakaba:AddPostRevive(player, func)
  wakaba:GetPlayerEntityData(player)
  --print("adding Post-Revival function")
  player:GetData().wakaba.postrevivefunction = func
end

function wakaba:PlayerUpdate_Revival(player)
  wakaba:GetPlayerEntityData(player)
  local data = player:GetData()
  if wakaba:IsHeartDifferent(player) then
    wakaba:RemoveRegisteredHeart(player)
		if wakaba:hasLunarStone(player) then
			data.wakaba.lunargauge = data.wakaba.lunargauge or 1000000
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
    if player:HasCollectible(wakaba.COLLECTIBLE_EATHEART) then
      wakaba:ChargeEatHeart(player, 1, "PlayerDamage")
    end
    if player:HasCollectible(wakaba.COLLECTIBLE_EATHEART) then
      Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_GOLDENTROLL, 0, wakaba:RandomNearbyPosition(entity), Vector.Zero, nil)
    end
  end


  if player:IsDead() and not player:WillPlayerRevive() then
    local revivaldata = wakaba:CanRevive(player) or wakaba:CanRevive(player:GetOtherTwin())
    if revivaldata then
      player:Revive()
      if player:GetOtherTwin() then
        if player:GetOtherTwin():IsDead() and not player:GetOtherTwin():WillPlayerRevive() then
          player:GetOtherTwin():Revive()
          player:GetOtherTwin():SetMinDamageCooldown(180)
        end
      end
      wakaba:PlayDeathAnimationWithRevival(player, revivaldata.ID)
      if revivaldata.PostRevival then
        wakaba:AddPostRevive(player, revivaldata.PostRevival)
      end
    end
  end
  if data.wakaba.revivefinished and player:AreControlsEnabled() then
    --print("revivefinished")
    player:AnimateCollectible(data.wakaba.reviveanim)
    player:SetMinDamageCooldown(180)
    --print("check Post-Revival function")
    data.wakaba.reviveanim = nil
    data.wakaba.revivefinished = nil
    data.wakaba.revivecurrentroom = nil
    player.ControlsEnabled = true
    if data.wakaba.postrevivefunction then
      --print("postrev")
      data.wakaba.postrevivefunction(player)
      data.wakaba.postrevivefunction = nil
    end
    if data.wakaba.reviveasjudas then
      player:ChangePlayerType(PlayerType.PLAYER_BLACKJUDAS)
    end
  elseif data.wakaba.reviveanim then
    --print("reviveanim", player:GetSprite():GetAnimation(), player:IsExtraAnimationFinished())
    player.Velocity = Vector.Zero
    if player:IsExtraAnimationFinished() then
      --print("reviveanimfinished")
      if not data.wakaba.revivecurrentroom and not wakaba:HasBeast() then
        Game():StartRoomTransition(Game():GetLevel():GetLastRoomDesc().SafeGridIndex, Direction.NO_DIRECTION, RoomTransitionAnim.WALK, player)
      else
        player.ControlsEnabled = true
      end
      data.wakaba.revivefinished = true
      --player.ControlsEnabled = true
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Revival)


function wakaba:TakeDmg_Revival(entity, amount, flag, source, countdown)
  if not entity:ToPlayer() then return end
  local player = entity:ToPlayer()
  local data = player:GetData()
  data.wakaba = data.wakaba or {}
  --print(data.wakaba.damageflag)


  wakaba:TakeDamage_CurseOfTower2(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_EatHeart(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_LunarStone(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_Concentration(entity, amount, flag, source, countdown)
  wakaba:TakeDamage_Elixir(entity, amount, flag, source, countdown)



  if not data.wakaba.damageflag then
    if data.wakaba.grimreaper and not wakaba:IsSacrificeRoomSpikes(flag) then
      --print("TookDamage - Grimreaper Defender")
      data.wakaba.damageflag = DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_NO_PENALTIES
      player:TakeDamage(1, flag | data.wakaba.damageflag, source, countdown)
      if wakaba:isMausoleumDoor(flag) then
        wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
      end
      return false
    elseif player:HasTrinket(wakaba.TRINKET_DETERMINATION_RIBBON) and not wakaba:IsSacrificeRoomSpikes(flag) then
      --print("TookDamage - TRINKET_DETERMINATION_RIBBON")
      data.wakaba.damageflag = DamageFlag.DAMAGE_NOKILL
      player:TakeDamage(1, flag | data.wakaba.damageflag, source, countdown)
      if wakaba:isMausoleumDoor(flag) then
        wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
      elseif player:GetTrinketMultiplier(wakaba.TRINKET_DETERMINATION_RIBBON) < 5 then
        local chance = player:GetTrinketRNG(wakaba.TRINKET_DETERMINATION_RIBBON):RandomInt(1000000)
        local threshold = 20000
        if Game().Difficulty == Difficulty.DIFFICULTY_NORMAL or Game().Difficulty == Difficulty.DIFFICULTY_GREED then
          threshold = threshold / 4
        end
        if player:GetTrinketMultiplier(wakaba.TRINKET_DETERMINATION_RIBBON) > 0 then
          threshold = threshold / player:GetTrinketMultiplier(wakaba.TRINKET_DETERMINATION_RIBBON)
        end
        --print(chance, threshold)
        if chance < threshold then
          --player:DropTrinket(player.Position, false)
          player:TryRemoveTrinket(wakaba.TRINKET_DETERMINATION_RIBBON)
          Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.TRINKET_DETERMINATION_RIBBON, Game():GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, nil)
          player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
        end
        return false
      end
      return false
    end
    if wakaba:IsFatalDamage(player, amount) then
      if wakaba:hasLunarStone(player) and data.wakaba.lunargauge and data.wakaba.lunargauge > 0 then
        --print("TookDamage - COLLECTIBLE_LUNAR_STONE")
        data.wakaba.damageflag = DamageFlag.DAMAGE_NOKILL
        player:TakeDamage(amount, flag | data.wakaba.damageflag, source, countdown)
        if wakaba:isMausoleumDoor(flag) then
          wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
        end
        wakaba:PlayDeathAnimationWithRevival(player, wakaba.COLLECTIBLE_LUNAR_STONE)
        return false
      elseif wakaba:HasWisp(player, wakaba.COLLECTIBLE_QUESTION_BLOCK) then
        --print("TookDamage - COLLECTIBLE_BOOK_OF_THE_GOD")
        data.wakaba.damageflag = DamageFlag.DAMAGE_NOKILL
        player:TakeDamage(amount, flag | data.wakaba.damageflag, source, countdown)
        if wakaba:isMausoleumDoor(flag) then
          wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
        end
        wakaba:PlayDeathAnimationWithRevival(player, wakaba.COLLECTIBLE_QUESTION_BLOCK)
        wakaba:AddPostRevive(player, wakaba:AfterRevival_QuestionBlock(player))
        return false
      elseif wakaba:HasWisp(player, wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER) then
        --print("TookDamage - COLLECTIBLE_BOOK_OF_THE_GOD")
        data.wakaba.damageflag = DamageFlag.DAMAGE_NOKILL
        player:TakeDamage(amount, flag | data.wakaba.damageflag, source, countdown)
        if wakaba:isMausoleumDoor(flag) then
          wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
        end
        wakaba:PlayDeathAnimationWithRevival(player, wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER)
        wakaba:AddPostRevive(player, wakaba:AfterRevival_GrimreaperDefender(player))
        return false
      elseif player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_THE_GOD) and not data.wakaba.shioriangel then
        --print("TookDamage - COLLECTIBLE_BOOK_OF_THE_GOD")
        data.wakaba.damageflag = DamageFlag.DAMAGE_NOKILL
        player:TakeDamage(amount, flag | data.wakaba.damageflag, source, countdown)
        if wakaba:isMausoleumDoor(flag) then
          wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
        end
        wakaba:PlayDeathAnimationWithRevival(player, wakaba.COLLECTIBLE_BOOK_OF_THE_GOD)
        wakaba:AddPostRevive(player, wakaba:AfterRevival_BookOfTheGod(player))
        return false
      elseif not player:HasCollectible(CollectibleType.COLLECTIBLE_HEARTBREAK) and data.wakaba.shioriangel --[[ and (player:GetHeartLimit() > 2) ]] then
        --print("TookDamage - COLLECTIBLE_BOOK_OF_THE_GOD")
        data.wakaba.damageflag = DamageFlag.DAMAGE_NOKILL
        player:TakeDamage(1, flag | data.wakaba.damageflag, source, countdown)
        if wakaba:isMausoleumDoor(flag) then
          wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
        else
          player:AddBrokenHearts(1)
        end
        return false
      elseif player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_THE_FALLEN) and not player:GetData().wakaba.shioridevil then
        --print("TookDamage - COLLECTIBLE_BOOK_OF_THE_FALLEN")
        data.wakaba.damageflag = DamageFlag.DAMAGE_NOKILL
        player:TakeDamage(amount, flag | data.wakaba.damageflag, source, countdown)
        if wakaba:isMausoleumDoor(flag) then
          wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
        end
        wakaba:PlayDeathAnimationWithRevival(player, wakaba.COLLECTIBLE_BOOK_OF_THE_FALLEN)
        wakaba:AddPostRevive(player, wakaba:AfterRevival_BookOfTheFallen(player))
        return false
      elseif player:HasCollectible(wakaba.COLLECTIBLE_VINTAGE_THREAT) and not player:GetData().wakaba.vintagethreat then
        --print("TookDamage - COLLECTIBLE_BOOK_OF_THE_FALLEN")
        data.wakaba.damageflag = DamageFlag.DAMAGE_NOKILL
        player:TakeDamage(amount, flag | data.wakaba.damageflag, source, countdown)
        if wakaba:isMausoleumDoor(flag) then
          wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
        end
        wakaba:PlayDeathAnimationWithRevival(player, wakaba.COLLECTIBLE_VINTAGE_THREAT, true)
        wakaba:AddPostRevive(player, wakaba:AfterRevival_VintageThreat(player))
        return false
      end
    end
  end
  data.wakaba.damageflag = nil
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_Revival, EntityType.ENTITY_PLAYER)

function wakaba:detectPlanC(usedItem, rng)
	if wakaba:HasJudasBr(player) then
    wakaba:GetPlayerEntityData(player)
    player:GetData().wakaba.reviveasjudas = true
  end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.detectPlanC, CollectibleType.COLLECTIBLE_PLAN_C)

if DetailedRespawnGlobalAPI then
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Lunar Stone",
    itemId = wakaba.COLLECTIBLE_LUNAR_STONE,
    condition = function(self, player)
      return wakaba:hasLunarStone(player)
    end,
    additionalText = "xInf",
  }, DetailedRespawnGlobalAPI.RespawnPosition.Last)
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Question Block Wisp",
    itemId = wakaba.COLLECTIBLE_QUESTION_BLOCK,
    condition = function(_, player)
      return wakaba:HasWisp(player, wakaba.COLLECTIBLE_QUESTION_BLOCK)
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Lunar Stone"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Grimreaper Defender Wisp",
    itemId = wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER,
    condition = function(_, player)
      return wakaba:HasWisp(player, wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER)
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Question Block Wisp"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Book of the God",
    itemId = wakaba.COLLECTIBLE_BOOK_OF_THE_GOD,
    condition = function(_, player)
      return player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_THE_GOD) and not player:GetData().wakaba.shioriangel
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Grimreaper Defender Wisp"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Book of the Fallen",
    itemId = wakaba.COLLECTIBLE_BOOK_OF_THE_FALLEN,
    condition = function(_, player)
      return player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_THE_FALLEN) and not player:GetData().wakaba.shioridevil
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Book of the God"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Vintage Threat",
    itemId = wakaba.COLLECTIBLE_VINTAGE_THREAT,
    condition = function(_, player)
      return player:HasCollectible(wakaba.COLLECTIBLE_VINTAGE_THREAT) and not player:GetData().wakaba.vintagethreat
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
