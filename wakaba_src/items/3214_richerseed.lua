--[[
	Seed of Richer (리셰의 씨앗) - 장신구(Trinket)
	뒤틀린 리셰(TR 리셰)로 Mother 처치
	동전 획득 시 2%의 확률로 소지한 아이템의 불꽃 소환 (Deja Vu 판정)
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