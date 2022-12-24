function wakaba:Cache_GameCD(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD) then
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + (0.16 * player:GetCollectibleNum(wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD))
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			--player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (30 / (player.MaxFireDelay + 1)) * 0.4)
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 0.7 * player:GetCollectibleNum(wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD))
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (34 * player:GetCollectibleNum(wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD))
		end
		if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + (0.1 * player:GetCollectibleNum(wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD))
		end
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (0.5 * player:GetCollectibleNum(wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD))
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_GameCD)

function wakaba:LewdRoomEffect()
	local hasCd = false
  for i = 1, wakaba.G:GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		if pl:HasCollectible(wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD) then
			hasCd = true
		end
	end
	if hasCd then
		local rr = (math.random(0,math.random(0,10)) * 0.01)
		local gg = (math.random(0,math.random(0,10)) * 0.01)
		local bb = (math.random(0,math.random(0,10)) * 0.01)
		local col = Color(1,1,1,1,rr,gg,bb)
		wakaba.G:GetRoom():SetFloorColor(col)
		wakaba.G:GetRoom():SetWallColor(col)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.LewdRoomEffect)










