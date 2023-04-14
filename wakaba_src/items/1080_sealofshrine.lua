--[[ 
	Seal of Shrine (신사의 봉인) - 액티브 : 8칸
	체력 한칸을 소모(로스트는 무료)하여 황금 장신구 소환, 미해금 시 장신구 2개 소환
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_SecretDoor(usedItem, rng, player, useFlags, activeSlot, varData)

	local room = wakaba.G:GetRoom()

	return {
		Discharge = true,
		Remove = false,
		ShowAnim = true,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_SecretDoor, wakaba.Enums.Collectibles.SECRET_DOOR)
