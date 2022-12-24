function wakaba:updatePlayerBitcoin(player)
	if player:HasTrinket(wakaba.Enums.Trinkets.BITCOIN, false) then
		if player:GetPlayerType() ~= PlayerType.PLAYER_XXX_B then
			player:AddBombs(-99)
			player:AddBombs(math.random(99))
		end
		player:AddKeys(-99)
		player:AddKeys(math.random(99))
		if player:HasCollectible(CollectibleType.COLLECTIBLE_DEEP_POCKETS) then
			player:AddCoins(-999)
			player:AddCoins(math.random(999))
		else
			player:AddCoins(-999)
			player:AddCoins(math.random(99))
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			player:AddPoopMana(-29)
			player:AddPoopMana(math.random(29))
		else
			player:AddPoopMana(-29)
			player:AddPoopMana(math.random(9))
		end
		player:AddSoulCharge(-99)
		player:AddSoulCharge(math.random(99))
		player:AddBloodCharge(-99)
		player:AddBloodCharge(math.random(99))
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.updatePlayerBitcoin)

function wakaba:newRoomBitcoin()
	for num = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(num)
		if player:HasTrinket(wakaba.Enums.Trinkets.BITCOIN, false) then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_D8, false, false, false, false, -1)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.newRoomBitcoin)


function wakaba:onBitcoinCache(player, cacheFlag)
  if player:HasTrinket(wakaba.Enums.Trinkets.BITCOIN, false) then
		local multiplier = 1 + (0.1 * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.BITCOIN))
    if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage * multiplier
    end
    if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
        player.ShotSpeed = player.ShotSpeed * multiplier
    end
    if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
        player.TearHeight = player.TearHeight - (player.TearHeight * multiplier)
        player.TearFallingSpeed = player.TearFallingSpeed + (player.TearFallingSpeed * multiplier)
    end
    if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
        player.MoveSpeed = player.MoveSpeed * multiplier
    end
    if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
        player.Luck = player.Luck * multiplier
    end
    if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
        player.MaxFireDelay = player.MaxFireDelay * (1 / multiplier)
    end
  end
	
end
 
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onBitcoinCache)


function wakaba.bitcoinUnlockCheck(pickup)
	if pickup.SubType == wakaba.Enums.Trinkets.BITCOIN and wakaba.state.unlock.bitcoin <= 0 then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.G:GetItemPool():GetTrinket())
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.bitcoinUnlockCheck, PickupVariant.PICKUP_TRINKET)
