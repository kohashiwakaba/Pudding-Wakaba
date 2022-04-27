CCO = CCO or {}

if CCO.DamoclesAPI then return end

CCO.DamoclesAPI = RegisterMod("Damocles API", 1)
local game = Game()
local itemsTable = {}
local itempool = game:GetItemPool()
local DamoclesCacheFncs = {}

function CCO.DamoclesAPI.AddDamoclesCallback(fnc, fncFailsafe)
	if type(fnc) == "table" then
		table.insert(DamoclesCacheFncs, fncFailsafe)
	elseif not fncFailsafe then
		table.insert(DamoclesCacheFncs, fnc)
	end
end

local function countDamocles()
	local damoclesCount = 0
	for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
		damoclesCount = damoclesCount + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
	end
	
	return damoclesCount
end
CCO.DamoclesAPI.AddDamoclesCallback(countDamocles)

local function itemSpawnedOneFrameAgo(curRoom, dim)
	local gameFrameCount = game:GetFrameCount()
	for _, item in ipairs(itemsTable[dim][curRoom]) do
		if (item.FrameCount == gameFrameCount - 1) then
			return true
		end
	end

	return false
end

local function sharesPositionWithItem(curRoom, dim, pickup)
	for _, item in ipairs(itemsTable[dim][curRoom]) do
		if item.Position and pickup.Position:DistanceSquared(item.Position) <= 4 then
			return true
		end
	end

	return false
end

local function EvaluateDuplicates()
	local damoclesCount = 0
	
	for _, fnc in ipairs(DamoclesCacheFncs) do
		damoclesCount = damoclesCount + fnc()
	end
	
	return damoclesCount
end

local function getDimension(roomDesc) -- By Xalum and DeadInfinity.
	local level = game:GetLevel()
    local desc = roomDesc or level:GetCurrentRoomDesc()

    local hash = GetPtrHash(desc)
    for dim = 0, 2 do
        local dimensionDesc = level:GetRoomByIdx(desc.SafeGridIndex, dim)
		
        if GetPtrHash(dimensionDesc) == hash then
            return dim
        end
    end
	
	return 0
end

CCO.DamoclesAPI:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, function(_, pickup)
	if pickup.FrameCount > 1 then return end
	
	local room = game:GetRoom()
	if (not room:IsFirstVisit()) and room:GetFrameCount() <= 1 then	return end
	
	local damoclesCount = EvaluateDuplicates()
	if damoclesCount == 0 then return end
	
	local dim = getDimension()
	if dim == 2 then return end
	
	local level = game:GetLevel()
	local roomDesc = level:GetCurrentRoomDesc()
	local curRoom = roomDesc.SafeGridIndex
	
	if not itemsTable[dim] then
		itemsTable[dim] = {}
	end
	
	if not itemsTable[dim][curRoom] then
		itemsTable[dim][curRoom] = {}
	end
	
	itemsTable[dim][curRoom][#itemsTable[dim][curRoom] + 1] = {
		FrameCount = game:GetFrameCount(),
	}
	
	local data = pickup:GetData()
	if data.DamoclesDuplicate
	or pickup.SpawnerEntity
	or pickup.Touched == true
	then
		itemsTable[dim][curRoom][#itemsTable[dim][curRoom]].Position = pickup.Position
		return
	end
	
	if itemSpawnedOneFrameAgo(curRoom, dim) or sharesPositionWithItem(curRoom, dim, pickup) then
		itemsTable[dim][curRoom][#itemsTable[dim][curRoom]].Position = pickup.Position
		return
	end
	
	itemsTable[dim][curRoom][#itemsTable[dim][curRoom]].Position = pickup.Position
	
	if pickup:IsShopItem() then
		return
	end
	
	local roomPool = itempool:GetPoolForRoom(room:GetType(), roomDesc.SpawnSeed)
	local rng
	
	if pickup.OptionsPickupIndex ~= 0 then
		rng = wakaba.RNG
		rng:SetSeed(pickup.OptionsPickupIndex, 35)
	end
	
	for i = 1, damoclesCount do
		local targetItem = itempool:GetCollectible(roomPool, true, pickup.InitSeed)
		local distanceVar = i <= 3 and 60 or 20
		local targetPos = room:FindFreePickupSpawnPosition(pickup.Position, distanceVar)
		
		local newItem = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, targetItem, targetPos, Vector.Zero, nil)
		newItem:GetData().DamoclesDuplicate = true
		
		if rng then
			newItem:ToPickup().OptionsPickupIndex = rng:RandomInt(9999999998) + 1
		end
	end
end, PickupVariant.PICKUP_COLLECTIBLE)

CCO.DamoclesAPI:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, function(_, pickup)
	pickup:ClearEntityFlags(EntityFlag.FLAG_ITEM_SHOULD_DUPLICATE)
end, PickupVariant.PICKUP_COLLECTIBLE)

CCO.DamoclesAPI:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
	itemsTable = {}
end)

Isaac.DebugString("[wakaba]Damocles API: Loaded Successfully!")
print("Damocles API: Loaded Successfully!")