local rng = wakaba.RNG
local isc = require("wakaba_src.libs.isaacscript-common")



local candidates = {}

local function IsRoomNearby(roomIdx)
	if roomIdx == 96 then return false end
  local level = wakaba.G:GetLevel()
	local top = roomIdx - 13
	local bottom = roomIdx + 13
	local left = roomIdx - 1
	local right = roomIdx + 1
	if top >= 0 and level:GetRoomByIdx(top).Data and level:GetRoomByIdx(top).Data.Type ~= RoomType.ROOM_SUPERSECRET then
		return true
	elseif bottom <= 169 and level:GetRoomByIdx(bottom).Data and level:GetRoomByIdx(bottom).Data.Type ~= RoomType.ROOM_SUPERSECRET then
		return true
	elseif left % 13 ~= 12 and level:GetRoomByIdx(left).Data and level:GetRoomByIdx(left).Data.Type ~= RoomType.ROOM_SUPERSECRET then
		return true
	elseif right % 13 ~= 0 and level:GetRoomByIdx(right).Data and level:GetRoomByIdx(right).Data.Type ~= RoomType.ROOM_SUPERSECRET then
		return true
	end
end

local availabledevilroom = {
	0,1,2,3,4,5,6,12,16,17,18
}
local availableangelroom = {
	0,1,2,3,4,5,8,10,11,13,15
}

function wakaba:UseCard_SoulOfWakaba(card, player, flags)
  local game = wakaba.G
  local room = wakaba.G:GetRoom()
  local level = wakaba.G:GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
  local StartingRoom = 84

	if CurStage ~= LevelStage.STAGE8 then
		local selected

		local newRoom = isc:newRoom(player:GetCardRNG(card))
		if newRoom then
			local targetSpecial = level:GetRoomByIdx(newRoom)
			local copyIdx = -1
			local tempRoomData = wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data
			wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data=nil
			if card == wakaba.Enums.Cards.SOUL_WAKABA2 then
				wakaba.G:GetLevel():InitializeDevilAngelRoom(false, true)
				while(wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data and wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data.Variant and not wakaba:has_value(availabledevilroom, wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data.Variant)) do
					wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data=nil
					wakaba.G:GetLevel():InitializeDevilAngelRoom(false, true)
				end
			else
				wakaba.G:GetLevel():InitializeDevilAngelRoom(true, false)
				while(wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data and wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data.Variant and not wakaba:has_value(availableangelroom, wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data.Variant)) do
					wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data=nil
					wakaba.G:GetLevel():InitializeDevilAngelRoom(true, false)
				end
			end
			if card == wakaba.Enums.Cards.SOUL_WAKABA2 then
			end
			--[[ 
				-1 : Devil/Angel room : Must invalidate before copy
				-2 : Error room
				-3 : Goto rooms. Planetariums this time
				-12 : Genesis Room : Game crash :(
				-13 : Member card room : Just another Shop with Member card shop layout.
				-18 : Stairway room
			]]
			local d = targetSpecial.Data
			targetSpecial.Data = level:GetRoomByIdx(copyIdx).Data
			wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data=tempRoomData
			if card == wakaba.Enums.Cards.SOUL_WAKABA2 then
				table.insert(wakaba.levelstate.wakabadevilshops, roomIdx)
			else
				table.insert(wakaba.levelstate.wakabaangelshops, roomIdx)
			end
			targetSpecial.DisplayFlags = 1 << 0 | 1 << 2
			if MinimapAPI then
				local mRoom = MinimapAPI:GetRoomByIdx(targetSpecial.GridIndex)
				if mRoom then
					mRoom.Shape = RoomShape.ROOMSHAPE_1x1
					if card == wakaba.Enums.Cards.SOUL_WAKABA2 then
						mRoom.Type = RoomType.ROOM_DEVIL
						mRoom.PermanentIcons = {"DevilRoom"}
					else
						mRoom.Type = RoomType.ROOM_ANGEL
						mRoom.PermanentIcons = {"AngelRoom"}
					end
				end
			end
			for i = 0, DoorSlot.NUM_DOOR_SLOTS do
				local doorR = room:GetDoor(i)
				if doorR then 
					if doorR.TargetRoomIndex == roomIdx then
						if card == wakaba.Enums.Cards.SOUL_WAKABA2 then
							doorR:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_DEVIL)
						else
							doorR:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_ANGEL)
						end
						doorR:GetSprite():Play('Opened',true)
					end
				end
			end
			SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)

		else
			if card == wakaba.Enums.Cards.SOUL_WAKABA2 then
				local p1 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 
					wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, false), 
					Isaac.GetFreeNearPosition(player.Position - Vector(32, 0), 32), Vector(0,0), nil):ToPickup()
				p1.ShopItemId = -1
				--[[ if Isaac.GetItemConfig():GetCollectible(p1.SubType) then
					p1.Price = Isaac.GetItemConfig():GetCollectible(p1.SubType).DevilPrice * -1
					if player:GetPlayerType() == PlayerType.PLAYER_BLUEBABY then
						p1.Price = Isaac.GetItemConfig():GetCollectible(p1.SubType).DevilPrice * -1 - 6
					end
				end ]]
			else
				local p1 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 
					wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL, false), 
					Isaac.GetFreeNearPosition(player.Position + Vector(32, 0), 32), Vector(0,0), nil):ToPickup()
				p1.ShopItemId = -1
				--[[ if Isaac.GetItemConfig():GetCollectible(p1.SubType) then
					p1.Price = Isaac.GetItemConfig():GetCollectible(p1.SubType).DevilPrice * 15
				end ]]
			end
			SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
		end
	
	else
		--wakaba.G:StartRoomTransition(-18,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
	end
	wakaba.G:GetLevel():UpdateVisibility()
	player:AddSoulHearts(2)

end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_SoulOfWakaba, wakaba.Enums.Cards.SOUL_WAKABA)
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_SoulOfWakaba, wakaba.Enums.Cards.SOUL_WAKABA2)

