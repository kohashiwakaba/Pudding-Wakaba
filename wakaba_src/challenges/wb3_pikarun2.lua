
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_MELT
local tp = wakaba.Enums.Players.RICHER
wakaba.ChallengeParams.TargetCharacters[c] = tp

wakaba.Blacklists.Pica2 = {
  [TrinketType.TRINKET_M] = true,
  [TrinketType.TRINKET_BUTTER] = true,
  [TrinketType.TRINKET_BROKEN_REMOTE] = true,
  [TrinketType.TRINKET_BROKEN_ANKH] = true,
  [TrinketType.TRINKET_KARMA] = true,
  [TrinketType.TRINKET_NO] = true,
  [TrinketType.TRINKET_PAY_TO_WIN] = true,
  [TrinketType.TRINKET_FOUND_SOUL] = true,
  [wakaba.Enums.Trinkets.BITCOIN] = true,
  [wakaba.Enums.Trinkets.DETERMINATION_RIBBON] = true,
  [wakaba.Enums.Trinkets.SIREN_BADGE] = true,
  [wakaba.Enums.Trinkets.KUROMI_CARD] = true,
  [wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA] = true,
}

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_Melt(player)
	if wakaba.G.Challenge ~= c then return end
  player:SetPocketActiveItem(wakaba.Enums.Collectibles._3D_PRINTER, ActiveSlot.SLOT_POCKET, true)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_Melt)

function wakaba:Challenge_GameStart_Melt(continue)
	if wakaba.G.Challenge ~= c then return end
	if continue then
	else
    local pool = wakaba.G:GetItemPool()
    for k, _ in pairs(wakaba.Blacklists.Pica2) do
      pool:RemoveTrinket(k)
    end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.Challenge_GameStart_Melt)

---@param player EntityPlayer
function wakaba:Challenge_PlayerUpdate_Melt(player)
  if wakaba.G.Challenge ~= c then return end
  wakaba.HiddenItemManager:CheckStack(player, wakaba.Enums.Collectibles.MAID_DUET, 1, "WAKABA_CHALLENGES")
  if not REPENTOGON then
		player:SetActiveCharge(12, ActiveSlot.SLOT_PRIMARY)
  end
  local c = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.MAID_DUET)
  if c >= 8 then
    player:GetEffects():RemoveCollectibleEffect(wakaba.Enums.Collectibles.MAID_DUET, -1)
    player:UseActiveItem(CollectibleType.COLLECTIBLE_MOMS_BOX, UseFlag.USE_OWNED)
  end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_Melt)

if REPENTOGON then
  wakaba:AddPriorityCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MAX_CHARGE, 0, function(_, itemID, player, varData)
    if wakaba.G.Challenge == c then
      return 0
    end
  end, CollectibleType.COLLECTIBLE_SMELTER)
end

wakaba:AddPriorityCallback(wakaba.Callback.PRE_RABBIT_RIBBON_CHARGE, -20000, function(_, player)
  if wakaba.G.Challenge == c then
		return true
  end
end)

wakaba:AddCallback(wakaba.Callback.EVALUATE_MAID_DUET, function(_, player)
	if wakaba.G.Challenge == c then
		return true
	end
end)

function wakaba:Challenge_PreReroll_Melt(itemPoolType, decrease, seed)
	if wakaba.G.Challenge == c then
		return CollectibleType.COLLECTIBLE_BELLY_BUTTON
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, -18000, wakaba.Challenge_PreReroll_Melt)

function wakaba:Challenge_RoomClear_Melt()
  if wakaba.G.Challenge ~= c then return end
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
    local c = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.MAID_DUET)
    wakaba:scheduleForUpdate(function()
      player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.MAID_DUET, false, c+1)
    end, 1)
	end)
end
wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, CallbackPriority.IMPORTANT, wakaba.Challenge_RoomClear_Melt)


function wakaba:Challenge_PickupInit_Melt(pickup)
  if wakaba.G.Challenge ~= c then return end
  pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, 0, true, true, false)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.Challenge_PickupInit_Melt, PickupVariant.PICKUP_TAROTCARD)
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.Challenge_PickupInit_Melt, PickupVariant.PICKUP_PILL)

---@param pickup EntityPickup
function wakaba:Challenge_PickupUpdate_Melt(pickup)
  if wakaba.G.Challenge ~= c then return end
  if not pickup:HasEntityFlags(EntityFlag.FLAG_PERSISTENT) then
    pickup:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.Challenge_PickupUpdate_Melt, PickupVariant.PICKUP_TRINKET)