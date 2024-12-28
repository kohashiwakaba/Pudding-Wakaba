
--- STANDALONE OR IMPORTED MODS MUST INCLUDE THIS LINE FOR MOD CONFLIT PREVENTATION
-- if _wakaba then return end

if not (REPENTANCE or REPENTANCE_PLUS) then return end
if not EID then return end
if EIDKR then return end

local game = Game()
local _debug = false

wakaba._InventoryDesc = RegisterMod("Inventory Descriptions", 1)
local idesc = wakaba._InventoryDesc ---@class InventoryDescriptions|ModReference
InventoryDescriptions = idesc

---@type Sprite
idesc.BackgroundSprite = Sprite()
idesc.BackgroundSprite:Load("gfx/ui/wakaba_idesc_menu.anm2", true)
idesc.BackgroundSprite:SetFrame("Idle",0)

---@type Sprite
idesc.IconBgSprite = Sprite()
idesc.IconBgSprite:Load("gfx/ui/wakaba_idesc_menu.anm2", true)
idesc.IconBgSprite:SetFrame("ItemIcon",0)

---@type Font
idesc.cf = Font() -- init font object
idesc.cf:Load("font/luaminioutlined.fnt") -- load a font into the font object

---@class InventoryDescEntries
---@field Entries InventoryDescEntry[]

---@class InventoryDescEntry
---@field RenderType InventoryDescType
---@field Type EntityType
---@field Variant integer
---@field SubType integer
---@field AllowModifiers boolean|function
---@field Lemegeton boolean
---@field InitCursorPos boolean
---@field IsHidden boolean|function
---@field Frame integer|function
---@field Icon string|function
---@field Color string|function
---@field LeftIcon string|function
---@field ExtraIcon string|function
---@field InnerText string|function
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
	RICHER = -996,
}
InvDescEIDType = idescEIDType

---@enum InvDescEIDVariant
local idescEIDVariant = {
	DEFAULT = -1,
	RICHER_UNIFORM = 0,
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
	q5icon = 25,
	q6icon = 26,
	invplayerinfos = true,
	invcurses = true,
	invcollectibles = true,
	invactives = true,
	invtrinkets = true,
	invpocketitems = true,
	invlistmode = "list",
	invgridcolumn = 6,
	invinitcursor = "character",
}
if _wakaba then
	idesc.options = wakaba.state.options

	wakaba.INVDESC_TYPE_PLAYER = -997
	wakaba.INVDESC_TYPE_CURSE = -998
	wakaba.INVDESC_RICHER_UNIFORM = -996
	wakaba.INVDESC_VARIANT = -1

	_debug = wakaba.Flags.debugInvDescList
end

--#region state data and functions
local istate = {
	showList = false,
	maxCollectibleID = Isaac.GetItemConfig():GetCollectibles().Size - 1,
	maxTrinketID = Isaac.GetItemConfig():GetTrinkets().Size - 1,
	allowmodifiers = true,
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
		name = nil,
		displayName1 = nil,
		displayName2 = nil,
		screenx = EID:getScreenSize().X,
		screeny = EID:getScreenSize().Y,
		max = 1,
		current = 1,
		offset = 0,
		allowmodifiers = false,
		listonly = false,
		listmode = "list",
		gridcolumn = 6,
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
	local validcount = math.ceil((y - getOffset() * 27) / ((EID.lineHeight + 1) * 2) ) - 3
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

function idesc:isListActive()
	return istate.showList
end

function idesc:getListPropName()
	return istate.listprops.name or "basic"
end

function idesc:setListPropName(name)
	istate.listprops.name = name
end

function idesc:getDisplayNames()
	return {
		DisplayName1 = istate.listprops.displayName1,
		DisplayName2 = istate.listprops.displayName2,
	}
end

function idesc:setDisplayNames(n1, n2)
	istate.listprops.displayName1 = n1
	istate.listprops.displayName2 = n2
end

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
	if not idesc.defaults[category] or not idesc.defaults[category][target] then
		return
	end
	for i, e in ipairs(idesc.defaults[category][target]) do
		if e == entry then
			table.remove(idesc.defaults[category][target], i)
			break
		end
	end
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

function idesc:hasBlacklist(category, target, entry)
	if not idesc.blacklists[category] or not idesc.blacklists[category][target] then
		return false
	end
	for i, e in ipairs(idesc.blacklists[category][target]) do
		if e == entry then
			return true
		end
	end
	return false
end

function idesc:removeBlacklist(category, target, entry)
	if not idesc.blacklists[category] or not idesc.blacklists[category][target] then
		return
	end
	for i, e in ipairs(idesc.blacklists[category][target]) do
		if e == entry then
			table.remove(idesc.blacklists[category][target], i)
			break
		end
	end
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
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.RIRA_B, wakaba.Enums.Collectibles.AZURE_RIR)
	idesc:addDefault(idescEntryType.COLLECTIBLE, wakaba.Enums.Players.ANNA, wakaba.Enums.Collectibles.KYOUTAROU_LOVER)
	linked = true
