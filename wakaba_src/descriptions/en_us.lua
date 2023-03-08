local desclang = "en_us"

wakaba.descriptions[desclang] = {}
wakaba.descriptions[desclang].birthright = {
	[wakaba.Enums.Players.WAKABA] = {
		playerName = "{{ColorWakabaBless}}Wakaba",
		description = "↑ {{Heart}}Extends one Heart limit#{{AngelChance}} 100% chance to find an Angel Room in all floors",
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		playerName = "{{ColorWakabaNemesis}}Tainted Wakaba",
		description = "↑ {{Collectible"..wakaba.Enums.Collectibles.WAKABAS_NEMESIS.."}}Wakaba's Nemesis no longer decreases all stats, and reduces damage fading rate#Explosions and crush impacts immunity",
	},
	[wakaba.Enums.Players.SHIORI] = {
		playerName = "{{ColorBookofShiori}}Shiori",
		description = "↑ Halves key consume when using active item(Minimum 1)",
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		playerName = "{{ColorCyan}}Minerva{{CR}}(Tainted Shiori)",
		description = "{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} Allows aura activation#The number of required keys for {{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_CONQUEST.."}}Book of Conquest and active items are reduced (Minimum 1)#↑ All stats up for current number of conquered enemies",
	},
	[wakaba.Enums.Players.TSUKASA] = {
		playerName = "{{ColorPink}}Tsukasa",
		description = "Allows Tsukasa to find Afterbirth ~ Repentance items#↑ Extends maximum {{Collectible"..wakaba.Enums.Collectibles.LUNAR_STONE.."}}Lunar gauge limit",
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		playerName = "???(Tainted Tsukasa)",
		description = "Allows Tainted Tsukasa to shoot tears#{{Collectible"..wakaba.Enums.Collectibles.FLASH_SHIFT.."}} Flash Shift ability is now moved into pocket item slot.",
	},
	[wakaba.Enums.Players.RICHER] = {
		playerName = "Richer",
		description = "#{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}}Sweets Catalog effect is now persistent until next catalog usage#{{Collectible260}} Grants immunity to curses",
	},
	[wakaba.Enums.Players.RICHER_B] = {
		playerName = "Tainted Richer",
		description = "#More durable Flames#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}}Water-Flame Grants additional passive per absorbed flame",
	},
}
wakaba.descriptions[desclang].collectibles = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		itemName = "Wakaba's Blessing",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#↑ Prevents {{Quality0}}/{{Quality1}} items from spawning"
		.. "#All damage taken will be non-penalty damage"
		.. "#Gives {{Collectible313}}Holy Mantle shield per room on a total of 1 heart or less (Except T.Lost)"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		itemName = "Wakaba's Nemesis",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#↑ Armor-piercing tears (Except Wakaba)"
		.. "#↓ Picking up an item grants temporary {{Damage}} +3.6 damage boost and permanent all stats downs"
		.. "#↓ Prevents {{Quality4}} items from spawning, also reduces chances for {{Quality3}} items"
		.. "#Cards and runes has chance to be replaced into {{Card78}}Cracked Key"
		.. "#{{DevilRoom}} Price of Devil room items are set to 6 coins"
		.. "#All damage taken will be non-penalty damage"
		.. "#!!! Taking this item by any means counts as Taking Devil deals."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.LEVIATHAN .. "",
	},
	[wakaba.Enums.Collectibles.WAKABA_DUALITY] = {
		itemName = "Wakaba Duality",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#↑ Armor-piercing tears (Except Wakaba)"
		.. "#↓ Picking up an item grants temporary {{Damage}} +3.6 damage boost and permanent all stats downs"
		.. "#{{AngelDevilChance}}100% chance to find an Devil/Angel Room in all floors except Blue Womb"
		.. "#↑ Can get all items with selection"
		.. "#Cards and runes has chance to be replaced into {{Card78}}Cracked Key"
		.. "#{{DevilRoom}} Price of Devil room items are set to 6 coins"
		.. "#All damage taken will be non-penalty damage"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.LEVIATHAN .. "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SHIORI] = {
		itemName = "Book of Shiori",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#Activates additional effect when book active items are being used"
		.. "#Isaac also gains extra tear effect when book active items are being used"
		.. "#Extra tear effect changes on next book usage"
		.. "#Spawns a random Book item at the start of every floor"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		itemName = "Book of Conquest",
		description = ""
		.. "#Permanently charms non-boss enemies in the current room."
		.. "#Charmed enemies' health is set to 10x of their max health."
		.. "#!!! Cannot use the item if there are too many friendly enemies!"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.MINERVA_AURA] = {
		itemName = "Minerva's Aura",
		description = ""
		.. "#Isaac and Other players inside aura grants:"
		.. "↑ {{Damage}} +1 damage"
		.. "↑ {{Tears}} +2.0 Fire rate up"
		.. "↑ Homing Tears"
		.. "#Friendly monsters/familiars inside the aura gradually recovers their health"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Collectibles.LUNAR_STONE] = {
		itemName = "Lunar Stone",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#↓ Reduces heart container limit to 8"
		.. "#↑ Grants additional Lunar gauge that gives {{Damage}}Damage, {{Tears}}Tears up that scales with it"
		.. "#If damage is taken, Lunar Stone deactivates and lunar gauge starts deplete"
		.. "#Soul hearts are automatically used for recover lunar gauge"
		.. "#↑ Unlimited lives as long as Isaac holds Lunar Stone"
		.. "#!!! Lunar Stone is removed when gauge depletes"
		.. "#All damage taken will be non-penalty damage"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ELIXIR_OF_LIFE] = {
		itemName = "Elixir of Life",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{WakabaAntiCurseUnknown}} Curse of the Unknown immunity"
		.. "#↓ {{ColorOrange}}Removes invincibility frames"
		.. "#Regenerates health for fast time if Isaac did not get hit for brief time depends on which type of health character is:"
		.. "#{{Heart}} {{ColorRed}}All soul hearts are converted into bone hearts. Regenerates Red Hearts"
		.. "#{{SoulHeart}} {{ColorSoul}}Regenerates Soul hearts until maximum count Isaac have gotten"
		.. "#{{Card"..Card.CARD_SOUL_LOST.."}} {{ColorSilver}}Regenerates {{Collectible313}}Holy Mantle shields up to 5"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		itemName = "Flash Shift",
		description = ""
		.. "Shifts Isaac for four direction that Isaac moving"
		.. "#Can be used up to 3 times until recharged"
		.. "#!!! Familiars do not shift, Beware when using orbitals or wisps"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.CONCENTRATION] = {
		itemName = "Concentration",
		description = ""
		.. "#Hold Drop button to enter concentration mode"
		.. "#Concentrate 3 seconds to fully charge active items"
		.. "#↑ +1.5 {{Range}} Range up for concentrate (additional +0.25 per count)"
		.. "#!!! Concentration time increases per usage. This count can be decreased on room clears"
		.. "#!!! Isaac cannot move and takes twice damage while in concentration mode"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.RABBIT_RIBBON] = {
		itemName = "Rabbit Ribbon",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{CurseCursed}} Changes other curses"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.SWEETS_CATALOG] = {
		itemName = "Sweets Catalog",
		description = ""
		.. "#Gives one of following weapons for current room:"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.WINTER_ALBIREO] = {
		itemName = "The Winter Albireo",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{PlanetariumChance}} Planetariums always appear if possible"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		itemName = "Water-Flame",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity while held"
		.. "#On use, absorbs the nearest passive pedestal and spawns copy wisp of the absorbed one."
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.BROKEN_TOOLBOX] = {
		itemName = "Broken Toolbox",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#While in uncleared room, Spawns a pickup per second"
		.. "#All pickups explode if 15 or more on the room."
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		itemName = "Eat Heart",
		description = ""
		.. "#Only can be charged through damaging enemies or self damage."
		.. "#Can be overcharged without {{Collectible"..CollectibleType.COLLECTIBLE_BATTERY .."}}The Battery. Max 15000 damage"
		--[[ .. "#!!! Wakaba variant : " ]]
		.. "#Spawns a random collectible item from current item pool"
		.. "#{{Quality3}}/{{Quality4}} are guaranteed to be spawned"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		itemName = "Book of Forgotten",
		description = ""
		.. "#Applies to all players on use:"
		.. "#↑ {{BoneHeart}} +1 Bone Heart"
		.. "#{{Heart}} Heals all heart containers"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		itemName = "D-Cup Ice Cream",
		description = ""
		.. "#↑ {{Heart}} +1 Heart Container"
		.. "#↑ {{Heart}} Heals one Red Heart"
		.. "#↑ {{Damage}} +0.3 Damage Up"
		.. "#↑ {{Damage}} +80% Damage Multiplier (Does not stack)"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM] = {
		itemName = "Mint-Chocolate Ice Cream",
		description = ""
		.. "#↑ {{Tears}} +100% Fire rate Multiplier (Does not stack)"
		.. "#↑ {{Tears}} +0.2 additional Fire rate per stack"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD] = {
		itemName = "Mysterious game CD",
		description = ""
		.. "#↑ {{Heart}} +1 Heart Container"
		.. "#↑ {{Speed}} +0.16 Speed"
		.. "#↑ {{Tears}} +0.7 Tears"
		.. "#↑ {{Shotspeed}} +0.1 Shot Speed"
		.. "#↑ {{Range}} +0.85 Range"
		.. "#↑ {{Damage}} +0.5 Damage"
		.. "#Rooms will be randomly colorized slightly"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		itemName = "Wakaba's Pendant",
		description = ""
		.. "#{{Luck}} Sets your Luck to 7 if you have less than 7"
		.. "#↑ {{Luck}} +0.35 Luck per Luck affect items"
		.. "#↑ {{Damage}} +1 Damage"
		.. "#{{Heart}} Full Health"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.WAKABAS_HAIRPIN] = {
		itemName = "Wakaba's Hairpin",
		description = ""
		.. "#↑ {{Luck}} +0.25 Luck per pill consumed"
		.. "#↑ {{Damage}} +1 Damage"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		itemName = "Secret Card",
		description = ""
		.. "#↑ {{Coin}} +22 Coins"
		.. "#{{Coin}} Coins will be generated per room cleared ({{HardMode}} Only 1 per clear on Hard Mode)"
		.. "#{{Shop}} Prevents Greed / Super Greed to be spawned in Shops"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		itemName = "Plumy",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_PLUM_FLUTE.."}} A Baby Plum familiar that follows Isaac."
		.. "#Shoots tears in front of Isaac and blocks projectiles"
		.. "#When Plumy gets damaged too much, Plumy cannot move and needs 10 seconds to recovery"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		itemName = "Executioner",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_ERASER .."}} Shoots Eraser tears for extremely low rate"
		.. "#Always shoots Eraser tears when only bosses are in the room"
		.. "#!!! {{ColorSilver}}Eraser tears will NOT fired in certain boss battles like Dogma and Mother{{ColorReset}}"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
	},
	[wakaba.Enums.Collectibles.NEW_YEAR_BOMB] = {
		itemName = "New Year's Eve Bomb",
		description = ""
		.. "#↑ {{Bomb}} +9 Bombs"
		.. "#↑ {{PoopPickup}}+2 Poops per new room for {{Player25}} Tainted ???"
		.. "#Enemies' Health hit by explosion of Isaac's attack will set to 1"
		.. "#↓ Enemies no longer be killed from this explosion"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
	},
	[wakaba.Enums.Collectibles.REVENGE_FRUIT] = {
		itemName = "Revenge Fruit",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_BRIMSTONE .."}} Adds a chance to shoot Brimstone Lasers instead of a tear"
		.. "#Chance increases every time Isaac takes damage on current floor"
		--.. "#{{Collectible"..CollectibleType.COLLECTIBLE_BRIMSTONE .."}} 1.5x Damage multiplier"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		itemName = "Wakaba's Uniform",
		description = ""
		.. "#Upon use, stores/swaps current card, pill, or rune"
		.. "#Drop button changes which slot to store/swap"
		.. "#When Isaac uses a card, pill, or rune, he also uses a copy of every card/pill/rune stored in Wakaba's Uniform"
		.. "#Hold Tab Key/Map Button to show current slot"
		.. "#Only consume charges in Hard mode."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
	},
	[wakaba.Enums.Collectibles.EYE_OF_CLOCK] = {
		itemName = "Eye of Clock",
		description = ""
		.. "#3 Tech. X lasers orbit Isaac"
		.. "#Lasers' damage scales with Isaac's Damage stats"
		.. "#Pressing fire button also fires lasers from each orbiting lasers"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
	},
	[wakaba.Enums.Collectibles.LIL_WAKABA] = {
		itemName = "Lil Wakaba",
		description = ""
		.. "#Shoots small Tech.X Lasers"
		.. "#Deals 40% of Isaac's damage"
		.. "#Fire rate depends on Isaac's Tears stats"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.COUNTER] = {
		itemName = "Counter",
		description = ""
		.. "#Makes Isaac invincible for 1 second"
		.. "#Fires lasers to enemies while invincible"
		.. "#!!! This item automatically activates when taking damage. Activating the item this way will also prevent Isaac to be damaged"
		.. "#Does not activate when other shields are active"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.RETURN_POSTAGE] = {
		itemName = "Return Postage",
		description = ""
		.. "#All selected enemies become charmed permenantly"
		.. "#{{Blank}} This includes : Needle, Pasty, Dust, Polty, Kineti, Mom's Hand"
		.. "#!!! Haunted Chest still damages Isaac, but tries to throw away from him"
		.. "#All Eternal Flies are removed"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.D6_PLUS] = {
		itemName = "D6 Plus",
		description = ""
		.. "#{{Card"..Card.CARD_SOUL_ISAAC.."}} Invokes Soul of Isaac effect"
		.. "#Rerolls the items in the room"
		.. "#Cycle back to their original form after one second"
		.. "#Effect repeats"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		itemName = "D6 Chaos",
		description = ""
		.. "#{{Card"..Card.CARD_SOUL_ISAAC.."}} Invokes Soul of Isaac effect for {{ColorRed}}9 times{{CR}}"
		.. "#Rerolled items cycle for insane speed"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.LIL_MOE] = {
		itemName = "Lil Moe",
		description = ""
		.. "#Shoots orbiting and homing tears"
		.. "#Every tear has random tear effects, dealing least 4 damage"
		.. "{{Blank}} (Explosive effects not included)"
		.. "#Fire rate depends on Isaac's Tears stats"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		itemName = "Book of Focus",
		description = ""
		.. "#{{Weakness}} Weakens all enemies in the current room"
		.. "#If Isaac is not moving manually, Isaac shoots Homing and Spectral tears with +1.4 {{Damage}}Damage and +1.0 {{Tears}}Tears"
		.. "#!!! Isaac will also take at least 2 Full Heart Damage in the current room"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		itemName = "Shiori's Bottle of Runes",
		description = ""
		.. "#{{Rune}} Gives Isaac a random rune"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		itemName = "Micro Doppelganger",
		description = ""
		.. "#Spawns 12 tiny Isaac familiars."
		.. "#They chase and shoot at nearby enemies"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		itemName = "Book of Silence",
		description = ""
		.. "#Removes all enemy projectiles"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.VINTAGE_THREAT] = {
		itemName = "{{ColorRed}}Vintage Threat",
		description = ""
		.. "#{{Player"..wakaba.Enums.Players.SHIORI_B.."}} On death, Respawn as Tainted Shiori in current room"
		.. "#Reviving into Tainted Shiori resets keys count to 0, and activates 4 {{Collectible656}}Damocles swords"
		.. "#!!! {{ColorBlink}}{{ColorRed}}TAKING ANY PENALTY DAMAGE WILL MAKE DAMOCLES SWORD FALL AND ENDS THE RUN IMMEDIATELY REGARDLESS OF EXTRA LIVES OR REMANING PLAYERS!{{ColorReset}}"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_GOD] = {
		itemName = "Book of the God",
		description = ""
		.. "#If damage is lethal, Isaac turns into angel"
		.. "#!!! After Isaac turning into Angel:"
		.. "#↓ -50% {{Damage}}Damage Multiplier"
		.. "#Tears gain a damaging aura which deals same amount of Isaac's Damage"
		.. "#{{BrokenHeart}} Taking any damage gives Isaac Broken heart"
		.. "#!!! Cannot get Sacrifice room rewards when turning into angel"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		itemName = "Grimreaper Defender",
		description = ""
		.. "#Prevents death and all damage taken is reduced to half a heart for current room."
		.. "#Also all damage takes red hearts first and prevents penalty damage."
		.. "#!!! {{ColorYellow}}The effect of the book will not work on Sacrifice rooms Spikes!{{ColorReset}}"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_TRAUMA] = {
		itemName = "Book of Trauma",
		description = ""
		.. "#Detonate Isaac's tears currently on the screen, causing each one to explode (Max 15)."
		.. "#Exploded tear shots Brimstone laser at 4 directions."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		itemName = "Book of The Fallen",
		description = ""
		--.. "#!!! This item cannot be used before reviving into Fallen Angel"
		.. "#If damage is lethal while having this item, Isaac turns into Fallen Angel, and gives 6 Black Hearts"
		.. "#!!! {{ColorSilver}}After Isaac turning into Fallen Angel:"
		.. "#{{ColorSilver}}On use, Spawns fires at random enemies which deal Isaac's Damage + 35"
		.. "#↓ {{ColorSilver}}Can no longer shoot tears"
		.. "#↑ {{Damage}} {{ColorSilver}}+1500% Damage Multiplier"
		.. "#!!! {{ColorYellow}}Isaac can no longer swap active items{{ColorReset}}"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.LEVIATHAN .. "," .. EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY] = {
		itemName = "Maijima Mythology",
		description = ""
		.. "#Random book active item effect"
		--[[ .. "#!!! Following books can be activated:" ]]
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = {
		itemName = "Apollyon Crisis",
		description = ""
		.. "#Invokes both {{Collectible477}}Void and {{Collectible706}}Abyss effect:"
		.. "#!!! When used, consume any pedestal items in the room"
		.. "#Active item: Its effect will be added to Void's effect (Stacking the effects)"
		.. "#↑ Passive item: Small stat upgrade to a random stat"
		.. "#Spawns an attack fly familiar for each consumed item"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.LIL_SHIVA] = {
		itemName = "Lil Shiva",
		description = ""
		.. "#{{Collectible532}} hungry tear familiar"
		.. "#Shoots Charged wave of tears"
		.. "#Tears slow down while traveling"
		.. "#Upon stopping, they explode in 8 smaller tears"
		.. "#Tears can be fired in other tears, making them bigger"
		.. "#Isaac can support Lil Shiva using his tears"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.NEKO_FIGURE] = {
		itemName = "Neko Figure",
		description = ""
		.. "#↓ {{Damage}} -10% Damage"
		.. "#Isaac's attacks now ignores armor"
		.. "#↑ Guarantees {{Quality3}}/{{Quality4}} items in {{UltraSecretRoom}}Ultra Secret Room"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.GUPPY .. "",
	},
	[wakaba.Enums.Collectibles.DEJA_VU] = {
		itemName = "Deja Vu",
		description = ""
		.. "#12.5% chance to reroll items into items that Isaac already holds"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.GUPPY .. "",
	},
	[wakaba.Enums.Collectibles.LIL_MAO] = {
		itemName = "Lil Mao",
		description = ""
		.. "#↑ {{Speed}} +0.15 Speed"
		.. "#Familiar that slides around and emits surrounding laser around her"
		.. "#Isaac can pick up and throw by touching her"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		itemName = "Isekai Definition",
		description = ""
		.. "#Spawns a Lil Clot (max 10)"
		.. "#Heals all spawned Lil Clots' health by 2"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.BALANCE] = {
		itemName = "Balance ecnalaB",
		description = ""
		.. "#↑ {{Coin}} +10 Coins"
		.. "#Converts 5 {{Coin}}coins into 1 {{Key}}key and 1 {{Bomb}}bomb."
		.. "#If there are not enough coins: "
		.. "#Converts 1 of Key/Bomb into another one that Isaac less have."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.RICHERS_FLIPPER] = {
		itemName = "Richer's Flipper",
		description = ""
		.. "#Converts {{Bomb}}/{{Key}} and {{Card}}/{{Pill}} each other"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.MOE_MUFFIN] = {
		itemName = "Moe's Muffin",
		description = ""
		.. "↑ {{Heart}} +1 Heart Container"
		.. "#↑ {{Heart}} Heals one Red Heart"
		.. "#↑ {{Damage}} +1.5 Damage Up"
		.. "#↑ {{Range}} +1.5 Range Up"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.MURASAME] = {
		itemName = "Murasame",
		description = ""
		.. "#!!! While held : "
		.. "#{{AngelDevilChance}} Forces a {{DevilRoom}}Devil/{{AngelRoom}}Angel room door to spawn after every boss fight"
		.. "#{{AngelChance}} Allows both Devil and Angel deals to be taken"
		.. "#!!! On use : "
		.. "#Adds +20% {{AngelChance}}Angel room chance for current floor"
		.. "#Revives one of defeated floor boss in current run as friendly and 320 HP"
		.. "#Monstro will be summoned if no floor boss is beaten"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.CLOVER_SHARD] = {
		itemName = "Clover Shard",
		description = ""
		.. "↑ {{Heart}} +1 Heart Container"
		.. "#↑ {{Heart}} Heals one Red Heart"
		.. "#↑ {{Damage}} +11% Damage Multiplier"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.NASA_LOVER] = {
		itemName = "Nasa Lover",
		description = ""
		.. "#{{Collectible494}} Electric tear familiar"
		.. "#{{Collectible494}} Isaac and all of Isaac's familiars also gain electric tears"
		.. "#{{Collectible565}} Makes Blood Puppy friendly"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.ARCANE_CRYSTAL] = {
		itemName = "Arcane Crystal",
		description = ""
		.. "#↑ {{Damage}} +12% Damage Multiplier"
		.. "#Homing tears"
		.. "#70% chance to take extra damage for enemies"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.ADVANCED_CRYSTAL] = {
		itemName = "Advanced Crystal",
		description = ""
		.. "#↑ {{Damage}} +14% Damage Multiplier"
		.. "#Piercing tears"
		.. "#25% chance to take armor-piercing damage for enemies"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.MYSTIC_CRYSTAL] = {
		itemName = "Mystic Crystal",
		description = ""
		.. "#↑ {{Damage}} +16% Damage Multiplier"
		.. "#Glowing tears"
		.. "#{{Card" .. Card.CARD_HOLY .."}}Getting soul hearts beyond limit activatesHoly Card effect (Max 5)"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		itemName = "3d Printer",
		description = ""
		.. "#Duplicates and smelts current held trinket"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.SYRUP] = {
		itemName = "Syrup",
		description = ""
		.. "#!!! While Held:"
		.. "#↓ {{Speed}} -10% Speed"
		.. "#↑ {{Range}} +3 Range"
		.. "#↑ {{Damage}} +1.25 Damage"
		.. "#Flight"
		.. "#!!! Does not have on use effect"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.PLASMA_BEAM] = {
		itemName = "Plasma Beam",
		description = ""
		.. "#↑ {{Range}} +2 Range"
		.. "#↓ {{Damage}} -40% Damage"
		.. "#{{Burning}} Piercing tears that can hit enemies multiple times and light enemies on fire"
	},
	[wakaba.Enums.Collectibles.POWER_BOMB] = {
		itemName = "Power Bomb",
		description = ""
		.. "#{{Bomb}} +10 Bombs"
		.. "#!!! Cannot use normal bombs"
		.. "#!!! Consumes half of current held bombs"
		.. "#Makes giant explosion that destroys all objects, opens all doors, and damages all enemies in the current room"
		.. "#!!! Explosion damage : 0.2 * consumed bombs per tick"
		.. "#{{Bomb}} Killing enemies has chance to drop bombs that despawns after 1.5 seconds"
		.. "#{{LuckSmall}} :8+({{LuckSmall}})%/max10%"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.MAGMA_BLADE] = {
		itemName = "Magma Blade",
		description = ""
		.. "#{{Burning}} Slashes fire blade on tear attack"
		.. "#{{DamageSmall}} +100% Damage multiplier for non-tear attacks"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		itemName = "Phantom Cloak",
		description = ""
		.. "#Makes Isaac invisible for short time"
		.. "#All enemies targeting Isaac will be confused while Isaac is invisible"
		.. "#!!! Still can take damage even while in invisible"
		.. "#Moving or firing tears reduces time faster"
		.. "#Timer only can be recharged by moving or firing. Cannot use until fully charged"
		.. "#Opens challenge room doors while in invisible"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.RED_CORRUPTION] = {
		itemName = "Red Corruption",
		description = "{{Collectible21}} Reveals icons on the map"
		.. "#All special rooms except Boss rooms will be turned into red rooms"
		.. "#Generates new rooms adjacent special rooms if possible"
		.. "#!!! Some doors may lead to {{ErrorRoom}}I AM ERROR rooms!"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		itemName = "Question Block",
		description = ""
		.. "#25% chance to spawn Collectible item"
		.. "#Magic Mushroom is guaranteed to be spawned if Isaac does not have it"
		.. "#!!! Taking any damage while holding this item will lose Magic Mushroom"
		.. "#!!! Taking any damage without Magic Mushroom makes Isaac The Lost state"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.CLENSING_FOAM] = {
		itemName = "Clensing Foam",
		description = ""
		.. "#{{Poison}} Poisons enemies in a small radius around Isaac"
		.. "#Removes champion property in a small radius around Isaac"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOB .. "",
	},
	[wakaba.Enums.Collectibles.BEETLEJUICE] = {
		itemName = "Beetlejuice",
		description = "{{Pill}} Identifies all pills"
		.. "#{{Pill}} When used, Randomizes 6 pill effects for current run and spawns one of changed pills"
		.. "#{{Pill}} Extra pills can be spawned on room clears while held"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2] = {
		itemName = "Curse of The Tower 2",
		description = ""
		.. "#{{GoldenBomb}} Infinite Bombs"
		.. "#Upon taking damage, spawns a golden troll bomb around the room"
		.. "#!!! Beware: All troll bombs are converted into Golden troll bombs if possible!"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.ANTI_BALANCE] = {
		itemName = "Anti Balance",
		description = ""
		.. "#{{Pill}} All pills will be Horse pills"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.VENOM_INCANTATION] = {
		itemName = "Venom Incantation",
		description = ""
		.. "#↑ {{Damage}} +1 Damage"
		.. "#{{Poison}} Poison/Burn damage have 5% chance to instakill normal enemies#{{Blank}} (1.36% on non-major bosses)"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.SPUN .. "",
	},
	[wakaba.Enums.Collectibles.FIREFLY_LIGHTER] = {
		itemName = "Firefly Lighter",
		description = ""
		.. "#↑ {{Range}} +2 Range"
		.. "#↑ {{Luck}} +1 Luck"
		.. "#{{WakabaAntiCurseDarkness}} Curse of Dakrness immunity"
		.. "#Room clear rewards can be spawned for traps through Reward plate"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
	},
	[wakaba.Enums.Collectibles.DOUBLE_INVADER] = {
		itemName = "Double Invader",
		description = ""
		.. "#↓ Devil/Angel rooms no longer appear"
		.. "#↑ {{Damage}} +250% Damage Multiplier#{{Blank}} (+100% per extra stack)"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.SEE_DES_BISCHOFS] = {
		itemName = "See Des Bischofs",
		description = ""
		.. "#{{Collectible584}} Spawns Book of Virtues Wisp per 4 rooms"
		.. "#{{Player"..wakaba.Enums.Players.TSUKASA_B.."}} Respawn as Tainted Tsukasa on death"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.JAR_OF_CLOVER] = {
		itemName = "Jar of Clover",
		description = ""
		.. "#↑ {{Luck}} +0.5 Luck per 1 game minute"
		.. "#{{Player"..wakaba.Enums.Players.WAKABA.."}} Respawn as Wakaba on death"
		.. "#{{Player"..wakaba.Enums.Players.WAKABA_B.."}} Tainted Wakaba simply revives"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.CRISIS_BOOST] = {
		itemName = "Crisis Boost",
		description = ""
		.. "#↑ {{Damage}} Damage multiplier up for low health (max +150%)"
		.. "#↑ {{Tears}} +1 Fire Rate"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.PRESTIGE_PASS] = {
		itemName = "Prestige Pass",
		description = ""
		.. "#{{BossRoom}} Spawns restock machine on boss room clears"
		.. "#Spawns restock machine in {{DevilRoom}}Devil/{{AngelRoom}}Angel room, {{Planetarium}}Planetariums, {{SecretRoom}}Secret/{{UltraSecretRoom}}Ultra Secret room, and Black markets"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		itemName = "Caramella Pancake",
		description = ""
		.. "#{{Player"..wakaba.Enums.Players.RICHER.."}} Respawn as Richer on death"
		.. "#{{Player"..wakaba.Enums.Players.RICHER_B.."}} Tainted Richer simply revives"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.EASTER_EGG] = {
		itemName = "Easter Egg",
		description = ""
		.. "#Orbital that shoots homing tears which deal 1 damage"
		.. "#Picking Easter Coins make damage, fire rate up"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ONSEN_TOWEL] = {
		itemName = "Onsel Towel",
		description = ""
		.. "#↑ {{SoulHeart}} +1 Soul Heart"
		.. "#{{HalfSoulHeart}} 45% Chance to heal half a soul heart every minute"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.SUCCUBUS_BLANKET] = {
		itemName = "Succubus Blanket",
		description = ""
		.. "#↑ {{BlackHeart}} +1 Black Heart"
		.. "#{{HalfBlackHeart}} 45% Chance to heal half a black heart every minute"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.RICHERS_UNIFORM] = {
		itemName = "Richer's Uniform",
		description = ""
		.. "#{{SacrificeRoom}} Sets Sacrifice room spike counter to 6th"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.CUNNING_PAPER] = {
		itemName = "Cunning Paper",
		description = ""
		.. "#{{Card}} Triggers a random card effect each use"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.TRIAL_STEW] = {
		itemName = "Trial Stew",
		description = "!!! While Isaac has only half heart and no shields:#↑ {{Tears}}+8 Fire rate#↑ {{Damage}}+100% Damage Multiplier",
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		itemName = "Wakaba's Double Dreams",
		description = ""
		.. "#↓ Devil/Angel rooms no longer appear"
		.. "#Upon use, Change the form of Wakaba's dreams"
		.. "#If collectibles appear, The pool from Wakaba's dream will be selected instead of default pool"
		.. "#{{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}} 8% chance to spawn Wakaba's Dream Card on room clears"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.LEVIATHAN .. "," .. EID.TRANSFORMATION.BOOKWORM,
	},
	[wakaba.Enums.Collectibles.EDEN_STICKY_NOTE] = {
		itemName = "Eden's Sticky Note",
		description = ""
		.. "#!!! ONE TIME USE"
		.. "#Gives Birthright upon use"
		.. "#Moves current primary active item into pocket slot"
		.. "#Active item in Pocket Slot does not be rerolled on hit"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.LEVIATHAN .. "," .. EID.TRANSFORMATION.BOOKWORM,
	},
}

