local game = Game()
local isc = require("wakaba_src.libs.isaacscript-common")

local aqua_trinkets_data = {
	run = {
	},
	level = {
		aquatrinkets = {},
		triedindexes = {},
	},
	room = {
	}
}
wakaba:saveDataManager("Aqua Trinkets", aqua_trinkets_data)
wakaba.aquatrinkets = aqua_trinkets_data

function wakaba:getAquaTrinketChance()
	return wakaba.Enums.Chances.AQUA_TRINKET_DEFAULT
end

function wakaba:TryTurnAquaTrinket(trinket, clearAqua)
	local currentRoomIndex = isc:getRoomListIndex()
	if not aqua_trinkets_data.level.aquatrinkets[currentRoomIndex] then
		aqua_trinkets_data.level.aquatrinkets[currentRoomIndex] = {}
	end
	if not aqua_trinkets_data.level.triedindexes[currentRoomIndex] then
		aqua_trinkets_data.level.triedindexes[currentRoomIndex] = {}
	end
	if not clearAqua then
		table.insert(aqua_trinkets_data.level.aquatrinkets[currentRoomIndex], wakaba:getPickupIndex(trinket))
	end
	table.insert(aqua_trinkets_data.level.triedindexes[currentRoomIndex], wakaba:getPickupIndex(trinket))
	trinket:GetData().wakaba = trinket:GetData().wakaba or {}
	trinket:GetData().wakaba.isAquaTrinket = not clearAqua
end

local hasTrinketDropped = false
function wakaba:PickupInit_AquaTrinkets(pickup)
	if pickup.FrameCount ~= 1 then return end -- why
	local currentRoomIndex = isc:getRoomListIndex()
	if not aqua_trinkets_data.level.aquatrinkets[currentRoomIndex] then
		aqua_trinkets_data.level.aquatrinkets[currentRoomIndex] = {}
	end
	if not aqua_trinkets_data.level.triedindexes[currentRoomIndex] then
		aqua_trinkets_data.level.triedindexes[currentRoomIndex] = {}
	end
	if hasTrinketDropped then
		wakaba.Log("hasTrinketDropped detected, skipping...")
	end
	local hasAzure, onlyTaintedRira = wakaba:anyPlayerHasAzureRir()
	if hasAzure and not wakaba:has_value(wakaba.Blacklists.AquaTrinkets, pickup.SubType) then
		wakaba:TryTurnAquaTrinket(pickup)
	end

	if wakaba:IsEntryUnlocked("aquatrinkets") and not pickup.Touched and not hasTrinketDropped
	and (--[[not wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT) and ]] not wakaba:has_value(wakaba.Blacklists.AquaTrinkets, pickup.SubType)) then
		local isAquaTrinket = wakaba:has_value(aqua_trinkets_data.level.aquatrinkets[currentRoomIndex], wakaba:getPickupIndex(pickup))
		local alreadyTried = wakaba:has_value(aqua_trinkets_data.level.triedindexes[currentRoomIndex], wakaba:getPickupIndex(pickup))
		wakaba.Log("Aqua trinket check for seed "..wakaba:getPickupIndex(pickup).."/ isAquaTrinket :",isAquaTrinket,"/ alreadyTried :",alreadyTried)
		local rand = RNG()
		rand:SetSeed(pickup.InitSeed, 35)
		local ran = rand:RandomFloat()
		wakaba.Log("Aqua trinket roll for seed "..wakaba:getPickupIndex(pickup).." :", ran, "/", wakaba:getAquaTrinketChance())
		if not alreadyTried and ran < wakaba:getAquaTrinketChance() then
			if not isAquaTrinket then
				--print("Aqua Trinket Registered! ID :"..pickup.SubType)
				table.insert(aqua_trinkets_data.level.aquatrinkets[currentRoomIndex], wakaba:getPickupIndex(pickup))
				isAquaTrinket = true
			end
		end
		table.insert(aqua_trinkets_data.level.triedindexes[currentRoomIndex], wakaba:getPickupIndex(pickup))
		if isAquaTrinket then
			--print("Aqua Trinket spawned! ID :"..pickup.SubType)
			pickup:GetData().wakaba = pickup:GetData().wakaba or {}
			pickup:GetData().wakaba.isAquaTrinket = true
		end
	else
		wakaba.Log("Skipped Aqua trinket check for seed "..wakaba:getPickupIndex(pickup))
		table.insert(aqua_trinkets_data.level.triedindexes[currentRoomIndex], wakaba:getPickupIndex(pickup))
	end
	hasTrinketDropped = false
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupInit_AquaTrinkets, PickupVariant.PICKUP_TRINKET)

