
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_DOPP
local tp = wakaba.Enums.Players.SHIORI
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_Doppelganger(player)
	if wakaba.G.Challenge ~= c then return end
  player:SetPocketActiveItem(wakaba.Enums.Collectibles.MICRO_DOPPELGANGER, ActiveSlot.SLOT_POCKET, true)
  player:GetData().wakaba.nextshioriflag = wakaba.Enums.Collectibles.MICRO_DOPPELGANGER
  if wakaba:Challenge_IsFirstInit(player) then
    player:UseActiveItem(wakaba.Enums.Collectibles.MICRO_DOPPELGANGER, (UseFlag.USE_NOANIM | UseFlag.USE_OWNED), -1)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_Doppelganger)

function wakaba:Challenge_PlayerUpdate_Doppelganger(player)
  if wakaba.G.Challenge ~= c then return end
  if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.Enums.Collectibles.MICRO_DOPPELGANGER then
    player:SetPocketActiveItem(wakaba.Enums.Collectibles.MICRO_DOPPELGANGER, ActiveSlot.SLOT_POCKET, true)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_Doppelganger)