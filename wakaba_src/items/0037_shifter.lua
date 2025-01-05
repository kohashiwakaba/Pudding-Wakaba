
local isc = require("wakaba_src.libs.isaacscript-common")
local searchPartitions = EntityPartition.PICKUP

function wakaba:hasShifter(player)
	return player:HasCollectible(wakaba.Enums.Collectibles.SHIFTER, true)
	or player:HasCollectible(wakaba.Enums.Collectibles.SHIFTER_PASSIVE, true)
	or (DifficultyManager and DifficultyManager.GetDifficulty() == "UpDown")
end

---@param pickup EntityPickup
---@param shift integer `1|-1`
---@param count integer
---@return EntityEffect
function wakaba:spawnShiftResultEffect(pickup, shift, count)
	if not (shift and count) then return end
	local animToPlay
	local overlay = ""
	if shift == 1 then
		animToPlay = "ShiftUp"
	elseif shift == -1 then
		animToPlay = "ShiftDown"
	end
	if type(count) ~= "number" or count < 0 or count > 9 then
		overlay = "U"
	else
		overlay = count
	end
	local offset = pickup:IsShopItem() and 40 or 64
	local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 401, pickup.Position - Vector(15, offset), Vector.Zero, nil):ToEffect()
	local spr = effect:GetSprite()
	spr:Play(animToPlay, true)
	spr:PlayOverlay("UpDown"..overlay, true)

	return effect
end

---@param entity Entity
local function isShifterCapable(target)
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

	local isStory = (
		conf:GetCollectible(eSubType) and conf:GetCollectible(eSubType):HasTags(ItemConfig.TAG_QUEST)
	)
	return isCollectible and target:Exists() and not isEmptyPedestal and not isStory
end

---@param player EntityPlayer
local function FindTarget(player)
	local pData = player:GetData()

	local collectibles = Isaac.FindInRadius(player.Position, tonumber(EID.Config["MaxDistance"])*40, searchPartitions)
	local nearest = isc:getClosestEntityTo(player, collectibles, function(_, e) return isShifterCapable(e) end)
	if nearest then

		local isCurrentTarget =
			pData.w_shifterTarget
			and pData.w_shifterTarget:Exists()
			and pData.w_shifterTarget.InitSeed == nearest.InitSeed
			and GetPtrHash(pData.w_shifterTarget) == GetPtrHash(nearest) -- Required to check save and continue

		if not pData.w_shifterTarget then
			pData.w_shifterTarget = nearest:ToPickup()
		elseif not isCurrentTarget then
			pData.w_shifterTarget = nearest:ToPickup()
		end
	else
		pData.w_shifterTarget = nil
	end
end

local keyPressFrame = 0

