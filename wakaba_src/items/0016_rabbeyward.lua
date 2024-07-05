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
local sfx = SFXManager()
local rabbey_ward_data = {
	run = {
		ascentSharedSeeds = {},
	},
	level = {
		wardRooms = {},
	}
}

local rwr = wakaba.Enums.Constants.RABBEY_WARD_RADIUS
local rwe = wakaba.Enums.Constants.RABBEY_WARD_EXTRA_RADIUS

local offsetVecToCheck = {
	[RoomShape.ROOMSHAPE_1x1] = {
		Vector(0, 0),
	},
	[RoomShape.ROOMSHAPE_IH] = {
		Vector(0, 0),
	},
	[RoomShape.ROOMSHAPE_IV] = {
		Vector(0, 0),
	},
	[RoomShape.ROOMSHAPE_1x2] = {
		Vector(0, 0),
		Vector(0, 1),
	},
	[RoomShape.ROOMSHAPE_IIV] = {
		Vector(0, 0),
		Vector(0, 1),
	},
	[RoomShape.ROOMSHAPE_2x1] = {
		Vector(0, 0),
		Vector(1, 0),
	},
	[RoomShape.ROOMSHAPE_IIH] = {
		Vector(0, 0),
		Vector(1, 0),
	},
	[RoomShape.ROOMSHAPE_2x2] = {
		Vector(0, 0),
		Vector(0, 1),
		Vector(1, 0),
		Vector(1, 1),
	},
	[RoomShape.ROOMSHAPE_LTL] = {
		Vector(0, 0),
		Vector(0, 1),
		Vector(-1, 1),
	},
	[RoomShape.ROOMSHAPE_LTR] = {
		Vector(0, 0),
		Vector(0, 1),
		Vector(1, 1),
	},
	[RoomShape.ROOMSHAPE_LBL] = {
		Vector(0, 0),
		Vector(1, 0),
		Vector(1, 1),
	},
	[RoomShape.ROOMSHAPE_LBR] = {
		Vector(0, 0),
		Vector(0, 1),
		Vector(1, 0),
	},
}

wakaba:saveDataManager("Rabbey Ward", rabbey_ward_data)
wakaba.RabbeyWards = rabbey_ward_data.level.wardRooms
local wardsRoomsToRender = {}
wakaba.wardShaderRenderVal = 0

function wakaba:printRabbeyWardList()
	local wd = rabbey_ward_data.level.wardRooms
	wakaba.Log("Rabbey Ward powers: ")
	for index, val in pairs(wd) do
		local nx = index // 13
		local ny = index % 13
		local vecPos = Vector(nx, ny)
		wakaba.Log("Index", index, "/ Grid", vecPos, ":", val)
	end
end

---@param player EntityPlayer?
function wakaba:getWardPower(player)
	local power = rwr
	if player and player.QueuedItem then
		for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.EVALUATE_RABBEY_WARD_POWER)) do
			local retVal = callback.Function(callback.Mod, player)
			if retVal then
				if type(retVal) == "table" then
					power = retVal.Override or power
					power = power + (retVal.Extra or 0)
				elseif type(retVal) == "number" then
					power = power + retVal
				end
			end
		end
	else
		local maxPow = rwr + 0
		wakaba:ForAllPlayers(function (player)
			local ss = maxPow + 0
			for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.EVALUATE_RABBEY_WARD_POWER)) do
				local retVal = callback.Function(callback.Mod, player)
				if retVal then
					if type(retVal) == "table" then
						ss = retVal.Override or ss
						ss = ss + (retVal.Extra or 0)
					elseif type(retVal) == "number" then
						ss = ss + retVal
					end
				end
			end
			maxPow = math.max(maxPow, ss)
		end)
		power = maxPow + 0
	end
	power = power // 1
	return power
end

