local DSSModName = "Dead Sea Scrolls (Wakaba)"
local MenuProvider = {}
local game = Game()


function MenuProvider.SaveSaveData()
	wakaba:save()
end

function MenuProvider.GetPaletteSetting()
	return wakaba.state.dss_menu.MenuPalette
end

function MenuProvider.SavePaletteSetting(var)
	wakaba.state.dss_menu.MenuPalette = var
end

function MenuProvider.GetGamepadToggleSetting()
	return wakaba.state.dss_menu.MenuControllerToggle
end

function MenuProvider.SaveGamepadToggleSetting(var)
	wakaba.state.dss_menu.MenuControllerToggle = var
end

function MenuProvider.GetMenuKeybindSetting()
	return wakaba.state.dss_menu.MenuKeybind
end

function MenuProvider.SaveMenuKeybindSetting(var)
	wakaba.state.dss_menu.MenuKeybind = var
end

function MenuProvider.GetMenuHintSetting()
	return wakaba.state.dss_menu.MenuHint
end

function MenuProvider.SaveMenuHintSetting(var)
	wakaba.state.dss_menu.MenuHint = var
end

function MenuProvider.GetMenuBuzzerSetting()
	return wakaba.state.dss_menu.MenuBuzzer
end

function MenuProvider.SaveMenuBuzzerSetting(var)
	wakaba.state.dss_menu.MenuBuzzer = var
end

function MenuProvider.GetMenusNotified()
	return wakaba.state.dss_menu.MenusNotified
end

function MenuProvider.SaveMenusNotified(var)
	wakaba.state.dss_menu.MenusNotified = var
end

function MenuProvider.GetMenusPoppedUp()
	return wakaba.state.dss_menu.MenusPoppedUp
end

function MenuProvider.SaveMenusPoppedUp(var)
	wakaba.state.dss_menu.MenusPoppedUp = var
end

local completionCharacterSets = {
	{
		{HeadName = "Wakaba", PlayerID = wakaba.Enums.Players.WAKABA, IsUnlocked = function() return true end},
		{HeadName = "WakabaB", PlayerID = wakaba.Enums.Players.WAKABA_B, IsUnlocked = function() return true end},
	},
	{
		{HeadName = "Shiori", PlayerID = wakaba.Enums.Players.SHIORI, IsUnlocked = function() return true end},
		{HeadName = "ShioriB", PlayerID = wakaba.Enums.Players.SHIORI_B, IsUnlocked = function() return true end},
	},
	{
		{HeadName = "Tsukasa", PlayerID = wakaba.Enums.Players.TSUKASA, IsUnlocked = function() return true end},
		{HeadName = "TsukasaB", PlayerID = wakaba.Enums.Players.TSUKASA_B, IsUnlocked = function() return wakaba.state.unlock.taintedtsukasa end},
	},
	{
		{HeadName = "Richer", PlayerID = wakaba.Enums.Players.RICHER, IsUnlocked = function() return true end},
		{HeadName = "RicherB", PlayerID = wakaba.Enums.Players.RICHER_B, IsUnlocked = function() return wakaba.state.unlock.taintedricher end},
	},
	{
		{HeadName = "Rira", PlayerID = wakaba.Enums.Players.RIRA, IsUnlocked = function() return true end},
		{HeadName = "RiraB", PlayerID = wakaba.Enums.Players.RIRA_B, IsUnlocked = function() return wakaba.state.unlock.taintedrira end},
	},
}



local function getScreenBottomRight()
	return game:GetRoom():GetRenderSurfaceTopLeft() * 2 + Vector(442,286)
end

local function getScreenCenterPosition()
	return getScreenBottomRight() / 2
end

local dssmenucore = include("wakaba_src.wakaba_deadseascrolls.dssmenucore")
local dssmod = dssmenucore.init(DSSModName, MenuProvider)

local NOTE1_RENDER_OFFSET = Vector(-116, -27)
local NOTE2_RENDER_OFFSET = Vector(-32, -27)
local NOTE3_RENDER_OFFSET = Vector(-74, -27)

local completionNoteSprite = Sprite()
completionNoteSprite:Load("gfx/ui/completion_widget.anm2")
completionNoteSprite:SetFrame("Idle", 0)
--completionNoteSprite.Scale = Vector.One / 2

local completionHead = Sprite()
completionHead:Load("gfx/ui/wakaba/completion_heads.anm2")
completionHead:SetFrame("Wakaba", 0)

local completionDoor = Sprite()
completionDoor:Load("gfx/ui/wakaba/completion_doors.anm2")
completionDoor:SetFrame("Wakaba", 0)

local function gT(str)
	local endTable = {}
	local currentString = ""
	for w in str:gmatch("%S+") do
		local newString = currentString .. w .. " "
		if newString:len() >= 15 then
			table.insert(endTable, currentString)
			currentString = ""
		end

		currentString = currentString .. w .. " "
	end

	table.insert(endTable, currentString)
	return { strset = endTable }
end

