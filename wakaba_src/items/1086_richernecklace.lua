--[[
	Richer's Necklace (리셰의 목걸이) - 패시브(Passive)
	눈물이 무언가에 부딪히면 잠시 후 랜덤 위치로 레이저를 발사합니다.
 ]]
local isc = _wakaba.isc

local function getNecklaceCooldown(player)
end

---@param startEntity Entity
---@param player EntityPlayer
---@param count integer
function wakaba:fireNecklaceLaser(startEntity, player, count)
	count = math.max(count or 0) + 1
	player:GetData().wakaba.richernecklacecooldown = player:GetData().wakaba.richernecklacecooldown or 0
	local cooldown = player:GetData().wakaba.richernecklacecooldown
	local cooldownAdd = 11/count
	if cooldown < 1 then
		wakaba.Log("Necklace laser passed, cooldown:", player:GetData().wakaba.richernecklacecooldown)
		local projectile = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_TEAR, 0, startEntity.Position, Vector.Zero, player):ToProjectile()
		local enemy = wakaba:findRandomEnemy(startEntity, player:GetCollectibleRNG(wakaba.Enums.Collectibles.RICHERS_NECKLACE), true)
		if enemy then
			projectile.Target = enemy
		end
		projectile:GetData().w_RicherNecklace = true
		projectile.Visible = false
		projectile:AddProjectileFlags(ProjectileFlags.LASER_SHOT)
		projectile:Die()
		player:GetData().wakaba.richernecklacecooldown = player:GetData().wakaba.richernecklacecooldown + cooldownAdd
	else
		wakaba.Log("Necklace laser skipped, cooldown:", player:GetData().wakaba.richernecklacecooldown)
	end
end

---@param tear EntityTear
function wakaba:TearDeath_RicherNecklace(tear)
	if tear:IsDead() then
		local player = wakaba:getPlayerFromTear(tear)
		if player and player:HasCollectible(wakaba.Enums.Collectibles.RICHERS_NECKLACE) then
			local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.RICHERS_NECKLACE) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.RICHERS_NECKLACE)
			wakaba:fireNecklaceLaser(tear, player, count)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearDeath_RicherNecklace)

---@param player EntityPlayer
function wakaba:PlayerUpdate_RicherNecklace(player)
	if not player:HasCollectible(wakaba.Enums.Collectibles.RICHERS_NECKLACE) then return end
	wakaba:GetPlayerEntityData(player)
	local d = player:GetData()
	player:GetData().wakaba.richernecklacecooldown = d.wakaba.richernecklacecooldown or 0
	--wakaba.Log("Richer's Necklace cooldown :",d.wakaba.richernecklacecooldown)
	if d.wakaba.richernecklacecooldown >= 1 then
		d.wakaba.richernecklacecooldown = d.wakaba.richernecklacecooldown - 1
	elseif d.wakaba.richernecklacecooldown < -1 then
		d.wakaba.richernecklacecooldown = -1
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_RicherNecklace)