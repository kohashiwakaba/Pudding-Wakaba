--[[
	Chimaki (치마키) - 패밀리어 (유니크)
	리라로 하드 모드 체크리스트 달성
	Blind 저주 면역, 다양한 방면으로 캐릭터 보조

	based off from virgil from Revelations
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
local sfx = SFXManager()

local function GetValidGridCollisions(groundMove)
	if groundMove ~= nil and groundMove == false then
		return {
			GridCollisionClass.COLLISION_NONE,
			GridCollisionClass.COLLISION_PIT,
			GridCollisionClass.COLLISION_OBJECT,
			GridCollisionClass.COLLISION_SOLID,
		}
	end
end

local function TryChimakiSound(sndId)
	if wakaba:getOptionValue("chimakisound") then
		sfx:Play(sndId, wakaba:getOptionValue("customsoundvolume") / 10 or 0.5)
	end
end

function wakaba:Chimaki_CommandShootTears(familiar, pos, hit, tinted, speedMult)
	local length = (pos - familiar.Position):Length()
	local player = familiar:GetData().player or familiar.Player
	local data = familiar:GetData()
	local entity = familiar:FireProjectile((pos - familiar.Position) * (speedMult / length))
	local tear = entity:ToTear()
	tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING | TearFlags.TEAR_SPECTRAL

	local multiplier = 1
	multiplier = multiplier * (1 + data.bffsPower)
	local tearDamage = (player:GetCollectibleNum(wakaba.Enums.Collectibles.CHIMAKI) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.CHIMAKI) + 1) * 3.5
	tear.CollisionDamage = tearDamage * multiplier

	if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_FETUS | TearFlags.TEAR_SPECTRAL
		tear.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
	end

	return tear
end
function wakaba:Chimaki_CommandShootLasers(familiar, pos, hit, tinted, speedMult)
	local player = familiar:GetData().player or familiar.Player
	local angle = (pos - familiar.Position):GetAngleDegrees()
	local data = familiar:GetData()
	local laser = EntityLaser.ShootAngle(2, familiar.Position, angle, 3, Vector(0, -20), familiar)
	laser:AddTearFlags(TearFlags.TEAR_RAINBOW | TearFlags.TEAR_HOMING | TearFlags.TEAR_SPECTRAL)
	laser.Parent = familiar

	local multiplier = 1
	multiplier = multiplier * (1 + data.bffsPower)
	local tearDamage = ((player:GetCollectibleNum(wakaba.Enums.Collectibles.CHIMAKI) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.CHIMAKI) ) * (1 + data.easterPower) / 4) + 5
	laser.CollisionDamage = tearDamage * multiplier

	return laser
end

function wakaba:Chimaki_CommandShootFlames(familiar, pos, hit, tinted, speedMult)
	local player = familiar:GetData().player or familiar.Player
	local fires = {}
	for i = -1, 1 do
		local length = (pos - familiar.Position):Length()
		local aimDirection = (pos - familiar.Position) * (speedMult / length)
		local rotatedDirection = aimDirection:Rotated(30 * i)
		local fire = Isaac.Spawn(1000, EffectVariant.BLUE_FLAME, 0, familiar.Position, rotatedDirection:Resized(15), player):ToEffect()
		fire.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
		fire.Timeout = 60
		fire:GetData().wakaba_chimakiBFParent = EntityRef(player)
		table.insert(fires, fire)
	end
	return fires
end
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)
	local parent = effect:GetData().wakaba_chimakiBFParent --- @type EntityRef
	if parent and parent.Entity then
		if effect.FrameCount % 5 == 0 then
			local player = parent.Entity:ToPlayer()
			for _, enemy in ipairs(Isaac.FindInRadius(effect.Position, effect.Size, EntityPartition.ENEMY)) do
				if enemy:IsVulnerableEnemy() then
					enemy:TakeDamage(player.Damage * 4, DamageFlag.DAMAGE_IGNORE_ARMOR, parent, 0)
				end
			end
		end
		for _, proj in ipairs(Isaac.FindInRadius(effect.Position, effect.Size, EntityPartition.BULLET)) do
			proj:Remove()
		end
	end
end, EffectVariant.BLUE_FLAME)
function wakaba:Chimaki_CommandKnife(familiar, pos, hit, tinted, speedMult)
	local player = familiar:GetData().player or familiar.Player
	local tearparams = player:GetTearHitParams(WeaponType.WEAPON_KNIFE, 1, 1, player)
	local length = (pos - familiar.Position):Length()
	local aimDirection = (pos - familiar.Position) * (speedMult / length)
	local knife = player:FireKnife(familiar, _, _, 4, 11)
	knife:GetSprite().Rotation = aimDirection:Resized(15):GetAngleDegrees() - 90
	knife.TearFlags = knife.TearFlags | player.TearFlags | tearparams.TearFlags
	local mul = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOMS_KNIFE) > 0 and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOMS_KNIFE) or 1
	knife.CollisionDamage = tearparams.TearDamage * 6 * mul
	return knife
end

