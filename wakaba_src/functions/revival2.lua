local isc = require("wakaba_src.libs.isaacscript-common")
local tempRevivalFunc = {

}

function wakaba:CanRevive(player)
  --if not player then return false end
  --[[ if player:WillPlayerRevive() then 
		if not (not wakaba:HasCard(player, Card.CARD_SOUL_LAZARUS) and player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)) then return false end
		--return false 
	end ]]
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
  elseif player:HasCollectible(wakaba.Enums.Collectibles.CARAMELLO_PANCAKE) then
    return {ID = wakaba.Enums.Collectibles.CARAMELLO_PANCAKE, PostRevival = function() wakaba:AfterRevival_CaramelloPancake(player) end}
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

function wakaba:PlayerUpdate_Revival2(player)
  local data = player:GetData().wakaba
  local revivalData = wakaba:CanRevive(player)
  local playerIndex = tostring(isc:getPlayerIndex(player))
	if revivalData then
		if not player:WillPlayerRevive() and not data.willRevive then
			player:GetEffects():AddNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
		end
		if wakaba:IsPlayerDying(player) then
			if player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) and not data.willRevive then
				data.willRevive = true
        data.revivalData = {}
        data.revivalData.ID = revivalData.ID
        data.revivalData.CurrentRoom = revivalData.CurrentRoom
        tempRevivalFunc[playerIndex] = revivalData.PostRevival
			end
		elseif data.willRevive then
      local savedRevivalData = data.revivalData
      if tempRevivalFunc[playerIndex] then
        tempRevivalFunc[playerIndex](player)
        tempRevivalFunc[playerIndex] = nil
      end

			data.willRevive = false
      if not savedRevivalData.CurrentRoom then
        wakaba.G:StartRoomTransition(wakaba.G:GetLevel():GetLastRoomDesc().SafeGridIndex, -1, 0, player)
      end
			wakaba:scheduleForUpdate(function()
				player:AnimateCollectible(savedRevivalData.ID)
			end, 3)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Revival2)