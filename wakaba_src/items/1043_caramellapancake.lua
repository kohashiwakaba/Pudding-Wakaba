--[[
	Caramella Pancake (카라멜라 팬케이크) - 패시브(Passive)
	공격력 +1, 행운 +1
	모든 자폭파리가 적을 자동으로 추적
	캐릭터의 눈물이 독파리로 변경, 무기에 따라 효과 변경 (이후 리셰/리라 전용 자폭 파리로 변경 예정)
	- 눈물 : 독파리로 변경
	- 섹션 : 태아에서 주기적으로 독파리 생성
	- 레이저/혈사 : 레이저 발사 위치에서 독파리 생성
	- 식칼 : 발사된 상태에서 독파리 생성
	- 스피릿 소드 : 투사체 or 회전 공격 시 독파리 생성
	- 루도(공격 속성 무관) : 공격 위치에서 독파리 생성
	- 포가튼 뼈 : 공격 시 독파리 생성
	- 에픽 : 조준하는 동안 조준점 위치에서 독파리 생성
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
local flyType = 2
wakaba.CaramellaAutoTargetFiles = {
	[wakaba.Enums.Flies.RICHER] = true,
	[wakaba.Enums.Flies.RIRA] = true,
	[wakaba.Enums.Flies.CIEL] = true,
	[wakaba.Enums.Flies.KORON] = true,
}

---comment
---@param player EntityPlayer
local function hasCaramellaEffect(player)
	return player:HasCollectible(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE)
end

---@param player EntityPlayer
local function getCaramellaEffectNum(player)
	return player:GetCollectibleNum(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE)
end

---comment
---@param player EntityPlayer
---@param flyType WakabaFlySubType
---@param damage float
---@param position Vector
---@param shouldTargetEnemy boolean
---@return EntityFamiliar
function wakaba:SpawnCaramellaFly(player, flyType, damage, position, shouldTargetEnemy)
	flyType = flyType or wakaba.Enums.Flies.RICHER
	position = position or player.Position
	local fly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, flyType, position, Vector(0, 0), player)
	if shouldTargetEnemy then
		local enemy = wakaba:findRandomEnemy(fly, player:GetCollectibleRNG(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE), true)
		if enemy then
			fly.Target = enemy
		end
	end
	wakaba:FamiliatInit_Pancake(fly)
	if damage then
		fly.CollisionDamage = damage
	else
		fly.CollisionDamage = player.Damage * wakaba.Enums.FlyDamageMult[fly.SubType]
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_HIVE_MIND) then
		fly.CollisionDamage = fly.CollisionDamage * 2
	end
	return fly
end

---@param player EntityPlayer
function wakaba:GetCaramellaFlies(player, flyType)
	flyType = flyType or wakaba.Enums.Flies.RICHER
	local playerFlies = {}
	if player then
		local fam = isc:getPlayerFamiliars(player)
		for _,f in ipairs(fam) do
			if f.Variant == FamiliarVariant.BLUE_FLY then
				if f.SubType == flyType then
					table.insert(playerFlies, f)
				end
			end
		end
	end
	return playerFlies
end

---comment
---@param player EntityPlayer
---@param cacheFlag CacheFlag
function wakaba:Cache_Pancake(player, cacheFlag)
	if hasCaramellaEffect(player) then
		if cacheFlag== CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (1 * getCaramellaEffectNum(player) * wakaba:getEstimatedDamageMult(player))
		end
		if cacheFlag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + (1 * getCaramellaEffectNum(player))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE ,wakaba.Cache_Pancake)

---리셰 팬케이크 눈물 : (리페어 극전갈)
---리셰 팬케이크 섹션 : 태아에서 주기적으로 독파리 생성
---@param tear EntityTear
function wakaba:TearInit_Pancake(tear)
	local player = wakaba:getPlayerFromTear(tear)
	if player and hasCaramellaEffect(player) then
		local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.RICHER)
		local vel = tear.Velocity
		if tear.Variant == TearVariant.FETUS then
			tear.CollisionDamage = 0
			if tear.FrameCount % 9 == 0 and #flies < 10 then
				wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.RICHER, player.Damage * 0.5, nil, true)
			end
		elseif not player:HasWeaponType(WeaponType.WEAPON_LUDOVICO_TECHNIQUE) then
			if #flies < 10 then
				local fly = wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.RICHER)
				fly:GetData().wakaba_vel = vel
				fly:GetData().wakaba_veltimer = player.TearRange / 5
			end
			tear:Remove()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearInit_Pancake)

---리셰 팬케이크 혈사/레이저 : 레이저 발사 위치에서 독파리 생성
---@param effect EntityEffect
function wakaba:EffectUpdate_CaramellaPancake_Laser(laserEndpoint)
	if laserEndpoint.SpawnerEntity and laserEndpoint.SpawnerEntity.Type == EntityType.ENTITY_LASER then
		local laser = laserEndpoint.SpawnerEntity
		local var = laser.Variant
		local subt = laser.SubType
		local player = isc:getPlayerFromEntity(laser)
		if (var == 1 and subt == 3) or var == 5 or var == 12 then
		elseif player and player:HasWeaponType(WeaponType.WEAPON_LUDOVICO_TECHNIQUE) then
		elseif player and laser.FrameCount % 6 == 0 then
			if hasCaramellaEffect(player) then
				local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.RIRA)
				if #flies < 10 then
					wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.RIRA)
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_CaramellaPancake_Laser, EffectVariant.LASER_IMPACT)

