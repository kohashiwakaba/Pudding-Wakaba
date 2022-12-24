
--[[ 
  You don't have to put all items in this table.
  But should insert if one of following conditions are met:
  ----------------------
  - Any items that is not weight of 1.0
  - Quality 0~2 : for Sacred Orb, T.Lost
  - not having tag 'offensive' : for T.Lost
  - tag 'nogreed' : for Greed Mode
  - tag 'nokeeper' : for Keeper
  - tag 'nochallenge' : for Challenges if any challenge uses T.Cain
  - tag 'nolostbr' : for The Lost
]]
wakaba.ItemPoolWeights = {
  [ItemPoolType.POOL_TREASURE] = {
    [wakaba.Enums.Collectibles.ARCANE_CRYSTAL] = 0.5,
    [wakaba.Enums.Collectibles.ADVANCED_CRYSTAL] = 0.5,
    [wakaba.Enums.Collectibles.MYSTIC_CRYSTAL] = 0.5,
    [wakaba.Enums.Collectibles.QUESTION_BLOCK] = 0.5,
    [wakaba.Enums.Collectibles.VENOM_INCANTATION] = 0.1,
    [wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = 1.0,
    [wakaba.Enums.Collectibles.JAR_OF_CLOVER] = 1.0,
    [wakaba.Enums.Collectibles.SEE_DES_BISCHOFS] = 1.0,
    [wakaba.Enums.Collectibles.CARAMELLO_PANCAKE] = 1.0,
  },
  [ItemPoolType.POOL_SHOP] = {
    [wakaba.Enums.Collectibles.WAKABAS_BLESSING] = 0.5,
    [wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = 0.5,
    [wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY] = 0.5,
    [wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = 0.2,
    [wakaba.Enums.Collectibles.CONCENTRATION] = 0.5,
    [wakaba.Enums.Collectibles.PHANTOM_CLOAK] = 0.5,
    [wakaba.Enums.Collectibles.ANTI_BALANCE] = 0.5,
    [wakaba.Enums.Collectibles.SYRUP] = 0.5,
    [wakaba.Enums.Collectibles.RED_CORRUPTION] = 0.5,
    [wakaba.Enums.Collectibles.COUNTER] = 1.0,
    [wakaba.Enums.Collectibles.RETURN_POSTAGE] = 1.0,
    [wakaba.Enums.Collectibles.PRESTIGE_PASS] = 0.1,
  },
  [ItemPoolType.POOL_BOSS] = {
    [wakaba.Enums.Collectibles.D_CUP_ICECREAM] = 0.2,
    [wakaba.Enums.Collectibles.FIREFLY_LIGHTER] = 1.0,
    [wakaba.Enums.Collectibles.ONSEN_TOWEL] = 1.0,
  },
  [ItemPoolType.POOL_DEVIL] = {
    [wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = 0.5,
    [wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = 1.0,
    [wakaba.Enums.Collectibles.VINTAGE_THREAT] = 1.0,
    [wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = 1.0,
    [wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = 1.0,
    [wakaba.Enums.Collectibles.PRESTIGE_PASS] = 0.5,
  },
  [ItemPoolType.POOL_ANGEL] = {
    [wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = 0.5,
    [wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = 1.0,
    [wakaba.Enums.Collectibles.VINTAGE_THREAT] = 1.0,
    [wakaba.Enums.Collectibles.BOOK_OF_THE_GOD] = 1.0,
    [wakaba.Enums.Collectibles.PRESTIGE_PASS] = 0.5,
  },
  [ItemPoolType.POOL_SECRET] = {
    [wakaba.Enums.Collectibles.WAKABAS_BLESSING] = 0.1,
    [wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = 0.1,
    [wakaba.Enums.Collectibles.EXECUTIONER] = 0.75,
    [wakaba.Enums.Collectibles.NEW_YEAR_BOMB] = 0.75,
    [wakaba.Enums.Collectibles.DOUBLE_DREAMS] = 0.75,
    [wakaba.Enums.Collectibles.LUNAR_STONE] = 0.4,
    [wakaba.Enums.Collectibles.RETURN_POSTAGE] = 1.0,
    [wakaba.Enums.Collectibles.UNIFORM] = 1.0,
    [wakaba.Enums.Collectibles.RED_CORRUPTION] = 1.0,
  },
  --[[ [ItemPoolType.POOL_LIBRARY] = {
    [wakaba.Enums.Collectibles.DOUBLE_DREAMS] = 0.2,
    [wakaba.Enums.Collectibles.BOOK_OF_SHIORI] = 0.5,
    [wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = 0.4,
    [wakaba.Enums.Collectibles.MINERVA_AURA] = 0.8,
  }, ]]
  [ItemPoolType.POOL_SHELL_GAME] = {

  },
  [ItemPoolType.POOL_GOLDEN_CHEST] = {
    [wakaba.Enums.Collectibles.WAKABAS_BLESSING] = 0.1,
  },
  [ItemPoolType.POOL_RED_CHEST] = {
    [wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = 0.1,
    [wakaba.Enums.Collectibles.ANTI_BALANCE] = 1.0,
    [wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = 1.0,
    [wakaba.Enums.Collectibles.RED_CORRUPTION] = 1.0,
  },
  [ItemPoolType.POOL_CURSE] = {
    --[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = 0.1,
    [wakaba.Enums.Collectibles.DOUBLE_INVADER] = 0.5,
    [wakaba.Enums.Collectibles.RED_CORRUPTION] = 0.5,
    [wakaba.Enums.Collectibles.ANTI_BALANCE] = 1.0,
    [wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = 1.0,
  },
  [ItemPoolType.POOL_PLANETARIUM] = {
    [wakaba.Enums.Collectibles.LUNAR_STONE] = 1.0,
  },
}

--local CraftingMaxItemID = EID.XMLMaxItemID
--local CraftingFixedRecipes = EID.XMLRecipes
local CraftingItemPools = EID.XMLItemPools
local moddedCrafting = false
-- Run this function inside 'PostGameStarted' callback.
--[[ function wakaba:ReplaceEIDBagWeight()
  if not EID.Config["BagOfCraftingModdedRecipes"] or moddedCrafting then return end
  local poolToIcon = { [0]="{{TreasureRoom}}",[1]="{{Shop}}",[2]="{{BossRoom}}",[3]="{{DevilRoom}}",[4]="{{AngelRoom}}",
  [5]="{{SecretRoom}}",[7]="{{PoopRoomIcon}}",[8]="{{GoldenChestRoomIcon}}",[9]="{{RedChestRoomIcon}}",[12]="{{CursedRoom}}",[26]="{{Planetarium}}" }
  
  local CraftingItemPools = EID.XMLItemPools
  print("[wakaba] Starting EID crafting data replacement")
  -- per pool
  for poolNum, _ in pairs(poolToIcon) do
    --for s, e in pairs(CraftingItemPools[1]) do
    for s, entry in pairs(CraftingItemPools[poolNum+1]) do
      -- for id, weight in pairs(wakaba.ItemPoolWeights[0]) do
      for itemId, weight in pairs(wakaba.ItemPoolWeights[poolNum]) do
        local found = false
        if entry[1] == itemId and weight ~= 1.0 then
          found = true
          --print("[wakaba] found :", poolNum, itemId, weight)
          entry[2] = weight
          break
        end
        -- Add weight data for tagged items if not available in item pools
        if not found then
          --print("[wakaba] not found :", poolNum, itemId)
          --table.insert(CraftingItemPools[poolNum+1], {itemId, weight or 1.0})
        end
      end
    end
  end
  moddedCrafting = true
  print("[wakaba] Finished EID crafting data replacement")
end
 ]]
function wakaba:ReplaceEIDBagWeight()
  if not EID.Config["BagOfCraftingModdedRecipes"] or moddedCrafting then return end
  local poolToIcon = { [0]="{{TreasureRoom}}",[1]="{{Shop}}",[2]="{{BossRoom}}",[3]="{{DevilRoom}}",[4]="{{AngelRoom}}",
  [5]="{{SecretRoom}}",[7]="{{PoopRoomIcon}}",[8]="{{GoldenChestRoomIcon}}",[9]="{{RedChestRoomIcon}}",[12]="{{CursedRoom}}",[26]="{{Planetarium}}" }
  
  print("[wakaba] Starting EID crafting data replacement")
  -- per pool
  for poolNum, _ in pairs(poolToIcon) do
    --for s, e in pairs(CraftingItemPools[1]) do
    for itemId, weight in pairs(wakaba.ItemPoolWeights[poolNum]) do
      local found = false
      for s, entry in pairs(CraftingItemPools[poolNum+1]) do
        if entry[1] == itemId and weight ~= 1.0 then
          found = true
          print("[wakaba] found :", itemId, "from pool", poolNum,", replacing weight of", weight)
          entry[2] = weight
          break
        elseif entry[1] == itemId then
          found = true
          print("[wakaba] found :", itemId, "from pool", poolNum,", keep values")
          break
        end
      end
      -- Add weight data for tagged items if not available in item pools
      if not found then
        print("[wakaba] not found :", itemId, "from", poolNum,", inserting weight of", weight)
        table.insert(CraftingItemPools[poolNum+1], {itemId, weight or 1.0})
      end
    end
  end
  moddedCrafting = true
  print("[wakaba] Finished EID crafting data replacement")
end