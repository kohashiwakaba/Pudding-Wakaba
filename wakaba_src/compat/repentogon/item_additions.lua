
--- Wakaba's Double Dreams : 액티브 아이템 칸을 소환 카운터로 설정.
wakaba:AddPriorityCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MIN_USABLE_CHARGE, -20000, function(_)
	return 0
end, wakaba.Enums.Collectibles.DOUBLE_DREAMS)

wakaba:AddPriorityCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MAX_CHARGE, -20000, function(_, _, player, varData)
	return 10000
end, wakaba.Enums.Collectibles.DOUBLE_DREAMS)