local isc = require("wakaba_src.libs.isaacscript-common")

wakaba.Reminder = {}
wakaba.Reminder.DefaultItems = {
	[PlayerType.PLAYER_LAZARUS] = {
		{
			item = CollectibleType.COLLECTIBLE_LAZARUS_RAGS
		},
		{
			item = CollectibleType.COLLECTIBLE_ANEMIC,
			cond = function()
				EID:HaveUnlockedAchievement(Achievement.LAZARUS_BLEEDS_MORE)
			end,
		},
	},
	[PlayerType.PLAYER_LAZARUS2] = {
		{
			item = CollectibleType.COLLECTIBLE_ANEMIC
		},
	},
	[PlayerType.PLAYER_THELOST] = {
		{
			item = CollectibleType.COLLECTIBLE_HOLY_MANTLE,
			cond = function()
				EID:HaveUnlockedAchievement(Achievement.LOST_HOLDS_HOLY_MANTLE)
			end,
		},
	},
	[PlayerType.PLAYER_LILITH] = {
		{
			item = CollectibleType.COLLECTIBLE_INCUBUS
		},
	},
	[PlayerType.PLAYER_SAMSON_B] = {
		{
			item = CollectibleType.COLLECTIBLE_BERSERK
		},
	},
	[PlayerType.PLAYER_AZAZEL_B] = {
		{
			item = CollectibleType.COLLECTIBLE_HEMOPTYSIS
		},
	},
	[PlayerType.PLAYER_LILITH_B] = {
		{
			item = CollectibleType.COLLECTIBLE_GELLO
		},
	},
	[wakaba.Enums.Players.WAKABA] = {
		{
			item = wakaba.Enums.Collectibles.WAKABAS_BLESSING,
		},
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		{
			item = wakaba.Enums.Collectibles.WAKABAS_NEMESIS,
		},
	},
	[wakaba.Enums.Players.SHIORI] = {
		{
			item = wakaba.Enums.Collectibles.BOOK_OF_SHIORI,
		},
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		{
			item = wakaba.Enums.Collectibles.BOOK_OF_SHIORI,
		},
		{
			item = wakaba.Enums.Collectibles.MINERVA_AURA,
		},
	},
	[wakaba.Enums.Players.TSUKASA] = {
		{
			item = wakaba.Enums.Collectibles.LUNAR_STONE,
		},
		{
			item = wakaba.Enums.Collectibles.CONCENTRATION,
		},
		{
			item = wakaba.Enums.Collectibles.NASA_LOVER,
			cond = function()
				wakaba:IsCompletionItemUnlockedTemp("nasalover")
			end,
		},
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		{
			item = wakaba.Enums.Collectibles.MURASAME,
		},
		{
			item = wakaba.Enums.Collectibles.FLASH_SHIFT,
		},
		{
			item = wakaba.Enums.Collectibles.ELIXIR_OF_LIFE,
		},
	},
	[wakaba.Enums.Players.RICHER] = {
		{
			item = wakaba.Enums.Collectibles.RABBIT_RIBBON,
		},
		{
			item = CollectibleType.COLLECTIBLE_MOMS_BOX,
		},
		{
			item = CollectibleType.COLLECTIBLE_WAFER,
		},
	},
	[wakaba.Enums.Players.RICHER_B] = {
		{
			item = wakaba.Enums.Collectibles.RABBIT_RIBBON,
		},
		{
			item = wakaba.Enums.Collectibles.WINTER_ALBIREO,
		},
	},
	[wakaba.Enums.Players.RIRA] = {
		{
			item = wakaba.Enums.Collectibles.CHIMAKI,
		},
	},
}


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

function wakaba:EIDItemReminder_AddPassiveEntry(player, id)
	local playerID = EID:getPlayerID(player)
	EID:InitItemInteractionIfAbsent(playerID)
	if not wakaba:has_value(EID.RecentlyTouchedItems[playerID], id) then
		table.insert(EID.RecentlyTouchedItems[playerID], id)
	end
end

---@param player EntityPlayer
function wakaba:PlayerUpdate_EIDItemReminder(player)
	if not EID or not EID.holdTabPlayer or not wakaba.Reminder.DefaultItems[player:GetPlayerType()] then return end
	if EID.GameUpdateCount % 10 == 0 then
		local entries = wakaba.Reminder.DefaultItems[player:GetPlayerType()]
		for i, e in ipairs(entries) do
			local id = e.item
			local condition = e.cond
			if condition == nil or (condition()) then
				wakaba:EIDItemReminder_AddPassiveEntry(player, id)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_EIDItemReminder)

