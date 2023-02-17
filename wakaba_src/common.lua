local isc = require("wakaba_src.libs.isaacscript-common")

local voidentered = false


wakaba.UniqueBirthrightSprites = {
	[wakaba.Enums.Players.WAKABA] = "gfx/items/collectibles/birthright/wakaba_birthright.png",
}

local hasBeast = false
local idle_timer = 0
local timerfreeze = 0
local usagetime = -1 -- stores the last time the effect was called.

local function isRep(stype)
	if (stype == StageType.STAGETYPE_REPENTANCE or stype == StageType.STAGETYPE_REPENTANCE_B) then
		return true	
	else 
		return false 
	end
end

--[[ 
	와카바 모드의 ForceVoid 옵션에 따른 플래그값 처리
 ]]
local function isFinalStage(stage, stageType, bossID)
	local flags = wakaba.VoidFlags.NONE
	if stage == 10 then
		-- Isaac/Satan
		if wakaba.state.forcevoid.isaacsatan == 1 then flags = flags | wakaba.VoidFlags.VOID end
	end
	if stage == 11 and bossID ~= 55 then
		-- ???/The Lamb, but Not Mega Satan
		if wakaba.state.forcevoid.bblamb == 1 then flags = flags | wakaba.VoidFlags.VOID end
		if wakaba.state.forcevoid.bblamb == 2 then flags = flags | wakaba.VoidFlags.RKEY end

		-- Key Piece check
		if wakaba.state.forcevoid.keypiece == 1 then flags = flags | wakaba.VoidFlags.PIECES end
	end
	if stage == 11 and bossID == 55 then
		-- Mega Satan
		if wakaba.state.forcevoid.megasatan == 1 then flags = flags | wakaba.VoidFlags.VOID end
		if wakaba.state.forcevoid.megasatan == 2 then flags = flags | wakaba.VoidFlags.RKEY end
	end
	if (stage == 7 or stage == 8) and bossID == 88 then
		-- Mother, Corpse/Labyrinth check is not needed as BossID will be checked anyway
		if wakaba.state.forcevoid.mother == 1 then flags = flags | wakaba.VoidFlags.VOID end
		if wakaba.state.forcevoid.mother == 2 then flags = flags | wakaba.VoidFlags.RKEY end
		if wakaba.state.forcevoid.mother == 3 then flags = flags | wakaba.VoidFlags.CONTINUE end
	end
	if stage == 12 and bossID == 70 then
		-- Delirium
		if wakaba.state.forcevoid.delirium == 2 then flags = flags | wakaba.VoidFlags.RKEY end
	end
	return flags
end

function wakaba:RegisterHeart(player, itemID, itemData)
	if not player then return end
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if not itemData then
		itemData = true
	end
	data.wakaba.registeredhearts = {}
	data.wakaba.registeredhearts.redhearts = player:GetHearts()
	data.wakaba.registeredhearts.soulhearts = player:GetSoulHearts()
	data.wakaba.registeredhearts.bonehearts = player:GetBoneHearts()
	data.wakaba.damageTriggered = data.wakaba.damageTriggered or {}
	if itemID then
		data.wakaba.damageTriggered[itemID] = itemData
	end
end

function wakaba:RemoveRegisteredHeart(player)
	if not player then return end
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	data.wakaba.registeredhearts = nil
end

function wakaba:IsHeartDifferent(player)
	if not player then return false end
	if not player:GetData().wakaba then return false end
	if not player:GetData().wakaba.registeredhearts then return false end
	if player:GetSprite():IsPlaying("LostDeath") or player:GetSprite():IsPlaying("Death") then return true end
	local data = player:GetData()
	registeredhearts = data.wakaba.registeredhearts
	if registeredhearts.redhearts ~= player:GetHearts() then return true end
	if registeredhearts.soulhearts ~= player:GetSoulHearts() then return true end
	if registeredhearts.bonehearts ~= player:GetBoneHearts() then return true end

	return false
end

function wakaba:unlockCheckReset(continue)
	if not continue then
		hasBeast = false
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.unlockCheckReset)

function wakaba:HasJudasBr(player)
	if not player then
		return false
	elseif player:GetPlayerType() == PlayerType.PLAYER_JUDAS or player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			return true
		end
	end

	return false 
end

function wakaba:GetPedestals(includeShop)
	local game = game or wakaba.G
	local pool = pool or game:GetItemPool()
	local config = config or Isaac.GetItemConfig()
	local Pedestals = {}
	includeShop = includeShop or true

	local items = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
	if (#items == 0) then return {} end
	for i = 1, #items do
		local item = items[i]:ToPickup()
		local iConfig = config:GetCollectible(item.SubType)
		if iConfig and (not item.IsShopItem or includeShop) then
			table.insert(Pedestals, {
				CollectibleType = item.SubType,
				Pedestal = item,
				Pool = pool:GetLastPool(),
				Tags = iConfig.Tags,
				Quality = iConfig.Quality,
				Config = iConfig
			})
		end
	end

	return Pedestals
end

--[[
	Helper functions from Cadaver Mod
]]

function wakaba:RandomVelocity()
	return Vector(math.random() * 2, math.random() * 2)
end

function wakaba:OneIndexedRandom(rng, max)
	return rng:RandomInt(max) + 1
end

function wakaba:RandomNearbyPosition(entity)
	local position = Vector(entity.Position.X + math.random(0, 80), entity.Position.Y + math.random(0, 80))
	position = Isaac.GetFreeNearPosition(position, 1)
	return position
end
--[[
	Detect Full Reroll
	Using 1/6 pip Dice rooms also call this function
]]
function wakaba:detectD4(usedItem, rng)
	if usedItem == CollectibleType.COLLECTIBLE_D4
	or usedItem == CollectibleType.COLLECTIBLE_D100
	then
		wakaba.fullreroll = true
		if FairOptionsConfig then
			FairOptionsConfig.Disabled = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.detectD4)

--[[
wakaba.state.forcevoid
Forces Void portals when defeating beyond Chapter 4. 
default is false since reutrning anything in MC_PRE_SPAWN_CLEAN_AWARD refuses grant completion marks

Trapdoor and Cathedral lights were planned to be added in Mother boss fight which is from
https://steamcommunity.com/sharedfiles/filedetails/?id=2493403665

]]
function wakaba:CanOpenMother()
	local c = Isaac.GetItemConfig()
	return c:GetCollectible(CollectibleType.COLLECTIBLE_MEAT_CLEAVER):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_YUCK_HEART):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_GUPPYS_EYE):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_AKELDAMA):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_ETERNAL_D6):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_BIRD_CAGE):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_BLOODY_GUST):IsAvailable() 
			or c:GetTrinket(TrinketType.TRINKET_DEVILS_CROWN):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_TINYTOMA):IsAvailable() 
			or c:GetTrinket(TrinketType.TRINKET_M):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_LOST_SOUL):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_BLOOD_PUPPY):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_KEEPERS_SACK):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_LIL_PORTAL):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_BONE_SPURS):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_REVELATION):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_MAGIC_SKIN):IsAvailable() 
end

function wakaba:CanOpenBeast()
	local c = Isaac.GetItemConfig()
	return c:GetCollectible(CollectibleType.COLLECTIBLE_RED_KEY):IsAvailable() 
end

