
local playerType = wakaba.Enums.Players.RICHER_B
local removed = false
local isRicherContinue = true

--[[ function wakaba:PostRicherUpdate(player)

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PostRicherUpdate) ]]

--[[ function wakaba:RicherTakeDmg(entity, amount, flag, source, countdownFrames)

end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.RicherTakeDmg) ]]


local RicherChar = { 
		DAMAGE = 0.75,
		SPEED = 0.1,
		SHOTSPEED = 1.0,
		TEARRANGE = 40 * 0,
		TEARS = 0.6,
		LUCK = -1,
		FLYING = false,																 
		TEARFLAG = TearFlags.TEAR_NORMAL | TearFlags.TEAR_QUADSPLIT,
		TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)	-- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}
 
function wakaba:onRicherCache_b(player, cacheFlag)
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
			--player.TearColor = RicherChar.TEARCOLOR
		end
	end
	
end
 
wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010720, wakaba.onRicherCache_b)

---@param player EntityPlayer
function wakaba:AfterRicherInit_b(player)
	--print("Richer event passed")
	player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		player:AddCollectible(wakaba.Enums.Collectibles.WATER_FLAME, 6, true, ActiveSlot.SLOT_POCKET)
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



function wakaba:PostRicherInit_b(player)
	if not isRicherContinue then
		wakaba:AfterRicherInit_b(player)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostRicherInit_b)

function wakaba:RicherInit_b(continue)
	if (not continue) then
		isRicherContinue = false
		wakaba:AfterRicherInit_b()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.RicherInit_b)

function wakaba:RicherExit_b()
	isRicherContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.RicherExit_b)