do
	local index = wakaba:EIDItemReminder_GetIndex("Special")
	table.insert(EID.ItemReminderCategories, index, {id = "w_Character",
		entryGenerators = {
			function(player) wakaba:EIDItemReminder_HandleCharacters(player) end,
		},
		hideInOverview = function(_) -- hide character description from overview, if player is not in the starting room
			return wakaba.G:GetLevel():GetStartingRoomIndex() ~= wakaba.G:GetLevel():GetCurrentRoomIndex()
		end,
	})
	table.insert(EID.ItemReminderCategories, index+1, {id = "w_ShioriFlags", entryGenerators = {
		function(player) wakaba:EIDItemReminder_HandleShioriFlags(player) end,
	}})
	table.insert(EID.ItemReminderCategories, index+2, {id = "w_Curse",
		--isScrollable = true,
		entryGenerators = {
			function(player) wakaba:EIDItemReminder_HandleCurses(player) end,
		}
	})
end

do
	local index = wakaba:EIDItemReminder_GetIndex("Pockets")
	table.insert(EID.ItemReminderCategories, index, {id = "w_WakabaUniform", entryGenerators = {
		function(player) wakaba:EIDItemReminder_HandleWakabaUniform(player) end,
	}})
end
--[[ 
do
	local index = wakaba:EIDItemReminder_GetIndex("Passives")
	local ent = EID.ItemReminderCategories[index]
	if ent and ent.entryGenerators then
		local gen = ent.entryGenerators
		table.insert(gen, math.max(#gen -1, 0) , function(player)
			if wakaba:hasAlbireo(player) and not EID:IsCategorySelected("Passives") then
				EID:ItemReminderAddDescription(player, 5, 100, wakaba.Enums.Collectibles.WINTER_ALBIREO)
			end
		end)
	end
end
 ]]
function wakaba:EIDItemReminder_HandleCharacters(player)
	if not EID:ItemReminderCanAddMoreToView() then return end
	local t = player:GetPlayerType()
	local entry = wakaba.descriptions["en_us"].playernotes[t] or wakaba.descriptions["en_us"].playernotes[-666]
	local icon = (entry.icon and "{{"..entry.icon.."}}") or (EID:getIcon("Player"..t) ~= EID.InlineIcons["ERROR"] and "{{Player"..t.."}}" or "{{CustomTransformation}}")
	EID:ItemReminderAddDescription(player, -997, -1, t, icon)
end

function wakaba:EIDItemReminder_HandleWakabaUniform(player)
	if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM, true) and EID:ItemReminderCanAddMoreToView() then
		EID:ItemReminderAddDescription(player, 5, 100, wakaba.Enums.Collectibles.UNIFORM)
	end
end

