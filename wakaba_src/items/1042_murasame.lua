function wakaba:HasMurasame(player)
	if not player then
		return false
	end
	if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
    return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.MURASAME) then
		return true
	else
		return false
	end
end

wakaba.MURASAME_DASH_ANIM = {
	[Direction.NO_DIRECTION] = "FloatShootDown",
	[Direction.LEFT] = "FloatShootRight",
	[Direction.UP] = "FloatShootUp",
	[Direction.RIGHT] = "FloatShootLeft",
	[Direction.DOWN] = "FloatShootDown"
}
wakaba.MURASAME_BLADE_ANIM = {
	[Direction.NO_DIRECTION] = "FloatShootDown",
	[Direction.LEFT] = "FloatShootRight",
	[Direction.UP] = "FloatShootUp",
	[Direction.RIGHT] = "FloatShootLeft",
	[Direction.DOWN] = "FloatShootDown"
}

function wakaba:initMurasameTear(player, familiar, multiplier, collisionsize)
	local tear = player:FireTear(familiar.Position, familiar.Velocity, false, true, false, player, multiplier)
	tear:AddTearFlags(TearFlags.TEAR_PIERCING)
	tear.FallingAcceleration = 0
	tear.FallingSpeed = 0
	tear.Scale = collisionsize / 10
	tear:SetColor(Color(1,1,1,0,0,0,0), 2, 1, false, false)
	tear:SetKnockbackMultiplier(6)
	tear.DepthOffset = familiar.DepthOffset - 1
	return tear
end
function wakaba:initMurasameKnife(player, familiar, multiplier, rotation)
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_KNIFE, 1, 1, player)
	local knife = player:FireKnife(familiar, 0, false, 2):ToKnife()
	knife:GetSprite().Rotation = rotation - 90
	--knife:SetPathFollowSpeed(1)
	--knife:GetSprite().Color = Color(0,0,0,0,1,1,1)
	knife.TearFlags = knife.TearFlags | player.TearFlags | tearparams.TearFlags
	local mul = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOMS_KNIFE) > 0 and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOMS_KNIFE) or 1
	knife.CollisionDamage = tearparams.TearDamage * 6 * mul
	--knife:Shoot(1, 80)
	return knife
end

function wakaba:initMurasameLaser(player, familiar, multiplier, collisionsize)
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_LASER, 1, 1, player)
	local laser = player:FireTechLaser(familiar.Position, LaserOffset.LASER_BRIMSTONE_OFFSET, familiar.Velocity, true, true, player, multiplier)
	laser:AddTearFlags(TearFlags.TEAR_PIERCING | player.TearFlags | tearparams.TearFlags)
	return laser
end
function wakaba:initMurasameBrimstoneLaser(player, familiar, multiplier, collisionsize)
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_LASER, 1, 1, player)
	local laser = player:FireBrimstone(familiar.Velocity, player, multiplier)
	--laser.ParentOffset = familiar.Position
	laser.Parent = familiar
	laser:AddTearFlags(TearFlags.TEAR_PIERCING | player.TearFlags | tearparams.TearFlags)
	return laser
end
function wakaba:initMurasameTechXLaser(player, familiar, multiplier, collisionsize)
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_LASER, 1, 1, player)
	local laser = player:FireTechXLaser(familiar.Position, familiar.Velocity, 80 * player.ShotSpeed, player, multiplier)
	laser:AddTearFlags(TearFlags.TEAR_PIERCING | player.TearFlags | tearparams.TearFlags)
	laser.Parent = familiar
	laser.Timeout = 15
	return laser
end

