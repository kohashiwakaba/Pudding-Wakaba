wakaba.COLLECTIBLE_ARCANE_CRYSTAL = Isaac.GetItemIdByName("Arcane Crystal")
wakaba.COLLECTIBLE_ADVANCED_CRYSTAL = Isaac.GetItemIdByName("Advanced Crystal")
wakaba.COLLECTIBLE_MYSTIC_CRYSTAL = Isaac.GetItemIdByName("Mystic Crystal")

function wakaba:Cache_Crystals(player, cacheFlag)
	if player:HasCollectible(wakaba.COLLECTIBLE_ARCANE_CRYSTAL) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (1 + (0.12 * player:GetCollectibleNum(wakaba.COLLECTIBLE_ARCANE_CRYSTAL)))
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING
		end
	end
	if player:HasCollectible(wakaba.COLLECTIBLE_ADVANCED_CRYSTAL) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (1 + (0.14 * player:GetCollectibleNum(wakaba.COLLECTIBLE_ADVANCED_CRYSTAL)))
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING
		end
	end
	if player:HasCollectible(wakaba.COLLECTIBLE_MYSTIC_CRYSTAL) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (1 + (0.16 * player:GetCollectibleNum(wakaba.COLLECTIBLE_MYSTIC_CRYSTAL)))
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_GLOW
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Crystals)


function wakaba:TakeDmg_Crystals(entity, amount, flag, source, countdownFrames)
	if entity.Type ~= EntityType.ENTITY_PLAYER
	and not (flag & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES) 
	then
		local player = nil
		if 
			(source
			and source.Entity 
			and source.Entity.SpawnerEntity 
			and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER )
		then
			player = source.Entity.SpawnerEntity:ToPlayer()
		elseif
			(source and source.Type == EntityType.ENTITY_PLAYER)
		then
			player = source.Entity:ToPlayer()
		end
		if player then
			if player:HasCollectible(wakaba.COLLECTIBLE_ARCANE_CRYSTAL) then
				local rng = player:GetCollectibleRNG(wakaba.COLLECTIBLE_ARCANE_CRYSTAL)
				local chance = rng:RandomInt(1000000)
				local threshold = 700000 + (30000 * player:GetCollectibleNum(wakaba.COLLECTIBLE_ADVANCED_CRYSTAL))
				if chance <= threshold then
					flag = flag | DamageFlag.DAMAGE_CLONES
					entity:TakeDamage(amount, flag, source, countdownFrames)
				end
			end
			if player:HasCollectible(wakaba.COLLECTIBLE_ADVANCED_CRYSTAL) then
				local rng = player:GetCollectibleRNG(wakaba.COLLECTIBLE_ADVANCED_CRYSTAL)
				local chance = rng:RandomInt(1000000)
				local threshold = 250000 + (50000 * player:GetCollectibleNum(wakaba.COLLECTIBLE_ADVANCED_CRYSTAL))
				if chance <= threshold then
					flag = flag | DamageFlag.DAMAGE_IGNORE_ARMOR | DamageFlag.DAMAGE_CLONES
					entity:TakeDamage(amount, flag, source, countdownFrames)
					return false
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_Crystals)



function wakaba:PickupCollision_Crystals(pickup, collider, low)
  if collider:ToPlayer() then
    local player = collider:ToPlayer()
		if (player:CanPickRedHearts() or player:CanPickSoulHearts()) and not wakaba:IsLost(player) then return end
		local thresholdmantlecount = wakaba.state.options.stackableholycard <= 5 and wakaba.state.options.stackableholycard or 5
		if player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) >= thresholdmantlecount then return end 
		if player:HasCollectible(wakaba.COLLECTIBLE_MYSTIC_CRYSTAL) then
			local picked = false
			if pickup.SubType == HeartSubType.HEART_BLENDED or pickup.SubType == HeartSubType.HEART_SOUL then
				player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
				player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
				picked = true
			elseif pickup.SubType == HeartSubType.HEART_HALF_SOUL then
				player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
				picked = true
			end
			if picked then
				if pickup:IsShopItem() then
					if pickup.Price == PickupPrice.PRICE_SPIKES then
						player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(pickup), 0)
					end
					pickup:Remove()
					return true
				else
					pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
					pickup:GetSprite():Play("Collect", true)
					pickup:PlayPickupSound()
					pickup:Die()
					return true
				end
			end
		end

  end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PickupCollision_Crystals, PickupVariant.PICKUP_HEART)





