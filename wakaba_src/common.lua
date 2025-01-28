local isc = _wakaba.isc

local voidentered = false

local game = Game()

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

function wakaba:getEstimatedTearsMult(player, negativeOnly, positiveOnly)
	local mult = 1
	local effects = player:GetEffects()
	if player:GetPlayerType() == wakaba.Enums.Players.RIRA then
		positiveOnly = true
	end

	-- [Missing] Star of Bethlehem / Hallowed Ground x2.5

	if player:HasWeaponType(WeaponType.WEAPON_BOMBS) then
		if player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
			mult = mult / 4.3
		else
			mult = mult * 0.4
		end
	elseif player:GetPlayerType() == PlayerType.PLAYER_AZAZEL or player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B and not player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then
		mult = mult * 0.267
	elseif player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) then
		mult = mult / 3
	elseif player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
		mult = mult / 4.3
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) then
		mult = (mult * 2) / 3
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_EVES_MASCARA) then
		mult = (mult * 2) / 3
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
		mult = mult / 3
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_20_20) then
		mult = mult
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE) or effects:HasCollectibleEffect(NullItemID.ID_REVERSE_HANGED_MAN) then
		mult = mult * 0.51
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS) or player:HasCollectible(CollectibleType.COLLECTIBLE_MUTANT_SPIDER) then
		mult = mult * 0.42
	end
	if positiveOnly then
		mult = math.max(mult, 1)
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_ALMOND_MILK) then
		mult = mult * 4
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_SOY_MILK) then
		mult = mult * 5.5
	end

	if effects:HasCollectibleEffect(NullItemID.ID_REVERSE_CHARIOT) or effects:HasCollectibleEffect(NullItemID.ID_REVERSE_CHARIOT_ALT) then
		mult = mult * 4
	end

	return mult
end

-- getEstimatedDamageMult from Retribution
function wakaba:getEstimatedDamageMult(player, negativeOnly, level)
	local mult = 1
	local effects = player:GetEffects()
	level = level or 0


	-- Modded items normally returns here

	if level > 10 then return mult end

	-- [Missing] L10 D8 xRand

	-- [Missing] L10 Succubus x1.5

	-- [Missing] L10 Star of Bethlehem x1.5

	-- [Missing] L10 Dead Eye

	if level > 9 then return mult end

	-- L9 20/20 x0.8
	if player:HasCollectible(CollectibleType.COLLECTIBLE_20_20) and not (
		player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_MUTANT_SPIDER)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_C_SECTION)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS)
	) then
		mult = mult * 0.8
	end

	-- L9 Almond x0.3 or Soy x0.2
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ALMOND_MILK) then
		mult = mult * 0.3
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_SOY_MILK) then
		mult = mult * 0.2
	end

	-- L9 Eve's Mascara
	if not negativeOnly and player:HasCollectible(CollectibleType.COLLECTIBLE_EVES_MASCARA) then
		mult = mult * 2
	end

	-- L9 Magic Mushroom or Cricket's Head or Martyt+Belial x1.5
	if not negativeOnly and (
			player:HasCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM) or
			player:HasCollectible(CollectibleType.COLLECTIBLE_CRICKETS_HEAD) or (
				player:HasCollectible(CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR) and
				effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL)
	)) then -- This multiplier is fucking stupid garbage and I hate it
		mult = mult * 1.5
	end

	if level > 8 then return mult end

	-- L8 Haemolacria or Brim+Tech x1.5
	if not negativeOnly and
		(player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) or
		(player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY)))
	then
		mult = mult * 1.5
	end

	-- L8 Azazel + Ludovico x0.5
	if (player:GetPlayerType() == PlayerType.PLAYER_AZAZEL or player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B)
	and player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) then
		mult = mult * 0.5
	end

	if level > 7 then return mult end

	-- [Missing] L7 Star of Bethlehem or Hallowed Ground or Immaculate Heart x1.2
	if not negativeOnly and player:HasCollectible(CollectibleType.COLLECTIBLE_IMMACULATE_HEART) then
		mult = mult * 1.2
	end

	if level > 6 then return mult end

	-- L6 Judas BR Damocles
	if player:GetPlayerType() == PlayerType.PLAYER_JUDAS
	and player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL_PASSIVE)
	and player:HasCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE) then
		mult = mult * 1.4
	end

	-- L6 Crown of Light x2
	if not negativeOnly and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) then
		mult = mult * 2
	end

	if level > 5 then return mult end

	-- L5 2+ Brimstones x1.2
	if not negativeOnly and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BRIMSTONE) >= 2
	then
		mult = mult * 1.2
	end

	-- L5 Sacred Heart x2.3
	if not negativeOnly and player:HasCollectible(CollectibleType.COLLECTIBLE_SACRED_HEART) then
		mult = mult * 2.3
	end

	if level > 4 then return mult end

	-- L4 Mega Mush x4
	if not negativeOnly and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) then
		mult = mult * 4
	end

	if level > 3 then return mult end

	-- L3 Polyphemus x2
	if not negativeOnly and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS)
	and not (
		player:HasCollectible(CollectibleType.COLLECTIBLE_20_20)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_MUTANT_SPIDER)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_C_SECTION)
	) then
		mult = mult * 2
	end

	if level > 2 then return mult end

	-- [Missing] L2 Character Multiplier
	if player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS then
		mult = mult * 2
	elseif player:GetPlayerType() == PlayerType.PLAYER_THELOST_B then
		mult = mult * 1.3
	elseif player:GetPlayerType() == PlayerType.PLAYER_AZAZEL
	or player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B
	or player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN
	or player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B
	or player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B then
		mult = mult * 1.5
	elseif player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2 then
		mult = mult * 1.4
	elseif player:GetPlayerType() == PlayerType.PLAYER_JUDAS then
		mult = mult * 1.35
	elseif player:GetPlayerType() == PlayerType.PLAYER_CAIN
	or player:GetPlayerType() == PlayerType.PLAYER_CAIN_B
	or player:GetPlayerType() == PlayerType.PLAYER_KEEPER
	or player:GetPlayerType() == PlayerType.PLAYER_EVE_B then
		mult = mult * 1.2
	elseif player:GetPlayerType() == PlayerType.PLAYER_BLUEBABY then
		mult = mult * 1.05
	elseif player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B
	or player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS and not effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then
		mult = mult * 0.75
	end

	if level > 1 then return mult end

	-- L1 Odd Mushroom x0.9
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ODD_MUSHROOM_RATE) then
		mult = mult * 0.9
	end
	-- [Missing] L1 Cracked Crown: I'm honestly not even sure how its stat boosts work

	return mult
