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
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.PRIEST_BLESSING)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.UNHOLY_CURSE)

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