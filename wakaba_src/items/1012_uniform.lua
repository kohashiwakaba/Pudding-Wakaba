
local isc = _wakaba.isc
local usinguniform = false

wakaba.save_uniform_data = {
	run = {
	},
}
wakaba:saveDataManager("Wakaba's Uniform", wakaba.save_uniform_data)

function wakaba:BlacklistUniform(pickuptype, effect)
	if pickuptype == "card" then
		if not wakaba:has_value(wakaba.Blacklists.Uniform.Cards, effect) then
			table.insert(wakaba.Blacklists.Uniform.Cards, effect)
		end
	elseif pickuptype == "pilleffect" or pickuptype == "pill" then
		if not wakaba:has_value(wakaba.Blacklists.Uniform.PillEffect, effect) then
			table.insert(wakaba.Blacklists.Uniform.PillEffect, effect)
		end
	elseif pickuptype == "pillcolor" then
		if not wakaba:has_value(wakaba.Blacklists.Uniform.PillColor, effect) then
			table.insert(wakaba.Blacklists.Uniform.PillColor, effect)
		end
	end
end

function wakaba:getMaxWakabaUniformSlots(player)
	local max = wakaba.Enums.Constants.WAKABA_UNIFORM_MAX_SLOTS
	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.MAX_UNIFORM_SLOTS)) do
		local evals = callback.Function(callback.Mod, player, max)
		if evals and type(evals) == "number" then
			max = evals
		end
	end
	return max
end

function wakaba:getCurrentWakabaUniformCursor(player, slot)
	local slot = wakaba:getPlayerDataEntry(player, "uniformSlot", 1)
	return slot
end

function wakaba:getCurrentWakabaUniformSlot(player, slot)
	local playerIndex = tostring(isc:getPlayerIndex(player))
	wakaba.save_uniform_data.run[playerIndex] = wakaba.save_uniform_data.run[playerIndex] or {}
	local entries = {}
	if slot then
		entries = wakaba.save_uniform_data.run[playerIndex][tostring(slot)]
	else
		local max = wakaba:getMaxWakabaUniformSlots(player)
		for i = 1, max do
			entries[i] = wakaba.save_uniform_data.run[playerIndex][tostring(i)]
		end
	end
	return entries
end

function wakaba:recalculateUniformCursor(player)
	local max = wakaba:getMaxWakabaUniformSlots(player)

	local newIndex = wakaba:getPlayerDataEntry(player, "uniformSlot", 1)
	if newIndex < 1 then
		wakaba:setPlayerDataEntry(player, "uniformSlot", max)
	elseif newIndex > max then
		wakaba:setPlayerDataEntry(player, "uniformSlot", 1)
	end
end

