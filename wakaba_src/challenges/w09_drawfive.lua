
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_DRAW

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_DrawFive(player)
	if wakaba.G.Challenge ~= c then return end
  player:AddCollectible(wakaba.Enums.Collectibles.UNIFORM)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_DrawFive)