function wakaba:getRabbeyWardCheckArea(_gridIndex, radius)
	radius = radius or wakaba:getWardPower()
	local retGridIndexes = {}
	local retVectes = {}
	local roomDesc = wakaba.G:GetLevel():GetRoomByIdx(_gridIndex)
	local gridIndex = roomDesc.SafeGridIndex
	local roomData = roomDesc.Data
	local shape = roomData and roomData.Shape or RoomShape.ROOMSHAPE_1x1

	local nx = gridIndex % 13
	local ny = gridIndex // 13
	local vecPos = Vector(nx, ny)

	local vecToCheck = offsetVecToCheck[shape]

	for _, offset in ipairs(vecToCheck) do
		for xx = -radius, radius do
			for yy = -radius, radius do
				local distance = math.abs(xx) + math.abs(yy)
				if (distance <= radius) then
					local newVec = vecPos + Vector(xx, yy) + offset
					if newVec.X >= 0 and newVec.X < 13
					and newVec.Y >= 0 and newVec.Y < 13 then
						local gridIndex =  newVec.Y * 13 + newVec.X
						local roomDesc = wakaba.G:GetLevel():GetRoomByIdx(gridIndex)
						local shape = roomDesc.RoomShape
						table.insert(retGridIndexes, {v = newVec, i = gridIndex, d = distance, s = shape})
					end
				end
			end
		end
	end
	return retGridIndexes
end

function wakaba:updateRabbeyWardPower(gridIndex)
end

function wakaba:hasRabbeyWard(player)
	if not player then
		return false
	end
	if player:GetPlayerType() == wakaba.Enums.Players.RIRA_B then
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.RABBEY_WARD) then
		return true
	else
		return false
	end
end

function wakaba:Cache_RabbeyWard(player, cacheFlag)
	local gridIndex = wakaba.G:GetLevel():GetCurrentRoomIndex()
	local power = wakaba:getRabbeyWardPower(gridIndex)
	if power > 0 then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + ((0.5 * power) * wakaba:getEstimatedDamageMult(player))
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (0.2 * power * wakaba:getEstimatedTearsMult(player)))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_RabbeyWard)

function wakaba:UseItem_RabbeyWard(_, rng, player, useFlags, activeSlot, varData)
	local room = wakaba.G:GetRoom()
	if room:IsClear() then
		wakaba:ForAllPlayers(function (p)
			local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 4, Vector(p.Position.X, p.Position.Y - 95), Vector.Zero, nil):ToEffect()
			p:AddSoulHearts(2)
		end)
	end

	local level = wakaba.G:GetLevel()
	wakaba.G:MakeShockwave(player.Position, 0.018, 0.01, 320)
	wakaba:InstallRabbeyWard(player)
	wakaba:scheduleForUpdate(function()
		wakaba:revealWardMap(level:GetCurrentRoomIndex())
	end, 1)
	return {
		Discharge = true,
		Remove = false,
		ShowAnim = true,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_RabbeyWard, wakaba.Enums.Collectibles.RABBEY_WARD)

