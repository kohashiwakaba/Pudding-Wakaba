
local isc = require("wakaba_src.libs.isaacscript-common")

wakaba.playerstats.WAKABA_T = { 
	DAMAGE_MULTI = 0.5,
	DAMAGE_FLAT = 3.5,
	FIRERATE_MULTI = 0.6,
	HEALTH_RED = 2,
	HEALTH_SOUL = 2,
	HEALTH_BROKEN = 6,
}

local function AddInvisibleWispEffect(player, collectible)
  if player:GetCollectibleNum(collectible) < 1 then
		Epiphany.DIW_Add(player, collectible)
	end
  if player:GetCollectibleNum(collectible) == 1 then
		player:RemoveCostume(Epiphany.config:GetCollectible(collectible))
	end
end

function wakaba:Update_CheckTRWakabaAbilities()
  if not Epiphany or not Epiphany.API then return end
  local num_players = Game():GetNumPlayers()
	for i=0,(num_players-1) do
    local player = Isaac.GetPlayer(i)
    if player:GetPlayerType() == wakaba.Enums.Players.WAKABA_T then
    	AddInvisibleWispEffect(player, CollectibleType.COLLECTIBLE_DUALITY)
    	AddInvisibleWispEffect(player, wakaba.Enums.Collectibles.WAKABA_DUALITY)
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_CheckTRWakabaAbilities)

local function SauceLazerAnim(_,player)
  if not Epiphany or not Epiphany.API then return end
  if player:GetPlayerType() ~= wakaba.Enums.Players.WAKABA_T then return end

  local controllerIndex = GetPlayerNumber(player)
  
  if Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, controllerIndex)
  or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, controllerIndex)
  or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, controllerIndex)
  or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, controllerIndex) then
    player.HeadFrameDelay = 30
  end

end
--Mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, SauceLazerAnim)

-- Pause Screen Completion Marks API
--[[ PauseScreenCompletionMarksAPI:AddModCharacterCallback(wakaba.Enums.Players.WAKABA_B, function()
	local wakabaCompletionTable = {
		["MOMSHEART"] = wakaba.state.unlock.taintedwakabamomsheart,
		["ISAAC"] = wakaba.state.unlock.bookofforgotten1,
		["SATAN"] = wakaba.state.unlock.bookofforgotten2,
		["BLUEBABY"] = wakaba.state.unlock.bookofforgotten3,
		["LAMB"] = wakaba.state.unlock.bookofforgotten4,
		["BOSSRUSH"] = wakaba.state.unlock.wakabasoul1,
		["MEGASATAN"] = wakaba.state.unlock.cloverchest,
		["HUSH"] = wakaba.state.unlock.wakabasoul2,
		["DELIRIUM"] = wakaba.state.unlock.eatheart,
		["MOTHER"] = wakaba.state.unlock.bitcoin,
		["BEAST"] = wakaba.state.unlock.nemesis,
		["ULTRAGREED"] = wakaba.state.unlock.blackjoker,
	}
	return wakabaCompletionTable
end) ]]
