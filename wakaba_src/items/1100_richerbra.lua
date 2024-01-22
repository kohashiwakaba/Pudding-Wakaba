--[[
	Richer's Bra (리셰의 속옷) - 패시브(Passive)
	- 모든 피격에 대한 패널티 방어
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:AlterPlayerDamage_RicherBra(player, amount, flags, source, countdown)
	if player:HasCollectible(wakaba.Enums.Collectibles.RICHERS_BRA) then
		return amount, flags | DamageFlag.DAMAGE_NO_PENALTIES
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, wakaba.AlterPlayerDamage_RicherBra)