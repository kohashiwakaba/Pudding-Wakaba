wakaba.COLLECTIBLE_PLUMY = Isaac.GetItemIdByName("Plumy")
wakaba.FAMILIAR_PLUMY = Isaac.GetEntityVariantByName("Plumy")
local cooldown = 120
local plumcount = 0
local hasPlum = false

local function CanPlumShootPlayerTears(player, fData)
	return wakaba:HasBless(player) or (Sewn_API and Sewn_API:IsSuper(fData)) or Game().Challenge == wakaba.challenges.CHALLENGE_PLUM
end

local function getPlumShootFrame(angle)
	local res = {
		Frame = "Idle",
		Offset = Vector(0, -24),
	}
	if not angle then return res end
	if angle >= 0 and angle < 60 then
		res.Frame = "ShootDownRight"
		res.Offset = Vector(13, -23)
	elseif angle >= 60 and angle <= 120 then
		res.Frame = "ShootDown"
		res.Offset = Vector(0, -23)
	elseif angle > 120 then
		res.Frame = "ShootDownLeft"
		res.Offset = Vector(-13, -24)
	elseif angle < 0 and angle > -60 then
		res.Frame = "ShootUpRight"
		res.Offset = Vector(13, -28)
	elseif angle <= -60 and angle >= -120 then
		res.Frame = "FloatUp"
		res.Offset = Vector(0, -29)
	elseif angle < -120 then
		res.Frame = "ShootUpLeft"
		res.Offset = Vector(-13, -28)
	end
	return res
end

function wakaba:initPlumBrimstoneLaser(player, familiar, multiplier, collisionsize, direction)
	local laser = player:FireBrimstone(direction, player, multiplier)
	--laser.ParentOffset = familiar.Position
	--local laser = Isaac.Spawn(EntityType.ENTITY_LASER, 1, 0)
	laser.Parent = familiar
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_LASER, 1, 1, player)
	laser.TearFlags = laser.TearFlags | TearFlags.TEAR_PIERCING | player.TearFlags | tearparams.TearFlags
	laser:SetOneHit(false)
	return laser
end


function wakaba:InitPlumMainBrimstoneLaser(player, familiar, multiplier)
	local fData = familiar:GetData()
	local laser = Isaac.Spawn(EntityType.ENTITY_LASER, 3, LaserSubType.LASER_SUBTYPE_RING_FOLLOW_PARENT, familiar.Position, Vector.Zero, familiar):ToLaser()
	laser.Parent = familiar
	laser:SetOneHit(false)
	laser.Radius = math.max(math.min(80.0), 0.001)
	laser:GetData().wakaba = {}
	laser:GetData().wakaba.plumymain = true
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_LASER, 1, 1, player)
	laser.TearFlags = laser.TearFlags | player.TearFlags | tearparams.TearFlags
	laser.CollisionDamage = player.Damage * multiplier

	return laser
end

function wakaba:initPlumSingleLaser(player, familiar, vector)
	local fData = familiar:GetData()
	local tear_vector = (Sewn_API and Sewn_API:IsUltra(fData)) and vector:Resized(13.5) or vector:Resized(8)
	local tear_angle = vector:GetAngleDegrees()
	local rng = player:GetCollectibleRNG(wakaba.COLLECTIBLE_PLUMY)
	local cornangle = (Sewn_API and Sewn_API:IsUltra(fData)) and 1 or 4
	local float = Vector(0, rng:RandomFloat() * cornangle - (cornangle / 2)):Rotated(tear_angle)
	local multiplier = 1 + (rng:RandomFloat() * 0.4 - 0.2)
	local laser = player:FireTechLaser(familiar.Position, LaserOffset.LASER_BRIMSTONE_OFFSET, tear_vector + float, true, true, player, multiplier)
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_LASER, 1, 1, player)
	laser.TearFlags = TearFlags.TEAR_SPECTRAL | player.TearFlags | tearparams.TearFlags
	
	if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		laser.TearFlags = laser.TearFlags | TearFlags.TEAR_HOMING
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_KING_BABY) then
		laser.TearFlags = laser.TearFlags | TearFlags.TEAR_TURN_HORIZONTAL
	end
	local dmg = tearparams.TearDamage * 0.4
	dmg = dmg >= 0.4 and dmg or 0.4
	laser.CollisionDamage = dmg * multiplier * ((Sewn_API and Sewn_API:IsSuper(fData)) and 1.5 or 1)
	return laser
end

