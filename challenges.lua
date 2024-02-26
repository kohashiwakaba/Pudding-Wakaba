

local isc = require("wakaba_src.libs.isaacscript-common")


local Challenges = wakaba.challenges
local randinterval = 300
local randtainted = wakaba.runstate.randtainted
local rift
local isChallengeContinue = true

function wakaba:isSpeed()
	local speed = false
	if wakaba.G.Challenge == Challenges.CHALLENGE_ELEC
	--or wakaba.G.Challenge == Challenges.CHALLENGE_SLNT
	--or wakaba.G.Challenge == Challenges.CHALLENGE_PLUM
	then
		speed = true
	end
	return speed
end
function wakaba:isSlow()
	local speed = false
	if wakaba.G.Challenge == Challenges.CHALLENGE_SLNT
	then
		speed = true
	end
	return speed
end

function wakaba:isHush()
	local hush = false
	if wakaba.G.Challenge == Challenges.CHALLENGE_HUSH
	or wakaba.G.Challenge == Challenges.CHALLENGE_PLUM
	or wakaba.G.Challenge == Challenges.CHALLENGE_DOPP
	then
		hush = true
	end
	return hush
end

function wakaba:isDelirium()
	local delirium = false
	if wakaba.G.Challenge == Challenges.CHALLENGE_DELI
	or wakaba.G.Challenge == Challenges.CHALLENGE_RAND
	or wakaba.G.Challenge == Challenges.CHALLENGE_SLNT
	or wakaba.G.Challenge == Challenges.CHALLENGE_BIKE
	or wakaba.G.Challenge == Challenges.CHALLENGE_RNPR
	then
		delirium = true
	end
	return delirium
end

function wakaba:isBeast()
	local beast = false
	if wakaba.G.Challenge == Challenges.CHALLENGE_DRMS
	or wakaba.G.Challenge == Challenges.CHALLENGE_SSRC
	then
		beast = true
	end
	return beast
end

function wakaba:isDevilAngelAllowed()
	local devil = true
	if wakaba.G.Challenge == Challenges.CHALLENGE_DRMS
	then
		devil = false
	end
	return devil
end

function wakaba:startChallenge(continue)
	local player = Isaac.GetPlayer()
	if not continue then
    isChallengeContinue = false
    wakaba:PostChallengePlayerInit(player)
	else
    wakaba:PostChallengePlayerInitCont(player)
	end
	if wakaba:isDelirium() or wakaba:isHush() then
		wakaba.G.BlueWombParTime = 2147483647
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.startChallenge)

function wakaba:challengeItemCheck(player)
	if wakaba.G:GetFrameCount() > 0 then
		if wakaba.G.Challenge == Challenges.CHALLENGE_ELEC and not player:HasCollectible(wakaba.Enums.Collectibles.EYE_OF_CLOCK) then
			player:AddCollectible(wakaba.Enums.Collectibles.EYE_OF_CLOCK)
		elseif wakaba.G.Challenge == Challenges.CHALLENGE_DOPP and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.Enums.Collectibles.MICRO_DOPPELGANGER then
			--print("Retaking")
			player:SetPocketActiveItem(wakaba.Enums.Collectibles.MICRO_DOPPELGANGER, ActiveSlot.SLOT_POCKET, true)
		elseif wakaba.G.Challenge == Challenges.CHALLENGE_DELI and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_STITCHES then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_STITCHES, ActiveSlot.SLOT_POCKET, true)
		elseif wakaba.G.Challenge == Challenges.CHALLENGE_SIST and not player:HasCollectible(wakaba.Enums.Collectibles.LIL_WAKABA) then
			player:AddCollectible(wakaba.Enums.Collectibles.LIL_WAKABA)
		elseif wakaba.G.Challenge == Challenges.CHALLENGE_HUSH and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_WHITE_PONY then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_WHITE_PONY, ActiveSlot.SLOT_POCKET, true)
		elseif wakaba.G.Challenge == Challenges.CHALLENGE_HOLD and not player:HasCollectible(wakaba.Enums.Collectibles.LIL_MAO) then
			player:AddCollectible(wakaba.Enums.Collectibles.LIL_MAO)
		elseif wakaba.G.Challenge == Challenges.CHALLENGE_DRMS and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.Enums.Collectibles.DOUBLE_DREAMS then
			player:SetPocketActiveItem(wakaba.Enums.Collectibles.DOUBLE_DREAMS, ActiveSlot.SLOT_POCKET, true)
		elseif wakaba.G.Challenge == Challenges.CHALLENGE_SSRC then
			if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.Enums.Collectibles.WATER_FLAME then
				player:SetPocketActiveItem(wakaba.Enums.Collectibles.WATER_FLAME, ActiveSlot.SLOT_POCKET, true)
			end
			if player:GetData().wakaba and player:GetData().wakaba.flamecnt > 0 then
				player:SetActiveCharge(200000, ActiveSlot.SLOT_POCKET)
			else
				player:SetActiveCharge(0, ActiveSlot.SLOT_POCKET)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.challengeItemCheck)

