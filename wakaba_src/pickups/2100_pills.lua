
wakaba.minpillno = wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP
wakaba.maxpillno = wakaba.Enums.Pills.UNHOLY_CURSE

local convertPHD = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP] = -1,
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP,
	[wakaba.Enums.Pills.ALL_STATS_UP] = -1,
	[wakaba.Enums.Pills.ALL_STATS_DOWN] = wakaba.Enums.Pills.ALL_STATS_UP,
	[wakaba.Enums.Pills.TO_THE_START] = -1,
	[wakaba.Enums.Pills.TROLLED] = wakaba.Enums.Pills.TO_THE_START,
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT] = -1,
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT,
	[wakaba.Enums.Pills.DUALITY_ORDERS] = -1,
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = wakaba.Enums.Pills.DUALITY_ORDERS,
	[wakaba.Enums.Pills.PRIEST_BLESSING] = -1,
	[wakaba.Enums.Pills.UNHOLY_CURSE] = wakaba.Enums.Pills.PRIEST_BLESSING,
}
local convertFalsePHD = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP] = wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN,
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = -1,
	[wakaba.Enums.Pills.ALL_STATS_UP] = wakaba.Enums.Pills.ALL_STATS_DOWN,
	[wakaba.Enums.Pills.ALL_STATS_DOWN] = -1,
	[wakaba.Enums.Pills.TROLLED] = -1,
	[wakaba.Enums.Pills.TO_THE_START] = -1,
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = -1,
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT] = wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2,
	[wakaba.Enums.Pills.DUALITY_ORDERS] = wakaba.Enums.Pills.SOCIAL_DISTANCE,
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = -1,
	[wakaba.Enums.Pills.PRIEST_BLESSING] = wakaba.Enums.Pills.UNHOLY_CURSE,
	[wakaba.Enums.Pills.UNHOLY_CURSE] = -1,
}
local pillClass = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = -3,
	[wakaba.Enums.Pills.ALL_STATS_DOWN] = -3,
	[wakaba.Enums.Pills.TROLLED] = -3,
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = -2,
	[wakaba.Enums.Pills.UNHOLY_CURSE] = -3,
}
wakaba.ConvertBlessingPills = {
	[PillEffect.PILLEFFECT_AMNESIA] = PillEffect.PILLEFFECT_SEE_FOREVER,
	[PillEffect.PILLEFFECT_RETRO_VISION] = PillEffect.PILLEFFECT_VURP,
	[PillEffect.PILLEFFECT_IM_EXCITED] = PillEffect.PILLEFFECT_GULP,
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = wakaba.Enums.Pills.DUALITY_ORDERS,
}

function wakaba:PlayerUpdate_Pills(player)
	player:GetData().wakaba_currentPill = player:GetPill(0)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Pills)

function wakaba:anyPlayerHasPHD()
	local a = false
	wakaba:ForAllPlayers(function (player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_PHD)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_VIRGO)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_LUCKY_FOOT)
		then
			a = true
		end
	end)
	return a
end

local function hasFalsePHD(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_FALSE_PHD)
	then
		return true
	else
		return false
	end
end

-- IsPlayerUsingHorsePill : from Xalum
function wakaba:IsPlayerUsingHorsePill(player, useFlags)
	local pillColour = player:GetPill(0)

	local holdingHorsePill = pillColour & PillColor.PILL_GIANT_FLAG > 0
	local proccedByEchoChamber = useFlags & (1 << 11) > 0 -- idk why this useflag isn't enumerated

	return holdingHorsePill and not proccedByEchoChamber
end

