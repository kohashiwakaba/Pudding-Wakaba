
local isc = require("wakaba_src.libs.isaacscript-common")

local updateSprite

local chargexpos = {
  [1] = 0,
  [2] = -7,
  [3] = -14,
  [4] = -7,
  [5] = 0,
}
local chargeypos = {
  [1] = -26,
  [2] = -13,
  [3] = 0,
  [4] = 13,
  [5] = 26,
}

local registeredWakabaChargeBar = {

}

local CHARGE_METER_ANIMATIONS = {
	NONE = "",
	CHARGING = "Charging",
	START_CHARGED = "StartCharged",
	CHARGED = "Charged",
	DISAPPEAR = "Disappear"
}

local ANIMATIONS_LAST_FRAME = {
	CHARGING = 100,
	START_CHARGED = 11,
	CHARGED = 5,
	DISAPPEAR = 8
}

---@param sprite Sprite
---@param charge integer
local function returnToCharging(sprite, charge)
	sprite:SetAnimation(CHARGE_METER_ANIMATIONS.CHARGING)
	updateSprite(sprite, charge, CHARGE_METER_ANIMATIONS.CHARGING, -1)
end

---@param sprite Sprite
---@param charge integer
local function stopCharging(sprite, charge)
	sprite:SetAnimation(CHARGE_METER_ANIMATIONS.DISAPPEAR)
	updateSprite(sprite, charge, CHARGE_METER_ANIMATIONS.DISAPPEAR, -1)
end


local updateSpriteJumpTable = {
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.NONE] = function(sprite, charge, frame)
		if charge == -1 then return end

		returnToCharging(sprite, charge)
	end,
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.CHARGING] = function(sprite, charge, frame)
		if charge == -1 then
			stopCharging(sprite, charge)
			return
		end

		if frame == ANIMATIONS_LAST_FRAME.CHARGING then
			sprite:SetAnimation(CHARGE_METER_ANIMATIONS.START_CHARGED)
			updateSprite(sprite, charge, CHARGE_METER_ANIMATIONS.START_CHARGED, -1)
			return
		end

		sprite:SetFrame(charge)
	end,
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.START_CHARGED] = function(sprite, charge, frame)
		if charge == -1 then
			stopCharging(sprite, charge)
			return
		end

		if charge ~= ANIMATIONS_LAST_FRAME.CHARGING then
			returnToCharging(sprite, charge)
			return
		end

		if frame == ANIMATIONS_LAST_FRAME.START_CHARGED then
			sprite:SetAnimation(CHARGE_METER_ANIMATIONS.CHARGED)
			updateSprite(sprite, charge, CHARGE_METER_ANIMATIONS.CHARGED, -1)
			return
		end

		sprite:SetFrame(frame + 1)
	end,
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.CHARGED] = function(sprite, charge, frame)
		if charge == -1 then
			stopCharging(sprite, charge)
			return
		end

		if charge ~= ANIMATIONS_LAST_FRAME.CHARGING then
			returnToCharging(sprite, charge)
			return
		end

		if frame == ANIMATIONS_LAST_FRAME.CHARGED then
			sprite:SetFrame(0)
			return
		end

		sprite:SetFrame(frame + 1)
	end,
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.DISAPPEAR] = function(sprite, charge, frame)
		if charge ~= -1 then
			returnToCharging(sprite, charge)
			return
		end

		if frame == ANIMATIONS_LAST_FRAME.DISAPPEAR then return end

		sprite:SetFrame(frame + 1)
	end
}

---@param sprite Sprite
---@param charge integer
---@param animation? string
---@param frame? integer
updateSprite = function(sprite, charge, animation, frame)
	animation = animation or sprite:GetAnimation()
	frame = frame or sprite:GetFrame()
	updateSpriteJumpTable[animation](sprite, charge, frame)
end