function wakaba:PostChallengePlayerInit(player)
  player = player or Isaac.GetPlayer()
	wakaba:GetPlayerEntityData(player)

	if wakaba.G.Challenge == Challenges.CHALLENGE_ELEC and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:AddCollectible(wakaba.Enums.Collectibles.EYE_OF_CLOCK)
		--wakaba.G:GetSeeds():AddSeedEffect(SeedEffect.SEED_ICE_PHYSICS)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_PLUM then
		player:AddCollectible(wakaba.Enums.Collectibles.PLUMY)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_GUPP and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("WakabaB", true) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("WakabaB", true))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_b.anm2"))
		wakaba.G:GetSeeds():AddSeedEffect(SeedEffect.SEED_NO_HUD)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_DOPP and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Shiori", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Shiori", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_shiori.anm2"))
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.MICRO_DOPPELGANGER, ActiveSlot.SLOT_POCKET, true)
    wakaba:AfterShioriInit(player)
		player:GetData().wakaba.nextshioriflag = wakaba.Enums.Collectibles.MICRO_DOPPELGANGER
		player:AddKeys(6)
		player:UseActiveItem(wakaba.Enums.Collectibles.MICRO_DOPPELGANGER, (UseFlag.USE_NOANIM | UseFlag.USE_OWNED), -1)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_DELI and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_STITCHES, ActiveSlot.SLOT_POCKET, true)
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_STITCHES, ActiveSlot.SLOT_POCKET, true)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_SIST and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:AddCollectible(wakaba.Enums.Collectibles.LIL_WAKABA)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_DRAW then
		player:AddCollectible(wakaba.Enums.Collectibles.UNIFORM)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_HUSH and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_WHITE_PONY, ActiveSlot.SLOT_POCKET, true)
		player:GetData().wakaba.ponycurrframe = wakaba.Enums.Constants.PONY_COOLDOWN
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_APPL and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, wakaba.Enums.Collectibles.WAKABAS_BLESSING, player.Position, Vector.Zero, player):ToFamiliar()
		Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, wakaba.Enums.Collectibles.WAKABAS_NEMESIS, player.Position, Vector.Zero, player):ToFamiliar()
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_BIKE and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_ANIMA_SOLA, ActiveSlot.SLOT_POCKET, true)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_BIKE and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Wakaba", false) then
		--print("esau spawn cont")
		player:GetData().wakaba.pendingesauspawn = true
		--player:AddCollectible(wakaba.Enums.Collectibles.MINERVA_AURA)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_CALC and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("ShioriB", true) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("ShioriB", true))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_shiori_b.anm2"))
    wakaba:AfterShioriInit_b(player)
		player:AddBombs(32)
		player:AddKeys(99)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_HOLD then
		--player:AddCollectible(wakaba.Enums.Collectibles.LIL_MAO)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_EVEN then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Richer", false))
		player:AddSoulHearts(4)
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.SWEETS_CATALOG, ActiveSlot.SLOT_POCKET, true)
		wakaba.G:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_MARKED)
		--player:AddCollectible(wakaba.Enums.Collectibles.LIL_MAO)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_RNPR then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Richer", false))
		player:AddSoulHearts(4)
		wakaba.G:GetItemPool():RemoveCollectible(wakaba.Enums.Collectibles.CLENSING_FOAM)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_RAND and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", randtainted) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.WAKABAS_CURFEW, ActiveSlot.SLOT_POCKET, true)
		player:DischargeActiveItem(ActiveSlot.SLOT_POCKET)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_DRMS and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.DOUBLE_DREAMS, ActiveSlot.SLOT_POCKET, true)
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_SLNT and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Shiori", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Shiori", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_shiori.anm2"))
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.BOOK_OF_SILENCE, ActiveSlot.SLOT_POCKET, true)
    wakaba:AfterShioriInit(player)
		player:AddKeys(6)
		wakaba.G:GetLevel():SetStage(LevelStage.STAGE7, StageType.STAGETYPE_ORIGINAL)
		Isaac.ExecuteCommand("goto s.boss.3414")
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_SSRC then
		player:ChangePlayerType(wakaba.Enums.Players.RICHER_B)
		player:GetData().wakaba.flamecnt = wakaba.Enums.Constants.SSRC_ALLOW_FLAMES
		player:AddMaxHearts(-6)
		player:AddSoulHearts(6)
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.WATER_FLAME, ActiveSlot.SLOT_POCKET, true)
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostChallengePlayerInit)

