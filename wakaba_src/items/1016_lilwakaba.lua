
wakaba.DIRECTION_FLOAT_ANIM = {
	[Direction.NO_DIRECTION] = "FloatDown", 
	[Direction.LEFT] = "FloatLeft",
	[Direction.UP] = "FloatUp",
	[Direction.RIGHT] = "FloatRight",
	[Direction.DOWN] = "FloatDown"
}

wakaba.DIRECTION_SHOOT_ANIM = {
	[Direction.NO_DIRECTION] = "FloatShootDown",
	[Direction.LEFT] = "FloatShootRight",
	[Direction.UP] = "FloatShootUp",
	[Direction.RIGHT] = "FloatShootLeft",
	[Direction.DOWN] = "FloatShootDown"
}
wakaba.DIRECTION_SHOOT_ANIM_MURASAME = {
	[Direction.NO_DIRECTION] = "FloatShootDown",
	[Direction.LEFT] = "FloatShootLeft",
	[Direction.UP] = "FloatShootUp",
	[Direction.RIGHT] = "FloatShootRight",
	[Direction.DOWN] = "FloatShootDown"
}

wakaba.DIRECTION_VECTOR = {
	[Direction.NO_DIRECTION] = Vector(0, 0),
	[Direction.LEFT] = Vector(-10, 0),
	[Direction.UP] = Vector(0, -10),
	[Direction.RIGHT] = Vector(10, 0),
	[Direction.DOWN] = Vector(0, 10)
}

wakaba.DIRECTION_ANGLE = {
	[Direction.NO_DIRECTION] = 0,
	[Direction.LEFT] = 180,
	[Direction.UP] = -90,
	[Direction.RIGHT] = 0,
	[Direction.DOWN] = 90
}

local function fireTechWakaba(player, familiar, vector, direction)
	local fData = familiar:GetData()
	local multiplier = 0.4
	local tear_movement_vector = Vector.Zero
	if vector ~= nil then
		tear_vector = vector
	else
		tear_vector = direction
		tear_movement_vector = player:GetTearMovementInheritance(direction)
		--tear_vector = player:GetTearMovementInheritance(player:GetShootingInput():Resized(10))
	end
	if (player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS)) then
		multiplier = 0.7
	end
	local new_tear_vector = Vector(tear_vector.X, tear_vector.Y) + tear_movement_vector
	local laser = player:FireTechXLaser(familiar.Position, new_tear_vector, 0.02, familiar, multiplier)
	laser.CollisionDamage = player.Damage * multiplier
	laser.Timeout = (40 * player.ShotSpeed) // 1
	laser.TearFlags = TearFlags.TEAR_NORMAL
  laser.Variant = 2
  laser.SubType = 3
	laser.Parent = familiar
	laser.DisableFollowParent = true
	laser.Radius = math.max(math.min(30.0), 0.001)
	--laser:GetSprite().Color = Color(0.1, 0.6, 0.1, 1, 0.0332, 0.6992, 0.0603)

	if Sewn_API then
		if Sewn_API:IsSuper(fData) then
			laser.CollisionDamage = laser.CollisionDamage * 1.4
			laser.TearFlags = laser.TearFlags | TearFlags.TEAR_HOMING
			laser.Timeout = laser.Timeout * 2
			if not Sewn_API:IsUltra(fData) then
				--laser:GetSprite().Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549)
				--laser:SetColor(Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549), 0, 1, false, false)
			end
		end
		if Sewn_API:IsUltra(fData) then
			laser.CollisionDamage = laser.CollisionDamage * 1.4
			laser.Timeout = laser.Timeout * 2
			--laser:GetSprite().Color = Color(1, 2, 2, 1, 1, 1, 1)
			--laser:SetColor(Color(2, 2, 2, 1, 1, 1, 1), 0, 1, false, false)
		end
	end

	return laser
end

function wakaba:initLilWakaba(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()
	familiar.FireCooldown = 3

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")
	
end

function wakaba:updateLilWakaba(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	local move_dir = player:GetMovementDirection()
	local sprite = familiar:GetSprite()
	local player_fire_direction = player:GetFireDirection()
	local autoaim = false

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
	else
		sprite:Play(wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
		if familiar.FireCooldown <= 0 then
			local tear_vector = nil
			if Isaac.CountEnemies() > 0 then
				
				if Sewn_API then
					if Sewn_API:IsUltra(fData) then
						autoaim = true
					end
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_KING_BABY) then 
					autoaim = true 
				end
				if autoaim then
					local enemy = wakaba:findNearestEntityByPartition(familiar, EntityPartition.ENEMY)
					if enemy ~= nil and enemy.Vector ~= nil then
						tear_vector = enemy.Vector
					end
				end
			end
			--[[local entity = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, Vector(familiar.Position.X, familiar.Position.Y), tear_vector, familiar)
			tear = entity:ToTear()
			tear.Scale = 0.9

			if (player:HasCollectible(bffs)) then
				tear.CollisionDamage = 7
			end
			
			if player:HasTrinket(baby_bender) then
				tear.TearFlags = TearFlags.TEAR_HOMING
				tear.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
			end
			]]
			--print(familiar.FireCooldown)
			local laser = fireTechWakaba(player, familiar, tear_vector, wakaba.DIRECTION_VECTOR[player_fire_direction])
			
			if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
				laser.TearFlags = TearFlags.TEAR_HOMING
				--laser.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
			end

			if player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
				familiar.FireCooldown = ((player.MaxFireDelay + 2) // 2) + 1
				--familiar.FireCooldown = 5
			else
				familiar.FireCooldown = ((player.MaxFireDelay + 1) // 1) + 1
				--familiar.FireCooldown = 10
			end
		end
	end
	familiar.FireCooldown = familiar.FireCooldown - 1
	if player:GetPlayerType() == PlayerType.PLAYER_LILITH and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		familiar:RemoveFromFollowers()
		familiar:GetData().BlacklistFromLilithBR = true -- to prevent conflict with using im_tem's code
		
		local dirVec = wakaba.DIRECTION_VECTOR[player:GetHeadDirection()]
		if player:AreControlsEnabled() and
		(		 Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
			or Input.IsMouseBtnPressed(0)
		) then
			dirVec = player:GetAimDirection()
		end
		local playerpos = player.Position
		local oldpos = familiar.Position
		local newpos = playerpos + dirVec:Resized(40)
		familiar.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length() * 0.4)

	else
		familiar:FollowParent()
	end
end

function wakaba:onCacheLilWakaba(player, cacheFlag)
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.Enums.Collectibles.LIL_WAKABA)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.LIL_WAKABA)
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 then
			count = player:GetCollectibleNum(wakaba.Enums.Collectibles.LIL_WAKABA) + efcount
		end
		player:CheckFamiliar(wakaba.Enums.Familiars.LIL_WAKABA, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.LIL_WAKABA))
	end
end

function wakaba:UpgradeLilWakaba(familiar)

end

if Sewn_API then
	Sewn_API:MakeFamiliarAvailable(wakaba.Enums.Familiars.LIL_WAKABA, wakaba.Enums.Collectibles.LIL_WAKABA)
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onCacheLilWakaba)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.initLilWakaba, wakaba.Enums.Familiars.LIL_WAKABA)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateLilWakaba, wakaba.Enums.Familiars.LIL_WAKABA)