function wakaba:CanOpenMegaSatan()
	local c = Isaac.GetItemConfig()
	return c:GetCollectible(CollectibleType.COLLECTIBLE_DADS_KEY):IsAvailable() 
end

function wakaba:CanOpenDeli()
	local c = Isaac.GetItemConfig()
	return c:GetCollectible(CollectibleType.COLLECTIBLE_DELIRIOUS):IsAvailable() 
			or c:GetCollectible(CollectibleType.COLLECTIBLE_LIL_DELIRIUM):IsAvailable() 
end

function wakaba:ForceVoid(rng, spawnPosition)
	local level = wakaba.G:GetLevel()
	local stage = level:GetAbsoluteStage()
	local stageType = level:GetStageType()
	local curse = level:GetCurses()
	local room = wakaba.G:GetRoom()
	local type1 = room:GetType()
	local bossID = room:GetBossID() -- 55:Mega Satan, 70:Delirium, 88:Mother
	local finalcheck = isFinalStage(stage, stageType, bossID)
	--print("finalcheck ", finalcheck)
	if type1 == RoomType.ROOM_BOSS 
	and finalcheck ~= wakaba.VoidFlags.NONE
	and (wakaba.G.Challenge == Challenge.CHALLENGE_NULL) then 
	-- -------------------------------
	-- Challenge.CHALLENGE_NULL must be set
	-- This is because Some Wakaba's Challenges requires to beat Hush, Delirium, or even The Beast
	-- -------------------------------
		local center = wakaba:GetGridCenter()
		-- chestfinals is Only for Mega Satan
		local chestfinals = room:GetGridPosition(67)
		local voidfinals = room:GetGridPosition(97)
		local sheol = room:GetGridPosition(66)
		local cathedral = room:GetGridPosition(68)
		local piece1pos = room:GetGridPosition(92)
		local piece2pos = room:GetGridPosition(102)
		if (stage == 7 or stage == 8) then
			-- -------------------------------
			-- Currently bottom of Mother's Boss room will be blocked when room is reentered
			-- Because of this Void portal and end chest will be moved to top
			-- RoomShape Check is for Larger Mother Boss room mod
			-- -------------------------------
			if room:GetRoomShape() == RoomShape.ROOMSHAPE_2x2 then
				chestfinals =	room:GetGridPosition(238)
				voidfinals = room:GetGridPosition(154)
				sheol = room:GetGridPosition(97)
				cathedral = room:GetGridPosition(99)
			else
				chestfinals =	room:GetGridPosition(67)
				voidfinals = room:GetGridPosition(97)
				sheol = room:GetGridPosition(65)
				cathedral = room:GetGridPosition(69)
			end
		elseif (stage == 11 and bossID == 55) then
			-- -------------------------------
			-- Mega Satan's Boss room is opposite from Mother's Boss room
			-- Void portal and end chest will be moved to bottom
			-- -------------------------------
			chestfinals = room:GetGridPosition(127)
			voidfinals = room:GetGridPosition(157)
		elseif (stage == 12) then
			voidfinals = room:GetGridPosition(322)
		end
		-- End Chest spawn, but is currently unused
		--Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BIGCHEST, -1, chestfinals, Vector(0,0), nil)
		if finalcheck & wakaba.VoidFlags.RKEY == wakaba.VoidFlags.RKEY then
			local rkey = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_R_KEY, voidfinals, Vector(0,0), nil):ToPickup()
			rkey:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_R_KEY, false, false, true)
			rkey:GetData().DamoclesDuplicate = true
		end

		if finalcheck & wakaba.VoidFlags.VOID == wakaba.VoidFlags.VOID and wakaba:CanOpenDeli() then
			Isaac.GridSpawn(17,0,voidfinals, true)
			for i=1, room:GetGridSize() do
				local gridEnt = room:GetGridEntity(i)
				if gridEnt then
					if gridEnt:GetType() == GridEntityType.GRID_TRAPDOOR	then
						if gridEnt:GetVariant() == 0 then
							room:SpawnGridEntity(i, GridEntityType.GRID_TRAPDOOR, 1, 0, 1)
							if (stage == 11 and bossID == 55) then return end
						end
					end
				end
			end
		end
		if finalcheck & wakaba.VoidFlags.PIECES == wakaba.VoidFlags.PIECES and wakaba:CanOpenMegaSatan() then
			local p1 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_1, room:GetGridPosition(92), Vector(0,0), nil):ToPickup()
			local p2 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_2, room:GetGridPosition(102), Vector(0,0), nil):ToPickup()
			p1:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_1, false, false, true)
			p2:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_2, false, false, true)
			p1:GetData().DamoclesDuplicate = true
			p2:GetData().DamoclesDuplicate = true
		end
		if finalcheck & wakaba.VoidFlags.CONTINUE == wakaba.VoidFlags.CONTINUE then
			--This must be called AFTER creating void portal
			Isaac.GridSpawn(17,0,sheol, true)
			--Isaac.GridSpawn(17,0,Vector(voidfinals.X, voidfinals.Y + 96), true)
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEAVEN_LIGHT_DOOR, 0, cathedral, Vector(0,0), nil)
		end
		--return true
	-- -------------------------------
	-- Fool card for Mom fight. does not return true to give reward as normal
	-- Only check for Mom fight and will not check for stage nor challenge to fix softlock when using Reverse Emperor card
	-- -------------------------------
	elseif type1 == RoomType.ROOM_BOSS 
	and bossID == 6 
	--and (wakaba.G.Challenge == Challenge.CHALLENGE_NULL) 
	then 
		-- -------------------------------
		-- Knife Piece check for Mausoleum/Gehenna II
		-- -------------------------------
		if wakaba.state.forcevoid.knifepiece > 0
		and (level:GetStageType() == StageType.STAGETYPE_REPENTANCE or level:GetStageType() == StageType.STAGETYPE_REPENTANCE_B) 
		and wakaba.G.Challenge == Challenge.CHALLENGE_NULL
		and wakaba:CanOpenMother() then
			local p1 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KNIFE_PIECE_1, room:GetGridPosition(92), Vector(0,0), nil):ToPickup()
			local p2 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KNIFE_PIECE_2, room:GetGridPosition(102), Vector(0,0), nil):ToPickup()
			p1:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KNIFE_PIECE_1, false, false, true)
			p2:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KNIFE_PIECE_2, false, false, true)
			p1:GetData().DamoclesDuplicate = true
			p2:GetData().DamoclesDuplicate = true
		end
		-- -------------------------------
		-- Fool card for Mom fight.
		-- -------------------------------
		if wakaba.state.forcevoid.mom > 0 and wakaba:CanOpenBeast() then
			-- -------------------------------
			-- Little Baggy Check.
			-- Drops Telepills instead of Fool Card.
			-- -------------------------------
			local hasbaggy = false
			for num = 1, wakaba.G:GetNumPlayers() do
				local player = wakaba.G:GetPlayer(num - 1)
				if player:HasCollectible(CollectibleType.COLLECTIBLE_SACK_HEAD, false) then
					wakaba:GetPlayerEntityData(player)
					player:GetData().wakaba.sackhead = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SACK_HEAD)
					for i = 1, player:GetData().wakaba.sackhead do
						player:RemoveCollectible(CollectibleType.COLLECTIBLE_SACK_HEAD)
					end
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_LITTLE_BAGGY, false) then
					hasbaggy = true
				end
			end
			if hasbaggy then
				local pool = wakaba.G:GetItemPool()
				local pill = pool:ForceAddPillEffect(wakaba.Enums.Pills.TO_THE_START)
				pool:IdentifyPill(pill)
				local p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BREAKFAST, wakaba:GetGridCenter(), Vector(0,0), nil):ToPickup()
				p:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, pill, false, false, true)
			else
				local p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BREAKFAST, wakaba:GetGridCenter(), Vector(0,0), nil):ToPickup()
				p:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_FOOL, false, false, true)
			end
			for num = 1, wakaba.G:GetNumPlayers() do
				local player = wakaba.G:GetPlayer(num - 1)
				if player:GetData().wakaba and player:GetData().wakaba.sackhead then
					for i = 1, player:GetData().wakaba.sackhead do
						player:AddCollectible(CollectibleType.COLLECTIBLE_SACK_HEAD)
					end
					player:GetData().wakaba.sackhead = nil
				end
			end
		end
	end
	
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.ForceVoid)