local function InitPlumTear(player, familiar, vector)
	local fData = familiar:GetData()
	local tear_vector = (Sewn_API and Sewn_API:IsUltra(fData)) and vector:Resized(math.max(30 / player.MaxFireDelay, 13.5)) or vector:Resized(math.max(30 / player.MaxFireDelay, 8))
	local tear_angle = vector:GetAngleDegrees()
	local rng = player:GetCollectibleRNG(wakaba.COLLECTIBLE_PLUMY)
	local cornangle = (Sewn_API and Sewn_API:IsUltra(fData)) and 1 or 4
	local float = Vector(0, rng:RandomFloat() * cornangle - (cornangle / 2)):Rotated(tear_angle)
	local multiplier = 1 + (rng:RandomFloat() * 0.4 - 0.2)
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_TEARS, 1, 1, player)
	local entity = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, familiar.Position + getPlumShootFrame(tear_angle).Offset, tear_vector + float, familiar)
	tear = entity:ToTear()
	tear.Parent = familiar
	tear.Scale = multiplier
	tear.TearFlags = TearFlags.TEAR_SPECTRAL
	if tear_angle >= 0 then
		tear.DepthOffset = familiar.DepthOffset + 2
	else
		tear.DepthOffset = familiar.DepthOffset - 2
	end
	
	if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
		tear.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_KING_BABY) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_TURN_HORIZONTAL
	end
	
	if CanPlumShootPlayerTears(player, fData) then
		tear.TearFlags = tear.TearFlags | player.TearFlags | tearparams.TearFlags
		tear.Color = tearparams.TearColor
		if tearparams.TearVariant ~= TearVariant.BLUE and tearparams.TearVariant ~= TearVariant.BLOOD then
			tear:ChangeVariant(tearparams.TearVariant)
		end
	end
	if (Sewn_API and Sewn_API:IsUltra(fData)) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOUNCE
	end

	local dmg = tearparams.TearDamage * 0.4
	dmg = dmg >= 0.4 and dmg or 0.4
	tear.CollisionDamage = dmg * multiplier * ((Sewn_API and Sewn_API:IsSuper(fData)) and 1.5 or 1)

	tear:GetData().wakaba = {
		plum = true,
		plumdamage = dmg * multiplier,
	}
	return tear
end

function wakaba:initPlumKnife(player, familiar, vector)
	local fData = familiar:GetData()
	local tear_vector = (Sewn_API and Sewn_API:IsUltra(fData)) and vector:Resized(13.5) or vector:Resized(8)
	local tear_angle = vector:GetAngleDegrees()
	local rng = player:GetCollectibleRNG(wakaba.COLLECTIBLE_PLUMY)
	local cornangle = (Sewn_API and Sewn_API:IsUltra(fData)) and 1 or 4
	local randcornangle = rng:RandomFloat() * cornangle - (cornangle / 2)
	local float = Vector(0, randcornangle):Rotated(tear_angle)
	local multiplier = 1 + (rng:RandomFloat() * 0.4 - 0.2)
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_KNIFE, 1, 1, player)
	--local entity = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, familiar.Position + getPlumShootFrame(tear_angle).Offset, tear_vector + float, familiar)
	local knife = player:FireKnife(familiar, 0, false, 2):ToKnife()
	knife:AddEntityFlags(EntityFlag.FLAG_INTERPOLATION_UPDATE)
	knife.Parent = familiar
	knife.Position = familiar.Position + getPlumShootFrame(tear_angle).Offset
	knife.TargetPosition = player.Position
	knife:GetSprite().Rotation = tear_angle + randcornangle - 90
	knife.Velocity = tear_vector + float
	knife:GetData().wakaba = {}
	knife:GetData().wakaba.isplum = true
	knife:GetData().wakaba.plumvel = (tear_vector + float) * Vector(player.ShotSpeed * 1.5, player.ShotSpeed * 1.5)
	
	if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		knife.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
		knife.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_KING_BABY) then
		knife.TearFlags = tear.TearFlags | TearFlags.TEAR_TURN_HORIZONTAL
	end
	
	if CanPlumShootPlayerTears(player, fData) then
		knife.TearFlags = knife.TearFlags | player.TearFlags | tearparams.TearFlags
		knife.Color = tearparams.TearColor
	end
	if (Sewn_API and Sewn_API:IsUltra(fData)) then
		knife.TearFlags = knife.TearFlags | TearFlags.TEAR_BOUNCE
	end

	local dmg = tearparams.TearDamage * 0.4
	dmg = dmg >= 0.4 and dmg or 0.4
	knife.CollisionDamage = dmg * multiplier * ((Sewn_API and Sewn_API:IsSuper(fData)) and 1.5 or 1)

	return knife
end


