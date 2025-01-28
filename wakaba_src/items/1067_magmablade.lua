--[[
	Magma Blade (마그마 블레이드) - 패시브(Passive)
	공격력 증가
	20발 공격 시 불꽃 블레이드를 추가로 휘두름
]]

local isc = _wakaba.isc

local function canActivateMagmaBlade(player)
	return player:HasCollectible(wakaba.Enums.Collectibles.MAGMA_BLADE)	or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.MAGMA_BLADE)
end

local function getMagmaBladeMultiplier(player)
	return player:GetCollectibleNum(wakaba.Enums.Collectibles.MAGMA_BLADE) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.MAGMA_BLADE)
end

function wakaba:Cache_MagmaBlade(player, cacheFlag)
	if canActivateMagmaBlade(player) then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (getMagmaBladeMultiplier(player) * wakaba:getEstimatedDamageMult(player))
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			if player:HasWeaponType(WeaponType.WEAPON_SPIRIT_SWORD) then
				player.TearFlags = player.TearFlags | TearFlags.TEAR_BURN
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_MagmaBlade)

if REPENTOGON then
	---@param dirVec Vector
	---@param fireAmount integer
	---@param owner Entity
	---@param weapon Weapon
	function wakaba:TriggerWeaponFire_MagmaBlade(dirVec, fireAmount, owner, weapon)
		local player = owner:ToPlayer()
		if not player then return end
		if not canActivateMagmaBlade(player) then return end
		local fires = (player:GetData().w_magmaCount or 0) + fireAmount
		local parNum = math.max(20 - (getMagmaBladeMultiplier(player) * 4))

		local sub = 0
		local dmgMult = 2
		if player.TearFlags & TearFlags.TEAR_HOMING > 0 then
			sub = 1
		end
		if player.TearFlags & TearFlags.TEAR_BURN > 0 then
			dmgMult = 3
		end

		if weapon:GetWeaponType() == WeaponType.WEAPON_SPIRIT_SWORD then
			local multiParams = player:GetMultiShotParams(WeaponType.WEAPON_TEARS)
		elseif weapon:GetWeaponType() == WeaponType.WEAPON_BONE then
			local multiParams = player:GetMultiShotParams(WeaponType.WEAPON_TECH_X)
			local range = math.max(player.TearRange // 80, 1)
			local sPos = player.Position + Vector(0,0)
			for dl = 1, range do
				wakaba:scheduleForUpdate(function ()
					for i = 0, multiParams:GetNumTears() - 1 do
						local posVel = player:GetMultiShotPositionVelocity(i, WeaponType.WEAPON_TECH_X, dirVec, 1, multiParams)
						local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FIRE_JET, sub, sPos + (posVel.Velocity * dl * 40), Vector.Zero, player):ToEffect()
						effect:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
						effect.CollisionDamage = player.Damage * dmgMult
					end
				end, dl * 2)
			end
		end

		if fires >= parNum then
			fires = -fireAmount
			if weapon:GetWeaponType() == WeaponType.WEAPON_SPIRIT_SWORD then
				weapon:SetCharge(200000)
				local range = math.max(player.TearRange // 80, 1)
				local sPos = player.Position + Vector(0,0)
				for dl = 1, range do
					wakaba:scheduleForUpdate(function ()
						for i = 0, 11 do
							local addPos = Vector.FromAngle(dirVec:GetAngleDegrees() + (i * 30)) * dl * 40
							local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FIRE_JET, sub, sPos + addPos, Vector.Zero, player):ToEffect()
							effect:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
							effect.CollisionDamage = player.Damage * dmgMult
						end
					end, dl * 2)
				end
			elseif weapon:GetWeaponType() == WeaponType.WEAPON_KNIFE then
				dirVec = weapon:GetDirection()
			elseif weapon:GetWeaponType() == WeaponType.WEAPON_BONE then

			else
				wakaba:FireClub(player, player:GetFireDirection(), wakaba.ClubOptions.MagmaBlade)
			end
			local multiParams = player:GetMultiShotParams(weapon:GetWeaponType())
			for i = 0, multiParams:GetNumTears() - 1 do
				local posVel = player:GetMultiShotPositionVelocity(i, weapon:GetWeaponType(), dirVec, 1, multiParams)
				local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FIRE_WAVE, sub, player.Position, posVel.Velocity, player):ToEffect()
				effect:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
				effect.Rotation = posVel.Velocity:GetAngleDegrees()
				effect.CollisionDamage = player.Damage * dmgMult
			end
		end
		player:GetData().w_magmaCount = fires
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_TRIGGER_WEAPON_FIRED, wakaba.TriggerWeaponFire_MagmaBlade)

	---@param knife EntityKnife
	function wakaba:KnifeUpdate_MagmaBlade(knife)
		if knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer() then
			local player = knife.SpawnerEntity:ToPlayer()
			if not canActivateMagmaBlade(player) then return end
			local isFlying = knife:IsFlying()
			if isFlying and knife.FrameCount % 4 == 0 then
				local sub = 0
				local dmgMult = 0.4
				if player.TearFlags & TearFlags.TEAR_HOMING > 0 then
					sub = 1
				end
				if player.TearFlags & TearFlags.TEAR_BURN > 0 then
					dmgMult = 1
				end
				local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FIRE_JET, sub, knife.Position, Vector.Zero, player):ToEffect()
				effect:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
				effect.CollisionDamage = player.Damage * dmgMult

			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, wakaba.KnifeUpdate_MagmaBlade)

	function wakaba:NegateDamage_MagmaBlade(player, amount, flags, source, cooldown)
		if canActivateMagmaBlade(player) then
			if flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION then
				player:SetMinDamageCooldown(1)
				return false
			end
		end
	end
	wakaba:AddCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_MagmaBlade)
end

-- if appeared as TMTRAINER item