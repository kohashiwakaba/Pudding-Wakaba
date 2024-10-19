local desclang = "en_us"
local u = wakaba.Enums.RicherUniformMode

function wakaba:EIDCond_PlayerHasBirthright(playerType)
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetPlayerType() == playerType and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			return true
		end
	end
	return false
end
function wakaba:EIDCond_IsChallenge(challenge)
	return wakaba.G.Challenge == challenge
end
function wakaba:EIDCond_IsHiddenEnabled()
	return EID and EID.Config["ItemReminderShowHiddenInfo"]
end

wakaba.descriptions[desclang] = {}
wakaba.descriptions[desclang].birthright = {}
wakaba.descriptions[desclang].characters = {
	[wakaba.Enums.Players.WAKABA] = {
		playerName = "Wakaba",
		shortDesc = "Homing Tears#Only Quality {{Quality2}} or higher items can spawn",
		detailedDesc = "Wakaba is a kawaii, and lucky girl from anime {{ColorLime}}Wakaba Girl{{CR}} from Hara Yui"
		.. "#She can get good items, and shoots homing tears"
		.. "#{{AngelChance}} She only can see Angel rooms"
		.. "#{{BrokenHeart}} Due to her lonely past, she only can have maximum of total 3 hearts"
		.. "#{{Pill}} Wakaba is unable to see Speed up, Luck Down pills"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WAKABAS_BLESSING.."}} Wakaba starts with Wakaba's Blessing"
		--.. "#"
		.. "",
		birthright = "↑ {{Heart}} Extends one Heart limit#{{AngelChance}} 100% chance to find an Angel Room in {{ColorLime}}ALL{{CR}} floors",
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		playerName = "Tainted Wakaba",
		shortDesc = "Can't have Red Hearts#Attacks pierce enemies' defense#Spectral, Piercing Tears",
		detailedDesc = "Tainted Wakaba is the lonely, and unlucky past version"
		.. "#She {{ColorRed}}CANNOT{{CR}} get good items, and shoots spectral and piercing tears"
		.. "#{{DevilChance}} She only can see Devil rooms. All collectibles for sale requires Soul Hearts"
		.. "#{{Damage}} Due to her lack of affection, she gets temporary +3.6 Damage up for getting a collectible item, but other stats are reduced permanently"
		.. "#{{Pill}} Tainted Wakaba is unable to see Speed down, Luck up pills"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WAKABAS_NEMESIS.."}} Tainted Wakaba starts with Wakaba's Nemesis"
		.. "#{{DevilRoom}} Collectibles on sale requires {{SoulHeart}}Soul Hearts"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.EATHEART.."}} Tainted Wakaba starts with Eat Heart"
		--.. "#"
		.. "",
		birthright = "↑ {{Collectible"..wakaba.Enums.Collectibles.WAKABAS_NEMESIS.."}} Wakaba's Nemesis no longer decreases all stats, and reduces damage fading rate#Explosions and crush impacts immunity",
	},
	[wakaba.Enums.Players.SHIORI] = {
		playerName = "Shiori",
		shortDesc = "Directional tears#Consume Keys to use active items#Cycle which book to use with {{ButtonRT}}",
		detailedDesc = "Shiori is a librarian from {{ColorBookofConquest}}The World God only Knows{{CR}} from Wakagi Tamaki"
		.. "#Low damage but shoots directional tears"
		.. "#{{Key}} Shiori requires keys to use active items. Lil' Batteries recover Shiori's Keys"
		.. "#{{GoldenKey}} Batteries in Shops are automatically converted into Golden Keys. Obtaining Golden Key automatically converts into 6 keys"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}} Shiori starts with Book of Shiori"
		--.. "#"
		.. "",
		birthright = "↑ Halves key consume when using active item(Minimum 1)",
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		playerName = "Minerva",
		shortDesc = "Can't have Red Hearts#Directional tears#Consume Keys to use active items",
		detailedDesc = "Minerva is one of Jupiter Sisters, who is attached with Shiori"
		.. "#She is little girl, but her wings allow her to fly"
		.. "#Low damage but shoots directional tears"
		.. "#{{Key}} Minerva requires keys to use active items. Lil' Batteries recover Minerva's Keys"
		.. "#{{GoldenKey}} Batteries in Shops are automatically converted into Golden Keys. Obtaining Golden Key automatically converts into 6 keys"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}} Minerva starts with Book of Shiori"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} Minerva starts with Minerva's Aura"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_CONQUEST.."}} Minerva starts with Book of Conquest"
		--.. "#"
		.. "",
		birthright = "{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} Allows aura activation#The number of required keys for {{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_CONQUEST.."}}Book of Conquest and active items are reduced (Minimum 1)#↑ All stats up for current number of conquered enemies",
	},
	[wakaba.Enums.Players.TSUKASA] = {
		playerName = "Tsukasa",
		shortDesc = "Short range laser instead of tears#Infinite Revival#Gets Game Over on Lunar Gauge depletion",
		detailedDesc = "Tsukasa is mysterious girl from {{ColorBookofConquest}}Tonikaku Kawaii{{CR}} from Hata Kenjiro"
		.. "#Shoots short range, spectral lasers"
		.. "#Due to her eternities, Tsukasa only can see items from ~Rebirth, and modded items"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.LUNAR_STONE.."}} Tsukasa starts with Lunar Stone"
		.. "#!!! Tsukasa dies when Lunar Stone disappears"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.CONCENTRATION.."}} Tsukasa starts with Concentration"
		--.. "#"
		.. "",
		birthright = "Allows Tsukasa to find Afterbirth ~ Repentance items#↑ Extends maximum {{Collectible"..wakaba.Enums.Collectibles.LUNAR_STONE.."}}Lunar gauge limit",
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		playerName = "Tainted Tsukasa",
		shortDesc = "Shift attack with Attack buttons#No invincibility frames",
		detailedDesc = "???"
		.. "#Cannot shoot tears, but her fairy, Murasame can use short range melee attack instead of her"
		.. "#Due to side effect from Elixir of Life, she {{ColorRed}}DOES NOT HAVE INVINCIBILITY FRAMES{{CR}}"
		.. "#Due to Elixir of Life, she recovers health for fast speed"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.ELIXIR_OF_LIFE.."}} Tainted Tsukasa starts with Elixir of Life"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.MURASAME.."}} Tainted Tsukasa starts with Murasame"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.FLASH_SHIFT.."}} Tainted Tsukasa starts with Flash Shift"
		--.. "#"
		.. "",
		birthright = "Allows Tainted Tsukasa to shoot tears#{{Collectible"..wakaba.Enums.Collectibles.FLASH_SHIFT.."}} Flash Shift ability is now moved into pocket item slot.",
	},
	[wakaba.Enums.Players.RICHER] = {
		playerName = "Richer",
		shortDesc = "Converts curses#Boosts trinkets#Reduces damage taken",
		detailedDesc = "Richer is a kawaii maid girl from {{ColorLime}}Love's Sweet Garnish{{CR}} from Miyasaka Miyu, Miyasaka Naco"
		.. "#Her soft body allows make to take damage by half, and make trinket boosts"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} Richer starts with Rabbit Ribbon"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}} Richer starts with Sweets Catalog"
		--.. "#"
		.. "",
		birthright = "#{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}} Sweets Catalog effect is now persistent until next catalog usage#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} Removes penalties, or gives advantages from Rabbit Ribbon curses (can be checked through Inventory Descriptions)",
	},
	[wakaba.Enums.Players.RICHER_B] = {
		playerName = "Tainted Richer",
		shortDesc = "Can't have Red Hearts#Converts curses#Touching an item pedestal turns it into an item wisp#The HUD has a preview of your item wisps#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}} Water-Flame absorbs selected item wisp into actual item#Cycle which item wisp to absorb with {{ButtonRT}}",
		detailedDesc = "Tainted Richer has a sweet body that is too delicate"
		.. "#She cannot get any passives normally, any attempt to get one will change it into item Wisp"
		.. "#Actives can be collected normally"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} Tainted Richer starts with Rabbit Ribbon"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WINTER_ALBIREO.."}} Tainted Richer starts with The Winter Albireo"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}} Tainted Richer starts with Water-Flame"
		--.. "#"
		.. "",
		birthright = "#More durable Flames#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}} Water-Flame Grants additional passive per absorbed flame",
	},
	[wakaba.Enums.Players.RIRA] = {
		playerName = "Rira",
		shortDesc = "Chance to shoot Aqua tears#Can use Donation mechanics while in white fire state",
		detailedDesc = "Rira is a kawaii maid girl from {{ColorLime}}Love's Sweet Garnish{{CR}} from Miyasaka Miyu, Miyasaka Naco"
		.. "#She seems very shy, but actually, is really ecchi"
		.. "#{{WakabaAqua}} She shoots Aqua tears that aquafies enemies that take more damage from some sources"
		.. "#She can use donation mechanics even when in Lost state"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.CHIMAKI.."}} Rira starts with Chimaki"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.NERF_GUN.."}} Rira starts with Nerf Gun"
		--.. "#"
		.. "",
		birthright = "#{{Collectible"..wakaba.Enums.Collectibles.NERF_GUN.."}} Weakness from Nerf Gun lasts longer#{{Collectible"..wakaba.Enums.Collectibles.CHIMAKI.."}} Chimaki becomes more stronger",
	},
	[wakaba.Enums.Players.RIRA_B] = {
		playerName = "Tainted Rira",
		shortDesc = "Can't have Red Hearts#Treasure rooms are converted into Trinkets#Being outside of Rabbey Ward area slowly drains health#Can charge Rabbey Ward even on non-hostile room#Can use Donation mechanics while in white fire state",
		detailedDesc = "Tainted Rira's tempting aqua body, emits sweet pheromones even without knowing it"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.AZURE_RIR.."}} She needs to be nearby {{ColorRira}}Rabbey Ward{{CR}}rooms, otherwise drains health slowly"
		.. "#{{AquaTrinket}} All Treasure room items are converted into {{ColorCyan}}Aqua Trinkets{{CR}}"
		.. "#She can use donation mechanics even when in Lost state"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.AZURE_RIR.."}} Tainted Rira starts with Azure Rir"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBEY_WARD.."}} Tainted Rira starts with Rabbey Ward"
		--.. "#"
		.. "",
		birthright = "#Health no longer drains outside of ward area#{{Collectible"..wakaba.Enums.Collectibles.RABBEY_WARD.."}} Doubles Rabbey Ward charge rate for new room#{{Collectible"..wakaba.Enums.Collectibles.RABBEY_WARD.."}} Using Rabbey Ward also divides nearby pedestal in the room#{{Collectible"..wakaba.Enums.Collectibles.RABBEY_WARD.."}} Rabbey Wards shoot homing laser to enemies",
	},
	[wakaba.Enums.Players.ANNA] = {
		playerName = "Anna",
		shortDesc = "",
		detailedDesc = "Anna is a lovely model from {{ColorLime}}The Dangers in My Heart{{CR}} from Nurio"
		.. "#{{Collectible402}} Her lovey-dovey behaviors with her lover Kyoutarou makes chaos around her"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.KYOUTAROU_LOVER.."}} Anna starts with Kyoutarou Lover"
		--.. "#"
		.. "#{{WakabaModLunatic}} Effectiveness from P&W items are reduced"
		.. "",
		birthright = "Prevents Quality {{Quality0}} items from spawning#{{Speed}} +0.003 Speed per obtained collectible",
	},
}
wakaba.descriptions[desclang].collectibles = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		itemName = "Wakaba's Blessing",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#↑ Prevents {{Quality0}}/{{Quality1}} items from spawning"
		.. "#↑ Prevents penalties from all damage taken"
		.. "#{{HolyMantle}} Gives Holy Mantle shield per room on a total of 1 heart or less"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Prevents {{Quality0}} items from spawning"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}(NO LONGER Prevents penalties from all damage taken)"
		.. "#{{HolyMantle}} Gives Holy Mantle shield per room on a total of 1 heart or less"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		itemName = "Wakaba's Nemesis",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{DevilChance}} Prevents Angel room to be spawned"
		.. "#↑ Armor-piercing tears"
		.. "#{{Damage}} Picking up an item grants temporary +3.6 Damage"
		.. "#↓ Prevents {{Quality4}}/{{Quality5}}/{{Quality6}} items from spawning, also reduces chances for {{Quality3}} items"
		.. "#↑ Prevents penalties from all damage taken"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{DevilChance}} Prevents Angel room to be spawned"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}(NO LONGER gives Armor-piercing tears)"
		.. "#{{Damage}} Picking up an item grants temporary +3.6 Damage"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Prevents {{Quality3}}/{{Quality4}}/{{Quality5}}/{{Quality6}} items from spawning"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}(NO LONGER Prevents penalties from all damage taken)"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.LEVIATHAN .. "",
	},
	[wakaba.Enums.Collectibles.WAKABA_DUALITY] = {
		itemName = "Wakaba Duality",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#↑ Armor-piercing tears"
		.. "#↓ Picking up an item grants temporary {{Damage}} +3.6 damage boost"
		.. "#{{AngelDevilChance}}100% chance to find an Devil/Angel Room in all floors"
		.. "#↑ Can get all items with selection"
		.. "#↑ Prevents penalties from all damage taken"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.LEVIATHAN .. "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SHIORI] = {
		itemName = "Book of Shiori",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{ShioriValut}} Guarantees Library every floor if possible"
		.. "#Activates additional effect when book active items are being used"
		.. "#Isaac also gains extra tear effect when book active items are being used"
		.. "#Extra tear effect changes on next book usage"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{ShioriValut}} Guarantees Library every floor if possible"
		.. "#Activates additional effect when book active items are being used"
		.. "#Isaac also gains extra tear effect when book active items are being used"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Extra tear effect changes on next book usage, or resets on entering new floor"
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
		carBattery = "{{BlinkYellowGreen}}Also makes non-major bosses friendly",
		--wisp = "{{ColorOrange}}Outer Ring x1: {{CR}}#Makes a non-boss enemy friendly on contact",
	},
	[wakaba.Enums.Collectibles.MINERVA_AURA] = {
		itemName = "Minerva's Aura",
		description = ""
		.. "#Isaac and Other players inside aura grants:"
		.. "#↓ {{Damage}} -0.5 damage"
		.. "#↑ {{Tears}} +0.5 Fire rate up"
		.. "#↑ {{Tears}} x2.3 Fire rate multiplier"
		.. "#↑ Homing Tears"
		.. "#Prevents penalties from all damage taken"
		.. "#Friendly monsters/familiars inside the aura gradually recovers their health"
		.. "{{CR}}",
		lunatic = ""
		.. "#Isaac and Other players inside aura grants:"
		.. "#{{WakabaModLunatic}} {{Damage}} {{ColorOrange}}-2 damage"
		.. "#↑ {{Tears}} +0.5 Fire rate up"
		.. "#{{WakabaModLunatic}} {{Tears}} {{ColorOrange}}x1.6 Fire rate multiplier"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}(NO LONGER gives homing tears)"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}(NO LONGER Prevents penalties from all damage taken)"
		.. "#Friendly monsters/familiars inside the aura gradually recovers their health"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Collectibles.LUNAR_STONE] = {
		itemName = "Lunar Stone",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#↑ Grants additional Lunar gauge that gives {{Damage}}Damage, {{Tears}}Tears mult while active"
		.. "#Taking damage deactivates and lunar gauge starts deplete, Clearing rooms recover it"
		.. "#↑ Unlimited lives while holding Lunar Stone"
		.. "#!!! Lunar Stone is removed when gauge depletes"
		.. "#↑ Prevents penalties from all damage taken"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#↑ Grants additional Lunar gauge that gives {{Damage}}Damage, {{Tears}}Tears mult while active"
		.. "#Taking damage deactivates and lunar gauge starts deplete, Clearing rooms recover it"
		.. "#↑ Unlimited lives while holding Lunar Stone"
		.. "#!!! Lunar Stone is removed when gauge depletes"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}(NO LONGER Prevents penalties from all damage taken)"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}(Faster lunar gauge reduction speed)"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ELIXIR_OF_LIFE] = {
		itemName = "Elixir of Life",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{WakabaAntiCurseUnknown}} Curse of the Unknown immunity"
		.. "#!!! {{ColorOrange}}Significantly reduces invincibility frames to 0.03s"
		.. "#Regenerates health for fast time if Isaac did not get hit for brief time depends on which type of health character currently has"
		.. "#!!! Removes, or reduces 1 heart recovery health per 4 donation mechanic usage"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{WakabaAntiCurseUnknown}} Curse of the Unknown immunity"
		.. "#{{WakabaModLunatic}} {{ColorRed}}Removes invincibility frames"
		.. "#Regenerates health for fast time if Isaac did not get hit for brief time depends on which type of health character currently has"
		.. "#!!! Removes, or reduces 1 heart recovery health per 4 donation mechanic usage"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		itemName = "Flash Shift",
		description = ""
		.. "Shifts Isaac for four direction that Isaac moving"
		.. "#Can be used up to 3 times until recharged"
		.. "#!!! Familiars do not shift, Beware when using orbitals or wisps"
		.. "{{CR}}",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.CONCENTRATION] = {
		itemName = "Concentration",
		description = ""
		.. "#Hold Drop button to enter concentration mode"
		.. "#Concentrate 3 seconds to fully charge active items"
		.. "#↑ +1.5 {{Range}} Range up for concentrate (additional +0.25 per count)"
		.. "#!!! Concentration time increases per usage. This count can be decreased on room clears"
		.. "#!!! Can't concentrate on 300+ counts"
		.. "#!!! Isaac cannot move and takes twice damage while in concentration mode"
		.. "{{CR}}",
		lunatic = ""
		.. "#Hold Drop button to enter concentration mode"
		.. "#Concentrate 3 seconds to fully charge active items"
		.. "#↑ +1.5 {{Range}} Range up for concentrate (additional +0.25 per count)"
		.. "#!!! Concentration time increases per usage. This count can be decreased on room clears"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Repeating concentration reqires room clears, can't concentrate on 60+ counts"
		.. "#!!! Isaac cannot move and takes twice damage while in concentration mode"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.RABBIT_RIBBON] = {
		itemName = "Rabbit Ribbon",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{CurseCursed}} Changes other curses"
		.. "#{{Battery}} Stores extra charge after clearing a room (max 16)"
		.. "#Automatically consumes stored ones for uncharged actives"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{CurseCursed}} Changes other curses"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Stores extra charge after clearing a room (max 6)"
		.. "#Automatically consumes stored ones for uncharged actives"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.SWEETS_CATALOG] = {
		itemName = "Sweets Catalog",
		description = ""
		.. "#Grants a random weapon for current room"
		.. "{{CR}}",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.WINTER_ALBIREO] = {
		itemName = "The Winter Albireo",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{RicherPlanetarium}} Richer's special Planetariums appear per stage that contains:"
		.. "#Random pool item depending of floor"
		.. "#White Fireplace"
		.. "#{{CrystalRestock}} Crystal restock machine"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{RicherPlanetarium}}Richer's special Planetariums replace treasure rooms that contains:"
		.. "#Random pool item depending of floor"
		.. "#White Fireplace"
		.. "#{{CrystalRestock}} Crystal restock machine"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		itemName = "Water-Flame",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity while held"
		.. "#On use, spawns 2 copy wisps of the nearest pedestal"
		.. "#Only can copy item that can be spawned by {{Collectible712}}Lemegeton"
		.. "{{CR}}",
		carBattery = {2, 4},
	},
	[wakaba.Enums.Collectibles.NERF_GUN] = {
		itemName = "Nerf Gun",
		description = ""
		.. "#Using the item and shooting in a direction fires multiple nerf tears"
		.. "#{{Weakness}} Nerfed enemies are {{Slow}} slowed and take double damage for 10 seconds"
		.. "{{CR}}",
		carBattery = "More nerf tears",
	},
	[wakaba.Enums.Collectibles.CHIMAKI] = {
		itemName = "Chimaki",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#Wanders around and helps Isaac not limited to:"
		.. "#Shoot tears or flames"
		.. "#{{Collectible374}} Jumps toward enemy"
		.. "#{{Collectible260}} Chance to remove Curses"
		.. "#{{Trinket63}} Converts Troll Bombs"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.RABBEY_WARD] = {
		itemName = "Rabbey Ward",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity while held"
		.. "#On use, installs a Rabbit Ward that causes:"
		.. "#Reveals further rooms"
		.. "#Damage, Tears up inside revealed rooms"
		.. "#{{SoulHeart}} Clearing room inside Rabbit Ward recovers 1 soul heart"
		.. "{{CR}}",
		carBattery = {"a Rabbit Ward", "2{{CR}} Rabbit Wards"},
	},
	[wakaba.Enums.Collectibles.AZURE_RIR] = {
		itemName = "Azure Rir",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Curse of the Blind immunity"
		.. "#{{AquaTrinket}} All trinkets become Aqua trinkets"
		.. "#!!! Blacklisted trinkets have no effect"
		--.. "#Room clear awards spawn earlier"
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
		.. "#Spawns a random collectible item from current item pool"
		.. "#{{Quality3}}/{{Quality4}} are guaranteed to be spawned ({{Quality1}} for {{Collectible477}})"
		.. "{{CR}}",
		lunatic = ""
		.. "#Only can be charged through damaging enemies or self damage."
		.. "#Can be overcharged without {{Collectible"..CollectibleType.COLLECTIBLE_BATTERY .."}}The Battery. Max 15000 damage"
		.. "#Spawns a random collectible item from current item pool"
		.. "#{{Quality3}}/{{Quality4}} are guaranteed to be spawned ({{Quality1}} for {{Collectible477}})"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Decreased charge rate by half"
		.. "{{CR}}",
		wisp = "{{ColorLime}}Inner ring x1: {{CR}}#Invincible Wisp#Cannot shoot tears",
		void = "No longer guarantees {{Quality3}}/{{Quality4}} when voided",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		itemName = "Book of Forgotten",
		description = ""
		.. "#Applies to all players on use:"
		.. "#↑ {{BoneHeart}} +1 Bone Heart"
		.. "#{{HealingRed}} Heals all heart containers"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		belial = "{{BlackHeart}}Gives 1 Black Heart instead of Bone Heart. Full Health effect is still intact",
		wisp = "{{ColorYellow}}Center Ring x1: {{CR}}#{{BoneHeart}}Spawns a Bone Heart when destroyed",
		carBattery = {1, 2},
	},
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		itemName = "D-Cup Ice Cream",
		description = ""
		.. "#↑ {{Heart}} +1 Health"
		.. "#↑ {{HealingRed}} Heals one Red Heart"
		.. "#↑ {{Damage}} +0.3 Damage Up"
		.. "#↑ {{Damage}} +80% Damage Multiplier (Does not stack)"
		.. "{{CR}}",
		lunatic = ""
		.. "#↑ {{Heart}} +1 Health"
		.. "#↑ {{HealingRed}} Heals one Red Heart"
		.. "#↑ {{Damage}} +0.3 Damage Up"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Damage}} +36% Damage Multiplier (Does not stack)"
		.. "{{CR}}",
		binge = "↑ {{Damage}} +1.0 Damage#↓ {{Speed}} -0.04 Speed",
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
		.. "#↑ {{Heart}} +1 Health"
		.. "#↑ {{Speed}} +0.16 Speed"
		.. "#↑ {{Tears}} +0.7 Tears"
		.. "#↑ {{Shotspeed}} +0.1 Shot Speed"
		.. "#↑ {{Range}} +0.85 Range"
		.. "#↑ {{Damage}} +0.5 Damage"
		.. "#{{ColorRainbow}}Rooms will be randomly colorized slightly"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		itemName = "Wakaba's Pendant",
		description = ""
		.. "#{{Luck}} Sets your Luck to 7 if you have less than 7"
		--.. "#↑ {{Luck}} +0.35 Luck per Luck affect items"
		.. "#↑ {{Damage}} +1 Damage"
		.. "#{{HealingRed}} Full Health"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Luck}} Sets your Luck to 3 if you have less than 3"
		--.. "#{{WakabaModLunatic}} {{ColorOrange}}(No additional luck)"
		.. "#↑ {{Damage}} +1 Damage"
		.. "#{{HealingRed}} Full Health"
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
		.. "#{{Coin}} Coins will be generated per room cleared"
		.. "#{{Coin}} +1 extra coin if Isaac did not take damage for current floor"
		.. "#{{Shop}} Prevents Greed / Super Greed to be spawned in Shops"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		itemName = "Plumy",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_PLUM_FLUTE.."}} A Baby Plum familiar that follows Isaac."
		.. "#Shoots tears in front of Isaac and blocks projectiles"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_PLUM_FLUTE.."}} A Baby Plum familiar that follows Isaac."
		.. "#Shoots tears in front of Isaac and blocks projectiles"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}When Plumy gets damaged too much, Plumy cannot move and needs 10 seconds to recovery"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		itemName = "Executioner",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_ERASER .."}} 0.75% to 'erase' non-boss enemies"
		.. "#{{Luck}} 10% chance at 117 Luck, 100% chance for bosses"
		.. "#!!! {{ColorSilver}}Some bosses are not affected like Dogma and Mother due to potential softlocks{{ColorReset}}"
		.. "{{CR}}",
		LuckFormula = function(luck) return wakaba:StackChance(0.0075 + wakaba:LuckBonus(luck, 117, 0.1 - 0.0075), 1) * 100 end
	},
	[wakaba.Enums.Collectibles.NEW_YEAR_BOMB] = {
		itemName = "New Year's Eve Bomb",
		description = ""
		.. "#↑ {{Bomb}} +9 Bombs"
		.. "#All explosions ignore enemies' armor"
		.. "#Explosions already ignored armor deal 2x damage"
		.. "#{{Player25}} Using Hold as Tainted ??? consumes 3 {{PoopPickup}}Poops and holds a bomb"
		.. "#!!! Can use Hold only when less than 3 Poops"
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
		.. "#On use, stores/swaps current card, pill, or rune"
		.. "#(change slot with {wakaba_extra_left} / {wakaba_extra_right})"
		.. "#Using a consumable, also activates stored contents"
		.. "{{CR}}",
		belial = "Invokes XV - The Devil card effect per card/pill/rune used inside Uniform",
		--wisp = "{{ColorRed}}!!!No Wisp {{CR}}#All wisps become invincible while held",
		void = "Can't change stored content anymore, copying stored content is changed to void usage",
		carBattery = "Stored content is used on active usage",
	},
	[wakaba.Enums.Collectibles.EYE_OF_CLOCK] = {
		itemName = "Eye of Clock",
		description = ""
		.. "#Constantly shooting gradually spawns Tech. X lasers orbiting Isaac"
		.. "#Orbiting lasers also shoots extra lasers"
		.. "#Orbiting lasers deal 0.75x of Isaac's damage"
		.. "#Extra lasers deal 0.25x of Isaac's damage"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
	},
	[wakaba.Enums.Collectibles.LIL_WAKABA] = {
		itemName = "Lil Wakaba",
		description = ""
		.. "#Shoots small Tech.X Lasers"
		.. "#Deals 40% of Isaac's damage"
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
		wisp = "{{ColorOrange}}Outer Ring x1: {{CR}}Only for current room#All wisps become invincible while counter shield is active",
		void = "Loses auto activation, shield duration extended to 20 seconds",
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
		wisp = "{{ColorLime}}Inner Ring x1: {{CR}}No special effect",
		carBattery = "Adds 1 more choice per pedestal",
	},
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		itemName = "D6 Chaos",
		description = ""
		.. "#{{Card"..Card.CARD_SOUL_ISAAC.."}} Invokes Soul of Isaac effect for {{ColorRed}}9 times{{CR}}"
		.. "#Rerolled items cycle for insane speed"
		.. "{{CR}}",
		wisp = "{{ColorLime}}Inner Ring x1: {{CR}}No special effect",
		carBattery = "No effect",
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
		wisp = "{{ColorYellow}}Center Ring x1: {{CR}}#Homing tears",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		itemName = "Shiori's Bottle of Runes",
		description = ""
		.. "#{{Rune}} Gives Isaac a random rune"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		belial = "50% chance to get Black rune instead of random one#{{ColorWakabaNemesis}}Invokes Black Rune effect for 10% chance",
		wisp = "{{ColorYellow}}Center Ring x1: {{CR}}#{{Rune}}15% chance for enemy to drop rune on kill#{{Rune}}Spawns a rune when destroyed",
		carBattery = {" a ", " 2 ", "random rune", "{{CR}}random runes"},
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		itemName = "Micro Doppelganger",
		description = ""
		.. "#Spawns 12 tiny Isaac familiars."
		.. "#They chase and shoot at nearby enemies"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		wisp = "{{ColorOrange}}Outer Ring x1: {{CR}}#Spawns MinIsaacs when destroyed",
		carBattery = {12, 24, 3, 6, 1, 2},
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		itemName = "Book of Silence",
		description = ""
		.. "#Removes all enemy projectiles"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		belial = "Invokes {{Collectible" .. CollectibleType.COLLECTIBLE_DARK_ARTS .. "}}Dark Arts effect and damages all enemies per erased projectiles",
		wisp = "{{ColorOrange}}Outer Ring x1: {{CR}}#Immune to projectiles#Erases nearby projectiles",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.VINTAGE_THREAT] = {
		itemName = "Vintage Threat",
		description = ""
		.. "#{{Player"..wakaba.Enums.Players.SHIORI_B.."}} On death, Respawn as Tainted Shiori in current room with 4 {{Collectible656}}Damocles swords, and removes all keys"
		.. "#!!! Damage penalty protection is invalidated after revival"
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
		wisp = "{{ColorLime}}Inner Ring x1: {{CR}}High durability#Revives Isaac on death and the wisp is consumed",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_TRAUMA] = {
		itemName = "Book of Trauma",
		description = ""
		.. "#Detonate Isaac's tears currently on the screen, causing each one to explode (Max 15)."
		.. "#Exploded tear shots Brimstone laser at 4 directions."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		carBattery = "Explosions are Giga Bomb explosions",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		itemName = "Book of The Fallen",
		description = ""
		.. "#On use, Spawns 3 Putagory ghosts that deals 0.4x of Isaac's Damage"
		.. "#If damage is lethal while held, Isaac turns into Fallen Angel, and gives 6 Black Hearts"
		.. "#!!! {{ColorSilver}}After Isaac turning into Fallen Angel:"
		.. "#{{ColorSilver}}On use, Spawns 11 Hungry Souls that deals Isaac's Damage"
		.. "#!!! {{ColorSilver}}Can no longer shoot tears"
		.. "#↑ {{Damage}} {{ColorSilver}}+600% Damage Multiplier"
		.. "#!!! {{ColorYellow}}Isaac can no longer swap active items{{ColorReset}}"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.LEVIATHAN .. "," .. EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY] = {
		itemName = "Maijima Mythology",
		description = ""
		.. "#Random book active item effect"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		wisp = "{{ColorOrange}}Outer Ring x1: {{CR}}#Spawns Unknown Bookmark when destroyed",
		carBattery = {"Random book", "2{{CR}} Random book", "effect", "effects"},
	},
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = {
		itemName = "Apollyon Crisis",
		description = ""
		.. "#{{WakabaModRgon}} {{ColorOrange}}REPENTOGON ONLY!{{CR}} REPORT TO DEV IF YOU FOUND THIS ITEM OUTSIDE FROM RGON"
		.. "{{CR}}",
		carBattery = "Activates selected active item again if possible",
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
		lunatic = ""
		.. "#{{Collectible532}} hungry tear familiar"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Shoots single tear"
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
		.. "#Isaac's non-explosive attacks now ignores armor"
		.. "#↑ Guarantees {{Quality3}}/{{Quality4}} items in {{UltraSecretRoom}}Ultra Secret Room"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.GUPPY .. "",
	},
	[wakaba.Enums.Collectibles.DEJA_VU] = {
		itemName = "Deja Vu",
		description = ""
		.. "#12.5% chance to reroll items into items that Isaac already holds"
		.. "{{CR}}",
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
		lunatic = ""
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Spawns a Lil Clot (max 4)"
		.. "#Heals all spawned Lil Clots' health by 2"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		carBattery = {" a ", " 2 ", "Lil Clot ", "{{CR}} Lil Clots ", 2, 4},
	},
	[wakaba.Enums.Collectibles.BALANCE] = {
		itemName = "Balance ecnalaB",
		description = ""
		.. "#Converts 5 {{Coin}}coins into 1 {{Key}}key and 1 {{Bomb}}bomb."
		.. "#If there are not enough coins: "
		.. "#Converts 1 of Key/Bomb into another one that Isaac less have."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		wisp = "{{ColorRed}}!!!No Wisp {{CR}}#All wisps become invincible while Isaac has same Keys and Bombs",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.RICHERS_FLIPPER] = {
		itemName = "Richer's Flipper",
		description = ""
		.. "#{{Bomb}} +1 Bomb"
		.. "#{{Key}} +1 Key"
		.. "#Converts {{Bomb}}/{{Key}} and {{Card}}/{{Pill}} each other"
		.. "{{CR}}",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.RICHERS_NECKLACE] = {
		itemName = "Richer's Necklace",
		description = ""
		.. "#Missed tears make Dogma's static lasers"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.MOE_MUFFIN] = {
		itemName = "Moe's Muffin",
		description = ""
		.. "↑ {{Heart}} +1 Health"
		.. "#↑ {{HealingRed}} Heals one Red Heart"
		.. "#↑ {{Damage}} +1.5 Damage Up"
		.. "#↑ {{Range}} +1.5 Range Up"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.MURASAME] = {
		itemName = "Murasame",
		description = ""
		.. "#{{AngelDevilChance}} Spawns both an Angel and Devil room for 100% chance#Entering one makes the other disappear"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.CLOVER_SHARD] = {
		itemName = "Clover Shard",
		description = ""
		.. "↑ {{Heart}} +1 Health"
		.. "#↑ {{HealingRed}} Heals one Red Heart"
		.. "#↑ {{Damage}} +11% Damage Multiplier"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles.NASA_LOVER] = {
		itemName = "Nasa Lover",
		description = ""
		.. "#{{Collectible494}} Electric tear familiar"
		.. "#{{Collectible494}} All of Isaac's familiars also gain electric tears"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.ARCANE_CRYSTAL] = {
		itemName = "Arcane Crystal",
		description = ""
		.. "#↑ {{Damage}} +12% Damage Multiplier"
		.. "#Homing tears"
		.. "#20% chance to take extra damage for enemies"
		.. "#{{Luck}} 60% chance at 43 Luck"
		.. "{{CR}}",
		LuckFormula = function(luck) return wakaba:StackChance(0.2 + wakaba:LuckBonus(luck, 43, 0.6 - 0.2), 1) * 100 end
	},
	[wakaba.Enums.Collectibles.ADVANCED_CRYSTAL] = {
		itemName = "Advanced Crystal",
		description = ""
		.. "#↑ {{Damage}} +14% Damage Multiplier"
		.. "#Piercing tears"
		.. "#5% chance to take armor-piercing damage for enemies"
		.. "#{{Luck}} 43% chance at 55 Luck"
		.. "{{CR}}",
		LuckFormula = function(luck) return wakaba:StackChance(0.05 + wakaba:LuckBonus(luck, 55, 0.43 - 0.05), 1) * 100 end
	},
	[wakaba.Enums.Collectibles.MYSTIC_CRYSTAL] = {
		itemName = "Mystic Crystal",
		description = ""
		.. "#↑ {{Damage}} +16% Damage Multiplier"
		.. "#Glowing tears"
		.. "#{{Card" .. Card.CARD_HOLY .."}} Holy Card effect is granted per 8 room clears (Max 2)"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		itemName = "3d Printer",
		description = ""
		.. "#Duplicates and smelts current held trinket"
		.. "{{CR}}",
		wisp = "{{ColorYellow}}Center Ring x1: {{CR}}#Spawns a trinket when destroyed",
		carBattery = "Doubles smelted trinket",
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
		.. "#↑ All Isaac's attack now deal 1.25x laser damage"
		.. "#↑ Prior laser damage now ignore enemies' armor"
	},
	[wakaba.Enums.Collectibles.POWER_BOMB] = {
		itemName = "Power Bomb",
		description = ""
		.. "#Makes giant explosion that destroys all objects, opens all doors, and damages all enemies in the current room"
		.. "#Pulls all pickups to explosion point on fading"
		.. "{{CR}}",
		carBattery = "Doubles explosion damage",
	},
	[wakaba.Enums.Collectibles.MAGMA_BLADE] = {
		itemName = "Magma Blade",
		description = ""
		.. "#{{WakabaModRgon}} {{ColorOrange}}REPENTOGON ONLY!{{CR}} REPORT TO DEV IF YOU FOUND THIS ITEM OUTSIDE FROM RGON"
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
		belial = "↑ {{Damage}} +25% Damage multiplier while in cloaked state",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.RED_CORRUPTION] = {
		itemName = "Red Corruption",
		description = "{{Collectible21}} Reveals icons on the map"
		.. "#All special rooms except Boss rooms will be turned into red rooms"
		.. "#Entering a new floor has 46% chance to generate new rooms adjacent special rooms if possible"
		.. "#{{Luck}} 100% chance at 29 Luck"
		.. "#!!! Some doors may lead to {{ErrorRoom}}I AM ERROR rooms!"
		.. "{{CR}}",
		LuckFormula = function(luck) return wakaba:StackChance(0.46 + wakaba:LuckBonus(luck, 29, 1 - 0.46), 1) * 100 end
	},
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		itemName = "Question Block",
		description = ""
		.. "#REPORT TO DEV IF YOU FOUND THIS ITEM"
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
		.. "#{{Pill}} When used, Randomizes a pill effect for current run and spawns changed pill"
		.. "#{{Pill}} Extra pills can be spawned on room clears while held"
		.. "{{CR}}",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2] = {
		itemName = "Curse of The Tower 2",
		description = ""
		.. "#{{GoldenBomb}} Infinite Bombs"
		.. "#Upon taking damage or losing Holy Mantle shields, spawns 6 golden troll bombs around the room"
		.. "#!!! Beware: All troll bombs are converted into Golden troll bombs if possible!"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ANTI_BALANCE] = {
		itemName = "Anti Balance",
		description = ""
		.. "{{Pill}} Identifies all pills#{{Pill}} All pills will be Horse pills"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.VENOM_INCANTATION] = {
		itemName = "Venom Incantation",
		description = ""
		.. "#↑ {{Damage}} +1 Damage"
		.. "#{{Poison}} Poison/Burn damage have 5% chance to instakill normal enemies#{{Blank}} (max 1.36% on non-major bosses)"
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
		.. "#All effects are retained even after revival"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.JAR_OF_CLOVER] = {
		itemName = "Jar of Clover",
		description = ""
		.. "#↑ {{Luck}} +0.25 Luck per 1 game minute"
		.. "#{{Player"..wakaba.Enums.Players.WAKABA.."}} Respawn as Wakaba on death"
		.. "#{{Player"..wakaba.Enums.Players.WAKABA_B.."}} Tainted Wakaba simply revives"
		.. "#All effects are retained even after revival"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.CRISIS_BOOST] = {
		itemName = "Crisis Boost",
		description = ""
		.. "#↑ {{Damage}} Damage multiplier up for low health (max +45%)"
		.. "#!!! {{HolyMantle}} Holy shields also count for health"
		.. "#↑ {{Tears}} +1 Fire Rate"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Damage}} Damage multiplier up for low health (max +16%)"
		.. "#!!! {{HolyMantle}} Holy shields also count for health"
		.. "#↑ {{Tears}} +1 Fire Rate"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.PRESTIGE_PASS] = {
		itemName = "Prestige Pass",
		description = ""
		.. "#{{BossRoom}} Spawns Richer's restock machine on boss room clears"
		.. "#Spawns Richer's restock machine in {{DevilRoom}}Devil/{{AngelRoom}}Angel room, {{Planetarium}}Planetariums, {{SecretRoom}}Secret/{{UltraSecretRoom}}Ultra Secret room, and Black markets"
		.. "#Richer's restock machine can be bombed or paid 5{{Coin}} to reroll, but breaks after 2 rerolls"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{BossRoom}} Spawns Richer's restock machine on boss room clears"
		.. "#Spawns Richer's restock machine in {{DevilRoom}}Devil/{{AngelRoom}}Angel room, {{Planetarium}}Planetariums, {{SecretRoom}}Secret/{{UltraSecretRoom}}Ultra Secret room, and Black markets"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Richer's restock machine can be bombed or paid 5{{Coin}} to reroll, but breaks after 1 reroll"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.BUNNY_PARFAIT] = {
		itemName = "Bunny Parfait",
		description = ""
		.. "#!!! Grants different tear effects depending of last digit of room no.:"
		.. "#0/5 : {{Collectible3}}"
		.. "#{{Blank}} 1/6 : {{Collectible224}}"
		.. "#{{Blank}} 2/7 : {{Collectible618}}"
		.. "#{{Blank}} 3/8 : {{Collectible374}}"
		.. "#{{Blank}} 4/9 : {{Collectible494}}"
		.. "#{{Player"..wakaba.Enums.Players.RIRA.."}} Respawn as Rira on death"
		.. "#{{Player"..wakaba.Enums.Players.RIRA_B.."}} Tainted Rira simply revives"
		.. "#All effects are retained even after revival"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		itemName = "Caramella Pancake",
		description = ""
		.. "#↑ {{Damage}} +1 Damage"
		.. "#↑ {{Luck}} +1 Luck"
		.. "#Replaces/spawns weapons to Caramella flies"
		.. "#The flies deal {{ColorRicher}}3x{{CR}}/{{WakabaAqua}}{{ColorRira}}1x+Aqua{{CR}}/{{ColorCiel}}5x+Explosion{{CR}}/{{ColorKoron}}1.5x+Petrify{{CR}} damage depending of color"
		.. "#{{Player"..wakaba.Enums.Players.RICHER.."}} Respawn as Richer on death"
		.. "#All effects are retained even after revival"
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
		itemName = "Onsen Towel",
		description = ""
		.. "#↑ {{SoulHeart}} +1 Soul Heart"
		.. "#{{HalfSoulHeart}} 45% Chance to heal half a soul heart every minute"
		.. "{{CR}}",
		lunatic = ""
		.. "#↑ {{SoulHeart}} +1 Soul Heart"
		.. "{{WakabaModLunatic}} {{ColorOrange}}{{HalfSoulHeart}} 10% Chance to heal half a soul heart every minute"
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
		.. "#Activates different effects depending on current room's type"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.LIL_RICHER] = {
		itemName = "Lil Richer",
		description = ""
		.. "#Shoots chasing tears"
		.. "#Deals 2 damage per tick"
		.. "#{{Battery}} Stores extra charge after clearing a room (max 12)"
		.. "#Automatically consumes stored ones for uncharged actives"
		.. "{{CR}}",
		lunatic = ""
		.. "#Shoots chasing tears"
		.. "#Deals 2 damage per tick"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Stores extra charge after clearing a room (max 4)"
		.. "#Automatically consumes stored ones for uncharged actives"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.CUNNING_PAPER] = {
		itemName = "Cunning Paper",
		description = ""
		.. "#{{Card}} Triggers a random card effect each use"
		.. "{{CR}}",
		carBattery = {" a ", " 2 ", "effect", "{{CR}}effects"},
	},
	[wakaba.Enums.Collectibles.TRIAL_STEW] = {
		itemName = "Trial Stew",
		description = "!!! While active:#↑ {{Tears}} +1 Fire rate per stack#↑ {{Damage}} +100% Damage Multiplier#↑ {{Damage}} +25% extra Damage per stack#All actives fully charge on room clears.",
	},
	[wakaba.Enums.Collectibles.SELF_BURNING] = {
		itemName = "Self Burning",
		description = "{{Burning}} Burns YOU on use"
		.. "#{{Burning}} While burning, immune to all enemy damage except for projectiles, but drains a half heart per 20 seconds#Getting hit by projectile cancels burn effect"
		.. "#Blood Donation machine (or similar), or Sacrifice rooms works normally"
		.. "#Can only be used once per floor"
		.. "{{CR}}",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.POW_BLOCK] = {
		itemName = "POW Block",
		description = "{{Bomb}} +6 Bombs#Deals 275 split damage for all ground enemies#{{Bomb}} Costs 2 Bombs",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.MOD_BLOCK] = {
		itemName = "MOd Block",
		description = "{{Bomb}} +6 Bombs#Deals 333 split damage for all floating enemies#{{Bomb}} Costs 2 Bombs",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.SECRET_DOOR] = {
		itemName = "Secret Door",
		description = "Teleports to Starting room"
		.. "#!!! Other effects may occur in certain situations"
		.. "{{CR}}",
		lunatic = "Teleports to Starting room"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Other effects won't occur"
		.. "{{CR}}",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.RIRAS_BRA] = {
		itemName = "Rira's Bra",
		description = "{{Collectible191}} Grants random tear effects for current room#Enemies with status effects take 25% more damage for current room",
		carBattery = {25, 50},
	},
	[wakaba.Enums.Collectibles.RIRAS_COAT] = {
		itemName = "Rira's Coat",
		description = "Activates white fire effect#Installs a white fireplace on Isaac's position",
		carBattery = {" a ", " 2 ", "white fireplace", "{{CR}}white fireplaces"},
	},
	[wakaba.Enums.Collectibles.RIRAS_SWIMSUIT] = {
		itemName = "Rira's Swimsuit",
		description = "{{WakabaAqua}} 10% chance to shoot tears that aquafy enemies#{{Luck}} 100% chance at 38 Luck#{{WakabaAqua}} Aquafied enemies take less damage from red poop/fire/burn/posion, but more damage from laser/explosion/aqua damage#{{WakabaAqua}} Aqua attacks instakill stone enemies",
		LuckFormula = function(luck) return wakaba:StackChance(0.1 + wakaba:LuckBonus(luck, 38, 1 - 0.1), 1) * 100 end
	},
	[wakaba.Enums.Collectibles.RIRAS_BANDAGE] = {
		itemName = "Rira's Bandage",
		description = "!!! On start of the floor:#{{Collectible486}} Activates on-damage effects 6 times#{{Collectible479}} Smelt held trinkets",
	},
	[wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI] = {
		itemName = "Black Bean Mochi",
		description = "{{WakabaZip}} 10% chance to shoot tears that 'zip' enemies"
		.. "#{{Luck}} 100% chance at 16 Luck"
		.. "#{{WakabaZip}} Zipped enemies make explosion on death"
		.. "#Zip explosion does not harm Isaac"
		.. "{{CR}}",
		lunatic = "{{WakabaZip}} 10% chance to shoot 'zip' enemies"
		.. "#{{Luck}} 100% chance at 16 Luck"
		.. "#{{WakabaZip}} Zipped enemies make explosion on death"
		.. "#Zip explosion does not harm Isaac"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Zip explosions no longer inherit Isaac's bomb synergies"
		.. "{{CR}}",
		LuckFormula = function(luck) return wakaba:StackChance(0.1 + wakaba:LuckBonus(luck, 16, 1 - 0.1), 1) * 100 end
	},
	[wakaba.Enums.Collectibles.SAKURA_MONT_BLANC] = {
		itemName = "Sakura Mont Blanc",
		description = "For each enemy killed in the room:"
		.. "#↑ {{Damage}} +0.16 Damage"
		.. "#↑ {{Tears}} +0.67 Fire rate"
		.. "#Caps at 6 kills"
		.. "#{{WakabaAqua}} Killed enemies aquafy nearby enemies"
		.. "#{{WakabaAqua}} Aquafied enemies take less damage from red poop/fire/burn/posion, but more damage from laser/explosion/aqua damage"
		.. "#{{WakabaAqua}} Aqua attacks instakill stone enemies"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.KANAE_LENS] = {
		itemName = "Kanae Lens",
		description = "↑ {{Damage}} x1.65 Damage multiplier#Homing tears from left eye",
		lunatic = "{{WakabaModLunatic}} {{ColorOrange}}{{Damage}} x1.15 Damage multiplier#Homing tears from left eye",
	},
	[wakaba.Enums.Collectibles.RIRAS_BENTO] = {
		itemName = "Rira's Bento",
		description = "↑ {{Heart}} +1 Health#{{HealingRed}} Heals 1 heart#↑ {{Speed}} +0.02 Speed#↑ {{Tears}} +0.2 Fire Rate#↑ {{Damage}} +0.1 Damage for every {{HalfHeart}} Half Heart Isaac has#↑ {{Damage}} +4% Damage Up#↑ {{Range}} +0.25 Range#↑ {{Luck}} +0.2 Luck#!!! All future items will be {{Collectible"..wakaba.Enums.Collectibles.RIRAS_BENTO.."}}Rira's Bento",
	},
	[wakaba.Enums.Collectibles.SAKURA_CAPSULE] = {
		itemName = "Sakura Capsule",
		description = ""
		.. "#↑ +1 Life"
		.. "#{{Collectible127}} Isaac respawns with 4{{Heart}} on death with restarting the entire floor"
		.. "#Spawns 1 of each pickup type per floor until respawn"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE] = {
		itemName = "Chewy Rolly Cake",
		description = "!!! Upon taking damage:"
		.. "#↑ {{Speed}} +0.3 Speed for the room"
		.. "#Clears nearby projectiles"
		.. "#{{Slow}} Slows all enemies in the room permanently"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.LIL_RIRA] = {
		itemName = "Lil Rira",
		description = ""
		.. "#Shoots chasing tears"
		.. "#Deals 2 damage per tick"
		.. "#{{Damage}} +0.05 Damage per used active pips"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	},
	[wakaba.Enums.Collectibles.MAID_DUET] = {
		itemName = "Maid Duet",
		description = ""
		.. "#Pressing {wakaba_md1} to swap current active with pocket active"
		.. "#Will be inserted if pocket active is empty"
		.. "#Can only swap once per room clear"
		.. "#!!! Some active items cannot be inserted into pocket"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.RICHERS_BRA] = {
		itemName = "Richer's Bra",
		description = "↑ Prevents penalties from all damage taken"
		.. "#Activates Silver button automatically"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.RIRAS_UNIFORM] = {
		itemName = "Rira's Uniform",
		description = "{{Timer}} On use:"
		.. "#Stops time for 2 seconds"
		.. "#Greatly increases speed and fire rate for 2 seconds"
		.. "{{CR}}",
		carBattery = "Doubles stat boost",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE] = {
		itemName = "Book of Amplitude",
		description = "{{ArrowGrayRight}} One of effects while held:"
		.. "#↑ {{Damage}} +2 Damage"
		.. "#↑ {{Tears}} +1 Fire rate"
		.. "#↑ {{Speed}} +0.15 Speed"
		.. "#↑ {{Luck}} +2 Luck"
		.. "#On use, or entering new room changes to next effect respectively"
		.. "{{CR}}",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.BUBBLE_BOMBS] = {
		itemName = "Bubble Bombs",
		description = "{{Bomb}} +5 Bombs"
		.. "#{{WakabaAqua}} Isaac's bombs aquafy enemies"
		.. "#{{WakabaAqua}} Aquafied enemies take less damage from red poop/fire/burn/posion, but more damage from laser/explosion/aqua damage"
		.. "#{{WakabaAqua}} Aqua attacks instakill stone enemies"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.CROSS_BOMB] = {
		itemName = "Cross Bomb",
		description = "{{Bomb}} +5 Bombs"
		.. "#Bombs explode in a delayed cross-shaped pattern"
		.. "#Extra explosions deal 10 damage and does not harm Isaac"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.CLEAR_FILE] = {
		itemName = "Clear File",
		description = ""
		.. "#On use, swaps one of Isaac's held passives with nearest passive pedestal"
		.. "#A list will appear for held passive selection"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.KYOUTAROU_LOVER] = {
		itemName = "Kyoutarou Lover",
		description = ""
		.. "#{{Collectible402}} All items are chosen from random item pools"
		.. "#Only certain of Quality items can be spawn"
		.. "#Getting an item changes next Quality that can be spawned"
		.. "#{{Blank}} ({{Quality0}} > {{Quality1}} > {{Quality2}} > {{Quality3}} > {{Quality4}} > {{Quality0}} ...)"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_0] = {
		itemName = "Anna Ribbon",
		description = ""
		.. "#↑ {{Range}} +0.05 Range"
		.. "#!!! Gives random negative effect"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_1] = {
		itemName = "Anna Ribbon",
		description = ""
		.. "#↑ {{Speed}} +0.01 Speed"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_2] = {
		itemName = "Anna Ribbon",
		description = ""
		.. "#↑ {{Luck}} +0.1 Luck"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_3] = {
		itemName = "Anna Ribbon",
		description = ""
		.. "#↑ {{Tears}} +0.1 Tears"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_4] = {
		itemName = "Anna Ribbon",
		description = ""
		.. "#↑ {{Damage}} +0.2 Damage"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.PURIFIER] = {
		itemName = "Purifier",
		description = ""
		.. "#{{Key}} Dissolves pedestal into keys"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		itemName = "Wakaba's Double Dreams",
		description = ""
		.. "#↓ Devil/Angel rooms no longer appear"
		.. "#On use, Change the form of Wakaba's dreams"
		.. "#On collectibles appear, The pool from Wakaba's dream will be selected instead of default pool"
		.. "#{{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}} While held, 8% chance to spawn Wakaba's Dream Card on room clears (caps at 13 tries)"
		.. "{{CR}}",
		lunatic = ""
		.. "#↓ Devil/Angel rooms no longer appear"
		.. "#On use, Change the form of Wakaba's dreams"
		.. "#On collectibles appear, The pool from Wakaba's dream will be selected instead of default pool"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}} While held, 1% chance to spawn Wakaba's Dream Card on room clears (caps at 15 tries)"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.LEVIATHAN .. "," .. EID.TRANSFORMATION.BOOKWORM,
		belial = "↑ +4%p chance to drop {{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}}Wakaba's Dream Card while held. No additional effect on use",
		void = "Spawns {{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}}Wakaba's Dream Card when voided",
		carBattery = "No effect",
	},
	[wakaba.Enums.Collectibles.STICKY_NOTE] = {
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
wakaba.descriptions[desclang].bookofshiori = {
	[CollectibleType.COLLECTIBLE_BIBLE] = {
		primary = "{{Damage}} 1.2x Damage multiplier and {{Collectible313}}Holy Mantle shield for current room",
		secondary = "{{Collectible331}} Tears have aura, does not homing",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] = {
		primary = "{{Damage}} Additional +1.5 Damage up for current room",
		secondary = "{{Collectible462}} Tears have Eye of Belial effect",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_NECRONOMICON] = {
		primary = "{{Fear}} Extra fear damage to enemies",
		secondary = "{{Collectible634}} Tears have chance to spawn Purgatory ghosts",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS] = {
		primary = "Extra shield duration",
		secondary = "{{Collectible213}} Tears can block enemy projectiles",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK] = {
		primary = "Explosions deal double damage for current room",
		secondary = "Tears can explode and Immune to explosions",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS] = {
		primary = "{{Collectible526}} Spawns 2 Lil Harbringers for current floor",
		secondary = "{{Collectible374}} Chance to shoot holy tears, which spawn a beam of light on hit",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SIN] = {
		primary = "50% chance to spawn extra pickup, or a friendly sin miniboss",
		secondary = "Killed enemies has a chance to drop pickups",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_MONSTER_MANUAL] = {
		primary = "Extra familiar spawn for current floor",
		secondary = "Familiars deal 3x Damage",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_TELEPATHY_BOOK] = {
		primary = "{{Collectible369}} Tears can fly over walls for current room",
		secondary = "{{Collectible3}} Homing tears",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS] = {
		primary = "Fully reveals the map and removes {{WakabaAntiCurseDarkness}}Curse of Darkness and {{WakabaAntiCurseLost}}Curse of the Lost",
		secondary = "{{Collectible618}} Chance to shoot tears that mark enemies",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_SATANIC_BIBLE] = {
		primary = "{{Damage}} Additional +1 Damage up for current floor",
		secondary = "{{Collectible259}} Chance to shoot fear tears",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD] = {
		primary = "Spawns additional friendly Bony",
		secondary = "{{Collectible237}} Scythe tears",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_LEMEGETON] = {
		primary = "Chance to absorb random Lemegeton wisp into item",
		secondary = "Chance to heal item wisps when enemies are killed",
		description = "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		primary = "Select Enemy to charm permanently#Requires Keys{{Key}} (+ Bombs{{Bomb}} for bosses) to charm",
		secondary = "",
		description = "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		primary = "",
		secondary = "{{Collectible453}} Tears shatter into 1-3 small bone shards upon hitting anything",
		description = "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		primary = "Ignores Enemy's armor when not moving while active",
		secondary = "",
		description = "{{ShioriSecDel}} !!! Removes secondary Shiori bonus",
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		primary = "{{Rune}} Grants extra Rune",
		secondary = "{{Rune}} Chance to drop a rune when enemies are killed",
		description = "",
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		primary = "Damage taken for Minissac is greatly reduced",
		secondary = "Minissac Copies Most of Isaac's tear effects",
		description = "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		primary = "Prevents all enemy projectiles for extra 2 seconds",
		secondary = "",
		description = "{{ShioriSecDel}} !!! Removes secondary Shiori bonus",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		primary = "Prevents death one more time",
		secondary = "{{Collectible579}} Gives Temporary Black Spirit Sword. The Scythe tears will be fired instead of sword projectile",
		description = "",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		primary = "All enemies targeting Isaac will also be slowed while Isaac is invisible",
		secondary = "",
		description = "",
	},
}
wakaba.descriptions[desclang].epiphany_golden = {
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		isReplace = true,
		description = ""
		.. "#{{Card"..Card.CARD_SOUL_ISAAC.."}} Invokes Soul of Isaac effect for {{ColorGold}}4 times{{CR}}"
		.. "#Rerolled items cycle for {{ColorGold}}intermediate{{CR}} speed"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.SYRUP] = {
		isReplace = true,
		description = ""
		.. "#!!! While Held:"
		.. "#↑ {{Speed}} {{ColorGold}}+10%{{CR}} Speed"
		.. "#↑ {{Range}} +{{ColorGold}}6{{CR}} Range"
		.. "#↑ {{Damage}} +{{ColorGold}}3{{CR}} Damage"
		.. "#Flight, {{ColorGold}}Spectral tears{{CR}}"
		.. "#!!! Does not have on use effect"
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		isReplace = false,
		description = "{{ColorGold}}Charge rate is doubled",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		isReplace = false,
		description = "{{Card14}} {{ColorGold}}Also deals 40 damage to all enemies",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_TRAUMA] = {
		isReplace = true,
		description = ""
		.. "#Detonate Isaac's tears currently on the screen, causing each one to explode (Max 15)"
		.. "#Exploded tear shots {{ColorGold}}causes Giga Bomb explosions"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		isReplace = true,
		description = ""
		.. "#{{ColorGold}}On use, Spawns 11 Hungry Souls that deals Isaac's Damage"
		.. "#If damage is lethal while held, Isaac turns into Fallen Angel, and gives 6 Black Hearts"
		.. "#!!! {{ColorSilver}}After Isaac turning into Fallen Angel:"
		.. "#{{ColorGold}}Can shoot tears even after revival"
		.. "#↑ {{Damage}} {{ColorGold}}+100% Damage Multiplier"
		.. "#!!! {{ColorYellow}}Isaac can no longer swap active items{{ColorReset}}"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		isReplace = false,
		description = "{{ColorGold}}Grants {{Tears}}small fire rate bonus per erased projectiles that slowly fades away",
	},
	[wakaba.Enums.Collectibles.BEETLEJUICE] = {
		isReplace = false,
		description = "{{ColorGold}}Spawns Golden Pill instead",
	},
	[wakaba.Enums.Collectibles.POWER_BOMB] = {
		isReplace = false,
		description = "{{ColorGold}}Turns room into gold, doubles damage, and makes all pickups available without options",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		isReplace = false,
		description = "{{ColorGold}}Also opens quest-related doors",
	},
	[wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		isReplace = false,
		description = "{{ColorGold}}While in shift, {{Collectible202}}Touching enemies turns them gold",
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		isReplace = false,
		description = "{{ColorGold}}Smelted trinkets are golden",
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		isReplace = false,
		description = "{{ColorGold}}Spawns Golden Clot instead",
	},
	[wakaba.Enums.Collectibles.BALANCE] = {
		isReplace = false,
		description = "{{Collectible555}} {{ColorGold}}Grants +1.2 Damage up for the current room if coins are spent",
	},
	[wakaba.Enums.Collectibles.RICHERS_FLIPPER] = {
		isReplace = false,
		description = "{{ColorGold}}Converts item pedestals into Golden variation",
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		isReplace = false,
		description = "{{ColorGold}}Prevents Quality{{Quality0}} to be spawned",
	},
}