-- Corpse to Sheol/Cathedral. currently unused because of bugged Delirium
function wakaba:ForceVoidNewRoomCheck()
	local level = wakaba.G:GetLevel()
	local stage = level:GetAbsoluteStage()
	local stageType = level:GetStageType()
	local room = wakaba.G:GetRoom()
	
	if wakaba.state.forcevoid.crackedkey == 1
	and wakaba.G.Challenge == Challenge.CHALLENGE_NULL
	and wakaba:CanOpenBeast()
	then
		if level:GetAbsoluteStage() == LevelStage.STAGE8 then
			if level:GetStartingRoomIndex() == level:GetCurrentRoomIndex() and room:IsFirstVisit() then
				local p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BREAKFAST, room:GetGridPosition(72), Vector(0,0), nil):ToPickup()
				p:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY, false, false, true)
			end
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.ForceVoidNewRoomCheck)

function wakaba:ForceVoidRenderCheck()
	local level = wakaba.G:GetLevel()
	local stage = level:GetAbsoluteStage()
	local stageType = level:GetStageType()
	local room = wakaba.G:GetRoom()
	-- Corpse to Sheol/Cathedral. currently unused because of bugged Delirium
	if room:GetBossID() == 88 then
		for num = 1, wakaba.G:GetNumPlayers() do
			local player = wakaba.G:GetPlayer(num - 1)
			if player:GetSprite():IsPlaying("Trapdoor") then
				if (player.Position.X <= wakaba.G:GetRoom():GetCenterPos().X - 64) then
					wakaba.G:GetLevel():SetStage(LevelStage.STAGE4_2, StageType.STAGETYPE_ORIGINAL)
				end
			elseif player:GetSprite():IsPlaying("LightTravel") then
				wakaba.G:GetLevel():SetStage(LevelStage.STAGE4_2, StageType.STAGETYPE_ORIGINAL)
			end
		end
	-- Remove Little Baggy to prevent Converting Cracked Key into pills
	elseif wakaba.state.forcevoid.crackedkey == 1
	and level:GetAbsoluteStage() == LevelStage.STAGE1_1
	and wakaba.G:GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH) == true
	then

		for num = 1, wakaba.G:GetNumPlayers() do
			local player = wakaba.G:GetPlayer(num - 1)
			if player:GetSprite():IsPlaying("LightTravel") then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_LITTLE_BAGGY) then
					-- Give Polydactyly first before removing Little Baggy
					if not player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDACTYLY) then
						player:AddCollectible(CollectibleType.COLLECTIBLE_POLYDACTYLY)
					end
					player:RemoveCollectible(CollectibleType.COLLECTIBLE_LITTLE_BAGGY)
				end
			end
		end

	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.ForceVoidRenderCheck)

function wakaba:findNearestEntityByPartition(entity, partition)
	local entities = Isaac.FindInRadius(entity.Position,2000,partition)
	local nearest = nil
	local nx, ny, nd = 2000, 2000, 2000
	local nv = nil
	for index, value in ipairs(entities) do
		if value.Type ~= EntityType.ENTITY_FIREPLACE
		and value:IsEnemy()
		and not value:IsInvincible()
		and not value:HasEntityFlags(EntityFlag.FLAG_ICE_FROZEN) 
		and not value:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) 
		then
			local x, y = value.Position.X, value.Position.Y
			local dx, dy = (entity.Position.X - x), (entity.Position.Y - y)
			local distance = math.sqrt((dx ^ 2) + (dy ^ 2))
			if distance < nd then
				nearest = value
				nx, ny, nd = dx, dy, distance
				nv = Vector(-nx, -ny)
			end
		end
	end
	if nv ~= nil then
		nv = nv:Resized(10)
		nx = (nv.X) * -1
		ny = (nv.Y) * -1
	end
	local ret = {
		Entity = nearest,
		Vector = nv,
		X = nx,
		Y = ny,
		Distance = distance,
	}
	--print(ret.Vector, ret.X, ret.Y, ret.Distance)
	return ret
end

-- Removes all spawned NPC entities when activating the function
--[[ function wakaba:onFriendlyInit(npc) 
		if wakaba.G.TimeCounter-usagetime == 0 then -- only remove enemies that spawned when the effect was called!
				npc:Remove()
		end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.onFriendlyInit)
 ]]
function wakaba:ForceOpenDoor(player, roomType)
	if not roomType then return end
	player = player or Isaac.GetPlayer()
	
	for i = 0, DoorSlot.NUM_DOOR_SLOTS do
		local doorR = wakaba.G:GetRoom():GetDoor(i)
		--print(i, (doorR and doorR.TargetRoomType), roomType)
		if doorR and doorR.TargetRoomType == roomType then 
			doorR:TryUnlock(player, true)
		end
	end
end

function wakaba:PreUnlockCheck()
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_BEAST, -1, -1, false, false)) do
		hasBeast = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.PreUnlockCheck)

function wakaba:HasBeast()
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_BEAST, -1, -1, false, false)) do
		return true
	end
	return false
end

function wakaba:TestAchievement(id)
	CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite[id])
end

