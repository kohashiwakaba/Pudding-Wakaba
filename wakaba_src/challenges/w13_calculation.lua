
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_CALC
local tp = wakaba.Enums.Players.SHIORI_B
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_Calculation(player)
	if wakaba.G.Challenge ~= c then return end
  wakaba:scheduleForUpdate(function ()
    if player:GetSoulHearts() == 1 then -- TODO temporary fix for RGON
      player:AddSoulHearts(5)
    end
  end, 0)
  player:AddBombs(32)
  player:AddKeys(99)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_Calculation)

function wakaba:Challenge_Update_Calculation()
	if wakaba.G.Challenge ~= c then return end
  for num = 1, wakaba.G:GetNumPlayers() do
    local player = wakaba.G:GetPlayer(num - 1)
    if wakaba.killcount > 100 then
      player:Die()
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Challenge_Update_Calculation)