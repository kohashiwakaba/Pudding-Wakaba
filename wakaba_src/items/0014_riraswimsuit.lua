--[[
	Rira's Swimsuit (리라의 속옷/수영복) - 패시브
	리라로 Isaac 처치
	연사 +0.3, 10%의 확률로 침수 공격 (행운 38 이상일 때 100%) / 리라의 경우 5%, 행운 19 이상일 때 100%
	침수 공격에 탄막이 닿으면 그 탄막을 빛줄기로 변경
	침수 상태의 적은 침수/산성/레이저 공격에 추가 피해, 불꽃/빨똥 공격에 면역
	P.S. 침수 공격은 돌 종류의 몬스터 즉사
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

wakaba.AquaInstakillEntities = {
	{EntityType.ENTITY_GIDEON},
	{EntityType.ENTITY_STONEY},
	{EntityType.ENTITY_STONEHEAD},
	{EntityType.ENTITY_GAPING_MAW},
	{EntityType.ENTITY_BROKEN_GAPING_MAW},
	{EntityType.ENTITY_CONSTANT_STONE_SHOOTER},
	{EntityType.ENTITY_BRIMSTONE_HEAD},
	{EntityType.ENTITY_STONE_EYE},
	{EntityType.ENTITY_QUAKE_GRIMACE},
	{EntityType.ENTITY_QUAKEY},
}

local sprite = Sprite()
sprite:Load("gfx/ui/wakaba/ui_statusicons.anm2", true)
sprite:Play("Aqua")
wakaba:RegisterStatusEffect("AQUA", sprite, {
	CanStack = false,
	EntityColor = wakaba.Colors.AQUA_ENTITY_COLOR,
	VasculitisFlag = wakaba.TearFlag.AQUA,
})

local function isAquaInstakill(entity)
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
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then return true end
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
				--print("passed")
				wakaba:AddStatusEffect(effectTarget, wakaba.StatusEffect.AQUA, 150, player)
			end
		elseif weapon and wakaba:IsLudoTear(weapon, true) then
			wakaba:ClearRicherTearFlags(weapon, wakaba.TearFlag.AQUA)
		end
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, wakaba.EvalTearFlag_RiraSwimsuit)

wakaba:AddCallback(wakaba.Callback.APPLY_TEARFLAG_EFFECT, function(_, effectTarget, player, effectSource)
	if isAquaInstakill(effectTarget) then
		effectTarget:Kill()
	end
	if wakaba:CanApplyStatusEffect(effectTarget) then
		wakaba:AddStatusEffect(effectTarget, wakaba.StatusEffect.AQUA, 150, player)
		if effectTarget:IsBoss() then
			wakaba:AddStatusCooldown(effectTarget)
		end
	end
end, wakaba.TearFlag.AQUA)

local function shouldApplySwordAqua(player)
	return player and player.Type == EntityType.ENTITY_PLAYER (player:HasCollectible(wakaba.Enums.Collectibles.RIRAS_SWIMSUIT) or player:GetPlayerType() == wakaba.Enums.Players.RIRA )
	and shouldApplyAqua(player) or shouldApplyAquaRira(player)
end

function wakaba:AquaDamage(source, target, data, newDamage, newFlags)
	local returndata = {}
	local num = 0
	local statusData = wakaba:HasStatusEffect(target, wakaba.StatusEffect.AQUA)
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
		or (source.Entity and source.Type == EntityType.ENTITY_PLAYER and shouldApplySwordAqua(source.Entity)) -- Spirit Sword
		then
			returndata.sendNewDamage = true
			returndata.newDamage = newDamage * 1.5
		end
	end
	return returndata
end