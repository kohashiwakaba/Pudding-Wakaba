local function g2p(grid)

end

local rooms = {
  {
    Name = "WAKABA_TURNOVER_WINTER_ALBIREO",		 -- shop name, is used internally
    Checker = function ()			-- takes 0 arguments, return true if this shop pool should be used
      local level = wakaba.G:GetLevel()
      local roomdesc = level:GetCurrentRoomDesc()
      return wakaba:IsValidWakabaRoom(roomdesc, wakaba.Enums.Collectibles.WINTER_ALBIREO)
    end,
    {
      --ShopKeeperPosition = Vector(320,180), -- optional, defaults to Vector(320, 200)
      SetUpPrice = 10,											-- optional, defaults to 10

      -- tables at numeric indexes starting from 0 are shop tiers
      -- it's possible to have any amount of shop tiers, as long as their indexes are sequential
      [0] =
      {
        SetUpPrice = 5, -- optional, overrides SetUpPrice in outer scope

        -- first index is always position, second is the item type
        -- pickups are chosen from PickupPool table
        {Vector(280, 320), ShopItemType.Pickup},

        -- collectibles are picked from current room's item pool
        -- unless a getter function is specified at index [3]
        {Vector(360, 320), ShopItemType.Collectible},
        {Vector(360, 360), ShopItemType.Collectible, function (itemPoolType, rng)
          local itemID = rng:RandomInt(CollectibleType.NUM_COLLECTIBLES) + 1
          return itemID
        end},

        -- slots are picked from Slots SlotGroup
        -- unless a getter function is specified at index [3]
        {Vector(360, 400), ShopItemType.Slot},
        {Vector(360, 440), ShopItemType.Slot, function (rng)
          local slotID = rng:RandomInt(9) + 1
          return slotID
        end},

        -- restock machine only spawns if turnover is used by TR Keeper with Birthright
        {Vector(360, 400), ShopItemType.RestockMachine}
      },
      [1] =
      {
        -- ...
      },
      -- PICKUP POOL ENTRY INFO
      -- [1] =
      -- {
      --		[1]				- Pickup variant
      --		[2]				- Pickup subtype
      --										 * may be an int or a function
      --									* that takes 0 arguments and returns the subtype
      --
      --		minTier - Lowest tier at which a pickup can appear
      --		maxTier - Highest tier at which a pickup can appear
      -- },
      -- Weight	- Pickup's weight
      --								* Higher weight pickups are more likely to spawn
      --								* Pickup's weight is reduced by 4 times for the current shop tier when it spawns
      --
      -- Pickup variant/subtype are required
      -- minTier, maxTier are optional, checks for them pass by default
      -- Weight is optional and defaults to 1.0
      PickupPool =
      {
        {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL,																	 minTier = 0, maxTier = 3 }},
        {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_DOUBLEPACK,														 minTier = 2, maxTier = 4 }},
        {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA,																		 minTier = 2, maxTier = 4 },	Weight = 0.06},
        {{ PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN,																	 minTier = 2, maxTier = 4 },	Weight = 0.03},
        {{ PickupVariant.PICKUP_KEY,	KeySubType.KEY_NORMAL,																	minTier = 0, maxTier = 3 }},
      }
    }
  }
}

return rooms