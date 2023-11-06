local alwayseraser = 0 -- 0 : default, 1 : always, -1 : never

function wakaba:update28()
	newplumcount = 0
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.EXECUTIONER) then
			trycount = true
		else
			trycount = false
		end
  end
	local hasnonboss = false
	local hasboss = false
	local hasdogma = false
	if trycount and Isaac.CountEnemies() > 0 then
		local entities = Isaac.FindInRadius(wakaba.G:GetRoom():GetCenterPos(), 2000, EntityPartition.ENEMY)
		for i, e in ipairs(entities) do
			if e.Type == EntityType.ENTITY_DOGMA 
			or e.Type == EntityType.ENTITY_VISAGE
			or e.Type == EntityType.ENTITY_MOTHER -- Erasing Dogma, Visage, Mother can cause softlock
			or e.Type == EntityType.ENTITY_MOMS_HEART -- Erasing Mom's heart will NOT give access to Corpse
			then
				hasdogma = true
			end
			if not hasdogma and e:IsVulnerableEnemy() and not e:IsBoss() then
				hasnonboss = true
			elseif not hasdogma and e:IsBoss() then
				hasboss = true
			end
		end
		--print("hasnonboss ",hasnonboss," hasboss ",hasboss," hasdogma ",hasdogma)
	end
	if hasdogma then
		alwayseraser = -1
	elseif not hasnonboss and hasboss then
		alwayseraser = 1
	else
		alwayseraser = 0
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.update28)
--LagCheck

--TearVariant.ERASER
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, function(_, tear)
	if tear ~= nil 
	and tear.SpawnerEntity ~= nil
	and tear.SpawnerEntity:ToPlayer() ~= nil 
	and tear.SpawnerEntity:ToPlayer():HasCollectible(wakaba.Enums.Collectibles.EXECUTIONER) then
		local spawner = tear.SpawnerEntity:ToPlayer()
		local rng = spawner:GetCollectibleRNG(wakaba.Enums.Collectibles.EXECUTIONER)
		local luck = (spawner.Luck) * spawner:GetCollectibleNum(wakaba.Enums.Collectibles.EXECUTIONER, false)
		local negativeLuck = luck
		if luck < 0 then
			luck = 1
		end
		if negativeLuck > 199 then
			negativeLuck = 199
		end
		local rand = rng:RandomFloat() * 400 - negativeLuck
		if not hasdogma and (luck >= rand or alwayseraser == 1) then
			tear:ChangeVariant(TearVariant.ERASER)
		end
	end
end)

function wakaba:Cache_Executioner(player, cacheFlag)
	local hasitem = player:HasCollectible(wakaba.Enums.Collectibles.EXECUTIONER) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.EXECUTIONER)
	if hasitem  then
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_BACKSTAB | TearFlags.TEAR_EXTRA_GORE
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Executioner)
