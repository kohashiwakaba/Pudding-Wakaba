

local playerType = wakaba.Enums.Players.SHIORI_B
local removed = false
local collectibleCount
local costumeEquipped 
local isShioriContinue = true
local iskeyinit = false
local isc = require("wakaba_src.libs.isaacscript-common")
wakaba:registerCharacterHealthConversion(wakaba.Enums.Players.SHIORI_B, isc.HeartSubType.SOUL)

function wakaba:GetShioriCostume_b(player, ignorecooldown)
	if ignorecooldown or wakaba.costumecurrframe == 0 then
		wakaba.costumecurrframe = wakaba.costumecooldown
		player:AddNullCostume(wakaba.COSTUME_SHIORI_B)
		player:AddNullCostume(wakaba.COSTUME_SHIORI_B_BODY)
	end
end

--[[ if Poglite then
	local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakaba_pog.anm2")
	Poglite:AddPogCostume("ShioriPog",playerType,pogCostume)
end ]]

--Costume currently not working in Knife Piece 2 area. Needs to be fixed.
function wakaba:PostShioriUpdate_b()
	
end
--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostShioriUpdate_b)

function wakaba:SetShioriCharge_b(player, amount, slot)
  if player == nil then return end
  local amount = amount or 0
  local slot = slot or ActiveSlot.SLOT_PRIMARY
  local activeItem = player:GetActiveItem(slot)
  if activeItem <= 0 then return end
  --if slot == ActiveSlot.SLOT_POCKET and wakaba.G.Challenge == wakaba.challenges.CHALLENGE_GURD then return end
  local activeConfig = wakaba.itemConfig:GetCollectible(activeItem)
  if activeConfig == nil then return end
  local maxCharges = activeConfig.MaxCharges
  if activeConfig.ChargeType == ItemConfig.CHARGE_TIMED or activeConfig.ChargeType == ItemConfig.CHARGE_SPECIAL then
    if wakaba:has_value(wakaba.shioriwhitelisted, activeItem) then
      if player:GetNumKeys() > 0 then
        player:SetActiveCharge(200000, slot)
      end
    end
  elseif activeItem == wakaba.Enums.Collectibles.BOOK_OF_CONQUEST then
    if wakaba.killcount <= 160 then
      player:SetActiveCharge(200000, slot)
    else
      player:SetActiveCharge(0, slot)
    end
  else
    player:SetActiveCharge(amount, slot)
  end
end

function wakaba:PostShioriPlayerUpdate_b(player)
	if player:GetPlayerType() == playerType then
    local keys = player:GetNumKeys()
    wakaba:SetShioriCharge_b(player, keys, ActiveSlot.SLOT_PRIMARY)
    wakaba:SetShioriCharge_b(player, keys, ActiveSlot.SLOT_SECONDARY)
    wakaba:SetShioriCharge_b(player, keys, ActiveSlot.SLOT_POCKET)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PostShioriPlayerUpdate_b)

function wakaba:PostGetCollectible_Shiori_b(player, item)
	if not player or player:GetPlayerType() ~= wakaba.Enums.Players.SHIORI_B then return end
	player:AddSoulHearts(player:GetSoulHearts() * -1)
	player:AddMaxHearts(2)
end
wakaba:addPostItemGetFunction(wakaba.PostGetCollectible_Shiori_b, CollectibleType.COLLECTIBLE_DEAD_CAT)

