--[[
	Richer's Necklace (리셰의 목걸이) - 패시브(Passive)
	눈물이 무언가에 부딪히면 잠시 후 랜덤 위치로 레이저를 발사합니다.
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

---@param tear EntityTear
function wakaba:TearDeath_RicherNecklace(tear)
	if tear:IsDead() then
		local player = wakaba:getPlayerFromTear(tear)
		if player and player:HasCollectible(wakaba.Enums.Collectibles.RICHERS_NECKLACE) then
			local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.RICHERS_NECKLACE) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.RICHERS_NECKLACE)
			for i = 1, count do
				local projectile = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_TEAR, 0, tear.Position, Vector.Zero, player):ToProjectile()
				local enemy = wakaba:findRandomEnemy(tear, player:GetCollectibleRNG(wakaba.Enums.Collectibles.RICHERS_NECKLACE), true)
				if enemy then
					projectile.Target = enemy
				end
				projectile.Visible = false
				projectile:AddProjectileFlags(ProjectileFlags.LASER_SHOT)
				projectile:Die()
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearDeath_RicherNecklace)