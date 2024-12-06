
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:PlayerUpdate_Shifter(player)
end

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
	local newType = collectibleType
	if collectibleType < 0 then
		newType = Isaac.GetItemConfig():GetCollectibles().Size - 1
	end
	local remainingCount = count
	while remainingCount > 0 do

	end
	return newType
end

if EID then

	local function STCondition(descObj)
		if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and not wakaba:IsQuestItem(descObj.ObjSubType) then
			return true
		end
		return false
	end
	local function STCallback(descObj)
		local icon = "{{Collectible"..wakaba.Enums.Collectibles.SHIFTER.."}}"
		local append = EID:getDescriptionEntry("WakabaVintageHotkey") or EID:getDescriptionEntryEnglish("WakabaVintageHotkey")
		descObj.Name = "{{ColorRed}}"..descObj.Name.."{{CR}}"
		EID:appendToDescription(descObj, "".. append:gsub("{1}", InputHelper.KeyboardToString[wakaba.state.options.vintagetriggerkey]) .. "{{CR}}")
		return descObj
	end
	EID:addDescriptionModifier("Richer Shifter", STCondition, STCallback)
end