--[[

rollItem code originally by Mana, modified for Eat Heart, Wakaba's Blessing, Wakaba's Nemesis

]]

local isc = require("wakaba_src.libs.isaacscript-common")
local randselected = false

local selecteditems = {}

local randPool = {
	ItemPoolType.POOL_TREASURE,
	ItemPoolType.POOL_SHOP,
	ItemPoolType.POOL_BOSS,
	ItemPoolType.POOL_DEVIL,
	ItemPoolType.POOL_ANGEL,
	ItemPoolType.POOL_SECRET,
	ItemPoolType.POOL_CURSE,
	ItemPoolType.POOL_CRANE_GAME,
	ItemPoolType.POOL_PLANETARIUM,
}
function wakaba:cardUnlockCheck(card)
	if not wakaba.state.achievementPopupShown or wakaba.state.options.allowlockeditems then return true end
	local isUnlocked = true

	if card == wakaba.Enums.Cards.CARD_DREAM_CARD and wakaba.state.unlock.donationcard < 1 then
		isUnlocked = false
	end
	if card == wakaba.Enums.Cards.CARD_COLOR_JOKER and wakaba.state.unlock.colorjoker < 1 then
		isUnlocked = false
	end
	if card == wakaba.Enums.Cards.CARD_WHITE_JOKER and wakaba.state.unlock.whitejoker < 1 then
		isUnlocked = false
	end
	if card == wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD and wakaba.state.unlock.confessionalcard < 1 then
		isUnlocked = false
	end
	if card == wakaba.Enums.Cards.CARD_CRANE_CARD and wakaba.state.unlock.cranecard < 1 then
		isUnlocked = false
	end
	
	if card == wakaba.Enums.Cards.CARD_BLACK_JOKER and wakaba.state.unlock.blackjoker < 2 then
		isUnlocked = false
	end
	
	if card == wakaba.Enums.Cards.SOUL_WAKABA and not wakaba.state.unlock.wakabasoul then
		isUnlocked = false
	end
	if card == wakaba.Enums.Cards.SOUL_WAKABA2 and not wakaba.state.unlock.wakabasoul then
		isUnlocked = false
	end

	if card == wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK and wakaba.state.unlock.unknownbookmark < 1 then
		isUnlocked = false
	end
	
	if card == wakaba.Enums.Cards.CARD_VALUT_RIFT and wakaba.state.unlock.shiorivalut < 1 then
		isUnlocked = false
	end

	if card == wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES and wakaba.state.unlock.queenofspades < 2 then
		isUnlocked = false
	end
	
	if card == wakaba.Enums.Cards.SOUL_SHIORI and not wakaba.state.unlock.shiorisoul then
		isUnlocked = false
	end

	if card == wakaba.Enums.Cards.CARD_RETURN_TOKEN and wakaba.state.unlock.returntoken < 2 then
		isUnlocked = false
	end
	
	if card == wakaba.Enums.Cards.SOUL_TSUKASA and not wakaba.state.unlock.tsukasasoul then
		isUnlocked = false
	end

	return isUnlocked
end