end

---@param player EntityPlayer
---@param isSet boolean
function wakaba:setBlindfold(player, isSet)
	isc:setBlindfold(player, isSet)
--[[
	if REPENTOGON then
		player:SetCanShoot(not isSet)
		player:UpdateCanShoot()
	else
		isc:setBlindfold(player, isSet)
	end
	 ]]
end

---결과 아이템 받침대 소환
---@param id CollectibleType 아이템 번호, 0 : 빈 받침대
---@param position Vector
---@param shouldDuplicate boolean 다모, 글크 등의 영향을 받아도 되는지 결정
function wakaba:SpawnResultPedestal(id, position, shouldDuplicate)
	id = id or 0
	shouldDuplicate = shouldDuplicate or false
	position = position or Game():GetRoom():GetCenterPos()
	local pickup = Isaac.Spawn(5, PickupVariant.PICKUP_BROKEN_SHOVEL, 0, position, Vector.Zero, nil):ToPickup()
	pickup:Morph(5, 100, (id == 0 and CollectibleType.COLLECTIBLE_BROKEN_SHOVEL_1 or id), true, true, (id == 0 or not shouldDuplicate))
	pickup:GetData().DamoclesDuplicate = not shouldDuplicate -- 에피파니, 와카바 모드는 다모 복제 방지 시 필요
	if id == 0 then
		if REPENTOGON then
			pickup:TryRemoveCollectible()
		else
			pickup.SubType = 0
			pickup:GetSprite():ReplaceSpritesheet(1, "gfx/none.png")
			pickup:GetSprite():ReplaceSpritesheet(4, "gfx/none.png")
			pickup:GetSprite():LoadGraphics()
		end
	end
	return pickup
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

---@class WakabaPedestalData
---@field CollectibleType CollectibleType
---@field Pedestal EntityPickup
---@field Pool ItemPoolType
---@field Tags ItemConfig
---@field Quality integer
---@field Config ItemConfigItem