wakaba.Chimaki = {
	busyStates = {
		--"Throw_Rock_Enemy",
		--"Throw_Rock",
		--"Throw_Bomb",
		--"AngryPointing",
		--"Swat_Bomb",
		--"Point_Trapdoor",
		"Chimaki_Rest",
		"Command_ConvertTrollBombs",
		"Command_RemoveCurse",
		--"Command_MegaChest",
		"Command_OpenChallengeDoor",
		"Command_Sacrifice",
		"Command_Locust",
		"Command_HolyLightJump",
		"Command_BlueFlame",
		"Command_ShootTears",
	}, -- states for which he is considered busy and cannot take new actions
}
local chimaki = wakaba.Chimaki

function wakaba:hasChimaki(player, includeRira)
	includeRira = includeRira or true
	if includeRira and player:GetPlayerType() == wakaba.Enums.Players.RIRA then
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.CHIMAKI) then
		return true
	else
		return false
	end
end

function wakaba:anyPlayerHasChimaki(includeRira)
	local power = 0
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		if wakaba:hasChimaki(player, includeRira) then
			power = power + 1
		end
	end)
	return power > 0
end

--#region
-- Chest/Dark Room 보스 방 격파 시 Ultra Greed로 진입하는 보스방 생성

function wakaba:RoomGen_Chimaki_BossDoor()
	local level = wakaba.G:GetLevel()
	if level:GetAbsoluteStage() == LevelStage.STAGE6 then
		local roomData = isc:getRoomDataForTypeVariant(RoomType.ROOM_BOSS, 42000)
		local writeableRoom = level:GetRoomByIdx(-14, -1)
		local writeablePrevRoom = level:GetRoomByIdx(-3, -1)
		writeableRoom.Data = roomData
		writeableRoom.SpawnSeed = writeablePrevRoom.SpawnSeed
		writeableRoom.DecorationSeed = writeablePrevRoom.DecorationSeed
		writeableRoom.AwardSeed = writeablePrevRoom.AwardSeed
	end
end
--wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_LEVEL, CallbackPriority.EARLY, wakaba.RoomGen_Chimaki_BossDoor)
function wakaba:NewLevel_Chimaki()
	local fams = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, wakaba.Enums.Familiars.CHIMAKI)
	for _, fam in ipairs(fams) do
		local data = fam:GetData()
		local player = data.player or fam:ToFamiliar().Player
		data.curseRemoveTries = player:GetCollectibleNum(wakaba.Enums.Collectibles.CHIMAKI) + (player:GetPlayerType() == wakaba.Enums.Players.RIRA and (player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BIRTHRIGHT) + 1) or 0)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_Chimaki)

function wakaba:RoomClear_Chimaki_BossDoor(rng, spawnPosition)
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	local bossID = room:GetBossID()
	if wakaba:anyPlayerHasChimaki() and level:GetAbsoluteStage() == LevelStage.STAGE6 and (bossID == 40 or bossID == 54) and room:IsClear() then
		--room:TrySpawnMegaSatanRoomDoor(true)
		room:TrySpawnBlueWombDoor(true, true, true)
		local doors = isc:getDoorsToRoomIndex(-8)
		for _, door in ipairs(doors) do
			door.TargetRoomIndex = -14
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_Chimaki_BossDoor)
--wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_ROOM, CallbackPriority.EARLY, wakaba.RoomClear_Chimaki_BossDoor)

--#endregion

--#region
--치마키 패밀리어

function wakaba:Cache_Chimaki(player, cacheFlag)
	if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		player:CheckFamiliar(wakaba.Enums.Familiars.CHIMAKI, wakaba:hasChimaki(player) and 1 or 0, player:GetCollectibleRNG(wakaba.Enums.Collectibles.CHIMAKI), Isaac.GetItemConfig():GetCollectible(wakaba.Enums.Collectibles.CHIMAKI))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Chimaki)

function wakaba:FamiliarInit_Chimaki(familiar)
	familiar:GetData().player = familiar.Player -- used when it was not a proper familiar, kept in case it stops being one again
	familiar.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
	familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
	--familiar.Player:GetData().wakaba._chimaki = familiar
	familiar:GetSprite():Play("idle", true)
	if familiar:GetData().startPos then -- manual spawn bug workaround
		familiar.Position = familiar:GetData().startPos
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.FamiliarInit_Chimaki, wakaba.Enums.Familiars.CHIMAKI)

function wakaba:NewRoom_Chimaki()
	wakaba:ForAllPlayers(function(player)
	end)
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Chimaki)

local function goToPos(pos, eff, data, speed, dist, force)
	if not force then
		pos = Isaac.GetFreeNearPosition(pos, 20)
	end
	data.gotoSpeed = speed or data.speed
	data.gotoDist = dist or 2
	data.targetPos = pos
end

local function goToEnt(ent, eff, data, speed, offset)
	data.targetEnt = ent
	data.targetEntSpeed = speed or data.speed
	data.targetEntOffset = offset or Vector.Zero
end

local function stopGoToPos(eff, data) data.targetPos = nil end

local function stopGoToEnt(data) data.targetEnt = nil end

local function playExtraAnim(anim, state, ent, spr, data)
	spr.PlaybackSpeed = 1
	data.ExtraAnim = anim
	spr:Play(anim, true)
	data.ExtraAnimState = state -- can be nil
end