function wakaba:trinketUnlockCheck(trinket)
	if wakaba.G.Challenge == Challenge.CHALLENGE_PICA_RUN then return true end
	local isUnlocked = true

	if trinket == wakaba.Enums.Trinkets.BITCOIN and wakaba.state.unlock.bitcoin < 1 then
		isUnlocked = false
	end
	if trinket == wakaba.Enums.Trinkets.CLOVER and wakaba.state.unlock.clover < 1 then
		isUnlocked = false
	end
	if trinket == wakaba.Enums.Trinkets.MAGNET_HEAVEN and wakaba.state.unlock.magnetheaven < 1 then
		isUnlocked = false
	end
	if trinket == wakaba.Enums.Trinkets.DETERMINATION_RIBBON and wakaba.state.unlock.determinationribbon < 1 then
		isUnlocked = false
	end
	if trinket == wakaba.Enums.Trinkets.HARD_BOOK and wakaba.state.unlock.hardbook < 1 then
		isUnlocked = false
	end
	if trinket == wakaba.Enums.Trinkets.BOOKMARK_BAG and not wakaba.state.unlock.bookmarkbag then
		isUnlocked = false
	end
	if trinket == wakaba.Enums.Trinkets.RING_OF_JUPITER and wakaba.state.unlock.ringofjupiter < 1 then
		isUnlocked = false
	end
	if trinket == wakaba.Enums.Trinkets.RANGE_OS and wakaba.state.unlock.rangeos < 1 then
		isUnlocked = false
	end
	
	if trinket == wakaba.Enums.Trinkets.SIREN_BADGE and wakaba.state.unlock.sirenbadge < 1 then
		isUnlocked = false
	end
	
	if trinket == wakaba.Enums.Trinkets.ISAAC_CARTRIDGE and not wakaba.state.unlock.isaaccartridge then
		isUnlocked = false
	end
	
	if trinket == wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE and not wakaba.state.unlock.isaaccartridge then
		isUnlocked = false
	end
	
	if trinket == wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE and not wakaba.state.unlock.isaaccartridge then
		isUnlocked = false
	end

	if trinket == wakaba.Enums.Trinkets.DIMENSION_CUTTER and not wakaba.state.unlock.delirium then
		isUnlocked = false
	end

	if trinket == wakaba.Enums.Trinkets.DELIMITER and not wakaba.state.unlock.delimiter then
		isUnlocked = false
	end

	return isUnlocked
end

function wakaba:GetTrinket_UnlockCheck(selected, rng)
	if not wakaba.state.achievementPopupShown or wakaba.state.options.allowlockeditems then return selected end
	if not wakaba:trinketUnlockCheck(selected) then
		return wakaba.G:GetItemPool():GetTrinket()
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_TRINKET, wakaba.GetTrinket_UnlockCheck)


local skipGetCard
local getCardRNG
function wakaba:GetCard_UnlockCheck(_, card, canSuit, canRune, onlyRune)
	if wakaba.G:GetFrameCount() == 0 then return end
	--Isaac.DebugString("[wakaba]Getting Cards "..card.." skipGetCard : "..(skipGetCard))
	if not getCardRNG then
		wakaba.runstate.cardRngSeed = wakaba.runstate.cardRngSeed or wakaba.G:GetSeeds():GetStartSeed()
		getCardRNG = RNG()
		getCardRNG:SetSeed(wakaba.runstate.cardRngSeed, 35)
	end

	if not skipGetCard then
		local returnValue = card
		local itempool = wakaba.G:GetItemPool()
		skipGetCard = true

		local forceReroll = wakaba:cardUnlockCheck(card, getCardRNG) == false
		local nemesis = isc:anyPlayerHasCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS) or isc:anyPlayerHasCollectible(wakaba.Enums.Collectibles.NEKO_FIGURE) or isc:anyPlayerIs(wakaba.Enums.Players.WAKABA_B)

		if canRune and not onlyRune then -- Objects allowed to spawn
			if nemesis and card ~= Card.CARD_HOLY and Isaac.GetItemConfig():GetCard(Card.CARD_CRACKED_KEY):IsAvailable() then
				local spawnChance = 0
				if wakaba.G.Difficulty == Difficulty.DIFFICULTY_NORMAL then
					spawnChance = 0.25
				elseif wakaba.G.Difficulty == Difficulty.DIFFICULTY_HARD then
					spawnChance = 0.115
				end
				if getCardRNG:RandomFloat() < spawnChance then
					returnValue = Card.CARD_CRACKED_KEY
					goto getCardEnd
				end
			end
		end

		if forceReroll then
			local new
			local i = 0

			repeat
				new = itempool:GetCard(getCardRNG:Next(), canSuit, canRune, onlyRune)
				--Isaac.DebugString("[wakaba]Try to getting Cards "..card.." new : "..new)
				i = i + 1
			until wakaba:cardUnlockCheck(new, getCardRNG)

			returnValue = new
		end

		::getCardEnd::
		skipGetCard = false
		wakaba.runstate.cardRngSeed = getCardRNG:GetSeed()
		if returnValue == card then
			-- We didn't change the spawned card. Return nil to avoid stepping the toes of other mods trying to do card replacements.
			return nil
		end
		return returnValue
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_GET_CARD, CallbackPriority.LATE, wakaba.GetCard_UnlockCheck)
--[[ 
function wakaba:GetCard_UnlockCheck(rng, currentCard, playing, runes, onlyRunes)
	if not wakaba.state.achievementPopupShown or wakaba.state.options.allowlockeditems then return currentCard end
	local hasDreams = false
	for num = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(num - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS) then
			hasDreams = true
		end
	end

	if not wakaba.state.options.allowlockeditems and not wakaba:cardUnlockCheck(currentCard) then
		if currentCard == wakaba.Enums.Cards.CARD_DREAM_CARD and hasDreams then
			-- Do Nothing
		else
			return wakaba.G:GetItemPool():GetCard(rng:Next(), playing, runes, onlyRunes)
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_GET_CARD, CallbackPriority.LATE, wakaba.GetCard_UnlockCheck)
 ]]
