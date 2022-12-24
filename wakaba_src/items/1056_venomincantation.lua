wakaba.venomblacklist = {
	EntityType.ENTITY_MOM,
	EntityType.ENTITY_MOMS_HEART,
	EntityType.ENTITY_ISAAC,
	EntityType.ENTITY_SATAN,
	EntityType.ENTITY_MEGA_SATAN,
	EntityType.ENTITY_MEGA_SATAN_2,
	EntityType.ENTITY_THE_LAMB,
	EntityType.ENTITY_HUSH,
	EntityType.ENTITY_DELIRIUM,
	EntityType.ENTITY_ULTRA_GREED,
	EntityType.ENTITY_MOTHER,
	EntityType.ENTITY_DOGMA,
	EntityType.ENTITY_BEAST,
	EntityType.ENTITY_HORNFEL,
}

function wakaba:TakeDamage_VenomIncantation(entity, amount, flags, source, countdown)
	if wakaba:has_value(wakaba.venomblacklist, entity.Type) then return end
	if entity.Type == EntityType.ENTITY_PLAYER then return end
	if not entity:IsEnemy() then return end
	if entity:IsInvincible() then return end

	if flags & DamageFlag.DAMAGE_POISON_BURN == DamageFlag.DAMAGE_POISON_BURN then
		for i = 0, wakaba.G:GetNumPlayers()-1 do
			local player = Isaac.GetPlayer(i)
			if player:HasCollectible(wakaba.Enums.Collectibles.VENOM_INCANTATION) then
				local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.VENOM_INCANTATION)
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
	if player:HasCollectible(wakaba.Enums.Collectibles.VENOM_INCANTATION) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 1
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_VenomIncantation)