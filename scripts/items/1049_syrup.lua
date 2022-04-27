wakaba.COLLECTIBLE_SYRUP = Isaac.GetItemIdByName("Syrup")
wakaba.FAMILIAR_SYRUP = Isaac.GetEntityVariantByName("Syrup")


function wakaba:initSyrup(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()
	familiar.FireCooldown = 3

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")
	
end

function wakaba:updateSyrup(familiar)
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
					local enemy = wakaba:findNearestEntity(familiar, EntityPartition.ENEMY)
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
				laser.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
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

function wakaba:onCacheSyrup(player, cacheFlag)
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		if player:HasCollectible(wakaba.COLLECTIBLE_LIL_WAKABA) or player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_MONSTER_MANUAL) > 0 then
			local monstermanual = player:GetEffects():GetCollectibleEffectNum(wakaba.COLLECTIBLE_LIL_WAKABA)
			count = player:GetCollectibleNum(wakaba.COLLECTIBLE_LIL_WAKABA) + monstermanual
		end
		player:CheckFamiliar(wakaba.FAMILIAR_LIL_WAKABA, count, player:GetCollectibleRNG(wakaba.COLLECTIBLE_LIL_WAKABA))
	end
end

function wakaba:UpgradeSyrup(familiar)

end

if Sewn_API then
	Sewn_API:MakeFamiliarAvailable(wakaba.FAMILIAR_LIL_WAKABA, wakaba.COLLECTIBLE_LIL_WAKABA)
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onCacheSyrup)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.initSyrup, wakaba.FAMILIAR_LIL_WAKABA)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateSyrup, wakaba.FAMILIAR_LIL_WAKABA)
