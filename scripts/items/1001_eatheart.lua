wakaba.COLLECTIBLE_EATHEART = Isaac.GetItemIdByName("Eat Heart")
wakaba.COLLECTIBLE_EATHEART_WAKABA = Isaac.GetItemIdByName("Eat Heart")
--wakaba.COLLECTIBLE_EATHEART_MAO = Isaac.GetItemIdByName("Let Heart")
--wakaba.COLLECTIBLE_EATHEART_MOE = Isaac.GetItemIdByName("Cat Heart")
--wakaba.COLLECTIBLE_EATHEART_SHIVA = Isaac.GetItemIdByName("Const Heart")
local eatHeartErr = 0
local used = 0
local hasHeart = 0
eatheartcharges = wakaba.state.eatheartcharges

if EID then
	local t = ""
	t = t .. "# Only can be charged through damaging enemies or self damage."
	t = t .. "# Can be overcharged without {{Collectible"..CollectibleType.COLLECTIBLE_BATTERY .."}}The Battery. Max 48 charges"
	t = t .. "#!!! Wakaba variant : "
	t = t .. "# Spawns a random collectible item from current item pool"
	t = t .. "# Items with a quality of 3+ are guaranteed. Higher quality of items that will be spawned for high charges"
	t = t .. ""
  --EID:addCollectible(wakaba.COLLECTIBLE_EATHEART, t)
--[[ 
	local t2 = ""
	t2 = t2 .. "# Only can be charged through damaging enemies or self damage."
	t2 = t2 .. "# Can be overcharged without {{Collectible"..CollectibleType.COLLECTIBLE_BATTERY .."}}The Battery. Max 48 charges"
	t2 = t2 .. "#!!! Mao variant : "
	t2 = t2 .. "# Attacks a nearest enemy with a single laser"
	t2 = t2 .. "# Laser strength and damage scales with charges"
	t2 = t2 .. "# Charges slowly deplete as long as laser persists"
	t2 = t2 .. ""
  EID:addCollectible(wakaba.COLLECTIBLE_EATHEART_MAO, t2)
	wakaba.eidextradesc.blessing[wakaba.COLLECTIBLE_EATHEART_MAO] = {
		en_us = "Spawns Homing laser, allowing to attack additional enemy", 
	}

	local t3 = ""
	t3 = t3 .. "# Only can be charged through damaging enemies or self damage."
	t3 = t3 .. "# Can be overcharged without {{Collectible"..CollectibleType.COLLECTIBLE_BATTERY .."}}The Battery. Max 48 charges"
	t3 = t3 .. "#!!! Moe variant : "
	t3 = t3 .. "# Attacks a nearest enemy with a single laser"
	t3 = t3 .. "# Laser strength and damage scales with charges"
	t3 = t3 .. "# Charges slowly deplete as long as laser persists"
	t3 = t3 .. ""
  EID:addCollectible(wakaba.COLLECTIBLE_EATHEART_MOE, t3)
	wakaba.eidextradesc.blessing[wakaba.COLLECTIBLE_EATHEART_MOE] = {
		en_us = "Spawns Homing laser, allowing to attack additional enemy", 
	}
	 ]]
end


function wakaba:ItemUse_EatHeart(_, rng, player, useFlags, activeSlot, varData)
	--print(rng," ", player," ", useFlags," ", activeSlot," ", varData)
	if used > 0 then return end
	local pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
	local result = false
	local tempeatheartcharges = 0
	hasHeart = 0
	local hasBless = false
  for i = 1, Game():GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		local hasBless = wakaba:HasBless(player)
  end
		
	if useFlags & UseFlag.USE_VOID == UseFlag.USE_VOID then
		used = 2
		hasHeart = 1
		tempeatheartcharges = 120000
		pData.wakaba.eatheartused = true
		pData.wakaba.eatheartcharges = tempeatheartcharges
	elseif activeSlot == ActiveSlot.SLOT_POCKET then -- Tainted Wakaba
		tempeatheartcharges = player:GetActiveCharge(ActiveSlot.SLOT_POCKET) + player:GetBatteryCharge(ActiveSlot.SLOT_POCKET)
		used = 2
		hasHeart = 1
		pData.wakaba.eatheartused = true
		pData.wakaba.eatheartcharges = tempeatheartcharges
		player:DischargeActiveItem(ActiveSlot.SLOT_POCKET)
	elseif activeSlot == ActiveSlot.SLOT_PRIMARY then
		used = 2
		hasHeart = 1
		tempeatheartcharges = player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) + player:GetBatteryCharge(ActiveSlot.SLOT_PRIMARY)
		pData.wakaba.eatheartused = true
		pData.wakaba.eatheartcharges = tempeatheartcharges
		player:DischargeActiveItem(ActiveSlot.SLOT_PRIMARY)
	end
		
	if hasHeart == 1 then
		wakaba.state.eatheartused = true
		local selected = Game():GetItemPool():GetCollectible(ItemPoolType.POOL_NULL)
		local Item1 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, selected, Isaac.GetFreeNearPosition(player.Position, 25), Vector(0,0), nil):ToPickup()
		Item1:GetData().DamoclesDuplicate = false
		wakaba:InsertNemesis(Item1.SubType)
		if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
			player:AnimateCollectible(wakaba.COLLECTIBLE_EATHEART, "UseItem", "PlayerPickup")
		end
		if player:HasCollectible(wakaba.COLLECTIBLE_EATHEART) then -- No charge on Void use
			player:GetData().wakaba.eatheartchargepending = true
			player:GetData().wakaba.tempeatheartcharges = tempeatheartcharges
		end
		tempeatheartcharges = 0
		result = false
	else
		player:AnimateSad()
	end
	--used = 0
	return result
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.ItemUse_EatHeart, wakaba.COLLECTIBLE_EATHEART)

