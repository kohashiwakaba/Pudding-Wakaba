wakaba.COLLECTIBLE_NASA_LOVER = Isaac.GetItemIdByName("Nasa Lover")
wakaba.FAMILIAR_LIL_NASA = Isaac.GetEntityVariantByName("Lil Nasa")

function wakaba:Cache_NasaLover(player, cacheFlag)
	if player:HasCollectible(wakaba.COLLECTIBLE_NASA_LOVER) then
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_JACOBS
		end
	end
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.COLLECTIBLE_NASA_LOVER)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.COLLECTIBLE_NASA_LOVER)
		local tsukasa = (wakaba.state.unlock.nasalover > 0 and player:GetPlayerType() == wakaba.PLAYER_TSUKASA) and 1 or 0
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 or tsukasa > 0 then
			count = player:GetCollectibleNum(wakaba.COLLECTIBLE_NASA_LOVER) + efcount + tsukasa
		end
		player:CheckFamiliar(wakaba.FAMILIAR_LIL_NASA, count, player:GetCollectibleRNG(wakaba.COLLECTIBLE_NASA_LOVER))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_NasaLover)

function wakaba:FamiliarUpdate_NasaLover(familiar)
	local data = familiar:GetData()
	data.wakaba = data.wakaba or {}
	if familiar.Player then
		local player = familiar.Player
		if player:HasCollectible(wakaba.COLLECTIBLE_NASA_LOVER) then
			data.wakaba.nasalover = true
		else
			data.wakaba.nasalover = nil
		end
	else
		data.wakaba.nasalover = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_NasaLover)

function wakaba:TearInit_NasaLover(tear)
	if not tear:HasTearFlags(TearFlags.TEAR_JACOBS) and ((tear.Parent and tear.Parent:GetData().wakaba) or (tear.SpawnerEntity and tear.SpawnerEntity:GetData().wakaba)) then
		local pdata = (tear.Parent and tear.Parent:GetData())
		local sdata = (tear.SpawnerEntity and tear.SpawnerEntity:GetData())
		if (pdata and pdata.wakaba and pdata.wakaba.nasalover) or (sdata and sdata.wakaba and sdata.wakaba.nasalover) then
			tear:AddTearFlags(TearFlags.TEAR_JACOBS)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_LASER_INIT, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_INIT, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, wakaba.TearInit_NasaLover)


function wakaba:NPC_NasaLover(puppy)
	if not puppy.SpawnerEntity or not puppy.SpawnerEntity:ToPlayer() then return end
	local player = puppy.SpawnerEntity:ToPlayer()
	if player:HasCollectible(wakaba.COLLECTIBLE_NASA_LOVER) then
		if not puppy:HasEntityFlags(EntityFlag.FLAG_CHARM) then
			puppy:AddEntityFlags(EntityFlag.FLAG_CHARM)
		end
		if not puppy:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			puppy:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.NPC_NasaLover, EntityType.ENTITY_BLOOD_PUPPY)
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPC_NasaLover, EntityType.ENTITY_BLOOD_PUPPY)



local function fireTearNasa(player, familiar, vector, rotation)
	local fData = familiar:GetData()
	local tear_vector = nil
	--local entity = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, Vector(familiar.Position.X, familiar.Position.Y), vector, familiar)
	local entity = familiar:FireProjectile(vector)
	tear = entity:ToTear()
	tear.TearFlags = tear.TearFlags | TearFlags.TEAR_JACOBS

	local multiplier = 1
	if (player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS)) then
		multiplier = multiplier * 2
	end
	local tearDamage = 3.5
	tear.CollisionDamage = tearDamage * multiplier
	
	if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
		tear.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_KING_BABY) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_TURN_HORIZONTAL
	end

	return tear
end


function wakaba:initLilNasa(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()
	familiar.FireCooldown = 3

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")
	
end

function wakaba:updateLilNasa(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	local move_dir = player:GetMovementDirection()
	local sprite = familiar:GetSprite()
	local player_fire_direction = player:GetFireDirection()
	local autoaim = false

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
	else
		local tear_vector = wakaba.DIRECTION_VECTOR[player_fire_direction]:Normalized()
		sprite:Play(wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
		if familiar.FireCooldown <= 0 then
			fireTearNasa(player, familiar, tear_vector, 0)
	
			if player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
				familiar.FireCooldown = 5
			else
				familiar.FireCooldown = 11
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


wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.initLilNasa, wakaba.FAMILIAR_LIL_NASA)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateLilNasa, wakaba.FAMILIAR_LIL_NASA)