function wakaba:getPillEffect(pillEffect, pillColor)
	local phd = wakaba:anyPlayerHasPHD()
	local fhd = wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_FALSE_PHD)
	local onlyPhd = phd and not fhd
	local onlyFhd = fhd and not phd
	wakaba:ForAllPlayers(function (player)
		if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
			if pillEffect == PillEffect.PILLEFFECT_LUCK_DOWN then
				if fhd then
					return PillEffect.PILLEFFECT_SPEED_DOWN
				else
					return PillEffect.PILLEFFECT_LUCK_UP
				end
			elseif pillEffect == PillEffect.PILLEFFECT_SPEED_UP then
				if phd then
					return PillEffect.PILLEFFECT_LUCK_UP
				else
					return PillEffect.PILLEFFECT_SPEED_DOWN
				end
			end
		elseif player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B then
			if pillEffect == PillEffect.PILLEFFECT_LUCK_UP then
				if phd then
					return wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP
				else
					return PillEffect.PILLEFFECT_LUCK_DOWN
				end
			end
		end
	end)
	if wakaba:ShouldRemoveBlind() then
		if wakaba.ConvertBlessingPills[pillEffect] then
			pillEffect = wakaba.ConvertBlessingPills[pillEffect]
		end
	end
	if phd and not fhd then
		if convertPHD[pillEffect] ~= nil then
			if convertPHD[pillEffect] ~= -1 then
				pillEffect = convertPHD[pillEffect]
			end
		end
	elseif not phd and fhd then
		if convertFalsePHD[pillEffect] ~= nil then
			if convertFalsePHD[pillEffect] ~= -1 then
				pillEffect = convertFalsePHD[pillEffect]
			end
		end
	end

	if pillEffect == wakaba.Enums.Pills.SOCIAL_DISTANCE and wakaba.G:IsGreedMode() then
		pillEffect = wakaba.Enums.Pills.ALL_STATS_DOWN
	end
	if pillEffect == wakaba.Enums.Pills.DUALITY_ORDERS then
		if wakaba.G:IsGreedMode() then
			pillEffect = wakaba.Enums.Pills.ALL_STATS_UP
		else
			local status = wakaba:getDevilAngelStatus()
			if status.WDreams then
				pillEffect = wakaba.Enums.Pills.SOCIAL_DISTANCE
			end
		end
	end
	--print(pillEffect)
	return pillEffect
end
wakaba:AddPriorityCallback(ModCallbacks.MC_GET_PILL_EFFECT, 100, wakaba.getPillEffect)

function wakaba:getCustomStat(player, statType)
	if type(statType) ~= "string" or not wakaba:has_value(wakaba.ValidCustomStat, statType) then return 0 end
	return player:GetData().wakaba.statmodify[statType]
end

function wakaba:addCustomStat(player, statType, amount)
	if type(statType) ~= "string" or not wakaba:has_value(wakaba.ValidCustomStat, statType) then return end
	if not amount or type(amount) ~= "number" then return end
	player:GetData().wakaba.statmodify[statType] = player:GetData().wakaba.statmodify[statType] + amount
end

function wakaba:setCustomStat(player, statType, amount)
	if type(statType) ~= "string" or not wakaba:has_value(wakaba.ValidCustomStat, statType) then return end
	if not amount or type(amount) ~= "number" then return end
	player:GetData().wakaba.statmodify[statType] = amount
end

