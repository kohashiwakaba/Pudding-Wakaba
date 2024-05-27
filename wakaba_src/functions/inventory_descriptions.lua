
--- STANDALONE OR IMPORTED MODS MUST INCLUDE THIS LINE FOR MOD CONFLIT PREVENTATION
-- if _wakaba then return end

if not REPENTANCE then return end
if not EID then return end
if EIDKR then return end

local game = Game()
local _debug = false

wakaba._InventoryDesc = RegisterMod("Inventory Descriptions", 1)
local idesc = wakaba._InventoryDesc

idesc.BackgroundSprite = Sprite()
idesc.BackgroundSprite:Load("gfx/ui/wakaba_idesc_menu.anm2", true)
idesc.BackgroundSprite:SetFrame("Idle",0)

idesc.IconBgSprite = Sprite()
idesc.IconBgSprite:Load("gfx/ui/wakaba_idesc_menu.anm2", true)
idesc.IconBgSprite:SetFrame("ItemIcon",0)

---@class InventoryDescEntries
---@field Entries InventoryDescEntry[]

---@class InventoryDescEntry
---@field RenderType InventoryDescType
---@field Type EntityType
---@field Variant integer
---@field SubType integer
---@field AllowModifiers boolean|function
---@field Lemegeton boolean
---@field Frame integer|function
---@field Icon string|function
---@field Color string|function
---@field LeftIcon string|function
---@field ExtraIcon string|function
---@field IconRenderOffset Vector
---@field ListPrimaryTitle string|function
---@field ListSecondaryTitle string|function

---@enum InventoryDescType
local idescEntryType = {
	PLAYER = "players",
	CURSE = "curses",
	COLLECTIBLE = "collectibles",
	TRINKET = "trinkets",
	CARD = "cards",
	PILL = "pills",
}
InventoryDescType = idescEntryType

---@enum InvDescEIDType
local idescEIDType = {
	PLAYER = -997,
	CURSE = -998,
	COLLECTIBLE = EntityType.ENTITY_PICKUP,
	TRINKET = EntityType.ENTITY_PICKUP,
	CARD = EntityType.ENTITY_PICKUP,
	PILL = EntityType.ENTITY_PICKUP,
}
InvDescEIDType = idescEIDType

---@enum InvDescEIDVariant
local idescEIDVariant = {
	DEFAULT = -1,
}
InvDescEIDVariant = idescEIDVariant

local idescVar = -1

idesc.options = {
	listoffset = 200,
	listkey = Keyboard.KEY_F5,
	idleicon = 0,
	selicon = 17,
	lemegetonicon = 18,
	q0icon = 20,
	q1icon = 21,
	q2icon = 22,
	q3icon = 23,
	q4icon = 24,
	invplayerinfos = true,
	invcurses = true,
	invcollectibles = true,
	invactives = true,
	invtrinkets = true,
	invpocketitems = true,
}
if _wakaba then
	idesc.options = wakaba.state.options

	wakaba.INVDESC_TYPE_PLAYER = -997
	wakaba.INVDESC_TYPE_CURSE = -998
	wakaba.INVDESC_VARIANT = -1

	_debug = wakaba.Flags.debugInvDescList
end

--#region state data and functions
local istate = {
	showList = false,
	maxCollectibleID = Isaac.GetItemConfig():GetCollectibles().Size - 1,
	maxTrinketID = Isaac.GetItemConfig():GetTrinkets().Size - 1,
	allowmodifiers = false,
	lists = {
		playernotes = {},
		items = {},
		curses = {},
		collectibles = {},
		lemegetonwisps = {},
		trinkets = {},
		cards = {},
		pills = {},
	},
	listprops = {
		screenx = EID:getScreenSize().X,
		screeny = EID:getScreenSize().Y,
		max = 1,
		current = 1,
		offset = 0,
		allowmodifiers = false,
		listonly = false,
	},
	savedtimer = nil,
}
idesc.state = istate
--#endregion

--#region defaults and blacklists
idesc.defaults = {}
idesc.defaults.collectibles = {
	[PlayerType.PLAYER_LAZARUS] = {CollectibleType.COLLECTIBLE_LAZARUS_RAGS},
	[PlayerType.PLAYER_LAZARUS2] = {CollectibleType.COLLECTIBLE_ANEMIC},
	--[PlayerType.PLAYER_THELOST] = {CollectibleType.COLLECTIBLE_HOLY_MANTLE},
	[PlayerType.PLAYER_LILITH] = {CollectibleType.COLLECTIBLE_INCUBUS},
	[PlayerType.PLAYER_SAMSON_B] = {CollectibleType.COLLECTIBLE_BERSERK},
	[PlayerType.PLAYER_AZAZEL_B] = {CollectibleType.COLLECTIBLE_HEMOPTYSIS},
	[PlayerType.PLAYER_LILITH_B] = {CollectibleType.COLLECTIBLE_GELLO},
}
idesc.defaults.trinkets = {
	[PlayerType.PLAYER_BLUEBABY] = {TrinketType.TRINKET_LIL_LARVA},
}

