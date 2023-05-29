local hasclover = 0
local DreamCardChance = wakaba.state.silverchance

function wakaba:cloverCache(player, cacheFlag)
  if player:HasTrinket(wakaba.Enums.Trinkets.CLOVER, false) then
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (0.3 * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.CLOVER) * wakaba:getEstimatedTearsMult(player)))
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + 1 + player:GetTrinketMultiplier(wakaba.Enums.Trinkets.CLOVER)
			player.Luck = player.Luck * 2
			if player.Luck < 0 then
				player.Luck = player.Luck * -1
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.cloverCache)

function wakaba:PostCloverUpdate()
	hasclover = 0

	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasTrinket(wakaba.Enums.Trinkets.CLOVER, false) then
			hasclover = hasclover + player:GetTrinketMultiplier(wakaba.Enums.Trinkets.CLOVER)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostCloverUpdate)
--LagCheck

function wakaba.cloverPickupCheck(pickup)
	if pickup.Variant == PickupVariant.PICKUP_TRINKET and pickup.SubType == wakaba.Enums.Trinkets.CLOVER and wakaba.state.unlock.clover <= 0 then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, TrinketType.TRINKET_NULL)
	elseif hasclover > 0 and pickup.Variant == PickupVariant.PICKUP_COIN and pickup.SubType == CoinSubType.COIN_PENNY then
		local randomInt = rng:RandomInt(DreamCardChance)
		if randomInt >= (2 + (hasclover * 2)) then
			return pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_LUCKYPENNY)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.cloverPickupCheck)
