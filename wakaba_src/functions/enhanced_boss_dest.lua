--[[
	Enhanced Boss Dest
	게임 시작 시 랜덤 보스 설정
	보스 체력 설정
 ]]

local bossTables = {
	["BlueBaby"] = 0,
	["Lamb"] = 1,
	["MegaSatan"] = 2,
	["Delirium"] = 3,
	["Mother"] = 4,
	--["Greed"] = 5,
	["Beast"] = 6,
}

local bossEntities = {
	["BlueBaby"] = {
		{EntityType.ENTITY_ISAAC, 0, Weight = 0.5},
		{EntityType.ENTITY_ISAAC, 1, Weight = 0.5},
	},
	["Lamb"] = {
		{EntityType.ENTITY_SATAN, 0, Weight = 0.25, OnUpdate = true, Filter = function(npc) local sprite = npc:GetSprite(); return sprite:IsPlaying("Change") end},
		{EntityType.ENTITY_SATAN, 10, Weight = 0.25},
		{EntityType.ENTITY_THE_LAMB, 0, Weight = 0.5},
		{EntityType.ENTITY_THE_LAMB, 10, Weight = 0.25},
	},
	["MegaSatan"] = {
		{EntityType.ENTITY_MEGA_SATAN, 0, Weight = 0.5},
		{EntityType.ENTITY_MEGA_SATAN_2, 0, Weight = 0.5, OnUpdate = true, Filter = function(npc) local sprite = npc:GetSprite(); return sprite:IsPlaying("Appear") end},
	},
	["Delirium"] = {
		{EntityType.ENTITY_HUSH, 0, Weight = 0.5},
		{EntityType.ENTITY_DELIRIUM, 0, Weight = 0.5},
	},
	["Mother"] = {
		{EntityType.ENTITY_MOTHER, 0, Weight = 0.5},
		{EntityType.ENTITY_MOTHER, 10, Weight = 0.5, OnUpdate = true, Filter = function(npc) local sprite = npc:GetSprite(); return sprite:IsPlaying("ChargeLoop") end},
	},
	["Greed"] = {
		{EntityType.ENTITY_ULTRA_GREED, 0, Weight = 0.5},
		{EntityType.ENTITY_ULTRA_GREED, 1, Weight = 0.5, OnUpdate = true, Filter = function(npc) local sprite = npc:GetSprite(); return sprite:IsPlaying("Idle") end},
	},
	["Beast"] = {
		{EntityType.ENTITY_DOGMA, 0, Weight = 0.25},
		{EntityType.ENTITY_DOGMA, 1, Weight = 0.25},
		{EntityType.ENTITY_DOGMA, 2, Weight = 0.25, OnUpdate = true, Filter = function(npc) local sprite = npc:GetSprite(); return sprite:IsPlaying("Idle") end},
		{EntityType.ENTITY_BEAST, 10, Weight = 0.1},
		{EntityType.ENTITY_BEAST, 20, Weight = 0.1},
		{EntityType.ENTITY_BEAST, 30, Weight = 0.1},
		{EntityType.ENTITY_BEAST, 40, Weight = 0.1},
		{EntityType.ENTITY_BEAST, 0, Weight = 0.1},
	},
}

function wakaba:GetBossDestinationData()
	local skip = false
	local bossData = {
		Boss = nil,
		Quality = nil,
		ModifyHealth = nil,
		Lunatic = nil,
		DamoclesStart = nil,
	}
	for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.BOSS_DESTINATION)) do
		local newData = callbackData.Function(callbackData.Mod)
		if type(newData) == "boolean" and newData == false then
			skip = true
			break
		elseif type(newData) == "table" and newData ~= nil then
			bossData.Boss = newData.Boss ~= nil and newData.Boss or bossData.Boss
			bossData.Quality = newData.Quality ~= nil and newData.Quality or bossData.Quality
			bossData.ModifyHealth = newData.ModifyHealth ~= nil and newData.ModifyHealth or bossData.ModifyHealth
			bossData.ModifyHealthAmount = newData.ModifyHealthAmount ~= nil and newData.ModifyHealthAmount or bossData.ModifyHealthAmount
			bossData.Lunatic = newData.Lunatic ~= nil and newData.Lunatic or bossData.Lunatic
			bossData.DamoclesStart = newData.DamoclesStart ~= nil and newData.DamoclesStart or bossData.DamoclesStart
			bossData.LockTarget = newData.LockTarget ~= nil and newData.LockTarget or bossData.LockTarget
		end
	end
	if skip then
		return false
	else
		return bossData
	end
