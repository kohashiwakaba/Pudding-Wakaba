
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_DRMS
local tp = wakaba.Enums.Players.WAKABA
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_TruePuristGirl(player)
	if wakaba.G.Challenge ~= c then return end
  player:SetPocketActiveItem(wakaba.Enums.Collectibles.DOUBLE_DREAMS, ActiveSlot.SLOT_POCKET, true)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_TruePuristGirl)

function wakaba:Challenge_PlayerUpdate_TruePuristGirl(player)
  if wakaba.G.Challenge ~= c then return end
  if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.Enums.Collectibles.DOUBLE_DREAMS then
    player:SetPocketActiveItem(wakaba.Enums.Collectibles.DOUBLE_DREAMS, ActiveSlot.SLOT_POCKET, true)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_TruePuristGirl)
