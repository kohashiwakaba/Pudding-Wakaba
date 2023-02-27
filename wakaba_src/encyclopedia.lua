local players = wakaba.Enums.Players
local items = wakaba.Enums.Collectibles
local trinkets = wakaba.Enums.Trinkets
local cards = wakaba.Enums.Cards
local pills = wakaba.Enums.Pills

if not Encyclopedia then
	return
end

wakaba.encyclopediadesc.class = "Pudding n Wakaba"
wakaba.encyclopediadesc.desc = {}

wakaba.encyclopediadesc.desc.char_sorted_keys = {
	wakaba.Enums.Players.WAKABA,
	wakaba.Enums.Players.WAKABA_B,
	wakaba.Enums.Players.SHIORI,
	wakaba.Enums.Players.SHIORI_B,
	wakaba.Enums.Players.TSUKASA,
	wakaba.Enums.Players.TSUKASA_B,
	wakaba.Enums.Players.RICHER,
	wakaba.Enums.Players.RICHER_B,
}

wakaba.encyclopediadesc.desc.characters = {
	[wakaba.Enums.Players.WAKABA] = {
		ID = wakaba.Enums.Players.WAKABA,
		Name = "Wakaba",
		Description = "The Clover",
		Sprite = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraits.anm2", "Wakaba", 0),
		CompletionTrackerFuncs = { -- You can skip this one if your mod doesn't have custom unlocks.
			function()
				local UnlocksTab = {
					MomsHeart = {Unlock = (wakaba.state.unlock.clover >= 1), Hard = (wakaba.state.unlock.clover == 2)},
					Isaac = {Unlock = (wakaba.state.unlock.counter >= 1), Hard = (wakaba.state.unlock.counter == 2)},
					Satan = {Unlock = (wakaba.state.unlock.dcupicecream >= 1), Hard = (wakaba.state.unlock.dcupicecream == 2)},
					BlueBaby = {Unlock = (wakaba.state.unlock.pendant >= 1), Hard = (wakaba.state.unlock.pendant == 2)},
					Lamb = {Unlock = (wakaba.state.unlock.revengefruit >= 1), Hard = (wakaba.state.unlock.revengefruit == 2)},
					BossRush = {Unlock = (wakaba.state.unlock.donationcard >= 1), Hard = (wakaba.state.unlock.donationcard == 2)},
					Hush = {Unlock = (wakaba.state.unlock.colorjoker >= 1), Hard = (wakaba.state.unlock.colorjoker == 2)},
					MegaSatan = {Unlock = (wakaba.state.unlock.whitejoker >= 1), Hard = (wakaba.state.unlock.whitejoker == 2)},
					Delirium = {Unlock = (wakaba.state.unlock.wakabauniform >= 1), Hard = (wakaba.state.unlock.wakabauniform == 2)},
					Mother = {Unlock = (wakaba.state.unlock.confessionalcard >= 1), Hard = (wakaba.state.unlock.confessionalcard == 2)},
					Beast = {Unlock = (wakaba.state.unlock.returnpostage >= 1), Hard = (wakaba.state.unlock.returnpostage == 2)},
					GreedMode = {Unlock = (wakaba.state.unlock.secretcard >= 1), Hard = (wakaba.state.unlock.cranecard == 2)},
				}
				return UnlocksTab
			end
		},
		WikiDesc = {
			{ -- Start Data
					{str = "Start Data", fsize = 2, clr = 3, halign = 0},
					{str = "Items", clr = 3, halign = 0},
					{str = "- Wakaba's Blessing"},
					{str = "- Deep Pockets"},
					{str = "- Wild Card"},
					{str = "Stats", clr = 3, halign = 0},
					{str = "- HP: 2 Red Hearts"},
					{str = "- Extra: 5 Coins"},
					{str = "- Speed: 1.10"},
					{str = "- Tear Rate: 2.03"},
					{str = "- Damage: 3.85"},
					{str = "- Range: 8.00"},
					{str = "- Shot Speed: 0.95"},
					{str = "- Luck: 3.00"},
			},
			{ -- Traits
					{str = "Traits", fsize = 2, clr = 3, halign = 0},
					{str = "Wakaba starts with Homing tears."},
					{str = "Wakaba is unable to find Luck Down and Speed Up pills."},
					{str = "Max 3 Hearts total. Others are filled with Broken Hearts."},
					{str = "- If Confessional is in the room, Wakaba's Broken Hearts will be disappeared temporarily. This is to prevent Confessional trying to remove broken hearts."},
					{str = "Wakaba's Blessing", clr = 3, halign = 0},
					{str = "Guarantees the Devil/Angel Room encountered to be an Angel Room."},
					{str = "- Devil Rooms will no longer appear unless Isaac has Duality, Wakaba's Nemesis, or Black Joker."},
					{str = "Prevents low-quality items from spawning. Greatly increasing quality of items received from all item pools."},
					{str = "- Items with a quality of 0-1 are automatically rerolled."},
					{str = "All penalties by taking damage are removed."},
					{str = "Gives a Holy Mantle Shield when the health is total of 1 heart or low. The shield activates per room until Wakaba recovers her health to more than 1 heart."},
			},
			{ -- Birthright
					{str = "Birthright", fsize = 2, clr = 3, halign = 0},
					{str = "Extends 1 heart limit."},
					{str = "100% chance for angel rooms."},
			},
			{ -- Notes
					{str = "Notes", fsize = 2, clr = 3, halign = 0},
					{str = "Wakaba's Blessing effect for Wakaba is intrinsic to the character, and it can't be rerolled."},
			},
			{ -- Unlockables
					{str = "Unlockables", fsize = 2, clr = 3, halign = 0},
					{str = "- Clover : Defeat Mom's Heart as Wakaba on Hard Mode"},
					{str = "- Counter : Defeat Isaac as Wakaba"},
					{str = "- D-Cup Icecream : Defeat Satan as Wakaba"},
					{str = "- Wakaba's Pendant : Defeat ??? as Wakaba"},
					{str = "- Revenge Fruit : Defeat The Lamb as Wakaba"},
					{str = "- White Joker : Defeat Mega Satan as Wakaba"},
					{str = "- Wakaba's Dream Card : Defeat Boss Rush as Wakaba"},
					{str = "- Color Joker : Defeat Hush as Wakaba"},
					{str = "- Secret Card : Defeat Ultra Greed as Wakaba"},
					{str = "- Crane Card : Defeat Ultra Greedier as Wakaba"},
					{str = "- Wakaba's Uniform : Defeat Delirium as Wakaba"},
					{str = "- Confessional Card : Defeat Mother as Wakaba"},
					{str = "- Return Postage : Defeat The Beast as Wakaba"},
					{str = "- Wakaba's Blessing : Earn all 12 completion Marks on Hard Mode as Wakaba"},
			},
			{ -- Trivia
					{str = "Trivia", fsize = 2, clr = 3, halign = 0},
					{str = "The original character 'Wakaba' is from manga 'Wakaba Girl', from Hara Yui."},
					{str = "In Wakaba Girl, many clover symbols appear in various situations. which makes most of Wakaba's unlockables emphasizes on Luck or Clovers."},
			},
		},
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		ID = wakaba.Enums.Players.WAKABA_B,
		Tainted = true,
		Name = "Wakaba",
		Description = "The Fury",
		Sprite = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraitsalt.anm2", "WakabaB", 0),
		CompletionTrackerFuncs = { -- You can skip this one if your mod doesn't have custom unlocks.
			function()
				local UnlocksTab = {
					MomsHeart = {Unlock = (wakaba.state.unlock.taintedwakabamomsheart >= 1), Hard = (wakaba.state.unlock.taintedwakabamomsheart == 2)},
					Isaac = {Unlock = (wakaba.state.unlock.bookofforgotten1 >= 1), Hard = (wakaba.state.unlock.bookofforgotten1 == 2)},
					Satan = {Unlock = (wakaba.state.unlock.bookofforgotten2 >= 1), Hard = (wakaba.state.unlock.bookofforgotten2 == 2)},
					BlueBaby = {Unlock = (wakaba.state.unlock.bookofforgotten3 >= 1), Hard = (wakaba.state.unlock.bookofforgotten3 == 2)},
					Lamb = {Unlock = (wakaba.state.unlock.bookofforgotten4 >= 1), Hard = (wakaba.state.unlock.bookofforgotten4 == 2)},
					BossRush = {Unlock = (wakaba.state.unlock.wakabasoul1 >= 1), Hard = (wakaba.state.unlock.wakabasoul1 == 2)},
					Hush = {Unlock = (wakaba.state.unlock.wakabasoul2 >= 1), Hard = (wakaba.state.unlock.wakabasoul2 == 2)},
					MegaSatan = {Unlock = (wakaba.state.unlock.cloverchest >= 1), Hard = (wakaba.state.unlock.cloverchest == 2)},
					Delirium = {Unlock = (wakaba.state.unlock.eatheart >= 1), Hard = (wakaba.state.unlock.eatheart == 2)},
					Mother = {Unlock = (wakaba.state.unlock.bitcoin >= 1), Hard = (wakaba.state.unlock.bitcoin == 2)},
					Beast = {Unlock = (wakaba.state.unlock.nemesis >= 1), Hard = (wakaba.state.unlock.nemesis == 2)},
					GreedMode = {Unlock = (wakaba.state.unlock.blackjoker >= 1), Hard = (wakaba.state.unlock.blackjoker == 2)},
				}
				return UnlocksTab
			end
		},
		WikiDesc = {
				{ -- Start Data
						{str = "Start Data", fsize = 2, clr = 3, halign = 0},
						{str = "Items", clr = 3, halign = 0},
						{str = "- Wakaba's Nemesis"},
						{str = "- Eat Heart"},
						{str = "Stats", clr = 3, halign = 0},
						{str = "- HP: 3 Black Hearts"},
						{str = "- Extra: 2 Bombs"},
						{str = "- Speed: 1.25"},
						{str = "- Tear Rate: 5.71"},
						{str = "- Damage: 2.45"},
						{str = "- Range: 5.00"},
						{str = "- Shot Speed: 0.80"},
						{str = "- Luck: -5.00"},
				},
				{ -- Traits
						{str = "Traits", fsize = 2, clr = 3, halign = 0},
						{str = "Tainted Wakaba starts with Continum and Piercing tears."},
						{str = "Tainted Wakaba is unable to find Luck Up pills."},
						{str = "All Heart Containers are converted into Black Hearts."},
						{str = "Worst Items, Furious Destiny - Wakaba's Nemesis", clr = 3, halign = 0},
						{str = "Tainted Wakaba cannot find 3+ quality items."},
						{str = "- Tainted Wakaba is guarenteed to find 3+ quality items in Ultra Secret Rooms."},
						{str = "All collectibles give Tainted Wakaba +3.6 temporary damage up, and small permanent all stat downs."},
						{str = "Guarentees the Devil/Angel Room encountered to be an Devil Room."},
						{str = "All collectibles on sale requires soul hearts."},
						{str = "All penalties by taking damage are removed."},
				},
				{ -- Birthright
						{str = "Birthright", fsize = 2, clr = 3, halign = 0},
						{str = "Immune to all explosions and shockwaves."},
						{str = "Reduce Temporary damage reduction rate."},
				},
				{ -- Notes
						{str = "Notes", fsize = 2, clr = 3, halign = 0},
						{str = "Wakaba's Nemesis effect for Tainted Wakaba is intrinsic to the character, and it can't be rerolled."},
				},
				{ -- Unlockables
						{str = "Unlockables", fsize = 2, clr = 3, halign = 0},
						{str = "- Book of Forgotten : Defeat Isaac, Satan, ???, The Lamb as Tainted Wakaba"},
						{str = "- Clover Chest : Defeat Mega Satan as Tainted Wakaba"},
						{str = "- Soul of Wakaba : Defeat Boss Rush, Hush as Tainted Wakaba"},
						{str = "- Black Joker : Defeat Ultra Greedier as Tainted Wakaba"},
						{str = "- Eat Heart : Defeat Delirium as Tainted Wakaba"},
						{str = "- Bitcoin II : Defeat Mother as Tainted Wakaba"},
						{str = "- Wakaba's Nemesis : Defeat The Beast as Tainted Wakaba"},
				},
	
		},
	},

	[wakaba.Enums.Players.SHIORI] = {
		ID = wakaba.Enums.Players.SHIORI,
		Name = "Shiori",
		Description = "The Bookmark",
		Sprite = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraits.anm2", "Shiori", 0),
		CompletionTrackerFuncs = { -- You can skip this one if your mod doesn't have custom unlocks.
			function()
				local UnlocksTab = {
					MomsHeart = {Unlock = (wakaba.state.unlock.hardbook >= 1), Hard = (wakaba.state.unlock.hardbook == 2)},
					Isaac = {Unlock = (wakaba.state.unlock.shiorid6plus >= 1), Hard = (wakaba.state.unlock.shiorid6plus == 2)},
					Satan = {Unlock = (wakaba.state.unlock.bookoffocus >= 1), Hard = (wakaba.state.unlock.bookoffocus == 2)},
					BlueBaby = {Unlock = (wakaba.state.unlock.deckofrunes >= 1), Hard = (wakaba.state.unlock.deckofrunes == 2)},
					Lamb = {Unlock = (wakaba.state.unlock.grimreaperdefender >= 1), Hard = (wakaba.state.unlock.grimreaperdefender == 2)},
					BossRush = {Unlock = (wakaba.state.unlock.unknownbookmark >= 1), Hard = (wakaba.state.unlock.unknownbookmark == 2)},
					Hush = {Unlock = (wakaba.state.unlock.bookoftrauma >= 1), Hard = (wakaba.state.unlock.bookoftrauma == 2)},
					MegaSatan = {Unlock = (wakaba.state.unlock.bookoffallen >= 1), Hard = (wakaba.state.unlock.bookoffallen == 2)},
					Delirium = {Unlock = (wakaba.state.unlock.bookofsilence >= 1), Hard = (wakaba.state.unlock.bookofsilence == 2)},
					Mother = {Unlock = (wakaba.state.unlock.vintagethreat >= 1), Hard = (wakaba.state.unlock.vintagethreat == 2)},
					Beast = {Unlock = (wakaba.state.unlock.bookofthegod >= 1), Hard = (wakaba.state.unlock.bookofthegod == 2)},
					GreedMode = {Unlock = (wakaba.state.unlock.magnetheaven >= 1), Hard = (wakaba.state.unlock.determinationribbon >= 2)},
				}
				return UnlocksTab
			end
		},
		WikiDesc = {
			{ -- Start Data
					{str = "Start Data", fsize = 2, clr = 3, halign = 0},
					{str = "Items", clr = 3, halign = 0},
					{str = "- Book of Shiori"},
					{str = "- Books (See traits)"},
					{str = "- Old Capacity"},
					{str = "Stats", clr = 3, halign = 0},
					{str = "- HP: 3 Red Hearts"},
					{str = "- Extra: 12 Keys"},
					{str = "- Speed: 1.00"},
					{str = "- Tear Rate: 3.00"},
					{str = "- Damage: 1.75"},
					{str = "- Range: 7.25"},
					{str = "- Shot Speed: 1.00"},
					{str = "- Luck: 0.00"},
			},
			{ -- Traits
					{str = "Traits", fsize = 2, clr = 3, halign = 0},
					{str = "Shiori starts with Horizontal Homing tears."},
					{str = "Shiori can use any book by switching each books."},
					{str = "Modded active items that conut towards Bookworm transformation will also be included."},
					{str = "Following books, Hidden items are blacklisted and are not included."},
					{str = "- Wakaba's Double Dreams"},
					{str = "- Book of The Fallen"},
					{str = "- Maijima Mythology"},
					{str = "- D6 Plus (Unlocked by defeating Isaac as Shiori)"},
					{str = "- Micro Doppelganger (Unlocked by completing Doppelganger challenge)"},
					{str = "- Book of Conquest (Unlocked by defeating Delirium as Tainted Shiori)"},
					{str = "- Isekai Definition (Unlocked by completing Delivery System challenge)"},
					{str = "- Balance ecnalaB (Unlocked by completing Calculation challenge)"},
					{str = "Shiori requires Keys to use active items. This applies for all 3 Active item slots."},
					{str = "Other than following items, Timed and special type charge items can be used normally and do not cost keys."},
					{str = "- Book of Silence"},
					{str = "- Book of Trauma"},
					{str = "- Eraser"},
					{str = "Shiori has a chance to get a Key when room is cleared."},
					{str = "Picking up Batteries as Shiori will give equivalent amount of keys."},
					{str = "- Picking up Micro Battery will give Shiori 1 key."},
					{str = "- Picking up Lil Battery will give Shiori 3 keys."},
					{str = "- Picking up Mega Battery will give Shiori 5 keys."},
					{str = "- Picking up Golden Battery will give Shiori 10 keys."},
					{str = "Shiori cannot see batteries in Shop. All batteries are converted into Golden key for 5 coins."},
					{str = "- Shiori also cannot hold Golden Keys. Obtaining Golden Key automatically converts into 6 keys."},
					{str = "Book of Shiori", clr = 3, halign = 0},
					{str = "Activates additional effect when book active items are being used."},
					{str = "Shiori also gains extra tear effect when book active items are being used."},
					{str = "extra tear effect changes on next book usage."},
			},
			{ -- Birthright
					{str = "Birthright", fsize = 2, clr = 3, halign = 0},
					{str = "Halves key consume when using active item."},
			},
			{ -- Notes
					{str = "Notes", fsize = 2, clr = 3, halign = 0},
					{str = "Book of Shiori effect for Shiori is intrinsic to the character, and it can't be rerolled."},
			},
				{ -- Unlockables
					{str = "Unlockables", fsize = 2, clr = 3, halign = 0},
					{str = "- Hard Book : Defeat Mom's Heart as Shiori on Hard Mode"},
					{str = "- Shiori starts with D6 Plus : Defeat Isaac as Shiori"},
					{str = "- Book of Focus : Defeat Satan as Shiori"},
					{str = "- Shiori's Bottle of Runes : Defeat ??? as Shiori"},
					{str = "- Grimreaper Defender : Defeat The Lamb as Shiori"},
					{str = "- Book of the Fallen : Defeat Mega Satan as Shiori"},
					{str = "- Unknown Bookmark : Defeat Boss Rush as Shiori"},
					{str = "- Book of Trauma : Defeat Hush as Shiori"},
					{str = "- Magnet Heaven : Defeat Ultra Greed as Shiori"},
					{str = "- Ribbon of Determination : Defeat Ultra Greedier as Shiori"},
					{str = "- Book of Silence : Defeat Delirium as Shiori"},
					{str = "- Vintage Threat : Defeat Mother as Shiori"},
					{str = "- Book of the God : Defeat The Beast as Shiori"},
					{str = "- Book of Shiori : Earn all 12 completion Marks on Hard Mode as Shiori"},
			}, 
			{ -- Trivia
					{str = "Trivia", fsize = 2, clr = 3, halign = 0},
					{str = "The original character 'Shiomiya Shiori' is from manga 'The world only god knows'(or 'TWOGK'), from Wakagi Tamaki."},
					{str = "In TWOGK, Shiori was one of the heroines of 'Katsuragi Keima', who has mission to solve the problems of each heroine in order to survive."},
					{str = "The name of the character 'Shiori' has the meaning of 'the bookmark' as japanese, a possible title for the character."},
			},

		},
	},
	
	[wakaba.Enums.Players.SHIORI_B] = {
		ID = wakaba.Enums.Players.SHIORI_B,
		Tainted = true,
		Name = "Shiori",
		Description = "The Minerva",
		Sprite = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraitsalt.anm2", "ShioriB", 0),
		CompletionTrackerFuncs = { -- You can skip this one if your mod doesn't have custom unlocks.
			function()
				local UnlocksTab = {
					MomsHeart = {Unlock = (wakaba.state.unlock.taintedshiorimomsheart >= 1), Hard = (wakaba.state.unlock.taintedshiorimomsheart == 2)},
					Isaac = {Unlock = (wakaba.state.unlock.bookmarkbag1 >= 1), Hard = (wakaba.state.unlock.bookmarkbag1 == 2)},
					Satan = {Unlock = (wakaba.state.unlock.bookmarkbag2 >= 1), Hard = (wakaba.state.unlock.bookmarkbag2 == 2)},
					BlueBaby = {Unlock = (wakaba.state.unlock.bookmarkbag3 >= 1), Hard = (wakaba.state.unlock.bookmarkbag3 == 2)},
					Lamb = {Unlock = (wakaba.state.unlock.bookmarkbag4 >= 1), Hard = (wakaba.state.unlock.bookmarkbag4 == 2)},
					BossRush = {Unlock = (wakaba.state.unlock.shiorisoul1 >= 1), Hard = (wakaba.state.unlock.shiorisoul1 == 2)},
					Hush = {Unlock = (wakaba.state.unlock.shiorisoul2 >= 1), Hard = (wakaba.state.unlock.shiorisoul2 == 2)},
					MegaSatan = {Unlock = (wakaba.state.unlock.shiorivalut >= 1), Hard = (wakaba.state.unlock.shiorivalut == 2)},
					Delirium = {Unlock = (wakaba.state.unlock.bookofconquest >= 1), Hard = (wakaba.state.unlock.bookofconquest == 2)},
					Mother = {Unlock = (wakaba.state.unlock.ringofjupiter >= 1), Hard = (wakaba.state.unlock.ringofjupiter == 2)},
					Beast = {Unlock = (wakaba.state.unlock.minervaaura >= 1), Hard = (wakaba.state.unlock.minervaaura == 2)},
					GreedMode = {Unlock = (wakaba.state.unlock.queenofspades >= 1), Hard = (wakaba.state.unlock.queenofspades >= 2)},
				}
				return UnlocksTab
			end
		},
		WikiDesc = {
			{ -- Start Data
					{str = "Start Data", fsize = 2, clr = 3, halign = 0},
					{str = "Items", clr = 3, halign = 0},
					{str = "- Book of Shiori"},
					{str = "- Book of Conquest"},
					{str = "- Minerva's Aura"},
					{str = "- Old Capacity"},
					{str = "Stats", clr = 3, halign = 0},
					{str = "- HP: 3 Soul Hearts"},
					{str = "- Extra: 12 Keys"},
					{str = "- Speed: 1.00"},
					{str = "- Tear Rate: 3.00"},
					{str = "- Damage: 1.00"},
					{str = "- Range: 6.00"},
					{str = "- Shot Speed: 1.00"},
					{str = "- Luck: 0.00"},
			},
			{ -- Traits
					{str = "Traits", fsize = 2, clr = 3, halign = 0},
					{str = "All Heart Containers are converted into Soul Hearts."},
					{str = "Tainted Shiori requires Keys to use active items. This applies for all 3 Active item slots."},
					{str = "Tainted Shiori has a chance to get the Key when room clears."},
					{str = "Picking up Batteries as Tainted Shiori will give equivalent amount of Keys."},
					{str = "- Picking up Micro Battery will give Tainted Shiori 1 Key."},
					{str = "- Picking up Lil Battery will give Tainted Shiori 3 Keys."},
					{str = "- Picking up Mega Battery will give Tainted Shiori 5 Keys."},
					{str = "- Picking up Golden Battery will give Tainted Shiori 10 Keys."},
					{str = "Tainted Shiori cannot see batteries in Shop. All batteries are converted into Golden key for 5 coins."},
					{str = "- Tainted Shiori also cannot hold Golden Keys. Obtaining Golden Key automatically converts into 6 keys."},
					{str = "Jupiter Wings", clr = 3, halign = 0},
					{str = "Tainted Shiori starts with flight."},
					{str = "Book of Shiori", clr = 3, halign = 0},
					{str = "Activates additional effect when book active items are being used."},
					{str = "Shiori also gains extra tear effect when book active items are being used."},
					{str = "extra tear effect changes on next book usage."},
					{str = "Minerva's Aura", clr = 3, halign = 0},
					{str = "Emits aura that follows Tainted Shiori."},
					{str = "Friendly monsters inside the aura gradually recovers health."},
					{str = "- Friendly monsters can recover up to 2x of their max health."},
					{str = "While Other players stand inside the aura, grants + 1.5 damage up, + 2.0 tears up, +1.5 range up and homing tears. It also gives players a chance to block damage similar to Infamy."},
			},
			{ -- Birthright
					{str = "Birthright", fsize = 2, clr = 3, halign = 0},
					{str = "Allows getting aura bonus for herself"},
					{str = "Reduces key consume by 1 when using active item. (Minimum 1)"},
					{str = "The number of required keys for Book of Conquest is reduced. (Minimum 1)"},
					{str = "All stats up for current number of conquered enemies."},
					{str = "- Also applies for other players inside Minerva's Aura."},
					{str = "Faster health regen rate of Minerva's aura for conquered enemies."},
			},
			{ -- Notes
					{str = "Notes", fsize = 2, clr = 3, halign = 0},
					{str = "Book of Shiori and Minerva's Aura effect for Tainted Shiori is intrinsic to the character, and it can't be rerolled."},
					{str = "- Tainted Shiori cannot get aura bonus even when she stands inside her own aura."},
					{str = "- Obtaining Birthright will allow Tainted Shiori get aura bonus for her own aura."},
					{str = "- Tainted Shiori can still find this item on a pedestal. Picking the item increases further aura bonuses."},
			},
			{ -- Unlockables
					{str = "Unlockables", fsize = 2, clr = 3, halign = 0},
					{str = "- Bookmark Bag : Defeat Isaac, Satan, ???, The Lamb as Tainted Shiori"},
					{str = "- Another Fortune Machine : Defeat Mega Satan as Tainted Shiori"},
					{str = "- Soul of Shiori : Defeat Boss Rush, Hush as Tainted Shiori"},
					{str = "- Queen of Spades : Defeat Ultra Greedier as Tainted Shiori"},
					{str = "- Book of Conquest : Defeat Delirium as Tainted Shiori"},
					{str = "- Ring of Jupiter : Defeat Mother as Tainted Shiori"},
					{str = "- Minerva's Aura : Defeat The Beast as Tainted Shiori"},
			},
			{ -- Trivia
					{str = "Trivia", fsize = 2, clr = 3, halign = 0},
					{str = "The original character 'Shiomiya Shiori' is from manga 'The world only god knows'(or 'TWOGK'), from Wakagi Tamaki."},
					{str = "In TWOGK, Shiori was one of the heroines of 'Katsuragi Keima', who has mission to solve the problems of each heroine in order to survive."},
					{str = "Shiori was also one of six heroines who holds the Goddesses called 'Sisters of Jupiter'."},
					{str = "The Goddess who is held by Shiori is 'Minerva', a possible title for the character."},
			},

		},
	},

	[wakaba.Enums.Players.TSUKASA] = {
		ID = wakaba.Enums.Players.TSUKASA,
		Name = "Tsukasa",
		Description = "The Entertainer",
		Sprite = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraits.anm2", "Tsukasa", 0),
		CompletionTrackerFuncs = { -- You can skip this one if your mod doesn't have custom unlocks.
			function()
				local UnlocksTab = {
					MomsHeart = {Unlock = (wakaba.state.unlock.murasame >= 1), Hard = (wakaba.state.unlock.murasame == 2)},
					Isaac = {Unlock = (wakaba.state.unlock.nasalover >= 1), Hard = (wakaba.state.unlock.nasalover == 2)},
					Satan = {Unlock = (wakaba.state.unlock.beetlejuice >= 1), Hard = (wakaba.state.unlock.beetlejuice == 2)},
					BlueBaby = {Unlock = (wakaba.state.unlock.redcorruption >= 1), Hard = (wakaba.state.unlock.redcorruption == 2)},
					Lamb = {Unlock = (wakaba.state.unlock.powerbomb >= 1), Hard = (wakaba.state.unlock.powerbomb == 2)},
					BossRush = {Unlock = (wakaba.state.unlock.concentration >= 1), Hard = (wakaba.state.unlock.concentration == 2)},
					Hush = {Unlock = (wakaba.state.unlock.rangeos >= 1), Hard = (wakaba.state.unlock.rangeos == 2)},
					MegaSatan = {Unlock = (wakaba.state.unlock.plasmabeam >= 1), Hard = (wakaba.state.unlock.plasmabeam == 2)},
					Delirium = {Unlock = (wakaba.state.unlock.newyearbomb >= 1), Hard = (wakaba.state.unlock.newyearbomb == 2)},
					Mother = {Unlock = (wakaba.state.unlock.phantomcloak >= 1), Hard = (wakaba.state.unlock.phantomcloak == 2)},
					Beast = {Unlock = (wakaba.state.unlock.magmablade >= 1), Hard = (wakaba.state.unlock.magmablade == 2)},
					GreedMode = {Unlock = (wakaba.state.unlock.arcanecrystal >= 1), Hard = (wakaba.state.unlock.questionblock >= 2)},
				}
				return UnlocksTab
			end
		},
		WikiDesc = {
			{ -- Start Data
					{str = "Start Data", fsize = 2, clr = 3, halign = 0},
					{str = "Items", clr = 3, halign = 0},
					{str = "- Lunar Stone"},
					{str = "- Concentration"},
					--{str = "- Flash Shift (Needs to be unlocked)"},
					{str = "Stats", clr = 3, halign = 0},
					{str = "- HP: 3 Red Hearts (8 max)"},
					{str = "- Speed: 1.50"},
					{str = "- Tear Rate: 1.00"},
					{str = "- Damage: 7.00"},
					{str = "- Range: 23.75"},
					{str = "- Shot Speed: 1.30"},
					{str = "- Luck: 0.00"},
			},
			{ -- Traits
					{str = "Traits", fsize = 2, clr = 3, halign = 0},
					{str = "Tsukasa starts with short range Electric laser."},
					{str = "Tsukasa cannot get soul hearts, All soul hearts will be replaced with lunar gauge."},
					{str = "Lunar Stone", clr = 3, halign = 0},
					{str = "Tsukasa starts with high stats with Lunar powers."},
					{str = "If damage is taken, Lunar Stone deactivates and lunar gauge starts deplete."},
					--{str = "Tsukasa is invincible while Lunar gauge is depleting."},
					{str = "Tsukasa dies when Lunar gauge is completely depleted."},
					{str = "Lunar gauge deplete speed can be decreased with current red hearts."},
					{str = "Concentration", clr = 3, halign = 0},
					{str = "Tsukasa cannot pickup batteries, instead active items can be charged by holding Drop button."},
					{str = "Red Hearts and Lunar gauge also can be healed if too low."},
					{str = "Tsukasa cannot move while in concentration. Taking damage in this state will double damage taken."},
					{str = "Isaac Cartridge", clr = 3, halign = 0},
					{str = "Tsukasa only can find pre-rebirth items, and modded items."},
			},
			{ -- Birthright
					{str = "Birthright", fsize = 2, clr = 3, halign = 0},
					{str = "Removes item limitation range."},
					{str = "Increases Lunar gauge capacity, can be overflowed."},
			},
			{ -- Notes
					{str = "Notes", fsize = 2, clr = 3, halign = 0},
					{str = "Lunar Stone, Concentration effect for Tsukasa is intrinsic to the character, and it can't be rerolled."},
			},
			{ -- Unlockables
					{str = "Unlockables", fsize = 2, clr = 3, halign = 0},
					{str = "- Murasame : Defeat Mom's Heart as Tsukasa on Hard Mode"},
					{str = "- Nasa Lover : Defeat Isaac as Tsukasa"},
					{str = "- Beetlejuice : Defeat Satan as Tsukasa"},
					{str = "- Red Corruption : Defeat ??? as Tsukasa"},
					{str = "- Power Bomb : Defeat The Lamb as Tsukasa"},
					{str = "- Beam : Defeat Mega Satan as Tsukasa"},
					{str = "- Concentration : Defeat Boss Rush as Tsukasa"},
					{str = "- Range OS : Defeat Hush as Tsukasa"},
					{str = "- Arcane Crystal : Defeat Ultra Greed as Tsukasa"},
					{str = "-- Advanced Crystal and Mystic Crystal are also unlocked with Arcane Crystal"},
					{str = "- Question Block : Defeat Ultra Greedier as Tsukasa"},
					{str = "- New Year's Eve Bomb : Defeat Delirium as Tsukasa"},
					{str = "- Phantom Cloak : Defeat Mother as Tsukasa"},
					{str = "- Hydra : Defeat The Beast as Tsukasa"},
					{str = "- Lunar Stone : Earn all 12 completion Marks on Hard Mode as Tsukasa"},
			},	
			{ -- Trivia
					{str = "Trivia", fsize = 2, clr = 3, halign = 0},
					{str = "The original character 'Yuzaki Tsukasa' is from manga 'Tonikaku Kawaii', from Hata Kenjiro."},
			},

		},
	},
	
	[wakaba.Enums.Players.TSUKASA_B] = {
		ID = wakaba.Enums.Players.TSUKASA_B,
		Tainted = true,
		Name = "Tsukasa",
		Description = "The Phoenix",
		Sprite = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraitsalt.anm2", "TsukasaB",0),
	 	CompletionTrackerFuncs = { -- You can skip this one if your mod doesn't have custom unlocks.
			function()
				local UnlocksTab = {
					MomsHeart = {Unlock = (wakaba.state.unlock.taintedtsukasamomsheart >= 1), Hard = (wakaba.state.unlock.taintedtsukasamomsheart == 2)},
					Isaac = {Unlock = (wakaba.state.unlock.isaaccartridge1 >= 1), Hard = (wakaba.state.unlock.isaaccartridge1 == 2)},
					Satan = {Unlock = (wakaba.state.unlock.isaaccartridge2 >= 1), Hard = (wakaba.state.unlock.isaaccartridge2 == 2)},
					BlueBaby = {Unlock = (wakaba.state.unlock.isaaccartridge3 >= 1), Hard = (wakaba.state.unlock.isaaccartridge3 == 2)},
					Lamb = {Unlock = (wakaba.state.unlock.isaaccartridge4 >= 1), Hard = (wakaba.state.unlock.isaaccartridge4 == 2)},
					BossRush = {Unlock = (wakaba.state.unlock.tsukasasoul1 >= 1), Hard = (wakaba.state.unlock.tsukasasoul1 == 2)},
					Hush = {Unlock = (wakaba.state.unlock.tsukasasoul2 >= 1), Hard = (wakaba.state.unlock.tsukasasoul2 == 2)},
					MegaSatan = {Unlock = (wakaba.state.unlock.easteregg >= 1), Hard = (wakaba.state.unlock.easteregg == 2)},
					Delirium = {Unlock = (wakaba.state.unlock.flashshift >= 1), Hard = (wakaba.state.unlock.flashshift == 2)},
					Mother = {Unlock = (wakaba.state.unlock.sirenbadge >= 1), Hard = (wakaba.state.unlock.sirenbadge == 2)},
					Beast = {Unlock = (wakaba.state.unlock.elixiroflife >= 1), Hard = (wakaba.state.unlock.elixiroflife == 2)},
					GreedMode = {Unlock = (wakaba.state.unlock.returntoken >= 1), Hard = (wakaba.state.unlock.returntoken == 2)},
				}
				return UnlocksTab
			end
		},
		UnlockFunc = function(self) -- Again this is in case your tainted is "unlockable"
				if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.taintedtsukasa then
						self.Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraitsalt.anm2", "TsukasaB",1)
						self.Desc = "Use Red Key on the hidden door in the Final Chapter as Tsukasa."
						self.TargetColor = Encyclopedia.VanillaColor
						
						return self
				end
		end,
		WikiDesc = {
			{ -- Start Data
					{str = "Start Data", fsize = 2, clr = 3, halign = 0},
					{str = "Items", clr = 3, halign = 0},
					{str = "- Elixir of life"},
					{str = "- Flash Shift (Passive)"},
					{str = "- Murasame (Passive)"},
					{str = "Stats", clr = 3, halign = 0},
					{str = "- HP: 3 Red Hearts"},
					{str = "- Speed: 1.20"},
					{str = "- Tear Rate: 1.88 / Blindfolded"},
					{str = "- Damage: 2.28"},
					{str = "- Range: 6.50"},
					{str = "- Shot Speed: 1.00"},
					{str = "- Luck: 0.00"},
			},
			{ -- Traits
					{str = "Traits", fsize = 2, clr = 3, halign = 0},
					{str = "No Tears", clr = 3, halign = 0},
					{str = "Tainted Tsukasa cannot shoot tears, making Flash Shift only attack method for her initial state."},
					{str = "Brittle Immortal", clr = 3, halign = 0},
					{str = "Tainted Tsukasa does not have any invincibiliy frames, Getting constant hit will take a lot of health."},
					{str = "Tainted Tsukasa automatically heals her health if no damage is taken for breif time."},
					{str = "Tainted Tsukasa cannot get Soul Hearts. All soul hearts are converted into Bone Hearts."},
					{str = "Flash Shift / Murasame", clr = 3, halign = 0},
					{str = "Flash Shift + Murasame is the only attack method for Tainted Tsukasa."},
					{str = "Pressing attack button will make Tsukasa dash for short distance in firing direction."},
					{str = "Tsukasa can only use Flash Shift 3 times. After using 3 times, Tsukasa needs to wait some times to make available again. Cooldown speed scales with Tears stat."},
					{str = "Using Flash Shift will grant Tsukasa 20 invincibility frames."},
			},
			{ -- Birthright
					{str = "Birthright", fsize = 2, clr = 3, halign = 0},
					{str = "Allows Tainted Tsukasa to shoot tears."},
					{str = "Flash Shift ability is now moved into pocket item slot."},
			},
			{ -- Notes
					{str = "Notes", fsize = 2, clr = 3, halign = 0},
					{str = "Elixir of life, Murasame, Flash Shift effect for Tainted Tsukasa is intrinsic to the character, and it can't be rerolled."},
			},
			{ -- Unlockables
					{str = "Unlockables", fsize = 2, clr = 3, halign = 0},
					{str = "- Isaac Cartridge : Defeat Isaac, Satan, ???, The Lamb as Tainted Tsukasa"},
					{str = "-- Afterbirth/Repentance Cartridge are also unlocked with Isaac Cartridge"},
					{str = "- Easter Coin : Defeat Mega Satan as Tainted Tsukasa"},
					{str = "- Soul of Tsukasa : Defeat Boss Rush, Hush as Tainted Tsukasa"},
					{str = "- Return Token : Defeat Ultra Greedier as Tainted Tsukasa"},
					{str = "- Flash Shift : Defeat Delirium as Tainted Tsukasa"},
					{str = "- Siren's Badge : Defeat Mother as Tainted Tsukasa"},
					{str = "- Elixir of life : Defeat The Beast as Tainted Tsukasa"},
			},
			{ -- Trivia
					{str = "Trivia", fsize = 2, clr = 3, halign = 0},
					{str = "The original character 'Iwasaka --------' is from manga 'FLY ME TO THE MOON', from Hata Kenjiro."},
					{str = "Tsukasa herself did not want Elixir of Life, but his father fed her the potion This later caused massive genocide for her family. Tsukasa later was captured, but slain people who believed the flesh of Tsukasa might give them long life."},
					{str = "The true name of tsukasa is unknown. The name 'Tsukasa' is given by a stranger called 'Umaya', who later became prince Shotoku."},
					{str = "After being immortal, Shotoku asked her to watch his history, with his challenge for humanity reaching the moon."},
			},
	
		},
	},

	[wakaba.Enums.Players.RICHER] = {
		ID = wakaba.Enums.Players.RICHER,
		Name = "Richer",
		Description = "The Maid",
		Sprite = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraits.anm2", "Richer", 0),
		WikiDesc = {
			{ -- Start Data
					{str = "Start Data", fsize = 2, clr = 3, halign = 0},
					{str = "Items", clr = 3, halign = 0},
					{str = "- Rabbit Ribbon"},
					{str = "- Sweets Catalog"},
					{str = "Stats", clr = 3, halign = 0},
					{str = "- HP: 2 Red, 1 Soul"},
					{str = "- Speed: 1.00"},
					{str = "- Tear Rate: 2.73"},
					{str = "- Damage: 3.50"},
					{str = "- Range: 6.50"},
					{str = "- Shot Speed: 1.00"},
					{str = "- Luck: 1.00"},
			},
			{ -- Traits
					{str = "Traits", fsize = 2, clr = 3, halign = 0},
					--{str = ""},
					{str = "Rabbit Ribbon", clr = 3, halign = 0},
					{str = "Richer is immune to Curse of the Blind."},
					{str = "If Richer got any curses, extra bonuses will be granted during curse."},
					{str = "Sweets Catalog", clr = 3, halign = 0},
					{str = "Richer has her expiremental recipies."},
					{str = "When used, Richer gets one of random weapon effects in current room."},
			},
			{ -- Birthright
					{str = "Birthright", fsize = 2, clr = 3, halign = 0},
					--{str = "Richer gets her sweets catalog on her pocket slot."},
					{str = "Sweets Catalog effect is now persistent until next catalog usage."},
					{str = "Grants immunity to curses."},
					{str = ""},
			},
			{ -- Notes
					{str = "Notes", fsize = 2, clr = 3, halign = 0},
					{str = "Rabbit Ribbon effect for Richer is intrinsic to the character, and it can't be rerolled."},
			},
			--[[ { -- Unlockables
					{str = "Unlockables", fsize = 2, clr = 3, halign = 0},
					{str = "- Clover : Defeat Mom's Heart as Wakaba on Hard Mode"},
					{str = "- Counter : Defeat Isaac as Wakaba"},
					{str = "- D-Cup Icecream : Defeat Satan as Wakaba"},
					{str = "- Wakaba's Pendant : Defeat ??? as Wakaba"},
					{str = "- Revenge Fruit : Defeat The Lamb as Wakaba"},
					{str = "- White Joker : Defeat Mega Satan as Wakaba"},
					{str = "- Wakaba's Dream Card : Defeat Boss Rush as Wakaba"},
					{str = "- Color Joker : Defeat Hush as Wakaba"},
					{str = "- Secret Card : Defeat Ultra Greed as Wakaba"},
					{str = "- Crane Card : Defeat Ultra Greedier as Wakaba"},
					{str = "- Wakaba's Uniform : Defeat Delirium as Wakaba"},
					{str = "- Confessional Card : Defeat Mother as Wakaba"},
					{str = "- Return Postage : Defeat The Beast as Wakaba"},
					{str = "- Wakaba's Blessing : Earn all 12 completion Marks on Hard Mode as Wakaba"},
			}, ]]
			{ -- Trivia
					{str = "Trivia", fsize = 2, clr = 3, halign = 0},
					{str = "'Richer', or 'riche' is one of doujin characters from Miyasaka Miyu, at Canvas+Garden"},
					{str = "She also appears in a visual novel 'Love's Sweet Garnish'."},
			},
		},
	},
	
	[wakaba.Enums.Players.RICHER_B] = {
		ID = wakaba.Enums.Players.RICHER_B,
		Tainted = true,
		Name = "Richer",
		Description = "The Miko",
		Sprite = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraitsalt.anm2", "RicherB", 0),
		UnlockFunc = function(self) -- Again this is in case your tainted is "unlockable"
				if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.taintedricher then
						self.Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/characterportraitsalt.anm2", "RicherB",1)
						self.Desc = "Use Red Key on the hidden door in the Final Chapter as Richer."
						self.TargetColor = Encyclopedia.VanillaColor
						
						return self
				end
		end,
		CompletionTrackerFuncs = { -- You can skip this one if your mod doesn't have custom unlocks.
		 function()
			 local UnlocksTab = {
				 MomsHeart = {Unlock = (wakaba.state.unlock.taintedrichermomsheart >= 1), Hard = (wakaba.state.unlock.taintedrichermomsheart == 2)},
				 Isaac = {Unlock = (wakaba.state.unlock.isaaccartridge1 >= 1), Hard = (wakaba.state.unlock.isaaccartridge1 == 2)},
				 Satan = {Unlock = (wakaba.state.unlock.isaaccartridge2 >= 1), Hard = (wakaba.state.unlock.isaaccartridge2 == 2)},
				 BlueBaby = {Unlock = (wakaba.state.unlock.isaaccartridge3 >= 1), Hard = (wakaba.state.unlock.isaaccartridge3 == 2)},
				 Lamb = {Unlock = (wakaba.state.unlock.isaaccartridge4 >= 1), Hard = (wakaba.state.unlock.isaaccartridge4 == 2)},
				 BossRush = {Unlock = (wakaba.state.unlock.tsukasasoul1 >= 1), Hard = (wakaba.state.unlock.tsukasasoul1 == 2)},
				 Hush = {Unlock = (wakaba.state.unlock.tsukasasoul2 >= 1), Hard = (wakaba.state.unlock.tsukasasoul2 == 2)},
				 MegaSatan = {Unlock = (wakaba.state.unlock.easteregg >= 1), Hard = (wakaba.state.unlock.easteregg == 2)},
				 Delirium = {Unlock = (wakaba.state.unlock.flashshift >= 1), Hard = (wakaba.state.unlock.flashshift == 2)},
				 Mother = {Unlock = (wakaba.state.unlock.sirenbadge >= 1), Hard = (wakaba.state.unlock.sirenbadge == 2)},
				 Beast = {Unlock = (wakaba.state.unlock.elixiroflife >= 1), Hard = (wakaba.state.unlock.elixiroflife == 2)},
				 GreedMode = {Unlock = (wakaba.state.unlock.returntoken >= 1), Hard = (wakaba.state.unlock.returntoken == 2)},
			 }
			 return UnlocksTab
		 end
	 },
		WikiDesc = {
			{ -- Start Data
					{str = "Start Data", fsize = 2, clr = 3, halign = 0},
					{str = "Items", clr = 3, halign = 0},
					{str = "- Rabbit Ribbon"},
					{str = "- The Winter Albireo"},
					{str = "- Water-Flame"},
					{str = "Stats", clr = 3, halign = 0},
					{str = "- HP: 3 Soul Hearts"},
					{str = "- Extra: 2 Keys"},
					{str = "- Speed: 1.08"},
					{str = "- Tear Rate: 3.33"},
					{str = "- Damage: 3.50"},
					{str = "- Range: 6.50"},
					{str = "- Shot Speed: 0.90"},
					{str = "- Luck: 0.00"},
			},
			{ -- Traits
					{str = "Traits", fsize = 2, clr = 3, halign = 0},
					{str = "All Heart Containers are converted into Soul Hearts."},
					{str = "Curse of Flames", clr = 3, halign = 0},
					{str = "All passive pedestals are converted into spiritual items."},
					{str = "Tainted Richer cannot obtain items for normal method. Touching the collectible as Tainted Richer will convert into Item Wisp."},
					{str = "Actives can be obtained through normal ways."},
					{str = "Plot-critical items are immune to this effect, thus can be obtained normally."},
					{str = "The Winter Albireo", clr = 3, halign = 0},
					{str = "If possible, her own version of rabbey-planetarium appears."},
					{str = "Rabbey-planetarium contains a spiritual planetarium item."},
					{str = "Water-Flame", clr = 3, halign = 0},
					{str = "Her magical body allows absorbing the item wisps."},
					{str = "Tainted Richer can select which wisp to absorb into passive item."},
			},
			{ -- Birthright
					{str = "Birthright", fsize = 2, clr = 3, halign = 0},
					{str = "Converted items will be doubled."},
					{str = "Drops Flame Princess pill on pickup."},
			},
			{ -- Notes
					{str = "Notes", fsize = 2, clr = 3, halign = 0},
					{str = "Rabbit Ribbon, The Winter Albireo for Tainted Richer is intrinsic to the character, and it can't be rerolled."},
			},
			{ -- Unlockables
					{str = "Unlockables", fsize = 2, clr = 3, halign = 0},
					{str = "- Star Reversal : Defeat Isaac, Satan, ???, The Lamb as Tainted Richer"},
					{str = "- Spiritual Items : Defeat Mega Satan as Tainted Richer"},
					{str = "- Soul of Richer : Defeat Boss Rush, Hush as Tainted Richer"},
					{str = "- Trial Stew : Defeat Ultra Greedier as Tainted Richer"},
					{str = "- Water-Flame : Defeat Delirium as Tainted Richer"},
					{str = "- Mistake : Defeat Mother as Tainted Richer"},
					{str = "- The Winter Albireo : Defeat The Beast as Tainted Richer"},
			},
	
		},
	},
}
wakaba.encyclopediadesc.desc.collectibles = {
	-----------------------------------------------------------------------------
	----------------------------- Core Collectibles -----------------------------
	-----------------------------------------------------------------------------

	WAKABAS_BLESSING = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "Guarantees the Devil/Angel Room encountered to be an Angel Room."},
			{str = "- Devil Rooms will no longer appear unless Isaac has Duality, Wakaba's Nemesis, or Black Joker."},
			{str = "Prevents low-quality items from spawning. Greatly increasing quality of items received from all item pools."},
			{str = "- Items with a quality of 0-1 are automatically rerolled."},
			{str = "All penalties by taking damage are removed. See synergies."},
			{str = "Gives a Holy Mantle Shield when the health is total of 1 heart or low. The shield activates per room until Isaac recovers his health to more than 1 heart."},
			{str = "- This effect does not apply for Tainted Lost."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Wakaba starts with this item and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Wakaba can still find this item on a pedestal. though picking the item only gives Tears up."},
			{str = "Wakaba's Blessing Locust deals 7x faster than normal locust, double of Isaac's Damage, chases through enemies, and freezes on death."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Filigree Feather", clr = 3, halign = 0},
			{str = "Due to Devil rooms being prevented, a large influx of items can be obtained over time."},
			{str = "Paschal Candle", clr = 3, halign = 0},
			{str = "Taking damage from any sources will not reset the tears up."},
			{str = "Perfection", clr = 3, halign = 0},
			{str = "Taking damage from any sources will not lose Perfection trinket."},
			{str = "Damocles/Vintage Threat", clr = 3, halign = 0},
			{str = "Taking damage from any sources does not count as damage taken for Damocles, and will not give it the chance to fall."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Wakaba's Nemesis", clr = 3, halign = 0},
			{str = "???"},
			{str = "Murasame/Goat Head/Eucharist", clr = 3, halign = 0},
			{str = "Angel room doors are always open after Boss rooms."},
			{str = "Sacred Orb", clr = 3, halign = 0},
			{str = "Overrides Item Quality bonus of Wakaba's Blessing"},
			{str = "Tainted Eden", clr = 3, halign = 0},
			{str = "Completely nullifies reroll effect when damaged"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This is originally intended as Doubling items like Damocles, but was scrapped as Doubling items combined with 100% Angel rooms was too overpowered even with the concept of Wakaba."},
			{str = "- This item now resembles Sacred Orb, which is more powerful version of this item."},
		},
	},
	WAKABAS_NEMESIS = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "Armor-piercing tears"},
			{str = "- some enemies like Hush have armor, taking less damage than regular enemies"},
			{str = "All stats downs per item Isaac have."},
			{str = "- Stats decreasing rate is 1% per item. maximum is 99.5% of Isaac's original stats for having 100 items."},
			{str = "Upon picking up an item, Isaac gains a +3.6 temporary damage boost."},
			{str = "- The temporary boost fades over 30 seconds."},
			{str = "- The temporary boost stacks, taking more items gains additional +3.6 temporary damage up."},
			{str = "- The temporary boost caps at +30 damage up."},
			{str = "Guarentees the Devil/Angel Room encountered to be an Devil Room."},
			{str = "- Angel Rooms will no longer appear unless Isaac has Duality, Wakaba's Blessing, Murasame or White Joker."},
			{str = "- Angel Rooms will not appear even when using Sacrifice Room or Confessional."},
			{str = "- If Confessional or a Sacrifice Room would give an Angel Room item, it will instead spawn Redemption if it is unlocked. NOTE: This is not 100% consistent."},
			{str = "Prevents high-quality items from spawning. Greatly decreasing quality of items recieved from all item pools."},
			{str = "- Items with a quality of 4 are automatically rerolled."},
			{str = "- Items with a quality of 3 have 50% chance to be rerolled."},
			{str = "All collectibles on sale require soul hearts corresponding original devil price."},
			{str = "All penalties by taking damage are removed. See synergies."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Wakaba starts with this item and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Tainted Wakaba can still find this item on a pedestal. Picking the item reduces stat penalty rate."},
			{str = "Wakaba's Nemesis Locust deals 5X of Isaac's Damage."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Eat Heart", clr = 3, halign = 0},
			{str = "Ignores Item Quality penalties from Wakaba's Nemesis."},
			{str = "- Eat Heart is the only way to get Items with a quality of 3+ as Tainted Wakaba."},
			{str = "Paschal Candle", clr = 3, halign = 0},
			{str = "Taking damage from any sources will not reset the tears up."},
			{str = "Perfection", clr = 3, halign = 0},
			{str = "Taking damage from any sources will not lose Perfection trinket."},
			{str = "Damocles/Vintage Threat", clr = 3, halign = 0},
			{str = "Taking damage from any sources does not count as damage taken for Damocles, and will not give it the chance to fall."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Wakaba's Blessing", clr = 3, halign = 0},
			{str = "???"},
			{str = "Murasame", clr = 3, halign = 0},
			{str = "Allows Angel rooms to be appeared. Also 100% chance for either Devil or Angel rooms."},
			{str = "Goat Head/Eucharist", clr = 3, halign = 0},
			{str = "100% chance for 'devil' rooms. Angel rooms will not appear unless Isaac has Duality, Wakaba's Blessing, or White Joker."},
			{str = "Sacred Orb", clr = 3, halign = 0},
			{str = "Only Items with a quality of 2 will spawn. The effect of Wakaba's Nemesis will be nullified when all items with a quality of 2 are exhausted"},
			{str = "Tainted Eden", clr = 3, halign = 0},
			{str = "Completely nullifies reroll effect when damaged"},
		},
	},
	
	WAKABA_DUALITY = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "Armor-piercing tears"},
			{str = "- some enemies like Hush have armor, taking less damage than regular enemies"},
			{str = "Upon picking up an item, Isaac gains a +3.6 temporary damage boost."},
			{str = "- The temporary boost fades over 30 seconds."},
			{str = "- The temporary boost stacks, taking more items gains additional +3.6 temporary damage up."},
			{str = "- The temporary boost caps at +30 damage up."},
			{str = "Guarenteed Devil/Angel rooms. An Devil/Angel Room Door will always spawn after every boss fight."},
			{str = "- The spawned door will not disappear when leaving and re-entering the boss room (except in Greed Mode)"},
			{str = "- If Confessional or a Sacrifice Room would give an Angel Room item, it will instead spawn Redemption if it is unlocked. NOTE: This is not 100% consistent."},
			{str = "All collectibles on sale require soul hearts corresponding original devil price."},
			{str = "All collectibles can be picked up without removing other items."},
			{str = "- To prevent softlock, Options in Death Certificate rooms will not be removed."},
			{str = "All penalties by taking damage are removed. See synergies."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item can only be acquired by collecting both Wakaba's Blessing and Wakaba's Nemesis."},
			{str = "Wakaba Duality is considered as Hidden item. It doesn't appear in any item pools, Death Certificate rooms, or by using Spindown Dice."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "There's Options, More Options", clr = 3, halign = 0},
			{str = "Isaac can get both items without removing others."},
			{str = "This also applies with all items with indexes, such as Boss Rush items."},
			{str = "Paschal Candle", clr = 3, halign = 0},
			{str = "Taking damage from any sources will not reset the tears up."},
			{str = "Perfection", clr = 3, halign = 0},
			{str = "Taking damage from any sources will not lose Perfection trinket."},
			{str = "Damocles/Vintage Threat", clr = 3, halign = 0},
			{str = "Taking damage from any sources does not count as damage taken for Damocles, and will not give it the chance to fall."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Eden", clr = 3, halign = 0},
			{str = "Completely nullifies reroll effect when damaged"},
		},
	},
	
	BOOK_OF_SHIORI = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "Activates additional effect when book active items are being used."},
			{str = "Shiori also gains extra tear effect when book active items are being used."},
			{str = "extra tear effect changes on next book usage."},
			{str = "Spawns a random Book item at the start of every floor."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Shiori and Tainted Shiori starts with this item and is intrinsic to the characters, and it can't be rerolled"},
			{str = "- The book at the start of every floor will not spawn when playing as Shiori or Tainted Shiori."},
			{str = "- Shiori and Tainted Shiori can still find this item on a pedestal. Picking the item allows her to spawn the book."},
			--{str = "Abyss Locust from this item deals 5X of Isaac's Damage."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "- The Bible : Grants Shiori 1.2x Damage multiplier for current room. Gives Godhead Tears until next book use."},
			{str = "- Book of Belial : Adds additional +1.5 Damage up. Gives Eye of Belial tears until next book use."},
			{str = "- The Necronomicon : Spawns 5 Maw of Void lasers dealing 16% of Shiori's Damage. Gives Rock Tears until next book use."},
			{str = "- Book of Shadows : Gives Shielded Tears until next book use."},
			{str = "- Anarchist Cookbook : Troll bombs deals double damage to enemies for current room. Gives Explosive Tears and Shiori is immune to explosions until next book use."},
			{str = "- Book of Revelations : Spawns a Lil Harbringer for current floor. Gives chance to fire Holy Light Tears until next book use."},
			{str = "- Book of Sin : Chance to drop pickups when enemies are killed until next book use."},
			{str = "- Monster Manual : Familiars deal 4x Damage until next book use."},
			{str = "- Telepathy for Dummies : Gives Spectral and Continum Tears for current room. Gives Homing and Electric Tears until next book use"},
			{str = "- Book of Secrets : Fully reveals the map and removes Curse of Darkness and Curse of the Lost. Gives Mark(Rotten Tomato) tears until next book use."},
			{str = "- Satanic Bible : Adds additional +1.0 Damage up for current floor. Gives Dark matter tears until next book use."},
			{str = "- Book of the Dead : Spawns additional friendly Bonies. Gives Death's Touch Tears until next book use."},
			{str = "- Lemegeton : Chance to absorb random wisp into item. Gives Chance to drop batteries when enemies are killed until next book use."},
		},
		{ -- Synergies
			{str = "Synergies(PW)", fsize = 2, clr = 3, halign = 0},
			{str = "- Book of the Forgotten : Gives Bone Tears until next book use."},
			{str = "- D6 Plus : Not implemented."},
			{str = "- Wakaba's Double Dreams : No effect."},
			{str = "- Book of Focus : Ignores Enemy's armor when not moving. Resets Shiori's Tear bonus."},
			{str = "- Shiori's Bottle of Runes : Gives Chance to drop runes when enemies are killed until next book use."},
			{str = "- Micro Doppelganger : Significantly decreases amount of damage taken for Minisaac until next book use."},
			{str = "- Book of Silence : Prevents all enemy projectiles for extra 2 seconds. Resets Shiori's Tear bonus."},
			{str = "- Grimreaper Defender : Until next book use, Gives Temporary Black Spirit Sword. The Scythe tears will be fired instead of sword projectile."},
			{str = "- Book of the Fallen : No effect / Currently unimplemented."},
			{str = "- Book of Trauma : No effect / Currently unimplemented."},
		},
	},
	
	EATHEART = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "This item charges when Isaac deals damage to enemies rather than by clearing rooms or picking up batteries. It requires a total of 7500 damage dealt to fully charge."},
			{str = "- This item also charges when Isaac takes damage. It requires a total of 48 full hearts of damage dealt to fully charge."},
			{str = "- Picking batteries will have no effect."},
			{str = "- This item can be used when charge is fully charged or more."},
			{str = "- This item can be overcharged even Isaac does not have The Battery."},
			{str = "Wakaba Variant", clr = 3, halign = 0},
			{str = "Upon Use, Spawns a random collectible item from current item pool."},
			{str = "- Items with a quality of 3+ are guaranteed to be spawned."},
			{str = "- High quality of items that will be spawned for high charges."},
			{str = "- Items with a quality of 4 are guaranteed to be spawned on double charges."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Wakaba starts with this item."},
			{str = "- Eat Heart is the only way to get Items with a quality of 3+ as Tainted Wakaba."},
			{str = "Eat Heart is unlocked by defeating Delirium as Tainted Wakaba."},
			{str = "Eat Heart Locust deals 3.5x faster than normal locust, triple of Isaac's Damage, travels at double speed."},
			{str = "Bulb drains 1/3 of full charges from this item, instead of 2."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Void", clr = 3, halign = 0},
			{str = "Voiding Eat Heart will still spawn item, but no longer spawns guaranteed 3+ quality items."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Wakaba's Blessing", clr = 3, halign = 0},
			{str = "Spawns two collectible items instead of one."},
			{str = "Habit", clr = 3, halign = 0},
			{str = "Doubles charge when Isaac takes damage."},
			{str = "Jumper Cables", clr = 3, halign = 0},
			{str = "Increases Eat Heart charge rate for 25% when Isaac deals damage to enemies."},
			{str = "4.5 Volt", clr = 3, halign = 0},
			{str = "Doubles charge when Isaac deals damage to enemies."},
			{str = "9 Volt", clr = 3, halign = 0},
			{str = "Preserves 8% of charge when used."},
			{str = "The Battery", clr = 3, halign = 0},
			{str = "Preserves 25% of charge when used."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The name of this item was from joke mod of The Binding of Isaac, the binning of isek: aferberts pluss"},
		},
	},
	BOOK_OF_CONQUEST = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Permanently charms non-boss enemies in the current room."},
			{str = "Charmed enemies' health is set to 10x of their max health"},
		},
		{ -- Effects
			{str = "Effects(Shiori)", fsize = 2, clr = 3, halign = 0},
			{str = "The effect is different when playing as Shiori/Tainted Shiori, or having Book of Shiori as other characters.", clr = 3},
			{str = "- Using this item through Bookmark Bag does not activate the item this way."},
			{str = "Upon use, Freezes the room."},
			{str = "Shiori can select enemy to charm by using left sticks or moving keys."},
			{str = "using the active item again will charm the selected enemy at cost of keys."},
			{str = "- charming bosses also requires bombs."},
			{str = "- major/final bosses are immune to this effect."},
			{str = "- Shiori cannot charm the enemy when bombs or keys are not sufficient."},
			{str = "Firing any tears will exit enemy selection, and will not consume any consumables."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Shiori starts with this item."},
			--{str = "Book of Conquest is unlocked by defeating Delirium as Tainted Shiori."},
			{str = "Max 160 cost of enemies can be charmed. Exceeding the cost will kill extra enemies."},
			{str = "- Friendly enemies spawned by another charmed/friendly enemy also take the cost."},
			{str = "Using Ace cards will turn all enemies, including charmed ones to corresponding pickups."},
			{str = "Due to softlock issue or being insta-killed when being charmed, some bosses cannot be charmed."},
			{str = "- Horfnel"},
			{str = "- Great Gideon"},
			{str = "- Visage"},
			{str = "- Rotgut"},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Shiori/Minerva's Aura", clr = 3, halign = 0},
			{str = "Decreases charmed enemies' health to 2x of their max health, but regenerates when inside the aura."},
			{str = "Book of Shiori +", clr = 3, halign = 0},
			{str = "Skeleton Key/Pyro: Allows charm more enemies or bosses."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item is a reference to 'Katsuragi Keima', who is the protagonist of 'The World God only Knows'."},
			{str = "Keima is known as 'God of Conquest' for other people, who raised Visual novel industry."},
			{str = "'God of Conquest' is also for being extremely skilled at conquering every girl in dating sims."},
			{str = "'God of Conquest' is also the name of the website which acts as the guide for various games."},
		},
	},
	MINERVA_AURA = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Emits aura that follows Isaac."},
			{str = "Friendly monsters inside the aura gradually recovers health."},
			{str = "- Friendly monsters can recover up to 2x of their max health."},
			{str = "While Isaac and other players stand inside the aura, grants + 1.5 damage up, + 2.0 tears up, +1.5 range up and homing tears. It also gives Isaac a chance to block damage similar to Infamy."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Shiori starts with this item and is intrinsic to the characters, and it can't be rerolled"},
			{str = "- Tainted Shiori cannot get aura bonus even when she stands inside her own aura."},
			{str = "- Obtaining Birthright will allow Tainted Shiori get aura bonus for her own aura."},
			{str = "- Tainted Shiori can still find this item on a pedestal. Picking the item increases further aura bonuses."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Book of Conquest/Friend Finder/Friendly Ball", clr = 3, halign = 0},
			{str = "Recovers all friendly enemies' health regardelss of source."},
			{str = "Diplopia/Crooked Penny", clr = 3, halign = 0},
			{str = "Duplicating Minerva's Aura increases aura bonuses."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "In 'The World God only knows', there are 6 goddesses known as 'Jupiter Sisters'."},
			{str = "'Minerva', the one who Shiori holds has an ability to buff other goddesses, or prevent entering other entities to protect ones inside her area."},
		},
	},

	LUNAR_STONE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "Grants Extra life."},
			{str = "- Extra lives are not limited as long as Isaac has Lunar Stone."},
			{str = "Reduces max heart limit to 8."},
			{str = "Can no longer store Soul Hearts."},
			{str = "If Lunar Stone is active : ", clr = 3, halign = 0},
			{str = "Gives Damage and Tears up."},
			{str = "- Damage and Tears bonus are max +40% of Isaac's original stats, depending of current Lunar Gauge."},
			{str = "If Isaac gets damaged : ", clr = 3, halign = 0},
			{str = "Lunar Stone is disabled and Lunar Gauge is slowey being depleted."},
			{str = "Lunar Gauge reduce rate gets faster if Isaac gets more hits."},
			{str = "Obtaining Soul Hearts will active Lunar Stone again and slowly recovers Lunar Gauge."},
			{str = "Gives -15% Damage and -10% Tears down."},
			{str = "Emits poison lunar gas that damages enemies. Isaac does not hurt by this gas."},
			{str = "Lunar gauge is be filled for clearing boss room. Still will be decreased though."},
			{str = "If Lunar gauge is depleted completely, Lunar Stone is disappeared."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tsukasa starts with this item and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Tsukasa dies if Lunar gauge is depleted completely."},
			{str = "- Tsukasa can still find this item on a pedestal. Picking the item does nothing."},
			--{str = "Abyss Locust from this item deals 5X of Isaac's Damage."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "In 'Tonikawa', appearently a lunar stone stored inside Chitose's mansion is considered as a real moonstone, which is secured inside a clear cabinet."},
			{str = "In real life, taking moonstone outside U.S. is considered as serious crime, though the stolen ones never came back."},
			{str = "It appears that Tsukiyomi Tokiko was the one that 'borrowed' a moonstone, to show the proof for Tsukasa."},
		},
	},
	CONCENTRATION = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Holding Drop button will make Isaac concentration mode."},
			{str = "While on concentration mode, Isaac cannot move and takes double damage when hit."},
			{str = "If concentration is finished, all normal active items will be fully charged."},
			{str = "If Isaac's health is under 3 hearts, Isaac needs more time to concentrate."},
			{str = "- If concentration is finished with low health, Isaac restores health to 3 hearts."},
			{str = "Concentration charge time increases every time Isaac concentrate."},
			{str = "- This count can be reduced when Isaac clears a room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tsukasa starts with this item and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Tsukasa can still find this item on a pedestal. Picking the item does nothing."},
			--{str = "Abyss Locust from this item deals 5X of Isaac's Damage."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Lunar Stone", clr = 3, halign = 0},
			{str = "Isaac can heal Lunar Gauge using concentration if the gauge is 10% or less."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Concentration is one of abilities from 'Metroid Other M', one of Metroid franchise."},
			{str = "In normal Metroid games, Samus aran(the player) restores her weapon and health by defeating enemies, while on Other M, she needs to concentrate to restore."},
		},
	},
	NASA_LOVER = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a familiar that follows Isaac around shooting electric tears, similar as Jacob's Ladder tears"},
			{str = "This item belongs to the Conjoined set. Collecting three items from this set will transform Isaac into a three-faced version of himself."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Blood Puppy", clr = 3, halign = 0},
			{str = "Blood puppy will be friendly permanently, regardless of its level."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Once Tsukasa defeats Isaac, Tsukasa starts with Lil Nasa and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Only Lil Nasa will follow her, Blood Puppy will not be friendly automatically."},
			{str = "Tsukasa can still find this item on a pedestal. Picking the item allows her to make Bloody Puppy friendly."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Yuzaki Nasa is Tsukasa's husband, with name of 'NASA', as his dad liked the idea that his son would become ' a man who's as vast as space...'."},
			{str = "He hated the fact that he was often mocked for his name. In response to this, he studied a lot with the main target to become a man nobody can make fun of."},
		},
	},
	ELIXIR_OF_LIFE = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind and Unknown immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "Removes invincibility frames."},
			{str = "Regenerates health for fast time if Isaac did not get hit for brief time."},
			{str = "All soul hearts are converted into bone hearts if Isaac can get Heart containers."},
			{str = "If Isaac cannot get Heart containers, Soul Hearts will be recovered until his maximum soul heart count he gotten."},
			{str = "If Stackable Holy Card is applied, Isaac will be given Holy shields as recovery if The Lost, or Lost Curse is applied."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Tsukasa starts with this item and is intrinsic to the character, and it can't be rerolled"},
		},
		--[[ { -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Flash Shift", clr = 3, halign = 0},
			{str = "Can be merged with Flash Shift. No longer needs charge to use sword attack."},
			{str = "Non-charged attacks will only attack enemies with less damage, and break only rock/poop type objects."},
		}, ]]
		--[[ { -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Book of Shiori", clr = 3, halign = 0},
			{str = "The activated book and Maijima Mythology itself will not reset nor change Book of Shiori bonuses."},
		}, ]]
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item references 'The Tale of the Bamboo Cutter', which story details the life of Kaguya-hime, a princess from the Moon who is discovered as a baby inside the stalk of a glowing bamboo plant."},
			{str = "- After she grows, her beauty attracts five suitors seeking her hand in marriage, whom she turns away by challenging them each with an impossible task."},
			{str = "- She later attracts the affection of the Emperor of Japan."},
			{str = "- At the tale's end, Kaguya-hime reveals her celestial origins and returns to the Moon."},
			{str = "- Kaguya-hime gave the emperor the 'elixir of immortality', but without Kaguya-hime, immortality was meaningless, so the emperor ordered his men to burn the elixir."},
			{str = "- Legend has it that the word for immortality, became the name of the mountain, Mount Fuji. It is also said that the kanji for the mountain, which translate literally to 'mountain abounding with warriors'"},
			{str = "- In 'Tonikawa', which was heavily influenced by this tale, The emperor's loyal subject, Iwasaka, ignored his orders and gave elixir to his daughter, Tsukasa."},
		},
	},
	MURASAME = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While held", clr = 3, halign = 0},
			{str = "Spawns a familiar that follows Isaac."},
			{str = "A Devil Room / Angel Room Door will always spawn after every boss fight, excluding first floor and floors after Chapter 4."},
			{str = "- The spawned door will not disappear when leaving and re-entering the boss room."},
			{str = "Angel Rooms can still appear even Isaac takes Devil deal."},
			{str = "On use", clr = 3, halign = 0},
			{str = "Revives one of defeated boss as friendly, and 320 HP."},
			{str = "Only counts from Boss rooms. Regular rooms does not count."},
			{str = "If there are no defeated bosses in Boss Room, Monstro will be summoned."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Tsukasa starts with this item as a passive item and is intrinsic to the character, and it can't be rerolled"},
			--{str = "- Tainted Tsukasa can still find this item on a pedestal. Picking the item allows her to active dash attack."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Tsukasa", clr = 3, halign = 0},
			{str = "Can be merged with Flash Shift. can damage enemies, or break rock/poop type objects."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Book of Shiori + Book of Conquest", clr = 3, halign = 0},
			{str = "The revived bosses from Murasame shares costs for Book of Conquest."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item references the sword 'Murasamemaru' and its guardian 'Murasame' in Senren Banka, by Yuzusoft."},
		},
	},
	FLASH_SHIFT = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "On use, Isaac dashes in moving direction."},
			{str = "While dashing, Isaac is invincible, but cannot damage enemies."},
			{str = "Can dash up to 3 times. Needs to be recharged for 4 seconds if all shifts are used."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Tsukasa starts with this item as a passive item and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Tainted Tsukasa can activate Flash Shift by using attack buttons. Using Flash Shift through this method will dash in firing direction."},
		},
		--[[ { -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Flash Shift", clr = 3, halign = 0},
			{str = "Can be merged with Flash Shift. No longer needs charge to use sword attack."},
			{str = "Non-charged attacks will only attack enemies with less damage, and break only rock/poop type objects."},
		}, ]]
		--[[ { -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Book of Shiori", clr = 3, halign = 0},
			{str = "The activated book and Maijima Mythology itself will not reset nor change Book of Shiori bonuses."},
		}, ]]
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item is one of 'Aeion abilities' in Metroid series. Flash shift is introduced in Metroid Dread."},
			{str = "Flash shift is a great ability for players because of allowing to move a lot faster."},
		},
	},
	RABBIT_RIBBON = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "If any curse is applied, replaces it into new curse."},
			{str = "Curse of Sniper : Replaces Curse of Darkenss, Richer cannot damage enemies in point blank range."},
			{str = "Curse of Labyrinth : Spawns extra special rooms"},
			{str = "Curse of Fairy : Replaces Curse of the Lost, Richer only can see map in limited range (same as spelunker hat)."},
			{str = "Curse of the Magical Girl : Replaces Curse of the Unknown, Soul of the Lost effect is always active, but enemies are weaker."},
			{str = "Curse of Amensia : Replaces Curse of the Maze, If Richer moves a room, there is a chance to make a random cleared room into uncleared."},
			{str = "Curse of the Blind : Simply removes the curse."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Richer starts with this item and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Richer can still find this item on a pedestal. Picking the item does nothing."},
			--{str = "Abyss Locust from this item deals 5X of Isaac's Damage."},
		},
		--[[ { -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Black Candle", clr = 3, halign = 0},
			{str = "No longer gives bonuses, but guarantees Devil/Angel rooms"},
		}, ]]
		--[[ { -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Richer's ribbon is precious for some reason."},
		}, ]]
	},
	SWEETS_CATALOG = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, Gives Isaac one of weapons."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Richer starts with this item by default"},
			--{str = "Abyss Locust from this item deals 5X of Isaac's Damage."},
		},
		--[[ { -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Black Candle", clr = 3, halign = 0},
			{str = "No longer gives bonuses, but guarantees Devil/Angel rooms"},
		}, ]]
		--[[ { -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Richer's ribbon is precious for some reason."},
		}, ]]
	},

	WATER_FLAME = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "On use, consumes nearby passive collectible and spawns extra item wisp that consumed."},
		},
	},

	WINTER_ALBIREO = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Planetariums always appear."},
		},
	},

	CHIMAKI = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "ssssssssssssssss"},
			{str = "ssssssssssssssss"},
		},
	},
	SYNCRO_CANDY = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "ssssssssssssssss"},
			{str = "ssssssssssssssss"},
		},
	},

	BROKEN_TOOLBOX = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "While in uncleared room, Spawns a pickup per second."},
			{str = "All pickups explode if 15 or more on the room."},
		},
	},
	
	-----------------------------------------------------------------------------
	----------------------------- Default Collectibles --------------------------
	-----------------------------------------------------------------------------

	MOE_MUFFIN = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants one full Red Heart container."},
			{str = "Heals 1 additional heart of health."},
			{str = "+1 Damage Up."},
			{str = "+1 Range Up."},
		},
	},
	MYSTERIOUS_GAME_CD = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants one full Red Heart container."},
			{str = "Heals 1 additional heart of health."},
			{str = "+0.16 Speed."},
			{str = "+0.7 tears."},
			{str = "+0.1 Shot Speed."},
			{str = "+0.85 Range."},
			{str = "+0.5 Damage Up."},
			{str = "Rooms will be randomly colorized slightly."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Mysterious Game CD Locust deals 1.7x faster than normal locust, double of Isaac's Damage."},
		},
	},
	D6_PLUS = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Rerolls the items in the room."},
			{str = "Cycle back to their original form after one second."},
			{str = "Effect repeats."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Like Soul of Isaac, Using this item on same pedestal multiple times, the cycle speed increases on 5/9 times."},
			{str = "Although this item is unlocked by default, this item needs to be unlocked for Shiori. Shiori will start with this item by defeating Isaac as Shiori."},
		},
	},
	D6_CHAOS = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Rerolls the items in the room 9 times."},
			{str = "Cycles for insane speed."},
		},
	},
	MAIJIMA_MYTHOLOGY = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When used, a random activated book item effect will be activated."},
			{str = "following items are example of book items:"},
			{str = "- The Bible"},
			{str = "- The Book of Belial"},
			{str = "- Anarchist Cookbook"},
			{str = "- Book of Revelations"},
			{str = "- Book of Shadows"},
			{str = "- Monster Manual"},
			{str = "- The Necronomicon"},
			{str = "- Satanic Bible"},
			{str = "- Telepathy for Dummies"},
			{str = "Modded items will also be activated if the active item has 'book' tag."},
			{str = "Following items are blacklisted and will not be activated:"},
			{str = "- How to Jump"},
			{str = "- Wakaba's Double Dreams"},
			{str = "- Book of Virtues: This item counts as passive item, thus will not be activated."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
		},
		--[[ { -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "- [REP] While Anarchist Cookbook can hurt the player, effects such as Book of Revelations, and The Nail will pay out with more health than is lost long-term."},
		}, ]]
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Book of Shiori", clr = 3, halign = 0},
			{str = "The activated book and Maijima Mythology itself will not reset nor change Book of Shiori bonuses."},
		},
		--[[ { -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The Dead Sea Scrolls are a collection of 981 Hellenistic-period manuscripts found within caves on the north shore of the Dead Sea."},
			{str = "- The pickup quote ''It's a mystery'' references the item's effect, as well as the fact that the real Dead Sea Scrolls are so tattered and eroded that reading them can prove impossible."},
		}, ]]
	},
	LIL_MOE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a familiar that follows Isaac around shooting orbiting tears."},
			{str = "Every tear has random tear effects."},
			{str = "Explosive effect (Explosivo, Ipecac, Fire Mind) is not included."},
			{str = "tear damage scales with Isaac's Damage, dealing least 4 damage."},
			{str = "Fire rate depends on Isaac's Tears stats."},
			{str = "This item belongs to the Conjoined set. Collecting three items from this set will transform Isaac into a three-faced version of himself."},
		},
		{ -- Trivia
				{str = "Trivia", fsize = 2, clr = 3, halign = 0},
				{str = "Moe's true name in Wakaba Girl is 'Tokita Moeko'."},
				{str = "Moe was good at cooking, Blocking anyone trying to cook with her."},
		},
	},
	LIL_SHIVA = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a familiar that follows Isaac around shooting hungry tears."},
			{str = "Lil Shiva's tears decelerate as they travel. Upon stopping or hitting an obstacle, they burst into 8 tears in all directions."},
			{str = "Tears can be fired into other tears to feed them, increasing their damage and the damage of the burst tears."},
			{str = "- If one tear is fed 5 other tears, it will immediately burst."},
			{str = "- The tears will have their damage added together, with the first consumed tear giving additional damage."},
			{str = "- Tears in the burst will deal half the damage the main tear would have."},
			{str = "tear damage scales with Isaac's Damage, dealing least 4 damage."},
			{str = "Tear bursting can also happen from sheer shot size. With sufficiently high damage or several tear-size increasing items, the tears will burst almost immediately after firing."},
			{str = "This item belongs to the Conjoined set. Collecting three items from this set will transform Isaac into a three-faced version of himself."},
		},
		{ -- Trivia
				{str = "Trivia", fsize = 2, clr = 3, halign = 0},
				{str = "Shiva's true name in Wakaba Girl is 'Mashiva Nao'."},
				{str = "Shiva's name is very similar with so-called 'Shiva Dog', After Nao called her as that name."},
				{str = "Shiva also tried shower with extremely cold water to win the certain contest, but failed and got catch a cold."},
				{str = "Shiva later requested Wakaba to join the contest, and Wakaba won the contest."},
		},
	},
	WINTER_ALBIREO = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Removes Jupiter from Item pool."},
			{str = "Add a chance to replace Treasure rooms to planetariums."},
			{str = "If there are no treasure rooms, a random room will be replaced into planetarium."},
			{str = "Planetariums and Treasure rooms are free to enter."},
			{str = "+0.1 Tears, +0.3 Damage up per Planetarium unlock item."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Saya with this item and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Saya can still find this item on a pedestal. Picking the item gives her additional bonus for Planetarium unlock item and increases chance for Planetariums."},
			--{str = "Abyss Locust from this item deals 5X of Isaac's Damage."},
		},
	},
	SEE_DES_BISCHOFS = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- Isaac will respawn as Tainted Tsukasa in the previous room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Resurrection items activate in a set order."},
			{str = "Because characters are respawned as Tainted Tsukasa, The abilities for their original character will be lost."},
			{str = "- Azazel will also lose his short-ranged Brimstone."},
			{str = "- If Lilith is resurrected she will lose Incubus and fire as any other character instead."},
			{str = "- Shiori will also lose all of her books."},
			{str = "Like other items that grant an extra life, but respawn Isaac as a different character, all completion marks earned from the moment of death onward will count towards the new character, not the old."},
		},
	},
	JAR_OF_CLOVER = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- Isaac will respawn as Wakaba in the previous room."},
		},
		{ -- Notes
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Wakaba", clr = 3, halign = 0},
			{str = "Revives as herself, rather than normal wakaba. Effectively acts as 1up!"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Resurrection items activate in a set order."},
			{str = "Because characters are respawned as Wakaba, The abilities for their original character will be lost."},
			{str = "- Azazel will also lose his short-ranged Brimstone."},
			{str = "- If Lilith is resurrected she will lose Incubus and fire as any other character instead."},
			{str = "- Shiori will also lose all of her books."},
			{str = "Like other items that grant an extra life, but respawn Isaac as a different character, all completion marks earned from the moment of death onward will count towards the new character, not the old."},
		},
	},
	DEJA_VU = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "12.5% chance to reroll items into items that Isaac already holds."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item has no item pool reduction, making Deja Vu appearing again if not collected."},
			{str = "The item icon for Deja Vu is exact same as question mark of 'Curse of Blind'."},
		},
	},
	CURSE_OF_THE_TOWER_2 = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac gets Golden Bomb permanently."},
			{str = "Replaces all bomb spawns with a random pickup."},
			{str = "Upon taking damage, spawns a golden troll bomb around the room."},
			{str = "All troll bombs are converted into Golden troll bombs if possible."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Power Bomb", clr = 3, halign = 0},
			{str = "Does not replace bomb pickups while held."},
		},
	},
	SYRUP = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While held", clr = 3, halign = 0},
			{str = "Flight"},
			{str = "0.9x Speed Multiplier"},
			{str = "+3 Range"},
			{str = "+1.25 Damage"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item counts as minor passive item, It takes active slot, but no effect on usage."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Syrup is a turtle pet from light novel/anime Bofuri, or 'Welcome to I Don't Want to Get Hurt, so I'll Max Out My Defense'."},
			{str = "Maple, who is Syrup's owner, met syrup by defeating extreme boss 'Silverwing' by matching party with Sally, who is super expert player by using her controls."},
			{str = "Syrup is one of the mythical beasts that had their eggs hidden in the game."},
			{str = "Normally, Syrup is incapable of flight, but Maple combined the skill and the game's system to make it fly, she even got a skill just to fly with it."},
		},
	},
	ONSEN_TOWEL = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants one Soul Heart when picked up."},
			{str = "Isaac has a chance to regenerate a Half Soul Heart every time the in-game timer hits a new minute (00:01:00, 00:02:00, etc)."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The regeneration can happen multiple times in the same room, so there is no need to move between rooms to continue regeneration."},
			{str = "- However, regeneration does not occur when standing in a Crawl Space."},
			{str = "Regeneration will only occur when Isaac can have Soul hearts:"},
			{str = "- Keeper's and Tainted Keeper's coin hearts will not regenerate, instead, a blue fly will be spawned instead."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Gnawed Leaf: Allows Isaac to safely regenerate in any room."},
		},
	},
	
	-----------------------------------------------------------------------------
	------------------------------- Wakaba Unlocks ------------------------------
	-----------------------------------------------------------------------------

	BOOK_OF_FORGOTTEN = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Gives a Bone Heart."},
			{str = "Fully heals Isaac."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Book of Forgotten Locust deals 3.5x faster than normal locust, double of Isaac's Damage, travels at double speed."},
		},
	},
	D_CUP_ICECREAM = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants one full Red Heart container."},
			{str = "Heals 1 additional heart of health."},
			{str = "x1.8 damage multiplier."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "D-Cup Ice-Cream Locust deals 1.2x faster than normal locust, double of Isaac's Damage."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Binge Eater", clr = 3, halign = 0},
			{str = "D-Cup Ice-cream can be appeared in the food section. Taking the ice-cream will give additional +0.75 Damage."},
			{str = "- D-Cup Ice-cream will be appeared in the food section even it is not unlocked."},
		},
	},
	MINT_CHOCO_ICECREAM = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "x2 fire rate multiplier."},
		},
	},
	WAKABAS_PENDANT = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Sets to 7 Luck if Luck is lower than 7."},
			{str = "+0.35 Luck up per Luck affect items."},
			{str = "+1 Damage."},
			{str = "Restores all Health."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Wakaba will not grant any of luck ups. +4 Damage up will be applied instead."},
			{str = "3 locusts appear when Abyss Wakaba's Pendant."},
			{str = "Wakaba's Pendant Locust deals 1.7x faster than normal locust."},
		},
	},
	WAKABAS_HAIRPIN = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+0.25 Luck up per pill use."},
			{str = "+1 Damage."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Wakaba will not grant any of luck ups. +0.25 Damage up per pill usage will be applied instead."},
		},
	},
	SECRET_CARD = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+22 Coins."},
			{str = "Coins will be generated per room cleared."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "2 locusts appear when Abyss Secret Card."},
			{str = "Secret Card Locust deals 7x faster than normal locust, 0.8x Isaac's Damage, drops coins when dealing damage."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Deep Pockets", clr = 3, halign = 0},
			{str = "Allows Isaac store more coins."},
		},
	},
	REVENGE_FRUIT = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Adds a chance to shoot Brimstone Lasers."},
			{str = "- Chance increases every time you get hit. this resets when entering the new floor."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Brimstone", clr = 3, halign = 0},
			{str = "No longer gain chance to fire additional laser, instead 1.25x Damage multiplier will be applied."},
			{str = "Wakaba's Blessing", clr = 3, halign = 0},
			{str = "2x chance for Lasers, Grants Homing Lasers."},
		},
	},
	UNIFORM = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, stores/swaps current card, pill, or rune."},
			{str = "- Holding Map button shows current uniform status"},
			{str = "- Drop button changes which slot to store/swap"},
			{str = "When Isaac uses a card, pill, or rune, he also uses a copy of every card/pill/rune stored in Wakaba's Uniform"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "single effect can be stacked by storing same card, pill, or rune in different slot."},
			{str = "- this can be powerful for stacking effects like the black rune or balls of steel."},
			{str = "Tainted Lost starts with this item by completing Draw Five Challenge, even it is not unlocked."},
			{str = "5 locusts appear when Abyss Wakaba's Uniform."},
			{str = "Wakaba's Uniform Locust deals 2.3x faster than normal locust, drops card when killed by the locust."},
		},
		{
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Schoolbag", clr = 3, halign = 0},
			{str = "As isaac needs to hold uniform constantly on his active item slot, schoolbag allows use another active item besides Wakaba's Uniform"},
			{str = "+ D1: copies dropped Card/Pill/Rune, allowing to stack single effect multiple times"},
			{str = "+ Deck of Cards/Mom's Bottle of Pills/Shiori's Bottle of Runes", clr = 3, halign = 0},
			{str = "Faster build speed for Wakaba's Uniform."},
		},
		{ -- Synergies
			{str = "Uniform Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Holy Card", clr = 3, halign = 0},
			{str = "Activates Holy Card every time Isaac uses Card/Pill. This is very effective for Tainted Lost."},
			{str = "Schoolbag + Blank Card + Rules Card", clr = 3, halign = 0},
			{str = "Allows using every stored card, pill, or rune effect for 1 room."},
			{str = "Ancient Recall, Vurp pill", clr = 3, halign = 0},
			{str = "Can be used to spawn infinite cards."},
			{str = "+ Schoolbag + R Key + ? Card: The ? Card effect can be used in conjunction with R Key without consuming it"},
			{str = "Blank Rune", clr = 3, halign = 0},
			{str = "not only Random rune effect will occur, but also has a chance to drop another Blank rune for continous use."},
			{str = "- stacking multiple Blank Runes can drop multiple blank runes. as Jera effect can copy the runes."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The idea of this item was from 'nerfing' echo chamber, by making echo chanber as an active item."},
			{str = "- unlike echo chamber, Wakaba's uniform only stores 5 effects instead of all."},
			{str = "- however, Wakaba's uniform can remove unwanted effects like teleport cards by swapping with held cards."},
		},
	},
	COUNTER = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Makes Isaac invincible for 1 second."},
			{str = "Fires lasers to enemies while invincible."},
			{str = "This item automatically activates when taking damage. Activating the item this way will also prevent Isaac to be damaged."},
			{str = "Does not fire lasers when other shields are active."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Void", clr = 3, halign = 0},
			{str = "Loses automatic activation when voided, Makes Isaac invincible for 20 seconds instead."},
		},
	},
	RETURN_POSTAGE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "All selected enemies become charmed permenantly."},
			{str = "This includes : Needle, Pasty, Dust, Polty, Kineti, Mom's Hand."},
			{str = "All Eternal Flies are removed."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The included enemies are the mostly hated enemies among the players, especially as The Lost, as they pop up out of nowhere, easily being killed by them."},
		},
	},
	
	
	-----------------------------------------------------------------------------
	------------------------------- Shiori Unlocks ------------------------------
	-----------------------------------------------------------------------------

	BOOK_OF_FOCUS = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "On use, Weakens all enemies in the current room."},
			{str = "If Isaac is not moving manually, Isaac shoots Homing and Spectral tears with +1.4 Damage and +1.0 Tears."},
			{str = "Isaac will also take at least 2 Full Heart Damage in the current room."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "XI - Strength?", clr = 3, halign = 0},
			{str = "Does not stack weakness effect."},
		},
	},
	DECK_OF_RUNES = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Gives Isaac a rune upon use."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Shiori can hold this jar despite the fact that this is 'technically' not a book, However, this item is considered as a book item."},
		},
		{ -- Synergy
			{str = "Synergy", fsize = 2, clr = 3, halign = 0},
			{str = "Starter deck ", clr = 3, halign = 0},
			{str = "Isaac can hold two runes."},
		},
	},
	GRIMREAPER_DEFENDER = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Prevents death and all damage taken is reduced to half a heart for current room."},
			{str = "all damage takes red hearts first and prevents penalty damage."},
			{str = "- The effect will be ignored when use of Sacrifice room spikes."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
		},
		--[[ { -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Shiori can hold this jar despite the fact that this is 'technically' not a book, However, this item is considered as a book item."},
		}, ]]
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Paschal Candle", clr = 3, halign = 0},
			{str = "Taking damage from any sources while in effect will not reset the tears up."},
			{str = "Perfection", clr = 3, halign = 0},
			{str = "Taking damage from any sources while in effect will not lose Perfection trinket."},
			{str = "Damocles/Vintage Threat", clr = 3, halign = 0},
			{str = "Taking damage from any sources while in effect does not count as damage taken for Damocles, and will not give it the chance to fall."},
			{str = "Damocles", clr = 3, halign = 0},
			{str = "For Damocles, Even if got hit for penalty damage, as long as holding Grimreaper Defender, it will protect Isaac from falling sword. This sacrifices Grimreaper Defender itself."},
			{str = "Tainted Eden", clr = 3, halign = 0},
			{str = "Taking any damage while in effect will not occur reroll effect as long as the effect of Grimreaper Defender is active."},
		},
	},
	BOOK_OF_SILENCE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Removes all enemy projectiles."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
		},
	},
	VINTAGE_THREAT = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- Isaac will respawn as Tainted Shiori in the current room."},
			{str = "After resurrected as Tainted Shiori, She gains 12 black hearts, but loses all her keys, and 3 Vintage Damocles swords will be automatically activated."},
			{str = "After Tainted Shiori gets hit once, the sword falls instantly, instantly killing Tainted Shiori regardless of her health."},
			{str = "- Self-damage (such as from a Blood Bank, Devil Beggar, Curse/Sacrifice room, or self-damage Active Items) or having Penalty-Damage protection(such as Wakaba's Blessing/Nemesis, or During effect of Grimreaper Defender) does not count as damage taken for Vintage Damocles, and will not fall."},
			{str = "Extra Life items such as Dead Cat will not activate after resurrected as Tainted Shiori.", clr = 3},
			{str = "Even when playing as CO-OP, Dying from this item ends the run regardless of remaining players.", clr = 3},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Resurrection items activate in a set order. Vintage Threat is the last order."},
			{str = "Because characters are respawned as Tainted Shiori, The abilities for their original character will be lost."},
			{str = "- Azazel will also lose his short-ranged Brimstone."},
			{str = "- If Lilith is resurrected she will lose Incubus and fire as any other character instead."},
			{str = "- Shiori will also lose all of her books."},
			{str = "Like other items that grant an extra life, but respawn Isaac as a different character, all completion marks earned from the moment of death onward will count towards the new character, not the old."},
		},
	},
	BOOK_OF_THE_GOD = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- Isaac will be resurrected as Angel form when the damage is lethal in the current room."},
			{str = "After resurrected as angel :", clr = 3, halign = 0},
			{str = "-50% Damage Down."},
			{str = "Tears gain a damaging aura."},
			{str = "Isaac is unable to get any hearts."},
			{str = "Taking any damage gives Isaac Broken heart."},
			{str = "At 12 Broken Hearts, Isaac dies."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac Cannot get Sacrifice room rewards when turning into angel."},
			{str = "The damaging aura gets bigger with items that make tears bigger, e.g. Cricket's Head, Polyphemus, and Pupula Duplex."},
			{str = "The aura deals Isaac's current damage per tick, and ticks a total of 15 times per second."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Wakaba", clr = 3, halign = 0},
			{str = "Broken hears no longer will be fixed when revived as the Angel. Wakaba will get Broken Heart on taking damage like other characters."},
			{str = "Book of the Fallen", clr = 3, halign = 0},
			{str = "Book of the God takes the priority on resurrection. On Death after being Angel, Isaac does not grant 6 black hearts, but all broken hearts will be removed."},
		},
	},
	BOOK_OF_THE_FALLEN = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- While held, Isaac will be resurrected as Fallen Angel form when the damage is lethal in the current room."},
			{str = "- Isaac gets 6 black hearts on resurrection."},
			{str = "After resurrected as fallen angel :", clr = 3, halign = 0},
			{str = "- Isaac is unable to shoot tears."},
			{str = "- 18x Damage Multiplier."},
			{str = "Isaac can no longer swap active items."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
			{str = "Due to modifying Blindfolded status, This item is considered as Plot-Critical item."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Cain", clr = 3, halign = 0},
			{str = "Tainted Cain still can shoot tears even on revival. However, will not gain 18x Damage Multiplier."},
			{str = "D4/D100/Tainted Eden", clr = 3, halign = 0},
			{str = "This item will not be rerolled through Full reroll effect, including Tainted Eden."},
			{str = "Rosary", clr = 3, halign = 0},
			{str = "As Rosary adds The Bible to all item pools, Picking up Rosary makes Isaac getting less items."},
			{str = "- Isaac must pick up The Bible before being resurrected as fallen angel."},
			{str = "Book of the God", clr = 3, halign = 0},
			{str = "Book of the God takes the priority on resurrection."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "No!", clr = 3, halign = 0},
			{str = "Rerolls Active items on pedestals, making Isaac to get more items."},
			{str = "Maw of the Void/Revelation", clr = 3, halign = 0},
			{str = "Due to 18x Damage Multiplier, Lasers deal extreme damage."},
			{str = "Fly generating items", clr = 3, halign = 0},
			{str = "Blue flies/spiders/locusts deal extreme damage."},
		},
	},
	BOOK_OF_TRAUMA = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Once activated, maximum of 7 player tears explode."},
			{str = "- Isaac is immune to this explosion."},
			{str = "- Explosion ignores enemy's armor."},
			{str = "- Explosion also activates Brimstone Bombs effect. which bursts into Brimstone lasers in 4 directions."},
			{str = "- Luck-based effects from items such as Tough Love or Holy Light are applied individually to each tear."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Book of Trauma becomes useless with the following, barring other sources of tears:"},
			{str = "- Azazel"},
			{str = "- Blindfolded"},
			{str = "- Brimstone"},
			{str = "- Dr. Fetus"},
			{str = "- Epic Fetus"},
			{str = "- Mom's Knife"},
			{str = "- Tech X"},
			{str = "- Technology"},
			{str = "- Technology 2"},
		},
	},


	
	-----------------------------------------------------------------------------
	------------------------------- Tsukasa Unlocks -----------------------------
	-----------------------------------------------------------------------------

	RED_CORRUPTION = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "When entering new floor, generates new rooms adjacent special rooms if possible."},
			{str = "All special rooms except Boss rooms will be turned into red rooms."},
			{str = "Reveals the locations and types of all special rooms on the map."},
			{str = "- All special rooms created from Red Corruption will also be revealed."},
			{str = "No effect on ???/Home."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "All special rooms that turned into red rooms will do behave differently."},
			{str = "- All special rooms that require key will show same door images."},
			{str = "- Challenge/Boss Challenge rooms will always open regardless of health."},
			{str = "Due to issues from Modding API, some rooms may not created correctly. Doors that is not created correctly may lead to I AM ERROR room."},
		},
	},
	ARCANE_CRYSTAL = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+12% Damage Multiplier"},
			{str = "Homing tears"},
			{str = "70% chance to take extra damage for enemies"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The three crystals are from the idle game 'My Archmage' from 'Mind Blossom'."},
			{str = "During the Magicisn's journey, She could find three crystals from the dimensional dungeon."},
			{str = "The dimensional dungeon is used to grind various equipments for the Magician. Three crystals could be dropped for extreme low rate."},
			{str = "The three crystals are more powerful than other equipments, giving additional effects for Magician."},
		},
	},
	ADVANCED_CRYSTAL = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+14% Damage Multiplier"},
			{str = "Piercing tears"},
			{str = "25% chance to take armor-piercing damage for enemies"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The three crystals are from the idle game 'My Archmage' from 'Mind Blossom'."},
			{str = "During the Magicisn's journey, She could find three crystals from the dimensional dungeon."},
			{str = "The dimensional dungeon is used to grind various equipments for the Magician. Three crystals could be dropped for extreme low rate."},
			{str = "The three crystals are more powerful than other equipments, giving additional effects for Magician."},
		},
	},
	MYSTIC_CRYSTAL = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+16% Damage Multiplier"},
			{str = "Glowing tears"},
			{str = "Getting soul hearts beyond limit activates Holy Card effect (Max 5)"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The three crystals are from the idle game 'My Archmage' from 'Mind Blossom'."},
			{str = "During the Magicisn's journey, She could find three crystals from the dimensional dungeon."},
			{str = "The dimensional dungeon is used to grind various equipments for the Magician. Three crystals could be dropped for extreme low rate."},
			{str = "The three crystals are more powerful than other equipments, giving additional effects for Magician."},
		},
	},
	NEW_YEAR_BOMB = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+9 Bombs."},
			{str = "Enemies' Health hit by explosion of this bomb will set to 1."},
			{str = "- Enemies no longer be killed from this explosion."},
			{str = "-- This also includes Shopkeepers."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Dr.Fetus, Epic Fetus", clr = 3, halign = 0},
			{str = "Enemies will be immune to fetus bombs."},
			{str = "- As Isaac can no longer kill any enemies, Isaac must find another attack method to finish the enemy."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item is inspired from 'New Year Eve's Bomb' from MOTHER 3."},
			{str = "- Original item didn't affect bosses compared to this item."},
			{str = "- In MOTHER 3, Porky's Statue was not considered as a boss. as a result, Even with highest health in the game, Porky's Statue can be beaten almost instantly."},
		},
	},
	PLASMA_BEAM = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+2 Range"},
			{str = "-40% Damage"},
			{str = "Grants piercing tears that travel through enemies (but not obstacles) instead of breaking on impact with them."},
			{str = "Tears can hit the same enemy multiple times."},
			{str = "Tears inflict burn to enemies."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Since the tears can strike one enemy multiple times, low shot speed can be very beneficial whereas high shot speed may lower effective damage."},
			{str = "Walking backward while firing can allow tears to move slower, making it useful for increasing damage output."},
		},
		--[[ { -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "8 Inch Nails / Blister / Pisces", clr = 3, halign = 0},
			{str = "Adds knockbacks to tears."},
		}, ]]
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Plasma Beam is one of the strongest beam through entire Metroid series."},
			{str = "Plasma Beam is first introduced in Metroid II - The Return of Samus. Plasma Beam in 2D Metroid series has abilty to pierce enemies."},
			{str = "Plasma Beam had got huge buff from Metroid Fusion, allowing a single beam hitting same enemy multiple times, and even piercing bosses."},
			{str = "Plasma Beam in 3D Metroid series also had burning effect for various enemies."},
		},
	},
	BEETLEJUICE = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Identifies all pills on pickup"},
			{str = "When used, Randomizes 6 pill effects for current run"},
			{str = "While held, An extra pill can spawn on room clears."},
			{str = "- Chance for spawning extra pill is 20%, does not affected by luck."},
		},
	},
	PHANTOM_CLOAK = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "On use, Makes Isaac invisible for short time."},
			{str = "All enemies targeting Isaac will be confused while Isaac is invisible."},
			{str = "Moving or firing tears reduces time faster."},
			{str = "Challenge room doors are open while in invisible."},
			{str = "Even in invisiblity, Isaac still takes damage when getting hit."},
			{str = "Isaac cannot use the item unless the item is recharged."},
			{str = "Timer only can be recharged by moving or firing."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item is one of 'Aeion abilities' in Metroid series. Phantom Clock is introduced in Metroid Dread."},
			{str = "Phantom Clock emphasizes hiding the user from danger. In Metroid Dread, Phantom Clock is used in certain area, where is occupied by a certain mechanic, which insta-kills the player when touched."},
		},
	},
	POWER_BOMB = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While held", clr = 3, halign = 0},
			{str = "Isaac cannot use normal bombs."},
			{str = "Killing enemies have 7% chance to drop bombs that disappears after 1.5 seconds."},
			{str = "Isaac must have 10 or more bombs to use the item."},
			{str = "On use", clr = 3, halign = 0},
			{str = "Consumes half of Isaac's bombs and Makes an explosion in entire room."},
			{str = "- Bombs are less consumed when Isaac has golden bombs."},
			{str = "All enemies take damage 0.2 x consumed bomb count per tick."},
			{str = "All doors and rock obstacles also destroyed during this process."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Power Bomb is one of most famous powerup in Metroid series."},
			{str = "In most Metroid series, Power bomb damages 300 damage per tick, total 600."},
			{str = "Power Bomb in later series also used as other usage, such as revealing hidden blocks which weapon is able to break."},
		},
	},
	QUESTION_BLOCK = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "On use, Spawns a collectible item by 25% chance."},
			{str = "Magic Mushroom is guaranteed to be spawned if Isaac does not have it."},
			{str = "Taking penalty damage while holding this item will lose Magic Mushroom. Taking the damage while not having mushroom makes Isaac turning to The Lost for current room."},
		},
		{ -- Notes
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Question blocks are one of the most common type of blocks from 'Super Mario' franchise."},
			{str = "Question blocks tend to give the player coins, but certain blocks gives powerups. The Super Mushroom, then Fire Flower. Taking damage reverts to non-powered state, then small state."},
			{str = "In Modern era, Question blocks can hold almost everything, not limits to gimmics, but also enemies."},
		},
	},
	MAGMA_BLADE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Slashes fire blade on tear attack"},
			{str = "+100% Damage multiplier for non-tear attacks"},
		},
	},
	LUNAR_DAMOCLES = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "After using Soul of Tsukasa, summons a sword that hangs directly above Isaac. As long as the sword hangs above Isaac, all item pedestals and items spawned from Machines and Beggars are doubled, spawning an additional, free item next to them."},
			{str = "- The extra item spawned will be pulled from the current room's item pool."},
			{str = "- Mega Chests will also spawn an extra item if they contained items."},
			{str = "After Isaac gets hit once with the item activated, at any time without warning, the sword may fall, removing half of Isaac's items. The sword has a 1/2500 chance every 4 frames to fall."},
			{str = "- Self-damage (such as from a Blood Bank, Devil Beggar, Curse/Sacrifice room, or self-damage Active Items) does not count as damage taken for Damocles, and will not give it the chance to fall."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The chance for the sword to fall does not increase beyond the first hit taken."},
			{str = "In scenarios that have multiple items to choose from (such as double Treasure Rooms and Boss Rush), an additional set of items for Isaac to choose from spawns. Only one item from each set can be taken."},
		},
		--[[ { -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Metronome: Can invoke the effect of Damocles, which will apply permanently."},
			{str = "Blood Oath: Getting stabbed by Blood Oath does not trigger the chance of falling."},
			{str = "Kamikaze!: Blowing yourself up does not trigger the chance of falling."},
			{str = "Isaac's Heart: Taking damage still allows it to fall, and the sword will still kill Isaac if it falls."},
			{str = "D4/ D100: The sword does not get rerolled."},
			{str = "Clicker: The sword cannot be removed from Isaac's inventory."},
			{str = "Genesis: The sword does not get removed going to the unique Bedroom. It will then cause all the options to generate 3 additional items that can be taken for free, effectively quadrupling Isaac's items. Bonus active items can spawn on top of each other, making items next to them unobtainable."},
			{str = "Butter!: Getting hit may cause Isaac to drop the sword, removing the effect and chance of falling."},
			{str = "Tainted Isaac: Damocles does not count toward his passive item count, and cannot be removed."},
			{str = "Jacob and Esau: The sword will only gain the chance to fall if the brother who used it takes damage."},
			{str = "Tainted Lazarus: The character that used Damocles must be active for double items to spawn."},
			{str = "- In the case of Boss Rooms, the character that did not use Damocles must fight the boss for it to drop double items."},
			{str = "Tainted Forgotten: The sword will hang over Tainted Forgotten's body but will still kill the character despite being invincible."},
			{str = "Panic Button: Does not activate when the sword falls on Isaac."},
			{str = "Holy Mantle: Does not protect Isaac from death when the sword falls."},
		}, ]]
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Diplopia/ Crooked Penny: An extra item is spawned per each item cloned."},
			{str = "Magic Skin: Spawns 2 items on every use instead of 1."},
			{str = "Unicorn Stump / My Little Unicorn / other items that give invulnerability: If active, will negate the sword's fall killing Isaac."},
		},
	},
	EASTER_EGG = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "When picking up a purple coin for the first time, a ghostly rainbow sphere orbit around Isaac."},
			{str = "- Rainbow sphere shoot homing, spectral tears that do 1 damage."},
			{str = "Picking multiple purple coins make rainbow sphere deal more damage, and shoot tears more frequently."},
		},
	},

	
	-----------------------------------------------------------------------------
	------------------------------- Richer Unlocks ------------------------------
	-----------------------------------------------------------------------------

	
	DOUBLE_INVADER = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+250% Damage Multiplier"},
			{str = "- +100% Damage Multiplier per extra copy"},
			{str = "Devil/Angel rooms no longer appear."},
		},
	},
	_3D_PRINTER = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "On use, Duplicates and smelts current held trinket."},
		},
	},
	CLENSING_FOAM = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Removes champion and Applies poison to enemies in a small radius around Isaac."},
		},
	},
	ANTI_BALANCE = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Converts all pills into Horse variant."},
			{str = "Pills that are present already also being converted."},
		},
	},
	VENOM_INCANTATION = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+1 Damage"},
			{str = "If an enemy takes damage with Poison/Burn, it will be killed instantly for 5% chance."},
			{str = "- Instakill chance does not scale with luck"},
			{str = "- Non-major Bosses have 1.36% chance instead of 5%"},
			{str = "- Major Bosses are immune to this effect"},
			{str = "This item belongs to the Spun set. Collecting three items from this set will transform Isaac into buff berserker."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Although the item gives powerful effect for Poison/Burn status effect, this item does not have any of them."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Toxic Shock/Acid Baby", clr = 3, halign = 0},
			{str = "Every tick damage has a chance to instakill an enemy"},
			{str = "Scorpio", clr = 3, halign = 0},
			{str = "Every tear has poison effect, resulting higher chance to instakill an enemy"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Venom Incantation is Maple's high-valuable skill that instakills an enemy by 10% chance if the attack has poison."},
			{str = "After the acknowlegement of Maple's poison-based skills, most people learned poison resistant skills to compete against Maple, Venom Incantation ignores poison resistance however."},
		},
	},
	FIREFLY_LIGHTER = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+2 Range"},
			{str = "+1 Luck"},
			{str = "Grants Curse of Darkenss immunity"},
		},
	},
	CARAMELLA_PANCAKE = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- Isaac will respawn as Richer in the previous room."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Richer", clr = 3, halign = 0},
			{str = "Revives as herself, rather than normal Richer. Effectively acts as 1up!"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Resurrection items activate in a set order."},
			{str = "Because characters are respawned as Richer, The abilities for their original character will be lost."},
			{str = "- Azazel will also lose his short-ranged Brimstone."},
			{str = "- If Lilith is resurrected she will lose Incubus and fire as any other character instead."},
			{str = "- Shiori will also lose all of her books."},
			{str = "Like other items that grant an extra life, but respawn Isaac as a different character, all completion marks earned from the moment of death onward will count towards the new character, not the old."},
		},
	},
	CUNNING_PAPER = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants a random card that transforms into a different random card upon use."},
			{str = "Each card has a 2 room charge."},
		},
	},
	PRESTIGE_PASS = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a restock machine in Boss, Devil, Angel rooms, Planetariums, Secret, Ultra Secret rooms, and Black markets."},
			{str = "Boss rooms need to be cleared to spawn restock machine."},
		},
	},
	TRIAL_STEW = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "This item can be only activated through cards, it doesn't appear in any item pools or death certificate rooms."},
			{str = "On use, Removes all health and Holy Mantle shields and fully charges active items."},
			{str = "+8 Fire rate, +100% Damage as long as Isaac has only half heart and no shields."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Blank Card", clr = 3, halign = 0},
			{str = "Requires 8 charges to use. Does NOT recharges Blank Card itself if used by Blank Card"},
			{str = "Holy Mantle, Blanket, Holy Card, Priest's Blessing, Wakaba's Blessing", clr = 3, halign = 0},
			{str = "Fire rate, Damage bonus will be gone as soon as Isaac recovers shield."},
			{str = "Elixir of Life / Tainted Tsukasa", clr = 3, halign = 0},
			{str = "After use, Automatic refill will not work until the effect goes off."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Tarot Card", clr = 3, halign = 0},
			{str = "Additional +1 Fire rate, and +25% damage bonus is granted."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Trial Stew is one of challenging items from 'Paper Mario : The Thousand Year Door', one of famous RPG titles from Mario series."},
			{str = "Using Trial Stew in PM : TTYD reduces player's HP to 1, and FP to 0, but refills all star powers, which allows to use special moves."},
		},
	},

	
	-----------------------------------------------------------------------------
	-------------------------------- Rira Unlocks -------------------------------
	-----------------------------------------------------------------------------



	-----------------------------------------------------------------------------
	------------------------------- Tainted Items -------------------------------
	-----------------------------------------------------------------------------


	-----------------------------------------------------------------------------
	------------------------------- Challenge Unlocks ---------------------------
	-----------------------------------------------------------------------------

	LIL_WAKABA = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a familiar that follows Isaac around shooting Tech.X lasers."},
			{str = "Lil Wakaba's fire rate depends on Isaac's tear stats."},
			{str = "Lasers' damage is 40% of Isaac's Damage."},
			{str = "This item belongs to the Conjoined set. Collecting three items from this set will transform Isaac into a three-faced version of himself."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "lil Wakaba Locust deals 1.3x faster than normal locust, travels 3x speed."},
		},
	},
	LIL_MAO = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns an little Mao familiar. It cannot move on its own, butcan be picked up when Isaac touches her."},
			{str = "Touching her will make Isaac pick her up, pressing shoot button to throw her."},
			{str = "A small circle laser will be around her, which can deal 40% of Isaac's Damage per tick."},
			{str = "This item belongs to the Conjoined set. Collecting three items from this set will transform Isaac into a three-faced version of himself."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Baby Bender", clr = 3, halign = 0},
			{str = "Her circle laser becomes homing. In addition, Lil Mao herself also chases into nearby enemy."},
		},
		{ -- Trivia
				{str = "Trivia", fsize = 2, clr = 3, halign = 0},
				{str = "Mao's true name in Wakaba Girl is 'Kurokawa Mao'."},
				{str = "She was longing for the 'Lady', as opposed to Wakaba."},
		},
	},
	EYE_OF_CLOCK = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "3 Tech. X lasers orbit Isaac."},
			{str = "Lasers' damage scales with Damage stats."},
			{str = "- Laser Damage : Damage * 0.4"},
			{str = "Holding fire button also fires additional lasers from each orbiting Tech.X lasers."},
			{str = "- All orbiting lasers and additional lasers inherit Isaac's tear effects."},
		},
	},
	NEKO_FIGURE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "x0.9 Damage Multiplier."},
			{str = "Isaac's attacks now ignore armor."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Getting more than 1 Neko Figures nullifies damage down, only leaves armor ignore ability."},
		},
	},
	MICRO_DOPPELGANGER = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Summons 12 micro-Isaac familiars."},
			{str = "- Shiori and Tainted Shiori only summons 3 Minisaacs."},
			{str = "- See 'Giant Cell' item for more informations."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "3 locusts appear when Abyss Micro Doppelganger."},
			{str = "Micro Doppelganger Locust deals 7x faster than normal locust, 0.9x Isaac's Damage, travels 3x speed."},
		},
		{ -- Notes
			{str = "Doppelganger", fsize = 2, clr = 3, halign = 0},
			{str = "In Doppelganger challenge, Shiori only starts with this book, and Shiori has to guide Minisaacs through rooms."},
			{str = "Using this book only summons 1 Minisaac."},
			{str = "Unlike Book of Shiori bonus, Minissacs are immune to all damage in Doppelganger challenge."},
			{str = "Completing Doppelganger challenge unlocks this item. This item needs to be unlocked even for Shiori."},
		},
	},
	PLUMY = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Summons Baby Plum to fight for Isaac."},
			{str = "- Baby plum will always twirl, jump, then spit blood and bounce around the room."},
			{str = "- Baby plum does 12 contact damage per tick (24 per second), 3.5 damage per shot, and 2 damage per tick with creep (20 per second)."},
			{str = "This item belongs to the Beelzebub set. Collecting three items from this set will transform Isaac into a giant humanoid fly."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Plumy Locust deals 2.3x faster than normal locust, 4x Isaac's Damage."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Wakaba's Blessing", clr = 3, halign = 0},
			{str = "All Baby plum shots will be homing shots."},
			{str = "Angelic Prism", clr = 3, halign = 0},
			{str = "Baby Plum's shots that pass through the Prism will be refracted."},
		},
		{ -- Challenges
			{str = "Berry Best Friend", fsize = 2, clr = 3, halign = 0},
			{str = "In Berry Best Friend Challenge, Baby plum will copy most of Tainted Lost's tear effects."},
			{str = "In Stage 2/4, Plumy will spawn instead of Boss pool items when the floor boss is defeated."},
			{str = "Every floor Tainted Lost progresses, Baby Plum will also have extra tear effects."},
			{str = "- From Caves/Catacombs/Flooded Caves I, Baby Plum's tears will pierce enemies."},
			{str = "- From Depths/Necropolis/Dank Depths I, Baby Plum's tears will spark, Like Jacob's Ladder."},
			{str = "- From Womb/Utero/Scarred Womb I, Baby Plum's tears will be homing tears."},
			--{str = "- In The Void, Baby Plum's tears will be Holy Light tears. always spawns beam of light when colliding with an enemy."},
			{str = "This item is unlocked by completing Berry Best Friend Challenge."},
		},
	},
	EXECUTIONER = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Adds a chance to shoot Erasers instead of a tear."},
			{str = "if the enemies are hit, despawning all enemies of that type for the rest of the run."},
			{str = "Deals damage to bosses. If fatal, erases the boss for the rest of the run."},
			{str = "Isaac will always shoot Eraser tears when Only bosses are present."},
			{str = "- To prevent softlocks, Isaac will never shoot Eraser tears in The Visage, Mother, Dogma, The Beast fight."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The chance to fire a eraser depends on the luck stat. The activation rate is equal to 1/(200 - Luck). At base luck (0), the chance is 0.5%, maxing out at 100% at 200 luck."},
			{str = "Executioner Locust deals 4.2x 'slower' than normal locust, 16x Isaac's Damage, travels at 0.1x speed."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Wakaba's Blessing", clr = 3, halign = 0},
			{str = "The chance to fire a eraser will be 10x."},
		},
	},
	APOLLYON_CRISIS = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, destroys all pedestal items in the room."},
			{str = "- If Apollyon Crisis destroys an active item, it gains the ability of that item - whenever Apollyon Crisis is used, it will simultaneously use all previous active items that were absorbed in the same order they were absorbed."},
			{str = "- If Apollyon Crisis destroys a passive item, the player gains 2 random stat boosts. Possible stat changes include:"},
			{str = "-- +1 flat damage"},
			{str = "-- +0.5 tears "},
			{str = "-- +0.2 speed and maximum speed (may never exceed 2.0)"},
			{str = "-- +0.2 shot speed"},
			{str = "-- +1 luck"},
			{str = "-- +0.5 range"},
			{str = "Gives Isaac a unique red locust familiar for each item destroyed."},
			{str = "- These locusts are permanent once created, except that there are a maximum of 64, after which creating more will replace older locusts."},
			{str = "-- This limit is shared with blue flies and spiders"},
			{str = "- The locusts loosely follow Isaac around and charge in the direction Isaac is firing until they hit an enemy or a wall or certain obstacles like key blocks, dealing Isaac's damage per tick (3 times per second)."},
			{str = "- The locusts may gain additional effects depending on the item destroyed."},
			{str = "Apollyon Crisis does not work on devil deal, black market, or shop items unless they have been bought first."},
			{str = "If there are no available pedestals in the room, Apollyon Crisis will spawn a default locust."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Apollyon Crisis is simply combined version of Void and Abyss. See each item for more information."},
			{str = "Unlike Void and Abyss, If Isaac absorbs items from a room with choice pedestals, it will absorb all items."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Car Battery", clr = 3, halign = 0},
			{str = "Using Apollyon Crisis with Car Battery will always spawn one more locust."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "More Options / There's Options", clr = 3, halign = 0},
			{str = "Using Void will cause both items to be absorbed."},
		},
	},
	
	
	ISEKAI_DEFINITION = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, Spawns a Lil clot."},
			{str = "- Isaac will be teleported into Death Certificate room for 0.5% chance instead."},
			{str = "Heals all spawned Lil Clots' health by 2."},
			{str = "If spawned clot count is 10 or more, no more clots will be spawn. Instead, DC Teleportation chance will be increased into 3%, and fully heals all spawned clots."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item is the reference to the japanese media 'That Time I Got Reincarnated as a Slime'."},
			{str = "The Japanese term 'Isekai' has the meaning as 'Another world'."},
			{str = "The Isekai genre can be mainly divided into two parts, 'reincarnation into another world', and 'transition into another world'."},
			{str = "- Even though some classic novel like 'Alice in the Wonderland', or 'The Wizard of Oz' meets criteria of Isekai genres, many modern people usually don't count them as Isekai genre."},
			{str = "Unlike previous era which mostly based off from current world, many Japanese began making many 'isekai' genre manga or anime, flooding the culture, eventually started to generate backlash."},
		},
	},
	
	BALANCE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants 10 coins on pickup."},
			{str = "Upon use, consumes 5 coins and gives 1 of each key, and bomb."},
			{str = "- If Isaac has less than 5 coins, Convers 1 of Key/Bomb into another one that Isaac less have."},
			{str = "- If Isaac has same amount of Keys and Bombs, Gives Golden Key and Golden Bomb."},
			{str = "This item belongs to the Bookworm set. Collecting three items from this set will transform Isaac into Bookworm."},
		},
	},


	EDEN_STICKY_NOTE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Gives Tainted Eden a Birthright upon use."},
			{str = "Moves current active item into pocket slot, much like other active items for tainted characters."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item is unlocked by completing Hyper Random challenge(14w)."},
			{str = "Tainted Eden starts with this item once unlocked."},
			{str = "This item is only available for Tainted Eden"},
			{str = "This item is considered as Plot-Critical item, Taking damage does not reroll the item."},
		},
	},
	CLOVER_SHARD = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants one full Red Heart container."},
			{str = "Heals 1 additional heart of health."},
			{str = "x1.11 damage multiplier."},
		},
		{ -- Notes
			{str = "Hold Me", fsize = 2, clr = 3, halign = 0},
			{str = "This challenge starts as Tainted Cain, with Lil Mao."},
			{str = "This item is only available in Hold Me challenge(14w). It doesn't appear in any item pools."},
			{str = "All collectibles will be replaced with Clover Shard. Fixed drops are not affected."},
			{str = "Tainted Cain can get this item normally."},
		},
	},

	WAKABAS_CURFEW = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Switches between Wakaba and Tainted Wakaba on Room clears. hit, or per 30 seconds."},
			{str = "Actviates All dice effects when switching."},
			{str = "- Frozen enemies revive when being rerolled by this item."},
			{str = "- Glitched items also will be rerolled when being rerolled by this item."},
		},
		{ -- Notes
			{str = "Hyper Random", fsize = 2, clr = 3, halign = 0},
			{str = "This challenge starts as Wakaba, but the health system does not follow any of Wakaba's forms."},
			{str = "Wakaba starts with Dogma, Magic Mushroom, and TMTRAINER in this challenge."},
			{str = "Wakaba/Tainted Wakaba's health system and stats does not apply in this challenge."},
			{str = "This item is only available in Hyper Random challenge(98w). It doesn't appear in any item pools."},
			{str = "When used outside Hyper Random challenge, The item has no effect."},
			{str = "Unlike original Tainted Eden, Gained Health will not be lost."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "In original anime 'Wakaba Girl', Due to incedent occured which got close to be kidnapped to her, Wakaba's curfew was set to 6.0 clock."},
			{str = "- Thankfully, After joining among friends, her curfew was extended."},
			{str = "The concept for Hyper Random challenge(98w) was combining Ultra Hard(34) + DELETE THIS(45) + Tainted Eden + Tainted Lazarus, but later some concept was forfeited due to constant, or high chance of getting game crash."},
		},
	},

	DOUBLE_DREAMS = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Devil/Angel rooms no longer appear."},
			{str = "- Even if Isaac drops this item, Devil/Angel rooms do not appear in current floor."},
			{str = "Upon use, Changes the pool of Wakaba's dreams."},
			{str = "- Wakaba's Dream will not show if Curse of the Unknown is active."},
			{str = "If collectibles appear, The pool from Wakaba's dream will be selected instead of default pool"},
			{str = "- Items will very likely to be passive items."},
			{str = "Wakaba's Dream Card may spawn on room clears, even if it is not unlocked."},
			{str = "- Chance for spawning Wakaba's Dream Card is 8%, does not affected by luck."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "As devil/angel room do not appear, isaac must find extra collectibles by using beggar, etc."},
			{str = "- Wakaba's Dream Cards are the main resources for finding extra collectibles."},
			{str = "Chests from Starting room of Chest/Dark room contains from Wakaba's dream pool."},
			{str = "Completing True Purist Girl challenge unlocks this item.."},
			{str = "- Shiori does NOT start with this item regardless of unlock."},
		},
		{ -- Synergies
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Chaos", clr = 3, halign = 0},
			{str = "Removes Chaos and spawns Wakaba's Dream Card."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "XX - Judgement, Magic Skin, Eat Heart", clr = 3, halign = 0},
			{str = "Beggars can spawn Devil/Angel room, or even planetarium Items if Wakaba's dream is set."},
			{str = "Gilded Key, The Left Hand", clr = 3, halign = 0},
			{str = "Allows more collectibles to be appeared."},
		},
	},
}

