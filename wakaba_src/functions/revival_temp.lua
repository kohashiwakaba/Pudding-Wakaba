local isc = require("wakaba_src.libs.isaacscript-common")

local customRevivalFunc = {
  [wakaba.Enums.Collectibles.LUNAR_STONE] = function(player) wakaba:AfterRevival_LunarStone(player) end,
  [wakaba.Enums.Collectibles.QUESTION_BLOCK] = function(player) wakaba:AfterRevival_QuestionBlock(player) end,
  [wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = function(player) wakaba:AfterRevival_GrimreaperDefender(player) end,
  [wakaba.Enums.Collectibles.SEE_DES_BISCHOFS] = function(player) wakaba:AfterRevival_LakeOfBishop(player) end,
  [wakaba.Enums.Collectibles.JAR_OF_CLOVER] = function(player) wakaba:AfterRevival_JarOfClover(player) end,
  [wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = function(player) wakaba:AfterRevival_CaramellaPancake(player) end,
  [wakaba.Enums.Collectibles.BOOK_OF_THE_GOD] = function(player) wakaba:AfterRevival_BookOfTheGod(player) end,
  [wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = function(player) wakaba:AfterRevival_BookOfTheFallen(player) end,
  [wakaba.Enums.Collectibles.VINTAGE_THREAT] = function(player) wakaba:AfterRevival_VintageThreat(player) end,
}

function wakaba:GetRevivalData(player)
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


function wakaba:PostPlayerFatalDamage(player)
  local data = player:GetData()
  data.wakaba = data.wakaba or {}
  --if isc:willPlayerRevive(player) or isc:willReviveFromHeartbreak(player) or isc:willReviveFromSpiritShackles(player) then return end
  if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER) then
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
    return false
  elseif wakaba:hasPlayerDataEntry(player, "shioriangel") and not (isc:willReviveFromHeartbreak(player) or isc:willReviveFromSpiritShackles(player)) then
    player:AddBrokenHearts(1)
    return false
  end

  local revivalData = wakaba:GetRevivalData(player)
  if revivalData and revivalData.CurrentRoom then
    revivalData.PostRevival(player)
    player:AnimateCollectible(revivalType)
    return false
  end
end
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_PLAYER_FATAL_DAMAGE, wakaba.PostPlayerFatalDamage)

function wakaba:CheckRevival(player)
  local revivalData = wakaba:GetRevivalData(player)
  if not revivalData then return end
  local revivalType = revivalData.ID
  return revivalType
end
wakaba:AddCallbackCustom(isc.ModCallbackCustom.PRE_CUSTOM_REVIVE, wakaba.CheckRevival)

function wakaba:AfterRevival(player, revivalType)
  if revivalType and customRevivalFunc[revivalType] then
    --print("revivalData found:", revivalType)
    customRevivalFunc[revivalType](player)
    player:AnimateCollectible(revivalType)
  end
end
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_CUSTOM_REVIVE, wakaba.AfterRevival)

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
    data.wakaba.damageTriggered = {}
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
  wakaba:TakeDamage_LunarDamocles(entity, amount, flag, source, countdown)
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_Revival, EntityType.ENTITY_PLAYER)

if DetailedRespawnGlobalAPI then
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Lunar Stone",
    itemId = wakaba.Enums.Collectibles.LUNAR_STONE,
    condition = function(self, player)
      local canRevive = wakaba:GetRevivalData(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.LUNAR_STONE
    end,
    additionalText = "xInf",
  }, DetailedRespawnGlobalAPI.RespawnPosition.Last)
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Question Block Wisp",
    itemId = wakaba.Enums.Collectibles.QUESTION_BLOCK,
    condition = function(_, player)
      local canRevive = wakaba:GetRevivalData(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.QUESTION_BLOCK
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Lunar Stone"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Grimreaper Defender Wisp",
    itemId = wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER,
    condition = function(_, player)
      local canRevive = wakaba:GetRevivalData(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Question Block Wisp"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Book of the God",
    itemId = wakaba.Enums.Collectibles.BOOK_OF_THE_GOD,
    condition = function(_, player)
      local canRevive = wakaba:GetRevivalData(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.BOOK_OF_THE_GOD
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Grimreaper Defender Wisp"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "See Des Bischofs",
    itemId = wakaba.Enums.Collectibles.SEE_DES_BISCHOFS,
    condition = function(_, player)
      local canRevive = wakaba:GetRevivalData(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.SEE_DES_BISCHOFS
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Book of the God"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Jar of Clover",
    itemId = wakaba.Enums.Collectibles.JAR_OF_CLOVER,
    condition = function(_, player)
      local canRevive = wakaba:GetRevivalData(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.JAR_OF_CLOVER
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("See Des Bischofs"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Caramella Pancake",
    itemId = wakaba.Enums.Collectibles.CARAMELLA_PANCAKE,
    condition = function(_, player)
      local canRevive = wakaba:GetRevivalData(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.CARAMELLA_PANCAKE
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Jar of Clover"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Book of the Fallen",
    itemId = wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN,
    condition = function(_, player)
      local canRevive = wakaba:GetRevivalData(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN
    end,
  }, DetailedRespawnGlobalAPI.RespawnPosition:After("Caramella Pancake"))
  DetailedRespawnGlobalAPI:AddCustomRespawn({
    name = "Vintage Threat",
    itemId = wakaba.Enums.Collectibles.VINTAGE_THREAT,
    condition = function(_, player)
      local canRevive = wakaba:GetRevivalData(player)
      return canRevive and canRevive.ID == wakaba.Enums.Collectibles.VINTAGE_THREAT
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
