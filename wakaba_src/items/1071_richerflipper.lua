--[[ 
	Richer's Flipper (리셰의 반전기) - 액티브(Active) - 3 rooms
	사용 시 카드/알약 및 폭탄/열쇠를 반전
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_RicherFlipper(_, rng, player, useFlags, activeSlot, varData)
	local discharge = false
	local pickups = isc:getEntities(EntityType.ENTITY_PICKUP)
	for _, pickup in ipairs(pickups) do
		if pickup.Variant == PickupVariant.PICKUP_BOMB then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, false, false, true)
		elseif pickup.Variant == PickupVariant.PICKUP_KEY then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 0, false, false, true)
		elseif pickup.Variant == PickupVariant.PICKUP_TAROTCARD then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, 0, false, false, true)
		elseif pickup.Variant == PickupVariant.PICKUP_PILL then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 0, false, false, true)
		end
	end
	if #pickups > 0 then
		discharge = true
		SFXManager():Play(SoundEffect.SOUND_DIMEDROP)
	else
		player:AnimateSad()
	end

	return {
		Discharge = discharge,
		Remove = false,
		ShowAnim = not discharge,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RicherFlipper, wakaba.Enums.Collectibles.RICHERS_FLIPPER)