function wakaba:PostChallengePlayerInitCont(player)
  local player = player or Isaac.GetPlayer()
	wakaba:GetPlayerEntityData(player)
	if wakaba.G.Challenge == Challenges.CHALLENGE_BIKE then
		local esau = Isaac.Spawn(EntityType.ENTITY_DARK_ESAU, 0, -1, wakaba:GetGridCenter(), Vector.Zero, player)
		esau:AddEntityFlags(EntityFlag.FLAG_NO_DEATH_TRIGGER | EntityFlag.FLAG_FRIENDLY)
		--esau:AddCharmed(EntityRef(esau), -1)
		esau.CollisionDamage = esau.CollisionDamage * 3
		--esau.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
		--print("Entered!")
		esau:Update()
	end
end

function wakaba:PostChallengePlayerInit2(player)
  --local player = player or Isaac.GetPlayer()

  if not isChallengeContinue then
    wakaba:PostChallengePlayerInit(player)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostChallengePlayerInit2)

function wakaba:ChallengeExit()
  isChallengeContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.ChallengeExit)

function wakaba:preUseItem_Challenge_AnimaSola(_, rng, player, flags, slot, vardata)
	if wakaba.G.Challenge == Challenges.CHALLENGE_BIKE then
		local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
		for i, e in ipairs(entities) do
			e:ClearEntityFlags(EntityFlag.FLAG_FRIENDLY)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.preUseItem_Challenge_AnimaSola, CollectibleType.COLLECTIBLE_ANIMA_SOLA)

function wakaba:UseItem_Challenge_Recall(_, rng, player, flags, slot, vardata)
	if wakaba.G.Challenge == Challenges.CHALLENGE_HOLD then
		if player:IsHoldingItem() then
			return {Discharge = false}
		end
		local maos = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.CUBE_BABY, wakaba.SUBTYPE_LIL_MAO)
		for i, f in ipairs(maos) do
			local mao = f:ToFamiliar()
			if mao and mao.Player then
				mao:GetData().wakaba.recall = 0
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_Challenge_Recall, CollectibleType.COLLECTIBLE_RECALL)

function wakaba:ChallengeSpeedUp()
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
	if wakaba.G.Challenge == Challenges.CHALLENGE_BIKE then
		local hasEsau = false
		local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
		for i, e in ipairs(entities) do
			e:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
			hasEsau = true
		end
		--[[ if not hasEsau then
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				wakaba:GetPlayerEntityData(player)
				player:GetData().wakaba.pendingesauspawn = true
			end
			local esau = Isaac.Spawn(EntityType.ENTITY_DARK_ESAU, 0, -1, wakaba:GetGridCenter(), Vector.Zero, Isaac.GetPlayer())
			esau:AddEntityFlags(EntityFlag.FLAG_NO_DEATH_TRIGGER | EntityFlag.FLAG_FRIENDLY)
			--esau:AddCharmed(EntityRef(esau), -1)
			esau.CollisionDamage = esau.CollisionDamage * 3
			--esau.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
			esau:Update()
		end ]]
		if room:IsFirstVisit() and isc:inStartingRoom() then
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				wakaba:GetPlayerEntityData(player)
				player:GetData().wakaba.pendingesauspawn = true
				player:GetData().wakaba.minervacount = 7
				player:GetData().wakaba.minervadeathcount = 100
			end
		else
			local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
			for i, e in ipairs(entities) do
				e.Position = Isaac.GetPlayer().Position
			end
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_RAND then
		if room:IsFirstVisit() and isc:inStartingRoom() then
			for i = 1, wakaba.G:GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				player:AddBrokenHearts(-12)
			end
		end
	end
	if wakaba.G.Challenge == Challenges.CHALLENGE_SLNT then
		for i = 0, DoorSlot.NUM_DOOR_SLOTS - 1 do
			local door = room:GetDoor(i)
			if door then
				room:RemoveDoor(i)
			end
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.ChallengeSpeedUp)

