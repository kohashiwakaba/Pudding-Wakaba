local isc = require("wakaba_src.libs.isaacscript-common")

local clover_chest_data = {
	run = {

	},
	floor = {
		cloverchestpedestals = {},
	},
	room = {

	}
}
wakaba:saveDataManager("Clover Chest", clover_chest_data)

wakaba.ChestSubType = {
	CLOSED = 1,
	OPEN = 0
}


function wakaba:manageCloverChests()
	local haspp = false
	
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i-1)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY) then
			haspp = true
			break
		end
	end
	local entities = Isaac.FindByType(5, wakaba.Enums.Pickups.CLOVER_CHEST, -1)
	for i, entity in ipairs(entities) do
		if entity.SubType == wakaba.ChestSubType.OPEN then
			entity:Remove()
		end
	end
	local pedestals = Isaac.FindByType(5, 100, -1)
	for i, entity in ipairs(pedestals) do
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.manageCloverChests)

function wakaba:ReplaceChests(pickup)
	local haspp = isc:anyPlayerHasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY)
	if pickup.Variant == PickupVariant.PICKUP_CHEST then
		local stage = wakaba.G:GetLevel():GetStage()
		wakaba.ItemRNG:SetSeed(pickup.DropSeed, 0)
		if wakaba.state.unlock.cloverchest > 0 
		and stage ~= LevelStage.STAGE6 
		and wakaba.ItemRNG:RandomFloat() < 0.05 
		and wakaba.G:GetRoom():GetType() ~= RoomType.ROOM_CHALLENGE then
			pickup:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.CLOSED)
		end
	elseif pickup.Variant == wakaba.Enums.Pickups.CLOVER_CHEST then
		if haspp then
			pickup:GetSprite():ReplaceSpritesheet(0, "gfx/cloverchest_pp.png") 
			pickup:GetSprite():LoadGraphics()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.ReplaceChests)

function wakaba:ReplaceChestsLate2(pickup)
	local room = wakaba.G:GetRoom()
	if room:GetFrameCount() < 2 then return end
	wakaba:ReplaceChestsLate(pickup)
end
function wakaba:ReplaceChestsLate(pickup)
	local haspp = isc:anyPlayerHasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY)
	local currentRoomIndex = isc:getRoomListIndex()
	if not clover_chest_data.floor.cloverchestpedestals[currentRoomIndex] then return end
	if wakaba:has_value(clover_chest_data.floor.cloverchestpedestals[currentRoomIndex], wakaba:getPickupIndex(pickup)) then
		pickup:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png") 
		if haspp then
			pickup:GetSprite():SetOverlayFrame("Alternates", 16)
		else
			pickup:GetSprite():SetOverlayFrame("Alternates", 10)
		end
		pickup:GetSprite():LoadGraphics()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.ReplaceChestsLate2, PickupVariant.PICKUP_COLLECTIBLE)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_PICKUP_INIT_LATE, wakaba.ReplaceChestsLate, PickupVariant.PICKUP_COLLECTIBLE)

function wakaba:UpdateChests(pickup)
	if pickup:GetSprite():IsEventTriggered("DropSound") then
		SFXManager():Play(SoundEffect.SOUND_CHEST_DROP)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.UpdateChests, PickupVariant.PICKUP_CHEST)

