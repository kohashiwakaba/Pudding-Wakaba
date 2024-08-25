return {
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
}