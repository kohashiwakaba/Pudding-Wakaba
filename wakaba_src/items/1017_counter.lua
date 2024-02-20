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

---@param entity EntityPlayer
---@param amount integer
---@param flag DamageFlag
---@param source EntityRef
---@param countdownFrames integer
---@return boolean
function wakaba:CounterTakeDmg(entity, amount, flag, source, countdownFrames)
	local player = entity:ToPlayer()
	if player:HasCollectible(wakaba.Enums.Collectibles.COUNTER) then
		for counterslot = 0, 2 do
			if player:GetActiveItem(counterslot) == wakaba.Enums.Collectibles.COUNTER and not player:NeedsCharge(counterslot) and player:GetData().wakabacountertimer == 0 then
				--player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
				--player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, true, 1)
				SFXManager():Play(SoundEffect.SOUND_HOLY_MANTLE)
				player:UseActiveItem(wakaba.Enums.Collectibles.COUNTER, 0, counterslot)
				player:DischargeActiveItem(counterslot)

				if source.Entity ~= nil and source.Entity.SpawnerEntity ~= nil then
					wakaba:TryShootCounterLaser(player, source.Entity.SpawnerEntity, 30)
				elseif source.Entity ~= nil then
					wakaba:TryShootCounterLaser(player, source.Entity, 30)
				end
				if wakaba:isMausoleumDoor(flag) then
					wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
				end

				return false
			end
		end
	end
	if player:GetData().wakabacountertimer > 0 then
		local timer = player:GetData().wakabacountertimer
		if source.Entity ~= nil and source.Entity.SpawnerEntity ~= nil then
			wakaba:TryShootCounterLaser(player, source.Entity.SpawnerEntity, timer)
		elseif source.Entity ~= nil then
			wakaba:TryShootCounterLaser(player, source.Entity, timer)
		end
		if wakaba:isMausoleumDoor(flag) then 
			wakaba:ForceOpenDoor(player, RoomType.ROOM_SECRET_EXIT)
		end
		return false
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.CounterTakeDmg, EntityType.ENTITY_PLAYER)

---@param player EntityPlayer
---@param entity Entity
function wakaba:TryShootCounterLaser(player, entity, timer)
	if not player or not entity then return end
	timer = timer or 30
	local data = entity:GetData()
	if not data.w_counter then
		player:FireTechLaser(player.Position, LaserOffset.LASER_TRACTOR_BEAM_OFFSET, entity.Position-player.Position, false, true, player, 5.0)
		data.w_counter = true
		wakaba:scheduleForUpdate(function()
			if entity and entity:Exists() then
				data.w_counter = false
			end
		end, timer)
	end
end

function wakaba:ItemUse_Counter(_, rng, player, useFlags, activeSlot, varData)
	local ct = player:GetData().wakabacountertimer
	local at = 30
	if useFlags & UseFlag.USE_VOID == UseFlag.USE_VOID or wakaba.G.Challenge == Challenge.CHALLENGE_CANTRIPPED then
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