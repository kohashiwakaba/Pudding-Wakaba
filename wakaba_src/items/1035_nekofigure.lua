function wakaba:Cache_NekoFigure(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.NEKO_FIGURE) 
	and player:GetCollectibleNum(wakaba.Enums.Collectibles.NEKO_FIGURE) == 1 then
    if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
      player.Damage = player.Damage * 0.9
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_NekoFigure)

function wakaba:TakeDmg_NekoFigure(entity, amount, flag, source, countdownFrames)
	if entity.Type ~= EntityType.ENTITY_PLAYER
	and not (flag & DamageFlag.DAMAGE_IGNORE_ARMOR == DamageFlag.DAMAGE_IGNORE_ARMOR) 
	then
		local player = nil
		if 
			(source ~= nil
			and source.Entity ~= nil
			and source.Entity.SpawnerEntity ~= nil
			and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER )
		then
			player = source.Entity.SpawnerEntity:ToPlayer()
		elseif
			(source ~= nil
			and source.Type == EntityType.ENTITY_PLAYER)
		then
			player = source.Entity:ToPlayer()
		end
		if player ~= nil then
			if player:HasCollectible(wakaba.Enums.Collectibles.NEKO_FIGURE)
			then
				flag = flag | DamageFlag.DAMAGE_IGNORE_ARMOR
				entity:TakeDamage(amount, flag, source, countdownFrames)
				return false
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.TakeDmg_NekoFigure)

