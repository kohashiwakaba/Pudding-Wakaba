
function wakaba:PlayerUpdate_FireflyLighter(player)
	if player:HasCollectible(wakaba.Enums.Collectibles.FIREFLY_LIGHTER) then
		local level = wakaba.G:GetLevel()
		local currentRoomDesc = level:GetRoomByIdx(level:GetCurrentRoomIndex())
		if currentRoomDesc.NoReward then
			currentRoomDesc.NoReward = false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_FireflyLighter)

function wakaba:Cache_FireflyLighter(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.FIREFLY_LIGHTER) then
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + (1 * player:GetCollectibleNum(wakaba.Enums.Collectibles.FIREFLY_LIGHTER))
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (80 * player:GetCollectibleNum(wakaba.Enums.Collectibles.FIREFLY_LIGHTER))
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_FireflyLighter)

---@param player EntityPlayer
local function shouldApplyHoly(player)
	local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.FIREFLY_LIGHTER)
	local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.FIREFLY_LIGHTER)
	local charmBonus = wakaba:getTeardropCharmBonus(player)

	local basicChance = 0.05
	local parLuck = 9
	local maxChance = 0.5 - basicChance

	local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck + charmBonus, parLuck, maxChance), count)
	return rng:RandomFloat() < chance
end

local function spawnLightBeam(effectTarget, player)
	local beam = Isaac.Spawn(1000, EffectVariant.CRACK_THE_SKY, 1, effectTarget.Position, Vector.Zero, player):ToEffect()
	beam.Parent = player
	beam.CollisionDamage = player.Damage * 4
	beam:Update()
	return beam
end

function wakaba:EvalTearFlag_FireflyLighter(weapon, player, effectTarget, isNonWeaponEntity)
	if isNonWeaponEntity then return end
	if player:HasCollectible(wakaba.Enums.Collectibles.FIREFLY_LIGHTER) and wakaba:hasLunarStone(player) then
		if shouldApplyHoly(player) then
			if weapon then
				if weapon.Type == EntityType.ENTITY_TEAR
				or weapon.Type == EntityType.ENTITY_LASER
				or weapon.Type == EntityType.ENTITY_KNIFE
				or weapon.Type == EntityType.ENTITY_BOMB
				then
					weapon:AddTearFlags(TearFlags.TEAR_LIGHT_FROM_HEAVEN)
				else
					wakaba:AddRicherTearFlags(weapon, wakaba.TearFlag.PSEUDO_HEAVEN)
				end
			else
				spawnLightBeam(effectTarget, player)
			end
		elseif weapon and wakaba:IsLudoTear(weapon, true) then
			wakaba:ClearRicherTearFlags(weapon, wakaba.TearFlag.PSEUDO_HEAVEN)
		end
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, wakaba.EvalTearFlag_FireflyLighter)

wakaba:AddCallback(wakaba.Callback.APPLY_TEARFLAG_EFFECT, function(_, effectTarget, player, effectSource)
	if wakaba:CanApplyStatusEffect(effectTarget) then
		spawnLightBeam(effectTarget, player)
	end
end, wakaba.TearFlag.PSEUDO_HEAVEN)

---@param npc EntityNPC
function wakaba:NPCUpdate_FireflyLighter(npc)
	if not wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.FIREFLY_LIGHTER) then return end
	if npc:HasEntityFlags(EntityFlag.FLAG_NO_REWARD) then
		npc:ClearEntityFlags(EntityFlag.FLAG_NO_REWARD)
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCUpdate_FireflyLighter)