local isc = require("wakaba_src.libs.isaacscript-common")

local RECOMMENDED_SHIFT_IDX = 35

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
		if (roomdesc.Data.Variant >= wakaba.RoomIDs.MIN_RICHER_ROOM_ID and roomdesc.Data.Variant <= wakaba.RoomIDs.MAX_RICHER_ROOM_ID) --[[ or mod.savedata.TaintedLuarooms[roomdesc.GridIndex] ]] then
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
	if (isc:anyPlayerHasCollectible(wakaba.Enums.Collectibles.WINTER_ALBIREO) or isc:anyPlayerIs(wakaba.Enums.Players.RICHER_B))
	and level:GetAbsoluteStage() <= LevelStage.STAGE4_2
	and wakaba.G:GetFrameCount() > 0
	and not level:IsAscent() then
			
		local seeds = wakaba.G:GetSeeds()
		local startSeed = seeds:GetStageSeed(level:GetAbsoluteStage())
		srng = RNG()
		srng:SetSeed(startSeed, RECOMMENDED_SHIFT_IDX)

		if isc:hasCurse(LevelCurse.CURSE_OF_LABYRINTH) then
			local roomNo = wakaba:GetRicherRooms(nil, srng)
			local roomData = isc:getRoomDataForTypeVariant(RoomType.ROOM_PLANETARIUM, roomNo)
			
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.WINTER_ALBIREO)
			local newRoomPoint = isc:newRoom(rng)
			--print(newRoomPoint)
			if newRoomPoint then
				isc:setRoomData(newRoomPoint, roomData)
				table.insert(wakaba.minimapRooms, newRoomPoint)
			end
		else
			local roomNo = wakaba:GetRicherRooms(nil, srng)
			local roomData = isc:getRoomDataForTypeVariant(RoomType.ROOM_PLANETARIUM, roomNo)
			
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.WINTER_ALBIREO)
			local newRoomPoint = isc:newRoom(rng)
			--print(newRoomPoint)
			if newRoomPoint then
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
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_WinterAlbireo)

--[[ wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, function(_, fam)
	print("[wakaba] Familiar Init : "..fam.Variant.."."..fam.SubType)
end) ]]