--[[
	Sacred Penny (신성한 페니) - 기타 픽업 (Pickup)
	뒤틀린 와카바(TR 와카바)로 Mother 처치
	획득 시 보호막 1개 획득

	Seed of Wakaba (와카바의 씨앗) - 장신구(Trinket)
	뒤틀린 와카바(TR 와카바)로 Mother 처치
	신성한 동전 드랍률 증가
]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:CoinInit_AuroraGem(pickup)
	if not wakaba.state.options.allowlockeditems and wakaba.state.unlock.easteregg < 1 then return end
	if pickup.SubType ~= 1 then return end
	local seed = pickup.InitSeed

	local rng = RNG()
	rng:SetSeed(seed, 35)
	local randInt = rng:RandomFloat() * 100

	local canTurn = wakaba:Roll(rng, 0, 2, 0)

	if not wakaba.G:IsGreedMode() and canTurn then
		pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, wakaba.Enums.Coins.EASTER_EGG, false, true, true)
		return
	end

	if not isc:anyPlayerHasTrinket(wakaba.Enums.Trinkets.AURORA_GEM) then return end
	local players = isc:getPlayersWithCollectible(wakaba.Enums.Trinkets.AURORA_GEM)
	for i, player in ipairs(players) do
		local minRoll = wakaba.Enums.Chances.AURORA_DEFAULT * player:GetTrinketMultiplier(wakaba.Enums.Trinkets.AURORA_GEM)
		local chanceNum = wakaba.Enums.Chances.AURORA_LUCK
		local maxNum = wakaba.Enums.Chances.AURORA_MAX
		local canTurn = wakaba:Roll(rng, player.Luck + player:GetCollectibleNum(wakaba.Enums.Collectibles.EASTER_EGG), minRoll, chanceNum, maxNum)

		if canTurn then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, wakaba.Enums.Coins.EASTER_EGG, false, true, true)
			return
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.CoinInit_AuroraGem, PickupVariant.PICKUP_COIN)

local isc = require("wakaba_src.libs.isaacscript-common")
local sacredSpawnChance = wakaba.Enums.Constants.CLOVER_CHEST_COLLECTIBLE_CHANCE

function wakaba:CoinUpdate_SacredPenny(pickup)
	if pickup.SubType ~= wakaba.Enums.Coins.EASTER_EGG then return end

	if pickup:GetSprite():IsEventTriggered("DropSound") then
		SFXManager():Play(SoundEffect.SOUND_PENNYDROP, 1, 0, false, 1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.CoinUpdate_SacredPenny, PickupVariant.PICKUP_COIN)

function wakaba:CoinCollision_SacredPenny(pickup, collider)
	if pickup.SubType ~= wakaba.Enums.Coins.EASTER_EGG then return end

	if collider:ToPlayer() or
		 (collider:ToFamiliar() and (collider.Variant == FamiliarVariant.BUM_FRIEND or
								collider.Variant == FamiliarVariant.BUMBO or
								collider.Variant == FamiliarVariant.SUPER_BUM))
	then
		local sprite = pickup:GetSprite()
		if not (sprite:WasEventTriggered("DropSound") or sprite:IsPlaying("Idle")) then
			return false
		end

		local player = collider:ToPlayer()
		local familiar = collider:ToFamiliar()

		if player then
			player:AddCoins(1)
			player:AddCollectible(wakaba.Enums.Collectibles.EASTER_EGG)
		elseif familiar then
			familiar.Coins = familiar.Coins + 1
			if familiar.Player then
				familiar.Player:AddCollectible(wakaba.Enums.Collectibles.EASTER_EGG)
			end
		end
		--sfx:Play(SoundEffect.SOUND_CANDLE_LIGHT, 1, 0, false, 1)
		SFXManager():Play(SoundEffect.SOUND_SOUL_PICKUP, 1.3, 0, false, 1)

		wakaba:RemoveOtherOptionPickups(pickup)

		pickup.Velocity = Vector.Zero
		pickup.Touched = true
		pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
		sprite:Play("Collect", true)
		pickup:Die()

		Game():SetStateFlag(GameStateFlag.STATE_HEART_BOMB_COIN_PICKED, true)

		return true
	elseif collider.Type == EntityType.ENTITY_ULTRA_GREED or
				collider.Type == EntityType.ENTITY_BUMBINO
	then
		pickup.SubType = 1
		return
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.CoinCollision_SacredPenny, PickupVariant.PICKUP_COIN)
