wakaba.BRING_ME_THERE = Isaac.GetTrinketIdByName("Bring me there")

local function isRep(stype)
	if (stype == StageType.STAGETYPE_REPENTANCE or stype == StageType.STAGETYPE_REPENTANCE_B) then
		return true	
	else 
		return false 
	end
end

function wakaba:checkMausoleumDest()
	local level = Game():GetLevel()
	local st = level:GetAbsoluteStage()
	local hasnote = false
	for num = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(num)
		if player:HasTrinket(wakaba.BRING_ME_THERE) then
			hasnote = true
			--Game():SetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT, true)
		end
	end
	if Game().Challenge == Challenge.CHALLENGE_NULL 
	-- Mines/Ashpit XL to Mausoleum/Gehenna XL
	and ((st == LevelStage.STAGE2_1 and level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH == LevelCurse.CURSE_OF_LABYRINTH and isRep(level:GetStageType()))
	-- Mines/Ashpit 2 to Mausoleum/Gehenna XL
	or (st == LevelStage.STAGE2_2 and isRep(level:GetStageType()))
	-- Depths 1 to Mausoleum/Gehenna 1
	-- Mausoleum/Gehenna 1 to Mausoleum/Gehenna 2
	or (st == LevelStage.STAGE3_1)
	) then
		if hasnote then
			for num = 1, Game():GetNumPlayers() do
				local player = Isaac.GetPlayer(num)
				if player:GetSprite():IsPlaying("Trapdoor") or player:GetSprite():IsPlaying("LightTravel") then
					Game():SetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT, true)
				end
			end
		end
	elseif st == LevelStage.STAGE4_1 then
		Game():SetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT, false)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.checkMausoleumDest)

function wakaba:startMausoleumRoomCheck()
	local hasTrinket = false
	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:HasTrinket(wakaba.BRING_ME_THERE) then
			hasTrinket = true
		end
	end
	local room = Game():GetRoom()
	local level = Game():GetLevel()
	if Game().Challenge == Challenge.CHALLENGE_NULL
	and not hasTrinket then
		if level:GetStartingRoomIndex() == level:GetCurrentRoomIndex() and room:IsFirstVisit()
		and isRep(level:GetStageType())
		and level:GetAbsoluteStage() == LevelStage.STAGE3_1
		and not Game():GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH)
		and level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH == 0
		then
			Game():SetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT, false)
		end
		if wakaba.state.forcevoid.beast
		and (Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE2_2 or Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE3_1) and (
			Game():GetLevel():GetStageType() == StageType.STAGETYPE_REPENTANCE or Game():GetLevel():GetStageType() == StageType.STAGETYPE_REPENTANCE_B
		) and not Game():GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH)
		then
			if level:GetStartingRoomIndex() == level:GetCurrentRoomIndex() and room:IsFirstVisit() then
				if level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH == LevelCurse.CURSE_OF_LABYRINTH and not Game():GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH_INIT) then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_FORGET_ME_NOW, room:GetGridPosition(102), Vector(0,0), nil)
				end
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.BRING_ME_THERE, room:GetGridPosition(92), Vector(0,0), nil)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.startMausoleumRoomCheck)

function wakaba:dadNoteCache(player, cacheFlag)
	if player:HasTrinket(wakaba.BRING_ME_THERE) and cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
		player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (1.5 * player:GetTrinketMultiplier(wakaba.BRING_ME_THERE)))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.dadNoteCache)

function wakaba.dadNotePickupCheck(pickup)
	if pickup.Variant == PickupVariant.PICKUP_TRINKET and pickup.SubType == wakaba.BRING_ME_THERE and Game().Challenge ~= Challenge.CHALLENGE_NULL then
		pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, TrinketType.TRINKET_NULL)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.dadNotePickupCheck)
