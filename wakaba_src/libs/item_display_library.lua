local ItemDisplay_libVersion = 1.1
CCO = CCO or {}

if CCO.ItemDisplay then
	if not CCO.ItemDisplay.VERSION
	or CCO.ItemDisplay.VERSION < ItemDisplay_libVersion
	then
		Isaac.DebugString("Item Display Library: [WARNING] A mod (or more) above this message has an outdated version of Item Display Library, make sure to check which mod(s) do and notify their developer(s) to avoid errors.")
		Isaac.DebugString("Item Display Library: [WARNING] Most up to date version: [" .. tostring(ItemDisplay_libVersion) .. "] (mods with an older version than this should be disabled or updated)")
		Isaac.DebugString("Item Display Library: [WARNING] Current loaded version: [" .. tostring(CCO.ItemDisplay.VERSION or "UNKNOWN") .. "]")
		print("Item Display Library: [WARNING] Outdated Item Display Library version, check the log.txt file for more information.")
		print("Item Display Library: [WARNING] C:/Users/[username]/Documents/My Games/Binding of Isaac Repentance/log.txt")
	end
	
	return CCO.ItemDisplay.API
end

--= IMPORTANT =--
-- In order for the library to work, you're required to copy 
-- the [ gfx/item display lib ] folder into your project,
-- under the same root, to have the necessary assets.
CCO.ItemDisplay = RegisterMod("Item Display Library", 1)
CCO.ItemDisplay.VERSION = ItemDisplay_libVersion
local game = Game()
local sound = SFXManager()
local zeroV = Vector.Zero
local itemConfig = Isaac.GetItemConfig()
local randomizer = RNG()
randomizer:SetSeed(Random() + 1, 35)

local script = {}

local ITEM_DISPLAY_DURATION = 90
local ITEM_OFFSET = Vector(24, -24)
local SEC_OFFSET = Vector(0, -1)
local OUTLINE_SCALE = Vector(1.125, 1.125)
local NORMAL_COLOR = Color(1, 1, 1, 1)
local WHITE_COLOR = Color(1, 1, 1, 1, 1, 1, 1)
local MAX_TMTRAINER_VARIANTS = 24

local SETTINGS = {
	SPEED_MULTI = 1, -- increments of 0.25 | min 0.5 / max 2.0
	SCALE = 1, -- increments of 0.25 | min 0.5 / max 1.5
	MAX_DISPLAY = 2, -- min 1 / max 5
	PLAY_SOUND = true,
}

local function copyTable(sourceTab)
	local targetTab = {}
	sourceTab = sourceTab or {}
	
	if type(sourceTab) ~= "table" then
		error("[ERROR] - cucco_helper.copyTable - invalid argument #1, table expected, got " .. type(sourceTab), 2)
	end

	for i, v in pairs(sourceTab) do
		if type(v) == "table" then
			targetTab[i] = copyTable(sourceTab[i])
		else
			targetTab[i] = sourceTab[i]
		end
	end
	
	return targetTab
end
local function mergeTables(tabPriority, tab2)
	local targetTab = {}
	tabPriority = tabPriority or {}
	tab2 = tab2 or {}
	
	if type(tabPriority) ~= "table" then
		error("[ERROR] - cucco_helper.mergeTables - invalid argument #1, table expected, got " .. type(tabPriority), 2)
	elseif type(tab2) ~= "table" then
		error("[ERROR] - cucco_helper.mergeTables - invalid argument #2, table expected, got " .. type(tabPriority), 2)
	end

	for i, v in pairs(tabPriority) do
		if type(v) == "table" then
			targetTab[i] = mergeTables(tabPriority[i], tab2[i])
		else
			targetTab[i] = tabPriority[i] ~= nil and tabPriority[i] or tab2[i]
		end
	end

	for i, v in pairs(tab2) do
		if type(v) == "table" then
			targetTab[i] = mergeTables(tabPriority[i], tab2[i])
		else
			targetTab[i] = tabPriority[i] ~= nil and tabPriority[i] or tab2[i]
		end
	end

	return targetTab
end

---------------
----= API =----
---------------

