wakaba.COLLECTIBLE_BEETLEJUICE = Isaac.GetItemIdByName("Beetlejuice")

local availablePills = {}

function wakaba:ItemUse_Beetlejuice(item, rng, player, useFlags, activeSlot, varData)
	pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
	local failed = false 
  local discharge = true
	local pool = Game():GetItemPool()
	local rng = player:GetCollectibleRNG(wakaba.COLLECTIBLE_BEETLEJUICE)
	for i = 1, 6 do
		local pillEffectCandidates = Isaac.GetItemConfig():GetPillEffects()
		local replacedPillEffect = Isaac.GetItemConfig():GetPillEffect(rng:RandomInt(pillEffectCandidates.Size)).ID
		local newPill = pool:ForceAddPillEffect(replacedPillEffect)
		pool:IdentifyPill(newPill)
	end

	if not failed and not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(item, "UseItem", "PlayerPickup")
	end
  return {Discharge = discharge}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Beetlejuice, wakaba.COLLECTIBLE_BEETLEJUICE)


function wakaba:PlayerUpdate_Beetlejuice(player)
  wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if player:HasCollectible(wakaba.COLLECTIBLE_BEETLEJUICE) and not data.wakaba.IdentifyPills then
    local pool = Game():GetItemPool()
    for i = 1, 13 do
			if not pool:IsPillIdentified(i) then
				pool:IdentifyPill(i)
			end
		end
		if FiendFolio then
			for i = 1, #FiendFolio.FFPillColours do
					FiendFolio.savedata.run.IdentifiedRunPills = FiendFolio.savedata.run.IdentifiedRunPills or {}
					FiendFolio.savedata.run.IdentifiedRunPills[tostring(mod.FFPillColours[i])] = true
			end
		end
		data.wakaba.IdentifyPills = true
	end

end

wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Beetlejuice)