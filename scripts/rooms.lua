local rng = RNG()
local game = Game()

-- Roomgen indexes by sgjd01
wakaba.adjindexes = {
	[RoomShape.ROOMSHAPE_1x1] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13, 
		[DoorSlot.RIGHT0] = 1, 
		[DoorSlot.DOWN0] = 13
	},
	[RoomShape.ROOMSHAPE_IH] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.RIGHT0] = 1
	},
	[RoomShape.ROOMSHAPE_IV] = {
		[DoorSlot.UP0] = -13, 
		[DoorSlot.DOWN0] = 13
	},
	[RoomShape.ROOMSHAPE_1x2] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13, 
		[DoorSlot.RIGHT0] = 1, 
		[DoorSlot.DOWN0] = 26,
		[DoorSlot.LEFT1] = 12, 
		[DoorSlot.RIGHT1] = 14
	},
	[RoomShape.ROOMSHAPE_IIV] = {
		[DoorSlot.UP0] = -13, 
		[DoorSlot.DOWN0] = 26
	},
	[RoomShape.ROOMSHAPE_2x1] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13, 
		[DoorSlot.RIGHT0] = 2,
		[DoorSlot.DOWN0] = 13,
		[DoorSlot.UP1] = -12,
		[DoorSlot.DOWN1] = 14
	},
	[RoomShape.ROOMSHAPE_IIH] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.RIGHT0] = 3
	},
	[RoomShape.ROOMSHAPE_2x2] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13,
		[DoorSlot.RIGHT0] = 2,
		[DoorSlot.DOWN0] = 26,
		[DoorSlot.LEFT1] = 12,
		[DoorSlot.UP1] = -12, 
		[DoorSlot.RIGHT1] = 15, 
		[DoorSlot.DOWN1] = 27
	},
	[RoomShape.ROOMSHAPE_LTL] = {
		[DoorSlot.LEFT0] = -1,
		[DoorSlot.UP0] = -1,
		[DoorSlot.RIGHT0] = 1, 
		[DoorSlot.DOWN0] = 25,
		[DoorSlot.LEFT1] = 11, 
		[DoorSlot.UP1] = -13, 
		[DoorSlot.RIGHT1] = 14, 
		[DoorSlot.DOWN1] = 26
	},
	[RoomShape.ROOMSHAPE_LTR] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13, 
		[DoorSlot.RIGHT0] = 1,
		[DoorSlot.DOWN0] = 26,
		[DoorSlot.LEFT1] = 12, 
		[DoorSlot.UP1] = 1,
		[DoorSlot.RIGHT1] = 15, 
		[DoorSlot.DOWN1] = 27
	},
	[RoomShape.ROOMSHAPE_LBL] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13,
		[DoorSlot.RIGHT0] = 2,
		[DoorSlot.DOWN0] = 13,
		[DoorSlot.LEFT1] = 13,
		[DoorSlot.UP1] = -12, 
		[DoorSlot.RIGHT1] = 15, 
		[DoorSlot.DOWN1] = 27
	},
	[RoomShape.ROOMSHAPE_LBR] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13,
		[DoorSlot.RIGHT0] = 2,
		[DoorSlot.DOWN0] = 26,
		[DoorSlot.LEFT1] = 12,
		[DoorSlot.UP1] = -12,
		[DoorSlot.RIGHT1] = 14,
		[DoorSlot.DOWN1] = 14
	}
}

wakaba.borderrooms = {
	[DoorSlot.LEFT0] = {0, 13, 26, 39, 52, 65, 78, 91, 104, 117, 130, 143, 156},
	[DoorSlot.UP0] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	[DoorSlot.RIGHT0] = {12, 25, 38, 51, 64, 77, 90, 103, 116, 129, 142, 155, 168},
	[DoorSlot.DOWN0] = {156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 186},
	[DoorSlot.LEFT1] = {0, 13, 26, 39, 52, 65, 78, 91, 104, 117, 130, 143, 156},
	[DoorSlot.UP1] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	[DoorSlot.RIGHT1] = {12, 25, 38, 51, 64, 77, 90, 103, 116, 129, 142, 155, 168},
	[DoorSlot.DOWN1] = {156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 186}
}

wakaba.oppslots = {
	[DoorSlot.LEFT0] = DoorSlot.RIGHT0, 
	[DoorSlot.UP0] = DoorSlot.DOWN0, 
	[DoorSlot.RIGHT0] = DoorSlot.LEFT0, 
	[DoorSlot.LEFT1] = DoorSlot.RIGHT0, 
	[DoorSlot.DOWN0] = DoorSlot.UP0, 
	[DoorSlot.UP1] = DoorSlot.DOWN0, 
	[DoorSlot.RIGHT1] = DoorSlot.LEFT0, 
	[DoorSlot.DOWN1] = DoorSlot.UP0
}

function wakaba:IsDeadEnd(roomidx, shape)
	local level = game:GetLevel()
	shape = shape or RoomShape.ROOMSHAPE_1x1
	local deadend = false
	local adjindex = wakaba.adjindexes[shape]
	local adjrooms = 0
	for i, entry in pairs(adjindex) do
		local oob = false
		for j, idx in pairs(wakaba.borderrooms[i]) do
			if idx == roomidx then
				oob = true
			end
		end
		if level:GetRoomByIdx(roomidx+entry).GridIndex ~= -1 and not oob then
			adjrooms = adjrooms+1
		end
	end
	if adjrooms == 1 then
		deadend = true
	end
	return deadend
end

