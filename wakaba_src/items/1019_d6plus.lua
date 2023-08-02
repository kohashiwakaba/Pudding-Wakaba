function wakaba:ItemUse_D6Plus(_, rng, player, useFlags, activeSlot, varData)
	
	local flag = UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOANIM | UseFlag.USE_NOHUD
	player:UseCard(Card.CARD_SOUL_ISAAC, flag)
	wakaba:makePedestalsUntouched()
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.D6_PLUS, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.ItemUse_D6Plus, wakaba.Enums.Collectibles.D6_PLUS)

function wakaba:ItemUse_D6Chaos(item, rng, player, useFlags, activeSlot, varData)
	
	local flag = UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOANIM | UseFlag.USE_NOHUD
	local rerollcount = (Epiphany and Epiphany.API and Epiphany.API:IsGoldenItem(item) and 4) or 9
	for i = 1, rerollcount do
		player:UseCard(Card.CARD_SOUL_ISAAC, flag)
	end
	wakaba:makePedestalsUntouched()
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.D6_CHAOS, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.ItemUse_D6Chaos, wakaba.Enums.Collectibles.D6_CHAOS)

function wakaba:makePedestalsUntouched()
	local pedestals = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
	for _, entity in ipairs(pedestals) do
		local pickup = entity:ToPickup()
		pickup.Touched = false
	end
end