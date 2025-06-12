local players = wakaba.Enums.Players
local i = wakaba.Enums.Collectibles
local t = wakaba.Enums.Trinkets
local c = wakaba.Enums.Cards
local p = wakaba.Enums.Pills

local class = "Pudding n Wakaba"

--#region Wakaba defaults
-- Bring Me There
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.BRING_ME_THERE,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.BRING_ME_THERE],
})
--Mysterious Game CD
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MYSTERIOUS_GAME_CD,
	Pools = {
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
	},
})
-- Moe's Muffin
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.MOE_MUFFIN,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MOE_MUFFIN,
	Pools = {
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_BEGGAR,
	},
})
-- Curse of the Tower 2
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CURSE_OF_THE_TOWER_2,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_CURSE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_CURSE,
		Encyclopedia.ItemPools.POOL_RED_CHEST,
	},
})
-- Jar of Clover
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.JAR_OF_CLOVER,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.JAR_OF_CLOVER,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
	},
})
-- D6 Plus
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.D6_PLUS,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.D6_PLUS,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
})
-- D6 Chaos
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.D6_CHAOS,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.D6_CHAOS,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
})
-- Lil Moe
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.LIL_MOE,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LIL_MOE,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_BABY_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
})
-- Lil Shiva
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.LIL_SHIVA,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.LIL_SHIVA,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
		Encyclopedia.ItemPools.POOL_BABY_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
})
--#endregion

--#region Shiori defaults
-- Minerva Ticket
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.CARD_MINERVA_TICKET,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_MINERVA_TICKET],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "Minerva Ticket",0),
})
-- Maijima Mythology
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MAIJIMA_MYTHOLOGY,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})
--#endregion

--#region Tsukasa defaults
-- Syrup
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.SYRUP,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SYRUP,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_BABY_SHOP,
	},
})
-- Crisis Boost
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.CRISIS_BOOST,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CRISIS_BOOST,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_BEGGAR,
	},
})
-- See Des Bischofs
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.SEE_DES_BISCHOFS,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SEE_DES_BISCHOFS,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_WOODEN_CHEST,
	},
})
-- Deja Vu
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.DEJA_VU,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.DEJA_VU,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})
--#endregion

--#region Richer defaults
-- Onsen Towel
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.ONSEN_TOWEL,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.ONSEN_TOWEL,
	Pools = {
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
	},
})
-- Richer's Report Card
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.REPORT_CARD,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.REPORT_CARD],
})
-- Mistake
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.MISTAKE,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.MISTAKE],
})
-- Kuromi Card
Encyclopedia.AddTrinket({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Trinkets.KUROMI_CARD,
	WikiDesc = wakaba.encyclopediadesc.desc.trinkets[t.KUROMI_CARD],
})
--#endregion

--#region Rira defaults
--Secret Door
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.SECRET_DOOR,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SECRET_DOOR,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_BEGGAR,
	},
})
--Rira's Bra
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.RIRAS_BRA,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RIRAS_BRA,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})
--Richer's Bra
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.RICHERS_BRA,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RICHERS_BRA,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})
--Kanae Lens
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.KANAE_LENS,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.KANAE_LENS,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
	},
})
--POW Block
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.POW_BLOCK,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.POW_BLOCK,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_BOMB_BUM,
	},
})
-- MOd Block
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.MOD_BLOCK,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MOD_BLOCK,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_BEGGAR,
	},
})
-- Rira's Coat
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.RIRAS_COAT,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.RIRAS_COAT,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_OLD_CHEST,
	},
})
-- Book of Amplitude
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BOOK_OF_AMPLITUDE,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})
-- Clear File
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.CLEAR_FILE,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.CLEAR_FILE,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
	UnlockFunc = function(self)
		if not REPENTOGON then
			self.Desc = "Requires REPENTOGON"
			return self
		end
	end,
})
-- Richer Ticket
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.CARD_RICHER_TICKET,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_RICHER_TICKET],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Richer Ticket",0),
})
-- Rira Ticket
Encyclopedia.AddCard({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Cards.CARD_RIRA_TICKET,
	WikiDesc = wakaba.encyclopediadesc.desc.cards[c.CARD_RIRA_TICKET],
	Spr = Encyclopedia.RegisterSprite(wakaba.modpath .. "content/gfx/ui_cardfronts.anm2", "wakaba_Rira Ticket",0),
})
--#endregion


--#region Tarnished defaults
--Mint Choco Icecream
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.MINT_CHOCO_ICECREAM,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
})
-- Wakaba's Hairpin
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.WAKABAS_HAIRPIN,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.WAKABAS_HAIRPIN,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
})
-- Succubus Blanket
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.SUCCUBUS_BLANKET,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.SUCCUBUS_BLANKET,
	Pools = {
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
	},
})
--#endregion

--TODO
--#region Unfinished items
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.BOOK_OF_SHIORI_FLOOR,
	Hide = true,
})
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.BOOK_OF_SHIORI_MISC,
	Hide = true,
})
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.BOOK_OF_SHIORI_ROOM,
	Hide = true,
})
-- Broken Toolbox
Encyclopedia.AddItem({
	Class = class,
	ModName = class,
	ID = wakaba.Enums.Collectibles.BROKEN_TOOLBOX,
	Hide = true,
	WikiDesc = wakaba.encyclopediadesc.desc.collectibles.BROKEN_TOOLBOX,
	Pools = {
	},
})
--#region