---@param player EntityPlayer
---@param slot integer
---@param pickup EntityPickup
function wakaba:swapUniformEntries(player, slot, pickup)
	local playerIndex = tostring(isc:getPlayerIndex(player))
	local success = false
	local entry = wakaba:getCurrentWakabaUniformSlot(player, slot)
	local entryToSet
	local entryToOut
	local pos
	if entry then
		wakaba.Log("Uniform entry", slot, "found")
		entryToOut = {}
		entryToOut.type = entry.type
		entryToOut.cardpill = entry.cardpill
		entryToOut.pilleffect = entry.pilleffect
		if entryToOut.type == "card" then
			entryToOut.Variant = PickupVariant.PICKUP_TAROTCARD
		else
			entryToOut.Variant = PickupVariant.PICKUP_PILL
		end
		success = true
	end
	if pickup and pickup:Exists() then
		wakaba.Log("Pickup to replace found!")
		local tempPickupVariant = pickup.Variant
		local tempPickupSubType = pickup.SubType
		pos = pickup.Position + Vector(0, 0)
		if tempPickupVariant == PickupVariant.PICKUP_TAROTCARD then
			entryToSet = {}
			entryToSet.type = "card"
			entryToSet.cardpill = tempPickupSubType
		elseif tempPickupVariant == PickupVariant.PICKUP_PILL then
			entryToSet = {}
			entryToSet.type = "pill"
			entryToSet.cardpill = tempPickupSubType
			entryToSet.pilleffect = wakaba.G:GetItemPool():GetPillEffect(tempPickupSubType, player)
		end
		pickup:Remove()
	end
	if entryToOut then
		wakaba.Log("Uniform entry", slot, "ejecting")
		local variant = entryToOut.Variant
		local subType = entryToOut.cardpill
		local position = pos or wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40)
		local dummyPickup = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, position, Vector.Zero, nil):ToPickup()
		local newPickup = dummyPickup:Morph(EntityType.ENTITY_PICKUP, variant, subType, false, true, true)
		success = true
	end
	if entryToSet then
		wakaba.Log("Uniform entry", slot, "setting")
		wakaba.save_uniform_data.run[playerIndex][tostring(slot)] = {}
		wakaba.save_uniform_data.run[playerIndex][tostring(slot)].type = entryToSet.type
		wakaba.save_uniform_data.run[playerIndex][tostring(slot)].cardpill = entryToSet.cardpill
		wakaba.save_uniform_data.run[playerIndex][tostring(slot)].pilleffect = entryToSet.pilleffect
		success = true
	elseif entryToOut then
		wakaba.Log("Uniform entry", slot, "removing")
		wakaba.save_uniform_data.run[playerIndex][tostring(slot)] = nil
		success = true
	end
	return success
end

function wakaba:Render_Uniform()
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)

		if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM) then

			local extraLeft = wakaba:getOptionValue("exl")
			local extraRight = wakaba:getOptionValue("exr")
			local extraLeftCont = Keyboard.KEY_LEFT_BRACKET
			local extraRightCont = Keyboard.KEY_RIGHT_BRACKET

			wakaba:initPlayerDataEntry(player, "uniformSlot", 1)
			wakaba:recalculateUniformCursor(player)

			local shift = 0
			if Input.IsButtonTriggered(extraLeft, 0)
				or Input.IsButtonTriggered(extraLeftCont, player.ControllerIndex)
			then shift = -1 end
			if Input.IsButtonTriggered(extraRight, 0)
				or Input.IsButtonTriggered(extraRightCont, player.ControllerIndex)
			then shift = 1 end
			if Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex) then
				shift = 1
			end

			if shift ~= 0 then
				wakaba:addPlayerDataCounter(player, "uniformSlot", shift)
				wakaba:recalculateUniformCursor(player)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_Uniform)


function wakaba:useUniform(player, slot)
	local flag = UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOANIM | UseFlag.USE_NOHUD
	local entries = wakaba:getCurrentWakabaUniformSlot(player)
	for i, item in ipairs(entries) do
		if item.type == "card" then
			wakaba.Log("Trying to use card", item.cardpill, "from slot", i)
			player:UseCard(item.cardpill, flag)
			if wakaba:HasJudasBr(player) then
				player:UseCard(Card.CARD_DEVIL, flag)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) then
				player:AddWisp(wakaba.Enums.Collectibles.UNIFORM, player.Position)
			end
		elseif item.type == "pill" then
			wakaba.Log("Trying to use pill", item.pilleffect, "from slot", i)
			local replacedPillEffect = item.pilleffect
			if FiendFolio and item.pilleffect == FiendFolio.ITEM.PILL.FF_UNIDENTIFIED then
				local pill = item.cardpill
				pill = pill % 2048
				FiendFolio.savedata.run.IdentifiedRunPills = FiendFolio.savedata.run.IdentifiedRunPills or {}
				if not FiendFolio.savedata.run.IdentifiedRunPills[tostring(pill)] then
					FiendFolio.savedata.run.IdentifiedRunPills[tostring(pill)] = true
				end

				local pillreplaced = 1
				if FiendFolio.savedata.run.PillCopies and FiendFolio.savedata.run.PillCopies[tostring(pill)] then
					pillreplaced = FiendFolio.savedata.run.PillCopies[tostring(pill)]
				end

				local itempool = wakaba.G:GetItemPool()
				replacedPillEffect = itempool:GetPillEffect(pillreplaced, player)
				-- check again
				if item.pilleffect == FiendFolio.ITEM.PILL.FF_UNIDENTIFIED then
					player:GetData().wakaba.uniform.items[i].pilleffect = replacedPillEffect
				end
			end
			if wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.ANTI_BALANCE) and item.cardpill < PillColor.PILL_GIANT_FLAG then
				item.cardpill = item.cardpill | PillColor.PILL_GIANT_FLAG
			end
			player:GetData().wakaba_currentPill = item.cardpill
			player:UsePill(replacedPillEffect, item.cardpill, flag)
			if wakaba:HasJudasBr(player) then
				player:UseCard(Card.CARD_DEVIL, flag)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) then
				player:AddWisp(wakaba.Enums.Collectibles.UNIFORM, player.Position)
			end
		end
	end
	player:GetData().wakaba_currentPill = player:GetData().wakaba_reservedPill
	player:GetData().wakaba_reservedPill = nil
	usinguniform = false
