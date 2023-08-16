--[[ 
	Eternity Cookie (이터니티 쿠키) - 장신구
	소멸형 픽업의 소멸 방지
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

local maxMult = 0
function wakaba:PostUpdate_EternityCookie()
	maxMult = 0
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		maxMult = math.max(maxMult, player:GetTrinketMultiplier(wakaba.Enums.Trinkets.ETERNITY_COOKIE))
	end)
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostUpdate_EternityCookie)

---@param pickup EntityPickup
function wakaba:PickupUpdate_EternityCookie(pickup)
	if maxMult == 0 then return end
	if pickup.Timeout > 0 then
		pickup.Timeout = -1
	end
	if maxMult > 1 and not (pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE and isc:inDeathCertificateArea()) then
		pickup.OptionsPickupIndex = 0
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_EternityCookie)