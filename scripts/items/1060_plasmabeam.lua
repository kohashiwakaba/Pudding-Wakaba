wakaba.COLLECTIBLE_PLASMA_BEAM = Isaac.GetItemIdByName("Plasma Beam")


function wakaba:TearInit_PlasmaBeam(tear)
	if (tear and tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer())
	or (tear and tear.Parent and tear.Parent:ToPlayer())
	then
		local player = (tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()) or (tear.Parent and tear.Parent:ToPlayer())
		local playerEffects = player:GetEffects()
		local plasmaEffect = playerEffects:GetCollectibleEffectNum(wakaba.COLLECTIBLE_PLASMA_BEAM)
		local plasma = player:GetCollectibleNum(wakaba.COLLECTIBLE_PLASMA_BEAM)
		if plasma + plasmaEffect > 0 then
			tear:GetData().wakaba = tear:GetData().wakaba or {}
			tear:GetData().wakaba.plasma = true
			local ipecacEffect = playerEffects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_IPECAC)
			local ipecac = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_IPECAC)
			if ipecac + ipecacEffect > 0 then
				tear:GetData().wakaba.plasma_ipecac = true
			end
		else
			tear:GetData().wakaba = tear:GetData().wakaba or {}
			tear:GetData().wakaba.plasma = false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, wakaba.TearInit_PlasmaBeam)
--wakaba:AddCallback(ModCallbacks.MC_POST_LASER_INIT, wakaba.TearInit_PlasmaBeam)
--wakaba:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, wakaba.TearInit_PlasmaBeam)
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_INIT, wakaba.TearInit_PlasmaBeam)
--wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, wakaba.TearInit_PlasmaBeam)
wakaba:AddCallback(ModCallbacks.MC_POST_BOMB_INIT, wakaba.TearInit_PlasmaBeam)

function wakaba:TearUpdate_PlasmaBeam(tear)
	if tear and tear:GetData().wakaba and tear:GetData().wakaba.plasma
	then
		if tear:HasTearFlags(TearFlags.TEAR_EXPLOSIVE) then
			tear:ClearTearFlags(TearFlags.TEAR_EXPLOSIVE)
			tear:GetData().wakaba.plasma_explosive = true
		end
		if tear:HasTearFlags(TearFlags.TEAR_BURN) then
			tear:ClearTearFlags(TearFlags.TEAR_BURN)
		end
		if tear.Type == EntityType.ENTITY_BOMB then
			tear:GetData().wakaba.plasma_explosive = true
		end
		if tear:GetData().wakaba.plasma_explosive and tear:IsDead() and not tear:GetData().wakaba.plasma_explosive_dead then
			Game():BombExplosionEffects(tear.Position, tear.CollisionDamage, tear.TearFlags, Color.Default, tear.SpawnerEntity)
			tear:GetData().wakaba.plasma_explosive_dead = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_PlasmaBeam)


function wakaba:TearCollision_PlasmaBeam(tear, entity, low)
	if not entity:ToNPC() then return end
	if tear and tear:GetData().wakaba and tear:GetData().wakaba.plasma
	then
		if not entity:IsEnemy() or entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) 
		then return end
		if tear:GetData().wakaba.plasma_explosive or (tear:GetData().wakaba.plasma_ipecac and tear.Type == EntityType.ENTITY_KNIFE) then
			Game():BombExplosionEffects(tear.Position, tear.CollisionDamage, tear.TearFlags | TearFlags.TEAR_BURN, Color.Default, tear.SpawnerEntity)
			if entity:IsInvincible() then
				entity:TakeDamage(tear.CollisionDamage, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(tear), 0)
			end
			if tear:GetData().wakaba.plasma_ipecac then
				tear.CollisionDamage = tear.CollisionDamage - 32
				tear:GetData().wakaba.plasma_ipecac = nil
			end
		else
			entity:TakeDamage(tear.CollisionDamage, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(tear), 0)
			entity:AddBurn(EntityRef(tear.SpawnerEntity), 123, tear.CollisionDamage)
		end
		return true
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, wakaba.TearCollision_PlasmaBeam)
wakaba:AddCallback(ModCallbacks.MC_PRE_BOMB_COLLISION, wakaba.TearCollision_PlasmaBeam)
wakaba:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, wakaba.TearCollision_PlasmaBeam)

--[[ function wakaba:TakeDamage_PlasmaBeam(entity, amount, flags, source, countdown)
	print(source.Entity.Type, source.Entity.SpawnerType)
	if entity.Type == EntityType.ENTITY_PLAYER then return end
	if entity.Type == EntityType.ENTITY_FIREPLACE then return end
	if flags & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES then return end
	if not (source.Entity:GetData().wakaba and source.Entity:GetData().wakaba.plasma_laser) then return end
	if not entity:ToNPC() then return end

	entity:TakeDamage(amount, DamageFlag.DAMAGE_IGNORE_ARMOR | DamageFlag.DAMAGE_CLONES, source, 0)
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_PlasmaBeam) ]]

function wakaba:Cache_PlasmaBeam(player, cacheFlag)
	local playerEffects = player:GetEffects()
	local plasmaEffect = playerEffects:GetCollectibleEffectNum(wakaba.COLLECTIBLE_PLASMA_BEAM)
	local plasma = player:GetCollectibleNum(wakaba.COLLECTIBLE_PLASMA_BEAM)
	local isnotmoving = player:GetData().wakaba.isnotmoving or false
	if plasmaEffect + plasma > 0 then 
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 0.6
			if player:HasWeaponType(WeaponType.WEAPON_LASER) 
			or player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) 
			or player:HasWeaponType(WeaponType.WEAPON_TECH_X) 
			or player:HasWeaponType(WeaponType.WEAPON_ROCKETS) 
			then
				player.Damage = player.Damage * 3
			end
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (80 * plasma)
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING
			if player:HasWeaponType(WeaponType.WEAPON_LASER)
			or player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) 
			or player:HasWeaponType(WeaponType.WEAPON_TECH_X) 
			or player:HasWeaponType(WeaponType.WEAPON_ROCKETS) 
			then
				player.TearFlags = player.TearFlags | TearFlags.TEAR_BURN
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_PlasmaBeam)