-- Creating a menu like any other DSS menu is a simple process.
-- You need a "Directory", which defines all of the pages ("items") that can be accessed on your menu, and a "DirectoryKey", which defines the state of the menu.
local wakabadirectory = {
	-- The keys in this table are used to determine button destinations.
	main = {
			-- "title" is the big line of text that shows up at the top of the page!
			title = 'wakaba-chan',

			-- "buttons" is a list of objects that will be displayed on this page. The meat of the menu!
			buttons = {
					-- The simplest button has just a "str" tag, which just displays a line of text.

					-- The "action" tag can do one of three pre-defined actions:
					--- "resume" closes the menu, like the resume game button on the pause menu. Generally a good idea to have a button for this on your main page!
					--- "back" backs out to the previous menu item, as if you had sent the menu back input
					--- "openmenu" opens a different dss menu, using the "menu" tag of the button as the name
					{str = 'resume', action = 'resume', tooltip = dssmod.menuOpenToolTip},

					-- The "dest" option, if specified, means that pressing the button will send you to that page of your menu.
					-- If using the "openmenu" action, "dest" will pick which item of that menu you are sent to.
					{str = 'settings', dest = 'settings'},
					--[[ {str = 'characters', dest = 'characters'}, ]]
					{str = "completion notes", dest = "completionnotes", cursoroff = Vector(6, 0), tooltip = {strset = {"check out", "your progress!"}}},
					{
						str = 'credits',
						dest = 'credits',
						tooltip = {strset = {'various','thanks','for creating','the mod'}}
					},

					-- A few default buttons are provided in the table returned from DSSInitializerFunction.
					-- They're buttons that handle generic menu features, like changelogs, palette, and the menu opening keybind
					-- They'll only be visible in your menu if your menu is the only mod menu active; otherwise, they'll show up in the outermost Dead Sea Scrolls menu that lets you pick which mod menu to open.
					-- This one leads to the changelogs menu, which contains changelogs defined by all mods.
					dssmod.changelogsButton,

					-- Text font size can be modified with the "fsize" tag. There are three font sizes, 1, 2, and 3, with 1 being the smallest and 3 being the largest.
					--[[ {str = 'look at the little text!', fsize = 2, nosel = true} ]]

					{
						str = "full unlock enabled",
						nosel = true,
						fsize = 1,
						displayif = function ()
							return wakaba.state.options.allowlockeditems
						end,
					},
			},

			-- A tooltip can be set either on an item or a button, and will display in the corner of the menu while a button is selected or the item is visible with no tooltip selected from a button.
			-- The object returned from DSSInitializerFunction contains a default tooltip that describes how to open the menu, at "menuOpenToolTip"
			-- It's generally a good idea to use that one as a default!
			--[[ tooltip = dssmod.menuOpenToolTip ]]
	},
	settings = {
		title = 'wakaba settings',
		buttons = {
			-- These buttons are all generic menu handling buttons, provided in the table returned from DSSInitializerFunction
			-- They'll only show up if your menu is the only mod menu active
			-- You should generally include them somewhere in your menu, so that players can change the palette or menu keybind even if your mod is the only menu mod active.
			-- You can position them however you like, though!
			dssmod.gamepadToggleButton,
			dssmod.menuKeybindButton,
			dssmod.paletteButton,
			{
				str = 'general',
				dest = 'general',
				tooltip = {strset = {'settings', 'for', 'wakaba mod'}}
			},
			{
				str = 'hud settings',
				dest = 'hud_setting',
				tooltip = {strset = {'hud settings', 'for', 'wakaba mod'}}
			},
			{
				str = 'forcevoid',
				dest = 'forcevoid',
				tooltip = {strset = {'settings', 'for', 'opening', 'void', 'portals'}}
			},
			{
				str = 'characters',
				dest = 'characters_setting',
				tooltip = {strset = {'settings', 'for', 'wakaba', 'characters'}}
			},
		}
	},
	general = {
		title = 'general settings',
		buttons = {
			-- allow locked items
			{
				str = 'allow locked items',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'AllowLockedItems',
				load = function()
					if wakaba.state.options.allowlockeditems then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.allowlockeditems = (var == 1)
				end,
				tooltip = {strset = {'change this', 'to enable or', 'disable all', 'unlocks.', "we'll still", 'keep track', 'for you!'}}
			},
			{
				str = 'extra left',
				fsize = 2,
				-- A keybind option lets you bind a key!
				keybind = true,
				-- -1 means no key set, otherwise use the Keyboard enum!
				setting = Keyboard.KEY_LEFT_BRACKET,
				variable = "InvDescListkey",
				load = function()
						return wakaba.state.options.exl or Keyboard.KEY_LEFT_BRACKET
				end,
				store = function(var)
						wakaba.state.options.exl = var
				end,
				tooltip = {strset = {'extra left','for some','items from','pnw','','default = ['}},
			},
			{
				str = 'extra right',
				fsize = 2,
				-- A keybind option lets you bind a key!
				keybind = true,
				-- -1 means no key set, otherwise use the Keyboard enum!
				setting = Keyboard.KEY_RIGHT_BRACKET,
				variable = "InvDescListkey",
				load = function()
						return wakaba.state.options.exr or Keyboard.KEY_RIGHT_BRACKET
				end,
				store = function(var)
						wakaba.state.options.exr = var
				end,
				tooltip = {strset = {'extra right','for some','items from','pnw','','default = ]'}},
			},
			-- charge bar align
			{
				str = 'charge bar align',
				fsize = 2,
				choices = {'left', 'right'},
				variable = "ChargebarAlign",
				setting = 1,
				load = function()
					if wakaba.state.options.leftchargebardigits then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.leftchargebardigits = (var == 1)
				end,
				tooltip = {strset = {'change', 'direction', 'for', 'charge bar', 'numbers'}}
			},
			-- hud alpha
			{
				str = 'hud alpha',
				fsize = 2,
				min = 0,
				max = 100,
				increment = 1,
				suf = '%',
				setting = 20,
				variable = "UniformAlpha",
				load = function()
					return wakaba.state.options.uniformalpha or 20
				end,
				store = function(var)
					wakaba.state.options.uniformalpha = var
				end,
				tooltip = {strset = {'transparency','setting','for',"wakaba's",'unform','and','book of','shiori'}},
			},
			{str = '', fsize = 1, nosel = true},
			{
					str = '-items-',
					nosel = true,
					glowcolor = 3
			},
			-- instant vintage
			{
				str = 'instant vintage',
				fsize = 2,
				-- A keybind option lets you bind a key!
				keybind = true,
				-- -1 means no key set, otherwise use the Keyboard enum!
				setting = Keyboard.KEY_F5,
				variable = "VintageTriggerKey",
				load = function()
						return wakaba.state.options.vintagetriggerkey or Keyboard.KEY_9
				end,
				store = function(var)
						wakaba.state.options.vintagetriggerkey = var
				end,
				tooltip = {strset = {'press to','activate','vintage','threat','immediately','default = 9'}},
			},
			{str = '', fsize = 1, nosel = true},
			-- stackable mantle
			{
					str = '-stackable mantle-',
					nosel = true,
					glowcolor = 3
			},
			{str = 'set these values to -1 to disable', fsize = 1, nosel = true},
			{str = 'or 0 so set infinite', fsize = 1, nosel = true},
			{str = '', fsize = 2, nosel = true},
			{
				str = 'holy mantle',
				fsize = 2,
				-- If "min" and "max" are set without "slider", you've got yourself a number option!
				-- It will allow you to scroll through the entire range of numbers from "min" to "max", incrementing by "increment"
				min = -1,
				max = 100,
				increment = 1,
				-- You can also specify a prefix or suffix that will be applied to the number, which is especially useful for percentages!
				-- pref = 'hi! ',
				setting = 0,
				variable = "HolyMantleStacks",
				load = function()
					return wakaba.state.options.stackablemantle or 0
				end,
				store = function(var)
					wakaba.state.options.stackablemantle = var
				end,
				changefunc = function(button, item)
					--[[
					if button.setting == -1 then
					elseif button.setting == 0 then
					else
					end
					]]
				end,
				tooltip = {strset = {'max stacks for', 'holy mantle','','does not','affect',"'the lost's", 'unique mantle'}},
			},
			{
				str = 'holy card',
				fsize = 2,
				min = -1,
				max = 100,
				increment = 1,
				setting = 5,
				variable = "HolyCardStacks",
				load = function()
					return wakaba.state.options.stackableholycard or 5
				end,
				store = function(var)
					wakaba.state.options.stackableholycard = var
				end,
				tooltip = {strset = {'max stacks', 'for holy card,','wooden cross'}},
			},
			{
				str = 'blanket',
				fsize = 2,
				min = -1,
				max = 100,
				increment = 1,
				setting = 0,
				variable = "BlanketStacks",
				load = function()
					return wakaba.state.options.stackableblanket or 0
				end,
				store = function(var)
					wakaba.state.options.stackableblanket = var
				end,
				tooltip = {strset = {'max stacks', 'for blanket','when entering','boss room'}},
			},
			{
				str = "wakaba's blessing",
				fsize = 2,
				min = -1,
				max = 100,
				increment = 1,
				setting = 0,
				variable = "WakabaShieldStacks",
				load = function()
					return wakaba.state.options.stackableblessing or 0
				end,
				store = function(var)
					wakaba.state.options.stackableblessing = var
				end,
				tooltip = {strset = {"max stacks","for wakaba's ","blessing","shield ","when total","hearts are","1 or less"}},
			},
			{str = '', fsize = 1, nosel = true},
			-- blanket settings
			{
					str = '- blanket -',
					nosel = true,
					glowcolor = 3
			},
			{str = '', fsize = 2, nosel = true},
			{
				str = 'dogma',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'DogmaBlanket',
				load = function()
					if wakaba.state.options.dogmablanket then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.dogmablanket = (var == 1)
				end,
				tooltip = {strset = {'activate','blanket','shield on','dogma fight'}}
			},
			{
				str = 'beast',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'BeastBlanket',
				load = function()
					if wakaba.state.options.beastblanket then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.beastblanket = (var == 1)
				end,
				tooltip = {strset = {'activate','blanket','shield on','beast fight'}}
			},
			{str = '', fsize = 1, nosel = true},
			-- dead wisp notif
			{
				str = 'dead wisp notif',
				choices = {'true', 'false'},
				setting = 1,
				variable = 'DeadWispNotif',
				load = function()
					if wakaba.state.options.deadwispnotif then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.deadwispnotif = (var == 1)
				end,
				tooltip = {strset = {'notify which','item wisp is','turned off'}}
			},
			{str = '', fsize = 1, nosel = true},
			-- custom sounds
			{
				str = '-custom sounds-',
				nosel = true,
				glowcolor = 3
			},
			{
				str = 'custom item sounds',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'CustomItemSound',
				load = function()
					if wakaba.state.options.customitemsound then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.customitemsound = (var == 1)
				end,
				tooltip = {strset = {'custom item','sound from','pudding & wakaba','items'}}
			},
			{
				str = 'custom hurt sounds',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'CustomHurtSound',
				load = function()
					if wakaba.state.options.customhitsound then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.customhitsound = (var == 1)
				end,
				tooltip = {strset = {'custom hurt','sound from','pudding & wakaba','characters'}}
			},
			{
					str = 'custom sounds volume',
					fsize = 2,
					-- The "slider" tag allows you to make a button a slider, with notches that are transparent / opaque depending on if they're filled.
					slider = true,
					-- Increment determines how much the value of the slider changes with each notch
					increment = 1,
					-- Max determines the maximum value of the slider. The number of notches is equal to max / increment!
					max = 10,
					-- Setting determines the initial value of the slider
					setting = 5,

					-- "variable" is used as a key to story your setting; just set it to something unique for each setting!
					variable = 'CustomSoundVolume',

					-- These functions work just like in the choice option!
					load = function()
							return wakaba.state.options.customsoundvolume or 5
					end,
					store = function(var)
							wakaba.state.options.customsoundvolume = var
					end,

					tooltip = {strset = {'volume for','pudding & wakaba','custom sounds'}}
			},
			{str = '', fsize = 1, nosel = true},
			-- inventory descriptions
			{
					str = '- inventory desc. -',
					nosel = true,
					glowcolor = 3
			},
			{str = 'press toggle key to enter list', fsize = 1, nosel = true},
			{str = 'press up/down for scroll', fsize = 1, nosel = true},
			{
				str = 'list key',
				fsize = 2,
				-- A keybind option lets you bind a key!
				keybind = true,
				-- -1 means no key set, otherwise use the Keyboard enum!
				setting = Keyboard.KEY_F5,
				variable = "InvDescListkey",
				load = function()
						return wakaba.state.options.listkey or Keyboard.KEY_F5
				end,
				store = function(var)
						wakaba.state.options.listkey = var
				end,
				tooltip = {strset = {'press to','display','list and','descriptions','for current','held items','','default = f5'}},
			},
			{
				str = 'switch key',
				fsize = 2,
				-- A keybind option lets you bind a key!
				keybind = true,
				-- -1 means no key set, otherwise use the Keyboard enum!
				setting = Keyboard.KEY_F6,
				variable = "InvDescSwitchkey",
				load = function()
						return wakaba.state.options.switchkey or Keyboard.KEY_F6
				end,
				store = function(var)
						wakaba.state.options.switchkey = var
				end,
				tooltip = {strset = {'press to','switch','descriptions','mode','for current','held items','','default = f6'}},
			},
			{
				str = 'history mode',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'InvDescHistory',
				load = function()
					if wakaba.state.options.invpassivehistory then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.invpassivehistory = (var == 1)
				end,
				displayif = function(btn, item, tbl)
					return REPENTOGON ~= nil
				end,
				tooltip = {strset = {'display type', 'in', 'inventory','descriptions'}}
			},
			{
				str = 'list offset',
				fsize = 2,
				min = 100,
				max = 600,
				increment = 10,
				setting = 200,
				variable = "InvDescListOffset",
				load = function()
					return wakaba.state.options.listoffset or 200
				end,
				store = function(var)
					wakaba.state.options.listoffset = var
				end,
				tooltip = {strset = {'right offset','for list','of items','','default = 200'}},
			},
			{
				str = 'initial display mode',
				fsize = 2,
				choices = {'list', 'grid'},
				setting = 1,
				variable = 'InvDescDisplay',
				load = function()
					if wakaba.state.options.invlistmode == "list" then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.invlistmode = (var == 1 and "list" or "grid")
				end,
				tooltip = {strset = {'display mode', 'in', 'inventory','descriptions'}}
			},
			{
				str = 'grid columns',
				fsize = 2,
				min = 3,
				max = 10,
				increment = 1,
				setting = 6,
				variable = "InvDescGridSize",
				load = function()
					return wakaba.state.options.invgridcolumn or 6
				end,
				store = function(var)
					wakaba.state.options.invgridcolumn = var
				end,
				tooltip = {strset = {'grid columns','for list','of items','','default = 6'}},
			},
			{
				str = 'init cursor position',
				fsize = 2,
				choices = {"character", "collectible", "collectible_modded", "trinket"},
				setting = 1,
				variable = 'InvDescInitPos',
				load = function()
					local c = wakaba.state.options.invinitcursor
					if not c or c == "character" then return 1
					elseif c == "collectible" then return 2
					elseif c == "collectible_modded" then return 3
					elseif c == "trinket" then return 4
					end
				end,
				store = function(var)
					-- TODO lazy
					if var == 1 then wakaba.state.options.invinitcursor = "character"
					elseif var == 2 then wakaba.state.options.invinitcursor = "collectible"
					elseif var == 3 then wakaba.state.options.invinitcursor = "collectible_modded"
					elseif var == 4 then wakaba.state.options.invinitcursor = "trinket"
					else
					end
				end,
				tooltip = {strset = {'initial cursor', 'position in', 'inventory','descriptions'}}
			},
		},
	},
	hud_setting = {
		title = 'hud settings',
		buttons = {
			{
				str = 'hit counter',
				fsize = 2,
				choices = {"don't show", "penalties only", "all"},
				setting = 1,
				variable = 'HUDHitCounter',
				load = function()
					return wakaba.state.options.hudhitcounter + 1
				end,
				store = function(var)
					wakaba.state.options.hudhitcounter = var - 1
				end,
				tooltip = {strset = {''}}
			},
			{
				str = 'room number',
				fsize = 2,
				choices = {"don't show", "number only", "full string", "combined with name"},
				setting = 1,
				variable = 'HUDRoomNumber',
				load = function()
					return wakaba.state.options.hudroomnumber + 1
				end,
				store = function(var)
					wakaba.state.options.hudroomnumber = var - 1
				end,
				tooltip = {strset = {''}}
			},
			{
				str = 'room name',
				fsize = 2,
				choices = {"don't show", "name scroll", "name only", "full string"},
				setting = 1,
				variable = 'HUDRoomName',
				load = function()
					return wakaba.state.options.hudroomname + 1
				end,
				store = function(var)
					wakaba.state.options.hudroomname = var - 1
				end,
				tooltip = {strset = {''}}
			},
			{
				str = 'room difficulty',
				fsize = 2,
				choices = {"don't show", "difficulty only", "full string", "combined with weight"},
				setting = 1,
				variable = 'HUDRoomDifficulty',
				load = function()
					return wakaba.state.options.hudroomdiff + 1
				end,
				store = function(var)
					wakaba.state.options.hudroomdiff = var - 1
				end,
				tooltip = {strset = {''}}
			},
			{
				str = 'room weight',
				fsize = 2,
				choices = {"don't show", "weight only", "full string"},
				setting = 1,
				variable = 'HUDRoomWeight',
				load = function()
					return wakaba.state.options.hudroomweight + 1
				end,
				store = function(var)
					wakaba.state.options.hudroomweight = var - 1
				end,
				displayif = function(btn, item, tbl)
					return wakaba.state.options.hudroomdiff ~= 3
				end,
				tooltip = {strset = {''}}
			},
		},
	},
	characters_setting = {
		title = 'characters',
		buttons = {

			-- T.Lost starts Wakaba's Uniform : TRUE/false
			{
				str = 'uniform for tainted lost',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'LostUniform',
				load = function()
					if wakaba.state.options.lostuniform then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.lostuniform = (var == 1)
				end,
				displayif = function(btn, item, tbl)
					return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'t.lost','starts with',"wakaba's",'uniform'}}
			},
			-- T.Eden starts with Sticky Note : TRUE/false
			{
				str = 'sticky for tainted eden',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'EdenSticky',
				load = function()
					if wakaba.state.options.edensticky then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.edensticky = (var == 1)
				end,
				displayif = function(btn, item, tbl)
					return wakaba.state.unlock.edensticky
				end,
				tooltip = {strset = {'t.eden','starts with','sticky','note'}}
			},

			---------------------------------------------------------------------------
			-------------------------------Wakaba Settings-----------------------------
			{str = '', fsize = 1, nosel = true},
			{
					str = 'wakaba',
					nosel = true
			},
			{str = '', fsize = 2, nosel = true},
			{
				str = 'clover chest chance',
				fsize = 2,
				min = 0,
				max = 100,
				increment = 0.5,
				suf = '%',
				setting = 0,
				variable = "CloverChestChance",
				load = function() return wakaba.state.options.cloverchestchance or wakaba.optiondefaults.cloverchestchance end,
				store = function(var) wakaba.state.options.cloverchestchance = var end,
				displayif = function(btn, item, tbl) return wakaba:IsEntryUnlocked("cloverchest") end,
				tooltip = {strset = {'chance for', 'spawn', 'clover chest', 'set 0 to', 'disable'}},
			},

			-- Minimum quality for Wakaba's Blessing : 0(Disable)/1/2
			-- Maximum quality for Wakaba's Nemesis : 2/3/4(Disable)
			-- Homing tears for Wakaba : TRUE/false
			-- Spectral/Piercing tears for T.Wakaba : TRUE/false
			-- Health limit for Wakaba : TRUE/false

			---------------------------------------------------------------------------
			-----------------------------	Shiori Settings	---------------------------
			{str = '', fsize = 1, nosel = true},
			{
					str = '- shiori -',
					nosel = true,
					glowcolor = 3
			},
			{str = '', fsize = 2, nosel = true},
			{
				str = 'shiori valut chance',
				fsize = 2,
				min = 0,
				max = 100,
				increment = 0.5,
				suf = '%',
				setting = 0,
				variable = "ShioriValutChance",
				load = function() return wakaba.state.options.valutchance or wakaba.optiondefaults.valutchance end,
				store = function(var) wakaba.state.options.valutchance = var end,
				displayif = function(btn, item, tbl) return wakaba:IsEntryUnlocked("shiorivalut") end,
				tooltip = {strset = {'chance for', 'spawn', 'shiori valut', 'set 0 to', 'disable'}},
			},

			---------------------------------------------------------------------------
			-----------------------------	Tsukasa Settings	---------------------------
			{str = '', fsize = 1, nosel = true},
			{
					str = '- tsukasa -',
					nosel = true,
					glowcolor = 3
			},
			{str = '', fsize = 2, nosel = true},

			{
				str = 'concentration key',
				fsize = 2,
				-- A keybind option lets you bind a key!
				keybind = true,
				-- -1 means no key set, otherwise use the Keyboard enum!
				setting = Keyboard.KEY_LEFT_CONTROL,
				variable = "TsukasaConcentrationKey",
				load = function()
						return wakaba.state.options.concentrationkeyboard or Keyboard.KEY_LEFT_CONTROL
				end,
				store = function(var)
						wakaba.state.options.concentrationkeyboard = var
				end,
				tooltip = {strset = {'hold to','enter','concentration','mode for','tsukasa','','default = lctrl'}},
			},

			{
				str = 'show lunar percent',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'TsukasaLunarPercentShow',
				load = function()
					if wakaba.state.options.lunarpercent then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.lunarpercent = (var == 1)
				end,
				tooltip = {strset = {'show','percent','for','lunar stone'}}
			},
			{
				str = 'easter egg chance',
				fsize = 2,
				min = 0,
				max = 100,
				increment = 0.5,
				suf = '%',
				setting = 0,
				variable = "EasterEggChance",
				load = function() return wakaba.state.options.eastereggchance or wakaba.optiondefaults.eastereggchance end,
				store = function(var) wakaba.state.options.eastereggchance = var end,
				displayif = function(btn, item, tbl) return wakaba:IsEntryUnlocked("easteregg") end,
				tooltip = {strset = {'chance for', 'spawn', 'easter egg', 'set 0 to', 'disable'}},
			},

			---------------------------------------------------------------------------
			-----------------------------	richer Settings	---------------------------
			{str = '', fsize = 1, nosel = true},
			{
					str = '- richer -',
					nosel = true,
					glowcolor = 3
			},
			{str = '', fsize = 2, nosel = true},
			{
				str = 'crystal restock chance',
				fsize = 2,
				min = 0,
				max = 100,
				increment = 0.5,
				suf = '%',
				setting = 0,
				variable = "CrystalRestockChance",
				load = function() return wakaba.state.options.crystalrestockchance or wakaba.optiondefaults.crystalrestockchance end,
				store = function(var) wakaba.state.options.crystalrestockchance = var end,
				displayif = function(btn, item, tbl) return wakaba:IsEntryUnlocked("crystalrestock") end,
				tooltip = {strset = {'chance for', 'spawn', 'crystal restock', 'set 0 to', 'disable'}},
			},

			---------------------------------------------------------------------------
			-----------------------------	rira Settings	---------------------------
			{str = '', fsize = 1, nosel = true},
			{
					str = '- rira -',
					nosel = true,
					glowcolor = 3
			},
			{str = '', fsize = 2, nosel = true},

			{
				str = 'swap stats',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 2,
				variable = 'RiraStatSwap',
				load = function()
					if wakaba.state.options.rirastatswap then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.rirastatswap = (var == 1)
					wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
						if player:GetPlayerType() == wakaba.Enums.Players.RIRA then
							player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
							player:EvaluateItems()
						end
					end)
				end,
			},

			{
				str = 'chimaki sounds',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'RiraChimakiSound',
				load = function()
					if wakaba.state.options.chimakisound then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.chimakisound = (var == 1)
				end,
				tooltip = {strset = {'rabbit sound','for chimaki'}}
			},
			{
				str = 'rabbey ward effects',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'RiraRabbeyWardRender',
				load = function()
					if wakaba.state.options.rabbeywardrender then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.rabbeywardrender = (var == 1)
				end,
				tooltip = {strset = {'render effects','for', 'rabbey ward'}}
			},
			{
				str = 'tainted rira full pica',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'RiraFullPica',
				load = function()
					if wakaba.state.options.rirafullpica then
						return 1
					else
						return 2
					end
				end,
				store = function(var)
					wakaba.state.options.rirafullpica = (var == 1)
				end,
				tooltip = {strset = {'tainted rira', 'converts all', 'items to trinkets'}}
			},

		},
		generate = function(item)
		end,
		update = function(item)
		end
	},
	wakabaunlocks = {

	},
	completionnotes = {
		title = "completion notes",
		nocursor = true,
		buttons = {
			{str = ""},
			{str = ""},
			{str = ""},
			{str = ""},
			{str = ""},

			--{str = "", nosel = true},
			--{str = "", nosel = true},
			{str = "", nosel = true},
			{str = "", nosel = true},
			{str = "", fsize = 2, nosel = true},

			{
				str = "current character : wakaba",
				nosel = true,
				fsize = 1,

				displayif = function(_, item)
					return item.bsel == 1
				end,
			},
			{
				str = "current character : shiori",
				nosel = true,
				fsize = 1,

				displayif = function(_, item)
					return item.bsel == 2
				end,
			},
			{
				str = "current character : tsukasa",
				nosel = true,
				fsize = 1,

				displayif = function(_, item)
					return item.bsel == 3
				end,
			},
			{
				str = "current character : richer",
				nosel = true,
				fsize = 1,

				displayif = function(_, item)
					return item.bsel == 4
				end,
			},
			{
				str = "current character : rira",
				nosel = true,
				fsize = 1,

				displayif = function(_, item)
					return item.bsel == 5
				end,
			},
		},

		postrender = function(item, tbl)
			if item.bsel < 1 then item.bsel = 5 end
			if item.bsel > 5 then item.bsel = 1 end
			--[[ if item.bsel == 5 then end ]]
			local centre = getScreenCenterPosition()
			local renderDataset = completionCharacterSets[item.bsel]
			local offsets = {NOTE1_RENDER_OFFSET, NOTE2_RENDER_OFFSET}
			if #renderDataset == 1 then offsets = {NOTE3_RENDER_OFFSET} end

			for index, renderData in pairs(renderDataset) do
				if renderData.IsUnlocked() then
					local dataset = wakaba:GetCompletionNoteLayerDataFromPlayerType(renderData.PlayerID)
					for index, value in pairs(dataset) do
						completionNoteSprite:SetLayerFrame(index, value)
					end
					completionHead:SetFrame(renderData.HeadName, 0)

					completionNoteSprite:Render(centre + offsets[index], Vector.Zero, Vector.Zero)
					completionHead:Render(centre + offsets[index] + Vector(30, 85), Vector.Zero, Vector.Zero)
				else
					completionHead:SetFrame(renderData.HeadName, 1)
					completionHead:Render(centre + offsets[index] + Vector(30, 85), Vector.Zero, Vector.Zero)

					completionDoor:SetFrame(renderDataset[index - 1].HeadName, 0)
					completionDoor:Render(centre + offsets[index], Vector.Zero, Vector.Zero)
				end
			end
		end,
	},
	unlockspopup = {
		title = "achievements?",
		fsize = 1,
		buttons = {
			{str = "pudding n' wakaba's characters come with", nosel = true},
			{str = "full sets of unlocks", nosel = true},
			{str = "", nosel = true},
			{str = "this is an optional feature", nosel = true},

			{str = "", nosel = true},
			{str = "do you want to lock", fsize = 2, nosel = true},
			{str = "some items behind", fsize = 2, nosel = true},
			{str = "our characters?", fsize = 2, nosel = true},
			{str = "", nosel = true},
			{
				str = "yes",
				action = "resume",
				fsize = 3,
				glowcolor = 3,

				func = function()
					wakaba.state.options.allowlockeditems = false
					wakaba.state.achievementPopupShown = true
					wakaba.showPersistentUnlockText = false

					wakaba:LockItems()
					if not wakaba:IsWakabaCharacterUnlocked(Isaac.GetPlayer()) then
						wakaba.G:FinishChallenge()
					end

					--Retribution.RemoveLockedItemsAndTrinkets()
					--Retribution.BuildCustomItemPools()
				end,
			},
			{
				str = "no",
				action = "resume",
				fsize = 3,

				func = function(button, item, root)
					wakaba.state.options.allowlockeditems = true
					wakaba.state.achievementPopupShown = true
					wakaba.showPersistentUnlockText = false
					if Isaac.GetPlayer():GetPlayerType() == wakaba.Enums.Players.RICHER then
						Isaac.GetPlayer():RemoveCollectible(wakaba.Enums.Collectibles.SWEETS_CATALOG)
						Isaac.GetPlayer():SetPocketActiveItem(wakaba.Enums.Collectibles.SWEETS_CATALOG, ActiveSlot.SLOT_POCKET, true)
					end

					--Retribution.RemoveLockedItemsAndTrinkets()
					--Retribution.BuildCustomItemPools()
				end
			},

			{str = "", nosel = true},
			{str = "you can change this later in our mod menu", nosel = true},
		},

		tooltip = {strset = {"you can", "change this", "later"}},
	},
	---------------------------------------------------------------------------
	-----------------------------------ForceVoid-------------------------------
	enhbossdest = {
		title = 'boss destination',
		generate = function(item)
			item.ds1 = {
				[1] = nil,
				[2] = "Random",
				[3] = "BlueBaby",
				[4] = "Lamb",
				[5] = "MegaSatan",
				[6] = "Delirium",
				[7] = "Mother",
				[8] = "Beast",
			}
			item.ds2 = {
				[1] = nil,
				[2] = -1,
				[3] = 500000,
				[4] = 1000000,
				[5] = 10000000,
				[6] = 100000000,
				[7] = 1000000000,
				[8] = 10000000000,
			}
			item.ds3 = {
				[1] = nil,
				[2] = "vanilla",
				[3] = "lunar",
				[4] = "vintage",
			}
		end,
		format = {
			Panels = {
				{
					Panel = dssmod.panels.main,
					Offset = Vector(100, 0),
					Color = Color.Default,
				}
			}
		},
		postrender = function(item, tbl)
			if tbl.Exiting then return end
			local sel = item.bsel
			local selToEntry = {
				[1] = "boss",
				[3] = "health",
				[5] = "damo",
				[7] = "lunatic",
				[9] = "lock",
				[11] = "roll",
				[12] = "clear",
			}
			if EID and selToEntry[sel] then
				local title = wakaba:getWakabaDesc("bossdest", "title_"..selToEntry[sel])
				local desc = wakaba:getWakabaDesc("bossdest", "desc_"..selToEntry[sel])
				local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
				demoDescObj.Name = "{{Player"..wakaba.Enums.Players.RICHER_B.."}} " .. (title or "")
				demoDescObj.Description = desc or ""
				EID:displayPermanentText(demoDescObj)
			end
		end,
		buttons = {
			{
				str = 'boss',
				fsize = 2,
				choices = {"none", "random", "bluebaby", "lamb", "megasatan", "delirium", "mother", "beast"},
				setting = 2,
				variable = 'BossDest',
			},
			{str = "", fsize = 1, nosel = true},
			{
				str = 'health',
				fsize = 2,
				choices = {"default", "dynamic", "500,000", "1,000,000", "10,000,000", "100,000,000", "1,000,000,000", "10,000,000,000"},
				setting = 2,
				variable = 'BossDestHealth',
			},
			{str = "", fsize = 1, nosel = true},
			{
				str = 'damocles start',
				fsize = 2,
				choices = {'none', 'vanilla', 'lunar', 'vintage'},
				setting = 1,
				variable = 'BossDestDamocles',
			},
			{str = "", fsize = 1, nosel = true},
			{
				str = 'lunatic mode',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 2,
				variable = 'BossDestLunatic',
			},
			{str = "", fsize = 1, nosel = true},
			{
				str = 'lock until clear',
				fsize = 2,
				choices = {'true', 'false'},
				setting = 1,
				variable = 'BossDestLock',
			},
			{str = "", fsize = 2, nosel = true},
			{
				str = "roll!!!",
				action = "resume",
				fsize = 3,

				func = function(button, item, root)
					local s_BossDest = item.ds1[item.buttons[1].setting]
					local s_BossDestHealth = item.ds2[item.buttons[3].setting]
					local s_Damocles = item.ds3[item.buttons[5].setting]
					local s_Lunatic = item.buttons[7].setting == 1
					local s_Lock = item.buttons[9].setting == 1

					print(s_BossDest, s_BossDestHealth, s_Damocles, s_Lunatic, s_Lock)

					if s_BossDest ~= "Random" then
						wakaba.state.bossdest = s_BossDest
						wakaba.state.bossdesthealth = s_BossDestHealth ~= nil
						wakaba.state.bossdestlunatic = s_Lunatic
						wakaba.state.damoclesstart = s_Damocles
						wakaba.state.bossdestlock = s_Lock
						wakaba.state.bossdesthealthamount = s_BossDestHealth
					else
						wakaba:BossRoll(s_BossDestHealth ~= nil, s_Lunatic, s_Damocles, s_BossDestHealth, s_Lock)
					end
					if s_Damocles then
						wakaba:SetupDamocles(s_Damocles)
					end
					if EID then
						EID:hidePermanentText()
					end
					DeadSeaScrollsMenu.CloseMenu(true)
				end
			},
			{str = "", fsize = 2, nosel = true},
			{
				str = "clear",
				action = "resume",
				fsize = 3,

				func = function(button, item, root)
					wakaba:ClearBossDestData()
					if EID then
						EID:hidePermanentText()
					end
					DeadSeaScrollsMenu.CloseMenu(true)
				end
			},
		},
	},


	---------------------------------------------------------------------------
	-----------------------------------ForceVoid-------------------------------
	forcevoid = {
		title = 'forcevoid',
		buttons = {
			{
					str = '- progression -',
					nosel = true,
					glowcolor = 3
			},
			{str = '', fsize = 2, nosel = true},
			{
				str = 'ascent',
				choices = {"don't drop", "drop fool/to the start"},
				setting = 1,
				variable = 'ForceVoidFool',
				load = function()
					return wakaba.state.forcevoid.mom + 1
				end,
				store = function(var)
					wakaba.state.forcevoid.mom = var - 1
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'defeating','mom drops','the fool','to enter','the ascent'}}
			},
			{
				str = 'mega satan',
				choices = {"don't drop", "drop key pieces"},
				setting = 1,
				variable = 'ForceVoidKeyPieces',
				load = function()
					return wakaba.state.forcevoid.keypiece + 1
				end,
				store = function(var)
					wakaba.state.forcevoid.keypiece = var - 1
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'defeating','???/lamb','drops','key pieces','to enter','mega satan'}}
			},
			{
				str = 'corpse',
				choices = {"don't drop", "drop knife pieces"},
				setting = 1,
				variable = 'ForceVoidKnifePieces',
				load = function()
					return wakaba.state.forcevoid.knifepiece + 1
				end,
				store = function(var)
					wakaba.state.forcevoid.knifepiece = var - 1
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'defeating','mausoleum','mom drops','knife pieces','to enter','the corpse'}}
			},
			{
				str = 'wrong mausoleum',
				choices = {"don't drop", "drop the paper trinket"},
				setting = 1,
				variable = 'ForceVoidBringMeThere',
				load = function()
					return wakaba.state.forcevoid.beast + 1
				end,
				store = function(var)
					wakaba.state.forcevoid.beast = var - 1
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'drops','a trinket','at the','starting room'}}
			},
			{
					str = 'starting room of mausoleum/gehenna ii',
					nosel = true,
					fsize = 1,
			},
			{
					str = 'spawns bring me there trinket',
					nosel = true,
					fsize = 1,
			},
			{
					str = "that replaces mom to dad's note",
					nosel = true,
					fsize = 1,
			},
			{
					str = "",
					nosel = true,
					fsize = 1,
			},
			{
				str = 'missing red key',
				choices = {"don't drop", "drop cracked key"},
				setting = 1,
				variable = 'ForceVoidRedKey',
				load = function()
					return wakaba.state.forcevoid.crackedkey + 1
				end,
				store = function(var)
					wakaba.state.forcevoid.crackedkey = var - 1
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'entering','home removes','little baggy','and drops','cracked key'}}
			},
			{str = '', fsize = 1, nosel = true},
			{
					str = '- void portals -',
					nosel = true,
					glowcolor = 3
			},
			{str = '', fsize = 2, nosel = true},
			{
				str = 'isaac/satan',
				choices = {"normal", "force open void portal", "drop r key"},
				setting = 1,
				variable = 'ForceVoidIsaacSatan',
				load = function()
					return wakaba.state.forcevoid.isaacsatan + 1
				end,
				store = function(var)
					wakaba.state.forcevoid.isaacsatan = var - 1
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'change','behavior','when','isaac/satan','is','defeated'}}
			},
			{
				str = '???/lamb',
				choices = {"normal", "force open void portal", "drop r key"},
				setting = 1,
				variable = 'ForceVoidBBLamb',
				load = function()
					return wakaba.state.forcevoid.bblamb + 1
				end,
				store = function(var)
					wakaba.state.forcevoid.bblamb = var - 1
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'change','behavior','when','???/lamb','is','defeated'}}
			},
			{
				str = 'mega satan',
				choices = {"normal", "force open void portal", "drop r key"},
				setting = 1,
				variable = 'ForceVoidMegaSatan',
				load = function()
					return wakaba.state.forcevoid.megasatan + 1
				end,
				store = function(var)
					wakaba.state.forcevoid.megasatan = var - 1
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'change','behavior','when','mega satan','is','defeated'}}
			},
			{
					str = '!!! warning !!!',
					nosel = true,
					fsize = 1,
			},
			{
					str = 'turning on this option will lock',
					nosel = true,
					fsize = 1,
			},
			{
					str = 'mega satan achievements!',
					nosel = true,
					fsize = 1,
			},
			{
				str = 'mother',
				choices = {"normal", "force open void portal", "drop r key", "sheol/cath passage"},
				setting = 1,
				variable = 'ForceVoidMother',
				load = function()
					return wakaba.state.forcevoid.mother + 1
				end,
				store = function(var)
					wakaba.state.forcevoid.mother = var - 1
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'change','behavior','when','mother','is','defeated'}}
			},
			{
				str = 'delirium',
				choices = {"normal", "drop r key"},
				setting = 1,
				variable = 'ForceVoidDelirium',
				load = function()
					if wakaba.state.forcevoid.mother == 2 then
						return 2
					else
						return 1
					end
				end,
				store = function(var)
					if var == 2 then
						wakaba.state.forcevoid.mother = 2
					else
						wakaba.state.forcevoid.mother = 0
					end
				end,
				displayif = function(btn, item, tbl)
					return true
					--return wakaba.state.unlock.lostuniform
				end,
				tooltip = {strset = {'change','behavior','when','delirium','is','defeated'}}
			},
		},
	},
	characters = {
		title = 'characters',
		buttons = {
			{str = 'wakaba', dest = 'wakabainfos'},
			{str = 'shiori', dest = 'shioriinfos'},
			{str = 'tsukasa', dest = 'tsukasainfos'},
		},
	},
	data_wakaba = {
		title = 'wakaba',
		nocursor = true,
		fsize = 1,
		buttons = {
			{str = ""},
			{str = ""},

			{str = "", nosel = true},
			{str = "", nosel = true},
			{str = "", nosel = true},
			{str = "", nosel = true},
			{str = "", nosel = true},
			{str = "", fsize = 2, nosel = true},

			{
					str = "press up/down for more information",
					nosel = true,
					fsize = 1,

					displayif = function(_, item)
							return item.bsel == 1
					end,
			},
		}
	},
	data_wakaba_t = {
		title = 'wakaba',
		nocursor = true,
		fsize = 1,
		buttons = {
		}
	},
	data_shiori = {
		title = 'shiori',
		nocursor = true,
		fsize = 1,
		buttons = {
		}
	},
	data_shiori_t = {
		title = 'shiori',
		nocursor = true,
		fsize = 1,
		buttons = {
		}
	},
	data_tsukasa = {
		title = 'tsukasa',
		nocursor = true,
		fsize = 1,
		buttons = {
		}
	},
	data_tsukasa_t = {
		title = 'tsukasa',
		nocursor = true,
		fsize = 1,
		buttons = {
		}
	},
}

