local isc = require("wakaba_src.libs.isaacscript-common")

local RECOMMENDED_SHIFT_IDX = 35

if StageAPI then
	wakaba.luarooms = {}
	wakaba.luarooms.WINTER_ALBIREO = StageAPI.RoomsList("wakaba_WinterAlbireoRooms", require("resources.wakaba_luarooms.winteralbireo"))
end

function wakaba:hasAlbireo(player)
	if not player then 
		return false 
	end
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
    return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.WINTER_ALBIREO) then
		return true
	else
		return false
	end
end

function wakaba:IsValidWakabaRoom(roomdesc)
	-- Richer Planetariums for Winter Albireo
	if roomdesc and roomdesc.Data and roomdesc.Data.Type == RoomType.ROOM_PLANETARIUM then
		if (roomdesc.Data.Variant >= wakaba.RoomIDs.MIN_RICHER_ROOM_ID and roomdesc.Data.Variant <= wakaba.RoomIDs.MAX_RICHER_ROOM_ID) or (wakaba.runstate.luarooms and wakaba.runstate.luarooms[roomdesc.GridIndex]) then
			return true
		end
	end
	return false
end

function wakaba:GetRicherRooms(roomType, rng)
	if not rng then
		local seeds = wakaba.G:GetSeeds()
		--local startSeed = seeds:GetStageSeed(wakaba.G:GetLevel():GetAbsoluteStage())
		local startSeed = seeds:GetStartSeed()
		rng = RNG()
		rng:SetSeed(startSeed, RECOMMENDED_SHIFT_IDX)
	end
	local candidates = {}
	local min = wakaba.RoomIDs.MIN_RICHER_ROOM_ID
	local max = wakaba.RoomIDs.MAX_RICHER_ROOM_ID
	local result = wakaba.RoomIDs.MIN_RICHER_ROOM_ID

	for i = min, max do
		table.insert(candidates, i)
	end
	
	result = candidates[rng:RandomInt(#candidates) + 1]
	return result
end

wakaba.minimapRooms = {}
function wakaba:NewLevel_WinterAlbireo()
	local level = wakaba.G:GetLevel()
	local player = isc:getPlayersWithCollectible(wakaba.Enums.Collectibles.WINTER_ALBIREO)[1] or Isaac.GetPlayer()
	if (wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.WINTER_ALBIREO) or isc:anyPlayerIs(wakaba.Enums.Players.RICHER_B))
	and level:GetAbsoluteStage() <= LevelStage.STAGE4_2
	and wakaba.G:GetFrameCount() > 0
	and not level:IsAscent() then
			
		local seeds = wakaba.G:GetSeeds()
		local startSeed = seeds:GetStageSeed(level:GetAbsoluteStage())
		srng = RNG()
		srng:SetSeed(startSeed, RECOMMENDED_SHIFT_IDX)

		if --[[ wakaba.luarooms ]] StageAPI and StageAPI.InOverriddenStage() then
			local roomNo = wakaba:GetRicherRooms(nil, srng)
			
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.WINTER_ALBIREO)
			local newRoomPoint = isc:newRoom(rng)
			--print(newRoomPoint)
			if newRoomPoint then
				local newroomdesc = isc:getRoomDescriptor(newRoomPoint)
				--newroomdesc.Data = data
				local data = StageAPI.GetGotoDataForTypeShape(RoomType.ROOM_PLANETARIUM, RoomShape.ROOMSHAPE_1x1)

				newroomdesc.Data = data
				local luaroom = StageAPI.LevelRoom{
					RoomType = RoomType.ROOM_DEFAULT,
					RequireRoomType = false,
					RoomsList = wakaba.luarooms.WINTER_ALBIREO,
					RoomDescriptor = newroomdesc
				}
				StageAPI.SetLevelRoom(luaroom, newroomdesc.ListIndex)
				newroomdesc.Flags = 0
				wakaba:UpdateRoomDisplayFlags(newroomdesc)
				level:UpdateVisibility()

				wakaba.runstate.luarooms = wakaba.runstate.luarooms or {}
				wakaba.runstate.luarooms[newRoomPoint] = true

				table.insert(wakaba.minimapRooms, newRoomPoint)
			end
		else
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.WINTER_ALBIREO)
			local newRoomPoint = isc:newRoom(rng)
			--print(newRoomPoint)
			if newRoomPoint then
				local roomNo = wakaba:GetRicherRooms(nil, srng)
				local roomData = isc:getRoomDataForTypeVariant(RoomType.ROOM_PLANETARIUM, roomNo)
				isc:setRoomData(newRoomPoint, roomData)
				table.insert(wakaba.minimapRooms, newRoomPoint)
			end
		end
		if MinimapAPI then
			MinimapAPI:LoadDefaultMap()
	
			if #wakaba.minimapRooms > 0 then
				for i, roomidx in pairs(wakaba.minimapRooms) do
					local minimaproom = MinimapAPI:GetRoomByIdx(roomidx)
					wakaba:scheduleForUpdate(function()
						if minimaproom then
							minimaproom.Color = Color(MinimapAPI.Config.DefaultRoomColorR, MinimapAPI.Config.DefaultRoomColorG, MinimapAPI.Config.DefaultRoomColorB, 1, 0, 0, 0)
							if wakaba:IsValidWakabaRoom(minimaproom.Descriptor) then
								minimaproom.PermanentIcons = {"wakaba_RicherPlanetariumIcon"}
							end
							wakaba.minimapRooms[i] = nil
						end
					end, 0)
				end
			else
				wakaba.minimapRooms = {}
			end
		end
	end

end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_WinterAlbireo)

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
			if wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_MORE_OPTIONS) then
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
			if door then
				local doorSprite = door:GetSprite()
				wakaba:ApplyDoorGraphics(door)
				doorSprite:Play("Opened")
			end
		end
	else
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
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_WinterAlbireo)

--[[ wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, function(_, fam)
	print("[wakaba] Familiar Init : "..fam.Variant.."."..fam.SubType)
end) ]]