function wakaba:registerRoundChargeBar(player, chargeBarName, chargeProfile)
	local playerIndex = isc:getPlayerIndex(player)
  registeredWakabaChargeBar[playerIndex] = registeredWakabaChargeBar[playerIndex] or {}

  chargeProfile.IsDischarging = function(_)
    if not chargeProfile.Sprite then return true end
    return chargeProfile.Sprite:GetAnimation() == CHARGE_METER_ANIMATIONS.DISAPPEAR
  end

  chargeProfile.UpdateSpritePercent = function(_, chargePercent)
    updateSprite(chargeProfile.Sprite, chargePercent)
  end
  chargeProfile.UpdateSprite = function(_, currentvalue, minValue, maxValue)
    minvalue = minvalue or 0
    maxvalue = maxvalue or 100
    local chargePercent = ((currentvalue - minValue) / (maxValue - minValue) * 100) // 1
    chargePercent = (currentvalue >= maxValue) and 100 or chargePercent
    updateSprite(chargeProfile.Sprite, chargePercent)
  end
  chargeProfile.UpdateText = function(_, count, countprefix, countsubfix)
    countsubfix = countsubfix or ""
    countprefix = countprefix or ""
    chargeProfile.RenderedText = countprefix .. count .. countsubfix
  end

  registeredWakabaChargeBar[playerIndex][chargeBarName] = chargeProfile
  updateSprite(chargeProfile.Sprite, -1)
  return chargeProfile
end

function wakaba:getRegisteredRoundChargeBars(player)
	local playerIndex = isc:getPlayerIndex(player)
  return registeredWakabaChargeBar[playerIndex]
end

function wakaba:getRoundChargeBar(player, chargeBarName)
	local playerIndex = isc:getPlayerIndex(player)
  if registeredWakabaChargeBar[playerIndex] then
    return registeredWakabaChargeBar[playerIndex][chargeBarName]
  end
end

function wakaba:isRoundChargeBarPlaying(player, chargeBarName)
	local playerIndex = isc:getPlayerIndex(player)
  if not (registeredWakabaChargeBar[playerIndex] and registeredWakabaChargeBar[playerIndex][chargeBarName]) then return false end

  local chargeProfile = registeredWakabaChargeBar[playerIndex][chargeBarName]
  local sprite = chargeProfile.Sprite
  return sprite:GetAnimation() ~= CHARGE_METER_ANIMATIONS.NONE and not (sprite:GetAnimation() == CHARGE_METER_ANIMATIONS.DISAPPEAR and sprite:GetFrame() == ANIMATIONS_LAST_FRAME.DISAPPEAR)
end


function wakaba:GetChargebarPos(chargeno)
  local targetno = chargeno % 5
  targetno = targetno == 0 and 5 or targetno
  local offset = (((chargeno - 1) // 5) * -16) - 16
  return Vector(offset + chargexpos[targetno], chargeypos[targetno])
end

function wakaba:renderRoundCharge(player, chargeBarName, renderIndex)
  local chargeProfile = wakaba:getRoundChargeBar(player, chargeBarName)
  if chargeProfile.Sprite == nil then return end

  local sprite = chargeProfile.Sprite
  local offset = wakaba:GetChargebarPos(renderIndex)
  sprite:Render(Isaac.WorldToScreen(player.Position) + offset + Vector(0, -10), Vector(0,0), Vector(0,0))
  local counter = chargeProfile.RenderedText
  if counter then
    local fpos = Isaac.WorldToScreen(player.Position) + offset + Vector(-1, -11) + Vector(8, -8)
    local boxwidth = 0
    local center = true
    if wakaba.state.options.leftchargebardigits then
      fpos = Isaac.WorldToScreen(player.Position) + offset + Vector(-16, -11) + Vector(8, -8)
      boxwidth = 1
      center = false
    end
    wakaba.cf:DrawStringScaledUTF8(counter, fpos.X, fpos.Y, 1.0, 1.0, KColor(1,1,1,1.0,0,0,0), boxwidth ,center)
  end

end

function wakaba:PlayerRender_ChargeBar_Richer(player)
  if not (wakaba.G:GetHUD():IsVisible() and Options.ChargeBars) then return end
  local renderIndex = 1

	local playerIndex = isc:getPlayerIndex(player)
  local chargeBarProfiles = wakaba:getRegisteredRoundChargeBars(player)
  if not chargeBarProfiles then return end
  for chargeBarName, data in pairs(chargeBarProfiles) do
    if wakaba:isRoundChargeBarPlaying(player, chargeBarName) then
      wakaba:renderRoundCharge(player, chargeBarName, renderIndex)
      renderIndex = renderIndex + 1
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.PlayerRender_ChargeBar_Richer)