function wakaba:spawnCloverChestReward(chest)
	local haspp = isc:anyPlayerHasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY)
	local currentRoomIndex = isc:getRoomListIndex()
	if not clover_chest_data.floor.cloverchestpedestals[currentRoomIndex] then
		clover_chest_data.floor.cloverchestpedestals[currentRoomIndex] = {}
	end
	-- 15% chance to spawn pedestal item
	if wakaba.RNG:RandomFloat() < 0.15 then
		local candidates = wakaba:getCollectiblesWithCacheFlag(CacheFlag.CACHE_LUCK)
		--local candidates = wakaba:GetCandidatesByCacheFlag(CacheFlag.CACHE_LUCK)
		--local entry = wakaba.RNG:RandomInt(#candidates) + 1
		--local itemID = candidates[entry]
		local rng = RNG()
		rng:SetSeed(chest.InitSeed, 35)
		local itemID = isc:getRandomSetElement(candidates, rng)
		local item = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemID, chest.Position, Vector.Zero, nil):ToPickup()
		item:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png") 
		if haspp then
			item:GetSprite():SetOverlayFrame("Alternates", 16)
		else
			item:GetSprite():SetOverlayFrame("Alternates", 10)
		end
		item:GetSprite():LoadGraphics()
		table.insert(clover_chest_data.floor.cloverchestpedestals[currentRoomIndex], wakaba:getPickupIndex(item))
		item.Wait = 10
		--local new = chest:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.OPEN)
		--new.Visible = false
		--new.EntityCollisionClass = 0
		chest:Remove()
	elseif wakaba.G:GetLevel():GetAbsoluteStage() == LevelStage.STAGE6 then
		local item = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, chest.Position, Vector.Zero, nil):ToPickup()
		item:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png") 
		if haspp then
			item:GetSprite():SetOverlayFrame("Alternates", 16)
		else
			item:GetSprite():SetOverlayFrame("Alternates", 10)
		end
		item:GetSprite():LoadGraphics()
		table.insert(clover_chest_data.floor.cloverchestpedestals[currentRoomIndex], wakaba:getPickupIndex(item))
		item.Wait = 10
		--local new = chest:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.OPEN)
		--new.Visible = false
		--new.EntityCollisionClass = 0
		chest:Remove()
	else
		-- 2 normal pickups
		for i=1,2 do
			local roll = wakaba.RNG:RandomFloat()
			if roll < 0.25 then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 0, chest.Position, wakaba.RandomVelocity(), nil)
			elseif roll < 0.5 then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, chest.Position, wakaba.RandomVelocity(), nil)
			elseif roll < 0.75 then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, chest.Position, wakaba.RandomVelocity(), nil)
			else
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 0, chest.Position, wakaba.RandomVelocity(), nil)
			end
		end

		-- 1 "lucky" option
		roll = wakaba.RNG:RandomFloat()
		if roll < 0.5 then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_LUCKYPENNY, chest.Position, wakaba.RandomVelocity(), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_LUCKYPENNY, chest.Position, wakaba.RandomVelocity(), nil)
		else
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, chest.Position, wakaba.RandomVelocity(), nil)
		end 
	end
end

function wakaba:openCloverChest(player, pickup)

	local numRewards = 1
	if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KEY) then
		numRewards = numRewards * 2
	end
	if player:HasTrinket(wakaba.Enums.Trinkets.CLOVER) then
		numRewards = numRewards * 2
	end
	if player:HasTrinket(TrinketType.TRINKET_POKER_CHIP) then
		if wakaba.RNG:RandomFloat() < 0.5 then
			numRewards = 0
		else
			numRewards = numRewards * 2
		end
	end
	for i=1,numRewards do
		wakaba:spawnCloverChestReward(pickup)
	end
	wakaba:RemoveOtherOptionPickups(pickup)
end

function wakaba:PickupCollision_CloverChest(pickup, collider, low)
	if pickup.SubType == wakaba.ChestSubType.CLOSED and collider.Type == EntityType.ENTITY_PLAYER then
		local player = collider:ToPlayer()
		if player:HasGoldenKey() or player:GetNumKeys() > 0 
		or player:HasTrinket(TrinketType.TRINKET_PAPER_CLIP)
		or (player:HasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY) and player:GetNumCoins() > 0) then
			if not player:HasGoldenKey() and not player:HasTrinket(TrinketType.TRINKET_PAPER_CLIP) then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY) then
					player:AddCoins(-1)
				else
					player:AddKeys(-1)
				end
			end
			pickup.Touched = true
		
			pickup:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.OPEN)
			SFXManager():Play(SoundEffect.SOUND_CHEST_OPEN)
			SFXManager():Play(SoundEffect.SOUND_UNLOCK00)
			wakaba:openCloverChest(player, pickup)
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PickupCollision_CloverChest, wakaba.Enums.Pickups.CLOVER_CHEST)

function wakaba:TearUpdate_CloverChest(tear)
	local ents = Isaac.FindInRadius(tear.Position, 12)
	for i, entity in ipairs(ents) do
		if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == wakaba.Enums.Pickups.CLOVER_CHEST and entity.SubType == wakaba.ChestSubType.CLOSED then
			entity = entity:ToPickup()
			entity.Touched = true
		
			entity:Morph(EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.OPEN)
			SFXManager():Play(SoundEffect.SOUND_CHEST_OPEN)
			SFXManager():Play(SoundEffect.SOUND_UNLOCK00)
	
			local spawner = tear.SpawnerEntity
			if spawner and spawner:ToPlayer() then
				wakaba:openCloverChest(spawner:ToPlayer(), entity)
			else
				wakaba:openCloverChest(Isaac.GetPlayer(), entity)
			end
		end
	end
end


wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_CloverChest, TearVariant.KEY)
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_CloverChest, TearVariant.KEY_BLOOD)