---리셰 팬케이크 식칼 : 발사되는 도중 독파리 생성
---리셰 팬케이크 스피릿 소드 : 투사체 or 회전 공격 시 독파리 생성
---리셰 팬케이크 포가튼 뼈 : 공격 시 독파리 생성
---@param knife EntityKnife
function wakaba:KnifeUpdate_CaramellaPancake(knife)
	local player = knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer()
	if player then
		local data = knife:GetData()
		if knife.Variant == isc.KnifeVariant.MOMS_KNIFE or knife.Variant == isc.KnifeVariant.SUMPTORIUM then
			if knife.FrameCount % 5 == 0 and knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer() then

				local isFlying = knife:IsFlying()
				if isFlying and hasCaramellaEffect(player) then
					local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.KORON)
					if #flies < 10 then
						wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.KORON, nil, knife.Position, true)
					end
				end
			end
		elseif knife.Variant == isc.KnifeVariant.SPIRIT_SWORD or knife.Variant == isc.KnifeVariant.TECH_SWORD then
			local spr = knife:GetSprite()
			if hasCaramellaEffect(player) and not data.wakaba_CaramellaSpawned then
				local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.KORON)
				if #flies < 10 then
					wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.KORON, nil, knife.Position, true)
				end
			end
			data.wakaba_CaramellaSpawned = true
		elseif knife.Variant == isc.KnifeVariant.BONE_CLUB or knife.Variant == isc.KnifeVariant.BONE_SCYTHE or knife.Variant == isc.KnifeVariant.DONKEY_JAWBONE then
			local spr = knife:GetSprite()
			if hasCaramellaEffect(player) and not data.wakaba_CaramellaSpawned then
				local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.KORON)
				if #flies < 10 then
					wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.KORON, nil, knife.Position, true)
				end
			end
			data.wakaba_CaramellaSpawned = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, wakaba.KnifeUpdate_CaramellaPancake)

---리셰 팬케이크 루도(공격 속성 무관) : 공격 위치에서 독파리 생성
---@param player EntityPlayer
function wakaba:PlayerUpdate_CaramellaPancake(player)
	if player.FrameCount % 9 == 0 and hasCaramellaEffect(player) and player:HasWeaponType(WeaponType.WEAPON_LUDOVICO_TECHNIQUE) then
		local weaponEntity = player:GetActiveWeaponEntity()
		local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.RICHER)
		if #flies < 10 then
			if weaponEntity then
				if weaponEntity.FrameCount > 0 then
					wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.RICHER, nil, weaponEntity.Position, true)
				end
			else
				wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.RICHER, nil, player.Position, true)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_CaramellaPancake)





---리셰 팬케이크 닥터 : (리페어 극전갈)
---@param bomb EntityBomb
function wakaba:BombInit_Pancake(bomb)
	local player = wakaba:getPlayerFromTear(bomb)
	if player and hasCaramellaEffect(player) and bomb.IsFetus then
		local vel = bomb.Velocity
		local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.CIEL)
		if #flies < 10 then
			local fly = wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.CIEL, player.Damage * 10, nil, true)
			fly:GetData().wakaba_vel = vel
			fly:GetData().wakaba_veltimer = player.TearRange / 5
		end
		bomb:Remove()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, wakaba.BombInit_Pancake)

---리셰 팬케이크 에픽 : 조준하는 동안 조준점 위치에서 독파리 생성
---@param effect EntityEffect
function wakaba:EffectUpdate_CaramellaPancake_EpicFetus(effect)
	local player = isc:getPlayerFromEntity(effect)
	if effect.FrameCount % 10 == 0 and player and hasCaramellaEffect(player) and player:HasWeaponType(WeaponType.WEAPON_ROCKETS) then
		local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.CIEL)
		if #flies < 10 then
			wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.CIEL, player.Damage * 10, effect.Position, true)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_CaramellaPancake_EpicFetus, EffectVariant.TARGET)