idesc.blacklists = {}
idesc.blacklists.collectibles = {}
idesc.blacklists.trinkets = {}

idesc.entryset = {
	collectibles = {Type = 5, Variant = 100},
	trinkets = {Type = 5, Variant = 350},
	cards = {Type = 5, Variant = 300},
}

--#endregion

--#region local functions and variables

local kts = {}

for key,num in pairs(Keyboard) do

	local keyString = key

	local keyStart, keyEnd = string.find(keyString, "KEY_")
	keyString = string.sub(keyString, keyEnd+1, string.len(keyString))

	keyString = string.gsub(keyString, "_", " ")

	kts[num] = keyString

end

local inputready = true

local function getOffset()
	return Options.HUDOffset or 1
end

local function initList()
end

local function isDiff(x, y, x2, y2)
	if math.ceil(x / 1) ~= math.ceil(x2 / 1) then
		return true
	end
	if math.ceil(y / 1) ~= math.ceil(y2 / 1) then
		return true
	end
	return false
end

local function getListCount()
	local x = EID:getScreenSize().X
	local y = EID:getScreenSize().Y
	local validcount = math.ceil((y - getOffset() * 72) / ((EID.lineHeight + 1) * 2))
	return validcount
end

local function merge(t1, t2)
	for k,v in ipairs(t2) do
		 table.insert(t1, v)
	end
	return t1
end

local function has (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

local function getMaxCurseId(curse)
	local maxloop = 0
	while curse > 0 do
		maxloop = maxloop + 1
		curse = curse // 2
	end
	return maxloop
end

--#endregion

--#region basic api functions

function idesc:addDefault(category, target, entry)
	if not idesc.defaults[category] then
		idesc.defaults[category] = {}
	end
	if not idesc.defaults[category][target] then
		idesc.defaults[category][target] = {}
	end
	table.insert(idesc.defaults[category][target], entry)
end

function idesc:removeDefault(category, target, entry)
end

function idesc:addBlacklist(category, target, entry)
	if not idesc.blacklists[category] then
		idesc.blacklists[category] = {}
	end
	if not idesc.blacklists[category][target] then
		idesc.blacklists[category][target] = {}
	end
	table.insert(idesc.blacklists[category][target], entry)
end

function idesc:removeBlacklist(category, target, entry)
end

--#endregion


--#region insert descriptions here

--example. check idesc_src/descriptions.lua
--include("idesc_src.descriptions")

---Recommended to manage descriptions into external files / 별도의 설명 파일에서 관리하는 것을 추천
--[[
	- Adding player descriptions / 플레이어 설명 추가
	local playerType = player:GetPlayerType()
	EID:addEntity(InvDescEIDType.PLAYER, InvdescEIDVariant.DEFAULT, playerType, "PlayerName", "Player Descriptions", "en_us")
]]
--[[
	- Adding curse descriptions / 저주 설명 추가
	local curse = 1 << (Isaac.GetCurseIdByName("Curse of Flames!") - 1)
	EID:addEntity(InvDescEIDType.CURSE, InvdescEIDVariant.DEFAULT, curse, "CurseName", "Curse Descriptions", "en_us")
	
	- Adding curse icons, if available / 저주 아이콘 추가
	- "CurseCustom" is used as "{{CurseCustom}}" on EID descriptions
	local curse = 1 << (Isaac.GetCurseIdByName("Curse of Flames!") - 1)
	EID:AddIconToObject(InvDescEIDType.CURSE, InvdescEIDVariant.DEFAULT, curse, "CurseCustom")
]]

--#endregion

--#region link description here

-- Default item links for characters
-- Innate items through Hidden Item Manager are not needed to link.
-- Only items that not detectable for player:HasCollectible() are needed to link.
-- idesc:addDefault(idescEntryType.COLLECTIBLE, PlayerType.PLAYER_ISAAC, CollectibleType.COLLECTIBLE_SAD_ONION)
-- idesc:addDefault(idescEntryType.TRINKET, PlayerType.PLAYER_ISAAC, TrinketType.TRINKET_SWALLOWED_PENNY)

-- 캐릭터별 기본 아이템 링크
-- Hidden Item Manager로 추가된 내장 패시브는 불필요,
-- 'lua 상으로 해당 패시브를 소지하지 않는 판정'일 때만 추가
-- 예시 :	와카바 모드의 축복은 별개로 구현되어 있는 능력이라 링크가 필요하지만,
--				player:HasCollectible로 감지되는 히든 능력의 경우 자동으로 추가되므로 링크 불필요
-- 모드 서순 고려하여 REPENTOGON 사용 시 ModCallbacks.MC_POST_MODS_LOADED에, 미사용 시 ModCallbacks.MC_POST_GAME_STARTED에 추가

local linked = false
function wakaba:LinkWakabaDefaults()
	if linked then return end
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.WAKABA, wakaba.Enums.Collectibles.WAKABAS_BLESSING)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.WAKABA_B, wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.SHIORI, wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.SHIORI_B, wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.SHIORI_B, wakaba.Enums.Collectibles.MINERVA_AURA)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.TSUKASA, wakaba.Enums.Collectibles.LUNAR_STONE)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.TSUKASA, wakaba.Enums.Collectibles.CONCENTRATION)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.TSUKASA_B, wakaba.Enums.Collectibles.FLASH_SHIFT)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.TSUKASA_B, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.TSUKASA_B, wakaba.Enums.Collectibles.MURASAME)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.RICHER, wakaba.Enums.Collectibles.RABBIT_RIBBON)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.RICHER_B, wakaba.Enums.Collectibles.RABBIT_RIBBON)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.RICHER_B, wakaba.Enums.Collectibles.WINTER_ALBIREO)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.RIRA, wakaba.Enums.Collectibles.CHIMAKI)
	linked = true
