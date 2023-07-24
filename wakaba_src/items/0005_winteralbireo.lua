--[[
	Winter Albireo (겨울의 알비레오) - 패시브, 알트 리셰 고유 능력
	매 스테이지마다 가능한 경우, 리셰 전용 천체관 생성,
	알트 리셰 플레이 시 기존 보물방을 천체관으로 대체

	Based off on Retribution Tainted Mammon Shop
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
wakaba.minimapRooms = {}
local game = wakaba.G

function wakaba:hasAlbireo(player)
	if not player then
		return false
	end
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
    return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.WINTER_ALBIREO) then
		return true
	elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_RNPR then
		return true
	else
		return false
	end
end

function wakaba:anyPlayerHasAlbireo()
	local hasAlbireo = false
	local onlyTaintedRicher = true
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i-1)
		hasAlbireo = player.Variant == 0 and wakaba:hasAlbireo(player)
		onlyTaintedRicher = onlyTaintedRicher and player:GetPlayerType() == wakaba.Enums.Players.RICHER_B
	end
	return hasAlbireo, onlyTaintedRicher
end

local function countVisibleConnections(originIndex)
	local level = game:GetLevel()
	local connections = 0

	for _, index in pairs({originIndex - 1, originIndex + 1, originIndex - 13, originIndex + 13}) do
		local desc = level:GetRoomByIdx(index)
		if desc.Data and desc.Data.Type ~= RoomType.ROOM_SECRET then
			connections = connections + 1
		end
	end

	return connections
end