---@param player EntityPlayer
function wakaba:PlayerUpdate_Shifter(player)
	local pData = player:GetData()
	local hasShifter = wakaba:hasShifter(player)
	if hasShifter then
		local idesc = wakaba._InventoryDesc ---@type InventoryDescriptions
		local istate = idesc.state
		if (not pData.w_shifterTarget or player.FrameCount % 6 == 0) and not (istate.showList) then
			FindTarget(player)
		end

		local extraLeft = wakaba:getOptionValue("gdkey")
		local extraRight = wakaba:getOptionValue("gpkey")
		local extraLeftCont = Keyboard.KEY_6
		local extraRightCont = Keyboard.KEY_7

		local shift = 0
		local currFrame = wakaba.G:GetFrameCount()
		if currFrame > keyPressFrame then
			if Input.IsButtonTriggered(extraLeft, 0)
				or Input.IsButtonTriggered(extraLeftCont, player.ControllerIndex)
			then
				if not (pData.w_shifterTarget and pData.w_shifterTarget:Exists()) then
					SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN)
					return
				end

				local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.SHIFTER)
				local min = wakaba.Flags.shifterMin
				local max = wakaba.Flags.shifterMax
				local randMax = max - min
				local random = REPENTOGON and rng:RandomInt(min, max) or rng:RandomInt(randMax) + min
				wakaba:shiftItem(pData.w_shifterTarget, -1, random)

				keyPressFrame = currFrame
				return
			end
			if Input.IsButtonTriggered(extraRight, 0)
				or Input.IsButtonTriggered(extraRightCont, player.ControllerIndex)
			then
				if not (pData.w_shifterTarget and pData.w_shifterTarget:Exists()) then
					SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN)
					return
				end

				local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.SHIFTER)
				local min = wakaba.Flags.shifterMin
				local max = wakaba.Flags.shifterMax
				local randMax = max - min
				local random = REPENTOGON and rng:RandomInt(min, max) or rng:RandomInt(randMax) + min
				wakaba:shiftItem(pData.w_shifterTarget, 1, random)

				keyPressFrame = currFrame
				return
			end
		end

	elseif pData.w_shifterTarget then
		pData.w_shifterTarget = nil
	end

	if pData.w_shifterTarget then
		if not pData.w_shifterCursor then
			pData.w_shifterCursor = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TARGET, 0, player.Position, Vector.Zero, player)
			local s = pData.w_shifterCursor:GetSprite()
			s:ReplaceSpritesheet(0, "gfx/effects/target_wakaba_shifter.png")
			s:LoadGraphics()
			local c = Color(0.9, 0.3, 0.9, 1)
			pData.w_shifterCursor.Color = c
			pData.w_shifterCursor:GetData().w_shifterCursor = true
		end
		pData.w_shifterCursor.Target = pData.w_shifterTarget
		pData.w_shifterCursor.Position = pData.w_shifterTarget.Position
		pData.w_shifterCursor.DepthOffset = pData.w_shifterTarget.DepthOffset - 50
		pData.w_shifterCursor.SpriteScale = Vector(0.1, 0.1) * pData.w_shifterTarget.Size * pData.w_shifterTarget.SizeMulti

		if pData.w_shifterTarget.FrameCount % 20 == 0 then
			--local c1 = pData.w_shifterTarget.Color
			--c1:SetColorize(3, 3, 3, 1)
			--pData.w_shifterTarget:SetColor(c1, 20, 1, true, true)

			local c2 = pData.w_shifterCursor.Color
			c2:SetColorize(4, 4, 1, 1)
			pData.w_shifterCursor:SetColor(c2, 20, 1, true, true)
		end
	elseif pData.w_shifterCursor then
		pData.w_shifterCursor:Remove()
		pData.w_shifterCursor = nil
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Shifter)

function wakaba:UseItem_Shifter(activeItem, rng, player, flags, slot, vardata)
	if flags & UseFlag.USE_OWNED == 0 then return end
	local showAnim = true
	return {
		ShowAnim = showAnim,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_Shifter, wakaba.Enums.Collectibles.SHIFTER)

---@param shift integer `1|-1`
---@param count integer
---@param collectibleType CollectibleType
---@return CollectibleType
function wakaba:getNextIDFromShifter(shift, count, collectibleType)
	if not (shift and count) then return collectibleType end
	if wakaba:IsQuestItem(collectibleType) then return collectibleType end
	local maxID = Isaac.GetItemConfig():GetCollectibles().Size - 1
	local newType = collectibleType
	if collectibleType < 0 then
		newType = maxID
	end
	local remainingCount = count
	while remainingCount > 0 do
		local shifted = false
		newType = newType + shift
		if newType < 0 then
			newType = maxID
		elseif newType > maxID then
			newType = CollectibleType.COLLECTIBLE_SAD_ONION
		end
		local c = Isaac.GetItemConfig():GetCollectible(newType)
		shifted = c and c:IsAvailable() and not c.Hidden and not c:HasTags(ItemConfig.TAG_QUEST)
		if shifted then
			remainingCount = remainingCount - 1
		end
	end
	return newType
end

