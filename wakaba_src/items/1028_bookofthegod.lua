function wakaba:initSingleCrack(player, pos)
	--EffectVariant.CRACK_THE_SKY
	local laser = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, -1, pos, Vector.Zero, player):ToEffect()
	return laser
end


local function calculateLength(player, r, i)
	local x, y = player.Position.X, player.Position.Y
  local angle = i * math.pi / 180
  local ptx, pty = x + r * math.cos( angle ), y + r * math.sin( angle )
	return Vector(ptx, pty)
end

function wakaba:InitCrackEffect(player)
	wakaba:initSingleCrack(player, player.Position)
	wakaba:initSingleCrack(player, calculateLength(player, 80.0, 0))
	wakaba:initSingleCrack(player, calculateLength(player, 80.0, 45))
	wakaba:initSingleCrack(player, calculateLength(player, 80.0, 90))
	wakaba:initSingleCrack(player, calculateLength(player, 80.0, 135))
	wakaba:initSingleCrack(player, calculateLength(player, 80.0, 180))
	wakaba:initSingleCrack(player, calculateLength(player, 80.0, 225))
	wakaba:initSingleCrack(player, calculateLength(player, 80.0, 270))
	wakaba:initSingleCrack(player, calculateLength(player, 80.0, 315))
end

function wakaba:AfterRevival_BookOfTheGod(player)
  local data = player:GetData()
  data.wakaba = data.wakaba or {}
	player:AddBrokenHearts(-18)
	player:AddMaxHearts(-24)
	player:AddBoneHearts(-12)
	player:AddSoulHearts(-24)
	player:AddCostume(Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_REVELATION), false)
	local Poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector.Zero, player):ToEffect()
	Poof.SpriteScale = Vector(1.5, 1.5)
	data.wakaba.shioriangel = true
	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FLYING | CacheFlag.CACHE_TEARFLAG)
	player:EvaluateItems()
	player:AddBrokenHearts(-12)
	player:AddSoulHearts(1)
	player:RemoveCollectible(wakaba.Enums.Collectibles.BOOK_OF_THE_GOD)
end


function wakaba:PlayerUpdate_BookOfTheGod()
	for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:GetData().wakaba
		and player:GetData().wakaba.shioriangel then
			if player:GetMaxHearts() > 0 then
				player:AddMaxHearts(player:GetMaxHearts() * -1)
			end
			if player:GetBoneHearts() > 0 then
				player:AddBoneHearts(player:GetBoneHearts() * -1)
			end
			if player:GetSoulHearts() ~= 1 then
				player:AddSoulHearts(1 - player:GetSoulHearts())
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PlayerUpdate_BookOfTheGod)
--LagCheck


function wakaba:PickupCollision_BookOfTheGod(pickup, collider, low)
  if collider:ToPlayer() ~= nil then
    local player = collider:ToPlayer()
		if player:GetData().wakaba
		and player:GetData().wakaba.shioriangel then
			return false
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PickupCollision_BookOfTheGod, PickupVariant.PICKUP_HEART)



 
function wakaba:Cache_BookOfTheGod(player, cacheFlag)
	if not player:GetData().wakaba then return end
  if player:GetData().wakaba.shioriangel then
    if cacheFlag | CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
      player.Damage = player.Damage * 0.5
    end
    if cacheFlag | CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
      player.TearFlags = player.TearFlags | TearFlags.TEAR_GLOW | TearFlags.TEAR_PIERCING
    end
    if cacheFlag | CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING then
      player.CanFly = true
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_BookOfTheGod)

function wakaba:EnemyTakeDmg_BookOfTheGod(target, damage, flags, source, cooldown)
	if math.floor(damage * 1000)/1000 == 2 and source.Entity ~= nil and source.Entity.Type == 2 then
		local player = source.Entity.SpawnerEntity and source.Entity.SpawnerEntity:ToPlayer()
		if player ~= nil and player:GetData().wakaba and player:GetData().wakaba.shioriangel then
			local tf = source.Entity:ToTear().TearFlags
			if player ~= nil and tf | TearFlags.TEAR_GLOW == tf then
				target:TakeDamage(player.Damage, flags, source, cooldown)
				return false
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.EnemyTakeDmg_BookOfTheGod)

function wakaba:AlterDamage_BookOfTheGod(player, amount, flags, source, countdown)
	if data.wakaba.shioriangel and not (player:HasCollectible(CollectibleType.COLLECTIBLE_HEARTBREAK) then
		return 1, flags | DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_NO_MODIFIERS
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, wakaba.AlterDamage_BookOfTheGod)

function wakaba:PostTakeDamage_BookOfTheGod(player, amount, flags, source, countdown)
	if data.wakaba.shioriangel and not (player:HasCollectible(CollectibleType.COLLECTIBLE_HEARTBREAK) then
		player:AddBrokenHearts(1)
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, wakaba.PostTakeDamage_BookOfTheGod)