local DISTANCE_MAX = 120 --TODO
local function defaultMove(ent, data, spr)
	if not data.targetPos then
		if data.randomMoveTimer == 0 then
			local room = wakaba.G:GetRoom()
			local pos = Isaac.GetFreeNearPosition(data.player.Position + RandomVector() * (math.random() * DISTANCE_MAX), 20)
			local speedMult = 1
			if room:IsClear() then speedMult = 0.5 end
			goToPos(pos, ent, data, data.speed * speedMult, 100)
			data.randomMoveTimer = 25 + math.random(25)
		else
			data.randomMoveTimer = data.randomMoveTimer - 1
			if data.player.Position:DistanceSquared(ent.Position) > (DISTANCE_MAX * 1.1) ^ 2 then
				data.randomMoveTimer = 0
			end
		end
	end
end

function wakaba:FamiliarUpdate_Chimaki(familiar)
	local spr, data = familiar:GetSprite(), familiar:GetData()
	--local standstill
	local room = wakaba.G:GetRoom()

	if not data.wakaba_init then
		local rng = RNG()
		rng:SetSeed(familiar.Player.InitSeed, 43)
		data.State = "Move_Default"
		data.ForceStateUpdate = true
		data.PrevState = "Move_Default"
		data.PrevCommand = ""
		data.FrameCount = 0
		data.WalkFrame = 0
		data.rockCooldown = 0
		data.lightCooldown = 0
		data.speed = 5
		data.randomMoveTimer = 0
		data.prevTarg = Vector(0, 0)
		data.chimakiRng = rng
		data.groundMove = true
		data.standstill = nil

		data.wakaba_init = true
	end
	--print("Chimaki States : ", data.State )

	if room:GetFrameCount() == 1 then
		data.randomMoveTimer = 0
		data.FrameCount = 0
		data.State = "Move_Default"
		data.ForceStateUpdate = true
		data.groundMove = true
		data.standstill = nil
		data.ignoreBeast = nil
		stopGoToPos(familiar, data)
		stopGoToEnt(data)
	end

	if data.ForceStateUpdate then
		data.State = "Move_Default"
		data.ExtraAnim = nil
		data.ExtraAnimState = nil
		data.ForceStateUpdate = nil
	end

	local player = data.player or familiar.Player
	data.riraBonus = 0
	if player:GetPlayerType() == wakaba.Enums.Players.RIRA then
		data.riraBonus = 2 + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
	end
	data.riraBR = (player:GetPlayerType() == wakaba.Enums.Players.RIRA and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT))
	data.lullabyPower = player:GetTrinketMultiplier(TrinketType.TRINKET_FORGOTTEN_LULLABY) + (data.riraBR and 1 or 0)
	data.bffsPower = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BFFS)
	data.babyBenderPower = player:GetTrinketMultiplier(TrinketType.TRINKET_BABY_BENDER)
	data.easterPower = player:GetCollectibleNum(wakaba.Enums.Collectibles.EASTER_EGG) + (data.riraBR and 5 or 0)
	data.standstill = nil
	data.isSuperpositioned = wakaba:isSuperpositionedPlayer(player)

	local run = false
	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.CHIMAKI_COMMAND)) do
		if callback.Param == data.State then
			callback.Function(callback.Mod, familiar, familiar.Player, spr, data, data.State)
			run = true
		end
	end
	if not run and data.State == "Move_Default" then
		defaultMove(familiar, data, spr)
	end

	if not data.ExtraAnim then
		wakaba:AnimateWalkFrameSpeed(spr, familiar.Velocity, "walk", false, false, "idle")
	elseif spr:IsFinished(data.ExtraAnim) or (data.ExtraAnimState and data.State ~= data.ExtraAnimState) then
		data.ExtraAnim = nil
	end

	local path, targ, speed

	if data.targetEnt and (not data.targetEnt:Exists() or data.targetEnt:IsDead()) then
		data.targetEnt = nil
	end
	if data.State == "Chimaki_Rest" then
		local threshold = 16 // (data.lullabyPower + 1)
		local rockThreshold = 9 // (data.lullabyPower + 1)
		data.FrameCount = data.FrameCount + 1
		if data.evadeEnemy and data.evadeEnemy:Exists() and not data.evadeEnemy:IsDead() then
			data.standstill = true

			if data.FrameCount > threshold then
				data.State = "Move_Default"
				data.evadeEnemy = nil
				data.FrameCount = 0
				if data.dummy then
					data.dummy:Remove()
					data.dummy = nil
				end
				data.rockCooldown = rockThreshold
			end
		else
			data.FrameCount = 0
			data.State = "Move_Default"
			data.evadeEnemy = nil
			data.rockCooldown = rockThreshold
		end
	elseif data.targetEnt then
		targ = data.targetEntOffset + data.targetEnt.Position
		local sind, tind = room:GetGridIndex(familiar.Position), room:GetGridIndex(targ)

		path = wakaba:GeneratePathAStar(sind, tind, GetValidGridCollisions(data.groundMove))

		speed = data.targetEntSpeed
	elseif data.targetPos then
		targ = data.targetPos

		local sind, tind = room:GetGridIndex(familiar.Position), room:GetGridIndex(targ)

		path = wakaba:GeneratePathAStar(sind, tind, GetValidGridCollisions(data.groundMove))
		speed = data.gotoSpeed * math.min(1, targ:Distance(familiar.Position) / 60 + 0.5)

		if familiar.Position:Distance(data.targetPos) < data.gotoDist then
			data.targetPos = nil
			data.standstill = true
		end
	end

	local isBeast
	if isc:inBeastRoom() then
		path = {}
		isBeast = not data.ignoreBeast
	end

	if (targ and (not data.prevTarg or targ:DistanceSquared(data.prevTarg) > 50)) or (path and #path ~= data.prevPathLength) then
		data.PathIndex = 1
	end

	if data.standstill or not (targ and path) then
		local l = familiar.Velocity:LengthSquared()
		if l < 0.01 then
			familiar.Velocity = Vector.Zero
		else
			familiar:MultiplyFriction(0.8)
		end
	elseif #path == 0 then
		familiar.Velocity = familiar.Velocity + (targ - familiar.Position):Resized(speed * 0.2)
		familiar:MultiplyFriction(0.8)
	else
		wakaba:FollowPath(familiar, speed * 0.2, path, true, 0.8, data.groundMove)
	end

	if data.dummy then
		data.dummy.Position = familiar.Position
		data.dummy.Velocity = familiar.Velocity
	end

	if data.rockCooldown > 0 then
		data.rockCooldown = data.rockCooldown - 1
	end
	if data.lightCooldown > 0 then
		data.lightCooldown = data.lightCooldown - 1
	end

	if not wakaba:has_value(chimaki.busyStates, data.State) then -- action select
		data.PrevCommand = Isaac.RunCallback(wakaba.Callback.EVALUATE_CHIMAKI_COMMAND, familiar, spr, data, player)
		if data.PrevCommand then
			data.State = data.PrevCommand .. ""
		end
		--revel.virgil.chooseState(familiar, spr, data)
	end

	data.prevTarg = targ
	if path then data.prevPathLength = #path end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_Chimaki, wakaba.Enums.Familiars.CHIMAKI)
--#endregion

--#region
-- 치마키 서포트:
--- 공용 :
---- 주변의 트롤 폭탄을 일반 폭탄으로 변경
local function getTrollBombs(familiar, data, player, range)
	local room = wakaba.G:GetRoom()
	range = range or 150
	local badbombs = {}
	for _, v in ipairs(isc:getBombs()) do
		if (v.Variant == BombVariant.BOMB_TROLL or v.Variant == BombVariant.BOMB_SUPERTROLL or v.Variant == BombVariant.BOMB_GOLDENTROLL or v.Variant == BombVariant.BOMB_GIGA) and v.Position:Distance(player.Position) < range then
			local sind, tind = room:GetGridIndex(familiar.Position), room:GetGridIndex(v.Position)

			path = wakaba:GeneratePathAStar(sind, tind, GetValidGridCollisions(data.groundMove))
			if path then
				table.insert(badbombs, v)
			end
		end
	end
	return badbombs
end
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_CHIMAKI_COMMAND, -400, function(_, ent, spr, data)
	local room = wakaba.G:GetRoom()
	--if not room:IsClear() then return end
	local badbombs = getTrollBombs(ent, data, data.player)

	if #badbombs ~= 0 then
		local rng = data.chimakiRng
		data.TrollBomb = badbombs[rng:RandomInt(#badbombs) + 1]
		goToEnt(data.TrollBomb, ent, data, 13)
		return "Command_ConvertTrollBombs"
	end
end)
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_CHIMAKI_COMMAND, 400, function(_, ent, spr, data)
	local room = wakaba.G:GetRoom()
	--if not room:IsClear() then return end
	local badbombs = getTrollBombs(ent, data, data.player, 2000)

	if #badbombs ~= 0 then
		local rng = data.chimakiRng
		data.TrollBomb = badbombs[rng:RandomInt(#badbombs) + 1]
		goToEnt(data.TrollBomb, ent, data, 8)
		return "Command_ConvertTrollBombs"
	end
end)
wakaba:AddCallback(wakaba.Callback.CHIMAKI_COMMAND, function(_, familiar, player, spr, data)
	player = player or Isaac.GetPlayer()
	local level = wakaba.G:GetLevel()
	if (data.TrollBomb and data.TrollBomb:Exists() and not data.TrollBomb:IsDead()) or spr:IsPlaying("kyuu") then
		if data.TrollBomb and familiar.Position:Distance(data.TrollBomb.Position) < 16 then
			local e = data.TrollBomb
			if e.Variant == BombVariant.BOMB_GOLDENTROLL then
				TryChimakiSound(wakaba.Enums.SoundEffects.CHIMAKI_KYUU)
				playExtraAnim("kyuu", nil, familiar, spr, data)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, e.Position, Vector.Zero, nil)
				data.TrollBomb:Remove()
				data.TrollBomb = nil
				data.ForceStateUpdate = #getTrollBombs(familiar, data, player) > 0
			elseif e.Variant == BombVariant.BOMB_GIGA then
				TryChimakiSound(wakaba.Enums.SoundEffects.CHIMAKI_KYUU)
				playExtraAnim("kyuu", nil, familiar, spr, data)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, e.Position, Vector.Zero, nil)
				data.TrollBomb:Remove()
				data.TrollBomb = nil
				data.ForceStateUpdate = #getTrollBombs(familiar, data, player) > 0
			elseif e.Variant == BombVariant.BOMB_SUPERTROLL then
				TryChimakiSound(wakaba.Enums.SoundEffects.CHIMAKI_KYUU)
				playExtraAnim("kyuu", nil, familiar, spr, data)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK, e.Position, Vector.Zero, nil)
				data.TrollBomb:Remove()
				data.TrollBomb = nil
				data.ForceStateUpdate = #getTrollBombs(familiar, data, player) > 0
			else
				TryChimakiSound(wakaba.Enums.SoundEffects.CHIMAKI_KYUU)
				playExtraAnim("kyuu", nil, familiar, spr, data)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, e.Position, Vector.Zero, nil)
				data.TrollBomb:Remove()
				data.TrollBomb = nil
				data.ForceStateUpdate = #getTrollBombs(familiar, data, player) > 0
			end
		end
		if spr:IsFinished("kyuu") then
			data.ForceStateUpdate = #getTrollBombs(familiar, data, player) > 0
			data.State = "Move_Default"
			data.TrollBomb = nil
		end
	else
		data.ForceStateUpdate = #getTrollBombs(familiar, data, player) > 0
		data.State = "Move_Default"
	end