function wakaba:initMurasame(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()
	familiar.FireCooldown = 3
	familiar:GetData().wakaba = familiar:GetData().wakaba or {}

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")

end

function wakaba:updateMurasame(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	local move_dir = player:GetMovementDirection() or Direction.NO_DIRECTION
	local sprite = familiar:GetSprite()
	local player_fire_direction = player:GetFireDirection() or Direction.NO_DIRECTION
	local autoaim = false

	if player_fire_direction == Direction.NO_DIRECTION then
		--sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
	else
		--sprite:Play(wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
		if familiar.FireCooldown <= 0 then
			local tear_vector = nil
			if Isaac.CountEnemies() > 0 then
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
		end
	end
	familiar.FireCooldown = familiar.FireCooldown - 1
	if fData.wakaba.dashcountdown and fData.wakaba.dashcountdown > 0 then
		familiar:RemoveFromFollowers()
		local collisionsize = 40
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
			collisionsize = 54
		end
		local dirVec = wakaba.DIRECTION_VECTOR[move_dir]
		if familiar:GetData().wakaba.dashvector then
			dirVec = familiar:GetData().wakaba.dashvector
		end
		sprite:Play(wakaba.DIRECTION_SHOOT_ANIM_MURASAME[familiar:GetData().wakaba.dashdirection] or wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
		local playerpos = player.Position
		local oldpos = familiar.Position
		local newpos = playerpos + dirVec:Resized(80)
		--familiar.Friction = 15 - fData.wakaba.dashcountdown
		familiar.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length() * 0.4)
		fData.wakaba.dashcountdown = fData.wakaba.dashcountdown - 1

		local multiplier = 4 - (2 * (player.Damage * 0.01))
		local dashmultiplier = 0.1
		if multiplier < 1.5 then
			multiplier = 1.5
		end
		if player.MaxFireDelay < 0 then
			multiplier = multiplier * (1 - player.MaxFireDelay)
			dashmultiplier = dashmultiplier * (1 - player.MaxFireDelay)
		end
		--[[ if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
			multiplier = multiplier * 3
			dashmultiplier = dashmultiplier * 1.5
		end ]]
		local nontear = false

		if not fData.wakaba.murasametear then
			fData.wakaba.murasametear = wakaba:initMurasameTear(player, familiar, multiplier, collisionsize)
		else
			--familiar.Friction = 15 - fData.wakaba.dashcountdown
			local tear = fData.wakaba.murasametear
			tear:SetWaitFrames(0)
			tear:SetColor(Color(1,1,1,0,0,0,0), 2, 1, false, false)
			tear.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length() * 0.4)
			if tear.StickTarget then
				fData.wakaba.murasametear = wakaba:initMurasameTear(player, familiar, multiplier, collisionsize)
			end
		end

		if player:HasWeaponType(WeaponType.WEAPON_KNIFE) then
			local rotation = dirVec:GetAngleDegrees()
			if not fData.wakaba.murasameknife then
				fData.wakaba.murasameknife = wakaba:initMurasameKnife(player, familiar, multiplier, rotation)
			else
				local knife = fData.wakaba.murasameknife
				knife.Position = familiar.Position + dirVec:Resized(32)
				knife:GetSprite().Rotation = rotation - 90
				--tear.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length() * 0.5)
			end
			nontear = true
		end
		if player:HasWeaponType(WeaponType.WEAPON_LASER) then
			if not fData.wakaba.murasamelaser then
				fData.wakaba.murasamelaser = wakaba:initMurasameLaser(player, familiar, multiplier, collisionsize)
			end
			nontear = true
		end
		if player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) then
			if not fData.wakaba.murasamebrlaser then
				fData.wakaba.murasamebrlaser = wakaba:initMurasameBrimstoneLaser(player, familiar, multiplier, collisionsize)
			end
			nontear = true
		end
		if player:HasWeaponType(WeaponType.WEAPON_TECH_X) then
			if not fData.wakaba.murasamexlaser then
				fData.wakaba.murasamexlaser = wakaba:initMurasameTechXLaser(player, familiar, multiplier, collisionsize)
			else
				local tear = fData.wakaba.murasamexlaser
				tear.Position = familiar.Position
				--tear.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length() * 0.4)
			end
			nontear = true
		end

		if --[[ not nontear and ]] (player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) or player:HasWeaponType(WeaponType.WEAPON_FETUS)) and fData.wakaba.dashcountdown > 11 then
			local repeatCount = player:HasWeaponType(WeaponType.WEAPON_FETUS) and 1 or 13
			for i = 0, repeatCount do
				local vec = familiar.Velocity
				local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.FLASH_SHIFT)
				local randFloat1 = rng:RandomFloat()
				local randFloat2 = rng:RandomFloat()
				local randvec = vec:Resized(player.ShotSpeed * 12)
				if player:HasWeaponType(WeaponType.WEAPON_FETUS) and fData.wakaba.dashcountdown % 2 == 0 then
					randvec = vec:Resized(player.ShotSpeed * 8)
					local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, 50, 0, player.Position, randvec + RandomVector():Resized(4), player):ToTear()
					--local tear = player:FireTear(familiar.Position, randvec + RandomVector():Resized(1), false, true, false, player, 1)
					tear:GetData().wakaba = {}
					tear:GetData().wakaba.murasamemonstro = true
					tear:ChangeVariant(50) -- fetus
					tear:AddTearFlags(TearFlags.TEAR_FETUS)
					tear.FallingSpeed = 0.05
					tear.FallingAcceleration = 0.05
				elseif player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
					local tear = player:FireTear(familiar.Position, randvec + RandomVector():Resized(1), false, true, false, player, 1)
					tear:GetData().wakaba = {}
					tear:GetData().wakaba.murasamemonstro = true
					tear.FallingSpeed = -15 + randFloat1 - 0.5
					tear.FallingAcceleration = 1 + (randFloat2 * 0.1) - 0.05
				end
			end
		end

		--[[ if player:HasWeaponType(WeaponType.WEAPON_FETUS) and fData.wakaba.dashcountdown == 14 then
			local tear = player:FireTear(player.Position, player.Velocity:Normalized():Resized(4 * player.ShotSpeed), false, true, false, player, multiplier)
			tear:ChangeVariant(50)
			tear.FallingAcceleration = 0
			tear.FallingSpeed = 0
			--tear:AddTearFlags(TearFlags.TEAR_HOMING | TearFlags.TEAR_PIERCING | TearFlags.TEAR_POP)
		end ]]


		--familiar.CollisionDamage = player.Damage * multiplier
		familiar.Size = collisionsize
		local dashdmg = player.Damage * dashmultiplier
		local ents = Isaac.FindInRadius(familiar.Position, collisionsize * (1 + player.TearRange / 40) * 0.16, EntityPartition.ENEMY)
		for i, e in ipairs(ents) do
			if not e:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
				if e.Type == EntityType.ENTITY_SHOPKEEPER then
					e:TakeDamage(100, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(player), 0)
				else
					e:TakeDamage(dashdmg, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(player), 0)
				end
			end
		end
		if player.TearFlags & TearFlags.TEAR_SHIELDED == TearFlags.TEAR_SHIELDED then
			local ents = Isaac.FindInRadius(familiar.Position, collisionsize * (1 + player.TearRange / 40) * 0.12, EntityPartition.BULLET)
			for i, e in ipairs(ents) do
				e:Die()
			end
		end
		local grid = wakaba.G:GetRoom():GetGridEntityFromPos(familiar.Position)
		if grid then
			local gridtype = grid:GetType()
			if (gridtype >= GridEntityType.GRID_ROCK and gridtype <= GridEntityType.GRID_ROCK_ALT)
			or gridtype == GridEntityType.GRID_ROCK_SS
			or gridtype == GridEntityType.GRID_ROCK_SPIKED
			or gridtype == GridEntityType.GRID_ROCK_ALT2
			or gridtype == GridEntityType.GRID_ROCK_GOLD
			then
				grid:Destroy(false)
			elseif gridtype == GridEntityType.GRID_TNT
			or gridtype == GridEntityType.GRID_POOP
			then
				grid:Hurt(1)
			end
		end
	else
		if fData.wakaba.murasametear and fData.wakaba.murasametear:Exists() then
			fData.wakaba.murasametear:Remove()
		end
		if fData.wakaba.murasameknife and fData.wakaba.murasameknife:Exists() then
			fData.wakaba.murasameknife:Remove()
		end
		if fData.wakaba.murasamelaser and fData.wakaba.murasamelaser:Exists() then
			fData.wakaba.murasamelaser:Remove()
		end
		if fData.wakaba.murasamexlaser and fData.wakaba.murasamexlaser:Exists() then
			fData.wakaba.murasamexlaser:Remove()
		end
		if fData.wakaba.murasamebrlaser and fData.wakaba.murasamebrlaser:Exists() then
			fData.wakaba.murasamebrlaser:Remove()
		end
		fData.wakaba.murasametear = nil
		fData.wakaba.murasameknife = nil
		fData.wakaba.murasamelaser = nil
		fData.wakaba.murasamexlaser = nil
		fData.wakaba.murasamebrlaser = nil
		sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
		--familiar.Size = 1
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
			familiar.Size = 16
		else
			familiar.Size = 13
		end
		familiar.CollisionDamage = 0
		familiar:FollowParent()
	end