function wakaba:UnlockCheck(rng, spawnPosition)
	local haswakaba = false
	local hastaintedwakaba = false
	local hasshiori = false
	local hastaintedshiori = false
	local hastsukasa = false
	local hastaintedtsukasa = false
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
			haswakaba = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B then
			hastaintedwakaba = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
			hasshiori = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B then
			hastaintedshiori = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
			hastsukasa = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
			hastaintedtsukasa = true
		end
	end
	local shouldShowPopup = Options.DisplayPopups and not wakaba.state.options.allowlockeditems
	
	local level = wakaba.G:GetLevel()
	local currentStage = level:GetAbsoluteStage()
	local currentStageType = level:GetStageType()
	local difficulty = wakaba.G.Difficulty
	local room = wakaba.G:GetRoom()
	local type1 = room:GetType()
	local bossID = room:GetBossID()
	if wakaba.G.Challenge == Challenge.CHALLENGE_NULL and wakaba.G:GetVictoryLap() <= 0 then
		if difficulty < 2 and type1 == RoomType.ROOM_DUNGEON then
			if currentStage == 13 and hasBeast then -- The Beast
				hasBeast = false
				if haswakaba and wakaba.state.unlock.returnpostage < 2 then 
					wakaba.state.unlock.returnpostage = difficulty + 1 
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.returnpostage)
					--CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.returnpostage)
				end
				if hastaintedwakaba and wakaba.state.unlock.nemesis < 2 then 
					wakaba.state.unlock.nemesis = difficulty + 1 
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.nemesis)
				end
				if hasshiori and wakaba.state.unlock.bookofthegod < 2 then 
					wakaba.state.unlock.bookofthegod = difficulty + 1 
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.bookofthegod)
				end
				if hastaintedshiori and wakaba.state.unlock.minervaaura < 2 then 
					wakaba.state.unlock.minervaaura = difficulty + 1 
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.minervaaura)
				end
				if hastsukasa and wakaba.state.unlock.magmablade < 2 then 
					wakaba.state.unlock.magmablade = difficulty + 1 
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.magmablade)
				end
				if hastaintedtsukasa and wakaba.state.unlock.elixiroflife < 2 then 
					wakaba.state.unlock.elixiroflife = difficulty + 1 
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.elixiroflife)
				end
				wakaba:CheckWakabaChecklist()
			end
		elseif type1 == RoomType.ROOM_BOSSRUSH then
			if haswakaba and wakaba.state.unlock.donationcard < 2 then 
				wakaba.state.unlock.donationcard = difficulty + 1 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.dreamcard)
			end
			if hastaintedwakaba and wakaba.state.unlock.wakabasoul1 < 2 then wakaba.state.unlock.wakabasoul1 = difficulty + 1 end
			if hasshiori and wakaba.state.unlock.unknownbookmark < 2 then 
				wakaba.state.unlock.unknownbookmark = difficulty + 1 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.unknownbookmark)
			end
			if hastaintedshiori and wakaba.state.unlock.shiorisoul1 < 2 then wakaba.state.unlock.shiorisoul1 = difficulty + 1 end
			if hastsukasa and wakaba.state.unlock.concentration < 2 then 
				wakaba.state.unlock.concentration = difficulty + 1 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.concentration)
			end
			if hastaintedtsukasa and wakaba.state.unlock.tsukasasoul1 < 2 then wakaba.state.unlock.tsukasasoul1 = difficulty + 1 end
			wakaba:CheckWakabaChecklist()
		elseif type1 == RoomType.ROOM_BOSS then
			if difficulty < 2 then
				if currentStage ~= LevelStage.STAGE7 and (bossID == 8 or bossID == 25) then -- Mom's Heart
					if haswakaba and wakaba.state.unlock.clover < 2 then
						wakaba.state.unlock.clover = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.clover)
					end
					if hastaintedwakaba and wakaba.state.unlock.taintedwakabamomsheart < 2 then wakaba.state.unlock.taintedwakabamomsheart = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.hardbook < 2 then 
						wakaba.state.unlock.hardbook = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.hardbook)
					end
					if hastaintedshiori and wakaba.state.unlock.taintedshiorimomsheart < 2 then wakaba.state.unlock.taintedshiorimomsheart = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.murasame < 2 then 
						wakaba.state.unlock.murasame = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.murasame)
					end
					if hastaintedtsukasa and wakaba.state.unlock.taintedtsukasamomsheart < 2 then wakaba.state.unlock.taintedtsukasamomsheart = difficulty + 1 end
				elseif bossID == 39 and currentStage == LevelStage.STAGE5 then -- Isaac
					if haswakaba and wakaba.state.unlock.counter < 2 then 
						wakaba.state.unlock.counter = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.counter)
					end
					if hastaintedwakaba and wakaba.state.unlock.bookofforgotten1 < 2 then wakaba.state.unlock.bookofforgotten1 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.shiorid6plus < 2 then 
						wakaba.state.unlock.shiorid6plus = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.shiorid6plus)
					end
					if hastaintedshiori and wakaba.state.unlock.bookmarkbag1 < 2 then wakaba.state.unlock.bookmarkbag1 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.nasalover < 2 then 
						wakaba.state.unlock.nasalover = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.nasalover)
					end
					if hastaintedtsukasa and wakaba.state.unlock.isaaccartridge1 < 2 then wakaba.state.unlock.isaaccartridge1 = difficulty + 1 end




				elseif bossID == 24 and currentStage == LevelStage.STAGE5 then -- Satan
					if haswakaba and wakaba.state.unlock.dcupicecream < 2 then 
						wakaba.state.unlock.dcupicecream = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.dcupicecream)
					end
					if hastaintedwakaba and wakaba.state.unlock.bookofforgotten2 < 2 then wakaba.state.unlock.bookofforgotten2 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.bookoffocus < 2 then 
						wakaba.state.unlock.bookoffocus = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookoffocus)
					end
					if hastaintedshiori and wakaba.state.unlock.bookmarkbag2 < 2 then wakaba.state.unlock.bookmarkbag2 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.beetlejuice < 2 then 
						wakaba.state.unlock.beetlejuice = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.beetlejuice)
					end
					if hastaintedtsukasa and wakaba.state.unlock.isaaccartridge2 < 2 then wakaba.state.unlock.isaaccartridge2 = difficulty + 1 end




				elseif bossID == 40 and currentStage == LevelStage.STAGE6 then -- ???
					if haswakaba and wakaba.state.unlock.pendant < 2 then 
						wakaba.state.unlock.pendant = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.pendant)
					end
					if hastaintedwakaba and wakaba.state.unlock.bookofforgotten3 < 2 then wakaba.state.unlock.bookofforgotten3 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.deckofrunes < 2 then 
						wakaba.state.unlock.deckofrunes = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.deckofrunes)
					end
					if hastaintedshiori and wakaba.state.unlock.bookmarkbag3 < 2 then wakaba.state.unlock.bookmarkbag3 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.redcorruption < 2 then 
						wakaba.state.unlock.redcorruption = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.redcorruption)
					end
					if hastaintedtsukasa and wakaba.state.unlock.isaaccartridge3 < 2 then wakaba.state.unlock.isaaccartridge3 = difficulty + 1 end




				elseif bossID == 54 and currentStage == LevelStage.STAGE6 then -- The Lamb
					if haswakaba and wakaba.state.unlock.revengefruit < 2 then 
						wakaba.state.unlock.revengefruit = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.revengefruit)
					end
					if hastaintedwakaba and wakaba.state.unlock.bookofforgotten4 < 2 then wakaba.state.unlock.bookofforgotten4 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.grimreaperdefender < 2 then
						wakaba.state.unlock.grimreaperdefender = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.grimreaperdefender)
					end
					if hastaintedshiori and wakaba.state.unlock.bookmarkbag4 < 2 then wakaba.state.unlock.bookmarkbag4 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.powerbomb < 2 then 
						wakaba.state.unlock.powerbomb = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.powerbomb)
					end
					if hastaintedtsukasa and wakaba.state.unlock.isaaccartridge4 < 2 then wakaba.state.unlock.isaaccartridge4 = difficulty + 1 end




				elseif bossID == 55 then -- Mega Satan
					if haswakaba and wakaba.state.unlock.whitejoker < 2 then 
						wakaba.state.unlock.whitejoker = difficulty + 1 
						--CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.whitejoker)
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.whitejoker)
					end
					if hastaintedwakaba and wakaba.state.unlock.cloverchest < 2 then
						wakaba.state.unlock.cloverchest = difficulty + 1 
						--CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.cloverchest)
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.cloverchest)
					end
					if hasshiori and wakaba.state.unlock.bookoffallen < 2 then 
						wakaba.state.unlock.bookoffallen = difficulty + 1 
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.bookoffallen)
					end
					if hastaintedshiori and wakaba.state.unlock.shiorivalut < 2 then
						wakaba.state.unlock.shiorivalut = difficulty + 1 
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.shiorivalut)
					end
					if hastsukasa and wakaba.state.unlock.plasmabeam < 2 then 
						wakaba.state.unlock.plasmabeam = difficulty + 1 
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.plasmabeam)
					end
					if hastaintedtsukasa and wakaba.state.unlock.easteregg < 2 then
						wakaba.state.unlock.easteregg = difficulty + 1 
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.easteregg)
					end




				elseif bossID == 63 then -- Hush
					if haswakaba and wakaba.state.unlock.colorjoker < 2 then 
						wakaba.state.unlock.colorjoker = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.colorjoker)
					end
					if hastaintedwakaba and wakaba.state.unlock.wakabasoul2 < 2 then wakaba.state.unlock.wakabasoul2 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.bookoftrauma < 2 then 
						wakaba.state.unlock.bookoftrauma = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookoftrauma)
					end
					if hastaintedshiori and wakaba.state.unlock.shiorisoul2 < 2 then wakaba.state.unlock.shiorisoul2 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.rangeos < 2 then 
						wakaba.state.unlock.rangeos = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.rangeos)
					end
					if hastaintedtsukasa and wakaba.state.unlock.tsukasasoul2 < 2 then wakaba.state.unlock.tsukasasoul2 = difficulty + 1 end




				elseif bossID == 70 then -- Delirium
					if haswakaba and wakaba.state.unlock.wakabauniform < 2 then 
						wakaba.state.unlock.wakabauniform = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.uniform)
					end
					if hastaintedwakaba and wakaba.state.unlock.eatheart < 2 then
						wakaba.state.unlock.eatheart = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.eatheart)
					end
					if hasshiori and wakaba.state.unlock.bookofsilence < 2 then 
						wakaba.state.unlock.bookofsilence = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookofsilence)
					end
					if hastaintedshiori and wakaba.state.unlock.bookofconquest < 2 then
						wakaba.state.unlock.bookofconquest = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookofconquest)
					end
					if hastsukasa and wakaba.state.unlock.newyearbomb < 2 then 
						wakaba.state.unlock.newyearbomb = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.newyearbomb)
					end
					if hastaintedtsukasa and wakaba.state.unlock.flashshift < 2 then
						wakaba.state.unlock.flashshift = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.flashshift)
					end




				elseif bossID == 88 then -- Mother
					if haswakaba and wakaba.state.unlock.confessionalcard < 2 then 
						wakaba.state.unlock.confessionalcard = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.confessionalcard)
					end
					if hastaintedwakaba and wakaba.state.unlock.bitcoin < 2 then
						wakaba.state.unlock.bitcoin = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bitcoin)
					end
					if hasshiori and wakaba.state.unlock.vintagethreat < 2 then 
						wakaba.state.unlock.vintagethreat = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.vintagethreat)
					end
					if hastaintedshiori and wakaba.state.unlock.ringofjupiter < 2 then
						wakaba.state.unlock.ringofjupiter = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.ringofjupiter)
					end
					if hastsukasa and wakaba.state.unlock.phantomcloak < 2 then 
						wakaba.state.unlock.phantomcloak = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.phantomcloak)
					end
					if hastaintedtsukasa and wakaba.state.unlock.sirenbadge < 2 then
						wakaba.state.unlock.sirenbadge = difficulty + 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.sirenbadge)
					end




				end
				wakaba:CheckWakabaChecklist()
			elseif difficulty == 2 then
				if bossID == 62 or bossID == 71 then -- Ultra Greed
					if haswakaba and wakaba.state.unlock.secretcard < 2 then 
						wakaba.state.unlock.secretcard = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.secretcard)
					end
					if hastaintedwakaba and wakaba.state.unlock.blackjoker < 1 then wakaba.state.unlock.blackjoker = 1 end
					if hasshiori and wakaba.state.unlock.magnetheaven < 2 then 
						wakaba.state.unlock.magnetheaven = 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.magnetheaven)
					end
					if hastaintedshiori and wakaba.state.unlock.queenofspades < 1	then wakaba.state.unlock.queenofspades = 1 end
					if hastsukasa and wakaba.state.unlock.arcanecrystal < 2 then 
						wakaba.state.unlock.arcanecrystal = 1 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.arcanecrystal)
					end
					if hastaintedtsukasa and wakaba.state.unlock.returntoken < 1	then wakaba.state.unlock.returntoken = 1 end




					wakaba:CheckWakabaChecklist()
				end
			elseif difficulty == 3 then
				if bossID == 62 or bossID == 71 then -- Ultra Greedier
					if haswakaba and wakaba.state.unlock.secretcard < 2 then 
						wakaba.state.unlock.secretcard = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.secretcard)
					end
					if haswakaba and wakaba.state.unlock.cranecard < 2 then 
						wakaba.state.unlock.cranecard = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.cranecard)
					end
					if hastaintedwakaba and wakaba.state.unlock.blackjoker < 2 then
						wakaba.state.unlock.blackjoker = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.blackjoker)
					end
					if hasshiori and wakaba.state.unlock.magnetheaven < 2 then 
						wakaba.state.unlock.magnetheaven = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.magnetheaven)
					end
					if hasshiori and wakaba.state.unlock.determinationribbon < 2 then 
						wakaba.state.unlock.determinationribbon = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.determinationribbon)
					end
					if hastaintedshiori and wakaba.state.unlock.queenofspades < 2 then
						wakaba.state.unlock.queenofspades = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.queenofspades)
					end
					if hastsukasa and wakaba.state.unlock.arcanecrystal < 2 then 
						wakaba.state.unlock.arcanecrystal = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.arcanecrystal)
					end
					if hastsukasa and wakaba.state.unlock.questionblock < 2 then 
						wakaba.state.unlock.questionblock = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.questionblock)
					end
					if hastaintedtsukasa and wakaba.state.unlock.returntoken < 2 then
						wakaba.state.unlock.returntoken = 2 
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.returntoken)
					end




					wakaba:CheckWakabaChecklist()
				end
			end
		end
	elseif wakaba.G.Challenge ~= Challenge.CHALLENGE_NULL then
		if		 wakaba.G.Challenge == wakaba.challenges.CHALLENGE_ELEC and bossID == 6 then
			if not wakaba.state.unlock.eyeofclock then 
				wakaba.state.unlock.eyeofclock = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.eyeofclock)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_PLUM and bossID == 63 then
			if not wakaba.state.unlock.plumy then
				wakaba.state.unlock.plumy = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.plumy)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_PULL and (bossID == 8 or bossID == 25) then
			if not wakaba.state.unlock.ultrablackhole then wakaba.state.unlock.ultrablackhole = true end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_MINE and (bossID == 8 or bossID == 25) then
			if not wakaba.state.unlock.delimiter then
				wakaba.state.unlock.delimiter = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.delimiter)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_GUPP and bossID == 88 then
			if not wakaba.state.unlock.nekodoll then 
				wakaba.state.unlock.nekodoll = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.nekodoll)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DOPP and bossID == 63 then
			if not wakaba.state.unlock.microdoppelganger then 
				wakaba.state.unlock.microdoppelganger = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.microdoppelganger)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DELI and bossID == 70 then
			if not wakaba.state.unlock.delirium then 
				wakaba.state.unlock.delirium = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.delirium)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_SIST and bossID == 54 then
			if not wakaba.state.unlock.lilwakaba then 
				wakaba.state.unlock.lilwakaba = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.lilwakaba)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DRAW and bossID == 40 then
			if not wakaba.state.unlock.lostuniform then 
				wakaba.state.unlock.lostuniform = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.lostuniform)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_HUSH and bossID == 63 then
			if not wakaba.state.unlock.executioner then 
				wakaba.state.unlock.executioner = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.executioner)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_APPL and bossID == 54 then
			if not wakaba.state.unlock.apollyoncrisis then 
				wakaba.state.unlock.apollyoncrisis = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.apollyoncrisis)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE and bossID == 70 then
			if not wakaba.state.unlock.deliverysystem then 
				wakaba.state.unlock.deliverysystem = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.deliverysystem)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_CALC and bossID == 55 then
			if not wakaba.state.unlock.calculation then 
				wakaba.state.unlock.calculation = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.calculation)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_HOLD and bossID == 88 then
			if not wakaba.state.unlock.lilmao then 
				wakaba.state.unlock.lilmao = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.lilmao)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_RAND and bossID == 70 then
			if not wakaba.state.unlock.edensticky then 
				wakaba.state.unlock.edensticky = true 
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.edensticky)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DRMS then
			if type1 == RoomType.ROOM_DUNGEON then
				if currentStage == 13 and hasBeast then -- The Beast
					hasBeast = false
					if not wakaba.state.unlock.doubledreams then 
						wakaba.state.unlock.doubledreams = true 
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.doubledreams)
					end
					wakaba:CheckWakabaChecklist()
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.UnlockCheck)

