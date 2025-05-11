--[[
	Question Block (물음표 블럭) - 패시브
  돌이 일정 확률로 물음표 블럭으로 변경
  물음표 블럭을 공격으로 치면 아래 효과 중 하나 발동
  - 동전
  - 동전 (10연속)
  - 버섯 : 그 스테이지에서 Magic Mushroom 지급, 패널티 피격 시 초기화
  - 플라워 : 그 방의 적에게 화상 효과 발동
  - 코끼리 : 확률적으로 그 방의 적 둔화
  - 버블 : 그 방에서 가장 체력이 높은 적 약화
  - 드릴 : 랜덤 픽업 드랍
]]

function wakaba:AfterRevival_QuestionBlock(player)
	local wisp = wakaba:HasWisp(player, wakaba.Enums.Collectibles.QUESTION_BLOCK)
	if wisp then
		wisp:Kill()
	end
end

if not REPENTOGON then return end

-- TODO
wakaba.QuestionBlockRewards = {
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COIN, s = CoinSubType.COIN_PENNY, x = SoundEffect.SOUND_PENNYPICKUP, w = 1.0},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COIN, s = CoinSubType.COIN_NICKEL,  x = SoundEffect.SOUND_PENNYPICKUP, w = 0.1},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COIN, s = CoinSubType.COIN_DIME,  x = SoundEffect.SOUND_PENNYPICKUP, w = 0.04},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COIN, s = CoinSubType.COIN_LUCKYPENNY,  x = SoundEffect.SOUND_PENNYPICKUP, w = 0.06},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COIN, s = CoinSubType.COIN_GOLDEN,  x = SoundEffect.SOUND_PENNYPICKUP, w = 0.03},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COIN, s = wakaba.Enums.Coins.EASTER_EGG,  x =  wakaba.Enums.SoundEffects.CHIMAKI_KYUU, w = 0.1},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_KEY,  s = KeySubType.KEY_NORMAL , x = SoundEffect.SOUND_PLOP, w = 0.4},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_BOMB, s = BombSubType.BOMB_NORMAL, x = SoundEffect.SOUND_PLOP, w = 0.4},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_TAROTCARD, s = 0, x = SoundEffect.SOUND_SHELLGAME, w = 0.2},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_PILL, s = 0, x = SoundEffect.SOUND_SHELLGAME, w = 0.2},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_GRAB_BAG, s = SackSubType.SACK_NORMAL, x = SoundEffect.SOUND_SHELLGAME, w = 0.1},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_THROWABLEBOMB, s = 0, x = SoundEffect.SOUND_SHELLGAME, w = 0.5},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_TRINKET, s = 0, x = SoundEffect.SOUND_SHELLGAME, w = 0.02},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COLLECTIBLE, s = CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM, x = SoundEffect.SOUND_MUSHROOM_POOF_2, w = 0.05},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COLLECTIBLE, s = CollectibleType.COLLECTIBLE_1UP, x = SoundEffect.SOUND_MUSHROOM_POOF_2, w = 0.01},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COLLECTIBLE, s = CollectibleType.COLLECTIBLE_MINI_MUSH, x = SoundEffect.SOUND_MUSHROOM_POOF_2, w = 0.01},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COLLECTIBLE, s = CollectibleType.COLLECTIBLE_MEGA_MUSH, x = SoundEffect.SOUND_MUSHROOM_POOF_2, w = 0.0001},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COLLECTIBLE, s = CollectibleType.COLLECTIBLE_GNAWED_LEAF, x = SoundEffect.SOUND_MUSHROOM_POOF_2, w = 0.01},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COLLECTIBLE, s = CollectibleType.COLLECTIBLE_BOBBY_BOMB, x = SoundEffect.SOUND_MUSHROOM_POOF_2, w = 0.01},
  {e = EntityType.ENTITY_PICKUP, v = PickupVariant.PICKUP_COLLECTIBLE, s = CollectibleType.COLLECTIBLE_GLITCHED_CROWN, x = SoundEffect.SOUND_MUSHROOM_POOF_2, w = 0.0001},
}

wakaba.QuestionBlockWeight = WeightedOutcomePicker()
for i, e in ipairs(wakaba.QuestionBlockRewards) do
  wakaba.QuestionBlockWeight:AddOutcomeFloat(i, e.w)
end

