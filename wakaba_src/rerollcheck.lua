--[[

rollItem code originally by Mana, modified for Eat Heart, Wakaba's Blessing, Wakaba's Nemesis

]]

local isc = require("wakaba_src.libs.isaacscript-common")

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
		local nemesis = wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS) or wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.NEKO_FIGURE) or isc:anyPlayerIs(wakaba.Enums.Players.WAKABA_B)

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

function wakaba:unlockCheck(item, pool)
	if not wakaba.state.achievementPopupShown or wakaba.state.options.allowlockeditems then return true end
	return wakaba:IsCompletionItemUnlockedTemp(item, "collectible")
end