end

function wakaba:onCacheMurasame(player, cacheFlag)
	wakaba:GetPlayerEntityData(player)
	local voided = false
	if player:GetData().wakaba.voided and player:GetData().wakaba.voided.murasame then
		voided = true
	end
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		if player:HasCollectible(wakaba.Enums.Collectibles.MURASAME) or voided or player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
			local voidcount = (voided and 1) or 0
			count = player:GetCollectibleNum(wakaba.Enums.Collectibles.MURASAME) + voidcount + (player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B and 1 or 0)
			count = count > 1 and 1 or count
		end
		player:CheckFamiliar(wakaba.Enums.Familiars.MURASAME, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.MURASAME))
	end
end


wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onCacheMurasame)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.initMurasame, wakaba.Enums.Familiars.MURASAME)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateMurasame, wakaba.Enums.Familiars.MURASAME)


function wakaba:TearInit_Murasame(tear)
	if tear:GetData().wakaba and tear:GetData().wakaba.murasamemonstro then
		--tear.FallingSpeed = tear.FallingSpeed - 0.4
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearInit_Murasame)

function wakaba:FamiliarCollision_Murasame(familiar, entity, bool)
	local fData = familiar:GetData()
	local player = familiar.Player
	if fData.wakaba.dashcountdown and fData.wakaba.dashcountdown > 0 then
		if entity.Type == EntityType.ENTITY_FIREPLACE and entity.Variant ~= 4 then
			entity:Die()
		end
		if entity.Type == EntityType.ENTITY_SHOPKEEPER then
			entity:Die()
		end
		if (player:HasWeaponType(WeaponType.WEAPON_KNIFE) or player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS)) and entity:IsVulnerableEnemy() then
			local mult = 0.25
			if player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then mult = mult * 6 end
			if player:HasWeaponType(WeaponType.WEAPON_KNIFE) then mult = mult * 3 end
			entity:TakeDamage(player.Damage * mult, 0, EntityRef(player), 0)
		end
		if (player:HasWeaponType(WeaponType.WEAPON_BOMBS) or player:HasWeaponType(WeaponType.WEAPON_ROCKETS)) and entity:IsVulnerableEnemy() then
			local mult = 1
			if player:HasWeaponType(WeaponType.WEAPON_ROCKETS) then
				mult = 2
			end
			wakaba.G:BombExplosionEffects(familiar.Position, player.Damage * 10 * mult, player.TearFlags, Color.Default, player, mult * 0.75, true, false, DamageFlag.DAMAGE_EXPLOSION)
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, wakaba.FamiliarCollision_Murasame, wakaba.Enums.Familiars.MURASAME)