end

if REPENTOGON then
	wakaba:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, wakaba.LinkWakabaDefaults)
else
	wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.LinkWakabaDefaults)
end

--#endregion

--#region

--#endregion

--#region

---@return InventoryDescEntry[]
function idesc:getPlayers()
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local entryIndex = player:GetPlayerType()
		if not has(ei, entryIndex) then
			---@type InventoryDescEntry
			local entry = {
				Type = idescEIDType.PLAYER,
				Variant = idescVar,
				SubType = entryIndex,
				Icon = "{{Player"..entryIndex.."}}",
				IconRenderOffset = Vector(-16.5, 1),
			}
			table.insert(entries, entry)
			table.insert(ei, entryIndex)
		end
	end
	return entries
end

function idesc:getDefaults()
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local entryIndex = player:GetPlayerType()
		if not has(ei, entryIndex) then
			table.insert(ei, entryIndex)
		end
	end
	for category, datas in pairs(idesc.defaults) do
		local entrySet = idesc.entryset[category]
		local ci = {}
		for _, eix in ipairs(ei) do
			if datas[eix] then
				for _, v in ipairs(datas[eix]) do
					if not has(ci, v) then
						---@type InventoryDescEntry
						local entry = {
							Type = entrySet.Type,
							Variant = entrySet.Variant,
							SubType = v,
						}
						table.insert(entries, entry)
						table.insert(ci, v)
					end
				end
			end
		end
	end
	return entries
end

---@return InventoryDescEntry[]
function idesc:getHeldActives()
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		for s = 0, 3 do
			local entryIndex = player:GetActiveItem(s)
			if entryIndex > 0 and not has(ei, entryIndex) then
				local quality = tonumber(EID.itemConfig:GetCollectible(tonumber(entryIndex)).Quality)
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.COLLECTIBLE,
					Variant = PickupVariant.PICKUP_COLLECTIBLE,
					SubType = entryIndex,
					Frame = function()
						return idesc:getOptions("q"..quality.."icon")
					end,
					LeftIcon = "{{Quality"..quality.."}}",
				}
				table.insert(entries, entry)
				table.insert(ei, entryIndex)
			end
		end
	end
	return entries
end

---@return InventoryDescEntry[]
function idesc:getHeldCards()
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		for s = 0, 3 do
			local entryIndex = player:GetCard(s)
			if entryIndex > 0 and not has(ei, entryIndex) then
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.CARD,
					Variant = PickupVariant.PICKUP_TAROTCARD,
					SubType = entryIndex,
				}
				table.insert(entries, entry)
				table.insert(ei, entryIndex)
			end
		end
	end
	return entries
end

---@return InventoryDescEntry[]
function idesc:getHeldPills()
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		for s = 0, 3 do
			local entryIndex = player:GetPill(s)
			if entryIndex > 0 and not has(ei, entryIndex) then
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.PILL,
					Variant = PickupVariant.PICKUP_PILL,
					SubType = entryIndex,
				}
				table.insert(entries, entry)
				table.insert(ei, entryIndex)
			end
		end
	end
	return entries
end

