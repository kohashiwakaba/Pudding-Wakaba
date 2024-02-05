local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:Cache_DoubleInvader(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_INVADER) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (1.5 + player:GetCollectibleNum(wakaba.Enums.Collectibles.DOUBLE_INVADER))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_DoubleInvader)

---comment
---@param npc EntityNPC
---@param collider Entity
---@param low boolean
function wakaba:Collision_DoubleInvader(npc, collider, low)
	if wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.DOUBLE_INVADER) then
		if collider:ToTear() then
			local tear = collider:ToTear()
			if not tear:HasTearFlags(TearFlags.TEAR_PIERCING) then
				tear:Die()
			end
			return true
		elseif collider.Type == EntityType.ENTITY_LASER
		then
			return true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, wakaba.Collision_DoubleInvader, EntityType.ENTITY_DEATHS_HEAD)


---comment
---@param tear EntityTear
---@param collider Entity
---@param low boolean
function wakaba:TearCollision_DoubleInvader(tear, collider, low)
	if wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.DOUBLE_INVADER) then
		if collider.Type == EntityType.ENTITY_DEATHS_HEAD then
			return true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, wakaba.TearCollision_DoubleInvader)

local headSpawned = false
local headErased = false

---@param satan EntityNPC
function wakaba:NPCUpdate_DoubleInvader_MegaSatan(satan)
	if satan.Variant > 0 then return end
	if not wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.DOUBLE_INVADER) then return end
	local sprite = satan:GetSprite()
	--print(satan.State, satan.StateFrame, satan.I1, satan.I2)
	--print(sprite:GetAnimation(), sprite:IsPlaying("Appear"))
	--print(color.A)
	if not headSpawned and sprite:IsPlaying("Appear") then
		local rng = RNG()
		rng:SetSeed(satan.InitSeed, 35)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(0, 5), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(1, 5), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(11, 5), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(12, 5), Vector.Zero, nil)
		headSpawned = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCUpdate_DoubleInvader_MegaSatan, EntityType.ENTITY_MEGA_SATAN)


---@param satan EntityNPC
function wakaba:NPCUpdate_DoubleInvader(satan)
	if satan.Variant > 0 then return end
	local sprite = satan:GetSprite()
	if not headErased and sprite:IsPlaying("Death") then
		wakaba:EraseDeathHeads()
		headErased = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCUpdate_DoubleInvader, EntityType.ENTITY_MEGA_SATAN_2)
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCUpdate_DoubleInvader, EntityType.ENTITY_HUSH)

---@param satan EntityNPC
function wakaba:NPCUpdate_DoubleInvader_Deli(satan)
	if not headErased and satan.HitPoints <= 1 then
		wakaba:EraseDeathHeads()
		headErased = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCUpdate_DoubleInvader_Deli, EntityType.ENTITY_DELIRIUM)

function wakaba:EraseDeathHeads()
	local entities = Isaac.FindByType(EntityType.ENTITY_DEATHS_HEAD)
	for i, e in ipairs(entities) do
		e:ToNPC().State = 18
	end
end

function wakaba:NewRoom_DoubleInvader()
	headSpawned = false
	headErased = false
	local room = wakaba.G:GetRoom()
	if wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.DOUBLE_INVADER) and (room:GetBossID() == 70 or room:GetBossID() == 63) and not room:IsClear() then
		local level = wakaba.G:GetLevel()

		local rng = RNG()
		rng:SetSeed(level:GetDungeonPlacementSeed(), 35)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(11, 1), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(13, 1), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(1, 6), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(24, 6), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(11, 12), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_DEATHS_HEAD, rng:RandomInt(2) == 1 and 2 or 0, 0, isc:gridCoordinatesToWorldPosition(13, 12), Vector.Zero, nil)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_DoubleInvader)