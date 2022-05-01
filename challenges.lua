
wakaba.COLLECTIBLE_WAKABAS_CURFEW = Isaac.GetItemIdByName("Wakaba's 6'o Clock Curfew")
wakaba.COLLECTIBLE_WAKABAS_CURFEW2 = Isaac.GetItemIdByName("Wakaba's 9'o Clock Curfew")
--wakaba.COLLECTIBLE_LAKE_OF_BISHOP = Isaac.GetItemIdByName("See des Bischofs")


local Challenges = wakaba.challenges
local randinterval = 300
local randtainted = wakaba.state.randtainted
local rift
local isChallengeContinue = true

function wakaba:isSpeed()
	local speed = false
	if Game().Challenge == Challenges.CHALLENGE_ELEC 
	--or Game().Challenge == Challenges.CHALLENGE_SLNT
	--or Game().Challenge == Challenges.CHALLENGE_PLUM 
	then
		speed = true
	end
	return speed
end
function wakaba:isSlow()
	local speed = false
	if Game().Challenge == Challenges.CHALLENGE_SLNT 
	then
		speed = true
	end
	return speed
end

function wakaba:isHush()
	local hush = false
	if Game().Challenge == Challenges.CHALLENGE_HUSH 
	or Game().Challenge == Challenges.CHALLENGE_PLUM 
	or Game().Challenge == Challenges.CHALLENGE_DOPP 
	then
		hush = true
	end
	return hush
end

function wakaba:isDelirium()
	local delirium = false
	if Game().Challenge == Challenges.CHALLENGE_DELI 
	or Game().Challenge == Challenges.CHALLENGE_RAND
	or Game().Challenge == Challenges.CHALLENGE_SLNT
	or Game().Challenge == Challenges.CHALLENGE_BIKE
	then
		delirium = true
	end
	return delirium
end

function wakaba:isBeast()
	local beast = false
	if Game().Challenge == Challenges.CHALLENGE_DRMS 
	then
		beast = true
	end
	return beast
end

function wakaba:isDevilAngelAllowed()
	local devil = true
	if Game().Challenge == Challenges.CHALLENGE_DRMS 
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
		Game().BlueWombParTime = 2147483647
	else
		Game().BlueWombParTime = 54000
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.startChallenge)

function wakaba:challengeItemCheck(player)
	if Game():GetFrameCount() > 0 then
		if Game().Challenge == Challenges.CHALLENGE_ELEC and not player:HasCollectible(wakaba.COLLECTIBLE_EYE_OF_CLOCK) then
			player:AddCollectible(wakaba.COLLECTIBLE_EYE_OF_CLOCK)
		elseif Game().Challenge == Challenges.CHALLENGE_DOPP and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.COLLECTIBLE_MICRO_DOPPELGANGER then
			--print("Retaking")
			player:SetPocketActiveItem(wakaba.COLLECTIBLE_MICRO_DOPPELGANGER, ActiveSlot.SLOT_POCKET, true)
		elseif Game().Challenge == Challenges.CHALLENGE_DELI and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_STITCHES then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_STITCHES, ActiveSlot.SLOT_POCKET, true)
		elseif Game().Challenge == Challenges.CHALLENGE_SIST and not player:HasCollectible(wakaba.COLLECTIBLE_LIL_WAKABA) then
			player:AddCollectible(wakaba.COLLECTIBLE_LIL_WAKABA)
		elseif Game().Challenge == Challenges.CHALLENGE_HUSH and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_WHITE_PONY then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_WHITE_PONY, ActiveSlot.SLOT_POCKET, true)
		elseif Game().Challenge == Challenges.CHALLENGE_HOLD and not player:HasCollectible(wakaba.COLLECTIBLE_LIL_MAO) then
			player:AddCollectible(wakaba.COLLECTIBLE_LIL_MAO)
		elseif Game().Challenge == Challenges.CHALLENGE_DRMS and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.COLLECTIBLE_DOUBLE_DREAMS then
			player:SetPocketActiveItem(wakaba.COLLECTIBLE_DOUBLE_DREAMS, ActiveSlot.SLOT_POCKET, true)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.challengeItemCheck)

