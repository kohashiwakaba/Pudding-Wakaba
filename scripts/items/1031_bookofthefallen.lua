local function calculateLength(player, r, i)
	local x, y = player.Position.X, player.Position.Y
  local angle = i * math.pi / 180
  local ptx, pty = x + r * math.cos( angle ), y + r * math.sin( angle )
	return Vector(ptx, pty)
end

function wakaba:initSingleFire(entity, player, pos)
	--EffectVariant.CRACK_THE_SKY
	local laser = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FIRE_JET, 1, pos, Vector.Zero, player):ToEffect()
	laser.Parent = player
	laser.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ENEMIES
	laser.CollisionDamage = (player.Damage) + 35
	laser:GetData().wakaba = {}
	laser:GetData().wakaba.fallengod = true
	return laser
end

function wakaba:TakeDmg_Fire(entity, amount, flag, source, countdownFrames)
	if entity.Type == EntityType.ENTITY_PLAYER then
		if source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.FIRE_JET then
			local w = source.Entity:GetData().wakaba
			if w and w.fallengod then
				return false 
			end
		end
	else
		if source.Type == EntityType.ENTITY_EFFECT and source.Variant == EffectVariant.FIRE_JET then
			local w = source.Entity:GetData().wakaba
			if w and w.fallengod then
				if flag & DamageFlag.DAMAGE_FIRE == DamageFlag.DAMAGE_FIRE then
					flag = flag - DamageFlag.DAMAGE_FIRE
					entity:TakeDamage(amount, flag, source, countdownFrames)
					return false
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_Fire)

function wakaba:InitFireEffect(entity, player)
	wakaba:initSingleFire(entity, player, entity.Position)
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 30.0, 0))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 30.0, 45))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 30.0, 90))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 30.0, 135))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 30.0, 180))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 30.0, 225))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 30.0, 270))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 30.0, 315))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 90.0, 0))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 90.0, 45))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 90.0, 90))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 90.0, 135))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 90.0, 180))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 90.0, 225))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 90.0, 270))
	--wakaba:initSingleFire(entity, player, calculateLength(entity, 90.0, 315))
end

function wakaba:AfterRevival_BookOfTheFallen(player)
  local data = player:GetData()
  data.wakaba = data.wakaba or {}
	player:AddBrokenHearts(-18)
	player:AddMaxHearts(-24)
	player:AddBoneHearts(-12)
	player:AddSoulHearts(-24)
	player:AddCostume(Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LORD_OF_THE_PIT), false)
	player:AddCostume(Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_FATE), false)

	local Poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector.Zero, player):ToEffect()
	Poof.SpriteScale = Vector(1.5, 1.5)
	data.wakaba.shioridevil = true
	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FLYING | CacheFlag.CACHE_TEARFLAG)
	player:AddBlackHearts(12)

	player:EvaluateItems()
end

function wakaba:PlayerUpdate_BookOfTheFallen()
	for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.fallenangelfirecount = player:GetData().wakaba.fallenangelfirecount or -1
		if player:GetData().wakaba.fallenangelfirecount > -1 then
			player:GetData().wakaba.fallenangelfirecount = player:GetData().wakaba.fallenangelfirecount - 1
			if player:GetData().wakaba.fallenangelfirecount % 15 == 0 then

				local enemies = Isaac.FindInRadius(wakaba.GetGridCenter(), 3000, EntityPartition.ENEMY)
				local validEnemies = {}
				
				for _, entity in ipairs(enemies) do
					if entity:IsEnemy() 
					and entity.Type ~= EntityType.ENTITY_FIREPLACE
					and not entity:IsInvincible()
					and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY)
					then
						--table.insert(wakaba.conquestready, EntityRef(entity))
						table.insert(validEnemies, EntityRef(entity))
					end
				end
			
				if #validEnemies > 0 then
					local selectedEnemy = validEnemies[wakaba.RNG:RandomInt(#validEnemies) + 1]
					wakaba:InitFireEffect(selectedEnemy.Entity, player)
					SFXManager():Play(SoundEffect.SOUND_KNIFE_PULL, 1.5, 2, false, 1.5, 0)
				else
					wakaba:InitFireEffect(player, player)
					SFXManager():Play(SoundEffect.SOUND_KNIFE_PULL, 1.5, 2, false, 1.5, 0)
				end
			
			end
		end
		if player:GetData().wakaba then
			if player:GetPlayerType() ~= 23 and player:GetData().wakaba.shioridevil and (not player:GetData().wakaba.blindfolded or player:CanShoot()) then
				local OldChallenge=wakaba.G.Challenge
				wakaba.G.Challenge=6
				player:UpdateCanShoot()
				player:GetData().wakaba.blindfolded = true
				wakaba.G.Challenge=OldChallenge
				player:AddNullCostume(14)
				--print("Trying Add Blindfold Costume")
			elseif player:GetData().wakaba.blindfolded and not player:GetData().wakaba.shioridevil then
				local OldChallenge=wakaba.G.Challenge
				wakaba.G.Challenge=0
				player:UpdateCanShoot()
				player:GetData().wakaba.blindfolded = false
				wakaba.G.Challenge=OldChallenge
				player:TryRemoveNullCostume(14)
				--print("Trying Remove Blindfold Costume")
			end
		end
		--[[ if player:GetData().wakaba 
		and player:GetData().wakaba.shioridevil 
		and player:GetBrokenHearts() >= 12 then
			player:Die()
		end ]]
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PlayerUpdate_BookOfTheFallen)
--LagCheck

function wakaba:ItemUse_BookOfTheFallen(_, rng, player, useFlags, activeSlot, varData)
	wakaba:GetPlayerEntityData(player)
	
	if (useFlags & UseFlag.USE_OWNED == UseFlag.USE_OWNED) and not player:GetData().wakaba.shioridevil then
		return {Discharge = false}
	end
	player:GetData().wakaba.fallenangelfirecount = 150
	
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfTheFallen, wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN)

function wakaba:NewRoom_BookOfTheFallen()
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:GetData().wakaba and player:GetData().wakaba.fallenangelfirecount and player:GetData().wakaba.fallenangelfirecount > -1 then
			player:GetData().wakaba.fallenangelfirecount = -1
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_BookOfTheFallen)

function wakaba:PickupCollision_BookOfTheFallen(pickup, collider, low)
  if collider:ToPlayer() ~= nil then
    local player = collider:ToPlayer()
		if player:GetData().wakaba
		and player:GetData().wakaba.shioridevil then
			return false
		end
  end
end
--wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PickupCollision_BookOfTheFallen, PickupVariant.PICKUP_HEART)



 
function wakaba:Cache_BookOfTheFallen(player, cacheFlag)
	if not player:GetData().wakaba then return end
  if player:GetData().wakaba.shioridevil then
    if player:GetPlayerType() ~= 23 and cacheFlag | CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
      player.Damage = player.Damage * 18
    end
    if cacheFlag | CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
      player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING
    end
    if cacheFlag | CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING then
      player.CanFly = true
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_BookOfTheFallen)


function wakaba:prePickupCollision_BookOfTheFallen(pickup, collider, low)
	if collider:ToPlayer() == nil then return end
	if not collider:GetData().wakaba then return end
	local player = collider:ToPlayer()
	if player:GetData().wakaba.shioridevil then
		local id = pickup.SubType
		local config = Isaac.GetItemConfig():GetCollectible(id)
		if config.Type == ItemType.ITEM_ACTIVE then
			return false
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.prePickupCollision_BookOfTheFallen, PickupVariant.PICKUP_COLLECTIBLE)
