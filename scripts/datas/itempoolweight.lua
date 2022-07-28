
-- Only put if the weight is not 1.0, or have one of these tags : offensive, nolostbr, nochallenge, nogreed
--[[ 
  You don't have to put all items in this table.
  But should insert if one of following conditions are met:
  ----------------------
  - Any items that is not weight of 1.0
  - Quality 0~2 : for Sacred Orb, T.Lost
  - tag 'offensive' : for T.Lost
  - tag 'nogreed' : for Greed Mode
  - tag 'nokeeper' : for Keeper
  - tag 'nochallenge' : for Challenges if any challenge uses T.Cain
  - tag 'nolostbr' : for The Lost
]]
wakaba.ItemPoolWeights = {
  [ItemPoolType.POOL_TREASURE] = {
    [wakaba.COLLECTIBLE_ARCANE_CRYSTAL] = 0.5,
    [wakaba.COLLECTIBLE_ADVANCED_CRYSTAL] = 0.5,
    [wakaba.COLLECTIBLE_MYSTIC_CRYSTAL] = 0.5,
    [wakaba.COLLECTIBLE_QUESTION_BLOCK] = 0.5,
    [wakaba.COLLECTIBLE_VENOM_INCANTATION] = 0.1,
  },
  [ItemPoolType.POOL_SHOP] = {
    [wakaba.COLLECTIBLE_WAKABAS_BLESSING] = 0.5,
    [wakaba.COLLECTIBLE_WAKABAS_NEMESIS] = 0.5,
    [wakaba.COLLECTIBLE_MAIJIMA_MYTHOLOGY] = 0.5,
    [wakaba.COLLECTIBLE_ISEKAI_DEFINITION] = 0.2,
    [wakaba.COLLECTIBLE_CONCENTRATION] = 0.5,
    [wakaba.COLLECTIBLE_PHANTOM_CLOAK] = 0.5,
    [wakaba.COLLECTIBLE_ANTI_BALANCE] = 0.5,
    [wakaba.COLLECTIBLE_SYRUP] = 0.5,
    [wakaba.COLLECTIBLE_RED_CORRUPTION] = 0.5,
  },
  [ItemPoolType.POOL_BOSS] = {
    [wakaba.COLLECTIBLE_D_CUP_ICECREAM] = 0.2,
  },
  [ItemPoolType.POOL_DEVIL] = {
    [wakaba.COLLECTIBLE_BOOK_OF_CONQUEST] = 0.5,
  },
  [ItemPoolType.POOL_ANGEL] = {
    [wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER] = 0.5,
  },
  [ItemPoolType.POOL_SECRET] = {
    [wakaba.COLLECTIBLE_WAKABAS_BLESSING] = 0.1,
    [wakaba.COLLECTIBLE_WAKABAS_NEMESIS] = 0.1,
    [wakaba.COLLECTIBLE_EXECUTIONER] = 0.75,
    [wakaba.COLLECTIBLE_NEW_YEAR_BOMB] = 0.75,
    [wakaba.COLLECTIBLE_DOUBLE_DREAMS] = 0.75,
    [wakaba.COLLECTIBLE_LUNAR_STONE] = 0.4,
  },
  --[[ [ItemPoolType.POOL_LIBRARY] = {
    [wakaba.COLLECTIBLE_DOUBLE_DREAMS] = 0.2,
    [wakaba.COLLECTIBLE_BOOK_OF_SHIORI] = 0.5,
    [wakaba.COLLECTIBLE_BOOK_OF_CONQUEST] = 0.4,
    [wakaba.COLLECTIBLE_MINERVA_AURA] = 0.8,
  }, ]]
  [ItemPoolType.POOL_SHELL_GAME] = {

  },
  [ItemPoolType.POOL_GOLDEN_CHEST] = {
    [wakaba.COLLECTIBLE_WAKABAS_BLESSING] = 0.1,
  },
  [ItemPoolType.POOL_RED_CHEST] = {
    [wakaba.COLLECTIBLE_WAKABAS_NEMESIS] = 0.1,
  },
  [ItemPoolType.POOL_CURSE] = {
    --[wakaba.COLLECTIBLE_WAKABAS_NEMESIS] = 0.1,
    [wakaba.COLLECTIBLE_DOUBLE_INVADER] = 0.5,
    [wakaba.COLLECTIBLE_RED_CORRUPTION] = 0.5,
  },
  [ItemPoolType.POOL_PLANETARIUM] = {

  },
}

-- Run this function inside 'PostGameStarted' callback.
function wakaba:ReplaceEIDBagWeight()
  local poolToIcon = { [0]="{{TreasureRoom}}",[1]="{{Shop}}",[2]="{{BossRoom}}",[3]="{{DevilRoom}}",[4]="{{AngelRoom}}",
  [5]="{{SecretRoom}}",[7]="{{PoopRoomIcon}}",[8]="{{GoldenChestRoomIcon}}",[9]="{{RedChestRoomIcon}}",[12]="{{CursedRoom}}",[26]="{{Planetarium}}" }
  
  local CraftingItemPools = EID.XMLItemPools
  print("[wakaba] Starting EID crafting data replacement")
  for poolNum, _ in pairs(poolToIcon) do
    for _, entry in pairs(CraftingItemPools[poolNum+1]) do
      for itemId, weight in pairs(wakaba.ItemPoolWeights[poolNum]) do
        local found = false
        print(itemId, weight, entry[1])
        if entry[1] == itemId then
          found = true
          entry[2] = weight
          break
        end
        -- Add weight data for tagged items if not available in item pools
        if not found then
          table.insert(CraftingItemPools[poolNum+1], {itemId, weight or 1.0})
        end
      end
    end
  end
  print("[wakaba] Finished EID crafting data replacement")
end