function wakaba:PostChallengePlayerInit(player)
  local player = player or Isaac.GetPlayer()
	wakaba:GetPlayerEntityData(player)

	if Game().Challenge == Challenges.CHALLENGE_ELEC and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:AddCollectible(wakaba.COLLECTIBLE_EYE_OF_CLOCK)
		--Game():GetSeeds():AddSeedEffect(SeedEffect.SEED_ICE_PHYSICS)
	elseif Game().Challenge == Challenges.CHALLENGE_PLUM then
		player:AddCollectible(wakaba.COLLECTIBLE_PLUMY)
	elseif Game().Challenge == Challenges.CHALLENGE_GUPP and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("WakabaB", true) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("WakabaB", true))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_b.anm2"))
		Game():GetSeeds():AddSeedEffect(SeedEffect.SEED_NO_HUD)
	elseif Game().Challenge == Challenges.CHALLENGE_DOPP and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Shiori", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Shiori", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_shiori.anm2"))
		player:SetPocketActiveItem(wakaba.COLLECTIBLE_MICRO_DOPPELGANGER, ActiveSlot.SLOT_POCKET, true)
    wakaba:AfterShioriInit(player)
		player:GetData().wakaba.nextshioriflag = wakaba.COLLECTIBLE_MICRO_DOPPELGANGER
		player:AddKeys(6)
		player:UseActiveItem(wakaba.COLLECTIBLE_MICRO_DOPPELGANGER, (UseFlag.USE_NOANIM | UseFlag.USE_OWNED), -1)
	elseif Game().Challenge == Challenges.CHALLENGE_DELI and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_STITCHES, ActiveSlot.SLOT_POCKET, true)
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_STITCHES, ActiveSlot.SLOT_POCKET, true)
	elseif Game().Challenge == Challenges.CHALLENGE_SIST and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:AddCollectible(wakaba.COLLECTIBLE_LIL_WAKABA)
	elseif Game().Challenge == Challenges.CHALLENGE_DRAW then
		player:AddCollectible(wakaba.COLLECTIBLE_UNIFORM)
	elseif Game().Challenge == Challenges.CHALLENGE_HUSH and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_WHITE_PONY, ActiveSlot.SLOT_POCKET, true)
		player:GetData().wakaba.ponycurrframe = wakaba.ponycooldown
	elseif Game().Challenge == Challenges.CHALLENGE_APPL and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, wakaba.COLLECTIBLE_WAKABAS_BLESSING, player.Position, Vector.Zero, player):ToFamiliar()
		Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, wakaba.COLLECTIBLE_WAKABAS_NEMESIS, player.Position, Vector.Zero, player):ToFamiliar()
	elseif Game().Challenge == Challenges.CHALLENGE_BIKE and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_ANIMA_SOLA, ActiveSlot.SLOT_POCKET, true)
	elseif Game().Challenge == Challenges.CHALLENGE_BIKE and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Wakaba", false) then
		--print("esau spawn cont")
		player:GetData().wakaba.pendingesauspawn = true
		--player:AddCollectible(wakaba.COLLECTIBLE_MINERVA_AURA)
	--[[ elseif Game().Challenge == Challenges.CHALLENGE_GURD and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("ShioriB", true) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("ShioriB", true))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_shiori.anm2"))
    wakaba:AfterShioriInit_b(player)
		player:AddKeys(12)
		player:AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
		player:AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
		player:AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
		player:GetData().wakaba.vintagethreat = true
		local bishop = Isaac.Spawn(EntityType.ENTITY_BISHOP, 0, 0, Isaac.GetFreeNearPosition(player.Position, 64), Vector.Zero, player)
		bishop:AddCharmed(EntityRef(player), -1)
		bishop:AddEntityFlags(EntityFlag.FLAG_PERSISTENT | EntityFlag.FLAG_NO_SPIKE_DAMAGE | EntityFlag.FLAG_DONT_OVERWRITE)
		bishop.HitPoints = bishop.MaxHitPoints * 100
		player:SetPocketActiveItem(wakaba.COLLECTIBLE_LAKE_OF_BISHOP, ActiveSlot.SLOT_POCKET, true) ]]
		
	elseif Game().Challenge == Challenges.CHALLENGE_CALC and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("ShioriB", true) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("ShioriB", true))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_shiori_b.anm2"))
    wakaba:AfterShioriInit_b(player)
		player:AddBombs(32)
		player:AddKeys(99)
	elseif Game().Challenge == Challenges.CHALLENGE_HOLD then
		--player:AddCollectible(wakaba.COLLECTIBLE_LIL_MAO)
	elseif Game().Challenge == Challenges.CHALLENGE_RAND and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", randtainted) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(wakaba.COLLECTIBLE_WAKABAS_CURFEW, ActiveSlot.SLOT_POCKET, true)
		player:DischargeActiveItem(ActiveSlot.SLOT_POCKET)
	elseif Game().Challenge == Challenges.CHALLENGE_DRMS and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Wakaba", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
		player:SetPocketActiveItem(wakaba.COLLECTIBLE_DOUBLE_DREAMS, ActiveSlot.SLOT_POCKET, true)
	elseif Game().Challenge == Challenges.CHALLENGE_SLNT and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Shiori", false) then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Shiori", false))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_shiori.anm2"))
		player:SetPocketActiveItem(wakaba.COLLECTIBLE_BOOK_OF_SILENCE, ActiveSlot.SLOT_POCKET, true)
    wakaba:AfterShioriInit(player)
		player:AddKeys(6)
		Game():GetLevel():SetStage(LevelStage.STAGE7, StageType.STAGETYPE_ORIGINAL)
		Isaac.ExecuteCommand("goto s.boss.3414")
	end

	--[[ if Game().Challenge ~= Challenge.CHALLENGE_NULL then
		local sti = player:GetData().wakaba.sindex
		
		wakaba.state.indexes[sti] = {
			storeindex = wakaba.state.storedplayers,
			playertype = player:GetPlayerType(),
			name = player:GetName(),
			controllerindex = player.ControllerIndex, -- controllerindex is available this point
		}
	end ]]