---@param includeShop boolean
---@return WakabaPedestalData[]
function wakaba:GetPedestals(includeShop)
	local pool = pool or wakaba.G:GetItemPool()
	local config = config or Isaac.GetItemConfig()
	local Pedestals = {}
	includeShop = includeShop or true

	local items = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
	if (#items == 0) then return {} end
	for _, it in ipairs(items) do
		if it:Exists() then
			local item = it:ToPickup()
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
	end

	return Pedestals
end

--[[
	Helper functions from Cadaver Mod
]]

function wakaba:RandomVelocity()
	return Vector((math.random() - 0.5) * 2, (math.random() - 0.5) * 2)
end

---@param rng RNG|integer
---@param multiplier integer
---@param entity Entity?
---@return Vector
function wakaba:RandomCenteredVelocity(rng, multiplier, entity)
	multiplier = multiplier or 1
	if rng and type(rng) == "number" then
		local seed = rng + 0
		rng = RNG()
		rng:SetSeed(seed, 35)
	elseif not rng and (entity and entity:Exists()) then
		rng = RNG()
		rng:SetSeed(entity.InitSeed, 35)
	elseif not rng then
		return wakaba:RandomVelocity()
	end

	local randX = (rng:RandomFloat() - 0.5) * multiplier
	local randY = (rng:RandomFloat() - 0.5) * multiplier

	return Vector(randX * 2, randY * 2)
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
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.detectD4)

function wakaba:PostTakeDamage_TEden(player, amount, flag, source, countdownFrames)
	if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
		wakaba.fullreroll = true
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_TEden)

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
			-- RoomShape Check is for Larger Mother Boss room Mod
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
			local rkey = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_POOP, 0, voidfinals, Vector(0,0), nil):ToPickup()
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
			local p1 = wakaba:SpawnResultPedestal(CollectibleType.COLLECTIBLE_KEY_PIECE_1, room:GetGridPosition(92))
			local p2 = wakaba:SpawnResultPedestal(CollectibleType.COLLECTIBLE_KEY_PIECE_2, room:GetGridPosition(102))
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
			local p1 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_POOP, 0, room:GetGridPosition(92), Vector(0,0), nil):ToPickup()
			local p2 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_POOP, 0, room:GetGridPosition(102), Vector(0,0), nil):ToPickup()
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
				local p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_POOP, 0, wakaba:GetGridCenter(), Vector(0,0), nil):ToPickup()
				p:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, pill, false, false, true)
			else
				local p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_POOP, 0, wakaba:GetGridCenter(), Vector(0,0), nil):ToPickup()
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
				local p = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_POOP, 0, room:GetGridPosition(72), Vector(0,0), nil):ToPickup()
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

