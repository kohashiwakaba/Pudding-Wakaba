function wakaba:updatePlayerBitcoin(player)
	if player.FrameCount % 10 == 0 then
		if player:HasTrinket(wakaba.Enums.Trinkets.BITCOIN, false) then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_D8, UseFlag.USE_NOANIM)
		end
		if player:HasTrinket(wakaba.Enums.Trinkets.BITCOIN, true) then
			local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.BITCOIN)
			if player:GetPlayerType() ~= PlayerType.PLAYER_XXX_B then
				player:AddBombs(-99)
				player:AddBombs(1 + rng:RandomInt(99))
			end
			player:AddKeys(-99)
			player:AddKeys(1 + rng:RandomInt(99))
			if player:HasCollectible(CollectibleType.COLLECTIBLE_DEEP_POCKETS) then
				player:AddCoins(-999)
				player:AddCoins(1 + rng:RandomInt(999))
			else
				player:AddCoins(-999)
				player:AddCoins(1 + rng:RandomInt(99))
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				player:AddPoopMana(-29)
				player:AddPoopMana(1 + rng:RandomInt(29))
			else
				player:AddPoopMana(-29)
				player:AddPoopMana(1 + rng:RandomInt(9))
			end
			player:AddSoulCharge(-99)
			player:AddSoulCharge(1 + rng:RandomInt(99))
			player:AddBloodCharge(-99)
			player:AddBloodCharge(1 + rng:RandomInt(99))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.updatePlayerBitcoin)


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

function wakaba:PickupUpdate_BitCoin(pickup)
	if pickup.SubType == wakaba.Enums.Trinkets.BITCOIN and pickup.Touched then
		if pickup.Timeout <= 0 then
			SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN)
			pickup.Timeout = 40020
			pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
		elseif pickup.Timeout <= 40000 then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
			pickup:Remove()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_BitCoin, PickupVariant.PICKUP_TRINKET)