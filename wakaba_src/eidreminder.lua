
local isc = require("wakaba_src.libs.isaacscript-common")



---comment
---@param id string
---@return table
---@return integer
function wakaba:EIDItemReminder_GetEntry(id)
	for i, t in ipairs(EID.ItemReminderCategories) do
		if t.id == id then
			return t, i
		end
	end
end

---@param id string
---@return integer
function wakaba:EIDItemReminder_GetIndex(id)
	for i, t in ipairs(EID.ItemReminderCategories) do
		if t.id == id then
			return i
		end
	end
end

do
	local index = wakaba:EIDItemReminder_GetIndex("Special")
	table.insert(EID.ItemReminderCategories, index, {id = "w_Character", entryGenerators = {
		function(player) wakaba:EIDItemReminder_HandleCharacters(player) end,
	}})
	table.insert(EID.ItemReminderCategories, index+1, {id = "w_Starting", entryGenerators = {
		--function(player) wakaba:EIDItemReminder_HandleCharacters(player) end,
	}})
	table.insert(EID.ItemReminderCategories, index+2, {id = "w_Curse", entryGenerators = {
		function(player) wakaba:EIDItemReminder_HandleCurses(player) end,
	}})
end

do
	local index = wakaba:EIDItemReminder_GetIndex("Pockets")
	table.insert(EID.ItemReminderCategories, index, {id = "w_WakabaUniform", entryGenerators = {
		function(player) wakaba:EIDItemReminder_HandleWakabaUniform(player) end,
	}})
end

do
	local index = wakaba:EIDItemReminder_GetIndex("Passives")
	local ent = EID.ItemReminderCategories[index]
	if ent and ent.entryGenerators then
		local gen = ent.entryGenerators
		table.insert(gen, #gen -1 , function(player)
			if wakaba:hasAlbireo(player) then
				EID:ItemReminderAddDescription(player, 5, 100, wakaba.Enums.Collectibles.WINTER_ALBIREO)
			end
		end)
	end
end

function wakaba:EIDItemReminder_HandleCharacters(player)
	local t = player:GetPlayerType()
	local entry = wakaba.descriptions["en_us"].playernotes[t] or wakaba.descriptions["en_us"].playernotes[-666]
	local icon = (entry.icon and "{{"..entry.icon.."}}") or (EID:getIcon("Player"..t) ~= EID.InlineIcons["ERROR"] and "{{Player"..t.."}}" or "{{CustomTransformation}}")
	EID:ItemReminderAddDescription(player, -997, -1, t, icon)
end

function wakaba:EIDItemReminder_HandleWakabaUniform(player)
	if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM, true) then
		EID:ItemReminderAddDescription(player, 5, 100, wakaba.Enums.Collectibles.UNIFORM)
	end
end

local function getMaxCurseId(curse)
	local maxloop = 0
	while curse > 0 do
		maxloop = maxloop + 1
		curse = curse // 2
	end
	return maxloop
end

function wakaba:EIDItemReminder_HandleCurses(player)
	if player.ControllerIndex ~= 0 then return end
	local currCurse = wakaba.G:GetLevel():GetCurses()
	for curseId = 0, getMaxCurseId(currCurse) do
		if 1 << curseId & currCurse > 0 then
			local c = 1 << curseId
			local entry = wakaba.descriptions["en_us"].curses[c]
			local icon = entry and entry.icon and "{{"..entry.icon.."}}"
			EID:ItemReminderAddDescription(player, wakaba.INVDESC_TYPE_CURSE, wakaba.INVDESC_VARIANT, c, icon)
		end
	end
end

EID.ItemReminderDescriptionModifier["5.100."..wakaba.Enums.Collectibles.WINTER_ALBIREO] = {
	modifierFunction = function(descObj, player)
		local pool = wakaba:GetAlbireoPool()
		if pool then
			local prepend = EID:getDescriptionEntry("AlbireoPool")
			local poolDescTable = EID:getDescriptionEntry("itemPoolNames")
			poolName = (EID.ItemPoolTypeToMarkup[pool] or "{{ItemPoolTreasure}}")..poolDescTable[pool] .. "{{CR}}#"
			descObj.Description = prepend .. poolName
		end
	end,
}

EID.ItemReminderDescriptionModifier["5.100."..wakaba.Enums.Collectibles.CUNNING_PAPER] = {
	isCheat = true,
	modifierFunction = function(descObj, player)
		local playerIndex = isc:getPlayerIndex(player)
		local card = wakaba.cunningPaperData[playerIndex]
		local demoDescObj = EID:getDescriptionObj(5, 300, card)
		EID:ItemReminderAddResultHeaderSuffix(descObj, demoDescObj.Name)
		descObj.Icon = "{{Card"..card.."}}"
		descObj.Description = demoDescObj.Description
	end,
}