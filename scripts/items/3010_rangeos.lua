wakaba.TRINKET_RANGE_OS = Isaac.GetTrinketIdByName("Range OS")

function wakaba:Cache_RangeOS(player, cacheFlag)
	if player:HasTrinket(wakaba.TRINKET_RANGE_OS) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			for i = 1, player:GetTrinketMultiplier(wakaba.TRINKET_RANGE_OS) do
				player.Damage = player.Damage * 2.25
			end
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			for i = 1, player:GetTrinketMultiplier(wakaba.TRINKET_RANGE_OS) do
				player.TearRange = player.TearRange * 0.55
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_RangeOS)