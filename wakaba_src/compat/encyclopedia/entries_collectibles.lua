local c = wakaba.Enums.Collectibles

wakaba.encyclopediadesc.desc.collectibles = {
  --#region Starting
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

	BOOK_OF_SHIORI = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "Activates additional effect when book active items are being used."},
			{str = "Shiori also gains extra tear effect when book active items are being used."},
			{str = "extra tear effect changes on next book usage."},
			{str = "Guarantees Library for each floor"},
			{str = "- Library doesn't appear on Blue Womb, or Chest/Dark room and onwards."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Shiori and Tainted Shiori starts with this item and is intrinsic to the characters, and it can't be rerolled"},
			{str = "- The book at the start of every floor will not spawn when playing as Shiori or Tainted Shiori."},
			{str = "- Shiori and Tainted Shiori can still find this item on a pedestal. Picking the item allows her to spawn extra library."},
			--{str = "Abyss Locust from this item deals 5X of Isaac's Damage."},
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
			{str = "While Isaac and other players stand inside the aura, grants + 1.5 damage up, + 2.0 tears up, 2.3x tears multiplier, and homing tears. It also gives Isaac a chance to block damage similar to Infamy."},
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
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Luna", clr = 3, halign = 0},
			{str = "???"},
			{str = "Sol", clr = 3, halign = 0},
			{str = "???"},
			{str = "Fragmented Card", clr = 3, halign = 0},
			{str = "???"},
			{str = "Firefly Lighter", clr = 3, halign = 0},
			{str = "Isaac has a chance to fire a glowing blue tear that, after colliding with an enemy, spawns a damaging beam of light. (simmilar as Holy Light)"},
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
			{str = "Concentration count is added every time Isaac concentrates depending of active's max charge."},
			{str = "- This count can be reduced when Isaac clears a room."},
			{str = "- Isaac cannot concentrate if count is over 300."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tsukasa starts with this item and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Tsukasa can still find this item on a pedestal. Picking it extends her maximum concentration count to normal and removes room clear penalty."},
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
			{str = "- For Keeper, and The Lost, or in Lost Curse state, Invincibility frames are reduced to 20 frames instead of removing all."},
			{str = "Regenerates health for fast time if Isaac did not get hit for brief time."},
			{str = "Soul Hearts will be recovered until his maximum soul heart count he gotten."},
			{str = "- For Keeper, and The Lost, or in Lost Curse state, regeneration time takes 6 seconds"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Tsukasa starts with this item and is intrinsic to the character, and it can't be rerolled"},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Diplopia", clr = 3, halign = 0},
			{str = "Multiple copies for Elixir of Life increases invincibility frames slightly, or reduces time to restore health for Keeper, or The Lost."},
		},
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
			{str = "Spawns a familiar that follows Isaac."},
			{str = "A Devil Room and Angel Room Door will always spawn after every boss fight, excluding first floor and floors after Chapter 4."},
			{str = "- The spawned door will not disappear when leaving and re-entering the boss room."},
			{str = "- Upon entering one, the other one will disappear."},
			{str = "- In rooms with only two accessible walls, only one of the two will spawn."},
			{str = "Angel Rooms can still appear even Isaac takes Devil deal if teleported via Joker, or etc."},
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
			{str = "Stores a charge for active items after every room."},
			{str = "- Rabbit Ribbon can store maximum of 16 charges."},
			{str = "- Automatically consumes stored charges if Isaac's active is not fully charged."},
			{str = "If any curse is applied, replaces it into new curse."},
			{str = "Curse of Sniper : Replaces Curse of Darkenss, Richer cannot see her weapons, but deal more damage to faraway enemies."},
			{str = "Curse of Labyrinth : Spawns more Treasure rooms and shops if possible."},
			{str = "Curse of Fairy : Replaces Curse of the Lost, Richer only can see map in limited range (same as spelunker hat) and her size is smaller."},
			{str = "Curse of the Magical Girl : Replaces Curse of the Unknown, Soul of the Lost effect is always active, but enemies are weaker. Also allows using Donation mechanics normally."},
			{str = "Curse of Amensia : Replaces Curse of the Maze, If Richer moves a room, there is a chance to make a random cleared room into uncleared."},
			{str = "Curse of the Blind : Simply removes the curse."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Richer starts with this item and is intrinsic to the character, and it can't be rerolled"},
			{str = "- Richer can still find this item on a pedestal. Picking the item adds 4 extra max charges."},
			{str = "- Tainted Richer can still find this item on a pedestal. Picking the item allows her storing extra charges."},
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
			{str = "If possible, additional rabbey-planetariums appear."},
			{str = "Rabbey-planetarium contains a planetarium item in even floors, and normal treasure item in odd floors."},
			{str = "- Rabbey-planetariums continue appear in Womb/Corpse floors."},
			{str = "- Rabbey-planetariums contain Devil items in Sheol, Angel items in Cathedral."},
			{str = "- Rabbey-planetariums contain Secret room items in Blue Womb."},
			{str = "- Rabbey-planetariums replace Treasure rooms if playing as Tainted Richer."},
			{str = "Crystal Restock machines appear in Rabbey-planetarium."},
			{str = "- Crystal Restocks can be used for paying 5 coins, or bombing itself."},
			{str = "- Can be used fixed amounts depending of its color."},
			{str = "- Crystal Restocks in Rabbey-planetariums always appear regardless of unlock status."},
		},
		{
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "More Options", clr = 3, halign = 0},
			{str = "Crystal restocks from Rabbey-planetariums gain more uses."},
		},
	},

	CHIMAKI = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "Wanders around and helps Rira through various behaviors:"},
			{str = "- Flies towards enemies if far away, with Holy Lights"},
			{str = "- Chance to remove Curses"},
			{str = "- Shoots Homing tears, or blue flames"},
			{str = "- Converts Troll bombs"},
		},
	},

	NERF_GUN = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Fires multiple 'nerf' tears that gives weakness status effect for 10 seconds."},
			{str = "- weakend enemies become slow and take double damage"},
		},
	},

	AZURE_RIR = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants Curse of The Blind immunity."},
			{str = "The extra blind items in Downpour, Mines and Mausoleum and their alternate stages will be revealed."},
			{str = "All trinkets become Aqua trinkets"},
			{str = "- Aqua trinkets are special type of trinket that are being absorbed on pickup instantly."},
			{str = "- Some trinkets are blacklisted to being Aqua trinkets, Azure Rir cannot change blacklisted trinkets."},
			{str = "- Azure Rir ignores unlock status from Aqua trinkets."},
		},
	},

	RABBEY_WARD = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Installs 'Rabbey Ward' that reveals on the map what type of room all 2 rooms adjacent to your current room are."},
			{str = "- Can also reveal Secret Rooms, Super Secret Rooms, Ultra Secret Rooms, and Mini-Boss Rooms."},
			{str = "Rooms within Rabbey Ward, or revealed by one also grants Damage, Tears up bonus."},
			{str = "- Bonus is determined how near the ward is"},
			{str = "Gives half Soul Heart when install."},
		},
	},

	KYOUTAROU_LOVER = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a familiar that follows Anna around shooting backstabbing tears that deal 3.5 damage."},
			{str = "All items are chosen from random item pools."},
			{str = "Only certain of Quality items can be spawn."},
			{str = "If Anna gets a collectible, The set quality is shifted by 1."},
			{str = "- If previous quality was 4, it will be shifted to 0."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Anna starts with this item and is intrinsic to the character, and it can't be rerolled"},
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


  --#endregion

  --#region Default

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
			{str = "5 books are selected per run."},
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
	CRISIS_BOOST = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+1 Tears Up"},
			{str = "Grants Damage Multiplier for less hearts and Holy Mantle Shields."},
			{str = "- formula : (26 - currentheart) / 32"},
			{str = "- Maximum multiplier is +45% for 1 or less total hearts."},
			{str = "- Grants +100% damage for total of half heart and no Holy shields."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item is inspired from 'Crisis Boost' from 'Rabi-Ribi'."},
			{str = "In Rabi-Ribi, Crisis Boost is activated if health is less than 20% of max."},
		},
	},
	SEE_DES_BISCHOFS = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- Isaac will respawn as Tainted Tsukasa in the previous room."},
			{str = "every 4 rooms spawns 4 book of virtues wisps."},
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
			{str = "luck gradually increases as timer goes on."},
			{str = "- +0.25 luck is added per minute."},
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
			{str = "Replaces all bomb spawns with a random pickup or golden troll bomb."},
			{str = "Upon taking damage, or losing Holy Mantle shields, spawns 6 golden troll bombs around the room."},
			{str = "All troll bombs are converted into Golden troll bombs if possible."},
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
	SUCCUBUS_BLANKET = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants one Black Heart when picked up."},
			{str = "Isaac has a chance to regenerate a Half Black Heart every time the in-game timer hits a new minute (00:01:00, 00:02:00, etc)."},
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
	RIRAS_BRA = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "On use, Grants Isaac 3-Dollar Bill effect for current room."},
			{str = "Enemies with status effects take 25% more damage under effect."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Stop Watch", clr = 3, halign = 0},
			{str = "Enemies always take more damage when Rira's Bra is in effect."},
		},
	},
	RIRAS_COAT = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "On use, Grants white fire effect for Isaac."},
			{str = "Also installs white fireplace."},
			{str = "The white fire effect is same as touching a white fire in Downpour/Dross 2."},
			{str = "The white fire effect is removed on room clear, and entering the other room."},
		},
	},
	POW_BLOCK = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Deals 275 split damage for all ground enemies."},
			{str = "Costs 2 Bombs on use"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "POW Block is one of very first element from entire Mario series."},
			{str = "Mario can use POW block to flip enemies on the ground."},
		},
	},

	MOD_BLOCK = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Deals 333 split damage for all floating enemies."},
			{str = "Costs 2 Bombs on use"},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "MOd Block is one fan elements from fangame from Mario franchise, 'Super Mario War'."},
		},
	},
	KANAE_LENS = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "x1.65 damage multiplier."},
			{str = "homing tears fired from Isaac's left eye"},
			{str = "- Isaac always shoots homing tears if more than 1 kanae lenses through such as diplopia."},
			{str = "- Isaac also always shoots homing tears for non-tear weapons."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The lens was taken from 'Shiratori Kanae', from 'Imouto no Okage de Motesugite Yabai.', or 'moteyaba' from hulotte."},
			{str = "Shiratori Kanae, or some females from Shiratori household gets heterochromia eyes, in order to watch some magical spells from the other household 'asasaka'"},
		},
	},
	RICHERS_BRA = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "All penalties by taking damage are removed. See synergies."},
			{str = "- Taking any damage counts as taking self-damage."},
			{str = "- Taking any red heart damage does not decrease the chance to open a Devil Room."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Paschal Candle", clr = 3, halign = 0},
			{str = "Taking damage from any sources will not reset the tears up."},
			{str = "Perfection", clr = 3, halign = 0},
			{str = "Taking damage from any sources will not lose Perfection trinket."},
			{str = "Damocles", clr = 3, halign = 0},
			{str = "Taking damage from any sources does not count as damage taken for Damocles, and will not give it the chance to fall."},
		},
	},
	BOOK_OF_AMPLITUDE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "While held, grants Isaac a boost depending on the book's color."},
			{str = "- Red : +2 Damage"},
			{str = "- Blue : +1 Fire rate"},
			{str = "- Yellow : +0.15 Speed"},
			{str = "- Green : +2 Luck"},
			{str = "Entering new room, or using active item changes to next color."},
			{str = "- The order is always Red - Blue - Yellow - Green, and goes to Red after Green"},
			{str = "RGON - Increases the chance to open the Devil Room or Angel Room after killing a boss by 20% while holding it"},
		},
	},
	CLEAR_FILE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "On use, opens a list that contains Isaac's current held passives"},
			{str = "Using again while on the list swaps nearby passive pedestal with selected item like Tainted Isaac."},
			{str = "- Cannot use against actives or quest items"},
		},
	},
	BUBBLE_BOMBS = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants 5 Bombs."},
			{str = "Isaac's Bombs aquafies enemies when they explode."},
			{str = "- Aquafied enemies take more damage from:"},
			{str = "-- Laser, Explosions, Aqua tears"},
			{str = "- Aquafied enemies take less damage from:"},
			{str = "-- Fire/Burn, Poison, Red Poops"},
			{str = "Bubble Bombs also instakills rock enemies such as:"},
			{str = "- Great Gideon"},
			{str = "- Stonies"},
			{str = "- Gaping Maws"},
			{str = "- Stone shooters"},
			{str = "- Rock Spiders"},
			{str = "- Ball and Chains"},
			{str = "- SpikeBalls"},
			{str = "- Wall Huggers"},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Dr. Fetus", clr = 3, halign = 0},
			{str = "Fired bombs have a chance to aquafy enemies. This chance scales with luck, going up to 100% at 22 Luck."},
			{str = "Epic Fetus", clr = 3, halign = 0},
			{str = "Fired missiles have a chance to aquafy enemies."},
		},
	},
  --#endregion

  --#region Wakaba

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
			{str = "Coins will be generated per room cleared."},
			{str = "Extra coin will be generated if Isaac did not take damage for current floor"},
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
			{str = "+ Deck of Cards/Mom's Bottle of Pills/Rune Archives", clr = 3, halign = 0},
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
			{str = "- unlike echo chamber, Wakaba's uniform only stores 3 effects instead of all."},
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

  --RIRAS_SWIMSUIT = {}, -- TR Wakaba Quartet
  --RIRAS_SWIMSUIT = {}, -- TR Wakaba Delirium

  --#endregion

  --#region Shiori

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
			{str = "Prevents death once and all damage taken is reduced to half a heart for current room."},
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


  --RIRAS_SWIMSUIT = {}, -- TR Shiori Quartet
  --RIRAS_SWIMSUIT = {}, -- TR Shiori Delirium

  --#endregion

  --#region Tsukasa

	RED_CORRUPTION = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "When entering new floor, generates new rooms adjacent special rooms if possible."},
			{str = "- The chance to create new room depends on Luck stat. At base luck (0), the chance is 25%, maxing out at 100% at 66 luck."},
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
			{str = "20% chance to take extra damage for enemies"},
			{str = "The chance for extra damage depends on the luck stat and goes up to 60% at 43 Luck."},
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
			{str = "5% chance to take armor-piercing damage for enemies"},
			{str = "The chance for extra damage depends on the luck stat and goes up to 43% at 55 Luck."},
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
			{str = "Clearing 8 rooms activate Holy Card effect (Max 2)"},
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
			{str = "All explosions ignore enemies' armor."},
			{str = "Explosions already ignored armor deal 2x damage."},
		},
		{ -- Notes
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted ???", clr = 3, halign = 0},
			{str = "Using Hold as Tainted ??? consumes 3 Poops and holds a bomb."},
			{str = "- This allows Tainted ??? using bombs more reliably. However, this will also make Hold relatively useless."},
			{str = "- Tainted ??? can use Hold only if his poops are less than 3."},
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
			{str = "All enemies now take 1.25x laser damage from all player's damage source."},
			{str = "All damage type that was already laser ignore enemies' armor."},
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
			{str = "Plasma Beam in Pudding n Wakaba mod has been changed, due to the original effect is excatly same as Trisagion item."},
		},
	},
	BEETLEJUICE = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Identifies all pills on pickup"},
			{str = "When used, Randomizes 1 pill effect for current run"},
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
			{str = "On use, Makes an explosion in entire room."},
			{str = "- All enemies take damage 2 per tick."},
			{str = "- All doors and rock obstacles also destroyed during this process."},
			{str = "- All pickups is pulled towards explosion point on fading."},
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
			{str = "After every 20 tears fired, Isaac will fire slash flame attack and wave of flames"},
			{str = "Each flame wave deals 2x of Isaac's damage"},
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

  --RIRAS_SWIMSUIT = {}, -- TR Tsukasa Quartet
  --RIRAS_SWIMSUIT = {}, -- TR Tsukasa Delirium

  --#endregion

  --#region Richer

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
			{str = "- Non-major Bosses have 1.36% chance instead of 5%, and is decreased over time and eventually goes to 0%"},
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
	BUNNY_PARFAIT = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- Isaac will respawn as Rira in the previous room."},
			{str = "Grants different tear effects depending of last digit of room number."},
			{str = "0/5 - Homing Tears (Spoon Bender)"},
			{str = "1/6 - Split Tears (Cricket's Body)"},
			{str = "2/7 - Mark Tears (Rotten Tomato)"},
			{str = "3/8 - Holy Tears (Holy Light)"},
			{str = "4/9 - Electric Tears (Jacob's Ladder)"},
			--{str = "Grants an extra life."},
			--{str = "- Isaac will respawn as Rira in the previous room."},
		},
		--[[ { -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Rira", clr = 3, halign = 0},
			{str = "Revives as herself, rather than normal Rira. Effectively acts as 1up!"},
		}, ]]
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Resurrection items activate in a set order."},
			{str = "Because characters are respawned as Rira, The abilities for their original character will be lost."},
			{str = "- Azazel will also lose his short-ranged Brimstone."},
			{str = "- If Lilith is resurrected she will lose Incubus and fire as any other character instead."},
			{str = "- Shiori will also lose all of her books."},
			{str = "Like other items that grant an extra life, but respawn Isaac as a different character, all completion marks earned from the moment of death onward will count towards the new character, not the old."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Bunny Parfait is one of Caramella recipe item references Niwasaka Rira."},
			-- TODO Trivia
		},
	},
	CARAMELLA_PANCAKE = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- Isaac will respawn as Richer in the previous room."},
			{str = "Attacks are replaced, or spawns Caramella member flies"},
			{str = "- Tears are replaced by lavender fly states Richer."},
			{str = "-- Richer flies take 4x damage."},
			{str = "- Shooting lasers also spawns pink fly states Rira."},
			{str = "-- Rira flies take 3x damage, and grants aqua status effect"},
			{str = "- Fetus bombs are replaced by golden fly states Ciel."},
			{str = "- Epic Fetus pointer spawns golden fly states Ciel."},
			{str = "-- Ciel flies take 10x damage, with explosion that doesn't hurt Isaac."},
			{str = "- Shooting Knives also spawns silver fly states Koron."},
			{str = "-- Koron flies take 4x damage, and grants petrified status effect."},
			{str = "- Each Caramella member flies can be stacked up to 10x"},
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
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Caramella Pancake is one of Caramella recipe item references Shionomiya Richer."},
			-- TODO Trivia
		},
	},
	RICHERS_UNIFORM = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "On use, Different effects occur depending on room types."},
		},
	},
	LIL_RICHER = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a familiar that follows Isaac around shooting chasing tears that deal 2 damage each tick."},
			{str = "Lil Richer shoots once per second."},
			{str = "Stores a charge for active items after every room."},
			{str = "- Lil Richer can store maximum of 12 charges."},
			{str = "Automatically consumes stored charges if Isaac's active is not fully charged."},
			{str = "This item belongs to the Conjoined set. Collecting three items from this set will transform Isaac into a three-faced version of himself."},
		},
	},
	CUNNING_PAPER = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants a random card that transforms into a different random card upon use."},
			{str = "Each card has a 2 room charge."},
		},
	},
	SELF_BURNING = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "On use, burns Isaac himself, making burning status."},
			{str = "During burn, Isaac is immune to take any damage except projectiles."},
			{str = "Isaac's health is drained per 20 seconds, but won't kill him."},
			{str = "Taking damage from projectiles removes burning status."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Self Burning is one of Mega Man's weapon from a romhack 'Rockman 7 EP'."},
			{str = "Self Burning allows Mega Man invincible except projectiles, and damages enemies if inside in water."},
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
			{str = "On use, Removes all health and Holy Mantle shields, fully charges active items and adds 8 trial stacks."},
			{str = "+1 Fire rate, +25% Damage per trial stack, +100% Damage during active."},
			{str = "Clearing a room will decrease a trial stack"},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Blank Card", clr = 3, halign = 0},
			{str = "Requires 8 charges to use. Does NOT recharges Blank Card itself if used by Blank Card"},
			{str = "Holy Mantle, Blanket, Holy Card, Priest's Blessing, Wakaba's Blessing", clr = 3, halign = 0},
			{str = "Allows Isaac recover shield as soon as the condition meets."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Tarot Card", clr = 3, halign = 0},
			{str = "Additional 3 trial stacks are granted."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Trial Stew is one of challenging items from 'Paper Mario : The Thousand Year Door', one of famous RPG titles from Mario series."},
			{str = "Using Trial Stew in PM : TTYD reduces player's HP to 1, and FP to 0, but refills all star powers, which allows to use special moves."},
		},
	},

  --RIRAS_SWIMSUIT = {}, -- TR Richer Quartet
  --RIRAS_SWIMSUIT = {}, -- TR Richer Delirium

  --#endregion

  --#region Rira
  BLACK_BEAN_MOCHI = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Adds 10% chance to shoot zipped tears, making explosion while zipped."},
			{str = "- The explosion from zip does not harm Isaac."},
			{str = "The explosion from zip also make nearby enemies zipped, which allow massive chain of explosions."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The chance for a tear to be zipped depends on the luck stat and goes up to 100% at 16 Luck."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Compound Fracture/ Cricket's Body/ Haemolacria/ The Parasite: Chance for tears and split tears to be zipped. If the main tear is zipped, the split tears are too."},
			{str = "Dr. Fetus/ Epic Fetus: Chance for bombs/explosions to become zipped."},
			{str = "Lachryphagy: If a poison tear is fed, all burst tears are zipped. If a normal tear is fed, the burst tears are not zipped."},
			{str = "The Ludovico Technique: The tear flickers dark red, capable of zip enemies when it does."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Black Bean Mochi was implemented from one of kohashiwahaba's unfinished item, 'Not a Shotgun'."},
			{str = "- Not a Shotgun was one of items that is referenced after Korean Isaac Streamer 'Murdoc', who is always angry and hitting elements all over the time"},
			{str = "- The term 'Shotgun' was also originated from this behavior."},
			{str = "Black Bean Mochi is one of Niwasaka Rira's memorial item."},
			-- TODO Trivia
		},
	},
  RIRAS_SWIMSUIT = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Adds 10% chance to shoot aqua tears, making enemies aquafied."},
			{str = "- Aquafied enemies take more damage from:"},
			{str = "-- Laser, Explosions, Aqua tears"},
			{str = "- Aquafied enemies take less damage from:"},
			{str = "-- Fire/Burn, Poison, Red Poops"},
			{str = "Aqua tears also instakills rock enemies such as:"},
			{str = "- Great Gideon"},
			{str = "- Stonies"},
			{str = "- Gaping Maws"},
			{str = "- Stone shooters"},
			{str = "- Rock Spiders"},
			{str = "- Ball and Chains"},
			{str = "- SpikeBalls"},
			{str = "- Wall Huggers"},
			--{str = "Aqua tears also instakills following enemies:"},
			--{str = "Aqua tears also degenerates following enemies into:"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The chance for a tear to be aqua depends on the luck stat and goes up to 100% at 38 Luck."},
			{str = "- Rira has innate version of this item, though the chance for a tear to be aqua reduced to 5% and goes up to 100% at 19 Luck."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Compound Fracture/ Cricket's Body/ Haemolacria/ The Parasite: Chance for tears and split tears to be aqua. If the main tear is aqua, the split tears are too."},
			{str = "Dr. Fetus/ Epic Fetus: Chance for bombs/explosions to become aqua."},
			{str = "Lachryphagy: If a poison tear is fed, all burst tears are aqua. If a normal tear is fed, the burst tears are not aqua."},
			{str = "The Ludovico Technique: The tear flickers dark red, capable of aquafy enemies when it does."},
		},
	},
  SAKURA_MONT_BLANC = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Each time an enemy is killed, Isaac gains a damage, fire rate boost for the current room."},
			{str = "- Each kill increases damage by 0.16, up to a maximum of 1 damage after 6 kills."},
			{str = "- Each kill increases fire rate by 0.67, up to a maximum of 4 fire rate after 6 kills."},
			{str = "Killed enemies also make nearby enemies aquafied."},
			{str = "- Aquafied enemies take more damage from:"},
			{str = "-- Laser, Explosions, Aqua tears"},
			{str = "- Aquafied enemies take less damage from:"},
			{str = "-- Fire/Burn, Poison, Red Poops"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Some summoned enemies like Rag man's Raglings do not trigger the effect when killed."},
			{str = "Blowing up a shopkeeper will grant Isaac a damage bonus as well."},
			{str = "Freezing enemies with ice tears from Uranus seems to not give the damage up."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Sakura Mont Blanc is one of Caramella recipe item references Niwasaka Rira."},
			-- TODO Trivia
		},
	},
  CHEWY_ROLLY_CAKE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon Isaac takes damage, grants +0.3 speed for the current room."},
			{str = "- Also, removes nearby projectiles and slows all enemies in the room permanently."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Slowing effect is same as Broken Watch, and cannot be stacked."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Chewy Rolly Cake is one of Caramella recipe item references Niwasaka Rira."},
			-- TODO Trivia
		},
	},
	RIRAS_UNIFORM = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "On use, grants Astral Projection effect."},
			{str = "- Isaac's tears and speed are greatly increased while time is stopped, although this is not shown on the HUD."},
			{str = "- Does not negate secondary damage."},
			{str = "Unlike the original item, Rira's Uniform also works in cleared rooms."},
		},
	},
	SECRET_DOOR = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Teleports to starting room."},
			{str = "For following conditions, different effect will occur:"},
			{str = "In Mom's Room, Opens Boss Rush Door."},
			{str = "In Shop, Opens Membership Shop Door."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Secret Door is the key item for finding hidden items from 'Paper Mario Sticker Star'."},
			{str = "Most special attacks for PMSS, which is called 'Things' requires Secret Door to find."},
		},
	},
  RIRAS_BENTO = {
		{ -- Effect
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants one full Red Heart container."},
			{str = "Heals 1 additional heart of health."},
			{str = "+0.04 Speed Up"},
			{str = "+0.35 Fire rate Up"},
			{str = "x1.07 Damage Multiplier"},
			{str = "+0.5 Range Up"},
			{str = "+0.4 Luck Up"},
			{str = "Every future items will be Rira's Bento, making unable to get other collectibles."},
			{str = "Every half heart Isaac has, grants +0.5 Damage up"},
		},
	},
  RIRAS_BANDAGE = {
		{ -- Effect
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "On new floor:"},
			{str = "- Activates on-damage effects 6 times"},
			{str = "- Smelts currently held trinkets"},
		},
	},
  LIL_RIRA = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a familiar that follows Isaac around shooting chasing tears that deal 2 damage each tick."},
			{str = "Lil Rira shoots once per second."},
			{str = "Grants permanent damage up on active usage"},
			{str = "- Does not add damage if charge is not consumed, such as debug 8 mode."},
			{str = "Every charge pip used grants Isaac +0.05 Damage up"},
			{str = "- For timed ones, +0.05 is granted per 12 second max charges."},
		},
	},
  SAKURA_CAPSULE = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an extra life."},
			{str = "- Isaac will respawn with 4 hearts with restarting the stage."},
			{str = "Until revival, On new floor, spawns one of each pickups."},
		},
	},
  MAID_DUET = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Pressing '8' on keyboard make Isaac's current held active item into pocket slot."},
			{str = "If there are any actives in pocket slot, previous pocket slot active will be moved into primary active slot."},
			{str = "- Does not work for some items. See blacklist section."},
			{str = "Once active location is swapped, Isaac cannot swap again until a room is cleared."},
		},
		{ -- Blacklist
			{str = "Blacklist", fsize = 2, clr = 3, halign = 0},
			{str = "To prevent unintended behaviors or bugs, some items or characters cannot use this item"},
			{str = "- Tainted Cain"},
			{str = "- Shiori"},
			{str = "- Book of Virtues"},
			{str = "- Book of Belial (Judas Birthright)"},
			{str = "- D Infinity"},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Diplopia: Multiple copies of Maid Duet adds extra charge for swapped actives."},
			{str = "- Timed actives give 10% of max charges."},
			{str = "- Special actives do not grant extra charges."},
		},
	},

  --RIRAS_SWIMSUIT = {}, -- T Rira Beast

  --RIRAS_SWIMSUIT = {}, -- TR Rira Quartet
  --RIRAS_SWIMSUIT = {}, -- TR Rira Delirium

  --#endregion

  --#region Challenges
	EYE_OF_CLOCK = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Max 3 orbiting lasers are created as Isaac is shooting."},
			{str = "Each orbiting Tech.X lasers also fire additional lasers."},
			{str = "- Laser Damage : Damage * 0.5"},
			{str = "- All orbiting lasers and additional lasers inherit Isaac's tear effects."},
			{str = "- Laser Damage : Damage * 0.16"},
			{str = "Lasers disappear if Isaac stops shooting."},
			{str = "- Being hit, changing rooms, and using items does not make laser disapeear."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Eye of Clock was implemented from one of kohashiwahaba's unfinished item, 'Eye of Clock'."},
			{str = "- The effect of original Eye of Clock was just adding straight laser from Isaac that constantly rotates over time"},
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
	NEKO_FIGURE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "x0.9 Damage Multiplier."},
			{str = "Isaac's non-explosive attacks now ignore armor."},
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
	EXECUTIONER = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac has a chance to fire an execution attack that erases the enemy."},
			{str = "if the enemies are hit, despawning all enemies of that type for the rest of the run."},
			{str = "Bosses have 100% chance to be erased."},
			{str = "- To prevent softlocks, Isaac will never shoot Eraser tears in The Visage, Mother, Dogma, The Beast fight."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The chance to fire a execution attack depends on the luck stat. At base luck (0), the chance is 0.75%, maxing out at 10% at 117 luck."},
			{str = "Executioner Locust deals 4.2x 'slower' than normal locust, 16x Isaac's Damage, travels at 0.1x speed."},
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
			{str = "After absorbing 1 or more active items, Isaac also can activate one of individual absorbed active item."},
			{str = "- Can be selected extra left/right button. configurable."},
			{str = "- Activating individual ones change max charges to corresponding item."},
			{str = "- Not selecting individual still activate original effect above."},
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
	RICHERS_FLIPPER = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, flips a group of pickups each other."},
			{str = "- Bombs and Keys"},
			{str = "- Cards/Runes and Pills"},
		},
	},
	RICHERS_NECKLACE = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "If a tear misses enemy, The leftover of the tear emits white laser, similarly with Dogma's laser tears."},
			{str = "- Emitted lasers targets random enemy, and deals 8 damage per tick, maximum 40."},
			{str = "- Can control laser emit timing by holding, or canceling shoot button."},
		},
	},
  CROSS_BOMB = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Grants 5 Bombs."},
			{str = "Causes bombs to explode in a large cross-shaped blast by adding three extra delayed explosions in each cardinal direction."},
			{str = "The damage for an extra explosion is 10 and does not harm Isaac."},
			{str = "With Cross Bomb, Bedrooms, super special rocks, and the (in Repentance)Mines can be accessed with a single bomb."},
		},
	},
  GOOMBELLA = {},

	-- Anna items
	ANNA_RIBBON_0 = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+0.05 Range"},
			{str = "Gives random troll trinket"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item can be only appeared through Anna"},
			{str = "- This item only appears when Quality 0 is not available."},
		},
	},

	ANNA_RIBBON_1 = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+0.01 Speed"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item can be only appeared through Anna"},
			{str = "- This item only appears when Quality 1 is not available."},
		},
	},

	ANNA_RIBBON_2 = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+0.1 Luck"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item can be only appeared through Anna"},
			{str = "- This item only appears when Quality 2 is not available."},
		},
	},

	ANNA_RIBBON_3 = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+0.01 Tears"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item can be only appeared through Anna"},
			{str = "- This item only appears when Quality 3 is not available."},
		},
	},

	ANNA_RIBBON_4 = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "+0.02 Damage"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item can be only appeared through Anna"},
			{str = "- This item only appears when Quality 4 is not available."},
		},
	},

	-- Final items

	PURIFIER = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Dissolves item pedestals into several keys for several keys"},
			{str = "- The Number of keys are 4 + Quality of the item."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item can be only appeared through Shiori, with Passive Skill Tree support"},
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
	STICKY_NOTE = {
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
  --#endregion
}