wakaba.COLLECTIBLE_D6_PLUS = Isaac.GetItemIdByName("D6 Plus")
wakaba.COLLECTIBLE_D6_CHAOS = Isaac.GetItemIdByName("D6 Chaos")


function wakaba:ItemUse_D6Plus(_, rng, player, useFlags, activeSlot, varData)
	
	local flag = UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOANIM | UseFlag.USE_NOHUD
	player:UseCard(Card.CARD_SOUL_ISAAC, flag)
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.COLLECTIBLE_D6_PLUS, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.ItemUse_D6Plus, wakaba.COLLECTIBLE_D6_PLUS)

function wakaba:ItemUse_D6Chaos(_, rng, player, useFlags, activeSlot, varData)
	
	local flag = UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOANIM | UseFlag.USE_NOHUD
	for i = 1, 9 do
		player:UseCard(Card.CARD_SOUL_ISAAC, flag)
	end
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.COLLECTIBLE_D6_CHAOS, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.ItemUse_D6Chaos, wakaba.COLLECTIBLE_D6_CHAOS)