function wakaba:getRabbeyWardPower(gridIndex, taintedRira)
	if isc:inDeathCertificateArea() then return 0 end
	if taintedRira and gridIndex == 84 then
		return 3
	end
	if gridIndex < 0 then
		gridIndex = wakaba.G:GetLevel():GetPreviousRoomIndex()
	end
	local currRoomPower = rabbey_ward_data.level.wardRooms[tostring(gridIndex)]
	if currRoomPower and currRoomPower > 0 then
		return currRoomPower * 3
	end
	local checkedIndexes = {}
	--local currentGridLocation = isc:roomGridIndexToVector(gridIndex)
	local power = 0
	local testAreas = wakaba:getRabbeyWardCheckArea(gridIndex)
	for _, td in pairs(testAreas) do
		local index = td.i // 1
		local distance = td.d // 1
		local roomDesc = wakaba.G:GetLevel():GetRoomByIdx(index)
		--print("[]", index, rabbey_ward_data.level.wardRooms[tostring(index)])
		if rabbey_ward_data.level.wardRooms[tostring(index)] then
			if not checkedIndexes[tostring(index)] then
				local p = rabbey_ward_data.level.wardRooms[tostring(index)]
				--wakaba.Log("Ward power from index", index, "found: power:", p)
				power = math.max(power, (p * 3) - distance)
				checkedIndexes[tostring(index)] = true
			end
		elseif roomDesc and rabbey_ward_data.level.wardRooms[tostring(roomDesc.SafeGridIndex)] then
			if not checkedIndexes[tostring(roomDesc.SafeGridIndex)] then
				local p = rabbey_ward_data.level.wardRooms[tostring(roomDesc.SafeGridIndex)]
				--wakaba.Log("Ward power from safeindex", roomDesc.SafeGridIndex, "found: power:", p)
				power = math.max(power, (p * 3) - distance)
				checkedIndexes[tostring(roomDesc.SafeGridIndex)] = true
			end
		end
	end
	return power
end

function wakaba:recalculateWards()
	local room = wakaba.G:GetRoom()
	local wards = Isaac.FindByType(EntityType.ENTITY_SLOT, wakaba.Enums.Slots.RABBEY_WARD)
	local count = 0
	for i, value in ipairs(wards) do
		if value.GridCollisionClass ~= GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
			count = count + 1
		end
	end
	return math.max(count, 0)
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
	if MinimapAPI then
		wakaba:recalculateWardMinimap()
	end
	level:UpdateVisibility()
end

function wakaba:recalculateWardMinimap(wardAreas)
	if wardAreas then
		-- Partial scan
		for _, td in pairs(wardAreas) do
			local room = MinimapAPI:GetRoomByIdx(td.index)
			if room then
				wakaba.Log("Rabbey room found on index", td.index)
				local power = td.power
				if power > 0 then
					local np = math.min(power, 3)
					room.Color = Color(1, 0.5 + (0.1 * np), 0.85, np * 0.2, 0, 0, 0)
				else
					room.Color = nil
				end
			end
		end
	else
		-- Full scan
		for _,room in ipairs(MinimapAPI:GetLevel()) do
			local desc = room.Descriptor ---@type RoomDescriptor
			if desc then
				local power = wakaba:getRabbeyWardPower(desc.SafeGridIndex)
				if power > 0 then
					local np = math.min(power, 3)
					room.Color = Color(1, 0.5 + (0.1 * np), 0.85, np * 0.2, 0, 0, 0)
				else
					room.Color = nil
				end
			end
		end
	end
end

function wakaba:InstallRabbeyWard(player)
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	local freeSpawnPos = room:FindFreePickupSpawnPosition(player.Position)
	wakaba.G:MakeShockwave(freeSpawnPos, 0.036, 0.01, 320)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, freeSpawnPos, Vector(0,0), nil)
	local s = Isaac.Spawn(EntityType.ENTITY_SLOT, wakaba.Enums.Slots.RABBEY_WARD, 0, freeSpawnPos, Vector.Zero, player)
	s:AddEntityFlags(EntityFlag.FLAG_APPEAR)
	SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
	if wakaba:getOptionValue("chimakisound") then
		sfx:Play(wakaba.Enums.SoundEffects.CHIMAKI_KYUU, wakaba:getOptionValue("customsoundvolume") / 10 or 0.5)
	end
	if REPENTOGON and (room:GetType() ~= RoomType.ROOM_DUNGEON and room:GetBossID() ~= BossType.MEGA_SATAN) then
		local water = room:GetWaterAmount()
		local newWater = math.min(math.max(water, 0.5), 1)
		room:SetWaterAmount(newWater)
		--room:SetWaterColorMultiplier(KColor(1, 0.28, 0.57, 0.45))
	end
	local gridIndex = level:GetCurrentRoomIndex()
	local desc = level:GetCurrentRoomDesc()
	local wards = wakaba:recalculateWards()
	rabbey_ward_data.level.wardRooms[tostring(gridIndex)] = wards
	rabbey_ward_data.level.wardRooms[tostring(desc.SafeGridIndex)] = wards
	wakaba:scheduleForUpdate(function()
		wakaba:ForAllPlayers(function (player)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
			player:EvaluateItems()
		end)
	end, 0)
