local isc = require("wakaba_src.libs.isaacscript-common")

local pedestal_data = {
	run = {
		ascentSharedSeeds = {},
	},
	level = {
		wakabaPedestals = {},
	},
}
wakaba:saveDataManager("Wakaba Pedestals", pedestal_data)
wakaba.saved_pedestals = pedestal_data.level.wakabaPedestals

local function shouldCheckAscent()
	local room = wakaba.G:GetRoom()
	return room:GetType() == RoomType.ROOM_BOSS or room:GetType() == RoomType.ROOM_TREASURE
end

function wakaba:MakeCustomPedestal(pickup, gfx, alt)
	--pickup:ClearEntityFlags(EntityFlag.FLAG_APPEAR | EntityFlag.FLAG_ITEM_SHOULD_DUPLICATE)
	pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)] = {
		Gfx = gfx,
		Alternate = alt,
	}
	if shouldCheckAscent() then
		pedestal_data.run.ascentSharedSeeds[wakaba:getPickupIndex(pickup)] = pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)]
	end
	local sprite = pickup:GetSprite()
	sprite:ReplaceSpritesheet(5, gfx)
	if alt then
		sprite:SetOverlayFrame("Alternates", alt)
	end
	sprite:LoadGraphics()
end

---@param pickup EntityPickup
function wakaba:PickupUpdate_Pedestals2(pickup)
	local room = wakaba.G:GetRoom()
	if room:GetFrameCount() < 2 then return end
	wakaba:PickupUpdate_Pedestals(pickup)
end
---@param pickup EntityPickup
function wakaba:PickupUpdate_Pedestals(pickup)
	local floorCheck = pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)]
	local ascentCheck = pedestal_data.run.ascentSharedSeeds[wakaba:getPickupIndex(pickup)]

	local meta = ascentCheck or floorCheck
	if not meta then return end
	pickup:GetSprite():ReplaceSpritesheet(5, meta.Gfx)
	if meta.Alternate then
		pickup:GetSprite():SetOverlayFrame("Alternates", meta.Alternate)
	end
	pickup:GetSprite():LoadGraphics()
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PickupUpdate_Pedestals2, PickupVariant.PICKUP_COLLECTIBLE)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_PICKUP_INIT_LATE, wakaba.PickupUpdate_Pedestals, PickupVariant.PICKUP_COLLECTIBLE)