wakaba.descriptions[desclang].bingeeater = {
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		description = "↑ {{Damage}} +1.0 Damage#↓ {{Speed}} -0.04 Speed",
	},
	--[[ [wakaba.Enums.Collectibles.MOE_MUFFIN] = {
		description = "+1.0 {{Damage}}Damage Up",
	}, ]]
	--[[ [wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		description = "+1.0 {{Damage}}Damage Up",
	}, ]]
}
wakaba.descriptions[desclang].belial = {
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description = "{{BlackHeart}}Gives 1 Black Heart instead of Bone Heart. Full Health effect is still intact",
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		description = "Invokes XV - The Devil card effect per card/pill/rune used inside Uniform", 
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		description = "50% chance to get Black rune instead of random one#{{ColorWakabaNemesis}}Invokes Black Rune effect for 10% chance", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		description = "Invokes {{Collectible" .. CollectibleType.COLLECTIBLE_DARK_ARTS .. "}}Dark Arts effect and damages all enemies per erased projectiles", 
	},
	--[[ [wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		description = "Summons Black Heart type Lil Clot instead of Soul Heart type", 
	}, ]]
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		description = "↑ +4% chance to drop {{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}}Wakaba's Dream Card while held. No additional effect when item is used", 
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		description = "↑ {{Damage}} +25% Damage multiplier while in cloaked state", 
	},
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		description = "Spawns {{DevilRoom}}Devil room items instead of current pool", 
	},
}
wakaba.descriptions[desclang].bookofvirtues = {

	--[[ Book of Virtues
		Ring position > count
		tearvariants
		effects
		when destroyed
	 ]]

	[wakaba.Enums.Collectibles.EATHEART] = {
		description = "{{ColorLime}}Inner ring x1: {{CR}}#Invincible Wisp#Cannot shoot tears"
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description = "{{ColorYellow}}Center Ring x1: {{CR}}#{{BoneHeart}}Spawns a Bone Heart when destroyed"
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		description = "{{ColorRed}}!!!No Wisp {{CR}}#All wisps become invincible while held"
	},
	[wakaba.Enums.Collectibles.COUNTER] = {
		description = "{{ColorOrange}}Outer Ring x1: {{CR}}Only for current room#All wisps become invincible while counter shield is active"
	},
	[wakaba.Enums.Collectibles.D6_PLUS] = {
		description = "{{ColorLime}}Inner Ring x1: {{CR}}No special effect"
	},
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		description = "{{ColorLime}}Inner Ring x1: {{CR}}No special effect"
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		description = "{{ColorYellow}}Center Ring x1: {{CR}}#Homing tears"
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		description = "{{ColorYellow}}Center Ring x1: {{CR}}#{{Rune}}15% chance for enemy to drop rune on kill#{{Rune}}Spawns a rune when destroyed"
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "{{ColorOrange}}Outer Ring x1: {{CR}}#Spawns MinIsaacs when destroyed"
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		description = "{{ColorOrange}}Outer Ring x1: {{CR}}#Immune to projectiles#Erases nearby projectiles"
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		description = "{{ColorOrange}}Outer Ring x1: {{CR}}#Makes a non-boss enemy friendly on contact"
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		description = "{{ColorLime}}Inner Ring x1: {{CR}}High durability#Revives Isaac on death and the wisp is consumed"
	},
	--[[ [wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		description = "{{ColorRed}}!!!링에 귀속되지 않는 불꽃 6: {{CR}}#이 아이템으로 부활한 이후 불꽃이 소환되며 불꽃이 적을 따라다니면서 피해를 줍니다.#불꽃이 어떠한 피해도 입지 않습니다."
	}, ]]
	[wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY] = {
		description = "{{ColorOrange}}Outer Ring x1: {{CR}}#Spawns Unknown Bookmark when destroyed"
	},
	--[[ [wakaba.Enums.Collectibles.APOLLYON_CRISIS] = {
		description = "{{ColorRed}}!!!No Wisp {{CR}}#현재 켜져 있는 모든 불꽃을 흡수하며 능력치로 환산합니다."
	}, ]]
	--[[ [wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		description = "{{ColorLime}}Inner Ring x1: {{CR}}#캐릭터와 같은 공격력의 눈물을 발사합니다."
	}, ]]
	[wakaba.Enums.Collectibles.BALANCE] = {
		description = "{{ColorRed}}!!!No Wisp {{CR}}#All wisps become invincible while Isaac has same Keys and Bombs"
	},
	--[[ [wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		description = "{{ColorRed}}!!!No Wisp {{CR}}#시프트 시 일정 시간동안 현재 켜져 있는 모든 불꽃이 어떠한 피해도 입지 않습니다."
	}, ]]
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		description = "{{ColorLime}}Inner Ring x1: {{CR}}(Max 1)#Invincible Wisp#Revives Isaac on death and the wisp is consumed"
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		description = "{{ColorYellow}}Center Ring x1: {{CR}}#Spawns a trinket when destroyed"
	},

	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		description = "{{ColorRed}}!!!No effect{{CR}}"
	},

}
wakaba.descriptions[desclang].abyss = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		description = "deals 7x faster than normal locust, double of Isaac's Damage, chases through enemies, and freezes on death"
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		description = "deals 5X of Isaac's Damage"
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		description = "deals 3.5x faster than normal locust, triple of Isaac's Damage, travels at double speed"
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description = "deals 3.5x faster than normal locust, double of Isaac's Damage, travels at double speed"
	},
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		description = "deals 1.2x faster than normal locust, double of Isaac's Damage"
	},
	[wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD] = {
		description = "deals 1.7x faster than normal locust, double of Isaac's Damage"
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		description = "3 Locusts that deal 1.7x faster than normal locust"
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		description = "2 yellow locust that deal 7x faster than normal locust, 0.8x Isaac's Damage, drops coins when dealing damage"
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		description = "Plumy Locust deals 2.3x faster than normal locust, 4x Isaac's Damage"
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		description = "4.2x 'slower' than normal locust, 16x Isaac's Damage, travels at 0.1x speed"
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		description = "5 Locusts that deal 2.3x faster than normal locust, drops card when killed by the locust"
	},
	[wakaba.Enums.Collectibles.LIL_WAKABA] = {
		description = "deals 1.3x faster than normal locust, travels 3x speed"
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "3 Locusts that deals 7x faster than normal locust, 0.9x Isaac's Damage, travels 3x speed"
	},
}
wakaba.descriptions[desclang].wakaba = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		description = "↑ {{Tears}} -25% Tear Delay",
	},
	[CollectibleType.COLLECTIBLE_URANUS] = {
		description = "↑ {{Damage}} +50% Damage Multiplier#{{ColorWakabaBless}}Armor-Piercing Tears",
	},
	
}
wakaba.descriptions[desclang].wakaba_b = {
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		description = "↑ {{Damage}} +4 Damage Up#↓ {{ColorWakabaNemesis}}Luck Bonuses are not applied",
	},
	[wakaba.Enums.Collectibles.WAKABAS_HAIRPIN] = {
		description = "↑ {{Damage}} +0.35 Damage per pill consumed#↓ {{ColorWakabaNemesis}}Luck Bonuses are not applied",
	},
}
wakaba.descriptions[desclang].shiori = {
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "Spawns 3 tiny Isaac familiars.",
	},
}
wakaba.descriptions[desclang].shiori_b = {
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "Spawns 3 tiny Isaac familiars.",
	},
}
wakaba.descriptions[desclang].tsukasa = {
	
}
wakaba.descriptions[desclang].tsukasa_b = {
	
}
wakaba.descriptions[desclang].richer = {
	
}
wakaba.descriptions[desclang].richer_b = {
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#On use, absorb selected Wisp"
		.. "#Can be change selection by {{ButtonRT}}"
		.. "{{CR}}",
	},
}
wakaba.descriptions[desclang].bless = {
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		description = "{{AngelDevilChance}}100% chance to find an Devil/Angel Room in all floors except Blue Womb#↑ {{ColorWakabaBless}}Can get all items with selection",
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		description = "Spawns two collectible items instead of one", 
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		description = "↑ {{Luck}} Additional +0.15 Luck up per Luck affect items#{{Luck}} {{ColorWakabaBless}}Sets to 10 Luck if Luck is lower than 10", 
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		description = "Plumy can replicate Isaac's tears", 
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		description = "↑ 1.2x chance for Eraser tears", 
	},
}
wakaba.descriptions[desclang].nemesis = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		description = "#{{AngelDevilChance}} 100% chance to find an Devil/Angel Room in all floors except Blue Womb#↑ {{ColorWakabaNemesis}}Can get all items with selection",
	},
	[wakaba.Enums.Collectibles.REVENGE_FRUIT] = {
		description = "↑ 2x chance for Lasers, Grants Homing Lasers", 
	},
}
wakaba.descriptions[desclang].bookofshiori = {
	[CollectibleType.COLLECTIBLE_BIBLE] = {
		description = "Grants Shiori {{Damage}} 1.2x Damage multiplier and gives Holy Mantle({{Collectible313}}) shield for current room#{{ColorBookofShiori}}Gives Godhead Tears({{Collectible331}}) until next book use", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] = {
		description = "Adds additional {{Damage}} +1.5 Damage up for current room#{{ColorBookofShiori}}Gives Eye of Belial Tears({{Collectible462}}) until next book use", 
	},
	[CollectibleType.COLLECTIBLE_NECRONOMICON] = {
		description = "Spawns 5 Maw of Void lasers dealing 64% of Shiori's Damage per tick#{{ColorBookofShiori}}Gives Rock Tears({{Collectible592}}) until next book use", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS] = {
		description = "No Extra temporary effect#{{ColorBookofShiori}}Gives Shielded Tears({{Collectible213}}) until next book use", 
	},
	[CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK] = {
		description = "Troll bombs and explosions deal double damage to enemies for current room#{{ColorBookofShiori}}Gives Explosive Tears and Shiori is immune to explosions until next book use", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS] = {
		description = "Spawns 2 Lil Harbringers for current floor#{{ColorBookofShiori}}Gives chance to fire Holy Light Tears({{Collectible374}}) until next book use", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SIN] = {
		description = "No Extra temporary effect#{{ColorBookofShiori}}Adds chance to drop a random pickup when enemies are killed until next book use", 
	},
	[CollectibleType.COLLECTIBLE_MONSTER_MANUAL] = {
		description = "No Extra temporary effect#↑ {{ColorBookofShiori}}Familiars deal 3x Damage until next book use", 
	},
	[CollectibleType.COLLECTIBLE_TELEPATHY_BOOK] = {
		description = "Gives Spectral and Continnum Tears({{Collectible369}}) for current room#{{ColorBookofShiori}}Gives Homing and Electric Tears({{Collectible494}}) until next book use", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS] = {
		description = "Fully reveals the map and removes {{WakabaAntiCurseDarkness}}Curse of Darkness and {{WakabaAntiCurseLost}}Curse of the Lost#{{ColorBookofShiori}}Gives Mark({{Collectible618}}) tears until next book use", 
	},
	[CollectibleType.COLLECTIBLE_SATANIC_BIBLE] = {
		description = "Adds additional {{Damage}} +1.0 Damage up for current floor#{{ColorBookofShiori}}Gives Dark matter tears({{Collectible259}}) until next book use", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD] = {
		description = "Spawns additional friendly Bonies#{{ColorBookofShiori}}Gives Death's Touch Tears({{Collectible237}}) until next book use", 
	},
	[CollectibleType.COLLECTIBLE_LEMEGETON] = {
		description = "Chance to absorb random Lemegeton wisp into item#{{ColorBookofShiori}}Gives Chance to drop batteries when enemies are killed until next book use", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		description = "Select Enemy to charm permanently#{{ColorBookofShiori}}Requires Keys{{Key}} (+ Bombs{{Bomb}} for bosses) to charm", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description = "No Extra temporary effect#{{ColorBookofShiori}}Gives Bone Tears({{Collectible453}}) until next book use", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		description = "Ignores Enemy's armor when not moving#{{ColorBookofShiori}}Resets current Book of Shiori Tear bonuses",
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		description = "No Extra temporary effect#{{Rune}} {{ColorBookofShiori}}Adds chance to drop a rune when enemies are killed until next book use", 
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "Damage taken for Minissac is greatly reduced#{{ColorBookofShiori}}Minissac Copies Most of Isaac's tear effects until next book use", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		description = "Prevents all enemy projectiles for extra 2 seconds#{{ColorBookofShiori}}Resets current Book of Shiori Tear bonuses", 
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		description = "No extra Temporary effect #{{Collectible579}} {{ColorBookofShiori}}Gives Temporary Black Spirit Sword. The Scythe tears will be fired instead of sword projectile", 
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		description = "All enemies targeting Isaac will also be slowed while Isaac is invisible.#{{ColorBookofShiori}}(No changes for current Book of Shiori Tear bonuses)", 
	},
}
wakaba.descriptions[desclang].murasame = {
	
}
wakaba.descriptions[desclang].flashshift = {
	
}
wakaba.descriptions[desclang].flashmurasame = {
	
}


