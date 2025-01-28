
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_SLNT
local tp = wakaba.Enums.Players.SHIORI
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_PureDeli(player)
	if wakaba.G.Challenge ~= c then return end
  player:SetPocketActiveItem(wakaba.Enums.Collectibles.BOOK_OF_SILENCE, ActiveSlot.SLOT_POCKET, true)
  if wakaba.G:GetFrameCount() == 0 then
    wakaba:scheduleForUpdate(function ()
      wakaba.G:GetLevel():SetStage(LevelStage.STAGE7, StageType.STAGETYPE_ORIGINAL)
      Isaac.ExecuteCommand("goto s.boss.3414")
    end, 1)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_PureDeli)

function wakaba:Challenge_NewRoom_PureDeli()
	if wakaba.G.Challenge ~= c then return end
  local game = wakaba.G
  local room = wakaba.G:GetRoom()
  local level = wakaba.G:GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
	local type1 = room:GetType()

  for i = 0, DoorSlot.NUM_DOOR_SLOTS - 1 do
    local door = room:GetDoor(i)
    if door then
      room:RemoveDoor(i)
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.Challenge_NewRoom_PureDeli)