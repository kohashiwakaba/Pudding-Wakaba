local DamoclesAPIVersion = 1.5
CCO = CCO or {}

if CCO.DamoclesAPI then
	if not CCO.DamoclesAPI.VERSION
	or CCO.DamoclesAPI.VERSION < DamoclesAPIVersion
	then
		Isaac.DebugString("Damocles API: [WARNING] A mod (or more) above this message has an outdated version of Damocles API, make sure to check which mod(s) do and notify their developer(s) to avoid errors.")
		Isaac.DebugString("Damocles API: [WARNING] Most up to date version: [" .. tostring(DamoclesAPIVersion) .. "] (mods with an older version than this should be disabled or updated)")
		Isaac.DebugString("Damocles API: [WARNING] Current loaded version: [" .. tostring(CCO.DamoclesAPI.VERSION or "UNKNOWN") .. "]")
		print("Damocles API: [WARNING] Outdated Damocles API version, check the log.txt file for more information.")
		print("Damocles API: [WARNING] C:/Users/[username]/Documents/My Games/Binding of Isaac Repentance/log.txt")
	end
	
	return
end

CCO.DamoclesAPI = RegisterMod("Damocles API", 1)
CCO.DamoclesAPI.VERSION = DamoclesAPIVersion
local game = Game()
local itemsTable = {}
local itempool = game:GetItemPool()

local DamoclesCacheFncs = {}
local disableDamocles = false
local activeBlacklist = {}
local pickupData = {}

function CCO.DamoclesAPI.AddActiveToBlacklist(itemId)
	if type(itemId) ~= "number"
	or itemId % 1 ~= 0 
	then
		Isaac.DebugString("Error - [CCO.DamoclesAPI.AddActiveToBlacklist] invalid argument #1 (itemId)")
		return false
	end
	
	activeBlacklist[itemId] = true
	
	return true
end
CCO.DamoclesAPI.AddActiveToBlacklist(CollectibleType.COLLECTIBLE_MOVING_BOX)
CCO.DamoclesAPI.AddActiveToBlacklist(CollectibleType.COLLECTIBLE_D6)
CCO.DamoclesAPI.AddActiveToBlacklist(CollectibleType.COLLECTIBLE_SPINDOWN_DICE)
CCO.DamoclesAPI.AddActiveToBlacklist(CollectibleType.COLLECTIBLE_FLIP)

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

local function getData(dataTable, entity)
	local index = tostring(entity.InitSeed)
	
	if dataTable[index] == nil then
		dataTable[index] = {}
	end
	
	return dataTable[index]
end

local function getPickupData(entity)
	return getData(pickupData, entity)
end

local function itemSpawnedOneFrameAgo(curRoom, dim)
	local gameFrameCount = game:GetFrameCount()
	for _, item in ipairs(itemsTable[dim][curRoom]) do
		if (item.FrameCount == gameFrameCount - 1) then
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

local function getDimension()
	local level = game:GetLevel()
    local roomIndex = level:GetCurrentRoomIndex()

    for i = 0, 2 do
        if GetPtrHash(level:GetRoomByIdx(roomIndex, i)) == GetPtrHash(level:GetRoomByIdx(roomIndex, -1)) then
            return i
        end
    end
    
    return 0
end

local function isButteredActive(pickup) -- may be able to proc false positives
	local player = pickup.SpawnerEntity and pickup.SpawnerEntity:ToPlayer() or nil
	
	if not player then
		return false
	end
	
	if player:GetActiveItem() == pickup.SubType
	and player:HasTrinket(TrinketType.TRINKET_BUTTER)
	then
		return true
	end
	
	return false
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
	
	local targetPos = pickup.TargetPosition
	local pickupData = getPickupData(pickup)
	local data = pickup:GetData() -- since it's a variable designed to be accessed by any mods.
	local player = pickup.SpawnerEntity and pickup.SpawnerEntity:ToPlayer() or nil
	
	if pickupData.targetPos
	and pickupData.targetPos[targetPos.X]
	and pickupData.targetPos[targetPos.X][targetPos.Y]
	then
		return
	end
	
	pickupData.targetPos = pickupData.targetPos or {}
	pickupData.targetPos[targetPos.X] = pickupData.targetPos[targetPos.X] or {}
	pickupData.targetPos[targetPos.X][targetPos.Y] = true
	
	if data.DamoclesDuplicate
	or pickup.Touched == true
	or itemSpawnedOneFrameAgo(curRoom, dim)
	or pickup:IsShopItem()
	then
		return
	end
	
	local roomPool = itempool:GetPoolForRoom(room:GetType(), roomDesc.SpawnSeed)
	local rng
	
	if pickup.OptionsPickupIndex ~= 0 then
		rng = RNG()
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

CCO.DamoclesAPI:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, itemId, rng, player)
	if activeBlacklist[itemId] then
		disableDamocles = true
	end
end)

CCO.DamoclesAPI:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, function(_, pickup)
	pickup:ClearEntityFlags(EntityFlag.FLAG_ITEM_SHOULD_DUPLICATE)
	
	if disableDamocles
	or isButteredActive(pickup)
	then
		local data = pickup:GetData()
		
		data.DamoclesDuplicate = true
	end
end, PickupVariant.PICKUP_COLLECTIBLE)

CCO.DamoclesAPI:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	disableDamocles = false
end)

CCO.DamoclesAPI:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
	itemsTable = {}
	pickupData = {}
end)

Isaac.DebugString("Damocles API: Loaded Successfully! Version: " .. CCO.DamoclesAPI.VERSION)
print("Damocles API: Loaded Successfully! Version: " .. CCO.DamoclesAPI.VERSION)