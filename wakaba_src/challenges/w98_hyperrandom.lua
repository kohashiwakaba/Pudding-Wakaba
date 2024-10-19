
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_RAND
local randtainted = wakaba.runstate.randtainted
wakaba.ChallengeParams.HyperRandomBlacklisted = {
  [CollectibleType.COLLECTIBLE_GENESIS] = true,
  [CollectibleType.COLLECTIBLE_DAMOCLES] = true,
  [wakaba.Enums.Collectibles.STICKY_NOTE] = true,
  [wakaba.Enums.Collectibles.SELF_BURNING] = true,
}

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_EvenOrOdd(player)
	if wakaba.G.Challenge ~= c then return end
  player:SetPocketActiveItem(wakaba.Enums.Collectibles.WAKABAS_CURFEW, ActiveSlot.SLOT_POCKET, true)
  player:DischargeActiveItem(ActiveSlot.SLOT_POCKET)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_EvenOrOdd)

---와카바 뒤집기
---@param player EntityPlayer
---@param prevTainted boolean
local function TryFlipWakaba(player, prevTainted)
	player:GetData().wakaba.maxitemnum = player:GetData().wakaba.maxitemnum or -1
	player:ChangePlayerType(prevTainted and wakaba.Enums.Players.WAKABA or wakaba.Enums.Players.WAKABA_B)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, false, false, false, false, -1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D8, false, false, false, false, -1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D10, false, false, false, false, -1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D12, false, false, false, false, -1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D20, false, false, false, false, -1)

	local removedcount = 0
	local maxnum = -1
	local itemcount = wakaba:GetMinTMTRAINERNumCount(player)
	while removedcount < itemcount do
		local config = Isaac.GetItemConfig():GetCollectible(maxnum)
		if config and player:HasCollectible(maxnum) then
			player:RemoveCollectible(maxnum)
			removedcount = removedcount + 1
		end
		maxnum = maxnum - 1
	end
	local addedcount = 0
	while addedcount < itemcount do
		local id = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_TREASURE)
		local config = Isaac.GetItemConfig():GetCollectible(id)
		Isaac.DebugString(config.Type .. " " .. player:GetActiveItem() .. " ")
		if config.Type ~= ItemType.ITEM_ACTIVE or player:GetActiveItem() == 0 then
			player:AddCollectible(id)
			addedcount = addedcount + 1
		end
	end

	player:AnimateSad()
	randtainted = prevTainted
	player:SetPocketActiveItem(prevTainted and wakaba.Enums.Collectibles.WAKABAS_CURFEW or wakaba.Enums.Collectibles.WAKABAS_CURFEW2, ActiveSlot.SLOT_POCKET, false)
	SFXManager():Play(prevTainted and SoundEffect.SOUND_LAZARUS_FLIP_DEAD or SoundEffect.SOUND_LAZARUS_FLIP_ALIVE)

end

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_HyperRandom(player)
	if wakaba.G.Challenge ~= c then return end
  player:SetPocketActiveItem(wakaba.Enums.Collectibles.WAKABAS_CURFEW, ActiveSlot.SLOT_POCKET, true)
  player:DischargeActiveItem(ActiveSlot.SLOT_POCKET)
  if player:GetPlayerType() == wakaba.Enums.Players.WAKABA or player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B then return end
  if wakaba.G:GetFrameCount() == 0 then
    Isaac.ExecuteCommand("restart " .. wakaba.Enums.Players.WAKABA)
    return
  else
    player:ChangePlayerType(wakaba.Enums.Players.WAKABA)
  end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_PLAYER_INIT, -19999, wakaba.Challenge_PlayerInit_HyperRandom)

function wakaba:Challenge_NewRoom_HyperRandom()
	if wakaba.G.Challenge ~= c then return end
  local game = wakaba.G
  local room = wakaba.G:GetRoom()
  local level = wakaba.G:GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
	local type1 = room:GetType()

  if room:IsFirstVisit() and isc:inStartingRoom() then
    for i = 1, wakaba.G:GetNumPlayers() do
      local player = Isaac.GetPlayer(i - 1)
      player:AddBrokenHearts(-12)
    end
  end

end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.Challenge_NewRoom_HyperRandom)


function wakaba:Challenge_Update_HyperRandom()
	if wakaba.G.Challenge ~= c then return end
  for num = 1, wakaba.G:GetNumPlayers() do
    local player = wakaba.G:GetPlayer(num - 1)
    player:FullCharge(ActiveSlot.SLOT_PRIMARY, true)

    if player:GetActiveCharge(ActiveSlot.SLOT_POCKET) >= 900 or player:GetBatteryCharge(ActiveSlot.SLOT_POCKET) > 0 then
      local tainted
      if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
        tainted = false
      elseif player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B then
        tainted = true
      end
      TryFlipWakaba(player, tainted)
      if player:HasCollectible(CollectibleType.COLLECTIBLE_RESTOCK) then
        player:RemoveCollectible(CollectibleType.COLLECTIBLE_RESTOCK)
        player:AddCollectible(CollectibleType.COLLECTIBLE_BREAKFAST)
      end
      player:DischargeActiveItem(ActiveSlot.SLOT_POCKET)
      player:EvaluateItems()
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Challenge_Update_HyperRandom)

function wakaba:Challenge_PostTakeDamage_HyperRandom(player, amount, flag, source, countdownFrames)
	if wakaba.G.Challenge == c then
		if player:GetActiveItem() ~= wakaba.Enums.Collectibles.WAKABAS_CURFEW and player:GetActiveItem() ~= wakaba.Enums.Collectibles.WAKABAS_CURFEW2 then
			player:SetPocketActiveItem(wakaba.Enums.Collectibles.WAKABAS_CURFEW, ActiveSlot.SLOT_POCKET, true)
		end
		player:FullCharge(ActiveSlot.SLOT_POCKET, true)
		player:AddBrokenHearts(-1)
	end
end

wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.Challenge_PostTakeDamage_HyperRandom)

function wakaba:PreUseItem_NoGenesis(item, rng, player, flag, slot, varData)
	if wakaba.G.Challenge == c and player:GetActiveItem(slot) ~= item then
		if isc:collectibleHasTag(item, ItemConfig.TAG_NO_CANTRIP) or wakaba.ChallengeParams.HyperRandomBlacklisted[item] then
      return true
    end
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.PreUseItem_NoGenesis)