function wakaba:GetDeadEnds(roomdesc)
	local level = game:GetLevel()
	local roomidx = roomdesc.SafeGridIndex
	local shape = roomdesc.Data.Shape
	local adjindex = wakaba.adjindexes[shape]
	local deadends = {}
	for i, entry in pairs(adjindex) do
		if level:GetRoomByIdx(roomidx).Data then
			local oob = false
			for j, idx in pairs(wakaba.borderrooms[i]) do
				if idx == roomidx then
					oob = true
				end
			end
			if roomdesc.Data.Doors & (1 << i) > 0 and wakaba:IsDeadEnd(roomidx+adjindex[i]) and level:GetRoomByIdx(roomidx+adjindex[i]).GridIndex == -1 and not oob then
				table.insert(deadends, {Slot = i, GridIndex = roomidx+adjindex[i]})
			end
		end
	end
	
	if deadends[1] then
		return deadends
	else
		return nil
	end
end

function wakaba:GetOppositeDoorSlot(slot)
	return wakaba.oppslots[slot]
end

function wakaba:UpdateRoomDisplayFlags(initroomdesc)
	local level = game:GetLevel()
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

function wakaba:UpdateLevelDisplayFlags()
	local level = game:GetLevel()
	for i = level:GetRooms().Size, 0, -1 do
		local roomdesc = level:GetRooms():Get(i-1)
		if roomdesc then
			wakaba:UpdateRoomDisplayFlags(roomdesc)
		end
	end
end

function wakaba:GenerateSpecialRoom(roomtype, minvariant, maxvariant, onnewlevel) --Roomtype must be provided as a string for goto use
	onnewlevel = onnewlevel or false
	local level = game:GetLevel()
	local hascurseofmaze = false
	local floordeadends = {}
	local roomvariants = {}
	local currentroomidx = level:GetCurrentRoomIndex()
	local currentroomvisitcount = level:GetRoomByIdx(currentroomidx).VisitedCount
	local currentroomcenterpos = game:GetRoom():GetCenterPos()
	
	if level:GetCurses() & LevelCurse.CURSE_OF_MAZE > 0 then
		level:RemoveCurses(LevelCurse.CURSE_OF_MAZE)
		hascurseofmaze = true
	end
	
	for i = level:GetRooms().Size, 0, -1 do
		local roomdesc = level:GetRooms():Get(i-1)
		if roomdesc and roomdesc.Data.Type == RoomType.ROOM_DEFAULT and roomdesc.Data.Subtype ~= 34 then
		local deadends = wakaba:GetDeadEnds(roomdesc)
			if deadends and not (onnewlevel and roomdesc.GridIndex == currentroomidx) then
				for j, deadend in pairs(deadends) do
					table.insert(floordeadends, {Slot = deadend.Slot, GridIndex = deadend.GridIndex, roomidx = roomdesc.GridIndex, visitcount = roomdesc.VisitedCount})
				end
			end
		end
	end
	
	if not floordeadends[1] then
		return false
	end
	
	for i = minvariant, maxvariant do
		table.insert(roomvariants, i)
	end
	
	wakaba:Shuffle(roomvariants)
	wakaba:Shuffle(floordeadends)
	
	for j, roomvariant in pairs(roomvariants) do
		Isaac.ExecuteCommand("goto s."..roomtype.."."..roomvariant)
		local data = level:GetRoomByIdx(-3,0).Data
		
		if data.Shape == RoomShape.ROOMSHAPE_1x1 then
			for i, entry in pairs(floordeadends) do
				local deadendslot = entry.Slot
				local deadendidx = entry.GridIndex
				local roomidx = entry.roomidx
				local visitcount = entry.visitcount
				local roomdesc = level:GetRoomByIdx(roomidx)
				if roomdesc.Data and level:GetRoomByIdx(roomdesc.GridIndex).GridIndex ~= -1 and wakaba:GetOppositeDoorSlot(deadendslot) and data.Doors & (1 << wakaba:GetOppositeDoorSlot(deadendslot)) > 0 then
						if level:MakeRedRoomDoor(roomidx, deadendslot) then
							local newroomdesc = level:GetRoomByIdx(deadendidx, 0)
							newroomdesc.Data = data
							newroomdesc.Flags = 0
							wakaba:scheduleForUpdate(function()
								SFXManager():Stop(SoundEffect.SOUND_UNLOCK00)
								game:StartRoomTransition(currentroomidx, 0, RoomTransitionAnim.FADE)
								level:GetRoomByIdx(currentroomidx).VisitedCount = currentroomvisitcount-1
								wakaba:UpdateRoomDisplayFlags(newroomdesc)
								level:UpdateVisibility()
								if onnewlevel then
									for i = game:GetNumPlayers(), 1, -1 do
										Isaac.GetPlayer(i-1).Position = Isaac.GetFreeNearPosition(currentroomcenterpos, 1)
									end
								end
							end, 0, ModCallbacks.MC_POST_RENDER)
							wakaba:scheduleForUpdate(function()
								if hascurseofmaze then
									level:AddCurse(LevelCurse.CURSE_OF_MAZE)
								end
								if onnewlevel then --You have to do it twice or it doesn't look right, not sure why
									for i = game:GetNumPlayers(), 1, -1 do
										Isaac.GetPlayer(i-1).Position = Isaac.GetFreeNearPosition(currentroomcenterpos, 1)
									end
								end
								level:UpdateVisibility()
							end, 0, ModCallbacks.MC_POST_UPDATE)
						return newroomdesc
					end
				end
			end
		end
	end
	
	game:StartRoomTransition(currentroomidx, 0, RoomTransitionAnim.FADE)
	if onnewlevel then
		wakaba:scheduleForUpdate(function()
			for i = game:GetNumPlayers(), 1, -1 do
				Isaac.GetPlayer(i-1).Position = Isaac.GetFreeNearPosition(currentroomcenterpos, 1)
			end
		end, 0, ModCallbacks.MC_POST_UPDATE)
	end
	return false
end