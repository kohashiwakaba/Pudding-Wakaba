wakaba.FamiliarPriority = {
	[wakaba.Enums.Familiars.LIL_WAKABA] = 8,
	[wakaba.Enums.Familiars.LIL_MOE] = FollowerPriority.DEFAULT,
	[wakaba.Enums.Familiars.LIL_SHIVA] = 8,
	[wakaba.Enums.Familiars.EASTER_EGG] = 9,
	[wakaba.Enums.Familiars.LIL_RICHER] = FollowerPriority.DEFENSIVE,
	[wakaba.Enums.Familiars.LIL_RIRA] = FollowerPriority.DEFENSIVE,
}


local function SyncRepentogonMarks(playerType)
	if not REPENTOGON or not playerType then return end

	--print("[wakaba] Trying to register Repentogon completion marks for ", playerType)
	Isaac.SetCompletionMarks({
		PlayerType = playerType,
		MomsHeart = wakaba:GetUnlockValuesFromBoss(playerType, "Heart"),
		Isaac = wakaba:GetUnlockValuesFromBoss(playerType, "Isaac"),
		Satan = wakaba:GetUnlockValuesFromBoss(playerType, "Satan"),
		BossRush = wakaba:GetUnlockValuesFromBoss(playerType, "BossRush"),
		BlueBaby = wakaba:GetUnlockValuesFromBoss(playerType, "BlueBaby"),
		Lamb = wakaba:GetUnlockValuesFromBoss(playerType, "Lamb"),
		MegaSatan = wakaba:GetUnlockValuesFromBoss(playerType, "MegaSatan"),
		UltraGreed = wakaba:GetUnlockValuesFromBoss(playerType, "Greed"),
		Hush = wakaba:GetUnlockValuesFromBoss(playerType, "Hush"),
		Delirium = wakaba:GetUnlockValuesFromBoss(playerType, "Delirium"),
		Mother = wakaba:GetUnlockValuesFromBoss(playerType, "Mother"),
		Beast = wakaba:GetUnlockValuesFromBoss(playerType, "Beast"),
	})
end

function wakaba:Repentogon_SyncCompletionMarks()

	print("[wakaba] Start Repentogon Sync MC_PRE_GAME_EXIT")
	for _, playerType in pairs(wakaba.Enums.Players) do
		if wakaba:has_value(wakaba.PlayersToCheckMarks, playerType) then
			SyncRepentogonMarks(playerType)
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GAME_EXIT, CallbackPriority.IMPORTANT, wakaba.Repentogon_SyncCompletionMarks)

---Wakaba familiar order
---@param familiar EntityFamiliar
---@return FamiliarPriority
function wakaba:Repentogon_GetPriority(familiar)
	if wakaba.FamiliarPriority[familiar.Variant] then
		return wakaba.FamiliarPriority[familiar.Variant]
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_FOLLOWER_PRIORITY, wakaba.Repentogon_GetPriority)


---Wakaba health limitation
---@param player EntityPlayer
---@param limit int
---@param isKeeper boolean
function wakaba:Repentogon_HandleWakabaHealth(player, limit, isKeeper)
	if player:GetData().wakaba and player:GetData().wakaba.shioriangel then
		return math.max(24, limit)
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		return math.min(8, limit)
	else
		return math.min(6, limit)
	end
end
wakaba:RemoveCallback(ModCallbacks.MC_POST_UPDATE, wakaba.HandleWakabaHealth)
wakaba:AddCallback(ModCallbacks.MC_PLAYER_GET_HEART_LIMIT, wakaba.Repentogon_HandleWakabaHealth, wakaba.Enums.Players.WAKABA)

-- Negate Damage to Repentogon callbacks
wakaba:RemoveCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_TaintedWakabaBirthright)
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, wakaba.NegateDamage_TaintedWakabaBirthright)

wakaba:RemoveCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_BookOfShiori)
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, wakaba.NegateDamage_BookOfShiori)

