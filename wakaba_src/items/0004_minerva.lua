wakaba.fcount = 0
wakaba.killcount = 0
local isc = require("wakaba_src.libs.isaacscript-common")

local auraDatas = {}

function wakaba:hasAura(player)
	if not player then 
		return false 
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) then
    return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.MINERVA_AURA) then
		return true
	elseif player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.MINERVA_AURA) then
		return true
	elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
		return true
	else
		return false
	end
end

function wakaba:auraCount(player)
	if not player then 
		return 0 
	end
	local count = 0
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) then
    count = count + 1
	end
	if player:HasCollectible(wakaba.Enums.Collectibles.MINERVA_AURA) then
		count = count + player:GetCollectibleNum(wakaba.Enums.Collectibles.MINERVA_AURA)
	end
	if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.MINERVA_AURA) then
		count = count + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.MINERVA_AURA)
	end
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
    count = count + 1
	end
	return count
end

function wakaba:initAura(player)
	local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALLOWED_GROUND, -1, player.Position, Vector.Zero, player):ToEffect()
	aura:AddEntityFlags(EntityFlag.FLAG_DONT_OVERWRITE)
	aura.Timeout = 108000000
	aura.LifeSpan = 108000000
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
		local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
		if #entities > 0 and wakaba.G:GetLevel():GetCurrentRoomIndex() ~= wakaba.G:GetLevel():GetStartingRoomIndex() then
			for i, e in ipairs(entities) do
				aura.Parent = e
				aura.Position = e.Position
				aura:FollowParent(e)
			end
		else
			aura:FollowParent(player)
			aura.Parent = player
		end
	else
		aura:FollowParent(player)
		aura.Parent = player
	end
	aura:GetData().wakaba = "minerva"
	aura:GetData().link = EntityRef(player)
	--aura:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
	wakaba:GetPlayerEntityData(player)
	local playerIndex = isc:getPlayerIndex(player)
	auraDatas[playerIndex] = auraDatas[playerIndex] or {}
	auraDatas[playerIndex].AuraEntity = aura
	auraDatas[playerIndex].Ref = EntityRef(aura)
	return aura
end

function wakaba:checkAura(playerno)
	local player = Isaac.GetPlayer(playerno)
	if not player:GetData().wakaba or not player:GetData().wakaba.aura then
		--print("No Aura!")
		return
	end
	local aura = player:GetData().wakaba.aura.Entity
	if aura then
		--print(aura:GetData().wakaba)
		return
	end
end

function wakaba:NewRoom_Minerva()
	auraDatas = {}
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if wakaba:hasAura(player) and not wakaba:checkAura(i - 1) then
			local aura = wakaba:initAura(player)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Minerva)

