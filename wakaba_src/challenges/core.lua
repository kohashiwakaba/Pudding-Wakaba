
local isc = require("wakaba_src.libs.isaacscript-common")

local Challenges = wakaba.challenges
local isChallengeContinue = true

wakaba.ChallengeParams = {}
wakaba.ChallengeParams.TargetCharacters = {}
wakaba.ChallengeParams.CharacterInitFuncs = {
	[wakaba.Enums.Players.WAKABA] = function(player) ---@param player EntityPlayer
		player:AddMaxHearts(4 - player:GetMaxHearts())
	end,
	[wakaba.Enums.Players.WAKABA_B] = function(player)
		player:AddMaxHearts(0 - player:GetMaxHearts())
		player:AddBlackHearts(6 - player:GetSoulHearts())
	end,
	[wakaba.Enums.Players.SHIORI] = function(player)
		player:AddMaxHearts(6 - player:GetMaxHearts())
		wakaba:AfterShioriInit(player)
		player:AddKeys(6)
	end,
	[wakaba.Enums.Players.SHIORI_B] = function(player)
		player:AddMaxHearts(0 - player:GetMaxHearts())
		player:AddSoulHearts(6 - player:GetSoulHearts())
		wakaba:AfterShioriInit_b(player)
		player:AddKeys(6)
	end,
	[wakaba.Enums.Players.TSUKASA] = function(player)
		player:AddMaxHearts(6 - player:GetMaxHearts())
	end,
	[wakaba.Enums.Players.TSUKASA_B] = function(player)
		player:AddMaxHearts(6 - player:GetMaxHearts())
	end,
	[wakaba.Enums.Players.RICHER] = function(player)
		player:AddMaxHearts(4 - player:GetMaxHearts())
		player:AddSoulHearts(2)
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.SWEETS_CATALOG, ActiveSlot.SLOT_POCKET, true)
	end,
	[wakaba.Enums.Players.RICHER_B] = function(player)
		player:AddMaxHearts(0 - player:GetMaxHearts())
		player:AddSoulHearts(6 - player:GetSoulHearts())
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.WATER_FLAME, ActiveSlot.SLOT_POCKET, true)
	end,
	[wakaba.Enums.Players.RIRA] = function(player)
		player:AddMaxHearts(0 - player:GetMaxHearts())
		player:AddSoulHearts(6)
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.NERF_GUN, ActiveSlot.SLOT_POCKET, true)
	end,
}
wakaba.ChallengeParams.Fast = {
	[wakaba.challenges.CHALLENGE_ELEC] = true,
}
wakaba.ChallengeParams.Slow = {
	[wakaba.challenges.CHALLENGE_SLNT] = true,
}
wakaba.ChallengeParams.Hush = {
	[wakaba.challenges.CHALLENGE_HUSH] = true,
	[wakaba.challenges.CHALLENGE_PLUM] = true,
	[wakaba.challenges.CHALLENGE_DOPP] = true,
}
wakaba.ChallengeParams.Deli = {
	[wakaba.challenges.CHALLENGE_DELI] = true,
	[wakaba.challenges.CHALLENGE_RAND] = true,
	[wakaba.challenges.CHALLENGE_SLNT] = true,
	[wakaba.challenges.CHALLENGE_BIKE] = true,
	[wakaba.challenges.CHALLENGE_RNPR] = true,
}
wakaba.ChallengeParams.Beast = {
	[wakaba.challenges.CHALLENGE_DRMS] = true,
	[wakaba.challenges.CHALLENGE_SSRC] = true,
}
wakaba.ChallengeParams.DevilDisallowed = {
	[wakaba.challenges.CHALLENGE_DRMS] = true,
}

include('wakaba_src.challenges.w01_electricdisorder')
include('wakaba_src.challenges.w02_berrybestfriend')
include('wakaba_src.challenges.w03_pullandpull')
include('wakaba_src.challenges.w04_minestuff')
include('wakaba_src.challenges.w05_blacknekodreams')
include('wakaba_src.challenges.w06_doppelganger')
include('wakaba_src.challenges.w07_delirium')
include('wakaba_src.challenges.w08_sistersfrombeyond')
include('wakaba_src.challenges.w09_drawfive')
include('wakaba_src.challenges.w10_rushrushhush')
include('wakaba_src.challenges.w11_apollyoncrisis')
include('wakaba_src.challenges.w12_deliverysystem')
include('wakaba_src.challenges.w13_calculation')
include('wakaba_src.challenges.w14_holdme')
include('wakaba_src.challenges.w15_evenorodd')
include('wakaba_src.challenges.w16_runawaypheromones')
include('wakaba_src.challenges.w98_hyperrandom')
include('wakaba_src.challenges.w99_truepuristgirl')
include('wakaba_src.challenges.wb1_puredelirium')
include('wakaba_src.challenges.wb2_supersensitive')

function wakaba:isSpeed()
	return wakaba.ChallengeParams.Fast[wakaba.G.Challenge] ~= nil
end
function wakaba:isSlow()
	return wakaba.ChallengeParams.Slow[wakaba.G.Challenge] ~= nil
end
function wakaba:isHush()
	return wakaba.ChallengeParams.Hush[wakaba.G.Challenge] ~= nil
end
function wakaba:isDelirium()
	return wakaba.ChallengeParams.Deli[wakaba.G.Challenge] ~= nil
end
function wakaba:isBeast()
	return wakaba.ChallengeParams.Beast[wakaba.G.Challenge] ~= nil
end
function wakaba:isDevilAngelAllowed()
	return wakaba.ChallengeParams.DevilDisallowed[wakaba.G.Challenge] ~= true