for _, playerType in ipairs(wakaba.encyclopediadesc.desc.char_sorted_keys) do
	local desc = wakaba.encyclopediadesc.desc.characters[playerType]
	if desc and desc.Tainted then
		Encyclopedia.AddCharacterTainted({
			ModName = wakaba.encyclopediadesc.class,
			Class = wakaba.encyclopediadesc.class,
			ID = playerType,
			Name = desc.Name,
			Description = desc.Description,
			Sprite = desc.Sprite,
			CompletionTrackerFuncs = desc.CompletionTrackerFuncs,
			UnlockFunc = desc.UnlockFunc,
			WikiDesc = desc.WikiDesc,
		})
	elseif desc then
		Encyclopedia.AddCharacter({
			ModName = wakaba.encyclopediadesc.class,
			Class = wakaba.encyclopediadesc.class,
			ID = playerType,
			Name = desc.Name,
			Description = desc.Description,
			Sprite = desc.Sprite,
			CompletionTrackerFuncs = desc.CompletionTrackerFuncs,
			WikiDesc = desc.WikiDesc,
		})
	end
end


if Encyclopedia then
	local class = "Pudding n Wakaba"

	local Wiki = {
		CARD_CRANE_CARD = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Spawns a crane game machine."},
			},
		},
		CARD_CONFESSIONAL_CARD = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Spawns a confessional booth."},
			},
		},
		CARD_VALUT_RIFT = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Spawns a Shiori's valut."},
				{str = "Shiori's valut contains a collectible item that costs 12 keys to open."},
			},
		},
		CARD_BLACK_JOKER = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "While held, prevents Angel rooms to be spawned."},
				{str = "Upon use, Teleports the player to the Devil room."},
			},
		},
		CARD_WHITE_JOKER = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "While held, prevents Devil rooms to be spawned."},
				{str = "Upon use, Teleports the player to the Angel room."},
			},
		},
		CARD_COLOR_JOKER = {
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
		
		CARD_DREAM_CARD = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Spawns random collectible item."},
			},
		},
		CARD_QUEEN_OF_SPADES = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Spawns 3 ~ 26 Keys."},
			},
		},
		CARD_UNKNOWN_BOOKMARK = {
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
		CARD_MINERVA_TICKET = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Activates Minerva's Aura for current room."},
			},
		},

		SOUL_WAKABA = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "+1 Soul Heart."},
				{str = "Converts random unvisited room into Angel shop."},
			},
		},

		SOUL_WAKABA2 = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "+1 Soul Heart."},
				{str = "Converts random unvisited room into Devil Room."},
			},
		},
		SOUL_SHIORI = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Heals 2 Red Hearts."},
				{str = "Activates Random Book of Shiori tear effect."},
			},
		},
		SOUL_TSUKASA = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Upon use, summons a sword that hangs directly above Isaac."},
				{str = "As long as the sword hangs above Isaac, all item pedestals are doubled, spawning an additional free item next to them."},
				{str = "After Isaac gets hit once with the item activated, at any time with only a brief warning, the sword may fall."},
				{str = "Sword does half heart damage to Isaac, but Removes half of Isaac's items."},
				{str = "Invincibilty does NOT protect damage against this."},
				{str = "The sword has a 1/2500 chance every 4 frames to fall."},
				{str = "Taking self-damage does not count as damage taken for blue sword, and will not give it the chance to fall."},
			},
		},
		CARD_RETURN_TOKEN = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Invokes R Key Effect."},
				{str = "Also resets game timer."},
				{str = "Removes all of Isaac's health, consumables, card/pills, and trinkets."},
			},
		},
		
		BRING_ME_THERE = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "+1.5 tears."},
				{str = "Entering Mausoleum/Gehenna II while holding this trinket makes Dad's Note being appear instead of Mom."},
				{str = "WARNING : CANNOT ENTER WOMB/CORPSE WHEN BEING REPLACED."},
			},
			{ -- Interactions
				{str = "Interactions", fsize = 2, clr = 3, halign = 0},
				{str = "Fiend Folio - Golem", clr = 3, halign = 0},
				{str = "Bring Me There is considered as special trinket, thus will be not converted into random stones, will be act as normal stone if interacted with Golem's unique beggars."},
			},
			{ -- Notes
				{str = "Notes", fsize = 2, clr = 3, halign = 0},
				{str = "This trinket also appears on the staring room in Mines/Ashpit II and Mausoleum/Gehenna I, for those who accidentally entered wrong path."},
			},
		},
		
		TRINKET_BITCOIN = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "Randomize consumable counters constantly."},
				{str = "Randomize stats every time Isaac enters another room."},
				{str = "The range for consumables can be all back to 0 to full of 99."},
			},
			{ -- Notes
				{str = "Notes", fsize = 2, clr = 3, halign = 0},
				{str = "As consumables completely randomized, Isaac has effectively infinite bombs, keys, and coins."},
			},
		},
		
		TRINKET_CLOVER = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "+0.3 tears"},
				{str = "Luck +2"},
				{str = "Luck Multiplier x2"},
				{str = "Luct stat will be always positive"},
				{str = "Increased chance for Lucky Pennies"},
			},
		},
		
		TRINKET_MAGNET_HEAVEN = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "Instantly teleports Bombs, Keys, and Coins to Isaac"},
				{str = "Converts Sticky Nickel into normal Nickel"},
			},
		},
		
		TRINKET_HARD_BOOK = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "Chance to drop random book collectible upon getting hit"},
				{str = "Prevents single damage taken for The Lost/Tainted Lost"},
				{str = "- 100% chance to drop a book in sacrifice rooms, or playing as The Lost/Tainted Lost"},
				{str = "The trinket gets disappeared when book drop"},
			},
		},
		
		TRINKET_DETERMINATION_RIBBON = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "All damage taken will be reduced to half heart"},
				{str = "Doesn't kill isaac as long as the trinket is held"},
				{str = "The effect of the trinket will not work on Sacrifice rooms Spikes!"},
			},
		},
		
		TRINKET_BOOKMARK_BAG = {
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

		TRINKET_RING_OF_JUPITER = {
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

		TRINKET_DIMENSION_CUTTER = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "When entering an uncleared room, Spawns a random Delirious boss for 15% chance."},
				{str = "In Greed Mode, 5% chance for spawn, but scales with Luck, Maxing out 25% chance for 10 Luck."},
				{str = "Chaos card can damage Delirium, and The Beast (339 damage per tick)."},
			},
		},

		TRINKET_DELIMITER = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "When entering new room :", clr = 3},
				{str = "Destroys Tinted, Super-Secret, and Fools Gold rocks."},
				{str = "Turns Pillars, Metal blocks, Spiked rocks into normal rocks."},
			},
		},

		TRINKET_RANGE_OS = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "-45% Range Multiplier"},
				{str = "+125% Damage Multiplier"},
			},
			{ -- Trivia
				{str = "Trivia", fsize = 2, clr = 3, halign = 0},
				{str = "This item is inspired from 'Assault OS', which was in 'Last Origin' from 'SmartJoy'."},
				{str = "In early era in Last Origin, There are 'effective range' for each skills, some skills needed to be used in close range."},
				{str = "Many players overused this equipment to control main skills for each unit, to only use stronger skills, which was not available in normal automatic playthrough."},
			},
		},
		
		TRINKET_SIREN_BADGE = {
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
		
		TRINKET_ISAAC_CARTRIDGE = {
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
		
		TRINKET_AFTERBIRTH_CARTRIDGE = {
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
		
		TRINKET_REPENTANCE_CARTRIDGE = {
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
		
		TRINKET_STAR_REVERSAL = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "Dropping the trinket in a Treasure room exchanges it for Planetarium item."},
				{str = "The trinket disappears on exchange."},
			},
		},
		
		TRINKET_AURORA_GEM = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "6.66% chance to replace normal coin into purple coins."},
				{str = "- The chance scales with Luck, +1%p per luck"},
				{str = "When picking up a purple coin for the first time, a ghostly rainbow sphere orbit around Isaac."},
				{str = "- Rainbow sphere shoot homing, spectral tears that do 1 damage."},
				{str = "Picking multiple purple coins make rainbow sphere deal more damage, and shoot tears more frequently."},
			},
		},
		
		TRINKET_MISTAKE = {
			{ -- Effects
				{str = "Effects", fsize = 2, clr = 3, halign = 0},
				{str = "Taking damage makes explosion on random enemy."},
			},
		},


		
		

	}
	
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------


	--Wakaba's Blessing
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WAKABAS_BLESSING,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_BLESSING,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
			Encyclopedia.ItemPools.POOL_OLD_CHEST,
			Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.blessing and not wakaba.runstate.hasbless then
				self.Desc = "Earn all 12 completion marks on Hard mode as Wakaba"
				
				return self
			end
		end,
	})
	
	--Wakaba's Nemesis
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WAKABAS_NEMESIS,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_NEMESIS,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_RED_CHEST,
			Encyclopedia.ItemPools.POOL_MOMS_CHEST,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.nemesis < 1 and not wakaba.runstate.hasnemesis then
				self.Desc = "Defeat The Beast as Tainted Wakaba"
				
				return self
			end
		end,
	})
	
	--Wakaba Duality
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WAKABA_DUALITY,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABA_DUALITY,
		Pools = {
		},
		UnlockFunc = function(self)
			if not (wakaba.runstate.hasbless and wakaba.runstate.hasnemesis) then
				self.Desc = "???"
				
				return self
			end
		end,
	})
	
	--Book of Shiori
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BOOK_OF_SHIORI,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_SHIORI,
		Pools = {
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.bookofshiori and not wakaba.hasshiori then
				self.Desc = "Earn all 12 completion marks on Hard mode as Shiori"
				
				return self
			end
		end,
	})
	
	--Winter Albireo
	--[[ Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WINTER_ALBIREO,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WINTER_ALBIREO,
		Hide = true,
	}) ]]
	
	--Eat Heart
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.EATHEART,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EATHEART,
		Pools = {
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
			Encyclopedia.ItemPools.POOL_RED_CHEST,
		},
		ActiveCharge = 7500,
		UnlockFunc = function(self)
			local hastaintedwakaba = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B then
					hastaintedwakaba = true
				end
			end
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.eatheart < 1 and not hastaintedwakaba then
				self.Desc = "Defeat Delirium as Tainted Wakaba"
				
				return self
			end
		end,
	})
	
	--Book of Conquest
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BOOK_OF_CONQUEST,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_CONQUEST,
		Pools = {
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.bookofconquest < 1 and not wakaba.hastaintedshiori then
				self.Desc = "Defeat Delirium as Tainted Shiori"
				
				return self
			end
		end,
	})
	
	--Minerva's Aura
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.MINERVA_AURA,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MINERVA_AURA,
		Pools = {
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.minervaaura < 1 and not wakaba.hastaintedshiori then
				self.Desc = "Defeat The Beast as Tainted Shiori"
				
				return self
			end
		end,
	})

	--Lunar Stone
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.LUNAR_STONE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LUNAR_STONE,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_PLANETARIUM,
		},
		UnlockFunc = function(self)
			local haslunarstone = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
					haslunarstone = true
				end
			end
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.lunarstone and not haslunarstone then
				self.Desc = "Earn all 12 completion marks on Hard mode as Tsukasa"
				
				return self
			end
		end,
	})
	--Concentration
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.CONCENTRATION,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CONCENTRATION,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
			Encyclopedia.ItemPools.POOL_MOMS_CHEST,
		},
		UnlockFunc = function(self)
			local haslunarstone = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
					haslunarstone = true
				end
			end
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.concentration < 1 and not haslunarstone then
				self.Desc = "Complete Boss Rush as Tsukasa"
				
				return self
			end
		end,
	})
	
	--Elixir of Life
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.ELIXIR_OF_LIFE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.ELIXIR_OF_LIFE,
		Pools = {
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_ROTTEN_BEGGAR,
			Encyclopedia.ItemPools.POOL_OLD_CHEST,
		},
		UnlockFunc = function(self)
			local haselixir = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
					haselixir = true
				end
			end
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.elixiroflife < 1 and not haslunarstone then
				self.Desc = "Defeat The Beast as Tainted Tsukasa"
				
				return self
			end
		end,
	})
	--Flash Shift
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.FLASH_SHIFT,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.FLASH_SHIFT,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			local haselixir = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
					haselixir = true
				end
			end
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.flashshift < 1 and not haslunarstone then
				self.Desc = "Defeat Delirium as Tainted Tsukasa"
				
				return self
			end
		end,
	})
	--Murasame
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.MURASAME,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MURASAME,
		Pools = {
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_KEY_MASTER,
			Encyclopedia.ItemPools.POOL_OLD_CHEST,
		},
		UnlockFunc = function(self)
			local haselixir = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
					haselixir = true
				end
			end
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.murasame < 2 and not haslunarstone then
				self.Desc = "Defeat MomsHeart as Tsukasa on Hard"
				
				return self
			end
		end,
	})
	--Rabbit Ribbon
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.RABBIT_RIBBON,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RABBIT_RIBBON,
		--[[ Pools = {
			Encyclopedia.ItemPools.POOL_BOSS,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		}, ]]
		UnlockFunc = function(self)
			local hasRicher = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.RICHER then
					hasRicher = true
				end
				if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
					hasRicher = true
				end
			end
			if not hasRicher then
				self.Desc = "Only available for Richer"
				
				return self
			end
		end,
	})
	--Sweets Catalog
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.SWEETS_CATALOG,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SWEETS_CATALOG,
		--[[ Pools = {
			Encyclopedia.ItemPools.POOL_BOSS,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		}, ]]
		UnlockFunc = function(self)
			local hasRicher = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.RICHER then
					hasRicher = true
				end
			end
			if not hasRicher then
				self.Desc = "Only available for Richer"
				
				return self
			end
		end,
	})
	
	--The Winter Albireo
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WINTER_ALBIREO,
		UnlockFunc = function(self)
			local hasRicher = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
					hasRicher = true
				end
			end
			if not hasRicher then
				self.Desc = "Only available for Tainted Richer"
				
				return self
			end
		end,
	})
	

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WATER_FLAME,
		UnlockFunc = function(self)
			local hasRicher = false
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
					hasRicher = true
				end
			end
			if not hasRicher then
				self.Desc = "Only available for Tainted Richer"
				
				return self
			end
		end,
	})


	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.CHIMAKI,
		Hide = true,
	})
	
	--Broken Toolbox
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BROKEN_TOOLBOX,
		Hide = true,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BROKEN_TOOLBOX,
		Pools = {
		},
	})
	
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------

	--Mysterious Game CD
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MYSTERIOUS_GAME_CD,
		Pools = {
			Encyclopedia.ItemPools.POOL_BOSS,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
		},
	})
	
	--Maijima Mythology
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MAIJIMA_MYTHOLOGY,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		},
	})
	
	--Moe's Muffin
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.MOE_MUFFIN,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MOE_MUFFIN,
		Pools = {
			Encyclopedia.ItemPools.POOL_BOSS,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
	})
	
	--Syrup
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.SYRUP,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SYRUP,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_BOSS,
			Encyclopedia.ItemPools.POOL_BABY_SHOP,
		},
	})

	--Curse of the Tower 2
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CURSE_OF_THE_TOWER_2,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_CURSE,
			Encyclopedia.ItemPools.POOL_RED_CHEST,
			Encyclopedia.ItemPools.POOL_BOMB_BUM,
		},
	})

	--Crisis Boost
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.CRISIS_BOOST,
		Hide = true,
	})
	
	--See Des Bischofs
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.SEE_DES_BISCHOFS,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SEE_DES_BISCHOFS,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
		},
	})
	
	--Jar of Clover
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.JAR_OF_CLOVER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.JAR_OF_CLOVER,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
		},
	})

	--D6 Plus
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.D6_PLUS,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.D6_PLUS,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
	})

	--D6 Chaos
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.D6_CHAOS,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.D6_CHAOS,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
	})
	
	--Lil Moe
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.LIL_MOE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LIL_MOE,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_BABY_SHOP,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
	})
	
	--Lil Shiva
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.LIL_SHIVA,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LIL_SHIVA,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_BABY_SHOP,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
	})
	
	--Deja Vu
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.DEJA_VU,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.DEJA_VU,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		},
	})
	
	--Onsen Towel
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.ONSEN_TOWEL,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.ONSEN_TOWEL,
		Pools = {
			Encyclopedia.ItemPools.POOL_BOSS,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
		},
	})
	
	
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------

	--Counter
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.COUNTER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.COUNTER,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.counter < 1 then
				self.Desc = "Defeat Isaac as Wakaba"
				
				return self
			end
		end,
	})
	
	--D Cup Icecream
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.D_CUP_ICECREAM,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.D_CUP_ICECREAM,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_BOSS,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
			Encyclopedia.ItemPools.POOL_MOMS_CHEST,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.dcupicecream < 1 then
				self.Desc = "Defeat Satan as Wakaba"
				
				return self
			end
		end,
	})
	
	--Wakaba's Pendant
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WAKABAS_PENDANT,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_PENDANT,
		Pools = {
			Encyclopedia.ItemPools.POOL_BOSS,
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
			Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.pendant < 1 then
				self.Desc = "Defeat ??? as Wakaba"
				
				return self
			end
		end,
	})
	
	--Revenge Fruit
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.REVENGE_FRUIT,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.REVENGE_FRUIT,
		Pools = {
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.revengefruit < 1 then
				self.Desc = "Defeat The Lamb as Wakaba"
				
				return self
			end
		end,
	})
	
	--Wakaba's Uniform
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.UNIFORM,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.UNIFORM,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.wakabauniform < 1 and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_DRAW then
				self.Desc = "Defeat Delirium as Wakaba"
				
				return self
			end
		end,
	})

	--Secret Card
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.SECRET_CARD,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SECRET_CARD,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_CURSE,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
			Encyclopedia.ItemPools.POOL_OLD_CHEST,
			Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.secretcard < 1 then
				self.Desc = "Defeat Ultra Greed as Wakaba"
				
				return self
			end
		end,
	})

	--Crane Card
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_CRANE_CARD,
		WikiDesc = Wiki.CARD_CRANE_CARD,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Crane Card",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.cranecard < 1 then
				self.Desc = "Defeat Ultra Greedier as Wakaba"
				
				return self
			end
		end,
	})
	
	--Confessional Card
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,
		WikiDesc = Wiki.CARD_CONFESSIONAL_CARD,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Confessional Card",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.confessionalcard < 1 then
				self.Desc = "Defeat Mother as Wakaba"
				
				return self
			end
		end,
	})
	
	--Book of Forgotten
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_FORGOTTEN,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
			Encyclopedia.ItemPools.POOL_KEY_MASTER,
			Encyclopedia.ItemPools.POOL_ROTTEN_BEGGAR,
			Encyclopedia.ItemPools.POOL_OLD_CHEST,
		},
		ActiveCharge = 6,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.bookofforgotten then
				self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Wakaba"
				
				return self
			end
		end,
	})
	
	--Black Joker
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_BLACK_JOKER,
		WikiDesc = Wiki.CARD_BLACK_JOKER,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Black Joker",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.blackjoker < 2 then
				self.Desc = "Defeat Ultra Greedier as Tainted Wakaba"
				
				return self
			end
		end,
	})
	
	--White Joker
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_WHITE_JOKER,
		WikiDesc = Wiki.CARD_WHITE_JOKER,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_White Joker",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.whitejoker < 1 then
				self.Desc = "Defeat Mega Satan as Wakaba"
				
				return self
			end
		end,
	})
	
	--Color Joker
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_COLOR_JOKER,
		WikiDesc = Wiki.CARD_COLOR_JOKER,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Color Joker",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.colorjoker < 1 then
				self.Desc = "Defeat Hush as Wakaba"
				
				return self
			end
		end,
	})
	
	--Return Postage
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.RETURN_POSTAGE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RETURN_POSTAGE,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.returnpostage < 1 then
				self.Desc = "Defeat The Beast as Wakaba"
				
				return self
			end
		end,
	})
	

	
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------

	--Book of Focus
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BOOK_OF_FOCUS,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_FOCUS,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_CURSE,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.bookoffocus < 1 and not wakaba.hasshiori then
				self.Desc = "Defeat Satan as Shiori"
				
				return self
			end
		end,
	})

	--Shiori's Bottle of Runes
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.DECK_OF_RUNES,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.DECK_OF_RUNES,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.deckofrunes < 1 and not wakaba.hasshiori then
				self.Desc = "Defeat ??? as Shiori"
				
				return self
			end
		end,
	})

	--Grimreaper Defender
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.GRIMREAPER_DEFENDER,
		Pools = {
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_ANGEL,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.grimreaperdefender < 1 and not wakaba.hasshiori then
				self.Desc = "Defeat The Lamb as Shiori"
				
				return self
			end
		end,
	})
	
	--Book of The Fallen
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_THE_FALLEN,
		Pools = {
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_CURSE,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
			Encyclopedia.ItemPools.POOL_RED_CHEST,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.bookoffallen < 1 then
				self.Desc = "Defeat The Mega Satan as Shiori"
				
				return self
			end
		end,
	})
	

	--Book of Trauma
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BOOK_OF_TRAUMA,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_TRAUMA,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.bookoftrauma < 1 and not wakaba.hasshiori then
				self.Desc = "Defeat Hush as Shiori"
				
				return self
			end
		end,
	})

	--Book of Silence
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BOOK_OF_SILENCE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_SILENCE,
		Pools = {
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_SECRET,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.bookofsilence < 1 and not wakaba.hasshiori then
				self.Desc = "Defeat Delirium as Shiori"
				
				return self
			end
		end,
	})

	--Vintage Threat
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.VINTAGE_THREAT,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.VINTAGE_THREAT,
		Pools = {
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_MOMS_CHEST,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.vintagethreat < 1 then
				self.Desc = "Defeat Mother as Shiori"
				
				return self
			end
		end,
	})

	--Book of The God
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BOOK_OF_THE_GOD,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_THE_GOD,
		Pools = {
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_KEY_MASTER,
			Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
			Encyclopedia.ItemPools.POOL_MOMS_CHEST,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.bookofthegod < 1 then
				self.Desc = "Defeat The Beast as Shiori"
				
				return self
			end
		end,
	})


	
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------


	--Nasa Lover
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.NASA_LOVER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.NASA_LOVER,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_KEY_MASTER,
			Encyclopedia.ItemPools.POOL_BABY_SHOP,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.nasalover < 1 then
				self.Desc = "Defeat Isaac as Tsukasa"
				return self
			end
		end,
	})
	--Beetlejuice
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BEETLEJUICE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BEETLEJUICE,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.beetlejuice < 1 then
				self.Desc = "Defeat Satan as Tsukasa"
				return self
			end
		end,
	})
	
	--Red Corruption
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.RED_CORRUPTION,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RED_CORRUPTION,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
			Encyclopedia.ItemPools.POOL_RED_CHEST,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
			Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.redcorruption < 1 then
				self.Desc = "Defeat ??? as Tsukasa"
				return self
			end
		end,
	})
	--Power Bomb
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.POWER_BOMB,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.POWER_BOMB,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_BOMB_BUM,
			Encyclopedia.ItemPools.POOL_OLD_CHEST,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.powerbomb < 1 then
				self.Desc = "Defeat The Lamb as Tsukasa"
				return self
			end
		end,
	})
	-- Plasma Beam
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.PLASMA_BEAM,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.PLASMA_BEAM,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
			Encyclopedia.ItemPools.POOL_OLD_CHEST,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.plasmabeam < 1 then
				self.Desc = "Defeat Mega Satan as Tsukasa"
				return self
			end
		end,
	})
	
	--New Year Eve's Bomb
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.NEW_YEAR_BOMB,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.NEW_YEAR_BOMB,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_GREED_CURSE,
			Encyclopedia.ItemPools.POOL_BOMB_BUM,
			Encyclopedia.ItemPools.POOL_MOMS_CHEST,
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.newyearbomb < 1 then
				self.Desc = "Defeat Delirium as Tsukasa"
				
				return self
			end
		end,
	})

	--Arcane Crystal
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.ARCANE_CRYSTAL,
		--ID = wakaba.Enums.Collectibles.MOE_MUFFIN,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.ARCANE_CRYSTAL,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.arcanecrystal < 1 then
				self.Desc = "Defeat Ultra Greed as Tsukasa"
				return self
			end
		end,
	})
	--Advanced Crystal
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.ADVANCED_CRYSTAL,
		--ID = wakaba.Enums.Collectibles.MOE_MUFFIN,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.ADVANCED_CRYSTAL,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.arcanecrystal < 1 then
				self.Desc = "Defeat Ultra Greed as Tsukasa"
				return self
			end
		end,
	})
	--Mystic Crystal
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.MYSTIC_CRYSTAL,
		--ID = wakaba.Enums.Collectibles.MOE_MUFFIN,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MYSTIC_CRYSTAL,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.arcanecrystal < 1 then
				self.Desc = "Defeat Ultra Greed as Tsukasa"
				return self
			end
		end,
	})
	--Question Block
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.QUESTION_BLOCK,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.QUESTION_BLOCK,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.questionblock < 1 then
				self.Desc = "Defeat Ultra Greedier as Tsukasa"
				return self
			end
		end,
	})
	--Phantom Cloak
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.PHANTOM_CLOAK,
		--ID = wakaba.Enums.Collectibles.MOE_MUFFIN,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.PHANTOM_CLOAK,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_OLD_CHEST,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.phantomcloak < 1 then
				self.Desc = "Defeat Mother as Tsukasa"
				return self
			end
		end,
	})
	--Easter Egg
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.EASTER_EGG,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EASTER_EGG,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.easteregg < 1 then
				self.Desc = "Defeat Mega Satan as Tainted Tsukasa"
				return self
			end
		end,
	})
	--Lunar Damocles
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.LUNAR_DAMOCLES,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LUNAR_DAMOCLES,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.tsukasasoul then
				self.Desc = "Defeat Boss Rush, Hush as Tainted Tsukasa"
				return self
			end
		end,
	})
	--Magma Blade
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.MAGMA_BLADE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MAGMA_BLADE,
		Pools = {
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
		Hide = true,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.magmablade < 1 then
				self.Desc = "Defeat The Beast as Tsukasa"
				return self
			end
		end,
	})

	

	
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------


	--Firefly Lighter
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.FIREFLY_LIGHTER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.FIREFLY_LIGHTER,
		Pools = {
			Encyclopedia.ItemPools.POOL_BOSS,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_KEY_MASTER,
		},
	})

	--Anti Balance
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.ANTI_BALANCE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.ANTI_BALANCE,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_RED_CHEST,
		},
	})

	--Clensing Foam
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.CLENSING_FOAM,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CLENSING_FOAM,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
	})

	--Double Invader
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.DOUBLE_INVADER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.DOUBLE_INVADER,
		Pools = {
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
			Encyclopedia.ItemPools.POOL_RED_CHEST,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
	})
	--Venom Incantation
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.VENOM_INCANTATION,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.VENOM_INCANTATION,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_CURSE,
			Encyclopedia.ItemPools.POOL_GREED_BOSS,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
			Encyclopedia.ItemPools.POOL_RED_CHEST,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
	})
	
	--3D Printer
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles._3D_PRINTER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles._3D_PRINTER,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
	})

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.CARAMELLA_PANCAKE,
		Hide = true,
	})

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.RICHERS_UNIFORM,
		Hide = true,
	})

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.PRESTIGE_PASS,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.PRESTIGE_PASS,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_SECRET,
		},
	})

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.LIL_RICHER,
		Hide = true,
	})

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BLACK_RIBBON,
		Hide = true,
	})

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.CUNNING_PAPER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CUNNING_PAPER,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
	})

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.TRIAL_STEW,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.TRIAL_STEW,
	})


	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.LIL_RIRA,
		Hide = true,
	})

	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------

	--Mint Choco Icecream
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MINT_CHOCO_ICECREAM,
		Pools = {
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.dcupicecream < 1 then
				self.Desc = "Defeat Satan as Wakaba"
				
				return self
			end
		end,
	})
	
	--Wakaba's Hairpin
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WAKABAS_HAIRPIN,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_HAIRPIN,
		Pools = {
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.pendant < 1 then
				self.Desc = "Defeat ??? as Wakaba"
				
				return self
			end
		end,
	})
	

	
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------

	--Eye of Clock
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.EYE_OF_CLOCK,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EYE_OF_CLOCK,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.eyeofclock and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_ELEC then
				self.Desc = "Complete Electric Disorder (challenge No.01w)"
				self.WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EYE_OF_CLOCK
				
				return self
			end
		end,
	})
	
	--Plumy
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.PLUMY,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.PLUMY,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_KEY_MASTER,
			Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.plumy and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_PLUM then
				self.Desc = "Complete Berry Best Friend (challenge No.02w)"
				self.WikiDesc = wakaba.encyclopediadesc.desc.collectibles.PLUMY
				
				return self
			end
		end,
	})
	
	--Neko Figure
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.NEKO_FIGURE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.NEKO_FIGURE,
		Pools = {
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_CURSE,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_CURSE,
			Encyclopedia.ItemPools.POOL_RED_CHEST,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.nekodoll then
				self.Desc = "Complete Black Neko Dreams (challenge No.05w)"
				
				return self
			end
		end,
	})

	
	--Micro Doppelganger
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.MICRO_DOPPELGANGER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MICRO_DOPPELGANGER,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.microdoppelganger and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_DOPP then
				self.Desc = "Complete Doppelganger (challenge No.06w)"
				
				return self
			end
		end,
	})

	--Lil Wakaba
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.LIL_WAKABA,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LIL_WAKABA,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_BEGGAR,
			Encyclopedia.ItemPools.POOL_BABY_SHOP,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.lilwakaba and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_SIST then
				self.Desc = "Complete Sisters From Beyond (challenge No.08w)"
				
				return self
			end
		end,
	})
	
	--Executioner
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.EXECUTIONER,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EXECUTIONER,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_GREED_CURSE,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.executioner then
				self.Desc = "Complete Rush Rush Hush (challenge No.10w)"
				
				return self
			end
		end,
	})
	
	--Apollyon Crisis
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.APOLLYON_CRISIS,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.APOLLYON_CRISIS,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.apollyoncrisis then
				self.Desc = "Complete Apollyon Crisis (challenge No.11w)"
				
				return self
			end
		end,
	})
	
	--Isekai Definition
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.ISEKAI_DEFINITION,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.ISEKAI_DEFINITION,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_DEVIL,
			Encyclopedia.ItemPools.POOL_ANGEL,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
			Encyclopedia.ItemPools.POOL_BABY_SHOP,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.deliverysystem then
				self.Desc = "Complete Delivery System (challenge No.12w)"
				
				return self
			end
		end,
	})

	
	--Balance
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.BALANCE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BALANCE,
		Pools = {
			Encyclopedia.ItemPools.POOL_SHOP,
			Encyclopedia.ItemPools.POOL_BEGGAR,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.calculation then
				self.Desc = "Complete Calculation (challenge No.13w)"
				
				return self
			end
		end,
	})
	
	--Lil Mao
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.LIL_MAO,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LIL_MAO,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_DEVIL,
			Encyclopedia.ItemPools.POOL_GREED_ANGEL,
			Encyclopedia.ItemPools.POOL_BABY_SHOP,
			Encyclopedia.ItemPools.POOL_CRANE_GAME,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.lilmao and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_HOLD then
				self.Desc = "Complete Hold Me (challenge No.14w)"
				
				return self
			end
		end,
	})

	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.CLOVER_SHARD,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CLOVER_SHARD,
	})
	
	--Wakaba's Curfew
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WAKABAS_CURFEW,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_CURFEW,
	})
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.WAKABAS_CURFEW2,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_CURFEW,
		Hide = true,
	})
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.EDEN_STICKY_NOTE,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EDEN_STICKY_NOTE,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.edensticky then
				self.Desc = "Complete Hyper Random (challenge No.98w)"
				return self
			end
		end,
	})
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = Isaac.GetItemIdByName("Shiori's Red Bookmark"),
		Hide = true,
	})
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = Isaac.GetItemIdByName("Shiori's Blue Bookmark"),
		Hide = true,
	})
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = Isaac.GetItemIdByName("Shiori's Yellow Bookmark"),
		Hide = true,
	})
	
	--Wakaba's Double Dreams
	Encyclopedia.AddItem({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Collectibles.DOUBLE_DREAMS,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.DOUBLE_DREAMS,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_LIBRARY,
			Encyclopedia.ItemPools.POOL_GREED_CURSE,
		},
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.doubledreams and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_DRMS then
				self.Desc = "Complete True Purist Girl (challenge No.99w)"
				self.Hide = true
				return self
			end
		end,
	})
	--Wakaba's Dream Card
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_DREAM_CARD,
		WikiDesc = Wiki.CARD_DREAM_CARD,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Wakaba's Dream Card"),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.donationcard < 1 and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_DRMS then
				self.Desc = "Complete Boss Rush as Wakaba"
				
				return self
			end
		end,
	})
	
	
	
	--Unknown Bookmark
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK,
		WikiDesc = Wiki.CARD_UNKNOWN_BOOKMARK,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Unknown Bookmark",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.unknownbookmark < 1 then
				self.Desc = "Complete Boss Rush as Shiori"
				
				return self
			end
		end,
	})
	
	--Queen of Spades
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES,
		WikiDesc = Wiki.CARD_QUEEN_OF_SPADES,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Queen of Spades",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.queenofspades < 1 then
				self.Desc = "Complete Ultra Greedier as Tainted Shiori"
				
				return self
			end
		end,
	})

	--Valut Rift
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_VALUT_RIFT,
		WikiDesc = Wiki.CARD_VALUT_RIFT,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Valut Rift",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.queenofspades < 1 then
				self.Desc = "Complete Mega Satan as Tainted Shiori"
				
				return self
			end
		end,
	})
	
	--Minerva Ticket
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_MINERVA_TICKET,
		WikiDesc = Wiki.CARD_MINERVA_TICKET,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Minerva Ticket",0),
		--[[ UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.queenofspades < 1 then
				self.Desc = "Complete Ultra Greedier as Tainted Shiori"
				
				return self
			end
		end, ]]
	})
	
	--Soul of Wakaba
	Encyclopedia.AddSoul({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.SOUL_WAKABA,
		WikiDesc = Wiki.SOUL_WAKABA,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Soul of Wakaba",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.wakabasoul then
				self.Desc = "Defeat Boss Rush, Hush as Tainted Wakaba"
				
				return self
			end
		end,
	})
	--Soul of Wakaba?
	Encyclopedia.AddSoul({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.SOUL_WAKABA2,
		WikiDesc = Wiki.SOUL_WAKABA2,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Soul of Wakaba?",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.wakabasoul then
				self.Desc = "Defeat Boss Rush, Hush as Tainted Wakaba"
				
				return self
			end
		end,
	})
	
	--Soul of Shiori
	Encyclopedia.AddSoul({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.SOUL_SHIORI,
		WikiDesc = Wiki.SOUL_SHIORI,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Soul of Shiori",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.shiorisoul then
				self.Desc = "Defeat Boss Rush, Hush as Tainted Shiori"
				
				return self
			end
		end,
	})

	--Soul of Tsukasa
	Encyclopedia.AddSoul({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.SOUL_TSUKASA,
		WikiDesc = Wiki.SOUL_TSUKASA,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Soul of Tsukasa",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.tsukasasoul then
				self.Desc = "Defeat Boss Rush, Hush as Tainted Tsukasa"
				
				return self
			end
		end,
	})
	
	--Return Token
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_RETURN_TOKEN,
		WikiDesc = Wiki.CARD_RETURN_TOKEN,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Return Token",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.returntoken then
				self.Desc = "Defeat Ultra Greedier as Tainted Tsukasa"
				
				return self
			end
		end,
	})
	
	--Trial Stew
	Encyclopedia.AddCard({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Cards.CARD_TRIAL_STEW,
		WikiDesc = wakaba.encyclopediadesc.desc.collectibles.TRIAL_STEW,
		Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Trial Stew",0),
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.trialstew then
				self.Desc = "Defeat Ultra Greedier as Tainted Richer"
				
				return self
			end
		end,
	})
	


	
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	
	
	--Bring Me There
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.BRING_ME_THERE,
		WikiDesc = Wiki.BRING_ME_THERE,
	})
	
	
	--Bitcoin II
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.BITCOIN,
		WikiDesc = Wiki.TRINKET_BITCOIN,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.bitcoin < 1 then
				self.Desc = "Defeat Mother as Tainted Wakaba"
				return self
			end
		end,
	})
	
	--Clover
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.CLOVER,
		WikiDesc = Wiki.TRINKET_CLOVER,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.clover < 2 then
				self.Desc = "Defeat Mom's Heart as Wakaba in Hard Mode"
				return self
			end
		end,
	})

	--Hard Book
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.HARD_BOOK,
		WikiDesc = Wiki.TRINKET_HARD_BOOK,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.hardbook < 2 then
				self.Desc = "Defeat Mom's Heart as Shiori on Hard Mode"
				return self
			end
		end,
	})

	--Magnet Heaven
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.MAGNET_HEAVEN,
		WikiDesc = Wiki.TRINKET_MAGNET_HEAVEN,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.magnetheaven < 1 then
				self.Desc = "Defeat Ultra Greed as Shiori"
				return self
			end
		end,
	})
	

	--Ribbon of Determination
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.DETERMINATION_RIBBON,
		WikiDesc = Wiki.TRINKET_DETERMINATION_RIBBON,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.magnetheaven < 1 then
				self.Desc = "Defeat Ultra Greedier as Shiori"
				return self
			end
		end,
	})

	--Bookmark Bag
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.BOOKMARK_BAG,
		WikiDesc = Wiki.TRINKET_BOOKMARK_BAG,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.bookmarkbag then
				self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Shiori"
				return self
			end
		end,
	})

	--Ring of Jupiter
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.RING_OF_JUPITER,
		WikiDesc = Wiki.TRINKET_RING_OF_JUPITER,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.ringofjupiter < 1 then
				self.Desc = "Defeat Mother as Tainted Shiori"
				return self
			end
		end,
	})

	--Range OS
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.RANGE_OS,
		WikiDesc = Wiki.TRINKET_RANGE_OS,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.rangeos < 1 then
				self.Desc = "Defeat Hush as Tsukasa"
				return self
			end
		end,
	})

	--Siren's Badge
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.SIREN_BADGE,
		WikiDesc = Wiki.TRINKET_SIREN_BADGE,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.sirenbadge < 1 then
				self.Desc = "Defeat Mother as Tainted Tsukasa"
				return self
			end
		end,
	})
	
	--Isaac Cartridges
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.ISAAC_CARTRIDGE,
		WikiDesc = Wiki.TRINKET_ISAAC_CARTRIDGE,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.isaaccartridge then
				self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Tsukasa"
				return self
			end
		end,
	})
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE,
		WikiDesc = Wiki.TRINKET_AFTERBIRTH_CARTRIDGE,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.isaaccartridge then
				self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Tsukasa"
				return self
			end
		end,
	})
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE,
		WikiDesc = Wiki.TRINKET_REPENTANCE_CARTRIDGE,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.isaaccartridge then
				self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Tsukasa"
				return self
			end
		end,
	})
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.AURORA_GEM,
		WikiDesc = Wiki.TRINKET_AURORA_GEM,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.easteregg < 1 then
				self.Desc = "Defeat Mega Satan as Tainted Tsukasa"
				return self
			end
		end,
	})
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.STAR_REVERSAL,
		WikiDesc = Wiki.TRINKET_STAR_REVERSAL,
		--[[ UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.isaaccartridge then
				self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Tsukasa"
				return self
			end
		end, ]]
	})
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.MISTAKE,
		WikiDesc = Wiki.TRINKET_MISTAKE,
		--[[ UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.easteregg < 1 then
				self.Desc = "Defeat Mega Satan as Tainted Tsukasa"
				return self
			end
		end, ]]
	})

	--Delimiter
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.DELIMITER,
		WikiDesc = Wiki.TRINKET_DELIMITER,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.delimiter then
				self.Desc = "Complete Mine Stuff (challenge No.04w)"
				return self
			end
		end,
	})

	--Dimension Cutter
	Encyclopedia.AddTrinket({
		Class = class,
		ModName = class,
		ID = wakaba.Enums.Trinkets.DIMENSION_CUTTER,
		WikiDesc = Wiki.TRINKET_DIMENSION_CUTTER,
		UnlockFunc = function(self)
			if not wakaba.state.options.allowlockeditems and not wakaba.state.unlock.delirium then
				self.Desc = "Complete Delirium (challenge No.07w)"
				return self
			end
		end,
	})

	-- Pills
	for k, v in pairs(wakaba.descriptions["en_us"].pills) do
		Encyclopedia.AddPill({
			Class = class,
			ModName = class,
			 ID = k,
			Desc = "",
			 WikiDesc = Encyclopedia.EIDtoWiki(v.description),
			 Color = 9,
		})
	end





	
	
	
	
	
	
	
end