function wakaba:PlayerUpdate_Delivery(player)
	if wakaba.G.Challenge == Challenges.CHALLENGE_HUSH then
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.ponycurrframe = player:GetData().wakaba.ponycurrframe or wakaba.Enums.Constants.PONY_COOLDOWN

		if player:NeedsCharge(ActiveSlot.SLOT_POCKET) then
			if player:GetData().wakaba.ponycurrframe > 0 then
				player:GetData().wakaba.ponycurrframe = player:GetData().wakaba.ponycurrframe - 1
			else
				player:FullCharge(ActiveSlot.SLOT_POCKET, true)
				player:GetData().wakaba.ponycurrframe = wakaba.Enums.Constants.PONY_COOLDOWN
			end
		elseif player:GetActiveCharge(ActiveSlot.SLOT_POCKET) >= 2 then
			player:GetData().wakaba.ponycurrframe = wakaba.Enums.Constants.PONY_COOLDOWN
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_BIKE then
		local game = wakaba.G
		local room = wakaba.G:GetRoom()
		local level = wakaba.G:GetLevel()
		local CurStage = level:GetAbsoluteStage()
		local CurRoom = level:GetCurrentRoomIndex()
		wakaba:GetPlayerEntityData(player)
		if player:GetData().wakaba.pendingesauspawn and not wakaba.G:IsPaused() then
			player:GetData().wakaba.pendingesauspawn = false
			local esau = Isaac.Spawn(EntityType.ENTITY_DARK_ESAU, 0, -1, wakaba:GetGridCenter(), Vector.Zero, player)
			esau:AddEntityFlags(EntityFlag.FLAG_NO_DEATH_TRIGGER | EntityFlag.FLAG_FRIENDLY)
			--esau:AddCharmed(EntityRef(esau), -1)
			esau.CollisionDamage = esau.CollisionDamage * 3
			--esau.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
			--print("Entered!")
			esau:Update()
		end
		player:GetData().wakaba.minervadeathcount = player:GetData().wakaba.minervadeathcount or 600
		if room:IsFirstVisit() and isc:inStartingRoom() then
			player:GetData().wakaba.minervacount = 7
			player:GetData().wakaba.minervadeathcount = 600
		elseif player:GetData().wakaba.minervacount > 0 then
			if player:GetData().wakaba.minervadeathcount < 600 then
				player:GetData().wakaba.minervadeathcount = player:GetData().wakaba.minervadeathcount + 12
				if player:GetData().wakaba.minervadeathcount > 600 then
					player:GetData().wakaba.minervadeathcount = 600
				end
			end
		else
			if player:GetData().wakaba.minervadeathcount > 0 then
				if player:AreControlsEnabled() then
					player:GetData().wakaba.minervadeathcount = player:GetData().wakaba.minervadeathcount - 1
				end

			else
				player:TakeDamage(1,0,EntityRef(player),0)
				player:Die()
				if player:WillPlayerRevive() then
					player:GetData().wakaba.minervadeathcount = 600
				end
			end
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_EVEN then
		if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.Enums.Collectibles.SWEETS_CATALOG then
			player:SetPocketActiveItem(wakaba.Enums.Collectibles.SWEETS_CATALOG, ActiveSlot.SLOT_POCKET, true)
		end
		player:SetActiveCharge(12, ActiveSlot.SLOT_POCKET)
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Delivery)


function wakaba:ChallengePostLevel()
	local level = wakaba.G:GetLevel()

	if wakaba:isDevilAngelAllowed() == false then
		level:DisableDevilRoom()
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.ChallengePostLevel)

function wakaba:checkChallengeDest()
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
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.checkChallengeDest)

