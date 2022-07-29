wakaba.COLLECTIBLE_PLASMA_BEAM = Isaac.GetItemIdByName("Plasma Beam")


function wakaba:TearInit_PlasmaBeam(tear)
	if tear
	and tear.SpawnerEntity
	and tear.SpawnerEntity:ToPlayer()
	then
		local player = tear.SpawnerEntity:ToPlayer()
		local playerEffects = player:GetEffects()
		local plasmaEffect = playerEffects:GetCollectibleEffectNum(wakaba.COLLECTIBLE_PLASMA_BEAM)
		local plasma = player:GetCollectibleNum(wakaba.COLLECTIBLE_PLASMA_BEAM)
		if plasma + plasmaEffect > 0 then
			tear:GetData().wakaba = tear:GetData().wakaba or {}
			tear:GetData().wakaba.plasma = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, wakaba.TearInit_PlasmaBeam)

function wakaba:TearUpdate_PlasmaBeam(tear)
	if tear and tear:GetData().wakaba and tear:GetData().wakaba.plasma
	then
		if tear:HasTearFlags(TearFlags.TEAR_EXPLOSIVE) then
			tear:ClearTearFlags(TearFlags.TEAR_EXPLOSIVE)
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
	if tear and tear:GetData().wakaba and tear:GetData().wakaba.plasma
	then
		if tear:GetData().wakaba.plasma_explosive then
			Game():BombExplosionEffects(tear.Position, tear.CollisionDamage, tear.TearFlags, Color.Default, tear.SpawnerEntity)
		else
			entity:TakeDamage(tear.CollisionDamage, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(tear), 0)
		end
		return true
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, wakaba.TearCollision_PlasmaBeam)

function wakaba:Cache_PlasmaBeam(player, cacheFlag)
	local playerEffects = player:GetEffects()
	local plasmaEffect = playerEffects:GetCollectibleEffectNum(wakaba.COLLECTIBLE_PLASMA_BEAM)
	local plasma = player:GetCollectibleNum(wakaba.COLLECTIBLE_PLASMA_BEAM)
	local isnotmoving = player:GetData().wakaba.isnotmoving or false
	if plasmaEffect + plasma > 0 then 
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (1 * plasma)
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (80 * plasma)
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING | TearFlags.TEAR_BURN
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_PlasmaBeam)