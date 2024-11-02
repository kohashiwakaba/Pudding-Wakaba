
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:UseItem_Purifier(activeItem, rng, player, flags, slot, vardata)
	if flags & UseFlag.USE_OWNED == 0 then return end
	local showAnim = false
	local pedestals = wakaba:GetPedestals(true)
	for i, p in ipairs(pedestals) do
		local pickup = p.Pedestal
		if not p.Config:HasTags(ItemConfig.TAG_QUEST) then
			if pickup:IsShopItem() then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
				pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_GOLDEN, true, true, true)
			else
				local numKeys = 4 + p.Quality
				if isc:hasCurse(wakaba.curses.CURSE_OF_SATYR) then
					numKeys = numKeys // 2
				end
				for i = 1, numKeys do
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, pickup.Position, wakaba:RandomVelocity(), nil):ToPickup()
				end
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
				pickup:Remove()
			end
			showAnim = true
		end
	end
	return {
		ShowAnim = showAnim,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_Purifier, wakaba.Enums.Collectibles.PURIFIER)