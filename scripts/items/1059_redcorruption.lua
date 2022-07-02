wakaba.COLLECTIBLE_RED_CORRUPTION = Isaac.GetItemIdByName("Red Corruption")


function wakaba:UpdateRoomDisplayFlags(initroomdesc)
	local level = Game():GetLevel()
	local roomdesc = level:GetRoomByIdx(initroomdesc.GridIndex)
	local roomdata = roomdesc.Data
	if level:GetRoomByIdx(roomdesc.GridIndex).DisplayFlags then
		if level:GetRoomByIdx(roomdesc.GridIndex) ~= level:GetCurrentRoomDesc().GridIndex then
			if roomdata then 
				if level:GetStateFlag(LevelStateFlag.STATE_FULL_MAP_EFFECT) then
					roomdesc.DisplayFlags = 111
				elseif roomdata.Type ~= RoomType.ROOM_DEFAULT and roomdata.Type ~= RoomType.ROOM_SECRET and roomdata.Type ~= RoomType.ROOM_SUPERSECRET and roomdata.Type ~= RoomType.ROOM_ULTRASECRET and level:GetStateFlag(LevelStateFlag.STATE_COMPASS_EFFECT) then
					roomdesc.DisplayFlags = 111
				elseif roomdata and level:GetStateFlag(LevelStateFlag.STATE_BLUE_MAP_EFFECT) and (roomdata.Type == RoomType.ROOM_SECRET or roomdata.Type == RoomType.ROOM_SUPERSECRET) then
					roomdesc.DisplayFlags = 111
				elseif level:GetStateFlag(LevelStateFlag.STATE_MAP_EFFECT) then
					roomdesc.DisplayFlags = 001
				else
					roomdesc.DisplayFlags = 0
				end
			end
		end
	end
end


function wakaba:NewLevel_RedCorruption()
	local game = Game()
	local level = game:GetLevel()
	if level:GetAbsoluteStage() == LevelStage.STAGE5 or level:GetAbsoluteStage() == LevelStage.STAGE8 then return end
	local hasCorruption = false
  for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.COLLECTIBLE_RED_CORRUPTION) then
			hasCorruption = true
		end
		if hasCorruption and not (game.Difficulty == Difficulty.DIFFICULTY_GREED or game.Difficulty == Difficulty.DIFFICULTY_GREEDIER) then
			for i=0,168 do
				local roomDesc = level:GetRoomByIdx(i)
				if roomDesc.Data 
				and (roomDesc.Data.Shape == RoomShape.ROOMSHAPE_1x1) 
				and (roomDesc.Data.Type ~= RoomType.ROOM_DEFAULT) 
				and (roomDesc.Data.Type ~= RoomType.ROOM_BOSS) 
				and (roomDesc.Data.Type ~= RoomType.ROOM_ULTRASECRET) 
				then
					for d = 0, 3 do
						local test = level:MakeRedRoomDoor(i, d)
						--print(test)
					end
				end
			end
			level:UpdateVisibility()
			if MinimapAPI then
				MinimapAPI:CheckForNewRedRooms()
			end
			for i=0,168 do
				local roomDesc = level:GetRoomByIdx(i)
				if roomDesc.Data then
					if (roomDesc.Data.Type > 1) then
						roomDesc.DisplayFlags = 111
						if (roomDesc.Data.Type ~= RoomType.ROOM_BOSS) then
							roomDesc.Flags = roomDesc.Flags | RoomDescriptor.FLAG_RED_ROOM
						end
						if MinimapAPI then
							local mRoom = MinimapAPI:GetRoomByIdx(roomDesc.GridIndex)
							if mRoom then
								mRoom.Color = Color(1,0.25,0.25,1,0,0,0)
								if not mRoom.Descriptor then
									mRoom.Descriptor = roomDesc
								end
							end
						end
					else
						if roomDesc.Flags & RoomDescriptor.FLAG_RED_ROOM == RoomDescriptor.FLAG_RED_ROOM then
							roomDesc.Flags = roomDesc.Flags ~ RoomDescriptor.FLAG_RED_ROOM
						end
						wakaba:UpdateRoomDisplayFlags(roomDesc)
						if MinimapAPI then
							local mRoom = MinimapAPI:GetRoomByIdx(roomDesc.GridIndex)
							if mRoom then
								mRoom.Color = nil
								if not mRoom.Descriptor then
									mRoom.Descriptor = roomDesc
								end
							end
						end
					end
				end
			end
			level:UpdateVisibility()
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_RedCorruption)