end, "Command_ConvertTrollBombs")
--#endregion

--#region
--- 스테이지 입장 시 :
---- 일정 확률로 저주 해제, XL 저주 제외
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_CHIMAKI_COMMAND, -399, function(_, ent, spr, data)
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	local curses = level:GetCurses()
	local player = data.player
	local pData = player:GetData()
	if not room:IsClear() then return end
	if data.bypassCurseCheck then
		return "Command_RemoveCurse"
	end
	if curses > 0 and curses & ~LevelCurse.CURSE_OF_LABYRINTH > 0 then
		if data.curseRemoveTries and data.curseRemoveTries > 0 then

			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.CHIMAKI)

			local basicChance = 0.4
			local parLuck = 8
			local maxChance = 1 - basicChance

			local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck, parLuck, maxChance), data.curseRemoveTries)
			data.curseRemoveTries = nil
			local result = rng:RandomFloat()
			local passed = result < chance
			wakaba.Log("Chimaki remove curse result:",result,"/",chance)
			if passed then
				data.bypassCurseCheck = true
				playExtraAnim("kyuu", nil, ent, spr, data)
				return "Command_RemoveCurse"
			end
		end
	end
end)
wakaba:AddCallback(wakaba.Callback.CHIMAKI_COMMAND, function(_, familiar, player, spr, data)
	player = player or Isaac.GetPlayer()
	local level = wakaba.G:GetLevel()
	--print(GetPtrHash(familiar), GetPtrHash(player), GetPtrHash(spr), data, player:GetPlayerType())
	if not wakaba:IsAnimOn(spr, ("kyuu")) then
		playExtraAnim("kyuu", nil, ent, spr, data)
	elseif spr:IsPlaying("kyuu") then
		data.standstill = true
	end
	if spr:IsFinished("kyuu") then
		--print("Finished")
		data.bypassCurseCheck = nil
		data.State = "Chimaki_Rest"
		stopGoToEnt(data)
	elseif spr:IsEventTriggered("kyuu") then
		--print("Event Triggered")
		TryChimakiSound(wakaba.Enums.SoundEffects.CHIMAKI_KYUU)
		level:RemoveCurses(level:GetCurses() & ~LevelCurse.CURSE_OF_LABYRINTH)
		for i = 0, 3 do
			local laser = EntityLaser.ShootAngle(LaserVariant.LIGHT_BEAM, familiar.Position, i * 90, 3, Vector(0, -20), familiar)
			laser.Parent = familiar
			laser.CollisionDamage = 0
		end
		--data.thrownRockEnemy = revel.virgil.throwRock(familiar, data.evadeEnemy.Position, true, false, 10)
	end

end, "Command_RemoveCurse")
--#endregion