function wakaba:PlayerRender_Murasame(player)
	wakaba:GetPlayerEntityData(player)
	if (player:GetData().wakaba.voided and player:GetData().wakaba.voided.murasame) or player:HasCollectible(wakaba.Enums.Collectibles.MURASAME) or player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
		wakaba.G:GetLevel():SetStateFlag(LevelStateFlag.STATE_REDHEART_DAMAGED, false)
		wakaba.G:GetRoom():SetRedHeartDamage(false)
		wakaba.G:SetLastDevilRoomStage(LevelStage.STAGE_NULL)
		if wakaba.G:GetLevel():GetAngelRoomChance() <= 0 then
			wakaba.G:GetLevel():AddAngelRoomChance((wakaba.G:GetLevel():GetAngelRoomChance() * -1) + 0.00001)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.PlayerRender_Murasame)

function wakaba:ItemUse_Murasame(_, rng, player, useFlags, activeSlot, varData)

end

wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Murasame, wakaba.Enums.Collectibles.MURASAME)

local function CheckTears()
	local tears = Isaac.FindByType(EntityType.ENTITY_TEAR)
	for i, e in ipairs(tears) do
		local tear = e:ToTear()
		local fpos = Vector(30, 60 + (8 * i)) - wakaba.G.ScreenShakeOffset + Vector(0, -10) + Vector(8, -8)
		local str = ""
		for p = 1, TearFlags.TEAR_EFFECT_COUNT do
			if tear:HasTearFlags(wakaba.TEARFLAG(p)) then
				str = str .. "1"
			else
				str = str .. "0"
			end
		end
		wakaba.cf:DrawStringScaledUTF8("x" .. " - " .. tear.FallingAcceleration .. "/" .. tear.FallingSpeed .. " " .. str, fpos.X, fpos.Y, 1.0, 1.0, KColor(1,1,1,1.0,0,0,0),0,true)
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, CheckTears)