end

---@param usedItem CollectibleType
---@param rng RNG
---@param player EntityPlayer
---@param useFlags UseFlag
---@param activeSlot ActiveSlot
---@param varData integer
function wakaba:ItemUse_Uniform(usedItem, rng, player, useFlags, activeSlot, varData)
	local discharge = true
	if (useFlags & (UseFlag.USE_CARBATTERY | UseFlag.USE_VOID | UseFlag.USE_MIMIC) > 0 )
	or (useFlags & UseFlag.USE_OWNED == 0)
	then
		usinguniform = true
		wakaba:useUniform(player)
		goto WakabaUniformUseSkip
	end
	do
		local current = wakaba:getCurrentWakabaUniformCursor(player)
		local pickups = isc:getEntities(EntityType.ENTITY_PICKUP)
		local nearest = isc:getClosestEntityTo(player, pickups,
			function(_, e)
				local isCard = e.Variant == PickupVariant.PICKUP_TAROTCARD
				local isPill = e.Variant == PickupVariant.PICKUP_PILL
				local isShopItem = e:ToPickup():IsShopItem()

				isCard = isCard and not wakaba:has_value(wakaba.Blacklists.Uniform.Cards, e.SubType)

				isPill = isPill and not wakaba:has_value(wakaba.Blacklists.Uniform.PillColor, e.SubType & PillColor.PILL_COLOR_MASK)
				isPill = isPill and not wakaba:has_value(wakaba.Blacklists.Uniform.PillEffect, wakaba.G:GetItemPool():GetPillEffect(e.SubType, player))

				return (isCard or isPill) and not isShopItem
			end
		)
		local success = wakaba:swapUniformEntries(player, current, nearest)
		if success then
			player:AnimateCollectible(wakaba.Enums.Collectibles.UNIFORM, "UseItem", "PlayerPickup")
			SFXManager():Play(SoundEffect.SOUND_GOLDENBOMB)
		else
			player:AnimateSad()
			discharge = false
		end
	end
	::WakabaUniformUseSkip::
	return {Discharge = discharge}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Uniform, wakaba.Enums.Collectibles.UNIFORM)

function wakaba:PocketUse_Uniform(cardpill, player, flags)
	wakaba.Log(flags)
	if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM) and flags & (UseFlag.USE_NOHUD | UseFlag.USE_CARBATTERY | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER) == 0 then
		player:GetData().wakaba_reservedPill = player:GetData().wakaba_currentPill
		usinguniform = true
		wakaba:useUniform(player)
	end
end

wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.PocketUse_Uniform)
wakaba:AddCallback(ModCallbacks.MC_USE_PILL, wakaba.PocketUse_Uniform)

wakaba.__uniformx = 0
wakaba.__uniformy = -1

local uniformIndicatorSprite = Sprite()
uniformIndicatorSprite:Load("gfx/ui/wakaba/uniform_indicator.anm2", true)
--uniformIndicatorSprite:Play("Icon", true)

