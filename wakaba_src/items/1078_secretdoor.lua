--[[ 
	Secret Door () - 액티브 : 2칸
	사용 시 시작 방으로 텔레포트, 특정 조건에서 다른 효과 발동
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_SecretDoor(usedItem, rng, player, useFlags, activeSlot, varData)

	local room = wakaba.G:GetRoom()

	if room:GetType() == RoomType.ROOM_BOSS and room:GetBossID() == 6 and wakaba.G:GetFrameCount() > wakaba.G.BossRushParTime then
		room:TrySpawnBossRushDoor(true)
	elseif room:GetType() == RoomType.ROOM_SHOP then
		room:TrySpawnSecretShop(true)
	else
		player:UseCard(Card.CARD_FOOL, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
	end

	return {
		Discharge = true,
		Remove = false,
		ShowAnim = true,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_SecretDoor, wakaba.Enums.Collectibles.SECRET_DOOR)
