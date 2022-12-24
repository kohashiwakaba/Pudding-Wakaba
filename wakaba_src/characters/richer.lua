
local playerType = wakaba.Enums.Players.RICHER
local removed = false
local isRicherContinue = true

--[[ function wakaba:PostRicherUpdate(player)

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PostRicherUpdate) ]]

--[[ function wakaba:RicherTakeDmg(entity, amount, flag, source, countdownFrames)

end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.RicherTakeDmg) ]]


-- TearFlags.TEAR_ICE is not working due to bugs. Planned in next patch
local RicherChar = { 
    DAMAGE = 1.0,
    SPEED = 0.1,
    SHOTSPEED = 1.0,
    TEARRANGE = 100,
		TEARS = 0,
    LUCK = 1,
    FLYING = false,                                 
    TEARFLAG = TearFlags.TEAR_NORMAL,
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)  -- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}
 
function wakaba:onRicherCache(player, cacheFlag)
  if player:GetPlayerType() == playerType then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
      player.Damage = player.Damage * RicherChar.DAMAGE
  	end
  	if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
  	  player.ShotSpeed = player.ShotSpeed * RicherChar.SHOTSPEED
  	end
  	if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
  	  player.TearRange = player.TearRange + RicherChar.TEARRANGE
  	end
  	if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
  	  player.MoveSpeed = player.MoveSpeed + RicherChar.SPEED
  	end
  	if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
  	  player.Luck = player.Luck + RicherChar.LUCK
  	end
  	if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and RicherChar.FLYING then
  	  player.CanFly = true
  	end
  	if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
  	  player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, RicherChar.TEARS)
  	end
  	if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
  	  player.TearFlags = player.TearFlags | RicherChar.TEARFLAG
  	end
  	if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
  	  player.TearColor = RicherChar.TEARCOLOR
  	end
	end
	
end
 
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onRicherCache)


function wakaba:AfterRicherInit(player)
	--print("Richer event passed")
  player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		player:AddCollectible(wakaba.Enums.Collectibles.SWEETS_CATALOG, 6, true, ActiveSlot.SLOT_PRIMARY)
		if wakaba.state.options.cp_wakaba_b then
			player:EvaluateItems()
      --player:ClearCostumes()
		else
			wakaba.costumecurrframe = 0
			wakaba:GetRicherCostume(player)
		end
	end
	
	--[[ if Poglite then
		if wakaba.state.pog ~= nil then
			if wakaba.state.pog then
				-- Richer POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakabapog.anm2")
				Poglite:AddPogCostume("RicherPog",playerType,pogCostume)
			else
				-- Origin POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakabapog.anm2")
				Poglite:AddPogCostume("RicherPog",playerType,pogCostume)
			end
		end
	end ]]
end



function wakaba:PostRicherInit(player)
  if not isRicherContinue then
    wakaba:AfterRicherInit(player)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostRicherInit)

function wakaba:RicherInit(continue)
  if (not continue) then
    isRicherContinue = false
    wakaba:AfterRicherInit()
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.RicherInit)

function wakaba:RicherExit()
  isRicherContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.RicherExit)

-- Pause Screen Completion Marks API
--[[ PauseScreenCompletionMarksAPI:AddModCharacterCallback(wakaba.Enums.Players.WAKABA, function()
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
end) ]]

