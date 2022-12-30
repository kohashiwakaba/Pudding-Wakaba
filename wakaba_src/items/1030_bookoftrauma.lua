local isc = require("wakaba_src.libs.isaacscript-common")
function wakaba:ItemUse_BookOfTrauma(_, rng, player, useFlags, activeSlot, varData)
	local i = 0
	local allowOtherTears = false
	local entities = Isaac.FindByType(EntityType.ENTITY_TEAR)
	if #entities > 0 then
		for _, e in ipairs(entities) do
			if i < 15 and (allowOtherTears or (e.FrameCount > 0 and e:ToTear() and isc:isTearFromFamiliar(e:ToTear()))) then
				wakaba.G:BombExplosionEffects(e.Position, player.Damage * 8 + 20, TearFlags.TEAR_BRIMSTONE_BOMB, Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR)
				e:Remove()
				i = i + 1
			elseif i >= 15 then
				finished = true
			end
		end
	end
	wakaba.G:BombExplosionEffects(player.Position, player.Damage * 8 + 20, TearFlags.TEAR_BRIMSTONE_BOMB, Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR)

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_TRAUMA, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfTrauma, wakaba.Enums.Collectibles.BOOK_OF_TRAUMA)