wakaba:RemoveCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_Minerva)
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, wakaba.NegateDamage_Minerva)

wakaba:RemoveCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_SelfBurning)
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, wakaba.NegateDamage_SelfBurning)

-- Remove Pickup Blind
--[[ wakaba:RemoveCallback(ModCallbacks.MC_POST_PICKUP_RENDER, wakaba.RevealItemImage, PickupVariant.PICKUP_COLLECTIBLE)
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, function(_, pickup)
	if wakaba:ShouldRemoveBlind() and wakaba.G:GetRoom():GetType() == RoomType.ROOM_TREASURE and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_RAND and pickup:IsBlind() then
		pickup:SetForceBlind(false)
	end
end, PickupVariant.PICKUP_COLLECTIBLE) ]]

-- TODO Wakaba's Nemesis health price
--wakaba:RemoveCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.pickupinit)
--wakaba:RemoveCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.pickupinit)

-- Rendering to Repentogon callbacks
wakaba:RemoveCallback(ModCallbacks.MC_GET_SHADER_PARAMS, wakaba.Render_GlobalHUDStats)
wakaba:RemoveCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_GlobalHUDStats)
wakaba:AddCallback(ModCallbacks.MC_HUD_RENDER, wakaba.Render_GlobalHUDStats)

-- Can't render above HUD with MC_HUD_RENDER
--wakaba:RemoveCallback(ModCallbacks.MC_GET_SHADER_PARAMS, wakaba.Render_ChallengeDest)
--wakaba:RemoveCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_ChallengeDest)
--wakaba:AddCallback(ModCallbacks.MC_HUD_RENDER, wakaba.Render_ChallengeDest)


-- Slot to Repentogon callbacks

wakaba:RemoveCallback(wakaba.Callback.SLOT_INIT, wakaba.InitCrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)
wakaba:RemoveCallback(wakaba.Callback.SLOT_COLLISION, wakaba.SlotCollision_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)
wakaba:RemoveCallback(wakaba.Callback.SLOT_UPDATE, wakaba.SlotUpdate_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)
wakaba:AddCallback(ModCallbacks.MC_POST_SLOT_INIT, wakaba.InitCrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)
wakaba:AddCallback(ModCallbacks.MC_POST_SLOT_COLLISION, wakaba.SlotCollision_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)
wakaba:AddCallback(ModCallbacks.MC_POST_SLOT_UPDATE, wakaba.SlotUpdate_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)

-- Sweets Catalog charges
---@param itemID CollectibleType
---@param player EntityPlayer
---@param varData integer
wakaba:AddCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MAX_CHARGE, function(_, itemID, player, varData)
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER then
		if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_EVEN then
			return 0
		else
			return 12
		end
	else
		return 8
	end
end, wakaba.Enums.Collectibles.SWEETS_CATALOG)

---@param itemID CollectibleType
---@param charge integer
---@param firstTime boolean
---@param slot ActiveSlot
---@param varData integer
---@param player EntityPlayer
wakaba:AddCallback(ModCallbacks.MC_PRE_ADD_COLLECTIBLE, function(_, itemID, charge, firstTime, slot, varData, player)
	if firstTime and player:GetPlayerType() ~= wakaba.Enums.Players.RICHER then
		return {itemID, 8, firstTime, slot, varData}
	end
end, wakaba.Enums.Collectibles.SWEETS_CATALOG)

wakaba.persistentGameData = nil