function wakaba:UnlockConvert(playerType)
	if playerType == Isaac.GetPlayerTypeByName("Wakaba", false) then
	elseif playerType == Isaac.GetPlayerTypeByName("WakabaB", true) then
	end
end

-- Get Player from Tear
-- snippet by kittenchilly
function wakaba:GetPtrHashEntity(entity)
	if entity then
			if entity.Entity then
					entity = entity.Entity
			end
			for _, matchEntity in pairs(Isaac.FindByType(entity.Type, entity.Variant, entity.SubType, false, false)) do
					if GetPtrHash(entity) == GetPtrHash(matchEntity) then
							return matchEntity
					end
			end
	end
	return nil
end

function wakaba:GetPlayerFromTear(tear)
	for i=1, 3 do
			local check = nil
			if i == 1 then
					check = tear.Parent
			elseif i == 2 then
					check = mod:GetSpawner(tear)
			elseif i == 3 then
					check = tear.SpawnerEntity
			end
			if check then
					if check.Type == EntityType.ENTITY_PLAYER then
							return wakaba:GetPtrHashEntity(check):ToPlayer()
					elseif check.Type == EntityType.ENTITY_FAMILIAR and check.Variant == FamiliarVariant.INCUBUS then
							local data = mod:GetData(tear)
							data.IsIncubusTear = true
							return check:ToFamiliar().Player:ToPlayer()
					end
			end
	end
	return nil
