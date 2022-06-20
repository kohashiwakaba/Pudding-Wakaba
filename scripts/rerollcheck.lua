--[[

rollItem code originally by Mana, modified for Eat Heart, Wakaba's Blessing, Wakaba's Nemesis

]]
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

function wakaba:trinketUnlockCheck(trinket)
	if Game().Challenge == Challenge.CHALLENGE_PICA_RUN then return true end
	local isUnlocked = true

	if trinket == wakaba.TRINKET_BITCOIN and wakaba.state.unlock.bitcoin < 1 then
		isUnlocked = false
  end
	if trinket == wakaba.TRINKET_CLOVER and wakaba.state.unlock.clover < 1 then
		isUnlocked = false
  end
	if trinket == wakaba.TRINKET_MAGNET_HEAVEN and wakaba.state.unlock.magnetheaven < 1 then
		isUnlocked = false
  end
	if trinket == wakaba.TRINKET_DETERMINATION_RIBBON and wakaba.state.unlock.determinationribbon < 1 then
		isUnlocked = false
  end
	if trinket == wakaba.TRINKET_HARD_BOOK and wakaba.state.unlock.hardbook < 1 then
		isUnlocked = false
  end
	if trinket == wakaba.TRINKET_BOOKMARK_BAG and not wakaba.state.unlock.bookmarkbag then
		isUnlocked = false
  end
	if trinket == wakaba.TRINKET_RING_OF_JUPITER and wakaba.state.unlock.ringofjupiter < 1 then
		isUnlocked = false
  end
	--[[ if trinket == wakaba.TRINKET_RANGE_OS and wakaba.state.unlock.rangesystem < 1 then
		isUnlocked = false
  end ]]

	if trinket == wakaba.TRINKET_DIMENSION_CUTTER and not wakaba.state.unlock.delirium then
		isUnlocked = false
  end

	if trinket == wakaba.TRINKET_DELIMITER and not wakaba.state.unlock.delimiter then
		isUnlocked = false
  end

	return isUnlocked
end


function wakaba:GetNemesisTrinket(selected, rng)
	if not wakaba:trinketUnlockCheck(selected) then
		return Game():GetItemPool():GetTrinket()
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_TRINKET, wakaba.GetNemesisTrinket)


