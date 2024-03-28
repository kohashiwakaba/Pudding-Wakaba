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
  if wakaba:hasLunarStone(player, true) and wakaba:getPlayerDataEntry(player , "lunargauge", 0) > 0 then
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

function wakaba:PlayerUpdate_Revival(player)
  wakaba:GetPlayerEntityData(player)
  local data = player:GetData()
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
--wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.detectPotatoPeeler, CollectibleType.COLLECTIBLE_POTATO_PEELER)



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
