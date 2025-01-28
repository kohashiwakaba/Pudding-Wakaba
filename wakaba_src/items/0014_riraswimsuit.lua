--[[
	Rira's Swimsuit (리라의 속옷/수영복) - 패시브
	리라로 Isaac 처치
	연사 +0.3, 10%의 확률로 침수 공격 (행운 38 이상일 때 100%) / 리라의 경우 5%, 행운 19 이상일 때 100%
	침수 공격에 탄막이 닿으면 그 탄막을 빛줄기로 변경
	침수 상태의 적은 침수/산성/레이저 공격에 추가 피해, 불꽃/빨똥 공격에 면역
	P.S. 침수 공격은 돌 종류의 몬스터 즉사
 ]]

local isc = _wakaba.isc

wakaba.AquaInstakillEntities = {
	{EntityType.ENTITY_GIDEON},
	{EntityType.ENTITY_STONEY},
	{EntityType.ENTITY_QUAKEY},
	{EntityType.ENTITY_HARDY},
	{EntityType.ENTITY_STONEHEAD},
	{EntityType.ENTITY_GAPING_MAW},
	{EntityType.ENTITY_BROKEN_GAPING_MAW},
	{EntityType.ENTITY_CONSTANT_STONE_SHOOTER},
	{EntityType.ENTITY_BRIMSTONE_HEAD},
	{EntityType.ENTITY_STONE_EYE},
	{EntityType.ENTITY_QUAKE_GRIMACE},
	{EntityType.ENTITY_QUAKEY},
	{EntityType.ENTITY_HOST, 3}, -- Hard Host
	{EntityType.ENTITY_BLASTER},
	{EntityType.ENTITY_ROCK_SPIDER},
	{EntityType.ENTITY_POKY},
	{EntityType.ENTITY_WALL_HUGGER},
	{EntityType.ENTITY_BALL_AND_CHAIN},
	{EntityType.ENTITY_SPIKEBALL},
	{EntityType.ENTITY_SINGE, 1}, -- Singe's Ball
}

-- Used for Rira's Swimsuit and Black Bean Mochi --
-- Explodes immediately from zipped tears, downgraded into second entry from aqua tears.
wakaba.AquaDowngradeEntities = {
	{{EntityType.ENTITY_GAPER, 2}, {EntityType.ENTITY_GAPER, 0}},
	{{EntityType.ENTITY_GURGLE, 1}, {EntityType.ENTITY_GURGLE, 0}},
	{{EntityType.ENTITY_WILLO, 0}, {EntityType.ENTITY_ATTACKFLY, 0}},
	{{EntityType.ENTITY_WILLO_L2, 0}, {EntityType.ENTITY_FLY_L2, 0}},
	{{EntityType.ENTITY_CLOTTY, 3}, {EntityType.ENTITY_CLOTTY, 0}},
	{{EntityType.ENTITY_DANNY, 1}, {EntityType.ENTITY_DANNY, 0}},
	{{EntityType.ENTITY_BOOMFLY, 3}, {EntityType.ENTITY_BOOMFLY, 0}},
	{{EntityType.ENTITY_FLAMINGHOPPER, 0}, {EntityType.ENTITY_HOPPER, 0}},
	{{EntityType.ENTITY_GYRO, 1}, {EntityType.ENTITY_GYRO, 0}},
	{{EntityType.ENTITY_KNIGHT, 4}, {EntityType.ENTITY_KNIGHT, 0}},
	{{EntityType.ENTITY_ROCK_SPIDER, 2}, {EntityType.ENTITY_ROCK_SPIDER, 0}},
	{{EntityType.ENTITY_FATTY, 2}, {EntityType.ENTITY_FATTY, 0}},
	{{EntityType.ENTITY_SKINNY, 2}, {EntityType.ENTITY_SKINNY, 0}},
}

local sprite = Sprite()
sprite:Load("gfx/ui/wakaba/ui_statusicons.anm2", true)
sprite:Play("Aqua")
wakaba.Status.RegisterStatusEffect(
	"wakaba_AQUA",
	sprite,
	wakaba.Colors.AQUA_ENTITY_COLOR
)

function wakaba:isAquaInstakill(entity)
	for _, dict in ipairs(wakaba.AquaInstakillEntities) do
		if entity.Type == dict[1] then
			if not dict[2] or entity.Variant == dict[2] then
				if not dict[3] or entity.SubType == dict[3] then
					return true
				end
			end
		end
	end
end

local function shouldAlwaysColorWeapon(player)
	return player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) or player:HasWeaponType(WeaponType.WEAPON_LASER) or player:HasWeaponType(WeaponType.WEAPON_KNIFE) or player:HasWeaponType(WeaponType.WEAPON_TECH_X)
end

function wakaba:Cache_RiraSwimsuit(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT) then
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 0.3 * player:GetCollectibleNum(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT) * wakaba:getEstimatedTearsMult(player))
		end
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			if shouldAlwaysColorWeapon(player) then
				player.TearColor = wakaba.Colors.AQUA_WEAPON_COLOR
				local lasercolor = Color(1.3, 1.3, 1.3, 1.0, 0/255, 0/255, 0/255)
				lasercolor:SetColorize(2.2, 2.3, 3.3, 1)
				player.LaserColor = lasercolor
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_RiraSwimsuit)

