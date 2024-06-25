local hastower = false
local rolledPickup = {
	PickupVariant.PICKUP_COIN,
	PickupVariant.PICKUP_GRAB_BAG,
	PickupVariant.PICKUP_HEART,
	PickupVariant.PICKUP_KEY,
	PickupVariant.PICKUP_LIL_BATTERY,
	PickupVariant.PICKUP_PILL,
	PickupVariant.PICKUP_TAROTCARD,
	PickupVariant.PICKUP_TRINKET,
}

function wakaba:Update_CurseOfTower2()
	hastower = false
	for num = 1, wakaba.G:GetNumPlayers() do
		local player = wakaba.G:GetPlayer(num - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2) then
			hastower = true
			if not player:HasGoldenBomb() then
				player:AddGoldenBomb()
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_CurseOfTower2)

function wakaba:PickupSelect_CurseOfTower2(pickup)
	if not hastower then return end
	local variant = pickup.Variant
	local subtype = pickup.SubType
	local savedpos = pickup.Position + Vector.Zero
	local savedvel = pickup.Velocity + Vector.Zero
	local spawnent = 5
	local spawnvar = nil
	local spawnsub = 0
	if variant == PickupVariant.PICKUP_BOMB then
		if subtype == BombSubType.BOMB_TROLL then
			spawnvar = variant
			spawnsub = BombSubType.BOMB_GOLDENTROLL
		elseif subtype == BombSubType.BOMB_SUPERTROLL then
			if Isaac.GetEntityVariantByName("Golden Megatroll Bomb") > -1
			then
				spawnent = 4
				spawnvar = Isaac.GetEntityVariantByName("Golden Megatroll Bomb")
			else
				spawnvar = variant
				spawnsub = BombSubType.BOMB_GOLDENTROLL
			end
		elseif subtype ~= BombSubType.BOMB_GOLDEN then
			local num = wakaba:GetGlobalCollectibleNum(wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2)
			local rng = RNG()
			rng:SetSeed(pickup.InitSeed, 35)
			local chance = 0.7
			if rng:RandomFloat() < chance then
				spawnent = 4
				spawnvar = variant
				spawnsub = BombSubType.BOMB_GOLDENTROLL
			else
				spawnvar = rolledPickup[rng:RandomInt(#rolledPickup) + 1]
				spawnsub = 0
			end
		end
	end
	if spawnvar then
		if spawnent == 5 then
			local newpickup = pickup:Morph(spawnent, spawnvar, spawnsub, true, true, true)
		else
			pickup:Remove()
			Isaac.Spawn(spawnent, spawnvar, spawnsub, savedpos, savedvel, nil)
		end
	end

end

wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PickupSelect_CurseOfTower2)


function wakaba:EntitySelect_CurseOfTower2(entitybomb)
	if not hastower then return end

	local variant = entitybomb.Variant
	local subtype = entitybomb.SubType
	local savedpos = entitybomb.Position + Vector.Zero
	local savedvel = entitybomb.Velocity + Vector.Zero
	local spawnent = 4
	local spawnvar = nil
	local spawnsub = 0
	local spent = entitybomb.SpawnerEntity

	if variant == BombVariant.BOMB_TROLL then
		spawnvar = BombVariant.BOMB_GOLDENTROLL
	elseif variant == BombVariant.BOMB_SUPERTROLL
	and Isaac.GetEntityVariantByName("Golden Megatroll Bomb") > -1
	then
		spawnvar = Isaac.GetEntityVariantByName("Golden Megatroll Bomb")
	end
	if spawnvar then
		entitybomb:Remove()
		Isaac.Spawn(spawnent, spawnvar, spawnsub, savedpos, savedvel, spent)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_BOMB_INIT, wakaba.EntitySelect_CurseOfTower2)

function wakaba:AlterPlayerDamage_CurseOfTower2(player, amount, flags, source, cooldown)
	if player:HasCollectible(wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2)
	and flags & DamageFlag.DAMAGE_RED_HEARTS ~= DamageFlag.DAMAGE_RED_HEARTS
	and flags & DamageFlag.DAMAGE_NO_PENALTIES ~= DamageFlag.DAMAGE_NO_PENALTIES then
		local data = player:GetData()
		data.wakaba.dropgoldentroll = true
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, -40000, wakaba.AlterPlayerDamage_CurseOfTower2)

function wakaba:PostTakeDamage_CurseOfTower2(player, amount, flags, source, cooldown)
	if player:HasCollectible(wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2) then
		local data = player:GetData()
		if data.wakaba.dropgoldentroll then
			player:UseCard(Card.CARD_TOWER, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
			--Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_GOLDENTROLL, 0, wakaba:RandomNearbyPosition(player), Vector.Zero, nil)
			data.wakaba.dropgoldentroll = false
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_CurseOfTower2)

