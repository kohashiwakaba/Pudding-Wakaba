local isc = _wakaba.isc

local headSpawned = false
local headErased = false

wakaba.DoubleInvaderDeathHeads = {
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 0, AllowExtra = true},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 0},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 0},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 0},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 0},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 2, AllowExtra = true},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 2},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 2},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 3},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 3, NoDuplicate = true},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 3, NoDuplicate = true},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 4, AllowExtra = true},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 4},
	{Type = EntityType.ENTITY_DEATHS_HEAD, Variant = 4},
	{Type = EntityType.ENTITY_DUSTY_DEATHS_HEAD, Variant = 0, AllowExtra = true},
	{Type = EntityType.ENTITY_DUSTY_DEATHS_HEAD, Variant = 0, AllowExtra = true},
	{Type = EntityType.ENTITY_DUSTY_DEATHS_HEAD, Variant = 0},
	{Type = EntityType.ENTITY_CAMILLO_JR, Variant = 0},
	{Type = EntityType.ENTITY_CAMILLO_JR, Variant = 0, NoLunatic = true},
	{Type = EntityType.ENTITY_CAMILLO_JR, Variant = 0, NoLunatic = true},
	{Type = EntityType.ENTITY_CAMILLO_JR, Variant = 0, NoLunatic = true},
}

wakaba.DoubleInvaderHeadLocations = {
	["Isaac"] = {
		{X = 5, Y = 2},
		{X = 7, Y = 2},
		{X = 5, Y = 4},
		{X = 7, Y = 4},
	},
	["Satan"] = {
		{X = 5, Y = 3},
		{X = 7, Y = 3},
	},
	["MegaSatan"] = {
		{X = 0, Y = 6},
		{X = 1, Y = 5},
		{X = 11, Y = 5},
		{X = 12, Y = 6},
	},
	["Hush"] = {
		{X = 0, Y = 0},
		{X = 11, Y = 1},
		{X = 13, Y = 1},
		{X = 19, Y = 1},
		{X = 25, Y = 3},
		{X = 24, Y = 6},
	},
	["Deli"] = {
		{X = 11, Y = 1},
		{X = 13, Y = 1},
		{X = 1, Y = 6},
		{X = 24, Y = 6},
		{X = 11, Y = 12},
		{X = 13, Y = 12},
	},
	["Witness"] = {
		{X = 0, Y = 0},
		{X = 2, Y = 0},
		{X = 10, Y = 0},
		{X = 12, Y = 0},
	},
	["Dogma"] = {
		{X = 0, Y = 6},
		{X = 0, Y = 7},
		{X = 12, Y = 6},
		{X = 12, Y = 7},
	},
	["Beast"] = {
		{X = 5, Y = 1},
		{X = 5, Y = 5},
		{X = 7, Y = 2},
		{X = 7, Y = 4},
		{X = 9, Y = 1},
		{X = 9, Y = 5},
		{X = 11, Y = 0},
		{X = 11, Y = 6},
	},
	["Greed"] = {
		{X = 5, Y = 5},
		{X = 5, Y = 7},
		{X = 7, Y = 5},
		{X = 7, Y = 7},
	},
}

local function invEnabled(noLunatic)
	return wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.DOUBLE_INVADER) or (wakaba:IsLunatic() and not noLunatic) or wakaba:getOptionValue("alwaysdoubleinvader")
end

local beastLoc = Vector(0,0)

local spawnedEntries = {}

local function isDuplicate(entry)
	for _, dict in ipairs(spawnedEntries) do
		if entry.Type == dict.Type then
			if not dict.Variant or entry.Variant == dict.Variant then
				if not dict.SubType or entry.SubType == dict.SubType then
					return true
				end
			end
		end
	end
end

