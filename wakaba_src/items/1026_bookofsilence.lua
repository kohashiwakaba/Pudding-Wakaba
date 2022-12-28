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

function wakaba:ItemUse_BookOfSilence(_, rng, player, useFlags, activeSlot, varData)
	local enemydmgvalue = 0
	local hasjudas = false
	local hasshiori = false
	if wakaba:HasJudasBr(player) then
		hasjudas = true
	end
	if wakaba:HasShiori(player) then
		hasshiori = true
	end
	for _, entry in ipairs(wakaba.SilenceErasures) do
		local ent = Isaac.FindByType(entry.Type, entry.Variant or -1, entry.SubType or -1, true, true)
		for i, e in ipairs(ent) do
			if hasjudas then
				enemydmgvalue = enemydmgvalue + e.CollisionDamage
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
				entity:TakeDamage(enemydmgvalue, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(player), 0)
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
