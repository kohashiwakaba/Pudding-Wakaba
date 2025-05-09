
--[[
function wakaba:GetCompletionNoteLayerDataFromPlayerType(playerType)
	for key, dataset in pairs(wakaba.state.completion) do
		if playertype_cache[key] == playerType then
			return {
				[noteLayer.DELI] 	= dataset.deli + (dataset.istainted and 3 or 0),
				[noteLayer.HEART] 	= dataset.heart,
				[noteLayer.ISAAC] 	= dataset.isaac,
				[noteLayer.SATAN] 	= dataset.satan,
				[noteLayer.RUSH] 	= dataset.rush,
				[noteLayer.BBABY] 	= dataset.bbaby,
				[noteLayer.LAMB] 	= dataset.lamb,
				[noteLayer.MEGA] 	= dataset.mega,
				[noteLayer.GREED] 	= dataset.greed,
				[noteLayer.HUSH] 	= dataset.hush,
				[noteLayer.MOTHER] 	= dataset.mother,
				[noteLayer.BEAST] 	= dataset.beast,
			}
		end
	end
end
 ]]
--[[
function wakaba:InitCharacterCompletion(playername, tainted, forceTaintedCompletion)
	local lookup = string.lower(playername)
	if tainted then lookup = lookup .. "B" end

	forceTaintedCompletion = forceTaintedCompletion ~= nil and forceTaintedCompletion or tainted
	wakaba.state.completion = wakaba.state.completion or {}

	playertype_cache[lookup] = Isaac.GetPlayerTypeByName(playername, tainted)

	if not wakaba.state.completion[lookup] then
		wakaba.state.completion[lookup] = {
			lookupstr	= lookup,
			istainted	= forceTaintedCompletion,

			heart	= 0,
			isaac	= 0,
			bbaby	= 0,
			satan	= 0,
			lamb	= 0,
			rush	= 0,
			hush	= 0,
			deli	= 0,
			mega	= 0,
			greed	= 0,
			mother	= 0,
			beast	= 0,
		}
	end
end

function wakaba:AssociateCompletionUnlocks(playerType, unlockset)
	for key, value in pairs(playertype_cache) do
		if value == playerType then
			unlocksHolder[key] = unlockset
		end
	end
end

function wakaba:AssociateItemWithTest(unlockType, itemID, conditionFunction)
	table.insert(unlocksHolder2, {
		Type = unlockType,
		ID = itemID,
		Check = conditionFunction,
	})
end


function wakaba:InitCharacterCompletionMarks()
	wakaba:InitCharacterCompletion("Wakaba", false)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.WAKABA, wakaba.UnlockTables[wakaba.Enums.Players.WAKABA])

	wakaba:InitCharacterCompletion("Wakaba", true)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.WAKABA_B, wakaba.UnlockTables[wakaba.Enums.Players.WAKABA_B])

	wakaba:InitCharacterCompletion("Shiori", false)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.SHIORI, wakaba.UnlockTables[wakaba.Enums.Players.SHIORI])

	wakaba:InitCharacterCompletion("Shiori", true)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.SHIORI_B, wakaba.UnlockTables[wakaba.Enums.Players.SHIORI_B])

	wakaba:InitCharacterCompletion("Tsukasa", false)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.TSUKASA, wakaba.UnlockTables[wakaba.Enums.Players.TSUKASA])

	wakaba:InitCharacterCompletion("Tsukasa", true)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.TSUKASA_B, wakaba.UnlockTables[wakaba.Enums.Players.TSUKASA_B])

	wakaba:InitCharacterCompletion("Richer", false)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.RICHER, wakaba.UnlockTables[wakaba.Enums.Players.RICHER])

	wakaba:InitCharacterCompletion("Richer", true)
	wakaba:AssociateCompletionUnlocks(wakaba.Enums.Players.RICHER_B, wakaba.UnlockTables[wakaba.Enums.Players.RICHER_B])
end
 ]]