end

wakaba:AddCallback(REPENTOGON and ModCallbacks.MC_POST_MODS_LOADED or ModCallbacks.MC_POST_GAME_STARTED, wakaba.LinkWakabaDefaults)

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
				InitCursorPos = (idesc:getOptions("invinitcursor") == "character"),
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
		local playerType = player:GetPlayerType()
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
function idesc:getVoidedActives()
	if not REPENTOGON then return end
	local ei = {}
	local entries = {} ---@type InventoryDescEntry[]
	for i = 0, game:GetNumPlayers() - 1 do
		ei = {}
		local player = Isaac.GetPlayer(i)
		local playerType = player:GetPlayerType()
		local voided = player:GetVoidedCollectiblesList()
		for _, entryIndex in ipairs(voided) do
			if entryIndex > 0 and not has(ei, entryIndex) then
				local quality = tonumber(EID.itemConfig:GetCollectible(tonumber(entryIndex)).Quality)
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.COLLECTIBLE,
					Variant = PickupVariant.PICKUP_COLLECTIBLE,
					SubType = entryIndex,
					Frame = function()
						return idesc:getOptions("q0icon")
					end,
					LeftIcon = "{{Player"..player:GetPlayerType().."}}",
					ExtraIcon = "{{Collectible"..CollectibleType.COLLECTIBLE_VOID.."}}",
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
		local playerType = player:GetPlayerType()
		for s = 0, 3 do
			local entryIndex = player:GetCard(s)
			if entryIndex > 0 and not has(ei, entryIndex) and not idesc:hasBlacklist("cards", playerType, entryIndex) then
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
		local playerType = player:GetPlayerType()
		for s = 0, 3 do
			local entryIndex = player:GetPill(s)
			if entryIndex > 0 and not has(ei, entryIndex) then
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.PILL,
					Variant = PickupVariant.PICKUP_PILL,
					SubType = entryIndex,
					IsHidden = not game:GetItemPool():IsPillIdentified(entryIndex),
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
	if REPENTOGON and idesc:getOptions("invpassivehistory") then
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local playerType = player:GetPlayerType()
			local historyList = player:GetHistory():GetCollectiblesHistory()
			for j, history in ipairs(historyList) do
				local entryIndex = history:GetItemID()
				if not history:IsTrinket() and entryIndex > 0 and player:HasCollectible(entryIndex) and not has(ei, entryIndex) and not idesc:hasBlacklist("collectibles", playerType, entryIndex) then
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
						InnerText = entryIndex,
						ExtraIcon = EID.ItemPoolTypeToMarkup[history:GetItemPoolType()],
						InitCursorPos = (idesc:getOptions("invinitcursor") == "collectible" or idesc:getOptions("invinitcursor") == "collectible_modded"),
					}
					table.insert(entries, entry)
					table.insert(ei, entryIndex)
				end
			end
		end
	else
		local passives = EID:GetAllPassiveItems()
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local playerType = player:GetPlayerType()
			for j, entryIndex in ipairs(passives) do
				if entryIndex > 0 and player:HasCollectible(entryIndex) and not has(ei, entryIndex) and not idesc:hasBlacklist("collectibles", playerType, entryIndex) then
					local onlyTrue = player:HasCollectible(entryIndex, true)
					local hasWisp = false
					if not onlyTrue then
						local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, entryIndex, false, false)
						for _, e in ipairs(wisps) do
							local f = e:ToFamiliar()
							if f and GetPtrHash(f.Player) == GetPtrHash(player) then
								hasWisp = true
							end
						end
					end
					if onlyTrue or not hasWisp then
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
							InnerText = entryIndex,
							InitCursorPos = (onlyTrue and ((idesc:getOptions("invinitcursor") == "collectible") or (entryIndex >= 732 and idesc:getOptions("invinitcursor") == "collectible_modded"))),
						}
						table.insert(entries, entry)
						table.insert(ei, entryIndex)
					end
				end
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
		local playerType = player:GetPlayerType()
		for j, entryIndex in ipairs(trinkets) do
			if entryIndex > 0 and player:HasTrinket(entryIndex) and not has(ei, entryIndex) and not idesc:hasBlacklist("trinkets", playerType, entryIndex) then
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.TRINKET,
					Variant = PickupVariant.PICKUP_TRINKET,
					SubType = entryIndex,
					InnerText = entryIndex,
					InitCursorPos = (idesc:getOptions("invinitcursor") == "trinket"),
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
	for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES)) do
		local newEntries = callbackData.Function(callbackData.Mod)
		if newEntries and type(newEntries) == "table" then
			entries = merge(entries, newEntries)
		end
	end
	return entries
