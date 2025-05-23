
local isc = _wakaba.isc


local lastSelected = nil
local initialItemNext = false
local flipItemNext = false
local lastGetItemResult = {nil, nil, nil, nil} -- itemID, Frame, gridIndex, InitSeed
local lastFrameGridChecked = 0
local preGetCollectibleAntiRecursive = false

function wakaba:preRollCheck(itemPoolType, decrease, seed)
	wakaba.Log("Prepare reroll - pool " .. itemPoolType .. " / seed " ..seed)

	if preGetCollectibleAntiRecursive then goto cont end

	if wakaba.G:GetFrameCount() == 0 then goto cont end
	-- Unlock check and Flip interaction for External Item Description
	if seed == 1 then goto cont end
	-- Library Expanded : Do not check reroll in Library Certifiate area
	if LibraryExpanded and LibraryExpanded:IsLibraryCertificateRoom() then goto cont end
	if not wakaba.fullreroll and wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.RIRAS_BENTO) then
		return wakaba.Enums.Collectibles.RIRAS_BENTO
	end

	if wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS) then
		if wakaba.runstate.dreampool ~= ItemPoolType.POOL_NULL and wakaba.runstate.dreampool ~= itemPoolType then
			preGetCollectibleAntiRecursive = true
			local newItem = wakaba.G:GetItemPool():GetCollectible(wakaba.runstate.dreampool, decrease, seed+2)
			preGetCollectibleAntiRecursive = false
			return newItem
		end
	end
	if wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_CHAOS) then
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

	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	-- Damocles API uses itempool:GetPoolForRoom to spawn extra items, WHYYYYYYYYYYYYYYYY
	if wakaba.runstate.dreampool == ItemPoolType.POOL_NULL then
		if room:GetType() == RoomType.ROOM_BOSS then
			if itemPoolType == ItemPoolType.POOL_BOSS then
				if room:GetBossID() == 23 then
					preGetCollectibleAntiRecursive = true
					local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, decrease, seed+2)
					preGetCollectibleAntiRecursive = false
					return newItem
				end
			end
		elseif room:GetType() == RoomType.ROOM_TREASURE then
			if itemPoolType == ItemPoolType.POOL_TREASURE then
				if level:GetCurrentRoomDesc().Flags & RoomDescriptor.FLAG_DEVIL_TREASURE > 0 then
					preGetCollectibleAntiRecursive = true
					local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, decrease, seed+2)
					preGetCollectibleAntiRecursive = false
					return newItem
				end
			end
		elseif room:GetType() == RoomType.ROOM_CHALLENGE then
			if itemPoolType == ItemPoolType.POOL_TREASURE then
				if level:HasBossChallenge() then
					preGetCollectibleAntiRecursive = true
					local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_BOSS, decrease, seed+2)
					preGetCollectibleAntiRecursive = false
					return newItem
				end
			end
		end
	end

	::cont::
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, wakaba.preRollCheck)

local recursionLevel = 0
local maxRecursion = 0
local forceAtGameStart = false