---@return InventoryDescEntry[]
function idesc:getPassives()
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	local passives = EID:GetAllPassiveItems()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		for _, entryIndex in ipairs(passives) do
			if entryIndex > 0 and player:HasCollectible(entryIndex) and not has(ei, entryIndex) then
				local quality = tonumber(EID.itemConfig:GetCollectible(tonumber(entryIndex)).Quality)
				local modifiers = entryIndex == CollectibleType.COLLECTIBLE_BIRTHRIGHT
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.COLLECTIBLE,
					Variant = PickupVariant.PICKUP_COLLECTIBLE,
					SubType = entryIndex,
					AllowModifiers = modifiers,
					Frame = function()
						return idesc:getOptions("q"..quality.."icon")
					end,
					LeftIcon = "{{Quality"..quality.."}}",
				}
				table.insert(entries, entry)
				table.insert(ei, entryIndex)
			end
		end
	end
	return entries
end

local trinketsAll = nil
local function getAllTrinkets()
	if trinketsAll then
		return trinketsAll
	end
	trinketsAll = {}

	for i = 1, Isaac.GetItemConfig():GetTrinkets().Size - 1 do
		local config = EID.itemConfig:GetTrinket(i)
		if config ~= nil then
			table.insert(trinketsAll, i)
		end
	end
	return trinketsAll
end

---@return InventoryDescEntry[]
function idesc:getTrinkets()
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	local trinkets = getAllTrinkets()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		for _, entryIndex in ipairs(trinkets) do
			if entryIndex > 0 and player:HasTrinket(entryIndex) and not has(ei, entryIndex) then
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.TRINKET,
					Variant = PickupVariant.PICKUP_TRINKET,
					SubType = entryIndex,
				}
				table.insert(entries, entry)
				table.insert(ei, entryIndex)
			end
		end
	end
	return entries
end

---@return InventoryDescEntry[]
function idesc:getItemWisps()
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
	for _, e in ipairs(wisps) do
		local entryIndex = e.SubType
		if entryIndex > 0 and not has(ei, entryIndex) then
			---@type InventoryDescEntry
			local entry = {
				Type = idescEIDType.COLLECTIBLE,
				Variant = PickupVariant.PICKUP_COLLECTIBLE,
				SubType = entryIndex,
				Frame = function()
					return idesc:getOptions("lemegetonicon")
				end,
				ExtraIcon = "{{Collectible"..CollectibleType.COLLECTIBLE_LEMEGETON.."}}",
			}
			table.insert(entries, entry)
			table.insert(ei, entryIndex)
		end
	end
	return entries
end

---@return InventoryDescEntry[]
function idesc:getVirtuesWisps()
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, -1, false, false)
	for _, e in ipairs(wisps) do
		local entryIndex = e.SubType
		if entryIndex > 0 and not has(ei, entryIndex) then
			---@type InventoryDescEntry
			local entry = {
				Type = idescEIDType.COLLECTIBLE,
				Variant = PickupVariant.PICKUP_COLLECTIBLE,
				SubType = entryIndex,
				Frame = function()
					return idesc:getOptions("lemegetonicon")
				end,
				ExtraIcon = "{{Collectible"..CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES.."}}",
			}
			table.insert(entries, entry)
			table.insert(ei, entryIndex)
		end
	end
	return entries
end

---@return InventoryDescEntry[]
function idesc:getCurses()
	local currCurse = game:GetLevel():GetCurses()
	local entries = {} ---@type InventoryDescEntry[]
	for curseId = 0, getMaxCurseId(currCurse) do
		if 1 << curseId & currCurse > 0 then
			---@type InventoryDescEntry
			local entry = {
				Type = idescEIDType.CURSE,
				Variant = idescVar,
				SubType = 1 << curseId,
			}
			table.insert(entries, entry)
		end
	end
	return entries
end

--#endregion

--#region
function idesc:getOptions(optionKey, fallback)
	return idesc.options[optionKey] or fallback
end

function idesc:setOptions(optionKey, value)
	idesc.options[optionKey] = value
end

function idesc:getBasicEntries(init)
	local entries = {}
	entries = merge(entries, idesc:getPlayers())
	entries = merge(entries, idesc:getDefaults())
	entries = merge(entries, idesc:getCurses())
	entries = merge(entries, idesc:getHeldActives())
	entries = merge(entries, idesc:getHeldCards())
	entries = merge(entries, idesc:getHeldPills())
	entries = merge(entries, idesc:getPassives())
	entries = merge(entries, idesc:getTrinkets())
	entries = merge(entries, idesc:getItemWisps())
	if init then
		--istate.lists.items = entries
		--istate.listprops.max = #entries
	end
	return entries
end

