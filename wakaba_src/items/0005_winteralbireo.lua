--[[
	Winter Albireo (겨울의 알비레오) - 패시브, 알트 리셰 고유 능력
	매 스테이지마다 가능한 경우, 리셰 전용 천체관 생성,
	알트 리셰 플레이 시 기존 보물방을 천체관으로 대체

	Based off on Retribution Tainted Mammon Shop
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
wakaba.minimapRooms = {}
local game = wakaba.G

---Check selected player has Winter Albireo, or playing as Tainted Richer
---@param player EntityPlayer
---@return boolean
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

---Check any player has Winter Albireo, or playing as Tainted Richer
---@return boolean hasAlbireo
---@return boolean onlyTaintedRicher
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

function wakaba:SetAlbireoRoomGreed(rng, onlyTaintedRicher)
	local roomPool = wakaba.RoomConfigs.WinterAlbireo["Standard"]
	local level = game:GetLevel()
	local roomIndex = 85
	local config = roomPool[rng:RandomInt(#roomPool) + 1]
	local targetDesc = level:GetRoomByIdx(roomIndex)
	targetDesc.Data = config
	table.insert(wakaba.minimapRooms, roomIndex)

	wakaba:TrySetAlbireoRoomDoor()
	level:UpdateVisibility()
end

function wakaba:SetAlbireoRoom(rng, onlyTaintedRicher)
	local roomPool = wakaba.RoomConfigs.WinterAlbireo["Standard"]
	local level = game:GetLevel()
	local roomIndex = level:QueryRoomTypeIndex(RoomType.ROOM_TREASURE, false, rng)
	local config = roomPool[rng:RandomInt(#roomPool) + 1]
	local targetDesc = level:GetRoomByIdx(roomIndex)

	local stage = level:GetStage()
	local isWombStage = stage >= LevelStage.STAGE4_1 and stage ~= LevelStage.STAGE4_3 and stage <= LevelStage.STAGE5

	if not onlyTaintedRicher or isWombStage then
		local index = wakaba:GetDeadEnd(rng)
		if index then
			targetDesc = level:GetRoomByIdx(index)
			targetDesc.Data = config
			targetDesc.DisplayFlags = targetDesc.DisplayFlags | getExpectedRoomDisplayFlags()
			targetDesc.Flags = targetDesc.Flags | RoomDescriptor.FLAG_MAMA_MEGA
			table.insert(wakaba.minimapRooms, index)
		else
		end
	elseif targetDesc.Data.Type == RoomType.ROOM_TREASURE then
		targetDesc.Data = config
		table.insert(wakaba.minimapRooms, roomIndex)
		targetDesc.Flags = targetDesc.Flags | RoomDescriptor.FLAG_MAMA_MEGA
		if game:GetFrameCount() <= 1 then
			local portal = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PORTAL_TELEPORT, 1000 + targetDesc.SafeGridIndex, isc:gridCoordinatesToWorldPosition(3, 0), Vector.Zero, nil)
			targetDesc.Flags = targetDesc.Flags | RoomDescriptor.FLAG_PORTAL_LINKED
		end
	end

	if StageAPI then
		StageAPI.PreviousBaseLevelLayout[targetDesc.ListIndex] = targetDesc

		if StageAPI.LevelRooms[0] then
			StageAPI.LevelRooms[0][targetDesc.ListIndex] = nil -- If this fucks something I'm so sorry
		end
	end

	wakaba:TrySetAlbireoRoomDoor()
	if game:GetFrameCount() > 0 then
		level:UpdateVisibility()
	end
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
						local stage = level:GetAbsoluteStage()
						local stageType = level:GetStageType()

						if stage <= LevelStage.STAGE4_2 then
							if stage % 2 ~= 0 then
								return RoomType.ROOM_TREASURE
							else
								return RoomType.ROOM_PLANETARIUM
							end
						elseif stage == LevelStage.STAGE4_3 then
							return RoomType.ROOM_SECRET
						elseif stage == LevelStage.STAGE5 then
							if stageType == StageType.STAGETYPE_ORIGINAL then
								return RoomType.ROOM_DEVIL
							else
								return RoomType.ROOM_ANGEL
							end
						end
					end
				end
			else
				-- Richer Planetariums for Winter Albireo
				if (roomDesc.Data.Variant >= wakaba.RoomIDs.MIN_RICHER_ROOM_ID and roomDesc.Data.Variant <= wakaba.RoomIDs.MAX_RICHER_ROOM_ID) then
					local stage = level:GetAbsoluteStage()
					local stageType = level:GetStageType()

					if stage <= LevelStage.STAGE4_2 then
						if stage % 2 ~= 0 then
							return RoomType.ROOM_TREASURE
						else
							return RoomType.ROOM_PLANETARIUM
						end
					elseif stage == LevelStage.STAGE4_3 then
						return RoomType.ROOM_SECRET
					elseif stage == LevelStage.STAGE5 then
						if stageType == StageType.STAGETYPE_ORIGINAL then
							return RoomType.ROOM_DEVIL
						else
							return RoomType.ROOM_ANGEL
						end
					end
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
		if game:IsGreedMode() then
			if stage < LevelStage.STAGE6_GREED then
				wakaba:SetAlbireoRoomGreed(rng, onlyTaintedRicher)
			end
		elseif stage <= LevelStage.STAGE5 and not level:IsAscent() then
			wakaba:SetAlbireoRoom(rng, onlyTaintedRicher)
			level:UpdateVisibility()
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


local extraItemSpawned = 0

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	if catchDebugRoom then
		catchDebugRoom = nil
	end
	extraItemSpawned = 0
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
	local room = wakaba.G:GetRoom()
	local doorSprite = door:GetSprite()

	local iscustomstage = StageAPI and StageAPI.InOverriddenStage()

	--if not iscustomstage then
		doorSprite:Load("gfx/grid/wakaba_richer_room_door.anm2", true)
		doorSprite:ReplaceSpritesheet(0, "gfx/grid/wakaba_richer_room_door.png")
	--end
	doorSprite:LoadGraphics()
	doorSprite:Play(room:IsClear() and "Opened" or "Closed")
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
			local items = Isaac.FindByType(5, 100, -1, false, false)
			for i, e in ipairs(items) do
				e:ToPickup().OptionsPickupIndex = 0
			end
		end
		for i = 0, DoorSlot.NUM_DOOR_SLOTS do
			local door = room:GetDoor(i)
			if door and door.TargetRoomType ~= RoomType.ROOM_SECRET and door.TargetRoomType ~= RoomType.ROOM_SUPERSECRET and door.TargetRoomType ~= RoomType.ROOM_ULTRASECRET and door.TargetRoomType ~= RoomType.ROOM_CURSE then
				local doorSprite = door:GetSprite()
				wakaba:ApplyDoorGraphics(door)
				doorSprite:Play(room:IsClear() and "Opened" or "Closed")
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
	if room:GetType() ~= RoomType.ROOM_SECRET and room:GetType() ~= RoomType.ROOM_CURSE then
		for i = 0, DoorSlot.NUM_DOOR_SLOTS do
			local door = room:GetDoor(i)
			if door and door.TargetRoomIndex then
				local targetroomdesc = level:GetRoomByIdx(door.TargetRoomIndex)
				if wakaba:IsValidWakabaRoom(targetroomdesc) then
					wakaba:ApplyDoorGraphics(door)
				end
			end
		end
	end
end

function wakaba:InitCrystalRestock_WinterAlbireo(slot)
	if wakaba:IsValidWakabaRoom(nil, wakaba.RoomTypes.WINTER_ALBIREO) and wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_MORE_OPTIONS) then
		return {extraCount = 2}
	end
end
wakaba:AddCallback(wakaba.Callback.PRE_EVALUATE_CRYSTAL_RESTOCK, wakaba.InitCrystalRestock_WinterAlbireo)

function wakaba:SlotSpawn_WinterAlbireo(entype, var, subtype, grindex, seed)
	if var ~= 14 then return end
	if not wakaba:IsValidWakabaRoom(nil, wakaba.RoomTypes.WINTER_ALBIREO) then return end
	local count = 0
	wakaba:ForAllPlayers(function(player)
		count = count + player:GetCollectibleNum(wakaba.Enums.Collectibles.WINTER_ALBIREO)
	end)
	print("extraItemSpawned :", extraItemSpawned, "count :", (count-1))
	if extraItemSpawned <= (count - 1) then
		extraItemSpawned = extraItemSpawned + 1
		return {5, 100, 0}
	else
		return {999, 175, 0}
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, wakaba.SlotSpawn_WinterAlbireo, EntityType.ENTITY_SLOT)