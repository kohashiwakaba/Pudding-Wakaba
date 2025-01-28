
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_RNPR
local tp = wakaba.Enums.Players.RICHER
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_RunawayPheromones(player)
	if wakaba.G.Challenge ~= c then return end
	player:RemoveCollectible(wakaba.Enums.Collectibles.SWEETS_CATALOG, false, ActiveSlot.SLOT_POCKET, true)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_RunawayPheromones)

---@param tear EntityProjectile
function wakaba:ProjectileUpdate_RunawayPheromones(tear)
	if wakaba.G.Challenge == c then
		if not tear:HasProjectileFlags(ProjectileFlags.LASER_SHOT) then
			tear:AddProjectileFlags(ProjectileFlags.LASER_SHOT)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, wakaba.ProjectileUpdate_RunawayPheromones)

function wakaba:Challenge_GameStart_RunawayPheromones(continue)
	if wakaba.G.Challenge ~= c then return end
	if continue then
	else
		wakaba.G:GetItemPool():RemoveCollectible(wakaba.Enums.Collectibles.CLENSING_FOAM)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.Challenge_GameStart_RunawayPheromones)

---@param npc EntityNPC
function wakaba:NPCInit_RunawayPheromones(npc)
	if wakaba.G.Challenge ~= c then return end
	if npc.Type ~= EntityType.ENTITY_FIREPLACE
	and npc:IsEnemy()
	and not npc:IsBoss()
	and not npc:HasEntityFlags(EntityFlag.FLAG_FRIENDLY)
	and npc:GetChampionColorIdx() ~= ChampionColor.PINK
	then
		npc:MakeChampion(npc.InitSeed, ChampionColor.PINK, true)
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCInit_RunawayPheromones)