if REPENTOGON then

	---@param player EntityPlayer
	---@param activeSlot ActiveSlot
	---@param offset Vector
	---@param alpha number
	---@param scale number
	---@param chargeBarOffset Vector
	function wakaba:ActiveRender_Uniform(player, activeSlot, offset, alpha, scale, chargeBarOffset)
		local item = player:GetActiveItem(activeSlot)
		if item == wakaba.Enums.Collectibles.UNIFORM and not player:IsCoopGhost() then
			local pocket = player:GetPocketItem(0)
			local ispocketactive = (pocket:GetSlot() == 3 and pocket:GetType() == 2)

			local renderPos = Vector(wakaba.__uniformx, wakaba.__uniformy)
			local renderScale = Vector(1, 1)

			if activeSlot == ActiveSlot.SLOT_PRIMARY then
			elseif activeSlot == ActiveSlot.SLOT_SECONDARY or (not ispocketactive) then
				renderPos = renderPos / 2
				renderScale = renderScale / 2
			end

			uniformIndicatorSprite.Scale = renderScale

			local config = Isaac.GetItemConfig()

			--local entries = wakaba:getCurrentWakabaUniformSlot(player)
			local max = wakaba:getMaxWakabaUniformSlots(player)
			local current = wakaba:getCurrentWakabaUniformCursor(player)
			for i = 1, max do
				local entry = wakaba:getCurrentWakabaUniformSlot(player, i)
				local renderPos2 = renderPos + (Vector(i * 8, 0) * renderScale)
				if entry then
					local type = entry.type
					local cardpill = entry.cardpill
					local pilleffect = entry.pilleffect

					if type == "card" then
						local conf = config:GetCard(cardpill)
						if conf.CardType == ItemConfig.CARDTYPE_SPECIAL_OBJECT then
							uniformIndicatorSprite:SetFrame("Icon", 5)
						elseif conf.CardType == ItemConfig.CARDTYPE_RUNE then
							uniformIndicatorSprite:SetFrame("Icon", 4)
						else
							uniformIndicatorSprite:SetFrame("Icon", 2)
						end
					elseif type == "pill" then
						uniformIndicatorSprite:SetFrame("Icon", 3)
					else
						uniformIndicatorSprite:SetFrame("Icon", 1)
					end
					uniformIndicatorSprite:Render(renderPos2 + offset, Vector.Zero, Vector.Zero)
				else
					uniformIndicatorSprite:SetFrame("Icon", 1)
					uniformIndicatorSprite:Render(renderPos2 + offset, Vector.Zero, Vector.Zero)
				end
				if i == current then
					uniformIndicatorSprite:SetFrame("Icon", 0)
					uniformIndicatorSprite:Render(renderPos2 + offset, Vector.Zero, Vector.Zero)
				end
			end

		end
	end

	wakaba:AddCallback(ModCallbacks.MC_POST_PLAYERHUD_RENDER_ACTIVE_ITEM, wakaba.ActiveRender_Uniform)
end

