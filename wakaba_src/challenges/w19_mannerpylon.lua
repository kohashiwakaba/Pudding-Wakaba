--[[
	w19 - Manner Pylon
	알트 리라, TMTRAINER 시작, We need to go Deeper 비활성화
	주기적으로 트로피 소환, 트로피 접촉 시 게임 종료
	목표 : Mom's Heart
]]

local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_MNPL
local tp = wakaba.Enums.Players.RIRA_B
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_MannerPylon(player)
	if wakaba.G.Challenge ~= c then return end
	player:RemoveCollectible(wakaba.Enums.Collectibles.RABBEY_WARD, false, ActiveSlot.SLOT_POCKET, true)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_MannerPylon)
