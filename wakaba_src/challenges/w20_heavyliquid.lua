--[[
	w19 - Heavy Liquid
	알트 리라, 비행 불가, 모든 적의 탄환이 특수 형태로 변경
	목표 : Hush
]]

local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_HVLQ
local tp = wakaba.Enums.Players.RIRA_B
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_HeavyLiquid(player)
	if wakaba.G.Challenge ~= c then return end
	player:RemoveCollectible(wakaba.Enums.Collectibles.RABBEY_WARD, false, ActiveSlot.SLOT_POCKET, true)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_HeavyLiquid)

---@param tear EntityProjectile
function wakaba:ProjectileUpdate_HeavyLiquid(tear)
	if wakaba.G.Challenge == c then
		local seed = tear.InitSeed
		local v = seed % 2
		if v == 1 then
			if not tear:HasProjectileFlags(ProjectileFlags.FIRE_WAVE) then
				tear:AddProjectileFlags(ProjectileFlags.FIRE_WAVE)
			end
		elseif v == 2 then
			if not tear:HasProjectileFlags(ProjectileFlags.FIRE_WAVE_X) then
				tear:AddProjectileFlags(ProjectileFlags.FIRE_WAVE_X)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, wakaba.ProjectileUpdate_HeavyLiquid)