function wakaba:ItemUse_Shiori_b(useditem, rng, player, useflag, slot, vardata)
  if wakaba.shioriblacklisted[useditem] then return end
  if useflag | UseFlag.USE_VOID == UseFlag.USE_VOID then return end
  if slot == ActiveSlot.SLOT_POCKET2 then return end
  if player:GetPlayerType() == playerType and slot ~= -1 then
    local item = Isaac.GetItemConfig():GetCollectible(useditem)
    local charge = item.MaxCharges
    local chargeType = item.chargeType --does not work
    local consume = charge
    if useditem == wakaba.Enums.Collectibles.BOOK_OF_CONQUEST then return end
    --if slot == ActiveSlot.SLOT_POCKET and wakaba.G.Challenge == wakaba.challenges.CHALLENGE_GURD then return end
    if player:HasCollectible(CollectibleType.COLLECTIBLE_9_VOLT) and consume > 1 then
      consume = consume - 1
    end
    if ((item.ChargeType == ItemConfig.CHARGE_TIMED or item.ChargeType == ItemConfig.CHARGE_SPECIAL) 
    and not wakaba:has_value(wakaba.shioriwhitelisted, useditem)) then
      if player:GetActiveCharge(slot) + player:GetBatteryCharge(slot) >= charge then 
        return
      else
        consume = 1
      end
    end
    if wakaba:has_value(wakaba.shioriwhitelisted, useditem) then
      consume = 1
    end
    if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and consume > 1 then
      consume = consume - 1
    end
    player:AddKeys(-consume)
  end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Shiori_b)

function wakaba:PostShioriPickupCollision_b(pickup, collider, low)
  if collider:ToPlayer() ~= nil then
    local player = collider:ToPlayer()
		if player:GetPlayerType() == playerType then
      if pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY then
        if player:GetNumKeys() < 99 and not player:IsHoldingItem() then
          if pickup.SubType == BatterySubType.BATTERY_NORMAL then
            if player:GetNumCoins() < pickup.Price then
              return true
            end
            player:AddKeys(3)
          elseif pickup.SubType == BatterySubType.BATTERY_MICRO then
            if player:GetNumCoins() < pickup.Price then
              return true
            end
            player:AddKeys(1)
          elseif pickup.SubType == BatterySubType.BATTERY_MEGA then
            if player:GetNumCoins() < pickup.Price then
              return true
            end
            player:AddKeys(5)
          elseif pickup.SubType == BatterySubType.BATTERY_GOLDEN then
            if player:GetNumCoins() < pickup.Price then
              return true
            end
            player:AddKeys(10)
            player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(pickup), 0)
          end
          --pickup:GetSprite():Play("Collect", true)
          local bookitem = wakaba.itemConfig:GetCollectible(player:GetActiveItem(ActiveSlot.SLOT_POCKET))
          local primaryitem = wakaba.itemConfig:GetCollectible(player:GetActiveItem(ActiveSlot.SLOT_PRIMARY))
          local secondaryitem = wakaba.itemConfig:GetCollectible(player:GetActiveItem(ActiveSlot.SLOT_SECONDARY))
          if bookitem ~= nil and bookitem.MaxCharges ~= 0 and bookitem.ChargeType ~= ItemConfig.CHARGE_SPECIAL then
            player:SetActiveCharge(0, ActiveSlot.SLOT_POCKET)
          elseif primaryitem ~= nil and primaryitem.MaxCharges ~= 0 and primaryitem.ChargeType ~= ItemConfig.CHARGE_SPECIAL then
            player:SetActiveCharge(0, ActiveSlot.SLOT_PRIMARY)
          elseif secondaryitem ~= nil and secondaryitem.MaxCharges ~= 0 and secondaryitem.ChargeType ~= ItemConfig.CHARGE_SPECIAL then
            player:SetActiveCharge(0, ActiveSlot.SLOT_SECONDARY)
          else
            local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 1, Vector(player.Position.X, player.Position.Y - 30), Vector.Zero, nil):ToEffect()
            --notif:FollowParent(player)
            notif.DepthOffset = player.DepthOffset + 5
            SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE, 2, 0, false, 1)
            if pickup:IsShopItem() then
              if pickup.Price == PickupPrice.PRICE_SPIKES then
                player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(pickup), 0)
              end
              pickup:Remove()
              return true
            else
              pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
              pickup:GetSprite():Play("Collect", true)
              pickup:PlayPickupSound()
              pickup:Die()
              return true
            end
          end
        end
      elseif pickup.Variant == PickupVariant.PICKUP_HEART then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_ALABASTER_BOX) and player:GetNumKeys() < 12 then
          if pickup.SubType == HeartSubType.HEART_SOUL then
            player:AddKeys(2)
          elseif pickup.SubType == HeartSubType.HEART_HALF_SOUL then
            player:AddKeys(1)
          end
        end
      elseif pickup.Variant == PickupVariant.PICKUP_KEY then
        if pickup.SubType == KeySubType.KEY_CHARGED then
          player:AddKeys(3)
        end
      end
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PostShioriPickupCollision_b)