local function spawnHeads(type, rng)
	if not wakaba.DoubleInvaderHeadLocations[type] then return end
	wakaba.G:GetRoom():SetBrokenWatchState(2)
	local spawnedIndex = {}
	local extra = wakaba:GetGlobalCollectibleNum(wakaba.Enums.Collectibles.DOUBLE_INVADER)
	for i, e in ipairs(wakaba.DoubleInvaderHeadLocations[type]) do
		for try = 1, 4 do
			local entryIndex = rng:RandomInt(#wakaba.DoubleInvaderDeathHeads) + 1
			local entry = wakaba.DoubleInvaderDeathHeads[entryIndex]
			if invEnabled(true) and not isDuplicate(entry) then
				local npc = Isaac.Spawn(entry.Type, entry.Variant or 0, entry.SubType or 0, isc:gridCoordinatesToWorldPosition(e.X, e.Y), Vector.Zero, nil):ToNPC()
				npc:AddEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS | EntityFlag.FLAG_NO_TARGET)
				npc.CanShutDoors = false
				npc:GetData().wakaba_stbond = true
				spawnedIndex[i] = entryIndex
				if entry.NoDuplicate then
					table.insert(spawnedEntries, entry)
				end
				if not entry.AllowExtra then
					extra = extra - 1
				end
				if extra <= 0 then
					break
				end
			end
		end
	end
	spawnedEntries = {}
end

function wakaba:Cache_DoubleInvader(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_INVADER) then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (3.2 + player:GetCollectibleNum(wakaba.Enums.Collectibles.DOUBLE_INVADER))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_DoubleInvader)

function wakaba:PreTakeDamage_DoubleInvader(entity)
	if headSpawned then
		if entity:GetData().wakaba_stbond then
			return false
		end
		for _, dict in ipairs(wakaba.DoubleInvaderDeathHeads) do
			if entity.Type == dict.Type then
				if not dict.Variant or entity.Variant == dict.Variant then
					if not dict.SubType or entity.SubType == dict.SubType then
						return false
					end
				end
			end
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, -19999, wakaba.PreTakeDamage_DoubleInvader)

---comment
---@param npc EntityNPC
---@param collider Entity
---@param low boolean
function wakaba:Collision_DoubleInvader(npc, collider, low)
	if invEnabled() and headSpawned then
		if collider:ToTear() then
			local tear = collider:ToTear()
			if not tear:HasTearFlags(TearFlags.TEAR_PIERCING | TearFlags.TEAR_FETUS) then
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
---@param npc EntityNPC
function wakaba:NPCUpdate_DoubleInvader(npc)
	if not invEnabled() then return end
	if not headSpawned or headErased then return end
	if not npc:GetData().wakaba_stbond then return end

	if not npc:Exists() then
		local npc2 = Isaac.Spawn(enpcntry.Type, npc.Variant or 0, npc.SubType or 0, npc.Position, Vector.Zero, nil):ToNPC()
		npc2:AddEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS | EntityFlag.FLAG_NO_TARGET)
		npc2.CanShutDoors = false
		npc2:GetData().wakaba_stbond = true
		return
	end

	if isc:inBeastRoom() then
		local d = npc:GetData()
		local addVec = d.w_beastVec or Vector(0,0)
		local pos = npc.Position
		local vec = npc.Velocity
		local fv = vec - addVec
		if (pos.X <= -48 and vec.X < 0) or pos.X >= 688 and vec.X > 0 then
			npc:AddVelocity(Vector(-vec.X, 0))
		end
		if (pos.Y <= 73 and vec.Y < 0) or pos.Y >= 484 and vec.Y > 0 then
			npc:AddVelocity(Vector(0, -vec.Y))
		end
		d.w_beastVec = beastVec
	end
end

---comment
---@param tear EntityTear
---@param collider Entity
---@param low boolean
function wakaba:TearCollision_DoubleInvader(tear, collider, low)
	if invEnabled() and headSpawned then
		if collider:GetData().wakaba_stbond then
			return true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, wakaba.TearCollision_DoubleInvader)


---@param satan EntityNPC
function wakaba:NPCUpdate_DoubleInvader_MegaSatan(satan)
	if not invEnabled() or headSpawned then return end
	local room = wakaba.G:GetRoom()
	local sprite = satan:GetSprite()
	if satan.Type == EntityType.ENTITY_MEGA_SATAN and satan.Variant == 0 then

		if sprite:IsPlaying("Appear") then
			local rng = RNG()
			rng:SetSeed(satan.InitSeed, 35)
			spawnHeads("MegaSatan", rng)
			headSpawned = true
		end
	elseif satan.Type == EntityType.ENTITY_DOGMA and satan.Variant == 0 then
		if sprite:IsPlaying("Idle") then
			local rng = RNG()
			rng:SetSeed(satan.InitSeed, 35)
			spawnHeads("Dogma", rng)
			headSpawned = true
		end
	elseif satan.Type == EntityType.ENTITY_FALLEN and satan.Variant == 0 and room:GetBossID() == 24 then
		local rng = RNG()
		rng:SetSeed(satan.InitSeed, 35)
		spawnHeads("Satan", rng)
		headSpawned = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCUpdate_DoubleInvader_MegaSatan)


