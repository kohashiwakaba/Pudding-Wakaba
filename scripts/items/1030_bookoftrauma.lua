wakaba.COLLECTIBLE_BOOK_OF_TRAUMA = Isaac.GetItemIdByName("Book of Trauma")


function wakaba:ItemUse_BookOfTrauma(_, rng, player, useFlags, activeSlot, varData)
	local entities = Isaac.FindByType(EntityType.ENTITY_TEAR)
	for _, e in ipairs(entities) do
		Game():BombExplosionEffects(e.Position, player.Damage * 8 + 20, TearFlags.TEAR_BRIMSTONE_BOMB, Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR)
		e:Remove()
	end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.COLLECTIBLE_BOOK_OF_TRAUMA, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfTrauma, wakaba.COLLECTIBLE_BOOK_OF_TRAUMA)