---@param grid GridEntity
---@return integer
function wakaba:getDesignatedQuestionBlockSeed(grid)
  return (wakaba.G:GetRoom():GetDecorationSeed() // 2) + (grid:GetGridIndex() * 266543457) - (grid.Position.X * 55325) + (grid.Position.Y * 654342)
end

---@param questionBlock GridEntity
---@function
function wakaba:loadQuestionBlockSprite(questionBlock)
  local sprite = questionBlock:GetSprite()
  local anim = sprite:GetAnimation()
  local frame = sprite:GetFrame()
  local anm2 = "gfx/grid/wakaba_question_block.anm2"
  if questionBlock.VarData == 1 then
    anm2 = "gfx/grid/wakaba_question_block_used.anm2"
  end
  sprite:Load(anm2, true)
  sprite:SetFrame(anim, frame)
end

function wakaba:NewRoom_QuestionBlock()
  local room = wakaba.R() ---@type Room
	for i = 0, room:GetGridSize() - 1 do
		local gridEnt = room:GetGridEntity(i)
		if gridEnt and gridEnt:ToRock() then
      if gridEnt:GetVariant() == wakaba.Enums.GridVars.QUESTION_BLOCK then
        wakaba:loadQuestionBlockSprite(gridEnt)
      end
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_ROOM, 300, wakaba.NewRoom_QuestionBlock)

---@param grid GridEntity
---@function
function wakaba:makeGridQuestionBlock(grid, force)
  if force then
    grid:SetType(GridEntityType.GRID_ROCK)
  else
    if grid:GetType() ~= GridEntityType.GRID_ROCK then
      return
    elseif grid:ToRock():GetBigRockFrame() ~= -1 then
      return
    elseif grid:GetVariant() >= 1 then
      return
    end
  end
  grid:SetVariant(wakaba.Enums.GridVars.QUESTION_BLOCK)
end

---@param questionBlock GridEntity
---@function
function wakaba:HitQuestionBlock(questionBlock)
  if questionBlock.VarData == 1 then
    return
  end
  wakaba:spawnQuestionBlockReward(questionBlock)
  questionBlock.VarData = 1
  wakaba:loadQuestionBlockSprite(questionBlock)
  questionBlock:Update()
end

---@param questionBlock GridEntity
---@function
function wakaba:spawnQuestionBlockReward(questionBlock)
  if questionBlock:GetVariant() ~= wakaba.Enums.GridVars.QUESTION_BLOCK then
    return
  end
  if questionBlock.VarData == 1 then
    return
  end

  local seed = wakaba:getDesignatedQuestionBlockSeed(questionBlock)
  local rng = RNG(seed)
  local outcome = wakaba.QuestionBlockWeight:PickOutcome(rng)
  local entry = wakaba.QuestionBlockRewards[outcome]
  SFXManager():Play(SoundEffect.SOUND_POT_BREAK)
  if entry.x then
    SFXManager():Play(entry.x)
  end

  if entry.e == EntityType.ENTITY_PICKUP and entry.v == PickupVariant.PICKUP_COLLECTIBLE then
    local itemPedestal = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, entry.s, questionBlock.Position, Vector.Zero, nil):ToPickup()
    questionBlock:Destroy()
  else
    local entity = Isaac.Spawn(entry.e, entry.v, entry.s, wakaba.R():FindFreePickupSpawnPosition(questionBlock.Position), Vector.Zero, nil):ToPickup()
  end
end

---@param grid GridEntity
function wakaba:PostGridSpawn_QuestionBlock(grid)
  if not (grid:GetType() == GridEntityType.GRID_ROCK and grid:GetVariant() ~= wakaba.Enums.GridVars.QUESTION_BLOCK) then
    return
  end
  local count = PlayerManager.GetNumCollectibles(wakaba.Enums.Collectibles.QUESTION_BLOCK)
  if count > 0 then
    local seed = (wakaba.G:GetRoom():GetDecorationSeed() // 2) + (grid:GetGridIndex() * 266543457) - (grid.Position.X * 55325) + (grid.Position.Y * 654342)

    local rng = RNG(seed, 35)
    local res = rng:PhantomFloat()
    wakaba.Log("Question block test from gridIdx", grid:GetGridIndex(), "seed", seed, "res", res)
    if res <= wakaba.Enums.Constants.QUESTION_BLOCK_SPAWN_RATE then
      wakaba.Log("Question block spawned! from gridIdx", grid:GetGridIndex(), "seed", seed)
      grid:SetVariant(wakaba.Enums.GridVars.QUESTION_BLOCK)
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GRID_ENTITY_SPAWN, wakaba.PostGridSpawn_QuestionBlock)

---@param tear EntityTear
---@param gridIndex integer
---@param questionBlock GridEntity
function wakaba:TearGridCollision_QuestionBlock(tear, gridIndex, questionBlock)
  if not questionBlock or not questionBlock:ToRock() or questionBlock:GetVariant() ~= wakaba.Enums.GridVars.QUESTION_BLOCK then
    return
  end
  if questionBlock.VarData == 1 then
    return
  end
  if not questionBlock:ToRock():IsBreakableRock() then return end
  wakaba:HitQuestionBlock(questionBlock)
end
wakaba:AddCallback(ModCallbacks.MC_PRE_TEAR_GRID_COLLISION, wakaba.TearGridCollision_QuestionBlock)