function wakaba:useWakabaPill(_pillEffect, player, useFlags, _pillColor)

	-- Post G FUEL patch by Connor
	local pillColor = REPENTOGON and _pillColor or player:GetData().wakaba_currentPill
	wakaba.Log("Pill Used:", pillColor)
	local pillEffect = wakaba.G:GetItemPool():GetPillEffect(pillColor, player)
	if pillColor % PillColor.PILL_GIANT_FLAG == PillColor.PILL_GOLD or pillColor % PillColor.PILL_GIANT_FLAG == PillColor.PILL_NULL then
		pillEffect = _pillEffect
	end
	local isHorse = pillColor and pillColor > 0 and pillColor >= PillColor.PILL_GIANT_FLAG
	local multiplier = 1
	if isHorse then
		multiplier = 2
	end
	--print(isHorse)
	if useFlags & UseFlag.USE_NOHUD ~= UseFlag.USE_NOHUD and Options.Language ~= "en" then
		local descTable = wakaba.descriptions[wakaba.LanguageMap[Options.Language]]
		if descTable then
			local pilltable = descTable.pills
			if pilltable and pilltable[pillEffect] and pilltable[pillEffect].itemName then
				wakaba.G:GetHUD():ShowItemText(pilltable[pillEffect].itemName)
			end
		end
	end

	if wakaba:getstoredindex(player) ~= nil then
		player:GetData().wakaba.statmodify.hairpinluck = player:GetData().wakaba.statmodify.hairpinluck or 0
		wakaba:addCustomStat(player, "hairpinluck", multiplier)

		if pillEffect == wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP then
			wakaba:addCustomStat(player, "damage", 0.08 * multiplier)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
			player:AnimateHappy()
			SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
		elseif pillEffect == wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN then
			wakaba:addCustomStat(player, "damage", -0.02 * multiplier)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
			player:AnimateSad()
		elseif pillEffect == wakaba.Enums.Pills.ALL_STATS_UP then
			wakaba:addCustomStat(player, "damage", 0.25 * multiplier)
			wakaba:addCustomStat(player, "tears", 0.2 * multiplier)
			wakaba:addCustomStat(player, "range", 0.4 * multiplier)
			wakaba:addCustomStat(player, "luck", 1 * multiplier)
			wakaba:addCustomStat(player, "speed", 0.12 * multiplier)
			wakaba:addCustomStat(player, "shotspeed", 0.08 * multiplier)
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
			player:AnimateHappy()
			SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
		elseif pillEffect == wakaba.Enums.Pills.ALL_STATS_DOWN then
			wakaba:addCustomStat(player, "damage", -0.1 * multiplier)
			wakaba:addCustomStat(player, "tears", -0.08 * multiplier)
			wakaba:addCustomStat(player, "range", -0.25 * multiplier)
			wakaba:addCustomStat(player, "luck", -1 * multiplier)
			wakaba:addCustomStat(player, "speed", -0.09 * multiplier)
			wakaba:addCustomStat(player, "shotspeed", -0.06 * multiplier)
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
			player:AnimateSad()
		elseif pillEffect == wakaba.Enums.Pills.TROLLED then
			local hasBeast = wakaba:HasBeast()
			if hasBeast then
				for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_BEAST, -1, -1, false, false)) do
					entity.HitPoints = entity.MaxHitPoints
				end
				player:AnimateSad()
			elseif wakaba.G:GetLevel():GetAbsoluteStage() == LevelStage.STAGE8 or wakaba.G:GetLevel():GetAbsoluteStage() == LevelStage.STAGE4_3 then
				wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_TMTRAINER, 1)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(player.Position, 32), Vector(0,0), nil)
				if isHorse then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(player.Position, 64), Vector(0,0), nil)
				end
				player:AnimateSad()
			elseif wakaba.G:GetLevel():GetAbsoluteStage() == LevelStage.STAGE3_2 and wakaba.G:GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT) and not wakaba.G:GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH) then
				player:UseCard(Card.CARD_EMPEROR, UseFlag.USE_MIMIC | UseFlag.USE_NOHUD | UseFlag.USE_NOANNOUNCER | UseFlag.USE_CARBATTERY | UseFlag.USE_NOANIM)
				--wakaba.G:StartRoomTransition(-2,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
				if isHorse then
					player:AddBrokenHearts(-1)
				end
			else
				wakaba.G:StartRoomTransition(-2,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
				if isHorse then
					player:AddBrokenHearts(-1)
				end
			end
		elseif pillEffect == wakaba.Enums.Pills.TO_THE_START then
			local hasBeast = wakaba:HasBeast()
			if hasBeast then
				for i = 1, wakaba.G:GetNumPlayers() do
					local player = Isaac.GetPlayer(i - 1)
					player:AddHearts(24)
					player:AddSoulHearts(24)
				end
				player:AnimateHappy()
				SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
			else
				if isHorse then
					if player:CanPickRedHearts() then
						player:AddHearts(2)
					else
						player:AddSoulHearts(2)
					end
					player:AddBrokenHearts(-1)
				end
				wakaba.G:StartRoomTransition(wakaba.G:GetLevel():GetStartingRoomIndex(),Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
			end
		elseif pillEffect == wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT then
			if isHorse then
				player:UseCard(Card.CARD_SOUL_AZAZEL, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_OWNED | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
			else
				player:UseActiveItem(CollectibleType.COLLECTIBLE_SULFUR, UseFlag.USE_NOANIM | UseFlag.USE_VOID)
			end
		elseif pillEffect == wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2 then
			wakaba:GetPlayerEntityData(player)
			player:GetData().wakaba.trollbrimstonecounter = player:GetPillRNG(wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2):RandomInt(100)
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ENEMY_BRIMSTONE_SWIRL, 0, player.Position, Vector.Zero, nil)
			if isHorse then
				player:UseActiveItem(CollectibleType.COLLECTIBLE_HEAD_OF_KRAMPUS, UseFlag.USE_NOANIM | UseFlag.USE_VOID)
			end
			player:AnimateSad()
		elseif pillEffect == wakaba.Enums.Pills.DUALITY_ORDERS then
			wakaba.HiddenItemManager:AddForFloor(player, CollectibleType.COLLECTIBLE_DUALITY, 0, 1, "WAKABA_PILLS")
			wakaba.HiddenItemManager:AddForFloor(player, CollectibleType.COLLECTIBLE_EUCHARIST, 0, 1, "WAKABA_PILLS")
			if isHorse then
				wakaba.G:SetLastDevilRoomStage(-1)

				local indRng = player:GetPillRNG(wakaba.Enums.Pills.DUALITY_ORDERS)
				local ind = indRng:RandomInt(41000) + 60

				local p1 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
					wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, false),
					Isaac.GetFreeNearPosition(player.Position - Vector(32, 0), 32), Vector(0,0), nil):ToPickup()
				local p2 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
				wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL, false),
					Isaac.GetFreeNearPosition(player.Position + Vector(32, 0), 32), Vector(0,0), nil):ToPickup()
			end
			player:AnimateHappy()
			SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
		elseif pillEffect == wakaba.Enums.Pills.SOCIAL_DISTANCE then
			wakaba.G:GetLevel():DisableDevilRoom()
			if isHorse then
				wakaba.G:SetLastDevilRoomStage(wakaba.G:GetLevel():GetAbsoluteStage())
			end
			player:AnimateSad()
		--[[ elseif pillEffect == wakaba.Enums.Pills.FLAME_PRINCESS then
			local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, -1, false, false)
			local haswisp = false
			local wispcnt = 0
			for i, e in ipairs(wisps) do
				if e.SpawnerEntity.Index == player.Index then
					if wispcnt * 2 > multiplier * #wisps then break end
					haswisp = true
					e.HitPoints = e.MaxHitPoints
					if isHorse then
						e.HitPoints = e.MaxHitPoints * 3
					end
				end
			end
			local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
			for i, e in ipairs(wisps) do
				if e.SpawnerEntity.Index == player.Index then
					haswisp = true
					local item = e.SubType
					local config = Isaac.GetItemConfig():GetCollectible(item)
					if config and (config.Type == ItemType.ITEM_PASSIVE or config.Type == ItemType.ITEM_FAMILIAR) then
						e:Kill()
						player:AddCollectible(item)
						if isHorse then
							player:AddCollectible(item)
						end
					else
						e.HitPoints = e.MaxHitPoints
						if isHorse then
							e.HitPoints = e.MaxHitPoints * 3
						end
					end
				else
					e.HitPoints = e.MaxHitPoints
				end
			end
			if not haswisp then
				local familiar = player:AddWisp(0, player.Position, true, false)
				familiar.Parent = collider
				familiar.Player = player
				familiar.CollisionDamage = familiar.CollisionDamage * 12
				familiar.MaxHitPoints = familiar.MaxHitPoints * 12
				familiar.HitPoints = familiar.MaxHitPoints
				if isHorse then
					familiar.MaxHitPoints = familiar.MaxHitPoints * 2
					familiar.HitPoints = familiar.MaxHitPoints
				end
			end

			player:AnimateHappy()
			SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
		elseif pillEffect == wakaba.Enums.Pills.FIREY_TOUCH then
			wakaba.G:GetLevel():AddCurse(wakaba.curses.CURSE_OF_FLAMES)
			local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, -1, false, false)
			for i, e in ipairs(wisps) do
				if e.SpawnerEntity.Index == player.Index then
					e.HitPoints = e.MaxHitPoints
					if isHorse then
						e.HitPoints = e.MaxHitPoints * 3
					end
				end
			end
			local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
			for i, e in ipairs(wisps) do
				if e.SpawnerEntity.Index == player.Index then
					e.HitPoints = e.MaxHitPoints
					if isHorse then
						e.HitPoints = e.MaxHitPoints * 3
					end
				end
			end
			player:AnimateSad()
		 ]]elseif pillEffect == wakaba.Enums.Pills.PRIEST_BLESSING then
			player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
			if multiplier == 2 then
				player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
			end
			player:AnimateHappy()
			SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
		elseif pillEffect == wakaba.Enums.Pills.UNHOLY_CURSE then
			if player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) > 0 then
				if multiplier == 2 and player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) > 1 then
					player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
				end
				player:TakeDamage(1, DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(player), 0)
			end
			player:AnimateSad()
		end

		if pillClass[pillEffect] then
			if pillClass[pillEffect] == -3 then
				wakaba:addCustomStat(player, "falsedamage", 0.6 * multiplier)
			elseif pillClass[pillEffect] == -2 or pillClass[pillEffect] == -1 then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_FALSE_PHD) then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
					if isHorse then
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
					end
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_PILL, wakaba.useWakabaPill)

