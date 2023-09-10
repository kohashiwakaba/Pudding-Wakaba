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
	return wakaba:IsCompletionItemUnlockedTemp(card, "card")
end

function wakaba:trinketUnlockCheck(trinket)
	if wakaba.G.Challenge == Challenge.CHALLENGE_PICA_RUN then return true end
	if not wakaba.state.achievementPopupShown or wakaba.state.options.allowlockeditems then return true end
	return wakaba:IsCompletionItemUnlockedTemp(trinket, "trinket")
end

function wakaba:GetTrinket_UnlockCheck(selected, rng)
	if not wakaba.state.achievementPopupShown or wakaba.state.options.allowlockeditems then

	elseif not wakaba:trinketUnlockCheck(selected) then
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
	Card Replacement(Booster Pack) check from Fiend Folio
	Modified for Pudding & Wakaba usage, expanding it with rune detection

  Booster Pack doesn't trigger MC_GET_CARD, so we have to handle that seperately.
]]
-- The last frame we detected a player obtaining a new copy of Booster Pack.
local boosterPackDetectedAt = nil
local boosterPackType = nil
local roomClearBoosterPack = false

wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
	boosterPackDetectedAt = nil
	boosterPackType = nil
end)
--[[
function wakaba:TrackBoosterPacks(player)
	boosterPackDetectedAt = wakaba.G:GetFrameCount() + 1
	boosterPackType = "booster"
	print(boosterPackDetectedAt)
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.TrackBoosterPacks, CollectibleType.COLLECTIBLE_BOOSTER_PACK)
 ]]
-- Detect when a player obtains a new copy of Booster Pack.

function wakaba:TrackBoosterPacks(player)
	local data = player:GetData()

	local prev = data.w_BoosterPackCount or 0
	local new = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BOOSTER_PACK, true)

	if new > prev then
		boosterPackDetectedAt = wakaba.G:GetFrameCount()
		boosterPackType = "booster"
	end

	data.w_BoosterPackCount = new
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.TrackBoosterPacks)

function wakaba:TakeDmg_TrackBoosterPacks(entity, amount, flag, source, countdownFrames)
	if flag & DamageFlag.DAMAGE_SPAWN_RUNE > 0 then
		--print("[wakaba] Rune spawn with enemy kill detected, Trying to reroll...")
		boosterPackDetectedAt = wakaba.G:GetFrameCount() + 1
		boosterPackType = "rune"
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, 30000, wakaba.TakeDmg_TrackBoosterPacks)

function wakaba:RuneBag_TrackBoosterPacks(familiar)
	local data = familiar:GetData()
	data.w_counter = data.w_counter or 0

	local prev = data.w_counter
	local new = familiar.RoomClearCount
	if new > prev then
		--print("[wakaba] Rune Bag spawn found, Trying to reroll...")
		boosterPackDetectedAt = wakaba.G:GetFrameCount()
		boosterPackType = "rune"
	end
	data.w_counter = new
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.RuneBag_TrackBoosterPacks, FamiliarVariant.RUNE_BAG)