---@param satan EntityNPC
function wakaba:NPCUpdate_DoubleInvader_Death(satan)
	if not headSpawned or headErased then return end
	local room = wakaba.G:GetRoom()
	local sprite = satan:GetSprite()
	if satan.Type == EntityType.ENTITY_SATAN and satan.Variant == 10 then
		if sprite:IsPlaying("Death") then
			wakaba:EraseDeathHeads()
			headErased = true
		end
	elseif satan.Type == EntityType.ENTITY_MEGA_SATAN_2 and satan.Variant == 0 then
		--print(sprite:GetAnimation())
		if sprite:IsPlaying("Death") then
			wakaba:EraseDeathHeads()
			headErased = true
		end
	elseif satan.Type == EntityType.ENTITY_HUSH and satan.Variant == 0 then
		if sprite:IsPlaying("Death") then
			wakaba:EraseDeathHeads()
			headErased = true
		end
	elseif satan.Type == EntityType.ENTITY_DELIRIUM then
		if satan.HitPoints <= 1 then
			wakaba:EraseDeathHeads()
			headErased = true
		end
	elseif satan.Type == EntityType.ENTITY_DOGMA and satan.Variant == 2 then
		if sprite:IsPlaying("Death") then
			wakaba:EraseDeathHeads()
			headErased = true
		end
	elseif satan.Type == EntityType.ENTITY_MOTHER and satan.Variant == 10 then
		if sprite:IsPlaying("Death") then
			wakaba:EraseDeathHeads()
			headErased = true
		end
	elseif satan.Type == EntityType.ENTITY_ULTRA_GREED then
		if satan.Variant == 0 and wakaba.G.Difficulty % 2 == 0 then
			if sprite:IsPlaying("Death") then
				wakaba:EraseDeathHeads()
				headErased = true
			end
		elseif satan.Variant == 1 and wakaba.G.Difficulty % 2 == 1 then
			if sprite:IsPlaying("Death") then
				wakaba:EraseDeathHeads()
				headErased = true
			end
		end
	elseif satan.Type == EntityType.ENTITY_BEAST and satan.Variant == 0 then
		beastLoc = satan.Position
		if sprite:IsPlaying("Death") then
			wakaba:EraseDeathHeads()
			beastLoc = Vector(0,0)
			headErased = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_RENDER, wakaba.NPCUpdate_DoubleInvader_Death)

function wakaba:EraseDeathHeads()
	for i, e in ipairs(Isaac.GetRoomEntities()) do
		if e:ToNPC() and e.Type == EntityType.ENTITY_DEATHS_HEAD then
			e:ToNPC().State = 18
		end
		if e:ToNPC() and e:Exists() and e:GetData().wakaba_stbond then
			e:ToNPC():Die()
		end
	end
	wakaba.Log("Trying to remove Death Heads...")
end

function wakaba:NewRoom_DoubleInvader()
	headSpawned = false
	headErased = false
	local room = wakaba.G:GetRoom()
	if invEnabled() and not room:IsClear() then
		local level = wakaba.G:GetLevel()
		local bossID = room:GetBossID()
		local entry = ""

		if bossID == 70 then
			entry = "Deli"
		elseif bossID == 63 then
			entry = "Hush"
		elseif bossID == 88 then
			entry = "Witness"
		elseif bossID == 39 then
			entry = "Isaac"
		elseif bossID == 40 then
			entry = "Isaac"
		elseif bossID == 24 then
			--entry = "Satan"
		elseif bossID == 54 then
			entry = "Satan"
		elseif bossID == 62 then
			entry = "Greed"
		elseif isc:inBeastRoom() then
			entry = "Beast"
		end

		if wakaba.DoubleInvaderHeadLocations[entry] then
			local rng = RNG()
			rng:SetSeed(level:GetDungeonPlacementSeed(), 35)
			spawnHeads(entry, rng)
			headSpawned = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_DoubleInvader)