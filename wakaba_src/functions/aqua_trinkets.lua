local game = Game()
local isc = require("wakaba_src.libs.isaacscript-common")

local aqua_trinkets_data = {
	run = {
	},
	floor = {
		aquatrinkets = {},
	},
	room = {
	}
}
wakaba:saveDataManager("Aqua Trinkets", aqua_trinkets_data)
wakaba.aquatrinkets = aqua_trinkets_data

function wakaba:TryTurnAquaTrinket(trinket)
	local currentRoomIndex = isc:getRoomListIndex()
	table.insert(aqua_trinkets_data.floor.aquatrinkets[currentRoomIndex], wakaba:getPickupIndex(trinket))
	pickup:GetData().wakaba = pickup:GetData().wakaba or {}
	pickup:GetData().wakaba.isAquaTrinket = true
end

function wakaba:PickupInit_AquaTrinkets(pickup)
	if --[[ wakaba.state.unlock.aquatrinkets > 0 and ]] not pickup.Touched
	and (--[[not isc:anyPlayerHasCollectible(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT) and ]] not wakaba:has_value(wakaba.Blacklists.AquaTrinkets, pickup.SubType)) then
		local currentRoomIndex = isc:getRoomListIndex()
		if not aqua_trinkets_data.floor.aquatrinkets[currentRoomIndex] then
			aqua_trinkets_data.floor.aquatrinkets[currentRoomIndex] = {}
		end
		local isAquaTrinket = wakaba:has_value(aqua_trinkets_data.floor.aquatrinkets[currentRoomIndex], wakaba:getPickupIndex(pickup))
		local rand = RNG()
		rand:SetSeed(pickup.InitSeed, 35)
		local ran = rand:RandomFloat()
		--print(ran, pickup:CanReroll(), pickup.Touched)
		if ran < wakaba.state.options.fortunereplacechance / 100 then
			if not isAquaTrinket then
				--print("Aqua Trinket Registered! ID :"..pickup.SubType)
				table.insert(aqua_trinkets_data.floor.aquatrinkets[currentRoomIndex], wakaba:getPickupIndex(pickup))
				isAquaTrinket = true
			end
		end
		if isAquaTrinket then
			--print("Aqua Trinket spawned! ID :"..pickup.SubType)
			pickup:GetData().wakaba = pickup:GetData().wakaba or {}
			pickup:GetData().wakaba.isAquaTrinket = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PickupInit_AquaTrinkets, PickupVariant.PICKUP_TRINKET)

local rr, gg, bb = 1.0, 1.0, 1.0
local rt = 1.0
local rc = 1.0
local rb = 1.0
function wakaba:PickupRender_AquaTrinkets(pickup, offset)
	pickup:GetData().wakaba = pickup:GetData().wakaba or {}
	if pickup:GetData().wakaba.isAquaTrinket then
		local sprite = pickup:GetSprite()
		local tcolor = Color(1, 1, 1, 1, 0, 0, 0)
		tcolor:SetColorize(rc, rc, rb*2+0.8, rc-0.4)
		local ntcolor = Color.Lerp(tcolor, tcolor, 0.5)
		rt = 1 - (math.sin(Game():GetFrameCount() / 6)/10)-0.1
		rc = 1 - (math.sin(Game():GetFrameCount() / 6)/5)-0.2
		rb = 1 - math.sin(Game():GetFrameCount() / 6)
		ntcolor.A = rt
	
		sprite.Color = ntcolor
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, wakaba.PickupRender_AquaTrinkets, PickupVariant.PICKUP_TRINKET)

function wakaba:TrinketCollision_AquaTrinkets(pickup, collider)
	local player = collider:ToPlayer()
	if player then
		wakaba:GetPlayerEntityData(player)
		pickup:GetData().wakaba = pickup:GetData().wakaba or {}
		if player and pickup:GetData().wakaba.isAquaTrinket then
			player:GetData().wakaba.tryAquaTrinket = pickup.SubType
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.TrinketCollision_AquaTrinkets, PickupVariant.PICKUP_TRINKET)


function wakaba:PlayerUpdate_AquaTrinkets(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if not player:IsItemQueueEmpty() and data.wakaba.tryAquaTrinket then
		local queue = player.QueuedItem.Item
		if queue:IsTrinket() and queue.ID == data.wakaba.tryAquaTrinket then
			player:AnimateTrinket(data.wakaba.tryAquaTrinket, "UseItem")
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
			data.wakaba.tryAquaTrinket = nil
		end
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