wakaba.descriptions[desclang].trinkets = {
	[wakaba.Enums.Trinkets.BRING_ME_THERE] = {
		itemName = "Bring me there",
		description = ""
		.. "#↑ {{Tears}} +1.5 Fire Rate"
		.. "#Entering Mausoleum/Gehenna II while holding this trinket makes Dad's Note being appear instead of Mom"
		.. "#Also spawns in Mines/Ashpit II and Mausoleum/Gehenna I"
		.. "#!!! {{ColorRed}}CANNOT ENTER WOMB/CORPSE WHEN BEING REPLACED{{ColorReset}}"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.BITCOIN] = {
		itemName = "Bitcoin II",
		description = ""
		.. "#Randomize consumable counters."
		.. "#When entering the room, Randomize stats"
		.. "#The range for consumables can be all back to 0 to full of 999"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.CLOVER] = {
		itemName = "Clover",
		description = ""
		.. "#↑ {{Tears}} +0.3 Fire Rate"
		.. "#↑ {{Luck}} +2 Luck"
		.. "#↑ {{Luck}} +100% Luck Multiplier"
		.. "#↑ Luct stat will be always positive"
		.. "#↑ Increased chance for Lucky Pennies"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.MAGNET_HEAVEN] = {
		itemName = "Magnet Heaven",
		description = ""
		.. "#Instantly teleports Bombs, Keys, and Coins to Isaac"
		.. "#Converts Sticky Nickel into normal Nickel"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.HARD_BOOK] = {
		itemName = "Hard Book",
		description = ""
		.. "#Chance to drop random book collectible upon getting hit"
		.. "#{{SacrificeRoom}} 100% chance to drop a book in sacrifice rooms"
		.. "#!!! The trinket gets disappeared when book drop"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.DETERMINATION_RIBBON] = {
		itemName = "Determination Ribbon",
		description = ""
		.. "#All damage taken will be reduced to half heart"
		.. "#Doesn't kill isaac as long as the trinket is held."
		.. "#!!! {{ColorYellow}}The effect of the trinket will not work on Sacrifice rooms Spikes!{{ColorReset}}"
		.. "#!!! The trinket gets dropped for 2% chance on taking Damage"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.BOOKMARK_BAG] = {
		itemName = "Bookmark Bag",
		description = ""
		.. "#Gives random one-time-use book item when Isaac enters new room"
		.. "#The included books are same as Shiori's starting books for 'All Books' mode"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.RING_OF_JUPITER] = {
		itemName = "Ring of Jupiter",
		description = ""
		.. "#Applies to all players:"
		.. "#↑ {{Tears}} -20% Tear Delay"
		.. "#↑ {{Speed}} +10% Speed"
		.. "#↑ {{Damage}} +16% Damage"
		.. "#↑ {{Shotspeed}} +5% Shot Speed"
		.. "#↑ {{Luck}} +1 Luck"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.DIMENSION_CUTTER] = {
		itemName = "Dimension Cutter",
		description = ""
		.. "#{{Collectible510}} 15% chance to spawn random delirious boss when entering an uncleared room"
		.. "#{{GreedMode}} 5% chance for Greed mode, {{Luck}}max 25% for 10+ Luck"
		.. "#↑ {{Card"..Card.CARD_CHAOS.."}}Chaos card can damage Delirium, and The Beast (339 damage per tick)"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.DELIMITER] = {
		itemName = "Delimiter",
		description = ""
		.. "#!!! When entering new room :"
		.. "#Destroys Tinted, Super-Secret, and Fools Gold rocks"
		.. "#Turns Pillars, Metal blocks, Spiked rocks into normal rocks"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.RANGE_OS] = {
		itemName = "Range OS",
		description = ""
		.. "#↓ {{Range}} -45% Range Multiplier"
		.. "#↑ {{Damage}} +125% Damage Multiplier"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.SIREN_BADGE] = {
		itemName = "Siren's Badge",
		description = ""
		.. "#Prevents contact damage"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.ISAAC_CARTRIDGE] = {
		itemName = "Isaac Cartridge",
		description = ""
		.. "#Only TBoI ~ Rebirth items will appear"
		.. "#{{Collectible619}}Birthright, Modded items also appear"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE] = {
		itemName = "Afterbirth Cartridge",
		description = ""
		.. "#Only TBoI ~ Afterbirth+ items will appear"
		.. "#{{Collectible619}}Birthright also appears"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE] = {
		itemName = "Repentance Cartridge",
		description = ""
		.. "#Only TBoI ~ Repentance items will appear"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.STAR_REVERSAL] = {
		itemName = "Star Reversal",
		description = ""
		.. "#Dropping the trinket in a {{TreasureRoom}}Treasure room exchanges it for {{Planetarium}}Planetarium item"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.AURORA_GEM] = {
		itemName = "Aurora Gem",
		description = ""
		.. "#Increased chance for Easter Coins"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.MISTAKE] = {
		itemName = "Mistake",
		description = ""
		.. "#Taking damage makes explosion on random enemy."
		.. "{{CR}}",
	},
	
}
wakaba.descriptions[desclang].goldtrinkets = {
	
}
wakaba.descriptions[desclang].cards = {
	[wakaba.Enums.Cards.CARD_CRANE_CARD] = {
		itemName = "Crane Card",
		description = "{{CraneGame}} Spawns a Crane Game machine",
		mimiccharge = 6,
	},
	[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = {
		itemName = "Confessional Card",
		description = "{{Confessional}} Spawns a Confessional Booth",
		mimiccharge = 4,
	},
	[wakaba.Enums.Cards.CARD_BLACK_JOKER] = {
		itemName = "Black Joker",
		description = "{{DevilChance}} While held, prevents Angel room to be spawned. #{{DevilRoom}} Upon use, Teleports the player to the Devil room",
		mimiccharge = 2,
	},
	[wakaba.Enums.Cards.CARD_WHITE_JOKER] = {
		itemName = "White Joker",
		description = "{{AngelChance}} While held, prevents Devil room to be spawned. #{{AngelRoom}} Upon use, Teleports the player to the Angel room",
		mimiccharge = 2,
	},
	[wakaba.Enums.Cards.CARD_COLOR_JOKER] = {
		itemName = "Color Joker",
		description = "{{BrokenHeart}} Sets Broken Heart counts to 6 #Spawns 3 Collectible items and 8 Card/Rune/Soul Stones",
		mimiccharge = 6,
	},
	[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = {
		itemName = "Queen of Spades",
		description = "{{Key}} Spawns 3~26 keys",
		mimiccharge = 10,
	},
	[wakaba.Enums.Cards.CARD_DREAM_CARD] = {
		itemName = "Wakaba's Dream Card",
		description = "Spawns a random collectible item",
		mimiccharge = 10,
	},
	[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = {
		itemName = "Unknown Bookmark",
		description = "Activates a random book effect#!!! Following books can be activated:",
		mimiccharge = 1,
	},
	[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = {
		itemName = "Return Token",
		description = "{{Collectible636}} Invokes R Key effect#Brings you back to the first floor of a new run#Items, stat boosts and pickups stay intact#{{Timer}} Resets game timer#Removes all of Isaac's consumables {{ColorRed}}including health{{CR}}",
	},
	[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = {
		itemName = "Return Token",
		description = "{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} Activates Minerva's Aura for current room",
		mimiccharge = 3,
	},
	[wakaba.Enums.Cards.SOUL_WAKABA] = {
		itemName = "Soul of Wakaba",
		description = "{{SoulHeart}} +1 Soul Heart#{{AngelRoom}} Creates new Angel shop on current floor#{{AngelRoom}} Spawns an Angel room item for sale if no rooms are available",
		mimiccharge = 8,
		isrune = true,
	},
	[wakaba.Enums.Cards.SOUL_WAKABA2] = {
		itemName = "Soul of Wakaba?",
		description = "{{SoulHeart}} +1 Soul Heart#{{DevilRoom}} Creates new Devil room on current floor#{{AngelRoom}} Spawns a Devil room item for sale if no rooms are available",
		mimiccharge = 8,
		isrune = true,
	},
	[wakaba.Enums.Cards.SOUL_SHIORI] = {
		itemName = "Soul of Shiori",
		description = "{{Heart}} Heals 2 Red Hearts#Activates Random Book of Shiori tear effect",
		mimiccharge = 8,
		isrune = true,
	},
	[wakaba.Enums.Cards.SOUL_TSUKASA] = {
		itemName = "Soul of Tsukasa",
		description = "Hangs a sword above Isaac's head, which doubles all pedestal items#Does not double Shop, Chest, or Devil deal items#{{Warning}} After taking any damage, the sword has a chance to remove half of Isaac's items and turns into random character every frame",
		mimiccharge = 12,
		isrune = true,
	},
	[wakaba.Enums.Cards.CARD_VALUT_RIFT] = {
		itemName = "Valut Rift",
		description = "Spawns a Shiori's Valut# The valut contains a collectible that requires 12 keys.",
		mimiccharge = 6,
	},
	[wakaba.Enums.Cards.CARD_TRIAL_STEW] = {
		itemName = "Trial Stew",
		description = "Removes all health and Holy Mantle shields and fully charges active items.#+8 Fire rate, +100% Damage as long as Isaac has only half heart and no shields.",
		mimiccharge = 8,
	},
}
wakaba.descriptions[desclang].tarotcloth = {
	[wakaba.Enums.Cards.CARD_CRANE_CARD] = {
		description = "Spawns 2 Crane Game machines",
	},
	[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = {
		description = "Spawns 2 Confessional Booths",
	},
	[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = {
		description = "Activates 2 random book effects",
	},
	[wakaba.Enums.Cards.CARD_VALUT_RIFT] = {
		description = "Spawns 2 valuts",
	},
	[wakaba.Enums.Cards.CARD_TRIAL_STEW] = {
		description = "Additional +1 Fire rate, +25% Damage",
	},
}
wakaba.descriptions[desclang].runechalk = {
	
}
wakaba.descriptions[desclang].pills = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP] = {
		itemName = "Damage Multiplier Up",
		description = "↑ {{Damage}} +8% Damage Multiplier",
		mimiccharge = 12,
		class = "3+",
	},
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = {
		itemName = "Damage Multiplier Down",
		description = "↓ {{Damage}} -2% Damage Multiplier",
		mimiccharge = 4,
		class = "3-",
	},
	[wakaba.Enums.Pills.ALL_STATS_UP] = {
		itemName = "All Stats Up",
		description = "↑ {{Damage}} +0.25 Damage#↑ {{Tears}} +0.2 Tears#↑ {{Speed}} +0.12 Speed#↑ {{Range}} +0.4 Range#↑ {{Shotspeed}} +0.04 Shot Speed#↑ {{Luck}} +1 Luck#",
		mimiccharge = 8,
		class = "3+",
	},
	[wakaba.Enums.Pills.ALL_STATS_DOWN] = {
		itemName = "All Stats Down",
		description = "↓ {{Damage}} -0.1 Damage#↓ {{Tears}} -0.08 Tears#↓ {{Speed}} -0.09 Speed#↓ {{Range}} -0.25 Range#↓ {{Shotspeed}} -0.03 Shot Speed#↓ {{Luck}} -1 Luck#",
		mimiccharge = 4,
		class = "3-",
	},
	[wakaba.Enums.Pills.TROLLED] = {
		itemName = "Trolled!",
		description = "{{ErrorRoom}} Teleports to I AM ERROR room#{{Collectible721}} Spawns Glitched items on ???/Home",
		mimiccharge = 4,
		class = "3-",
	},
	[wakaba.Enums.Pills.TO_THE_START] = {
		itemName = "To the Start!",
		description = "Teleports to Starting room on the floor",
		mimiccharge = 2,
		class = "0+",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = {
		itemName = "Explosive Diarrehea 2!",
		description = "Spawns 2 troll Brimstone swirls at Isaac's position",
		mimiccharge = 3,
		class = "2-",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT] = {
		itemName = "Explosive Diarrehea 2?",
		description = "{{Card88}} Invokes Soul of Azazel effect:#{{Collectible441}} Activates Mega Blast for 7.5 seconds",
		mimiccharge = 6,
		class = "2+",
	},
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = {
		itemName = "Social Distance",
		description = "Closes Devil/Angel room for current floor",
		mimiccharge = 4,
		class = "2-",
	},
	[wakaba.Enums.Pills.DUALITY_ORDERS] = {
		itemName = "Duality Orders",
		description = "Spawns an each of {{DevilRoom}}Devil/{{AngelRoom}}Angel room items#Only one can be taken",
		mimiccharge = 6,
		class = "3+",
	},
	[wakaba.Enums.Pills.FLAME_PRINCESS] = {
		itemName = "Flame Princess",
		description = "Absorbs all Lemegeton Wisps into items#Heals all remaining Wisps' health to max#{{Collectible584}} Spawns a Book of Virtues Wisp if there are no wisps",
		mimiccharge = 8,
		class = "1+",
	},
	[wakaba.Enums.Pills.FIREY_TOUCH] = {
		itemName = "Firey Touch",
		description = "{{WakabaCurseFlames}} Curse of Flames effect for current floor#Heals all Wisps' health to max",
		mimiccharge = 4,
		class = "2-",
	},
	[wakaba.Enums.Pills.PRIEST_BLESSING] = {
		itemName = "Priest's Blessing",
		description = "Grants the Holy Mantle effect#(Prevents damage once)#Effect lasts until damage is taken#{{Card51}} Same Effect as Holy Card",
		mimiccharge = 4,
		class = "3+",
	},
	[wakaba.Enums.Pills.UNHOLY_CURSE] = {
		itemName = "Unholy Curse",
		description = "Breaks a stack from Holy Mantle shield#Does nothing if Isaac don't have Holy Mantle shields",
		mimiccharge = 4,
		class = "3-",
	},
}
wakaba.descriptions[desclang].horsepills = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP +1] = {
		tostring(wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP),
		"Damage Multiplier Up",
		"↑ {{Damage}} +16% Damage Multiplier",
	},
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN +1] = {
		tostring(wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN),
		"Damage Multiplier Down",
		"↓ {{Damage}} -4% Damage Multiplier",
	},
	[wakaba.Enums.Pills.ALL_STATS_UP +1] = {
		tostring(wakaba.Enums.Pills.ALL_STATS_UP),
		"All Stats Up",
		"↑ {{Damage}} +0.5 Damage#↑ {{Tears}} +0.4 Tears#↑ {{Speed}} +0.24 Speed#↑ {{Range}} +0.8 Range#↑ {{Shotspeed}} +0.08 Shot Speed#↑ {{Luck}} +2 Luck#",
	},
	[wakaba.Enums.Pills.ALL_STATS_DOWN +1] = {
		tostring(wakaba.Enums.Pills.ALL_STATS_DOWN),
		"All Stats Down",
		"↓ {{Damage}} -0.2 Damage#↓ {{Tears}} -0.16 Tears#↓ {{Speed}} -0.18 Speed#↑ {{Range}} -0.5 Range#↓ {{Shotspeed}} -0.06 Shot Speed#↓ {{Luck}} -2 Luck#",
	},
	[wakaba.Enums.Pills.TROLLED +1] = {
		tostring(wakaba.Enums.Pills.TROLLED),
		"Trolled!",
		"{{ErrorRoom}} Teleports to I AM ERROR room#{{Collectible721}} Spawns Glitched items on ???/Home#Removes a Broken Heart",
	},
	[wakaba.Enums.Pills.TO_THE_START +1] = {
		tostring(wakaba.Enums.Pills.TO_THE_START),
		"To the Start!",
		"Teleports to Starting room on the floor#Heals 1 Heart#Removes a Broken Heart",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2 +1] = {
		tostring(wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2),
		"Explosive Diarrehea 2!",
		"Spawns 2 troll Brimstone swirls at Isaac's position",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT +1] = {
		tostring(wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT),
		"Explosive Diarrehea 2?",
		"{{Card88}} Invokes Soul of Azazel effect:#{{Collectible441}} Activates Mega Blast for 7.5 seconds",
	},
	[wakaba.Enums.Pills.SOCIAL_DISTANCE +1] = {
		tostring(wakaba.Enums.Pills.SOCIAL_DISTANCE),
		"Social Distance",
		"Closes Devil/Angel room for current floor#↓ {{AngelDevilChance}} Decreases Devil/Angel room chance for later floors",
	},
	[wakaba.Enums.Pills.DUALITY_ORDERS +1] = {
		tostring(wakaba.Enums.Pills.DUALITY_ORDERS),
		"Duality Orders",
		"Spawns an each of {{DevilRoom}}Devil/{{AngelRoom}}Angel room items#Both items can be taken",
	},
	[wakaba.Enums.Pills.FLAME_PRINCESS +1] = {
		tostring(wakaba.Enums.Pills.FLAME_PRINCESS),
		"Flame Princess",
		"Absorbs all Lemegeton Wisps into two duplicated items#Heals all remaining Wisps' health to 3x of their max healt#{{Collectible584}} Spawns a Book of Virtues Wisp if there are no wisps",
	},
	[wakaba.Enums.Pills.FIREY_TOUCH +1] = {
		tostring(wakaba.Enums.Pills.FIREY_TOUCH),
		"Firey Touch",
		"{{WakabaCurseFlames}} Curse of Flames effect for current floor#Heals all Wisps' health to max",
	},
	[wakaba.Enums.Pills.PRIEST_BLESSING +1] = {
		tostring(wakaba.Enums.Pills.PRIEST_BLESSING),
		"Priest's Blessing",
		"Grants the Holy Mantle effect#(Prevents damage once)#Effect lasts until damage is taken#{{Card51}} Same Effect as Holy Card",
	},
	[wakaba.Enums.Pills.UNHOLY_CURSE +1] = {
		tostring(wakaba.Enums.Pills.UNHOLY_CURSE),
		"Unholy Curse",
		"Breaks a stack from Holy Mantle shield#Does nothing if Isaac does not have Holy Mantle shields",
	},
}

wakaba.descriptions[desclang].sewnupgrade = {
	[wakaba.Enums.Familiars.LIL_WAKABA] = {
		super = ""
		.. "#Gives Homing property for lasers"
		.. "#Deals 70% of Isaac's damage"
		.. "{{CR}}",
		ultra = ""
		.. "#Automatically aims at the enemy even without King Baby"
		.. "#Deals 100% of Isaac's damage"
		.. "{{CR}}",
		name = "Lil Wakaba",
	},
	[wakaba.Enums.Familiars.LIL_MOE] = {
		super = ""
		.. "#Two effects can be combined"
		.. "#Deals 150% of Isaac's damage"
		.. "{{CR}}",
		ultra = ""
		.. "#Three effects can be combined"
		.. "#Deals 200% of Isaac's damage"
		.. "{{CR}}",
		name = "Lil Wakaba",
	},
	[wakaba.Enums.Familiars.LIL_SHIVA] = {
		super = ""
		.. "#Fires 7 charged wave of tears"
		.. "#Deals 150% of your damage"
		.. "{{CR}}",
		ultra = ""
		.. "#Damage x2"
		.. "#Fires 8 charged wave of tears"
		.. "#After hitting the first enemy, the tear deals double damage and gains a homing effect"
		.. "{{CR}}",
		name = "Lil Shiva",
	},
	[wakaba.Enums.Familiars.PLUMY] = {
		super = ""
		.. "#Allows to shoot Isaac's tears"
		.. "#↑ Damage Up"
		.. "#↑ Reduced recovery time"
		.. "{{CR}}",
		ultra = ""
		.. "#↑ Tears and accuracy Up"
		.. "#Bouncing tears"
		.. "#↑ Reduced recovery time"
		.. "{{CR}}",
		name = "Plumy",
	},
}
wakaba.descriptions[desclang].uniform = {
	changeslot = "Change slot",
	empty = "Empty",
	unknownpill = "Unknown Pill",
	use = "Using current held {{Pill}}/{{Card}}/{{Rune}} will activate all above",
	pushprefix = "Using this item will push the held {{Pill}}/{{Card}}/{{Rune}} to {{ColorGold}}slot ",
	pushsubfix = "{{CR}}",
	pullprefix = "Using this item will pull the {{Pill}}/{{Card}}/{{Rune}} from {{ColorGold}}slot ",
	pullsubfix = "{{CR}}",
	useprefix = "Using this item will swap {{ColorGold}}slot ",
	usesubfix = "{{CR}} and current held {{Pill}}/{{Card}}/{{Rune}}",
	pickupprefix = "Using Uniform will store/swap this into {{ColorGold}}",
	pickupmidfix = "'s uniform slot ",
	pickupsubfix = ".{{CR}}",
}
wakaba.descriptions[desclang].bookofconquest = {
	selectstr = "Select",
	selectenemy = "Selected Enemy",
	selectreq = "Requires",
	selectboss = "Boss entity :#{{Blank}} {{ColorCyan}} Will disappear on continue",
	selectconq = "Use the item again to conquer",
	selecterr = "{{ColorError}}Cannot conquer :#{{Blank}} {{ColorError}}Not enough {{Key}} or {{Bomb}}",
	selectexit = "Press attack button to exit selection",
}
wakaba.descriptions[desclang].waterflame = {
	taintedricher = "Absorbs selected Item Wisp and grant as passive collectible item#Can be selected with {{ButtonRT}}",
	titleprefix = "Selection",
	supersensitiveprefix = "Remaning count : ",
	supersensitivesubfix = "",
	supersensitivefinal = "Can no longer be used",
}
wakaba.descriptions[desclang].doubledreams = {
	lastpool = "Pool for item",
	currenttitle = "Wakaba's Current Dream pool",
	Default = "Default",
	Treasure = "Treasure",
	Shop = "Shop",
	Boss = "Boss",
	Devil = "Devil",
	Angel = "Angel",
	Secret = "Secret",
	Library = "Library",
	ShellGame = "Shell Game",
	GoldenChest = "Golden Chest",
	RedChest = "Red Chest",
	Beggar = "Beggar",
	DemonBeggar = "Demon Beggar",
	Curse = "Curse",
	KeyMaster = "Key Master",
	BatteryBum = "Battery Bum",
	MomChest = "Mom's Chest",
	GreedTreasure = "Greed Treasure",
	GreedBoss = "Greed Boss",
	GreedShop = "Greed Shop",
	GreedDevil = "Greed Devil",
	GreedAngel = "Greed Angel",
	GreedCurse = "Greed Curse",
	GreedSecret = "Greed Secret",
	CraneGame = "Crane Game",
	UltraSecret = "Ultra Secret",
	BombBum = "Bomb Bum",
	Planetarium = "Planetarium",
	OldChest = "Old Chest",
	BabyShop = "Baby Shop",
	WoodenChest = "Wooden Chest",
	RottenBeggar = "Rotten Beggar",
}

wakaba.descriptions[desclang].entities = {
	{
		type = EntityType.ENTITY_SLOT,
		variant = wakaba.Enums.Slots.SHIORI_VALUT,
		subtype = 0,
		name = "Shiori's Another Fortune Machine",
		description = ""
		.. "{{Key}} Requires 5 Keys to activate"
		.. "#{{Warning}} Bumping into the Machine spawns one of followings :"
		.. "#{{BlendedHeart}} {{ColorSilver}}Blended Heart"
		.. "#{{Card}} {{ColorSilver}}Random Card"
		.. "#{{Card49}} {{ColorSilver}}Dice Shard"
		.. "#{{Card31}} {{ColorSilver}}Joker"
		.. "#{{Rune}} {{ColorSilver}}Random Rune"
		.. "#{{Trinket}} {{ColorSilver}}Golden Trinket"
		.. "#{{PlanetariumChance}} {{ColorSilver}}Star-related collectible"
		.. "#{{Warning}} Spawning 5 (3 in Hard Mode) or more times has high chance to explode"
	},
	{
		type = EntityType.ENTITY_PICKUP,
		variant = wakaba.Enums.Pickups.CLOVER_CHEST,
		subtype = wakaba.ChestSubType.CLOSED,
		name = "Wakaba's Clover Chest",
		description = ""
		.. "{{Key}} Requires a key to open"
		.. "#{{Warning}} Opening the chest may contain one of followings :"
		.. "#{{Coin}} {{ColorSilver}}Golden Coin"
		.. "#{{Coin}} {{ColorSilver}}2 Lucky Coins"
		.. "#{{Luck}} {{ColorSilver}}Luck-related collectible"
	},
}



wakaba.descriptions[desclang].curses = {
	[-1] = {
		icon = "Blank",
		name = "<Curse not found(or modded curse)>",
	},
	[LevelCurse.CURSE_OF_DARKNESS] = {
		icon = "CurseDarkness",
		name = "Curse of Darkenss",
		description = "The floor is much darker, and is only barely lit by the Isaac's natural aura"
		.. "#Occasionally rooms will be filled with swirling clouds of what could be fireflies or glowing motes of dust"
		.. "#Fire, explosions, and lasers will all cast light as normal, as will red creep"
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_DARKNESS,
	},
	[LevelCurse.CURSE_OF_LABYRINTH] = {
		icon = "CurseLabyrinth",
		name = "Curse of the Labyrinth",
		description = "Appears only on the first floor of a chapter"
		.. "#Makes the floor an XL floor, which contains two Boss Rooms, two items and counts as two floors"
		.. "#!!! Only Boss/Treasure rooms are doubled. Other special rooms still contains as in single floor"
		.. "#Both Treasure Room doors will be unlocked on first floor"
		.. "#This curse cannot be removed by {{Collectible260}}Black Candle"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} If playing as Richer, or Rabbit Ribbon is held, Creates extra special rooms if possible"
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_LABYRINTH,
	},
	[LevelCurse.CURSE_OF_THE_LOST] = {
		icon = "CurseLost",
		name = "Curse of the Lost",
		description = "Removes the map from the HUD"
		.. "#Same effect as the Amnesia pill"
		.. "#Also increases the possible total room count of the current floor to the size of the next floor"
		.. "#Can be removed by {{Collectible260}}Black Candle, but increased rooms do not disappear"
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_LOST,
	},
	[LevelCurse.CURSE_OF_THE_UNKNOWN] = {
		icon = "CurseUnknown",
		name = "Curse of the Unknown",
		description = ""
		.. "#Removes Isaac's health from the HUD, leaving the player unable to see how many hearts remain of any kind"
		.. "#Health will still be tracked as normal, including Soul/Black/Eternal Hearts, Holy Mantle Shield, and Extra Lives"
		.. "#When Isaac is down to half a heart, it is still marked by urine when entering a room"
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_UNKNOWN,
	},
	[LevelCurse.CURSE_OF_THE_CURSED] = {
		icon = "CurseCursed",
		name = "Curse of the Cursed",
		description = "Changes normal doors into cursed doors"
		.. "#Due to mechanism of Cursed doors, Isaac takes damage regardless of flight"
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_CURSED,
	},
	[LevelCurse.CURSE_OF_MAZE] = {
		icon = "CurseMaze",
		name = "Curse of the Maze",
		description = "Entering a new room (including teleporting) will occasionally take Isaac to the wrong room"
		.. ", with a screen-shake and sound effect to indicate the jump"
		.. "#Occasionally, discovered rooms can swap contents, without a screen-shake or sound effect"
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_MAZE,
	},
	[LevelCurse.CURSE_OF_BLIND] = {
		icon = "CurseBlind",
		name = "Curse of the Blind",
		description = "All items are replaced with a question mark and are not revealed until they are picked up"
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_BLIND,
	},
	[LevelCurse.CURSE_OF_GIANT] = {
		icon = "CurseGiant",
		name = "Curse of the Giant",
		description = "Combines normal sized room into 2x2, 1x2, 2x1 or L-shaped rooms"
		.. "#Narrow rooms are not affected"
		.. "#This curse cannot be removed by {{Collectible260}}Black Candle"
		.. "",
	},
	[wakaba.curses.CURSE_OF_FLAMES] = {
		icon = "WakabaCurseFlames",
		name = "Curse of Flames",
		description = "Isaac cannot obtain any items when the curse is active"
		.. "#Attempting to take an item from a pedestal will turn it into Wisps, with massive health"
		.. "#Passive: Turns into Lemegeton Wisp. Book of Virtues Wisp if not possible"
		.. "#Active: Turns into Book of Virtues Wisp. Normal wisp if not the item does not have corresponding wisp"
		.. "#Plot-Critical items and Death Certifiate rooms are the exception for this curse"
		.. "",
	},
	[wakaba.curses.CURSE_OF_SATYR] = {
		icon = "WakabaCurseSatyr",
		name = "Curse of Satyr",
		description = "!!! Only appears for Shiori with 'Curse of Satyr' mode"
		.. "#Shiori cannot switch books"
		.. "#Using the book in pocket slot makes the book change into another"
		.. "#Unlike Unknown Bookmark or Maijima Mythology, Using the book this way will change Shiori's tear bonus"
		.. "#This curse cannot be removed by {{Collectible260}}Black Candle"
		.. "",
	},
	[wakaba.curses.CURSE_OF_SNIPER] = {
		icon = "WakabaCurseSniper",
		name = "Curse of Sniper",
		description = "!!! Only appears for {{Player"..wakaba.Enums.Players.RICHER.."}}Richer, or {{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}}Rabbit Ribbon is held"
		.. "#{{CurseDarkness}} Replaces Curse of Darkness"
		.. "#Tears cannot damage enemies for a short time"
		.. "#Deals 3x damage to enemies after 0.5 seconds"
		.. "",
	},
	[wakaba.curses.CURSE_OF_FAIRY] = {
		icon = "WakabaCurseFairy",
		name = "Curse of Fairy",
		description = "!!! Only appears for {{Player"..wakaba.Enums.Players.RICHER.."}}Richer, or {{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}}Rabbit Ribbon is held"
		.. "#{{CurseLost}} Replaces Curse of the Lost"
		.. "#Isaac cannot see the map far away"
		.. "#{{SecretRoom}} Can reveal Secret and Super Secret Rooms"
		.. "",
	},
	[wakaba.curses.CURSE_OF_AMNESIA] = {
		icon = "WakabaCurseAmnesia",
		name = "Curse of Amnesia",
		description = "!!! Only appears for {{Player"..wakaba.Enums.Players.RICHER.."}}Richer, or {{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}}Rabbit Ribbon is held"
		.. "#{{CurseMaze}} Replaces Curse of the Maze"
		.. "#Sometimes cleared rooms are randomly be uncleared"
		.. "#Special rooms are not included"
		.. "",
	},
	[wakaba.curses.CURSE_OF_MAGICAL_GIRL] = {
		icon = "WakabaCurseMagicalGirl",
		name = "Curse of Magical Girl",
		description = "!!! Only appears for {{Player"..wakaba.Enums.Players.RICHER.."}}Richer, or {{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}}Rabbit Ribbon is held"
		.. "#{{CurseUnknown}} Replaces Curse of the Unknown"
		.. "#{{Card91}} Permanent Lost Curse state for current floor"
		.. "#{{Collectible285}} All enemies are devolved if possible"
		.. "",
	},
}
wakaba.descriptions[desclang].cursesappend = {}
wakaba.descriptions[desclang].cursesappend.CURCOL = {
	[1 << (Isaac.GetCurseIdByName("Curse of Decay") - 1)] = {
		icon = "Blank",
		name = "Curse of Decay",
		description = "Pickups have a chance to spawn with a timeout"
		.. "#Decaying pickups disappear after a few seconds"
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Famine") - 1)] = {
		icon = "Blank",
		name = "Curse of Famine",
		description = "All pickups will be downgraded"
		.. "#Heart will be spawned as their half ones"
		.. "#1+1 pickups will be spawned as single ones"
		.. "#Lil batteries will be spawned as half ones"
		.. "#!!! Only works for randomly selected pickups. Does not affect fixed pickups"
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Blight") - 1)] = {
		icon = "CURCOL_blight",
		name = "Curse of Blight",
		description = "All items will be hidden behind a veil of darkness and are not revealed until they are picked up"
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Conquest") - 1)] = {
		icon = "Blank",
		name = "Curse of Conquest",
		description = "More enemies will be turned into champions"
		.. "#This includes enemies spawned by other enemies"
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Rebirth") - 1)] = {
		icon = "Blank",
		name = "Curse of Rebirth",
		description = "Enemies have a chance of being reborn after dying"
		.. "#Champions will remain a champion even after being reborn"
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Creation") - 1)] = {
		icon = "CURCOL_crea",
		name = "Curse of Creation",
		description = "Obstacles have a chance to be re-created as a rock after being broken"
		.. "#Isaac will be teleported to previous room if stuck by this curse"
		.. "",
	},
}

wakaba.descriptions[desclang].playernotes = {
	-- copy-paste this snippet
	[-50000] = {
		-- icon = "",
		name = "Isaac",
		description = ""
		.. "#"
		.. "",
	},
	-- copy-paste this snippet end
	[-666] = {
		icon = "Blank",
		name = "<Player not found(or modded player)>",
	},
	[PlayerType.PLAYER_ISAAC] = {
		-- icon = "",
		name = "Isaac",
		description = "Isaac Moriah is the main character of the series, returning from the original {{ColorLime}}The Binding of Isaac{{CR}} From 2011."
		.. "#Abraham is commanded by God to sacrifice his only son, Isaac, to prove his loyalty and love."
		.. "#Isaac has average stats, no upsides and downsides"
		.. "#{{Collectible105}} {{GoldenKey}}Starts With : The D6({{Player4}}-> Defeat Isaac)"
		.. "",
	},
	[PlayerType.PLAYER_MAGDALENE] = {
		-- icon = "",
		name = "Magdalene",
		description = "Magdalene is the name of Isaac’s mother Magdalene O. Moriah, or MOM"
		.. "#The last name Moriah is a reference to the biblical story of Isaac where the name Moriah is the name of the mountain Isaac was to be sacrificed on in the Book of Genesis."
		.. "#{{Heart}} More Health, but low Speed"
		.. "#{{Collectible45}} Starts With : Yum Heart"
		.. "#{{Pill}} {{GoldenKey}}Starts With : Full Health pill(32: Complete Aprils Fool)"
		.. "",
	},
	[PlayerType.PLAYER_CAIN] = {
		-- icon = "",
		name = "Cain",
		description = "Cain commits the first murder by killing Abel."
		.. "#!!! Cain can only shoot tears from his right eye. This affects certain items."
		.. "#{{Damage}} High damage, but low health"
		.. "#{{Collectible46}} Starts with : Lucky Foot"
		.. "#{{Trinket19}} {{GoldenKey}}Starts with : Paper Clip({{GreedMode}}: 68{{Coin}})"
		.. "",
	},
	[PlayerType.PLAYER_JUDAS] = {
		-- icon = "",
		name = "Judas",
		description = "Judas betrayed Jesus to the Romans in exchange for 3{{Coin}}"
		.. "#{{Damage}} Super High damage, but super low health"
		.. "#{{Collectible34}} Starts with : The Book of Belial"
		.. "",
	},
	[PlayerType.PLAYER_BLUEBABY] = {
		-- icon = "",
		name = "???",
		description = "??? is ??? of ???"
		.. "#???'s look originally came from Dead Baby Dressup, one of Edmund McMillen's first Flash games"
		.. "#{{SoulHeart}} ???'s health meter is unique in that he cannot gain red heart containers. Any item that grant him a red heart container (including an empty one), adds a Soul Heart instead"
		.. "#Bone Hearts grant an empty Bone Heart upon pickup, but they cannot be refilled using Red Hearts"
		.. "#Sleeping on a bed will give ??? three Soul Hearts"
		.. "#Destroying a poop spawns a blue fly"
		.. "#{{Collectible36}} Starts with : The Poop"
		.. "",
	},
	[PlayerType.PLAYER_EVE] = {
		-- icon = "",
		name = "Eve",
		description = "Eve was the first woman on earth, born of Adam's rib in the book of Genesis, and was banned from the Garden of Eden"
		.. "#Eve has a higher chance of finding Soul Hearts than other characters"
		.. "#Super low damage"
		.. "#{{Collectible117}} Starts with : Dead Bird"
		.. "#{{Collectible122}} Starts with : Whore of Babylon"
		.. "#{{Blank}} Eve's Whore of Babylon Whore of Babylon's effect activates with one remaining Red Heart, instead of half a heart, and it will set her damage multiplier to 1.00"
		.. "#{{Collectible126}} {{GoldenKey}}Starts with : Razor Blade({{GreedMode}}: 439{{Coin}})"
		.. "",
	},
	[PlayerType.PLAYER_SAMSON] = {
		-- icon = "",
		name = "Samson",
		description = "Samson was a supernaturally strong warrior who derived his power from his Nazarite vow, entitling immense strength to Samson if he did not cut his hair."
		.. "#{{Collectible157}} Starts with : Bloody Lust"
		.. "#{{Trinket34}} {{GoldenKey}}Starts with : Child's Heart(34: Complete Ultra Hard)"
		.. "",
	},
	[PlayerType.PLAYER_AZAZEL] = {
		-- icon = "",
		name = "Azazel",
		description = "Azazel is the name given to the goat that was cast into the wild as part of Jewish atonement rituals"
		.. "#Azazel also was fallen angel who taught people to make weapons and jewelry and taught women the 'sinful art' of painting their faces"
		.. "#{{Damage}} High damage, but super low range"
		.. "#{{Collectible118}} Azazel starts with a short-ranged version of Brimstone Brimstone which deals damage 8 times in one second"
		.. "#Azazel has the ability to fly"
		.. "",
	},
	[PlayerType.PLAYER_LAZARUS] = {
		-- icon = "",
		name = "Lazarus",
		description = "Lazarus of Bethany was resurrected by Jesus 4 days after his death"
		.. "#{{Collectible332}} Unique ability : Lazarus' Rags"
		.. "#!!! Resurrection items activate in a set order. Lazarus' inherent extra life is after Soul of Lazarus and 1up!"
		.. "#{{Damage}} Permanent +0.5 Damage per revival through {{Collectible332}}Lazarus' Rags"
		.. "#{{Collectible214}} {{GoldenKey}}Starts with : Anemic(31: Complete Backasswards)"
		.. "#{{Pill}} Starts with : a Random pill"
		.. "",
	},
	[PlayerType.PLAYER_EDEN] = {
		-- icon = "",
		name = "Eden",
		description = "Eden is the fabled 'mystery man'"
		.. "#In the book of Genesis, the Garden of Eden was the place where Adam and Eve lived before consuming the fruit of the tree of the knowledge of good and evil, and thus being cast out by God"
		.. "#Each time a game is started as Eden, one token is consumed and a new Eden is randomly generated based on the seed, with one of the multiple hairstyles, random base stats, and two randomly chosen starting items"
		.. "#{{CurseBlind}} Starts with : ???"
		.. "#{{CurseBlind}} Starts with : ???"
		.. "",
	},
	[PlayerType.PLAYER_THELOST] = {
		-- icon = "",
		name = "The Lost",
		description = "The Lost is ??? of ???, maybe related with {{Trinket23}}Missing Poster?"
		.. "#The Lost starts with flight, spectral tears"
		.. "#The Lost starts with no health and cannot gain health by any means. Therefore, {{ColorRed}}it will die from any damage taken.{{CR}} Beware of Demon beggars and Blood Donation Machines"
		.. "#{{GreedMode}} The Lost can activate the button in Greed mode without taking damage, at the price of one less coin spawning in the next wave's reward"
		.. "#The Lost can take devil deals and Black Market items for free, but taking one will despawn all other deals in the room"
		.. "#{{Collectible609}} Starts with : Eternal D6"
		.. "#{{Collectible313}} {{GoldenKey}}Unique ability : Holy Mantle({{GreedMode}}: 879{{Coin}})"
		.. "",
	},
	[PlayerType.PLAYER_LAZARUS2] = {
		-- icon = "",
		name = "Isaac",
		description = "Lazarus of Bethany was resurrected by Jesus 4 days after his death"
		.. "#Has been revived, but is bleeding because Lazarus is already dead once"
		.. "#Will be reverted into normal Lazarus when new floor starts"
		.. "#{{Collectible214}} Starts with : Anemic"
		.. "#{{Collectible214}} {{GoldenKey}}Unique ability : Anemic(Permanent/31: Complete Backasswards)"
		.. "#!!! Anemic effect is permanent and no longer requires him to take damage"
		.. "",
	},
	[PlayerType.PLAYER_BLACKJUDAS] = {
		-- icon = "",
		name = "Black Judas",
		description = "Judas betrayed Jesus to the Romans in exchange for 3{{Coin}}"
		.. "#{{Damage}} Super High damage"
		.. "#{{BlackHeart}} Black Judas's health meter is unique in that he cannot gain red heart containers. Any item that grant him a red heart container (including an empty one), adds a Black Heart instead"
		.. "#Bone Hearts grant an empty Bone Heart upon pickup, but they cannot be refilled using Red Hearts"
		.. "#Sleeping on a bed will give Black Judas three Soul Hearts"
		.. "#!!! Completion marks share with {{Player3}}Judas"
		.. "",
	},
	[PlayerType.PLAYER_LILITH] = {
		-- icon = "",
		name = "Lilith",
		description = "Lilith is the original woman God created before Eve. She refused to become subservient to Adam and left Eden"
		.. "#Lilith is permanently blindfolded, meaning she has no ability to fire tears; she instead deals damage with the Incubus Incubus familiar that follows her"
		.. "#Lilith strongly benefits from other familiars and familiar enhancers"
		.. "#{{Collectible360}} Unique ability : Incubus"
		.. "#{{Collectible367}} Starts with : Box of Friends"
		.. "#{{Collectible412}} Starts with : Cambion Conception"
		.. "#"
		.. "",
	},
	[PlayerType.PLAYER_KEEPER] = {
		-- icon = "",
		name = "Keeper",
		description = "Keeper is ???'s ??? from greed"
		.. "#{{CoinHeart}} Keeper uses coins as health. He starts with two Coin Hearts, loses one every time he is damaged, and heals for one coin every time he obtains a coin"
		.. "#!!! Keeper cannot have more than 3 Coin Hearts"
		.. "#Keeper has a triple shot, but low tears"
		.. "#Instead of using coin heart containers to trade for Devil Deal items, they must be bought using coins. One-heart and two-heart deals cost 15 and 30 cents, respectively"
		.. "#{{Collectible349}} {{GoldenKey}}Starts with : Wooden Nickel({{Player14}}-> Defeat Isaac)"
		.. "#{{Trinket83}} {{GoldenKey}}Starts with : Store Key({{Player14}}-> Defeat Satan)"
		.. "",
	},
	[PlayerType.PLAYER_APOLLYON] = {
		-- icon = "",
		name = "Apollyon",
		description = "Apollyon is the Greek name for the angel Abaddon, and is also known as 'The Destroyer'"
		.. "#Apollyon is a living statue, and has flesh but it appears like stone"
		.. "#{{Collectible477}} Starts with : Void"
		.. "",
	},
	[PlayerType.PLAYER_THEFORGOTTEN] = {
		-- icon = "",
		name = "The Forgotten",
		description = "The Forgotten is ???'s ??? from ???"
		.. "#{{Chargeable}} He cannot fire regular tears, and instead has a bone club that can be swung as a melee weapon or charged to be thrown"
		.. "#{{BoneHeart}} The Forgotten cannot acquire regular heart containers. Any regular heart containers acquired will be turned into bone hearts"
		.. "#{{ColorRed}}Breaking Bone hearts LOSES Devil deal chance, regardless of damage source{{CR}}"
		.. "#Any soul or black hearts will be given to The Soul"
		.. "#Pressing the swap key will switch control to The Soul"
		.. "",
	},
	[PlayerType.PLAYER_THESOUL] = {
		-- icon = "",
		name = "The Soul",
		description = "The Soul is a blue ghost chained to The Forgotten"
		.. "#Unlike The Forgotten, The Soul shoots spectral tears, and has ability to fly"
		.. "#While controlling The Soul, The Forgotten cannot take damage, blocks all normal shots that touch it, and attracts shots in a small radius"
		.. "#{{SoulHeart}} The Soul cannot gain red heart containers. Any item that grant him a red heart container (including an empty one), adds a Soul Heart instead"
		.. "#Any Bone Hearts will be given to The Forgotten"
		.. "#Sleeping on a bed will give ??? three Soul Hearts"
		.. "#Pressing the swap key will switch control to The Forgotten"
		.. "",
	},
	[PlayerType.PLAYER_BETHANY] = {
		-- icon = "",
		name = "Bethany",
		description = "Bethany was the sister of Lazarus"
		.. "#Bethany is unable to utilize Soul Hearts and Black Hearts as health"
		.. "#Soul Hearts are converted to a resource unique to Bethany called 'Soul Charges' at the rate of one charge per half heart"
		.. "#Soul charges can be consumed to use Bethany's activated item when the item isn't fully charged, at the rate of one soul charge per empty bar of charge"
		.. "#{{Collectible584}} Starts with : Book of Virtues"
		.. "",
	},
	[PlayerType.PLAYER_JACOB] = {
		-- icon = "",
		name = "Jacob",
		description = "Jacob & Esau are the twin sons of Isaac and Rebekah"
		.. "#Jacob & Esau are controlled as one, move at the same speed, and use the same coins, bombs, and keys. Otherwise, they are completely independent in terms of stats, items, and health"
		.. "#Both characters have collision and can be separated,"
		.. "#Holding drop key can be held to keep Esau in place while Jacob is free to move around the room"
		.. "#Actives for Jacob can be used by pressing the normal active item button"
		.. "#To use cards and pills, the player holds the drop button and then presses the corresponding character's active item buttons"
		.. "#If either Jacob or Esau die, they both die regardless of the other character's remaining health"
		.. "",
	},
	[PlayerType.PLAYER_ESAU] = {
		-- icon = "",
		name = "Esau",
		description = "Jacob & Esau are the twin sons of Isaac and Rebekah"
		.. "#Jacob & Esau are controlled as one, move at the same speed, and use the same coins, bombs, and keys. Otherwise, they are completely independent in terms of stats, items, and health"
		.. "#Both characters have collision and can be separated,"
		.. "#Holding drop key can be held to keep Esau in place while Jacob is free to move around the room"
		.. "#Actives for Esau can be used by pressing the card/pill button"
		.. "#To use cards and pills, the player holds the drop button and then presses the corresponding character's active item buttons"
		.. "#If either Jacob or Esau die, they both die regardless of the other character's remaining health"
		.. "",
	},

	-- Tainted
	[PlayerType.PLAYER_ISAAC_B] = {
		-- icon = "",
		name = "Isaac(Tainted)",
		description = "The Broken: Isaac got hit too many times from Mom"
		.. "#Tainted Isaac can only hold 8 passive items at a time. Tainted Isaac's current 8 passive items are visible in the top-left corner of the screen, with one highlighted by a white square"
		.. "#Upon picking up a 9th passive item, the item currently selected, or rather the item currently in the white square, will be dropped on a pedestal in front of Tainted Isaac"
		.. "#The swap key can be pressed to cycle which item is selected"
		.. "",
	},
	[PlayerType.PLAYER_MAGDALENE_B] = {
		-- icon = "",
		name = "Magdalene(Tainted)",
		description = "The Dauntless: Magdalene must keep going even when she loses her beauty"
		.. "#When Tainted Magdalene's health is above 2 Red Hearts, she will leave red creep on the floor and will lose health at the rate of half a heart per 10 seconds"
		.. "#This health loss affects all types of hearts, but prioritizes red heart health. Affected hearts on the health bar are faded and slowly pulsating"
		.. "#Only non-leaky red heart damage will impose Devil/Angel chance penalty"
		.. "#{{Collectible724}} all enemies have a chance of dropping a Half Red Heart upon death which will flicker and disappear in 2 seconds"
		.. "#On contact, Tainted Magdalene activate Melee attak, which hits deal 6x damage and all enemies killed by the melee attack have a 100% chance of dropping a half red heart"
		.. "#She also receives double healing from all sources except heart pickups"
		.. "#{{Collectible45}} Unique ability : Yum Heart"
		.. "",
	},
	[PlayerType.PLAYER_CAIN_B] = {
		-- icon = "",
		name = "Cain(Tainted)",
		description = "The Hoarder: The sin is too high for killing his brother"
		.. "#Tainted Cain can't obtain items through any means other than the {{Collectible710}}Bag of Crafting, and attempting to take an item from a pedestal will reduce it into an assortment of pickups"
		.. "#The pickups dropped are dependent on what type of room the item was touched in"
		.. "#{{Collectible710}} Unique ability : Bag of Crafting"
		.. "#{{Blank}} Once 8 pickups are held in the bag, the bag will show a preview what would be crafted. Holding down the Use Pill/Card button will craft the item and place it directly in Tainted Cain's inventory"
		.. "#{{Blank}} If pickups are collected after the max of 8 is reached, the contents shift left and up, deleting the top left slot and adding at the bottom right. Tapping the switch key cycles the bag's contents left and up in a loop, making it possible to choose which pickup to overwrite"
		.. "#{{CurseBlind}} Curse of the Blind hides the crafting preview"
		.. "",
	},
	[PlayerType.PLAYER_JUDAS_B] = {
		-- icon = "",
		name = "Judas(Tainted)",
		description = "The Deceiver: The betrayal is forever"
		.. "#{{BlackHeart}} Tainted Judas's health meter is unique in that he cannot gain red heart containers. Any item that grant him a red heart container (including an empty one), adds a Black Heart instead"
		.. "#Bone Hearts grant an empty Bone Heart upon pickup, but they cannot be refilled using Red Hearts"
		.. "#Sleeping on a bed will give Tainted Judas three Soul Hearts"
		.. "#{{Collectible705}} Unique ability : Dark Arts"
		.. "#{{Blank}} For every enemy/bullet he walked through, he will gain a temporary +1 damage bonus, which wears off at a rate of -0.25 damage every half second"
		.. "",
	},
	[PlayerType.PLAYER_BLUEBABY_B] = {
		-- icon = "",
		name = "???(Tainted)",
		description = "The Soiled: Time to return into soil"
		.. "#{{PoopPickup}} Tainted ??? cannot use bombs. Bomb pickups are replaced by poop pickups"
		.. "#Poop pickups also have a chance to drop from fallen enemies and by Tainted ??? by dealing damage"
		.. "#{{Collectible725}} The order in which different types of poop are obtained is predetermined based on the seed"
		.. "#{{SoulHeart}} ???'s health meter is unique in that he cannot gain red heart containers. Any item that grant him a red heart container (including an empty one), adds a Soul Heart instead"
		.. "#{{Collectible715}} Unique ability : Hold"
		.. "",
	},
	[PlayerType.PLAYER_EVE_B] = {
		-- icon = "",
		name = "Eve(Tainted)",
		description = "The Curdled: The pain is not over"
		.. "#{{Collectible713}} Unique ability : Sumptorium(Passive)"
		.. "#{{Blank}} Holding attack button for 2 seconds automatically actives Sumptorium"
		.. "#{{Blank}} Using Sumptorium from pocket slot destroy all blood clots, returning the health used to create them"
		.. "#If every remaining clot is killed and Tainted Eve only has half a red heart left, she begins to use Sumptorium as a weapon that functions similarly to Mom's Knife"
		.. "",
	},
	[PlayerType.PLAYER_SAMSON_B] = {
		-- icon = "",
		name = "Samson(Tainted)",
		description = "The Savage: Samson killed an army of 1,000 Philistines using a donkey's jawbone"
		.. "#{{Collectible704}} Unique ability : Berserk!(Passive)"
		.. "#{{Blank}} Cannot see charges, Berserk! will be automatically activated after fully charged"
		.. "#{{Blank}} Berserk! will be also charged when Tainted Samson takes damage"
		.. "",
	},
	[PlayerType.PLAYER_AZAZEL_B] = {
		-- icon = "",
		name = "Azazel(Tainted)",
		description = "The Benighted: The fallen angel tried to beat the god, but failed, and his wings and horns are ripped off"
		.. "#{{Collectible118}} His brimstone laser no longer has short range, but now is very thin, and deals half of his damage"
		.. "#CANNOT fly"
		.. "#{{Collectible704}} Unique ability : Hemoptysis"
		.. "#{{Blank}} Hemoptysis activates at the start of charging, instead of double tap"
		.. "#{{Blank}} Hitting enemies with the Hemoptysis sneeze halves Brimstone's remaining charge time"
		.. "",
	},
	[PlayerType.PLAYER_LAZARUS_B] = {
		-- icon = "",
		name = "Lazarus(Tainted)",
		description = "The Enigma: The miracle is always the mystery"
		.. "#{{Collectible711}} Unique ability : Flip"
		.. "#Whenever a room is cleared, including each wave of multi-wave rooms, Tainted Lazarus swaps between the two forms"
		.. "#Each character has separate items, attributes, trinkets, and consumables"
		.. "#Some items(such as Plot-critical items) are counted as both characters having them"
		.. "#!!! ghostly form of an item only flips when Flip is used manually"
		.. "",
	},
	[PlayerType.PLAYER_EDEN_B] = {
		-- icon = "",
		name = "Eden(Tainted)",
		description = "The Capricious: Now the garden is 'deleted'"
		.. "#Each time a game is started as Tainted Eden, one token is consumed and a new Eden is randomly generated based on the seed, with one of the multiple hairstyles, random base stats, and two randomly chosen starting items"
		.. "#{{Collectible721}} {{ColorRed}}Every time they take damage, all of their stats, items (passive and active), their trinket and their currently-held card or pill get re-rolled{{CR}}"
		.. "#{{CurseBlind}} Starts with : ???"
		.. "#{{CurseBlind}} Starts with : ???"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.EDEN_STICKY_NOTE.."}} {{GoldenKey}}Unique ability : Eden's Sticky Note(w98: Complete Hyper Random)"
		.. "",
	},
	[PlayerType.PLAYER_THELOST_B] = {
		-- icon = "",
		name = "The Lost(Tainted)",
		description = "The Baleful: The mercy is no longer, The ghost is now miserable"
		.. "#{{Collectible691}} {{Quality0}}~{{Quality2}} items has 20% chance to be rerolled and only items with 'offensive' tag will appear"
		.. "#{{Blank}} Useless items no longer appear, but defensive items also no longer appear"
		.. "#{{Blank}} Blacklisted items only appear with set drops"
		.. "#{{Card51}} Starts with : Holy Card"
		.. "#{{Card51}} All cards that spawn have roughly a 10% chance of being turned into a Holy Card"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.UNIFORM.."}} {{GoldenKey}}Starts with : Wakaba's Uniform(w09: Complete Draw Five)"
		.. "",
	},
	[PlayerType.PLAYER_LAZARUS2_B] = {
		-- icon = "",
		name = "Lazarus(Tainted-Dead)",
		description = "The Enigma: The miracle is always the mystery"
		.. "#{{Collectible711}} Unique ability : Flip"
		.. "#Whenever a room is cleared, including each wave of multi-wave rooms, Tainted Lazarus swaps between the two forms"
		.. "#Each character has separate items, attributes, trinkets, and consumables"
		.. "#Some items(such as Plot-critical items) are counted as both characters having them"
		.. "#!!! ghostly form of an item only flips when Flip is used manually"
		.. "",
	},
	[PlayerType.PLAYER_LILITH_B] = {
		-- icon = "",
		name = "Lilith(Tainted)",
		description = "The Harlot: The baby of the woman, who had intercourse with demons in the underworld, was born"
		.. "#{{Collectible728}} Unique ability : Gello(Passive)"
		.. "#Holding attack button launches Gello, It returns to Tainted Lilith once the fire button is released"
		.. "",
	},
	[PlayerType.PLAYER_KEEPER_B] = {
		-- icon = "",
		name = "Keeper(Tainted)",
		description = "The Miser: The greed brings more greedy"
		.. "#{{CoinHeart}} Tainted Keeper uses coins as health. He starts with two Coin Hearts, loses one every time he is damaged, and heals for one coin every time he obtains a coin"
		.. "#!!! Tainted Keeper cannot have more than 2 Coin Hearts"
		.. "#Tainted Keeper has a quad shot, but low tears"
		.. "#Instead of using coin heart containers to trade for Devil Deal items, they must be bought using coins. One-heart and two-heart deals cost 15 and 30 cents, respectively"
		.. "#Whenever an enemy is defeated, a random coin is dropped that will vanish quickly"
		.. "#Most items encountered when playing as Tainted Keeper must first be paid for with coins"
		.. "#In the standard game mode, Shops are different and much better for Tainted Keeper. They do not require a key, and extra {{TreasureRoom}}/{{BossRoom}}/{{Shop}} items are in sale"
		.. "",
	},
	[PlayerType.PLAYER_APOLLYON_B] = {
		-- icon = "",
		name = "Apollyon(Tainted)",
		description = "The Empty: The abyss is bottomless"
		.. "#{{Collectible706}} Unique ability : Abyss"
		.. "",
	},
	[PlayerType.PLAYER_THEFORGOTTEN_B] = {
		-- icon = "",
		name = "The Forgotten(Tainted)",
		description = "The Fettered: Cannot move himself"
		.. "#{{SoulHeart}} Tainted Forgotten's health meter is unique in that he cannot gain red heart containers. Any item that grant him a red heart container (including an empty one), adds a Soul Heart instead"
		.. "#Tainted Forgotten invincible, but cannot move without soul"
		.. "#Any items picked up will normally behave as if Tainted Forgotten picked them up and don't directly affect Tainted Soul"
		.. "",
	},
	[PlayerType.PLAYER_THESOUL_B] = {
		-- icon = "",
		name = "The Soul(Tainted)",
		description = "Tainted Soul cannot shoot tears, but is able to pick up and move around with, or throw, Tainted Forgotten"
		.. "#Tainted Soul Does NOT have any health, but unlike The Lost, Tainted Forgotten's health will be reduced when Tainted Soul gets hit, instead of death"
		.. "#Tainted Soul can enter the mirror world for free, because of lack of health"
		.. "#Enemies almost always target Tainted Soul and ignore Tainted Forgotten"
		.. "#Tainted Soul has ability to fly"
		.. "",
	},
	[PlayerType.PLAYER_BETHANY_B] = {
		-- icon = "",
		name = "Bethany(Tainted)",
		description = "The Zealot: The revival of her brother made the faith stronger"
		.. "#{{SoulHeart}} Tainted Bethany's health meter is unique in that he cannot gain red heart containers. Any item that grant him a red heart container (including an empty one), adds a Soul Heart instead"
		.. "#Red Hearts are converted to a resource unique to Tainted Bethany called 'Blood Charges' at the rate of one charge per half heart"
		.. "#Blood charges can be consumed to use Tainted Bethany's activated item when the item isn't fully charged, at the rate of one soul charge per empty bar of charge"
		.. "#Any items held by Tainted Bethany that give positive modifiers and multipliers have only 75% of their effect. Familiars and Orbitals also deal only 75% of their usual damage"
		.. "#{{Collectible712}} Unique ability : Lemegeton"
		.. "#"
		.. "",
	},
	[PlayerType.PLAYER_JACOB_B] = {
		-- icon = "",
		name = "Jacob(Tainted)",
		description = "The Deserter: Jacob needs to flee from Esau's Wrath"
		.. "#If Dark Esau damages Tainted Jacob, Tainted Jacob 'dies' and becomes ghostly state with no health"
		.. "#Dark Esau is able to damage enemies as well as Tainted Jacob"
		.. "#While charging at Tainted Jacob, Dark Esau damage enemies which ignores Armor, and inflicts Burning"
		.. "#{{Collectible722}} Unique ability : Anima Sola"
		.. "#{{Blank}} Using Anima Sola when used in a room with no enemies will immediately spawn Dark Esau without exhausting the item's charge"
		.. "#{{Blank}} Anima Sola always affects Dark Esau if he is on screen"
		.. "",
	},
	[PlayerType.PLAYER_JACOB2_B] = {
		-- icon = "",
		name = "Jacob(Tainted)",
		description = "The Deserter: Jacob needs to flee from Esau's Wrath"
		.. "#!!! Currently ghostly state: {{ColorRed}}Tainted Jacob will die from any damage taken{{CR}}"
		.. "#Upon reaching a new floor, Tainted Jacob will return to his living state"
		.. "#If Dark Esau damages Tainted Jacob, Tainted Jacob 'dies' and becomes ghostly state with no health"
		.. "#Dark Esau is able to damage enemies as well as Tainted Jacob"
		.. "#While charging at Tainted Jacob, Dark Esau damage enemies which ignores Armor, and inflicts Burning"
		.. "#{{Collectible722}} Unique ability : Anima Sola"
		.. "#{{Blank}} Using Anima Sola when used in a room with no enemies will immediately spawn Dark Esau without exhausting the item's charge"
		.. "#{{Blank}} Anima Sola always affects Dark Esau if he is on screen"
	
	
	},


	
	-- wakaba
	[wakaba.Enums.Players.WAKABA] = {
		-- icon = "",
		name = "Wakaba",
		description = "Wakaba is a kawaii, and lucky girl from anime {{ColorLime}}Wakaba Girl{{CR}} from Hara Yui"
		.. "#She can get good items, and shoots homing and ice tears"
		.. "#{{AngelChance}} She only can see Angel rooms"
		.. "#{{BrokenHeart}} Due to her lonely past, her heart is mostly filled with Broken Hearts"
		.. "#{{Pill}} Wakaba is unable to see Speed up, Luck Down pills"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WAKABAS_BLESSING.."}} Wakaba starts with Wakaba's Blessing"
		--.. "#"
		.. "",
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		-- icon = "",
		name = "Tainted Wakaba",
		description = "Tainted Wakaba is the lonely, and unlucky past version"
		.. "#She {{ColorRed}}CANNOT{{CR}} get good items, and shoots spectral and piercing tears"
		.. "#{{DevilChance}} She only can see Devil rooms. All devil deals' price are 6 coins"
		.. "#{{Damage}} Due to her lack of affection, she gets temporary +3.6 Damage up for getting a collectible item, but other stats are reduced permanently"
		.. "#{{Pill}} Tainted Wakaba is unable to see Speed down, Luck up pills"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WAKABAS_BLESSING.."}} Tainted Wakaba starts with Wakaba's Nemesis"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.EATHEART.."}} Tainted Wakaba starts with Eat Heart"
		--.. "#"
		.. "",
	},
	-- shiori
	[wakaba.Enums.Players.SHIORI] = {
		-- icon = "",
		name = "Shiori",
		description = "Shiori is a librarian from {{ColorBookofConquest}}The World God only Knows{{CR}} from Wakagi Tamaki"
		.. "#Low damage but shoots directional tears"
		.. "#{{Key}} Shiori requires keys to use active items. Lil' Batteries recover Shiori's Keys"
		.. "#{{GoldenKey}} Batteries in Shops are automatically converted into Golden Keys. Obtaining Golden Key automatically converts into 6 keys"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}} Shiori starts with Book of Shiori"
		--.. "#"
		.. "",
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		-- icon = "",
		name = "Minerva",
		description = "Minerva is one of Jupiter Sisters, who is attached with Shiori"
		.. "#She is little girl, but her wings allow her to fly"
		.. "#Low damage but shoots directional tears"
		.. "#{{Key}} Minerva requires keys to use active items. Lil' Batteries recover Minerva's Keys"
		.. "#{{GoldenKey}} Batteries in Shops are automatically converted into Golden Keys. Obtaining Golden Key automatically converts into 6 keys"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}} Minerva starts with Book of Shiori"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} Minerva starts with Minerva's Aura"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_CONQUEST.."}} Minerva starts with Book of Conquest"
		--.. "#"
		.. "",
	},
	-- tsukasa
	[wakaba.Enums.Players.TSUKASA] = {
		-- icon = "",
		name = "Tsukasa",
		description = "Tsukasa is mysterious girl from {{ColorBookofConquest}}Tonikaku Kawaii{{CR}} from Hata Kenjiro"
		.. "#Shoots short range, spectral lasers"
		.. "#Due to her eternities, Tsukasa only can see items from ~Rebirth, and modded items"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.LUNAR_STONE.."}} Tsukasa starts with Lunar Stone"
		.. "#!!! Tsukasa dies when Lunar Stone disappears"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.CONCENTRATION.."}} Tsukasa starts with Concentration"
		--.. "#"
		.. "",
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		-- icon = "",
		name = "Tainted Tsukasa",
		description = "???"
		.. "#Cannot shoot tears, but her fairy, Murasame "
		.. "#Due to side effect from Elixir of Life, she {{ColorRed}}DOES NOT HAVE INVINCIBILITY FRAMES{{CR}}"
		.. "#Due to Elixir of Life, she recovers health for fast speed"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.ELIXIR_OF_LIFE.."}} Tainted Tsukasa starts with Elixir of Life"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.MURASAME.."}} Tainted Tsukasa starts with Murasame"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.FLASH_SHIFT.."}} Tainted Tsukasa starts with Flash Shift"
		--.. "#"
		.. "",
	},
	-- richer
	[wakaba.Enums.Players.RICHER] = {
		-- icon = "",
		name = "Richer",
		description = "Richer is a kawaii maid girl from {{ColorLime}}Love's Sweet Garnish{{CR}} from Miyasaka Miyu, Miyasaka Naco"
		.. "#She can improve her destiny with her ribbon"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} Richer starts with Rabbit Ribbon"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}} Richer starts with Sweets Catalog"
		--.. "#"
		.. "",
	},
	[wakaba.Enums.Players.RICHER_B] = {
		-- icon = "",
		name = "Tainted Richer",
		description = "Tainted Richer has a sweet body that is too delicate"
		.. "#She cannot get any passives normally, any attempt to get one will change it into item Wisp"
		.. "#Actives can be collected normally"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} Tainted Richer starts with Rabbit Ribbon"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WINTER_ALBIREO.."}} Tainted Richer starts with The Winter Albireo"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}} Tainted Richer starts with Water-Flame"
		--.. "#"
		.. "",
	},

}

