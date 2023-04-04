--[[ 
	Rira's Bra (리라의 속옷) - 액티브 : 4칸
	사용 시 그 방에서 랜덤 눈물 효과(3달러 지폐와 동일), 상태이상에 걸린 적에게 추가 피해
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_RiraBra(usedItem, rng, player, useFlags, activeSlot, varData)

	return {
		Discharge = true,
		Remove = false,
		ShowAnim = true,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RiraBra, wakaba.Enums.Collectibles.RIRAS_BRA)