--CacheFlags for Challenges
function wakaba:cacheChallenges(player, cacheFlag)
	if wakaba.G.Challenge == Challenges.CHALLENGE_ELEC then
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed * 3
		end
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			--player.Damage = player.Damage * 0.4
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			local fDelay = player.FireDelay * 2
			local fDelayMax = player.MaxFireDelay * 2
			player.FireDelay = math.floor(fDelay+0.5)
			player.MaxFireDelay = math.floor(fDelayMax+0.5)
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_PULL then
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.FireDelay = 50000
			player.MaxFireDelay = 50000
		end
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = 0.0001
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_MINE then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 1.6
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_APPL then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (((30 / (player.MaxFireDelay + 1)) / 8) * (player.ShotSpeed * 0.8) + 1)
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_BIKE then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			local totaldamage = 1
			for num = 1, wakaba.G:GetNumPlayers() do
				local tp = wakaba.G:GetPlayer(num - 1)
				totaldamage = totaldamage + (tp.Damage / 16)
			end
			local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
			for i, e in ipairs(entities) do
				e.CollisionDamage = totaldamage
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.cacheChallenges)

---와카바 뒤집기
---@param player EntityPlayer
---@param prevTainted boolean
local function TryFlipWakaba(player, prevTainted)
	player:GetData().wakaba.maxitemnum = player:GetData().wakaba.maxitemnum or -1
	player:ChangePlayerType(prevTainted and wakaba.Enums.Players.WAKABA or wakaba.Enums.Players.WAKABA_B)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, false, false, false, false, -1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D8, false, false, false, false, -1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D10, false, false, false, false, -1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D12, false, false, false, false, -1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D20, false, false, false, false, -1)

	local removedcount = 0
	local maxnum = -1
	local itemcount = wakaba:GetMinTMTRAINERNumCount(player)
	while removedcount < itemcount do
		local config = Isaac.GetItemConfig():GetCollectible(maxnum)
		if config and player:HasCollectible(maxnum) then
			player:RemoveCollectible(maxnum)
			removedcount = removedcount + 1
		end
		maxnum = maxnum - 1
	end
	local addedcount = 0
	while addedcount < itemcount do
		local id = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_TREASURE)
		local config = Isaac.GetItemConfig():GetCollectible(id)
		Isaac.DebugString(config.Type .. " " .. player:GetActiveItem() .. " ")
		if config.Type ~= ItemType.ITEM_ACTIVE or player:GetActiveItem() == 0 then
			player:AddCollectible(id)
			addedcount = addedcount + 1
		end
	end

	player:AnimateSad()
	randtainted = prevTainted
	player:SetPocketActiveItem(prevTainted and wakaba.Enums.Collectibles.WAKABAS_CURFEW or wakaba.Enums.Collectibles.WAKABAS_CURFEW2, ActiveSlot.SLOT_POCKET, false)
	SFXManager():Play(prevTainted and SoundEffect.SOUND_LAZARUS_FLIP_DEAD or SoundEffect.SOUND_LAZARUS_FLIP_ALIVE)

end

function wakaba:PostWakabaChallengeUpdate()
	if wakaba.G.Challenge == Challenges.CHALLENGE_PULL then
		local player = Isaac.GetPlayer()
		if player:GetNumBombs() < 1 then
			player:AddBombs(1)
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_MINE then
		local pl = Isaac.GetPlayer()
		if pl:GetActiveItem(ActiveSlot.SLOT_PRIMARY) ~= CollectibleType.COLLECTIBLE_NOTCHED_AXE then
			pl:AddCollectible(CollectibleType.COLLECTIBLE_NOTCHED_AXE, 128, true, ActiveSlot.SLOT_PRIMARY, 0)
		end
		if pl:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_NOTCHED_AXE then
			pl:SetActiveCharge(128, ActiveSlot.SLOT_PRIMARY)
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_GUPP then
		if wakaba.G:GetHUD():IsVisible() then
			wakaba.G:GetHUD():SetVisible(false)
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_BIKE then
		local hasEsau = false
		local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
		for i, e in ipairs(entities) do
			hasEsau = true
			e:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
			if e:IsDead() then

			end
		end
		--[[ if not hasEsau then
			local esau = Isaac.Spawn(EntityType.ENTITY_DARK_ESAU, 0, -1, wakaba:GetGridCenter(), Vector.Zero, Isaac.GetPlayer())
			esau:AddEntityFlags(EntityFlag.FLAG_BOSSDEATH_TRIGGERED | EntityFlag.FLAG_DONT_COUNT_BOSS_HP | EntityFlag.FLAG_NO_TARGET | EntityFlag.FLAG_NO_DEATH_TRIGGER)
			esau.CollisionDamage = esau.CollisionDamage * 3
			esau:Update()
		end ]]
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_CALC then
		for num = 1, wakaba.G:GetNumPlayers() do
			local player = wakaba.G:GetPlayer(num - 1)
			if wakaba.killcount > 100 then
				player:Die()
			end
		end

	elseif wakaba.G.Challenge == Challenges.CHALLENGE_RAND then
		--randinterval = randinterval - 1
		for num = 1, wakaba.G:GetNumPlayers() do
			local player = wakaba.G:GetPlayer(num - 1)
			player:FullCharge(ActiveSlot.SLOT_PRIMARY, true)

			if player:GetActiveCharge(ActiveSlot.SLOT_POCKET) >= 900 or player:GetBatteryCharge(ActiveSlot.SLOT_POCKET) > 0 then
				wakaba.roomstate.allowactives = false
				local tainted
				if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
					tainted = false
				elseif player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B then
					tainted = true
				end
				TryFlipWakaba(player, tainted)
				if player:HasCollectible(CollectibleType.COLLECTIBLE_RESTOCK) then
					player:RemoveCollectible(CollectibleType.COLLECTIBLE_RESTOCK)
					player:AddCollectible(CollectibleType.COLLECTIBLE_BREAKFAST)
				end
				player:DischargeActiveItem(ActiveSlot.SLOT_POCKET)
				player:EvaluateItems()
				--print("Form Changed : ", wakaba.runstate.hasbless,"/",wakaba.runstate.hasnemesis)
				wakaba.roomstate.allowactives = true
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostWakabaChallengeUpdate)

