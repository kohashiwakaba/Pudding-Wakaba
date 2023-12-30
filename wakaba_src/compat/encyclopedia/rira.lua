local players = wakaba.Enums.Players
local i = wakaba.Enums.Collectibles
local t = wakaba.Enums.Trinkets
local c = wakaba.Enums.Cards
local p = wakaba.Enums.Pills

local class = "Pudding n Wakaba"


-- Rira / Comp : Chimaki [Starting item]
-- Rira / Heart : Black Bean Mochi
-- Rira / Isaac : Nerf Gun [Starting item]
-- Rira / Satan : Rira's Swimsuit
-- Rira / Blue : Sakura Mont Blanc
-- Rira / Lamb : Chewy Rolly Cake
-- Rira / Rush : Caramella Pancake
-- Rira / Hush : Secret Door
-- Rira / MegaS : Rira's Bento
-- Rira / Deli : Rira's Bandage
-- Rira / Greed : Rabbit Pillow
-- Rira / Gdier : Lil Rira
-- Rira / Mother : Sakura Capsule
-- Rira / Beast : Maid Duet

-- Rira_B / Quartet :
-- Rira_B / Duet :
-- Rira_B / MegaS :
-- Rira_B / Deli : Rabbey Ward [Starting item]
-- Rira_B / Gdier :
-- Rira_B / Mother :
-- Rira_B / Beast : [Starting item]

-- Rira_T / Quartet :
-- Rira_T / Duet :
-- Rira_T / MegaS :
-- Rira_T / Deli :
-- Rira_T / Gdier :
-- Rira_T / Mother :
-- Rira_T / Beast :
-- Rira_T / Comp : Pluton [Starting item]



-- Rira / Heart : Black Bean Mochi
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.BLACK_BEAN_MOCHI,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("blackbeanmochi") then
			self.Desc = "Defeat Mom's Heart as Rira in Hard Mode"
			return self
		end
	end,
	WikiDesc = {

	},
})

-- Rira / Satan : Rira's Swimsuit
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.RIRAS_SWIMSUIT,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("riraswimsuit") then
			self.Desc = "Defeat Satan as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})

-- Rira / Blue : Sakura Mont Blanc
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.SAKURA_MONT_BLANC,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("sakuramontblanc") then
			self.Desc = "Defeat ??? as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})


-- Rira / Lamb : Chewy Rolly Cake
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.CHEWY_ROLLY_CAKE,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("chewyrollycake") then
			self.Desc = "Defeat The Lamb as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})


-- Rira / Rush : Caramella Pancake
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.CARAMELLA_PANCAKE,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("caramellapancake") then
			self.Desc = "Defeat Boss Rush as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})


-- Rira / Hush : Secret Door
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.SECRET_DOOR,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("secretdoor") then
			self.Desc = "Defeat Hush as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})


-- Rira / MegaS : Rira's Bento
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.RIRAS_BENTO,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("rirabento") then
			self.Desc = "Defeat Mega Satan as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})


-- Rira / Deli : Rira's Bandage
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.RIRAS_BANDAGE,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("rirabandage") then
			self.Desc = "Defeat Delirium as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})


-- Rira / Greed : Rabbit Pillow
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = t.RABBIT_PILLOW,
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("rabbitpillow") then
			self.Desc = "Defeat Ultra Greed as Rira"
			return self
		end
	end,
	WikiDesc = {
	},
})

-- Rira / Gdier : Lil Rira
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.LIL_RIRA,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("lilrira") then
			self.Desc = "Defeat Ultra Greedier as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})


-- Rira / Mother : Sakura Capsule
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.SAKURA_CAPSULE,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("sakuracapsule") then
			self.Desc = "Defeat Mother as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})


-- Rira / Beast : Maid Duet
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.MAID_DUET,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("maidduet") then
			self.Desc = "Defeat The Beast as Rira"
			return self
		end
	end,
	WikiDesc = {

	},
})