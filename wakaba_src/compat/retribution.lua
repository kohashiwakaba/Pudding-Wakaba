local rtReplaced = false
function wakaba:GameStart_RetributionCompat()
	if Retribution and not rtReplaced then
		local mod = Retribution

		-- Ret - Everlasting Pills
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.TROLLED)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.TO_THE_START)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.SOCIAL_DISTANCE)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.DUALITY_ORDERS)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.PRIEST_BLESSING)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.UNHOLY_CURSE)

		-- Ret - Neverlasting Pills
		table.insert(mod.NeverlastingPills, wakaba.Enums.Pills.ALL_STATS_DOWN)
		table.insert(mod.NeverlastingPills, wakaba.Enums.Pills.ALL_STATS_UP)
		table.insert(mod.NeverlastingPills, wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN)
		table.insert(mod.NeverlastingPills, wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP)

		-- PHD map
			wakaba:DictionaryBulkAppend(mod.PhdEffectMap, {
				[wakaba.Enums.Pills.TROLLED] = wakaba.Enums.Pills.TO_THE_START,
				[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT,
				[wakaba.Enums.Pills.SOCIAL_DISTANCE] = wakaba.Enums.Pills.DUALITY_ORDERS,
				[wakaba.Enums.Pills.UNHOLY_CURSE] = wakaba.Enums.Pills.PRIEST_BLESSING,
				[wakaba.Enums.Pills.ALL_STATS_DOWN] = wakaba.Enums.Pills.ALL_STATS_UP,
				[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP,
			})

		wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, -20000, function(_)
			if mod.savedata.icarusCurseIndicator % 2 == 0 then
				local player = Isaac.GetPlayer()
				if player:GetPlayerType() == mod.PLAYER_TYPE.ICARUS then
					return {Skip = true}
				end
			end
		end)

		wakaba:BulkAppend(wakaba.Blacklists.AquaTrinkets, mod.CursedTrinketPool)

		rtReplaced = true
	end
end