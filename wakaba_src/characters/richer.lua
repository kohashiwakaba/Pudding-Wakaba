
local playerType = wakaba.Enums.Players.RICHER
local removed = false
local isRicherContinue = true

local isc = _wakaba.isc

function wakaba:PostRicherUpdate(player)
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER then
		wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_WAFER, 1, "WAKABA_I_RICHER")
		wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_MOMS_BOX, 1, "WAKABA_I_RICHER")
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
	else
		if wakaba.HiddenItemManager:Has(player, CollectibleType.COLLECTIBLE_WAFER, "WAKABA_I_RICHER") then
			wakaba.HiddenItemManager:RemoveStack(player, CollectibleType.COLLECTIBLE_WAFER, "WAKABA_I_RICHER")
		end
		if wakaba.HiddenItemManager:Has(player, CollectibleType.COLLECTIBLE_MOMS_BOX, "WAKABA_I_RICHER") then
			wakaba.HiddenItemManager:RemoveStack(player, CollectibleType.COLLECTIBLE_MOMS_BOX, "WAKABA_I_RICHER")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PostRicherUpdate)



function wakaba:RoomClear_Richer(rng, pos)
	wakaba:ForAllPlayers(function (player)---@param player EntityPlayer
		if player:GetPlayerType() == wakaba.Enums.Players.RICHER then
			player:GetData().wakaba.richerroomclearcount = (player:GetData().wakaba.richerroomclearcount or 0) + 1
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
			player:EvaluateItems()
		end
	end)
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_Richer)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.RoomClear_Richer)

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
		TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)	-- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}

function wakaba:onRicherCache(player, cacheFlag)
	if player:GetPlayerType() == playerType then
		local richerPower = (player:GetData().wakaba and player:GetData().wakaba.richerroomclearcount) or 0
		local brPower = math.max(player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BIRTHRIGHT), 0) + 1
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			--player.Damage = player.Damage + (richerPower * 0.01 * brPower * wakaba:getEstimatedDamageMult(player))
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
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, ((RicherChar.TEARS --[[ + (richerPower * 0.016 * brPower) ]]) * wakaba:getEstimatedTearsMult(player)))
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | RicherChar.TEARFLAG
		end
		if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
			--player.TearColor = RicherChar.TEARCOLOR
		end
	end

end

wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010720, wakaba.onRicherCache)


function wakaba:AfterRicherInit(player)
	--print("Richer event passed")
	player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_RNPR then
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_MELT then

		else
			player:SetPocketActiveItem(wakaba.Enums.Collectibles.SWEETS_CATALOG, ActiveSlot.SLOT_POCKET, true)
		end
		if wakaba.state.options.cp_wakaba then
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
