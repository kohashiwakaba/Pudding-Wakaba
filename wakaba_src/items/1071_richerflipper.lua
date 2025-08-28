--[[
	Richer's Flipper (리셰의 반전기) - 액티브(Active) - 3 rooms
	사용 시 카드/알약 및 폭탄/열쇠를 반전
 ]]
local isc = _wakaba.isc

function wakaba:ItemUse_RicherFlipper(item, rng, player, useFlags, activeSlot, varData)
	local discharge = false
	local pickups = isc:getEntities(EntityType.ENTITY_PICKUP)
	local isGolden = wakaba:IsGoldenItem(item, player)
	for _, prePickup in ipairs(pickups) do
		local pickup = prePickup:ToPickup()
		if pickup then
			if pickup.Variant == PickupVariant.PICKUP_BOMB then
				discharge = true
				pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, false, false, true)
			elseif pickup.Variant == PickupVariant.PICKUP_KEY then
				discharge = true
				pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 0, false, false, true)
			elseif pickup.Variant == PickupVariant.PICKUP_TAROTCARD then
				discharge = true
				pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, 0, false, false, true)
			elseif pickup.Variant == PickupVariant.PICKUP_PILL then
				discharge = true
				pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 0, false, false, true)
			elseif isGolden and pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
				Epiphany.Pickup.GOLDEN_ITEM.DisableGoldPedestal = true
				Epiphany.Pickup.GOLDEN_ITEM:TurnPedestalGold(pickup, false)
				Epiphany.Pickup.GOLDEN_ITEM.DisableGoldPedestal = false
				discharge = true
			end
		end
	end
	if discharge then
		SFXManager():Play(SoundEffect.SOUND_DIMEDROP)
	else
		player:AnimateSad()
	end

	return {
		Discharge = discharge,
		Remove = false,
		ShowAnim = discharge,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RicherFlipper, wakaba.Enums.Collectibles.RICHERS_FLIPPER)