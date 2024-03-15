
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_SSRC
local tp = wakaba.Enums.Players.RICHER_B
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_SensitiveRicher(player)
	if wakaba.G.Challenge ~= c then return end
  if wakaba:Challenge_IsFirstInit(player) then
    wakaba:scheduleForUpdate(function ()
      if player:GetSoulHearts() == 1 then -- TODO temporary fix for RGON
        player:AddSoulHearts(5)
      end
    end, 0)
    wakaba:scheduleForUpdate(function ()
      player:GetData().wakaba.flamecnt = wakaba.Enums.Constants.SSRC_ALLOW_FLAMES
    end, 1)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_SensitiveRicher)


function wakaba:Challenge_PlayerUpdate_SensitiveRicher(player)
  if wakaba.G.Challenge ~= c then return end
  wakaba:GetPlayerEntityData(player)
  if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.Enums.Collectibles.WATER_FLAME then
    player:SetPocketActiveItem(wakaba.Enums.Collectibles.WATER_FLAME, ActiveSlot.SLOT_POCKET, true)
  end
  if player:GetData().wakaba and player:GetData().wakaba.flamecnt and player:GetData().wakaba.flamecnt > 0 then
    player:SetActiveCharge(200000, ActiveSlot.SLOT_POCKET)
  else
    player:SetActiveCharge(0, ActiveSlot.SLOT_POCKET)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_SensitiveRicher)