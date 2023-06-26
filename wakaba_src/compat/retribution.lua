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
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.FLAME_PRINCESS)
		table.insert(mod.EverlastingPills, wakaba.Enums.Pills.FIREY_TOUCH)



		rtReplaced = true
	end
end