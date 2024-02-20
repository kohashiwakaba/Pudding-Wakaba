
local font = Font()
font:Load("font/luaminioutlined.fnt")

local function shouldDeHook()

	local reqs = {
		not wakaba.ChallengeDest.initialized,
		not Options.FoundHUD,
		not Game():GetHUD():IsVisible(),
		Game():GetRoom():GetType() == RoomType.ROOM_DUNGEON and Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE8, --beast fight
		Game():GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD),
		-- Game():IsGreedMode() //The chance should still display on Greed Mode even if its 0 for consistency with the rest of the HUD.
	}

	return reqs[1] or reqs[2] or reqs[3] or reqs[4] or reqs[5]
end

function wakaba:FoundHUDUpdateCheck()
	local updatePos = false

	local activePlayers = Game():GetNumPlayers()

	for p = 1, activePlayers do
		local player = Isaac.GetPlayer(p - 1)
		if player.FrameCount == 0 or wakaba:DidPlayerCharacterJustChange(player) or wakaba:DidPlayerDualityCountJustChange(player) then
			updatePos = true
		end
	end

	if wakaba.runstate.numplayers ~= activePlayers then
		updatePos = true
		wakaba.runstate.numplayers = activePlayers
	end

	if wakaba.runstate.hudoffset ~= Options.HUDOffset then
		updatePos = true
		wakaba.runstate.hudoffset = Options.HUDOffset
	end

	--Was a Victory Lap Completed, Runs completed on Normal Difficulty Will switch to HARD upon start of a Victory Lap
	if wakaba.runstate.VictoryLap ~= Game():GetVictoryLap() then
		updatePos = true
		wakaba.runstate.VictoryLap = Game():GetVictoryLap()
	end

	--Certain Seed Effects block achievements
	if wakaba.runstate.NumSeedEffects ~= Game():GetSeeds():CountSeedEffects() then
		updatePos = true
		wakaba.runstate.NumSeedEffects = Game():GetSeeds():CountSeedEffects()
	end

	if updatePos then
		wakaba:updateHUDPosition()
	end
end

function wakaba:updateHUDPosition()
	--Updates position of Chance Stat
	local TrueCoopShift = false
	local BombShift = false
	local PoopShift = false
	local RedHeartShift = false
	local SoulHeartShift = false
	local DualityShift = false

	local ShiftCount = 0

	wakaba.globalHUDCoords = Vector(0, 168)

	for i = 0, Game():GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local playerType = player:GetPlayerType()

		if player:GetBabySkin() == -1 then
			if i > 0 and player.Parent == nil and playerType == player:GetMainTwin():GetPlayerType() and not TrueCoopShift then
				TrueCoopShift = true
			end

			if playerType ~= PlayerType.PLAYER_BLUEBABY_B and not BombShift then -- Shift Stats because of Bomb Counter
				BombShift = true
			end
		end
		if playerType == PlayerType.PLAYER_BLUEBABY_B and not PoopShift then -- Shift Stats because of Poop Spell Counter
			PoopShift = true
		end
		if playerType == PlayerType.PLAYER_BETHANY_B and not RedHeartShift then -- Shifts Stats because of Red Heart Counter
			RedHeartShift = true
		end
		if playerType == PlayerType.PLAYER_BETHANY and not SoulHeartShift then -- Shifts Stats because of Soul Heart Counter
			SoulHeartShift = true
		end

		if player:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) and not DualityShift then -- Shifts Stats because of Duality
			DualityShift = true
		end
	end

	if BombShift then
		ShiftCount = ShiftCount + 1
	end
	if PoopShift then
		ShiftCount = ShiftCount + 1
	end
	if RedHeartShift then
		ShiftCount = ShiftCount + 1
	end
	if SoulHeartShift then
		ShiftCount = ShiftCount + 1
	end
	ShiftCount = ShiftCount - 1 -- There will always be 1 ShiftCount due to bombs and poop, so its safe to do this
	if ShiftCount > 0 then
		wakaba.globalHUDCoords = wakaba.globalHUDCoords + Vector(0, (11 * ShiftCount) - 2)
	end

	--For some reason whether or not Jacob&Esau are 1st player or another player matters, so I have to check specifically if Jacob is player 1 here
	if Isaac.GetPlayer(0):GetPlayerType() == PlayerType.PLAYER_JACOB then
		wakaba.globalHUDCoords = wakaba.globalHUDCoords + Vector(0, 30)
	elseif TrueCoopShift then
		wakaba.globalHUDCoords = wakaba.globalHUDCoords + Vector(0, 16)
		if DualityShift then
			wakaba.globalHUDCoords = wakaba.globalHUDCoords + Vector(0, -2) -- I hate this
		end
	end
	if DualityShift then
		wakaba.globalHUDCoords = wakaba.globalHUDCoords + Vector(0, -12)
	end

	--Checks if Hard Mode and Seeded/Challenge/Daily; Seeded/Challenge have no achievements logo, and Daily Challenge has destination logo.
	if Game().Difficulty == Difficulty.DIFFICULTY_HARD or Game():IsGreedMode() or not wakaba:CanRunUnlockAchievements() then
		wakaba.globalHUDCoords = wakaba.globalHUDCoords + Vector(0, 16)
	end

	wakaba.globalHUDCoords = wakaba.globalHUDCoords + (Options.HUDOffset * Vector(20, 12))
