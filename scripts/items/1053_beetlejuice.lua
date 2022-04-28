wakaba.COLLECTIBLE_BEETLEJUICE = Isaac.GetItemIdByName("Beetlejuice")

function wakaba:ItemUse_Beetlejuice(item, rng, player, useFlags, activeSlot, varData)
	pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
  local discharge = true


	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(item, "UseItem", "PlayerPickup")
	end
  return {Discharge = discharge}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Beetlejuice, wakaba.COLLECTIBLE_BEETLEJUICE)
