return {
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
}