---@param entries InventoryDescEntry[]
---@param stopTimer boolean
function idesc:showEntries(entries, stopTimer, listOnly)
	if #entries <= 0 then
		return false
	end
	istate.lists.items = entries
	istate.listprops.max = #entries
	istate.showList = not istate.showList
	local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
	istate.listprops.screenx = x
	istate.listprops.screeny = y
	istate.listprops.listonly = listOnly
	return istate.showList
end

---@return InventoryDescEntry[]
function idesc:currentEntries()
	return istate.lists.items
end

function idesc:resetEntries()
	local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
	istate.showList = false
	istate.listprops.screenx = x
	istate.listprops.screeny = y
	istate.listprops.offset = 0
	istate.listprops.current = 1
	istate.listprops.max = 1
	istate.listprops.listonly = false
	EID:hidePermanentText()
	for i=0, game:GetNumPlayers()-1 do
		local player = Isaac.GetPlayer(i)
		local data = player:GetData()
		--enable player controls
		data.InvDescPlayerPosition = nil
		if data.InvDescPlayerControlsDisabled then
			player.ControlsEnabled = true
			data.InvDescPlayerControlsDisabled = false
		end
		istate.savedtimer = nil
	end
end

function idesc:recalculateOffset()

	local validcount = getListCount()
	local listprops = istate.listprops
	
	local listOffset = listprops.offset
	local entries = idesc:currentEntries()
	local min = listOffset + 1
	local max = math.min(listOffset + validcount, #entries)
	local numEntries = #entries

	if listprops.current > max then
		istate.listprops.offset = listprops.offset + (listprops.current - listprops.offset - validcount + 2)
	elseif listprops.offset + validcount > listprops.max then
		istate.listprops.offset = listprops.max - validcount
	end

	local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
	istate.listprops.screenx = x
	istate.listprops.screeny = y
end

--#endregion

function idesc:Update(player)
	local inputKey = idesc:getOptions("listkey", -1)
	if inputKey == -1 then return end
	if not inputready then
		inputready = true
		return
	end

	if Input.IsButtonTriggered(inputKey, 0) then
		inputready = false
		if Isaac.CountBosses() > 0 or Isaac.CountEnemies() > 0 then
			return
		end
		local entries = idesc:getBasicEntries()
		if idesc:showEntries(entries, true) then
			istate.savedtimer = game.TimeCounter
		else
			idesc:resetEntries()
		end
	end

	if istate.showList then
		if Input.IsButtonTriggered(Keyboard.KEY_ESCAPE, 0) or Input.IsActionTriggered(ButtonAction.ACTION_PAUSE, 0) then
			idesc:resetEntries()
			return
		end
		local listcount = getListCount()
		local listprops = istate.listprops
		if Input.IsActionTriggered(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex or 0) then
			inputready = false
			istate.listprops.current = listprops.current - 1
			if listprops.current - listprops.offset < 2 and listprops.offset > 0 then
				istate.listprops.offset = listprops.offset - 1
			end
			if listprops.current <= 0 then
				istate.listprops.current = listprops.max
				istate.listprops.offset = (listprops.max - listcount) > 0 and listprops.max - listcount or 0
			end
		elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex or 0) then
			inputready = false
			istate.listprops.current = listprops.current - listcount
			istate.listprops.offset = listprops.offset - listcount
			if listprops.offset < 0 then
				istate.listprops.offset = 0
			end
			if listprops.current <= 0 then
				istate.listprops.current = 1
				istate.listprops.offset = 0
			end
		elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex or 0) then
			inputready = false
			istate.listprops.current = listprops.current + 1
			if listprops.current - listprops.offset > (listcount - 2) and listprops.max - listprops.offset > listcount then
				istate.listprops.offset = listprops.offset + 1
			end
			if listprops.current > listprops.max then
				istate.listprops.current = 1
				istate.listprops.offset = 0
			end
		elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex or 0) and (listprops.current + listcount) < listprops.max then
			inputready = false
			istate.listprops.current = listprops.current + listcount
			istate.listprops.offset = listprops.offset + listcount
			if listprops.max - listprops.offset < listcount then
				istate.listprops.current = listprops.current - (listcount - (listprops.max - listprops.offset))
				istate.listprops.offset = listprops.max - listcount
			end
			if listprops.current > listprops.max then
				istate.listprops.current = listprops.max
				istate.listprops.offset = listprops.max - listcount
			end
		end
	end
end
idesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, idesc.Update)

