-------------------------------------------------------------------------------------------------------
-- Do not edit this file, this is shared code between all mods that wish to use Completion Note API. --
--                                                                                                   --
-- If you want to make use of this api in your mod, please read the documentation.txt file included  --
-- in the standalone steam workshop version:                                                         --
-- https://steamcommunity.com/sharedfiles/filedetails/?id=1297540365                                 --
--                                                                                                   --
-- Again, DO NOT EDIT THIS! You WILL break stuff.                                                    --
-------------------------------------------------------------------------------------------------------

local currentVersion = 21

--remove any previous versions that may exist
if CompletionNoteAPIMod then
	local thisVersion = 1
	if CompletionNoteAPIMod.Version then
		thisVersion = CompletionNoteAPIMod.Version
	end
	if thisVersion < currentVersion then
		if CompletionNoteAPIMod.RemoveCallbacks then
			CompletionNoteAPIMod:RemoveCallbacks()
		end
		CompletionNoteAPIMod = nil
		Isaac.DebugString("[wakaba]Removed older completion note api mod (version " .. thisVersion .. ")")
	end
end

if not CompletionNoteAPIMod then
	CompletionNoteAPIMod = RegisterMod("Completion Note API", 1)
	CompletionNoteAPIMod.Version = currentVersion
	Isaac.DebugString("[wakaba]Loading completion note api mod version " .. CompletionNoteAPIMod.Version)
	function CompletionNoteAPIMod:RemoveCallbacks()
		CompletionNoteAPIMod:RemoveCallback(ModCallbacks.MC_POST_UPDATE, CompletionNoteAPIMod.onUpdate)
		CompletionNoteAPIMod:RemoveCallback(ModCallbacks.MC_POST_RENDER, CompletionNoteAPIMod.onRender)
		CompletionNoteAPIMod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, CompletionNoteAPIMod.onEntityDeath)
		CompletionNoteAPIMod:RemoveCallback(ModCallbacks.MC_EXECUTE_CMD, CompletionNoteAPIMod.consoleConfig)
		CompletionNoteAPIMod:RemoveCallback(ModCallbacks.MC_POST_GAME_STARTED, CompletionNoteAPIMod.onGameStart)
	end

	local function GetScreenCenter()
		local room = Game():GetRoom()
		local shape = room:GetRoomShape()
		local centerOffset = (room:GetCenterPos()) - room:GetTopLeftPos()
		local pos = room:GetCenterPos()
		if centerOffset.X > 260 then
			pos.X = pos.X - 260
		end
		if shape == RoomShape.ROOMSHAPE_LBL or shape == RoomShape.ROOMSHAPE_LTL then
			pos.X = pos.X - 260
		end
		if centerOffset.Y > 140 then
			pos.Y = pos.Y - 140
		end
		if shape == RoomShape.ROOMSHAPE_LTR or shape == RoomShape.ROOMSHAPE_LTL then
			pos.Y = pos.Y - 140
		end
		return Isaac.WorldToRenderPosition(pos, false)
	end

	--save data
	local json = require("json")
	CompletionNoteAPIData = {}
	
	function CompletionNoteAPIMod:copyTable(tableToCopy)
		local table2 = {}
		for i, value in pairs(tableToCopy) do
			if type(value) == "table" then
				table2[i] = CompletionNoteAPIMod:copyTable(value)
			else
				table2[i] = value
			end
		end
		return table2
	end
	
	function CompletionNoteAPIMod:fillTable(tableToFill, tableToFillFrom)
		for i, value in pairs(tableToFillFrom) do
			if tableToFill[i] ~= nil then
				if type(value) == "table" then
					tableToFill[i] = CompletionNoteAPIMod:fillTable(tableToFill[i], value)
				else
					tableToFill[i] = value
				end
			else
				if type(value) == "table" then
					tableToFill[i] = CompletionNoteAPIMod:fillTable({}, value)
				else
					tableToFill[i] = value
				end
			end
		end
		return tableToFill
	end

	function CompletionNoteAPIMod:LoadSave(saveData)
		if type(saveData) == "string" then
			CompletionNoteAPIData = json.decode(saveData)
		end
	end
	
	function CompletionNoteAPIMod:GetSave()
		return json.encode(CompletionNoteAPIData)
	end
	
	local otherModsShouldSave = false
	function CompletionNoteAPIMod:ShouldSave()
		return otherModsShouldSave
	end
	
	--depreciated
	function CompletionNoteAPIMod:Load()
		if CompletionNoteAPIModStandalone then
			CompletionNoteAPIModStandalone:Load()
		end
	end

	--depreciated
	function CompletionNoteAPIMod:Save()
		if CompletionNoteAPIModStandalone then
			CompletionNoteAPIModStandalone:Save()
		end
	end
	
	--unlock enums
	CompletionMarkType = {
		MOMSHEART = 1,
		ISAAC = 2,
		BOSSRUSH = 3,
		SATAN = 4,
		BLUEBABY = 5,
		THELAMB = 6,
		MEGASATAN = 7,
		ULTRAGREED = 8,
		HUSH = 9,
		DELIRIUM = 10,
		KNIFE = 11,
		DADSNOTE = 12,
	}
	CompletionDifficultyType = {
		NONE = 0,
		NORMAL = 1,
		HARD = 2,
		HARDONLY = 3
	}
	local markName = {
		[CompletionMarkType.MOMSHEART] = 'beatMomsHeart',
		[CompletionMarkType.ISAAC] = 'beatIsaac',
		[CompletionMarkType.BOSSRUSH] = 'beatBossRush',
		[CompletionMarkType.SATAN] = 'beatSatan',
		[CompletionMarkType.BLUEBABY] = 'beatBlueBaby',
		[CompletionMarkType.THELAMB] = 'beatLamb',
		[CompletionMarkType.MEGASATAN] = 'beatMegaSatan',
		[CompletionMarkType.ULTRAGREED] = 'beatUltraGreed',
		[CompletionMarkType.HUSH] = 'beatHush',
		[CompletionMarkType.DELIRIUM] = 'beatDelirium',
		[CompletionMarkType.KNIFE] = 'beatMother',
		[CompletionMarkType.DADSNOTE] = 'beatTheBeast'
	}
	
	local lastDefaultCharacter = PlayerType.PLAYER_THESOUL_B
	
	local defaultCompletionData = {
		beatMomsHeart = 0,	--unlock progress
		beatIsaac = 0,		--0 = not beat
		beatBossRush = 0,	--1 = beat in normal mode
		beatSatan = 0,		--2 = beat in hard mode
		beatBlueBaby = 0,	--3 = beat in hard mode but not normal mode (was only used for greedier before booster 5)
		beatLamb = 0,
		beatMegaSatan = 0,
		beatUltraGreed = 0,
		beatHush = 0,
		beatDelirium = 0,
		beatMother = 0,
		beatTheBeast = 0
	}
	
	function CompletionNoteAPIMod:addPlayerNameToAPI(playerName)
		if playerName == nil then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: addPlayerNameToAPI was called with a nil arg #1 - expected player name")
			return nil
		end
		
		local player = Isaac.GetPlayer(0)
		local playerType = player:GetPlayerType()
		if playerType <= lastDefaultCharacter then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: addPlayerNameToAPI was called with a default character - only mod characters are supported")
			return nil
		end
		
		local data = CompletionNoteAPIMod:getCompletionDataByPlayerName(playerName)
		if data then
			return data
		end
		
		CompletionNoteAPIData[playerName] = CompletionNoteAPIMod:copyTable(defaultCompletionData)
		otherModsShouldSave = true
		return CompletionNoteAPIData[playerName]
	end

	function CompletionNoteAPIMod:getCompletionDataByPlayerName(playerName)
		if playerName == nil then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: getCompletionDataByPlayerName was called with a nil arg #1 - expected player name")
			return nil
		end
		
		local player = Isaac.GetPlayer(0)
		local playerType = player:GetPlayerType()
		if playerType <= lastDefaultCharacter then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: getCompletionDataByPlayerName was called with a default character - only mod characters are supported")
			return nil
		end

		return CompletionNoteAPIData[playerName]
	end

	function CompletionNoteAPIMod:setCompletionDataForPlayerName(playerName, completionData)
		if playerName == nil then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: setCompletionDataForPlayerName was called with a nil arg #1 - expected player name")
			return nil
		elseif completionData == nil then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: setCompletionDataForPlayerName was called with a nil arg #2 - expected completion data")
			return nil
		end
		
		local player = Isaac.GetPlayer(0)
		local playerType = player:GetPlayerType()
		if playerType <= lastDefaultCharacter then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: setCompletionDataForPlayerName was called with a default character - only mod characters are supported")
			return nil
		end
		
		if not CompletionNoteAPIData[playerName] then 
			return nil 
		end
		
		CompletionNoteAPIData[playerName] = CompletionNoteAPIMod:copyTable(completionData)
		return completionData
	end

	--returns true if the mark is completed
	function CompletionNoteAPIMod:isMarkCompleted(playerName, mark, state)
		--deal with any nil values
		if playerName == nil then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: isMarkCompleted was called with a nil arg #1 - expected player name")
			return false
		end
		local player = Isaac.GetPlayer(0)
		local playerType = player:GetPlayerType()
		if playerType <= lastDefaultCharacter then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: isMarkCompleted was called with a default character - only mod characters are supported")
			return false
		end
		local completionData = CompletionNoteAPIMod:getCompletionDataByPlayerName(playerName)
		if completionData == nil then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: isMarkCompleted was called with a player name that isn't registered with the api, use addPlayerNameToAPI function")
			return false
		end
		if state == nil then
			state = CompletionDifficultyType.NORMAL
		end
		
		--get the proper var to check
		local check = completionData[markName[mark]]
		if not check then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: isMarkCompleted was called with a nil arg #2 - expected CompletionMarkType enum")
			return false
		end
		
		--check it
		if state == CompletionDifficultyType.NONE then
			return check == CompletionDifficultyType.NONE
		elseif state == CompletionDifficultyType.NORMAL then
			return check == CompletionDifficultyType.NORMAL or check == CompletionDifficultyType.HARD
		elseif state == CompletionDifficultyType.HARD then
			return check == CompletionDifficultyType.HARD or check == CompletionDifficultyType.HARDONLY
		elseif state == CompletionDifficultyType.HARDONLY then
			return check == CompletionDifficultyType.HARDONLY
		else
			return false
		end
	end

	--returns true if the player has 100% completion
	function CompletionNoteAPIMod:isFullyCompleted(playerName)
		if playerName == nil then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: isFullyCompleted was called with a nil arg #1 - expected player name")
			return false
		end
		local player = Isaac.GetPlayer(0)
		local playerType = player:GetPlayerType()
		if playerType <= lastDefaultCharacter then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: isFullyCompleted was called with a default character - only mod characters are supported")
			return false
		end
		return CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.MOMSHEART,  CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.ISAAC,      CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.BOSSRUSH,   CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.SATAN,      CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.BLUEBABY,   CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.THELAMB,    CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.MEGASATAN,  CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.ULTRAGREED, CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.HUSH,       CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.DELIRIUM,   CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.KNIFE,      CompletionDifficultyType.HARD) and 
			   CompletionNoteAPIMod:isMarkCompleted(playerName, CompletionMarkType.DADSNOTE,   CompletionDifficultyType.HARD)
	end

	--sets the completion mark and unlocks stuff if possible
	function CompletionNoteAPIMod:setMarkCompleted(playerName, mark, state, force, noSave)
		--deal with any nil values
		if playerName == nil then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: setMarkCompleted was called with a nil arg #1 - expected player name")
			return false
		end
		local player = Isaac.GetPlayer(0)
		local playerType = player:GetPlayerType()
		if playerType <= lastDefaultCharacter then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: setMarkCompleted was called with a default character - only mod characters are supported")
			return false
		end
		local completionData = CompletionNoteAPIMod:getCompletionDataByPlayerName(playerName)
		if completionData == nil then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: isMarkCompleted was called with a player name that isn't registered with the api, use addPlayerNameToAPI function")
			return false
		end
		if state == nil then
			state = CompletionDifficultyType.NORMAL
		end
		if force == nil then
			force = false
		end
		
		--get the proper var to set
		local set = completionData[markName[mark]]
		if not set then
			Isaac.DebugString("[wakaba][Completion Note API] ERROR: setMarkCompleted was called with a nil arg #2 - expected CompletionMarkType enum")
			return false
		end
		
		--set it
		if force then
			set = state
		else
            -- allows HARDONLY = 2, HARD = 3 for branchless logic without messing with saves or NONE and NORMAL
			set = (state ~ (state > 1 and 1 or 0)) | set
			set = set ~ (set > 1 and 1 or 0)
		end
		
		--apply it to the real var
		completionData[markName[mark]] = set
		
		--set the data
		CompletionNoteAPIMod:setCompletionDataForPlayerName(playerName, completionData)
		
		if not noSave then --might not be needed, but just in case
			otherModsShouldSave = true
		end
		
		return true
	end

	local deliriumWasInRoom = false
	local motherWasInRoom = false
	local theBeastWasInRoom = false
	function CompletionNoteAPIMod:onMotherInit(entity)
		motherWasInRoom = true
	end
	function CompletionNoteAPIMod:onDeliriumInit(entity)
		deliriumWasInRoom = true
	end
	function CompletionNoteAPIMod:onTheBeastInit(entity)
		theBeastWasInRoom = true
	end
	CompletionNoteAPIMod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, CompletionNoteAPIMod.onDeliriumInit, EntityType.ENTITY_DELIRIUM)
	CompletionNoteAPIMod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, CompletionNoteAPIMod.onMotherInit, EntityType.ENTITY_MOTHER)
	CompletionNoteAPIMod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, CompletionNoteAPIMod.onTheBeastInit, EntityType.ENTITY_THE_BEAST)

	function CompletionNoteAPIMod:onRoomChange(entity)
		deliriumWasInRoom = false
		for i, entity in pairs(Isaac.GetRoomEntities()) do
			if entity.Type == EntityType.ENTITY_DELIRUM then
				deliriumWasInRoom = true
			end
		end
		motherWasInRoom = false
		for i, entity in pairs(Isaac.GetRoomEntities()) do
			if entity.Type == EntityType.ENTITY_MOTHER then
				motherWasInRoom = true
			end
		end
		theBeastWasInRoom = false
		for i, entity in pairs(Isaac.GetRoomEntities()) do
			if entity.Type == EntityType.ENTITY_THE_BEAST then
				theBeastWasInRoom = true
			end
		end
	end
	CompletionNoteAPIMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, CompletionNoteAPIMod.onRoomChange)
	
	local bossRushWasCompleted = false
	local ultraGreedWasDefeated = false
	local roomWasCleared = false
	function CompletionNoteAPIMod:onUpdate()
		otherModsShouldSave = false
		
		local player = Isaac.GetPlayer(0) --this is intentional. the game by default only looks at player 1 for unlocks.
		local playerType = player:GetPlayerType()
		
		if playerType <= lastDefaultCharacter then
			return
		end
		local playerName = player:GetName()

		local level = Game():GetLevel()
		local room = Game():GetRoom()
		local roomType = room:GetType()
		local currentStage = level:GetStage()
		local difficulty = Game().Difficulty

		local roomIsClear = room:IsClear()
		
		--do greed mode unlock
		if Game():IsGreedMode() then
			if not ultraGreedWasDefeated then
				if currentStage == LevelStage.STAGE7_GREED then
					if not roomWasCleared and roomIsClear and roomType == RoomType.ROOM_BOSS and room:IsCurrentRoomLastBoss() then
						if difficulty == 2 then --greed mode
							CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.ULTRAGREED)
						elseif difficulty == 3 then --greedier mode
							CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.ULTRAGREED, CompletionDifficultyType.HARD)
						end
						ultraGreedWasDefeated = true
					end
				end
			end
			return
		end
		
		--do boss rush unlock
		if not bossRushWasCompleted then
			if roomType == RoomType.ROOM_BOSSRUSH and room:IsAmbushDone() then
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.BOSSRUSH)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.BOSSRUSH, CompletionDifficultyType.HARD)
				end
				bossRushWasCompleted = true
			end
		end
		
		--do other unlocks if the other methods didnt work
		if not roomWasCleared and roomIsClear and roomType == RoomType.ROOM_BOSS then
			local currentStageType = level:GetStageType()
			local curses = level:GetCurses()
			
			if currentStage == 8 or (currentStage == 7 and curses & LevelCurse.CURSE_OF_LABYRINTH ~= 0 and room:IsCurrentRoomLastBoss()) then --womb 2
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.MOMSHEART)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.MOMSHEART, CompletionDifficultyType.HARD)
				end
			elseif currentStage == 10 then
				if currentStageType == 1 then --cathedral
					if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.ISAAC)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.ISAAC, CompletionDifficultyType.HARD)
					end
				elseif currentStageType == 0 then --sheol
					if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.SATAN)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.SATAN, CompletionDifficultyType.HARD)
					end
				end
			elseif currentStage == 11 then
				local backdrop = room:GetBackdropType()
				if backdrop == 18 then
					   if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.MEGASATAN)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.MEGASATAN, CompletionDifficultyType.HARD)
					end
				   elseif currentStageType == 1 then --chest
					if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.BLUEBABY)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.BLUEBABY, CompletionDifficultyType.HARD)
					end
				elseif currentStageType == 0 then --dark room
					if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.THELAMB)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.THELAMB, CompletionDifficultyType.HARD)
					end
				end
			elseif currentStage == 9 then --blue womb
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.HUSH)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.HUSH, CompletionDifficultyType.HARD)
				end
			elseif currentStage == 12 then --the void
				if deliriumWasInRoom then
					if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.DELIRIUM)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.DELIRIUM, CompletionDifficultyType.HARD)
					end
				end
			elseif currentStage == 8 or (currentStage == 7 and curses & LevelCurse.CURSE_OF_LABYRINTH ~= 0 and room:IsCurrentRoomLastBoss()) then --corpse 2
				if motherWasInRoom then
					if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.KNIFE)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.KNIFE, CompletionDifficultyType.HARD)
					end
				end
			elseif currentStage == 13 then --home
				if deliriumWasInRoom then
					if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.DADSNOTE)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.DADSNOTE, CompletionDifficultyType.HARD)
					end
				end
			end
		end
		roomWasCleared = roomIsClear
	end
	CompletionNoteAPIMod:AddCallback(ModCallbacks.MC_POST_UPDATE, CompletionNoteAPIMod.onUpdate)

	local CompletionPage = Sprite()
	CompletionPage:Load("gfx/ui/pausescreen_completion.anm2", true) --pause menu paper background, completion page, and black background (we replace revelations' black background with a fully transparent image so it doesn't overlay above our's)
	CompletionPage:LoadGraphics()
	CompletionPage.PlaybackSpeed = CompletionPage.PlaybackSpeed * 0.5
	local isShowingCompletionPage = false
	local wasPaused = false
	local isPaused = false
	local ignorePauseCooldown = 5
	CompletionPageIsVisible = false
	CompletionPageHudPosition = Vector(0,0)
	CompletionPagePauseSelections = {
		INOPTIONS = -1,
		OPTIONS = 0,
		RESUME = 1,
		QUIT = 2
	}
	CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.RESUME
	function CompletionNoteAPIMod:onRender()
		local player = Isaac.GetPlayer(0) --this is intentional. the game by default only looks at player 1 for unlocks.
		local playerType = player:GetPlayerType()
		local playerName = player:GetName()
		local controllerIndex = player.ControllerIndex
		
		--guess if the game is paused
		if ignorePauseCooldown > 0 then
			ignorePauseCooldown = ignorePauseCooldown - 1
		else
			if isPaused then
				if Input.IsActionTriggered(ButtonAction.ACTION_MENUUP, controllerIndex) then
					if CompletionPageCurrentPauseSelection ~= CompletionPagePauseSelections.INOPTIONS then
						if CompletionPageCurrentPauseSelection == CompletionPagePauseSelections.OPTIONS then
							CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.QUIT
						elseif CompletionPageCurrentPauseSelection == CompletionPagePauseSelections.RESUME then
							CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.OPTIONS
						elseif CompletionPageCurrentPauseSelection == CompletionPagePauseSelections.QUIT then
							CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.RESUME
						end
					end
				elseif Input.IsActionTriggered(ButtonAction.ACTION_MENUDOWN, controllerIndex) then
					if CompletionPageCurrentPauseSelection ~= CompletionPagePauseSelections.INOPTIONS then
						if CompletionPageCurrentPauseSelection == CompletionPagePauseSelections.OPTIONS then
							CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.RESUME
						elseif CompletionPageCurrentPauseSelection == CompletionPagePauseSelections.RESUME then
							CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.QUIT
						elseif CompletionPageCurrentPauseSelection == CompletionPagePauseSelections.QUIT then
							CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.OPTIONS
						end
					end
				elseif Input.IsActionTriggered(ButtonAction.ACTION_MENUCONFIRM, controllerIndex) then
					if CompletionPageCurrentPauseSelection ~= CompletionPagePauseSelections.INOPTIONS then
						if CompletionPageCurrentPauseSelection == CompletionPagePauseSelections.OPTIONS then
							CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.INOPTIONS
						elseif CompletionPageCurrentPauseSelection == CompletionPagePauseSelections.RESUME then
							CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.RESUME
							isPaused = false
							ignorePauseCooldown = 5
						end
					end
				elseif Input.IsActionTriggered(ButtonAction.ACTION_MENUBACK, controllerIndex) then
					if CompletionPageCurrentPauseSelection ~= CompletionPagePauseSelections.INOPTIONS then
						CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.RESUME
						isPaused = false
						ignorePauseCooldown = 5
					else
						CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.OPTIONS
					end
				elseif Input.IsActionTriggered(ButtonAction.ACTION_PAUSE, controllerIndex) then
					if CompletionPageCurrentPauseSelection ~= CompletionPagePauseSelections.INOPTIONS then
						CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.RESUME
						isPaused = false
						ignorePauseCooldown = 5
					end
				end
			else
				if not wasPaused then
					if Input.IsActionTriggered(ButtonAction.ACTION_PAUSE, controllerIndex) or (Input.IsButtonTriggered(Keyboard.KEY_ESCAPE, controllerIndex) and not Input.IsButtonTriggered(ButtonAction.ACTION_LEFT, controllerIndex)) then
						CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.RESUME
						isPaused = true
						ignorePauseCooldown = 5
					end
				end
			end
			if ignorePauseCooldown <= 0 then
				if not Game():IsPaused() then
					CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.RESUME
					isPaused = false
				end
			end
		end
		
		wasPaused = Game():IsPaused()
		
		--render the completion page if the game is paused
		local showCompletionPage = false
		local removeCompletionPage = false
		if isPaused then
			showCompletionPage = true
		end
		if not showCompletionPage and isShowingCompletionPage then
			showCompletionPage = true
			removeCompletionPage = true
		end
		if showCompletionPage then
			CompletionPageHudPosition = Vector((GetScreenCenter().X * 1.2), GetScreenCenter().Y)
			
			if not isShowingCompletionPage then
				isShowingCompletionPage = true
				CompletionPage:Play("Appear", true)
				if playerType > lastDefaultCharacter then
					CompletionPage:ReplaceSpritesheet(0, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(1, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(2, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(3, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(4, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(5, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(6, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(7, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(8, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(9, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(12, "gfx/ui/completion_widget_pause.png")
					CompletionPage:ReplaceSpritesheet(13, "gfx/ui/completion_widget_pause.png")
					CompletionPage:LoadGraphics()
				else --only show the completion page for characters hooked up with our api
					CompletionPage:ReplaceSpritesheet(0, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(1, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(2, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(3, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(4, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(5, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(6, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(7, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(8, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(9, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(12, "gfx/ui/completion_widget_blank.png")
					CompletionPage:ReplaceSpritesheet(13, "gfx/ui/completion_widget_blank.png")
					CompletionPage:LoadGraphics()
				end
			end
			
			if CompletionPage:IsFinished("Appear") then
				CompletionPage:SetFrame("Idle", 0)
				if playerType > lastDefaultCharacter then --no way to get the completion progress of default characters... if that were possible i'd reimplement their notes as well for consistency and so other mods could render over their notes
					local completionData = CompletionNoteAPIMod:getCompletionDataByPlayerName(playerName)
					
					if not completionData then
						completionData = CompletionNoteAPIMod:addPlayerNameToAPI(playerName)
					end
					
					CompletionPage:SetLayerFrame(0, completionData.beatDelirium)
					CompletionPage:SetLayerFrame(1, completionData.beatMomsHeart)
					CompletionPage:SetLayerFrame(2, completionData.beatIsaac)
					CompletionPage:SetLayerFrame(3, completionData.beatSatan)
					CompletionPage:SetLayerFrame(4, completionData.beatBossRush)
					CompletionPage:SetLayerFrame(5, completionData.beatBlueBaby)
					CompletionPage:SetLayerFrame(6, completionData.beatLamb)
					CompletionPage:SetLayerFrame(7, completionData.beatMegaSatan)
					CompletionPage:SetLayerFrame(8, completionData.beatUltraGreed)
					CompletionPage:SetLayerFrame(9, completionData.beatHush)
					CompletionPage:SetLayerFrame(12, completionData.beatMother)
					CompletionPage:SetLayerFrame(13, completionData.beatTheBeast)
				end
			end
			
			if removeCompletionPage then
				if not CompletionPage:IsPlaying("Dissapear") then
					CompletionPage:Play("Dissapear", true)
					CompletionPageIsVisible = false
				end
			else
				CompletionPageIsVisible = true
			end
			
			CompletionPage:Update()
			if CompletionPageCurrentPauseSelection ~= CompletionPagePauseSelections.INOPTIONS then --hide the menu if we're in the options menu
				CompletionPage:Render(CompletionPageHudPosition, Vector(0,0), Vector(0,0))
			end
			
			if CompletionPage:IsFinished("Dissapear") then
				isShowingCompletionPage = false
				CompletionPageIsVisible = false
			end
		end
	end
	CompletionNoteAPIMod:AddCallback(ModCallbacks.MC_POST_RENDER, CompletionNoteAPIMod.onRender)

	--check if any of the final bosses have died on their floor
	function CompletionNoteAPIMod:onEntityDeath(entity)
		local player = Isaac.GetPlayer(0) --this is intentional. the game by default only looks at player 1 for unlocks.
		local playerType = player:GetPlayerType()
		
		if playerType <= lastDefaultCharacter then return end
		local playerName = player:GetName()
			
		local level = Game():GetLevel()
		local currentStage = level:GetStage()
		local currentStageType = level:GetStageType()
		local difficulty = Game().Difficulty
			
		if difficulty >= 2 then return
		
		elseif entity.Type == EntityType.ENTITY_MOMS_HEART then
			if entity.Variant == 0 or entity.Variant == 1 then --mom's heart or it lives
				local curses = level:GetCurses()
				if currentStage == 8 or (currentStage == 7 and curses & LevelCurse.CURSE_OF_LABYRINTH ~= 0) then --womb 2
					if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.MOMSHEART)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.MOMSHEART, CompletionDifficultyType.HARD)
					end
				end
			end
		elseif entity.Type == EntityType.ENTITY_ISAAC then
			if entity.Variant == 0 then --normal isaac
				if currentStage == 10 and currentStageType == 1 then --cathedral
					if difficulty == 0 then --normal mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.ISAAC)
					elseif difficulty == 1 then --hard mode
						CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.ISAAC, CompletionDifficultyType.HARD)
					end
			   elseif entity.Variant == 1 then --blue baby
				   if currentStage == 11 and currentStageType == 1 then --chest
					   if difficulty == 0 then --normal mode
						   CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.BLUEBABY)
					   elseif difficulty == 1 then --hard mode
						   CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.BLUEBABY, CompletionDifficultyType.HARD)
					   end
				   end
				end
			end
		elseif entity.Type == EntityType.ENTITY_SATAN and entity.Variant == 10 then --satan's stomp (final phase)
			if currentStage == 10 and currentStageType == 0 then --sheol
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.SATAN)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.SATAN, CompletionDifficultyType.HARD)
				end
			end
		elseif entity.Type == EntityType.ENTITY_THE_LAMB and entity.Variant == 0 then --the lamb
			if currentStage == 11 and currentStageType == 0 then --dark room
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.THELAMB)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.THELAMB, CompletionDifficultyType.HARD)
				end
			end
		elseif entity.Type == EntityType.ENTITY_MEGA_SATAN_2 and entity.Variant == 0 then --mega satan's skull (final phase)
			if currentStage == 11 then --dark room/chest
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.MEGASATAN)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.MEGASATAN, CompletionDifficultyType.HARD)
				end
			end
		elseif entity.Type == EntityType.ENTITY_HUSH and entity.Variant == 0 then --hush
			if currentStage == 9 then --blue womb
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.HUSH)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.HUSH, CompletionDifficultyType.HARD)
				end
			end
		elseif entity.Type == EntityType.ENTITY_DELIRIUM and entity.Variant == 0 then --delirium
			if currentStage == 12 then --the void
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.DELIRIUM)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.DELIRIUM, CompletionDifficultyType.HARD)
				end
			end
		elseif entity.Type == EntityType.ENTITY_MOTHER and entity.Variant == 10 then --mother
			local curses = level:GetCurses()
			if currentStage == 8 or (currentStage == 7 and curses & LevelCurse.CURSE_OF_LABYRINTH ~= 0) then --corpse 2
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.KNIFE)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.KNIFE, CompletionDifficultyType.HARD)
				end
			end
		elseif entity.Type == 951 and entity.Variant == 0 then --the beast
			if currentStage == 13 then --home
				if difficulty == 0 then --normal mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.DADSNOTE)
				elseif difficulty == 1 then --hard mode
					CompletionNoteAPIMod:setMarkCompleted(playerName, CompletionMarkType.DADSNOTE, CompletionDifficultyType.HARD)
				end
			end
		end
	end
	CompletionNoteAPIMod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, CompletionNoteAPIMod.onEntityDeath)

	CompletionNoteAPIHasLoaded = false
	function CompletionNoteAPIMod:onGameStart(isSaveGame)
		bossRushWasCompleted = false
		ultraGreedWasDefeated = false
		isShowingCompletionPage = false
		isPaused = false
		ignorePauseCooldown = 5
		CompletionPageIsVisible = false
		CompletionPageCurrentPauseSelection = CompletionPagePauseSelections.RESUME
		
		local player = Isaac.GetPlayer(0) --this is intentional. the game by default only looks at player 1 for unlocks.
		local playerType = player:GetPlayerType()
		local playerName = player:GetName()
		print("playerType = " .. tostring(playerType))
		print("playerName = " .. tostring(playerName))
		if playerType > lastDefaultCharacter then
			CompletionNoteAPIMod:addPlayerNameToAPI(playerName) --add them to the api
		end
		
		if not CompletionNoteAPIHasLoaded then
			if CompletionNoteAPIPreLoad then
				for _, thisFunction in pairs(CompletionNoteAPIPreLoad) do
					thisFunction()
				end
				CompletionNoteAPIPreLoad = {}
			end
			
			--other mods need to do this
			-- local CompletionNoteAPIPreLoadFunction = myCoolFunction
			-- if CompletionNoteAPIHasLoaded then
				-- CompletionNoteAPIPreLoadFunction()
			-- else
				-- if not CompletionNoteAPIPreLoad then
					-- CompletionNoteAPIPreLoad = {}
				-- end
				-- CompletionNoteAPIPreLoad[#CompletionNoteAPIPreLoad + 1] = CompletionNoteAPIPreLoadFunction
			-- end
			
			CompletionNoteAPIHasLoaded = true
		end
	end
	CompletionNoteAPIMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, CompletionNoteAPIMod.onGameStart)
end

CompletionNoteAPIMod:ForceError() --this function doesn't exist, we do this to cause an error intentionally