-- Use these specific tables to handle dssmenu settings for this library in your mod.
-- See the Job Modpack dss_menu.lua for reference.
script.DSS_MENU = {
	MAIN = {
		str = 'item display lib',
		dest = 'DISPLAY_LIB_SETTINGS',
		tooltip = {strset = {'settings for', 'the item', 'display', 'library'}},
	},
	MAIN_SUB = {str = 'item_display_library.lua settings', fsize = 1, clr = 3, nosel = true},
	DISPLAY_LIB_SETTINGS = {
        title = 'Item Display Library',
		generate = function()
			local player = Isaac.GetPlayer()
			for i = 1, SETTINGS.MAX_DISPLAY * 3 do
				script.queueItemDisplay(player, 1)
			end
		end,
        buttons = {
			{
				str = 'Scroll Speed',
				choices = {'50%', '75%', '100%', '125%', '150%', '175%', '200%'},
				variant = "DISPLAY_LIB_SPEED_MULTI",
				setting = 3,
				load = function()
					return (SETTINGS.SPEED_MULTI - 0.25) / 0.25
				end,
				store = function(var)
					SETTINGS.SPEED_MULTI = (var * 0.25) + 0.25
				end,
				changefunc = function(button)
					SETTINGS.SPEED_MULTI = (button.setting * 0.25) + 0.25
				end,
				tooltip = {strset = {'the speed at', 'which items', 'scroll', 'upwards'}},
			},
			{
				str = 'Item Scale',
				choices = {'50%', '75%', '100%', '125%', '150%'},
				variant = "DISPLAY_LIB_SCALE",
				setting = 3,
				load = function()
					return (SETTINGS.SCALE - 0.25) / 0.25
				end,
				store = function(var)
					SETTINGS.SCALE = (var * 0.25) + 0.25
				end,
				changefunc = function(button)
					SETTINGS.SCALE = (button.setting * 0.25) + 0.25
				end,
				tooltip = {strset = {'the size', 'of displayed', 'items'}},
			},
			{
                str = 'Visible Item Num',
                increment = 1, max = 5,
                slider = true,
                variable = 'MAX_DISPLAY',
                setting = 2,
                load = function()
                    return SETTINGS.MAX_DISPLAY
                end,
                store = function(var)
                    SETTINGS.MAX_DISPLAY = var
                end,
				changefunc = function(button)
					SETTINGS.MAX_DISPLAY = button.setting
				end,
                tooltip = {strset = {'the amount', 'of items', 'that can be', 'displayed', 'at once'}},
            },
			{
				str = 'Display Sound',
				choices = {'enabled', 'disabled'},
				variant = "DISPLAY_LIB_PLAY_SOUND",
				setting = 1,
				load = function()
					return SETTINGS.PLAY_SOUND and 1 or 2
				end,
				store = function(var)
					SETTINGS.PLAY_SOUND = var == 1
				end,
				changefunc = function(button)
					SETTINGS.PLAY_SOUND = button.setting == 1
				end,
				tooltip = {strset = {'whether', 'items should', 'play a', 'sound when', 'displayed'}},
			},
        },
        tooltip = menuOpenToolTip
	},
}

--[[ Call this function when saving your mod's data.

local json = require("json")
local itemDisplayLib = require("item_display_library")

local SAVE_STATE = {}
local function saveData()
	SAVE_STATE.ITEM_DISPLAY_LIBRARY = itemDisplayLib.getSaveData
	
	mod:SaveData(json.encode(SAVE_STATE))
end

]]
script.getSaveData = function()
	return copyTable(SETTINGS)
end

--[[ Call this function when loading your mod's data.

local json = require("json")
local itemDisplayLib = require("item_display_library")

local SAVE_STATE = {}
local function loadData()
	SAVE_STATE = json.decode(mod:LoadData())
	
	itemDisplayLib.loadData(SAVE_STATE.ITEM_DISPLAY_LIBRARY)
end

]]
script.loadData = function(tab)
	SETTINGS = mergeTables(tab, SETTINGS)
end

-----------------
----= LOGIC =----
-----------------

local playerData = {}

local function getData(dataTable, entity)
	local index = tostring(entity.InitSeed)
	
	if dataTable[index] == nil then
		dataTable[index] = {}
	end
	
	return dataTable[index]
end

local function getPlayerData(entity)
	return getData(playerData, entity)
end

function randomfloat(x, y, rng)
	if not x
	and not y
	then
		rng = rng or randomizer
		return rng:RandomFloat()
	end
    if not y then
        y = x
        x = 0
    end
	x = x * 1000
	y = y * 1000
   	rng = rng or randomizer
    return math.floor((rng:RandomInt(y - x + 1)) + x) / 1000
end

local function createSprite(gfxroot, anmtoplay, anmframe, newspr, layer, returnobject)
	local newSprite = Sprite()
	newSprite:Load(tostring(gfxroot), true)
	
	if not anmframe then
		newSprite:Play(anmtoplay and tostring(anmtoplay) or newSprite:GetDefaultAnimationName(), true)
	else
		newSprite:SetFrame(anmtoplay and tostring(anmtoplay) or newSprite:GetDefaultAnimationName(), anmframe)
	end
	
	if newspr then
		if layer == true then
			for i = 0, newSprite:GetLayerCount() - 1 do
				newSprite:ReplaceSpritesheet(i, newspr)
			end
			newSprite:LoadGraphics()
		else
			newSprite:ReplaceSpritesheet(layer or 0, newspr)
			newSprite:LoadGraphics()
		end
	end

	return returnobject and {Sprite = sprite, Anm2Root = gfxroot, SprRoot = newspr, AnmName = anmtoplay, AnmFrame = anmframe or 0} or newSprite
