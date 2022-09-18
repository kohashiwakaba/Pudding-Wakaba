wakaba.fcount = 0
wakaba.killcount = 0

function wakaba:hasAlbireo(player)
	if not player then 
		return false 
	end
	--[[ if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Saya", false) then
    return true
	else ]]if player:HasCollectible(wakaba.Enums.Collectibles.WINTER_ALBIREO) then
		return true
	else
		return false
	end
end


local newRoomData = false
local ReplaceT = false
local candidates = {}
local treasureRooms = {}

function wakaba:NewRoom_Albireo()
  local game = wakaba.G
  local room = wakaba.G:GetRoom()
  local level = wakaba.G:GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
  local StartingRoom = 84

  --if wakaba.G:GetFrameCount() == 0 then ReplaceT = false return end
  
	if room:IsFirstVisit() and CurRoom == StartingRoom then
    print("Replace!")
		ReplaceT = true
	end

  for i = 0, DoorSlot.NUM_DOOR_SLOTS do
    local doorR = room:GetDoor(i)
    if doorR and doorR:IsRoomType(RoomType.ROOM_PLANETARIUM) then 
      
      doorR:SetLocked(false) 
    elseif doorR and doorR:IsRoomType(RoomType.ROOM_SECRET) then 
      --print("Secret Room!")
    end
  end

	if ReplaceT then
		if not newRoomData then
      -- possible vals = 0,1,2,5,6
			newRoomData = 1
			Isaac.ExecuteCommand("goto s.planetarium.0")
      print("Planetarium Found!")
		else
      print("Planetarium Entered!")
			if newRoomData == 1 then
        print("Planetarium Copied!")
				newRoomData = level:GetRoomByIdx(CurRoom).Data
				game:StartRoomTransition(StartingRoom,0,1)
			end
			local replacePlanetarium = false
			for i = 1, game:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				local luck = player.Luck
				if luck < 0 then luck = 0 end
				if wakaba:hasAlbireo(player) and player:GetCollectibleRNG(wakaba.Enums.Collectibles.WINTER_ALBIREO):RandomInt(10000) > (4000 + (luck * 200)) then
					replacePlanetarium = true 
					break
				end
			end
			if replacePlanetarium then
				local IsTreasure = false
				for i=0,169 do
					local roomCount = level:GetRoomByIdx(i)
          local doorCount = 0
					if (CurStage == LevelStage.STAGE8) then
						Replace = nil
						if roomCount.Data and roomCount.Data.Type == RoomType.ROOM_TREASURE then IsTreasure = true end
						return
					end
          if roomCount.Data and (roomCount.Data.Shape == 1 or 2 or 3) and (roomCount.Data.Type == RoomType.ROOM_DEFAULT) then
            doorCount = roomCount.Data.Doors
            visitCount = roomCount.VisitedCount
            if wakaba:numNextRoomCount(i) and doorCount < 16 and visitCount < 1 then
              table.insert(candidates, i)
            end
          end
          if roomCount.Data and (roomCount.Data.Shape == 1 or 2 or 3) and (roomCount.Data.Type == RoomType.ROOM_TREASURE) then
            table.insert(treasureRooms, i)
          end
				end
				
        print("Now replacing...")
        if #treasureRooms > 0 then
          for i = 1, #treasureRooms do
            local roomCount = level:GetRoomByIdx(treasureRooms[i])
            --roomCount.Data.Type = RoomType.ROOM_PLANETARIUM
            roomCount.Data = newRoomData
            roomCount.DisplayFlags = 1 << 0 | 1 << 2
            if MinimapAPI then
              local mRoom = MinimapAPI:GetRoomByIdx(roomCount.GridIndex)
              mRoom.Type = RoomType.ROOM_PLANETARIUM
              mRoom.Shape = RoomShape.ROOMSHAPE_1x1
              mRoom.PermanentIcons = {"Planetarium"}
            end

          end
				else
					while #candidates > 0 do
						print("Found Empty Room Candidate!")
						local roomIdx = candidates[RNG():RandomInt(#candidates) + 1]
						local roomCount = level:GetRoomByIdx(roomIdx)
						roomCount.Data = newRoomData
						candidates = {}
						roomCount.DisplayFlags = 1 << 0 | 1 << 2
						if MinimapAPI then
							local mRoom = MinimapAPI:GetRoomByIdx(roomCount.GridIndex)
							mRoom.Type = RoomType.ROOM_PLANETARIUM
							mRoom.Shape = RoomShape.ROOMSHAPE_1x1
							mRoom.PermanentIcons = {"Planetarium"}
						end
					end
        end

				--[[ for i=0,169 do
					local roomCount = level:GetRoomByIdx(i)
					if i ~= StartingRoom then
						if roomCount.Data then
							--if (roomCount.Data.Shape == 1 or 2 or 3) and ( (roomCount.Data.Type == RoomType.ROOM_DEFAULT and IsTreasure == false) or (roomCount.Data.Type == RoomType.ROOM_TREASURE)) then
							if (roomCount.Data.Shape == 1 or 2 or 3) and (roomCount.Data.Type == RoomType.ROOM_TREASURE) then
                print("Treasure room Found : ", i)
                roomCount.Data = newRoomData
                print("Replaced!...")
                roomCount.DisplayFlags = 1 << 0 | 1 << 2
                if MinimapAPI then
                  local mRoom = MinimapAPI:GetRoomByIdx(roomCount.GridIndex)
                  mRoom.PermanentIcons = {"Planetarium"}
                end
              elseif (roomCount.Data.Shape == 1 or 2 or 3) and (roomCount.Data.Type == RoomType.ROOM_BOSS) then

							end
						end
					end
				end ]]

        game:StartRoomTransition(StartingRoom,0,1)
        level:UpdateVisibility()
        ReplaceT = nil
        candidates = {}
        treasureRooms = {}
			else
				ReplaceT = nil
        candidates = {}
        treasureRooms = {}
			end
		end
  end
end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Albireo)


function wakaba:Cache_Albireo(player, cacheFlag)
  if wakaba:hasAlbireo(player) then

    if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
      player.Damage = player.Damage + (count * 0.3)
    end
    if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			for i = 1, count do
				player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 0.1)
			end
    end
    --[[ if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
      player.TearColor = newTearColor
    end ]]
  end
	
end
 
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Albireo)