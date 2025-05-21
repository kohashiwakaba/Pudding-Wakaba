
--#region RoomgenData from Tainted Treasure rooms
local mod = wakaba

mod.adjindexes = {
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

mod.borderrooms = {
	[DoorSlot.LEFT0] = {0, 13, 26, 39, 52, 65, 78, 91, 104, 117, 130, 143, 156},
	[DoorSlot.UP0] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	[DoorSlot.RIGHT0] = {12, 25, 38, 51, 64, 77, 90, 103, 116, 129, 142, 155, 168},
	[DoorSlot.DOWN0] = {156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168},
	[DoorSlot.LEFT1] = {0, 13, 26, 39, 52, 65, 78, 91, 104, 117, 130, 143, 156},
	[DoorSlot.UP1] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	[DoorSlot.RIGHT1] = {12, 25, 38, 51, 64, 77, 90, 103, 116, 129, 142, 155, 168},
	[DoorSlot.DOWN1] = {156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168}
}

mod.oppslots = {
	[DoorSlot.LEFT0] = DoorSlot.RIGHT0,
	[DoorSlot.UP0] = DoorSlot.DOWN0,
	[DoorSlot.RIGHT0] = DoorSlot.LEFT0,
	[DoorSlot.LEFT1] = DoorSlot.RIGHT0,
	[DoorSlot.DOWN0] = DoorSlot.UP0,
	[DoorSlot.UP1] = DoorSlot.DOWN0,
	[DoorSlot.RIGHT1] = DoorSlot.LEFT0,
	[DoorSlot.DOWN1] = DoorSlot.UP0
}

mod.shapeindexes = {
	[RoomShape.ROOMSHAPE_1x1] = { 0 },
	[RoomShape.ROOMSHAPE_IH] = { 0 },
	[RoomShape.ROOMSHAPE_IV] = { 0 },
	[RoomShape.ROOMSHAPE_1x2] = { 0, 13 },
	[RoomShape.ROOMSHAPE_IIV] = { 0, 13 },
	[RoomShape.ROOMSHAPE_2x1] = { 0, 1 },
	[RoomShape.ROOMSHAPE_IIH] = { 0, 1 },
	[RoomShape.ROOMSHAPE_2x2] = { 0, 1, 13, 14 },
	[RoomShape.ROOMSHAPE_LTL] = { 1, 13, 14 },
	[RoomShape.ROOMSHAPE_LTR] = { 0, 13, 14 },
	[RoomShape.ROOMSHAPE_LBL] = { 0, 1, 14 },
	[RoomShape.ROOMSHAPE_LBR] = { 0, 1, 13 },
}
--#endregion RoomgenData end

local game = wakaba.G

function mod:IsDeadEnd(roomidx, shape)
	local level = game:GetLevel()
	shape = shape or RoomShape.ROOMSHAPE_1x1
	local deadend = false
	local adjindex = mod.adjindexes[shape]
	local adjrooms = 0
	for i, entry in pairs(adjindex) do
		local oob = false
		for j, idx in pairs(mod.borderrooms[i]) do
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

function mod:GetDeadEnds(roomdesc)
	local level = game:GetLevel()
	local roomidx = roomdesc.SafeGridIndex
	local shape = roomdesc.Data.Shape
	local adjindex = mod.adjindexes[shape]
	local deadends = {}
	for i, entry in pairs(adjindex) do
		if level:GetRoomByIdx(roomidx).Data then
			local oob = false
			for j, idx in pairs(mod.borderrooms[i]) do
				for k, shapeidx in pairs(mod.shapeindexes[shape]) do
					if idx == roomidx+shapeidx then
						oob = true
					end
				end
			end
			if roomdesc.Data.Doors & (1 << i) > 0 and mod:IsDeadEnd(roomidx+adjindex[i]) and level:GetRoomByIdx(roomidx+adjindex[i]).GridIndex == -1 and not oob then
				table.insert(deadends, {Slot = i, GridIndex = roomidx+adjindex[i]})
			end
		end
	end

	if #deadends >= 1 then
		return deadends
	else
		return nil
	end
end

function mod:GetOppositeDoorSlot(slot)
	return mod.oppslots[slot]
end

function wakaba:getLevelDeadEndCandidates(onnewlevel)
	local level = wakaba.G:GetLevel()
	local currentroomidx = level:GetCurrentRoomIndex()
	local candidates = {}

	for i = level:GetRooms().Size, 0, -1 do
		local roomdesc = level:GetRooms():Get(i-1)
		if roomdesc and roomdesc.Data.Type == RoomType.ROOM_DEFAULT and roomdesc.Data.Subtype == 0 then
		local deadends = mod:GetDeadEnds(roomdesc)
			if deadends and not (onnewlevel and roomdesc.GridIndex == currentroomidx) then
				for j, deadend in pairs(deadends) do
					table.insert(candidates, {Slot = deadend.Slot, GridIndex = deadend.GridIndex, roomidx = roomdesc.GridIndex, visitcount = roomdesc.VisitedCount})
				end
			end
		end
	end
	return candidates
end

local isc = _wakaba.isc

if REPENTOGON then
	function wakaba:generateDevilAngelRoom(roomType, roomSubType, allowConnectStartingRoom, showIfGenerated)
    local level = game:GetLevel()

    local dimension = -1  -- current dimension
    local seed = level:GetDungeonPlacementSeed()

    -- Fetch a random RoomConfig for a new treasure room.
  	local roomConfig = RoomConfigHolder.GetRandomRoom(seed, true, StbType.SPECIAL_ROOMS, roomType, RoomShape.ROOMSHAPE_1x1, 0, -1, 0, 99, 4, roomSubType)

    -- Disallow placements with multiple doors, or placements that connect to other special rooms.
    local allowMultipleDoors = false
    local allowSpecialNeighbors = false

    -- Fetch all valid locations.
    local options = level:FindValidRoomPlacementLocations(roomConfig, dimension, allowMultipleDoors, allowSpecialNeighbors)

    for _, gridIndex in pairs(options) do
      -- You may have additional conditions or priorities when it comes to where you would prefer to place your room.
      -- For the purposes of this example we arbitarily forbid the new room from being connected to the starting room,
      -- and otherwise just place the room at the first place we check.

      -- Get the RoomDescriptors of all rooms that would be neighboring the room if placed here.
      local neighbors = level:GetNeighboringRooms(gridIndex, roomConfig.Shape)

      local connectsToStartingRoom = false

      for doorSlot, neighborDesc in pairs(neighbors) do
        if neighborDesc.GridIndex == level:GetStartingRoomIndex() then
          connectsToStartingRoom = true
        end
      end

      if allowConnectStartingRoom or not connectsToStartingRoom then
        -- Try to place the room.
        local room = level:TryPlaceRoom(roomConfig, gridIndex, dimension, seed, allowMultipleDoors, allowSpecialNeighbors)
        if room then
          -- The room was placed successfully!
					if showIfGenerated then
						room.DisplayFlags = 1 << 0 | 1 << 2
					end
					if MinimapAPI then
						local mRoom = MinimapAPI:GetRoomByIdx(room.GridIndex)
						if mRoom then
							mRoom.Shape = RoomShape.ROOMSHAPE_1x1
							if roomType == RoomType.ROOM_DEVIL then
								mRoom.Type = RoomType.ROOM_DEVIL
								mRoom.PermanentIcons = {"DevilRoom"}
							elseif roomType == RoomType.ROOM_ANGEL then
								mRoom.Type = RoomType.ROOM_ANGEL
								mRoom.PermanentIcons = {"AngelRoom"}
							end
						end
					end
					level:UpdateVisibility()
          return true
        end
      end
    end
		return false
	end
	function wakaba:generateNewRoom(roomType, roomID, allowConnectStartingRoom)
    local level = game:GetLevel()

    local dimension = -1  -- current dimension
    local seed = level:GetDungeonPlacementSeed()

    -- Fetch a random RoomConfig for a new treasure room.
  	-- local roomConfig = RoomConfigHolder.GetRandomRoom(seed, true, StbType.SPECIAL_ROOMS, RoomType.ROOM_TREASURE, RoomShape.ROOMSHAPE_1x1)
		local roomConfig = RoomConfigHolder.GetRoomByStageTypeAndVariant(StbType.SPECIAL_ROOMS, roomType, roomID)

    -- Disallow placements with multiple doors, or placements that connect to other special rooms.
    local allowMultipleDoors = false
    local allowSpecialNeighbors = false

    -- Fetch all valid locations.
    local options = level:FindValidRoomPlacementLocations(roomConfig, dimension, allowMultipleDoors, allowSpecialNeighbors)

    for _, gridIndex in pairs(options) do
      -- You may have additional conditions or priorities when it comes to where you would prefer to place your room.
      -- For the purposes of this example we arbitarily forbid the new room from being connected to the starting room,
      -- and otherwise just place the room at the first place we check.

      -- Get the RoomDescriptors of all rooms that would be neighboring the room if placed here.
      local neighbors = level:GetNeighboringRooms(gridIndex, roomConfig.Shape)

      local connectsToStartingRoom = false

      for doorSlot, neighborDesc in pairs(neighbors) do
        if neighborDesc.GridIndex == level:GetStartingRoomIndex() then
          connectsToStartingRoom = true
        end
      end

      if allowConnectStartingRoom or not connectsToStartingRoom then
        -- Try to place the room.
        local room = level:TryPlaceRoom(roomConfig, gridIndex, dimension, seed, allowMultipleDoors, allowSpecialNeighbors)
        if room then
          -- The room was placed successfully!
          return true
        end
      end
    end
		return false
	end
else
	function wakaba:generateNewRoom()
	end
end

function wakaba:NewLevel_RoomGen()
	local roomsToGenerate = {}
	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.ROOM_GENERATION)) do
		local returnedTable = callback.Function(callback.Mod)
		if type(returnedTable) == "table" then
			for _, e in ipairs(returnedTable) do
				if type(e) == "table" and type(e[2]) == "number" then
					table.insert(roomsToGenerate, e)
				end
			end
		end
	end

	if REPENTOGON then
		local valid = true
		for _, roomVar in ipairs(roomsToGenerate) do
			if valid then
				valid = wakaba:generateNewRoom(roomVar[1], roomVar[2], true)
			end
		end
		if MinimapAPI then
			MinimapAPI:LoadDefaultMap()
		end
	else
		local rng = RNG()
		local level = wakaba.G:GetLevel()
		local seeds = wakaba.G:GetSeeds()
		local currentroomidx = level:GetCurrentRoomIndex()
		local candidates = {}
		local haspermamaze = false
		local hascurseofmaze = false

		local tried = false
		local tries = 0

		local currentRoomIdx = level:GetCurrentRoomIndex()
		candidates = wakaba:getLevelDeadEndCandidates(true)
		wakaba.FLog("debugLevelGen", "roomsToGenerate:", #roomsToGenerate, "/ candidates:", #candidates)
		local preserved = nil
		while (#roomsToGenerate > 0 or preserved) and #candidates > 0 do
			if seeds:HasSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_MAZE) then
				seeds:RemoveSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_MAZE)
				haspermamaze = true
			end
			if level:GetCurses() & LevelCurse.CURSE_OF_MAZE > 0 then
				level:RemoveCurses(LevelCurse.CURSE_OF_MAZE)
				hascurseofmaze = true
			end

			tried = true
			tries = tries + 1
			wakaba.FLog("debugLevelGen", "current tries:", tries)

			local roomVar = preserved or isc:getRandomArrayElementAndRemove(roomsToGenerate, rng)
			local e = isc:getRandomArrayElementAndRemove(candidates, rng)
			local roomData = isc:getRoomDataForTypeVariant(roomVar[1], roomVar[2], false)

			local deadendslot = e.Slot
			local deadendidx = e.GridIndex
			local roomidx = e.roomidx
			local visitcount = e.visitcount
			local roomdesc = level:GetRoomByIdx(roomidx)
			if roomdesc.Data and level:GetRoomByIdx(roomdesc.GridIndex).GridIndex ~= -1 and mod:GetOppositeDoorSlot(deadendslot) and roomData.Doors & (1 << mod:GetOppositeDoorSlot(deadendslot)) > 0 then
				local success = level:MakeRedRoomDoor(e.roomidx, e.Slot)
				wakaba.FLog("debugLevelGen", "Trying to Generate room for gridIndex", e.roomidx, "slot", e.Slot, success)
				if success then

					local writeableRoom = level:GetRoomByIdx(e.GridIndex, -1)
					writeableRoom.Data = roomData
					writeableRoom.Flags = writeableRoom.Flags & ~RoomDescriptor.FLAG_RED_ROOM -- remove red room flag

					level:UpdateVisibility()
					preserved = nil
				end
			else
				wakaba.FLog("debugLevelGen", "Found invalid location for gridIndex", e.roomidx, "slot", e.Slot)
				preserved = roomVar
			end
		end

		if tried then
			wakaba:scheduleForUpdate(function()
				SFXManager():Stop(SoundEffect.SOUND_UNLOCK00)
				wakaba.G:StartRoomTransition(currentroomidx, 0, RoomTransitionAnim.FADE)
			end, 0, ModCallbacks.MC_POST_RENDER)
			wakaba:scheduleForUpdate(function()
				if haspermamaze then
					seeds:AddSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_MAZE)
				end
				if hascurseofmaze then
					level:AddCurse(LevelCurse.CURSE_OF_MAZE)
				end
			end, 0, ModCallbacks.MC_POST_UPDATE)

			Game():StartRoomTransition(currentRoomIdx, Direction.NO_DIRECTION, RoomTransitionAnim.FADE)
		end
	end
	if MinimapAPI then
		MinimapAPI:LoadDefaultMap()
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_LEVEL, CallbackPriority.EARLY, wakaba.NewLevel_RoomGen)

