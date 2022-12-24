
wakaba.pickupAnimFrames = {
	[wakaba.Enums.Pickups.CLOVER_CHEST] = 0,
}
wakaba.curseAnimFrames = {
	[wakaba.curses.CURSE_OF_FLAMES] = 0,
	[wakaba.curses.CURSE_OF_SATYR] = 1,
	[wakaba.curses.CURSE_OF_SNIPER] = 2,
	[wakaba.curses.CURSE_OF_AMNESIA] = 3,
	[wakaba.curses.CURSE_OF_FAIRY] = 4,
	[wakaba.curses.CURSE_OF_MAGICAL_GIRL] = 5,
}

if MinimapAPI then
	--Curse of Flames render
	MinimapAPI:AddMapFlag(
	  "CurseOfFlames",
	  function()
			return wakaba.curses.CURSE_OF_FLAMES > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_FLAMES == wakaba.curses.CURSE_OF_FLAMES
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_FLAMES]
	)
	--Curse of Satyr render
	MinimapAPI:AddMapFlag(
	  "CurseOfSatyr",
	  function()
			return wakaba.curses.CURSE_OF_SATYR > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_SATYR == wakaba.curses.CURSE_OF_SATYR
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_SATYR]
	)
	--Curse of Sniper render
	MinimapAPI:AddMapFlag(
	  "CurseOfSniper",
	  function()
			return wakaba.curses.CURSE_OF_SNIPER > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_SNIPER == wakaba.curses.CURSE_OF_SNIPER
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_SNIPER]
	)
	--Curse of Amnesia render
	MinimapAPI:AddMapFlag(
	  "CurseOfAmnesia",
	  function()
			return wakaba.curses.CURSE_OF_AMNESIA > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_AMNESIA == wakaba.curses.CURSE_OF_AMNESIA
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_AMNESIA]
	)
	--Curse of Fairy render
	MinimapAPI:AddMapFlag(
	  "CurseOfFairy",
	  function()
			return wakaba.curses.CURSE_OF_FAIRY > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_FAIRY == wakaba.curses.CURSE_OF_FAIRY
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_FAIRY]
	)
	--Curse of Magical Girl render
	MinimapAPI:AddMapFlag(
	  "CurseOfMagicalGirl",
	  function()
			return wakaba.curses.CURSE_OF_MAGICAL_GIRL > LevelCurse.CURSE_OF_GIANT and wakaba.G:GetLevel():GetCurses() & wakaba.curses.CURSE_OF_MAGICAL_GIRL == wakaba.curses.CURSE_OF_MAGICAL_GIRL
		end,
	  wakaba.MiniMapAPISprite,
	  "Curses",
	  wakaba.curseAnimFrames[wakaba.curses.CURSE_OF_MAGICAL_GIRL]
	)
	--Clover Chest render
	MinimapAPI:AddIcon(
		"CloverChestIcon", 
		wakaba.MiniMapAPISprite, 
		"Pickups", 
		wakaba.pickupAnimFrames[wakaba.Enums.Pickups.CLOVER_CHEST]
	)

	MinimapAPI:AddPickup(
		"CloverChest", 
		"CloverChestIcon", 
		5, 
		wakaba.Enums.Pickups.CLOVER_CHEST, 
		wakaba.ChestSubType.CLOSED, 
		MinimapAPI.PickupChestNotCollected, 
		"chests", 
		7450
	)



end