function wakaba:GetDeadEnd(rng)
	local deadEnds = {}
	local level = game:GetLevel()
	local roomsList = level:GetRooms()

	for i = 0, #roomsList - 1 do
		local desc = roomsList:Get(i)
		if desc.Data.Type == RoomType.ROOM_DEFAULT and desc.Data.Shape == RoomShape.ROOMSHAPE_1x1 and countVisibleConnections(desc.SafeGridIndex) == 1 then
			table.insert(deadEnds, desc)
		end
	end

	if #deadEnds > 0 then
		return deadEnds[rng:RandomInt(#deadEnds) + 1].SafeGridIndex
	end
end

local albireoRooms = {}

for i = wakaba.RoomIDs.MIN_RICHER_ROOM_ID, wakaba.RoomIDs.MAX_RICHER_ROOM_ID do
	table.insert(albireoRooms, i)
end

local spawnerEntityPositions = {}
local resetEntityPositions = true

local function getExpectedRoomDisplayFlags()
	local level = game:GetLevel()
	local flags = RoomDescriptor.DISPLAY_NONE

	if level:GetStateFlag(LevelStateFlag.STATE_MAP_EFFECT) then flags = RoomDescriptor.DISPLAY_BOX end
	if level:GetStateFlag(LevelStateFlag.STATE_COMPASS_EFFECT) then flags = RoomDescriptor.DISPLAY_ALL end
	if level:GetStateFlag(LevelStateFlag.STATE_FULL_MAP_EFFECT) then flags = RoomDescriptor.DISPLAY_ALL end

	return flags
end

local function hasCachedAlbireoRooms()
	return wakaba.RoomConfigs and wakaba.RoomConfigs.WinterAlbireo
end

function wakaba:SetAlbireoRoom(rng, onlyTaintedRicher)
	local roomPool = wakaba.RoomConfigs.WinterAlbireo["Standard"]
	local level = game:GetLevel()
	local roomIndex = level:QueryRoomTypeIndex(RoomType.ROOM_TREASURE, false, rng)
	local config = roomPool[rng:RandomInt(#roomPool) + 1]
	local targetDesc = level:GetRoomByIdx(roomIndex)

	local stage = level:GetStage()
	local isWombStage = stage >= LevelStage.STAGE4_1 and stage ~= LevelStage.STAGE4_3 and stage <= LevelStage.STAGE5

	if game:GetFrameCount() == 0 or not onlyTaintedRicher or isWombStage then
		local index = wakaba:GetDeadEnd(rng)
		if index then
			targetDesc = level:GetRoomByIdx(index)
			targetDesc.Data = config
			targetDesc.DisplayFlags = targetDesc.DisplayFlags | getExpectedRoomDisplayFlags()
			table.insert(wakaba.minimapRooms, index)
		else
		end
	elseif targetDesc.Data.Type == RoomType.ROOM_TREASURE then
		targetDesc.Data = config
		table.insert(wakaba.minimapRooms, roomIndex)
	end

	if StageAPI then
		StageAPI.PreviousBaseLevelLayout[targetDesc.ListIndex] = targetDesc

		if StageAPI.LevelRooms[0] then
			StageAPI.LevelRooms[0][targetDesc.ListIndex] = nil -- If this fucks something I'm so sorry
		end
	end

	wakaba:TrySetAlbireoRoomDoor()
	level:UpdateVisibility()
end

function wakaba:IsValidWakabaRoom(roomdesc, wakabaRoomType)
	local level = game:GetLevel()
	local roomDesc = roomdesc or level:GetCurrentRoomDesc()
	wakabaRoomType = wakabaRoomType or wakaba.RoomTypes.WINTER_ALBIREO

	if roomDesc and roomDesc.Data then
		if wakabaRoomType == wakaba.RoomTypes.WINTER_ALBIREO and roomDesc.Data.Type == RoomType.ROOM_PLANETARIUM then
			if hasCachedAlbireoRooms() then
				for _, index in ipairs(albireoRooms) do
					if index == roomDesc.Data.Variant then
						return true
					end
				end
			else
				-- Richer Planetariums for Winter Albireo
				if (roomDesc.Data.Variant >= wakaba.RoomIDs.MIN_RICHER_ROOM_ID and roomDesc.Data.Variant <= wakaba.RoomIDs.MAX_RICHER_ROOM_ID) then
					return true
				end
			end
		end
	end


	return false
end

local catchDebugRoom
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_LEVEL, CallbackPriority.IMPORTANT, function()
	local level = game:GetLevel()
	local hasAlbireo, onlyTaintedRicher = wakaba:anyPlayerHasAlbireo()
	if hasAlbireo and (wakaba.state.unlock.taintedricher or wakaba.state.options.allowlockeditems or not wakaba.state.achievementPopupShown) then
		if not hasCachedAlbireoRooms() then
			wakaba.RoomConfigs = wakaba.RoomConfigs or {}
			wakaba.RoomConfigs.WinterAlbireo = wakaba.RoomConfigs.WinterAlbireo or {}

			wakaba.RoomConfigs.WinterAlbireo.Standard = {}

			for _, index in pairs(albireoRooms) do
				Isaac.ExecuteCommand("goto s.planetarium." .. index)
				table.insert(wakaba.RoomConfigs.WinterAlbireo.Standard, level:GetRoomByIdx(-3).Data)
			end

			catchDebugRoom = {
				ReturnIndex = level:GetCurrentRoomIndex(),
				Positions = {},
			}

			wakaba:ForAllPlayers(function(player)
				table.insert(catchDebugRoom.Positions, {
					Player = player,
					Position = Vector(player.Position.X, player.Position.Y),
				})
			end)
		end

		local stage = level:GetStage()
		local rng = RNG()
		rng:SetSeed(level:GetDungeonPlacementSeed(), 35)
		if stage <= LevelStage.STAGE5 and not level:IsAscent() then
			wakaba:SetAlbireoRoom(rng, onlyTaintedRicher)
		end
		if MinimapAPI then
			MinimapAPI:LoadDefaultMap()

			if #wakaba.minimapRooms > 0 then
				wakaba:scheduleForUpdate(function()
					for i, roomidx in pairs(wakaba.minimapRooms) do
						local minimaproom = MinimapAPI:GetRoomByIdx(roomidx)
						if minimaproom then
							minimaproom.Color = Color(MinimapAPI.Config.DefaultRoomColorR, MinimapAPI.Config.DefaultRoomColorG, MinimapAPI.Config.DefaultRoomColorB, 1, 0, 0, 0)
							if wakaba:IsValidWakabaRoom(minimaproom.Descriptor) then
								minimaproom.PermanentIcons = {"wakaba_RicherPlanetariumIcon"}
							end
							wakaba.minimapRooms[i] = nil
						end
					end
				end, 0)
			else
				wakaba.minimapRooms = {}
			end
		end
	end
end)

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	if catchDebugRoom then
		catchDebugRoom = nil
	end
end)

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	if catchDebugRoom then
		if game:GetLevel():GetCurrentRoomIndex() == -3 then
			game:ChangeRoom(catchDebugRoom.ReturnIndex)
		else
			for _, data in pairs(catchDebugRoom.Positions) do
				data.Player.Position = data.Position
			end
			catchDebugRoom = nil
		end
	end
end)

--[[ 
	Door sprite replacement, from Tainted Treasure rooms
	customRoomType is for future usage
	possible types planned : richer(winter albireo), rira(???), trwakaba(???)
 ]]
 function wakaba:ApplyDoorGraphics(door, customRoomType)
	local doorSprite = door:GetSprite()

	local iscustomstage = StageAPI and StageAPI.InOverriddenStage()
	
	--if not iscustomstage then
		doorSprite:Load("gfx/grid/wakaba_richer_room_door.anm2", true)
		doorSprite:ReplaceSpritesheet(0, "gfx/grid/wakaba_richer_room_door.png")
	--end
	doorSprite:LoadGraphics()
	doorSprite:Play("Closed")
	door:SetLocked(false)
end

function wakaba:NewRoom_WinterAlbireo()
	local level = wakaba.G:GetLevel()
	local roomidx = level:GetCurrentRoomIndex()
	local roomdesc = level:GetCurrentRoomDesc()
	local roomdata = roomdesc.Data
	local room = wakaba.G:GetRoom()
	local roomtype = room:GetType()
	if wakaba:IsValidWakabaRoom(roomdesc) then
		if room:IsFirstVisit() then
			if isc:anyPlayerHasCollectible(CollectibleType.COLLECTIBLE_MORE_OPTIONS) then
				local slots = Isaac.FindByType(6, wakaba.Enums.Slots.CRYSTAL_RESTOCK, wakaba.Enums.CrystalRestockSubType.NORMAL)
				for _, slot in ipairs(slots) do
					local position = Vector(slot.Position.X, slot.Position.Y)
					slot:Remove()
					Isaac.Spawn(6, wakaba.Enums.Slots.CRYSTAL_RESTOCK, wakaba.Enums.CrystalRestockSubType.YELLOW, position, Vector.Zero, nil)
				end
			end
		end
		for i = 0, DoorSlot.NUM_DOOR_SLOTS do
			local door = room:GetDoor(i)
			if door and door.TargetRoomType ~= RoomType.ROOM_SECRET then
				local doorSprite = door:GetSprite()
				wakaba:ApplyDoorGraphics(door)
				doorSprite:Play("Opened")
			end
		end
	else
		wakaba:TrySetAlbireoRoomDoor()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_WinterAlbireo)

function wakaba:TrySetAlbireoRoomDoor()
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	if room:GetType() ~= RoomType.ROOM_SECRET then
		for i = 0, DoorSlot.NUM_DOOR_SLOTS do
			local door = room:GetDoor(i)
			if door then
				local targetroomdesc = level:GetRoomByIdx(door.TargetRoomIndex)
				if wakaba:IsValidWakabaRoom(targetroomdesc) then
					wakaba:ApplyDoorGraphics(door)
				end
			end
		end
	end
end