end
--wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostChallengePlayerInit)

function wakaba:PostChallengePlayerInitCont(player)
  local player = player or Isaac.GetPlayer()
	wakaba:GetPlayerEntityData(player)
	if Game().Challenge == Challenges.CHALLENGE_BIKE then
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
	if Game().Challenge == Challenges.CHALLENGE_BIKE then
		local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
		for i, e in ipairs(entities) do
			e:ClearEntityFlags(EntityFlag.FLAG_FRIENDLY)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.preUseItem_Challenge_AnimaSola, CollectibleType.COLLECTIBLE_ANIMA_SOLA)

function wakaba:UseItem_Challenge_Recall(_, rng, player, flags, slot, vardata)
	if Game().Challenge == Challenges.CHALLENGE_HOLD then
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
  local game = Game()
  local room = Game():GetRoom()
  local level = Game():GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
	local type1 = room:GetType()
  local StartingRoom = 84
	
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
	if Game().Challenge == Challenges.CHALLENGE_BIKE then
		local hasEsau = false
		local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
		for i, e in ipairs(entities) do
			e:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
			hasEsau = true
		end
		--[[ if not hasEsau then
			for i = 1, Game():GetNumPlayers() do
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
		if room:IsFirstVisit() and CurRoom == StartingRoom then
			for i = 1, Game():GetNumPlayers() do
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
	elseif Game().Challenge == Challenges.CHALLENGE_RAND then
		if room:IsFirstVisit() and CurRoom == StartingRoom then
			for i = 1, Game():GetNumPlayers() do
				local player = Isaac.GetPlayer(i - 1)
				player:AddBrokenHearts(-12)
			end
		end
	end
	if Game().Challenge == Challenges.CHALLENGE_SLNT then
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
	if Game().Challenge == Challenges.CHALLENGE_HUSH then
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.ponycurrframe = player:GetData().wakaba.ponycurrframe or wakaba.ponycooldown

		if player:NeedsCharge(ActiveSlot.SLOT_POCKET) then
			if player:GetData().wakaba.ponycurrframe > 0 then
				player:GetData().wakaba.ponycurrframe = player:GetData().wakaba.ponycurrframe - 1
			else
				player:FullCharge(ActiveSlot.SLOT_POCKET, true)
				player:GetData().wakaba.ponycurrframe = wakaba.ponycooldown
			end
		elseif player:GetActiveCharge(ActiveSlot.SLOT_POCKET) >= 2 then
			player:GetData().wakaba.ponycurrframe = wakaba.ponycooldown
		end
		if not wakaba.sprites.WhitePonySprite then 
			wakaba.sprites.WhitePonySprite = Sprite()
			wakaba.sprites.WhitePonySprite:Load("gfx/chargebar_pony.anm2", true)
			wakaba.sprites.WhitePonySprite.Color = Color(1,1,1,1)
		end

		local chargeno = wakaba:GetChargeBarIndex(player, "RushPony")
		local chargestate = wakaba:GetChargeState(player, "RushPony")
		local count = (player:GetData().wakaba.ponycurrframe // 6) / 10
		local currval = player:GetData().wakaba.ponycurrframe ~= wakaba.ponycooldown and count or nil

		if chargestate then
			chargestate.CurrentValue = player:GetData().wakaba.ponycurrframe
			chargestate.Count = currval
			chargestate.Sprite = wakaba.sprites.WhitePonySprite
		else
			chargestate = {
				Index = chargeno,
				Profile = "RushPony",
				IncludeFinishAnim = true,
				Sprite = wakaba.sprites.WhitePonySprite,
				MaxValue = wakaba.ponycooldown,
				MinValue = 0,
				Count = currval,
				CurrentValue = player:GetData().wakaba.ponycurrframe,
				Reverse = false,
			}
		end
		wakaba:SetChargeBarData(player, chargeno, chargestate)



	elseif Game().Challenge == Challenges.CHALLENGE_BIKE then
		local game = Game()
		local room = Game():GetRoom()
		local level = Game():GetLevel()
		local CurStage = level:GetAbsoluteStage()
		local CurRoom = level:GetCurrentRoomIndex()
		local StartingRoom = 84
		wakaba:GetPlayerEntityData(player)
		if player:GetData().wakaba.pendingesauspawn and not Game():IsPaused() then
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
		player:GetData().wakaba.chargedframe = player:GetData().wakaba.chargedframe or 0
		player:GetData().wakaba.chargedframe = player:GetData().wakaba.chargedframe + 1
		if player:GetData().wakaba.chargedframe > 5 then
			player:GetData().wakaba.chargedframe = 0
		end
		if room:IsFirstVisit() and CurRoom == StartingRoom then
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
				local chargebarindex = wakaba:GetChargeBarIndex(player, "DeliveryMinerva")
				local chargestate = player:GetData().wakaba.chargestate[chargebarindex]
				if chargestate and chargestate.checkremove then
					wakaba:RemoveChargeBarData(player, chargebarindex)
				end
				if player:WillPlayerRevive() then
					player:GetData().wakaba.minervadeathcount = 600
				end
			end
		end
		if not wakaba.sprites.DeliveryMinervaSprite then 
			wakaba.sprites.DeliveryMinervaSprite = Sprite()
			wakaba.sprites.DeliveryMinervaSprite:Load("gfx/chargebar_clover.anm2", true)
			wakaba.sprites.DeliveryMinervaSprite.Color = Color(1,1,1,1)
		end

		local chargeno = wakaba:GetChargeBarIndex(player, "DeliveryMinerva")
		local chargestate = wakaba:GetChargeState(player, "DeliveryMinerva")
		if chargestate then
			chargestate.CurrentValue = player:GetData().wakaba.minervadeathcount
			chargestate.Count = ((player:GetData().wakaba.minervadeathcount // 6 )/ 10)
			chargestate.Sprite = wakaba.sprites.DeliveryMinervaSprite
		else
			chargestate = {
				Index = chargeno,
				Profile = "DeliveryMinerva",
				IncludeFinishAnim = false,
				Sprite = wakaba.sprites.DeliveryMinervaSprite,
				MaxValue = 600,
				MinValue = 1,
				Count = ((player:GetData().wakaba.minervadeathcount // 6 )/ 10),
				CurrentValue = player:GetData().wakaba.minervadeathcount,
				Reverse = true,
			}
		end
		wakaba:SetChargeBarData(player, chargeno, chargestate)
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Delivery)


function wakaba:ProjectileUpdate_Challenge(tear)

	if Game().Challenge == Challenges.CHALLENGE_SLNT then
		tear:GetData().wakabaInit = true
		tear:AddProjectileFlags(ProjectileFlags.SLOWED)
		tear:ClearProjectileFlags(ProjectileFlags.GHOST)
		tear:ClearProjectileFlags(ProjectileFlags.NO_WALL_COLLIDE)
		tear:AddProjectileFlags(ProjectileFlags.ANY_HEIGHT_ENTITY_HIT)
		tear:AddFallingSpeed((tear.FallingSpeed * -1))
		tear:AddFallingAccel((tear.FallingAccel * -1))
		if tear.Acceleration > 1.3 then
			tear.Acceleration = 1.3
		end
		tear.Height = -10
		
	end

end
--wakaba:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, wakaba.ProjectileUpdate_Challenge)

--[[ function wakaba:ItemUse_LakeOfBishop(_, rng, player, useFlags, activeSlot, varData)
	local ent = Isaac.FindByType(EntityType.ENTITY_BISHOP, -1, -1, true, false)
	local bishop = nil
	for i, e in ipairs(ent) do
		if bishop == nil and e.Parent == player or e:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			bishop = e
		end
	end

	if bishop ~= nil then
		player:AnimateTeleport(true)
		player.Position = Isaac.GetFreeNearPosition(bishop.Position, 16)
		player.Position = bishop.Position
		player:AnimateTeleport(false)
	end

end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_LakeOfBishop, wakaba.COLLECTIBLE_LAKE_OF_BISHOP) ]]


function wakaba:ChallengePostLevel()
	local level = Game():GetLevel()
	
	if wakaba:isDevilAngelAllowed() == false then
		level:DisableDevilRoom()
	end
	
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.ChallengePostLevel)

function wakaba:checkChallengeDest()
	if wakaba:isBeast() and 
	(Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE3_1
		or Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE2_1
		or Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE2_2
	) then
		for num = 1, Game():GetNumPlayers() do
			local player = Game():GetPlayer(num - 1)
			if player:GetSprite():IsPlaying("Trapdoor") or player:GetSprite():IsPlaying("LightTravel") then
				Game():SetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT, true)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.checkChallengeDest)

function wakaba.DreamAdd()
	if Game().Challenge == Challenges.CHALLENGE_DRMS then
		return 1
	else
		return 0
	end
end
--CCO.DamoclesAPI.AddDamoclesCallback(wakaba.DreamAdd)

--CacheFlags for Challenges
function wakaba:cacheChallenges(player, cacheFlag)
	if Game().Challenge == Challenges.CHALLENGE_ELEC then
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
	elseif Game().Challenge == Challenges.CHALLENGE_PULL then
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.FireDelay = 50000
			player.MaxFireDelay = 50000
		end
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = 0.0001
		end
	elseif Game().Challenge == Challenges.CHALLENGE_MINE then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 1.6
		end
	elseif Game().Challenge == Challenges.CHALLENGE_APPL then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (((30 / (player.MaxFireDelay + 1)) / 8) * (player.ShotSpeed * 0.8) + 1)
		end
	elseif Game().Challenge == Challenges.CHALLENGE_BIKE then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			local totaldamage = 1
			for num = 1, Game():GetNumPlayers() do
				local tp = Game():GetPlayer(num - 1)
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

function wakaba:PostWakabaChallengeUpdate()
	if Game().Challenge == Challenges.CHALLENGE_PULL then
		local player = Isaac.GetPlayer()
		if player:GetNumBombs() < 1 then
			player:AddBombs(1)
		end
	elseif Game().Challenge == Challenges.CHALLENGE_MINE then
		local pl = Isaac.GetPlayer()
		if pl:GetActiveItem(ActiveSlot.SLOT_PRIMARY) ~= CollectibleType.COLLECTIBLE_NOTCHED_AXE then
			pl:AddCollectible(CollectibleType.COLLECTIBLE_NOTCHED_AXE, 128, true, ActiveSlot.SLOT_PRIMARY, 0)
		end
		if pl:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_NOTCHED_AXE then
			pl:SetActiveCharge(128, ActiveSlot.SLOT_PRIMARY)
		end
	elseif Game().Challenge == Challenges.CHALLENGE_GUPP then
		if Game():GetHUD():IsVisible() then
			Game():GetHUD():SetVisible(false)
		end
	elseif Game().Challenge == Challenges.CHALLENGE_BIKE then
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
	elseif Game().Challenge == Challenges.CHALLENGE_CALC then
		for num = 1, Game():GetNumPlayers() do
			local player = Game():GetPlayer(num - 1)
			if wakaba.killcount > 100 then
				player:Die()
			end
		end

	elseif Game().Challenge == Challenges.CHALLENGE_RAND then
		--randinterval = randinterval - 1
		for num = 1, Game():GetNumPlayers() do
			local player = Game():GetPlayer(num - 1)
			player:FullCharge(ActiveSlot.SLOT_PRIMARY, true)
			
			if player:GetActiveCharge(ActiveSlot.SLOT_POCKET) >= 900 or player:GetBatteryCharge(ActiveSlot.SLOT_POCKET) > 0 then
				wakaba.state.allowactives = false
				player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
				player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_b.anm2"))
				if player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) then
					player:GetData().wakaba.maxitemnum = player:GetData().wakaba.maxitemnum or -1
					player:ChangePlayerType(Isaac.GetPlayerTypeByName("Wakaba", false))
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
						local id = Game():GetItemPool():GetCollectible(ItemPoolType.POOL_TREASURE)
						local config = Isaac.GetItemConfig():GetCollectible(id)
						Isaac.DebugString(config.Type .. " " .. player:GetActiveItem() .. " ")
						if config.Type ~= ItemType.ITEM_ACTIVE or player:GetActiveItem() == 0 then
							player:AddCollectible(id)
							addedcount = addedcount + 1
						end
					end
					--player:UseActiveItem(CollectibleType.COLLECTIBLE_D4, false, false, false, false, -1)


					newhealth = player:GetSoulHearts()
					player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba.anm2"))
					player:AnimateSad()
					randtainted = false
					player:SetPocketActiveItem(wakaba.COLLECTIBLE_WAKABAS_CURFEW, ActiveSlot.SLOT_POCKET, false)
					--randinterval = 300
					SFXManager():Play(SoundEffect.SOUND_LAZARUS_FLIP_DEAD)
				else
					player:GetData().wakaba.maxitemnum = player:GetData().wakaba.maxitemnum or -1
					player:ChangePlayerType(Isaac.GetPlayerTypeByName("WakabaB", true))
					player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, false, false, false, false, -1)
					player:UseActiveItem(CollectibleType.COLLECTIBLE_D8, false, false, false, false, -1)
					player:UseActiveItem(CollectibleType.COLLECTIBLE_D10, false, false, false, false, -1)
					player:UseActiveItem(CollectibleType.COLLECTIBLE_D12, false, false, false, false, -1)
					player:UseActiveItem(CollectibleType.COLLECTIBLE_D20, false, false, false, false, -1)

					local removedcount = 0
					local maxnum = -1
					local itemcount = wakaba:GetMinTMTRAINERNumCount(player)
					Isaac.DebugString("[wakaba]Rem Start " .. maxnum .. " " .. removedcount .. " " .. itemcount)
					--print(itemcount)
					while removedcount < itemcount do
						local config = Isaac.GetItemConfig():GetCollectible(maxnum)
						if config and player:HasCollectible(maxnum) then
							player:RemoveCollectible(maxnum)
							Isaac.DebugString("[wakaba]Removed " .. config.Name .. " " .. removedcount .. " " .. itemcount)
							removedcount = removedcount + 1
						end
						maxnum = maxnum - 1
					end
					local addedcount = 0
					Isaac.DebugString("[wakaba]Adding items...")
					while addedcount < itemcount do
						local id = Game():GetItemPool():GetCollectible(ItemPoolType.POOL_TREASURE)
						local config = Isaac.GetItemConfig():GetCollectible(id)
						Isaac.DebugString(config.Type .. " " .. player:GetActiveItem() .. " ")
						if config.Type ~= ItemType.ITEM_ACTIVE or player:GetActiveItem() == 0 then
							player:AddCollectible(id)
							addedcount = addedcount + 1
						end
					end
					--player:UseActiveItem(CollectibleType.COLLECTIBLE_D4, false, false, false, false, -1)

					player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/character_wakaba_b.anm2"))
					player:AnimateSad()
					randtainted = true
					player:SetPocketActiveItem(wakaba.COLLECTIBLE_WAKABAS_CURFEW2, ActiveSlot.SLOT_POCKET, false)
					--randinterval = 300
					SFXManager():Play(SoundEffect.SOUND_LAZARUS_FLIP_ALIVE)
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_RESTOCK) then
					player:RemoveCollectible(CollectibleType.COLLECTIBLE_RESTOCK)
					player:AddCollectible(CollectibleType.COLLECTIBLE_BREAKFAST)
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE) then
					player:RemoveCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
				end
				player:DischargeActiveItem(ActiveSlot.SLOT_POCKET)
				player:EvaluateItems()
				--print("Form Changed : ", wakaba.state.hasbless,"/",wakaba.state.hasnemesis)
				wakaba.state.allowactives = true
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostWakabaChallengeUpdate)

function wakaba:prePickupCollisionChallenge_Delivery(pickup, colliders, low)
	if Game().Challenge == Challenges.CHALLENGE_APPL then
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
			return false
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.prePickupCollisionChallenge_Delivery, PickupVariant.PICKUP_COLLECTIBLE)

function wakaba:pullDamage(target, damage, flags, source, cooldown)
	if Game().Challenge == Challenges.CHALLENGE_PULL then
		if source.Entity ~= nil and source.Entity.Type == 2 then
			local player = source.Entity.SpawnerEntity:ToPlayer()
			if player ~= nil then
				return false
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.pullDamage)

function wakaba:playerDamageChallenge(target, damage, flags, source, cooldown)
	if Game().Challenge == Challenges.CHALLENGE_RAND then
			local player = target:ToPlayer()
			if player then
				if player:GetActiveItem() ~= wakaba.COLLECTIBLE_WAKABAS_CURFEW and player:GetActiveItem() ~= wakaba.COLLECTIBLE_WAKABAS_CURFEW2 then
					player:SetPocketActiveItem(wakaba.COLLECTIBLE_WAKABAS_CURFEW, ActiveSlot.SLOT_POCKET, true)
				end
				player:FullCharge(ActiveSlot.SLOT_POCKET, true)
				player:AddBrokenHearts(-1)
			end
	end