end

idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -400, function (_) return idesc:getPlayers() end)
idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -380, function (_) return idesc:getDefaults() end)
idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -360, function (_) return idesc:getCurses() end)
idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -340, function (_) return idesc:getHeldActives() end)
idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -330, function (_) return idesc:getVoidedActives() end)
idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -320, function (_) return idesc:getHeldCards() end)
idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -300, function (_) return idesc:getHeldPills() end)
idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -280, function (_) return idesc:getPassives() end)
idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -260, function (_) return idesc:getTrinkets() end)
idesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -240, function (_) return idesc:getItemWisps() end)

---@param entries InventoryDescEntry[]
---@param stopTimer boolean
function idesc:showEntries(entries, listType, stopTimer, listOnly, propName)
	if #entries <= 0 then
		return false
	end
	if not istate.showList then
		local preventOpen = Isaac.RunCallbackWithParam("WakabaCallbacks.INVENTORY_DESCRIPTIONS_PRE_LIST_OPEN", propName)
		if preventOpen then return end
	end
	istate.lists.items = entries
	istate.listprops.max = #entries
	istate.showList = not istate.showList
	local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
	istate.listprops.screenx = x
	istate.listprops.screeny = y
	istate.listprops.listonly = listOnly
	istate.listprops.listmode = listType or "list"
	istate.listprops.name = propName or "basic"
	if istate.showList then
		Isaac.RunCallbackWithParam("WakabaCallbacks.INVENTORY_DESCRIPTIONS_POST_LIST_OPEN", propName)
	end
	return istate.showList
end

---@return InventoryDescEntry[]
function idesc:currentEntries()
	return istate.lists.items
end

---@param newEntries InventoryDescEntry[]
---@return InventoryDescEntry[]
function idesc:appendCurrentEntries(newEntries)
	if not istate.showList then
		wakaba.Log("Invdesc is not showing! skipping appendCurrentEntries...")
		return
	end
	if not newEntries or type(newEntries) ~= "table" then
		wakaba.Log("newEntries value invalid!")
		return
	end
	if #newEntries == 0 then
		newEntries = {newEntries}
	end
	istate.lists.items = merge(istate.lists.items, newEntries)
	istate.listprops.max = istate.listprops.max + #newEntries
	return istate.lists.items
end

function idesc:resetEntries()
	Isaac.RunCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_PRE_LIST_CLOSE")
	postClose = true
	local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
	istate.showList = false
	istate.listprops.name = nil
	istate.listprops.displayName1 = nil
	istate.listprops.displayName1 = nil
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
	Isaac.RunCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_POST_LIST_CLOSE")
