wakaba.COLLECTIBLE_BOOK_OF_SILENCE = Isaac.GetItemIdByName("Book of Silence")


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
	local ent = Isaac.FindByType(EntityType.ENTITY_PROJECTILE, Variant, SubType, true, true)
	for i, e in ipairs(ent) do
		if hasjudas then
			enemydmgvalue = enemydmgvalue + e.CollisionDamage
		end
		e:Remove()
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
			player:AnimateCollectible(wakaba.COLLECTIBLE_BOOK_OF_SILENCE, "UseItem", "PlayerPickup")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfSilence, wakaba.COLLECTIBLE_BOOK_OF_SILENCE)