end

wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.playerDamageChallenge, 1)

function wakaba:playerDamageChallenge_Delivery(target, damage, flags, source, cooldown)
	if Game().Challenge == Challenges.CHALLENGE_BIKE then
		if target.Type == EntityType.ENTITY_PLAYER then
			if target:GetData().wakaba
			and target:GetData().wakaba.minervadeathcount > 0 then
				if not (
					flags & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS 
					and flags & DamageFlag.DAMAGE_IV_BAG == DamageFlag.DAMAGE_IV_BAG 
					and flags & DamageFlag.DAMAGE_INVINCIBLE == DamageFlag.DAMAGE_INVINCIBLE
				) then
					return false
				else
				end
			end
		elseif source.Type == EntityType.ENTITY_DARK_ESAU then
			if target:IsEnemy() and damage > 0 
			-- Dark Esau ignores armor by default, but left it just in case
			and not (flags & DamageFlag.DAMAGE_IGNORE_ARMOR == DamageFlag.DAMAGE_IGNORE_ARMOR and flags & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES)
			then
				local collisionMultiplier = source.Entity.CollisionDamage
				damage = damage * collisionMultiplier
				flags = flags | DamageFlag.DAMAGE_IGNORE_ARMOR | DamageFlag.DAMAGE_CLONES
				--Isaac.DebugString("[wakaba]Estimated Damage : " .. damage .. "(" .. collisionMultiplier .."x Damage Multiplier")
				target:TakeDamage(damage, flags, source, cooldown)
				return false
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.playerDamageChallenge_Delivery)