end


function wakaba:SlotInit_RabbeyWard(slot)
	if slot.GridCollisionClass ~= GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
		local sprite = slot:GetSprite()
		local slotSprite = slot:GetSprite()
		slot:AddEntityFlags(EntityFlag.FLAG_NO_REWARD | EntityFlag.FLAG_NO_KNOCKBACK | EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_NO_DEATH_TRIGGER)
		if slot:HasEntityFlags(EntityFlag.FLAG_APPEAR) then
			slotSprite:Play("Initiate")
		else
			slotSprite:Play("Idle")
		end
		local d = slot:GetData()
		d.wakaba_rabbeyLaserSeed = slot.DropSeed
		d.wakaba_rabbeyLaserCooldown = d.wakaba_rabbeyLaserCooldown or 0
	else
		--slot:Remove()
	end
end
wakaba:AddCallback(wakaba.Callback.SLOT_INIT, wakaba.SlotInit_RabbeyWard, wakaba.Enums.Slots.RABBEY_WARD)

---@param slot Entity|EntitySlot
function wakaba:SlotUpdate_RabbeyWard(slot)
	local d = slot:GetData()
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	local slotSprite = slot:GetSprite()
	local player = wakaba:GameHasBirthrightEffect(wakaba.Enums.Players.RIRA_B, true)
	if slotSprite:IsFinished("Initiate") then
		slot:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
		slotSprite:Play("Idle")
	end
	if slotSprite:IsFinished("Shoot") then
		d.wakaba_rabbeyLaserPos = nil
		slotSprite:Play("Idle")
	end

	if slot.GridCollisionClass == GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
		if not d.Dead then
			d.Dead = true
			wakaba:scheduleForUpdate(function ()
				local gridIndex = level:GetCurrentRoomIndex()
				local desc = level:GetCurrentRoomDesc()
				local wards = wakaba:recalculateWards()
				rabbey_ward_data.level.wardRooms[tostring(gridIndex)] = wards
				rabbey_ward_data.level.wardRooms[tostring(desc.SafeGridIndex)] = wards
				wardsRoomsToRender = wakaba:getNearbyWardRooms(gridIndex)
				wakaba:ForAllPlayers(function (player)
					player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
					player:EvaluateItems()
				end)
				wakaba:recalculateWardMinimap()
				wakaba.Log("Rabbey Ward killed! recalculating...")
			end, 1)
			slot:ClearEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK | EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
		end
		if slotSprite:IsFinished("Death") then
			slotSprite:Play("Broken")
		elseif not slotSprite:IsPlaying("Broken") then
			wakaba:RemoveDefaultPickup(slot)
			slotSprite:Play("Death")
		end
	elseif player then
		d.wakaba_rabbeyLaserCooldown = d.wakaba_rabbeyLaserCooldown - 1
		if d.wakaba_rabbeyLaserCooldown < 0 then
			local rng = RNG()
			rng:SetSeed(d.wakaba_rabbeyLaserSeed, 35)
			d.wakaba_rabbeyLaserCooldown = rng:RandomInt(20) + 26
			d.wakaba_rabbeyLaserSeed = rng:GetSeed()
			if not d.wakaba_rabbeyLaserPos then
				local enemy = wakaba:findNearestEntityByPartition(slot, EntityPartition.ENEMY)
				if enemy and enemy.Entity and enemy.Entity:Exists() then
					d.wakaba_rabbeyLaserPos = enemy.Entity.Position + Vector.Zero
					slotSprite:Play("Shoot")
				end
			end
		end
	end

	if slotSprite:IsPlaying("Shoot") then
		if slotSprite:IsEventTriggered("ShootLaser") then
			if wakaba:getOptionValue("chimakisound") then
				sfx:Play(wakaba.Enums.SoundEffects.CHIMAKI_KYUU, wakaba:getOptionValue("customsoundvolume") / 10 or 0.5)
			end
			local pos = d.wakaba_rabbeyLaserPos
			if pos then
				player = player or Isaac.GetPlayer()
				local angle = (pos - slot.Position):GetAngleDegrees()
				local laser = EntityLaser.ShootAngle(2, slot.Position, angle, 3, Vector(0, -30), player)
				laser:AddTearFlags(TearFlags.TEAR_RAINBOW | TearFlags.TEAR_HOMING | TearFlags.TEAR_SPECTRAL)
				laser.Parent = player
				laser.CollisionDamage = math.max(player.Damage, 3.5)
			end
		end
	else
		d.wakaba_rabbeyLaserPos = nil
	end
