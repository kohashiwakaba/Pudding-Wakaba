
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_ELEC
local tp = wakaba.Enums.Players.WAKABA
wakaba.ChallengeParams.TargetCharacters[c] = tp

function wakaba:Challenge_PlayerUpdate_ElectricDisorder(player)
	if wakaba.G.Challenge ~= c then return end
	wakaba.HiddenItemManager:CheckStack(player, wakaba.Enums.Collectibles.EYE_OF_CLOCK, 1, "WAKABA_CHALLENGES")
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_ElectricDisorder)

function wakaba:Challenge_Cache_ElectricDisorder(player, cacheFlag)
	if wakaba.G.Challenge ~= c then return end
	if cacheFlag == CacheFlag.CACHE_SPEED then
		player.MoveSpeed = player.MoveSpeed * 3
	end
	if cacheFlag == CacheFlag.CACHE_FIREDELAY then
		local fDelay = player.FireDelay * 2
		local fDelayMax = player.MaxFireDelay * 2
		player.FireDelay = math.floor(fDelay+0.5)
		player.MaxFireDelay = math.floor(fDelayMax+0.5)
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Challenge_Cache_ElectricDisorder)