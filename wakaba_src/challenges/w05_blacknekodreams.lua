
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_GUPP
local tp = wakaba.Enums.Players.WAKABA_B
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_BlackNekoDreams(player)
	if wakaba.G.Challenge ~= c then return end
  player:AddSoulHearts((REPENTOGON and 2 or 0) - player:GetSoulHearts())
  wakaba.G:GetSeeds():AddSeedEffect(SeedEffect.SEED_NO_HUD)
  wakaba.G:GetHUD():SetVisible(false)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_BlackNekoDreams)

function wakaba:Challenge_Update_BlackNekoDreams()
	if wakaba.G.Challenge ~= c then return end
  if wakaba.G:GetHUD():IsVisible() then
    wakaba.G:GetHUD():SetVisible(false)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Challenge_Update_BlackNekoDreams)