function wakaba:getPickupState_b(pickup, offset)
  --print("Battery HP",pickup.HitPoints)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, wakaba.getPickupState_b, PickupVariant.PICKUP_LIL_BATTERY)

function wakaba:PostShioriPickupInit_b(pickup)
  local hasshiori = false
  local shioriluck = 0
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == playerType then
      hasshiori = true
      shioriluck = shioriluck + player.Luck
      local rng = wakaba.PickupRNG
      local randomNum = rng:RandomFloat()
      randomNum = randomNum * 100
      local minNum = wakaba.state.options.shiorikeychance
      minNum = minNum + (shioriluck * 4)
      if randomNum <= minNum then
        player:AddKeys(1)
      end
    end
  end

end
--wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PostShioriPickupInit_b)

function wakaba:PostNPCDeathShiori_b(entity)
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == playerType then
      local data = player:GetData()
      data.wakaba = data.wakaba or {}
      data.wakaba.enemieskilled = data.wakaba.enemieskilled or 0
      if player:HasCollectible(CollectibleType.COLLECTIBLE_JUMPER_CABLES) then
        data.wakaba.enemieskilled = data.wakaba.enemieskilled + 1
        if data.wakaba.enemieskilled >= 15 then
          data.wakaba.enemieskilled = data.wakaba.enemieskilled - 15
          player:AddKeys(1)
        end
      end
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, wakaba.PostNPCDeathShiori_b)

function wakaba:PreTakeDamageShiori_b(entity, amount, flags, source, countdown)
	if entity.Type ~= EntityType.ENTITY_PLAYER
	then
		local player = nil
		if 
			(source ~= nil
			and source.Entity ~= nil
			and source.Entity.SpawnerEntity ~= nil
			and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER )
		then
			player = source.Entity.SpawnerEntity:ToPlayer()
		elseif
			(source ~= nil
			and source.Type == EntityType.ENTITY_PLAYER)
		then
			player = source.Entity:ToPlayer()
		end
		if player ~= nil then
			if (player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_4_5_VOLT))
			--or (player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_4_5_VOLT))
			then
        local data = player:GetData()
        data.wakaba = data.wakaba or {}
        data.wakaba.currdamage = data.wakaba.currdamage or 0
        local increase = amount
        if amount > entity.HitPoints then
          increase = entity.HitPoints
        end
        data.wakaba.currdamage = data.wakaba.currdamage + increase
        local border = 40 + (20 * wakaba.G:GetLevel():GetAbsoluteStage())
        if data.wakaba.currdamage >= border then
          data.wakaba.currdamage = data.wakaba.currdamage - border
          player:AddKeys(1)
        end
			end
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.PreTakeDamageShiori_b)

function wakaba:PreRoomClearShiori(rng, spawnPosition)
  local hasshiori = false
  local shioriluck = 0
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == playerType then
      hasshiori = true
      shioriluck = shioriluck + player.Luck
      local rng = wakaba.PickupRNG
      local randomNum = rng:RandomFloat()
      randomNum = randomNum * 100
      local minNum = wakaba.state.options.shiorikeychance
      minNum = minNum + (shioriluck * 4)
      if randomNum <= minNum then
        player:AddKeys(1)
      end
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.PreRoomClearShiori)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.PreRoomClearShiori)


local ShioriChar_b = { 
  DAMAGE = 0.2,
  SPEED = 0.0,
  SHOTSPEED = 1.0,
  TEARRANGE = -20,
	TEARS = 0.27,
  LUCK = 1,
  FLYING = true,                                 
  TEARFLAG = TearFlags.TEAR_TURN_HORIZONTAL,
  TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)  -- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}
 