--#region

	--- 비전투 시 :
	---- 열쇠 1개로 메가 체스트 완전 오픈
--[[
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_CHIMAKI_COMMAND, -349, function(_, ent, spr, data)
	local room = wakaba.G:GetRoom()
	local player = data.player
	if player:GetNumKeys() <= 1 and not player:HasGoldenKey() then return end
	if not room:IsClear() then return end
	local megachests = {}
	for _, v in ipairs(isc:getEntities(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_MEGACHEST)) do
		if v.SubType > 0 and v.Position:Distance(data.player.Position) < 240 then
			table.insert(megachests, v:ToPickup())
		end
	end

	if #megachests ~= 0 then
		local rng = data.chimakiRng
		data.MegaChest = megachests[rng:RandomInt(#megachests) + 1]
		goToEnt(data.MegaChest, ent, data, nil)
		return "Command_MegaChest"
	end
end)
wakaba:AddCallback(wakaba.Callback.CHIMAKI_COMMAND, function(_, familiar, player, spr, data)
	player = player or Isaac.GetPlayer()
	local level = wakaba.G:GetLevel()
	if (data.MegaChest and data.MegaChest:Exists() and not data.MegaChest:IsDead()) or spr:IsPlaying("kyuu") then
		if data.MegaChest and data.MegaChest.SubType > 0 and familiar.Position:Distance(data.MegaChest.Position) < 16 then
			local e = data.MegaChest
			TryChimakiSound(wakaba.Enums.SoundEffects.CHIMAKI_KYUU)
			playExtraAnim("kyuu", nil, familiar, spr, data)
			e.OptionsPickupIndex = 0
			if e:TryOpenChest(player) and not player:HasGoldenKey() then
				player:AddKeys(-1)
			end
		end
		if spr:IsFinished("kyuu") then
			data.State = "Move_Default"
			data.MegaChest = nil
		end
	else
		data.State = "Move_Default"
	end

end, "Command_MegaChest")
 ]]
--#endregion

--#region

--- 전투 시 :
---- 자폭 파리 소환, 모든 자폭파리 타겟팅
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_CHIMAKI_COMMAND, -249, function(_, ent, spr, data)
	if data.PrevCommand == "Command_Locust" then return end
	local room = wakaba.G:GetRoom()
	local blueflies = {}
	local enemies = {}
	for _, v in ipairs(isc:getAliveNPCs(-1, -1, -1, true)) do
		if wakaba:IsActiveVulnerableEnemy(v) then
			table.insert(enemies, v)
		end
	end
	if #blueflies > 0 and #enemies > 0 then
		return "Command_Locust"
	end
end)
wakaba:AddCallback(wakaba.Callback.CHIMAKI_COMMAND, function(_, familiar, player, spr, data)
	player = player or Isaac.GetPlayer()
	if not wakaba:IsAnimOn(spr, ("kyuu")) then
		playExtraAnim("kyuu", nil, ent, spr, data)
		for _, e in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY)) do
			if e:ToFamiliar() then
				local enemy = wakaba:findRandomEnemy(e, player:GetCollectibleRNG(wakaba.Enums.Collectibles.CHIMAKI), true)
				if enemy then
					e.Target = enemy
				end
			end
		end
		stopGoToEnt(data)
	end
	if spr:IsFinished("kyuu") then
		data.State = "Chimaki_Rest"
		--data.TrollBomb = nil
	end