---comment
---@param fly EntityFamiliar
function wakaba:FamiliatInit_Pancake(fly)
	if fly.FrameCount <= 1 then
		if fly.SubType == wakaba.Enums.Flies.RICHER then
			local spr = fly:GetSprite()
			spr:Load("gfx/wakaba_flies.anm2", true)
			spr:Play("Richer", true)
			local player = fly.Player or Isaac.GetPlayer()
			fly.CollisionDamage = player.Damage * 4
			if player:HasCollectible(CollectibleType.COLLECTIBLE_HIVE_MIND) then
				fly.CollisionDamage = fly.CollisionDamage * 2
			end
		elseif fly.SubType == wakaba.Enums.Flies.RIRA then
			local spr = fly:GetSprite()
			spr:Load("gfx/wakaba_flies.anm2", true)
			spr:Play("Rira", true)
			local player = fly.Player or Isaac.GetPlayer()
			fly.CollisionDamage = player.Damage * 4
			if player:HasCollectible(CollectibleType.COLLECTIBLE_HIVE_MIND) then
				fly.CollisionDamage = fly.CollisionDamage * 2
			end
		elseif fly.SubType == wakaba.Enums.Flies.CIEL then
			local spr = fly:GetSprite()
			spr:Load("gfx/wakaba_flies.anm2", true)
			spr:Play("Ciel", true)
			local player = fly.Player or Isaac.GetPlayer()
			fly.CollisionDamage = player.Damage * 10
			if player:HasCollectible(CollectibleType.COLLECTIBLE_HIVE_MIND) then
				fly.CollisionDamage = fly.CollisionDamage * 2
			end
		elseif fly.SubType == wakaba.Enums.Flies.KORON then
			local spr = fly:GetSprite()
			spr:Load("gfx/wakaba_flies.anm2", true)
			spr:Play("Koron", true)
			local player = fly.Player or Isaac.GetPlayer()
			fly.CollisionDamage = player.Damage * 4
			if player:HasCollectible(CollectibleType.COLLECTIBLE_HIVE_MIND) then
				fly.CollisionDamage = fly.CollisionDamage * 2
			end
		end
	elseif wakaba.CaramellaAutoTargetFiles[fly.SubType] then
		if not (fly.Target and fly.Target:Exists()) then
			local room = wakaba.G:GetRoom()
			local vel = fly:GetData().wakaba_vel
			local veltimer = fly:GetData().wakaba_veltimer
			if (room:GetFrameCount() > 0 and vel and veltimer and veltimer > 0) then
				fly:GetData().wakaba_veltimer = fly:GetData().wakaba_veltimer - 1
				fly.Velocity = vel
			else
				fly:GetData().wakaba_veltimer = nil
				fly:GetData().wakaba_vel = nil
			end

			local rng = RNG()
			rng:SetSeed(fly.InitSeed + fly.FrameCount, 35)
			local enemy = wakaba:findRandomEnemy(fly, rng, true)
			if enemy then
				fly.Target = enemy
			end
		else
			fly:GetData().wakaba_veltimer = nil
			fly:GetData().wakaba_vel = nil
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliatInit_Pancake, FamiliarVariant.BLUE_FLY)
--- 리셰 자폭 파리


--- 리라 자폭 파리


--- 시엘 자폭 파리
--- 폭발성, 자해 폭발 없음

---@param entity Entity
---@param source EntityRef
function wakaba:TakeDmg_Pancake(entity, amount, flag, source, countdownFrames)
	if entity:ToFamiliar() and entity.Variant == FamiliarVariant.BLUE_FLY then
		if wakaba.Enums.Flies[entity.SubType] then
			if flag & DamageFlag.DAMAGE_SPIKES > 0 then return false end
		end
	elseif source.Entity ~= nil then
		if source.Type == EntityType.ENTITY_FAMILIAR and entity:IsVulnerableEnemy() then
			local fly = source.Entity:ToFamiliar() ---@param EntityFamiliar
			if fly.Variant == FamiliarVariant.BLUE_FLY then
				if fly.SubType == wakaba.Enums.Flies.RIRA then
					local player = fly.Player or Isaac.GetPlayer()
					wakaba:AddStatusEffect(entity, wakaba.StatusEffect.AQUA, 60, player)
				elseif fly.SubType == wakaba.Enums.Flies.CIEL then
					local player = fly.Player or Isaac.GetPlayer()
					wakaba.G:BombExplosionEffects(fly.Position, fly.CollisionDamage, player.TearFlags, Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR)
				elseif fly.SubType == wakaba.Enums.Flies.KORON then
					local player = fly.Player or Isaac.GetPlayer()
					entity:AddFreeze(player, 60)
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_Pancake)

--- 코론 자폭 파리



if EID then
	local rollValues = {
		"CaramellaFlyRicher",
		"CaramellaFlyRira",
		"CaramellaFlyCiel",
		"CaramellaFlyKoron",
	}
	local function CaramellaCondition(descObj)
		if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and descObj.ObjSubType == wakaba.Enums.Collectibles.CARAMELLA_PANCAKE then
			return true
		end
		return false
	end
	local function CaramellaCallback(descObj)
		local room = wakaba.G:GetRoom()
		local frameCount = room:GetFrameCount()
		local par = frameCount // 30
		local entry = (par % #rollValues) + 1
		local append = EID:getDescriptionEntry(rollValues[entry]) or EID:getDescriptionEntryEnglish(rollValues[entry])
		descObj.Description = descObj.Description:gsub("{wakaba_cp1}", append)
		return descObj
	end
	EID:addDescriptionModifier("Wakaba Caramella Pancake", CaramellaCondition, CaramellaCallback)
end