end

function wakaba:getPlayerFromKnife(knife)
	if knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer() then
		return knife.SpawnerEntity:ToPlayer()
	elseif knife.SpawnerEntity and knife.SpawnerEntity:ToFamiliar() and knife.SpawnerEntity:ToFamiliar().Player then
		local familiar = knife.SpawnerEntity:ToFamiliar()

		if familiar.Variant == FamiliarVariant.INCUBUS or familiar.Variant == FamiliarVariant.SPRINKLER or
				familiar.Variant == FamiliarVariant.TWISTED_BABY or familiar.Variant == FamiliarVariant.BLOOD_BABY or
				familiar.Variant == FamiliarVariant.UMBILICAL_BABY then
			return familiar.Player
		else
			return nil
		end
	else
		return nil
	end
end

function wakaba:GetActiveSlot(player, item)
	local counterslot = nil
	if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == item then
		counterslot = ActiveSlot.SLOT_PRIMARY
	elseif player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == item then
		counterslot = ActiveSlot.SLOT_SECONDARY
	elseif player:GetActiveItem(ActiveSlot.SLOT_POCKET) == item then
		counterslot = ActiveSlot.SLOT_POCKET
	end
	return counterslot
end



local newRoomData = false
local ReplaceT = false
local candidates = {}
local treasureRooms = {}

wakaba.deliblacklist = {
	EntityType.ENTITY_MOTHER,
	EntityType.ENTITY_VISAGE,
	EntityType.ENTITY_ROTGUT,
	EntityType.ENTITY_DUMMY,
}

function wakaba:BlacklistDeli(npc)
	if wakaba.G:GetRoom():GetBossID() == 70 then
		npc:Morph(EntityType.ENTITY_DELIRIUM, 0, 0, -1)
		npc:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
	end
end
for i = 1, #wakaba.deliblacklist do
	wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT,wakaba.BlacklistDeli, wakaba.deliblacklist[i])
end

function wakaba:Render_HUDAlpha()
	local pressed = false
	for i = 1, wakaba.G:GetNumPlayers() do
		if Input.IsActionPressed(ButtonAction.ACTION_MAP, Isaac.GetPlayer(i - 1).ControllerIndex) then
			pressed = true
		end
	end
	if pressed then
		if wakaba.runstate.currentalpha > 100 then
			wakaba.runstate.currentalpha = 100
		elseif wakaba.runstate.currentalpha < 100 then
			wakaba.runstate.currentalpha = wakaba.runstate.currentalpha + 8
		end
	else
		if wakaba.runstate.currentalpha < wakaba.state.options.uniformalpha then
			wakaba.runstate.currentalpha = wakaba.state.options.uniformalpha
		elseif wakaba.runstate.currentalpha > wakaba.state.options.uniformalpha then
			wakaba.runstate.currentalpha = wakaba.runstate.currentalpha - 8
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_HUDAlpha)


function wakaba:GetMinTMTRAINERNum()
	local minnum = -1
	local config = Isaac.GetItemConfig()
	while config:GetCollectible(minnum) do
		minnum = minnum - 1
	end
	return minnum
end

function wakaba:GetMinTMTRAINERNumCount(player)
	local count = 0
	local threshold = -1
	local minnum = wakaba:GetMinTMTRAINERNum()
	while threshold >= minnum do
		--print(threshold, minnum)
		if player:HasCollectible(threshold) then
			count = count + 1
		end
		threshold = threshold - 1
	end
	--print(count)
	return count
end

wakaba.validtainted = {
	wakaba.Enums.Players.WAKABA,
	wakaba.Enums.Players.WAKABA_B,
	wakaba.Enums.Players.SHIORI,
	wakaba.Enums.Players.SHIORI_B,
	wakaba.Enums.Players.TSUKASA,
	wakaba.Enums.Players.TSUKASA_B,
}
wakaba.taintedsprite = {
	[wakaba.Enums.Players.WAKABA] = "gfx/characters/costumes/character_wakabab.png",
	[wakaba.Enums.Players.WAKABA_B] = "gfx/characters/costumes/character_wakaba.png",
	[wakaba.Enums.Players.SHIORI] = "gfx/characters/costumes/character_shiorib.png",
	[wakaba.Enums.Players.SHIORI_B] = "gfx/characters/costumes/character_shiori.png",
	[wakaba.Enums.Players.TSUKASA] = "gfx/characters/costumes/character_tsukasab.png",
	[wakaba.Enums.Players.TSUKASA_B] = "gfx/characters/costumes/character_tsukasa.png",
}


