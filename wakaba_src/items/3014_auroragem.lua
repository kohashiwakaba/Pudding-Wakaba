
local isc = _wakaba.isc
local easterEggChance = wakaba.state.options.eastereggchance

function wakaba:CoinInit_AuroraGem(pickup)
  if not wakaba:IsEntryUnlocked("easteregg") then return end
	if pickup.SubType ~= 1 then return end
  local seed = pickup.InitSeed

  local rng = RNG()
  rng:SetSeed(seed, 35)
  local randInt = rng:RandomFloat() * 100

  local canTurn = wakaba:Roll(rng, 0, wakaba:getOptionValue("eastereggchance") or 2, 0)

  if not wakaba.G:IsGreedMode() and canTurn then
    pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, wakaba.Enums.Coins.EASTER_EGG, false, true, true)
    return
  end

  if not isc:anyPlayerHasTrinket(wakaba.Enums.Trinkets.AURORA_GEM) then return end
  local players = isc:getPlayersWithTrinket(wakaba.Enums.Trinkets.AURORA_GEM) ---@type EntityPlayer[]
  for i, player in ipairs(players) do
	  local basicChance = (wakaba.Enums.Chances.AURORA_DEFAULT / 100)
	  local parLuck = 69
	  local maxChance = (wakaba.Enums.Chances.AURORA_MAX / 100) - basicChance
    local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.AURORA_GEM)
    local count = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.AURORA_GEM)

    local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck, parLuck, maxChance), count)

    local canTurn = rng:RandomFloat() < chance

    if canTurn then
      pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, wakaba.Enums.Coins.EASTER_EGG, false, true, true)
      return
    end
  end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.CoinInit_AuroraGem, PickupVariant.PICKUP_COIN)