function idesc:Render()
	if ModConfigMenu and ModConfigMenu.IsVisible then
		idesc:resetEntries()
		return
	end

	if Encyclopedia and DeadSeaScrollsMenu.IsOpen() then
		idesc:resetEntries()
		return
	end

	if istate.showList and not EID.CachingDescription then
		if not istate.listprops.listonly then

			for i=0, game:GetNumPlayers()-1 do
				local player = Isaac.GetPlayer(i)
				local data = player:GetData()
	
				--freeze players and disable their controls
				player.Velocity = Vector(0,0)
	
				if not data.InvDescPlayerPosition then
					data.InvDescPlayerPosition = player.Position
				end
				player.Position = data.InvDescPlayerPosition
				if not data.InvDescPlayerControlsDisabled then
					player.ControlsEnabled = false
					data.InvDescPlayerControlsDisabled = true
				end
	
				--disable toggling revelations menu
				if data.input and data.input.menu and data.input.menu.toggle then
					data.input.menu.toggle = false
				end
			end
		end

		local validcount = getListCount()
		local offset = getOffset()
		local listprops = istate.listprops
		local x, y = EID:getScreenSize().X, EID:getScreenSize().Y
		local x2, y2 = listprops.screenx, listprops.screeny

		--창 크기 변경 시 발동
		if isDiff(x, y, x2, y2) then
			idesc:recalculateOffset()
		end

		local currentcursor = 1

		local optionsOffset = idesc:getOptions("listoffset")
		local inputKey = idesc:getOptions("listkey", -1)

		-- Render headers
		EID:renderString("Current item list("..listprops.current.."/"..listprops.max..")", Vector(x - optionsOffset, 36-(EID.lineHeight*2)) - Vector(offset * 10, offset * -10), Vector(1,1), EID:getNameColor())
		EID:renderString("Press ".. kts[inputKey].." again to exit", Vector(x - optionsOffset, 36-EID.lineHeight) - Vector(offset * 10, offset * -10), Vector(1,1), EID:getNameColor())

		local listOffset = listprops.offset
		local entries = idesc:currentEntries()
		local min = listOffset + 1
		local max = math.min(listOffset + validcount, #entries)
		local numEntries = #entries
		local selObj = nil
		local selEntry = nil

		if true then -- Render List

			for ix = min, max do
				local entry = entries[ix]
				if not entry then break end
				local isHighlighted = ix == listprops.current
				local allowModifiers = type(entry.AllowModifiers) == "function" and entry.AllowModifiers() or entry.AllowModifiers;
				local obj = EID:getDescriptionObj(entry.Type, entry.Variant, entry.SubType, nil, istate.allowmodifiers or allowModifiers)

				if isHighlighted then selObj = obj; selEntry = entry end

				local i = ix - min + 1

				local height = EID.lineHeight
				local renderpos = Vector(x - optionsOffset, 36 + ((i-1) * (height + 1) * 2)) - Vector(offset * 10, offset * -10)
				local iconrenderpos = renderpos + Vector(-23, ((height + 0) / 2) - 4)
				local qtextrenderpos = renderpos + Vector(-33, (height / 2) + 1)
				local textrenderpos = renderpos + Vector(0, 1)
				local color = isHighlighted and EID:getColor("{{ColorGold}}", EID:getNameColor()) or EID:getNameColor()
				local frameno = (type(entry.Frame) == "function" and entry.Frame() or entry.Frame) or idesc:getOptions("idleicon");
				frameno = isHighlighted and idesc:getOptions("selicon") or frameno
				idesc.IconBgSprite.Scale = Vector(EID.Scale / 3, EID.Scale / 3)
				idesc.IconBgSprite.Color = Color(1, 1, 1, EID.Config["Transparency"], 0, 0, 0)

				local extIcon = type(entry.Icon) == "function" and entry.Icon() or entry.Icon;
				local leftIcon = type(entry.LeftIcon) == "function" and entry.LeftIcon() or entry.LeftIcon;
				local extraIcon = type(entry.ExtraIcon) == "function" and entry.ExtraIcon() or entry.ExtraIcon;
				local iconOffset = entry.IconRenderOffset or Vector(-18, 1)

				-- 리스트 윗라인 (이름)
				local primaryListName = type(entry.ListPrimaryTitle) == "function" and entry.ListPrimaryTitle() or entry.ListPrimaryTitle;
				if not primaryListName then
					local curName = obj.Name
					if EID.Config["TranslateItemName"] ~= 2 then
						local curLanguage = EID.Config["Language"]
						if EID:getLanguage() ~= "en_us" then
							EID.Config["Language"] = "en_us"
							local englishName = EID:getObjectName(obj.ObjType, obj.ObjVariant, obj.ObjSubType)
							EID.Config["Language"] = curLanguage
							if EID.Config["TranslateItemName"] == 1 then
								curName = englishName
							elseif EID.Config["TranslateItemName"] == 3 and curName ~= englishName then
								curName = curName.." ("..englishName..")"
							end
						end
					end
					primaryListName = curName
				end
				-- 윗라인 추가 아이콘
				if extraIcon then
					primaryListName = extraIcon .. " " .. primaryListName
				end
				-- 리스트 아랫라인 (모드명)
				local secondaryListName = type(entry.ListSecondaryTitle) == "function" and entry.ListSecondaryTitle() or entry.ListSecondaryTitle;
				if not secondaryListName then
					local isModded = obj.ModName
					local modIcon = isModded and EID.ModIndicator[obj.ModName] and EID.ModIndicator[obj.ModName].Icon
					if isModded and obj.ModName and EID.ModIndicator[obj.ModName] and EID.ModIndicator[obj.ModName].Name then
						local rst = ""
						rst = rst .. "{{"..EID.Config["ModIndicatorTextColor"].."}}" .. EID.ModIndicator[obj.ModName].Name
						if modIcon then
							rst = rst .. "{{".. EID.ModIndicator[obj.ModName].Icon .."}}"
						end
						secondaryListName = rst
					end
				end
				idesc.IconBgSprite:SetFrame("ItemIcon",frameno)
				idesc.IconBgSprite:Render(iconrenderpos, Vector(0,0), Vector(0,0))
				local iconOffsetPos = Vector(iconOffset.X, (height / 2) + iconOffset.Y)
				if extIcon then
					EID:renderString(extIcon, renderpos + iconOffsetPos, Vector(1,1), color)
				elseif obj.Icon then
					EID:renderInlineIcons({{obj.Icon,0}}, renderpos.X + iconOffsetPos.X, renderpos.Y + iconOffsetPos.Y)
				else
					EID:renderString("{{CustomTransformation}}", renderpos + iconOffsetPos, Vector(1,1), color)
				end
				if leftIcon then
					EID:renderString(leftIcon, qtextrenderpos, Vector(1,1), color)
				end
				if primaryListName then
					EID:renderString(primaryListName, textrenderpos + Vector(0, secondaryListName ~= nil and 0 or (EID.lineHeight / 2)), Vector(1,1), color)
				end
				if secondaryListName then
					EID:renderString(secondaryListName, textrenderpos + Vector(0, EID.lineHeight + 1), Vector(1,1), EID:getTextColor())
				end
			end
		else -- Render Grid
		end

		if _debug then
			local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
			demoDescObj.Name = "{{Player"..wakaba.Enums.Players.RICHER_B.."}} " .. "Inventory Description list debug"

			local desc = ""
				.. "# props.screenx : " .. istate.listprops.screenx
				.. "# props.screeny : " .. istate.listprops.screeny
				.. "# props.max : " .. istate.listprops.max
				.. "# props.current : " .. istate.listprops.current
				.. "# props.offset : " .. istate.listprops.offset
				.. "# validcount : " .. getListCount()
				.. "# numEntries : " .. numEntries
				.. "# calcMin : " .. (listOffset + 1)
				.. "# calcMax : " .. (math.min(listOffset + validcount, #entries))

			demoDescObj.Description = desc or ""
			EID:displayPermanentText(demoDescObj)
		elseif selObj and not istate.listprops.listonly then
			desc = selObj
			if selEntry.Type == idescEIDType.PLAYER then
				local extIcon = type(selEntry.Icon) == "function" and selEntry.Icon() or selEntry.Icon;
				if extIcon then
					desc.Name = extIcon .. desc.Name
				end
			end
			EID:displayPermanentText(desc)
		end

	end

end
idesc:AddCallback(ModCallbacks.MC_POST_RENDER, idesc.Render)

function idesc:InputAction(entity, inputHook, buttonAction)
	if idesc:getOptions("listkey", -1) == -1 then return end

	if istate.showList and istate.savedtimer then
		game.TimeCounter = istate.savedtimer
	elseif istate.savedtimer then
		istate.savedtimer = nil
	end

	if istate.showList
	and buttonAction ~= ButtonAction.ACTION_FULLSCREEN
	and buttonAction ~= ButtonAction.ACTION_CONSOLE
	and buttonAction ~= idesc:getOptions("listkey") then

		if inputHook == InputHook.IS_ACTION_PRESSED or inputHook == InputHook.IS_ACTION_TRIGGERED then
			return false
		else
			return 0
		end
	end
end
idesc:AddCallback(ModCallbacks.MC_INPUT_ACTION, idesc.InputAction)

--#region 와카바 모드 테스트용 간단 설명 리스트

function idesc:tti(min, max, allow_mod, filter)
	local entries = {}
	local config = Isaac.GetItemConfig()
	min = min or 1
	max = max or config:GetCollectibles().Size - 1
	for i = min, max do
		if config:GetCollectible(i) and (not (filter and type(filter) == "function") or (filter(i))) then
			local quality = tonumber(config:GetCollectible(tonumber(i)).Quality)
			---@type InventoryDescEntry
			local entry = {
				Type = idescEIDType.COLLECTIBLE,
				Variant = PickupVariant.PICKUP_COLLECTIBLE,
				SubType = i,
				AllowModifiers = allow_mod,
				Frame = function()
					return idesc:getOptions("q"..quality.."icon")
				end,
				LeftIcon = "{{Quality"..quality.."}}",
			}
			table.insert(entries, entry)
		end
	end

	idesc:showEntries(entries)
end
function idesc:ttt(min, max, allow_mod, isGolden, filter)
	local entries = {}
	local config = Isaac.GetItemConfig()
	min = min or 1
	max = max or config:GetTrinkets().Size - 1
	for i = min, max do
		if config:GetTrinket(i) and (not (filter and type(filter) == "function") or (filter(i))) then
			---@type InventoryDescEntry
			local entry = {
				Type = idescEIDType.TRINKET,
				Variant = PickupVariant.PICKUP_TRINKET,
				SubType = isGolden and i + 32678 or i,
				AllowModifiers = allow_mod or isGolden,
			}
			table.insert(entries, entry)
		end
	end
	idesc:showEntries(entries)
end
function idesc:ttc(min, max, allow_mod, filter)
	local entries = {}
	local config = Isaac.GetItemConfig()
	min = min or 1
	max = max or config:GetCards().Size - 1
	for i = min, max do
		if config:GetCard(i) and (not (filter and type(filter) == "function") or (filter(i))) then
			---@type InventoryDescEntry
			local entry = {
				Type = idescEIDType.CARD,
				Variant = PickupVariant.PICKUP_TAROTCARD,
				SubType = i,
				AllowModifiers = allow_mod,
			}
			table.insert(entries, entry)
		end
	end
	idesc:showEntries(entries)
end

function idesc:tce()
	local entries = {}
	local config = Isaac.GetItemConfig()
	table.insert(entries, {
		Type = idescEIDType.COLLECTIBLE,
		Variant = PickupVariant.PICKUP_COLLECTIBLE,
		SubType = CollectibleType.COLLECTIBLE_1UP,
		AllowModifiers = true,
		ListSecondaryTitle = "{{WakabaModRgon}}리셰",
	})
	table.insert(entries, {
		Type = idescEIDType.COLLECTIBLE,
		Variant = PickupVariant.PICKUP_COLLECTIBLE,
		SubType = wakaba.Enums.Collectibles.SYRUP,
		AllowModifiers = true,
		ListSecondaryTitle = "{{MomBoss}}메이플",
	})
	table.insert(entries, {
		Type = idescEIDType.COLLECTIBLE,
		Variant = PickupVariant.PICKUP_COLLECTIBLE,
		SubType = CollectibleType.COLLECTIBLE_1UP,
		AllowModifiers = true,
		ListSecondaryTitle = "{{WakabaModRgon}}와카바",
	})
	table.insert(entries, {
		Type = idescEIDType.COLLECTIBLE,
		Variant = PickupVariant.PICKUP_COLLECTIBLE,
		SubType = CollectibleType.COLLECTIBLE_STAR_OF_BETHLEHEM,
		AllowModifiers = true,
		ListSecondaryTitle = "{{MomBoss}}카논",
	})
	table.insert(entries, {
		Type = idescEIDType.COLLECTIBLE,
		Variant = PickupVariant.PICKUP_COLLECTIBLE,
		SubType = CollectibleType.COLLECTIBLE_TMTRAINER,
		AllowModifiers = true,
		ListSecondaryTitle = "{{Delirium}}Mana_4403",
	})
	table.insert(entries, {
		Type = idescEIDType.COLLECTIBLE,
		Variant = PickupVariant.PICKUP_COLLECTIBLE,
		SubType = CollectibleType.COLLECTIBLE_SACRED_HEART,
		AllowModifiers = true,
		LeftIcon = "{{Crown}}",
		ListSecondaryTitle = "{{ColorRainbow}}{{Delirium}}흔한 닉네임의 3305",
	})
	table.insert(entries, {
		Type = idescEIDType.COLLECTIBLE,
		Variant = PickupVariant.PICKUP_COLLECTIBLE,
		SubType = CollectibleType.COLLECTIBLE_SACRED_HEART,
		AllowModifiers = true,
		ListSecondaryTitle = "{{Delirium}}asdf",
	})
	idesc:showEntries(entries, nil, true)
end

--#endregion



print("InvDesc v2 for Pudding and Wakaba Loaded")