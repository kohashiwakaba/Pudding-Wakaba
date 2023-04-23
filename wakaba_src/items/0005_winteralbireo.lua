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
			print(newRoomPoint)
			if newRoomPoint then
				isc:setRoomData(newRoomPoint, roomData)
			end
		else
			local roomNo = wakaba:GetRicherRooms(nil, srng)
			local roomData = isc:getRoomDataForTypeVariant(RoomType.ROOM_PLANETARIUM, roomNo)
			
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.WINTER_ALBIREO)
			local newRoomPoint = isc:newRoom(rng)
			print(newRoomPoint)
			if newRoomPoint then
				isc:setRoomData(newRoomPoint, roomData)
			end
		end
		if MinimapAPI then
			MinimapAPI:LoadDefaultMap()
		end
	end

end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_WinterAlbireo)


--[[ wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, function(_, fam)
	print("[wakaba] Familiar Init : "..fam.Variant.."."..fam.SubType)
end) ]]