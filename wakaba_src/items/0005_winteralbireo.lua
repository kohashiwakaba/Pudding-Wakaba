local isc = require("wakaba_src.libs.isaacscript-common")


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

function wakaba:NewLevel_WinterAlbireo()
	local level = wakaba.G:GetLevel()
	local player = isc:getPlayersWithCollectible(wakaba.Enums.Collectibles.WINTER_ALBIREO)[1] or Isaac.GetPlayer()
	if (isc:anyPlayerHasCollectible(wakaba.Enums.Collectibles.WINTER_ALBIREO) or isc:anyPlayerIs(wakaba.Enums.Players.RICHER_B))
	and level:GetAbsoluteStage() <= LevelStage.STAGE4_2
	and wakaba.G:GetFrameCount() > 0
	and not level:IsAscent() then
		local roomData = isc:getRoomDataForTypeVariant(RoomType.ROOM_PLANETARIUM, 0)
		local RECOMMENDED_SHIFT_IDX = 35
		
		local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.WINTER_ALBIREO)
		local newRoomPoint = isc:newRoom(rng)
		--print(newRoomPoint)
		if newRoomPoint then
			isc:setRoomData(newRoomPoint, roomData)
		end
		if MinimapAPI then
			MinimapAPI:LoadDefaultMap()
		end
	end

end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_WinterAlbireo)