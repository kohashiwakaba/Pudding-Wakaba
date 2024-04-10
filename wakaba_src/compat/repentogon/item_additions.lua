--MC_PLAYER_GET_ACTIVE_MAX_CHARGE skips remaining callbacks if a value is returned, so doing in one singe callback

--- Sweets Catalog : 특수 챌린지의 경우 항상 발동 가능
---@param itemID CollectibleType
---@param player EntityPlayer
---@param varData integer
wakaba:AddPriorityCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MAX_CHARGE, 0, function(_, itemID, player, varData)
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_EVEN then
		return 0
	end
end, wakaba.Enums.Collectibles.SWEETS_CATALOG)

---@param itemID CollectibleType
---@param charge integer
---@param firstTime boolean
---@param slot ActiveSlot
---@param varData integer
---@param player EntityPlayer
wakaba:AddCallback(ModCallbacks.MC_PRE_ADD_COLLECTIBLE, function(_, itemID, charge, firstTime, slot, varData, player)
	if firstTime and player:GetPlayerType() ~= wakaba.Enums.Players.RICHER then
		--return {itemID, 8, firstTime, slot, varData}
	end
end, wakaba.Enums.Collectibles.SWEETS_CATALOG)

local maidRecursive = false
--- Maid Duet : 모든 액티브 아이템의 최대 충전량 2칸 감소 (최소 1), 시간제, 스페셜의 경우 15%
---@param itemID CollectibleType
---@param player EntityPlayer
---@param varData integer
wakaba:AddPriorityCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MAX_CHARGE, 20000, function(_, itemID, player, varData)
	if not maidRecursive and player:HasCollectible(wakaba.Enums.Collectibles.MAID_DUET) and itemID ~= 0 and not wakaba.Blacklists.MaidDuetCharges[itemID] then
		maidRecursive = true
		local cfg = Isaac.GetItemConfig():GetCollectible(itemID)
		local maxCharges = player:GetActiveMaxCharge(player:GetActiveItemSlot(itemID))
		local type = cfg.ChargeType
		maidRecursive = false
		if type == ItemConfig.CHARGE_NORMAL then
			if maxCharges <= 2 then
				return math.max(maxCharges - 1, 0)
			else
				return math.max(maxCharges - 2, 0)
			end
		else
			return math.floor(maxCharges * 0.85)
		end

	end
end)

--- Wakaba's Double Dreams : 액티브 아이템 칸을 소환 카운터로 설정.
wakaba:AddPriorityCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MIN_USABLE_CHARGE, -20000, function(_)
	return 0
end, wakaba.Enums.Collectibles.DOUBLE_DREAMS)

wakaba:AddPriorityCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MAX_CHARGE, -20000, function(_, _, player, varData)
	return 10000
end, wakaba.Enums.Collectibles.DOUBLE_DREAMS)

--- Devil/Angel chance : 악마/천사 확률 조절
function wakaba:AlterDevilChance_Core()
	local richerBraCnt = PlayerManager.GetNumCollectibles(wakaba.Enums.Collectibles.RICHERS_BRA)
	local add = 0
	if richerBraCnt > 0 then
		add = add + (0.05 * (richerBraCnt + 1))
	end
	return add
end
wakaba:AddCallback(ModCallbacks.MC_PRE_DEVIL_APPLY_ITEMS, wakaba.AlterDevilChance_Core)

function wakaba:AlterDevilChance_Sp()
	local status = wakaba:getDevilAngelStatus()
	if status.WDreams then
		return 0
	elseif (status.Blessing and status.Nemesis) or status.WakabaBR or status.Murasame then
		return 4001
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_DEVIL_APPLY_SPECIAL_ITEMS, wakaba.AlterDevilChance_Sp)

function wakaba:AlterDevilChance_Final()
	local status = wakaba:getDevilAngelStatus()
	if status.WDreams then
		return -20000
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_DEVIL_CALCULATE, 20000, wakaba.AlterDevilChance_Final)
