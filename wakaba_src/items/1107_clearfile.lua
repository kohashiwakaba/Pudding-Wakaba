--[[
	Clear File (클리어 파일) - 액티브(Active) - ? rooms
	- REPENTOGON 전용
	- 사용 시 선택한 패시브 중 하나와 받침대 패시브 하나를 교체
]]
local isc = _wakaba.isc

---@param player EntityPlayer
---@param rng RNG
---@return InventoryDescEntry[]
local function makeClearFileEntries(player, rng)
	local entries = {} ---@type InventoryDescEntry[]
	if REPENTOGON then
		local passives = player:GetCollectiblesList()
		for collectibleType, count in pairs(passives) do
			if collectibleType > 0 and count > 0 then
				local conf = EID.itemConfig:GetCollectible(tonumber(collectibleType))
				local quality = tonumber(conf.Quality)
				local isQuest = conf:HasTags(ItemConfig.TAG_QUEST)
				local isPassive = conf.Type ~= ItemType.ITEM_ACTIVE
				if not isQuest and isPassive then
					---@type InventoryDescEntry
					local entry = {
						--ListSecondaryTitle = "",
						Type = InvDescEIDType.COLLECTIBLE,
						Variant = PickupVariant.PICKUP_COLLECTIBLE,
						SubType = collectibleType,
						AllowModifiers = true,
						Frame = 20,
						LeftIcon = "{{Quality"..quality.."}}",
						InnerText = collectibleType,
						ExtraIcon = "{{Collectible"..wakaba.Enums.Collectibles.CLEAR_FILE.."}}",
					}
					table.insert(entries, entry)
				end
			end
		end
	else
		local passives = EID:GetAllPassiveItems()
		for i, collectibleType in ipairs(passives) do
			if collectibleType > 0 and player:HasCollectible(collectibleType, true) then
				local conf = EID.itemConfig:GetCollectible(tonumber(collectibleType))
				local quality = tonumber(conf.Quality)
				local isQuest = conf:HasTags(ItemConfig.TAG_QUEST)
				if not isQuest then
					---@type InventoryDescEntry
					local entry = {
						--ListSecondaryTitle = "",
						Type = InvDescEIDType.COLLECTIBLE,
						Variant = PickupVariant.PICKUP_COLLECTIBLE,
						SubType = collectibleType,
						AllowModifiers = true,
						Frame = 20,
						LeftIcon = "{{Quality"..quality.."}}",
						InnerText = collectibleType,
						ExtraIcon = "{{Collectible"..wakaba.Enums.Collectibles.CLEAR_FILE.."}}",
					}
					table.insert(entries, entry)
				end
			end
		end
	end
	return entries
end

---@param entity Entity
local function isClearFileCapable(target)
	if target:GetSprite():IsPlaying("Collect") or target:GetSprite():IsPlaying("PlayerPickupSparkle") then return false end

	local eType = target.Type
	local eVariant = target.Variant
	local eSubType = target.SubType

	local conf = Isaac.GetItemConfig()

	local isCollectible = (
		eType == EntityType.ENTITY_PICKUP
		and eVariant == PickupVariant.PICKUP_COLLECTIBLE
	)

	local isEmptyPedestal = (
		eType == EntityType.ENTITY_PICKUP
		and eVariant == PickupVariant.PICKUP_COLLECTIBLE
		and eSubType < 1
	)

	local isPassive = (
		conf:GetCollectible(eSubType) and conf:GetCollectible(eSubType).Type ~= ItemType.ITEM_ACTIVE
	)
	return isCollectible and target:Exists() and not isEmptyPedestal and isPassive
end

