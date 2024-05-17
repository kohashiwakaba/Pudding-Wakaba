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

wakaba.LunaticCharges = {
	[wakaba.Enums.Collectibles.RIRAS_COAT] = 6,
	[wakaba.Enums.Collectibles.COUNTER] = 1800,
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = 12,
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = 900,
	[wakaba.Enums.Collectibles.RICHERS_UNIFORM] = 6,
}

function wakaba:GetCalculatedMaidMaxCharges()
end

local maidRecursive = false
--- Maid Duet : 모든 액티브 아이템의 최대 충전량 2칸 감소 (최소 1), 시간제, 스페셜의 경우 15%
---@param itemID CollectibleType
---@param player EntityPlayer
---@param varData integer
wakaba:AddPriorityCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MAX_CHARGE, 20000, function(_, itemID, player, varData)
	if wakaba:IsLunatic() and wakaba.LunaticCharges[itemID] then
		return wakaba.LunaticCharges[itemID]
	end
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

---@param itemID CollectibleType
---@param charge integer
---@param firstTime boolean
---@param slot ActiveSlot
---@param varData integer
---@param player EntityPlayer
wakaba:AddCallback(ModCallbacks.MC_PRE_ADD_COLLECTIBLE, function(_, itemID, charge, firstTime, slot, varData, player)
	if firstTime and (player:HasCollectible(wakaba.Enums.Collectibles.MAID_DUET) or wakaba:IsLunatic()) then
		wakaba.Log("getting maid charge from item...", charge)
		--return {itemID, charge, firstTime, slot, varData}
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
	if PlayerManager.AnyoneHasCollectible(wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE) then
		add = add + 0.2
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

local ampSprite = Sprite()
ampSprite:Load('gfx/items/wakaba_bookofamplitude.anm2', true)

-- Book of Amplitude
---@param player EntityPlayer
---@param activeSlot ActiveSlot
---@param offset Vector
---@param alpha number
---@param scale number
---@param chargeBarOffset Vector
function wakaba:ActiveRender_BookOfAmplitude(player, activeSlot, offset, alpha, scale, chargeBarOffset)
	local item = player:GetActiveItem(activeSlot)
	if item == wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE and not player:IsCoopGhost() then
		local ampStat = wakaba:getPlayerDataEntry(player, "ampstat")
		if ampStat then
			local mode = ampStat % 4

			local pocket = player:GetPocketItem(0)
			local ispocketactive = (pocket:GetSlot() == 3 and pocket:GetType() == 2)

			local renderPos = Vector(16, 16)
			local renderScale = Vector(1, 1)

			if mode < 4 then
				if activeSlot == ActiveSlot.SLOT_PRIMARY then
				elseif activeSlot == ActiveSlot.SLOT_SECONDARY or (not ispocketactive) then
					renderPos = renderPos / 2
					renderScale = renderScale / 2
				end
				ampSprite:SetFrame("Idle", mode)
				ampSprite.Scale = renderScale
				ampSprite:Render(renderPos + offset, Vector.Zero, Vector.Zero)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYERHUD_RENDER_ACTIVE_ITEM, wakaba.ActiveRender_BookOfAmplitude)

-- Clover Chest + Guppy's Eye
---@param pickup EntityPickup
function wakaba:PickupLoot_CloverChest(pickup)
	if pickup.Variant == wakaba.Enums.Pickups.CLOVER_CHEST and pickup.SubType == wakaba.ChestSubType.CLOSED then
		local rewards = wakaba:getCloverChestRewards(pickup)

		local loot = LootList()
		for _, e in ipairs(rewards) do
			loot:PushEntry(e[1], e[2] or 0, e[3] or 0, pickup.InitSeed)
		end
		return loot
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_GET_LOOT_LIST, wakaba.PickupLoot_CloverChest)

---@param pickup EntityPickup
function wakaba:GhostPickup_CloverChest(pickup)
	if pickup.Variant == wakaba.Enums.Pickups.CLOVER_CHEST and pickup.SubType == wakaba.ChestSubType.CLOSED and PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_GUPPYS_EYE) then
		--pickup:UpdatePickupGhosts()
		return true
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_UPDATE_GHOST_PICKUPS, wakaba.GhostPickup_CloverChest)

function wakaba:Cache_CloverChest(_, _)
	print("Clover chest invalidated!")
	wakaba:InvalidateCloverChestRewards()
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_CloverChest, CacheFlag.CACHE_PICKUP_VISION)

---@param player EntityPlayer
function wakaba:VisionChange_CloverChest(player, _)
	wakaba:InvalidateCloverChestRewards()
	wakaba.G:GetRoom():InvalidatePickupVision()
end
wakaba:AddCallback(ModCallbacks.MC_POST_TRIGGER_TRINKET_ADDED, wakaba.VisionChange_CloverChest, wakaba.Enums.Trinkets.CLOVER)
wakaba:AddCallback(ModCallbacks.MC_POST_TRIGGER_TRINKET_REMOVED, wakaba.VisionChange_CloverChest, wakaba.Enums.Trinkets.CLOVER)
wakaba:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, wakaba.VisionChange_CloverChest, CollectibleType.COLLECTIBLE_MOMS_KEY)
wakaba:AddCallback(ModCallbacks.MC_POST_TRIGGER_COLLECTIBLE_REMOVED, wakaba.VisionChange_CloverChest, CollectibleType.COLLECTIBLE_MOMS_KEY)

local function getfilename(sprite)
    local name = sprite:GetFilename()
    local index = string.find(name, "/[^/]*$")
    return string.sub(name, index+1, string.len(name))
end

-- Wakaba Tickets are golden
---@param pickup EntityPickup
function wakaba:Render_Golden(pickup)
	local sprite = pickup:GetSprite()
	local anm2Flags = sprite:GetRenderFlags()
	local fileName = getfilename(sprite)
	if string.find(fileName, "Wakaba Ticket") then
		sprite:SetRenderFlags(anm2Flags | AnimRenderFlags.GOLDEN)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, wakaba.Render_Golden, PickupVariant.PICKUP_TAROTCARD)
