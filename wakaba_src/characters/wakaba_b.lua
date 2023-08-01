
local playerType = wakaba.Enums.Players.WAKABA_B
local removed = false
local collectibleCount_b
local costumeEquipped_b
local isWakabaContinue = true
local isc = require("wakaba_src.libs.isaacscript-common")
wakaba:registerCharacterHealthConversion(wakaba.Enums.Players.WAKABA_B, isc.HeartSubType.BLACK)

local function InitWakabaPlayer_b()
	collectibleCount_b = 0
	costumeEquipped_b = false
end

--some mods force the players cache update to happen every frame, triggering costume application
--this prevents costume from being applied repeatedly
function wakaba:GetWakabaCostume_b(player)
	if wakaba.costumecurrframe == 0 then
		wakaba.costumecurrframe = wakaba.costumecooldown
		--player:GetSprite():Load("gfx/wakaba.anm2", true)
		player:AddNullCostume(wakaba.COSTUME_WAKABA_B)
	end
end

--[[ if Poglite then
	local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakaba_b_pog.anm2")
	Poglite:AddPogCostume("TaintedWakabaPog",playerType,pogCostume)
end ]]

--Costume currently not working in Knife Piece 2 area. Needs to be fixed.
function wakaba:PostWakabaUpdate_b(player)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PostWakabaUpdate_b)

--[[ function wakaba:PostWakabaRenderUpdate_b(player, offset)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true)
	and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_RAND then
		if player:GetMaxHearts() > 0 then
			local conv = player:GetMaxHearts()
			player:AddMaxHearts(-conv, true)
			player:AddBlackHearts(conv)
		end
		if player:GetBoneHearts() > 0 then
			local conv = player:GetBoneHearts()
			player:AddBoneHearts(-conv, true)
			player:AddBlackHearts(conv * 2)
		end
		if player:GetHearts() > 0 then
			local conv = player:GetHearts()
			player:AddHearts(-conv)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.PostWakabaRenderUpdate_b, 0) ]]

function wakaba:NegateDamage_TaintedWakabaBirthright(player, amount, flags, source, cooldown)
	if player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		if flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION then
			player:SetMinDamageCooldown(1)
			return false
		end
		if flags & DamageFlag.DAMAGE_CRUSH == DamageFlag.DAMAGE_CRUSH then
			player:SetMinDamageCooldown(1)
			return false
		end
	end
end
wakaba:AddCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_TaintedWakabaBirthright)


function wakaba:PostGetCollectible_Wakaba_b(player, item)
	if not player or player:GetPlayerType() ~= wakaba.Enums.Players.WAKABA_B then return end
	player:AddSoulHearts(player:GetSoulHearts() * -1)
	player:AddMaxHearts(2)
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_Wakaba_b, CollectibleType.COLLECTIBLE_DEAD_CAT)

function wakaba:OnWakabaUpdate_b(player)
	-- If the player is Wakaba
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) then

		player:AddNullCostume(wakaba.COSTUME_WAKABA_B)
		costumeEquipped_b = true
	end
end

--wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.OnWakabaUpdate_b)

local WakabaChar_b = {
    DAMAGE = 0.7,
    SPEED = 0.25,
    SHOTSPEED = 1.1,
    TEARRANGE = 20,
		TEARS = 3.0,
    LUCK = -5,
    FLYING = false,                                 
    TEARFLAG = TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_PIERCING,
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)  -- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}
 
function wakaba:onWakabaCache_b(player, cacheFlag)
  if player:GetPlayerType() == playerType
	then
		--wakaba:GetWakabaCostume_b(player)
		if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_RAND then
			if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
					player.TearFlags = player.TearFlags | WakabaChar_b.TEARFLAG
			end
		else
			if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
					player.Damage = player.Damage * WakabaChar_b.DAMAGE
			end
			if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
					player.ShotSpeed = player.ShotSpeed * WakabaChar_b.SHOTSPEED
			end
    	if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
    	    player.TearRange = player.TearRange + WakabaChar_b.TEARRANGE
    	end
			if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
					player.MoveSpeed = player.MoveSpeed + WakabaChar_b.SPEED
			end
			if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
					player.Luck = player.Luck + WakabaChar_b.LUCK
			end
			if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and WakabaChar_b.FLYING then
					player.CanFly = true
			end
			if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
					player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (WakabaChar_b.TEARS * wakaba:getEstimatedTearsMult(player)))
			end
			if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
					player.TearFlags = player.TearFlags | WakabaChar_b.TEARFLAG
			end
			if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
					player.TearColor = WakabaChar_b.TEARCOLOR
			end
		end
  end
end
 
wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010720, wakaba.onWakabaCache_b)


function wakaba:AfterWakabaInit_b(player)
  player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
    local data = player:GetData()
    data.wakaba = data.wakaba or {}
    if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.Enums.Collectibles.EATHEART and wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
			player:SetPocketActiveItem(wakaba.Enums.Collectibles.EATHEART, ActiveSlot.SLOT_POCKET, true)
			player:SetActiveCharge(0, ActiveSlot.SLOT_POCKET)
    end
		if wakaba.state.options.cp_wakaba_b then
			player:EvaluateItems()
      --player:ClearCostumes()
		else
			wakaba:GetWakabaCostume_b(player)
		end
  end
end

function wakaba:PostWakabaInit_b(player)
	if player:GetPlayerType() == playerType then
		wakaba.costumecurrframe = 0
		wakaba:GetWakabaCostume_b(player)
	end
  if not isWakabaContinue then
    wakaba:AfterWakabaInit_b(player)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostWakabaInit_b)

function wakaba:WakabaInit_b(continue)
  if (not continue) then
    isWakabaContinue = false
    wakaba:AfterWakabaInit_b()
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.WakabaInit_b)

function wakaba:WakabaExit_b()
  isWakabaContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.WakabaExit_b)

