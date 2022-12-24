
wakaba.state.CCOUnlocks = {
	MomsHeart = {Unlock = false, Hard = false},
	Isaac = {Unlock = false, Hard = false},
	Satan = {Unlock = false, Hard = false},
	BlueBaby = {Unlock = false, Hard = false},
	Lamb = {Unlock = false, Hard = false},
	BossRush = {Unlock = false, Hard = false},
	Hush = {Unlock = false, Hard = false},
	MegaSatan = {Unlock = false, Hard = false},
	Delirium = {Unlock = false, Hard = false},
	Mother = {Unlock = false, Hard = false},
	Beast = {Unlock = false, Hard = false},
	GreedMode = {Unlock = false, Hard = false},
	FullCompletion = {Unlock = false, Hard = false},
}

local function UpdateCompletion(name)
	if CCOUnlocks[name].Unlock == false then
		CCOUnlocks[name].Unlock = true
	end
	if difficulty == Difficulty.DIFFICULTY_HARD
	or difficulty == Difficulty.DIFFICULTY_GREEDIER then
		CCOUnlocks[name].Hard = true
	end
	
	local MissingHard = false
	for boss, tab in pairs(CCOUnlocks) do
		if boss ~= "FullCompletion" then
			if tab.Unlock == false then
				return
			end
			if tab.Hard == false then
				MissingHard = true
			end
		end
	end
	
	if not CCOUnlocks.FullCompletion.Unlock then
		CCOUnlocks.FullCompletion.Unlock = true
	end
	CCOUnlocks.FullCompletion.Hard = not MissingHard
end

local UnlockFunctions = {
	[LevelStage.STAGE4_2] = function(room, stageType, difficulty, desc) -- Heart / Mother
		if room:IsClear() then
			local Name
			if stageType >= StageType.STAGETYPE_REPENTANCE and desc.SafeGridIndex == -1 then
				Name = "Mother"
			elseif stageType <= StageType.STAGETYPE_AFTERBIRTH then
				Name = "MomsHeart"
			end
		
			if Name then
				UpdateCompletion(Name)
			end
		end
	end,
	[LevelStage.STAGE4_3] = function(room, stageType, difficulty, desc) -- Hush
		if room:IsClear() then
			local Name = "Hush"
		
			UpdateCompletion(Name)
		end
	end,
	[LevelStage.STAGE5] = function(room, stageType, difficulty, desc) -- Satan / Isaac
		if room:IsClear() then
			local Name = "Satan"
			if stageType == StageType.STAGETYPE_WOTL then
				Name = "Isaac"
			end
		
			UpdateCompletion(Name)
		end
	end,
	[LevelStage.STAGE6] = function(room, stageType, difficulty, desc) -- Mega Satan / Lamb / Blue Baby
		if desc.SafeGridIndex == -1 then
			local MegaSatan
			for _, satan in ipairs(Isaac.FindByType(EntityType.ENTITY_MEGA_SATAN_2, 0)) do
				MegaSatan = satan
				break
			end
		
			if not MegaSatan then return end
			
			local sprite = MegaSatan:GetSprite()
			
			if sprite:IsPlaying("Death") and sprite:GetFrame() == 110 then
				local Name = "MegaSatan"
			
				UpdateCompletion(Name)
			end
		else
			if room:IsClear() then
				local Name = "Lamb"
				if stageType == StageType.STAGETYPE_WOTL then
					Name = "BlueBaby"
				end
			
				UpdateCompletion(Name)
			end
		end
	end,
	[LevelStage.STAGE7] = function(room, stageType, difficulty, desc) -- Delirium
		if desc.Data.Subtype == 70 and room:IsClear() then
			local Name = "Delirium"
		
			UpdateCompletion(Name)
		end
	end,
	
	BossRush = function(room, stageType, difficulty, desc) -- Boss Rush
		if room:IsAmbushDone() then
			local Name = "BossRush"
		
			UpdateCompletion(Name)
		end
	end,
	Beast = function(room, stageType, difficulty, desc) -- Beast
		local Beast
		for _, beast in ipairs(Isaac.FindByType(EntityType.ENTITY_BEAST, 0)) do
			Beast = beast
			break
		end
	
		if not Beast then return end
		
		local sprite = Beast:GetSprite()
		
		if sprite:IsPlaying("Death") and sprite:GetFrame() == 30 then
			local Name = "Beast"
		
			UpdateCompletion(Name)
		end
	end,
	Greed = function(room, stageType, difficulty, desc) -- Greed
		if room:IsClear() then
			local Name = "GreedMode"
			
			UpdateCompletion(Name)
		end
	end,
}

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	local level = Game():GetLevel()
	local room = Game():GetRoom()
	local desc = level:GetCurrentRoomDesc()
	local levelStage = level:GetStage()
	local roomType = room:GetType()
	local difficulty = Game().Difficulty
	
	if difficulty <= Difficulty.DIFFICULTY_HARD then
		local stageType = level:GetStageType()
	
		if roomType == RoomType.ROOM_BOSS and UnlockFunctions[levelStage] then
			UnlockFunctions[levelStage](room, stageType, difficulty, desc)
		elseif roomType == RoomType.ROOM_BOSSRUSH then
			UnlockFunctions.BossRush(room, stageType, difficulty, desc)
		elseif levelStage == LevelStage.STAGE8 and roomType == RoomType.ROOM_DUNGEON then
			UnlockFunctions.Beast(room, stageType, difficulty, desc)
		end
	else
		if levelStage == LevelStage.STAGE7_GREED
		and roomType == RoomType.ROOM_BOSS
		and desc.SafeGridIndex == 45
		then
			UnlockFunctions.Greed(room, nil, difficulty, desc)
		end
	end
end)