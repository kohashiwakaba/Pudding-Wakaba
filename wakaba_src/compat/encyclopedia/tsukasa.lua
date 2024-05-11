local players = wakaba.Enums.Players
local i = wakaba.Enums.Collectibles
local t = wakaba.Enums.Trinkets
local c = wakaba.Enums.Cards
local p = wakaba.Enums.Pills

local class = "Pudding n Wakaba"


-- Tsukasa / Comp : Lunar Stone [Starting item]
-- Tsukasa / Heart : Murasame [Starting item]
-- Tsukasa / Isaac : Nasa Lover
-- Tsukasa / Satan : Beetlejuice
-- Tsukasa / Blue : Red Corruption
-- Tsukasa / Lamb : Power Bomb
-- Tsukasa / Rush : Concentration [Starting item]
-- Tsukasa / Hush : Range OS
-- Tsukasa / MegaS : Plasma Beam
-- Tsukasa / Deli : New Year's Eve Bomb
-- Tsukasa / Greed : Arcane Crystal
-- Tsukasa / Gdier : Question Block
-- Tsukasa / Mother : Phantom Cloak
-- Tsukasa / Beast : Magma Blade

-- Tsukasa_B / Quartet : Isaac Cartridge
-- Tsukasa_B / Duet : Soul of Tsukasa
-- Tsukasa_B / MegaS : Easter Egg
-- Tsukasa_B / Deli : Flash Shift [Starting item]
-- Tsukasa_B / Gdier : Return Token
-- Tsukasa_B / Mother : Siren's Badge
-- Tsukasa_B / Beast : Elixir of Life [Starting item]

-- Tsukasa_T / Quartet :
-- Tsukasa_T / Duet :
-- Tsukasa_T / MegaS :
-- Tsukasa_T / Deli :
-- Tsukasa_T / Gdier :
-- Tsukasa_T / Mother :
-- Tsukasa_T / Beast :
-- Tsukasa_T / Comp : Laputa [Starting item]


--#region Tsukasa
-- Tsukasa / Isaac : Nasa Lover
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.NASA_LOVER,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.NASA_LOVER,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_BABY_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("nasalover") then
			self.Desc = "Defeat Isaac as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / Satan : Beetlejuice
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
		if not wakaba:IsEntryUnlocked("beetlejuice") then
			self.Desc = "Defeat Satan as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / Blue : Red Corruption
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.RED_CORRUPTION,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RED_CORRUPTION,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_CURSE,
		Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
		Encyclopedia.ItemPools.POOL_RED_CHEST,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("redcorruption") then
			self.Desc = "Defeat ??? as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / Lamb : Power Bomb
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
		if not wakaba:IsEntryUnlocked("powerbomb") then
			self.Desc = "Defeat The Lamb as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / Hush : Range OS
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.RANGE_OS,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.RANGE_OS],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("rangeos") then
			self.Desc = "Defeat Hush as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / MegaS : Plasma Beam
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
		if not wakaba:IsEntryUnlocked("plasmabeam") then
			self.Desc = "Defeat Mega Satan as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / Deli : New Year's Eve Bomb
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.NEW_YEAR_BOMB,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.NEW_YEAR_BOMB,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_CURSE,
		Encyclopedia.ItemPools.POOL_BOMB_BUM,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("newyearbomb") then
			self.Desc = "Defeat Delirium as Tsukasa"

			return self
		end
	end,
})
-- Tsukasa / Greed : Arcane Crystal
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
		if not wakaba:IsEntryUnlocked("arcanecrystal") then
			self.Desc = "Defeat Ultra Greed as Tsukasa"
			return self
		end
	end,
})
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
		if not wakaba:IsEntryUnlocked("arcanecrystal") then
			self.Desc = "Defeat Ultra Greed as Tsukasa"
			return self
		end
	end,
})
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
		if not wakaba:IsEntryUnlocked("arcanecrystal") then
			self.Desc = "Defeat Ultra Greed as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / Gdier : Question Block
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
		if not wakaba:IsEntryUnlocked("questionblock") then
			self.Desc = "Defeat Ultra Greedier as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / Mother : Phantom Cloak
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
		if not wakaba:IsEntryUnlocked("phantomcloak") then
			self.Desc = "Defeat Mother as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / Beast : Magma Blade
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.MAGMA_BLADE,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MAGMA_BLADE,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("magmablade") then
			self.Desc = "Defeat The Beast as Tsukasa"
			return self
		end
	end,
})
--#endregion

--#region Tainted Tsukasa
-- Tsukasa_B / Quartet : Isaac Cartridge
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.ISAAC_CARTRIDGE,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.ISAAC_CARTRIDGE],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("isaaccartridge") then
			self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Tsukasa"
			return self
		end
	end,
})
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.AFTERBIRTH_CARTRIDGE],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("isaaccartridge") then
			self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Tsukasa"
			return self
		end
	end,
})
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.REPENTANCE_CARTRIDGE],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("isaaccartridge") then
			self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Tsukasa"
			return self
		end
	end,
})
-- Tsukasa_B / Duet : Soul of Tsukasa
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.LUNAR_DAMOCLES,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LUNAR_DAMOCLES,
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("tsukasasoul") then
			self.Desc = "Defeat Boss Rush, Hush as Tainted Tsukasa"
			return self
		end
		if not wakaba.Flags.stackableDamocles then
			self.Desc = "Requires Damocles API to work"
			return self
		end
	end,
})
Encyclopedia.AddSoul({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.SOUL_TSUKASA,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.SOUL_TSUKASA],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Soul of Tsukasa",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("tsukasasoul") then
			self.Desc = "Defeat Boss Rush, Hush as Tainted Tsukasa"

			return self
		end
		if not wakaba.Flags.stackableDamocles then
			self.Desc = "Requires Damocles API to work"
			return self
		end
	end,
})
-- Tsukasa_B / MegaS : Easter Egg
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.EASTER_EGG,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EASTER_EGG,
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("easteregg") then
			self.Desc = "Defeat Mega Satan as Tainted Tsukasa"
			return self
		end
	end,
})
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.AURORA_GEM,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.AURORA_GEM],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("easteregg") then
			self.Desc = "Defeat Mega Satan as Tainted Tsukasa"
			return self
		end
	end,
})
-- Tsukasa_B / Gdier : Return Token
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.CARD_RETURN_TOKEN,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_RETURN_TOKEN],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Return Token",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("returntoken") then
			self.Desc = "Defeat Ultra Greedier as Tainted Tsukasa"

			return self
		end
	end,
})
-- Tsukasa_B / Mother : Siren's Badge
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.SIREN_BADGE,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.SIREN_BADGE],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("sirenbadge") then
			self.Desc = "Defeat Mother as Tainted Tsukasa"
			return self
		end
	end,
})
--#endregion

--#region Tarnished Tsukasa
-- Tsukasa_T / ??? : Sigil of Kaguya
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.SIGIL_OF_KAGUYA],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("sigilofkaguya") then
			self.Desc = "Defeat Mother as Tarnished Tsukasa"
			return self
		end
	end,
  Hide = true,
})
--#endregion