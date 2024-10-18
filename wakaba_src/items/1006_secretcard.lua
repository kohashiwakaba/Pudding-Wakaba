local isc = require("wakaba_src.libs.isaacscript-common")
--LagCheck

function wakaba:PreRoomClear_SecretCard()
	if wakaba.G:IsGreedMode() then return end
	local hasSecretCard = false
  for i = 1, wakaba.G:GetNumPlayers() do
  	local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.SECRET_CARD) then
			hasSecretCard = true
		end
  end

	if hasSecretCard then
		for i = 0, 169 do
			local room = wakaba.G:GetLevel():GetRoomByIdx(i,-1)
			if room.Data and room.Data.Type == RoomType.ROOM_SHOP and room.SurpriseMiniboss then
				room.SurpriseMiniboss = false
			end
		end
	end
end

function wakaba:RoomClear_SecretCard()
	local extra = wakaba.G:GetLevel():GetStateFlag(LevelStateFlag.STATE_DAMAGED) and 0 or 1
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.SECRET_CARD) then
			player:AddCoins(extra + player:GetCollectibleNum(wakaba.Enums.Collectibles.SECRET_CARD))
		end
  end
end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.PreRoomClear_SecretCard)
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_SecretCard)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.PreRoomClear_SecretCard)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.RoomClear_SecretCard)

