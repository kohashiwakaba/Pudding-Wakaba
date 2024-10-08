local conv = {
	[wakaba.Enums.Players.WAKABA] = "gfx/ui/wakaba/charactermenu_kr.png",
	[wakaba.Enums.Players.SHIORI] = "gfx/ui/wakaba/charactermenu_kr.png",
	[wakaba.Enums.Players.TSUKASA] = "gfx/ui/wakaba/charactermenu_kr.png",
	[wakaba.Enums.Players.RICHER] = "gfx/ui/wakaba/charactermenu_kr.png",
	[wakaba.Enums.Players.RIRA] = "gfx/ui/wakaba/charactermenu_kr.png",
	[wakaba.Enums.Players.WAKABA_B] = "gfx/ui/wakaba/charactermenualt_kr.png",
	[wakaba.Enums.Players.SHIORI_B] = "gfx/ui/wakaba/charactermenualt_kr.png",
	[wakaba.Enums.Players.TSUKASA_B] = "gfx/ui/wakaba/charactermenualt_kr.png",
	[wakaba.Enums.Players.RICHER_B] = "gfx/ui/wakaba/charactermenualt_kr.png",
	[wakaba.Enums.Players.RIRA_B] = "gfx/ui/wakaba/charactermenualt_kr.png",
}

local conv2 = {
	[wakaba.Enums.Players.WAKABA] = "gfx/ui/wakaba/charactermenu_kr.anm2",
	[wakaba.Enums.Players.SHIORI] = "gfx/ui/wakaba/charactermenu_kr.anm2",
	[wakaba.Enums.Players.TSUKASA] = "gfx/ui/wakaba/charactermenu_kr.anm2",
	[wakaba.Enums.Players.RICHER] = "gfx/ui/wakaba/charactermenu_kr.anm2",
	[wakaba.Enums.Players.RIRA] = "gfx/ui/wakaba/charactermenu_kr.anm2",
	[wakaba.Enums.Players.WAKABA_B] = "gfx/ui/wakaba/charactermenualt_kr.anm2",
	[wakaba.Enums.Players.SHIORI_B] = "gfx/ui/wakaba/charactermenualt_kr.anm2",
	[wakaba.Enums.Players.TSUKASA_B] = "gfx/ui/wakaba/charactermenualt_kr.anm2",
	[wakaba.Enums.Players.RICHER_B] = "gfx/ui/wakaba/charactermenualt_kr.anm2",
	[wakaba.Enums.Players.RIRA_B] = "gfx/ui/wakaba/charactermenualt_kr.anm2",
}

local lastType = 0

---@param playerType PlayerType
---@param renderPos Vector
---@param sprite Sprite
function wakaba:MainMenu_CharScreen(playerType, renderPos, sprite)
	if Options.Language == "kr" then
		if conv2[playerType] then
			local anm2 = conv2[playerType]
			local s = Sprite()

			s:Load(anm2, true)
			s:Render(renderPos)
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_PRE_RENDER_CUSTOM_CHARACTER_MENU, wakaba.MainMenu_CharScreen)