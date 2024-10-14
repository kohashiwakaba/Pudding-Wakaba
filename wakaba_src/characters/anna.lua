--[[
	Anna(안나)

	고유 능력 : 카오스, 증폭의 책
	- 증폭의 책 효과 및 색상 변경, 색상은 아이템 획득 시에만 변경되며 색상에 따라 해당 퀄리티의 아이템만 등장
	생득권 : 0등급 미등장, 소지 아이템 개수당 이동속도 증가
 ]]

local playerType = wakaba.Enums.Players.ANNA
local isAnnaContinue = true

function wakaba:PostAnnaUpdate(player)
	if player:GetPlayerType() == wakaba.Enums.Players.ANNA then
		wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_CHAOS, 1, "WAKABA_I_ANNA")
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
	else
		if wakaba.HiddenItemManager:Has(player, CollectibleType.COLLECTIBLE_CHAOS, "WAKABA_I_ANNA") then
			wakaba.HiddenItemManager:RemoveStack(player, CollectibleType.COLLECTIBLE_CHAOS, "WAKABA_I_ANNA")
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PostAnnaUpdate)

local AnnaChar = {
		DAMAGE = 1.1,
		SPEED = -0.2,
		SHOTSPEED = 0.7,
		TEARRANGE = 0,
		TEARS = 0,
		LUCK = 0,
		FLYING = false,
		TEARFLAG = TearFlags.TEAR_NORMAL,
		TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)	-- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}

function wakaba:onAnnaCache(player, cacheFlag)
	if player:GetPlayerType() == playerType then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * AnnaChar.DAMAGE
		end
		if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed * AnnaChar.SHOTSPEED
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + AnnaChar.TEARRANGE
		end
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + AnnaChar.SPEED
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + AnnaChar.LUCK
		end
		if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and AnnaChar.FLYING then
			player.CanFly = true
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (AnnaChar.TEARS * wakaba:getEstimatedTearsMult(player)))
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | AnnaChar.TEARFLAG
		end
		if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
			--player.TearColor = AnnaChar.TEARCOLOR
		end
	end

end

wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010720, wakaba.onAnnaCache)

function wakaba:AfterAnnaInit(player)
	player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE, ActiveSlot.SLOT_POCKET, true)
	end
end

function wakaba:PostAnnaInit(player)
	if not isAnnaContinue then
		wakaba:AfterAnnaInit(player)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostAnnaInit)

function wakaba:AnnaInit(continue)
	if (not continue) then
		isAnnaContinue = false
		wakaba:AfterAnnaInit()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.AnnaInit)

function wakaba:AnnaExit()
	isAnnaContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.AnnaExit)
