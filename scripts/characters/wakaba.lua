
local playerType = Isaac.GetPlayerTypeByName("Wakaba", false)
local removed = false
local isWakabaContinue = true
local collectibleCount
local costumeEquipped 
local broken
local damaged
local function InitWakabaPlayer()
	broken = 9
	collectibleCount = 0 
	costumeEquipped = false 
	damaged = false
end



--some mods force the players cache update to happen every frame, triggering costume application
--this prevents costume from being applied repeatedly
function wakaba:GetWakabaCostume(player)
	--print("wakaba.costumecurrframe ",wakaba.costumecurrframe)
	if wakaba.costumecurrframe == 0 then
		wakaba.costumecurrframe = wakaba.costumecooldown
		--player:GetSprite():Load("gfx/wakaba.anm2", true)
		player:AddNullCostume(wakaba.COSTUME_WAKABA)
	end
end

--[[ if Poglite then
	local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakaba_pog.anm2")
	Poglite:AddPogCostume("WakabaPog",playerType,pogCostume)
end ]]

--Costume currently not working in Knife Piece 2 area. Needs to be fixed.
function wakaba:PostWakabaUpdate()
	local hasconf = false
	local conf = Isaac.FindByType(6, 17, -1, false, false)
	if #conf > 0 then
		hasconf = true
	end
	
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Wakaba", false)
		then
			wakaba:GetPlayerEntityData(player)
			if Game().Challenge ~= wakaba.challenges.CHALLENGE_RAND 
			and not player:GetData().wakaba.shioriangel then
				if hasconf then
					broken = 0
				elseif player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
					broken = 8
				else
					broken = 9
				end
				if player:GetBrokenHearts() ~= broken then
					player:AddBrokenHearts(-(player:GetBrokenHearts()-broken))
				end
			end
			
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostWakabaUpdate)
--LagCheck

function wakaba:WakabaTakeDmg(entity, amount, flag, source, countdownFrames)
	Isaac.DebugString("[wakaba] TookDmg flag:"..flag.."")
	if entity.Type ~= EntityType.ENTITY_PLAYER
	and not (flag & DamageFlag.DAMAGE_IGNORE_ARMOR == DamageFlag.DAMAGE_IGNORE_ARMOR) 
	then
		local player = nil
		if 
			(source ~= nil 
			and source.Entity ~= nil
			and source.Entity.SpawnerEntity ~= nil
			and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER )
		then
			player = source.Entity.SpawnerEntity:ToPlayer()
		elseif
			(source ~= nil
			and source.Type == EntityType.ENTITY_PLAYER)
		then
			player = source.Entity:ToPlayer()
		end
		if player ~= nil then
			if (player:GetPlayerType() == wakaba.PLAYER_WAKABA and player:HasCollectible(CollectibleType.COLLECTIBLE_URANUS))
			or (player:GetPlayerType() ~= wakaba.PLAYER_WAKABA and player:HasCollectible(wakaba.COLLECTIBLE_WAKABAS_NEMESIS))
			or player:GetPlayerType() == wakaba.PLAYER_WAKABA_B
			then
				flag = flag | DamageFlag.DAMAGE_IGNORE_ARMOR
				entity:TakeDamage(amount, flag, source, countdownFrames)
				return false
			end
		end
	elseif entity.Type == EntityType.ENTITY_PLAYER
	-- DAMAGE_RED_HEARTS flag is same as DAMAGE_NO_PENALTIES flag. Only difference is DAMAGE_RED_HEARTS takes red hearts first
	-- Sharp Plug, Blood Oath do NOT have DAMAGE_NO_PENALTIES flag, so must also check DAMAGE_RED_HEARTS flag
	-- Do NOT give DAMAGE_NO_PENALTIES flag, or return false when being damaged with DAMAGE_RED_HEARTS flag, otherwise Sharp Plug, Blood Oath becomes unusable (Both deal half heart damage, but will do nothing)
	-- Crow Heart does NOT have DAMAGE_RED_HEARTS flag. So ignore that trinket
	and flag & DamageFlag.DAMAGE_NO_PENALTIES ~= DamageFlag.DAMAGE_NO_PENALTIES 
	and flag & DamageFlag.DAMAGE_RED_HEARTS ~= DamageFlag.DAMAGE_RED_HEARTS
	and (wakaba.state.hasbless or wakaba.state.hasnemesis or wakaba:hasLunarStone(entity:ToPlayer()))
	then
		flag = flag | DamageFlag.DAMAGE_NO_PENALTIES
		-- flag = flag | DamageFlag.DAMAGE_RED_HEARTS -- red heart damage with devil room chance protection does not need DAMAGE_NO_PENALTIES flag
		entity:TakeDamage(amount, flag, source, countdownFrames)
		--entity:ToPlayer():SetMinDamageCooldown(1)
		return false
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.WakabaTakeDmg)


