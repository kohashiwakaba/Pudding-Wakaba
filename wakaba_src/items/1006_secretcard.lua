local isc = require("wakaba_src.libs.isaacscript-common")
local enemycount = 0
--LagCheck

function wakaba:PreRoomClear_SecretCard()
	local hasSecretCard = false
	enemycount = 0
  for i = 1, wakaba.G:GetNumPlayers() do
  	local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.SECRET_CARD) then
			hasSecretCard = true
		end
		local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.SECRET_CARD)
  	if (wakaba.G.Difficulty ~= Difficulty.DIFFICULTY_HARD and wakaba.G:GetRoom():IsFirstVisit() and player:HasCollectible(wakaba.Enums.Collectibles.SECRET_CARD)) or wakaba.G:IsGreedMode() then
  	  enemycount = enemycount + rng:RandomInt(4) * player:GetCollectibleNum(wakaba.Enums.Collectibles.SECRET_CARD) + 1
  	end
  
  end

	if wakaba.G:IsGreedMode() then return end

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
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.SECRET_CARD) then
			player:AddCoins(enemycount + player:GetCollectibleNum(wakaba.Enums.Collectibles.SECRET_CARD))
			enemycount = 0
		end
  end
end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.PreRoomClear_SecretCard)
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_SecretCard)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.PreRoomClear_SecretCard)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.RoomClear_SecretCard)