---@param player EntityPlayer
local function shouldApplyAquaRira(player)
	if player:GetPlayerType() ~= wakaba.Enums.Players.RIRA then return false end
	local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT)
	local count = 1
	local charmBonus = wakaba:getTeardropCharmBonus(player)

	local basicChance = 0.05
	local parLuck = 19
	local maxChance = 1 - basicChance

	local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck + charmBonus, parLuck, maxChance), count)
	return rng:RandomFloat() < chance
end

---@param player EntityPlayer
local function shouldApplyAqua(player)
	local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT)
	local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT) + (player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.RIRAS_BRA) * 2)
	local charmBonus = wakaba:getTeardropCharmBonus(player)

	local basicChance = 0.1
	local parLuck = 38
	local maxChance = 1 - basicChance

	local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck + charmBonus, parLuck, maxChance), count)
	return count > 0 and rng:RandomFloat() < chance
end


function wakaba:EvalTearFlag_RiraSwimsuit(weapon, player, effectTarget)
	if player:HasCollectible(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT) or player:GetPlayerType() == wakaba.Enums.Players.RIRA then
		--print("have coll")
		if weapon and weapon.Type == EntityType.ENTITY_LASER and wakaba:IsLaserColorable(weapon) then -- Epic Fetus lasers
			local lasercolor = Color(1.3, 1.3, 1.3, 1.0, 0/255, 0/255, 0/255)
			lasercolor:SetColorize(2.2, 2.3, 3.3, 1)
			weapon.Color = lasercolor
		end
		if shouldApplyAqua(player) or shouldApplyAquaRira(player) then
			if weapon then
				--print("weapon found!")
				wakaba:AddRicherTearFlags(weapon, wakaba.TearFlag.AQUA)
				if weapon.Type == EntityType.ENTITY_EFFECT and weapon.Variant == EffectVariant.ROCKET then
					--print("fetus found!")
					weapon:GetSprite().Color = wakaba.Colors.AQUA_WEAPON_COLOR
					weapon:GetData().wakaba_ExplosionColor = wakaba.Colors.AQUA_WEAPON_COLOR
				elseif weapon.Type ~= EntityType.ENTITY_LASER then
					weapon.Color = wakaba.Colors.AQUA_WEAPON_COLOR
				end
			else
				wakaba.Status:AddStatusEffect(effectTarget, StatusEffectLibrary.StatusFlag.wakaba_AQUA, 150, EntityRef(player))
			end
		elseif weapon and wakaba:IsLudoTear(weapon, true) then
			wakaba:ClearRicherTearFlags(weapon, wakaba.TearFlag.AQUA)
		end
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, wakaba.EvalTearFlag_RiraSwimsuit)

wakaba:AddCallback(wakaba.Callback.APPLY_TEARFLAG_EFFECT, function(_, effectTarget, player, effectSource)
	if wakaba:isAquaInstakill(effectTarget) then
		effectTarget:Kill()
	elseif effectTarget:HasEntityFlags(EntityFlag.FLAG_ICE) then
		effectTarget.HitPoints = 0
		effectTarget:Update()
		--effectTarget:AddEntityFlags(EntityFlag.FLAG_ICE_FROZEN)
	end
	wakaba.Status:AddStatusEffect(effectTarget, StatusEffectLibrary.StatusFlag.wakaba_AQUA, 150, EntityRef(player))
end, wakaba.TearFlag.AQUA)

local function shouldApplySwordAqua(player)
	return player and player.Type == EntityType.ENTITY_PLAYER and (player:HasCollectible(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT) or player:GetPlayerType() == wakaba.Enums.Players.RIRA )
	and shouldApplyAqua(player) or shouldApplyAquaRira(player)
end

function wakaba:AquaDamage(source, target, data, newDamage, newFlags)
	local returndata = {}
	local num = 0
	local statusData = wakaba.Status:GetStatusEffectData(target, wakaba.Status.StatusFlag.wakaba_AQUA)
	if statusData then
		--print(source.Entity, wakaba:HasRicherTearFlags(source.Entity, wakaba.TearFlag.AQUA))
		if newFlags & DamageFlag.DAMAGE_FIRE > 0
		or newFlags & DamageFlag.DAMAGE_POISON_BURN > 0
		or newFlags & DamageFlag.DAMAGE_POOP > 0
		then
			returndata.sendNewDamage = true
			returndata.newDamage = newDamage * 0.8
		end
		if newFlags & DamageFlag.DAMAGE_LASER > 0
		or newFlags & DamageFlag.DAMAGE_EXPLOSION > 0
		or (source.Entity and wakaba:HasRicherTearFlags(source.Entity, wakaba.TearFlag.AQUA))
		or (source.Entity and source.Type == EntityType.ENTITY_PLAYER and shouldApplySwordAqua(source.Entity:ToPlayer())) -- Spirit Sword
		then
			returndata.sendNewDamage = true
			returndata.newDamage = newDamage * 1.5
		end
		if source.Entity then
			local convertedEntity = source.Entity:ToPlayer() or source.Entity:ToTear() or source.Entity:ToBomb() or source.Entity:ToKnife()
			if convertedEntity and convertedEntity.TearFlags and convertedEntity.TearFlags & TearFlags.TEAR_ICE > 0 then
				returndata.newFlags = newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR
				returndata.sendNewDamage = true
				if target:IsBoss() then
					returndata.newDamage = newDamage * 4
				else
					returndata.newDamage = target.HitPoints + 1
				end
			end
		end
		if returndata.sendNewDamage then
			SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES)
		end
	end
	return returndata
end