--[[

local function HasPlayerAchievedQuartet(playerKey)
	return (
		wakaba.state.completion[playerKey].isaac >= 1 and
		wakaba.state.completion[playerKey].bbaby >= 1 and
		wakaba.state.completion[playerKey].satan >= 1 and
		wakaba.state.completion[playerKey].lamb >= 1
	)
end

local function HasPlayerAchievedDuet(playerKey)
	return (
		wakaba.state.completion[playerKey].rush >= 1 and
		wakaba.state.completion[playerKey].hush >= 1
	)
end

local function TestUnlock(playerKey, unlockType)
	if unlockType == "All" then
		local allHard = true

		for key, value in pairs(wakaba.state.completion[playerKey]) do
			if type(value) == "number" then
				if value < 2 then
					allHard = false
					break
				end
			end
		end

		return allHard
	elseif unlockType == "Quartet" then
		return HasPlayerAchievedQuartet(playerKey)
	elseif unlockType == "Duet" then
		return HasPlayerAchievedDuet(playerKey)
	else
		return wakaba.state.completion[playerKey][associationToValueMap[unlockType] ] >= associationTestValue[unlockType]
	end
end
 ]]
--[[
function wakaba.IsCompletionMarkUnlocked(playerKey, unlockType)
	return TestUnlock(string.lower(playerKey), unlockType)
end

function wakaba.IsCompletionItemUnlocked(itemID)
	for _, data in pairs(unlocksHolder2) do
		if data.Type == "collectible" and data.ID == itemID and data.Check() then
			return true
		end
	end

	for playerKey, dataset in pairs(unlocksHolder) do
		for unlockType, unlockData in pairs(dataset) do
			if unlockData[1] == "collectible" and unlockData[2] == itemID then
				return TestUnlock(playerKey, unlockType)
			end
		end
	end

	return true
end

function wakaba.IsCompletionTrinketUnlocked(trinketID)
	for _, data in pairs(unlocksHolder2) do
		if data.Type == "trinket" and data.ID == trinketID and data.Check() then
			return true
		end
	end

	for playerKey, dataset in pairs(unlocksHolder) do
		for unlockType, unlockData in pairs(dataset) do
			if unlockData[1] == "trinket" and unlockData[2] == trinketID then
				return TestUnlock(playerKey, unlockType)
			end
		end
	end

	return true
end

function wakaba.RemoveLockedItemsAndTrinkets()
	local itempool = game:GetItemPool()

	for playerKey, dataset in pairs(unlocksHolder) do
		for unlockType, unlockData in pairs(dataset) do
			if unlockData[1] == "collectible" then
				if not TestUnlock(playerKey, unlockType) then
					itempool:RemoveCollectible(unlockData[2])
				end
			elseif unlockData[1] == "trinket" then
				if not TestUnlock(playerKey, unlockType) then
					itempool:RemoveTrinket(unlockData[2])
				end
			end
		end
	end

	for _, data in pairs(unlocksHolder2) do
		if not data.Check() then
			if data.Type == "collectible" then
				itempool:RemoveCollectible(data.ID)
			elseif data.Type == "trinket" then
				itempool:RemoveTrinket(data.ID)
			end
		end
	end
end

function wakaba.RemoveLockedTrinkets()
	local itempool = game:GetItemPool()

	for playerKey, dataset in pairs(unlocksHolder) do
		for unlockType, unlockData in pairs(dataset) do
			if unlockData[1] == "trinket" then
				if not TestUnlock(playerKey, unlockType) then
					itempool:RemoveTrinket(unlockData[2])
				end
			end
		end
	end

	for _, data in pairs(unlocksHolder2) do
		if not data.Check() then
			if data.Type == "trinket" then
				itempool:RemoveTrinket(data.ID)
			end
		end
	end
end

 ]]