if EID then
	EID.descriptions[desclang].WakabaAchievementWarningTitle = "{{ColorYellow}}!!! Achievements?"
	EID.descriptions[desclang].WakabaAchievementWarningText = "Pudding & Wakaba's characters come with full sets of unlocks#This is an optional feature#Do you want to lock some items behind our characters?"

	EID.descriptions[desclang].TaintedTsukasaWarningTitle = "{{ColorYellow}}!!! Locked !!!"
	EID.descriptions[desclang].TaintedTsukasaWarningText = "Have to unlock this character first#Howto : Use Red Key to open the hidden closet in Home as Tsukasa#Entering the right door will exit the game"
	
	EID.descriptions[desclang].SweetsChallenge = "On use, shows prompt for quality#If the quality matches, get the item"
	EID.descriptions[desclang].SweetsFlipFlop = "Use item again to cancel#{{ButtonY}}/{{ButtonX}}:{{Quality1}}or{{Quality3}}#{{ButtonA}}/{{ButtonB}}:{{Quality2}}or{{Quality4}}#If the selected quality matches with item's one, get the item, else disappear otherwise"

	EID.descriptions[desclang].SweetsChallengeFailed = "{{ColorOrange}}Failed for mismatching quality : "
	EID.descriptions[desclang].SweetsChallengeSuccess = "{{ColorCyan}}Succeed for matching quality : "

end