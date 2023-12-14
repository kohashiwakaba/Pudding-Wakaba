--[[
	Magma Blade (마그마 블레이드) - 패시브(Passive)
	연사 감소, 공격력 증가
	공격 시 불꽃 블레이드를 추가로 휘두름
	- 눈물/섹션 : 눈물 위치에 짧은 화염을 남김
	- 레이저/혈사 : 레이저 범위에 짧은 화염을 남김
	- 식칼 : 발사된 상태에서 짧은 화염을 남김, 공격력 증가
	- 스피릿 소드 : 투사체 or 회전 공격 시 360도 방향으로 짧은 화염을 남김
	- 루도(공격 속성 무관) : 공격 위치에서 짧은 화염을 남김
	- 포가튼 뼈 : 공격방향으로 여러 개의 짧은 화염을 남김
	- 에픽 : 폭발한 위치에서 360도 방향으로 짧은 화염을 남김
 ]]

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




