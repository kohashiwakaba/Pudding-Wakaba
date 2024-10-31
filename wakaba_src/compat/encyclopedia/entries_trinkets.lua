local t = wakaba.Enums.Trinkets

wakaba.encyclopediadesc.desc.trinkets = {
	[t.BRING_ME_THERE] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+1.5 tears."},
			{str = "Entering the boss room of Mausoleum/Gehenna II while holding this trinket makes Dad's Note being appear instead of Mom."},
			{str = "Dropping the trinket reverts the Boss Room into Mom."},
			{str = "- This do not work when Isaac is entered Mausoleum/Gehenna II through Polaroid/Negative door."},
			{str = "- Using Forget Me Now while holding this trinket also locks the Boss room to one that holds Dad's Note."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Fiend Folio - Golem", clr = 3, halign = 0},
			{str = "Bring Me There is considered as special trinket, thus will be not converted into random stones, will be act as normal stone if interacted with Golem's unique beggars."},
		},
	},
	[t.REPORT_CARD] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+5 Luck."},
			{str = "If Isaac takes non-self damage while holding it, -0.5 Luck."},
			{str = "This penalty cannot exceed below Luck stat granted by the trinket."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This trinket is minor version of Perfection trinket, from Repentance DLC."},
		},
	},
	[t.CLOVER] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+0.3 tears"},
			{str = "Luck +2"},
			{str = "Luck Multiplier x2"},
			{str = "Luct stat will be always positive"},
			{str = "Increased chance for Lucky Pennies"},
		},
	},
	[t.BITCOIN] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Randomize consumable counters and stats constantly."},
			{str = "The range for consumables can be all back to 0 to full of 999."},
			{str = "Once the trinket has been swapped, dropped, the trinket disappears."},
			{str = "Once the trinket has been smelted, the consumables no longer shuffled."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "As consumables completely randomized, Isaac has effectively infinite bombs, keys, and coins while held."},
		},
	},
	[t.HARD_BOOK] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Chance to drop random book collectible upon getting hit"},
			{str = "Prevents single damage taken for The Lost/Tainted Lost"},
			{str = "- 100% chance to drop a book in sacrifice rooms, or playing as The Lost/Tainted Lost"},
			{str = "The trinket gets disappeared when book drop"},
		},
	},
	[t.MAGNET_HEAVEN] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Instantly teleports Bombs, Keys, and Coins to Isaac"},
			{str = "Converts Sticky Nickel into normal Nickel"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	[t.DETERMINATION_RIBBON] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "All damage taken will be reduced to half heart"},
			{str = "Doesn't kill isaac as long as the trinket is held"},
			{str = "The effect of the trinket will not work on Sacrifice rooms Spikes!"},
		},
	},
	[t.BOOKMARK_BAG] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Gives Isaac a Book item as a consumable when he enters a new room. The Book disappears when he leaves the room."},
			{str = "Also grants Isaac the ability to hold extra consumable item slot for that room, so Isaac gets a Book even if he is already holding a consumable item."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If Isaac leaves and re-enters a room, Bookmark Bag will not try to give another Book when Isaac re-enters it."},
			{str = "Any book item can be given to Isaac, including ones that haven't been unlocked yet."},
			{str = "Bookmark Bag also can give modded items if the item counts toward bookworm transformation."},
			{str = "Bookmark Bag cannot give Hidden, or blacklisted items."},
			{str = "Dropping the trinket on the ground does not remove the Book consumable until Isaac leaves the room."},
		},
		{ -- Strategy
			{str = "Strategy", fsize = 2, clr = 3, halign = 0},
			{str = "Be cautious when carrying cards and/or pills, the book item Bookmark Bag gives will always be first in the consumable cue if it gives one, one unaware press of the ''use consumable'' button can lead to Isaac's build getting fully rerolled."},
			{str = "- Extreme caution when entering Satan's room!, as The Bible also can be selected."},
		},
		--[[ { -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Starter Deck/ Little Baggy/ Polydactyly: The two cards/pills and die can be held at the same time, and can be cycled through as normal with the swap key."},
			{str = "Glowing Hour Glass: The dice given in the room Isaac used Glowing Hour Glass in will be granted in the next new room Isaac visits, regardless of what it is."},
			{str = "Jacob and Esau: Regardless of who is holding the dice, it is activated by pressing the consumable key. If Esau is holding an active item, it will be used at the same time as the dice. Possibly unintended behavior."},
		}, ]]
		--[[ { -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This trinket resembles a bag from Crown Royal, a popular brand of liquor that comes in a purple sack. In real life, these bags are commonly used as dice bags due to their availability."},
		}, ]]
	},
	[t.RING_OF_JUPITER] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "-20% Tear Delay."},
			{str = "+10% Speed Up."},
			{str = "x1.16 Damage Multiplier."},
			{str = "+5% Shot Speed Up."},
			{str = "+1 Luck."},
			{str = "Grants Homing Tears."},
			{str = "All effects are applied to all players if one or more has the trinket."},
		},
	},
	[t.RANGE_OS] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "-60% Range Multiplier"},
			{str = "- Range Limit is locked to 6.5."},
			{str = "+125% Damage Multiplier"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item is inspired from 'Assault OS', which was in 'Last Origin' from 'Studio Valkyrie'."},
			{str = "In early era in Last Origin, There are 'effective range' for each skills, some skills needed to be used in close range."},
			{str = "Many players overused this equipment to control main skills for each unit, to only use stronger skills, which was not available in normal playthrough."},
		},
	},
	[t.ISAAC_CARTRIDGE] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac only can find pre-rebirth items, and modded items."},
			{str = "Birthright is whitelisted from this trinket."},
			{str = "Only modded items will be shown in Planetarium pool."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Afterbirth Cartridge", clr = 3, halign = 0},
			{str = "Overrides Isaac Cartridge."},
			{str = "Repentance Cartridge", clr = 3, halign = 0},
			{str = "Overrides Isaac Cartridge."},
		},
	},
	[t.AFTERBIRTH_CARTRIDGE] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac only can find pre-afterbirth+ items."},
			{str = "Birthright is whitelisted from this trinket."},
			{str = "Treasure item pool items will be shown in Planetarium pool."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Tsukasa/Isaac Cartridge", clr = 3, halign = 0},
			{str = "Overridden by Afterbirth Cartridge."},
			{str = "Repentance Cartridge", clr = 3, halign = 0},
			{str = "Overrides Afterbirth Cartridge."},
		},
	},
	[t.REPENTANCE_CARTRIDGE] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac only can find pre-repentance items, making modded items unable to be found."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Tsukasa/Isaac Cartridge", clr = 3, halign = 0},
			{str = "Overridden by Repentance Cartridge."},
			{str = "Afterbirth Cartridge", clr = 3, halign = 0},
			{str = "Overridden by Repentance Cartridge."},
		},
	},
	[t.AURORA_GEM] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "6.66% chance to replace normal coin into purple coins."},
			{str = "- The chance for purple coins depends on the luck stat and goes up to 100% at 69 Luck."},
			{str = "When picking up a purple coin for the first time, a ghostly rainbow sphere called as 'Easter Egg' following Isaac."},
			{str = "- Rainbow sphere shoot homing, spectral tears that do 1 damage."},
			{str = "Picking multiple purple coins make rainbow sphere deal more damage, and shoot tears more frequently."},
		},
	},
	[t.SIREN_BADGE] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Prevents contact damage for Isaac"},
			{str = "Isaac still can be damaged from non-contact damage such as spikes, curse room doors, or projectiles"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item is inspired from 'Pure Love' from 'Rabi-Ribi'."},
			{str = "In Rabi-Ribi, there are a demon called Lilith, who held the badge"},
			{str = "Pure Love prevents any collision damage from bosses"},
		},
	},
	[t.STAR_REVERSAL] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Dropping the trinket in a Treasure room exchanges it for Planetarium item."},
			{str = "The trinket disappears on exchange."},
			{str = "Pressing Drop button while smelted also exchanges the trinket."},
		},
	},
	[t.ETERNITY_COOKIE] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "All pickups no longer have time limit."},
		},
	},
	[t.RABBIT_PILLOW] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Allows to use donation mechanics while in White fire state."},
		},
	},
	--[t.CANDY_OF_RICHER] = {},
	--[t.CANDY_OF_RIRA] = {},
	--[t.CANDY_OF_CIEL] = {},
	--[t.CANDY_OF_KORON] = {},
	--[t.CARAMELLA_CANDY_BAG] = {}, -- Rira Quartet
	--[t.CARAMELLA_CANDY_BAG] = {}, -- Rira Mother
	[t.DELIMITER] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "When entering new room :", clr = 3},
			{str = "Destroys Tinted rocks, and Fools Gold rocks."},
			{str = "Turns Pillars, Metal blocks, Spiked rocks into normal rocks."},
		},
	},
	[t.DIMENSION_CUTTER] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "When entering an uncleared room, Spawns a random Delirious boss for 15% chance."},
			{str = "In Greed Mode, 5% chance for spawn, but scales with Luck, Maxing out 25% chance for 10 Luck."},
			{str = "Chaos card can damage Delirium, and The Beast (339 damage per tick)."},
		},
	},
	[t.KUROMI_CARD] = {},
	[t.MISTAKE] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Taking damage makes explosion on random enemy."},
		},
	},
	[t.CARAMELLA_CANDY_BAG] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon entering an uncleared room for the first time, spawns a random Caramella Locust."},
		},
	},
	[t.CANDY_OF_RICHER] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon entering an uncleared room for the first time, spawns a Blue Caramella Locust that deals 3x of Isaac's damage."},
		},
	},
	[t.CANDY_OF_RIRA] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon entering an uncleared room for the first time, spawns a Pink Caramella Locust that deals 1x of Isaac's damage."},
		},
	},
	[t.CANDY_OF_CIEL] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon entering an uncleared room for the first time, spawns a Yellow Caramella Locust that deals 5x of Isaac's damage."},
		},
	},
	[t.CANDY_OF_KORON] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon entering an uncleared room for the first time, spawns a Gray Caramella Locust that deals 1.5x of Isaac's damage."},
		},
	},
	[t.PINK_FORK] = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Decreases Soul Heart heal rate by half heart"},
			{str = "Decreased rate are converted to +0.2 Damage"},
		},
	},



	[t.SIGIL_OF_KAGUYA] = {},
}