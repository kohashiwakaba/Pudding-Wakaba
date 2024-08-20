local players = wakaba.Enums.Players
local i = wakaba.Enums.Collectibles
local t = wakaba.Enums.Trinkets
local c = wakaba.Enums.Cards
local p = wakaba.Enums.Pills

local class = "Pudding n Wakaba"


-- w01 Electric Disorder
-- w02 Berry Best Friend
-- w03
-- w04 Mine Stuff
-- w05 Black Neko Dreams
-- w06 Doppelganger
-- w07 Delirium
-- w08 Sisters from Beyond
-- w09 Draw Five
-- w10 Rush Rush Hush
-- w11 Apollyon Crisis
-- w12 Delivery System
-- w13 Calculation
-- w14 Hold Me
-- w15 Even or Odd
-- w16 Runaway Pheromones
-- w17 The Floor is Lava
-- w18 Universe of Goom
-- w19 Manner Pylon

-- w98 Hyper Random
-- w99 True Purist Girl




-- w01 Electric Disorder
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.EYE_OF_CLOCK,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EYE_OF_CLOCK,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("eyeofclock") and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_ELEC then
			self.Desc = "Complete Electric Disorder (challenge No.01w)"
			return self
		end
	end,
})

-- w02 Berry Best Friend
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.PLUMY,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.PLUMY,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_KEY_MASTER,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("plumy") and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_PLUM then
			self.Desc = "Complete Berry Best Friend (challenge No.02w)"

			return self
		end
	end,
})

-- w03
-- w04 Mine Stuff
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = t.DELIMITER,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.DELIMITER],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("delimiter") then
			self.Desc = "Complete Mine Stuff (challenge No.04w)"
			return self
		end
	end,
})
-- w05 Black Neko Dreams
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.NEKO_FIGURE,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.NEKO_FIGURE,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_CURSE,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_CURSE,
		Encyclopedia.ItemPools.POOL_RED_CHEST,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("nekodoll") then
			self.Desc = "Complete Black Neko Dreams (challenge No.05w)"

			return self
		end
	end,
})
-- w06 Doppelganger
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.MICRO_DOPPELGANGER,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MICRO_DOPPELGANGER,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("microdoppelganger") and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_DOPP then
			self.Desc = "Complete Doppelganger (challenge No.06w)"

			return self
		end
	end,
})
-- w07 Delirium
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = t.DIMENSION_CUTTER,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.DIMENSION_CUTTER],
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("delirium") then
			self.Desc = "Complete Delirium (challenge No.07w)"
			return self
		end
	end,
})
-- w08 Sisters from Beyond
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.LIL_WAKABA,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LIL_WAKABA,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_BABY_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("lilwakaba") and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_SIST then
			self.Desc = "Complete Sisters From Beyond (challenge No.08w)"

			return self
		end
	end,
})
-- w09 Draw Five
-- w10 Rush Rush Hush
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.EXECUTIONER,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EXECUTIONER,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_CURSE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("executioner") then
			self.Desc = "Complete Rush Rush Hush (challenge No.10w)"

			return self
		end
	end,
})
-- w11 Apollyon Crisis
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.APOLLYON_CRISIS,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.APOLLYON_CRISIS,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
	UnlockFunc = function(self)
		if not REPENTOGON then
			self.Desc = "Requires REPENTOGON"
			return self
		end
		if not wakaba:IsEntryUnlocked("apollyoncrisis") then
			self.Desc = "Complete Apollyon Crisis (challenge No.11w)"

			return self
		end
	end,
})
-- w12 Delivery System
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.ISEKAI_DEFINITION,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.ISEKAI_DEFINITION,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_BABY_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("deliverysystem") then
			self.Desc = "Complete Delivery System (challenge No.12w)"

			return self
		end
	end,
})
-- w13 Calculation
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.BALANCE,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BALANCE,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_BEGGAR,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("calculation") then
			self.Desc = "Complete Calculation (challenge No.13w)"

			return self
		end
	end,
})
-- w14 Hold Me
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.LIL_MAO,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LIL_MAO,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_BABY_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("lilmao") and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_HOLD then
			self.Desc = "Complete Hold Me (challenge No.14w)"

			return self
		end
	end,
})
-- w15 Even or Odd
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.RICHERS_FLIPPER,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RICHERS_FLIPPER,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_BEGGAR,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("richerflipper") then
			self.Desc = "Complete Even or Odd (challenge No.15w)"

			return self
		end
	end,
})
-- w16 Runaway Pheromones
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.RICHERS_NECKLACE,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RICHERS_NECKLACE,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("richernecklace") then
			self.Desc = "Complete Runaway Pheromones (challenge No.16w)"

			return self
		end
	end,
})
-- TODO w17 The Floor is Lava
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.CROSS_BOMB,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CROSS_BOMB,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_BOMB_BUM,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("crossbomb") then
			self.Desc = "Complete The Floor is Lava (challenge No.17w)"

			return self
		end
	end,
})
-- TODO w18 Universe of Goom
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.GOOMBELLA,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.GOOMBELLA,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
	Hide = true,
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("goombella") then
			self.Desc = "Complete Universe of Goom (challenge No.18w)"

			return self
		end
	end,
})
-- TODO w19 Heavy Liquid
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.BUBBLE_BOMBS,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BUBBLE_BOMBS,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_BOMB_BUM,
	},
	Hide = true,
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("bubblebombs") then
			self.Desc = "Complete Heavy Liquid (challenge No.19w)"

			return self
		end
	end,
})

-- w98 Hyper Random
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.WAKABAS_CURFEW,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_CURFEW,
})
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.WAKABAS_CURFEW2,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_CURFEW,
	Hide = true,
})
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.EDEN_STICKY_NOTE,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.EDEN_STICKY_NOTE,
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("edensticky") then
			self.Desc = "Complete Hyper Random (challenge No.98w)"
			return self
		end
	end,
})
-- w99 True Purist Girl
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = i.DOUBLE_DREAMS,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.DOUBLE_DREAMS,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_LIBRARY,
	},
	UnlockFunc = function(self)
		if not wakaba:IsEntryUnlocked("doubledreams") and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_DRMS then
			self.Desc = "Complete True Purist Girl (challenge No.99w)"
			self.Hide = true
			return self
		end
	end,
})