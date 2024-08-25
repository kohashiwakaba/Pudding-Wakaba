return {
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
			str = 'modes',
			fsize = 2,
			choices = wakaba.shiorimodestringsdss,
			setting = wakaba.shiorimodes.SHIORI_AKASIC_RECORDS + 1,
			variable = 'ShioriModes',
			load = function()
				return wakaba.state.options.shiorimodes + 1
			end,
			store = function(var)
				wakaba.state.options.shiorimodes = var - 1
			end,
			changefunc = function(button, item)
				item.shiorimodes = button.setting - 1
			end,
			tooltip = {strset = {'sets',"shiori's",'character','mode'}}
		},
		{
				str = '',
				nosel = true,
				fsize = 1,
		},
		{
				str = '',
				nosel = true,
				fsize = 1,
		},
		{
				str = '',
				nosel = true,
				fsize = 1,
		},
		{
				str = '',
				nosel = true,
				fsize = 1,
		},
		{
			str = '', fsize = 1, nosel = true,
		},
		{
			str = 'books per floor',
			fsize = 2,
			min = 1,
			max = 10,
			increment = 1,
			setting = 3,
			variable = "ShioriAkasicBookCount",
			load = function()
				return wakaba.state.options.shioriakasicbooks or 3
			end,
			store = function(var)
				wakaba.state.options.shioriakasicbooks = var
			end,
			displayif = function(btn, item, tbl)
				return item.shiorimodes == wakaba.shiorimodes.SHIORI_AKASIC_RECORDS
			end,
			tooltip = {strset = {'number of','books','shiori can','start','each floor','','default = 3'}},
		},
		{
			str = 'minimum quality',
			fsize = 2,
			min = 0,
			max = 4,
			increment = 1,
			setting = 0,
			variable = "ShioriAkasicMinQuality",
			load = function()
				return wakaba.state.options.shioriakasicminquality or 0
			end,
			store = function(var)
				wakaba.state.options.shioriakasicminquality = var
				if wakaba.state.options.shioriakasicminquality > wakaba.state.options.shioriakasicmaxquality then
					wakaba.state.options.shioriakasicmaxquality = wakaba.state.options.shioriakasicminquality
				end
			end,
			displayif = function(btn, item, tbl)
				return item.shiorimodes == wakaba.shiorimodes.SHIORI_AKASIC_RECORDS
			end,
			tooltip = {strset = {'minimum','quality for','books','','default = 0'}},
		},
		{
			str = 'maximum quality',
			fsize = 2,
			min = 0,
			max = 4,
			increment = 1,
			setting = 4,
			variable = "ShioriAkasicMaxQuality",
			load = function()
				return wakaba.state.options.shioriakasicmaxquality or 4
			end,
			store = function(var)
				wakaba.state.options.shioriakasicmaxquality = var
				if wakaba.state.options.shioriakasicminquality > wakaba.state.options.shioriakasicmaxquality then
					wakaba.state.options.shioriakasicminquality = wakaba.state.options.shioriakasicmaxquality
				end
			end,
			displayif = function(btn, item, tbl)
				return item.shiorimodes == wakaba.shiorimodes.SHIORI_AKASIC_RECORDS
			end,
			tooltip = {strset = {'maximum','quality for','books','','default = 4'}},
		},
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
		item.shiorimodes = wakaba.state.options.shiorimodes or wakaba.shiorimodes.SHIORI_AKASIC_RECORDS
	end,
	update = function(item)
		local setting = item.shiorimodes or wakaba.shiorimodes.SHIORI_AKASIC_RECORDS
		local shioriModeStr1Index = -1
		if item and item.buttons then
			for i, button in ipairs(item.buttons) do
				if button.variable == 'ShioriModes' then
					shioriModeStr1Index = i + 1
				end
			end
		end
		if shioriModeStr1Index ~= -1 then
			if wakaba.shiorimodestrings[setting].dssdesc1 then
				item.buttons[shioriModeStr1Index].str = wakaba.shiorimodestrings[setting].dssdesc1
				item.buttons[shioriModeStr1Index].display = true
				item.buttons[shioriModeStr1Index].nosel = true
			else
				item.buttons[shioriModeStr1Index].str = ""
				item.buttons[shioriModeStr1Index].display = false
			end
			if wakaba.shiorimodestrings[setting].dssdesc2 then
				item.buttons[shioriModeStr1Index+1].str = wakaba.shiorimodestrings[setting].dssdesc2
				item.buttons[shioriModeStr1Index+1].display = true
				item.buttons[shioriModeStr1Index+1].nosel = true
			else
				item.buttons[shioriModeStr1Index+1].str = ""
				item.buttons[shioriModeStr1Index+1].display = false
			end
			if wakaba.shiorimodestrings[setting].dssdesc3 then
				item.buttons[shioriModeStr1Index+2].str = wakaba.shiorimodestrings[setting].dssdesc3
				item.buttons[shioriModeStr1Index+2].display = true
				item.buttons[shioriModeStr1Index+2].nosel = true
			else
				item.buttons[shioriModeStr1Index+2].str = ""
				item.buttons[shioriModeStr1Index+2].display = false
			end
			if wakaba.shiorimodestrings[setting].dssdesc4 then
				item.buttons[shioriModeStr1Index+3].str = wakaba.shiorimodestrings[setting].dssdesc4
				item.buttons[shioriModeStr1Index+3].display = true
				item.buttons[shioriModeStr1Index+3].nosel = true
			else
				item.buttons[shioriModeStr1Index+3].str = ""
				item.buttons[shioriModeStr1Index+3].display = false
			end
		end
	end
}