function wakaba:toDelirium(rng, spawnPosition)
	local level = Game():GetLevel()
	local stage = level:GetAbsoluteStage()
	local curse = level:GetCurses()
	local room = Game():GetRoom()
	local type1 = room:GetType()
	--[[ if room:GetBossID() == 6 and Game().Challenge == wakaba.challenges.CHALLENGE_ELEC then
		Game():GetRoom():TrySpawnSecretExit(true, true)
		local dealdoor=nil
		local doorcount=0
		for i=0,8 do
			if Game():GetRoom():GetDoor(i) and Game():GetRoom():GetDoor(i).TargetRoomIndex == GridRooms.ROOM_SECRET_EXIT_IDX then
				dealdoor=Game():GetRoom():GetDoor(i)
				break
			end
		end
    if dealdoor then
			dealdoor:Open()
		end

	end ]]
	if type1 == RoomType.ROOM_BOSS 
	and (wakaba:isDelirium() or wakaba:isHush()) then
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
			return true
		elseif stage == 9 or stage == 8 or (stage == 7 and (curse & LevelCurse.CURSE_OF_LABYRINTH == LevelCurse.CURSE_OF_LABYRINTH)) then
			Game().BlueWombParTime = 2147483647
			return true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.toDelirium)

function wakaba:plumItemPedestal(itemPoolType, decrease, seed) 
	if Game().Challenge == Challenges.CHALLENGE_PLUM then
		if Game():GetRoom():GetType() == RoomType.ROOM_BOSS then
			if Game():GetLevel():GetAbsoluteStage() == 2 then
				return CollectibleType.COLLECTIBLE_CUPIDS_ARROW
			elseif Game():GetLevel():GetAbsoluteStage() == 4 then
				return CollectibleType.COLLECTIBLE_JACOBS_LADDER
			elseif Game():GetLevel():GetAbsoluteStage() == 6 then
				return CollectibleType.COLLECTIBLE_SPOON_BENDER
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, wakaba.plumItemPedestal)