end
function idesc:recalculateOffset()

	local validcount = getListCount()
	local listprops = istate.listprops
	if istate.listprops.listmode == "grid" then
		local columns = math.max(idesc:getOptions("invgridcolumn", 6), 1)

		local listOffset = listprops.offset
		local entries = idesc:currentEntries()
		local min = listOffset + 1
		local max = math.min(listOffset + (validcount * columns), #entries)
		local numEntries = #entries

		if listprops.current > max then
			local overRows = math.ceil((listprops.current - max) / columns)
			istate.listprops.offset = listprops.offset + (overRows * columns)
		elseif listprops.offset + (validcount * columns) > listprops.max then
			istate.listprops.offset = math.max((math.ceil(listprops.max / columns) * columns) - (validcount * columns), 0)
		end
	else
		local listOffset = listprops.offset
		local entries = idesc:currentEntries()
		local min = listOffset + 1
		local max = math.min(listOffset + validcount, #entries)
		local numEntries = #entries

		if listprops.current > max then
			istate.listprops.offset = listprops.offset + (listprops.current - listprops.offset - validcount + 2)
		elseif listprops.offset + validcount > listprops.max then
			istate.listprops.offset = math.max(listprops.max - validcount, 0)
		end
	end

	local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
	istate.listprops.screenx = x
	istate.listprops.screeny = y
end

--#endregion

function idesc:Update(player)
	local inputKey = idesc:getOptions("listkey", -1)
	local switchKey = idesc:getOptions("switchkey", -1)
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
		local listMode = idesc:getOptions("invlistmode", "list")
		if idesc:showEntries(entries, listMode, true) then
			istate.savedtimer = game.TimeCounter
			local initOffset = 0
			for i, e in ipairs(entries) do
				if e.InitCursorPos then
					initOffset = i
					break
				end
			end
			if initOffset > 0 then
				istate.listprops.current = initOffset
				idesc:recalculateOffset()
			end
		else
			idesc:resetEntries()
		end
	end

	if istate.showList then
		if Input.IsButtonTriggered(Keyboard.KEY_ESCAPE, 0) or Input.IsActionTriggered(ButtonAction.ACTION_PAUSE, 0) then
			idesc:resetEntries()
			return
		end

		if switchKey ~= -1 and Input.IsButtonTriggered(switchKey, 0) then
			inputready = false

			local option = idesc:getOptions("invlistmode")
			if option == "grid" then
				idesc:setOptions("invlistmode", "list")
				istate.listprops.listmode = "list"
			else
				idesc:setOptions("invlistmode", "grid")
				istate.listprops.listmode = "grid"
			end

			idesc:recalculateOffset()
		end

		local listcount = getListCount()
		local listprops = istate.listprops

		if istate.listprops.listmode == "grid" then -- Render Grid
			local columns = idesc:getOptions("invgridcolumn", 6)

			if Input.IsActionTriggered(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex or 0) then
				inputready = false
				istate.listprops.current = listprops.current - 1
				if listprops.current - listprops.offset < 0 and listprops.offset > 0 then
					istate.listprops.offset = math.max(listprops.offset - columns, 0)
				end
				if listprops.current <= 0 then
					istate.listprops.current = listprops.max
					istate.listprops.offset = math.max((math.ceil(listprops.max / columns) * columns) - (listcount * columns), 0)
				end
			elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex or 0) then
				inputready = false
				istate.listprops.current = listprops.current + 1
				if listprops.current > (listprops.offset + (listcount * columns)) then
					istate.listprops.offset = istate.listprops.offset + columns
				end
				if listprops.current > listprops.max then
					istate.listprops.current = 1
					istate.listprops.offset = 0
				end
			elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex or 0) then
				inputready = false
				istate.listprops.current = listprops.current - columns
				if listprops.current - listprops.offset < 0 and listprops.offset > 0 then
					istate.listprops.offset = math.max(listprops.offset - columns, 0)
				end
				if listprops.current <= 0 then
					istate.listprops.current = listprops.max
					istate.listprops.offset = math.max((math.ceil(listprops.max / columns) * columns) - (listcount * columns), 0)
				end
			elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex or 0) then
				inputready = false
				local cr = istate.listprops.current
				local mx = istate.listprops.max
				if 0 < mx - cr and mx - cr < columns then
					istate.listprops.current = listprops.max
				elseif mx == cr then
					istate.listprops.current = 1
					istate.listprops.offset = 0
				else
					istate.listprops.current = listprops.current + columns
					if listprops.current > (listprops.offset + (listcount * columns)) then
						istate.listprops.offset = istate.listprops.offset + columns
					end
				end
			end
		else
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
end
idesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, idesc.Update)