function wakaba:onShioriCache_b(player, cacheFlag)
  if player:GetPlayerType() == playerType then
		local additional = 0
    if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			additional = wakaba.fcount
    end
		wakaba:GetShioriCostume_b(player)
    if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
      player.Damage = (player.Damage + (additional * 0.2)) * ShioriChar_b.DAMAGE + 0.3
    end
    if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
      player.ShotSpeed = player.ShotSpeed * ShioriChar_b.SHOTSPEED + (additional * 0.02)
    end
    if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
        player.TearRange = player.TearRange + ShioriChar_b.TEARRANGE + (additional * 0.05)
    end
    if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
      player.MoveSpeed = player.MoveSpeed + ShioriChar_b.SPEED + (additional * 0.04)
    end
    if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
      player.Luck = player.Luck + ShioriChar_b.LUCK + (additional * 0.25)
    end
    if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and ShioriChar_b.FLYING then
      player.CanFly = true
    end
    if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
      player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, ShioriChar_b.TEARS)
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (additional * 0.06))
    end
    if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
      player.TearFlags = player.TearFlags | ShioriChar_b.TEARFLAG
    end
    if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
      player.TearColor = ShioriChar_b.TEARCOLOR
    end
	else
		player:TryRemoveNullCostume(wakaba.COSTUME_SHIORI_B)
  end
	
end
 
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onShioriCache_b)

function wakaba:AfterShioriInit_b(player)
  local player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
    local data = player:GetData()
    data.wakaba = data.wakaba or {}
    data.wakaba.bookindex = data.wakaba.bookindex or 1
    data.wakaba.currdamage = data.wakaba.currdamage or 0
    data.wakaba.enemieskilled = data.wakaba.enemieskilled or 0
    data.wakaba.nextshioriflag = data.wakaba.nextshioriflag or 0
    player:SetPocketActiveItem(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST, ActiveSlot.SLOT_POCKET, false)
    Isaac.DebugString("[wakaba]Adding bookmakrs")
    if not player:HasCollectible(wakaba.SHIORI_BOOKMARK) then player:AddCollectible(wakaba.SHIORI_BOOKMARK) end
    if not player:HasCollectible(wakaba.SHIORI_BOOKMARK2) then player:AddCollectible(wakaba.SHIORI_BOOKMARK2) end
    if not player:HasCollectible(wakaba.SHIORI_BOOKMARK3) then player:AddCollectible(wakaba.SHIORI_BOOKMARK3) end
		
		if not player:HasTrinket(TrinketType.TRINKET_OLD_CAPACITOR, false) then
			player:AddTrinket(TrinketType.TRINKET_OLD_CAPACITOR)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM, -1)
		end
		if wakaba.G:IsGreedMode() and not player:HasTrinket(TrinketType.TRINKET_FLAT_PENNY, false) then
			player:AddTrinket(TrinketType.TRINKET_FLAT_PENNY)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM, -1)
		end

    
		if wakaba.state.options.cp_shiori_b then
      player:EvaluateItems()
      --player:ClearCostumes()
		else
			wakaba:GetShioriCostume_b(player)
		end


  end
end

function wakaba:PostShioriInit_b(player)
	if player:GetPlayerType() == playerType then
		wakaba:GetShioriCostume_b(player)
	end
  if not isShioriContinue then
    wakaba:AfterShioriInit_b(player)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostShioriInit_b)

function wakaba:ShioriInit_b(continue)
  if (not continue) then
    isShioriContinue = false
    wakaba:AfterShioriInit_b()
  end
  
  if Poglite then
  	if wakaba.state.pog ~= nil then
  		if wakaba.state.pog then
  			-- Shiori POG
  			local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/shiorisosig.anm2")
  			Poglite:AddPogCostume("MinervaPog",playerType,pogCostume)
  		else
  			-- Origin POG
  			local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/shioripog.anm2")
  			Poglite:AddPogCostume("MinervaPog",playerType,pogCostume)
  		end
  	end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.ShioriInit_b)

function wakaba:ShioriExit_b()
  isShioriContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.ShioriExit_b)