--[[ 
	Tainted Character unlock code from AgentCucco(Job)
	Normally, the player is defined through for i = 0, wakaba.G:GetNumPlayers() -1 , then Isaac.GetPlayer(i).
	But this function used Isaac.GetPlayer(0) on purpose as Tainted unlock only works for first player even with vanilla characters.
 ]]
function wakaba:Effect_TaintedWakabaReady()
	local player = Isaac.GetPlayer(0)
	wakaba:GetPlayerEntityData(player)
	local ptype = Isaac.GetPlayer(0):GetPlayerType()

	if wakaba:has_value(wakaba.validtainted, ptype) and not player:GetData().wakaba.taintedtouched then
		if wakaba.G:GetLevel():GetCurrentRoomDesc().Data.Name == "Closet L" then
			local ents = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
			local ents2 = Isaac.FindByType(EntityType.ENTITY_SHOPKEEPER)
			if #ents + #ents2 > 0 then
				for _, e in ipairs(ents) do
					--local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, e.Position, Vector.Zero, player)
					e:Remove()
				end
				for _, e in ipairs(ents2) do
					--local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, e.Position, Vector.Zero, player)
					e:Remove()
				end
			end
			local tents = Isaac.FindByType(EntityType.ENTITY_SLOT, 14)
			if #tents > 0 then
				for _, e in ipairs(tents) do
					if wakaba.runstate.lockedcharacter then
						e:Remove()
					else
						local sprite = e:GetSprite()
						local edata = e:GetData()
						if edata.wakaba and edata.wakaba.tready then
							if sprite:IsFinished("PayPrize") then
								player:GetData().wakaba.taintedtouched = true
								if not wakaba.state.unlock.taintedtsukasa and edata.wakaba.ptype and edata.wakaba.ptype == wakaba.Enums.Players.TSUKASA then
									wakaba.state.unlock.taintedtsukasa = true
									CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.taintedtsukasa)
									wakaba:CheckWakabaChecklist()
								else
									for i = 0, wakaba.G:GetNumPlayers() - 1 do
										Isaac.GetPlayer(i):AddCollectible(CollectibleType.COLLECTIBLE_INNER_CHILD)
									end
								end
							end
						end
						edata.wakaba = edata.wakaba or {}
						edata.wakaba.tready = true
						edata.wakaba.ptype = ptype
						sprite:ReplaceSpritesheet(0, wakaba.taintedsprite[ptype])
						sprite:LoadGraphics()
					end
				end
			elseif not wakaba.runstate.lockedcharacter then
				local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, wakaba.G:GetRoom():GetCenterPos(), Vector.Zero, nil)
				ne:GetData().wakaba = {}
				ne:GetData().wakaba.tready = true
				ne:GetData().wakaba.ptype = ptype
				ne:GetSprite():ReplaceSpritesheet(0, wakaba.taintedsprite[ptype])
				ne:GetSprite():LoadGraphics()
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Effect_TaintedWakabaReady)

--[[ 
	Birthright code from "Unique Birthright Sprites" @Gouchnox
	https://steamcommunity.com/sharedfiles/filedetails/?id=2690434875
	Temporarily added for support Wakaba characters
 ]]
function wakaba:UniqueBirthrightUpdate(e)
	local player = Isaac.GetPlayer(0)
	if e.Type == EntityType.ENTITY_PICKUP and e.Variant == PickupVariant.PICKUP_COLLECTIBLE and e.SubType == CollectibleType.COLLECTIBLE_BIRTHRIGHT 
	and wakaba.G:GetLevel():GetCurses() & LevelCurse.CURSE_OF_BLIND ~= LevelCurse.CURSE_OF_BLIND 
	and wakaba.UniqueBirthrightSprites[player:GetPlayerType()] then
		local sprite = e:GetSprite()
		sprite:ReplaceSpritesheet(1, wakaba.UniqueBirthrightSprites[player:GetPlayerType()])
		sprite:LoadGraphics()
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.UniqueBirthrightUpdate)

-- Roll function from manaphoenix

-- Luck is the Players Current Luck
-- MinRoll is the Minium percentage needed to hit the chance you want. (aka, if you want it happen 30% of the time, put 30)
-- LuckPerc is how much each 1 Luck is worth in terms of percentage. (aka, if you want 1 luck = +5% chance on top whatever it rolled, put 5)
-- returns true if you *Should* consider the roll successful, and false if not.
function wakaba:Roll(rng, Luck, MinRoll, LuckPerc, MaxPerc)
	if not rng then return end
	Luck = Luck or 0
	MinRoll = MinRoll or 0
	LuckPerc = LuckPerc or 0
	if LuckPerc > 0 and MaxPerc and type(MaxPerc) == "number" then
		if MinRoll + (Luck * LuckPerc) > MaxPerc then
			Luck = (MaxPerc - MinRoll) / LuckPerc
		end
	end 
	local roll = rng:RandomFloat() * 100
	local offset = 100 - (roll + Luck * LuckPerc)
--[[ 
	print(Luck, MinRoll, LuckPerc, MaxPerc)
	print(roll)
	print(Luck * LuckPerc)
	print(roll + Luck * LuckPerc)
	print(offset, MinRoll)
	 ]]
	if offset <= MinRoll then
		return true
	end

	return false
end

local function fact(log, num, max) -- used for the log func, don't use!
	local n = 0
	for i = num, 2, - 1 do
		local form = (log * ((max - i) / max))
		form = form % 1 > 0 and (math.floor(form) + 1) or form
		n = n + form
	end
	return n
end

-- Luck is the Players Current Luck
-- MinRoll is the Minium percentage needed to hit the chance you want. (aka, if you want it happen 30% of the time, put 30)
-- LuckPerc is how much each 1 Luck is worth in terms of percentage. (aka, if you want 1 luck = +5% chance on top whatever it rolled, put 5)
-- Max is the the Max number you want your chance to scale with luck. (aka, if you want your chance to stop scaling after the players get above 20 luck, put 20)
-- returns true if you *Should* consider the roll successful, and false if not.
function wakaba:LogRoll(rng, Luck, MinRoll, LuckPerc, Max)
	local roll = rng:RandomFloat() * 100
	local offset = 100 - roll
	if (Luck == 1) then
		offset = 100 - (roll + LuckPerc)
	else
		offset = 100 - (roll + fact(LuckPerc, Luck, Max))
	end
	if offset <= MinRoll then
		return true
	end

	return false
end

function wakaba:IsMoveTriggered(player)
	if Input.IsActionTriggered(ButtonAction.ACTION_LEFT, player.ControllerIndex)
	or Input.IsActionTriggered(ButtonAction.ACTION_RIGHT, player.ControllerIndex)
	or Input.IsActionTriggered(ButtonAction.ACTION_UP, player.ControllerIndex)
	or Input.IsActionTriggered(ButtonAction.ACTION_DOWN, player.ControllerIndex)
	then
		return true
	end
end

