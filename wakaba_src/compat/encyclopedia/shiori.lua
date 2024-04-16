local players = wakaba.Enums.Players
local i = wakaba.Enums.Collectibles
local t = wakaba.Enums.Trinkets
local c = wakaba.Enums.Cards
local p = wakaba.Enums.Pills

local class = "Pudding n Wakaba"


-- Shiori / Comp : Book of Shiori [Starting item]
-- Shiori / Heart : Hard Book
-- Shiori / Satan : Book of Focus
-- Shiori / Blue : Bottle of Runes
-- Shiori / Lamb : Grimreaper Defender
-- Shiori / Rush : Unknown Bookmark
-- Shiori / Hush : Book of Trauma
-- Shiori / MegaS : Book of the Fallen
-- Shiori / Deli : Book of Silence
-- Shiori / Greed : Magnet Heaven
-- Shiori / Gdier : Determination Ribbon
-- Shiori / Mother : Vintage Threat
-- Shiori / Beast : Book of the God

-- Shiori_B / Quartet : Bookmark Bag
-- Shiori_B / Duet : Soul of Shiori
-- Shiori_B / MegaS : Shiori's Valut
-- Shiori_B / Deli : Book of Conquest [Starting item]
-- Shiori_B / Gdier : Queen of Spades
-- Shiori_B / Mother : Ring of Jupiter
-- Shiori_B / Beast : Minerva's Aura [Starting item]

-- Shiori_T / Quartet :
-- Shiori_T / Duet :
-- Shiori_T / MegaS :
-- Shiori_T / Deli :
-- Shiori_T / Gdier :
-- Shiori_T / Mother :
-- Shiori_T / Beast :
-- Shiori_T / Comp : Karmic Book [Starting item]


--#region Shiori
-- Shiori / Heart : Hard Book
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.HARD_BOOK,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.HARD_BOOK],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("hardbook") then
			self.Desc = "Defeat Mom's Heart as Shiori on Hard Mode"
			return self
		end
	end,
})
-- Shiori / Satan : Book of Focus
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
		if not wakaba:IsEntryUnlocked("bookoffocus") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.SHIORI) then
			self.Desc = "Defeat Satan as Shiori"

			return self
		end
	end,
})
-- Shiori / Blue : Bottle of Runes
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.DECK_OF_RUNES,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.DECK_OF_RUNES,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("deckofrunes") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.SHIORI) then
			self.Desc = "Defeat ??? as Shiori"

			return self
		end
	end,
})
-- Shiori / Lamb : Grimreaper Defender
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
		if not wakaba:IsEntryUnlocked("grimreaperdefender") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.SHIORI) then
			self.Desc = "Defeat The Lamb as Shiori"

			return self
		end
	end,
})
-- Shiori / Rush : Unknown Bookmark
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_UNKNOWN_BOOKMARK],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Unknown Bookmark",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("unknownbookmark") then
			self.Desc = "Complete Boss Rush as Shiori"

			return self
		end
	end,
})
-- Shiori / Hush : Book of Trauma
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
		if not wakaba:IsEntryUnlocked("bookoftrauma") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.SHIORI) then
			self.Desc = "Defeat Hush as Shiori"

			return self
		end
	end,
})
-- Shiori / MegaS : Book of the Fallen
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
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("bookoffallen") then
			self.Desc = "Defeat The Mega Satan as Shiori"

			return self
		end
	end,
})
-- Shiori / Deli : Book of Silence
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
		if not wakaba:IsEntryUnlocked("bookofsilence") and not wakaba:GameHasPlayerType(wakaba.Enums.Players.SHIORI) then
			self.Desc = "Defeat Delirium as Shiori"

			return self
		end
	end,
})
-- Shiori / Greed : Magnet Heaven
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.MAGNET_HEAVEN,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.MAGNET_HEAVEN],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("magnetheaven") then
			self.Desc = "Defeat Ultra Greed as Shiori"
			return self
		end
	end,
})
-- Shiori / Gdier : Determination Ribbon
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.DETERMINATION_RIBBON,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.DETERMINATION_RIBBON],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("determinationribbon") then
			self.Desc = "Defeat Ultra Greedier as Shiori"
			return self
		end
	end,
})
-- Shiori / Mother : Vintage Threat
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
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("vintagethreat") then
			self.Desc = "Defeat Mother as Shiori"

			return self
		end
		if not wakaba.Flags.stackableDamocles then
			self.Desc = "Requires Damocles API to work"
			return self
		end
	end,
})
-- Shiori / Beast : Book of the God
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.BOOK_OF_THE_GOD,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_THE_GOD,
	Pools = {
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
		Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("bookofthegod") then
			self.Desc = "Defeat The Beast as Shiori"

			return self
		end
	end,
})

--#endregion

--#region Tainted Shiori
-- Shiori_B / Quartet : Bookmark Bag
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.BOOKMARK_BAG,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.BOOKMARK_BAG],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("bookmarkbag") then
			self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Shiori"
			return self
		end
	end,
})
-- Shiori_B / Duet : Soul of Shiori
Encyclopedia.AddSoul({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.SOUL_SHIORI,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.SOUL_SHIORI],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Soul of Shiori",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("shiorisoul") then
			self.Desc = "Defeat Boss Rush, Hush as Tainted Shiori"

			return self
		end
	end,
})
-- Shiori_B / MegaS : Shiori's Valut
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.CARD_VALUT_RIFT,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_VALUT_RIFT],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Valut Rift",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("shiorivalut") then
			self.Desc = "Complete Mega Satan as Tainted Shiori"

			return self
		end
	end,
})
-- Shiori_B / Gdier : Queen of Spades
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_QUEEN_OF_SPADES],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Queen of Spades",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("queenofspades") then
			self.Desc = "Complete Ultra Greedier as Tainted Shiori"

			return self
		end
	end,
})
-- Shiori_B / Mother : Ring of Jupiter
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.RING_OF_JUPITER,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.RING_OF_JUPITER],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("ringofjupiter") then
			self.Desc = "Defeat Mother as Tainted Shiori"
			return self
		end
	end,
})
--#endregion

--#region Tarnished Shiori
--#endregion