function wakaba:findRandomEnemy(rootEntity, rng, ignoreFriendly)
	if rng == nil then
		rng = RNG()
		rng:SetSeed(wakaba.G:GetSeeds():GetStartSeed(), 35)
	end
	local position = Vector(0, 0)
	if rootEntity then
		position = rootEntity.Position
	end
	local entities = Isaac.FindInRadius(position,2000,partition)
	local entries = {}
	local target = nil
	for index, entity in ipairs(entities) do
		if entity.Type ~= EntityType.ENTITY_FIREPLACE
		and entity:IsEnemy()
		and not entity:IsInvincible()
		and not entity:HasEntityFlags(EntityFlag.FLAG_ICE_FROZEN)
		and not entity:HasEntityFlags(EntityFlag.FLAG_NO_TARGET)
		and not (ignoreFriendly and entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY))
		then
			if entity.EntityCollisionClass > 0 and not badent and entity.Type ~= 4 then
				table.insert(entries, entity)
			end
		end
	end

	if #entries > 0 then
		target = entries[rng:RandomInt(#entries) + 1]
	end
	return target
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

-- getPlayerFromTear from fiend folio
function wakaba:getPlayerFromTear(tear)
	for i=1, 3 do
		local check = nil
		if i == 1 then
			check = tear.Parent
		elseif i == 2 then
			check = tear.SpawnerEntity
		elseif i == 3 then
			local spawnData = tear:GetData().wakaba and tear:GetData().wakaba.SpawnData
			if spawnData then
				check = spawnData.SpawnerEntity
			end
		end
		if check ~= nil and check:Exists() then
			if check.Type == EntityType.ENTITY_PLAYER and check:ToPlayer() then
				return wakaba:GetPtrHashEntity(check):ToPlayer()
			elseif check.Type == EntityType.ENTITY_FAMILIAR and check.Variant == FamiliarVariant.INCUBUS and check:ToFamiliar() then
				familiar = check:ToFamiliar()
				local player = familiar.Player
				if player ~= nil and player:Exists() and player.Type == EntityType.ENTITY_PLAYER and player:ToPlayer() then
					return wakaba:GetPtrHashEntity(player):ToPlayer()
				end
			end
		end

	end
	return nil
end

wakaba:AddPriorityCallback(ModCallbacks.MC_POST_TEAR_INIT, CallbackPriority.IMPORTANT, function(_, tear)
	local data = tear:GetData()
	tear:GetData().wakaba = tear:GetData().wakaba or {}
	data.wakaba.SpawnData = tear:GetData()
end)

function wakaba:getPlayerFromKnife(knife)
	if knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer() then
		return knife.SpawnerEntity:ToPlayer()
	elseif knife.SpawnerEntity and knife.SpawnerEntity:ToFamiliar() and knife.SpawnerEntity:ToFamiliar().Player then
		local familiar = knife.SpawnerEntity:ToFamiliar()

		if familiar.Variant == FamiliarVariant.INCUBUS or familiar.Variant == FamiliarVariant.SPRINKLER or
				familiar.Variant == FamiliarVariant.TWISTED_BABY or familiar.Variant == FamiliarVariant.BLOOD_BABY or
				familiar.Variant == FamiliarVariant.UMBILICAL_BABY or familiar.Variant == FamiliarVariant.CAINS_OTHER_EYE then
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
	EntityType.ENTITY_LARRYJR,
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

function wakaba:DisplayHUDItemText(player, tableName, id)
	if Options.Language ~= "en" and id then
		tableName = tableName or "collectibles"
		lang = EID.LanguageMap[Options.Language] or "en_us"
		local entrytables = wakaba.descriptions[lang] or wakaba.descriptions["en_us"]
		if entrytables and entrytables[tableName] then
			local config = Isaac.GetItemConfig()
			local iConf = config:GetCollectible(id)
			local fallbackEntry = wakaba.descriptions["en_us"][tableName][id]
			local entry = entrytables[tableName][id] or fallbackEntry
			local name = (entry and entry.itemName) or (fallbackEntry and fallbackEntry.itemName) or iConf.Name
			local queueDesc = (entry and entry.queueDesc) or (fallbackEntry and fallbackEntry.itemName) or iConf.Description
			if entry then
				wakaba.G:GetHUD():ShowItemText(name, queueDesc)
			else
				wakaba.G:GetHUD():ShowItemText(player, Isaac.GetItemConfig():GetCollectible(id))
			end
		end
	end
end

---gets a target used by Marked, or Eye of Occult for certain synergies
---@param player EntityPlayer
---@function
function wakaba:GetMarkedTarget(player)
	local occults = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.OCCULT_TARGET)
	for _, target in ipairs(occults) do
		if target.SpawnerEntity and GetPtrHash(player) == GetPtrHash(target.SpawnerEntity) then
			return target
		end
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) then
		local marks = Isaac.FindByType(EntityType.ENTITY_EFFECT, 30)
		for _, target in ipairs(marks) do
			if target.SpawnerEntity and GetPtrHash(player) == GetPtrHash(target.SpawnerEntity) then
				return target
			end
		end
	end

end

---@param itemID CollectibleType
---@function
function wakaba:isActiveItem(itemID)
	local itemConfig = Isaac.GetItemConfig():GetCollectible(itemID)
	if not itemConfig then return false end
	return itemConfig:IsCollectible() and itemConfig.Type == ItemType.ITEM_ACTIVE
end