function wakaba:EffectUpdate_Minerva(effect)
	local data = effect:GetData()
	local wdata = data.wakaba
	if not wdata then return end
	if not wdata == "minerva" then return end
	if not effect.Parent then return end
	local psti = wakaba:getstoredindex(effect.Parent:ToPlayer())
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
		psti = 1
	end
	effect.Timeout = 108000000
	effect.LifeSpan = 108000000
	--effect:FollowParent(effect.Parent)
	for _, ent in ipairs(Isaac.FindInRadius(effect.Position, 88, EntityPartition.FAMILIAR)) do
		if ent.HitPoints < (ent.MaxHitPoints * 2) then
			ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 1, 1, true, false)
			ent.HitPoints = ent.HitPoints + (ent.MaxHitPoints * 0.04)
			if ent.HitPoints > (ent.MaxHitPoints * 2) then
				ent.HitPoints = (ent.MaxHitPoints * 2)
			end
		else
			ent:SetColor(Color(1, 1, 1, 1, 0.2, 0.4, 0.1), 1, 1, true, false)
		end
	end
	for _, ent in ipairs(Isaac.FindInRadius(effect.Position, 88, EntityPartition.ENEMY)) do
		if ent:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			--ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 1, 1, true, false)
			if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then 
				if ent.HitPoints < (ent.MaxHitPoints * 2) then
					ent.HitPoints = ent.HitPoints + (ent.MaxHitPoints * 0.04)
					if ent.HitPoints > (ent.MaxHitPoints * 2) then
						ent.HitPoints = (ent.MaxHitPoints * 2)
					end
				else
				end
			elseif effect.Parent:ToPlayer() ~= nil
			and effect.Parent:ToPlayer():GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) 
			and effect.Parent:ToPlayer():HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			then
				if ent.HitPoints < (ent.MaxHitPoints * 3) then
					ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 1, 1, true, false)
					ent.HitPoints = ent.HitPoints + (ent.MaxHitPoints * 0.32)
					if ent.HitPoints > (ent.MaxHitPoints * 3) then
						ent.HitPoints = (ent.MaxHitPoints * 3)
					end
				else
					ent:SetColor(Color(1, 1, 1, 1, 0.2, 0.4, 0.1), 1, 1, true, false)
				end
			else
				if ent.HitPoints < (ent.MaxHitPoints * 2) then
					ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 1, 1, true, false)
					ent.HitPoints = ent.HitPoints + (ent.MaxHitPoints * 0.04)
					if ent.HitPoints > (ent.MaxHitPoints * 2) then
						ent.HitPoints = (ent.MaxHitPoints * 2)
					end
				else
					ent:SetColor(Color(1, 1, 1, 1, 0.2, 0.4, 0.1), 1, 1, true, false)
				end
			end
		end
	end
	
  --[[ for i = 1, wakaba.G:GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		
		pl:GetData().wakaba = pl:GetData().wakaba or {}
		pl:GetData().wakaba.minervalevel = 1
	end ]]

	--88 for radius
	for i, ent in ipairs(Isaac.FindInRadius(effect.Position, 2000, EntityPartition.PLAYER)) do
		local distance = math.sqrt(((effect.Position.X - ent.Position.X) ^ 2) + ((effect.Position.Y - ent.Position.Y) ^ 2))
		ent:GetData().wakaba = ent:GetData().wakaba or {}
		ent:GetData().wakaba.minervalevel = ent:GetData().wakaba.minervalevel or {}
		ent:GetData().wakaba.minervalevel[psti] = ent:GetData().wakaba.minervalevel[psti] or {}
		local sti = wakaba:getstoredindex(ent:ToPlayer())

		--print(ent:ToPlayer():GetName(), effect.Parent:ToPlayer().ControllerIndex , ent:ToPlayer().ControllerIndex, effect.Parent:ToPlayer().ControllerIndex == ent:ToPlayer().ControllerIndex)
		if (effect.Parent ~= nil and effect.Parent:ToPlayer() ~= nil) or wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
			if  wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_BIKE
			and GetPtrHash(effect.Parent:ToPlayer()) == GetPtrHash(ent:ToPlayer())
			and (effect.Parent:ToPlayer():GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) 
			and not effect.Parent:ToPlayer():HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT))
			then
				ent:GetData().wakaba.minervalevel[psti][sti] = 0
				--ent:GetData().wakaba.minervacount = 0
			elseif distance <= 88 then
				if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
					ent:GetData().wakaba.insideminerva = true
					ent:GetData().wakaba.minervacount = 5
					if (ent:ToPlayer() and not ent:ToPlayer():GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_CAMO_UNDIES)) then
						ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
					end
				else
					ent:GetData().wakaba.minervalevel[psti][sti] = wakaba:auraCount(effect.Parent:ToPlayer())
					ent:GetData().wakaba.insideminerva = true
					if effect.Parent:ToPlayer() ~= nil
					and effect.Parent:ToPlayer():GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) 
					and effect.Parent:ToPlayer():HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
					then
						ent:GetData().wakaba.minervacount = 7
						ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
						if (ent:ToPlayer() and not ent:ToPlayer():GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_CAMO_UNDIES)) then
							ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
						end
					else
						ent:GetData().wakaba.minervacount = 5
						ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
						if (ent:ToPlayer() and not ent:ToPlayer():GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_CAMO_UNDIES)) then
							ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
						end
					end
				end
			else
				ent:GetData().wakaba.minervalevel[psti][sti] = 0
				ent:GetData().wakaba.insideminerva = false
			end
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_Minerva, EffectVariant.HALLOWED_GROUND)

