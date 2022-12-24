local isc = require("wakaba_src.libs.isaacscript-common")

local ribbon_data = {
	run = {
		pendingCurseImmunityCount = 0,
	},
	floor = {

	},
	room = {

	}
}
wakaba:saveDataManager("Richer Uniform", ribbon_data)


function wakaba:ItemUse_RicherUniform(item, rng, player, useFlags, activeSlot, varData)
	pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
  local discharge = true
	local failed = false
	local room = wakaba.G:GetRoom()
	local roomType = room:GetType()

	if roomType == RoomType.ROOM_BOSS then
		
	elseif roomType == RoomType.ROOM_SHOP or roomType == RoomType.ROOM_BLACK_MARKET then
		room:ShopReshuffle(false, true)
	elseif roomType == RoomType.ROOM_DEVIL then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_COUPON, UseFlag.USE_NOANIM | UseFlag.USE_NOCOSTUME | UseFlag.USE_VOID | UseFlag.USE_MIMIC)
	elseif roomType == RoomType.ROOM_ANGEL then
		player:AddSoulHearts(1)
		player:AddHearts(1)
		ribbon_data.run.pendingCurseImmunityCount = ribbon_data.run.pendingCurseImmunityCount + 1
	elseif roomType == RoomType.ROOM_SACRIFICE then
		player:AddBoneHearts(1)
		local spikes = isc:getGridEntities(GridEntityType.GRID_SPIKES)
		for i, spike in ipairs(spikes) do
			spike.VarData = 5
			spike:Update()
		end
	else
		room:ShopRestockFull()
	end


	if not failed and not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(item, "UseItem", "PlayerPickup")
	end
  return {Discharge = discharge}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RicherUniform, wakaba.Enums.Collectibles.RICHERS_UNIFORM)
