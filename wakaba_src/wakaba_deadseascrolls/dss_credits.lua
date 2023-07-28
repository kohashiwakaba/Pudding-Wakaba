local wakabadirectory = wakaba.DSS_DIRECTORY
local dssmod = wakaba.DSS_MOD

local credits = {
	"general mod development",
	{"kohashiwahaba",				""},
	"original character desingers",
	{"wakaba",				"hara yui"},
	{"shiori",				"wakagi tamaki"},
	{"tsukasa",				"hata kenjiro"},
	{"richer",				"miysaska miyu"},
	"special thanks",
	{"_kilburn",				"various snippets"},
	{"xalum",				"various snippets"},
	{"",				"majority of functions from retribution"},
	{"zamiel",				"isaacscript"},
	{"agentcucco",				"various snippets"},
	{"",				"achievement api"},
	{"",				"damocles api"},
	{"deadinfinity",				"various snippets"},
	--{"",				"dss achievement viewer"},
	{"mana",				"item reroll snippet"},
	{"meloonicscorp",				""},
	{"",				"glitched item snippet"},
	{"neodement",				"various snippets"},
	{"im_tem",				"pseudo-lilith birthright"},
	{"wofsauge",				"eid"},
	{"",				"pseudo-dark arts trail"},
	{"cadever mod",				"various snippets"},
	{"connor",				"hidden item manager"},
	{"bogdanrudyka",				"custom callbacks"},
	{"nfrost",				"charge meter library"},
	{"sanio",				""},
	{"",				"character costume protector"},
	{"iristeru",				""},
	{"",				"base frame for character sprites"},
	"",
	{"you", "playing the mod"}
}

wakabadirectory.credits = {
	format = {
		Panels = {
			{
				Panel = dssmod.panels.main,
				Offset = Vector(12, 10),
				Color = 1
			}
		}
	},
	fsize = 1,
	generate = function()
	end,
	gridx = maxCol,
	buttons = {}
}

for _, credit in ipairs(credits) do
	if type(credit) == "string" then
		wakabadirectory.credits.buttons[#wakabadirectory.credits.buttons + 1] = {str = credit, nosel = true}
	else
		for i, part in ipairs(credit) do
			if i ~= 1 then
				if i == 2 then
					local button = {strpair = {{str = credit[1]}, {str = part}}}
					if credit[1] == "" then button.nosel = true end
					if credit.tooltip then
						if type(credit.tooltip) == "string" then
							credit.tooltip = {credit.tooltip}
						end
						button.tooltip = {strset = credit.tooltip}
					end
					wakabadirectory.credits.buttons[#wakabadirectory.credits.buttons + 1] = button
				else
					wakabadirectory.credits.buttons[#wakabadirectory.credits.buttons + 1] = {strpair = {{str = ''}, {str = part}}, nosel = true}
				end
			end
		end
	end
end