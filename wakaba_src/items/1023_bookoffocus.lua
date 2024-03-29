function wakaba:ItemUse_BookOfFocus(_, rng, player, useFlags, activeSlot, varData)

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_FOCUS, "UseItem", "PlayerPickup")
	end
	SFXManager():Play(SoundEffect.SOUND_THUMBSDOWN_AMPLIFIED)

end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfFocus, wakaba.Enums.Collectibles.BOOK_OF_FOCUS)


function wakaba:PostShiori_BookofFocus(player)
	if not player:GetData().wakaba then return end
	local w = player:GetData().wakaba
	w.isnotmoving = w.isnotmoving or false
	if w.isnotmoving then
		if Input.IsActionPressed(ButtonAction.ACTION_LEFT, player.ControllerIndex)
		or Input.IsActionPressed(ButtonAction.ACTION_RIGHT, player.ControllerIndex)
		or Input.IsActionPressed(ButtonAction.ACTION_UP, player.ControllerIndex)
		or Input.IsActionPressed(ButtonAction.ACTION_DOWN, player.ControllerIndex)
		then
			w.isnotmoving = false
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_TEARFLAG)
			player:EvaluateItems()
		end
	else
		if not Input.IsActionPressed(ButtonAction.ACTION_LEFT, player.ControllerIndex)
		and not Input.IsActionPressed(ButtonAction.ACTION_RIGHT, player.ControllerIndex)
		and not Input.IsActionPressed(ButtonAction.ACTION_UP, player.ControllerIndex)
		and not Input.IsActionPressed(ButtonAction.ACTION_DOWN, player.ControllerIndex)
		then
			w.isnotmoving = true
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_TEARFLAG)
			player:EvaluateItems()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PostShiori_BookofFocus)

function wakaba:NpcUpcate_BookofFocus(entity)
	local power = wakaba:GetGlobalCollectibleEffectNum(wakaba.Enums.Collectibles.BOOK_OF_FOCUS)
	if power > 0 then
		if entity:IsVulnerableEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_WEAKNESS) then
			entity:AddEntityFlags(EntityFlag.FLAG_WEAKNESS)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NpcUpcate_BookofFocus)

function wakaba:PreTakeDamage_BookofFocus(entity, amount, flags, source, countdown)
	if entity.Type ~= EntityType.ENTITY_PLAYER
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
			local playerEffects = player:GetEffects()
			local focusnum = playerEffects:GetCollectibleEffectNum(wakaba.Enums.Collectibles.BOOK_OF_FOCUS)
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.PreTakeDamage_BookofFocus)

function wakaba:AlterPlayerDamage_BookofFocus(player, amount, flags, source, countdown)
	local playerEffects = player:GetEffects()
	local focus = playerEffects:GetCollectibleEffectNum(wakaba.Enums.Collectibles.BOOK_OF_FOCUS)
	if focus > 0 then
		if source.Entity and source.Entity:HasEntityFlags(EntityFlag.FLAG_WEAKNESS) and amount < 8 then
			return 8
		elseif amount < 4 then
			return 4
		end
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, wakaba.AlterPlayerDamage_BookofFocus)

function wakaba:Cache_BookofFocus(player, cacheFlag)
	if not player:GetData().wakaba then return end

	local playerEffects = player:GetEffects()
	local focus = playerEffects:GetCollectibleEffectNum(wakaba.Enums.Collectibles.BOOK_OF_FOCUS)
	local isnotmoving = player:GetData().wakaba.isnotmoving or false
	if focus > 0 and isnotmoving then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (1.4 * focus * wakaba:getEstimatedDamageMult(player))
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (1.0 * focus) * wakaba:getEstimatedTearsMult(player))
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (80 * focus)
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING | TearFlags.TEAR_SPECTRAL
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_BookofFocus)