wakaba.DSS_DIRECTORY = wakabadirectory
wakaba.DSS_MOD = dssmod

local wakabadirectorykey = {
	Item = wakabadirectory.main, -- This is the initial item of the menu, generally you want to set it to your main item
	Main = 'main', -- The main item of the menu is the item that gets opened first when opening your mod's menu.

	-- These are default state variables for the menu; they're important to have in here, but you don't need to change them at all.
	Idle = false,
	MaskAlpha = 1,
	Settings = {},
	SettingsChanged = false,
	Path = {},
}

DeadSeaScrollsMenu.AddMenu("Pudding n wakaba", {Run = dssmod.runMenu, Open = dssmod.openMenu, Close = dssmod.closeMenu, Directory = wakabadirectory, DirectoryKey = wakabadirectorykey})
local displayOptionsEID = false
local tempFont
--[[ wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if EID and EID:getLanguage() ~= "en_us" then
		if DeadSeaScrollsMenu.IsOpen() and DeadSeaScrollsMenu.OpenedMenu.Name == "Pudding n wakaba" then
			displayOptionsEID = true
			local openedMenu = DeadSeaScrollsMenu.OpenedMenu
			if openedMenu.DirectoryKey.Item.title == "achievements?" then
				local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
				demoDescObj.Name = EID:getDescriptionEntry("WakabaAchievementWarningTitle") or ""
				demoDescObj.Description = EID:getDescriptionEntry("WakabaAchievementWarningText") or ""
				--EID:displayPermanentText(demoDescObj, "WakabaAchievementWarningTitle")
				EID:printBulletPoints(demoDescObj.Description, EID:getTextPosition())
			elseif openedMenu.DirectoryKey.Item then
				local item = openedMenu.DirectoryKey.Item
				local currentTitle = item.title
				local currentSel = item.selectedbutton and item.selectedbutton.str
				local currentSelVar = item.selectedbutton and item.selectedbutton.variable
				local currentValue = item.selectedbutton and item.selectedbutton.setting
				if currentTitle == "general settings" and currentSelVar == "ChargebarAlign" then
					local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
					demoDescObj.Name = "차지바 설정"
					demoDescObj.Description = "와카바모드의 차지바 표시 위치를 설정합니다.#Left:원형 왼쪽#Right:원형 오른쪽#TestTestTestTestTestTestTestTest#TestTestTestTestTestTestTestTest#TestTestTestTestTestTestTestTest#TestTestTestTestTestTestTestTest"
					--EID:displayPermanentText(demoDescObj, "WakabaAchievementWarningTitle")
					EID:printBulletPoints(demoDescObj.Description, EID:getTextPosition())
				end
			end
		elseif displayOptionsEID then
			EID:hidePermanentText()
			displayOptionsEID = false
		end
	end
end) ]]
--[[


	settings = {
			title = 'wakaba settings',
			buttons = {
					-- These buttons are all generic menu handling buttons, provided in the table returned from DSSInitializerFunction
					-- They'll only show up if your menu is the only mod menu active
					-- You should generally include them somewhere in your menu, so that players can change the palette or menu keybind even if your mod is the only menu mod active.
					-- You can position them however you like, though!
					dssmod.gamepadToggleButton,
					dssmod.menuKeybindButton,
					dssmod.paletteButton,
					{
						str = 'General',
						dest = 'general',
						tooltip = {strset = {'if enabled', 'there will be', 'increased', 'fortune', 'variety', '', 'enabled by', 'default'}}
					},
					{
						str = 'Forcevoid',
						dest = 'forcevoid',
						tooltip = {strset = {'settings', 'for', 'opening', 'void', 'portals'}}
					},
					{
						str = 'Characters',
						dest = 'characters',
						tooltip = {strset = {'change', 'character', 'settings'}}
					},

					{
							str = 'charge bar align',

							-- The "choices" tag on a button allows you to create a multiple-choice setting
							choices = {'Left', 'Right'},
							-- The "setting" tag determines the default setting, by list index. EG "1" here will result in the default setting being "choice a"
							setting = 1,

							-- "variable" is used as a key to story your setting; just set it to something unique for each setting!
							variable = 'ExampleChoiceOption',

							-- When the menu is opened, "load" will be called on all settings-buttons
							-- The "load" function for a button should return what its current setting should be
							-- This generally means looking at your mod's save data, and returning whatever setting you have stored
							load = function()
									return wakaba.state.options.exampleoption or 1
							end,

							-- When the menu is closed, "store" will be called on all settings-buttons
							-- The "store" function for a button should save the button's setting (passed in as the first argument) to save data!
							store = function(var)
									wakaba.state.options.exampleoption = var
							end,

							-- A simple way to define tooltips is using the "strset" tag, where each string in the table is another line of the tooltip
							tooltip = {strset = {'configure', 'my options', 'please!'}}
					},
					{
							str = 'slider option',

							-- The "slider" tag allows you to make a button a slider, with notches that are transparent / opaque depending on if they're filled.
							slider = true,
							-- Increment determines how much the value of the slider changes with each notch
							increment = 1,
							-- Max determines the maximum value of the slider. The number of notches is equal to max / increment!
							max = 10,
							-- Setting determines the initial value of the slider
							setting = 1,

							-- "variable" is used as a key to story your setting; just set it to something unique for each setting!
							variable = 'ExampleSliderOption',

							-- These functions work just like in the choice option!
							load = function()
									return wakaba.state.options.exampleslider or 1
							end,
							store = function(var)
									wakaba.state.options.exampleslider = var
							end,

							tooltip = {strset = {'like a slide!'}}
					},
					{
							str = 'number option',

							-- If "min" and "max" are set without "slider", you've got yourself a number option!
							-- It will allow you to scroll through the entire range of numbers from "min" to "max", incrementing by "increment"
							min = 20,
							max = 100,
							increment = 5,

							-- You can also specify a prefix or suffix that will be applied to the number, which is especially useful for percentages!
							pref = 'hi! ',
							suf = '%',

							setting = 20,

							variable = "ExampleNumberOption",

							load = function()
									return wakaba.state.options.examplenumber or 20
							end,
							store = function(var)
									wakaba.state.options.examplenumber = var
							end,

							tooltip = {strset = {"who knows", "what it could", "mean"}},
					},
					{
							str = 'keybind option',

							-- A keybind option lets you bind a key!
							keybind = true,
							-- -1 means no key set, otherwise use the Keyboard enum!
							setting = -1,

							variable = "ExampleKeybindOption",

							load = function()
									return wakaba.state.options.examplekeybind or -1
							end,
							store = function(var)
									wakaba.state.options.examplekeybind = var
							end,

							tooltip = {strset = {"it's the key!"}},
					},
					{
							-- Creating gaps in your page can be done simply by inserting a blank button.
							-- The "nosel" tag will make it impossible to select, so it'll be skipped over when traversing the menu, while still rendering!
							str = '',
							fsize = 2,
							nosel = true
					},
					{
							str = 'kill me!',

							-- If you want a button to do something unusual, you can have it call a function using the "func" tag!
							-- The function passes in "button", which is this button object, "item", which is the item object containing these buttons, and "menuObj", which is what you pass into AddMenu (contains DirectoryKey and Directory!)
							func = function(button, item, menuObj)
									Isaac.GetPlayer():Kill()
							end,

							-- "displayif" allows you to dynamically hide or show a button. If you return true, it will display, and if you return false, it won't!
							-- It passes in all the same args as "func"
							-- In this example, this button will be hidden if the "slider option" button above is set to its maximum value.
							displayif = function(button, item, menuObj)
									if item and item.buttons then
											for _, btn in ipairs(item.buttons) do
													if btn.str == 'slider option' and btn.setting == 10 then
															return false
													end
											end
									end

									return true
							end,

							-- The "generate" function is run the very first time a button displays upon switching to its item
							-- You can use this to change the button's data dynamically, for instance for a menu that uses non-constant data.
							-- In this example, it's just a random chance to change the string the button displays, but you could do pretty much anything!
							generate = function(button, item, tbl)
									if math.random(1, 100) == 1 then
											button.str = "really kill me!"
									else
											button.str = "kill me!"
									end
							end,

							tooltip = {strset = {'press this', 'to kill', 'isaac!'}}
					},
			}
	},
 ]]