--[[ 
	Angel Position : 52
	Shop location
	1 : [82]
	2 : [81, 83]
	3 : [80, 82, 84]
	4 : [64, 81, 83, 70]
	5 : [49, 55, 80, 82, 84]
	Fireplace location
	a : 16, 17, 18, 26, 27, 28
	b : 


 ]]
local angelpools = {
	[1] = {82},
	[2] = {81, 83},
	[3] = {82, 80, 84},
	[4] = {64, 70, 81, 83},
	[5] = {80, 84, 82, 49, 55},
	[6] = {63, 71, 92, 81, 83, 102},
	[7] = {82, 35, 39, 77, 94, 100, 87},
	[8] = {77, 64, 70, 87, 94, 81, 83, 100},
}
local guarenteedangelitems = {
	[1] = 1,
	[2] = 1,
	[3] = 1,
	[4] = 2,
	[5] = 2,
	[6] = 2,
	[7] = 3,
	[8] = 4,
}
local firepools = {
	{},
	{},
	{16, 17, 18, 26, 27, 28},
	{49, 55},
	{16, 28, 106, 118},
	{50, 54, 16, 31, 32, 28, 42, 43},
	{34, 40, 92, 102},
	{32, 36, 38, 42},
}
local slotpools = {
	{}
}



function wakaba:NewRoom_SoulOfWakaba()
  local game = wakaba.G
  local room = wakaba.G:GetRoom()
  local level = wakaba.G:GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoomIndex = level:GetCurrentRoomIndex()
  local StartingRoom = 84
	if room:IsFirstVisit() then
		if isc:inStartingRoom() then
			wakaba.levelstate.wakabaangelshops = {}
			wakaba.levelstate.wakabadevilshops = {}
		elseif wakaba:has_value(wakaba.levelstate.wakabadevilshops, wakaba.G:GetLevel():GetCurrentRoomIndex()) then
			for i = 1, room:GetGridSize() do
				local grid = room:GetGridEntity(i)
				if grid and grid:ToPit() then
					room:RemoveGridEntity(i, 0, false)
					room:GetGridEntity(i):Update()
				elseif grid and grid:ToSpikes() then
					room:RemoveGridEntity(i, 0, false)
					room:GetGridEntity(i):Update()
				end
			end
			room:Update()
			local olditems = Isaac.FindByType(EntityType.ENTITY_PICKUP, -1, -1)
			for i, f in ipairs(olditems) do
				f:Remove()
			end
			local oldslots = Isaac.FindByType(EntityType.ENTITY_SLOT, -1, -1)
			for i, f in ipairs(oldslots) do
				f:Remove()
			end

			local rng = RNG()
			rng:SetSeed(Random() + 1, 1)
			local minspawn = 1
			local maxspawn = 4
			if game.Difficulty == Difficulty.DIFFICULTY_NORMAL then
				minspawn = 2
				maxspawn = 5
			elseif game.Difficulty == Difficulty.DIFFICULTY_HARD then
				minspawn = 1
				maxspawn = 4
			elseif game.Difficulty == Difficulty.DIFFICULTY_GREED then
				minspawn = 2
				maxspawn = 3
			elseif game.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
				minspawn = 1
				maxspawn = 2
			end
			local angelresult = rng:RandomInt(maxspawn) + 1
			if angelresult < minspawn then 
				angelresult = minspawn
			elseif angelresult > maxspawn then 
				angelresult = maxspawn
			end
			
			local angelspawn = angelpools[angelresult]
			local fixedcollectiblecount = guarenteedangelitems[angelresult] + 0
			for i = 1, #angelspawn do
				local p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_SHOPITEM, 0, room:GetGridPosition(angelspawn[i]), Vector.Zero, nil)
				while fixedcollectiblecount > 0 and (not p or p.Variant ~= PickupVariant.PICKUP_COLLECTIBLE) do
					if p then
						p:Remove()
					end
					p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_SHOPITEM, 0, room:GetGridPosition(angelspawn[i]), Vector.Zero, nil)
				end
				if fixedcollectiblecount > 0 then
					fixedcollectiblecount = fixedcollectiblecount - 1
				end
			end

		elseif wakaba:has_value(wakaba.levelstate.wakabaangelshops, wakaba.G:GetLevel():GetCurrentRoomIndex()) then
			local fireplaces = Isaac.FindByType(EntityType.ENTITY_FIREPLACE, -1, -1)
			for i, f in ipairs(fireplaces) do
				f:Remove()
			end
			local oldslots = Isaac.FindByType(EntityType.ENTITY_SLOT, -1, -1)
			for i, f in ipairs(oldslots) do
				f:Remove()
			end
			local olditems = Isaac.FindByType(EntityType.ENTITY_PICKUP, -1, -1)
			for i, f in ipairs(olditems) do
				f:Remove()
			end
			local angels = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.ANGEL, -1)
			if #angels == 0 then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ANGEL, 0, Vector(0,0), Vector.Zero, nil)
			end
			local rng = RNG()
			rng:SetSeed(Random() + 1, 1)
			local minspawn = 1
			local maxspawn = 8
			if game.Difficulty == Difficulty.DIFFICULTY_NORMAL then
				minspawn = 3
				maxspawn = 8
			elseif game.Difficulty == Difficulty.DIFFICULTY_HARD then
				minspawn = 1
				maxspawn = 8
			elseif game.Difficulty == Difficulty.DIFFICULTY_GREED then
				minspawn = 4
				maxspawn = 8
			elseif game.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
				minspawn = 2
				maxspawn = 6
			end
			local angelresult = rng:RandomInt(maxspawn) + 1
			local fireresult = rng:RandomInt(#firepools) + 1
			if angelresult < minspawn then 
				angelresult = minspawn
			elseif angelresult > maxspawn then 
				angelresult = maxspawn
			end
			--print(angelresult)

			local angelspawn = angelpools[angelresult]
			local fixedcollectiblecount = guarenteedangelitems[angelresult] + 0
			local firespawn = firepools[fireresult]
			for i = 1, #angelspawn do
				local p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_SHOPITEM, 0, room:GetGridPosition(angelspawn[i]), Vector.Zero, nil)
				while fixedcollectiblecount > 0 and (not p or p.Variant ~= PickupVariant.PICKUP_COLLECTIBLE) do
					if p then
						p:Remove()
					end
					p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_SHOPITEM, 0, room:GetGridPosition(angelspawn[i]), Vector.Zero, nil)
				end
				if fixedcollectiblecount > 0 then
					fixedcollectiblecount = fixedcollectiblecount - 1
				end
			end
			for i = 1, #firespawn do
				if not wakaba:has_value(angelspawn, firespawn[i]) then
					Isaac.Spawn(EntityType.ENTITY_FIREPLACE, 2, 0, room:GetGridPosition(firespawn[i]), Vector.Zero, nil)
				end
			end

		end
	elseif wakaba:has_value(wakaba.levelstate.wakabadevilshops, wakaba.G:GetLevel():GetCurrentRoomIndex()) then
		for i = 1, room:GetGridSize() do
			local grid = room:GetGridEntity(i)
			if grid and grid:ToPit() then
				room:RemoveGridEntity(i, 0, false)
				room:GetGridEntity(i):Update()
			elseif grid and grid:ToSpikes() then
				room:RemoveGridEntity(i, 0, false)
				room:GetGridEntity(i):Update()
			end
		end
		room:Update()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_SoulOfWakaba)