function wakaba:EIDItemReminder_HandleShioriFlags(player)
	if not EID:ItemReminderCanAddMoreToView() then return end
	local shioriFlag = wakaba:getShioriFlag(player)
	if shioriFlag then
		local wakabaBuff = wakaba:getWakabaDesc("bookofshiori", shioriFlag)
		if wakabaBuff then
			EID:ItemReminderAddDescription(player, 5, 100, wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
		end
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
		if 1 << curseId & currCurse > 0 and EID:ItemReminderCanAddMoreToView() then
			local c = 1 << curseId
			local entry = wakaba.descriptions["en_us"].curses[c]
			local icon = entry and entry.icon and "{{"..entry.icon.."}}"
			EID:ItemReminderAddDescription(player, wakaba.INVDESC_TYPE_CURSE, wakaba.INVDESC_VARIANT, c, icon)
		end
	end
end

EID.ItemReminderDescriptionModifier["5.100."..wakaba.Enums.Collectibles.WINTER_ALBIREO] = {
	modifierFunction = function(descObj, player, inOverview)
		local pool = wakaba:GetAlbireoPool()
		if pool then
			local prepend = EID:getDescriptionEntry("AlbireoPool")
			local poolDescTable = EID:getDescriptionEntry("itemPoolNames")
			poolName = (EID.ItemPoolTypeToMarkup[pool] or "{{ItemPoolTreasure}}")..poolDescTable[pool] .. "{{CR}}#"
			descObj.Description = prepend .. poolName
		end
	end,
}

EID.ItemReminderDescriptionModifier["5.100."..wakaba.Enums.Collectibles.BOOK_OF_SHIORI] = {
	modifierFunction = function(descObj, player, inOverview)
		if EID:IsCategorySelected("w_ShioriFlags") then
			local shioriFlag = wakaba:getShioriFlag(player)
			local wakabaBuff = wakaba:getWakabaDesc("bookofshiori", shioriFlag)
			if wakabaBuff then
				local demoDescObj = EID:getDescriptionObj(5, 100, shioriFlag)
				local description = wakabaBuff.description
				local iconStr = "#{{Collectible" .. wakaba.Enums.Collectibles.BOOK_OF_SHIORI .. "}} {{ColorBookofShiori}}"
				descObj.Icon = demoDescObj.Icon
				descObj.Name = demoDescObj.Name
				descObj.Description = iconStr.. description .. "{{CR}}"
			end
		end
	end,
}

EID.ItemReminderDescriptionModifier["5.100."..wakaba.Enums.Collectibles.UNIFORM] = {
	modifierFunction = function(descObj, player, inOverview)
		if EID:IsCategorySelected("w_WakabaUniform") then
			local unistr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].uniform) or wakaba.descriptions["en_us"].uniform
			local eidstring = ""
			local preservedslotstate = false
			local itemConfig = Isaac.GetItemConfig()

			for i,item in pairs(player:GetData().wakaba.uniform.items) do
				if i > wakaba.Enums.Constants.WAKABA_UNIFORM_MAX_SLOTS then
					goto wakabaUniformEIDSkip
				end
				do
					if player:GetData().wakaba.uniform.cursor == i then
						eidstring = eidstring .. "#{{ArrowGrayRight}} {{ColorGold}}"
					else
						eidstring = eidstring .. "#{{Blank}} "
					end
					if item.type == "card" then
						local str = (EID and EID:getObjectName(5, PickupVariant.PICKUP_TAROTCARD, item.cardpill)) or itemConfig:GetCard(item.cardpill).Name
						eidstring = eidstring .. "{{Card" .. item.cardpill .. "}} " .. str
						if player:GetData().wakaba.uniform.cursor == i then
							preservedslotstate = true
						end
					elseif item.type == "pill" then
						if wakaba.G:GetItemPool():IsPillIdentified(item.cardpill) then
							local str = (EID and EID:getObjectName(5, PickupVariant.PICKUP_PILL, item.cardpill)) or itemConfig:GetPillEffect(item.pilleffect).Name
							if item.pilleffect == 14 then
								str = "Gold Pill"
							end
							if item.cardpill > 2048 then
								str = str .. "[!]"
								eidstring = eidstring .. "{{Pill" .. item.cardpill-2048 .. "}} {{ColorYellow}}" .. str
							else
								eidstring = eidstring .. "{{Pill" .. item.cardpill .. "}} " ..str
							end
						else
							eidstring = eidstring .. "{{Pill" .. item.cardpill .. "}}{{WakabaUniformUnknownPill}}"
						end
						if player:GetData().wakaba.uniform.cursor == i then
							preservedslotstate = true
						end
					else
						eidstring = eidstring .. "{{WakabaUniformEmpty}}"
					end
				end
				::wakabaUniformEIDSkip::
			end
			--demoDescObj.ObjVariant = 350
			local prefix = unistr.changeslot .. " : {{ButtonRT}}"
			local playerID = player:GetPlayerType()
			--eidstring = "#"..(EID:getIcon("Player"..playerID) ~= EID.InlineIcons["ERROR"] and "{{Player"..playerID.."}}" or "{{CustomTransformation}}").." {{ColorGray}}" .. player:GetName() .. "(Player " .. player.ControllerIndex+1 .. ")#" .. prefix .. eidstring
			--eidstring = eidstring .. "#" .. unistr.use

			eidstring = eidstring:gsub("{{WakabaUniformEmpty}}",unistr.empty)
			eidstring = eidstring:gsub("{{WakabaUniformUnknownPill}}",unistr.unknownpill)
			descObj.Description = eidstring
		end
	end,
}

EID.ItemReminderDescriptionModifier["5.100."..wakaba.Enums.Collectibles.CUNNING_PAPER] = {
	isCheat = true,
	modifierFunction = function(descObj, player, inOverview)
		local playerIndex = isc:getPlayerIndex(player)
		local card = wakaba.cunningPaperData[playerIndex]
		local demoDescObj = EID:getDescriptionObj(5, 300, card)
		EID:ItemReminderAddResultHeaderSuffix(descObj, demoDescObj.Name)
		descObj.Icon = "{{Card"..card.."}}"
		descObj.Description = demoDescObj.Description
	end,
}

EID.ItemReminderDescriptionModifier["5.100."..wakaba.Enums.Collectibles.APOLLYON_CRISIS] = EID.ItemReminderDescriptionModifier["5.100.477"]