---From Epiphany, get random entry from table
---@param list table
---@param rng RNG
---@param number integer
---@function
function wakaba:getRandomEntry(list, rng, number)
	if number > #list then
		return list
	end
	local newList = {}
	if not rng then
		rng = RNG()
		rng:SetSeed(Random(), 42)
	end
	for _ = 1, number do
		local Index = RNG:RandomInt(#list) + 1
		table.insert(newList, list[Index])
		table.remove(list, Index)
		table.sort(list)
	end

	return newList
end

---comment
---@param collectiblesOnly boolean
---@function
function wakaba:getSelectionPickups(collectiblesOnly)
	local roomEntities = wakaba:GetRoomEntities()
	local selections = {}
	for _, e in ipairs(roomEntities) do
		if e:ToPickup() and e:ToPickup().OptionsPickupIndex ~= 0 then
			if not (collectiblesOnly and e.Variant ~= PickupVariant.PICKUP_COLLECTIBLE) then
				table.insert(selections, e:ToPickup())
			end
		end
	end
	return selections
end

---Getting pickup index from InitSeed
---Normally, InitSeed isn't enough to determine pickup index
---But only use this for now to prevent extreme lags in such as Death Certificate area.
---
--- TODO : Change this to wakaba:getExtendedPickupIndex(pickup) if better optimization method is found.
---@param pickup EntityPickup
---@function
function wakaba:getPickupIndex(pickup)
	return tostring(pickup.InitSeed)
end
--[[
function wakaba:getExtendedPickupIndex(pickup)
	return tostring(pickup.InitSeed)
end
 ]]

-- Getting options value from Pudding & Wakaba mod
function wakaba:getOptionValue(optionKey)
	if optionKey and type(optionKey) == "string" then
		return wakaba.state.options[optionKey]
	end
end

function wakaba:getTeardropCharmBonus(player)
	local power = player:GetTrinketMultiplier(TrinketType.TRINKET_TEARDROP_CHARM)
	if power > 0 then
		return 2 + (2 * power)
	end
	return 0
end

function wakaba:getCurrentCollectibles(player, includeActive, includeCount)
	if not player or player:IsCoopGhost() then return {} end
	local list = {}
	local id = 1
	while (id < CollectibleType.NUM_COLLECTIBLES or Isaac.GetItemConfig():GetCollectible(id)) do
		local count = player:GetCollectibleNum(id, true)
		if count > 0 then
			if includeCount then
				table.insert(list, id)
			else
				list[id] = count
			end
		end
		id = id + 1
	end
	return list
end


-- Get the median of a table.
function wakaba:getMedian(t)
	local temp={}

	-- deep copy table so that when we sort it, the original is unchanged
	-- also weed out any non numbers
	for k,v in pairs(t) do
		if type(v) == 'number' then
			table.insert( temp, v )
		end
	end

	table.sort( temp )

	-- If we have an even number of table elements or odd.
	if math.fmod(#temp,2) == 0 then
		-- return mean value of middle two elements
		return ( temp[#temp/2] + temp[(#temp/2)+1] ) / 2
	else
		-- return middle element
		return temp[math.ceil(#temp/2)]
	end
end

function wakaba:getMean( t )
	local sum = 0
	local count= 0

	for k,v in pairs(t) do
		if type(v) == 'number' then
			sum = sum + v
			count = count + 1
		end
	end

	return (sum / count)
end

---Check whether item is procedural or not
---@param player EntityPlayer
---@param usedItem CollectibleType
---@param slot ActiveSlot
function wakaba:IsActiveFromProceduralItem(player, usedItem, slot)
	slot = slot or ActiveSlot.SLOT_PRIMARY
	if slot == -1 then -- Item not used directly
		return false, false, true
	end

	local currentItem = player:GetActiveSlot(slot)
	if currentItem < 0 then -- Item is used by Procedural item
		return true, false, false
	elseif currentItem == CollectibleType.COLLECTIBLE_VOID then -- Item is used by Void
		return false, true, false
	elseif currentItem ~= usedItem then -- Item not used directly
		return false, false, true
	end
end

function wakaba:IsLunatic()
	return wakaba.state.bossdestlunatic or wakaba.state.options.forceLunatic -- TODO move to lunatic.lua
end

function wakaba:RoomShouldCheckAscent()
	local room = wakaba.G:GetRoom()
	if room:GetType() == RoomType.ROOM_BOSS or room:GetType() == RoomType.ROOM_TREASURE then
		return true
	end
	return false
end

function wakaba:SpawnPurgatoryGhost(player, rng, wait)
	local soul = Isaac.Spawn(1000, EffectVariant.PURGATORY, 1, player.Position, Vector.Zero, player):ToEffect()
	soul:GetData().wakaba = {}
	soul.Parent = player
	soul:GetData().wakaba.isFallenGhost = true
	if not wait then
		for i = 1, 39 do
			soul:Update()
		end
	end
	soul.Target = wakaba:findRandomEnemy(player, rng, true)

	return soul
end
function wakaba:isTLaz(player)
	local playerType = player:GetPlayerType()
	return playerType == PlayerType.PLAYER_LAZARUS_B or playerType == PlayerType.PLAYER_LAZARUS2_B
end

function wakaba:getFlippedForm(player)
	if REPENTOGON then
		return player:GetFlippedForm()
	elseif wakaba:isTLaz(player) then
		return wakaba:getTaintedLazarusSubPlayer(player)
	end
	return false
end