-- Anti-recursion bit.
local fixingBoosterPackSpawn = false
-- On pickup init, if any player was detected obtaining a new copy of Booster Pack within the last frame, check if the card should be replaced.
-- Normally replacements are done on MC_GET_CARD, some situations don't trigger that callback for some reason.
--- Booster Pack
--- Rune Bag
--- Kill enemy with DamgeFlag.DAMAGE_SPAWN_RUNE
---@param pickup EntityPickup
function wakaba:CheckBoosterPackSpawn(pickup)
	if fixingBoosterPackSpawn or pickup:GetSprite():GetAnimation() ~= "Appear" then return end

	-- The card spawns from Booster Pack can occur prior to us detecting the Booster Pack in MC_POST_PEFFECT_UPDATE.
	-- So check all the players here, too.

	for i, e in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.RUNE_BAG)) do
		if e:ToFamiliar() then
			wakaba:RuneBag_TrackBoosterPacks(e:ToFamiliar())
		end
	end
	for i=0, wakaba.G:GetNumPlayers()-1 do
		local player = wakaba.G:GetPlayer(i)
		if player and player:Exists() then
			wakaba:TrackBoosterPacks(player)
		end
	end

	-- The frame we last detected Booster Pack shouldn't ever be higher than the current frame.
	-- If this happens, some cards probably spawned prior to MC_POST_GAME_STARTED, and we didn't reset `boosterPackDetectedAt` yet.
	--print(boosterPackDetectedAt, wakaba.G:GetFrameCount())
	if boosterPackDetectedAt and boosterPackDetectedAt > wakaba.G:GetFrameCount() then
		--print("[wakaba] Erasing Booster Pack tracking")
		boosterPackDetectedAt = nil
		boosterPackType = nil
	end

	--print(boosterPackDetectedAt, wakaba.G:GetFrameCount())
	if boosterPackDetectedAt and wakaba.G:GetFrameCount() - boosterPackDetectedAt <= 1 then
		local originalCard = pickup.SubType
		local config = Isaac.GetItemConfig()
		local origConfig = config:GetCard(originalCard)
		local cardType = origConfig.CardType

		local canSuit = true
		local canRune = true
		local onlyRune = false

		if cardType == ItemConfig.CARDTYPE_SPECIAL_OBJECT then
			canSuit = true
			canRune = true
			onlyRune = false
		elseif cardType == ItemConfig.CARDTYPE_RUNE then
			canSuit = false
			canRune = true
			onlyRune = true
		elseif boosterPackType == "booster" then
			canRune = false
		end

		-- This is probably a Booster Pack spawn.
		local replacement = wakaba:GetCard_UnlockCheck(nil, originalCard, canSuit, canRune, onlyRune)
		--print("[wakaba] Booster Pack detected. rerolling... from card id "..originalCard)
		if replacement then
			--print("[wakaba] Booster Pack replaced to "..replacement)
			fixingBoosterPackSpawn = true
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, replacement, true, true, true)
			fixingBoosterPackSpawn = false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.CheckBoosterPackSpawn, PickupVariant.PICKUP_TAROTCARD)

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
	return wakaba:IsCompletionItemUnlockedTemp(item, "collectible")
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

local function TagCheck(selected, tagBlackList, tagWhiteList, ignoreActives)
	if not selected then return true end
	if ignoreActives and isc:isActiveCollectible(selected) then return true end
	local skip = false
	for tag, _ in pairs(tagWhiteList) do
		if tag then skip = true end
		if isc:collectibleHasTag(selected, tag) then
			return true
		end
	end
	if skip then return false end
	for tag, _ in pairs(tagBlackList) do
		if isc:collectibleHasTag(selected, tag) then
			return false
		end
	end
	return true
end

local lastSelected = nil
local initialItemNext = false
local flipItemNext = false
local lastGetItemResult = {nil, nil, nil, nil} -- itemID, Frame, gridIndex, InitSeed
local lastFrameGridChecked = 0
local preGetCollectibleAntiRecursive = false