end, "Command_Locust")
--#endregion

--#region

---- 탄환을 향해 3방향 파란 불꽃 발사
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_CHIMAKI_COMMAND, -248, function(_, ent, spr, data)
	if data.PrevCommand == "Command_BlueFlame" then return end
	local nearbyProjs = {}
	for _, v in ipairs(isc:getEntities(EntityType.ENTITY_PROJECTILE, -1, -1, true)) do
		if v:ToProjectile() and not v:ToProjectile():HasProjectileFlags(ProjectileFlags.CANT_HIT_PLAYER) and (v.Position:Distance(ent.Position) < 120) then
			table.insert(nearbyProjs, v)
		end
	end

	if #nearbyProjs ~= 0 then
		local rng = data.chimakiRng

		local targ
		local shortestLength = 1000000
		for _, e in ipairs(nearbyProjs) do
			if e.Position:Distance(ent.Position) <= shortestLength then
				shortestLength = e.Position:Distance(ent.Position)
				targ = e
			end
		end
		data.Projectile = targ
		--data.Projectile = nearbyProjs[rng:RandomInt(#nearbyProjs) + 1]
		playExtraAnim("kyuu", nil, ent, spr, data)
		--goToEnt(data.Projectile, ent, data, 8)
		return "Command_BlueFlame"
	end
end)
wakaba:AddCallback(wakaba.Callback.CHIMAKI_COMMAND, function(_, familiar, player, spr, data)
	player = player or Isaac.GetPlayer()

	if data.targetEnt and data.targetEnt.Position:DistanceSquared(familiar.Position) < 14400 and not wakaba:IsAnimOn(spr, "kyuu") then
		playExtraAnim("kyuu", nil, familiar, spr, data)
	elseif spr:IsPlaying("kyuu") then
		data.standstill = true
	elseif not data.targetEnt then
		data.State = "Move_Default"
	end

	if spr:IsFinished("kyuu") then
		--print("Finished")
		data.State = "Chimaki_Rest"
		data.FrameCount = 0
		data.Projectile = nil
		stopGoToEnt(data)
	elseif spr:IsEventTriggered("kyuu") then
		--print("Event Triggered")
		TryChimakiSound(wakaba.Enums.SoundEffects.CHIMAKI_KYUU)
		wakaba:Chimaki_CommandShootFlames(familiar, data.Projectile.Position, true, false, 1)
		wakaba:Chimaki_CommandKnife(familiar, data.Projectile.Position, true, false, 1)
		--data.thrownRockEnemy = revel.virgil.throwRock(familiar, data.evadeEnemy.Position, true, false, 10)
	end
end, "Command_BlueFlame")
--#endregion

--#region

---- 유도 눈물 발사
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_CHIMAKI_COMMAND, -246, function(_, ent, spr, data)
	if data.PrevCommand == "Command_ShootTears" or data.rockCooldown > 0 then return end
	local room = wakaba.G:GetRoom()
	local enemies = {}
	for _, v in ipairs(isc:getAliveNPCs(-1, -1, -1, true)) do
		if (wakaba:IsActiveVulnerableEnemy(v) and v.Position:Distance(ent.Position) < 320 and room:IsPositionInRoom(v.Position, 0)) then
			table.insert(enemies, v)
		end
	end
	if #enemies > 0 then
		local rng = data.chimakiRng
		local targ
		local shortestLength = 1000000
		for _, e in ipairs(enemies) do
			if e.Position:Distance(ent.Position) <= shortestLength then
				shortestLength = e.Position:Distance(ent.Position)
				targ = e
			end
		end

		local sind, tind = room:GetGridIndex(ent.Position), room:GetGridIndex(targ.Position)
		path = wakaba:GeneratePathAStar(sind, tind)
		if not path then
			data.transferTarget = targ
			return
		end -- skip to LightJump

		if targ.Position:DistanceSquared(ent.Position) < 25600 then -- 160^2, aka 4 tiles
			playExtraAnim("kyuu_three", nil, ent, spr, data)
		else
			goToEnt(targ, ent, data)
		end

		data.evadeEnemy = targ
		return "Command_ShootTears"
	end
end)
wakaba:AddCallback(wakaba.Callback.CHIMAKI_COMMAND, function(_, familiar, player, spr, data)
	player = player or Isaac.GetPlayer()

	if data.targetEnt and data.targetEnt.Position:DistanceSquared(familiar.Position) < 25600 and not wakaba:IsAnimOn(spr, "kyuu_three") then
		playExtraAnim("kyuu_three", nil, familiar, spr, data)
	elseif spr:IsPlaying("kyuu_three") then
		data.standstill = true
	elseif not data.targetEnt then
		data.State = "Move_Default"
	end

	if spr:IsFinished("kyuu_three") then
		--print("Finished")
		data.State = "Chimaki_Rest"
		data.FrameCount = 0
		stopGoToEnt(data)
	elseif spr:IsEventTriggered("shoot_tears") then
		--print("Event Triggered")
		TryChimakiSound(wakaba.Enums.SoundEffects.CHIMAKI_TRIPLE)
		if data.easterPower >= 5 then
			wakaba:Chimaki_CommandShootLasers(familiar, data.evadeEnemy.Position, true, false, 1)
		else
			wakaba:Chimaki_CommandShootTears(familiar, data.evadeEnemy.Position, true, false, 1)
		end
		spr.FlipX = familiar.Position.X > data.evadeEnemy.Position.X
		--data.thrownRockEnemy = revel.virgil.throwRock(familiar, data.evadeEnemy.Position, true, false, 10)
	end

end, "Command_ShootTears")
--#endregion

