--[[
	Secret Door () - 액티브 : 2칸
	사용 시 시작 방으로 텔레포트, 특정 조건에서 다른 효과 발동
 ]]

local isc = _wakaba.isc

function wakaba:ItemUse_SecretDoor(usedItem, rng, player, useFlags, activeSlot, varData)

	local room = wakaba.G:GetRoom()

	if wakaba:IsLunatic() then
		player:UseCard(Card.CARD_FOOL, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
	else
		if room:GetType() == RoomType.ROOM_BOSS and room:GetBossID() == 6 and wakaba.G:GetFrameCount() > wakaba.G.BossRushParTime then
			room:TrySpawnBossRushDoor(true)
			SFXManager():Play(SoundEffect.SOUND_GOLDENKEY, 2, 0, false, 1)
		elseif room:GetType() == RoomType.ROOM_SHOP then
			room:TrySpawnSecretShop(true)
			SFXManager():Play(SoundEffect.SOUND_GOLDENKEY, 2, 0, false, 1)
		else
			player:UseCard(Card.CARD_FOOL, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
		end
	end

	return {
		Discharge = true,
		Remove = false,
		ShowAnim = true,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_SecretDoor, wakaba.Enums.Collectibles.SECRET_DOOR)
