wakaba.COLLECTIBLE_NASA_LOVER = Isaac.GetItemIdByName("Nasa Lover")

function wakaba:Cache_NasaLover(player, cacheFlag)
	if player:HasCollectible(wakaba.COLLECTIBLE_NASA_LOVER) then
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_JACOBS
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_NasaLover)

function wakaba:FamiliarUpdate_NasaLover(familiar)
	local data = familiar:GetData()
	data.wakaba = data.wakaba or {}
	if familiar.Player then
		local player = familiar.Player
		if player:HasCollectible(wakaba.COLLECTIBLE_NASA_LOVER) then
			data.wakaba.nasalover = true
		else
			data.wakaba.nasalover = nil
		end
	else
		data.wakaba.nasalover = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_NasaLover)

function wakaba:TearInit_NasaLover(tear)
	if not tear:HasTearFlags(TearFlags.TEAR_JACOBS) and ((tear.Parent and tear.Parent:GetData().wakaba) or (tear.SpawnerEntity and tear.SpawnerEntity:GetData().wakaba)) then
		local pdata = (tear.Parent and tear.Parent:GetData())
		local sdata = (tear.SpawnerEntity and tear.SpawnerEntity:GetData())
		if (pdata and pdata.wakaba and pdata.wakaba.nasalover) or (sdata and sdata.wakaba and sdata.wakaba.nasalover) then
			tear:AddTearFlags(TearFlags.TEAR_JACOBS)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_LASER_INIT, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_INIT, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, wakaba.TearInit_NasaLover)
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, wakaba.TearInit_NasaLover)


function wakaba:NPC_NasaLover(puppy)
	if not puppy.SpawnerEntity or not puppy.SpawnerEntity:ToPlayer() then return end
	local player = puppy.SpawnerEntity:ToPlayer()
	if player:HasCollectible(wakaba.COLLECTIBLE_NASA_LOVER) then
		if not puppy:HasEntityFlags(EntityFlag.FLAG_CHARM) then
			puppy:AddEntityFlags(EntityFlag.FLAG_CHARM)
		end
		if not puppy:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			puppy:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.NPC_NasaLover, EntityType.ENTITY_BLOOD_PUPPY)
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPC_NasaLover, EntityType.ENTITY_BLOOD_PUPPY)







