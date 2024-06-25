--[[
	Rabbey Ward (토끼 와드) - 액티브(Active / 6 rooms)
	뒤집힌 리라로 델리리움 처치
	Soul of Rira (리라의 영혼) - 영혼석(Soul Stone / 4 rooms)
	뒤집힌 리라로 보스러시/허쉬 처치

	사용 시 토끼 와드 설치, 설치한 위치의 맵 상 반경 3칸 범위의 방을 보여줌,
	토끼 와드 근처의 방에 있으면 ???

	리라영혼 한정 추가 - 그 방의 모든 장신구를 아쿠아화 (해금 무관)
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
local rabbey_ward_data = {
	run = {
		ascentSharedSeeds = {},
	},
	floor = {
		wards = {},
		wardRooms = {},
	}
}
wakaba:saveDataManager("Rabbey Ward", rabbey_ward_data)
wakaba.RabbeyWards = rabbey_ward_data.floor.wards
wakaba.RabbeyWardRooms = rabbey_ward_data.floor.wardRooms
local wardsRoomsToRender = {}

function wakaba:Cache_RabbeyWard(player, cacheFlag)
	local gridIndex = wakaba.G:GetLevel():GetCurrentRoomIndex()
	local power = wakaba:getRabbeyWardPower(gridIndex)
	if power > 0 then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + ((1.5 * power) * wakaba:getEstimatedDamageMult(player))
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (0.5 * power * wakaba:getEstimatedTearsMult(player)))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_Minerva)

function wakaba:UseItem_RabbeyWard(_, rng, player, useFlags, activeSlot, varData)
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	wakaba.G:MakeShockwave(player.Position, 0.018, 0.01, 320)
	wakaba:InstallRabbeyWard(player)
	wakaba:revealWardMap(level:GetCurrentRoomIndex())
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_RabbeyWard, wakaba.Enums.Collectibles.RABBEY_WARD)

function wakaba:getRabbeyWardPower(gridIndex)
	if wakaba.RabbeyWardRooms[gridIndex] then
		return 3
	end
	local currentGridLocation = isc:roomGridIndexToVector(gridIndex)
	local power = 0
	for index, value in pairs(wakaba.RabbeyWardRooms) do
		local gridLocation = isc:roomGridIndexToVector(index)
		local distVec = currentGridLocation - gridLocation
		local calculatedDist = math.abs(distVec.X) + math.abs(distVec.Y)
		power = math.max(power, 3 - calculatedDist)
	end
	return power
end

function wakaba:revealWardMap(gridIndex)
	local level = wakaba.G:GetLevel()
	local currentGridLocation = isc:roomGridIndexToVector(gridIndex)
	local pendingRooms = {}
	for index = 0, 168 do
		local gridLocation = isc:roomGridIndexToVector(index)
		local distVec = currentGridLocation - gridLocation
		local calculatedDist = math.abs(distVec.X) + math.abs(distVec.Y)
		if calculatedDist <= 2 then
			local roomdesc = level:GetRoomByIdx(index)
			local roomdata = roomdesc.Data
			if roomdata and roomdesc.DisplayFlags then
				roomdesc.DisplayFlags = roomdesc.DisplayFlags | RoomDescriptor.DISPLAY_BOX | RoomDescriptor.DISPLAY_ICON
			end
			table.insert(pendingRooms, {i = index, p = (3 - calculatedDist)})
		end
	end
	level:UpdateVisibility()
end

function wakaba:InstallRabbeyWard(player)
	--wakaba.G:MakeShockwave(player.Position, 0.036, 0.01, 320)
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	--Isaac.Spawn(EntityType.ENTITY_SLOT, wakaba.Enums.Slots.RABBEY_WARD, 0, player.Position, Vector.Zero, nil)
	if REPENTOGON then
		room:SetWaterAmount(0.9)
		room:SetWaterColorMultiplier(KColor(1, 0.28, 0.57, 0.45))
	end
	local desc = level:GetCurrentRoomDesc()
	local wards = wakaba:recalculateWards()
	wakaba.RabbeyWardRooms[desc.GridIndex] = wards
	wakaba.RabbeyWardRooms[desc.SafeGridIndex] = wards
	wakaba.RabbeyWardRooms[level:GetCurrentRoomIndex()] = wards
end

function wakaba:Update_RabbeyWard()
	local room = wakaba.G:GetRoom()
	if room:GetFrameCount() % 150 == 2 then
		local gridIndex = wakaba.G:GetLevel():GetCurrentRoomIndex()
		local currentGridLocation = isc:roomGridIndexToVector(gridIndex)
		local centerPos = room:GetCenterPos()
		for _, entry in pairs(wardsRoomsToRender) do
			local listIndex = entry.listIndex
			local gridLocation = entry.grid
			local centerPos = room:GetCenterPos()
			if gridLocation ~= currentGridLocation then
				--print(centerPos, gridLocation, currentGridLocation, centerPos + (gridLocation - currentGridLocation) * Vector(640, 600))
				wakaba.G:MakeShockwave(centerPos + (gridLocation - currentGridLocation) * Vector(640, 600), 0.018, 0.01, 320)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_RabbeyWard)

function wakaba:recalculateWards()
	local room = wakaba.G:GetRoom()
	local wards = Isaac.FindByType(EntityType.ENTITY_SLOT, wakaba.Enums.Slots.RABBEY_WARD)
	return math.max(#wards, 0)
end

function wakaba:getNearbyWardRooms(gridIndex)
	local loc = {}
	gridIndex = gridIndex or wakaba.G:GetLevel():GetCurrentRoomIndex()
	local currentGridLocation = isc:roomGridIndexToVector(gridIndex)
	for index, value in pairs(wakaba.RabbeyWardRooms) do
		local gridLocation = isc:roomGridIndexToVector(index)
		local distVec = currentGridLocation - gridLocation
		local calculatedDist = math.abs(distVec.X) + math.abs(distVec.Y)
		if calculatedDist <= 2 then
			table.insert(loc, {
				index = gridLocation,
				grid = gridLocation,
				power = 3 - calculatedDist,
			})
		end
	end
	return loc
end

function wakaba:NewRoom_RabbeyWard()
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	local rabbeyPower = wakaba:getRabbeyWardPower(level:GetCurrentRoomIndex())
	if rabbeyPower > 0 then
		--isc:openDoorFast()
		if REPENTOGON then
			room:SetWaterAmount(0.3 * rabbeyPower)
			room:SetWaterColorMultiplier(KColor(1, 0.28, 0.57, 0.15 * rabbeyPower))
		end
	end
	if room:IsFirstVisit() and room:IsClear() then
		wakaba:ForAllPlayers(function (player)---@param player EntityPlayer
			if player:GetPlayerType() == wakaba.Enums.Players.RIRA_B then
				for i = 0, 3 do
					local activeId = player:GetActiveItem(i)
					if activeId == wakaba.Enums.Collectibles.RABBEY_WARD then
						wakaba:AddCharges(player, i, 1)
						break
					end
				end
			end
		end)
	end
	wardsRoomsToRender = wakaba:getNearbyWardRooms(gridIndex)
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_RabbeyWard)