function idesc:Render()
	if istate.showList and ModConfigMenu and ModConfigMenu.IsVisible then
		idesc:resetEntries()
		return
	end

	if istate.showList and Encyclopedia and DeadSeaScrollsMenu.IsOpen() then
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

		local oldTransparency = EID.Config["Transparency"] + 0
		EID.Config["Transparency"] = 1

		local dn = idesc:getDisplayNames()
		local pstr = dn.DisplayName1 or "Current item list ({current}/{max})"
		local sstr = dn.DisplayName2 or "Press {listkey} again to exit"
		pstr = pstr:gsub("{current}", listprops.current)
		pstr = pstr:gsub("{max}", listprops.max)
		pstr = pstr:gsub("{listkey}", kts[inputKey])
		sstr = sstr:gsub("{current}", listprops.current)
		sstr = sstr:gsub("{max}", listprops.max)
		sstr = sstr:gsub("{listkey}", kts[inputKey])

		-- Render headers
		EID:renderString(pstr, Vector(x - optionsOffset, 36-(EID.lineHeight*2)) - Vector(offset * 10, offset * -10), Vector(1,1), EID:getNameColor())
		EID:renderString(sstr, Vector(x - optionsOffset, 36-EID.lineHeight) - Vector(offset * 10, offset * -10), Vector(1,1), EID:getNameColor())

		local listOffset = listprops.offset
		local entries = idesc:currentEntries()
		local numEntries = #entries
		local selObj = nil
		local selEntry = nil

		if istate.listprops.listmode == "grid" then -- Render Grid
			local columns = idesc:getOptions("invgridcolumn", 6)
			local min = listOffset + 1
			local max = math.min(listOffset + (validcount * columns), #entries)

			for ix = min, max do
				local lIndex = ix - listOffset
				local entry = entries[ix]
				if not entry then break end
				local isHighlighted = ix == listprops.current
				local isHidden = type(entry.IsHidden) == "function" and entry.IsHidden() or entry.IsHidden;
				local allowModifiers = type(entry.AllowModifiers) == "function" and entry.AllowModifiers() or entry.AllowModifiers;
				local obj = EID:getDescriptionObj(entry.Type, entry.Variant, entry.SubType, nil, istate.allowmodifiers or allowModifiers)

				if isHighlighted then selObj = obj; selEntry = entry end

				local i = ix - min + 1
				local iv = ((i - 1) // columns) + 1
				local currCol = ((i - 1) % columns)

				local height = EID.lineHeight
				local renderpos = Vector(x - optionsOffset, 36 + ((iv-1) * (height + 1) * 2)) - Vector(offset * 10, offset * -10)
				renderpos = renderpos + Vector(currCol * 24, 0)

				local iconrenderpos = renderpos + Vector(-23, ((height + 0) / 2) - 4)
				local qtextrenderpos = renderpos + Vector(-26, -2)
				local etextrenderpos = renderpos + Vector(-9, 16)
				local intextrenderpos = renderpos + Vector(-3, -6)
				local textrenderpos = renderpos + Vector(0, 1)
				local color = isHighlighted and EID:getColor("{{ColorGold}}", EID:getNameColor()) or EID:getNameColor()
				local frameno = (type(entry.Frame) == "function" and entry.Frame() or entry.Frame) or idesc:getOptions("idleicon");
				frameno = isHighlighted and idesc:getOptions("selicon") or frameno
				idesc.IconBgSprite.Scale = Vector(EID.Scale / 3, EID.Scale / 3)
				idesc.IconBgSprite.Color = Color(1, 1, 1, EID.Config["Transparency"], 0, 0, 0)

				local extIcon = type(entry.Icon) == "function" and entry.Icon() or entry.Icon;
				local leftIcon = type(entry.LeftIcon) == "function" and entry.LeftIcon() or entry.LeftIcon;
				local extraIcon = type(entry.ExtraIcon) == "function" and entry.ExtraIcon() or entry.ExtraIcon;
				local innerText = type(entry.InnerText) == "function" and entry.InnerText() or entry.InnerText;
				local iconOffset = entry.IconRenderOffset or Vector(-18, 1)

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
				if extraIcon then
					EID:renderString(extraIcon, etextrenderpos, Vector(1,1), color)
				end
				if innerText then
					idesc.cf:DrawStringScaledUTF8(innerText, intextrenderpos.X, intextrenderpos.Y, 1.0, 1.0, KColor(1,1,1,1.0,0,0,0), 1 ,false)
				end
				if isHighlighted then
					EID:renderString("{{ArrowGrayLeft}}", renderpos + Vector(-18, 1) + Vector(-10, 5), Vector(0.5,0.5), color)
					EID:renderString("{{ArrowGrayRight}}", renderpos + Vector(-18, 1) + Vector(10, 5), Vector(0.5,0.5), color)
					EID:renderString("{{ArrowGrayUp}}", renderpos + Vector(-18, 1) + Vector(1, -5), Vector(0.5,0.5), color)
					EID:renderString("{{ArrowGrayDown}}", renderpos + Vector(-18, 1) + Vector(0, 16), Vector(0.5,0.5), color)
				end


			end
		else -- Render List
			local min = listOffset + 1
			local max = math.min(listOffset + validcount, #entries)

			for ix = min, max do
				local entry = entries[ix]
				if not entry then break end
				local isHighlighted = ix == listprops.current
				local isHidden = type(entry.IsHidden) == "function" and entry.IsHidden() or entry.IsHidden;
				local allowModifiers = type(entry.AllowModifiers) == "function" and entry.AllowModifiers() or entry.AllowModifiers;
				local obj = EID:getDescriptionObj(entry.Type, entry.Variant, entry.SubType, nil, istate.allowmodifiers or allowModifiers)

				if isHighlighted then selObj = obj; selEntry = entry end

				local i = ix - min + 1

				local height = EID.lineHeight
				local renderpos = Vector(x - optionsOffset, 36 + ((i-1) * (height + 1) * 2)) - Vector(offset * 10, offset * -10)
				local iconrenderpos = renderpos + Vector(-23, ((height + 0) / 2) - 4)
				local qtextrenderpos = renderpos + Vector(-33, (height / 2) + 1)
				local intextrenderpos = renderpos + Vector(-3, -6)
				local textrenderpos = renderpos + Vector(0, 1)
				local color = isHighlighted and EID:getColor("{{ColorGold}}", EID:getNameColor()) or EID:getNameColor()
				local frameno = (type(entry.Frame) == "function" and entry.Frame() or entry.Frame) or idesc:getOptions("idleicon");
				frameno = isHighlighted and idesc:getOptions("selicon") or frameno
				idesc.IconBgSprite.Scale = Vector(EID.Scale / 3, EID.Scale / 3)
				idesc.IconBgSprite.Color = Color(1, 1, 1, EID.Config["Transparency"], 0, 0, 0)

				local extIcon = type(entry.Icon) == "function" and entry.Icon() or entry.Icon;
				local leftIcon = type(entry.LeftIcon) == "function" and entry.LeftIcon() or entry.LeftIcon;
				local extraIcon = type(entry.ExtraIcon) == "function" and entry.ExtraIcon() or entry.ExtraIcon;
				local innerText = type(entry.InnerText) == "function" and entry.InnerText() or entry.InnerText;
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
				if isHidden then
					primaryListName = "???"
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
				if isHidden then
					secondaryListName = nil
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
				if innerText then
					idesc.cf:DrawStringScaledUTF8(innerText, intextrenderpos.X, intextrenderpos.Y, 1.0, 1.0, KColor(1,1,1,1.0,0,0,0), 1 ,false)
				end
				if primaryListName then
					EID:renderString(primaryListName, textrenderpos + Vector(0, secondaryListName ~= nil and 0 or (EID.lineHeight / 2)), Vector(1,1), color)
				end
				if secondaryListName then
					EID:renderString(secondaryListName, textrenderpos + Vector(0, EID.lineHeight + 1), Vector(1,1), EID:getTextColor())
				end
			end
		end
		EID.Config["Transparency"] = oldTransparency + 0

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
			local isHidden = type(selEntry.IsHidden) == "function" and selEntry.IsHidden() or selEntry.IsHidden;
			if isHidden then
				if EID.isDisplayingPermanent then
					EID:hidePermanentText()
				end
				EID:renderQuestionMark(nil)
			else
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

end
idesc:AddCallback(ModCallbacks.MC_POST_RENDER, idesc.Render)

function idesc:InputAction(entity, inputHook, buttonAction)
	if idesc:getOptions("listkey", -1) == -1 then return end

	if istate.showList and istate.savedtimer then
		game.TimeCounter = istate.savedtimer
	elseif istate.savedtimer then
		istate.savedtimer = nil
	end
	local shouldBypassBlock = Isaac.RunCallback(wakaba.Callback.INVENTORY_DESCRIPTIONS_PRE_LOCK_INPUT, idesc, entity, inputHook, buttonAction)

	if istate.showList
	and buttonAction ~= ButtonAction.ACTION_FULLSCREEN
	and buttonAction ~= ButtonAction.ACTION_CONSOLE
	and buttonAction ~= idesc:getOptions("listkey")
	and not shouldBypassBlock then

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
	idesc:showEntries(entries, nil, nil, true)
	istate.listprops.current = 6
	idesc:recalculateOffset()
end

-- example function for show random entries
function idesc:tme()
	local entries = {}
	local config = Isaac.GetItemConfig()
	local minModdedItemsID = CollectibleType.COLLECTIBLE_MOMS_RING + 1
	local maxModdedItemsID = config:GetCollectibles().Size - 1
	local size = maxModdedItemsID - minModdedItemsID
	local capacity = idesc:getOptions("invgridcolumn", 6) * getListCount()
	if size <= capacity then
		for i = minModdedItemsID, maxModdedItemsID do
			if config:GetCollectible(i) and config:GetCollectible(i):IsAvailable() then
				local quality = tonumber(config:GetCollectible(tonumber(i)).Quality)
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.COLLECTIBLE,
					Variant = PickupVariant.PICKUP_COLLECTIBLE,
					SubType = i,
					AllowModifiers = true,
					InnerText = i,
					Frame = function()
						return idesc:getOptions("q"..quality.."icon")
					end,
					LeftIcon = "{{Quality"..quality.."}}",
				}
				table.insert(entries, entry)
			end
		end
	else
		local ei = {}
		local rng = RNG()
		local failedCnt = 0
		rng:SetSeed(wakaba.G:GetLevel():GetDungeonPlacementSeed(), 35)
		while #entries < capacity and failedCnt < 20 do
			local entryIndex = rng:RandomInt(size) + minModdedItemsID
			if not has(ei, entryIndex) and config:GetCollectible(entryIndex) and config:GetCollectible(entryIndex):IsAvailable() then
				failedCnt = 0
				local quality = tonumber(config:GetCollectible(tonumber(entryIndex)).Quality)
				---@type InventoryDescEntry
				local entry = {
					Type = idescEIDType.COLLECTIBLE,
					Variant = PickupVariant.PICKUP_COLLECTIBLE,
					SubType = entryIndex,
					AllowModifiers = true,
					InnerText = entryIndex,
					Frame = function()
						return idesc:getOptions("q"..quality.."icon")
					end,
					LeftIcon = "{{Quality"..quality.."}}",
				}
				table.insert(entries, entry)
				table.insert(ei, entryIndex)
			else
				failedCnt = failedCnt + 1
			end
		end
	end
	idesc:showEntries(entries, "grid", nil, true, "test_random")
end

--#endregion



print("InvDesc v2.2 for Pudding and Wakaba Loaded")