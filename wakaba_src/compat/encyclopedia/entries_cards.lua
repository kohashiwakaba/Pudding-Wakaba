local c = wakaba.Enums.Cards

wakaba.encyclopediadesc.desc.cards = {
	--#region Wakaba Tickets
	[c.CARD_CRANE_CARD] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a crane game machine."},
		},
	},
	[c.CARD_CONFESSIONAL_CARD] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a confessional booth."},
		},
	},
	[c.CARD_VALUT_RIFT] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a Shiori's valut."},
			{str = "Shiori's valut contains a collectible item that costs 12 keys to open."},
		},
	},
	[c.CARD_UNKNOWN_BOOKMARK] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Activates random book active item. The effect is pretty much same as 'Maijima Mythology' active item"},
			{str = "Modded items will also be activated if the active item has 'book' tag and hidden flag is not set."},
			{str = "Following items are blacklisted and will not be activated:"},
			{str = "- How to Jump"},
			{str = "- Wakaba's Double Dreams"},
			{str = "- Book of Virtues: This item counts as passive item, thus will not be activated."},
		},
	},
	[c.CARD_MINERVA_TICKET] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Activates Minerva's Aura for current room."},
		},
	},
	[c.CARD_RICHER_TICKET] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, Gives Isaac one of known combinations or synergies. The effect is pretty much same as 'Sweets Catalog' active item"},
		},
	},
	[c.CARD_RIRA_TICKET] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Recovers 1 Broken Heart."},
			{str = "- Recovered Broken Heart will be turned into Soul or Bone Heart depending of Isaac's status"},
			{str = "- Smelt current held trinkets."},
			{str = "- Heals 1 Red Heart if Isaac does not have any trinkets and Broken Hearts."},
		},
	},
	--[c.CARD_RURI_TICKET] = {}, -- Ruri Ticket
	--#endregion

	--#region Soul Stones
	[c.SOUL_WAKABA] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+1 Soul Heart."},
			{str = "Generates Angel Room in current floor."},
			{str = "If there are no rooms to add, spawns a random Angel pool item."},
			{str = "In The Beast battle, Isaac will be granted a random Angel pool item directly."},
		},
	},
	[c.SOUL_WAKABA2] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+1 Soul Heart."},
			{str = "Generates Devil Room in current floor."},
			{str = "If there are no rooms to add, spawns a random Devil pool item."},
			{str = "In The Beast battle, Isaac will be granted a random Devil pool item directly."},
		},},
	[c.SOUL_SHIORI] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Heals 2 Red Hearts."},
			{str = "Activates Random Book of Shiori tear effect."},
			{str = "Random Book of Shiori tear effect granted by this card persist through entire run unless Isaac uses the book with Book of Shiori."},
		},},
	[c.SOUL_TSUKASA] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, summons a sword that hangs directly above Isaac."},
			{str = "As long as the sword hangs above Isaac, all item pedestals are doubled, spawning an additional free item next to them."},
			{str = "After Isaac gets hit once with the item activated, at any time with only a brief warning, the sword may fall."},
			{str = "Sword does half heart damage to Isaac, but Removes half of Isaac's items."},
			{str = "Invincibilty does NOT protect damage against this."},
			{str = "The sword has a 1/2500 chance every 4 frames to fall."},
			{str = "Taking self-damage does not count as damage taken for blue sword, and will not give it the chance to fall."},
			{str = "Using Soul of Tsukasa while blue sword is active reduces chance to fall."},
		},
	},
	[c.SOUL_RICHER] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns 6 Lemegeton Wisps."},
			{str = "All items spawned are guaranteed for at least Quality 2."},
		},
	},
	[c.SOUL_RIRA] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns 3 Aqua trinkets."},
			{str = "- Aqua trinkets spawned this way ignores unlock status."},
			{str = "Aqua trinkets are special trinket that immediately absorbed on pickup."},
		},
	},
--#endregion

	--#region Misc Cards
	[c.CARD_BLACK_JOKER] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While held, prevents Angel rooms to be spawned."},
			{str = "Upon use, Teleports the player to the Devil room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The effect of Black Joker counts as holding Wakaba's Nemesis."},
			{str = "- Angel Rooms will no longer appear unless Isaac has Duality, Wakaba's Blessing, Murasame or White Joker."},
			{str = "- Angel Rooms will not appear even when using Sacrifice Room or Confessional."},
		},
	},
	[c.CARD_WHITE_JOKER] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While held, prevents Devil rooms to be spawned."},
			{str = "Upon use, Teleports the player to the Angel room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The effect of White Joker counts as holding Wakaba's Blessing."},
			{str = "- Devil Rooms will no longer appear unless Isaac has Duality, Wakaba's Nemesis, or Black Joker."},
		},
	},
	[c.CARD_COLOR_JOKER] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Sets Broken Heart counts to 6."},
			{str = "- For characters that have less heart limit, sets broken heart counts to half of their initial heart limit."},
			{str = "Spawns 3 Collectible items and 8 Card/Rune/Soul Stones."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Color Joker is inspired from certain card game called 'Onecard', was popular among old korean teenagers using generic Playing cards. which was the counterpart of 'UNO'."},
			{str = "In OneCard, there are so many similarities share with UNO, Some are identical, and some are more powerful than UNO."},
			{str = "There are no counterparts of this card in UNO, as 'Wild +4 card', or '+5 Card' from 'UNO Flip' is considered as the counterpart of 'Black Joker' in Onecard, which is far weaker version of Color Joker."},
			{str = "- Color Joker in Onecard makes next person to force draw at least 8 cards (Simply 'Wild +8 Card'), while Black Joker only draws 5."},
		},
	},
	[c.CARD_DREAM_CARD] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns random collectible item."},
		},
	},
	[c.CARD_QUEEN_OF_SPADES] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns 3 ~ 26 Keys."},
		},
	},
	[c.CARD_FLIP] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While holding Flip card, when Isaac enters a new room containing an item (Treasure Room, Shop, etc.), the item pedestal will have a second 'ghostly' item behind it."},
			{str = "- The real item can be interacted with normally, while the ghostly item cannot."},
			{str = "- The ghostly item will vanish if there is no real item on the pedestal and Isaac leaves the room."},
			{str = "Upon use, flips all real / ghostly items around on pedestals, allowing Isaac to collect the ghostly items. Does not affect pedestals that do not contain a ghostly item."},
			{str = "If playing as Tainted Lazarus, activating it also flips between them and Dead Tainted Lazarus."},
		},
	},
	--#endregion

	--#region Objects
	[c.CARD_RETURN_TOKEN] = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Invokes R Key Effect."},
			{str = "Also resets game timer."},
			{str = "Removes all of Isaac's health, consumables, card/pills, and trinkets."},
		},
	},
	--#endregion

	--#region
	--#endregion

}