end

local colourDefault = KColor(1, 1, 1, 0.5, 0, 0, 0)
wakaba._hudShiftPos = 1
function wakaba:Render_GlobalHUDStats(sn)
	if shouldDeHook() then return end

	if not REPENTOGON then

		local isShader = sn == "wakaba_ChallengeDest_DummyShader" and true or false
		if not (wakaba.G:IsPaused() and Isaac.GetPlayer(0).ControlsEnabled) and not isShader then return end -- no render when unpaused
		if (wakaba.G:IsPaused() and Isaac.GetPlayer(0).ControlsEnabled) and isShader then return end -- no shader when paused
		if sn ~= nil and not isShader then return end -- final failsafe
	end


	wakaba:FoundHUDUpdateCheck()
	local position = Vector(wakaba.globalHUDCoords.X, wakaba.globalHUDCoords.Y)
	local offset = 0

  for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD)) do
    local renderedHUDElement = callback.Function(callback.Mod)
    if renderedHUDElement then
      local sprite = renderedHUDElement.Sprite
      local renderedText = renderedHUDElement.Text
      local textColor = renderedHUDElement.TextColor or colourDefault
      if sprite and renderedText then
        --account for screenshake offset
				local renderPos = position + Vector(0, (12 * offset) )
        local textCoords = renderPos + Game().ScreenShakeOffset

        font:DrawString(renderedText, textCoords.X + 16, textCoords.Y + 1, textColor, 0, true)
				sprite.Color = Color(1, 1, 1, 0.5, 0, 0, 0)
        sprite:Render(renderPos + Vector(0, wakaba._hudShiftPos or 1), Vector(0, 0), Vector(0, 0))

        offset = offset + 1
      elseif renderedHUDElement.Skip then
        offset = offset + 1
      end
    end
  end
end

wakaba:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, wakaba.Render_GlobalHUDStats)
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_GlobalHUDStats)


function wakaba:DidPlayerDualityCountJustChange(player)
	local data = player:GetData()
	if data.w_didDualityCountJustChange then
		return true
	end
	return false
end

wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
	local data = player:GetData()
	local currentDualityCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DUALITY)
	if not data.w_lastDualityCount then
		data.w_lastDualityCount = currentDualityCount
	end
	data.w_didDualityCountJustChange = false
	if data.w_lastDualityCount ~= currentDualityCount then
		data.w_didDualityCountJustChange = true
	end
	data.w_lastDualityCount = currentDualityCount
end)

--character just change
function wakaba:DidPlayerCharacterJustChange(player)
	local data = player:GetData()
	if data.w_playerTypeJustChanged then
		return true
	end
	return false
end

wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
	local data = player:GetData()
	local playerType = player:GetPlayerType()
	if not data.w_lastPlayerType then
		data.w_lastPlayerType = playerType
	end
	data.w_playerTypeJustChanged = false
	if data.w_lastPlayerType ~= playerType then
		data.w_playerTypeJustChanged = true
	end
	data.w_lastPlayerType = playerType
end)


wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, -30000, function(_)
	if PlanetariumChance and not PlanetariumChance:shouldDeHook() then
		return {Skip = true}
	end
end)