-- TearFlags.TEAR_ICE is not working due to bugs. Planned in next patch
local WakabaChar = { 
    DAMAGE = 1.1,
    SPEED = 0.1,
    SHOTSPEED = 0.95,
    TEARRANGE = 100,
		TEARS = 0,
    LUCK = 3,
    FLYING = false,                                 
    TEARFLAG = TearFlags.TEAR_HOMING,
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)  -- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}
 
function wakaba:onWakabaCache(player, cacheFlag)
  if player:GetPlayerType() == playerType then
		--wakaba:GetWakabaCostume(player)
		if Game().Challenge == wakaba.challenges.CHALLENGE_RAND then
    	if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
    	    player.TearFlags = player.TearFlags | WakabaChar.TEARFLAG
    	end
		else
			if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage * WakabaChar.DAMAGE
				if player:HasCollectible(CollectibleType.COLLECTIBLE_URANUS) then
					player.Damage = player.Damage * 1.5
				end
    	end
    	if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
    	    player.ShotSpeed = player.ShotSpeed * WakabaChar.SHOTSPEED
    	end
    	if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
    	    player.TearRange = player.TearRange + WakabaChar.TEARRANGE
    	end
    	if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
    	    player.MoveSpeed = player.MoveSpeed + WakabaChar.SPEED
    	end
    	if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
    	    player.Luck = player.Luck + WakabaChar.LUCK
    	end
    	if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and WakabaChar.FLYING then
    	    player.CanFly = true
    	end
    	if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
    	    player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, WakabaChar.TEARS)
					if player:HasCollectible(wakaba.COLLECTIBLE_WAKABAS_BLESSING) then
						if player.MaxFireDelay < 0 then
							player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (player.MaxFireDelay * -0.25))
						else
							player.MaxFireDelay = player.MaxFireDelay * 0.75
						end
					end
    	end
    	if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
    	    player.TearFlags = player.TearFlags | WakabaChar.TEARFLAG
    	end
    	if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
    	    player.TearColor = WakabaChar.TEARCOLOR
    	end
		end
  end
	
end
 
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onWakabaCache)


function wakaba:AfterWakabaInit(player)
	--print("Wakaba event passed")
  player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		--player:UsePill(PillEffect.PILLEFFECT_TEARS_DOWN, 0, UseFlag.USE_NOANIM | UseFlag.USE_NOCOSTUME | UseFlag.USE_NOANNOUNCER) 
		if wakaba.state.options.cp_wakaba_b then
			player:EvaluateItems()
      --player:ClearCostumes()
		else
			InitWakabaPlayer()
			wakaba.costumecurrframe = 0
			wakaba:GetWakabaCostume(player)
		end
	end
	
	if Poglite then
		if wakaba.state.pog ~= nil then
			if wakaba.state.pog then
				-- Wakaba POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakabapog.anm2")
				Poglite:AddPogCostume("WakabaPog",playerType,pogCostume)
			else
				-- Origin POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakabapog.anm2")
				Poglite:AddPogCostume("WakabaPog",playerType,pogCostume)
			end
		end
	end
end



function wakaba:PostWakabaInit(player)
	if player:GetPlayerType() == playerType then
		wakaba:GetWakabaCostume(player)
	end
  if not isWakabaContinue then
    wakaba:AfterWakabaInit(player)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostWakabaInit)

function wakaba:WakabaInit(continue)
  if (not continue) then
    isWakabaContinue = false
    wakaba:AfterWakabaInit()
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.WakabaInit)

function wakaba:WakabaExit()
  isWakabaContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.WakabaExit)

-- Pause Screen Completion Marks API
PauseScreenCompletionMarksAPI:AddModCharacterCallback(wakaba.PLAYER_WAKABA, function()
	local wakabaCompletionTable = {
		["MOMSHEART"] = wakaba.state.unlock.clover,
		["ISAAC"] = wakaba.state.unlock.counter,
		["SATAN"] = wakaba.state.unlock.dcupicecream,
		["BLUEBABY"] = wakaba.state.unlock.pendant,
		["LAMB"] = wakaba.state.unlock.revengefruit,
		["BOSSRUSH"] = wakaba.state.unlock.donationcard,
		["MEGASATAN"] = wakaba.state.unlock.whitejoker,
		["HUSH"] = wakaba.state.unlock.colorjoker,
		["DELIRIUM"] = wakaba.state.unlock.wakabauniform,
		["MOTHER"] = wakaba.state.unlock.confessionalcard,
		["BEAST"] = wakaba.state.unlock.returnpostage,
		["ULTRAGREED"] = wakaba.state.unlock.secretcard,
	}
	return wakabaCompletionTable
end)