wakaba.descriptions[desclang].trinkets = {
	[wakaba.Enums.Trinkets.BRING_ME_THERE] = {
		itemName = "Bring me there",
		description = ""
		.. "#↑ {{Tears}} +1.5 Fire Rate"
		.. "#While held, entering Boss room of Mausoleum/Gehenna II makes Dad's Note being appear instead of Mom"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.BITCOIN] = {
		itemName = "Bitcoin II",
		description = ""
		.. "#Randomize consumable counters and stats"
		.. "#The range for consumables can be all back to 0 to full of 999"
		.. "#!!! Will be removed once dropped!"
		.. "#!!! Will no longer randomize consumables when smelted"
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
		.. "#{{Card"..Card.CARD_CHAOS.."}} Chaos card can damage Delirium, and The Beast (339 damage per tick)"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.DELIMITER] = {
		itemName = "Delimiter",
		description = ""
		.. "#!!! When entering new room :"
		.. "#Destroys Tinted, and Fools Gold rocks"
		.. "#Turns Pillars, Metal blocks, Spiked rocks into normal rocks"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	},
	[wakaba.Enums.Trinkets.RANGE_OS] = {
		itemName = "Range OS",
		description = ""
		.. "#↓ {{Range}} -60% Range Multiplier"
		.. "#{{Range}} Limit Range to 6.5"
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
		.. "#Also works while smelted"
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
	[wakaba.Enums.Trinkets.KUROMI_CARD] = {
		itemName = "Kuromi Card",
		description = ""
		.. "#Using an active item will not consume its charge or item.#!!! 90% chance to remove the trinket on use!"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.ETERNITY_COOKIE] = {
		itemName = "Eternity Cookie",
		description = ""
		.. "#Timed pickups no longer disappear"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.REPORT_CARD] = {
		itemName = "Richer's Report Card",
		description = ""
		.. "#↑ {{Luck}} +5 Luck"
		.. "#↓ Taking damage reduces {{Luck}} -0.5 Luck (does not exceed minimum)"
		.. "#Reduced Luck is restored on new floor"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.RABBIT_PILLOW] = {
		itemName = "Rabbit Pillow",
		description = ""
		.. "Allows to use donation mechanics while in White fire state."
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG] = {
		itemName = "Caramella Candy Bag",
		description = ""
		.. "Entering a hostile room spawns one of followings:"
		.. "#{{Trinket"..wakaba.Enums.Trinkets.CANDY_OF_RICHER.."}} Lavender fly that deals 3x of Isaac's Damage"
		.. "#{{Trinket"..wakaba.Enums.Trinkets.CANDY_OF_RIRA.."}} Pink fly that deals 1x of Isaac's Damage and inflicts Aqua"
		.. "#{{Trinket"..wakaba.Enums.Trinkets.CANDY_OF_CIEL.."}} Lavender fly that deals 5x of Isaac's Damage with Explosion"
		.. "#{{Trinket"..wakaba.Enums.Trinkets.CANDY_OF_KORON.."}} Gray fly that deals 1.5x of Isaac's Damage and inflicts Petrify"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_RICHER] = {
		itemName = "Candy of Richer",
		description = ""
		.. "Entering a hostile room spawns 2 Richer flies"
		.. "#The fly deals 4x Isaac's damage"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_RIRA] = {
		itemName = "Candy of Rira",
		description = ""
		.. "Entering a hostile room spawns 2 Rira flies"
		.. "#The fly deals 4x Isaac's aqua damage"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_CIEL] = {
		itemName = "Candy of Ciel",
		description = ""
		.. "Entering a hostile room spawns an exploding Ciel fly"
		.. "#The fly deals 10x Isaac's explosive damage"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_KORON] = {
		itemName = "Candy of Koron",
		description = ""
		.. "Entering a hostile room spawns 2 Koron flies"
		.. "#The fly deals 4x Isaac's freezing damage"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.PINK_FORK] = {
		itemName = "Pink Fork",
		description = ""
		.. "#{{WakabaModRgon}} {{ColorOrange}}REPENTOGON ONLY!{{CR}} REPORT TO DEV IF YOU FOUND THIS ITEM OUTSIDE FROM RGON"
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA] = {
		itemName = "Sigil of Kaguya",
		description = ""
		.. "{{Collectible160}} 16% chance to Activates Crack the Sky effect per 15 seconds"
		.. "#{{Luck}} 100% chance at 34 Luck"
		.. "#Activation will be delayed in cleared rooms"
		.. "{{CR}}",
		LuckFormula = function(luck) return wakaba:StackChance(0.16 + wakaba:LuckBonus(luck, 34, 1 - 0.16), 1) * 100 end
	},


	---------------------
	-- Cursed Trinkets --
	---------------------
	[wakaba.Enums.Trinkets.CORRUPTED_CLOVER] = {
		itemName = "Corrupted Clover",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.DARK_PENDANT] = {
		itemName = "Dark Pendant",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.BROKEN_NECKLACE] = {
		itemName = "Broken Necklace",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.LEAF_NEEDLE] = {
		itemName = "Leaf Needle",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.RICHERS_HAIR] = {
		itemName = "Richer's Hair",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.RIRAS_HAIR] = {
		itemName = "Rira's Hair",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.SPY_EYE] = {
		itemName = "Spy Eye",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.FADED_MARK] = {
		itemName = "Faded Mark",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.NEVERLASTING_BUNNY] = {
		itemName = "Neverlasting Bunny",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.RIBBON_CAGE] = {
		itemName = "Ribbon Cage",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.RIRAS_WORST_NIGHTMARE] = {
		itemName = "Rira's Worst Nightmare",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.MASKED_SHOVEL] = {
		itemName = "Masked Shovel",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.BROKEN_WATCH_2] = {
		itemName = "Broken Watch 2",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.ROUND_AND_ROUND] = {
		itemName = "Round and Round",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.GEHENNA_ROCK] = {
		itemName = "Gehenna Rock",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.BROKEN_MURASAME] = {
		itemName = "Broken Murasame",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.LUNATIC_CRYSTAL] = {
		itemName = "Lunatic Crystal",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.TORN_PAPER_2] = {
		itemName = "Torn Paper 2",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.MINI_TORIZO] = {
		itemName = "Mini Torizo",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.GRENADE_D20] = {
		itemName = "Grenade D20",
		description = ""
		.. ""
		.. "{{CR}}",
	},
	[wakaba.Enums.Trinkets.WAKABA_SIREN] = {
		itemName = "Wakaba Siren",
		description = ""
		.. ""
		.. "{{CR}}",
	},

}
wakaba.descriptions[desclang].goldtrinkets = {
	[wakaba.Enums.Trinkets.CLOVER] = { "↑ Further increase chance for Lucky Penny" },
	[wakaba.Enums.Trinkets.HARD_BOOK] = { "drop random book", "drop 2 books", "drop 3 books" },
	[wakaba.Enums.Trinkets.STAR_REVERSAL] = { "{{Planetarium}}Planetarium item", "2 {{Planetarium}}Planetarium items"},
	[wakaba.Enums.Trinkets.ETERNITY_COOKIE] = { "↑ Removes all selection from pickups" },
	[wakaba.Enums.Trinkets.MAGNET_HEAVEN] = { "{{Magnetize}} Magnetize all enemies for 5 seconds when entering a new room" },
	[wakaba.Enums.Trinkets.CANDY_OF_RICHER] = { "2 Richer flies", "3 Richer flies", "4 Richer flies" },
	[wakaba.Enums.Trinkets.CANDY_OF_RIRA] = { "2 Rira flies", "3 Rira flies", "4 Rira flies" },
	[wakaba.Enums.Trinkets.CANDY_OF_CIEL] = { "an exploding Ciel fly", "2 exploding Ciel flies", "3 exploding Ciel flies" },
	[wakaba.Enums.Trinkets.CANDY_OF_KORON] = { "2 Koron flies", "3 Koron flies", "4 Koron flies" },
}
wakaba.descriptions[desclang].cards = {
	[wakaba.Enums.Cards.CARD_CRANE_CARD] = {
		itemName = "Crane Card",
		description = "{{CraneGame}} Spawns a Crane Game machine",
		tarot = {"{{CraneGame}} Spawns {{ColorShinyPurple}}2{{CR}} Crane Game machines"},
		mimiccharge = 5,
	},
	[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = {
		itemName = "Confessional Card",
		description = "{{Confessional}} Spawns a Confessional Booth",
		tarot = {"{{Confessional}} Spawns {{ColorShinyPurple}}2{{CR}} Confessional Booths"},
		mimiccharge = 4,
	},
	[wakaba.Enums.Cards.CARD_BLACK_JOKER] = {
		itemName = "Black Joker",
		description = "{{DevilChance}} While held, prevents Angel room to be spawned #{{DevilRoom}} Upon use, Teleports the player to the Devil room",
		mimiccharge = 2,
	},
	[wakaba.Enums.Cards.CARD_WHITE_JOKER] = {
		itemName = "White Joker",
		description = "{{AngelChance}} While held, prevents Devil room to be spawned #{{AngelRoom}} Upon use, Teleports the player to the Angel room",
		mimiccharge = 2,
	},
	[wakaba.Enums.Cards.CARD_COLOR_JOKER] = {
		itemName = "Color Joker",
		description = "{{BrokenHeart}} Sets Broken Heart counts to 6 #Spawns 3 Collectible items and 8 Card/Rune/Soul Stones",
		lunatic = "{{WakabaModLunatic}} {{BrokenHeart}} {{ColorOrange}}Adds 6 Broken Hearts#Spawns 3 Collectible items and 8 Card/Rune/Soul Stones",
		mimiccharge = 6,
	},
	[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = {
		itemName = "Queen of Spades",
		description = "{{Key}} Spawns 3~26 keys",
		lunatic = "{{WakabaModLunatic}} {{ColorOrange}}{{Key}}Spawns 1~6 keys",
		mimiccharge = 8,
	},
	[wakaba.Enums.Cards.CARD_DREAM_CARD] = {
		itemName = "Wakaba's Dream Card",
		description = "Spawns a random collectible item",
		mimiccharge = 8,
	},
	[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = {
		itemName = "Unknown Bookmark",
		description = "Activates a random book effect#!!! Following books can be activated:",
		tarot = "Activates 2 random book effects from above",
		mimiccharge = 1,
	},
	[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = {
		itemName = "Return Token",
		description = "{{Collectible636}} Invokes R Key effect#Brings you back to the first floor of a new run#Items, stat boosts and pickups stay intact#{{Timer}} Resets game timer#Removes all of Isaac's consumables {{ColorRed}}including health{{CR}}",
	},
	[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = {
		itemName = "Minerva Ticket",
		description = "{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} Activates Minerva's Aura for current room#{{Blank}} ({{Damage}}-0.5/{{Tears}}+0.5x2.3/Homing tears)",
		tarot = "Activates the effect twice",
		mimiccharge = 3,
	},
	[wakaba.Enums.Cards.SOUL_WAKABA] = {
		itemName = "Soul of Wakaba",
		description = "{{SoulHeart}} +1 Soul Heart#{{AngelRoom}} Creates new Angel room on current floor#{{AngelRoom}} Spawns an Angel room item for sale if no rooms are available",
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
		description = "{{HealingRed}} Heals 2 Red Hearts#Activates Random Book of Shiori tear effect",
		mimiccharge = 6,
		isrune = true,
	},
	[wakaba.Enums.Cards.SOUL_TSUKASA] = {
		itemName = "Soul of Tsukasa",
		description = "Hangs a sword above Isaac's head, which doubles all pedestal items#Does not double Shop, Chest, or Devil deal items#{{Warning}} After taking any damage, the sword has a chance to remove half of Isaac's items and turns into random character every frame",
		mimiccharge = 12,
		isrune = true,
	},
	[wakaba.Enums.Cards.SOUL_RICHER] = {
		itemName = "Soul of Richer",
		description = "{{Collectible712}} Grants 1 ~ 6 Lemegeton Wisps ({{Collectible263}} : 1 ~ 3)#All wisps are guaranteed to be Quality{{Quality2}}+",
		mimiccharge = 6,
		isrune = true,
	},
	[wakaba.Enums.Cards.CARD_VALUT_RIFT] = {
		itemName = "Valut Rift",
		description = "{{ShioriValut}} Spawns a Shiori's Valut#{{ShioriValut}} The valut contains a blue colored collectible that requires several keys.#Low chance to spawn random valut that containes other themed item",
		tarot = {"{{ShioriValut}} Spawns {{ColorShinyPurple}}2{{CR}} Shiori's Valuts#{{ShioriValut}} The valut contains a blue colored collectible that requires several keys#Low chance to spawn random valut that containes other themed item"},
		mimiccharge = 6,
	},
	[wakaba.Enums.Cards.CARD_TRIAL_STEW] = {
		itemName = "Trial Stew",
		description = "Removes all health and Holy Mantle shields#Adds 8 stacks of effect for:#↑ {{Tears}} +1 Fire rate per stack#↑ {{Damage}} +100% Damage Multiplier#↑ {{Damage}} +25% extra Damage per stack#All actives fully charge, decreases a stack on room clears.",
		tarot = {8, 11},
		mimiccharge = 8,
	},
	[wakaba.Enums.Cards.CARD_RICHER_TICKET] = {
		itemName = "Richer Ticket",
		description = "{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}} Grants a random combinations current room",
		mimiccharge = 8,
	},
	[wakaba.Enums.Cards.CARD_RIRA_TICKET] = {
		itemName = "Rira Ticket",
		description = "{{BrokenHeart}}Recovers 1 Broken Heart into {{EmptyBoneHeart}}or{{SoulHeart}}#{{Collectible479}} Smelt current held trinkets#{{HealingRed}} Heals 1 Red Heart if no trinkets and Broken Hearts",
		tarot = {"{{BrokenHeart}}Recovers 1 Broken Heart into {{ColorShinyPurple}}({{EmptyBoneHeart}}or{{SoulHeart}}+{{Heart}})#{{Collectible479}} Smelt current held trinkets#{{HealingRed}} Heals {{ColorShinyPurple}}2{{CR}} Red Heart if no trinkets and Broken Hearts"},
		mimiccharge = 6,
	},
	[wakaba.Enums.Cards.CARD_FLIP] = {
		itemName = "Flip Card",
		description = "{{Collectible711}} Holding, or using the card grants Flip effect#Entering a room with item pedestals displays a ghostly second item on the pedestals#Using the item flips the real and ghostly item",
		mimiccharge = 4,
	},
	[wakaba.Enums.Cards.SOUL_RIRA] = {
		itemName = "Soul of Rira",
		description = "{{AquaTrinket}} Spawns 3 Aqua trinkets ({{Collectible263}} : 1)#{{Blank}} (ignores unlock status)",
		mimiccharge = 6,
		isrune = true,
	},
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
		description = "↓ {{Damage}} -6% Damage Multiplier",
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
		itemNameAfter = "A pill for troll",
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
		description = "{{Collectible118}} Grants Brimstone for the current room",
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
		description = "{{Collectible498}} Guarantees both an Angel and Devil room for current floor#Entering one makes the other disappear",
		mimiccharge = 6,
		class = "3+",
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
	[wakaba.Enums.Pills.HEAVY_MASCARA] = {
		itemName = "Heavy Mascara",
		description = "{{CurseBlind}} Curse of the Blind effect for the floor",
		mimiccharge = 4,
		class = "3-",
	},
}
wakaba.descriptions[desclang].horsepills = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP] = {
		tostring(wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP),
		"Damage Multiplier Up",
		"↑ {{Damage}} +16% Damage Multiplier",
	},
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = {
		tostring(wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN),
		"Damage Multiplier Down",
		"↓ {{Damage}} -12% Damage Multiplier",
	},
	[wakaba.Enums.Pills.ALL_STATS_UP] = {
		tostring(wakaba.Enums.Pills.ALL_STATS_UP),
		"All Stats Up",
		"↑ {{Damage}} +0.5 Damage#↑ {{Tears}} +0.4 Tears#↑ {{Speed}} +0.24 Speed#↑ {{Range}} +0.8 Range#↑ {{Shotspeed}} +0.08 Shot Speed#↑ {{Luck}} +2 Luck#",
	},
	[wakaba.Enums.Pills.ALL_STATS_DOWN] = {
		tostring(wakaba.Enums.Pills.ALL_STATS_DOWN),
		"All Stats Down",
		"↓ {{Damage}} -0.2 Damage#↓ {{Tears}} -0.16 Tears#↓ {{Speed}} -0.18 Speed#↓ {{Range}} -0.5 Range#↓ {{Shotspeed}} -0.06 Shot Speed#↓ {{Luck}} -2 Luck#",
	},
	[wakaba.Enums.Pills.TROLLED] = {
		tostring(wakaba.Enums.Pills.TROLLED),
		"Trolled!",
		"{{ErrorRoom}} Teleports to I AM ERROR room#{{Collectible721}} Spawns Glitched items on ???/Home#Removes a Broken Heart",
	},
	[wakaba.Enums.Pills.TO_THE_START] = {
		tostring(wakaba.Enums.Pills.TO_THE_START),
		"To the Start!",
		"Teleports to Starting room on the floor#{{HealingRed}} Heals 1 Heart#Removes a Broken Heart",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = {
		tostring(wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2),
		"Explosive Diarrehea 2!",
		"Spawns 2 troll Brimstone swirls at Isaac's position#{{Collectible293}} Shoot brimstone lasers in all 4 directions",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT] = {
		tostring(wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT),
		"Explosive Diarrehea 2?",
		"{{Card88}} Activates {{Collectible441}}Mega Blast for 7.5 seconds",
	},
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = {
		tostring(wakaba.Enums.Pills.SOCIAL_DISTANCE),
		"Social Distance",
		"Closes Devil/Angel room for current floor#↓ {{AngelDevilChance}} Decreases Devil/Angel room chance for later floors",
	},
	[wakaba.Enums.Pills.DUALITY_ORDERS] = {
		tostring(wakaba.Enums.Pills.DUALITY_ORDERS),
		"Duality Orders",
		"{{Collectible498}} Guarantees both an Angel and Devil room for current floor#Entering one makes the other disappear#Spawns an each of {{DevilRoom}}Devil/{{AngelRoom}}Angel room items#Both items can be taken",
	},
	[wakaba.Enums.Pills.PRIEST_BLESSING] = {
		tostring(wakaba.Enums.Pills.PRIEST_BLESSING),
		"Priest's Blessing",
		"{{Card51}} Grants the Holy Mantle effect#(Prevents damage once)#Effect lasts until damage is taken",
	},
	[wakaba.Enums.Pills.UNHOLY_CURSE] = {
		tostring(wakaba.Enums.Pills.UNHOLY_CURSE),
		"Unholy Curse",
		"Breaks 2 stacks from Holy Mantle shield#Does nothing if Isaac does not have Holy Mantle shields",
	},
	[wakaba.Enums.Pills.HEAVY_MASCARA] = {
		tostring(wakaba.Enums.Pills.HEAVY_MASCARA),
		"Heavy Mascara",
		"{{CurseBlind}} Curse of the Blind effect for the floor#{{CurseUnknown}} Curse of the Unknown effect for the floor",
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
		name = "Shiori's Valut",
		description = ""
		.. ""
	},
	{
		type = EntityType.ENTITY_PICKUP,
		variant = wakaba.Enums.Pickups.CLOVER_CHEST,
		subtype = wakaba.ChestSubType.CLOSED,
		name = "Wakaba's Clover Chest",
		description = ""
		.. "{{Key}} Requires a key to open"
		.. "#{{Warning}} Opening the chest may contain one of followings :"
		.. "#{{Coin}} {{ColorSilver}}Lucky Coin, Nickel, or Dime"
		.. "#{{Luck}} {{ColorSilver}}Clover chest pool collectible"
	},
}
wakaba.descriptions[desclang].richeruniform = {
	default = "#{{Room}} {{ColorCyan}}Default#Activates restock machine once",
	[u.DEFAULT] = "#{{Room}} {{ColorCyan}}Normal Room#{{Collectible285}} Devolves all enemies in the room 2 times#20% Armor Piercing damage for bosses",
	[u.SHOP] = "#{{Shop}} {{ColorCyan}}Shop#{{Collectible64}} Shop items cost 75% less for current room",
	[u.ERROR] = "#{{ErrorRoom}} {{ColorCyan}}I AM ERROR#Brings all collectibles and pickups in the room to starting room",
	[u.TREASURE] = "#{{TreasureRoom}} {{ColorCyan}}Treasure Room#{{Card90}} Rerolls pedestals and pickups in the current room#The rerolled items come from random item pools",
	[u.BOSS] = "#{{BossRoom}} {{ColorCyan}}Boss Room#{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} {{Damage}}-0.5/{{Tears}}+0.5x2.3/Homing tears for current room",
	[u.MINIBOSS] = "#{{BossRoom}} {{ColorCyan}}Miniboss Room#{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} {{Damage}}-0.5/{{Tears}}+0.5x2.3/Homing tears for current room",
	[u.SECRET] = "#{{SecretRoom}} {{ColorCyan}}Secret Room#{{Collectible609}} Rerolls all pedestal items in the room#Has a 25% chance to delete items instead of rerolling them",
	[u.SUPERSECRET] = "#{{SuperSecretRoom}} {{ColorCyan}}Super Secret Room#{{Collectible609}} Rerolls all pedestal items in the room#Has a 25% chance to delete items instead of rerolling them",
	[u.ARCADE] = "#{{ArcadeRoom}} {{ColorCyan}}Arcade Room#Spawns a {{Slotmachine}} Slot Machine or {{FortuneTeller}} Fortune Machine#{{Collectible46}} Better chance to win while gambling for current room",
	[u.CURSE] = "#{{CursedRoom}} {{ColorCyan}}Curse Room#{{RedChest}}	Spawns 2 red chests#!!! Takes 1 full heart of damage",
	[u.CHALLENGE] = "#{{ChallengeRoom}} {{ColorCyan}}Challenge Room#{{Collectible347}} Duplicates any pedestals and consumables in the current room",
	[u.LIBRARY] = "#{{Library}} {{ColorCyan}}Library#{{Card53}} Spawns 3 cards",
	[u.SACRIFICE] = "#{{SacrificeRoom}} {{ColorCyan}}Sacrifice Room#Sets next sacrifice counter into 6th ({{AngelChance}}33%/{{Chest}}67%)#!!! Takes 1 full heart of damage if counter is < 6",
	[u.DEVIL] = "#{{DevilRoom}} {{ColorCyan}}Devil Room#Spawns Quality {{Quality3}} item that costs 2 heart containers#The spawned item disappears on room exit",
	[u.ANGEL] = "#{{AngelRoom}} {{ColorCyan}}Angel Room#Heals {{HalfHeart}} + {{HalfSoulHeart}}#{{CurseCursed}} Protects curse from being applied for one time",
	--[u.DUNGEON] = "",
	[u.BOSSRUSH] = "#{{BossRushRoom}} {{ColorCyan}}Boss Rush#All choices are removed, resulting all items can be collected",
	[u.ISAACS] = "#{{IsaacsRoom}} {{ColorCyan}}Bedroom#{{Card92}} Permanently grants a random familiar",
	[u.BARREN] = "#{{BarrenRoom}} {{ColorCyan}}Bedroom#{{Collectible"..wakaba.Enums.Collectibles.MICRO_DOPPELGANGER.."}} Spawns 12 tiny Isaac familiars",
	[u.CHEST] = "#{{ChestRoom}} {{ColorCyan}}Valut Room#{{EternalChest}} Spanws a Eternal chest and 3 Golden chests",
	[u.DICE] = "#{{DiceRoom}} {{ColorCyan}}Dice Room#{{Card78}} Spawns Cracked Key",
	[u.BLACK_MARKET] = "#{{LadderRoom}} {{ColorCyan}}Black Market#{{Collectible521}} Makes one random item for sale free",
	[u.GREED_EXIT] = "#{{MinecartRoom}} {{ColorCyan}}Greed Exit#{{Coin}} Grants 50% of Isaac's number of coins",
	[u.PLANETARIUM] = "#{{Planetarium}} {{ColorCyan}}Planetarium#{{Collectible105}} Rerolls all pedestal items in the room#{{Collectible589}} Spawns Luna Light",

	[u.START_ROOM] = "#{{RedRoom}} {{ColorCyan}}Starting Room#Spawns one of portals from Card Reading",
	[u.BEAST] = "#{{Beast}} {{ColorCyan}}Beast Room#!!! ONE TIME USE#{{Collectible633}} Grants Dogma once more ({{Heart}}min6/{{Damage}}+2/{{HolyMantle}})",
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
		.. "#Weapons are invisible and deal less damage enemies for a short time"
		.. "#Deals 2x damage to enemies after 4 tiles"
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
		.. "#Donation mechanics can be used even with Lost Curse state"
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
		.. "#{{Collectible357}} Starts with : Box of Friends"
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
		.. "#{{Collectible"..wakaba.Enums.Collectibles.STICKY_NOTE.."}} {{GoldenKey}}Unique ability : Eden's Sticky Note(w98: Complete Hyper Random)"
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
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		_fromCharDesc = true,
	},
	-- shiori
	[wakaba.Enums.Players.SHIORI] = {
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		_fromCharDesc = true,
	},
	-- tsukasa
	[wakaba.Enums.Players.TSUKASA] = {
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		_fromCharDesc = true,
	},
	-- richer
	[wakaba.Enums.Players.RICHER] = {
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.RICHER_B] = {
		_fromCharDesc = true,
	},
	-- rira
	[wakaba.Enums.Players.RIRA] = {
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.RIRA_B] = {
		_fromCharDesc = true,
	},

}

wakaba.descriptions[desclang].conditionals = {}
wakaba.descriptions[desclang].conditionals.collectibles = {
	[CollectibleType.COLLECTIBLE_URANUS] = {
		desc = "{{Player"..wakaba.Enums.Players.WAKABA.."}} ↑ {{Damage}} +50% Damage Multiplier#{{{Player"..wakaba.Enums.Players.WAKABA.."}} {ColorWakabaBless}}Armor-Piercing Tears",
		func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.WAKABA) end,
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		desc = "{{Player"..wakaba.Enums.Players.WAKABA_B.."}} ↑ {{Damage}} Damage +4#{{Player"..wakaba.Enums.Players.WAKABA_B.."}} ↓ {{ColorWakabaNemesis}} Luck Bonuses are not applied",
		func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.WAKABA_B) end,
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		{
			desc = {"Coins will be", "1 Coin will be"},
			func = EID.IsHardMode,
			type = "findReplace",
			modifierText = "Hard Mode",
		},
	},
	[wakaba.Enums.Collectibles.WAKABAS_HAIRPIN] = {
		desc = "{{Player"..wakaba.Enums.Players.WAKABA_B.."}} ↑ {{Damage}} Damage +0.35 per pill consumed#{{Player"..wakaba.Enums.Players.WAKABA_B.."}} ↓ {{ColorWakabaNemesis}} Luck Bonuses are not applied",
		func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.WAKABA_B) end,
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		desc = "{{Player"..wakaba.Enums.Players.SHIORI.."}} Spawns 3 tiny Isaac familiars",
		func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.SHIORI, true) end,
	},
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		{
			desc = "{{Player"..wakaba.Enums.Players.WAKABA.."}} ↑{{Tears}} -25% Tear Delay",
			func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.WAKABA) end,
			modifierText = "Wakaba",
		},
		{
			desc = "{{Player31}} No mantle shields",
			func = function() return EID:ConditionalCharCheck(PlayerType.PLAYER_THELOST_B) end,
			modifierText = "Tainted Lost",
		},
	},
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		{
			desc = "{{Player"..wakaba.Enums.Players.RICHER_B.."}} Absorb selected Wisp#{{Player"..wakaba.Enums.Players.RICHER_B.."}} Can be change selection by {{ButtonRT}}",
			func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.RICHER_B) end,
			modifierText = "Tainted Richer",
		},
	},
	[wakaba.Enums.Collectibles.CONCENTRATION] = {
		desc = "{{Player"..wakaba.Enums.Players.TSUKASA.."}} Repeating concentration reqires room clears, can't concentrate on 60+ counts",
		func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.TSUKASA) end,
	},
	[wakaba.Enums.Collectibles.JAR_OF_CLOVER] = {
		desc = "{{Player"..wakaba.Enums.Players.WAKABA_B.."}} Tainted Wakaba simply revives",
		func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.WAKABA_B) end,
	},
	[wakaba.Enums.Collectibles.BUNNY_PARFAIT] = {
		desc = "{{Player"..wakaba.Enums.Players.RIRA_B.."}} Tainted Rira simply revives",
		func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.RIRA_B) end,
	},
	[wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER_B.."}} Tainted Richer simply revives",
		func = function() return EID:ConditionalCharCheck(wakaba.Enums.Players.RICHER_B) end,
	},
	[wakaba.Enums.Collectibles.SWEETS_CATALOG] = {
		type = "replaceAll",
		desc = "{{WakabaMod}} Checks nearby collectible's quality#{{WakabaMod}} If matched, take it, otherwise, it disappears",
		func = function() return wakaba:EIDCond_IsChallenge(wakaba.challenges.CHALLENGE_EVEN) end,
	},
	-- HIDDEN DESCRIPTIONS
	[wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2] = {
		desc = "{{WakabaModHidden}} {{ColorGray}}Replaces all Bomb spawns with a {{Coin}}/{{GrabBag}}/{{Heart}}/{{Key}}/{{Battery}}/{{Pill}}/{{Card}}/{{Trinket}}",
		func = wakaba.EIDCond_IsHiddenEnabled,
	},
	[wakaba.Enums.Collectibles.MINERVA_AURA] = {
		desc = "{{WakabaModHidden}} {{ColorGray}}25% chance to block damage",
		func = wakaba.EIDCond_IsHiddenEnabled,
	},
	[wakaba.Enums.Collectibles.NASA_LOVER] = {
		desc = "{{WakabaModHidden}} {{Collectible565}}{{ColorGray}}Makes Blood Puppy friendly",
		func = wakaba.EIDCond_IsHiddenEnabled,
	},
	[wakaba.Enums.Collectibles.DOUBLE_INVADER] = {
		desc = "{{WakabaModHidden}} {{ColorGray}}Multiple invincible Death's heads appear in major boss rooms",
		func = wakaba.EIDCond_IsHiddenEnabled,
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		desc = "{{WakabaModHidden}} {{Collectible628}} {{ColorGray}}0.5% chance to teleport Isaac to Death Certificate area instead ({{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}} 4.5% with Book of Shiori)",
		func = wakaba.EIDCond_IsHiddenEnabled,
	},
	[wakaba.Enums.Collectibles.SAKURA_CAPSULE] = {
		desc = "{{WakabaModHidden}} {{ColorGray}}Force assign random pill as 'Gulp!' if not available",
		func = wakaba.EIDCond_IsHiddenEnabled,
	},
	-- REPENTOGON ADDITIONS
	[wakaba.Enums.Collectibles.RICHERS_BRA] = {
		desc = "{{WakabaModRgon}} {{AngelDevilChance}} {{ColorRicher}}+10% Devil/Angel Room chance",
		func = function() return REPENTOGON and true end,
	},
	[wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE] = {
		desc = "{{WakabaModRgon}} {{AngelDevilChance}} {{ColorRicher}}+20% Devil/Angel Room chance while held",
		func = function() return REPENTOGON and true end,
	},
	[wakaba.Enums.Collectibles.MAID_DUET] = {
		desc = "{{WakabaModRgon}} {{Battery}} {{ColorRicher}}Reduces Active items' cooldown by 1~2",
		func = function() return REPENTOGON and true end,
	},
	[wakaba.Enums.Collectibles.MAGMA_BLADE] = {
		desc = {"↑ {{Damage}} +1 Damage#{{WakabaModRgon}} Explosion immunity#{{WakabaModRgon}} Isaac swings fire blade and flame wave every 20 tears"},
		func = function() return REPENTOGON and true end,
	},
	[wakaba.Enums.Collectibles.AZURE_RIR] = {
		desc = "{{WakabaModRgon}} {{Tears}} {{ColorRicher}}+0.2 Fire delay up per smelted trinkets#{{WakabaModRgon}} {{Heart}} {{ColorRicher}}+6 Total heart limit",
		func = function() return REPENTOGON and true end,
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		desc = "{{WakabaModRgon}} {{ColorRicher}}Active chargebar is shown to indicate how many card spawn chance have been failed",
		func = function() return REPENTOGON and true end,
	},
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = {
		desc = { ""
		.. "Can be made to act as any absorbed item with the extra button ({wakaba_extra_left} / {wakaba_extra_right})"
		.. "#Charge time varies based on the last active item used and updates with every use"
		.. "#If not selected, invokes both {{Collectible477}}Void and {{Collectible706}}Abyss effect"
		},
		func = function() return REPENTOGON and true end,
	},
}
wakaba.descriptions[desclang].conditionals.trinkets = {
	[wakaba.Enums.Trinkets.PINK_FORK] = {
		desc = {"{{WakabaModRgon}} Decreases Soul Heart heal rate by half heart#{{WakabaModRgon}} Decreased rate are converted to {{Damage}} +0.2 Damage#Does not work if half Soul Heart heal"},
		func = function() return REPENTOGON and true end,
	},
}
wakaba.descriptions[desclang].conditionals.cards = {}
wakaba.descriptions[desclang].conditionals.entities = {
	["-998.-1."..LevelCurse.CURSE_OF_LABYRINTH] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}Spawns extra special rooms",
		func = function() return wakaba:EIDCond_PlayerHasBirthright(wakaba.Enums.Players.RICHER) end,
	},
	["-998.-1."..wakaba.curses.CURSE_OF_SNIPER] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}Weapons are visible and can deal normal damage for nearby enemies",
		func = function() return wakaba:EIDCond_PlayerHasBirthright(wakaba.Enums.Players.RICHER) end,
	},
	["-998.-1."..wakaba.curses.CURSE_OF_FAIRY] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}Maps are not being lost",
		func = function() return wakaba:EIDCond_PlayerHasBirthright(wakaba.Enums.Players.RICHER) end,
	},
	["-998.-1."..wakaba.curses.CURSE_OF_AMNESIA] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}Cleared rooms no longer being uncleared, room clear award still spawns",
		func = function() return wakaba:EIDCond_PlayerHasBirthright(wakaba.Enums.Players.RICHER) end,
	},
	["-998.-1."..wakaba.curses.CURSE_OF_MAGICAL_GIRL] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}All damage deals Richer normally as if Richer is not in Lost state",
		func = function() return wakaba:EIDCond_PlayerHasBirthright(wakaba.Enums.Players.RICHER) end,
	},
}

