
local isc = require("wakaba_src.libs.isaacscript-common")
local Replaced = false
function wakaba:GameStart_SamaelCompat()
	if SamaelMod and not Replaced then
		wakaba:BlacklistUniform("card", SamaelMod.ITEMS.DENIAL_DICE)

		wakaba:AddCallback(wakaba.Callback.WAKABA_COLLECTIBLE_REROLL, function(_, rerollProps, selected, selectedItemConf, itemPoolType, decrease, seed, isCustom)
			if isCustom and (selected >= Isaac.GetItemIdByName("Malakh Mot") and selected <= Isaac.GetItemIdByName("Tainted Samael Tractor Beam")) then
				if SamaelMod.ContentManager:ItemLockedOrDisabled(selected) then
					return true
				end
			end
		end)

		Replaced = true
	end
end
