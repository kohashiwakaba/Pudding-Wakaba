local revenge = wakaba.state.revengecount 

function wakaba:TearInit_RevengeFruit(tear)
	if tear
	and tear.SpawnerEntity
	and tear.SpawnerEntity:ToPlayer()
	and tear.SpawnerEntity:ToPlayer():HasCollectible(wakaba.Enums.Collectibles.REVENGE_FRUIT) 
	then
		local player = tear.SpawnerEntity:ToPlayer()
		local luck = (player.Luck) * player:GetCollectibleNum(wakaba.Enums.Collectibles.REVENGE_FRUIT, false)
		local negativeLuck = luck
		local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.REVENGE_FRUIT)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.revengecount = player:GetData().wakaba.revengecount or 7
		if luck < 0 then
			luck = 1
		end
		if wakaba:HasNemesis(player) then
			luck = luck * 2
		end
		luck = luck * player:GetData().wakaba.revengecount / 3
		local rand = (rng:RandomFloat() * 300) - negativeLuck
		if luck >= rand then
			tear:GetData().wakaba = {}
			tear:GetData().wakaba.revenge = true
			tear:GetData().wakaba.revengebless = wakaba:HasNemesis(player) and true or false
			tear:GetData().wakaba.revengeref = EntityRef(player)
			tear:GetData().wakaba.revengepos = tear.Position
			--print(player.Position, tear.Position)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, wakaba.TearInit_RevengeFruit)

function wakaba:TearUpdate_RevengeFruit(tear)
	if tear and tear:GetData().wakaba and tear:GetData().wakaba.revenge
	then
		local player = tear:GetData().wakaba.revengeref.Entity:ToPlayer()
		if player then
			local laser = EntityLaser.ShootAngle(1, tear:GetData().wakaba.revengepos, tear.Velocity:GetAngleDegrees(), 14, Vector(0, -27), tear.SpawnerEntity)
			--local laser = player:FireBrimstone(tear.Velocity, tear, 2)
			if tear:GetData().wakaba.revengebless then
				laser:AddTearFlags(TearFlags.TEAR_HOMING)
			end
			tear:Remove()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_RevengeFruit)

function wakaba:RevengeFruitTakeDmg(entity, amount, flag, source, countdownFrames)
	if entity.Type == EntityType.ENTITY_PLAYER
	and entity:ToPlayer():HasCollectible(wakaba.Enums.Collectibles.REVENGE_FRUIT)
	then
		local player = entity:ToPlayer()
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.revengecount = player:GetData().wakaba.revengecount or 7
		if player:GetData().wakaba.revengecount <= 14 then
			player:GetData().wakaba.revengecount = player:GetData().wakaba.revengecount + 1
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.RevengeFruitTakeDmg)

function wakaba:RevengeFruitPostLevel()
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.revengecount = 7
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.RevengeFruitPostLevel)

function wakaba:cacheUpdate31(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.REVENGE_FRUIT) and not player:HasWeaponType(WeaponType.WEAPON_TEARS) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 1.5
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.cacheUpdate31)