--#region

---- 먼 거리 점프, 점프 중 그 위치에 빛줄기 소환 (이후 추가 예정)
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_CHIMAKI_COMMAND, -245, function(_, ent, spr, data, player)
	local room = wakaba.G:GetRoom()
	if data.PrevCommand == "Command_HolyLightJump" or room:GetFrameCount() < 1 or data.lightCooldown > 0 then return end
	local enemies = {}
	if data.transferTarget then
		table.insert(enemies, data.transferTarget)
		data.transferTarget = nil
		goto skipLightCheck
	end
	for _, v in ipairs(isc:getAliveNPCs(-1, -1, -1, true)) do
		if (wakaba:IsActiveVulnerableEnemy(v) and v.Position:Distance(ent.Position) >= 320 and room:IsPositionInRoom(v.Position, 0)) then
			table.insert(enemies, v)
		end
	end
	::skipLightCheck::
	if #enemies > 0 then
		local rng = data.chimakiRng
		local targ = enemies[rng:RandomInt(#enemies) + 1]
		ent.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
		data.groundMove = false
		data.ignoreBeast = true
		if data.babyBenderPower > 0 then
			goToEnt(targ, ent, data, data.babyBenderPower * data.speed * 1.4)
			local eff = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TARGET, 0, targ.Position, Vector.Zero, ent):ToEffect()
			eff.Parent = targ
			eff:FollowParent(targ)
			eff:SetTimeout(200)
			data.evadeEnemy = targ
			data.holyLightTargetEnt = eff
		else
			goToPos(targ.Position, ent, data, data.speed * 1.4, 0, true)
			local eff = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TARGET, 0, targ.Position, Vector.Zero, ent):ToEffect()
			eff:SetTimeout(200)
			data.holyLightTargetEnt = eff
		end
		playExtraAnim("long_fly_start", nil, ent, spr, data)
		--data.evadeEnemy = targ
		return "Command_HolyLightJump"
	end
end)
function wakaba:Chimaki_CommandSpawnBeam(player, position, power)
	local beam = Isaac.Spawn(1000, EffectVariant.CRACK_THE_SKY, 1, position, Vector.Zero, player):ToEffect()
	beam.Parent = player
	beam.CollisionDamage = player.Damage * 3 * power
	beam:Update()
	return beam
end
function wakaba:Chimaki_CommandSpawnLaserRing(player, position, power)
	local laser = Isaac.Spawn(EntityType.ENTITY_LASER, LaserVariant.THIN_RED, LaserSubType.LASER_SUBTYPE_RING_PROJECTILE, position, Vector.Zero, familiar):ToLaser()
	laser.Timeout = 8
	laser.DisableFollowParent = true
	laser.TearFlags = TearFlags.TEAR_RAINBOW | TearFlags.TEAR_HOMING
	laser.Parent = player
	laser.CollisionDamage = player.Damage * 3 * power
	laser.Radius = math.max(math.min(30.0), 0.001)
	laser:Update()
	return laser
