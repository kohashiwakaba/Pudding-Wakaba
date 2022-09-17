function wakaba:Cache_Hydra(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.HYDRA) then
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_POISON
		end
	end
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.Enums.Collectibles.HYDRA)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.HYDRA)
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 then
			count = player:GetCollectibleNum(wakaba.Enums.Collectibles.HYDRA) + efcount
		end
		player:CheckFamiliar(wakaba.Enums.Familiars.HYDRA_LEFT, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.HYDRA))
		player:CheckFamiliar(wakaba.Enums.Familiars.HYDRA_RIGHT, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.HYDRA))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Hydra)

function wakaba:FamiliarUpdate_Hydra(familiar)
	local data = familiar:GetData()
	data.wakaba = data.wakaba or {}
	if familiar.Player then
		local player = familiar.Player
		if player:HasCollectible(wakaba.Enums.Collectibles.HYDRA) then
			data.wakaba.nasalover = true
		else
			data.wakaba.nasalover = nil
		end
	else
		data.wakaba.nasalover = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_Hydra)

function wakaba:TearInit_Hydra(tear)
	if not tear:HasTearFlags(TearFlags.TEAR_JACOBS) and ((tear.Parent and tear.Parent:GetData().wakaba) or (tear.SpawnerEntity and tear.SpawnerEntity:GetData().wakaba)) then
		local pdata = (tear.Parent and tear.Parent:GetData())
		local sdata = (tear.SpawnerEntity and tear.SpawnerEntity:GetData())
		if (pdata and pdata.wakaba and pdata.wakaba.nasalover) or (sdata and sdata.wakaba and sdata.wakaba.nasalover) then
			tear:AddTearFlags(TearFlags.TEAR_JACOBS)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, wakaba.TearInit_Hydra)
wakaba:AddCallback(ModCallbacks.MC_POST_LASER_INIT, wakaba.TearInit_Hydra)
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_INIT, wakaba.TearInit_Hydra)
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearInit_Hydra)
wakaba:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, wakaba.TearInit_Hydra)
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, wakaba.TearInit_Hydra)


function wakaba:NPC_Hydra(puppy)
	if not puppy.SpawnerEntity or not puppy.SpawnerEntity:ToPlayer() then return end
	local player = puppy.SpawnerEntity:ToPlayer()
	if player:HasCollectible(wakaba.Enums.Collectibles.HYDRA) then
		if not puppy:HasEntityFlags(EntityFlag.FLAG_CHARM) then
			puppy:AddEntityFlags(EntityFlag.FLAG_CHARM)
		end
		if not puppy:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			puppy:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.NPC_Hydra, EntityType.ENTITY_BLOOD_PUPPY)
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPC_Hydra, EntityType.ENTITY_BLOOD_PUPPY)