function wakaba:preRollCheck(itemPoolType, decrease, seed)

	if preGetCollectibleAntiRecursive then goto cont end

	if wakaba.G:GetFrameCount() == 0 then goto cont end
	-- Unlock check and Flip interaction for External Item Description
	if seed == 1 then goto cont end
	-- Library Expanded : Do not check reroll in Library Certifiate area
	if LibraryExpanded and LibraryExpanded:IsLibraryCertificateRoom() then goto cont end

	if isc:anyPlayerHasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS) then
		if wakaba.runstate.dreampool ~= ItemPoolType.POOL_NULL and wakaba.runstate.dreampool ~= itemPoolType then
			preGetCollectibleAntiRecursive = true
			local newItem = wakaba.G:GetItemPool():GetCollectible(wakaba.runstate.dreampool, decrease, seed+2)
			preGetCollectibleAntiRecursive = false
			return newItem
		end
	end
	if isc:anyPlayerHasCollectible(CollectibleType.COLLECTIBLE_CHAOS) then
		goto cont
	end
	if wakaba:IsValidWakabaRoom(nil, wakaba.RoomTypes.WINTER_ALBIREO) then
		local level = wakaba.G:GetLevel()
		local stage = level:GetAbsoluteStage()
		local stageType = level:GetStageType()

		if wakaba.G:IsGreedMode() then
			stage = level:GetStage()
			if stage % 2 ~= 0 and itemPoolType ~= ItemPoolType.POOL_GREED_TREASURE then
				preGetCollectibleAntiRecursive = true
				local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_GREED_TREASURE, decrease, seed)
				preGetCollectibleAntiRecursive = false
				return newItem
			end
		else
			if stage <= LevelStage.STAGE4_2 then
				if stage % 2 ~= 0 and itemPoolType == ItemPoolType.POOL_PLANETARIUM then
					preGetCollectibleAntiRecursive = true
					local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_TREASURE, decrease, seed)
					preGetCollectibleAntiRecursive = false
					return newItem
				end
			elseif stage == LevelStage.STAGE4_3 and (itemPoolType == ItemPoolType.POOL_PLANETARIUM or itemPoolType == ItemPoolType.POOL_TREASURE) then
				preGetCollectibleAntiRecursive = true
				local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_SECRET, decrease, seed)
				preGetCollectibleAntiRecursive = false
				return newItem
			elseif stage == LevelStage.STAGE5 and (itemPoolType == ItemPoolType.POOL_PLANETARIUM or itemPoolType == ItemPoolType.POOL_TREASURE) then
				if stageType == StageType.STAGETYPE_ORIGINAL then
					preGetCollectibleAntiRecursive = true
					local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, decrease, seed)
					preGetCollectibleAntiRecursive = false
					return newItem
				else
					preGetCollectibleAntiRecursive = true
					local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL, decrease, seed)
					preGetCollectibleAntiRecursive = false
					return newItem
				end

			end
		end
	end
	::cont::
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, wakaba.preRollCheck)

function wakaba:rollCheck(selected, itemPoolType, decrease, seed)

	local validQuality = {
		["0"] = wakaba.runstate.rerollquality["0"] ~= false,
		["1"] = wakaba.runstate.rerollquality["1"] ~= false,
		["2"] = wakaba.runstate.rerollquality["2"] ~= false,
		["3"] = wakaba.runstate.rerollquality["3"] ~= false,
		["4"] = wakaba.runstate.rerollquality["4"] ~= false,
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

	local hasDoubleDreams = false

	local ignoreActiveFilter = true

	local tagWhiteList = {}
	local tagBlackList = {}
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
		if wakaba:hasWaterFlame(player) then
			tagWhiteList[ItemConfig.TAG_SUMMONABLE] = true
		end
		if player:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS) then
			hasDoubleDreams = true
		end
	end

	if wakaba.roomstate.allowactives == nil then
		AllowActives = true
	end
	if wakaba.fullreroll then
		AllowActives = false
	end
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_EVEN then
		AllowActives = false
		validQuality["0"] = false
	end

	if hasDoubleDreams and wakaba:IsGoldenItem(wakaba.Enums.Collectibles.DOUBLE_DREAMS) then
		validQuality["0"] = false
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
	local hasTagLimit = selected and TagCheck(selected, tagBlackList, tagWhiteList, ignoreActiveFilter)
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
	local itemQuality = isc:clamp(itemConfig.Quality, 0, 4)
	local active = (AllowActives == true) and true or (itemConfig.Type == ItemType.ITEM_PASSIVE or itemConfig.Type == ItemType.ITEM_FAMILIAR)
	local min_quality = MinQuality == 0 and true or itemQuality >= MinQuality
	local max_quality = MaxQuality == 4 and true or (itemQuality <= MaxQuality or selected == wakaba.Enums.Collectibles.WAKABAS_BLESSING or selected == CollectibleType.COLLECTIBLE_BIRTHRIGHT)
	local valid_quality = validQuality[tostring(itemQuality)]

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
	if wakaba.state.rerollloopcount == 0 and hasDejaVu and itemQuality <= 2 then
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
	local isConditionMet = (isPoolCorrect and isRangeCorrect and hasTagLimit and active and isUnlocked and min_quality and max_quality and valid_quality)
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


