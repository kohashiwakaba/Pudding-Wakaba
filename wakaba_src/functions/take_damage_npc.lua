--[[
	Base damage function from Fiend Folio
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
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
		end

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
		elseif source.Type == EntityType.ENTITY_BOMBDROP and flags == flags | DamageFlag.DAMAGE_EXPLOSION then
			local sourceData = source.Entity:GetData()
		elseif source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL then
			local sourceData = source.Entity:GetData()
		elseif source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.ROCKET then
			local sourceData = source.Entity:GetData()
		elseif source.Type == EntityType.ENTITY_KNIFE then
			local player = wakaba:getPlayerFromKnife(source.Entity)
			if player ~= nil then
			end
		elseif source.Type == EntityType.ENTITY_PLAYER and flags == flags | DamageFlag.DAMAGE_LASER then
			local player = source.Entity:ToPlayer()
		elseif source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.DARK_SNARE then
			if source.Entity and source.Entity.SpawnerEntity and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER then
				local player = source.Entity.SpawnerEntity:ToPlayer()
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