end
wakaba:AddCallback(wakaba.Callback.CHIMAKI_COMMAND, function(_, familiar, player, spr, data)
	player = player or Isaac.GetPlayer()
	local room = wakaba.G:GetRoom()
	if spr:IsPlaying("long_fly_start") then
		if familiar.FrameCount % (8 // (1 + data.lullabyPower)) == 0 then
			local light = wakaba:Chimaki_CommandSpawnBeam(player, familiar.Position, 1 + data.bffsPower + data.riraBonus + (data.easterPower * 0.02))
			if data.easterPower >= 5 then
				local laser = wakaba:Chimaki_CommandSpawnLaserRing(player, familiar.Position, 1 + data.bffsPower + data.riraBonus + (data.easterPower * 0.02))
			end
		end
		spr.FlipX = familiar.Velocity.X < 0
		if spr:IsEventTriggered("next") then
			playExtraAnim("long_fly_loop", nil, ent, spr, data)
		end
	elseif spr:IsPlaying("long_fly_loop") then
		data.longFlyCount = (data.longFlyCount or 0) + 1
		if familiar.FrameCount % (8 // (1 + data.lullabyPower)) == 0 then
			local light = wakaba:Chimaki_CommandSpawnBeam(player, familiar.Position, 1 + data.bffsPower + data.riraBonus + (data.easterPower * 0.02))
			if data.easterPower >= 5 then
				local laser = wakaba:Chimaki_CommandSpawnLaserRing(player, familiar.Position, 1 + data.bffsPower + data.riraBonus + (data.easterPower * 0.02))
			end
		end
		spr.FlipX = familiar.Velocity.X < 0
		if data.standstill or data.longFlyCount >= 150
			or (data.targetPos and (data.targetPos:Distance(familiar.Position) <= 40 or not room:IsPositionInRoom(data.targetPos, 0)))
			or (data.targetEnt and (data.targetEnt.Position:Distance(familiar.Position) <= 40 or not room:IsPositionInRoom(data.targetEnt.Position, 0)))
		then
			--print("Land")
			playExtraAnim("long_fly_end", nil, ent, spr, data)
		end
	elseif spr:IsPlaying("long_fly_end") then
		if familiar.FrameCount % (8 // (1 + data.lullabyPower)) == 0 then
			local light = wakaba:Chimaki_CommandSpawnBeam(player, familiar.Position, 1 + data.bffsPower + data.riraBonus + (data.easterPower * 0.02))
			if data.easterPower >= 5 then
				local laser = wakaba:Chimaki_CommandSpawnLaserRing(player, familiar.Position, 1 + data.bffsPower + data.riraBonus + (data.easterPower * 0.02))
			end
		end
		spr.FlipX = familiar.Velocity.X < 0
		if data.holyLightTargetEnt and data.holyLightTargetEnt:Exists() then
			data.holyLightTargetEnt:Remove()
			data.holyLightTargetEnt = nil
		end
	elseif not data.targetEnt then
		data.State = "Move_Default"
		familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
		data.groundMove = true
		data.ignoreBeast = nil
		data.lightCooldown = 48
		data.holyLightTargetEnt = nil
	end

	if spr:IsFinished("long_fly_end") then
		--print("Finished")
		data.State = "Chimaki_Rest"
		data.FrameCount = 0
		stopGoToEnt(data)
		stopGoToPos(familiar, data)
		familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
		data.groundMove = true
		data.ignoreBeast = nil
		data.lightCooldown = 48
		data.longFlyCount = nil
	elseif spr:IsEventTriggered("kyuu") then
		--print("Event Triggered")
		TryChimakiSound(wakaba.Enums.SoundEffects.CHIMAKI_KYUU)
		--wakaba:Chimaki_CommandShootTears(familiar, data.evadeEnemy.Position, true, false, 1)
		--data.thrownRockEnemy = revel.virgil.throwRock(familiar, data.evadeEnemy.Position, true, false, 10)
	end

end, "Command_HolyLightJump")
--#endregion





function wakaba:HUD_Chimaki()
	if not wakaba.Flags or not wakaba.Flags.debugCore or not wakaba.Flags.debugChimaki then return end
	local fam
	local fams = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, wakaba.Enums.Familiars.CHIMAKI)
	if #fams > 0 then
		fam = fams[1]
	end
	if fam then
		wakaba.globalHUDSprite:RemoveOverlay()
		local data = fam:GetData()
		wakaba.globalHUDSprite:SetFrame("Chimaki", 0)
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = data.State or "CHIMAKI NOT FOUND",
		}
		return tab
	end
end
wakaba:AddCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, wakaba.HUD_Chimaki)



function wakaba:FamiliarRender_EasterEgg_Chimaki(familiar)
	local data = familiar:GetData()
	if not data.easterPower or data.easterPower < 5 then return end

	local sprite = familiar:GetSprite()
	local tcolor = Color(1, 1, 1, 1, 0, 0, 0)
	tcolor:SetColorize(wakaba.RGB.R/255,wakaba.RGB.G/255,wakaba.RGB.B/255, 0.42)
	local ntcolor = Color.Lerp(tcolor, tcolor, 0.5)
	ntcolor.A = 0.9

	sprite.Color = ntcolor
end
wakaba:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, wakaba.FamiliarRender_EasterEgg_Chimaki, wakaba.Enums.Familiars.CHIMAKI)