function wakaba:PlayerUpdate_Minerva(player)
	local playerIndex = isc:getPlayerIndex(player)
	auraDatas[playerIndex] = auraDatas[playerIndex] or {}
	auraDatas[playerIndex].Ref = EntityRef(aura)

	if not player:GetData().wakaba then return end
	if wakaba:hasAura(player) and not (auraDatas[playerIndex] and auraDatas[playerIndex].AuraEntity and auraDatas[playerIndex].AuraEntity:Exists()) then
		local aura = wakaba:initAura(player)
	end
	
	player:GetData().wakaba.minervacount = player:GetData().wakaba.minervacount or 0
	player:GetData().wakaba.hasminerva = player:GetData().wakaba.hasminerva or 0
	player:GetData().wakaba.minervalevel = player:GetData().wakaba.minervalevel or {}
	player:GetData().wakaba.minervadmgprotect = player:GetData().wakaba.minervadmgprotect or 0
	--local minervacount = player:GetData().wakaba.minervacount
	--local hasminerva = player:GetData().wakaba.hasminerva
	if player:GetData().wakaba.minervacount > 0 then
		player:GetData().wakaba.minervacount = player:GetData().wakaba.minervacount - 1
	end
	--[[ for i = 1, wakaba.runstate.storedplayers do
		player:GetData().wakaba.minervalevel[i] = player:GetData().wakaba.minervalevel[i] or {}
		for s = 1, wakaba.runstate.storedplayers do
			if player:GetData().wakaba.minervalevel[i][s] ~= nil and player:GetData().wakaba.minervalevel[i][s] > 0 then
				player:GetData().wakaba.minervalevel[i][s] = player:GetData().wakaba.minervalevel[i][s] - 1
			end
		end
	end ]]
	if player:GetData().wakaba.minervadmgprotect > 0 then
		player:GetData().wakaba.minervadmgprotect = player:GetData().wakaba.minervadmgprotect - 1
	end
	if player:GetData().wakaba.hasminerva == 0 and player:GetData().wakaba.minervacount > 0 then
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
		player:GetData().wakaba.hasminerva = 1
	elseif player:GetData().wakaba.minervacount <= 0 and player:GetData().wakaba.hasminerva == 1 then
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
		player:GetData().wakaba.hasminerva = 0
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Minerva)
--[[ 
function wakaba:TestRender_Minerva()
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		local minervalevel = 0
		for i = 1, wakaba.runstate.storedplayers do
			if player:GetData().wakaba and player:GetData().wakaba.minervalevel then
				local ti = player:GetData().wakaba.minervalevel[i]
				if ti ~= nil then
					for s = 1, wakaba.runstate.storedplayers do
						local ts = player:GetData().wakaba.minervalevel[i][s]
						if ts == nil then
							ts = 0
						end
						minervalevel = minervalevel + ts
						wakaba.f:DrawStringScaledUTF8(ts, Isaac.WorldToScreen(player.Position).X + (i * 10), Isaac.WorldToScreen(player.Position).Y + (s * 10), 1, 1, KColor(1,1,1,1,0,0,0),0,true)
					end
				end
			end
		end
		wakaba.f:DrawStringScaledUTF8((i - 1) .. "+" .. minervalevel, Isaac.WorldToScreen(player.Position).X, Isaac.WorldToScreen(player.Position).Y, 1, 1, KColor(1,1,1,1,0,0,0),0,true)
	end

end ]]
--wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.TestRender_Minerva)

function wakaba:Cache_Minerva(player, cacheFlag)
	if not player:GetData().wakaba then return end
	
	local sti = wakaba:getstoredindex(player)
	player:GetData().wakaba.minervacount = player:GetData().wakaba.minervacount or 0 -- for birthright check
	local minervalevel = 0
	local mt = player:GetData().wakaba.minervalevel or {} -- for duplication check
	if sti ~= nil then
		for s = 1, wakaba.runstate.storedplayers do
			if mt[s] ~= nil and mt[s][sti] ~= nil then
				minervalevel = minervalevel + mt[s][sti]
			end
		end
	end
	--print(minervalevel)
	if player:GetData().wakaba.minervacount > 0 then
		local additional = 0
		if player:GetData().wakaba.minervacount > 5 then
			additional = wakaba.fcount
		end
    if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
      player.MoveSpeed = player.MoveSpeed + (minervalevel * additional * 0.006)
    end
    if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
      player.Luck = player.Luck + (minervalevel * additional * 0.1)
    end
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + (1.5 * minervalevel) + (additional * 0.03)
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (60 * minervalevel) + (additional * 0.5)
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			for i = 1, minervalevel do
				player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 2.0)
			end
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (additional * 0.005))
		end
		if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed - 0.08
		end
    if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
        player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING
    end
    if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
        player.TearColor = Color(1, 1, 1, 1, 0.4, 0.1, 0.2)
    end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_Minerva)