function wakaba:unlockCheck(item, pool)
	if not wakaba.state.achievementPopupShown or wakaba.state.options.allowlockeditems then return true end
	local isUnlocked = true

	if item == wakaba.Enums.Collectibles.WAKABAS_BLESSING and wakaba.state.unlock.blessing ~= true then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.BOOK_OF_SHIORI and wakaba.state.unlock.bookofshiori ~= true then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.PLUMY and wakaba.state.unlock.plumy ~= true then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.EXECUTIONER and wakaba.state.unlock.executioner ~= true then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN and wakaba.state.unlock.bookofforgotten ~= true then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.EYE_OF_CLOCK and wakaba.state.unlock.eyeofclock ~= true then
		isUnlocked = false
	end
	
	if item == wakaba.Enums.Collectibles.MICRO_DOPPELGANGER and wakaba.state.unlock.microdoppelganger ~= true then
		isUnlocked = false
	end
	
	if item == wakaba.Enums.Collectibles.APOLLYON_CRISIS and wakaba.state.unlock.apollyoncrisis ~= true then
		isUnlocked = false
	end
	
	if item == wakaba.Enums.Collectibles.NEKO_FIGURE and wakaba.state.unlock.nekodoll ~= true then
		isUnlocked = false
	end

	if item == wakaba.Enums.Collectibles.LIL_WAKABA and wakaba.state.unlock.lilwakaba ~= true then
		isUnlocked = false
	end

	if item == wakaba.Enums.Collectibles.ISEKAI_DEFINITION and wakaba.state.unlock.deliverysystem ~= true then
		isUnlocked = false
	end

	if item == wakaba.Enums.Collectibles.BALANCE and wakaba.state.unlock.calculation ~= true then
		isUnlocked = false
	end

	if item == wakaba.Enums.Collectibles.DOUBLE_DREAMS and wakaba.state.unlock.doubledreams ~= true then
		isUnlocked = false
	end
	
	if item == wakaba.Enums.Collectibles.WAKABAS_NEMESIS and wakaba.state.unlock.nemesis < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.EATHEART and wakaba.state.unlock.eatheart < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.D_CUP_ICECREAM and wakaba.state.unlock.dcupicecream < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.WAKABAS_PENDANT and wakaba.state.unlock.pendant < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.SECRET_CARD and wakaba.state.unlock.secretcard < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.NEW_YEAR_BOMB and wakaba.state.unlock.newyearbomb < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.UNIFORM and wakaba.state.unlock.wakabauniform < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.COUNTER and wakaba.state.unlock.counter < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.RETURN_POSTAGE and wakaba.state.unlock.returnpostage < 1 then
		isUnlocked = false
	end


	if item == wakaba.Enums.Collectibles.BOOK_OF_FOCUS and wakaba.state.unlock.bookoffocus < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.DECK_OF_RUNES and wakaba.state.unlock.deckofrunes < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER and wakaba.state.unlock.grimreaperdefender < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN and wakaba.state.unlock.bookoffallen < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.BOOK_OF_TRAUMA and wakaba.state.unlock.bookoftrauma < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.BOOK_OF_SILENCE and wakaba.state.unlock.bookofsilence < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.VINTAGE_THREAT and wakaba.state.unlock.vintagethreat < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.BOOK_OF_THE_GOD and wakaba.state.unlock.bookofthegod < 1 then
		isUnlocked = false
	end


	if item == wakaba.Enums.Collectibles.BOOK_OF_CONQUEST and wakaba.state.unlock.bookofconquest < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.MINERVA_AURA and wakaba.state.unlock.minervaaura < 1 then
		isUnlocked = false
	end

	if item == wakaba.Enums.Collectibles.MURASAME and wakaba.state.unlock.murasame < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.NASA_LOVER and wakaba.state.unlock.nasalover < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.RED_CORRUPTION and wakaba.state.unlock.redcorruption < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.BEETLEJUICE and wakaba.state.unlock.beetlejuice < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.POWER_BOMB and wakaba.state.unlock.powerbomb < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.CONCENTRATION and wakaba.state.unlock.concentration < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.PLASMA_BEAM and wakaba.state.unlock.plasmabeam < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.PHANTOM_CLOAK and wakaba.state.unlock.phantomcloak < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.MAGMA_BLADE and wakaba.state.unlock.magmablade < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.ARCANE_CRYSTAL and wakaba.state.unlock.arcanecrystal < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.ADVANCED_CRYSTAL and wakaba.state.unlock.arcanecrystal < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.MYSTIC_CRYSTAL and wakaba.state.unlock.arcanecrystal < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.QUESTION_BLOCK and wakaba.state.unlock.queenofspades < 1 then
		isUnlocked = false
	end

	if item == wakaba.Enums.Collectibles.LUNAR_STONE and wakaba.state.unlock.lunarstone ~= true then
		isUnlocked = false
	end

	if item == wakaba.Enums.Collectibles.FLASH_SHIFT and wakaba.state.unlock.flashshift < 1 then
		isUnlocked = false
	end
	if item == wakaba.Enums.Collectibles.ELIXIR_OF_LIFE and wakaba.state.unlock.elixiroflife < 1 then
		isUnlocked = false
	end



	return isUnlocked