---@param player EntityPlayer
local function FindTarget(player)
	local pData = player:GetData()

	local collectibles = isc:getEntities(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
	local nearest = isc:getClosestEntityTo(player, collectibles, function(_, e) return isClearFileCapable(e) end)
	if nearest then

		local isCurrentTarget =
			pData.w_clearFileTarget
			and pData.w_clearFileTarget:Exists()
			and pData.w_clearFileTarget.InitSeed == nearest.InitSeed
			and GetPtrHash(pData.w_clearFileTarget) == GetPtrHash(nearest) -- Required to check save and continue

		if not pData.w_clearFileTarget then
			pData.w_clearFileTarget = nearest:ToPickup()
		elseif not isCurrentTarget then
			pData.w_clearFileTarget = nearest:ToPickup()
		end
	else
		pData.w_clearFileTarget = nil
	end
end

---@param player EntityPlayer
function wakaba:PlayerUpdate_ClearFile(player)
	local pData = player:GetData()
	local hasClearFile = player:HasCollectible(wakaba.Enums.Collectibles.CLEAR_FILE, true)

	if hasClearFile then
		local idesc = wakaba._InventoryDesc ---@type InventoryDescriptions
		local istate = idesc.state
		local iListPropName = idesc:getListPropName()
		if (not pData.w_clearFileTarget or player.FrameCount % 6 == 0) and not (istate.showList and iListPropName == "wakaba_clearfile") then
			FindTarget(player)
		end
	elseif pData.w_clearFileTarget then
		pData.w_clearFileTarget = nil
	end

	if pData.w_clearFileTarget then
		if not pData.w_clearFileCursor then
			pData.w_clearFileCursor = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TARGET, 0, player.Position, Vector.Zero, player)
			local s = pData.w_clearFileCursor:GetSprite()
			s:ReplaceSpritesheet(0, "gfx/effects/target_wakaba_clearfile.png")
			s:LoadGraphics()
			local c = Color(0.9, 0.9, 0.9, 1)
			pData.w_clearFileCursor.Color = c
			pData.w_clearFileCursor:GetData().w_clearFileCursor = true
		end
		pData.w_clearFileCursor.Target = pData.w_clearFileTarget
		pData.w_clearFileCursor.Position = pData.w_clearFileTarget.Position
		pData.w_clearFileCursor.DepthOffset = pData.w_clearFileTarget.DepthOffset - 50
		pData.w_clearFileCursor.SpriteScale = Vector(0.1, 0.1) * pData.w_clearFileTarget.Size * pData.w_clearFileTarget.SizeMulti

		if pData.w_clearFileTarget.FrameCount % 20 == 0 then
			local c1 = pData.w_clearFileTarget.Color
			c1:SetColorize(3, 3, 3, 1)
			pData.w_clearFileTarget:SetColor(c1, 20, 1, true, true)

			local c2 = pData.w_clearFileCursor.Color
			c2:SetColorize(4, 4, 4, 1)
			pData.w_clearFileCursor:SetColor(c2, 20, 1, true, true)
		end
	elseif pData.w_clearFileCursor then
		pData.w_clearFileCursor:Remove()
		pData.w_clearFileCursor = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_ClearFile)

---@param idesc InventoryDescriptions
---@param entity Entity
---@param inputHook InputHook
---@param buttonAction ButtonAction
---@return boolean
function wakaba:IDescLockInput_ClearFile(idesc, entity, inputHook, buttonAction)
	local iListPropName = idesc:getListPropName()
	if iListPropName == "wakaba_clearfile" then
		if buttonAction == ButtonAction.ACTION_ITEM and (not entity:ToPlayer() or entity:ToPlayer():GetActiveItem(ActiveSlot.SLOT_PRIMARY) == wakaba.Enums.Collectibles.CLEAR_FILE) then
			return true
		end
		if buttonAction == ButtonAction.ACTION_PILLCARD and (not entity:ToPlayer() or entity:ToPlayer():GetActiveItem(ActiveSlot.SLOT_POCKET) == wakaba.Enums.Collectibles.CLEAR_FILE) then
			return true
		end
	end
end
wakaba:AddCallback(wakaba.Callback.INVENTORY_DESCRIPTIONS_PRE_LOCK_INPUT, wakaba.IDescLockInput_ClearFile)