if EID then
	local function UniformCondition_CardPill(descObj)
		if EID.InsideItemReminder then return false end
		if not descObj.Entity then return false end
		if not (descObj.ObjType == 5 and (descObj.ObjVariant == PickupVariant.PICKUP_TAROTCARD or descObj.ObjVariant == PickupVariant.PICKUP_PILL)) then return false end
		if not (descObj.Entity.Type == 5 and (descObj.Entity.Variant == PickupVariant.PICKUP_TAROTCARD or descObj.Entity.Variant == PickupVariant.PICKUP_PILL)) then return false end

		local player = EID.player
		local isCard = descObj.ObjVariant == PickupVariant.PICKUP_TAROTCARD
		local isPill = descObj.ObjVariant == PickupVariant.PICKUP_PILL
		local isShopItem = descObj.Entity:ToPickup():IsShopItem()

		isCard = isCard and not wakaba:has_value(wakaba.Blacklists.Uniform.Cards, descObj.ObjSubType)

		isPill = isPill and not wakaba:has_value(wakaba.Blacklists.Uniform.PillColor, descObj.ObjSubType & PillColor.PILL_COLOR_MASK)
		isPill = isPill and not wakaba:has_value(wakaba.Blacklists.Uniform.PillEffect, wakaba.G:GetItemPool():GetPillEffect(descObj.ObjSubType, player))

		return (isCard or isPill) and not isShopItem
	end

	local function UniformCallback_CardPill(descObj)
		local player = EID.player
		local unistr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].uniform) or wakaba.descriptions["en"].uniform
		local eidstring = ""
		for _, player in ipairs(EID.coopAllPlayers) do
			if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM) then
				local playerID = player:GetPlayerType()
				local birthrightDesc = EID:getDescriptionEntry("birthright", playerID+1)
				local playerName = birthrightDesc and birthrightDesc[1] or player:GetName()
				local playerStr = "" .. (EID:getIcon("Player"..playerID) ~= EID.InlineIcons["ERROR"] and "{{Player"..playerID.."}}" or "") .. ""..playerName..""

				descObj.Description =
					descObj.Description
					.. "#{{Collectible"..wakaba.Enums.Collectibles.UNIFORM.."}} "
					.. unistr.pickupprefix
					.. playerStr
					.. unistr.pickupmidfix
					.. (wakaba:getCurrentWakabaUniformCursor(player))
					.. unistr.pickupsubfix
			end
		end
		return descObj
	end
	EID:addDescriptionModifier("Wakaba's Uniform_CardPill", UniformCondition_CardPill, UniformCallback_CardPill)
end
do
	---@return InventoryDescEntry[]
	function wakaba:InvdescEntries_Uniform()
		local idesc = wakaba._InventoryDesc
		local entries = {} ---@type InventoryDescEntry[]
		for i = 0, wakaba.G:GetNumPlayers() - 1 do
			ei = {}
			local player = Isaac.GetPlayer(i)
			local playerType = player:GetPlayerType()

			if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM, true, true) then
				local max = wakaba:getMaxWakabaUniformSlots(player)
				for i = 1, max do
					local entry = wakaba:getCurrentWakabaUniformSlot(player, i)
					if entry then
						local type = entry.type
						local cardpill = entry.cardpill
						local pilleffect = entry.pilleffect
						if type == "card" then
							---@type InventoryDescEntry
							local entry = {
								Type = InvDescEIDType.CARD,
								Variant = PickupVariant.PICKUP_TAROTCARD,
								SubType = cardpill,
								Frame = function()
									return idesc:getOptions("q0icon")
								end,
								LeftIcon = "{{Player"..player:GetPlayerType().."}}",
								ExtraIcon = "{{Collectible"..wakaba.Enums.Collectibles.UNIFORM.."}}",
								ListSecondaryTitle = EID:getObjectName(5, 100, wakaba.Enums.Collectibles.UNIFORM) .. " Slot " .. i,
							}
							table.insert(entries, entry)
						elseif type == "pill" then
							---@type InventoryDescEntry
							local entry = {
								Type = InvDescEIDType.PILL,
								Variant = PickupVariant.PICKUP_PILL,
								SubType = cardpill,
								IsHidden = not wakaba.G:GetItemPool():IsPillIdentified(cardpill),
								Frame = function()
									return idesc:getOptions("q0icon")
								end,
								LeftIcon = "{{Player"..player:GetPlayerType().."}}",
								ExtraIcon = "{{Collectible"..wakaba.Enums.Collectibles.UNIFORM.."}}",
								ListSecondaryTitle = EID:getObjectName(5, 100, wakaba.Enums.Collectibles.UNIFORM) .. " Slot " .. i,
							}
						else
						end
					else
					end
				end
			end
		end
		return entries
	end
	wakaba:AddPriorityCallback(wakaba.Callback.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES, -339, function (_) return wakaba:InvdescEntries_Uniform() end)
end