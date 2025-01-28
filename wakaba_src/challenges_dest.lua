--[[
  Challenge Destination Indicator from
  https://github.com/slvn/isaac-destination-indicator/blob/main/src/main.ts
]]

local isc = _wakaba.isc
wakaba.ChallengeDest = {
  initialized = false,
  baseLoc = Vector(20, 73)
}

local HushSpriteNo = 8
local DeliSpriteNo = 9
local BeastSpriteNo = 11

local destSprite = Sprite()
destSprite:Load("gfx/ui/wakaba/boss_dest.anm2", true)

local offset = 0

function wakaba:ShouldShowDest()
  return wakaba:isHush() or wakaba:isDelirium() or wakaba:isBeast()
end

local function GetOffset()
  return Options.HUDOffset * 10
end

function wakaba:GameStart_ChallengeDest(cont)
  local destFrame = 0
  if wakaba:isHush() then
    destFrame = HushSpriteNo
    destSprite:SetFrame("Destination", destFrame)
    wakaba.ChallengeDest.baseLoc = Vector(15.5, 73)
  elseif wakaba:isDelirium() then
    destFrame = DeliSpriteNo
    destSprite:SetFrame("Destination", destFrame)
    wakaba.ChallengeDest.baseLoc = Vector(15.5, 73)
  elseif wakaba:isBeast() then
    destFrame = BeastSpriteNo
    destSprite:SetFrame("Destination", destFrame)
    wakaba.ChallengeDest.baseLoc = Vector(15.5, 73)
  else
    destFrame = 12
  end
	wakaba.ChallengeDest.initialized = true
end

function wakaba:GameExit_ChallengeDest()
	wakaba.ChallengeDest.initialized = false
end

function wakaba:shouldDeHook()
	local reqs = {
		not wakaba.ChallengeDest.initialized,
		not Game():GetHUD():IsVisible(),
		Game():GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD),
    not wakaba:ShouldShowDest(),
		-- Game():IsGreedMode() //The chance should still display on Greed Mode even if its 0 for consistency with the rest of the HUD.
	}
	return reqs[1] or reqs[2] or reqs[3] or reqs[4]
end

function wakaba:Render_ChallengeDest(sn)
	if wakaba:shouldDeHook() then return end

  if true --[[ not REPENTOGON ]] then

    local isShader = sn == "wakaba_ChallengeDest_DummyShader" and true or false

    if not (wakaba.G:IsPaused() and Isaac.GetPlayer(0).ControlsEnabled) and not isShader then return end -- no render when unpaused
    if (wakaba.G:IsPaused() and Isaac.GetPlayer(0).ControlsEnabled) and isShader then return end -- no shader when paused

    if sn ~= nil and not isShader then return end -- final failsafe
  end

  if wakaba.G.Challenge == Challenge.CHALLENGE_NULL then return end

  local offset = GetOffset()
  local baseLoc = wakaba.ChallengeDest.baseLoc

  local x = baseLoc.X + 2 * offset
  local y = baseLoc.Y + 1.2 * offset

  destSprite:Render(Vector(x, y) + wakaba.G.ScreenShakeOffset, Vector(0, 0), Vector(0, 0))

end

wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.GameStart_ChallengeDest)
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.GameExit_ChallengeDest)

wakaba:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, wakaba.Render_ChallengeDest)
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_ChallengeDest)