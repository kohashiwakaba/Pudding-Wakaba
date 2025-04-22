
---@param player EntityPlayer
function wakaba:PreUseItem_EatHeart(_, rng, player, useFlags, activeSlot, varData)
	if activeSlot < 0 and useFlags & UseFlag.USE_VOID == 0 then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_METRONOME, UseFlag.USE_VOID, -1)
	else
		if useFlags & UseFlag.USE_VOID == UseFlag.USE_VOID then
			player:GetData().wakaba.eatheartquality = 1
		else
			player:GetData().wakaba.eatheartquality = 3
		end
		player:GetData().wakaba.eatheartused = true
		local s = wakaba.G:GetRoom():GetSpawnSeed()
		--local selected = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_NULL, false, wakaba.G:GetRoom():GetSpawnSeed())
		local Item1 = wakaba.G:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Isaac.GetFreeNearPosition(player.Position, 25), Vector.Zero, nil, 0, s):ToPickup()
		--local Item1 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, selected, Isaac.GetFreeNearPosition(player.Position, 25), Vector(0,0), nil):ToPickup()
		Item1:GetData().DamoclesDuplicate = false
		if Epiphany then
			Item1:GetData().TRK_HasMidasImmunity = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.PreUseItem_EatHeart, wakaba.Enums.Collectibles.EATHEART)

function wakaba:UseItem_EatHeart(_, rng, player, useFlags, activeSlot, varData)
	return {
		Discharge = true,
		Remove = false,
		ShowAnim = player:GetData().wakaba.eatheartused and not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM),
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_EatHeart, wakaba.Enums.Collectibles.EATHEART)

function wakaba:ChargeEatHeart(player, amount, mode)
	-- mode : true - player is taken, false - enemy is taken
	mode = mode or "EnemyDamage"

	local tempeatheartcharges = 0
	local multiplier = 32
	local isGolden = wakaba:IsGoldenItem(wakaba.Enums.Collectibles.EATHEART, player)
	if mode == "PlayerDamage" then
		amount = amount * 5000
		multiplier = 1
		if player:HasCollectible(CollectibleType.COLLECTIBLE_HABIT) then
			multiplier = multiplier * 1.5
		end
	elseif mode == "EnemyDamage" then
		multiplier = 32
		if player:HasCollectible(CollectibleType.COLLECTIBLE_JUMPER_CABLES) then
			multiplier = multiplier + 8
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_4_5_VOLT) then
			multiplier = multiplier * 2
		end
	elseif mode == "Preserve" then
		multiplier = 0
		if player:HasCollectible(CollectibleType.COLLECTIBLE_9_VOLT) then
			multiplier = multiplier + 0.08
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BATTERY) then
			multiplier = multiplier + 0.25
		end
	end
	if isGolden then
		multiplier = multiplier * 2
	end
	if wakaba:IsLunatic() then
		multiplier = multiplier / 2
	end
	local chargeamount = (amount * multiplier) // 1
	for i = 0, 2 do
		if player:GetActiveItem(i) == wakaba.Enums.Collectibles.EATHEART then
			tempeatheartcharges = player:GetActiveCharge(i) + player:GetBatteryCharge(i) + chargeamount
			player:SetActiveCharge(tempeatheartcharges, i)
			wakaba.G:GetHUD():FlashChargeBar(player, i)
		end
	end
end

function wakaba:PostTakeDamage_EatHeart(player, amount, flags, source, cooldown)
	if player:HasCollectible(wakaba.Enums.Collectibles.EATHEART) then
		wakaba:ChargeEatHeart(player, 1, "PlayerDamage")
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_EatHeart)


function wakaba:PlayerUpdate_EatHeart(player)
	wakaba:GetPlayerEntityData(player)
	if player:HasCollectible(wakaba.Enums.Collectibles.EATHEART) then
		local room = wakaba.G:GetRoom()
		local dmgToCharge = room:GetEnemyDamageInflicted()
		if dmgToCharge > 0 then
			wakaba:ChargeEatHeart(player, dmgToCharge, "EnemyDamage")
		end
		if player:GetEffects():GetCollectibleEffect(wakaba.Enums.Collectibles.EATHEART) then
			wakaba:ChargeEatHeart(player, 240000, "Preserve")
			player:GetEffects():RemoveCollectibleEffect(wakaba.Enums.Collectibles.EATHEART)
		end
	end
	if player:GetData().wakaba and player:GetData().wakaba.eatheartused == true then
		player:GetData().wakaba.eatheartused = false
		player:GetData().wakaba.eatheartquality = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_EatHeart)