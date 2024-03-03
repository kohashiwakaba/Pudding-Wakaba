
local isc = require("wakaba_src.libs.isaacscript-common")
local easterEggChance = wakaba.state.options.eastereggchance

function wakaba:CoinInit_AuroraGem(pickup)
  if not wakaba:IsEntryUnlocked("easteregg") then return end
	if pickup.SubType ~= 1 then return end
  local seed = pickup.InitSeed

  local rng = RNG()
  rng:SetSeed(seed, 35)
  local randInt = rng:RandomFloat() * 100

  local canTurn = wakaba:Roll(rng, 0, easterEggChance, 0)

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