end

wakaba:AddCallback(wakaba.Callback.SLOT_UPDATE, wakaba.SlotUpdate_RabbeyWard, wakaba.Enums.Slots.RABBEY_WARD)

function wakaba:getNearbyRabbitWard(player)
	player = player or Isaac.GetPlayer()
	local room = wakaba.G:GetRoom()
	local wards = Isaac.FindByType(EntityType.ENTITY_SLOT, wakaba.Enums.Slots.RABBEY_WARD)
	local nearest = nil
	local nx, ny, nd = 2000, 2000, 2000
	local nv = nil
	for i, value in ipairs(wards) do
		if value.GridCollisionClass ~= GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
			local x, y = value.Position.X, value.Position.Y
			local dx, dy = (player.Position.X - x), (player.Position.Y - y)
			local distance = math.sqrt((dx ^ 2) + (dy ^ 2))
			if distance < nd then
				nearest = value
				nx, ny, nd = dx, dy, distance
				nv = Vector(-nx, -ny)
			end
		end
	end
	return nearest
end

function wakaba.RoomClear_RabbeyWard()
	local wards = wakaba:recalculateWards()
	if wards > 0 then
		wakaba:ForAllPlayers(function (player)
			local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 4, Vector(player.Position.X, player.Position.Y - 95), Vector.Zero, nil):ToEffect()
			player:AddSoulHearts(wards * 2)
		end)
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_RabbeyWard)
--wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.RoomClear_RabbeyWard)

