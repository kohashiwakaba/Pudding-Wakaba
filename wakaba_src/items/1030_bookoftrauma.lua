local isc = require("wakaba_src.libs.isaacscript-common")
function wakaba:ItemUse_BookOfTrauma(item, rng, player, useFlags, activeSlot, varData)
	local i = 0
	local max = wakaba.Enums.Constants.MAX_TRAUMA_COUNT
	local isGolden = wakaba:IsGoldenItem(item)
	local allowOtherTears = false
	local entities = Isaac.FindByType(EntityType.ENTITY_TEAR)
	if #entities > 0 then
		for _, e in ipairs(entities) do
			if i < max and (allowOtherTears or GetPtrHash(isc:getPlayerFromEntity(e)) == GetPtrHash(player)) then
				wakaba.G:BombExplosionEffects(e.Position, player.Damage * 8 * (isGolden and 1.3 or 1) + 20, (isGolden and TearFlags.TEAR_GIGA_BOMB or TearFlags.TEAR_BRIMSTONE_BOMB), Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR)
				e:Remove()
				i = i + 1
			elseif i >= max then
				finished = true
			end
		end
	end
	wakaba.G:BombExplosionEffects(player.Position, player.Damage * 8 * (isGolden and 1.3 or 1) + 20, TearFlags.TEAR_BRIMSTONE_BOMB | (isGolden and TearFlags.TEAR_GIGA_BOMB or 0), Color.Default, player, (isGolden and 2 or 1), true, false, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR)

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_TRAUMA, "HideItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfTrauma, wakaba.Enums.Collectibles.BOOK_OF_TRAUMA)