function wakaba:unlockCheck(item, pool)
	local isUnlocked = true

	if item == wakaba.COLLECTIBLE_WAKABAS_BLESSING and wakaba.state.unlock.blessing ~= true then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_BOOK_OF_SHIORI and wakaba.state.unlock.bookofshiori ~= true then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_PLUMY and wakaba.state.unlock.plumy ~= true then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_EXECUTIONER and wakaba.state.unlock.executioner ~= true then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_BOOK_OF_FORGOTTEN and wakaba.state.unlock.bookofforgotten ~= true then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_EYE_OF_CLOCK and wakaba.state.unlock.eyeofclock ~= true then
		isUnlocked = false
  end
	
	if item == wakaba.COLLECTIBLE_MICRO_DOPPELGANGER and wakaba.state.unlock.microdoppelganger ~= true then
		isUnlocked = false
  end
	
	if item == wakaba.COLLECTIBLE_APOLLYON_CRISIS and wakaba.state.unlock.apollyoncrisis ~= true then
		isUnlocked = false
  end
	
	if item == wakaba.COLLECTIBLE_NEKO_FIGURE and wakaba.state.unlock.nekodoll ~= true then
		isUnlocked = false
  end

	if item == wakaba.COLLECTIBLE_LIL_WAKABA and wakaba.state.unlock.lilwakaba ~= true then
		isUnlocked = false
  end

	if item == wakaba.COLLECTIBLE_ISEKAI_DEFINITION and wakaba.state.unlock.deliverysystem ~= true then
		isUnlocked = false
  end

	if item == wakaba.COLLECTIBLE_BALANCE and wakaba.state.unlock.calculation ~= true then
		isUnlocked = false
  end

	if item == wakaba.COLLECTIBLE_DOUBLE_DREAMS and wakaba.state.unlock.doubledreams ~= true then
		isUnlocked = false
  end
	
	if item == wakaba.COLLECTIBLE_WAKABAS_NEMESIS and wakaba.state.unlock.nemesis < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_EATHEART and wakaba.state.unlock.eatheart < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_D_CUP_ICECREAM and wakaba.state.unlock.dcupicecream < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_WAKABAS_PENDANT and wakaba.state.unlock.pendant < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_SECRET_CARD and wakaba.state.unlock.secretcard < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_NEW_YEAR_BOMB and wakaba.state.unlock.newyearbomb < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_UNIFORM and wakaba.state.unlock.wakabauniform < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_COUNTER and wakaba.state.unlock.counter < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_RETURN_POSTAGE and wakaba.state.unlock.returnpostage < 1 then
		isUnlocked = false
  end


	if item == wakaba.COLLECTIBLE_BOOK_OF_FOCUS and wakaba.state.unlock.bookoffocus < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_DECK_OF_RUNES and wakaba.state.unlock.deckofrunes < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER and wakaba.state.unlock.grimreaperdefender < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_BOOK_OF_THE_FALLEN and wakaba.state.unlock.bookoffallen < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_BOOK_OF_TRAUMA and wakaba.state.unlock.bookofgatling < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_BOOK_OF_SILENCE and wakaba.state.unlock.bookofsilence < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_VINTAGE_THREAT and wakaba.state.unlock.bookoftheking < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_BOOK_OF_THE_GOD and wakaba.state.unlock.bookofthegod < 1 then
		isUnlocked = false
  end


	if item == wakaba.COLLECTIBLE_BOOK_OF_CONQUEST and wakaba.state.unlock.bookofconquest < 1 then
		isUnlocked = false
  end
	if item == wakaba.COLLECTIBLE_MINERVA_AURA and wakaba.state.unlock.minervaaura < 1 then
		isUnlocked = false
  end
	return isUnlocked
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

	if Game():GetFrameCount() == 0 then return end
	-- Unlock check and Flip interaction for External Item Description
	if seed == 1 then return end 
	-- Reverie - Touhou Combinations loads item pool from startup to generate item pool cache, which crashes the game if selected is -1, which is for TMTRAINER items.
	if selected and selected <= 0 then
		return
	end
	
	if (Game().Challenge == wakaba.challenges.CHALLENGE_HOLD) then
		return wakaba.COLLECTIBLE_CLOVER_SHARD
	end

	wakaba.state.rerollloopcount = wakaba.state.rerollloopcount or 0

	local pool = Game():GetItemPool()
	local level = Game():GetLevel()
	local room = Game():GetRoom()
	local config = Isaac.GetItemConfig()
	local AllowActives = wakaba.state.allowactives
  local defaultPool = itemPoolType or ItemPoolType.POOL_NULL

	local hasDejaVu = false
	local hasSacredOrb = false
	local hasNeko = false
	local hasAntiBalance = false

	local eatHeartUsed = false
	local eatHeartCharges = 0
	local onlyIsaacCartridge = 0
	local estimatedPlayerCount = 0
	local hasIsaacCartridge = false
	for i = 1, Game():GetNumPlayers() do
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
			if --[[ player:HasTrinket(wakaba.TRINKET_ISAAC_CARTRIDGE) or ]] 
			(player:GetPlayerType() == wakaba.PLAYER_TSUKASA and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT))
			then
				onlyIsaacCartridge = onlyIsaacCartridge + 1
			end
		end
		local pData = player:GetData()
		if player:HasCollectible(wakaba.COLLECTIBLE_DEJA_VU) then
			hasDejaVu = true
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_SACRED_ORB) then
			hasSacredOrb = true
		end
		if player:HasCollectible(wakaba.COLLECTIBLE_NEKO_FIGURE) then
			hasNeko = true
		end
		if player:HasCollectible(wakaba.COLLECTIBLE_ANTI_BALANCE) then
			hasAntiBalance = true
		end
		if pData.wakaba and pData.wakaba.eatheartused then
			eatHeartUsed = true
			eatHeartCharges = pData.wakaba.eatheartcharges
		end
	end
	if estimatedPlayerCount == onlyIsaacCartridge then
		hasIsaacCartridge = true
	end

	if wakaba.state.allowactives == nil then
    AllowActives = true
  end
	if wakaba.fullreroll then
		AllowActives = false
	end

	local itemType = defaultPool
	
	if wakaba.state.dreampool ~= ItemPoolType.POOL_NULL and wakaba.state.rerollloopcount <= 40 then
		itemType = wakaba.state.dreampool
		AllowActives = false
	end

	-- Was trying to check Devil's crown, but doesn't work, there are RoomDescriptor.FLAG_DEVIL_TREASURE, which cannot be accessable yet.
	if wakaba.state.dreampool == ItemPoolType.POOL_NULL and level:GetCurrentRoomDesc().Flags & RoomDescriptor.FLAG_DEVIL_TREASURE == RoomDescriptor.FLAG_DEVIL_TREASURE then
		itemType = ItemPoolType.POOL_DEVIL
	end
	
	if (Game().Challenge == wakaba.challenges.CHALLENGE_RAND) then
		itemType = randPool[math.random(1,#randPool)]
		randselected = true
	end

	local isPoolCorrect = (itemPoolType == itemType) or randselected
	local isRangeCorrect = selected and ((not hasIsaacCartridge) or (selected == CollectibleType.COLLECTIBLE_BIRTHRIGHT) or (selected < CollectibleType.COLLECTIBLE_DIPLOPIA or selected > CollectibleType.COLLECTIBLE_MOMS_RING))
	local isUnlocked = selected and wakaba:unlockCheck(selected)
	local MinQuality = 0
	local MaxQuality = 4
	if eatHeartUsed then
		local rng = RNG()
		rng:SetSeed(seed, 35)
		local chance = rng:RandomFloat() * 480000
		if eatHeartCharges >= 240000 then
			if chance <= eatHeartCharges then MinQuality = 4 else MinQuality = 3 end
		end
	elseif hasNeko and Game():GetRoom():GetType() == RoomType.ROOM_ULTRASECRET then
		MinQuality = 3
	elseif not eatHeartUsed and wakaba.state.hasnemesis and not wakaba.state.hasbless and not wakaba.state.options.blessnemesisqualityignore and not hasSacredOrb then
		if Game():GetRoom():GetType() == RoomType.ROOM_ULTRASECRET or itemType == ItemPoolType.POOL_ULTRA_SECRET then
			MinQuality = 3
		else
			MaxQuality = 2
		end
	elseif not eatHeartUsed and not wakaba.state.hasnemesis and wakaba.state.hasbless and not wakaba.state.options.blessnemesisqualityignore then
		MinQuality = 2
	end
	if hasAntiBalance then
		validQuality["2"] = false
	end

	local itemConfig = config:GetCollectible(selected)
	local active = (AllowActives == true) and true or (itemConfig.Type == ItemType.ITEM_PASSIVE or itemConfig.Type == ItemType.ITEM_FAMILIAR)
	local min_quality = MinQuality == 0 and true or itemConfig.Quality >= MinQuality
	local max_quality = MaxQuality == 4 and true or (itemConfig.Quality <= MaxQuality or selected == wakaba.COLLECTIBLE_WAKABAS_BLESSING or selected == CollectibleType.COLLECTIBLE_BIRTHRIGHT)
	local valid_quality = validQuality[tostring(itemConfig.Quality)]

	--check time
	-- No reroll when should not change Fair Options at the Start? mod
	if FairOptionsConfig and not FairOptionsConfig.Disabled then
		local level = Game():GetLevel()
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
			rng2:SetSeed(Game():GetRoom():GetSpawnSeed(), 35)
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
		wakaba.state.spent = false
		wakaba.state.eatheartused = false
		if wakaba.state.rerollloopcount >= wakaba.state.options.rerollbreakfastthreshold then
			selected = CollectibleType.COLLECTIBLE_BREAKFAST
		end
		
		randselected = false
		-- TODO : also Flip data for EID
		table.insert(selecteditems, selected)
		if EID then
			if wakaba.state.dreampool ~= ItemPoolType.POOL_NULL or itemPoolType == ItemPoolType.POOL_CRANE_GAME then
				for _, crane in ipairs(Isaac.FindByType(6, 16, -1, true, false)) do
					print(tostring(crane.InitSeed), crane.DropSeed, EID.CraneItemType[tostring(crane.InitSeed)], EID.CraneItemType[tostring(crane.InitSeed).."Drop"..crane.DropSeed])
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

			local curRoomIndex = Game():GetLevel():GetCurrentRoomDesc().ListIndex
			for _, item in ipairs(Isaac.FindByType(5, 100, -1, true, false)) do
				if EID.flipItemPositions[curRoomIndex] 
				and EID.flipItemPositions[curRoomIndex][item.InitSeed]
				and EID.flipItemPositions[curRoomIndex][item.InitSeed][1] == lastSelected 
				and EID.flipItemPositions[curRoomIndex][item.InitSeed][2] == Game():GetRoom():GetGridIndex(item.Position)
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
		for i = 1, Game():GetNumPlayers() do
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
		wakaba.state.nemesis = wakaba.defaultstate.nemesis
		Game():GetItemPool():ResetRoomBlacklist()
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