function wakaba:prePickupCollision_Challenge(pickup, colliders, low)
	if wakaba.G.Challenge == Challenges.CHALLENGE_APPL then
		local id = pickup.SubType
		local config = Isaac.GetItemConfig():GetCollectible(id)
		if not config or not (config:HasTags(ItemConfig.TAG_QUEST) or id == CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			local player = Isaac.GetPlayer()
			if pickup:IsShopItem() and player:GetNumCoins() >= pickup.Price then
				player:AddCoins(pickup.Price * -1)
				if wakaba.kud_wafu then
				else
					SFXManager():Play(SoundEffect.SOUND_POWERUP3)
				end
				pickup.Price = 0
			end
			return pickup:IsShopItem()
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_EVEN then
		local id = pickup.SubType
		local config = Isaac.GetItemConfig():GetCollectible(id)
		if not config or not config:HasTags(ItemConfig.TAG_QUEST) then
			return pickup:IsShopItem()
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.prePickupCollision_Challenge, PickupVariant.PICKUP_COLLECTIBLE)

function wakaba:PostTakeDamage_Challenge(player, amount, flag, source, countdownFrames)
	if wakaba.G.Challenge == Challenges.CHALLENGE_RAND then
		if player:GetActiveItem() ~= wakaba.Enums.Collectibles.WAKABAS_CURFEW and player:GetActiveItem() ~= wakaba.Enums.Collectibles.WAKABAS_CURFEW2 then
			player:SetPocketActiveItem(wakaba.Enums.Collectibles.WAKABAS_CURFEW, ActiveSlot.SLOT_POCKET, true)
		end
		player:FullCharge(ActiveSlot.SLOT_POCKET, true)
		player:AddBrokenHearts(-1)
	end
end

wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_Challenge)

function wakaba:NegateDamage_Challenge(player, amount, flag, source, countdownFrames)
	if wakaba.G.Challenge == Challenges.CHALLENGE_BIKE then
		if player:GetData().wakaba
		and player:GetData().wakaba.minervadeathcount > 0 then
			if not (
				flags & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS
				and flags & DamageFlag.DAMAGE_IV_BAG == DamageFlag.DAMAGE_IV_BAG
				and flags & DamageFlag.DAMAGE_INVINCIBLE == DamageFlag.DAMAGE_INVINCIBLE
			) then
				return false
			end
		end
	end
end
wakaba:AddCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_Challenge)

function wakaba:DeliveryOnDamage(source, newDamage, newFlags)
	local returndata = {}
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
		local collisionMultiplier = source.Entity.CollisionDamage
		returndata.newDamage = newDamage * collisionMultiplier
		returndata.sendNewDamage = true
		returndata.newFlags = newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR | DamageFlag.DAMAGE_CLONES
	end
	return returndata
end

function wakaba:toDelirium(rng, spawnPosition)
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
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.toDelirium)