function wakaba:newRollCheck(selected, itemPoolType, decrease, seed)
	local bypassEntireReroll = Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_COLLECTIBLE_REROLL, selected, itemPoolType, decrease, seed)
	if bypassEntireReroll then return end

	local pool = wakaba.G:GetItemPool()
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	local config = Isaac.GetItemConfig()

	wakaba.state.rerollloopcount = wakaba.state.rerollloopcount or 0
	local defaultPool = itemPoolType or ItemPoolType.POOL_NULL

	local rerollProps = {
		qualityChance = {
			[0] = 1,
			[1] = 1,
			[2] = 1,
			[3] = 1,
			[4] = 1,
		},
		allowActives = true,
		itemType = itemPoolType,
	}
	if wakaba.state.rerollloopcount == 0 then
		lastSelected = selected
	end

	for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.EVALUATE_WAKABA_COLLECTIBLE_REROLL_PROPS)) do
		local newRerollProps = callbackData.Function(callbackData.Mod, rerollProps, selected, itemPoolType, decrease, seed)

		if newRerollProps then
			rerollProps = newRerollProps
		end
	end

	for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.POST_EVALUATE_WAKABA_COLLECTIBLE_REROLL_PROPS)) do
		local newRerollProps = callbackData.Function(callbackData.Mod, rerollProps, selected, itemPoolType, decrease, seed)

		if newRerollProps then
			rerollProps = newRerollProps
		end
	end

	local bypassEarlyReroll = false

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
		rng:SetSeed(seed, 35)
		local chance = rng:RandomInt(10000)
		if chance <= 1250 then
			local rng2 = RNG()
			rng2:SetSeed(wakaba.G:GetRoom():GetSpawnSeed(), 35)
			local TargetIndex = rng2:RandomInt(#candidates) + 1
			pool:AddRoomBlacklist(candidates[TargetIndex])
			preConditionMet = true
			selected = candidates[TargetIndex]
			bypassEarlyReroll = true
		end
	end

	local selectedItemConf = config:GetCollectible(selected)
	local isPassed = bypassEarlyReroll or not Isaac.RunCallback(wakaba.Callback.WAKABA_COLLECTIBLE_REROLL, rerollProps, selected, selectedItemConf, rerollProps.itemType or itemPoolType, decrease, seed)
	local str_ispassed = (isPassed and "passed") or "not passed"
	wakaba.Log("Rerolling items - #" .. wakaba.state.rerollloopcount .. ", Item No." .. selected .. " is " ..str_ispassed)
	wakaba.Log("Reroll Seed - ", seed)

	pool:AddRoomBlacklist(selected)
	if not isPassed and wakaba.state.rerollloopcount <= wakaba.state.options.rerollbreakfastthreshold and selected ~= CollectibleType.COLLECTIBLE_DADS_NOTE then
		wakaba.state.rerollloopcount = wakaba.state.rerollloopcount + 1
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
		return pool:GetCollectible(rerollProps.itemType or itemPoolType, decrease, nextRNG:Next(), CollectibleType.COLLECTIBLE_DADS_NOTE)
	else
		wakaba.state.rerollloopcount = 0
		wakaba.runstate.spent = false
		if wakaba.state.rerollloopcount >= wakaba.state.options.rerollbreakfastthreshold or selected == CollectibleType.COLLECTIBLE_DADS_NOTE then
			selected = CollectibleType.COLLECTIBLE_BREAKFAST
		end
		--table.insert(selecteditems, selected)
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
--wakaba:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, wakaba.newRollCheck)

wakaba:AddCallback(wakaba.Callback.EVALUATE_WAKABA_COLLECTIBLE_REROLL, function(_, selected, itemPoolType, decrease, seed)
	local shouldSkip =
		wakaba.G:GetFrameCount() == 0
		or seed == 1
		or (selected and selected <= 0)
		or (LibraryExpanded and LibraryExpanded:IsLibraryCertificateRoom())
		or wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
	if shouldSkip then return true end
end)

function wakaba:rerollCooltime()
	if wakaba.rerollcooltime > -2 then
		wakaba.rerollcooltime = wakaba.rerollcooltime - 1
	else
		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			local pData = player:GetData()
			if player:GetData().wakaba and player:GetData().wakaba.eatheartused == true then
				player:GetData().wakaba.eatheartused = false
				player:GetData().wakaba.eatheartquality = nil
			end
		end
	end
	if wakaba.rerollcooltime < 0 and wakaba.rerollcooltime > -2 then
		--print("nemesis check reset")

		wakaba.fullreroll = false
		wakaba.spindownreroll = 0
		if FairOptionsConfig and FairOptionsConfig.Disabled then
			FairOptionsConfig.Disabled = false
		end
		wakaba.G:GetItemPool():ResetRoomBlacklist()
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.rerollCooltime)