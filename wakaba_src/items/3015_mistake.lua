
local isc = require("wakaba_src.libs.isaacscript-common")


function wakaba:TakeDamage_Mistake(entity, amount, flags, source, cooldown)
	local player = entity:ToPlayer()
	if player then
		if player:HasTrinket(wakaba.Enums.Trinkets.MISTAKE) then
      wakaba:RegisterHeart(player, wakaba.Enums.Trinkets.MISTAKE + 65535)
		end
	end
end

function wakaba:Trigger_Mistake(player)
	local enemies = isc:getNPCs()
	if #enemies <= 0 then return end
	local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.MISTAKE)
	local rand = rng:RandomInt(#enemies)
	local enemy = enemies[rand+1]
	local bombdmg = 100
	if player:HasCollectible(CollectibleType.COLLECTIBLE_MR_MEGA) then bombdmg = 185 end
	bombdmg = bombdmg * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.MISTAKE)
	if enemy:IsVulnerableEnemy() then
		wakaba.G:BombExplosionEffects(enemy.Position, bombdmg, player:GetBombFlags(), Color.Default, player, 1, false, false, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR)
	end

end