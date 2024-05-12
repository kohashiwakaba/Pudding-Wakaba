local isc = require("wakaba_src.libs.isaacscript-common")
local collectibleSpawnChance = wakaba.Enums.Constants.CLOVER_CHEST_COLLECTIBLE_CHANCE

local clover_chest_data = {
	run = {},
	level = {
		cachedRewards = {},
	},
}
wakaba:saveDataManager("Clover Chest", clover_chest_data)

wakaba.ChestSubType = {
	CLOSED = 1,
	OPEN = 0
}

wakaba.Weights.CloverChestPickups = {}
wakaba.Weights.CloverChestPickups.Normal = {
	{{EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART}, 1},
	{{EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY}, 1},
	{{EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB}, 1},
	{{EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN}, 1},
}
wakaba.Weights.CloverChestPickups.Extra = {
	{{EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_LUCKYPENNY}, 1},
	{{EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_LUCKYPENNY}, 1},
	{{EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_NICKEL}, 0.2},
	{{EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_DIME}, 0.1},
}

local function shouldCheckAscent()
	local room = wakaba.G:GetRoom()
	return room:GetType() == RoomType.ROOM_BOSS or room:GetType() == RoomType.ROOM_TREASURE
end

---@param chest EntityPickup
---@return table
function wakaba:getCloverChestRewards(chest)
	if clover_chest_data.level.cachedRewards[chest.InitSeed] then
		return clover_chest_data.level.cachedRewards[chest.InitSeed]
	end

	local rewards = {}
	local rng = RNG()
	rng:SetSeed(chest.InitSeed, 35)
	if rng:RandomFloat() < collectibleSpawnChance then
		local itemID = wakaba:GetItemFromWakabaPools("CloverChest", false, chest.InitSeed)
		table.insert(rewards, {EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemID})
	else
		player = player or Isaac.GetPlayer()
		local momKeyPower = wakaba:GetGlobalCollectibleNum(CollectibleType.COLLECTIBLE_MOMS_KEY)
		local cloverPower = wakaba:GetGlobalTrinketMultiplier(wakaba.Enums.Trinkets.CLOVER)
		local loops = 1 + momKeyPower + cloverPower
		for i = 1, loops do
			local normalPickup = isc:getRandomFromWeightedArray(wakaba.Weights.CloverChestPickups.Normal, rng:Next())
			local premiumPickup = isc:getRandomFromWeightedArray(wakaba.Weights.CloverChestPickups.Extra, rng:Next())
			table.insert(rewards, normalPickup)
			table.insert(rewards, premiumPickup)
		end
	end
	clover_chest_data.level.cachedRewards[chest.InitSeed] = rewards

	return rewards
end

function wakaba:NewRoom_RemoveOpenedCloverChest()
	local entities = Isaac.FindByType(5, wakaba.Enums.Pickups.CLOVER_CHEST, -1)
	for i, entity in ipairs(entities) do
		if entity.SubType == wakaba.ChestSubType.OPEN then
			entity:Remove()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_RemoveOpenedCloverChest)

function wakaba:InvalidateCloverChestRewards()
	clover_chest_data.level.cachedRewards = {}
end

function wakaba:ReplaceChests(pickup)
	local haspp = wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY)
	if pickup.Variant == PickupVariant.PICKUP_CHEST then
		local stage = wakaba.G:GetLevel():GetStage()
		wakaba.ItemRNG:SetSeed(pickup.DropSeed, 0)
		if wakaba:IsEntryUnlocked("cloverchest")
		and stage ~= LevelStage.STAGE6
		and wakaba.ItemRNG:RandomFloat() * 100 < wakaba.state.options.cloverchestchance
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

function wakaba:UpdateChests(pickup)
	if pickup:GetSprite():IsEventTriggered("DropSound") then
		SFXManager():Play(SoundEffect.SOUND_CHEST_DROP)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.UpdateChests, PickupVariant.PICKUP_CHEST)

function wakaba:spawnCloverChestReward(chest, player)
	local haspp = wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_PAY_TO_PLAY)
	player = player or chest:GetData().w_player

	local rewards = wakaba:getCloverChestRewards(chest)
	if #rewards == 1 then
		local entry = rewards[1]
		local item = Isaac.Spawn(entry[1], entry[2], entry[3], chest.Position, Vector.Zero, nil):ToPickup()
		item:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
		wakaba:MakeCustomPedestal(item, haspp and "gfx/items/wakaba_cloverchest_altar_p2p.png" or "gfx/items/wakaba_cloverchest_altar.png", 10)
		item.Wait = 10
		if Epiphany then
			Epiphany:AddCainEssenceInfo(item, EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.CLOSED)
		end
		chest:Remove()
		wakaba:InvalidateCloverChestRewards()
	else
		for i, entry in ipairs(rewards) do
			local item = Isaac.Spawn(entry[1], entry[2] or 0, entry[3] or 0, chest.Position, wakaba.RandomVelocity(), nil):ToPickup()
		end
		if Epiphany then
			Epiphany:AddCainEssenceInfo(chest, EntityType.ENTITY_PICKUP, wakaba.Enums.Pickups.CLOVER_CHEST, wakaba.ChestSubType.CLOSED)
		end
	end
end


function wakaba:openCloverChest(player, chest)
	wakaba:spawnCloverChestReward(chest, player)
	wakaba:RemoveOtherOptionPickups(chest)
end


function wakaba:PickupCollision_CloverChest(pickup, collider, low)
	if pickup.SubType > 0 and collider.Type == EntityType.ENTITY_PLAYER then
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
		if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == wakaba.Enums.Pickups.CLOVER_CHEST and entity.SubType > 0 then
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