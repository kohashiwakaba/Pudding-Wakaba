
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_HUSH
local tp = wakaba.Enums.Players.WAKABA
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_RushRushHush(player)
	if wakaba.G.Challenge ~= c then return end
  player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_WHITE_PONY, ActiveSlot.SLOT_POCKET, true)
  if wakaba:Challenge_IsFirstInit(player) then
    player:GetData().wakaba.ponycurrframe = wakaba.Enums.Constants.PONY_COOLDOWN
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_RushRushHush)

function wakaba:Challenge_PlayerUpdate_RushRushHush(player)
	if wakaba.G.Challenge ~= c then return end
  wakaba:GetPlayerEntityData(player)
  player:GetData().wakaba.ponycurrframe = player:GetData().wakaba.ponycurrframe or wakaba.Enums.Constants.PONY_COOLDOWN

  if player:NeedsCharge(ActiveSlot.SLOT_POCKET) then
    if player:GetData().wakaba.ponycurrframe > 0 then
      player:GetData().wakaba.ponycurrframe = player:GetData().wakaba.ponycurrframe - 1
    else
      player:FullCharge(ActiveSlot.SLOT_POCKET, true)
      player:GetData().wakaba.ponycurrframe = wakaba.Enums.Constants.PONY_COOLDOWN
    end
  elseif player:GetActiveCharge(ActiveSlot.SLOT_POCKET) >= 2 then
    player:GetData().wakaba.ponycurrframe = wakaba.Enums.Constants.PONY_COOLDOWN
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.Challenge_PlayerUpdate_RushRushHush)


---@param player EntityPlayer
function wakaba:Challenge_ChargeBarUpdate_RushRushHush(player)
	if wakaba.G.Challenge ~= c then return end
  if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_WHITE_PONY then
    player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_WHITE_PONY, ActiveSlot.SLOT_POCKET, true)
  end
  if not wakaba:getRoundChargeBar(player, "RushPony") then
    local sprite = Sprite()
    sprite:Load("gfx/chargebar_pony.anm2", true)

    wakaba:registerRoundChargeBar(player, "RushPony", {
      Sprite = sprite,
    }):UpdateSpritePercent(-1)
  end
  local chargeBar = wakaba:getRoundChargeBar(player, "RushPony")

  local current = player:GetData().wakaba.ponycurrframe or wakaba.Enums.Constants.PONY_COOLDOWN
  local count = (current // 6) / 10
  local currval = current ~= wakaba.Enums.Constants.PONY_COOLDOWN and count or -1
  local percent = 100 - (((current / wakaba.Enums.Constants.PONY_COOLDOWN) * 100) // 1)
  if currval == -1 then
    chargeBar:UpdateSpritePercent(-1)
    chargeBar:UpdateText("")
  else
    chargeBar:UpdateSpritePercent(percent)
    chargeBar:UpdateText(currval)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_ChargeBarUpdate_RushRushHush)