function wakaba:onPillCache(player, cacheFlag)
	local sti = player:GetData().wakaba
	if sti and sti.statmodify then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (wakaba:getCustomStat(player, "damage") * wakaba:getEstimatedDamageMult(player))
			if player:HasCollectible(CollectibleType.COLLECTIBLE_FALSE_PHD) then
				player.Damage = player.Damage + (wakaba:getCustomStat(player, "falsedamage") * wakaba:getEstimatedDamageMult(player))
			end
			player.Damage = player.Damage * (1 + sti.statmultiplier.damage)
		end
		if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			if sti.statmodify.shotspeed >= 0 then
				player.ShotSpeed = player.ShotSpeed + (math.sqrt(1 + sti.statmodify.shotspeed) - 1)
			else
				player.ShotSpeed = player.ShotSpeed + wakaba:getCustomStat(player, "shotspeed")
			end
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (wakaba:getCustomStat(player, "range") * 40)
		end
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + wakaba:getCustomStat(player, "speed")
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + wakaba:getCustomStat(player, "luck")
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, wakaba:getCustomStat(player, "tears") * wakaba:getEstimatedTearsMult(player))
		end
	end

end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onPillCache)


--Updates the Passive Effects

function wakaba:onPillUpdate(player)
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.trollbrimstonecounter = player:GetData().wakaba.trollbrimstonecounter or -1
	if player:GetData().wakaba.trollbrimstonecounter > -1 then
		player:GetData().wakaba.trollbrimstonecounter = player:GetData().wakaba.trollbrimstonecounter - 1
		if player:GetData().wakaba.trollbrimstonecounter == 0 then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ENEMY_BRIMSTONE_SWIRL, 0, player.Position, Vector.Zero, nil)
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.onPillUpdate)