function wakaba:Update_RabbeyWard()
	local room = wakaba.G:GetRoom()
	local gridIndex = wakaba.G:GetLevel():GetCurrentRoomIndex()
	local power = wakaba:getRabbeyWardPower(gridIndex) * 10
	local curr = wakaba.wardShaderRenderVal // 1
	--print("Shader ", (wardShaderRender // 1) ~= power * 10, (wardShaderRender // 1), power * 10)
	if curr > power then
		wakaba.wardShaderRenderVal = math.floor(wakaba:Lerp(wakaba.wardShaderRenderVal, power, 0.08))
	elseif curr < power then
		wakaba.wardShaderRenderVal = math.ceil(wakaba:Lerp(wakaba.wardShaderRenderVal, power, 0.08))
	end
	if room:GetFrameCount() % 150 == 2 then
		local ward = wakaba:getNearbyRabbitWard()
		if ward then
			wakaba.G:MakeShockwave(ward.Position, 0.018, 0.01, 320)
		else
			local currentGridLocation = isc:roomGridIndexToVector(gridIndex)
			local centerPos = room:GetCenterPos()
			for _, entry in pairs(wardsRoomsToRender) do
				--local listIndex = entry.listIndex
				local gridLocation = entry.grid
				local centerPos = room:GetCenterPos()
				if gridLocation ~= currentGridLocation then
					--print(centerPos, gridLocation, currentGridLocation, centerPos + (gridLocation - currentGridLocation) * Vector(640, 600))
					wakaba.G:MakeShockwave(centerPos + (gridLocation - currentGridLocation) * Vector(640, 600), 0.018, 0.01, 320)
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_RabbeyWard)

---@param gridIndex integer|RoomDescriptor
---@return table
function wakaba:getNearbyWardRooms(gridIndex)
	local checkedIndexes = {}
	local loc = {}
	if isc:inDeathCertificateArea() then return loc end
	gridIndex = gridIndex or wakaba.G:GetLevel():GetCurrentRoomIndex()
	--local currentGridLocation = isc:roomGridIndexToVector(gridIndex)
	local testAreas = wakaba:getRabbeyWardCheckArea(gridIndex)
	for _, td in pairs(testAreas) do
		local index = td.i // 1
		local grid = td.v
		local distance = td.d // 1
		local roomDesc = wakaba.G:GetLevel():GetRoomByIdx(index)
		if rabbey_ward_data.level.wardRooms[tostring(index)] then
			if not checkedIndexes[tostring(index)] then
				local p = rabbey_ward_data.level.wardRooms[tostring(index)]
				table.insert(loc, {
					index = index,
					grid = grid,
					power = p > 0 and 3 - distance or 0,
				})
				checkedIndexes[tostring(index)] = true
			end
		elseif rabbey_ward_data.level.wardRooms[tostring(roomDesc.SafeGridIndex)] then
			if not checkedIndexes[tostring(roomDesc.SafeGridIndex)] then
				local p = rabbey_ward_data.level.wardRooms[tostring(roomDesc.SafeGridIndex)]
				table.insert(loc, {
					index = index,
					grid = grid,
					power = p > 0 and 3 - distance or 0,
				})
				checkedIndexes[tostring(roomDesc.SafeGridIndex)] = true
			end
		end
	end
	return loc
end
local delayWardEffect = false
function wakaba:CurseEval_RabbeyWard()
	wakaba.wardShaderRenderVal = 0
	delayWardEffect = true
end
wakaba:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, wakaba.CurseEval_RabbeyWard)

local lastRabbeyPower = 0
local function newRoomFunc()
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	local rabbeyPower = wakaba:getRabbeyWardPower(level:GetCurrentRoomIndex())
	if rabbeyPower > 0 then
		--isc:openDoorFast()
		if REPENTOGON and (room:GetType() ~= RoomType.ROOM_DUNGEON and room:GetBossID() ~= BossType.MEGA_SATAN) then
			local water = room:GetWaterAmount()
			local newWater = math.min(math.max(water, 0.16 * rabbeyPower), 1)
			room:SetWaterAmount(newWater)
			--room:SetWaterColorMultiplier(KColor(1, 0.28, 0.57, 0.15 * rabbeyPower))
		end
	end
	if not isc:inDeathCertificateArea() then
		wardsRoomsToRender = wakaba:getNearbyWardRooms(gridIndex)
	end
	if rabbeyPower ~= lastRabbeyPower then
		wakaba:ForAllPlayers(function (player)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
			player:EvaluateItems()
		end)
		lastRabbeyPower = rabbeyPower
	end
end

function wakaba:NewRoom_RabbeyWard()
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	if delayWardEffect then
		wakaba:scheduleForUpdate(function ()
			newRoomFunc()
		end, 0)
	else
		newRoomFunc()
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
	delayWardEffect = false
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_RabbeyWard)

wakaba:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, CallbackPriority.LATE, function ()
	wakaba:recalculateWardMinimap()
end)

wakaba:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, function(_, shaderName)
	if shaderName == "wakaba_RabbeyWardArea" then

		local params = {
			Strength = wakaba.wardShaderRenderVal * 0.03,
			Time = Isaac.GetFrameCount()
		}
		return params
	end
end)