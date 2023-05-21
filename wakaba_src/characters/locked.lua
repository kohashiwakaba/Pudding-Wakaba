local lockedChars = {
	[wakaba.Enums.Players.TSUKASA_B] = {
		unlockCheck = "taintedtsukasa",
		targetPlayerType = wakaba.Enums.Players.TSUKASA,
		EIDWarningTitle = "TaintedTsukasaWarningTitle",
		EIDWarningDesc = "TaintedTsukasaWarningText",
		lockedSprite = "gfx/characters/costumes/character_tsukasab.png",
	},
	[wakaba.Enums.Players.RICHER_B] = {
		unlockCheck = "taintedricher",
		targetPlayerType = wakaba.Enums.Players.RICHER,
		EIDWarningTitle = "TaintedTsukasaWarningTitle",
		EIDWarningDesc = "TaintedRicherWarningText",
		lockedSprite = "gfx/characters/costumes/character_richerb.png",
	},
}


local game = Game()
local room = game:GetRoom()
local level = game:GetLevel()
local HUD = game:GetHUD()
local SFX = SFXManager()

local GOTO_COMMAND = "stage 13"

local GRIDINDEX_BEFORE_CLOSET = 108
local CLOSET_GRIDINDEX = 94
--Variables
local reviveFirstPlayer, done, debounce, targetType

local function GoToHomeCloset()
	Isaac.ExecuteCommand(GOTO_COMMAND)
	
	level:MakeRedRoomDoor(GRIDINDEX_BEFORE_CLOSET, DoorSlot.LEFT0)
	level:ChangeRoom(CLOSET_GRIDINDEX)

	for _, v in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
		v:Remove()
	end
	
	for _, v in pairs(Isaac.FindByType(EntityType.ENTITY_SHOPKEEPER)) do
		v:Remove()
	end
--[[ 
	local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, wakaba.G:GetRoom():GetCenterPos(), Vector.Zero, nil)
	ne:GetSprite():ReplaceSpritesheet(0, lockedChars[targetType].lockedSprite)
	ne:GetSprite():LoadGraphics()
 ]]
	level:ChangeRoom(CLOSET_GRIDINDEX)
	Isaac.GetPlayer().Position = wakaba.G:GetRoom():GetCenterPos()
	game:GetSeeds():AddSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_LOST)
end

local function MakeDoorInvisible()
	--room:GetDoor(DoorSlot.RIGHT0):GetSprite().Scale = Vector.Zero
end

local function ShouldPlayerGetInitialised(player)
	local sprite = player:GetSprite()
	local level = game:GetLevel()
	local room = level:GetCurrentRoom()
	if (player.FrameCount == 0 or (room:GetFrameCount() > 1 and player.FrameCount == 1)) 
		and sprite:IsFinished(sprite:GetDefaultAnimation()) 
		and not player.Parent then
			if (level:GetAbsoluteStage() == LevelStage.STAGE1_1 and level:GetCurrentRoomIndex() == level:GetStartingRoomIndex()) or level:GetCurrentRoomIndex() == GridRooms.ROOM_GENESIS_IDX then
					return room:IsFirstVisit()
			end
	end
end

--Functions (core)
local function PostPlayerInit(_, player)
	wakaba:GetPlayerEntityData(player)
	if not wakaba.state.achievementPopupShown then return end
	if wakaba.state.options.allowlockeditems then return end
	if lockedChars[player:GetPlayerType()] and wakaba.state.unlock[lockedChars[player:GetPlayerType()].unlockCheck] then 
		return 
	end
	if player:GetData().wakaba.bypassunlock then
		return
	end
	if lockedChars[player:GetPlayerType()] then
		targetType = player:GetPlayerType()
		if game:GetNumPlayers() ~= 1 then
			player:ChangePlayerType(lockedChars[player:GetPlayerType()].targetPlayerType)
		else
			player:GetData().wakaba.taintedtouched = true
			player:GetData().wakaba.locked = true
		end
	end
end

local function PostGameStarted(_, isContinue)
	if not wakaba.state.achievementPopupShown then return end
	if wakaba.state.options.allowlockeditems then return end

	local firstPlayer = Isaac.GetPlayer(0)
	if firstPlayer:GetData().wakaba.bypassunlock then
		return 
	end
	if not lockedChars[firstPlayer:GetPlayerType()] or wakaba.state.unlock[lockedChars[firstPlayer:GetPlayerType()].unlockCheck] or not targetType then 
		return 
	end
	
	wakaba.runstate.lockedcharacter = true

	if game.Difficulty <= Difficulty.DIFFICULTY_HARD then
		GoToHomeCloset()
		MakeDoorInvisible()
	end
	
	done = true
end

local function PreGameExit()
	targetType = nil
	done = false
end

local function PostNewRoom() --Thank you revelations
	if not (done and level:GetCurrentRoomIndex() ~= CLOSET_GRIDINDEX) then return end
	
	level:ChangeRoom(CLOSET_GRIDINDEX)
	wakaba.G:FinishChallenge()
	MakeDoorInvisible()
end

wakaba:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, CallbackPriority.LATE, PostGameStarted)
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, PreGameExit)
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_PLAYER_INIT, CallbackPriority.LATE, PostPlayerInit)
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PostNewRoom)

if EID then
	local hasShownWarning
	function wakaba:Render_LockedTsukasa()
		if not EID.Config["DisableStartOfRunWarnings"] and done and not hasShownWarning then
			local player = Isaac.GetPlayer()
			local title = lockedChars[player:GetPlayerType()].EIDWarningTitle
			local desc = lockedChars[player:GetPlayerType()].EIDWarningDesc
			local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
			demoDescObj.Name = EID:getDescriptionEntry(title) or ""
			demoDescObj.Description = EID:getDescriptionEntry(desc) or ""
			EID:displayPermanentText(demoDescObj, title)
			hasShownStartWarning = true
			hasShownWarning = true
		else
			hasShownWarning = false
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_LockedTsukasa)
end
