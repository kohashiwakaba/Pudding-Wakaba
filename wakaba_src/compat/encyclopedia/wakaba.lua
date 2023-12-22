local players = wakaba.Enums.Players
local i = wakaba.Enums.Collectibles
local t = wakaba.Enums.Trinkets
local c = wakaba.Enums.Cards
local p = wakaba.Enums.Pills

local class = "Pudding n Wakaba"


-- Wakaba / Comp : Wakaba's Blessing [Starting item]
-- Wakaba / Heart : Clover
-- Wakaba / Isaac : Counter
-- Wakaba / Satan : D-Cup Ice Cream
-- Wakaba / Blue : Wakaba's Pendant
-- Wakaba / Lamb : Revenge Fruit
-- Wakaba / Rush : Wakaba's Dream Card
-- Wakaba / Hush : Color Joker
-- Wakaba / MegaS : White Joker
-- Wakaba / Deli : Wakaba's Uniform
-- Wakaba / Greed : Secret Card
-- Wakaba / Gdier : Crane Card
-- Wakaba / Mother : Confessional Card
-- Wakaba / Beast : Anger Reversal

-- Wakaba_B / Quartet : Book of Forgotten
-- Wakaba_B / Duet : Soul of Wakaba
-- Wakaba_B / MegaS : Clover Chest
-- Wakaba_B / Deli : Eat Heart [Starting item]
-- Wakaba_B / Gdier : Black Joker
-- Wakaba_B / Mother : Bitcoin II
-- Wakaba_B / Beast : Wakaba's Nemesis [Starting item]

-- Wakaba_T / Quartet :
-- Wakaba_T / Duet :
-- Wakaba_T / MegaS :
-- Wakaba_T / Deli :
-- Wakaba_T / Gdier :
-- Wakaba_T / Mother :
-- Wakaba_T / Beast :
-- Wakaba_T / Comp : Tree of Sepiroth [Starting item]

--#region Wakaba
-- Wakaba / Heart : Clover
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = t.CLOVER,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.CLOVER],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("clover") then
			self.Desc = "Defeat Mom's Heart as Wakaba in Hard Mode"
			return self
		end
	end,
})
-- Wakaba / Isaac : Counter
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.COUNTER,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.COUNTER,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("counter") then
			self.Desc = "Defeat Isaac as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Satan : D-Cup Ice Cream
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.D_CUP_ICECREAM,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.D_CUP_ICECREAM,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("dcupicecream") then
			self.Desc = "Defeat Satan as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Blue : Wakaba's Pendant
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.WAKABAS_PENDANT,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_PENDANT,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("pendant") then
			self.Desc = "Defeat ??? as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Lamb : Revenge Fruit
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.REVENGE_FRUIT,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.REVENGE_FRUIT,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("revengefruit") then
			self.Desc = "Defeat The Lamb as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Rush : Wakaba's Dream Card
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = c.CARD_DREAM_CARD,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_DREAM_CARD],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Wakaba's Dream Card"),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("donationcard") and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_DRMS then
			self.Desc = "Complete Boss Rush as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Hush : Color Joker
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = c.CARD_COLOR_JOKER,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_COLOR_JOKER],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Color Joker",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("colorjoker") then
			self.Desc = "Defeat Hush as Wakaba"

			return self
		end
	end,
})
-- Wakaba / MegaS : White Joker
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = c.CARD_WHITE_JOKER,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_WHITE_JOKER],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_White Joker",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("whitejoker") then
			self.Desc = "Defeat Mega Satan as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Deli : Wakaba's Uniform
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.UNIFORM,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.UNIFORM,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("wakabauniform") and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_DRAW then
			self.Desc = "Defeat Delirium as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Greed : Secret Card
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.SECRET_CARD,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SECRET_CARD,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_CURSE,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("secretcard") then
			self.Desc = "Defeat Ultra Greed as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Gdier : Crane Card
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = c.CARD_CRANE_CARD,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_CRANE_CARD],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Crane Card",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("cranecard") then
			self.Desc = "Defeat Ultra Greedier as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Mother : Confessional Card
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = c.CARD_CONFESSIONAL_CARD,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_CONFESSIONAL_CARD],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Confessional Card",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("confessionalcard") then
			self.Desc = "Defeat Mother as Wakaba"

			return self
		end
	end,
})
-- Wakaba / Beast : Anger Reversal
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.RETURN_POSTAGE,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RETURN_POSTAGE,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("returnpostage") then
			self.Desc = "Defeat The Beast as Wakaba"

			return self
		end
	end,
})
--#endregion

--#region Tainted Wakaba
-- Wakaba_B / Quartet : Book of Forgotten
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.BOOK_OF_FORGOTTEN,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_FORGOTTEN,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_OLD_CHEST,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("bookofforgotten") then
			self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Wakaba"

			return self
		end
	end,
})
-- Wakaba_B / Duet : Soul of Wakaba
Encyclopedia.AddSoul({
	Class = class,
	ModName = class,
	ID = c.SOUL_WAKABA,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.SOUL_WAKABA],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Soul of Wakaba",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("wakabasoul") then
			self.Desc = "Defeat Boss Rush, Hush as Tainted Wakaba"

			return self
		end
	end,
})
Encyclopedia.AddSoul({
	Class = class,
	ModName = class,
	ID = c.SOUL_WAKABA2,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.SOUL_WAKABA2],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Soul of Wakaba?",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("wakabasoul") then
			self.Desc = "Defeat Boss Rush, Hush as Tainted Wakaba"

			return self
		end
	end,
})
-- Wakaba_B / MegaS : Clover Chest
-- Wakaba_B / Gdier : Black Joker
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = c.CARD_BLACK_JOKER,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_BLACK_JOKER],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Black Joker",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("blackjoker") then
			self.Desc = "Defeat Ultra Greedier as Tainted Wakaba"

			return self
		end
	end,
})
-- Wakaba_B / Mother : Bitcoin II
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = t.BITCOIN,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.BITCOIN],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("bitcoin") then
			self.Desc = "Defeat Mother as Tainted Wakaba"
			return self
		end
	end,
})
--#endregion

--#region Tarnished Wakaba
--#endregion