end

wakaba:AddCallback(wakaba.Callback.BOSS_DESTINATION, function()
	return {
		Boss = wakaba.state.bossdest, --타겟 보스 (HUD 표시용, 50만 챌린지 적용 시 해당 보스 체력 강화)
		Quality = wakaba.state.startquality, --시작 아이템 퀄리티 (HUD 표시용)
		ModifyHealth = wakaba.state.bossdesthealth, --50만 챌린지 적용
		ModifyHealthAmount = wakaba.state.bossdesthealthamount, --50만 챌린지 적용 체력(총합 기준, 기본값 500000)
		Lunatic = wakaba.state.bossdestlunatic, -- 50만 챌린지 적용 시 대부분 와카바 모드의 방어 무시 효과 무효화, 일부 와카바 모드 아이템 너프
		DamoclesStart = wakaba.state.damoclesstart, -- 50만 챌린지 적용 시 다모 적용
		LockTarget = wakaba.state.bossdestlock, -- 리셋 시 이전 타겟 유지
	}
end)

function wakaba:getBossBuffWeight(entity)
	local bossData = wakaba:GetBossDestinationData()
	if not bossData or type(bossData) ~= "table" or not bossData.Boss or not bossEntities[bossData.Boss] then return end
	for _, dict in ipairs(bossEntities[bossData.Boss]) do
		if entity.Type == dict[1] then
			if not dict[2] or entity.Variant == dict[2] then
				if not dict[3] or entity.SubType == dict[3] then
					return dict.Weight, dict.OnUpdate, dict.Filter
				end
			end
		end
	end
end

---@param npc EntityNPC
function wakaba:NPCInit_BossDest(npc)
	local bossData = wakaba:GetBossDestinationData()
	if not (bossData and bossData.ModifyHealth) then return end
	local weight = wakaba:getBossBuffWeight(npc)
	if not weight or npc:GetData().w_destHealthAltered then return end
	local totalHealth = bossData.ModifyHealthAmount or 500000
	npc.MaxHitPoints = math.max(totalHealth * weight, 1)
	npc.HitPoints = npc.MaxHitPoints
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NPC_INIT, 200, wakaba.NPCInit_BossDest)

---@param npc EntityNPC
function wakaba:NPCUpdate_BossDest(npc)
	if npc:GetData().w_destHealthAltered then return end
	local weight, onUpdate, filter = wakaba:getBossBuffWeight(npc)
	if not onUpdate or not filter or type(filter) ~= "function" then return end
	if filter(npc) then
		wakaba:NPCInit_BossDest(npc)
		npc:GetData().w_destHealthAltered = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCUpdate_BossDest)

function wakaba:BossRoll(modifyHealth, lunatic, damocles, healthAmount, lock, seed)
	local entries = {}
	for k, _ in pairs(bossTables) do
		table.insert(entries, k)
	end
	seed = seed or wakaba.G:GetSeeds():GetStartSeed()
	local rng = RNG()
	rng:SetSeed(seed, 35)
	local selected = rng:RandomInt(#entries) + 1
	local entry = entries[selected]
	wakaba.state.bossdest = entry
	wakaba.state.bossdesthealth = modifyHealth
	wakaba.state.bossdestlunatic = lunatic
	wakaba.state.damoclesstart = damocles
	wakaba.state.bossdestlock = lock
	wakaba.state.bossdesthealthamount = healthAmount
	return entry
end

function wakaba:ClearBossDestData()
	wakaba.state.bossdest = nil
	wakaba.state.bossdesthealth = nil
	wakaba.state.bossdestlunatic = nil
	wakaba.state.damoclesstart = nil
	wakaba.state.bossdestlock = nil
	wakaba.state.bossdesthealthamount = nil
end

function wakaba:SetupDamocles()
	if REPENTOGON then
		if not Isaac.CanStartTrueCoop() then return end
	else
		local game = wakaba.G
		local level = game:GetLevel()
		local inFirstRoom = level:GetStage() == LevelStage.STAGE1_1 and level:GetCurrentRoomIndex() == level:GetStartingRoomIndex() and game:GetRoom():IsFirstVisit() and level:GetStageType() ~= StageType.STAGETYPE_REPENTANCE and level:GetStageType() ~= StageType.STAGETYPE_REPENTANCE_B and not game:GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH)
		if not inFirstRoom then return end
	end
	wakaba:scheduleForUpdate(function()
		wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
			if REPENTOGON then
				local pls = PlayerManager.GetPlayers()
				for _, p in ipairs(pls) do
					if p:GetPlayerType() ~= PlayerType.PLAYER_THESOUL_B then p:AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE) end
					if p:GetFlippedForm() then p:GetFlippedForm():AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE) end
				end
			else
				wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
					if player:GetPlayerType() ~= PlayerType.PLAYER_THESOUL_B then player:AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE) end
					if player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B and wakaba:getTaintedLazarusSubPlayer(player) then wakaba:getTaintedLazarusSubPlayer(player):AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE) end
				end)
			end
		end)
	end, 1)
