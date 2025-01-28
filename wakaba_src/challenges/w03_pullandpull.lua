
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_PULL

function wakaba:Challenge_PlayerUpdate_PullAndPull(player)
	if wakaba.G.Challenge ~= c then return end
	if player:GetNumBombs() < 1 then
		player:AddBombs(1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_PullAndPull)

function wakaba:Challenge_Cache_PullAndPull(player, cacheFlag)
	if wakaba.G.Challenge == c then
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.FireDelay = 50000
			player.MaxFireDelay = 50000
		end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = 0.0001
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Challenge_Cache_PullAndPull)