wakaba.descriptions[desclang].bossdest = {
	title_boss			= "Boss",
	title_health		= "Health",
	title_damo			= "Damocles Start",
	title_lunatic		= "Lunatic Mode",
	title_lock			= "Lock until clear",
	title_roll			= "ROLL!!",
	title_clear			= "Clear challenge",

	desc_boss			= "Select boss to challenge",
	desc_health		= "Select health to challenge#Dynamic: Health multiplier is set dynamically with Isaac's current strength",
	desc_damo			= "Choose damocles to start (Only affected on starting room)#{{Collectible656}} {{ColorSilver}}Vanilla{{CR}}: Normal Damocles#{{Collectible"..wakaba.Enums.Collectibles.LUNAR_DAMOCLES.."}} {{ColorYellow}}Lunar{{CR}}: High chance to fall, removes half of items on fall#{{Collectible"..wakaba.Enums.Collectibles.VINTAGE_THREAT.."}} {{ColorRed}}Vintage{{CR}}: 4 swords. Any prior penalty damage ends the run, damage penalty protection items are invalid",
	desc_lunatic	= "Choose to enable Lunatic mode#In Lunatic mode, most of Pudding & Wakaba items will be nerfed#All damage penalty protection effect except Richer's Bra will be disabled#All Armor-piercing effect/items except Advanced Crystal will be disabled/removed from the pool",
	desc_lock			= "Preserve this challenge until game is cleared",
	desc_roll			= "Are you ready?",
	desc_clear		= "Clear challenge destination#Damocles added by this challenge will not removed",
}

