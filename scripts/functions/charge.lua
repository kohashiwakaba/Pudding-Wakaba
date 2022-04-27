wakaba.debugCharge = {
  Profile = "LunarGauge",
  IncludeFinishAnim = true,
  Sprite = wakaba.sprites.debugChargeSprite,
  MaxValue = 100,
  MinValue = 0,
  CurrentValue = 0,
  Reverse = true,
}
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

function wakaba:GetMaxChargebarIndex(player)
  if not player or not player:GetData().wakaba then return 0 end
  if not player:GetData().wakaba.chargestate then return 0 end
  local s = player:GetData().wakaba.chargestate
  local max = 0
  for i, e in ipairs(s) do
    if e.Index >= max then max = e.Index end
    --print(e.Index, "e.Index")
  end
  --print(#s, max, "max")
  return max
end

function wakaba:GetChargebarXpos(chargeno)
  local targetno = chargeno % 5
  local offset = (chargeno / 5) * -16
  return offset + chargexpos[targetno]
end

function wakaba:GetChargebarYpos(chargeno)
  local targetno = chargeno % 5
  return chargeypos[targetno]
end

function wakaba:GetChargebarPos(chargeno)
  local targetno = chargeno % 5
  targetno = targetno == 0 and 5 or targetno
  local offset = (((chargeno - 1) // 5) * -16) - 16
  return Vector(offset + chargexpos[targetno], chargeypos[targetno])
end

function wakaba:RemoveDuplicateChargebars(player, chargeprofile)
  if not player or not player:GetData().wakaba then return -1 end
  if not player:GetData().wakaba.chargestate then
    return 1 
  elseif chargeprofile then
    local fixed = 0
    for i, e in ipairs(player:GetData().wakaba.chargestate) do
      if e.Profile == chargeprofile then
        if fixed == 0 then
          fixed = e.Index
        else
          wakaba:RemoveChargeBarData(player, i)
        end
      end
    end
  end
end

function wakaba:GetChargeBarIndex(player, chargeprofile)
  if not player or not player:GetData().wakaba then return -1 end
  if not player:GetData().wakaba.chargestate then
    return 1 
  elseif chargeprofile then
    for i, e in ipairs(player:GetData().wakaba.chargestate) do
      if e.Profile == chargeprofile then
        wakaba:RemoveDuplicateChargebars(player, chargeprofile)
        return e.Index
      end
    end
    --print(#player:GetData().wakaba.chargestate, wakaba:GetMaxChargebarIndex(player))
    for i = 1, wakaba:GetMaxChargebarIndex(player) do
      if not player:GetData().wakaba.chargestate[i] then
        return i
      end
    end
    return wakaba:GetMaxChargebarIndex(player) + 1
  else
    for i = 1, wakaba:GetMaxChargebarIndex(player) do
      if not player:GetData().wakaba.chargestate[i] then
        return i
      end
    end
  end
  return wakaba:GetMaxChargebarIndex(player) + 1
end

function wakaba:GetChargeState(player, chargeprofile)
  if not player or not player:GetData().wakaba then return end
  if not player:GetData().wakaba.chargestate or not chargeprofile then
    return
  end
  for i, e in ipairs(player:GetData().wakaba.chargestate) do
    if e.Profile == chargeprofile then
      return e
    end
  end
end

function wakaba:SetChargeBarData(player, chargeno, chargestate)
  if not player or not player:GetData().wakaba or not chargeno or not chargestate then return end
  player:GetData().wakaba.chargestate = player:GetData().wakaba.chargestate or {}
  player:GetData().wakaba.chargestate[chargeno] = chargestate
end

function wakaba:RemoveChargeBarData(player, chargeno)
  if not player or not player:GetData().wakaba or not chargeno then return end
  player:GetData().wakaba.chargestate = player:GetData().wakaba.chargestate or {}
  player:GetData().wakaba.chargestate[chargeno] = nil
end

function wakaba:RenderChargeBar(player, chargeno, currentvalue, minvalue, maxvalue, sprite, offset, includefinishanim, reverse, count, countprefix, countsubfix)
  if not player then return end
	wakaba:GetPlayerEntityData(player)
  if player:GetData().wakaba.chargestate[chargeno].checkremove then return end
  minvalue = minvalue or 0
  maxvalue = maxvalue or 100
  reverse = reverse or false
  includefinishanim = includefinishanim or true
  --Isaac.DebugString(currentvalue, maxvalue)
  if currentvalue and currentvalue >= maxvalue then
    if includefinishanim and sprite:GetAnimation() == "Charging" then
      --print(sprite:GetAnimation(), sprite:GetFrame(), includefinishanim)
      sprite:SetFrame("StartCharged", 0)
    elseif includefinishanim and sprite:GetAnimation() == "StartCharged" and sprite:GetFrame() < 11 then
      if player.FrameCount % 2 == 0 then
        sprite:SetFrame("StartCharged", sprite:GetFrame() + 1)
      end
    else
      sprite:SetFrame("Charged", player.FrameCount % 6)
    end
  elseif not currentvalue or currentvalue < minvalue then
    if sprite:GetAnimation() ~= "Disappear" then
      sprite:SetFrame("Disappear", 0)
    elseif sprite:GetAnimation() == "Disappear" and sprite:GetFrame() < 8 then
      sprite:SetFrame("Disappear", sprite:GetFrame() + 1)
    elseif sprite:GetAnimation() == "Disappear" and sprite:GetFrame() >= 8 then
      player:GetData().wakaba.chargestate[chargeno].checkremove = true
    else
      sprite:SetFrame("Disappear", sprite:GetFrame() + 1)
    end
  else
    if reverse then
      sprite:SetFrame("Charging", (currentvalue / maxvalue) * 100 // 1)
    else
      sprite:SetFrame("Charging", 100 - ((currentvalue / maxvalue) * 100 // 1) - 1)
    end
  end
  if Game():GetHUD():IsVisible() and Options.ChargeBars then
    local ismirror = Game():GetRoom():IsMirrorWorld()
    sprite:Update()
    sprite:Render(Isaac.WorldToScreen(player.Position) + offset + Vector(0, -10), Vector(0,0), Vector(0,0))
    if count and sprite:GetAnimation() ~= "Disappear" then
      countsubfix = countsubfix or ""
      countprefix = countprefix or ""
      local fpos = Isaac.WorldToScreen(player.Position) + offset + Vector(-1, -11) + Vector(8, -8)
      local boxwidth = 0
      local center = true
      if wakaba.state.options.leftchargebardigits then
        fpos = Isaac.WorldToScreen(player.Position) + offset + Vector(-16, -11) + Vector(8, -8)
        boxwidth = 1
        center = false
      end
      wakaba.cf:DrawStringScaledUTF8(countprefix .. count .. countsubfix, fpos.X, fpos.Y, 1.0, 1.0, KColor(1,1,1,1.0,0,0,0), boxwidth ,center)
    end
  end
end

--[[ 
function wakaba:RenderChargeBar(player, chargeno, currentvalue, minvalue, maxvalue, sprite, offset, includefinishanim, reverse, count, countprefix, countsubfix)
  if not player or not sprite then return end
	wakaba:GetPlayerEntityData(player)
  if player:GetData().wakaba.chargestate[chargeno].checkremove then return end
  minvalue = minvalue or 0
  maxvalue = maxvalue or 100
  reverse = reverse or false
  includefinishanim = includefinishanim or true
  --Isaac.DebugString(currentvalue, maxvalue)
  if currentvalue and currentvalue >= maxvalue then
    if includefinishanim and sprite:IsPlaying("Charging") then
      sprite:Play("StartCharged")
    elseif includefinishanim and sprite:IsPlaying("Charging") and not sprite:IsFinished("StartCharged") then
      sprite:Play("StartCharged", false)
    else
      sprite:Play("Charged")
    end
    sprite:Update()
  elseif not currentvalue or currentvalue < minvalue then
    --print("Disappear 1")
    if sprite:IsPlaying("Disappear") and sprite:IsFinished("Disappear") then
      --print("Disappear fin")
      player:GetData().wakaba.chargestate[chargeno].checkremove = true
      --wakaba:RemoveChargeBarData(player, chargeno)
      return
    elseif not sprite:IsPlaying("Disappear") and not player:GetData().wakaba.chargestate[chargeno].checkremove then
      --print("Disappear fin 2")
      sprite:Play("Disappear")
      sprite:Update()
    else
      --print("Disappear fin 3")
      sprite:Play("Disappear", false)
      sprite:Update()
    end
  else
    if reverse then
      sprite:SetFrame("Charging", (currentvalue / maxvalue) * 100 // 1)
    else
      sprite:SetFrame("Charging", 100 - ((currentvalue / maxvalue) * 100 // 1))
    end
    sprite:Update()
  end
  if Game():GetHUD():IsVisible() and Options.ChargeBars then
    sprite:Render(Isaac.WorldToScreen(player.Position) + offset - Game().ScreenShakeOffset + Vector(0, -10), Vector(0,0), Vector(0,0))
    if count and sprite:GetAnimation() ~= "Disappear" then
      countsubfix = countsubfix or ""
      countprefix = countprefix or ""
      local fpos = Isaac.WorldToScreen(player.Position) + offset - Game().ScreenShakeOffset + Vector(0, -10) + Vector(8, -8)
      wakaba.cf:DrawStringScaledUTF8(countprefix .. count .. countsubfix, fpos.X, fpos.Y, 1.0, 1.0, KColor(1,1,1,1.0,0,0,0),0,true)
    end
  end
end ]]

function wakaba:PlayerRender_ChargeBar(player)
  if Game():GetRoom():GetRenderMode() == RenderMode.RENDER_WATER_REFLECT then return end
	wakaba:GetPlayerEntityData(player)
	local chargestate = player:GetData().wakaba.chargestate
  if chargestate and #chargestate > 0 then
    for i, e in ipairs(chargestate) do
      if e then
        local c = e
        wakaba:RenderChargeBar(player, c.Index, c.CurrentValue, c.MinValue, c.MaxValue, c.Sprite, wakaba:GetChargebarPos(i), c.IncludeFinishAnim, c.Reverse, c.Count, c.CountPrefix, c.CountSubfix)
      end
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.PlayerRender_ChargeBar)




function wakaba:AddDebugCharge(profileName, currentvalue)
  local player = Isaac.GetPlayer()
  local chargestate = wakaba.debugCharge
  local chargeno = wakaba:GetChargeBarIndex(Isaac.GetPlayer(), profileName)
  chargestate.Profile = profileName
  chargestate.CurrentValue = currentvalue
  wakaba.sprites["profileName"] = Sprite()
  wakaba.sprites["profileName"]:Load("gfx/chargebar_lunarstone.anm2", true)
  wakaba.sprites["profileName"].Color = Color(1,1,1,1)
  chargestate.Sprite = wakaba.sprites["profileName"]
  wakaba:SetChargeBarData(player, chargeno, chargestate)
end

function wakaba:TestDebugCharge(count)
  count = count or 1
  for i = 1, count do
    wakaba:AddDebugCharge("Debug" .. i, Random() % 100)
  end
end


function wakaba:ChargeOn(bool)
  if bool ~= false then
    wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.TestDebugChargeRender)
  else
    wakaba:RemoveCallback(ModCallbacks.MC_POST_RENDER, wakaba.TestDebugChargeRender)
  end
end

function wakaba:TestDebugChargeRender()
  for s = 0, Game():GetNumPlayers() - 1 do
    local player = Isaac.GetPlayer(s)
	  wakaba:GetPlayerEntityData(player)
	  local chargestate = player:GetData().wakaba.chargestate
    if chargestate and #chargestate > 0 then
      for i, e in ipairs(chargestate) do
        if e then
          local fpos = Vector(200 + (50 * s), 60 + (8 * i)) - Game().ScreenShakeOffset + Vector(0, -10) + Vector(8, -8)
          wakaba.cf:DrawStringScaledUTF8("x" .. e.Index .. " - " .. e.Profile, fpos.X, fpos.Y, 1.0, 1.0, KColor(1,1,1,1.0,0,0,0),0,true)
          --wakaba:RenderChargeBar(player, i, c.CurrentValue, c.MinValue, c.MaxValue, c.Sprite, wakaba:GetChargebarPos(i), c.IncludeFinishAnim, c.Reverse, c.Count)
        end
      end
    end
  end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.TestDebugChargeRender)

-- for backup purposes
--[[ 
function wakaba:RenderChargeBar(player, chargeno, currentvalue, minvalue, maxvalue, sprite, offset, includefinishanim, reverse, count, countprefix, countsubfix)
  if not player then return end
	wakaba:GetPlayerEntityData(player)
  if player:GetData().wakaba.chargestate[chargeno].checkremove then return end
  minvalue = minvalue or 0
  maxvalue = maxvalue or 100
  reverse = reverse or false
  includefinishanim = includefinishanim or true
  --Isaac.DebugString(currentvalue, maxvalue)
  if currentvalue and currentvalue >= maxvalue then
    if includefinishanim and sprite:GetAnimation() == "Charging" then
      --print(sprite:GetAnimation(), sprite:GetFrame(), includefinishanim)
      sprite:SetFrame("StartCharged", 0)
    elseif includefinishanim and sprite:GetAnimation() == "StartCharged" and sprite:GetFrame() < 11 then
      if player.FrameCount % 2 == 0 then
        sprite:SetFrame("StartCharged", sprite:GetFrame() + 1)
      end
    else
      sprite:SetFrame("Charged", player.FrameCount % 6)
    end
  elseif not currentvalue or currentvalue < minvalue then
    if sprite:GetAnimation() ~= "Disappear" then
      sprite:SetFrame("Disappear", 0)
    elseif sprite:GetAnimation() == "Disappear" and sprite:GetFrame() < 8 then
      sprite:SetFrame("Disappear", sprite:GetFrame() + 1)
    elseif sprite:GetAnimation() == "Disappear" and sprite:GetFrame() >= 8 then
      player:GetData().wakaba.chargestate[chargeno].checkremove = true
    else
      sprite:SetFrame("Disappear", sprite:GetFrame() + 1)
    end
  else
    if reverse then
      sprite:SetFrame("Charging", (currentvalue / maxvalue) * 100 // 1)
    else
      sprite:SetFrame("Charging", 100 - ((currentvalue / maxvalue) * 100 // 1))
    end
  end
  if Game():GetHUD():IsVisible() and Options.ChargeBars then
    sprite:Update()
    sprite:Render(Isaac.WorldToScreen(player.Position) + offset - Game().ScreenShakeOffset + Vector(0, -10), Vector(0,0), Vector(0,0))
    if count and sprite:GetAnimation() ~= "Disappear" then
      countsubfix = countsubfix or ""
      countprefix = countprefix or ""
      local fpos = Isaac.WorldToScreen(player.Position) + offset - Game().ScreenShakeOffset + Vector(0, -10) + Vector(8, -8)
      wakaba.cf:DrawStringScaledUTF8(countprefix .. count .. countsubfix, fpos.X, fpos.Y, 1.0, 1.0, KColor(1,1,1,1.0,0,0,0),0,true)
    end
  end
end
 ]]