end

function wakaba:GameStart_BossDest(isContinue)
	if isContinue then return end
	if wakaba.state.bossdestlock then
		if wakaba.state.damoclesstart then
			wakaba:SetupDamocles()
		end
	else
		wakaba:ClearBossDestData()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.GameStart_BossDest)

function wakaba:GameEnd_BossDest(isGameOver)
	if isGameOver then return end
	wakaba:ClearBossDestData()
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_END, wakaba.GameEnd_BossDest)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, -2, function(_)
	local bossData = wakaba:GetBossDestinationData()
	if not bossData or type(bossData) ~= "table" or not bossData.Boss or not bossTables[bossData.Boss] then return end
	wakaba.globalHUDSprite:SetFrame("BossDestination", bossTables[bossData.Boss])
	local text = bossData.Text or bossData.Boss
	local textColor = nil
	local prepend = {}
	if bossData.Lunatic then
		table.insert(prepend, "LUN")
		textColor = KColor(1,0.2,0.2,0.5,0,0,0)
	end
	if bossData.ModifyHealth then
		wakaba.globalHUDSprite:SetOverlayFrame("QualityFlag", 6)
		table.insert(prepend, "EX")
	elseif bossData.Quality and type(bossData.Quality) == "number" then
		wakaba.globalHUDSprite:SetOverlayFrame("QualityFlag", bossData.Quality)
		table.insert(prepend, "Q".. bossData.Quality)
	else
		wakaba.globalHUDSprite:SetOverlayFrame("QualityFlag", 5)
	end
	if #prepend > 0 then
		local prependText = table.concat(prepend, "|")
		text = "["..prependText.."]"..text
	end
	local tab = {
		Sprite = wakaba.globalHUDSprite,
		Text = text,
		TextColor = textColor,
	}
	return tab
end)

function wakaba:NewRoom_BossDest()
	local bossData = wakaba:GetBossDestinationData()
	local level = wakaba.G:GetLevel()
	local stage = level:GetAbsoluteStage()
	local room = wakaba.G:GetRoom()
	if not room:IsClear() then return end
	if bossData.Boss == "Delirium" then
		if stage <= 8 and (room:GetBossID() == 8 or room:GetBossID() == 25) then
			room:TrySpawnBlueWombDoor(false, true, false)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_BossDest)

function wakaba:RoomClear_BossDest()
	local bossData = wakaba:GetBossDestinationData()
	local level = wakaba.G:GetLevel()
	local stage = level:GetAbsoluteStage()
	local room = wakaba.G:GetRoom()
	if bossData.Boss == "Delirium" then
		if stage <= 8 and (room:GetBossID() == 8 or room:GetBossID() == 25) then
			room:TrySpawnBlueWombDoor(false, true, false)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_BossDest)

---@param player EntityPlayer
function wakaba:PlayerUpdate_BossDest(player)
	if Input.IsButtonTriggered(Keyboard.KEY_EQUAL, player.ControllerIndex) then
		if DeadSeaScrollsMenu.OpenedMenu and DeadSeaScrollsMenu.OpenedMenu.DirectoryKey.Item.title == "boss destination" then
			if EID then
				EID:hidePermanentText()
			end
			DeadSeaScrollsMenu.CloseMenu(true)
		else
			DeadSeaScrollsMenu.QueueMenuOpen("Pudding n wakaba", "enhbossdest", 1, true)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_BossDest)