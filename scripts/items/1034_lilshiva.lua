wakaba.COLLECTIBLE_LIL_SHIVA = Isaac.GetItemIdByName("Lil Shiva")
wakaba.FAMILIAR_LIL_SHIVA = Isaac.GetEntityVariantByName("Lil Shiva")

local function fireTearShiva(player, familiar, vector, rotation)
	local fData = familiar:GetData()
	local tear_vector = nil
	--local entity = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, Vector(familiar.Position.X, familiar.Position.Y), vector, familiar)
	local entity = familiar:FireProjectile(vector)
	tear = entity:ToTear()
	if player:HasCollectible(CollectibleType.COLLECTIBLE_C_SECTION) then
		tear:ChangeVariant(50) -- there are no TearVarinat.FETUS
	else
		tear:ChangeVariant(TearVariant.HUNGRY)
	end
	tear.Scale = 0.9
	tear.TearFlags = TearFlags.TEAR_PIERCING | TearFlags.TEAR_ABSORB
	--tear.FallingSpeed = 0
	--tear.FallingAcceleration = -0.1

	local multiplier = 1
	if (player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS)) then
		multiplier = multiplier * 2
	end
	local tearDamage = player.Damage
	if tearDamage < 4 then
		tearDamage = 4
	end
	tear.CollisionDamage = tearDamage * multiplier
	
	if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
		tear.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
	end

	if Sewn_API then
		if Sewn_API:IsUltra(fData) then
			tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BELIAL
			tear.CollisionDamage = tearDamage * 2
		end
	end

	return tear
end

function wakaba:initLilShiva(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()
	familiar.FireCooldown = 3

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")
	
end

function wakaba:updateLilShiva(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	local move_dir = player:GetMovementDirection()
	local sprite = familiar:GetSprite()
	local player_fire_direction = player:GetFireDirection()
	local autoaim = false
	local targetoffset = 5
	
	if Sewn_API then
		if Sewn_API:IsSuper(fData) then
			targetoffset = targetoffset + 2
		end
		if Sewn_API:IsUltra(fData) then
			targetoffset = targetoffset + 1
		end
	end

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
		if familiar.FireCooldown <= 0 then
			familiar.FireCooldown = 0
		end
	else
		local tear_vector = wakaba.DIRECTION_VECTOR[player_fire_direction]:Normalized()
		sprite:Play(wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
		if familiar.FireCooldown <= 0 then
			fireTearShiva(player, familiar, tear_vector, 0)
			if familiar.FireCooldown <= (targetoffset * -1) then
				if player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
					familiar.FireCooldown = 12
				else
					familiar.FireCooldown = 24
				end
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

function wakaba:onCacheLilShiva(player, cacheFlag)
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.COLLECTIBLE_LIL_SHIVA)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.COLLECTIBLE_LIL_SHIVA)
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 then
			count = player:GetCollectibleNum(wakaba.COLLECTIBLE_LIL_SHIVA) + efcount
		end
		player:CheckFamiliar(wakaba.FAMILIAR_LIL_SHIVA, count, player:GetCollectibleRNG(wakaba.COLLECTIBLE_LIL_SHIVA))
	end
end

function wakaba:UpgradeLilShiva(familiar)

end

if Sewn_API then
	Sewn_API:MakeFamiliarAvailable(wakaba.FAMILIAR_LIL_SHIVA, wakaba.COLLECTIBLE_LIL_SHIVA)
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onCacheLilShiva)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.initLilShiva, wakaba.FAMILIAR_LIL_SHIVA)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateLilShiva, wakaba.FAMILIAR_LIL_SHIVA)
