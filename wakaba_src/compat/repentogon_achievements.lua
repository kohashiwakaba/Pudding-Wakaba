
wakaba:AddCallback(ModCallbacks.MC_POST_SAVESLOT_LOAD, function(_, saveslot, isSlotSelected, rawSlot)
	if wakaba.RepentogonUnlocks and wakaba.RepentogonUnlocks.taintedricher > 0 then return end
	-- key should be same as unlock entry key (wakaba.state.unlock)
	wakaba.RepentogonUnlocks = {
		--- Character
		--wakaba = Isaac.GetAchievementIdByName("Wakaba"),
		--shiori = Isaac.GetAchievementIdByName("Shiori"),
		--tsukasa = Isaac.GetAchievementIdByName("Tsukasa"),
		--richer = Isaac.GetAchievementIdByName("Richer"),
		--rira = Isaac.GetAchievementIdByName("Rira"),
		--- Character Tainted
		--taintedwakaba = Isaac.GetAchievementIdByName("The Fury"),
		--taintedshiori = Isaac.GetAchievementIdByName("The Minerva"),
		taintedtsukasa = Isaac.GetAchievementIdByName("The Phoenix"),
		taintedricher = Isaac.GetAchievementIdByName("The Miko"),
		--taintedrira = Isaac.GetAchievementIdByName("The Aqua"),
		--- Character Tarnished
		--tarnishedwakaba = Isaac.GetAchievementIdByName("The Root"),
		--tarnishedshiori = Isaac.GetAchievementIdByName("The Page"),
		--tarnishedtsukasa = Isaac.GetAchievementIdByName("The Loop"),
		--tarnishedricher = Isaac.GetAchievementIdByName("The Solar"),
		--tarnishedrira = Isaac.GetAchievementIdByName("The Ink"),

		-- Core items

		--- Wakaba unlocks
		clover = Isaac.GetAchievementIdByName("Clover"),
		counter = Isaac.GetAchievementIdByName("Counter"),
		pendant = Isaac.GetAchievementIdByName("Wakaba's Pendant"),
		dcupicecream = Isaac.GetAchievementIdByName("D-Cup Ice Cream"),
		revengefruit = Isaac.GetAchievementIdByName("Revenge Fruit"),
		donationcard = Isaac.GetAchievementIdByName("Wakaba's Dream Card"),
		colorjoker = Isaac.GetAchievementIdByName("Color Joker"),
		wakabauniform = Isaac.GetAchievementIdByName("Wakaba's Uniform"),
		whitejoker = Isaac.GetAchievementIdByName("White Joker"),
		confessionalcard = Isaac.GetAchievementIdByName("Confessional Card"),
		returnpostage = Isaac.GetAchievementIdByName("Return Postage"),
		secretcard = Isaac.GetAchievementIdByName("Secret Card"),
		cranecard = Isaac.GetAchievementIdByName("Crane Card"),
		blessing = Isaac.GetAchievementIdByName("Wakaba's Blessing"),

		--- Tainted Wakaba unlocks
		bookofforgotten = Isaac.GetAchievementIdByName("Book of Forgotten"),
		wakabasoul = Isaac.GetAchievementIdByName("Soul of Wakaba"),
		eatheart = Isaac.GetAchievementIdByName("Eat Heart"),
		cloverchest = Isaac.GetAchievementIdByName("Clover Chest"),
		bitcoin = Isaac.GetAchievementIdByName("Bitcoin II"),
		blackjoker = Isaac.GetAchievementIdByName("Black Joker"),
		nemesis = Isaac.GetAchievementIdByName("Wakaba's Nemesis"),

		--- Shiori unlocks
		hardbook = Isaac.GetAchievementIdByName("Hard Book"),
		shiorid6plus = Isaac.GetAchievementIdByName("Shiori holds D6 Plus"),
		deckofrunes = Isaac.GetAchievementIdByName("Shiori's Bottle of Runes"),
		bookoffocus = Isaac.GetAchievementIdByName("Book of Focus"),
		grimreaperdefender = Isaac.GetAchievementIdByName("Grimreaper Defender"),
		unknownbookmark = Isaac.GetAchievementIdByName("Unknown Bookmark"),
		bookoftrauma = Isaac.GetAchievementIdByName("Book of Trauma"),
		bookofsilence = Isaac.GetAchievementIdByName("Book of Silence"),
		bookoffallen = Isaac.GetAchievementIdByName("Book of The Fallen"),
		vintagethreat = Isaac.GetAchievementIdByName("Vintage Threat"),
		bookofthegod = Isaac.GetAchievementIdByName("Book of The God"),
		magnetheaven = Isaac.GetAchievementIdByName("Magnet Heaven"),
		determinationribbon = Isaac.GetAchievementIdByName("Determination Ribbon"),
		bookofshiori = Isaac.GetAchievementIdByName("Book of Shiori"),

		--- Tainted Shiori unlocks
		bookmarkbag = Isaac.GetAchievementIdByName("Bookmark Bag"),
		shiorisoul = Isaac.GetAchievementIdByName("Soul of Shiori"),
		bookofconquest = Isaac.GetAchievementIdByName("Book of Conquest"),
		shiorivalut = Isaac.GetAchievementIdByName("Shiori's Valut"),
		ringofjupiter = Isaac.GetAchievementIdByName("Ring of Jupiter"),
		queenofspades = Isaac.GetAchievementIdByName("Queen of Spades"),
		minervaaura = Isaac.GetAchievementIdByName("Minerva's Aura"),

		--- Tsukasa unlocks
		murasame = Isaac.GetAchievementIdByName("Murasame"),
		nasalover = Isaac.GetAchievementIdByName("Nasa Lover"),
		redcorruption = Isaac.GetAchievementIdByName("Red Corruption"),
		beetlejuice = Isaac.GetAchievementIdByName("Beetlejuice"),
		powerbomb = Isaac.GetAchievementIdByName("Power Bomb"),
		concentration = Isaac.GetAchievementIdByName("Concentration"),
		rangeos = Isaac.GetAchievementIdByName("Range OS"),
		newyearbomb = Isaac.GetAchievementIdByName("New Year's Eve Bomb"),
		plasmabeam = Isaac.GetAchievementIdByName("Plasma Beam"),
		phantomcloak = Isaac.GetAchievementIdByName("Phantom Cloak"),
		magmablade = Isaac.GetAchievementIdByName("Magma Blade"),
		arcanecrystal = Isaac.GetAchievementIdByName("Arcane Crystal"),
		questionblock = Isaac.GetAchievementIdByName("Question Block"),
		lunarstone = Isaac.GetAchievementIdByName("Lunar Stone"),

		--- Tainted Tsukasa unlocks
		isaaccartridge = Isaac.GetAchievementIdByName("Isaac Cartridge"),
		tsukasasoul = Isaac.GetAchievementIdByName("Soul of Tsukasa"),
		easteregg = Isaac.GetAchievementIdByName("Easter Egg"),
		sirenbadge = Isaac.GetAchievementIdByName("Siren's Badge"),
		flashshift = Isaac.GetAchievementIdByName("Flash Shift"),
		returntoken = Isaac.GetAchievementIdByName("Return Token"),
		elixiroflife = Isaac.GetAchievementIdByName("Elixir of Life"),

		--- Richer unlocks
		fireflylighter = Isaac.GetAchievementIdByName("Firefly Lighter"),
		sweetscatalog = Isaac.GetAchievementIdByName("Sweets Catalog"),
		doubleinvader = Isaac.GetAchievementIdByName("Double Invader"),
		antibalance = Isaac.GetAchievementIdByName("Anti Balance"),
		venomincantation = Isaac.GetAchievementIdByName("Venom Incantation"),
		bunnyparfait = Isaac.GetAchievementIdByName("Bunny Parfait"),
		richeruniform = Isaac.GetAchievementIdByName("Richer's Uniform"),
		prestigepass = Isaac.GetAchievementIdByName("Prestige Pass"),
		printer = Isaac.GetAchievementIdByName("3D Printer"),
		cunningpaper = Isaac.GetAchievementIdByName("Cunning Paper"),
		selfburning = Isaac.GetAchievementIdByName("Self Burning"),
		clensingfoam = Isaac.GetAchievementIdByName("Clensing Foam"),
		lilricher = Isaac.GetAchievementIdByName("Lil Richer"),
		rabbitribbon = Isaac.GetAchievementIdByName("Rabbit Ribbon"),


		starreversal = Isaac.GetAchievementIdByName("Star Reversal"),
		richersoul = Isaac.GetAchievementIdByName("Soul of Richer"),
		waterflame = Isaac.GetAchievementIdByName("Water-Flame"),
		crystalrestock = Isaac.GetAchievementIdByName("Crystal Restock Machine"),
		eternitycookie = Isaac.GetAchievementIdByName("Eternity Cookie"),
		trialstew = Isaac.GetAchievementIdByName("Trial Stew"),
		winteralbireo = Isaac.GetAchievementIdByName("The Winter Albireo"),

		--- Rira unlocks
		--BLACK_BEAN_MOCHI = Isaac.GetAchievementIdByName("Black Bean Mochi"),
		--RIRAS_SWIMSUIT = Isaac.GetAchievementIdByName("Rira's Swimsuit"),
		--SAKURA_MONT_BLANC = Isaac.GetAchievementIdByName("Sakura Mont Blanc"),
		--NERF_GUN = Isaac.GetAchievementIdByName("Nerf Gun"),
		--RIRAS_BENTO = Isaac.GetAchievementIdByName("Rira's Bento"),
		--CHEWY_ROLLY_CAKE = Isaac.GetAchievementIdByName("Chewy Rolly Cake"),
		--RIRAS_COAT = Isaac.GetAchievementIdByName("Rira's Coat"),
		--CARAMELLA_PANCAKE = Isaac.GetAchievementIdByName("Caramella Pancake"),
		--SECRET_DOOR = Isaac.GetAchievementIdByName("Secret Door"),
		--RIRAS_BANDAGE = Isaac.GetAchievementIdByName("Rira's Bandage"),
		--POW_BLOCK = Isaac.GetAchievementIdByName("POW Block"),
		--MOD_BLOCK = Isaac.GetAchievementIdByName("MOd Block"),
		--CHIMAKI = Isaac.GetAchievementIdByName("Chimaki"),
		--LIL_RIRA = Isaac.GetAchievementIdByName("Lil Rira"),
		--SAKURA_CAPSULE = Isaac.GetAchievementIdByName("Sakura Capsule"),
		--MAID_DUET = Isaac.GetAchievementIdByName("Maid Duet"),
		--RABBIT_PILLOW = Isaac.GetAchievementIdByName("Rabbit Pillow"),

		--- Tarnished Wakaba unlocks
		--- Tarnished Shiori unlocks
		--- Tarnished Tsukasa unlocks
		--- Tarnished Richer unlocks
		--- Tarnished Rira unlocks

		--- Challenge unlocks
		eyeofclock = Isaac.GetAchievementIdByName("Eye of Clock"),
		plumy = Isaac.GetAchievementIdByName("Plumy"),
		--PLUMY = Isaac.GetAchievementIdByName("Plumy"),
		delimiter = Isaac.GetAchievementIdByName("Delimiter"),
		nekodoll = Isaac.GetAchievementIdByName("Neko Figure"),
		microdoppelganger = Isaac.GetAchievementIdByName("Micro Doppelganger"),
		delirium = Isaac.GetAchievementIdByName("Dimension Cutter"),
		lilwakaba = Isaac.GetAchievementIdByName("Lil Wakaba"),
		lostuniform = Isaac.GetAchievementIdByName("Lost Holds Uniform"),
		executioner = Isaac.GetAchievementIdByName("Executioner"),
		apollyoncrisis = Isaac.GetAchievementIdByName("Apollyon Crisis"),
		deliverysystem = Isaac.GetAchievementIdByName("Isekai Definition"),
		calculation = Isaac.GetAchievementIdByName("Balance ecnalaB"),
		lilmao = Isaac.GetAchievementIdByName("Lil Mao"),
		richerflipper = Isaac.GetAchievementIdByName("Richer's Flipper"),
		richernecklace = Isaac.GetAchievementIdByName("Richer's Necklace"),
		crossbomb = Isaac.GetAchievementIdByName("Cross Bomb"),
		goombella = Isaac.GetAchievementIdByName("Goombella"),
		edensticky = Isaac.GetAchievementIdByName("Eden's Sticky Note"),
		doubledreams = Isaac.GetAchievementIdByName("Wakaba's Double Dreams"),

		-- Misc unlocks
		WAKABA_DUALITY = Isaac.GetAchievementIdByName("Wakaba Duality"),
	}
end)