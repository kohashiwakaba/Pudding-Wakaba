wakaba.COLLECTIBLE_VENOM_INCANTATION = Isaac.GetItemIdByName("Venom Incantation")

function wakaba:TakeDamage_VenomIncantation(entity, amount, flags, source, countdown)
	if entity.Type == EntityType.ENTITY_PLAYER then return end
	if not entity:IsEnemy() then return end
	if entity:IsInvincible() then return end

	if flags & DamageFlag.DAMAGE_POISON_BURN == DamageFlag.DAMAGE_POISON_BURN then
		for i = 0, Game():GetNumPlayers()-1 do
			local player = Isaac.GetPlayer(i)
			if player:HasCollectible(wakaba.COLLECTIBLE_VENOM_INCANTATION) then
				local rng = player:GetCollectibleRNG(wakaba.COLLECTIBLE_VENOM_INCANTATION)
				local chance = 0.05
				if entity:IsBoss() then
					chance = 0.0136
				end
				local val = rng:RandomFloat()
				if val <= chance then
					entity:Kill()
				end
			end
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_VenomIncantation)


function wakaba:Cache_VenomIncantation(player, cacheFlag)
	if player:HasCollectible(wakaba.COLLECTIBLE_VENOM_INCANTATION) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 1
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_VenomIncantation)