function wakaba:plumItemPedestal(itemPoolType, decrease, seed)
	if wakaba.G.Challenge == Challenges.CHALLENGE_PLUM then
		if wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSS then
			if wakaba.G:GetLevel():GetAbsoluteStage() == 2 then
				return CollectibleType.COLLECTIBLE_CUPIDS_ARROW
			elseif wakaba.G:GetLevel():GetAbsoluteStage() == 4 then
				return CollectibleType.COLLECTIBLE_JACOBS_LADDER
			elseif wakaba.G:GetLevel():GetAbsoluteStage() == 6 then
				return CollectibleType.COLLECTIBLE_SPOON_BENDER
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, wakaba.plumItemPedestal)

function wakaba:PreUseItem_NoGenesis(item, rng, player, flag, slot, varData)
	if wakaba.G.Challenge == Challenges.CHALLENGE_RAND and player:GetActiveItem(slot) ~= item then
		return true
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.PreUseItem_NoGenesis, CollectibleType.COLLECTIBLE_GENESIS)
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.PreUseItem_NoGenesis, CollectibleType.COLLECTIBLE_DAMOCLES)
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.PreUseItem_NoGenesis, wakaba.Enums.Collectibles.EDEN_STICKY_NOTE)

---@param tear EntityProjectile
function wakaba:ProjectileUpdate_RunawayPheromones(tear)
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_RNPR then
		if not tear:HasProjectileFlags(ProjectileFlags.LASER_SHOT) then
			tear:AddProjectileFlags(ProjectileFlags.LASER_SHOT)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, wakaba.ProjectileUpdate_RunawayPheromones)

---@param npc EntityNPC
function wakaba:NPCInit_RunawayPheromones(npc)
	if wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_RNPR then return end
	if npc.Type ~= EntityType.ENTITY_FIREPLACE
	and npc:IsEnemy()
	and not npc:IsBoss()
	and not npc:HasEntityFlags(EntityFlag.FLAG_FRIENDLY)
	and npc:GetChampionColorIdx() ~= ChampionColor.PINK
	then
		npc:MakeChampion(npc.InitSeed, ChampionColor.PINK, true)
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCInit_RunawayPheromones)










---@param player EntityPlayer
function wakaba:ChargeBarUpdate_Challenge(player)
	if wakaba.G.Challenge == Challenges.CHALLENGE_HUSH then
		if not wakaba:getRoundChargeBar(player, "RushPony") then
			local sprite = Sprite()
			sprite:Load("gfx/chargebar_pony.anm2", true)

			wakaba:registerRoundChargeBar(player, "RushPony", {
				Sprite = sprite,
			}):UpdateSpritePercent(-1)
		end
		local chargeBar = wakaba:getRoundChargeBar(player, "RushPony")

		local current = player:GetData().wakaba.ponycurrframe or wakaba.Enums.Constants.PONY_COOLDOWN
		local count = (current // 6) / 10
		local currval = current ~= wakaba.Enums.Constants.PONY_COOLDOWN and count or -1
		local percent = 100 - (((current / wakaba.Enums.Constants.PONY_COOLDOWN) * 100) // 1)
		if currval == -1 then
			chargeBar:UpdateSpritePercent(-1)
			chargeBar:UpdateText("")
		else
			chargeBar:UpdateSpritePercent(percent)
			chargeBar:UpdateText(currval)
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_BIKE then
		if not wakaba:getRoundChargeBar(player, "DeliveryMinerva") then
			local sprite = Sprite()
			sprite:Load("gfx/chargebar_clover.anm2", true)

			wakaba:registerRoundChargeBar(player, "DeliveryMinerva", {
				Sprite = sprite,
			}):UpdateSpritePercent(-1)
		end
		local chargeBar = wakaba:getRoundChargeBar(player, "DeliveryMinerva")

		local current = player:GetData().wakaba.minervadeathcount
		local count = (current // 6) / 10
		local currval = pcurrent ~= wakaba.Enums.Constants.PONY_COOLDOWN and count or -1
		local percent = ((current / 600) * 100) // 1
		if player:IsDead() then
			chargeBar:UpdateSpritePercent(-1)
			chargeBar:UpdateText("")
		else
			chargeBar:UpdateSpritePercent(percent)
			chargeBar:UpdateText(currval)
		end
	elseif wakaba.G.Challenge == Challenges.CHALLENGE_CALC then
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.ChargeBarUpdate_Challenge)