function wakaba:IsMoving(player)
	if Input.IsActionPressed(ButtonAction.ACTION_LEFT, player.ControllerIndex)
	or Input.IsActionPressed(ButtonAction.ACTION_RIGHT, player.ControllerIndex)
	or Input.IsActionPressed(ButtonAction.ACTION_UP, player.ControllerIndex)
	or Input.IsActionPressed(ButtonAction.ACTION_DOWN, player.ControllerIndex)
	then
		return true
	end
end

function wakaba:IsFireTriggered(player)
	if Input.IsActionTriggered(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
	or Input.IsActionTriggered(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
	or Input.IsActionTriggered(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
	or Input.IsActionTriggered(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
	then
		return true
	end
end

function wakaba:IsFiring(player)
	if Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
	or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
	or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
	or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
	then
		return true
	end
end

-- Pickup Price handle, from Fiend Folio
function wakaba:canAffordPickup(player, pickup)
	local playerType = player:GetPlayerType()
	if pickup.Price > 0 then
		return player:GetNumCoins() >= pickup.Price
	elseif playerType == PlayerType.PLAYER_THELOST or playerType == PlayerType.PLAYER_THELOST_B then
		return true
	elseif pickup.Price == -1 then
		--1 Red
		return math.ceil(player:GetMaxHearts() / 2) + player:GetBoneHearts() >= 1
	elseif pickup.Price == -2 then
		--2 Red
		return math.ceil(player:GetMaxHearts() / 2) + player:GetBoneHearts() >= 1
	elseif pickup.Price == -3 then
		--3 soul
		return math.ceil(player:GetSoulHearts() / 2) >= 1
	elseif pickup.Price == -4 then
		--1 Red, 2 Soul
		return math.ceil(player:GetMaxHearts() / 2) + player:GetBoneHearts() >= 1
	elseif pickup.Price == -7 then
		--1 Soul
		return math.ceil(player:GetSoulHearts() / 2) >= 1
	elseif pickup.Price == -8 then
		--2 Souls
		return math.ceil(player:GetSoulHearts() / 2) >= 1
	elseif pickup.Price == -9 then
		--1 Red, 1 Soul
		return math.ceil(player:GetMaxHearts() / 2) + player:GetBoneHearts() >= 1
	else
		return true
	end
end

function wakaba:PurchasePickup(player, pickup)
	local playerType = player:GetPlayerType()
	if pickup.Price == PickupPrice.PRICE_FREE then
		player:TryRemoveTrinket(TrinketType.TRINKET_STORE_CREDIT)
	elseif pickup.Price > 0 then
		player:AddCoins(-pickup.Price)
	elseif playerType == PlayerType.PLAYER_THELOST or playerType == PlayerType.PLAYER_THELOST_B then
		wakaba:RemoveOtherOptionPickups(pickup)
	elseif pickup.Price == -1 then
		--1 Red
		if player:GetMaxHearts() > 0 then
			player:AddMaxHearts(-2)
		else
			player:AddBoneHearts(-1)
		end
	elseif pickup.Price == -2 then
		--2 Red
		if player:GetMaxHearts() > 2 then
			player:AddMaxHearts(-4)
		elseif player:GetMaxHearts() > 0 then
			player:AddMaxHearts(-2)
			player:AddBoneHearts(-1)
		else
			player:AddBoneHearts(-2)
		end
	elseif pickup.Price == -3 then
		--3 soul
		player:AddSoulHearts(-6)
	elseif pickup.Price == -4 then
		--1 Red, 2 Soul
		if player:GetMaxHearts() > 0 then
			player:AddMaxHearts(-2)
		else
			player:AddBoneHearts(-1)
		end
		player:AddSoulHearts(-4)
	elseif pickup.Price == -7 then
		--1 Soul
		player:AddSoulHearts(-2)
	elseif pickup.Price == -8 then
		--2 Souls
		player:AddSoulHearts(-4)
	elseif pickup.Price == -9 then
		--1 Red, 1 Soul
		if player:GetMaxHearts() > 0 then
			player:AddMaxHearts(-2)
		else
			player:AddBoneHearts(-1)
		end
		player:AddSoulHearts(-2)
	end

	--pickup.Price = PickupPrice.PRICE_FREE
	--pickup.AutoUpdatePrice = false

end

local redHearts = {
	[HeartSubType.HEART_BLENDED] = true,
	[HeartSubType.HEART_HALF] = true,
	[HeartSubType.HEART_FULL] = true,
	[HeartSubType.HEART_DOUBLEPACK] = true,
	[HeartSubType.HEART_SCARED] = true
}

local soulHearts = {
	[HeartSubType.HEART_SOUL] = true,
	[HeartSubType.HEART_HALF_SOUL] = true,
	[HeartSubType.HEART_BLENDED] = true,
}

function wakaba:CanPurchasePickup(player, pickup)
	if pickup.Variant == PickupVariant.PICKUP_HEART then
		local isPickableRed = player:CanPickRedHearts() and redHearts[pickup.SubType]
		local isPickableSoul = player:CanPickSoulHearts() and soulHearts[pickup.SubType]
		local isPickableBone = player:CanPickBoneHearts() and pickup.SubType == HeartSubType.HEART_BONE
		local isPickableBlack = player:CanPickBlackHearts() and pickup.SubType == HeartSubType.HEART_BLACK
		local isPickableGolden = player:CanPickGoldenHearts() and pickup.SubType == HeartSubType.HEART_GOLDEN
		if (redHearts[pickup.SubType] or soulHearts[pickup.SubType] or pickup.SubType == HeartSubType.HEART_BONE or pickup.SubType == HeartSubType.HEART_BLACK or pickup.SubType == HeartSubType.HEART_GOLDEN)
		and not (isPickableRed or isPickableSoul or isPickableBone or isPickableBlack or isPickableGolden) then
			return false
		end
	elseif pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY and not player:NeedsCharge() then
		return false
	elseif pickup.Variant == PickupVariant.PICKUP_TRINKET then
		if player:GetMaxTrinkets() == 1 and player:GetTrinket(0) == TrinketType.TRINKET_TICK then
			return false
		end
	end

	return true
end

function wakaba:RemoveOtherOptionPickups(pickup)
	if pickup.OptionsPickupIndex ~= 0 then
		local pickups = Isaac.FindByType(EntityType.ENTITY_PICKUP)
		for _, entity in ipairs(pickups) do
			if entity:ToPickup().OptionsPickupIndex == pickup.OptionsPickupIndex and
				 (entity.Index ~= pickup.Index or entity.InitSeed ~= pickup.InitSeed)
			then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil)
				entity:Remove()
			end
		end
	end
end

function wakaba:isSuperpositionedPlayer(player)
	if player then
		local playertype = player:GetPlayerType()
		if playertype == PlayerType.PLAYER_LAZARUS_B or playertype == PlayerType.PLAYER_LAZARUS2_B then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) or
				 (player:GetOtherTwin() and player:GetOtherTwin():HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT))
			then
				local maintwin = player:GetMainTwin()
				if maintwin.Index ~= player.Index or maintwin.InitSeed ~= player.InitSeed then
					return true
				end
			end
		end
	end
	return false
end

-- GetPersistentPickupData from Retribution
function wakaba:GetPersistentPickupData(pickup)
	if wakaba.runstate and wakaba.runstate.persistentPickupData then
		local tableIndex = tostring(pickup.InitSeed)
		wakaba.runstate.persistentPickupData[tableIndex] = wakaba.runstate.persistentPickupData[tableIndex] or {}
		return wakaba.runstate.persistentPickupData[tableIndex]
	end
end


