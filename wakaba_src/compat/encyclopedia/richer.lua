local players = wakaba.Enums.Players
local i = wakaba.Enums.Collectibles
local t = wakaba.Enums.Trinkets
local c = wakaba.Enums.Cards
local p = wakaba.Enums.Pills

local class = "Pudding n Wakaba"


-- Richer / Comp : Rabbit Ribbon [Starting item]
-- Richer / Heart : Firefly Lighter
-- Richer / Isaac : Sweets Catalog [Starting item]
-- Richer / Satan : Anti Balance
-- Richer / Blue : Double Invader
-- Richer / Lamb : Venom Incantation
-- Richer / Rush : Bunny Parfait
-- Richer / Hush : Richer's Uniform
-- Richer / MegaS : 3D Printer
-- Richer / Deli : Prestige Pass
-- Richer / Greed : Clensing Foam
-- Richer / Gdier : Lil Richer
-- Richer / Mother : Cunning Paper
-- Richer / Beast : Self Burning

-- Richer_B / Quartet : Star Reversal
-- Richer_B / Duet : Soul of Richer
-- Richer_B / MegaS : Crystal Restock
-- Richer_B / Deli : Water-Flame [Starting item]
-- Richer_B / Gdier : Trial Stew
-- Richer_B / Mother : Eternity Cookie
-- Richer_B / Beast : The Winter Albireo [Starting item]

-- Richer_T / Quartet :
-- Richer_T / Duet :
-- Richer_T / MegaS :
-- Richer_T / Deli :
-- Richer_T / Gdier :
-- Richer_T / Mother :
-- Richer_T / Beast :
-- Richer_T / Comp : Iblis [Starting item]


--#region Richer
-- Richer / Heart : Firefly Lighter
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
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("fireflylighter") then
			self.Desc = "Defeat Mom's Heart as Richer on Hard"
			return self
		end
	end,
})
-- Richer / Satan : Anti Balance
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
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("antibalance") then
			self.Desc = "Defeat Satan as Richer"
			return self
		end
	end,
})
-- Richer / Blue : Double Invader
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
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("doubleinvader") then
			self.Desc = "Defeat ??? as Richer"
			return self
		end
	end,
})
-- Richer / Lamb : Venom Incantation
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
		Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
		Encyclopedia.ItemPools.POOL_RED_CHEST,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("venomincantation") then
			self.Desc = "Defeat The Lamb as Richer"
			return self
		end
	end,
})
-- Richer / Rush : Bunny Parfait
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.BUNNY_PARFAIT,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BUNNY_PARFAIT,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_BEGGAR,
		Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("bunnyparfait") then
			self.Desc = "Complete Boss Rush as Richer"
			return self
		end
	end,
})
-- Richer / Hush : Richer's Uniform

Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.RICHERS_UNIFORM,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RICHERS_UNIFORM,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("richeruniform") then
			self.Desc = "Defeat Hush as Richer"
			return self
		end
	end,
})
-- Richer / MegaS : 3D Printer
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
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("printer") then
			self.Desc = "Defeat Mega Satan as Richer"
			return self
		end
	end,
})
-- Richer / Deli : Prestige Pass
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
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("prestigepass") then
			self.Desc = "Defeat Delirium as Richer"
			return self
		end
	end,
})
-- Richer / Greed : Clensing Foam
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
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("clensingfoam") then
			self.Desc = "Defeat Ultra Greed as Richer"
			return self
		end
	end,
})
-- Richer / Gdier : Lil Richer
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.LIL_RICHER,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LIL_RICHER,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_BABY_SHOP,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("lilricher") then
			self.Desc = "Defeat Ultra Greedier as Richer"
			return self
		end
	end,
})
-- Richer / Mother : Cunning Paper
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
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("cunningpaper") then
			self.Desc = "Defeat Mother as Richer"
			return self
		end
	end,
})
-- Richer / Beast : Self Burning
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.SELF_BURNING,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SELF_BURNING,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_BOMB_BUM,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("selfburning") then
			self.Desc = "Defeat The Beast as Richer"
			return self
		end
	end,
})
--#endregion

--#region Tainted Richer
-- Richer_B / Quartet : Star Reversal
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.STAR_REVERSAL,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.STAR_REVERSAL],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("starreversal") then
			self.Desc = "Defeat Isaac, Satan, ???, and The Lamb as Tainted Richer"
			return self
		end
	end,
})
-- Richer_B / Duet : Soul of Richer
Encyclopedia.AddSoul({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.SOUL_RICHER,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.SOUL_RICHER],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Soul of Richer",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("richersoul") then
			self.Desc = "Defeat Boss Rush, Hush as Tainted Richer"

			return self
		end
	end,
})
-- Richer_B / MegaS : Crystal Restock
-- Richer_B / Gdier : Trial Stew
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.TRIAL_STEW,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.TRIAL_STEW,
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("trialstew") then
			self.Desc = "Defeat Ultra Greedier as Tainted Richer"

			return self
		end
	end,
})
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.CARD_TRIAL_STEW,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.TRIAL_STEW,
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Trial Stew",0),
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("trialstew") then
			self.Desc = "Defeat Ultra Greedier as Tainted Richer"

			return self
		end
	end,
})
-- Richer_B / Mother : Eternity Cookie
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.ETERNITY_COOKIE,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.ETERNITY_COOKIE],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("eternitycookie") then
			self.Desc = "Defeat Mother as Tainted Richer"
			return self
		end
	end,
})
--#endregion

--#region Tarnished Richer
--#endregion