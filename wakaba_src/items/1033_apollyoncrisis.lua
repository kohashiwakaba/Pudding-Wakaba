
function wakaba:RemovePedestalIndex(includeShop)
	includeShop = includeShop or true
	local items = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
	if (#items == 0) then return nil end
	for i = 1, #items do
		local item = items[i]:ToPickup()
		if includeShop or not item:IsShopItem() then
			item.OptionsPickupIndex = 0
		end
	end
end

wakaba.Blacklists.ApollyonCrisis = {
	[CollectibleType.COLLECTIBLE_VOID] = true,
	[CollectibleType.COLLECTIBLE_ABYSS] = true,
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = true,
}

if REPENTOGON then
	local function recalculateVoidCursor(player, lastItem)
		local list = player:GetVoidedCollectiblesList()

		local newIndex = wakaba:getPlayerDataEntry(player, "apcrIndex", 0)
		if newIndex < 0 then
			wakaba:setPlayerDataEntry(player, "apcrIndex", #list)
		elseif newIndex > #list then
			wakaba:setPlayerDataEntry(player, "apcrIndex", 0)
		end
	end


	function wakaba:PlayerUpdate_ApollyonCrisis(player)
		if not player:HasCollectible(wakaba.Enums.Collectibles.APOLLYON_CRISIS, true) then return end

		local extraLeft = wakaba:getOptionValue("exl")
		local extraRight = wakaba:getOptionValue("exr")
		local extraLeftCont = Keyboard.KEY_LEFT_BRACKET
		local extraRightCont = Keyboard.KEY_RIGHT_BRACKET

		local list = player:GetVoidedCollectiblesList()
		wakaba:initPlayerDataEntry(player, "apcrIndex", 0)
		recalculateVoidCursor(player)

		local shift = 0
		if Input.IsButtonTriggered(extraLeft, 0)
			or Input.IsButtonTriggered(extraLeftCont, player.ControllerIndex)
		then shift = -1 end
		if Input.IsButtonTriggered(extraRight, 0)
			or Input.IsButtonTriggered(extraRightCont, player.ControllerIndex)
		then shift = 1 end

		if shift == 0 then return end

		wakaba:addPlayerDataCounter(player, "apcrIndex", shift)
		
		recalculateVoidCursor(player)
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_ApollyonCrisis)

	local voidSprite = Sprite()
	voidSprite:Load("gfx/005.100_collectible.anm2", false)
	voidSprite:Play("ShopIdle", true)

	---@param player EntityPlayer
	---@param activeSlot ActiveSlot
	---@param offset Vector
	---@param alpha number
	---@param scale number
	---@param chargeBarOffset Vector
	function wakaba:ActiveRender_ApollyonCrisis(player, activeSlot, offset, alpha, scale, chargeBarOffset)
		local item = player:GetActiveItem(activeSlot)
		if item == wakaba.Enums.Collectibles.APOLLYON_CRISIS and not player:IsCoopGhost() then
			local list = player:GetVoidedCollectiblesList()
			local index = wakaba:getPlayerDataEntry(player, "apcrIndex", 0)
			if index ~= 0 then
				local config = Isaac.GetItemConfig():GetCollectible(list[index])
				if config then
					local pocket = player:GetPocketItem(0)
					local ispocketactive = (pocket:GetSlot() == 3 and pocket:GetType() == 2)
					local renderPos = Vector(16, 24)
					local renderScale = Vector(1, 1)

					local g = config.GfxFileName

					if activeSlot == ActiveSlot.SLOT_PRIMARY then
					elseif activeSlot == ActiveSlot.SLOT_SECONDARY or (not ispocketactive) then
						renderPos = renderPos / 2
						renderScale = renderScale / 2
					end
					voidSprite:ReplaceSpritesheet(1, g, true)
					voidSprite.Scale = renderScale
					voidSprite:Render(renderPos + offset, Vector.Zero, Vector.Zero)
				end
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_PLAYERHUD_RENDER_ACTIVE_ITEM, wakaba.ActiveRender_ApollyonCrisis)

	---@param itemID CollectibleType
	---@param player EntityPlayer
	---@param varData integer
	---@param current integer
	function wakaba:MaxCharge_ApollyonCrisis(itemID, player, varData, current)
		if varData ~= 0 then
			return varData
		end
	end
	
	wakaba:AddCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MAX_CHARGE, wakaba.MaxCharge_ApollyonCrisis, wakaba.Enums.Collectibles.APOLLYON_CRISIS)
	
	---@param rng RNG
	---@param player EntityPlayer
	---@param useFlags UseFlag
	---@param activeSlot ActiveSlot
	---@param varData integer
	function wakaba:ItemUse_ApollyonCrisis(_, rng, player, useFlags, activeSlot, varData)
		
		local index = wakaba:getPlayerDataEntry(player, "apcrIndex", 0)

		if index == 0 then
			wakaba:RemovePedestalIndex(false)
			local pedestals = wakaba:GetPedestals(false)
			if not pedestals then 
				Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, 0, player.Position, Vector.Zero, player):ToFamiliar():AddEntityFlags(EntityFlag.FLAG_DONT_OVERWRITE)
			else
				for i, p in ipairs(pedestals) do
					Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, p.CollectibleType, player.Position, Vector.Zero, player):ToFamiliar():AddEntityFlags(EntityFlag.FLAG_DONT_OVERWRITE)
					if (p.CollectibleType == CollectibleType.COLLECTIBLE_VOID or p.CollectibleType == CollectibleType.COLLECTIBLE_ABYSS or p.CollectibleType == wakaba.Enums.Collectibles.APOLLYON_CRISIS) then
						p.Pedestal:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BREAKFAST, true, true, true)
					end
				end
			end
			player:UseActiveItem(CollectibleType.COLLECTIBLE_VOID, 0, -1)
			if useFlags && UseFlag.USE_CARBATTERY == 0 then
				player:SetActiveVarData(0, activeSlot)
			end
		else
			local list = player:GetVoidedCollectiblesList()
			local target = list[index]
			local config = Isaac.GetItemConfig():GetCollectible(target)
			if not config then
				return {
					Discharge = false,
					ShowAnim = false,
					Remove = false,
				}
			end
			player:UseActiveItem(target, UseFlag.USE_OWNED | UseFlag.USE_VOID | UseFlag.USE_ALLOWWISPSPAWN)
			local maxCharges = math.min(math.max(1, config.MaxCharges), 12)
			local chargeType = config.ChargeType
			if chargeType == ItemConfig.CHARGE_TIMED then maxCharges = 1 end
			if useFlags && UseFlag.USE_CARBATTERY == 0 then
				player:SetActiveVarData(maxCharges, activeSlot)
			end
		end
		return {
			Discharge = true,
			ShowAnim = true,
			Remove = false,
		}
	end
	wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_ApollyonCrisis, wakaba.Enums.Collectibles.APOLLYON_CRISIS)
else
	function wakaba:ItemUse_ApollyonCrisis(_, rng, player, useFlags, activeSlot, varData)
		Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, 0, player.Position, Vector.Zero, player):ToFamiliar():AddEntityFlags(EntityFlag.FLAG_DONT_OVERWRITE)
		return {
			Discharge = true,
			ShowAnim = true,
			Remove = false,
		}
	end
	wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_ApollyonCrisis, wakaba.Enums.Collectibles.APOLLYON_CRISIS)
end