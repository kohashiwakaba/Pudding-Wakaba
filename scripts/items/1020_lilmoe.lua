wakaba.COLLECTIBLE_LIL_MOE = Isaac.GetItemIdByName("Lil Moe")
wakaba.FAMILIAR_LIL_MOE = Isaac.GetEntityVariantByName("Lil Moe")

local function fireTearMoe(player, familiar, vector, rotation)
	local fData = familiar:GetData()
	local tear_vector = nil
	local randomTearFlag = wakaba.RNG:RandomInt(TearFlags.TEAR_EFFECT_COUNT - 2) + 1
	while (randomTearFlag == 12 or randomTearFlag == 0 or randomTearFlag == 61 or randomTearFlag == 22 or randomTearFlag == 69 or randomTearFlag == 80
			or randomTearFlag == 28 or randomTearFlag == 29 or randomTearFlag == 35 or randomTearFlag == 36 or randomTearFlag == 37 or randomTearFlag == 45 
			or randomTearFlag == 72 or randomTearFlag == 75 or randomTearFlag == 78) do
		randomTearFlag = wakaba.RNG:RandomInt(TearFlags.TEAR_EFFECT_COUNT - 2) + 1
	end
	local randomTearVariant = wakaba.RNG:RandomInt(49)
	while (randomTearVariant == 4 or randomTearVariant == 5 or randomTearVariant == 9 or randomTearVariant == 19 or randomTearVariant == 45) do
		randomTearVariant = wakaba.RNG:RandomInt(49)
	end
	local entity = Isaac.Spawn(EntityType.ENTITY_TEAR, randomTearVariant, 0, Vector(familiar.Position.X, familiar.Position.Y), vector, familiar)
	tear = entity:ToTear()
	tear.Scale = 0.9
	tear.TearFlags = TearFlags.TEAR_HOMING | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_ORBIT_ADVANCED | wakaba.TEARFLAG(randomTearFlag)
	tear.FallingSpeed = 0
	tear.FallingAcceleration = -0.1

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
	if player:HasCollectible(CollectibleType.COLLECTIBLE_KING_BABY) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_TURN_HORIZONTAL
	end
	
	if Sewn_API then
		local secondTearFlag = wakaba.RNG:RandomInt(TearFlags.TEAR_EFFECT_COUNT - 2) + 1
		if Sewn_API:IsSuper(fData) then
			tear.CollisionDamage = tear.CollisionDamage * 2
			while (secondTearFlag == 12 or secondTearFlag == 0 or secondTearFlag == 61 or secondTearFlag == 22 or secondTearFlag == randomTearFlag) do
				secondTearFlag = wakaba.RNG:RandomInt(TearFlags.TEAR_EFFECT_COUNT - 2) + 1
			end
			tear.TearFlags = tear.TearFlags | wakaba.TEARFLAG(secondTearFlag)
		end
		if Sewn_API:IsUltra(fData) then
			tear.CollisionDamage = tear.CollisionDamage * 2
			local thirdTearFlag = wakaba.RNG:RandomInt(TearFlags.TEAR_EFFECT_COUNT - 2) + 1
			while (thirdTearFlag == 12 or thirdTearFlag == 0 or thirdTearFlag == 61 or thirdTearFlag == 22 or thirdTearFlag == randomTearFlag or thirdTearFlag == secondTearFlag) do
				thirdTearFlag = wakaba.RNG:RandomInt(TearFlags.TEAR_EFFECT_COUNT - 2) + 1
			end
			tear.TearFlags = tear.TearFlags | wakaba.TEARFLAG(thirdTearFlag)
			tear.Color = Color(1, 2, 2, 1, 1, 1, 1)
			--laser:SetColor(Color(2, 2, 2, 1, 1, 1, 1), 0, 1, false, false)
		end
	end

	return tear
end

function wakaba:initLilMoe(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()
	familiar.FireCooldown = 3

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")
	
end

function wakaba:updateLilMoe(familiar)
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
			fireTearMoe(player, familiar, Vector(0, player.ShotSpeed * 10), 0)
	
			if player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
				familiar.FireCooldown = player.MaxFireDelay * 1.25 // 1
			else
				familiar.FireCooldown = player.MaxFireDelay * 2.5 // 1
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

function wakaba:onCacheLilMoe(player, cacheFlag)
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.COLLECTIBLE_LIL_MOE)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.COLLECTIBLE_LIL_MOE)
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 then
			count = player:GetCollectibleNum(wakaba.COLLECTIBLE_LIL_MOE) + efcount
		end
		player:CheckFamiliar(wakaba.FAMILIAR_LIL_MOE, count, player:GetCollectibleRNG(wakaba.COLLECTIBLE_LIL_MOE))
	end
end

function wakaba:UpgradeLilMoe(familiar)

end

if Sewn_API then
	Sewn_API:MakeFamiliarAvailable(wakaba.FAMILIAR_LIL_MOE, wakaba.COLLECTIBLE_LIL_MOE)
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onCacheLilMoe)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.initLilMoe, wakaba.FAMILIAR_LIL_MOE)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateLilMoe, wakaba.FAMILIAR_LIL_MOE)
