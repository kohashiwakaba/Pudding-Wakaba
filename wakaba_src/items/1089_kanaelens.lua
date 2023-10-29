--[[
	Kanae Lens (카나에 렌즈) - 패시브(Passive)
	공격력 x1.65, 왼쪽 눈에 유도 효과 부여
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:Cache_KanaeLens(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.KANAE_LENS) then
		local power = player:GetCollectibleNum(wakaba.Enums.Collectibles.KANAE_LENS)
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (1.65 ^ power)
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			if not player:HasWeaponType(WeaponType.WEAPON_TEARS) or power >= 2 then
				player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING
			end
		end
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			if not player:HasWeaponType(WeaponType.WEAPON_TEARS) or power >= 2 then
				player.TearColor = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549)
				player.LaserColor = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_KanaeLens)

function wakaba:FireTear_KanaeLens(tear)
	if not tear.Parent then
		return
	end
	local player = tear.Parent:ToPlayer()
	if player and player:HasCollectible(wakaba.Enums.Collectibles.KANAE_LENS) and player:GetCollectibleNum(wakaba.Enums.Collectibles.KANAE_LENS) == 1 and tear.CanTriggerStreakEnd then
		local fireDirection = player:GetAimDirection()
		if fireDirection.X == 0.0 and fireDirection.Y == 0.0 then
			fireDirection = tear.Velocity:Normalized()
		end
		local rightward = Vector(fireDirection.Y, -fireDirection.X)
		local positionOffset = tear.Position - player.Position - tear.Velocity

		if positionOffset:Dot(rightward) > 0 then
			tear:AddTearFlags(TearFlags.TEAR_HOMING)
			tear.Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, wakaba.FireTear_KanaeLens)
