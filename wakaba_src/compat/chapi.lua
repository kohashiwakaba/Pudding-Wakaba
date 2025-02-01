wakaba:RegisterPatch(0, "CustomHealthAPI", function() return (CustomHealthAPI ~= nil) end, function()
	do
		CustomHealthAPI.Library.UnregisterCallbacks("wakaba")
		wakaba:RemoveCallback(ModCallbacks.MC_PRE_PLAYER_ADD_HEARTS, wakaba.PreAddHealth_PinkFork)
	end
	do
		CustomHealthAPI.Library.AddCallback("wakaba", CustomHealthAPI.Enums.Callbacks.PRE_ADD_HEALTH, -20, function(player, key, hp)
			if CustomHealthAPI.Library.GetInfoOfKey(key, "Type") == CustomHealthAPI.Enums.HealthTypes.SOUL then
				if player:HasTrinket(wakaba.Enums.Trinkets.PINK_FORK) and hp >= 2 then
					local count = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.PINK_FORK)
					wakaba:addCustomStat(player, "damage", 0.2 * count)
					player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
					player:EvaluateItems()
					return key, math.max(hp - 1, 1)
				end
			end
		end)
	end
end)