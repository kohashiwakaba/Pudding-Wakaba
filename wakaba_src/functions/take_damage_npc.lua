--[[
	Base damage function from Fiend Folio
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

local function ApplyWakabaTearEffects(entity, source, isLaser)
	if isLaser then
		Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, nil, source.Entity:ToPlayer(), entity)
	elseif source.Type =~ EntityType.ENTITY_PLAYER then
		local data = source.Entity:GetData()
		data.wakaba_TearEffectEntityBlacklist = data.wakaba_TearEffectEntityBlacklist or {}
		if data.wakaba_TearEffectEntityBlacklist[entity.InitSeed] then return end
	
		for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.APPLY_TEARFLAG_EFFECT)) do
			if wakaba:HasRicherTearFlags(source.Entity, callbackData.Param) then
				local newEntity = callbackData.Function(callbackData.Mod, entity, source.Entity.SpawnerEntity:ToPlayer(), source.Entity)
	
				if newEntity then
					entity = newEntity
				end
			end
		end
		data.wakaba_TearEffectEntityBlacklist[entity.InitSeed] = true
	end
end

function wakaba:TakeDamage_Global(target, damage, flags, source, countdown)
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_PULL then
		if source ~= nil and source.Type == EntityType.ENTITY_TEAR then
			local player = source.Entity.SpawnerEntity:ToPlayer()
			if player then
				return false
			end
		end
	end
	local data = target:GetData()
	local cloned = flags & DamageFlag.DAMAGE_CLONES ~= 0
	if not data.wakaba_ignoreDuplicateDamage and not cloned and target:ToNPC() then
		local originalDamage = damage
		local newDamage = damage
		local newFlags = flags
		local sendNewDamage = false

		local returndata = wakaba:RiraBraOnDamage(source, target, data, newDamage, newFlags)
		newDamage = returndata.newDamage or newDamage
		sendNewDamage = returndata.sendNewDamage or sendNewDamage

		if flags == flags | DamageFlag.DAMAGE_EXPLOSION then
			local returndata = wakaba:NewYearBombDamage(source, target, data, newDamage, newFlags, flags == flags | DamageFlag.DAMAGE_IGNORE_ARMOR)
			newDamage = returndata.newDamage or newDamage
			sendNewDamage = returndata.sendNewDamage or sendNewDamage
			newFlags = returndata.newFlags or newFlags
		else
			local returndata = wakaba:NekoFigureDamage(source, target, data, newDamage, newFlags)
			newDamage = returndata.newDamage or newDamage
			sendNewDamage = returndata.sendNewDamage or sendNewDamage
			newFlags = returndata.newFlags or newFlags
		end

		local returndata = wakaba:PlasmaBeamDamage(source, target, data, newDamage, newFlags, flags == flags | DamageFlag.DAMAGE_LASER)
		newDamage = returndata.newDamage or newDamage
		sendNewDamage = returndata.sendNewDamage or sendNewDamage
		newFlags = returndata.newFlags or newFlags

		if source == nil then
			-- do nothing
		elseif source.Type == EntityType.ENTITY_TEAR or
			(source.Type == EntityType.ENTITY_BOMBDROP and flags == flags | DamageFlag.DAMAGE_EXPLOSION) or
			(source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL) or
			(source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.ROCKET)
		then
			local data = source.Entity:GetData()

			local returndata = wakaba:RabbitSniperOnDamage_Tear(source, target, data, newDamage, newFlags)
			newDamage = returndata.newDamage or newDamage
			sendNewDamage = returndata.sendNewDamage or sendNewDamage

		elseif source.Type == EntityType.ENTITY_KNIFE and (source.Variant == 0 or source.Variant == 5) then
			local player = wakaba:getPlayerFromKnife(source.Entity)
			if player ~= nil then
				local secondHandMultiplier = player:GetTrinketMultiplier(TrinketType.TRINKET_SECOND_HAND) + 1
			end

			local returndata = wakaba:RabbitSniperOnDamage_Knife(source, target, data, newDamage, newFlags)
			newDamage = returndata.newDamage or newDamage
			sendNewDamage = returndata.sendNewDamage or sendNewDamage
		elseif source.Type == EntityType.ENTITY_PLAYER and flags == flags | DamageFlag.DAMAGE_LASER then
		elseif source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.DARK_SNARE then
			if source.Entity and source.Entity.SpawnerEntity and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER then
				local player = source.Entity.SpawnerEntity:ToPlayer()
				local secondHandMultiplier = player:GetTrinketMultiplier(TrinketType.TRINKET_SECOND_HAND) + 1
			end
		elseif source.Type == EntityType.ENTITY_FAMILIAR and source.Variant == FamiliarVariant.ABYSS_LOCUST then
			if source.Entity and source.Entity.SpawnerEntity and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER then
				local player = source.Entity.SpawnerEntity:ToPlayer()
				local secondHandMultiplier = player:GetTrinketMultiplier(TrinketType.TRINKET_SECOND_HAND) + 1
			end
		end

		local hasRerolled = false

		if source.Type == EntityType.ENTITY_TEAR then
			local sourceData = source.Entity:GetData()
			local sourceTear = source.Entity:ToTear()

			ApplyWakabaTearEffects(target, source)

		elseif source.Type == EntityType.ENTITY_BOMBDROP and flags == flags | DamageFlag.DAMAGE_EXPLOSION then
			local sourceData = source.Entity:GetData()
			
			ApplyWakabaTearEffects(target, source)

		elseif source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL then
			local sourceData = source.Entity:GetData()
			
			ApplyWakabaTearEffects(target, source)

		elseif source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.ROCKET then
			local sourceData = source.Entity:GetData()
			
			ApplyWakabaTearEffects(target, source)

		elseif source.Type == EntityType.ENTITY_KNIFE then
			local player = wakaba:getPlayerFromKnife(source.Entity)
			if player ~= nil then
			
				ApplyWakabaTearEffects(target, source, true)
	
			end
		elseif source.Type == EntityType.ENTITY_PLAYER and flags == flags | DamageFlag.DAMAGE_LASER then
			local player = source.Entity:ToPlayer()
			
			ApplyWakabaTearEffects(target, source, true)

		elseif source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.DARK_SNARE then
			if source.Entity and source.Entity.SpawnerEntity and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER then
				local player = source.Entity.SpawnerEntity:ToPlayer()
			
				ApplyWakabaTearEffects(target, source)
	
			end
		elseif source.Type == EntityType.ENTITY_FAMILIAR and source.Variant == FamiliarVariant.ABYSS_LOCUST then
			if source.Entity and source.Entity.SpawnerEntity and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER then
				local player = source.Entity.SpawnerEntity:ToPlayer()
			end
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE and source.Type == EntityType.ENTITY_DARK_ESAU then
			local returndata = wakaba:DeliveryOnDamage(source, newDamage, newFlags)
			newDamage = returndata.newDamage or newDamage
			newFlags = returndata.newFlags or newFlags
			sendNewDamage = returndata.sendNewDamage or sendNewDamage
		elseif source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.HUNGRY_SOUL then
			local player = isc:getPlayerFromEntity(source.Entity)
			if player ~= nil then
				local returndata = wakaba:BookofTheFallenOnDamage_Pugartory(player, target, source, newDamage, newFlags)
				newDamage = returndata.newDamage or newDamage
				newFlags = returndata.newFlags or newFlags
				sendNewDamage = returndata.sendNewDamage or sendNewDamage
			end
		end


		if sendNewDamage and not hasRerolled and flags & DamageFlag.DAMAGE_FIRE == 0 then
			data.wakaba_ignoreDuplicateDamage = true
			target:TakeDamage(newDamage, newFlags, source, countdown)
			data.wakaba_ignoreDuplicateDamage = nil
			return false
		end

	end
end

wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_Global)