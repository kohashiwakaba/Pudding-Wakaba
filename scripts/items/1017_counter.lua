local countertimer = 0
local counteractivetimer = 30
local shadowitem = CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS
local shadow = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS)


function wakaba:CounterPlayerEffectUpdate(player)
	local playerData = player:GetData()
	local ct = playerData.wakabacountertimer
	if ct == nil then
		playerData.wakabacountertimer = 0
		--print("counter timer reset")
	end
	if playerData.wakabacountertimer > 0 then
		--player:AddCostume(shadow, false)
		--[[if not player:GetEffects():HasCollectibleEffect(shadowitem) then
			player:GetEffects():AddCollectibleEffect(shadowitem, true, 1)
		end]]
		playerData.wakabacountertimer = playerData.wakabacountertimer - 1
	else
		if not player:GetEffects():HasCollectibleEffect(shadowitem) then
			player:RemoveCostume(shadow)
		end
	end
	--print(playerData.wakabacountertimer)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.CounterPlayerEffectUpdate)


function wakaba:CounterTakeDmg(entity, amount, flag, source, countdownFrames)
	local player = entity:ToPlayer()
	if player:HasCollectible(wakaba.Enums.Collectibles.COUNTER) then
		local counterslot = wakaba:GetActiveSlot(player, wakaba.Enums.Collectibles.COUNTER)
		if counterslot ~= nil and player:GetActiveCharge(counterslot) >= 120 and player:GetData().wakabacountertimer == 0 then
			--player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
			--player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, true, 1)
			SFXManager():Play(SoundEffect.SOUND_HOLY_MANTLE)
			player:UseActiveItem(wakaba.Enums.Collectibles.COUNTER, 0, counterslot)
			player:DischargeActiveItem(counterslot)
			
			if source.Entity ~= nil and source.Entity.SpawnerEntity ~= nil then
				player:FireTechLaser(player.Position, LaserOffset.LASER_TRACTOR_BEAM_OFFSET, source.Entity.SpawnerEntity.Position-player.Position, false, true, player, 5.0)
			elseif source.Entity ~= nil then
				player:FireTechLaser(player.Position, LaserOffset.LASER_TRACTOR_BEAM_OFFSET, source.Entity.Position-player.Position, false, true, player, 5.0)
			end
			if wakaba:isMausoleumDoor(flag) then 
				wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
			end
	
			return false
		end
	end
	if player:GetData().wakabacountertimer > 0 then
		if source.Entity ~= nil and source.Entity.SpawnerEntity ~= nil then
			player:FireTechLaser(player.Position, LaserOffset.LASER_TRACTOR_BEAM_OFFSET, source.Entity.SpawnerEntity.Position-player.Position, false, true, player, 5.0)
		elseif source.Entity ~= nil then
			player:FireTechLaser(player.Position, LaserOffset.LASER_TRACTOR_BEAM_OFFSET, source.Entity.Position-player.Position, false, true, player, 5.0)
		end
		if wakaba:isMausoleumDoor(flag) then 
			wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
		end
		return false
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.CounterTakeDmg, EntityType.ENTITY_PLAYER)

function wakaba:ItemUse_Counter(_, rng, player, useFlags, activeSlot, varData)
	local ct = player:GetData().wakabacountertimer
	local at = 30
	if useFlags & UseFlag.USE_VOID == UseFlag.USE_VOID then
		at = 600
	end
	if ct == nil then
		player:GetData().wakabacountertimer = at
		player:AddCostume(shadow, false)
		--print("counter timer set")
	else
		player:GetData().wakabacountertimer = player:GetData().wakabacountertimer + at
		player:AddCostume(shadow, false)
		--print("counter timer added")
	end
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.COUNTER, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.ItemUse_Counter, wakaba.Enums.Collectibles.COUNTER)