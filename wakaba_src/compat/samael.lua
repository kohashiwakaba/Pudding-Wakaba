
local isc = require("wakaba_src.libs.isaacscript-common")

wakaba:RegisterPatch(0, "SamaelMod", function() return (SamaelMod ~= nil) end, function()
	do
		wakaba:BlacklistUniform("card", SamaelMod.ITEMS.DENIAL_DICE)

		wakaba:AddCallback(wakaba.Callback.WAKABA_COLLECTIBLE_REROLL, function(_, rerollProps, selected, selectedItemConf, itemPoolType, decrease, seed, isCustom)
			if isCustom and (selected >= Isaac.GetItemIdByName("Malakh Mot") and selected <= Isaac.GetItemIdByName("Tainted Samael Tractor Beam")) then
				if SamaelMod.ContentManager:ItemLockedOrDisabled(selected) then
					return true
				end
			end
		end)
	end
end)