---@param pickup EntityPickup
---@param shift integer `1|-1`
---@param count integer
function wakaba:shiftItem(pickup, shift, count)
	if not (pickup or pickup:Exists()) then return end
	local current = pickup.SubType
	local next = wakaba:getNextIDFromShifter(shift, count, current)
	pickup.SubType = next
	local sprite = pickup:GetSprite()
	sprite:ReplaceSpritesheet(1, isc:getCollectibleGfxFilename(next))
	sprite:LoadGraphics()
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector(0,0), nil)
	wakaba:spawnShiftResultEffect(pickup, shift, count)
	SFXManager():Play(SoundEffect.SOUND_BLACK_POOF)
	wakaba.Log("Shift item result from ", current, "/ shift by ", count, "/ to ", next)
end

if EID then
	local function wr(id)
		return "{{Collectible"..id.."}}"
	end

	local function STCondition(descObj)
		if not (
			wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.SHIFTER)
			or wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.SHIFTER_PASSIVE)
			or (DifficultyManager and DifficultyManager.GetDifficulty() == "UpDown")
		) then return false end
		if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and not wakaba:IsQuestItem(descObj.ObjSubType) then
			return true
		end
		return false
	end
	local function STCallback(descObj)
		local baseID = descObj.ObjSubType
		local downIDs = ""
		local upIDs = ""
		for i = (wakaba.Flags.shifterMin or 0), (wakaba.Flags.shifterMax or 4) do
			downIDs = wr(wakaba:getNextIDFromShifter(-1, i, baseID)) .. downIDs
			upIDs = upIDs .. wr(wakaba:getNextIDFromShifter(1, i, baseID))
		end

		local icon = "#{{Collectible"..wakaba.Enums.Collectibles.SHIFTER.."}} {{NoLB}}: "
		local append = downIDs .. "|↓{{Collectible".. baseID .."}}↑|" ..upIDs
		--EID:appendToDescription(descObj, "".. append:gsub("{1}", InputHelper.KeyboardToString[wakaba.state.options.vintagetriggerkey]) .. "{{CR}}")
		EID:appendToDescription(descObj, icon .. append)
		return descObj
	end
	EID:addDescriptionModifier("Richer Shifter", STCondition, STCallback)

end
do
	---@return InventoryDescEntry[]
	function wakaba:InvdescEntries_Shifter()
		local idesc = wakaba._InventoryDesc ---@type InventoryDescriptions
		local entries = {} ---@type InventoryDescEntry[]
		for i = 0, wakaba.G:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local playerType = player:GetPlayerType()
			if wakaba:hasShifter(player) and player:GetData().w_shifterTarget then
				local min, max = (wakaba.Flags.shifterMin or 0), (wakaba.Flags.shifterMax or 4)
				local baseID = player:GetData().w_shifterTarget.SubType
				for i = min, max do
					local downID = wakaba:getNextIDFromShifter(-1, i, baseID)
					local upID = wakaba:getNextIDFromShifter(1, i, baseID)

					---@type InventoryDescEntry
					local upEntry = {
						Type = InvDescEIDType.COLLECTIBLE,
						Variant = PickupVariant.PICKUP_COLLECTIBLE,
						SubType = upID,
						Frame = function()
							return 4
						end,
						LeftIcon = "{{Collectible"..wakaba.Enums.Collectibles.SHIFTER.."}}",
						ExtraIcon = "{{WakabaUp"..i.."}}",
						ListSecondaryTitle = EID:getObjectName(5, 100, wakaba.Enums.Collectibles.SHIFTER) .. " +" .. i .. " Result",
					}
					---@type InventoryDescEntry
					local downEntry = {
						Type = InvDescEIDType.COLLECTIBLE,
						Variant = PickupVariant.PICKUP_COLLECTIBLE,
						SubType = downID,
						Frame = function()
							return 4
						end,
						LeftIcon = "{{Collectible"..wakaba.Enums.Collectibles.SHIFTER.."}}",
						ExtraIcon = "{{WakabaDown"..i.."}}",
						ListSecondaryTitle = EID:getObjectName(5, 100, wakaba.Enums.Collectibles.SHIFTER) .. " +" .. i .. " Result",
					}
					table.insert(entries, upEntry)
					table.insert(entries, 1, downEntry)
				end
				break
			end
		end
		return entries
	end
	wakaba:AddPriorityCallback(wakaba.Callback.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES, -348, function (_) return wakaba:InvdescEntries_Shifter() end)
end