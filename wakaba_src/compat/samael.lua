
local isc = require("wakaba_src.libs.isaacscript-common")
local Replaced = false
function wakaba:GameStart_SamaelCompat()
	if SamaelMod and not Replaced then
		wakaba:BlacklistUniform("card", SamaelMod.ITEMS.DENIAL_DICE)

		Replaced = true
	end
end
