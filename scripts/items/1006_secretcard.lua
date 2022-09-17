local enemycount = 0


local forcoins = 0
function wakaba:update26()
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.SECRET_CARD) and Game():IsGreedMode() then
  		local items = Isaac.FindByType(5, 20, 1, false, false)
  		for i, e in ipairs(items) do
  		   e:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 4, true)
  		end
		end
  end
end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.update26)
--LagCheck


wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	local hasSecretCard = false
	enemycount = 0
  for i = 1, Game():GetNumPlayers() do
  	local player = Isaac.GetPlayer(i - 1)
		if (player:GetPlayerType() == wakaba.PLAYER_WAKABA or player:HasCollectible(wakaba.Enums.Collectibles.SECRET_CARD)) and not Game():IsGreedMode() then
			hasSecretCard = true
		end
		local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.SECRET_CARD)
  	if Game():GetRoom():IsFirstVisit() and player:HasCollectible(wakaba.Enums.Collectibles.SECRET_CARD) and not Game():IsGreedMode() then
  	  enemycount = enemycount + rng:RandomInt(4) * player:GetCollectibleNum(wakaba.Enums.Collectibles.SECRET_CARD) + 1
  	end
  
  end

	if hasSecretCard then
		for i = 0, 169 do
			local room = Game():GetLevel():GetRoomByIdx(i,-1)
			if room.Data and room.Data.Type == RoomType.ROOM_SHOP and room.SurpriseMiniboss then
				room.SurpriseMiniboss = false
			end
		end
	end

end)


function wakaba:roomClearSecretCard()
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.SECRET_CARD) then
			player:AddCoins(enemycount)
			enemycount = 0
		end
  end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.roomClearSecretCard)

