
wakaba.pickupAnimFrames = {
	[wakaba.Enums.Pickups.CLOVER_CHEST] = 0,
}
wakaba.curseAnimFrames = {
	[wakaba.curses.CURSE_OF_FLAMES] = 0,
	[wakaba.curses.CURSE_OF_SATYR] = 1,
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