local players = wakaba.Enums.Players
local items = wakaba.Enums.Collectibles
local trinkets = wakaba.Enums.Trinkets
local cards = wakaba.Enums.Cards
local pills = wakaba.Enums.Pills

local class = "Pudding n Wakaba"

-- Wakaba / Wakaba's Blessing
-- Wakaba_B / Wakaba's Nemesis
-- Wakaba_B / Wakaba Duality
-- Wakaba_B / Eat Heart
-- Wakaba_T / Clover Shard
-- Wakaba_T / Tree of Sepiroth

-- Shiori / Book of Shiori
-- Shiori_B / Book of Conquest
-- Shiori_B / Minerva's Aura
-- Shiori_T / Karmic Book
-- Shiori_T / ????

-- Tsukasa / Lunar Stone
-- Tsukasa / Nasa Lover
-- Tsukasa / Concentration
-- Tsukasa_B / Elixir of Life
-- Tsukasa_B / Murasame
-- Tsukasa_B / Flash Shift
-- Tsukasa_T / Laputa
-- Tsukasa_T / ????

-- Richer / Rabbit Ribbon
-- Richer / Sweets Catalog
-- Richer_B / Water-Flame
-- Richer_B / The Winter Albireo
-- Richer_T / Iblis
-- Richer_T / ????

-- Rira / Chimaki
-- Rira / Nerf Gun
-- Rira_B / Rabbey Ward
-- Rira_B / ????
-- Rira_T / Pluton
-- Rira_T / ????


--#region Wiki area
--#endregion

--#region Wiki area
--#endregion


--#region Wakaba Starting

-- Wakaba / Wakaba's Blessing
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.WAKABAS_BLESSING,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_BLESSING,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("blessing") and not wakaba.runstate.hasbless then
			self.Desc = "Earn all 12 completion marks on Hard mode as Wakaba"
			return self
		end
	end,
})
-- Wakaba_B / Wakaba's Nemesis
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.WAKABAS_NEMESIS,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_NEMESIS,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("nemesis") and not wakaba.runstate.hasnemesis then
			self.Desc = "Defeat The Beast as Tainted Wakaba"
			return self
		end
	end,
})
-- Wakaba_B / Wakaba Duality
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
-- Wakaba_B / Eat Heart
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.EATHEART,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EATHEART,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_CURSE,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_RED_CHEST,
	},
	ActiveCharge = 7500,
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("eatheart") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.WAKABA_B) then
			self.Desc = "Defeat Delirium as Tainted Wakaba"
			return self
		end
	end,
})
-- Wakaba_T / Clover Shard
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.CLOVER_SHARD,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CLOVER_SHARD,
	UnlockFunc = function(self)
		if not wakaba:GameHasPlayerType(wakaba.Enums.Players.WAKABA_T) and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_HOLD then
			self.Desc = "???"
			return self
		end
	end,
})
-- Wakaba_T / Tree of Sepiroth

--#endregion


--#region Shiori Starting

-- Shiori / Book of Shiori
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
		if not wakaba:IsEntryUnlocked("bookofshiori") and not wakaba.hasshiori then
			self.Desc = "Earn all 12 completion marks on Hard mode as Shiori"
			return self
		end
	end,
})
-- Shiori_B / Book of Conquest
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
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("bookofconquest") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.SHIORI_B) then
			self.Desc = "Defeat Delirium as Tainted Shiori"
			return self
		end
	end,
})
-- Shiori_B / Minerva's Aura
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
		if not wakaba:IsEntryUnlocked("minervaaura") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.SHIORI_B) then
			self.Desc = "Defeat The Beast as Tainted Shiori"
			return self
		end
	end,
})
-- Shiori_T / Karmic Book
-- Shiori_T / ????

--#endregion


--#region Tsukasa Starting

-- Tsukasa / Lunar Stone
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
		if not wakaba:IsEntryUnlocked("lunarstone") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.TSUKASA) then
			self.Desc = "Earn all 12 completion marks on Hard mode as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa / Nasa Lover
-- Tsukasa / Concentration
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.CONCENTRATION,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CONCENTRATION,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_BEGGAR,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("concentration") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.TSUKASA) then
			self.Desc = "Complete Boss Rush as Tsukasa"
			return self
		end
	end,
})
-- Tsukasa_B / Elixir of Life
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
		Encyclopedia.ItemPools.POOL_OLD_CHEST,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("elixiroflife") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.TSUKASA_B) then
			self.Desc = "Defeat The Beast as Tainted Tsukasa"
			return self
		end
	end,
})
-- Tsukasa_B / Murasame
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
		if not wakaba:IsEntryUnlocked("murasame") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.TSUKASA_B) then
			self.Desc = "Defeat Mom's Heart as Tsukasa on Hard"
			return self
		end
	end,
})
-- Tsukasa_B / Flash Shift
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
		if not wakaba:IsEntryUnlocked("flashshift") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.TSUKASA_B) then
			self.Desc = "Defeat Delirium as Tainted Tsukasa"
			return self
		end
	end,
})
-- Tsukasa_T / Laputa
-- Tsukasa_T / ????

--#endregion


--#region Richer Starting

-- Richer / Rabbit Ribbon
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.RABBIT_RIBBON,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RABBIT_RIBBON,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("rabbitribbon") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.RICHER) and not wakaba:GameHasPlayerType(wakaba.Enums.Players.RICHER_B) then
			self.Desc = "Earn all 12 completion marks on Hard mode as Richer"
			return self
		end
	end,
})
-- Richer / Sweets Catalog
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.SWEETS_CATALOG,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SWEETS_CATALOG,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("sweetscatalog") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.RICHER) then
			self.Desc = "Defeat Isaac as Richer"
			return self
		end
	end,
})
-- Richer_B / Water-Flame
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.WATER_FLAME,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WATER_FLAME,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("waterflame") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.RICHER_B) then
			self.Desc = "Defeat Delirium as Tainted Richer"
			return self
		end
	end,
})
-- Richer_B / The Winter Albireo
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.WINTER_ALBIREO,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WINTER_ALBIREO,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_PLANETARIUM,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("winteralbireo") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.RICHER_B) then
			self.Desc = "Defeat The Beast as Tainted Richer"
			return self
		end
	end,
})
-- Richer_T / Iblis
-- Richer_T / ????

--#endregion


--#region Rira Starting

-- Rira / Chimaki
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.CHIMAKI,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CHIMAKI,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_BABY_SHOP,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("chimaki") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.RIRA) then
			self.Desc = "Earn all 12 completion marks on Hard mode as Rira"
			return self
		end
	end,
})
-- Rira / Nerf Gun
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.NERF_GUN,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.NERF_GUN,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.WOODEN_CHEST,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("nerfgun") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.RIRA) then
			self.Desc = "Defeat Isaac as Rira"
			return self
		end
	end,
})
-- Rira_B / Rabbey Ward
-- Rira_B / ????
-- Rira_T / Pluton
-- Rira_T / ????

--#endregion