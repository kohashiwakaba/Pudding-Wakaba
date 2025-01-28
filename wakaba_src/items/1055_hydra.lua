local HYDRA_CENTER = 0
local HYDRA_LEFT = 1
local HYDRA_RIGHT = 2
local isc = _wakaba.isc

local HydraState = {
	IDLE = 0,
	DASHING = 10,
	CHARGING = 20,
	SHOOTING = 21,
}

function wakaba:Cache_Hydra(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.HYDRA) then
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_POISON
		end
	end
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.Enums.Collectibles.HYDRA)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.HYDRA)
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 then
			count = player:GetCollectibleNum(wakaba.Enums.Collectibles.HYDRA) + efcount
		end
		player:CheckFamiliar(wakaba.Enums.Familiars.HYDRA, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.HYDRA), nil, HYDRA_LEFT)
		player:CheckFamiliar(wakaba.Enums.Familiars.HYDRA, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.HYDRA), nil, HYDRA_RIGHT)
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Hydra)

function wakaba:FamiliarInit_Hydra(familiar)
	familiar.FireCooldown = 42
	familiar.State = HydraState.IDLE

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")

end

wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.FamiliarInit_Hydra, wakaba.Enums.Familiars.HYDRA)

function wakaba:FamiliarUpdate_Hydra(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	local move_dir = player:GetMovementDirection()
	local sprite = familiar:GetSprite()
	local player_fire_direction = player:GetFireDirection()
	local autoaim = false

	familiar.FireCooldown = familiar.FireCooldown - 1
	if not familiar.Target then
		familiar:PickEnemyTarget(120, 13, 16, Vector.Zero, 15)
	end

	if familiar.FireCooldown <= 0 then
		if familiar.State == HydraState.IDLE then
			familiar.FireCooldown = 42
			familiar:PickEnemyTarget(120, 13, 16, Vector.Zero, 15)
			familiar.State = HydraState.DASHING
		elseif familiar.State == HydraState.DASHING then
			if player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
				familiar.FireCooldown = 15
				--Fire Brimstone
				familiar.State = HydraState.SHOOTING
			else
				familiar.FireCooldown = 42
				familiar.State = HydraState.CHARGING
			end
		elseif familiar.State == HydraState.CHARGING then
			familiar.FireCooldown = 15
			familiar.State = HydraState.SHOOTING
		elseif familiar.State == HydraState.SHOOTING then
			familiar.State = HydraState.IDLE
		end
	end

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


	-- idle : move at least once
	-- 2 patterns - dash, brimstone
	-- pattern 1 : dash towards into enemies
	-- pattern 2-1 : charge
	-- pattern 2-2 : fire poison brimstone
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_Hydra)