function wakaba:Update_Minerva()
	wakaba.fcount = 0
	wakaba.killcount = 0
	local entities = Isaac.FindInRadius(wakaba.GetGridCenter(), 2000, EntityPartition.ENEMY)
	for _, entity in ipairs(entities) do
		if wakaba.runstate.hasnemesis and not entity:HasEntityFlags(EntityFlag.FLAG_BRIMSTONE_MARKED) then
			entity:AddEntityFlags(EntityFlag.FLAG_BRIMSTONE_MARKED)
		end
		if entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			local bombcost, keycost = wakaba:CalculateCost(entity)
			if wakaba.killcount > 160 and entity.Type ~= EntityType.ENTITY_PLAYER and not entity:IsBoss() then
				entity:Die()
			else
				if entity.Parent and wakaba:has_value(wakaba.conquestsegmentwhitelist, entity.Type) then
					wakaba.killcount = wakaba.killcount + ((bombcost + keycost) // 3)
				else
					wakaba.killcount = wakaba.killcount + bombcost + keycost
				end
				if wakaba.fcount > 60 then
					wakaba.fcount = wakaba.fcount + ((bombcost + keycost) / 4)
				else
					wakaba.fcount = wakaba.fcount + bombcost + keycost
				end
			end
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_Minerva)

function wakaba:CalculateMinervaCost()
	wakaba.fcount = 0
	wakaba.killcount = 0
	local entities = Isaac.GetRoomEntities()
	for _, entity in ipairs(entities) do
		if entity:IsEnemy() and not entity:IsDead() then
			if entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
				local bombcost, keycost = wakaba:CalculateCost(entity)
				if wakaba.killcount > 160 and entity.Type ~= EntityType.ENTITY_PLAYER and not entity:IsBoss() then
					entity:Die()
				else
					if entity.Parent and wakaba:has_value(wakaba.conquestsegmentwhitelist, entity.Type) then
						wakaba.killcount = wakaba.killcount + ((bombcost + keycost) // 3)
					else
						wakaba.killcount = wakaba.killcount + bombcost + keycost
					end
					if wakaba.fcount > 60 then
						wakaba.fcount = wakaba.fcount + ((bombcost + keycost) / 4)
					else
						wakaba.fcount = wakaba.fcount + bombcost + keycost
					end
				end
			end
		end
	end
end

function wakaba:NPCChange_Minerva(e)
	wakaba:CalculateMinervaCost()
end

wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.NPCChange_Minerva)
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, wakaba.NPCChange_Minerva)


--LagCheck

--[[ function wakaba:GameStart_Minerva(continue)
  for i = 1, wakaba.G:GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		if wakaba:hasAura(player) then
			local aura = wakaba:initAura(player)
		end
	end
end ]]
--wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.GameStart_Minerva)

function wakaba:PlayerTakeDmg_Minerva(entity, amount, flag, source, countdownFrames)
	if (entity:GetData().wakaba and entity:GetData().wakaba.hasminerva > 0) then
		local rng = entity:ToPlayer():GetCollectibleRNG(wakaba.Enums.Collectibles.MINERVA_AURA)
		local rand = rng:RandomFloat() * 100
		--Isaac.DebugString(rng)
		if rand <= 16 or entity:GetData().wakaba.minervadmgprotect > 0 then
			--entity:SetColor(Color(1, 1, 1, 1, 0.3, 0.1, 0.6), 5, 2, true, false)
			--Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 9, Isaac.GetPlayer().Position, Vector.Zero, Isaac.GetPlayer())
			local halo = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 9, entity.Position - Vector(0, 22), Vector.Zero, entity)
			--halo.SpriteOffset = Vector(0, -40)
			SFXManager():Play(SoundEffect.SOUND_TOOTH_AND_NAIL, 1, 0, false, 1.1, 0)
			entity:ToPlayer():SetMinDamageCooldown(30)
			return false
		end
		if flag & (DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS) == 0 then
			flag = flag | DamageFlag.DAMAGE_NO_PENALTIES
			entity:TakeDamage(amount, flag, source, countdownFrames)
			return false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.PlayerTakeDmg_Minerva, EntityType.ENTITY_PLAYER)

