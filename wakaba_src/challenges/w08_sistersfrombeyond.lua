
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_SIST
local tp = wakaba.Enums.Players.WAKABA
wakaba.ChallengeParams.TargetCharacters[c] = tp

function wakaba:Challenge_PlayerUpdate_SistersFromBeyond(player)
	if wakaba.G.Challenge ~= c then return end
	wakaba.HiddenItemManager:CheckStack(player, wakaba.Enums.Collectibles.LIL_WAKABA, 1, "WAKABA_CHALLENGES")
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_SistersFromBeyond)