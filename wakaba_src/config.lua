
-- MOD CONFIG MENU Compatibility
local MCM = ModConfigMenu

if MCM then
	MCM.RemoveCategory("Pudding & Wakaba")
	local function AnIndexOf(t, val)
		for k, v in ipairs(t) do
			if v == val then
				return k
			end
		end
		return 1
	end
	---------------------------------------------------------------------------
	-----------------------------------Info------------------------------------
	MCM.UpdateSubcategory("Pudding & Wakaba", "Info", {
		Info = ""
	})
	MCM.AddSpace("Pudding & Wakaba", "Info")
	MCM.AddText("Pudding & Wakaba", "Info", function() return "Pudding & Wakaba" end)
	MCM.AddText("Pudding & Wakaba", "Info", function() return ""..wakaba.version end)
	MCM.AddText("Pudding & Wakaba", "Info", function() return "by kohashiwahaba aka. Mika" end)

	---------------------------------------------------------------------------
	-----------------------------------Items---------------------------------
--[[ 	MCM.UpdateSubcategory("Pudding & Wakaba", "Items", {
		Info = "Choose What items to show"
	})
	MCM.AddText("Pudding & Wakaba", "Items", function() return "WIP. Comming soon..." end)
 ]]
	---------------------------------------------------------------------------
	-----------------------------------General---------------------------------
	MCM.UpdateSubcategory("Pudding & Wakaba", "General", {
		Info = ""
	})
	-- General - Allow Locked items
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.allowlockeditems
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.allowlockeditems then
					onOff = "True"
				end
				return "Allow Locked Items: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.allowlockeditems = currentBool
			end,
			Info = {
				"Allows Locked items to be shown.",
				"This ignores character's completion marks.",
			}
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "General")
	MCM.AddText("Pudding & Wakaba", "General", function() return "Charge Bars" end)
	-- General - Charge Bar
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.leftchargebardigits
			end,
			Display = function()
				local onOff = "Right"
				if wakaba.state.options.leftchargebardigits then
					onOff = "Left"
				end
				return "Charge Bar align: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.leftchargebardigits = currentBool

			end,
			Info = {
				"Change alignment for number of charge bars.",
				"Percent display only shows when Charge Bars in Isaac options is enabled.",
			}
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "General")
	MCM.AddText("Pudding & Wakaba", "General", function() return "Stackable Holy Mantle" end)
	-- General - Stackable Mantles
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.stackablemantle
			end,
			Minimum = -1,
			Maximum = 100,
			Display = function()
				local val = ""
				if wakaba.state.options.stackablemantle == -1 then
					val = "Disabled"
				elseif wakaba.state.options.stackablemantle == 0 then
					val = "Infinite"
				else
					val = wakaba.state.options.stackablemantle
				end
				return "Max stacks for Holy Mantle: " .. val
			end,
			OnChange = function(currentNum)
				wakaba.state.options.stackablemantle = currentNum

			end,
			Info = {
				"Maximum stacks for Holy Mantle shield per room. Does not affect The Lost's Holy mantle.",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.stackableholycard
			end,
			Minimum = -1,
			Maximum = 100,
			Display = function()
				local val = ""
				if wakaba.state.options.stackableholycard == -1 then
					val = "Disabled"
				elseif wakaba.state.options.stackableholycard == 0 then
					val = "Infinite"
				else
					val = wakaba.state.options.stackableholycard
				end
				return "Max stacks for Holy Card: " .. val
			end,
			OnChange = function(currentNum)
				wakaba.state.options.stackableholycard = currentNum

			end,
			Info = {
				"Maximum stacks for Holy Card, Wooden Cross, Elixir of Life, and Mystic Crystal.",
				"Elixir of Life, and Mystic Crystal limits to 5 regardless of this option.",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.stackableblanket
			end,
			Minimum = -1,
			Maximum = 100,
			Display = function()
				local val = ""
				if wakaba.state.options.stackableblanket == -1 then
					val = "Disabled"
				elseif wakaba.state.options.stackableblanket == 0 then
					val = "Infinite"
				else
					val = wakaba.state.options.stackableblanket
				end
				return "Max stacks for Blanket: " .. val
			end,
			OnChange = function(currentNum)
				wakaba.state.options.stackableblanket = currentNum

			end,
			Info = {
				"Maximum stacks for Blanket shield when entering the boss room.",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.stackableblessing
			end,
			Minimum = -1,
			Maximum = 100,
			Display = function()
				local val = ""
				if wakaba.state.options.stackableblessing == -1 then
					val = "Disabled"
				elseif wakaba.state.options.stackableblessing == 0 then
					val = "Infinite"
				else
					val = wakaba.state.options.stackableblessing
				end
				return "Max stacks for Wakaba's Blessing: " .. val
			end,
			OnChange = function(currentNum)
				wakaba.state.options.stackableblessing = currentNum

			end,
			Info = {
				"Maximum stacks for Wakaba's Blessing shield when total hearts are 1 or less.",
			}
		}
	)

	MCM.AddSpace("Pudding & Wakaba", "General")
	MCM.AddText("Pudding & Wakaba", "General", function() return "Blanket Settings" end)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.dogmablanket
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.dogmablanket then
					onOff = "True"
				end
				return "Activate for Dogma: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.dogmablanket = currentBool

			end,
			Info = {
				"Activate Blanket shield on Dogma fight",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.beastblanket
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.beastblanket then
					onOff = "True"
				end
				return "Activate for The Beast: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.beastblanket = currentBool

			end,
			Info = {
				"Activate Blanket shield on The Beast fight",
			}
		}
	)

	MCM.AddSpace("Pudding & Wakaba", "General")
	MCM.AddText("Pudding & Wakaba", "General", function() return "Dead Wisp Notification" end)
	-- General - Dead Wisp Notification
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.deadwispnotif
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.deadwispnotif then
					onOff = "True"
				end
				return "Notify on Item Wisp Death: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.deadwispnotif = currentBool

			end,
			Info = {
				"Notify which Item wisp is turned off",
			}
		}
	)

	MCM.AddSpace("Pudding & Wakaba", "General")
	MCM.AddText("Pudding & Wakaba", "General", function() return "Sounds" end)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.customitemsound
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.customitemsound then
					onOff = "True"
				end
				return "Custom item Sound: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.customitemsound = currentBool

			end,
			Info = {
				"Allow custom item sound from Pudding & Wakaba items",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.customhitsound
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.customhitsound then
					onOff = "True"
				end
				return "Custom hurt Sound: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.customhitsound = currentBool

			end,
			Info = {
				"Allow custom hurt/death sound from Pudding & Wakaba characters",
				"(Richer, Rira)",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.SCROLL,
			CurrentSetting = function()
				return wakaba.state.options.customsoundvolume
			end,
			Display = function()
				return "Custom Sound volume: $scroll" .. wakaba.state.options.customsoundvolume
			end,
			OnChange = function(currentNum)
				wakaba.state.options.customsoundvolume = currentNum
			end,
			Info = {
				"Adjust volume for Pudding & Wakaba custom sounds",
				"(Richer, Rira, Chimaki, etc)",
			}
		}
	)

	--[[ MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.deadwispnotifsound
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.deadwispnotifsound then
					onOff = "True"
				end
				return "Sound on Item Wisp Death: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.deadwispnotifsound = currentBool

			end,
			Info = {
				"Sound which Item wisp is turned off",
			}
		}
	) ]]

	MCM.AddSpace("Pudding & Wakaba", "General")
	MCM.AddText("Pudding & Wakaba", "General", function() return "Inventory Descriptions" end)
	-- General - Inventory Descriptions
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.KEYBIND_KEYBOARD,
			CurrentSetting = function()
				return wakaba.state.options.listkey
			end,
			Display = function()
				local currentValue = wakaba.state.options.listkey
				local displayString = "List toggle key : "
				local key = "None"
				if currentValue > -2 then
					key = "Unknown Key"
					if currentValue == -1 then
						key = "(Disabled)"
					end
					if InputHelper.KeyboardToString[currentValue] then
						key = InputHelper.KeyboardToString[currentValue]
					end
				end
				displayString = displayString .. key
				return displayString
			end,
			Popup = function()

				local currentValue = wakaba.state.options.listkey

				local goBackString = "back"
				if ModConfigMenu.Config.LastBackPressed then

					if InputHelper.KeyboardToString[ModConfigMenu.Config.LastBackPressed] then
						goBackString = InputHelper.KeyboardToString[ModConfigMenu.Config.LastBackPressed]
					end

				end

				local keepSettingString = ""
				if currentValue > -2 then

					local currentSettingString = nil
					if currentValue == -1 then
						currentSettingString = "(Disabled)"
					end
					if InputHelper.KeyboardToString[currentValue] then
						currentSettingString = InputHelper.KeyboardToString[currentValue]
					end

					keepSettingString = "This setting is currently set to \"" .. currentSettingString .. "\".$newlinePress this button to keep it unchanged.$newline$newline"

				end

				local deviceString = ""
				deviceString = "keyboard"

				return "Press a button on your " .. deviceString .. " to change this setting.$newline$newline" .. keepSettingString .. "Press \"" .. goBackString .. "\" to go back and clear this setting."

			end,
			PopupGfx = ModConfigMenu.PopupGfx.WIDE_SMALL,
			PopupWidth = 280,
			OnChange = function(current)
				if current then
					wakaba.state.options.listkey = current
				end
			end,
			Info = {
				"Press to display list and descriptions for current held items(Default = F4 key)",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.listoffset
			end,
			Minimum = 100,
			Maximum = 600,
			ModifyBy = 10,
			Display = function()
				return "List offset: " .. wakaba.state.options.listoffset
			end,
			OnChange = function(current)
				wakaba.state.options.listoffset = current
			end,
			Info = {
				"Right offset for list of items(Default = 200)",
			}
		}
	)

	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.invcurses
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.invcurses then
					onOff = "True"
				end
				return 'Curses: ' .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.invcurses = currentBool
			end,
			Info = {"Show Curses in Inventory Descriptions."}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.invcollectibles
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.invcollectibles then
					onOff = "True"
				end
				return 'Collectibles: ' .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.invcollectibles = currentBool
			end,
			Info = {"Show Collectibles in Inventory Descriptions."}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.invactives
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.invactives then
					onOff = "True"
				end
				return 'Active items: ' .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.invactives = currentBool
			end,
			Info = {"Show Active items first in Inventory Descriptions."}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.invtrinkets
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.invtrinkets then
					onOff = "True"
				end
				return 'Trinkets: ' .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.invtrinkets = currentBool
			end,
			Info = {"Show Trinkets in Inventory Descriptions."}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.invpocketitems
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.invpocketitems then
					onOff = "True"
				end
				return 'Cards/Pills: ' .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.invpocketitems = currentBool
			end,
			Info = {"Show Cards/Pills in Inventory Descriptions."}
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "General")
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function() return true end,
			Display = function()
				return "--! DISABLE INVDESC HOTKEY !--"
			end,
			OnChange = function(current)
				wakaba.state.options.listkey = -1
			end,
			Info = {
				"Press this to disable Inventory Descriptions hotkeys",
			}
		}
	)



	MCM.AddSpace("Pudding & Wakaba", "General")
	MCM.AddText("Pudding & Wakaba", "General", function() return "Wakaba's Uniform Settings" end)
	-- General - HUD Render 1
	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.uniformalpha
			end,
			Minimum = 0,
			Maximum = 100,
			Display = function()
				return "Font Opacity: " .. wakaba.state.options.uniformalpha .. "%"
			end,
			OnChange = function(currentNum)
				wakaba.state.options.uniformalpha = currentNum

			end,
			Info = {
				"",
			}
		}
	)

	MCM.AddSetting(
		"Pudding & Wakaba",
		"General",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.uniformscale
			end,
			Minimum = 25,
			Maximum = 200,
			ModifyBy = 25,
			Display = function()
				return "Font Size: " .. wakaba.state.options.uniformscale .. "%"
			end,
			OnChange = function(currentNum)
				wakaba.state.options.uniformscale = currentNum

			end,
			Info = {
				"",
			}
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "General")
	-- General - POG
	if Poglite then
		MCM.AddSetting(
			"Pudding & Wakaba",
			"General",
			{
				Type = ModConfigMenu.OptionType.BOOLEAN,
				CurrentSetting = function()
					return wakaba.state.pog
				end,
				Display = function()
					local onOff = "POG"
					if wakaba.state.pog then
						onOff = "Sausage"
					end
					return 'POG Type: ' .. onOff
				end,
				OnChange = function(currentBool)
					wakaba.state.pog = currentBool
				end,
				Info = {"Choose whether POG to be selected. Only works when 'POG for Good Items' Mod is active. Changes will be applied in next game startup."}
			}
		)
	end
	MCM.AddSpace("Pudding & Wakaba", "General")
	---------------------------------------------------------------------------
	------------------------------Item Functions-------------------------------
	MCM.UpdateSubcategory("Pudding & Wakaba", "Items", {
		Info = ""
	})
	-- Items - Wakaba Items
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Items",
		{
			Type = ModConfigMenu.OptionType.KEYBIND_KEYBOARD,
			CurrentSetting = function()
				return wakaba.state.options.vintagetriggerkey
			end,
			Display = function()
				local currentValue = wakaba.state.options.vintagetriggerkey
				local displayString = "Vintage Trigger key : "
				local key = "None"
				if currentValue > -2 then
					key = "Unknown Key"
					if currentValue == -1 then
						key = "(Disabled)"
					end
					if InputHelper.KeyboardToString[currentValue] then
						key = InputHelper.KeyboardToString[currentValue]
					end
				end
				displayString = displayString .. key
				return displayString
			end,
			Popup = function()

				local currentValue = wakaba.state.options.vintagetriggerkey

				local goBackString = "back"
				if ModConfigMenu.Config.LastBackPressed then

					if InputHelper.KeyboardToString[ModConfigMenu.Config.LastBackPressed] then
						goBackString = InputHelper.KeyboardToString[ModConfigMenu.Config.LastBackPressed]
					end

				end

				local keepSettingString = ""
				if currentValue > -2 then

					local currentSettingString = nil
					if currentValue == -1 then
						currentSettingString = "(Disabled)"
					end
					if InputHelper.KeyboardToString[currentValue] then
						currentSettingString = InputHelper.KeyboardToString[currentValue]
					end

					keepSettingString = "This setting is currently set to \"" .. currentSettingString .. "\".$newlinePress this button to keep it unchanged.$newline$newline"

				end

				local deviceString = ""
				deviceString = "keyboard"

				return "Press a button on your " .. deviceString .. " to change this setting.$newline$newline" .. keepSettingString .. "Press \"" .. goBackString .. "\" to go back and clear this setting."

			end,
			PopupGfx = ModConfigMenu.PopupGfx.WIDE_SMALL,
			PopupWidth = 280,
			OnChange = function(current)
				if current then
					wakaba.state.options.vintagetriggerkey = current
				end
			end,
			Info = {
				"Press to activate Vintage Threat immediately(Default = O key)",
			}
		}
	)

	MCM.AddSpace("Pudding & Wakaba", "Items")
	MCM.AddText("Pudding & Wakaba", "Items", function() return "Starting Items" end)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Items",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.lostuniform
			end,
			Minimum = 0,
			Maximum = 100,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.lostuniform then
					onOff = "True"
				end
				return "T.Lost - Wakaba's Uniform: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.lostuniform = currentBool

			end,
			Info = {
				"Change behavior whether Tainted Lost's Starting Item",
				"Unlocked after completing 'Draw Five'",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Items",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.edensticky
			end,
			Minimum = 0,
			Maximum = 100,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.edensticky then
					onOff = "True"
				end
				return "T.Eden - Sticky Note: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.edensticky = currentBool

			end,
			Info = {
				"Change behavior whether Tainted Eden's Starting Item",
				"Unlocked after completing 'Hyper Random'",
			}
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "Items")

	---------------------------------------------------------------------------
	---------------------------------Found HUD---------------------------------

	local OptionNames_HitCounter = {"Off", "Penalties only", "All hits"}
	MCM.AddSetting(
		"Pudding & Wakaba",
		"HUD",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.hudhitcounter
			end,
			Minimum = 0,
			Maximum = 2,
			Display = function()
				return "Hit Counter: " .. OptionNames_HitCounter[wakaba.state.options.hudhitcounter+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.options.hudhitcounter = currentNum

			end,
			Info = {
				"Shows hit counter from HUD."
			}
		}
	)

	local OptionNames_RoomNumber = {"Off", "Value only", "Detailed", "Combined with name"}
	MCM.AddSetting(
		"Pudding & Wakaba",
		"HUD",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.hudroomnumber
			end,
			Minimum = 0,
			Maximum = 3,
			Display = function()
				return "Room Number: " .. OptionNames_RoomNumber[wakaba.state.options.hudroomnumber+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.options.hudroomnumber = currentNum

			end,
			Info = {
				"Shows Room Number from HUD."
			}
		}
	)

	local OptionNames_RoomNames = {"Off", "Name Scroll", "Full Name", "Detailed"}
	MCM.AddSetting(
		"Pudding & Wakaba",
		"HUD",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.hudroomname
			end,
			Minimum = 0,
			Maximum = 3,
			Display = function()
				return "Room Name: " .. OptionNames_RoomNames[wakaba.state.options.hudroomname+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.options.hudroomname = currentNum

			end,
			Info = {
				"Shows Room Name from HUD."
			}
		}
	)

	local OptionNames_RoomDiff = {"Off", "Value only", "Detailed", "Combined with Weight"}
	MCM.AddSetting(
		"Pudding & Wakaba",
		"HUD",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.hudroomdiff
			end,
			Minimum = 0,
			Maximum = 3,
			Display = function()
				return "Room Difficulty: " .. OptionNames_RoomDiff[wakaba.state.options.hudroomdiff+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.options.hudroomdiff = currentNum

			end,
			Info = {
				"Shows Room Difficulty from HUD."
			}
		}
	)

	local OptionNames_RoomWeight = {"Off", "Value only", "Detailed"}
	MCM.AddSetting(
		"Pudding & Wakaba",
		"HUD",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.hudroomweight
			end,
			Minimum = 0,
			Maximum = 2,
			Display = function()
				return "Room Weight: " .. OptionNames_RoomNumber[wakaba.state.options.hudroomweight+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.options.hudroomweight = currentNum

			end,
			Info = {
				"Shows Room Weight from HUD."
			}
		}
	)


	---------------------------------------------------------------------------
	------------------------------------Curses---------------------------------

	MCM.UpdateSubcategory("Pudding & Wakaba", "Curses", {
		Info = ""
	})
	MCM.AddText("Pudding & Wakaba", "Curses", function() return "Curse of Flames" end)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Curses",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.flamesoverride
			end,
			Minimum = 0,
			Maximum = 100,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.flamesoverride then
					onOff = "True"
				end
				return "Override Curse: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.flamesoverride = currentBool

			end,
			Info = {
				"Choose whether Curse of Flames priotizes over other curses",
			}
		}
	)

	MCM.AddSetting(
		"Pudding & Wakaba",
		"Curses",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.flamescurserate
			end,
			Minimum = 0,
			Maximum = 1800,
			ModifyBy = 25,
			Display = function()
				local rate = wakaba.state.options.flamescurserate
				local effectiverate = 0
				if wakaba.state.options.flamesoverride == true then
					effectiverate = wakaba.state.options.flamescurserate / 6
				else
					effectiverate = wakaba.state.options.flamescurserate / (3 * (LevelCurse.NUM_CURSES - 3))
				end
				if effectiverate > 100 then effectiverate = 100 end
				return "Curse Rate: " .. rate .. " (" .. (math.floor(effectiverate * 100) / 100) .. "%)"
			end,
			OnChange = function(currentNum)
				wakaba.state.options.flamescurserate = currentNum

			end,
			Info = {
				"Sets rate of getting Curse of Flames",
			}
		}
	)



	---------------------------------------------------------------------------
	-----------------------------------ForceVoid-------------------------------

	-- Persistent Settings - ForceVoid
	--[[
		mom - Drop The Fool/Telepills after beating Mom.
		beast - Drop Bring me there trinket at starting room of Mines II/Mausoelum I
		keypiece - Drop Key Pieces after beating Chest/Dark Room
		knifepiece - Drop Knife Pieces after beating Mom in Mausoleum/Gehenna II

		isaacsatan, bblamb, megasatan, mother, delirium
		0 : nothing, 1 : to spawn void portal, 2 : to spawn R Key
	wakaba.forcevoiddefaults = {
		beast = 1,
		mom = 1,
		keypiece = 1,
		knifepiece = 1,
		isaacsatan = 1,
		bblamb = 1,
		megasatan = 0,
		mother = 2,
		delirium = 2,
	}
	]]
	MCM.UpdateSubcategory("Pudding & Wakaba", "ForceVoid", {
		Info = ""
	})
	-- Fool Card from Mom
	local momName = {"Don't drop", "Drop Fool Card/Telepills"}
	local mausoleumMomName = {"Don't drop", "Drop Knife Pieces"}
	local keyPieceName = {"Don't drop", "Drop Key Pieces"}
	local beastName = {"Don't drop", "Drop Trinket at Start Room"}
	local crackedKeyName = {"Don't drop", "Drop Key at Start Room"}

	local forceVoidName = {"Normal", "Force open Void Portal", "Drop R Key", "Sheol/Cathedral passage"}
	local deliName = {"Normal", "Drop R Key"}
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.forcevoid.mom
			end,
			Minimum = 0,
			Maximum = 1,
			Display = function()
				return "Mom General: " .. momName[wakaba.state.forcevoid.mom+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.mom = currentNum

			end,
			Info = {
				"Change Behavior when Mom is defeated"
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.forcevoid.keypiece
			end,
			Minimum = 0,
			Maximum = 1,
			Display = function()
				return "Key Pieces: " .. keyPieceName[wakaba.state.forcevoid.keypiece+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.keypiece = currentNum

			end,
			Info = {
				"Change setting for Key Pieces when defeating ??? or The Lamb",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.forcevoid.knifepiece
			end,
			Minimum = 0,
			Maximum = 1,
			Display = function()
				return "Mausoleum Mom: " .. mausoleumMomName[wakaba.state.forcevoid.knifepiece+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.knifepiece = currentNum

			end,
			Info = {
				"Change setting for Knife Pieces when Mom from Alt path is defeated",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.forcevoid.beast
			end,
			Minimum = 0,
			Maximum = 1,
			Display = function()
				return "Dad's Note: " .. beastName[wakaba.state.forcevoid.beast+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.beast = currentNum

			end,
			Info = {
				"Change Behavior when entering Mausoleum I",
				"Entering Mausoleum II while holding the trinket will replace Mom to Dad's Note.",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.forcevoid.crackedkey
			end,
			Minimum = 0,
			Maximum = 1,
			Display = function()
				return "Cracked Key: " .. crackedKeyName[wakaba.state.forcevoid.crackedkey+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.crackedkey = currentNum

			end,
			Info = {
				"Change Behavior when entering Home",
				"Entering Home removes Little Baggy and drops Cracked Key.",
			}
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "ForceVoid")
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.forcevoid.isaacsatan
			end,
			Minimum = 0,
			Maximum = 2,
			Display = function()
				return "Isaac/Satan: " .. forceVoidName[wakaba.state.forcevoid.isaacsatan+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.isaacsatan = currentNum

			end,
			Info = {
				"Change Behavior when Isaac/Satan is Defeated",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.forcevoid.bblamb
			end,
			Minimum = 0,
			Maximum = 2,
			Display = function()
				return "???/Lamb: " .. forceVoidName[wakaba.state.forcevoid.bblamb+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.bblamb = currentNum

			end,
			Info = {
				"Change Behavior when ???/The Lamb is Defeated",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.forcevoid.megasatan
			end,
			Minimum = 0,
			Maximum = 2,
			Display = function()
				return "Mega Satan: " .. forceVoidName[wakaba.state.forcevoid.megasatan+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.megasatan = currentNum

			end,
			Info = {
				"Change Behavior when Mega Satan is Defeated",
				"Use with caution!",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.forcevoid.mother
			end,
			Minimum = 0,
			Maximum = 3,
			Display = function()
				return "Mother: " .. forceVoidName[wakaba.state.forcevoid.mother+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.mother = currentNum

			end,
			Info = {
				"Change Behavior when Mother is Defeated",
				"Use with caution!",
			}
		}
	)
	local deli = {0,2}
	MCM.AddSetting(
		"Pudding & Wakaba",
		"ForceVoid",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(deli, wakaba.state.forcevoid.delirium)
			end,
			Minimum = 1,
			Maximum = 2,
			Display = function()
				return "Delirium: " .. forceVoidName[wakaba.state.forcevoid.delirium+1]
			end,
			OnChange = function(currentNum)
				wakaba.state.forcevoid.delirium = deli[currentNum]

			end,
			Info = {
				"Change Behavior when Delirium is Defeated",
			}
		}
	)


	---------------------------------------------------------------------------
	-------------------------------Wakaba Settings-----------------------------

	MCM.UpdateSubcategory("Pudding & Wakaba", "Wakaba", {
		Info = "Settings for Wakaba"
	})
	MCM.AddText("Pudding & Wakaba", "Wakaba", function() return "Wakaba Settings" end)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Wakaba",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.startingroomindexed
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.startingroomindexed then
					onOff = "True"
				end
				return "Ignore Starting room: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.startingroomindexed = currentBool

			end,
			Info = {
				"Change behavior whether Wakaba Duality ignore Starting Room",
			}
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "Wakaba")
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Wakaba",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.firsttreasureroomindexed
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.firsttreasureroomindexed then
					onOff = "True"
				end
				return "Ignore First Treasure room: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.firsttreasureroomindexed = currentBool

			end,
			Info = {
				"Change behavior whether Wakaba Duality ignore First Treasure Room",
			}
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "Wakaba")
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Wakaba",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.blessnemesisindexed
			end,
			Display = function()
				local onOff = "True"
				if wakaba.state.options.blessnemesisindexed then
					onOff = "False"
				end
				return "Remove Index: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.blessnemesisindexed = currentBool

			end,
			Info = {
				"Change behavior whether Wakaba Duality to apply remove index ability",
				"Wakaba can take all selection items when index is removed.",
			}
		}
	)
	MCM.AddSetting("Pudding & Wakaba", "Wakaba",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			Minimum = 0,
			Maximum = 100,
			ModifyBy = 0.5,
			CurrentSetting = function() return wakaba.state.options.cloverchestchance end,
			Display = function() return "Clover Chest Chance: " .. wakaba.state.options.cloverchestchance .. "%" end,
			OnChange = function(currentNum) wakaba.state.options.cloverchestchance = currentNum end,
			Info = { "Spawn rate for Clover Chest (Default = "..wakaba.optiondefaults.cloverchestchance..")", "Does not affect Book of Shiori valuts"}
		}
	)
	--[[ MCM.AddSpace("Pudding & Wakaba", "Wakaba")
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Wakaba",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.blessnemesisqualityignore
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.blessnemesisqualityignore then
					onOff = "True"
				end
				return "Ignore Quality Check: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.blessnemesisqualityignore = currentBool
			end,
			Info = {
				"Change behavior whether Wakaba's Blessing/Nemesis to ignore item qualities",
				"Eat Heart still checks item quality",
			}
		}
	) ]]
	MCM.AddSpace("Pudding & Wakaba", "Wakaba")

	if wakaba.state.unlock.doubledreams then

	end
--[[
	if Poglite then
		MCM.AddSetting(
			"Pudding & Wakaba",
			"Wakaba",
			{
				Type = ModConfigMenu.OptionType.BOOLEAN,
				CurrentSetting = function()
					return wakaba.state.pog
				end,
				Display = function()
					local onOff = "Original"
					if wakaba.state.pog then
						onOff = "Wakaba"
					end
					return 'POG Type: ' .. onOff
				end,
				OnChange = function(currentBool)
					wakaba.state.pog = currentBool
				end,
				Info = {"Choose whether POG to be selected. Only works when 'POG for Good Items' Mod is active. Changes will be applied in next game startup."}
			}
		)
	end
	]]
	---------------------------------------------------------------------------
	-----------------------------  Shiori Settings  ---------------------------

	MCM.UpdateSubcategory("Pudding & Wakaba", "Shiori", {
		Info = "Settings for Shiori"
	})

	MCM.AddText("Pudding & Wakaba", "Shiori", function() return "Shiori Mode only changes" end)
	MCM.AddText("Pudding & Wakaba", "Shiori", function() return "when new run is started" end)
	MCM.AddSpace("Pudding & Wakaba", "Shiori")
	MCM.AddText("Pudding & Wakaba", "Shiori", function() return "Shiori Modes" end)

	MCM.AddSetting(
		"Pudding & Wakaba",
		"Shiori",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.shiorimodes
			end,
			Minimum = 0,
			Maximum = wakaba.shiorimodes.NUM_SHIORI_MAX,
			Display = function()
				return "Mode: " .. wakaba.shiorimodestrings[wakaba.state.options.shiorimodes].name .. ""
			end,
			OnChange = function(currentNum)
				wakaba.state.options.shiorimodes = currentNum

			end,
			Info = function()
				local st = wakaba.shiorimodestrings[wakaba.state.options.shiorimodes].configdesc
				return st
			end,
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "Shiori")
	MCM.AddText("Pudding & Wakaba", "Shiori", function() return "Akasic Record Settings" end)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Shiori",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.shioriakasicbooks
			end,
			Minimum = 1,
			Maximum = 10,
			Display = function()
				return "Books per floor: " .. wakaba.state.options.shioriakasicbooks .. ""
			end,
			OnChange = function(currentNum)
				wakaba.state.options.shioriakasicbooks = currentNum

			end,
			Info = {
				"Number of books Shiori can start each floor (Default = 3)",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Shiori",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.shioriakasicminquality
			end,
			Minimum = 0,
			Maximum = 4,
			Display = function()
				return "Minimum quality: " .. wakaba.state.options.shioriakasicminquality .. ""
			end,
			OnChange = function(currentNum)
				wakaba.state.options.shioriakasicminquality = currentNum
				if wakaba.state.options.shioriakasicminquality > wakaba.state.options.shioriakasicmaxquality then
					wakaba.state.options.shioriakasicmaxquality = wakaba.state.options.shioriakasicminquality
				end

			end,
			Info = {
				"Minimum quality for books (Default = 0)",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Shiori",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.shioriakasicmaxquality
			end,
			Minimum = 0,
			Maximum = 4,
			Display = function()
				return "Minimum quality: " .. wakaba.state.options.shioriakasicmaxquality .. ""
			end,
			OnChange = function(currentNum)
				wakaba.state.options.shioriakasicmaxquality = currentNum
				if wakaba.state.options.shioriakasicminquality > wakaba.state.options.shioriakasicmaxquality then
					wakaba.state.options.shioriakasicminquality = wakaba.state.options.shioriakasicmaxquality
				end

			end,
			Info = {
				"Maximum quality for books (Default = 4)",
			}
		}
	)


	MCM.AddSpace("Pudding & Wakaba", "Shiori")
	MCM.AddText("Pudding & Wakaba", "Shiori", function() return "Shiori Settings" end)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Shiori",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return wakaba.state.options.shiorikeychance
			end,
			Minimum = 0,
			Maximum = 100,
			Display = function()
				return "Default Key Drop Chance: " .. wakaba.state.options.shiorikeychance .. "%"
			end,
			OnChange = function(currentNum)
				wakaba.state.options.shiorikeychance = currentNum

			end,
			Info = {
				"Drop rate for Keys when pickup is appeared or Room clear (Default = 50)",
			}
		}
	)
	MCM.AddSetting("Pudding & Wakaba", "Shiori",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			Minimum = 0,
			Maximum = 100,
			ModifyBy = 0.5,
			CurrentSetting = function() return wakaba.state.options.valutchance end,
			Display = function() return "Shiori's Valut Chance: " .. wakaba.state.options.valutchance .. "%" end,
			OnChange = function(currentNum) wakaba.state.options.valutchance = currentNum end,
			Info = { "Spawn rate for Shiori's Valut (Default = "..wakaba.optiondefaults.valutchance..")", }
		}
	)
	---------------------------------------------------------------------------
	-----------------------------  Tsukasa Settings  ---------------------------

	MCM.UpdateSubcategory("Pudding & Wakaba", "Tsukasa", {
		Info = "Settings for Tsukasa"
	})

	MCM.AddText("Pudding & Wakaba", "Tsukasa", function() return "Tsukasa Settings" end)
	MCM.AddSpace("Pudding & Wakaba", "Tsukasa")
	MCM.AddText("Pudding & Wakaba", "Tsukasa", function() return "Concentration key :" end)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Tsukasa",
		{
			Type = ModConfigMenu.OptionType.KEYBIND_KEYBOARD,
			CurrentSetting = function()
				return wakaba.state.options.concentrationkeyboard
			end,
			Display = function()
				local currentValue = wakaba.state.options.concentrationkeyboard
				local displayString = "Keyboard : "
				local key = "None"
				if currentValue > -1 then
					key = "Unknown Key"
					if InputHelper.KeyboardToString[currentValue] then
						key = InputHelper.KeyboardToString[currentValue]
					end
				end
				displayString = displayString .. key
				return displayString
			end,
			Popup = function()

				local currentValue = wakaba.state.options.concentrationkeyboard

				local goBackString = "back"
				if ModConfigMenu.Config.LastBackPressed then

					if InputHelper.KeyboardToString[ModConfigMenu.Config.LastBackPressed] then
						goBackString = InputHelper.KeyboardToString[ModConfigMenu.Config.LastBackPressed]
					end

				end

				local keepSettingString = ""
				if currentValue > -1 then

					local currentSettingString = nil
					if InputHelper.KeyboardToString[currentValue] then
						currentSettingString = InputHelper.KeyboardToString[currentValue]
					end

					keepSettingString = "This setting is currently set to \"" .. currentSettingString .. "\".$newlinePress this button to keep it unchanged.$newline$newline"

				end

				local deviceString = ""
				deviceString = "keyboard"

				return "Press a button on your " .. deviceString .. " to change this setting.$newline$newline" .. keepSettingString .. "Press \"" .. goBackString .. "\" to go back and clear this setting."

			end,
			PopupGfx = ModConfigMenu.PopupGfx.WIDE_SMALL,
			PopupWidth = 280,
			OnChange = function(current)
				if current then
					wakaba.state.options.concentrationkeyboard = current

				end
			end,
			Info = {
				"Hold to enter Concentration mode for Tsukasa/Concnetration(Default = Left Ctrl key)",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Tsukasa",
		{
			Type = ModConfigMenu.OptionType.KEYBIND_CONTROLLER,
			CurrentSetting = function()
				return wakaba.state.options.concentrationcontroller
			end,
			Display = function()
				local currentValue = wakaba.state.options.concentrationcontroller
				local displayString = "Controller : "
				local key = "None"
				if currentValue > -1 then
					key = "Unknown Button"
					if InputHelper.ControllerToString[currentValue] then
						key = InputHelper.ControllerToString[currentValue]
					end
				end
				displayString = displayString .. key
				return displayString
			end,
			Popup = function()

				local currentValue = wakaba.state.options.concentrationcontroller

				local goBackString = "back"
				if ModConfigMenu.Config.LastBackPressed then

					if InputHelper.KeyboardToString[ModConfigMenu.Config.LastBackPressed] then
						goBackString = InputHelper.KeyboardToString[ModConfigMenu.Config.LastBackPressed]
					elseif InputHelper.ControllerToString[ModConfigMenu.Config.LastBackPressed] then
						goBackString = InputHelper.ControllerToString[ModConfigMenu.Config.LastBackPressed]
					end

				end

				local keepSettingString = ""
				if currentValue > -1 then

					local currentSettingString = nil
					if InputHelper.ControllerToString[currentValue] then
						currentSettingString = InputHelper.ControllerToString[currentValue]
					end

					keepSettingString = "This setting is currently set to \"" .. currentSettingString .. "\".$newlinePress this button to keep it unchanged.$newline$newline"

				end

				local deviceString = "controller"

				return "Press a button on your " .. deviceString .. " to change this setting.$newline$newline" .. keepSettingString .. "Press \"" .. goBackString .. "\" to go back and clear this setting."

			end,
			PopupGfx = ModConfigMenu.PopupGfx.WIDE_SMALL,
			PopupWidth = 280,
			OnChange = function(current)
				if current then
					wakaba.state.options.concentrationcontroller = current

				end
			end,
			Info = {
				"Hold to enter Concentration mode for Tsukasa/Concnetration(Default = Drop button)",
			}
		}
	)
	MCM.AddSpace("Pudding & Wakaba", "Tsukasa")
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Tsukasa",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.lunarpercent
			end,
			Display = function()
				local onOff = "Hide"
				if wakaba.state.options.lunarpercent then
					onOff = "Show"
				end
				return "Lunar Stone Percent: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.lunarpercent = currentBool

			end,
			Info = {
				"Change behavior whether Lunar Stone percent displayed next to charge bar",
				"Percent display only shows when Charge Bars in Isaac options is enabled.",
			}
		}
	)
	MCM.AddSetting("Pudding & Wakaba", "Tsukasa",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			Minimum = 0,
			Maximum = 100,
			ModifyBy = 0.5,
			CurrentSetting = function() return wakaba.state.options.eastereggchance end,
			Display = function() return "Easter Egg Chance: " .. wakaba.state.options.eastereggchance .. "%" end,
			OnChange = function(currentNum) wakaba.state.options.eastereggchance = currentNum end,
			Info = { "Spawn rate for Easter Egg coins (Default = "..wakaba.optiondefaults.eastereggchance..")", }
		}
	)
	---------------------------------------------------------------------------
	-----------------------------  Richer Settings  ---------------------------
	MCM.UpdateSubcategory("Pudding & Wakaba", "Richer", {
		Info = "Settings for Richer"
	})

	MCM.AddText("Pudding & Wakaba", "Richer", function() return "Richer Settings" end)
	MCM.AddSpace("Pudding & Wakaba", "Richer")
	MCM.AddSetting("Pudding & Wakaba", "Richer",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			Minimum = 0,
			Maximum = 100,
			ModifyBy = 0.5,
			CurrentSetting = function() return wakaba.state.options.crystalrestockchance end,
			Display = function() return "Crystal Restock Chance: " .. wakaba.state.options.crystalrestockchance .. "%" end,
			OnChange = function(currentNum) wakaba.state.options.crystalrestockchance = currentNum end,
			Info = { "Spawn rate for Crystal Restock (Default = "..wakaba.optiondefaults.crystalrestockchance..")", "Does not affect Albiero/Prestige restocks"}
		}
	)
	---------------------------------------------------------------------------
	-----------------------------  Rira Settings  ---------------------------
	MCM.UpdateSubcategory("Pudding & Wakaba", "Rira", {
		Info = "Settings for Rira"
	})

	MCM.AddText("Pudding & Wakaba", "Rira", function() return "Rira Settings" end)
	MCM.AddSpace("Pudding & Wakaba", "Rira")
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Rira",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.rirastatswap
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.rirastatswap then
					onOff = "True"
				end
				return "Stat Swap: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.rirastatswap = currentBool
				wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
					if player:GetPlayerType() == wakaba.Enums.Players.RIRA then
						player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
						player:EvaluateItems()
					end
				end)
			end,
			Info = {
				"Adds Tears mult x1/3 and Damage mult x3 for Rira",
				"This can be helpful by reducing tears count that causes lags",
				"Always active in Lunatic mode",
			}
		}
	)
	MCM.AddSetting(
		"Pudding & Wakaba",
		"Rira",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return wakaba.state.options.chimakisound
			end,
			Display = function()
				local onOff = "False"
				if wakaba.state.options.chimakisound then
					onOff = "True"
				end
				return "Chimaki Sound: " .. onOff
			end,
			OnChange = function(currentBool)
				wakaba.state.options.chimakisound = currentBool

			end,
			Info = {
				"Allow Chimaki 'kyuu' sound",
			}
		}
	)

end
