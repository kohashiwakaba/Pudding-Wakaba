local isc = _wakaba.isc
wakaba.SUBTYPE_LIL_MAO = 93

function wakaba:InitMaoLaser(player, familiar, multiplier)
	local multiplier = multiplier or 0.4
	--local laser = player:FireTechXLaser(familiar.Position, Vector.Zero, 80, familiar, multiplier)
	local laser = Isaac.Spawn(EntityType.ENTITY_LASER, 3, LaserSubType.LASER_SUBTYPE_RING_FOLLOW_PARENT, familiar.Position, Vector.Zero, familiar):ToLaser()
	laser.CollisionDamage = player.Damage * multiplier
	laser.Timeout = 60000
	laser.TearFlags = TearFlags.TEAR_NORMAL | TearFlags.TEAR_SPECTRAL
	laser.Parent = familiar
	laser.Radius = math.max(math.min(80.0), 0.001)
	laser:GetData().wakaba = {}
	laser:GetData().wakaba.lilmao = true
	laser:GetSprite().Color = Color(0.6, 0.1, 0.2, 1, 0.6992, 0.2033, 0.6992)

	return laser
end

function wakaba:LaserUpdate_LilMao(laser)
	laser:GetData().wakaba = laser:GetData().wakaba or {}
	local parent = laser.Parent
	if not parent or not laser:GetData().wakaba.lilmao then
		return
	end
	if not parent:ToFamiliar() then return end
	if not (parent.Variant == FamiliarVariant.CUBE_BABY and parent.SubType == wakaba.SUBTYPE_LIL_MAO) then return end
	if not parent:Exists() and laser:GetData().wakaba.lilmao then laser:Die() return end
	--print(laser.Variant, laser.SubType)
	laser.Timeout = 60000
	local multiplier = 0.4
	if parent:ToFamiliar().Player then
		local player = parent:ToFamiliar().Player
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
			multiplier = multiplier * 2
		end
		if player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
			multiplier = multiplier * 2
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_KING_BABY) or player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
			laser:AddTearFlags(TearFlags.TEAR_HOMING)
		else
			laser:ClearTearFlags(TearFlags.TEAR_HOMING)
		end
		laser.CollisionDamage = player.Damage * multiplier
	end
	--laser.Position = parent.Position
end

function wakaba:initLilMao(familiar)
	if familiar.SubType ~= wakaba.SUBTYPE_LIL_MAO then return end
	familiar.FireCooldown = 5
	familiar.GridCollisionClass = familiar.GridCollisionClass - GridCollisionClass.COLLISION_PIT
end

function wakaba:updateLilMao(familiar)
	if familiar.SubType ~= wakaba.SUBTYPE_LIL_MAO then return end
	--if familiar.State
	familiar:GetData().wakaba = familiar:GetData().wakaba or {}
	local player = familiar.Player
	if familiar.FireCooldown > 0 then
		familiar.FireCooldown = familiar.FireCooldown - 1
	end

	if not familiar:GetData().wakaba.laser or (familiar:GetData().wakaba.laser and not familiar:GetData().wakaba.laser:Exists()) then
		familiar:GetData().wakaba.laser = wakaba:InitMaoLaser(familiar.Player, familiar)
	end
	if player:HasTrinket(TrinketType.TRINKET_RC_REMOTE) then
	end

	if familiar:GetData().wakaba.recall then
		familiar:GetData().wakaba.recall = familiar:GetData().wakaba.recall + 1
		local pos = familiar.Position
		local playerpos = player.Position
		local velocity = familiar:GetData().wakaba.recall
		familiar.Velocity = (playerpos - pos):Normalized():Resized(velocity)
		--print(pos, playerpos, (playerpos - pos), familiar.Velocity)
	elseif player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		local target = wakaba:findNearestEntityByPartition(familiar, EntityPartition.ENEMY)
		if target and target.Entity then

			local targpos = target.Entity.Position
			local velocity = (targpos - familiar.Position) / 2
			velocity = velocity:Resized(math.min(velocity:Length(), 10))
			familiar.Velocity = isc:lerp(familiar.Velocity, velocity, 0.05)
		end
	end
end

function wakaba:NewRoom_LilMao()
	local maos = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.CUBE_BABY, wakaba.SUBTYPE_LIL_MAO)
	for i, f in ipairs(maos) do
		local mao = f:ToFamiliar()
		if mao and mao.Player then
			mao.Position = Isaac.GetFreeNearPosition(mao.Position, 32)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_LilMao)

function wakaba:onCacheLilMao(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.LIL_MAO) then
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + (0.15 * player:GetCollectibleNum(wakaba.Enums.Collectibles.LIL_MAO))
		end
	end
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.Enums.Collectibles.LIL_MAO)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.LIL_MAO)
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 then
			count = player:GetCollectibleNum(wakaba.Enums.Collectibles.LIL_MAO) + efcount
		end
		player:CheckFamiliar(FamiliarVariant.CUBE_BABY, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.LIL_MAO), Isaac.GetItemConfig():GetCollectible(wakaba.Enums.Collectibles.LIL_MAO), wakaba.SUBTYPE_LIL_MAO)
	end
end

function wakaba:UpgradeLilMao(familiar)

end

function wakaba:PreCollision_LilMao(familiar, entity, bool)
	if familiar.SubType ~= wakaba.SUBTYPE_LIL_MAO then return end
	if entity:ToProjectile() then
		entity:Die()
		return true
	end
	if not entity:ToPlayer() then return end

	local player = entity:ToPlayer()
	if player:HasTrinket(TrinketType.TRINKET_RC_REMOTE) then
		--return true
	end
	if not player:IsHoldingItem() then
		if familiar.FireCooldown <= 0 then
			player:TryHoldEntity(familiar)
			if familiar:GetData().wakaba and familiar:GetData().wakaba.recall then
				familiar:GetData().wakaba.recall = nil
			end
		end
		return true
	end

end




wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onCacheLilMao)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.initLilMao, FamiliarVariant.CUBE_BABY)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateLilMao, FamiliarVariant.CUBE_BABY)
wakaba:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, wakaba.PreCollision_LilMao, FamiliarVariant.CUBE_BABY)


wakaba:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, wakaba.LaserUpdate_LilMao)