-- TODO wakaba unlocks to repentogon achievements
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_SAVESLOT_LOAD, 100, function(_, saveslot, isSlotSelected, rawSlot)
	local persistentGameData = Isaac.GetPersistentGameData()
	wakaba.persistentGameData = persistentGameData
	print("[wakaba] Pre Repentogon Sync MC_POST_SAVESLOT_LOAD", saveslot, isSlotSelected, rawSlot)
	if isSlotSelected and wakaba:saveDataManagerInMenu() then
		print("[wakaba] Start Repentogon Sync MC_POST_SAVESLOT_LOAD")
		wakaba:saveDataManagerLoad()
		if wakaba.state.unlock.repentogon then return end
		for _, playerType in pairs(wakaba.Enums.Players) do
			if wakaba:has_value(wakaba.PlayersToCheckMarks, playerType) then
				SyncRepentogonMarks(playerType)
			end
		end
		for entryName, achievementID in pairs(wakaba.RepentogonUnlocks) do
			if wakaba:IsEntryUnlocked(entryName, true) and not persistentGameData:Unlocked(achievementID) then
				print("[wakaba] Try Unlock", achievementID, "from", saveslot, rawSlot)
				persistentGameData:TryUnlock(achievementID)
			end
		end
		wakaba.state.unlock.repentogon = true
		wakaba:saveDataManagerSave()
	end
end)


local completionTypeToValueMap = {
	[CompletionType.MOMS_HEART] = "Heart",
	[CompletionType.ISAAC] = "Isaac",
	[CompletionType.SATAN] = "Satan",
	[CompletionType.BOSS_RUSH] = "BossRush",
	[CompletionType.BLUE_BABY] = "BlueBaby",
	[CompletionType.LAMB] = "Lamb",
	[CompletionType.MEGA_SATAN] = "MegaSatan",
	[CompletionType.ULTRA_GREED] = "Greed",
	[CompletionType.ULTRA_GREEDIER] = "Greedier",
	[CompletionType.DELIRIUM] = "Delirium",
	[CompletionType.MOTHER] = "Mother",
	[CompletionType.BEAST] = "Beast",
	[CompletionType.HUSH] = "Hush",
}

function wakaba:GetEntryFromType(playerType, completionType)
	if not wakaba.UnlockTables[playerType] then return end
	local entries = wakaba.UnlockTables[playerType]
	local bossName = completionTypeToValueMap[completionType]
	return wakaba:GetUnlockMeta(playerType, bossName)
end

local function isQuartetOrDuet(completionType)
	return (
		completionType == CompletionType.ISAAC
		or completionType == CompletionType.SATAN
		or completionType == CompletionType.BLUE_BABY
		or completionType == CompletionType.BLUE_BABY
		or completionType == CompletionType.BOSS_RUSH
		or completionType == CompletionType.HUSH
	)
end

local DifficultyToCompletionMap = {
	[Difficulty.DIFFICULTY_NORMAL]	 = 1,
	[Difficulty.DIFFICULTY_HARD]	 = 2,
	[Difficulty.DIFFICULTY_GREED]	 = 1,
	[Difficulty.DIFFICULTY_GREEDIER] = 2,
}

local checkGroup = {}

function wakaba:Repentogon_TryUnlock(playerType, completionType, force)
	if not force and wakaba.G:AchievementUnlocksDisallowed() then return end
	if not (wakaba:has_value(wakaba.PlayersToCheckMarks, playerType) and wakaba.UnlockTables[playerType]) then return end
	local persistentGameData = Isaac.GetPersistentGameData()
	local entries = wakaba.UnlockTables[playerType]
	local taintedCompletion = entries.istainted or entries.istarnished
	local value = DifficultyToCompletionMap[wakaba.G.Difficulty]
	-- 그리디어일 때 울그 선행 언락
	if not taintedCompletion and completionType == CompletionType.ULTRA_GREEDIER then
		local bossName = completionTypeToValueMap[CompletionType.ULTRA_GREED]
		local entry, meta = wakaba:GetUnlockMeta(playerType, bossName)
		local achievementID = wakaba.RepentogonUnlocks[entry]
		wakaba.state.unlock[entry] = math.max(wakaba.state.unlock[entry], value)
		--Isaac.SetCompletionMark(playerType, completionType, math.max(wakaba.state.unlock[entry], value)) -- TODO remove after MC_POST_COMPLETION_EVENT is available
		if achievementID and not persistentGameData:Unlocked(achievementID) then
			persistentGameData:TryUnlock(achievementID)
		end
	end
	-- 개별 언락
	do
		local bossName = completionTypeToValueMap[completionType]
		if not (bossName == "Heart" and value == 1) then
			local entry, meta = wakaba:GetUnlockMeta(playerType, bossName)
			local achievementID = wakaba.RepentogonUnlocks[entry]
			wakaba.state.unlock[entry] = math.max(wakaba.state.unlock[entry], value)
			--Isaac.SetCompletionMark(playerType, completionType, math.max(wakaba.state.unlock[entry], value)) -- TODO remove after MC_POST_COMPLETION_EVENT is available
			if achievementID and not persistentGameData:Unlocked(achievementID) then
				persistentGameData:TryUnlock(achievementID)
			end
		end
	end
	checkGroup[playerType] = true

