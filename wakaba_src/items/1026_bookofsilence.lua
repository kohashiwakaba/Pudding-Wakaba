wakaba.SilenceErasures = {
	{name = "Default", Type = EntityType.ENTITY_PROJECTILE},
	{name = "I_Fire", Type = 33, Variant = 10},
	{name = "I_Fire2", Type = 33, Variant = 11},
}

function wakaba:addSilenceTarget(modifierName, type, var, sub)
	if type == EntityType.ENTITY_PLAYER then return end
	for _,v in ipairs(wakaba.SilenceErasures) do
		if v["name"] == modifierName then
			v["Type"] = type
			v["Variant"] = var
			v["SubType"] = sub
			return
		end
	end
	table.insert(wakaba.SilenceErasures, {
		name = modifierName,
		Type = type,
		Variant = var,
		SubType = sub,
	})
end

function wakaba:removeSilenceTarget(modifierName)
	for i,v in ipairs(wakaba.SilenceErasures) do
		if v["name"] == modifierName then
			table.remove(wakaba.SilenceErasures,i)
			return
		end
	end
end

function wakaba:addSilenceTearsBuff(player, amount)
	local data = player:GetData()
	if data.wakaba then
		data.wakaba.silencetearsbuff = (data.wakaba.silencetearsbuff or 0) + amount
	end
end

function wakaba:getSilenceTearsBuff(player)
	local data = player:GetData()
	return (data.wakaba and data.wakaba.silencetearsbuff) or 0
end

function wakaba:ItemUse_BookOfSilence(item, rng, player, useFlags, activeSlot, varData)
	local enemydmgvalue = 0
	local hasjudas = false
	local hasshiori = false
	local isGolden = false
	if wakaba:HasJudasBr(player) then
		hasjudas = true
	end
	if wakaba:HasShiori(player) then
		hasshiori = true
	end
	if wakaba:IsGoldenItem(item, player) then
		isGolden = true
	end
	for _, entry in ipairs(wakaba.SilenceErasures) do
		local ent = Isaac.FindByType(entry.Type, entry.Variant or -1, entry.SubType or -1, true, true)
		for i, e in ipairs(ent) do
			if hasjudas then
				enemydmgvalue = enemydmgvalue + e.CollisionDamage
			end
			if isGolden then
				wakaba:addSilenceTearsBuff(player, 6)
			end
			e:Remove()
		end
	end
	if hasjudas then
		local entities = Isaac.FindInRadius(wakaba.GetGridCenter(), 3000, EntityPartition.ENEMY)
		for _, entity in ipairs(entities) do
			if entity:IsEnemy()
			and not entity:IsInvincible()
			and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY)
			then
				entity:TakeDamage(enemydmgvalue, not wakaba:IsLunatic() and DamageFlag.DAMAGE_IGNORE_ARMOR or 0, EntityRef(player), 0)
			end
		end
		player:UseActiveItem(CollectibleType.COLLECTIBLE_DARK_ARTS, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
		player:UseActiveItem(CollectibleType.COLLECTIBLE_DARK_ARTS, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
		player:UseActiveItem(CollectibleType.COLLECTIBLE_DARK_ARTS, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
		if hasshiori then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_DARK_ARTS, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_DARK_ARTS, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
		end
	else
		if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
			player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_SILENCE, "UseItem", "PlayerPickup")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfSilence, wakaba.Enums.Collectibles.BOOK_OF_SILENCE)

function wakaba:PlayerUpdate_BookOfSilence(player)
	if wakaba:getSilenceTearsBuff(player) > 0 then
		if player.FrameCount % 5 == 0 then
			wakaba:addSilenceTearsBuff(player, -1)
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:EvaluateItems()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_BookOfSilence)



function wakaba:Cache_BookOfSilence(player, cacheFlag)
	local buffs = wakaba:getSilenceTearsBuff(player)
	if buffs > 0 then
    if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, ((buffs / 10) * wakaba:getEstimatedTearsMult(player)))
    end
  end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_BookOfSilence)