local function getSelectionItems()
	local roomEntities = wakaba:GetRoomEntities()
	local selections = {}
	for _, e in ipairs(roomEntities) do
		if e:ToPickup() and e:ToPickup().OptionsPickupIndex ~= 0 then
			table.insert(selections, e:ToPickup())
		end
	end
	return selections
end

function wakaba:NewRoom_Murasame()
	local murasame_count = wakaba:GetGlobalCollectibleNum(wakaba.Enums.Collectibles.MURASAME)
	if murasame_count <= 1 then return end
	local murasame_players = {}
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		if player:HasCollectible(wakaba.Enums.Collectibles.MURASAME) then
			table.insert(murasame_players, player)
		elseif player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
			table.insert(murasame_players, player)
			murasame_count = murasame_count + 1
		end
	end)

	local roomDesc = wakaba.G:GetLevel():GetCurrentRoomDesc()
	local room = wakaba.G:GetRoom()
	local player = murasame_players[1]
	if roomDesc.SafeGridIndex == GridRooms.ROOM_ANGEL_SHOP_IDX then
		for i = 1, (murasame_count - 1) do
			player:UseActiveItem(CollectibleType.COLLECTIBLE_COUPON, UseFlag.USE_NOANIM)
		end
	elseif roomDesc.SafeGridIndex == GridRooms.ROOM_DEVIL_IDX then
		if room:GetType() == RoomType.ROOM_DEVIL then
			for i = 1, (murasame_count - 1) do
				player:UseActiveItem(CollectibleType.COLLECTIBLE_COUPON, UseFlag.USE_NOANIM)
			end
		elseif room:GetType() == RoomType.ROOM_ANGEL then
			local selections = wakaba:getSelectionPickups()
			local filtered = wakaba:getRandomEntry(selections, player:GetCollectibleRNG(wakaba.Enums.Collectibles.MURASAME), (murasame_count - 1))
			for _, e in ipairs(filtered) do
				e.OptionsPickupIndex = 0
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Murasame)