function wakaba:PlayerInit_Pills(player)
	if player:GetPlayerType() == PlayerType.PLAYER_THELOST_B then
		local pool = wakaba.G:GetItemPool()
		local hasPriest = false
		for i = 1, 13 do
			if pool:GetPillEffect(i) == wakaba.Enums.Pills.PRIEST_BLESSING then
				pool:IdentifyPill(i)
				hasPriest = true
			end
		end
		if not hasPriest then
			local pill = pool:ForceAddPillEffect(wakaba.Enums.Pills.PRIEST_BLESSING)
			pool:IdentifyPill(pill)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PlayerInit_Pills, 0)

if EID then
	EID:addDescriptionModifier("Wakaba Pills", function (descObj)
		return descObj.ObjType == 5
			and descObj.ObjVariant == PickupVariant.PICKUP_PILL
			and wakaba.G:GetItemPool():IsPillIdentified(descObj.ObjSubType)
			--and descObj.ObjSubType > PillColor.PILL_GIANT_FLAG
	end, function (descObj)
		local adjustedID = EID:getAdjustedSubtype(descObj.ObjType, descObj.ObjVariant, descObj.ObjSubType)
		local engDesc = wakaba.descriptions["en_us"]
		local desc = wakaba.descriptions[EID:getLanguage()] or engDesc
		local pillEntries = desc.pills or engDesc.pills
		local pillDesc = pillEntries[adjustedID-1] or engDesc.pills[adjustedID-1]
		if pillDesc then
			if pillDesc.itemNameAfter then
				descObj.Name = pillDesc.itemNameAfter
			end
		end
		if descObj.ObjSubType > PillColor.PILL_GIANT_FLAG then
			local unistr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].horsepills) or wakaba.descriptions["en_us"].horsepills
			if unistr[adjustedID-1] then
				descObj.Description = unistr[adjustedID-1][3]
			end
		end
		return descObj
	end)
end