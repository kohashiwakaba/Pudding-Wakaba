local jupiterstats = {
	damage = 0,
	speed = 0,
	tears = 0,
	shotspeed = 0,
	luck = 0,
}
local currjupiterstats = wakaba:deepcopy(jupiterstats)

function wakaba:Update_RingofJupiter()
	currjupiterstats = wakaba:deepcopy(jupiterstats)
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasTrinket(wakaba.Enums.Trinkets.RING_OF_JUPITER) then
			--print("Adding Player",i,"stats...")
			currjupiterstats.damage = currjupiterstats.damage + ((player.Damage * 0.16) * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.RING_OF_JUPITER))
			currjupiterstats.speed = currjupiterstats.speed + ((player.MoveSpeed * 0.1) * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.RING_OF_JUPITER))
			currjupiterstats.tears = currjupiterstats.tears + ((30 / (player.MaxFireDelay + 1)) * 0.2 * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.RING_OF_JUPITER))
			currjupiterstats.shotspeed = currjupiterstats.shotspeed + ((player.ShotSpeed * 0.05) * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.RING_OF_JUPITER))
			currjupiterstats.luck = currjupiterstats.luck + (1 * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.RING_OF_JUPITER))
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_RingofJupiter)

function wakaba:Cache_RingofJupiter(player, cacheFlag)
	local jupiter = 0 
	for i = 1, wakaba.G:GetNumPlayers() do
		local p = Isaac.GetPlayer(i - 1)
		if p:HasTrinket(wakaba.Enums.Trinkets.RING_OF_JUPITER) then
			jupiter = jupiter + p:GetTrinketMultiplier(wakaba.Enums.Trinkets.RING_OF_JUPITER)
		end
	end
	if jupiter > 0 then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + ((player.Damage * 0.16) * jupiter)
		end
		if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + ((player.ShotSpeed * 0.05) * jupiter)
		end
		--[[ if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearHeight = player.TearHeight - 1.5
			player.TearFallingSpeed = player.TearFallingSpeed + 1.5
		end ]]
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + ((player.MoveSpeed * 0.1) * jupiter)
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + (1 * jupiter)
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, ((30 / (player.MaxFireDelay + 1)) * 0.2 * jupiter))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_RingofJupiter)