---@param item CollectibleType
---@param rng RNG
---@param player EntityPlayer
---@param useFlags UseFlag
---@param activeSlot ActiveSlot
---@param varData integer
function wakaba:ItemUse_ClearFile(item, rng, player, useFlags, activeSlot, varData)
	if useFlags & UseFlag.USE_CARBATTERY > 0 or activeSlot < 0 then return end
	local pData = player:GetData()
	if not (pData.w_clearFileTarget and pData.w_clearFileTarget:Exists()) then
		player:AnimateSad()
		return {
			Discharge = false,
			Remove = false,
			ShowAnim = false,
		}
	end

	local idesc = wakaba._InventoryDesc ---@type InventoryDescriptions
	local istate = idesc.state
	local iListPropName = idesc:getListPropName()

	if istate.showList and iListPropName == "wakaba_clearfile" then
		local entries = idesc:currentEntries()
		local current = istate.listprops.current
		local sel = entries[current]
		local type = sel.SubType

		local target = pData.w_clearFileTarget ---@type EntityPickup
		local newType = target.SubType
		local touched = target.Touched
		local oldPrice = target.Price
		wakaba.Log("Clear File To replace:", type, "nearby pedestal:", newType)

		-- trail : player to target
		--[[ do
			local trail = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SPRITE_TRAIL, 0, player.Position, Vector.Zero, nil):ToEffect()
			trail:FollowParent(target) -- parents the trail to another entity and makes it follow it around
			trail.MinRadius = 0.1 -- fade rate, lower values yield a longer trail
			trail:GetSprite().Color = Color(0.14, 0.1, 0.7, 1, 0, 0, 0.3) -- sets the color of the trail
			trail.Timeout = 2
			trail:Update()
		end ]]
		-- trail : target to player
		--[[ do
			local trail = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SPRITE_TRAIL, 0, target.Position, Vector.Zero, nil):ToEffect()
			trail:FollowParent(player) -- parents the trail to another entity and makes it follow it around
			trail.MinRadius = 0.1 -- fade rate, lower values yield a longer trail
			trail:GetSprite().Color = Color(0.7, 0.1, 0.14, 1, 0, 0, 0.3) -- sets the color of the trail
			trail.Timeout = 2
			trail:Update()
		end ]]
		if REPENTOGON then
			player:DropCollectible(type, target)
			player:AddCollectible(newType, 0, not touched)
			target.Price = oldPrice
		else
			player:RemoveCollectible(type, true, -1, false)
			target:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, type, true, true, true)
			target.Touched = true
			player:AddCollectible(newType, 0, not touched)
		end
		if wakaba:IsGoldenItem(wakaba.Enums.Collectibles.CLEAR_FILE, player) then
			if Epiphany then
				if tonumber(Epiphany.VERSION) >= 7.5 then
					Epiphany.Pickup.GOLDEN_ITEM:TurnPedestalGold(target, false)
				else
					Epiphany.Pickup.GOLDEN_ITEM:TurnItemGold(target, false)
				end
			end
		end
		idesc:resetEntries()
		player:AnimateCollectible(newType, "HideItem", "PlayerPickup")
		--player:GetEffects():RemoveCollectibleEffect(item, -1)
		return {
			Discharge = true,
			Remove = false,
			ShowAnim = false,
		}
	else
		local entries = makeClearFileEntries(player, rng)
		local listMode = idesc:getOptions("invlistmode", "list")
		if idesc:showEntries(entries, listMode, true, false, "wakaba_clearfile") then
			--player:AnimateCollectible(item, "LiftItem", "PlayerPickup")
			idesc:setDisplayNames("Select item to swap", "Use item to confirm")
			istate.savedtimer = wakaba.G.TimeCounter
			player:GetData().InvDescPlayerControlsDisabled = true
		else
			player:AnimateSad()
		end
		return {
			Discharge = false,
			Remove = false,
			ShowAnim = false,
		}
	end
end

wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_ClearFile, wakaba.Enums.Collectibles.CLEAR_FILE)