end

function wakaba:NewLevel_Challenges()
	local level = wakaba.G:GetLevel()
	if not wakaba:isDevilAngelAllowed() then
		level:DisableDevilRoom()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_Challenges)

---@param player EntityPlayer
function wakaba:Challenge_IsFirstInit(player)
	local players = Isaac.FindByType(EntityType.ENTITY_PLAYER)
	if wakaba.G:GetFrameCount() == 0 then
		return #players == 0
	end
	if player.FrameCount == 0 then
		return #players > 0
	end
end

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_Core(player)
	local c = wakaba.G.Challenge
	if c ~= Challenge.CHALLENGE_NULL and wakaba.ChallengeParams.TargetCharacters[c] then
		local tp = wakaba.ChallengeParams.TargetCharacters[c]
		if player:GetPlayerType() ~= tp then
			wakaba.Log("Player incorrectness found from challenge", c, ", time :", wakaba.G:GetFrameCount())
			if wakaba.G:GetFrameCount() == 0 then
				wakaba.Log("First player! restarting...")
				Isaac.ExecuteCommand("restart " .. tp)
				return
			else
				wakaba.Log("Second player! changing...")
				player:ChangePlayerType(tp)
				if wakaba.ChallengeParams.CharacterInitFuncs[tp] then
					wakaba.ChallengeParams.CharacterInitFuncs[tp](player)
				end
			end
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_PLAYER_INIT, -19999, wakaba.Challenge_PlayerInit_Core)

function wakaba:NewRoom_Challenges()
  local game = wakaba.G
  local room = wakaba.G:GetRoom()
  local level = wakaba.G:GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
	local type1 = room:GetType()

	if wakaba:isSpeed() then
		room:SetBrokenWatchState(2)
	elseif wakaba:isSlow() then
		--room:SetBrokenWatchState(1)
	elseif wakaba:isDelirium() or wakaba:isHush() then
		if CurStage == LevelStage.STAGE5 then
			Isaac.ExecuteCommand("stage 9")
		elseif CurStage == LevelStage.STAGE5 then
			Isaac.ExecuteCommand("stage 12")
		elseif type1 == RoomType.ROOM_ERROR and ((CurStage == 7 and level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH == LevelCurse.CURSE_OF_LABYRINTH) or CurStage == 8 or CurStage == 9) then
			game:ChangeRoom(level:GetStartingRoomIndex())
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Challenges)


function wakaba:Render_Challenge()
	if wakaba:isBeast() and
	(wakaba.G:GetLevel():GetAbsoluteStage() == LevelStage.STAGE3_1
		or wakaba.G:GetLevel():GetAbsoluteStage() == LevelStage.STAGE2_1
		or wakaba.G:GetLevel():GetAbsoluteStage() == LevelStage.STAGE2_2
	) then
		for num = 1, wakaba.G:GetNumPlayers() do
			local player = wakaba.G:GetPlayer(num - 1)
			if player:GetSprite():IsPlaying("Trapdoor") or player:GetSprite():IsPlaying("LightTravel") then
				wakaba.G:SetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT, true)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_Challenge)

function wakaba:Challenge_PlayerUpdate_Core(player)
	local c = wakaba.G.Challenge
	if c ~= Challenge.CHALLENGE_NULL and wakaba.ChallengeParams.TargetCharacters[c] then
		local tp = wakaba.ChallengeParams.TargetCharacters[c]
		if player:GetPlayerType() ~= tp then
			player:ChangePlayerType(tp)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_Core)

function wakaba:RoomClear_Challenge(rng, spawnPosition)
	local level = wakaba.G:GetLevel()
	local stage = level:GetAbsoluteStage()
	local curse = level:GetCurses()
	local room = wakaba.G:GetRoom()
	local type1 = room:GetType()
	if type1 == RoomType.ROOM_BOSS
	and (wakaba:isDelirium() or wakaba:isHush()) then
		wakaba.Log("Hush/Deli challenge check", wakaba:isDelirium(), wakaba:isHush(), stage)
		if (stage == 9) then
			if wakaba:isDelirium() then
				local hasvoid = false
				Isaac.GridSpawn(17,0,Isaac.GetFreeNearPosition(room:GetCenterPos(), 32), true)
				for i=1, room:GetGridSize() do
					local gridEnt = room:GetGridEntity(i)
					if gridEnt then
						if gridEnt:GetType() == GridEntityType.GRID_TRAPDOOR  then
							if gridEnt:GetVariant() == 0 then
								--room:RemoveGridEntity(i,0,false)
								room:SpawnGridEntity(i, GridEntityType.GRID_TRAPDOOR, 1, 0, 1)
								hasvoid = true
							end
						end
					end
				end
				if not hasvoid then
					Isaac.ExecuteCommand("gridspawn 9000.1")
				end
			else
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TROPHY, -1, room:GetCenterPos(), Vector(0,0), nil)
			end
			wakaba.Log("Hush challenge passed, skipping room clear")
			return true
		elseif stage == 9 or stage == 8 or (stage == 7 and (curse & LevelCurse.CURSE_OF_LABYRINTH == LevelCurse.CURSE_OF_LABYRINTH)) then
			wakaba.G.BlueWombParTime = 2147483647
			wakaba.Log("Hush door for Mom's Heart, skipping room clear")
			return true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_Challenge)


function wakaba:startChallenge(continue)
	if wakaba:isDelirium() or wakaba:isHush() then
		wakaba.G.BlueWombParTime = 2147483647
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.startChallenge)

function wakaba:ChallengeExit()
  isChallengeContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.ChallengeExit)