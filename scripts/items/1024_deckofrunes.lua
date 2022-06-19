wakaba.COLLECTIBLE_DECK_OF_RUNES = Isaac.GetItemIdByName("Shiori's Bottle of Runes")

function wakaba:ItemUse_DeckOfRunes(_, rng, player, useFlags, activeSlot, varData)
	local judaschance = rng:RandomFloat() * 10000
	if judaschance >= 5000 and wakaba:HasJudasBr(player) then
		player:AddCard(Card.RUNE_BLACK)
	else
		player:AddCard(Game():GetItemPool():GetCard(rng:Next(), false, true, true))
	end
	if judaschance >= 9000 and wakaba:HasJudasBr(player) then
		player:UseCard(Card.RUNE_BLACK, UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOANIM | UseFlag.USE_NOHUD)
	end
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.COLLECTIBLE_DECK_OF_RUNES, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_DeckOfRunes, wakaba.COLLECTIBLE_DECK_OF_RUNES)