end

local function IsRangeCorrect(selected, isaacOnly, aftOnly, repOnly)
	if not selected then return true end
	if selected == CollectibleType.COLLECTIBLE_BIRTHRIGHT then return true end
	if not (isaacOnly or aftOnly or repOnly) then return true end
	local isModded = selected > CollectibleType.COLLECTIBLE_MOMS_RING
	if repOnly then
		return selected <= CollectibleType.COLLECTIBLE_MOMS_RING or selected == CollectibleType.COLLECTIBLE_CLEAR_RUNE
	elseif aftOnly then
		return selected <= CollectibleType.COLLECTIBLE_MOMS_SHOVEL
	elseif isaacOnly then
		return isModded or (selected < CollectibleType.COLLECTIBLE_DIPLOPIA and selected ~= CollectibleType.COLLECTIBLE_CLEAR_RUNE)
	end
end

local lastSelected = nil
local initialItemNext = false
local flipItemNext = false
local lastGetItemResult = {nil, nil, nil, nil} -- itemID, Frame, gridIndex, InitSeed
local lastFrameGridChecked = 0

function wakaba:rollCheck(selected, itemPoolType, decrease, seed)

	local validQuality = {
		["0"] = true,
		["1"] = true,
		["2"] = true,
		["3"] = true,
		["4"] = true,
	}

	local preConditionMet = false
	if wakaba.state.rerollloopcount == 0 then
		lastSelected = selected
	end
	
	--if not decrease then return end

	if wakaba.G:GetFrameCount() == 0 then return end
	-- Unlock check and Flip interaction for External Item Description
	if seed == 1 then return end 
	-- Reverie - Touhou Combinations loads item pool from startup to generate item pool cache, which crashes the game if selected is -1, which is for TMTRAINER items.
	if selected and selected <= 0 then
		return
	end
	-- Library Expanded : Do not check reroll in Library Certifiate area
	if LibraryExpanded and LibraryExpanded:IsLibraryCertificateRoom() then return end
	
	if (wakaba.G.Challenge == wakaba.challenges.CHALLENGE_HOLD) then
		return wakaba.Enums.Collectibles.CLOVER_SHARD
	end

	wakaba.state.rerollloopcount = wakaba.state.rerollloopcount or 0

	local pool = wakaba.G:GetItemPool()
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	local config = Isaac.GetItemConfig()
	local AllowActives = wakaba.roomstate.allowactives
	local defaultPool = itemPoolType or ItemPoolType.POOL_NULL

	local hasDejaVu = false
	local hasSacredOrb = false
	local hasNeko = false
	local hasAntiBalance = false

	local eatHeartUsed = false
	local eatHeartCharges = 0
	local estimatedPlayerCount = 0
	local hasIsaacCartridge = false
	local hasAftCartridge = false
	local hasRepCartridge = false
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_TMTRAINER) then
			return
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_FLIP) and not decrease then
			--return
		end
		if player.Variant == 0 then
			estimatedPlayerCount = estimatedPlayerCount + 1
			-- not implemented yet
			if player:HasTrinket(wakaba.Enums.Trinkets.ISAAC_CARTRIDGE) or 
			(player:GetPlayerType() == wakaba.Enums.Players.TSUKASA and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT))
			then
				hasIsaacCartridge = true
			end
			if player:HasTrinket(wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE) then
				hasAftCartridge = true
			end
			if player:HasTrinket(wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE) then
				hasRepCartridge = true
			end
		end
		local pData = player:GetData()
		if player:HasCollectible(wakaba.Enums.Collectibles.DEJA_VU) then
			hasDejaVu = true
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_SACRED_ORB) then
			hasSacredOrb = true
		end
		if player:HasCollectible(wakaba.Enums.Collectibles.NEKO_FIGURE) then
			hasNeko = true
		end
		if pData.wakaba and pData.wakaba.eatheartused then
			eatHeartUsed = true
			eatHeartCharges = pData.wakaba.eatheartcharges
		end
	end

	if wakaba.roomstate.allowactives == nil then
		AllowActives = true
	end
	if wakaba.fullreroll then
		AllowActives = false
	end

	local itemType = defaultPool
	
	if wakaba.runstate.dreampool ~= ItemPoolType.POOL_NULL and wakaba.state.rerollloopcount <= 5 then
		itemType = wakaba.runstate.dreampool
		AllowActives = false
	end

	-- Was trying to check Devil's crown, but doesn't work, there are RoomDescriptor.FLAG_DEVIL_TREASURE, which cannot be accessable yet.
	if wakaba.runstate.dreampool == ItemPoolType.POOL_NULL and level:GetCurrentRoomDesc().Flags & RoomDescriptor.FLAG_DEVIL_TREASURE == RoomDescriptor.FLAG_DEVIL_TREASURE then
		itemType = ItemPoolType.POOL_DEVIL
	end
	
	if (wakaba.G.Challenge == wakaba.challenges.CHALLENGE_RAND) then
		itemType = randPool[math.random(1,#randPool)]
		randselected = true
	end

	local isPoolCorrect = (itemPoolType == itemType) or randselected
	local isRangeCorrect = selected and IsRangeCorrect(selected, hasIsaacCartridge, hasAftCartridge, hasRepCartridge)
	local isUnlocked = selected and wakaba:unlockCheck(selected)
	local MinQuality = 0
	local MaxQuality = 4
	if eatHeartUsed then
		--decrease = false
		local rng = RNG()
		rng:SetSeed(seed, 35)
		local chance = rng:RandomFloat() * 480000
		if eatHeartCharges >= 240000 then
			if chance <= eatHeartCharges then MinQuality = 4 else MinQuality = 3 end
		end
	elseif hasNeko and wakaba.G:GetRoom():GetType() == RoomType.ROOM_ULTRASECRET then
		MinQuality = 3
	elseif not eatHeartUsed and wakaba.runstate.hasnemesis and not wakaba.runstate.hasbless and not wakaba.state.options.blessnemesisqualityignore and not hasSacredOrb then
		local rng = RNG()
		rng:SetSeed(seed, 35)
		local chance = rng:RandomFloat()
		if wakaba.G:GetRoom():GetType() == RoomType.ROOM_ULTRASECRET or itemType == ItemPoolType.POOL_ULTRA_SECRET then
			MinQuality = 3
		elseif chance < 0.5 then
			MaxQuality = 2
		else
			MaxQuality = 3
		end
	elseif not eatHeartUsed and not wakaba.runstate.hasnemesis and wakaba.runstate.hasbless and not wakaba.state.options.blessnemesisqualityignore then
		MinQuality = 2
	end

	local itemConfig = config:GetCollectible(selected)
	local active = (AllowActives == true) and true or (itemConfig.Type == ItemType.ITEM_PASSIVE or itemConfig.Type == ItemType.ITEM_FAMILIAR)
	local min_quality = MinQuality == 0 and true or itemConfig.Quality >= MinQuality
	local max_quality = MaxQuality == 4 and true or (itemConfig.Quality <= MaxQuality or selected == wakaba.Enums.Collectibles.WAKABAS_BLESSING or selected == CollectibleType.COLLECTIBLE_BIRTHRIGHT)
	local valid_quality = validQuality[tostring(itemConfig.Quality)]

	--check time
	-- No reroll when should not change Fair Options at the Start? mod
	if FairOptionsConfig and not FairOptionsConfig.Disabled then
		local level = wakaba.G:GetLevel()
		if FairOptionsConfig.IsAffectedRoom ~= nil and FairOptionsConfig:IsAffectedRoom() and wakaba.pedestalreroll then
			index = (FairOptionsConfig.RerollCount % FairOptionsConfig.RerollItemsNumber) + 1
			if FairOptionsConfig.RerollCount < 1 and index ~= 1 then return end
		end
	end

	-- Check Deja Vu spawn after Fair Options at the Start? mod check
	-- Don't check Deja Vu again if conditions are not met
	if wakaba.state.rerollloopcount == 0 and hasDejaVu and itemConfig.Quality <= 2 then
		local candidates = wakaba:ReadDejaVuCandidates()
		
		local rng = RNG()
		rng:SetSeed(Random(), 35)
		local chance = rng:RandomInt(10000)
		if chance <= 1250 then
			local rng2 = RNG()
			rng2:SetSeed(wakaba.G:GetRoom():GetSpawnSeed(), 35)
			local TargetIndex = rng2:RandomInt(#candidates) + 1
			pool:AddRoomBlacklist(candidates[TargetIndex])
			preConditionMet = true
			selected = candidates[TargetIndex]
		end
	end


	-- Print time
	local isConditionMet = (isPoolCorrect and isRangeCorrect and active and isUnlocked and min_quality and max_quality and valid_quality)
	local str_ispassed = (isConditionMet and "passed") or "not passed"
	Isaac.DebugString("[wakaba] Rerolling items - #" .. wakaba.state.rerollloopcount .. ", Item No." .. selected .. " is " ..str_ispassed)
	--print("[wakaba] Rerolling items - seed "..seed.."#"..wakaba.state.rerollloopcount..", Item No."..selected.." is "..str_ispassed,itemType,decrease)

	pool:AddRoomBlacklist(selected)
	if not preConditionMet and not isConditionMet and wakaba.state.rerollloopcount <= wakaba.state.options.rerollbreakfastthreshold then
		wakaba.state.rerollloopcount = wakaba.state.rerollloopcount + 1
		-- Change roll pool into Treasure if too much (Default : 120)
		if wakaba.state.rerollloopcount > wakaba.state.options.rerolltreasurethreshold then
			itemType = ItemPoolType.POOL_TREASURE
		end
		if FairOptionsConfig and not FairOptionsConfig.Disabled and FairOptionsConfig.RerollCount > 0 then
			if FairOptionsConfig:IsAffectedRoom() and wakaba.pedestalreroll then
				FairOptionsConfig.RerollCount = FairOptionsConfig.RerollCount - 1
			end
		end
		local nextRNG = RNG()
		nextRNG:SetSeed(seed, 35)
		return pool:GetCollectible(itemType, decrease, nextRNG:Next(), CollectibleType.COLLECTIBLE_BREAKFAST)
	else
		wakaba.state.rerollloopcount = 0
		wakaba.runstate.spent = false
		wakaba.runstate.eatheartused = false
		if wakaba.state.rerollloopcount >= wakaba.state.options.rerollbreakfastthreshold then
			selected = CollectibleType.COLLECTIBLE_BREAKFAST
		end
		
		randselected = false
		-- TODO : also Flip data for EID
		table.insert(selecteditems, selected)
		if EID then
			if wakaba.runstate.dreampool ~= ItemPoolType.POOL_NULL or itemPoolType == ItemPoolType.POOL_CRANE_GAME then
				for _, crane in ipairs(Isaac.FindByType(6, 16, -1, true, false)) do
					--print(tostring(crane.InitSeed), crane.DropSeed, EID.CraneItemType[tostring(crane.InitSeed)], EID.CraneItemType[tostring(crane.InitSeed).."Drop"..crane.DropSeed])
					if not crane:GetSprite():IsPlaying("Broken") then
						if EID.CraneItemType[tostring(crane.InitSeed)] then
							if EID.CraneItemType[tostring(crane.InitSeed)] == lastSelected then
								EID.CraneItemType[tostring(crane.InitSeed)] = selected
							end--[[ 
							if not EID.CraneItemType[tostring(crane.InitSeed).."Drop"..crane.DropSeed] or EID.CraneItemType[tostring(crane.InitSeed).."Drop"..crane.DropSeed] == lastSelected then
								EID.CraneItemType[tostring(crane.InitSeed).."Drop"..crane.DropSeed] = selected
							end ]]
						end
					end
				end
			end

			local curRoomIndex = wakaba.G:GetLevel():GetCurrentRoomDesc().ListIndex
			for _, item in ipairs(Isaac.FindByType(5, 100, -1, true, false)) do
				if EID.flipItemPositions[curRoomIndex] 
				and EID.flipItemPositions[curRoomIndex][item.InitSeed]
				and EID.flipItemPositions[curRoomIndex][item.InitSeed][1] == lastSelected 
				and EID.flipItemPositions[curRoomIndex][item.InitSeed][2] == wakaba.G:GetRoom():GetGridIndex(item.Position)
				then
					EID.flipItemPositions[curRoomIndex][item.InitSeed][1] = selected
				end
			end

		end
		pool:ResetRoomBlacklist()
		return selected
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, wakaba.rollCheck)

function wakaba:rerollCooltime()
	if #selecteditems > 0 then
		local str = ""
		for i = 1, #selecteditems do
			str = str .. selecteditems[i]
			if i ~= #selecteditems then
				str = str .. ", "
			end
		end
		--print("[wakaba] selected items :", str)
		selecteditems = {}
	end
	if wakaba.rerollcooltime > -2 then
		wakaba.rerollcooltime = wakaba.rerollcooltime - 1
	else
		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			local pData = player:GetData()
			if player:GetData().wakaba and player:GetData().wakaba.eatheartused == true then
				player:GetData().wakaba.eatheartused = false
				player:GetData().wakaba.eatheartcharges = 0
			end
		end
	end
	if wakaba.rerollcooltime < 0 and wakaba.rerollcooltime > -2 then
		--print("nemesis check reset")
		
		wakaba.fullreroll = false
		if FairOptionsConfig and FairOptionsConfig.Disabled then
			FairOptionsConfig.Disabled = false
		end
		wakaba.G:GetItemPool():ResetRoomBlacklist()
	end

end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.rerollCooltime)

--[[
local function GetRoomItem(defaultPool, AllowActives, MinQuality, MaxQuality)
	defaultPool = defaultPool or ItemPoolType.POOL_TREASURE
	MinQuality = MinQuality or 0
	if AllowActives == nil then
		AllowActives = true
	end

	local itemType = pool:GetPoolForRoom(room:GetType(), room:GetAwardSeed())
	itemType = itemType > - 1 and itemType or defaultPool
	local collectible = pool:GetCollectible(itemType)

	if (not AllowActives or MinQuality > 0) then
		local itemConfig = config:GetCollectible(collectible)
		local active = (AllowActives == true) and true or itemConfig.Type == ItemType.ITEM_PASSIVE
		local quality = MinQuality == 0 and true or itemConfig.Quality >= MinQuality
		while not (quality and active) do
			collectible = pool:GetCollectible(itemType)
			itemConfig = config:GetCollectible(collectible)
			active = (AllowActives == true) and true or itemConfig.Type == ItemType.ITEM_PASSIVE
			quality = MinQuality == 0 and true or itemConfig.Quality >= MinQuality
		end
		print(itemConfig.Quality, itemConfig.Type == ItemType.ITEM_PASSIVE)
	end

	return collectible
end
]]