if EID then
	if EID.descriptions[desclang].ItemReminder and EID.descriptions[desclang].ItemReminder.CategoryNames then
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_Character = "Character"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_Starting = "Starting items"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_WakabaUniform = "Wakaba's Uniform"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_Curse = "Curses"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_ShioriFlags = "Shiori Tear effects"
	end

	EID.descriptions[desclang].WakabaGlobalWarningTitle = "{{ColorOrange}}Warning from Wakaba-chan"
	EID.descriptions[desclang].WakabaRGONWarningText = "REPENTOGON not installed! Pudding & Wakaba works without REPENTOGON, but some items effects or elements will be removed!"
	EID.descriptions[desclang].WakabaDamoclesWarningText = "Damocles API disabled! Some items requires it, and will be removed until it's re-enabled again!"

	EID.descriptions[desclang].WakabaAchievementWarningTitle = "{{ColorYellow}}!!! Achievements?"
	EID.descriptions[desclang].WakabaAchievementWarningText = "Pudding & Wakaba's characters come with full sets of unlocks#This is an optional feature#Do you want to lock some items behind our characters?"

	EID.descriptions[desclang].TaintedTsukasaWarningTitle = "{{ColorYellow}}!!! Locked !!!"
	EID.descriptions[desclang].TaintedTsukasaWarningText = "Have to unlock this character first#Howto : Use Red Key to open the hidden closet in Home as Tsukasa#Entering the right door will exit the game"
	EID.descriptions[desclang].TaintedRicherWarningText = "Have to unlock this character first#Howto : Use Red Key to open the hidden closet in Home as Richer#Entering the right door will exit the game"

	EID.descriptions[desclang].SweetsChallenge = "On use, shows prompt for quality#If the quality matches, get the item"
	EID.descriptions[desclang].SweetsFlipFlop = "Use item again to cancel#{{ButtonY}}/{{ButtonX}}:{{Quality1}}or{{Quality3}}#{{ButtonA}}/{{ButtonB}}:{{Quality2}}or{{Quality4}}#If the selected quality matches with item's one, get the item, else disappear otherwise"

	EID.descriptions[desclang].SweetsChallengeFailed = "{{ColorOrange}}Failed for mismatching quality : "
	EID.descriptions[desclang].SweetsChallengeSuccess = "{{ColorCyan}}Succeed for matching quality : "

	EID.descriptions[desclang].WakabaVintageHotkey = "#!!! Press {1} to activate immediately"

	EID.descriptions[desclang].CaramellaFlyRicher = "!!! {{ColorRicher}}Richer: The fly deals 4x Isaac's damage"
	EID.descriptions[desclang].CaramellaFlyRira = "!!! {{ColorRira}}Rira: The fly deals 3x Isaac's damage + aqua status"
	EID.descriptions[desclang].CaramellaFlyCiel = "!!! {{ColorCiel}}Ciel: The fly deals 10x Isaac's damage + explosion damage (does not hurt Isaac)"
	EID.descriptions[desclang].CaramellaFlyKoron = "!!! {{ColorKoron}}Koron: The fly deals 4x Isaac's damage + petrify status"

	EID.descriptions[desclang].MaidDuetBlacklisted = "{{Collectible"..wakaba.Enums.Collectibles.MAID_DUET.."}} Can't swapped by Maid Duet"

	EID.descriptions[desclang].AquaTrinketText = "{{AquaTrinket}} {{ColorCyan}}Aqua Trinket : Automatically absorbed{{CR}}"

	EID.descriptions[desclang].AlbireoPool = "{{RicherPlanetarium}} Pool for this floor : "

	EID.descriptions[desclang].ClearFileSelection = "Selection for Clear File"

	EID.descriptions[desclang].ConditionalDescs.WakabaWardSynergy = "{{ColorRira}}Expands Rabbey Ward area"
	EID.descriptions[desclang].ConditionalDescs.WakabaWardSynergyFrom = "{1} expands ward area"

	EID.descriptions[desclang].ConditionalDescs.WakabaVintageInvalidated = "{1} invalidates damage penalty protection"
	EID.descriptions[desclang].ConditionalDescs.WakabaVintageInvalidates = "Invalidates {1}"

end