function wakaba:RoomGen_RabbitRibbon()
	local player = isc:getPlayersWithCollectible(wakaba.Enums.Collectibles.RABBIT_RIBBON)[1] or Isaac.GetPlayer()
	if (wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.RABBIT_RIBBON) or isc:anyPlayerIs(wakaba.Enums.Players.RICHER) or isc:anyPlayerIs(wakaba.Enums.Players.RICHER_B))
	and (isc:hasCurse(LevelCurse.CURSE_OF_LABYRINTH) or wakaba.G:GetSeeds():HasSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_LABYRINTH))
	and not wakaba.G:GetLevel():IsAscent() then
		local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.RABBIT_RIBBON)
		local s = {}
		table.insert(s, {RoomType.ROOM_SHOP, isc:getRandomInt(wakaba.RoomIDs.MIN_RABBEY_SHOP_ROOM_ID, wakaba.RoomIDs.MAX_RABBEY_SHOP_ROOM_ID, rng)})
		table.insert(s, {RoomType.ROOM_TREASURE, isc:getRandomInt(wakaba.RoomIDs.MIN_RABBEY_TREASURE_ROOM_ID, wakaba.RoomIDs.MAX_RABBEY_TREASURE_ROOM_ID, rng)})
		table.insert(s, {RoomType.ROOM_TREASURE, isc:getRandomInt(wakaba.RoomIDs.MIN_RABBEY_TREASURE_ROOM_ID, wakaba.RoomIDs.MAX_RABBEY_TREASURE_ROOM_ID, rng)})
		return s
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.ROOM_GENERATION, CallbackPriority.EARLY, wakaba.RoomGen_RabbitRibbon)