function wakaba:ChargeEatHeart(player, amount, mode)
	-- mode : true - player is taken, false - enemy is taken
	mode = mode or "EnemyDamage"

	local tempeatheartcharges = 0
	local multiplier = 32
	if mode == "PlayerDamage" then
		amount = amount * 5000
		multiplier = 1
		if player:HasCollectible(CollectibleType.COLLECTIBLE_HABIT) then
			multiplier = multiplier * 1.5
		end
	elseif mode == "EnemyDamage" then
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
	local chargeamount = (amount * multiplier) // 1
	--print(amount, multiplier, chargeamount)
	if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == wakaba.COLLECTIBLE_EATHEART then
		tempeatheartcharges = player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) + player:GetBatteryCharge(ActiveSlot.SLOT_PRIMARY) + chargeamount
		player:SetActiveCharge(tempeatheartcharges, ActiveSlot.SLOT_PRIMARY)
		Game():GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_PRIMARY)
	end
	if player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == wakaba.COLLECTIBLE_EATHEART then
		tempeatheartcharges = player:GetActiveCharge(ActiveSlot.SLOT_SECONDARY) + player:GetBatteryCharge(ActiveSlot.SLOT_SECONDARY) + chargeamount
		player:SetActiveCharge(tempeatheartcharges, ActiveSlot.SLOT_SECONDARY)
		Game():GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_SECONDARY)
	end
	if player:GetActiveItem(ActiveSlot.SLOT_POCKET) == wakaba.COLLECTIBLE_EATHEART then
		tempeatheartcharges = player:GetActiveCharge(ActiveSlot.SLOT_POCKET) + player:GetBatteryCharge(ActiveSlot.SLOT_POCKET) + chargeamount
		player:SetActiveCharge(tempeatheartcharges, ActiveSlot.SLOT_POCKET)
		Game():GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_POCKET)
	end
end

function wakaba:PreTakeDamage_EatHeart(entity, amount, flags, source, countdown)
	if entity.Type == EntityType.ENTITY_PLAYER then
		local player = entity:ToPlayer()
		if player and player:HasCollectible(wakaba.COLLECTIBLE_EATHEART) then
			wakaba:ChargeEatHeart(player, amount, "PlayerDamage")
		end
	else
		if entity:IsInvincible() then return end
		if entity.Type == EntityType.ENTITY_FIREPLACE then return end
		local player = nil
		if 
			(source and source.Entity and source.Entity.SpawnerEntity and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER )
		then
			player = source.Entity.SpawnerEntity:ToPlayer()
		elseif
			(source and source.Type == EntityType.ENTITY_PLAYER)
		then
			player = source.Entity:ToPlayer()
		end
		if player and player:HasCollectible(wakaba.COLLECTIBLE_EATHEART) then
			if entity.HitPoints < amount then
				amount = entity.HitPoints
			end
			wakaba:ChargeEatHeart(player, amount, "EnemyDamage")
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.PreTakeDamage_EatHeart)


function wakaba:PlayerUpdate_EatHeart(player)
	wakaba:GetPlayerEntityData(player)
	if player:GetData().wakaba.eatheartchargepending and player:GetData().wakaba.tempeatheartcharges then
		wakaba:ChargeEatHeart(player, player:GetData().wakaba.tempeatheartcharges, "Preserve")
		player:GetData().wakaba.eatheartchargepending = nil
		player:GetData().wakaba.tempeatheartcharges = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_EatHeart)

function wakaba:Damocles_EatHeart()
	local dupcnt = 0
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if wakaba:HasBless(player) and used > 0 then
			dupcnt = dupcnt + 1
		end
	end
	return dupcnt
end
CCO.DamoclesAPI.AddDamoclesCallback(wakaba.Damocles_EatHeart)

function wakaba:Update_EatHeart()
	eatHeartErr = 0
	if used > 0 then
		used = used - 1
	end
	if hasHeart > 0 then
		hasHeart = 0
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_EatHeart)
--LagCheck


function wakaba:PlayerRender_EatHeart(player)
	local pData = player:GetData()
	wakaba:GetPlayerEntityData(player)
	local usedslot = -1
	--print(player:GetCard(0) == 0, player:GetPill(0) == 0)
	if (Input.IsActionTriggered(ButtonAction.ACTION_PILLCARD, player.ControllerIndex) and player:GetActiveItem(ActiveSlot.SLOT_POCKET) == wakaba.COLLECTIBLE_EATHEART)
	then
		--print(not pData.wakaba.ehtriggered and (player:GetCard(0) == 0 and player:GetPill(0) == 0))
		if not pData.wakaba.ehtriggered and (player:GetCard(0) == 0 and player:GetPill(0) == 0) then
			usedslot = ActiveSlot.SLOT_POCKET
			pData.wakaba.ehused = true
			pData.wakaba.ehtriggered = true
		else
			pData.wakaba.ehused = false
			pData.wakaba.ehtriggered = true
		end
	end
	if (Input.IsActionTriggered(ButtonAction.ACTION_ITEM, player.ControllerIndex) and player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == wakaba.COLLECTIBLE_EATHEART)
	then
		usedslot = ActiveSlot.SLOT_PRIMARY
		pData.wakaba.ehused = true
		pData.wakaba.ehtriggered = true
	end
	if pData.wakaba.ehtriggered and pData.wakaba.ehused then
		player:UseActiveItem(wakaba.COLLECTIBLE_EATHEART, UseFlag.USE_OWNED)
		pData.wakaba.ehused = nil
		pData.wakaba.ehtriggered = nil
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerRender_EatHeart)