--[[
local antiRecursion = false
wakaba:AddCallback(ModCallbacks.MC_GET_TRINKET, function(_, trinket, rng)
	if not antiRecursion and not wakaba.IsCompletionTrinketUnlocked(trinket) then
		antiRecursion = true

		wakaba.RemoveLockedTrinkets()

		local itempool = game:GetItemPool()
		local new = itempool:GetTrinket()

		antiRecursion = false

		return new
	end
end)

]]
--[[
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, function()
	if wakaba:CanRunUnlockAchievements() then
		local room = game:GetRoom()
		local roomtype = room:GetType()

		local value = DifficultyToCompletionMap[game.Difficulty]
		local checkTables = {}

		for _, data in pairs(wakaba.state.completion) do
			if playertype_cache[data.lookupstr] == Isaac.GetPlayer():GetPlayerType() then
				table.insert(checkTables, data)
			end
		end

		for _, check in ipairs(checkTables) do
			if isc:inBeastRoom() then
				if value > check.beast then
					CheckOnCompletionFunctions(check.lookupstr, "Beast", value, check.istainted)
				end

				check.beast = math.max(check.beast, value)
			elseif roomtype == RoomType.ROOM_BOSS then
				local boss = room:GetBossID()

				local playerKey = check.lookupstr
				local taintedCompletion = check.istainted

				if game:GetLevel():GetStage() == LevelStage.STAGE7 then -- Void

					if boss == BossID.DELIRIUM then
						if value > check.deli then
							CheckOnCompletionFunctions(playerKey, "Delirium", value, taintedCompletion)
						end

						check.deli = math.max(check.deli, value)
					end
				else
					if boss == BossID.HEART or boss == BossID.IT_LIVES or boss == BossID.MAUS_HEART then
						if value > check.heart and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Heart", value)
						end

						check.heart = math.max(check.heart, value)
					elseif boss == BossID.ISAAC then
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)

						if value > check.isaac and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Isaac", value)
						end

						check.isaac = math.max(check.isaac, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)
						if isQuartetAchieved and not wasQuartetAchieved then
							unlocksHolder[playerKey].Quartet[4]()
						end
					elseif boss == BossID.BLUE_BABY then
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)

						if value > check.bbaby and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "BlueBaby", value)
						end

						check.bbaby = math.max(check.bbaby, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)
						if isQuartetAchieved and not wasQuartetAchieved then
							unlocksHolder[playerKey].Quartet[4]()
						end
					elseif boss == BossID.SATAN then
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)

						if value > check.satan and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Satan", value)
						end

						check.satan = math.max(check.satan, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)
						if isQuartetAchieved and not wasQuartetAchieved then
							unlocksHolder[playerKey].Quartet[4]()
						end
					elseif boss == BossID.LAMB then
						local wasQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)

						if value > check.lamb and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Lamb", value)
						end

						check.lamb = math.max(check.lamb, value)
						local isQuartetAchieved = taintedCompletion and HasPlayerAchievedQuartet(playerKey)
						if isQuartetAchieved and not wasQuartetAchieved then
							unlocksHolder[playerKey].Quartet[4]()
						end
					elseif boss == BossID.HUSH then
						local wasDuetAchieved = taintedCompletion and HasPlayerAchievedDuet(playerKey)

						if value > check.hush and not taintedCompletion then
							CheckOnCompletionFunctions(playerKey, "Hush", value)
						end

						check.hush = math.max(check.hush, value)
						local isDuetAchieved = taintedCompletion and HasPlayerAchievedDuet(playerKey)
						if isDuetAchieved and not wasDuetAchieved then
							unlocksHolder[playerKey].Duet[4]()
						end
					elseif boss == BossID.MEGA_SATAN then
						if value > check.mega then
							CheckOnCompletionFunctions(playerKey, "MegaSatan", value, taintedCompletion)
						end

						check.mega = math.max(check.mega, value)
					elseif boss == BossID.GREED or boss == BossID.GREEDIER then
						if value > check.greed then
							if not check.istainted then
								CheckOnCompletionFunctions(playerKey, "Greed", value)
							end
							CheckOnCompletionFunctions(playerKey, "Greedier", value, taintedCompletion)
						end

						check.greed = math.max(check.greed, value)
					elseif boss == BossID.MOTHER then
						if value > check.mother then
							CheckOnCompletionFunctions(playerKey, "Mother", value, taintedCompletion)
						end

						check.mother = math.max(check.mother, value)
					end
				end
			elseif roomtype == RoomType.ROOM_BOSSRUSH then
				local wasDuetAchieved = check.istainted and HasPlayerAchievedDuet(check.lookupstr)

				if value > check.rush and not check.istainted then
					CheckOnCompletionFunctions(check.lookupstr, "BossRush", value)
				end

				check.rush = math.max(check.rush, value)
				local isDuetAchieved = check.istainted and HasPlayerAchievedDuet(check.lookupstr)
				if isDuetAchieved and not wasDuetAchieved then
					unlocksHolder[playerKey].Duet[4]()
				end
			end
		end
	end
end)

 ]]