function wakaba:FamiliarInit_Plumy(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()
	familiar.FireCooldown = 3
	familiar:GetData().wakaba = {}
	familiar:GetData().wakaba.plumhealth = 200000
	familiar:GetData().wakaba.plumrecover = false
	--familiar.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ENEMIES

	local sprite = familiar:GetSprite()
	sprite:Play("Idle")
	
end

function wakaba:FamiliarUpdate_Plumy(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	local move_dir = player:GetMovementDirection()
	local sprite = familiar:GetSprite()
	local player_fire_direction = player:GetFireDirection()
	local autoaim = false
	local recovertime = 10
	recovertime = (Sewn_API and Sewn_API:IsSuper(fData)) and 8 or recovertime
	recovertime = (Sewn_API and Sewn_API:IsUltra(fData)) and 5 or recovertime

	
	if fData.wakaba.plumhealth <= 0 and not fData.wakaba.plumrecover then
		fData.wakaba.plumrecover = true
		familiar.Velocity = Vector.Zero
		sprite:Play("RecoverStart", true)
		SFXManager():Play(SoundEffect.SOUND_MEAT_JUMPS)
		sprite:Update()
	elseif sprite:IsPlaying("RecoverEnd") then
		familiar.Velocity = Vector.Zero
	elseif sprite:IsFinished("RecoverEnd") then
		fData.wakaba.plumrecover = false
		familiar:FollowParent()
		sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
		sprite:Update()
	elseif sprite:IsFinished("RecoverStart") then
		familiar.Velocity = Vector.Zero
		sprite:Play("RecoverLoop", true)
		sprite:Update()
	elseif fData.wakaba.plumrecover then
		local recoverrate = 200000 / (30 * recovertime)
		local threshold = 200000
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
			recoverrate = 300000 / (30 * recovertime)
			threshold = 300000
		end
		familiar.HitPoints = familiar.MaxHitPoints
		if fData.wakaba.plumhealth < threshold then
			fData.wakaba.plumhealth = fData.wakaba.plumhealth + recoverrate
		else
			sprite:Play("RecoverEnd", true)
			SFXManager():Play(SoundEffect.SOUND_THUMBSUP)
			sprite:Update()
		end
	elseif player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
		fData.wakaba.plumlaser = nil
		fData.wakaba.plumybrlaser = nil
		familiar:FollowParent()
	else

		local dirVec = wakaba.DIRECTION_VECTOR[player:GetHeadDirection()]
		if player:AreControlsEnabled() and
		(		 Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
			or Input.IsMouseBtnPressed(0)
		) then
			familiar:RemoveFromFollowers()
			dirVec = player:GetAimDirection()
			sprite:Play(getPlumShootFrame(dirVec:GetAngleDegrees()).Frame, false)
			local playerpos = player.Position
			local oldpos = familiar.Position
			local newpos = playerpos + dirVec:Resized(60)
			familiar.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length() * 0.4)
			
			if player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) then
				if not fData.wakaba.plumybrlaser then
					fData.wakaba.plumybrlaser = wakaba:InitPlumMainBrimstoneLaser(player, familiar, 0.88)
				end
				local laser = fData.wakaba.plumybrlaser
				laser.Timeout = laser.Timeout + 1
				laser.ParentOffset = Vector(0,-40)
			end
			
			--[[ if not fData.wakaba.plumlaser then
				fData.wakaba.plumlaser = wakaba:initPlumBrimstoneLaser(player, familiar, 0.3, collisionsize, dirVec)
			end
			fData.wakaba.plumlaser.Timeout = fData.wakaba.plumlaser.Timeout + 1
			print(fData.wakaba.plumlaser.ParentOffset, fData.wakaba.plumlaser.Position, newpos)
			fData.wakaba.plumlaser.AngleDegrees = dirVec:GetAngleDegrees() ]]
			if familiar.FireCooldown <= 0 then
				
				local nontear = false
				if CanPlumShootPlayerTears(player, fData) then
					if player:HasWeaponType(WeaponType.WEAPON_KNIFE) or player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
						wakaba:initPlumKnife(player, familiar, dirVec:Resized(math.min(30 / player.MaxFireDelay, 1)))
						nontear = true
					end
					if player:HasWeaponType(WeaponType.WEAPON_TECH_X) or player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) then
						wakaba:initPlumSingleLaser(player, familiar, dirVec)
						nontear = true
						--nontear = true
					end
					if player:HasWeaponType(WeaponType.WEAPON_LASER) or player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) then
						wakaba:initPlumSingleLaser(player, familiar, dirVec)
						nontear = true
					end

				end
				if nontear ~= true then
					InitPlumTear(player, familiar, dirVec)
				end
				familiar.FireCooldown = math.min(player.MaxFireDelay // 1,(Sewn_API and Sewn_API:IsSuper(fData)) and 2 or 4)
			else
				familiar.FireCooldown = familiar.FireCooldown - 1
			end

		else
			fData.wakaba.plumlaser = nil
			fData.wakaba.plumybrlaser = nil
			familiar:FollowParent()
		end

	end


end

function wakaba:FamiliarCollision_Plumy(familiar, entity, bool)
	if (entity:IsEnemy() or entity:ToProjectile()) and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
		if entity:ToProjectile() and not entity:ToProjectile():HasProjectileFlags(ProjectileFlags.CANT_HIT_PLAYER) then
			if not familiar:GetData().wakaba.plumrecover then
				--familiar:GetData().wakaba.plumhealth = familiar:GetData().wakaba.plumhealth - (entity.CollisionDamage * 1000)
			end
			--print(familiar:GetData().wakaba.plumhealth)
			entity:Die()
		end
		familiar:TakeDamage(entity.CollisionDamage, 0, EntityRef(entity), 0)
	end
	--if entity:ToLaser() and (entity.SpawnerEntity and entity.SpawnerEntity:IsEnemy())
end


--[[ 

wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, function(_, e)
	--print(e.State)
	hasPlum = false
  for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.COLLECTIBLE_PLUMY) then
			hasPlum = true
		end
		if wakaba:HasBless(player) then
			wakaba.state.hasbless = true
		end
  end
	
  if hasPlum then
		--print("Plum Update ", npc.State)
		if e.State == 7 then
			e.State = 4
		end
		
  end
end, FamiliarVariant.BABY_PLUM)

function wakaba:NewRoom_Plumy()
  for i = 0, Game():GetNumPlayers()-1 do
    local player = Isaac.GetPlayer(i)
		if player:HasCollectible(wakaba.COLLECTIBLE_PLUMY) then
			player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
			player:EvaluateItems()
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Plumy)

wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, function(_, tear)
	if Game().Challenge == wakaba.challenges.CHALLENGE_PLUM
	or wakaba.state.hasbless
	then
		if hasPlum
		and tear.SpawnerType == EntityType.ENTITY_FAMILIAR
		and tear.SpawnerVariant == FamiliarVariant.BABY_PLUM then
			if wakaba.state.hasbless then
				tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
				tear:SetColor(Color(0.3, 0, 0.4, 1, 0.3, 0, 0.5), -1, 1, true, false)
			end
			if Game().Challenge == wakaba.challenges.CHALLENGE_PLUM then
				local stage = Game():GetLevel():GetAbsoluteStage()
				if stage >= 3 then tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PIERCING end
				if stage >= 5 then tear.TearFlags = tear.TearFlags | TearFlags.TEAR_JACOBS end
				if stage >= 7 then tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING end
				if stage >= 12 then tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LIGHT_FROM_HEAVEN end
				for i = 1, Game():GetNumPlayers() do
					local player = Isaac.GetPlayer(i - 1)
					tear:SetColor(player.TearColor, -1, 1, false, false)
					tear.TearFlags = tear.TearFlags | player.TearFlags
					tear.CollisionDamage = tear.CollisionDamage + player.Damage
				end
			end
		end
	end
end)
]]

function wakaba:KnifeUpdate_Plumy(knife)
	if not knife:GetData().wakaba then return end
	if not knife:GetData().wakaba.isplum then return end
	if not knife:GetData().wakaba.plumvel then return end
	knife.Velocity = knife:GetData().wakaba.plumvel
end
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, wakaba.KnifeUpdate_Plumy)

function wakaba:TakeDamage_Plumy(familiar, damage, flags, source, cooldown)
	--print("Plum took dmg")
	if familiar.Variant ~= wakaba.FAMILIAR_PLUMY then return end
	if not familiar:GetData().wakaba then return end
	if familiar:GetData().wakaba.plumrecover then return false end
	familiar:GetData().wakaba.plumhealth = familiar:GetData().wakaba.plumhealth - (damage * 1000)
	if familiar:GetData().wakaba.plumhealth <= 0 or familiar.HitPoints <= damage then
		return false
	end
	--print(familiar.HitPoints)
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_Plumy, EntityType.ENTITY_FAMILIAR)

function wakaba:Cache_Plumy(player, cacheFlag)
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.COLLECTIBLE_PLUMY)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.COLLECTIBLE_PLUMY)
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 then
			count = player:GetCollectibleNum(wakaba.COLLECTIBLE_PLUMY) + efcount
		end
		player:CheckFamiliar(wakaba.FAMILIAR_PLUMY, count, player:GetCollectibleRNG(wakaba.COLLECTIBLE_PLUMY))
	end
end

if Sewn_API then
	Sewn_API:MakeFamiliarAvailable(wakaba.FAMILIAR_PLUMY, wakaba.COLLECTIBLE_PLUMY)
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Plumy)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.FamiliarInit_Plumy, wakaba.FAMILIAR_PLUMY)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_Plumy, wakaba.FAMILIAR_PLUMY)
wakaba:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, wakaba.FamiliarCollision_Plumy, wakaba.FAMILIAR_PLUMY)