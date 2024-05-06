
local isc = require("wakaba_src.libs.isaacscript-common")

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

	local rng = RNG()
	local level = wakaba.G:GetLevel()

	local currentRoomIdx = level:GetCurrentRoomIndex()
	local candidates = isc:getNewRoomCandidatesForLevel()
	wakaba.FLog("debugLevelGen", "roomsToGenerate:", #roomsToGenerate, "/ candidates:", #candidates)
	while #roomsToGenerate > 0 and #candidates > 0 do
		local roomVar = isc:getRandomArrayElementAndRemove(roomsToGenerate, rng)
		local e = isc:getRandomArrayElementAndRemove(candidates, rng)
		local success = level:MakeRedRoomDoor(e.adjacentRoomGridIndex, e.doorSlot)
		wakaba.FLog("debugLevelGen", "Trying to Generate room for gridIndex", e.adjacentRoomGridIndex, "slot", e.doorSlot, success)
		if success then
			local roomData = isc:getRoomDataForTypeVariant(roomVar[1], roomVar[2], false)

			local writeableRoom = level:GetRoomByIdx(e.newRoomGridIndex, -1)
			writeableRoom.Data = roomData
			writeableRoom.Flags = writeableRoom.Flags & ~RoomDescriptor.FLAG_RED_ROOM -- remove red room flag

			level:UpdateVisibility()

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