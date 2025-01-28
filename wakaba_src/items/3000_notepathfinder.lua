
local isc = _wakaba.isc

local function shouldSpawnTrinket(onInit)
	local level = wakaba.G:GetLevel()
	if wakaba.G:GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH) then return false end
	if onInit and wakaba.G:GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT) then return false end
	if level:GetAbsoluteStage() == LevelStage.STAGE3_2
	and (level:GetStageType() == StageType.STAGETYPE_REPENTANCE or level:GetStageType() == StageType.STAGETYPE_REPENTANCE_B)
	then
		return true
	end
	if level:GetAbsoluteStage() == LevelStage.STAGE3_1
	and (level:GetStageType() == StageType.STAGETYPE_REPENTANCE or level:GetStageType() == StageType.STAGETYPE_REPENTANCE_B)
	and (level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH > 0 or wakaba.G:GetSeeds():HasSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_LABYRINTH))
	then
		return true
	end
end

function wakaba:RoomGen_BringMeThere()
	--print("challenge check")
	if wakaba.G.Challenge ~= Challenge.CHALLENGE_NULL then return end
	wakaba.runstate.savednoteroom = nil
	local level = wakaba.G:GetLevel()
	local currentRoomIdx = level:GetCurrentRoomIndex()
	--print("condition check")
	if shouldSpawnTrinket(true) then
		local roomData = isc:getRoomDataForTypeVariant(RoomType.ROOM_BOSS, 43000)

		local altMomRoom = level:GetRoomByIdx(-11)
		local altBeastRoom = level:GetRoomByIdx(-9)
		altBeastRoom.Data = roomData

		--local roomData = isc:getRoomDataForTypeVariant(RoomType.ROOM_BOSS, 42000)
		local rooms = isc:getRoomsInsideGrid()
		for _, room in ipairs(rooms) do
			if room.Data then
				if room.GridIndex > 0 and room.Data.Type == RoomType.ROOM_BOSS and room.Data.Subtype == 89 then
					altMomRoom.Data = room.Data
					wakaba.runstate.savednoteroom = room.GridIndex
					if wakaba.state.forcevoid.beast == 1 then
						local note = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.Enums.Trinkets.BRING_ME_THERE, wakaba.G:GetRoom():GetGridPosition(102), Vector(0,0), nil):ToPickup()
						wakaba:TryTurnAquaTrinket(note, true)
					end
					break
				end
			end
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_LEVEL, CallbackPriority.EARLY, wakaba.RoomGen_BringMeThere)

local recentPower = 0
function wakaba:Update_BringMeThere()
	if wakaba.G.Challenge ~= Challenge.CHALLENGE_NULL then return end
	local level = wakaba.G:GetLevel()
	if wakaba.runstate.savednoteroom and shouldSpawnTrinket() then
		local savedBossRoom = level:GetRoomByIdx(wakaba.runstate.savednoteroom)
		if savedBossRoom.VisitedCount > 0 then return end
		local currentPower = wakaba:GetGlobalTrinketMultiplier(wakaba.Enums.Trinkets.BRING_ME_THERE)
		if recentPower ~= currentPower then
			local isBeastRun = currentPower > 0
			--savedBossRoom.SurpriseMiniboss = isBeastRun
			wakaba.G:SetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT, isBeastRun)

			local altMomRoom = level:GetRoomByIdx(-11)
			local altBeastRoom = level:GetRoomByIdx(-9)
			if isBeastRun then
				--savedBossRoom.Data = altBeastRoom.Data
				savedBossRoom.Data = REPENTOGON and RoomConfigHolder.GetRoomByStageTypeAndVariant(StbType.MAUSOLEUM, RoomType.ROOM_BOSS, 1, 5) or altBeastRoom.Data
			else
				--savedBossRoom.Data = altMomRoom.Data
				savedBossRoom.Data = REPENTOGON and RoomConfigHolder.GetRoomByStageTypeAndVariant(StbType.SPECIAL_ROOMS, RoomType.ROOM_BOSS, 6030, 5) or altMomRoom.Data
			end

		end
		recentPower = currentPower
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_BringMeThere)

function wakaba:dadNoteCache(player, cacheFlag)
	if player:HasTrinket(wakaba.Enums.Trinkets.BRING_ME_THERE) and cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
		player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (1.5 * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.BRING_ME_THERE) * wakaba:getEstimatedTearsMult(player)))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.dadNoteCache)

function wakaba.dadNotePickupCheck(pickup)
	if pickup.Variant == PickupVariant.PICKUP_TRINKET and pickup.SubType == wakaba.Enums.Trinkets.BRING_ME_THERE and wakaba.G.Challenge ~= Challenge.CHALLENGE_NULL then
		pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, TrinketType.TRINKET_NULL)
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.dadNotePickupCheck)

function wakaba.NewRoom_BringMeThere()
	if wakaba.G.Challenge ~= Challenge.CHALLENGE_NULL then return end
	if not wakaba.G:GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT) then return end
	if not wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.BRING_ME_THERE) then return end
	if not wakaba.runstate.savednoteroom then return end
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	local targetGridIndex = wakaba.runstate.savednoteroom
	if room:GetType() == RoomType.ROOM_BOSS and level:GetCurrentRoomIndex() == targetGridIndex then
		if wakaba.G:GetStateFlag(GameStateFlag.STATE_MAUSOLEUM_HEART_KILLED) then
			wakaba.runstate.savednoteroom = nil
			wakaba.G:SetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT, false)
			room:SpawnGridEntity(37, GridEntityType.GRID_TRAPDOOR, 0, level:GetDungeonPlacementSeed(), 0)
		else
			room:TrySpawnSecretExit(false, true)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_BringMeThere)


-- TODO move this to other file
local stageTypeToOffset = {
	[StageType.STAGETYPE_ORIGINAL] = 0,
	[StageType.STAGETYPE_WOTL] = 1,
	[StageType.STAGETYPE_AFTERBIRTH] = 2,
	[StageType.STAGETYPE_REPENTANCE] = 4,
}
function wakaba:RoomEntitySpawn_AltHeart(type)
	if not wakaba:IsLunatic() or (type ~= EntityType.ENTITY_MOMS_HEART) then return end
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	local stage = level:GetAbsoluteStage()
	local oldStageType = level:GetStageType()
	if room:IsClear() then return end

	if room:GetBossID() == 8 or room:GetBossID() == 25 then
		level:SetStage(stage, StageType.STAGETYPE_REPENTANCE)
		wakaba:scheduleForUpdate(function()
			level:SetStage(stage, stageTypeToOffset[oldStageType])
		end, 1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, wakaba.RoomEntitySpawn_AltHeart)