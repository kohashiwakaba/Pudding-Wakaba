--[[
	Black Bean Mochi - 패시브(Passive)
	적 처치 시 폭발
 ]]
local isc = _wakaba.isc

local sprite = Sprite()
sprite:Load("gfx/ui/wakaba/ui_statusicons.anm2", true)
sprite:Play("Zipped")
wakaba.Status.RegisterStatusEffect(
	"wakaba_ZIPPED",
	sprite,
	wakaba.Colors.ZIPPED_ENTITY_COLOR
)

local function shouldAlwaysColorWeapon(player)
	return player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) or player:HasWeaponType(WeaponType.WEAPON_LASER) or player:HasWeaponType(WeaponType.WEAPON_KNIFE) or player:HasWeaponType(WeaponType.WEAPON_TECH_X)
end

function wakaba:Cache_BlackBeanMochi(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI) then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 0.5
		end
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			if shouldAlwaysColorWeapon(player) then
				player.TearColor = wakaba.Colors.ZIPPED_WEAPON_COLOR
				player.LaserColor = wakaba.Colors.ZIPPED_LASER_COLOR
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_BlackBeanMochi)

---@param player EntityPlayer
local function shouldApplyZipped(player)
	local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI)
	local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI)
	local charmBonus = wakaba:getTeardropCharmBonus(player)

	local basicChance = 0.1
	local parLuck = 16
	local maxChance = 1 - basicChance

	local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck + charmBonus, parLuck, maxChance), count)
	return rng:RandomFloat() < chance
end

function wakaba:EvalTearFlag_BlackBeanMochi(weapon, player, effectTarget)
	if player:HasCollectible(wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI) then
		--print("have coll")
		if weapon and weapon.Type == EntityType.ENTITY_LASER and wakaba:IsLaserColorable(weapon) then -- Epic Fetus lasers
			weapon.Color = wakaba.Colors.ZIPPED_LASER_COLOR
		end
		if shouldApplyZipped(player) then
			if weapon then
				--print("weapon found!")
				wakaba:AddRicherTearFlags(weapon, wakaba.TearFlag.ZIPPED)
				if weapon.Type == EntityType.ENTITY_EFFECT and weapon.Variant == EffectVariant.ROCKET then
					--print("fetus found!")
					weapon:GetSprite().Color = wakaba.Colors.ZIPPED_WEAPON_COLOR
					weapon:GetData().wakaba_ExplosionColor = wakaba.Colors.ZIPPED_WEAPON_COLOR
				elseif weapon.Type ~= EntityType.ENTITY_LASER then
					weapon.Color = wakaba.Colors.ZIPPED_WEAPON_COLOR
				end
			else
				wakaba.Status:AddStatusEffect(effectTarget, StatusEffectLibrary.StatusFlag.wakaba_ZIPPED, 90, EntityRef(player))
			end
		elseif weapon and wakaba:IsLudoTear(weapon, onlyTear) then
			wakaba:ClearRicherTearFlags(weapon, wakaba.TearFlag.ZIPPED)
		end
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, wakaba.EvalTearFlag_BlackBeanMochi)

wakaba:AddCallback(wakaba.Callback.APPLY_TEARFLAG_EFFECT, function(_, effectTarget, player, effectSource)
	wakaba.Status:AddStatusEffect(effectTarget, StatusEffectLibrary.StatusFlag.wakaba_ZIPPED, 90, EntityRef(player))
end, wakaba.TearFlag.ZIPPED)

---@param npc EntityNPC
function wakaba:NPCDeath_BlackBeanMochi(entity)
	if not entity:ToNPC() then return end
	local npc = entity:ToNPC()
	if wakaba.Status:HasStatusEffect(entity, wakaba.Status.StatusFlag.wakaba_ZIPPED) then
		local statusData = wakaba.Status:GetStatusEffectData(npc, wakaba.Status.StatusFlag.wakaba_ZIPPED)
		local source = statusData.Source
		local player = source.Entity and source.Entity:ToPlayer()
		if source and player then
			local enemies = isc:getNPCs()
			for i, e in ipairs(enemies) do
				if wakaba:EntitiesAreWithinRange(npc, e, 75) then
					wakaba.Status:AddStatusEffect(e, StatusEffectLibrary.StatusFlag.wakaba_ZIPPED, 90, source)
				end
			end
			local flags = wakaba:IsLunatic() and 0 or player:GetBombFlags()
			wakaba.G:BombExplosionEffects(npc.Position, 15, flags, Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION | (not wakaba:IsLunatic() and DamageFlag.DAMAGE_IGNORE_ARMOR or 0))
			--print("Explode!")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, wakaba.NPCDeath_BlackBeanMochi)