
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_DELI
local tp = wakaba.Enums.Players.WAKABA
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_Delirium(player)
	if wakaba.G.Challenge ~= c then return end
  player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_STITCHES, ActiveSlot.SLOT_POCKET, true)
  if wakaba:Challenge_IsFirstInit(player) then
    player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    player:EvaluateItems()
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_Delirium)


function wakaba:Challenge_PlayerUpdate_Delirium(player)
  if wakaba.G.Challenge ~= c then return end
  if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_STITCHES then
    player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_STITCHES, ActiveSlot.SLOT_POCKET, true)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_Delirium)