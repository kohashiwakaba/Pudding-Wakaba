local isc = require("wakaba_src.libs.isaacscript-common")

local function canActivateMagmaBlade(player)
	return player:HasCollectible(wakaba.Enums.Collectibles.MAGMA_BLADE)	or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.MAGMA_BLADE)
end

local function getMagmaBladeMultiplier(player)
	return player:GetCollectibleNum(wakaba.Enums.Collectibles.MAGMA_BLADE)	or player:GetEffects():GetCollectibleEffecNum(wakaba.Enums.Collectibles.MAGMA_BLADE)
end

function wakaba:Cache_MagmaBlade(player, cacheFlag)
  if canActivateMagmaBlade(player) then
		if not player:HasWeaponType(WeaponType.WEAPON_TEARS) then
			if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage * (1 + getMagmaBladeMultiplier(player))
			end
			if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
				player.ShotSpeed = 0.6
			end
		end
    if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_BURN
    end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_MagmaBlade)

local function fireMagmaBlade(tear)
	local player = tear.SpawnerEntity:ToPlayer()
	local tearParams = player:GetTearHitParams()
	local dmg = tearParams.TearDamage
	local color = tearParams.TearColor
	local flags = tearParams.TearFlags


end

function wakaba:FireTearVLate_MagmaBlade(tear)
	if --[[ isc:isTearFromPlayer(tear) ]] true then
		local player = wakaba:getPlayerFromTear(tear)
		if canActivateMagmaBlade(player)
		then
			--tear:Remove()
			tear:ChangeVariant(TearVariant.PUPULA)
			if player.TearFlags & TearFlags.TEAR_EXPLOSIVE <= 0 then
				tear:ClearTearFlags(TearFlags.TEAR_EXPLOSIVE)
			end
			tear.CollisionDamage = tear.CollisionDamage / 4
			tear.Scale = tear.Scale * 3
			tear:ResetSpriteScale()
			SFXManager():Play(SoundEffect.SOUND_CANDLE_LIGHT)
			wakaba:FireClub(player, player:GetFireDirection(), wakaba.ClubOptions.MagmaBlade)
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, wakaba.FireTearVLate_MagmaBlade)
--wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_TEAR_INIT_VERY_LATE, wakaba.FireTearVLate_MagmaBlade)