end

local function isPaused()
	return game:IsPaused()
		or (ModConfigMenu and ModConfigMenu.IsVisible)
		or (DeadSeaScrollsMenu and DeadSeaScrollsMenu.OpenedMenu)
end

function script.queueItemDisplay(player, item)
	player = player or Isaac.GetPlayer()
	
	if not item
	or type(item) ~= "number"
	or item % 1 ~= 0
	then
		error("[ERROR] - ItemDisplay.queueItemDisplay - CollectibleType expected, got " .. type(item), 2)
	end
	
	local data = getPlayerData(player)
	
	data._lostItemQueue = data._lostItemQueue or {}
	
	table.insert(data._lostItemQueue, {
		sprite = itemConfig:GetCollectible(item).GfxFileName,
		duration = ITEM_DISPLAY_DURATION,
	})
end

local function renderLostItem(player, layer)
	layer = layer or 1
	local data = getPlayerData(player)
	local item = data._lostItemQueue[layer]
	local sprite = data["_lostItemSpr" .. layer]
	
	if not item then
		return
	end
	
	if not sprite then
		data["_lostItemSpr" .. layer] = createSprite("gfx/item display lib/32x32.anm2", "Idle")
		sprite = data["_lostItemSpr" .. layer]
	end

	if not item.init then
		local targetSprite = item.sprite
		
		if targetSprite == "" then
			local randomVariant = random(MAX_TMTRAINER_VARIANTS)
			targetSprite = "gfx/item display lib/tmtrainer/variant" .. tostring(randomVariant) .. ".png"
		end
	
		sprite.Offset = ITEM_OFFSET + (SEC_OFFSET * math.abs(item.duration - ITEM_DISPLAY_DURATION))
		sprite:ReplaceSpritesheet(0, targetSprite)
		sprite:LoadGraphics()
		
		item.init = true
	end
	
	local clr = WHITE_COLOR
	sprite.Scale = OUTLINE_SCALE * SETTINGS.SCALE
	sprite.Color = Color(clr.R, clr.G, clr.B, math.min(1, item.duration / 80), clr.RO, clr.GO, clr.BO)
	sprite:Render(Isaac.WorldToScreen(player.Position), zeroV, zeroV)
	clr = NORMAL_COLOR
	sprite.Scale = Vector.One * SETTINGS.SCALE
	sprite.Color = Color(clr.R, clr.G, clr.B, math.min(1, item.duration / 50), clr.RO, clr.GO, clr.BO)
	sprite:Render(Isaac.WorldToScreen(player.Position), zeroV, zeroV)
	
	if item.duration <= 0 then
		return true
	elseif not isPaused() then
		if game:GetRoom():HasWater() then
			item.duration = item.duration - (0.5 * SETTINGS.SPEED_MULTI)
			sprite.Offset = sprite.Offset + ((SEC_OFFSET / 2) * SETTINGS.SPEED_MULTI)
		else
			item.duration = item.duration - (1 * SETTINGS.SPEED_MULTI)
			sprite.Offset = sprite.Offset + (SEC_OFFSET * SETTINGS.SPEED_MULTI)
		end
	end
end

local function postPlayerRender(_, player)
	local data = getPlayerData(player)
	
	if not data._lostItemQueue
	or not data._lostItemQueue[1]
	then
		data._lostItemQueue = nil
		return
	end
	
	local index = 1
	local item = data._lostItemQueue[index]
	local spacerDelay = ITEM_DISPLAY_DURATION / SETTINGS.MAX_DISPLAY
	local shouldDequeue = false
	
	while item do
		if SETTINGS.PLAY_SOUND
		and item.duration == ITEM_DISPLAY_DURATION
		and not isPaused()
		then
			sound:Play(SoundEffect.SOUND_MENU_RIP, 1.5, 0, false, randomfloat(0.85, 1.3))
		end
	
		local inverseDuration = math.abs(item.duration - ITEM_DISPLAY_DURATION)
		local finished = renderLostItem(player, index)
		shouldDequeue = shouldDequeue or finished
		
		if inverseDuration > spacerDelay then
			index = index + 1
			item = data._lostItemQueue[index]
		else
			break
		end
	end
	
	if not shouldDequeue then
		return
	end
	
	table.remove(data._lostItemQueue, 1)
	
	for _, item in ipairs(data._lostItemQueue) do
		if not item.init then
			break
		end
		
		item.init = nil
	end
end
CCO.ItemDisplay:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, postPlayerRender)

local function postNewLevel()
	playerData = {}
end
CCO.ItemDisplay:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, postNewLevel)

CCO.ItemDisplay.API = copyTable(script)

Isaac.DebugString("Item Display Library: Loaded Successfully! Version: " .. CCO.ItemDisplay.VERSION)
print("Item Display Library: Loaded Successfully! Version: " .. CCO.ItemDisplay.VERSION)

return script