end

function wakaba:Repentogon_TryUnlock_Group(playerType, completionType, force)

	if not force and wakaba.G:AchievementUnlocksDisallowed() then return end
	if not (wakaba:has_value(wakaba.PlayersToCheckMarks, playerType) and wakaba.UnlockTables[playerType]) then return end
	local persistentGameData = Isaac.GetPersistentGameData()
	local entries = wakaba.UnlockTables[playerType]
	local taintedCompletion = entries.istainted or entries.istarnished
	local value = DifficultyToCompletionMap[wakaba.G.Difficulty]
	-- 그룹 언락
	if taintedCompletion then
		if Isaac.AllTaintedCompletion(playerType, TaintedMarksGroup.POLAROID_NEGATIVE) > 0 then
			local entry, meta = wakaba:GetUnlockMeta(playerType, "Quartet")
			local achievementID = wakaba.RepentogonUnlocks[entry]
			wakaba.state.unlock[entry] = true
			if not persistentGameData:Unlocked(achievementID) then
				persistentGameData:TryUnlock(achievementID)
			end
		end
		if Isaac.AllTaintedCompletion(playerType, TaintedMarksGroup.SOULSTONE) > 0 then
			local entry, meta = wakaba:GetUnlockMeta(playerType, "Duet")
			local achievementID = wakaba.RepentogonUnlocks[entry]
			wakaba.state.unlock[entry] = true
			if not persistentGameData:Unlocked(achievementID) then
				persistentGameData:TryUnlock(achievementID)
			end
		end
	end

	-- 전체 언락
	if not entries.istainted and Isaac.AllMarksFilled(playerType) == 2 then
		local entry, meta = wakaba:GetUnlockMeta(playerType, "All")
		local achievementID = wakaba.RepentogonUnlocks[entry]
		wakaba.state.unlock[entry] = true
		if not persistentGameData:Unlocked(achievementID) then
			persistentGameData:TryUnlock(achievementID)
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_COMPLETION_EVENT, function(_, completionType)
	local playersToCheck = {}

	wakaba:ForAllPlayers(function(player)
		if wakaba:has_value(wakaba.PlayersToCheckMarks, player:GetPlayerType()) then
			if not wakaba:has_value(playersToCheck, player:GetPlayerType()) then
				table.insert(playersToCheck, player:GetPlayerType())
			end
		end
	end)
	for _, playerType in ipairs(playersToCheck) do
		wakaba:Repentogon_TryUnlock(playerType, completionType)
	end

end)

-- MC_POST_COMPLETION_MARK_GET is also called from saveslot load, so made some checks
wakaba:AddCallback(ModCallbacks.MC_POST_COMPLETION_MARK_GET, function(_, completionType, playerType)
	if not checkGroup[playerType] then return end
	print("[wakaba] MC_POST_COMPLETION_MARK_GET called for :", completionType, playerType)
	wakaba:Repentogon_TryUnlock_Group(playerType, completionType)
	checkGroup[playerType] = nil
end)