local rr, gg, bb = 1.0, 1.0, 1.0
local rt = 1.0
local rc = 1.0
local rb = 1.0
function wakaba:PickupRender_AquaTrinkets(pickup, offset)
	pickup:GetData().wakaba = pickup:GetData().wakaba or {}
	if pickup:GetData().wakaba.isAquaTrinket then
		local sprite = pickup:GetSprite()
		sprite.Color = wakaba.ColorDatas.aqu
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, wakaba.PickupRender_AquaTrinkets, PickupVariant.PICKUP_TRINKET)

function wakaba:TrinketCollision_AquaTrinkets(pickup, collider)
	local player = collider:ToPlayer()
	if player then
		wakaba.Log("hasTrinketDropped set")
		hasTrinketDropped = true
		wakaba:GetPlayerEntityData(player)
		pickup:GetData().wakaba = pickup:GetData().wakaba or {}
		if player and pickup:GetData().wakaba.isAquaTrinket then
			player:GetData().wakaba.tryAquaTrinket = pickup.SubType
			player:GetData().wakaba.prevTrinketPrimary = player:GetTrinket(0)
			player:GetData().wakaba.prevTrinketSecondary = player:GetTrinket(1)
			if player:GetTrinket(0) > 0 then
				player:TryRemoveTrinket(player:GetTrinket(0))
			end
			if player:GetTrinket(1) > 0 then
				player:TryRemoveTrinket(player:GetTrinket(1))
			end
		elseif player then
			player:GetData().wakaba.blockAquaSpawn = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.TrinketCollision_AquaTrinkets, PickupVariant.PICKUP_TRINKET)


function wakaba:PlayerUpdate_AquaTrinkets(player)
	if hasTrinketDropped then
		wakaba.Log("hasTrinketDropped unset")
		hasTrinketDropped = false
	end
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if not player:IsItemQueueEmpty() and data.wakaba.tryAquaTrinket then
		local queue = player.QueuedItem.Item
		if queue:IsTrinket() and queue.ID == (data.wakaba.tryAquaTrinket % TrinketType.TRINKET_GOLDEN_FLAG) then
			player:AnimateTrinket(data.wakaba.tryAquaTrinket, "UseItem")
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
			if data.wakaba.prevTrinketPrimary > 0 then
				player:AddTrinket(data.wakaba.prevTrinketPrimary)
			end
			if data.wakaba.prevTrinketSecondary > 0 then
				player:AddTrinket(data.wakaba.prevTrinketSecondary)
			end
			data.wakaba.prevTrinketPrimary = nil
			data.wakaba.prevTrinketSecondary = nil
			data.wakaba.tryAquaTrinket = nil
			if REPENTOGON then
				player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY, true)
			end
		end
	end
	if not player:IsCoopGhost() then
		data.wakaba.prevTrinketPrimary = data.wakaba.prevTrinketPrimary or 0
		data.wakaba.prevTrinketSecondary = data.wakaba.prevTrinketSecondary or 0

		local currentTrinketPrimary = player:GetTrinket(0)
		local currentTrinketSecondary = player:GetTrinket(1)

		if data.wakaba.prevTrinketPrimary ~= currentTrinketPrimary
		or data.wakaba.prevTrinketSecondary ~= currentTrinketSecondary then
			wakaba.Log("hasTrinketDropped set")
			hasTrinketDropped = true
		end
		data.wakaba.prevTrinketPrimary = currentTrinketPrimary
		data.wakaba.prevTrinketSecondary = currentTrinketSecondary
	end
	if data.wakaba.blockAquaSpawn then
		data.wakaba.blockAquaSpawn = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_AquaTrinkets)

if EID then
	local function AquaTrinketCondition(descObj)
		if not descObj.Entity then return false end
		local pickup = descObj.Entity
		return descObj.ObjType == 5
			and descObj.ObjVariant == PickupVariant.PICKUP_TRINKET
			and pickup:GetData().wakaba and pickup:GetData().wakaba.isAquaTrinket
	end
	local function AquaTrinketCallback(descObj)
		descObj.Description = EID:getDescriptionEntry("AquaTrinketText") .."#".. descObj.Description
		return descObj
	end
	EID:addDescriptionModifier("Wakaba Aqua Trinkets", AquaTrinketCondition, AquaTrinketCallback)
end