function wakaba:toDelirium2()
	--print("toDelirium called")
	local level = Game():GetLevel()
	local stage = level:GetAbsoluteStage()
	local curse = level:GetCurseName()
	local room = Game():GetRoom()
	local type1 = room:GetType()
	--print("isBoss = ".. type1 == RoomType.ROOM_BOSS)
	--print("stage = ".. stage)
	if type1 == RoomType.ROOM_BOSS 
	and (stage == 8 or stage == 9 or (stage == 7 and curse == "Curse of the Labyrinth")) 
	and (wakaba:isDelirium()) then
		if room:IsClear() then
			local items = Isaac.FindByType(5, PickupVariant.PICKUP_TROPHY, -1, false, false)
			for i, e in ipairs(items) do
				e:Remove()
			end
			
			
			for i=1, room:GetGridSize() do
				local gridEnt = room:GetGridEntity(i)
				if gridEnt then
					if gridEnt:GetType() == GridEntityType.GRID_TRAPDOOR  then
						--print(gridEnt:GetType(), " ",gridEnt:GetVariant())
						if gridEnt:GetVariant() == 1 then
							hasVoid = true
						end
					end
				end
			end
			
			if not hasVoid then
				--print("toDelirium checked")
				local i = math.floor(room:GetGridSize() / 4)
				local gridEnt = room:GetGridEntity()
				room:SpawnGridEntity(i, GridEntityType.GRID_TRAPDOOR, 0, 0, 1)
			end
			
		end
		return false
	end
	
end
--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.toDelirium2)


function wakaba:PreUseItem_NoGenesis(item, rng, player, flag, slot, varData)
	if Game().Challenge == Challenges.CHALLENGE_RAND then
		return true
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.PreUseItem_NoGenesis, CollectibleType.COLLECTIBLE_GENESIS)
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.PreUseItem_NoGenesis, wakaba.COLLECTIBLE_EDEN_STICKY_NOTE)