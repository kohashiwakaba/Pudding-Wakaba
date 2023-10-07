--[[
  Retribtion core utilities from Xalum
  changed 'retribution' naming into 'richer' to prevent confusion
 ]]

local mod = wakaba
local game = Game()

function mod:Bound(value, lower, upper) 	return math.max(lower, math.min(upper, value)) end
function mod:LuckBonus(luck, max, bonus) 	return (mod:Bound(luck, 0, max) / max) * bonus end
function mod:StackChance(chance, amount)	return 1 - (1 - chance) ^ amount end
function mod:Lerp(init, target, percentage)	return init + (target - init) * percentage end
function mod:Round(value, step)				return math.floor((value / step) + 0.5) * step end
function mod:RoundVector(vec, step)			return Vector(mod:Round(vec.X, step or 1), mod:Round(vec.Y, step or 1)) end
function mod:VectorModulo(vec, modValue)	return Vector(vec.X % modValue, vec.Y % modValue) end
function mod:Any(v, ...)
	local options = {...}
	for _, o in pairs(options) do
		if o == v then return true end
	end
	return false
end

function mod:CountBits(mask)
	local count = 0
	while mask ~= 0 do
		count = count + 1
		mask = mask & mask - 1
	end

	return count
end

function mod:GetRoomEntities()
	mod.roomEntitiesCache = mod.roomEntitiesCache or Isaac.GetRoomEntities()
	return mod.roomEntitiesCache
end

function mod:GetRoomPlayers()
	if not mod.roomPlayersCache then
		mod.roomPlayersCache = {}
		for i = 0, game:GetNumPlayers() - 1 do
			table.insert(mod.roomPlayersCache, Isaac.GetPlayer(i))
		end
	end

	return mod.roomPlayersCache
end

function mod:ForAllPlayers(func, typeFilter)
	for _, player in pairs(mod:GetRoomPlayers()) do
		if player:Exists() and not typeFilter or typeFilter == player:GetPlayerType() then
			local returnValue = func(player)

			if returnValue ~= nil then
				return returnValue
			end
		end
	end
end

function mod:ForAllEntities(func, invalidate)
	for _, entity in pairs(mod:GetRoomEntities()) do
		if entity:Exists() then
			func(entity)
		end
	end

	if invalidate then
		mod.roomEntitiesCache = nil
	end
end

function mod:AnyPlayerHasTrinket(id)
	local returnValue = mod:ForAllPlayers(function(player)
		if player:HasTrinket(id) then
			return player
		end
	end)

	return returnValue or false
end

function mod:AnyPlayerHasCollectible(id)
	local returnValue = mod:ForAllPlayers(function(player)
		if player:HasCollectible(id) then
			return player
		end
	end)

	return returnValue or false
end

function mod:GetGlobalTrinketMultiplier(id)
	local power = 0
	mod:ForAllPlayers(function(player)
		power = power + player:GetTrinketMultiplier(id)
	end)

	return power
end

function mod:GetGlobalCollectibleNum(id)
	local power = 0
	mod:ForAllPlayers(function(player)
		power = power + player:GetCollectibleNum(id)
	end)

	return power
end

function mod:InitFamiliarRNG(familiar, item)
	familiar:GetData().rng = mod:RNG(familiar.InitSeed)
	familiar.Player:GetCollectibleRNG(item):Next()
end

function mod:GridAlignPosition(pos)
	local x = pos.X
	local y = pos.Y

	x = 40 * math.floor(x/40 + 0.5)
	y = 40 * math.floor(y/40 + 0.5)

	return Vector(x, y)
end

local function ShouldGetNewTargetPosition(entity)
	local data = entity:GetData()
	local room = game:GetRoom()

	return (
		not data.targetGridPosition or
		data.targetGridPosition:Distance(entity.Position) < 5 or
		data.targetGridPosition:Distance(entity.Position) > 60 or
		room:GetGridCollisionAtPos(data.targetGridPosition) ~= GridCollisionClass.COLLISION_NONE
	)
end

function mod:GetRoomTileValues(targetPosition)
	local valueByTile = {}
	local room = game:GetRoom()
	local loopingPositions = {targetPosition}
	local targetPosition = mod:GridAlignPosition(targetPosition)
	local index = 0

	while #loopingPositions > 0 do
		local temporaryLoop = {}

		for _, position in pairs(loopingPositions) do
			if room:IsPositionInRoom(position, 0) then
				if room:GetGridCollisionAtPos(position) == GridCollisionClass.COLLISION_NONE or index == 0 then
					local gridIndex = room:GetGridIndex(position)
					if not valueByTile[gridIndex] then
						valueByTile[gridIndex] = index

						for i = 1, 4 do
							table.insert(temporaryLoop, position + Vector(40, 0):Rotated(i * 90))
						end
					end
				end
			end
		end

		index = index + 1
		loopingPositions = temporaryLoop
	end

	return valueByTile
end

--[[
function mod:TofuPathfind(entity, targetPosition, speedLimit)
	local data = entity:GetData()

	if ShouldGetNewTargetPosition(entity) then
		local room = game:GetRoom()
		local entityPosition = mod:GridAlignPosition(entity.Position)
		local indexedGrids = mod:GetRoomTileValues(targetPosition)
		local entityIndex = room:GetGridIndex(entityPosition)
		local index = indexedGrids[entityIndex] or 99999
		local choice = entityPosition

		for i = 1, 4 do
			local position = entityPosition + Vector(40, 0):Rotated(i * 90)
			local positionIndex = room:GetGridIndex(position)
			local value = indexedGrids[positionIndex]

			if value and value <= index then
				index = value
				choice = position
			end
		end

		data.targetGridPosition = choice
	end

	if data.targetGridPosition then
		local targetVelocity = (data.targetGridPosition - entity.Position):Resized(speedLimit)
		entity.Velocity = mod:Lerp(entity.Velocity, targetVelocity, 0.4)
	else
		entity.Velocity = mod:Lerp(entity.Velocity, Vector.Zero, 0.8)
	end
end
 ]]

function mod:RandomPathfind(entity, speedLimit)
	local data = entity:GetData()

	if entity.FrameCount % 60 == 0 or not data.direction or entity:CollidesWithGrid() then
		local room = game:GetRoom()

		local i = 0
		repeat
			data.direction = RandomVector():Resized(speedLimit)
			i = i + 1

			local testPosition = entity.Position + data.direction:Resized(entity.Size * 2)
		until (room:IsPositionInRoom(testPosition, 0) and room:GetGridCollisionAtPos(testPosition) == GridCollisionClass.COLLISION_NONE) or i >= 32

		if i >= 32 then
			data.direction = (room:GetCenterPos() - entity.Position):Resized(speedLimit)
		end
	end

	local targetPosition = entity.Position + data.direction
	local targetVelocity = (targetPosition - entity.Position):Resized(speedLimit)

	entity.Velocity = mod:Lerp(entity.Velocity, targetVelocity, 0.1)
end

function mod:HasLineOfSight(position1, position2, checkMode)
	return game:GetRoom():CheckLine(position1, position2, checkMode or 0, 900)
end

function mod:GenericPathfind(npc, speedLimit, target, lerpStrengthOverride)
	local data = npc:GetData()
	local targetPosition = target or npc:GetPlayerTarget().Position

	if npc:CollidesWithGrid() then
		data.lastGridCollision = npc.FrameCount
	end

	if not (data.lastGridCollision and data.lastGridCollision + 15 > npc.FrameCount) and mod:HasLineOfSight(npc.Position, targetPosition) then
		local targetVelocity = (targetPosition - npc.Position):Resized(speedLimit)
		npc.Velocity = mod:Lerp(npc.Velocity, targetVelocity, lerpStrengthOverride or 0.2)
	else
		npc.Pathfinder:FindGridPath(targetPosition, speedLimit / 8, 1, false)
	end
end

function mod:IsKnifeSwingable(knife)
	return (
		knife.Variant == mod.KnifeVariant.BONE_CLUB or
		knife.Variant == mod.KnifeVariant.BONE_SCYTHE or
		knife.Variant == mod.KnifeVariant.DONKEY_JAWBONE or
		knife.Variant == mod.KnifeVariant.BAG_OF_CRAFTING or
		knife.Variant == mod.KnifeVariant.NOTCHED_AXE or
		knife.Variant == mod.KnifeVariant.SPIRIT_SWORD or
		knife.Variant == mod.KnifeVariant.TECH_SWORD
	)
end

function mod:IsKnifeSwinging(knife)
	local animation = knife:GetSprite():GetAnimation()

	return (
		animation == "Swing" or
		animation == "Swing2" or
		animation == "SwingDown" or
		animation == "SwingDown2" or

		animation == "AttackRight" or -- Spirit Sword
		animation == "AttackLeft" or
		animation == "AttackUp" or
		animation == "AttackDown" or
		animation == "SpinRight" or
		animation == "SpinLeft" or
		animation == "SpinUp" or
		animation == "SpinDown"
	)
end

function mod:GetEntityFromRef(reference)
	if reference.Entity then
		for _, entity in pairs(Isaac.FindByType(reference.Type, reference.Variant, -1)) do
			if entity.InitSeed == reference.Entity.InitSeed then return entity end
		end
	end
	return nil
end

function mod:CalcPlayerDamageMult(player, negativeOnly)
	local mult = 1
	local effects = player:GetEffects()

	-- Missing
	--[[
		Dead Eye: CollectibleEffects don't seem to be used to track the scaling, no other easy way to get it that I can think of
		Cracked Crown: I'm honestly not even sure how its stat boosts work
	]]

	player = player:ToPlayer()
	if not negativeOnly and (
			player:HasCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM) or
			player:HasCollectible(CollectibleType.COLLECTIBLE_MAXS_HEAD) or (
				player:HasCollectible(CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR) and
				effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL)
	)) then -- This multiplier is fucking stupid garbage and I hate it
		mult = mult * 1.5
	end
	if not negativeOnly and player:HasCollectible(CollectibleType.COLLECTIBLE_EVES_MASCARA) then
		mult = mult * 2
	end
	if not negativeOnly and player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) then
		mult = mult * 1.5 -- Changed from ~ +31% in ab+
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ODD_MUSHROOM_RATE) then
		mult = mult * 0.9
	end
	if not negativeOnly and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS) then
		mult = mult * 2
	end
	--[[if player:HasCollectible(CollectibleType.COLLECTIBLE_PROPTOSIS) then -- Removed in repentance, now +0.5 Damage
		mult = mult * 2
	end]]
	if not negativeOnly and player:HasCollectible(CollectibleType.COLLECTIBLE_SACRED_HEART) then
		mult = mult * 2.3
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_SOY_MILK) then
		mult = mult * 0.2
	end
	--[[if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) then -- Removed in repentance, now laser decreases its damage independantly
		mult = mult * 0.65
	end]]
	if not negativeOnly and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) then
		mult = mult * 2
	end

	-- Repentance Begin
	if not negativeOnly and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) then
		mult = mult * 4
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ALMOND_MILK) then
		mult = mult * 0.3
	end
	if not negativeOnly and player:HasCollectible(CollectibleType.COLLECTIBLE_IMMACULATE_HEART) then
		mult = mult * 1.2
	end

	return mult
end

function mod:GetExpectedFamiliarNum(player, item)
	if not player or not item then return 0 end
	return player:GetCollectibleNum(item) + player:GetEffects():GetCollectibleEffectNum(item)
end

function mod:GetItem(id)
	local config = Isaac.GetItemConfig()
	return config:GetCollectible(id)
end

function mod:GetTrinketConfig(id)
	local config = Isaac.GetItemConfig()
	return config:GetTrinket(id)
end

function mod:CalcPlayerHealth(player, lite)
	if lite then
		return player:GetHearts() + player:GetSoulHearts()
	else
		return player:GetHearts() + player:GetSoulHearts() + player:GetBoneHearts() + player:GetEternalHearts() - player:GetRottenHearts()
	end
end

function mod:IsDamageOnBlackHeart(player, damage, flags)
	if flags & DamageFlag.DAMAGE_RED_HEARTS > 0 and player:GetHearts() > 0 then
		return false
	end

	local souls = player:GetSoulHearts()
	if souls == 0 then return false end

	local bones = player:GetBoneHearts()
	local extrahearts = math.ceil(souls / 2 + bones)

	local currentsoul = 0
	local black = false

	for i = 0, extrahearts - 1 do
		if not player:IsBoneHeart(i) then
			if i == extrahearts - damage and player:IsBlackHeart(currentsoul + 1) then
				black = true
				break
			end

			currentsoul = currentsoul + 2
		end
	end

	return black
end

function mod:GetTearPlayer(tear, strict)
	local parent = tear.SpawnerEntity or tear.Parent or Isaac.GetPlayer()
	local familiar = parent:ToFamiliar()

	if familiar then
		parent = familiar.Player
	end

	return parent:ToPlayer() or ((not strict) and Isaac.GetPlayer())
end

--[[
function mod:GetCrutchIgnoredFlags()
	return (
		mod.TearFlag.CATARACT |
		mod.TearFlag.BOOSTER_SHOT |
		mod.TearFlag.MILK_TOOTH |
		mod.TearFlag.HYPEROPIA |
		mod.TearFlag.MYOPIA |
		mod.TearFlag.HEART_WORM |
		mod.TearFlag.REFLUX |
		mod.TearFlag.REFLUX_DEFUSED |
		mod.TearFlag.TECH_OMICRON |
		mod.TearFlag.EVES_NAIL_POLISH |
		mod.TearFlag.CONJUNCTIVITIS |
		mod.TearFlag.GLORIOSA
	)
end
 ]]
--[[ 
function mod:TearHasCustomEffect(tear, isCrutchCheck)
	local testFlags = mod.TearFlag.ALL
	local myFlags = mod:GetRicherTearFlags(tear)

	if isCrutchCheck then
		testFlags = testFlags - mod:GetCrutchIgnoredFlags()

		if myFlags & mod.TearFlag.FORCE_CRUTCH > 0 then
			return true
		end
	end

	return myFlags & testFlags > 0
end
 ]]
function mod:AddRicherTearFlags(tear, flags)
	local data = tear:GetData()
	data.richer_TearFlags = data.richer_TearFlags and data.richer_TearFlags | flags or flags
end

function mod:ClearRicherTearFlags(tear, flags)
	local data = tear:GetData()
	data.richer_TearFlags = data.richer_TearFlags and data.richer_TearFlags & ~ flags or 0
end

function mod:HasRicherTearFlags(tear, flags)
	local data = tear:GetData()
	return (data.richer_TearFlags or 0) & flags > 0
end

function mod:GetRicherTearFlags(tear)
	return tear:GetData().richer_TearFlags or 0
end

function mod:ClearCustomTearEffects(tear)
	tear:GetData().richer_TearFlags = 0
end

function mod:WipeRicherTearFlags(tear)
	mod:ClearCustomTearEffects(tear)
end

mod.PlayerMimickingFamiliars = {
	[FamiliarVariant.INCUBUS] 			= true,
	[FamiliarVariant.FATES_REWARD] 		= true,
	[FamiliarVariant.TWISTED_BABY] 		= true,
	[FamiliarVariant.UMBILICAL_BABY] 	= true,
}

function mod:WasTearFiredByPlayerMimic(tear, explicit)
	if not tear.SpawnerEntity then
		return false
	end

	local player = tear.SpawnerEntity:ToPlayer()
	if player and not explicit then
		return true
	end

	local familiar = tear.SpawnerEntity:ToFamiliar()
	if familiar and mod.PlayerMimickingFamiliars[familiar.Variant] then
		return true
	end

	return false
end

--[[
function mod:ShouldTearGetEffects(tear)
	local data = tear:GetData()
	local priority = mod.TEAR_VARIANT_PRIORITY[tear.Variant] or 0

	return (
		mod:WasTearFiredByPlayerMimic(tear) and
		priority < mod.TEAR_VARIANT_PRIORITY.TEAR_EFFECTS_THRESHOLD and
		not tear:HasTearFlags(TearFlags.TEAR_CHAIN) and
		not data.richer_Detoxified and
		not data.richer_IsMadOnion
	)
end

function mod:CanTearBecomeVariant(current, target)
	return (
		current ~= target and
		(mod.TEAR_VARIANT_PRIORITY[target] or 0) > (mod.TEAR_VARIANT_PRIORITY[current] or 0)
	)
end

function mod:IsRicherTearVariant(variant)
	for _, testVariant in pairs(mod.TearVariant) do
		if variant == testVariant then
			return true
		end
	end
end
 ]]

--[[
function mod:IsTearBloody(tear)
	return mod.BloodyTearVariants[tear.Variant]
end

function mod:TryMakeTearBloody(tear, defaultTargetVariant)
	if defaultTargetVariant then
		if mod:TryChangeTearVariant(tear, defaultTargetVariant) then
			return true
		end
	end

	local bloodyVariant = mod.BloodyTearVariants[tear.Variant]
	if bloodyVariant and mod:TryChangeTearVariant(tear, bloodyVariant) then
		return true
	end

	return false
end

function mod:TryChangeTearVariant(tear, variant, ignorePriority)
	if mod:CanTearBecomeVariant(tear.Variant, variant) or (ignorePriority and tear.Variant ~= variant) then
		tear:ChangeVariant(variant)

		if mod:IsRicherTearVariant(variant) then
			tear:Update()
		end

		return true
	end

	return false
end

function mod:TryMultipleTearVariants(tear, variants)
	for i = 1, #variants do
		local variant = variants[i]

		if mod:TryChangeTearVariant(tear, variant) then
			break
		end
	end
end

mod.TearAnimScaleThresholds 		= {0, 0.3, 0.55, 0.675, 0.80, 0.925, 1.05, 1.175, 1.425, 1.675, 1.925, 2.175, 2.55}
mod.StoneTearAnimScaleThresholds 	= {0, 0.675, 0.925, 1.175, 1.675, 2.175}
mod.ThornTearAnimScaleThresholds	= {0, 0.675, 0.925, 1.425, 2.175}

function mod:GetTearAnimationNumber(tear)
	local size = 1
	local list = mod.TearAnimScaleThresholds

	if mod.StoneTearVariants[tear.Variant] then
		list = mod.StoneTearAnimScaleThresholds
	elseif mod.ThornTearVariants[tear.Variant] then
		list = mod.ThornTearAnimScaleThresholds
	end

	for i = 1, #list do
		if tear.Scale > list[i] then
			size = i
		end
	end

	return size
end
 ]]

--[[
mod.TearSplashes = {
	[mod.TearVariant.ARROW_OF_LIGHT]			= "gfx/effects/arrowoflight_tearpoof.png",
	[mod.TearVariant.ARROW_OF_LIGHT_BLOOD]		= "gfx/effects/arrowoflight_blood_tearpoof.png",
	[mod.TearVariant.ARROW_OF_LIGHT_CUPID]		= "gfx/effects/arrowoflight_tearpoof.png",
	[mod.TearVariant.ARROW_OF_LIGHT_CUPID_BLOOD]= "gfx/effects/arrowoflight_blood_tearpoof.png",
	[mod.TearVariant.TOOL]				= "gfx/effects/tool_tearpoof.png",
	[mod.TearVariant.TOOL_CUPID]		= "gfx/effects/tool_tearpoof.png",
	[mod.TearVariant.EARWAX]			= "gfx/effects/earwax_tearpoof.png",
	[mod.TearVariant.CATARACT]			= "gfx/effects/cataract_tearpoof.png",
	[mod.TearVariant.TOFU]				= "gfx/effects/tofu_tearpoof.png",
	[mod.TearVariant.REFLUX]			= "gfx/effects/reflux_tearpoof.png",
	[mod.TearVariant.REFLUX_BLOOD]		= "gfx/effects/reflux_blood_tearpoof.png",
	[mod.TearVariant.BAPTISMAL_SHELL]	= "gfx/effects/baptism_tearpoof.png",
	[mod.TearVariant.CHOLERA]		 	= "gfx/effects/cholera_tearpoof.png",
	[mod.TearVariant.MELITODES]			= "gfx/effects/honey_tearpoof.png",
	[mod.TearVariant.MAD_ONION]			= "gfx/effects/redonion_tearpoof.png",
	[mod.TearVariant.EVES_NAIL_POLISH]			= "gfx/effects/evesnailpolish_tearpoof.png",
	[mod.TearVariant.EVES_NAIL_POLISH_CUPID]	= "gfx/effects/evesnailpolish_tearpoof.png",
}

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, function(_, entity)
	if mod.TearSplashes[entity.Variant] then
		local poof = Isaac.Spawn(1000, 12, 0, entity.Position, Vector.Zero, entity)
		poof.Color = entity.Color

		local sprite = poof:GetSprite()
		sprite:Load("gfx/effect_tearpoof_legacy.anm2", true)
		sprite:ReplaceSpritesheet(0, mod.TearSplashes[entity.Variant])
		sprite:LoadGraphics()
		sprite:Play("Poof")
		sprite.Offset = entity.PositionOffset / 1.5

		sfx:Play(SoundEffect.SOUND_TEARIMPACTS)
	end
end, EntityType.ENTITY_TEAR)
 ]]

mod.UnlockBlockingSeedEffects = {
	SeedEffect.SEED_INFINITE_BASEMENT,
	SeedEffect.SEED_PICKUPS_SLIDE,
	SeedEffect.SEED_ITEMS_COST_MONEY,
	SeedEffect.SEED_PACIFIST,
	SeedEffect.SEED_ENEMIES_RESPAWN,
	SeedEffect.SEED_POOP_TRAIL,
	SeedEffect.SEED_INVINCIBLE,
	SeedEffect.SEED_KIDS_MODE,
	SeedEffect.SEED_PERMANENT_CURSE_LABYRINTH,
	SeedEffect.SEED_PREVENT_CURSE_DARKNESS,
	SeedEffect.SEED_PREVENT_CURSE_LABYRINTH,
	SeedEffect.SEED_PREVENT_CURSE_LOST,
	SeedEffect.SEED_PREVENT_CURSE_UNKNOWN,
	SeedEffect.SEED_PREVENT_CURSE_MAZE,
	SeedEffect.SEED_PREVENT_CURSE_BLIND,
	SeedEffect.SEED_PREVENT_ALL_CURSES,
	SeedEffect.SEED_GLOWING_TEARS,
	SeedEffect.SEED_ALL_CHAMPIONS,
	SeedEffect.SEED_ALWAYS_CHARMED,
	SeedEffect.SEED_ALWAYS_CONFUSED,
	SeedEffect.SEED_ALWAYS_AFRAID,
	SeedEffect.SEED_ALWAYS_ALTERNATING_FEAR,
	SeedEffect.SEED_ALWAYS_CHARMED_AND_AFRAID,
	SeedEffect.SEED_SUPER_HOT,
}

--[[
function mod:IsSlotCustom(slot)
	for _, variant in pairs(mod.SLOTS) do
		if slot.Variant == variant then
			return true
		end
	end

	return false
end
 ]]

mod.DirectionToVector = {
	[Direction.DOWN]	= Vector(0, 1),
	[Direction.UP]		= Vector(0, -1),
	[Direction.LEFT]	= Vector(-1, 0),
	[Direction.RIGHT]	= Vector(1, 0),
}

mod.DirectionToString = {
	[Direction.DOWN] = "Down",
	[Direction.UP] = "Up",
	[Direction.LEFT] = "Side",
	[Direction.RIGHT] = "Side",
}

mod.DirectionToString2 = {
	[Direction.DOWN] = "Down",
	[Direction.UP] = "Up",
	[Direction.LEFT] = "Left",
	[Direction.RIGHT] = "Right",
}

local redhearts = {
	[HeartSubType.HEART_FULL] = 2,
	[HeartSubType.HEART_HALF] = 1,
	[HeartSubType.HEART_DOUBLEPACK] = 4,
	[HeartSubType.HEART_SCARED] = 2,
}

function mod:IsRedHeart(heartSub)
	return redhearts[heartSub] -- Returns healAmount
end

function mod:CanPickHeart(player, heart)
  if heart.SubType == HeartSubType.HEART_BLENDED then -- Red + Soul
    return player:CanPickRedHearts() and player:CanPickSoulHearts()
  elseif mod:IsRedHeart(heart.SubType) then -- Red
    return player:CanPickRedHearts()
  elseif heart.SubType == HeartSubType.HEART_SOUL or heart.SubType == HeartSubType.HEART_HALF_SOUL then
    return player:CanPickSoulHearts()
  elseif heart.SubType == HeartSubType.HEART_BLACK then
    return player:CanPickBlackHearts()
  elseif heart.SubType == HeartSubType.HEART_GOLDEN then
    return player:CanPickGoldenHearts()
  elseif heart.SubType == HeartSubType.HEART_BONE then
    return player:CanPickBoneHearts()
  elseif heart.SubType == HeartSubType.HEART_ROTTEN then
    return player:CanPickRottenHearts()
  elseif heart.SubType == HeartSubType.HEART_ETERNAL then
    return true
  end
end

function mod:SetCollectibleEffectNum(player, item, amount)
	local effects = player:GetEffects()
	local current = effects:GetCollectibleEffectNum(item)

	effects:RemoveCollectibleEffect(item, current)
	if amount > 0 then
		effects:AddCollectibleEffect(item, false, amount)
	end
end

function mod:IncrementCollectibleEffectNum(player, item, decrement)
	local effects = player:GetEffects()

	if decrement then
		effects:RemoveCollectibleEffect(item, 1)
	else
		effects:AddCollectibleEffect(item, false, 1)
	end

	return effects:GetCollectibleEffectNum(item)
end

function mod:SetTrinketEffectNum(player, trinket, amount)
	local effects = player:GetEffects()
	local current = effects:GetTrinketEffectNum(trinket)

	effects:RemoveTrinketEffect(trinket, current)
	if amount > 0 then
		effects:AddTrinketEffect(trinket, false, amount)
	end
end

function mod:IncrementTrinketEffectNum(player, trinket, decrement)
	local effects = player:GetEffects()

	if decrement then
		effects:RemoveTrinketEffect(trinket, 1)
	else
		effects:AddTrinketEffect(trinket, false, 1)
	end

	return effects:GetTrinketEffectNum(trinket)
end

function mod:GetStageCollisionDamage()
	local level = game:GetLevel()

	if level:GetStage() >= LevelStage.STAGE4_1 and game.Difficulty < Difficulty.DIFFICULTY_GREED then
		return 2
	else
		return 1
	end
end

function mod:IsPlayerHoldingTrinket(player, trinket)
	for i = 0, 1 do
		if player:GetTrinket(i) == trinket then
			return i
		end
	end

	return false
end

function mod:PlayerHasSmeltedTrinket(player, trinket)
	return player:HasTrinket(trinket) and not mod:IsPlayerHoldingTrinket(player, trinket)
end

function mod:SmeltHeldTrinket(player, slot)
	local otherSlot = (slot + 1) % 2
	local otherTrinket = player:GetTrinket(otherSlot)

	if otherTrinket ~= 0 then
		player:TryRemoveTrinket(otherTrinket)
	end

	player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM)

	if otherTrinket ~= 0 then
		player:AddTrinket(otherTrinket, false)
	end
end

function mod:AddSmeltedTrinket(player, trinket, firstPickup)
	local trinket0 = player:GetTrinket(0)
	local trinket1 = player:GetTrinket(1)

	if trinket0 > 0 then player:TryRemoveTrinket(trinket0) end
	if trinket1 > 0 then player:TryRemoveTrinket(trinket1) end

	player:AddTrinket(trinket, firstPickup)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM)

	if trinket1 > 0 then player:AddTrinket(trinket1, false) end
	if trinket0 > 0 then player:AddTrinket(trinket0, false) end
end

--[[
mod.DiamondsCards = {
	Card.CARD_ACE_OF_DIAMONDS,
	Card.CARD_DIAMONDS_2,
}

function mod:IsCardDiamonds(cardID)
	for _, id in pairs(mod.DiamondsCards) do
		if id == cardID then
			return true
		end
	end
end

mod.SpadesCards = {
	Card.CARD_ACE_OF_SPADES,
	Card.CARD_SPADES_2,
}

function mod:IsCardSpades(cardID)
	for _, id in pairs(mod.SpadesCards) do
		if id == cardID then
			return true
		end
	end
end

mod.ClubsCards = {
	Card.CARD_ACE_OF_CLUBS,
	Card.CARD_CLUBS_2,
}

function mod:IsCardClubs(cardID)
	for _, id in pairs(mod.ClubsCards) do
		if id == cardID then
			return true
		end
	end
end

mod.HeartsCards = {
	Card.CARD_ACE_OF_HEARTS,
	Card.CARD_HEARTS_2,
	Card.CARD_QUEEN_OF_HEARTS,
	Card.CARD_SUICIDE_KING, -- King of Hearts
}

function mod:IsCardHearts(cardID)
	for _, id in pairs(mod.HeartsCards) do
		if id == cardID then
			return true
		end
	end
end

function mod:IsCardSuited(cardID)
	return mod:IsCardDiamonds(cardID) or mod:IsCardSpades(cardID) or mod:IsCardClubs(cardID) or mod:IsCardHearts(cardID)
end
 ]]

function mod:IsRealEnemy(entity)
	return entity:IsEnemy() and entity.Type ~= 33 and entity.Type ~= 292
end

function mod:IsActiveVulnerableEnemy(entity)
	return mod:IsRealEnemy(entity) and entity:IsActiveEnemy() and entity:IsVulnerableEnemy()
end

function mod:DoEntitiesOverlap(entity1, entity2)
	return entity1.Position:Distance(entity2.Position) <= entity1.Size + entity2.Size
end

function mod:AreEntitiesSame(entity1, entity2)
	return entity1 and entity2 and GetPtrHash(entity1) == GetPtrHash(entity2)
end

function mod:RemoveDefaultSlotDrops(slot)
	for i = 4, 5 do
		for _, entity in pairs(Isaac.FindByType(i)) do
			if mod:DoEntitiesOverlap(entity, slot) and entity.FrameCount <= 1 then
				entity:Remove()
			end
		end
	end
end

function mod:ShouldPlayerGetInitialised(player) -- Credit to Kittenchilly
	if (player.FrameCount == 0 or (player.FrameCount == 1 and game:GetNumPlayers() > 1)) and not player.Parent then
		local level = game:GetLevel()

		if (level:GetAbsoluteStage() == LevelStage.STAGE1_1 and level:GetCurrentRoomIndex() == level:GetStartingRoomIndex()) or level:GetCurrentRoomIndex() == GridRooms.ROOM_GENESIS_IDX then
			return level:GetCurrentRoomDesc().VisitedCount == 1
		end
	end
end

function mod:GetScreenVector()
	return Vector(Isaac.GetScreenWidth(), Isaac.GetScreenHeight())
end

function mod:GetScreenCentre()
    return mod:GetScreenVector() / 2
end

function mod:AddTears(baseFiredelay, tearsUp) -- Credit to _Kilburn and DeadInfinity
	local currentTears = 30 / (baseFiredelay + 1)
	local newTears = currentTears + tearsUp
	local newFiredelay = math.max((30 / newTears) - 1, -0.75)

	return newFiredelay
end

function mod:MultiplyTears(baseFiredelay, multiplier)
	local currentTears = 30 / (baseFiredelay + 1)
	local newTears = currentTears * multiplier
	local newFiredelay = math.max((30 / newTears) - 1, -0.75)

	return newFiredelay
end

function mod:GetTopLeftHudShift()
	local offsetInt = Options.HUDOffset * 10
	local offset = Vector(offsetInt * 2, offsetInt * 1.2)

	return offset
end

function mod:GetTopRightHudShift()
	local offsetInt = Options.HUDOffset * 10
	local offset = Vector(offsetInt * -1.6, offsetInt * 1.2)

	return offset
end

function mod:GetBottomRightHudShift()
	local offsetInt = Options.HUDOffset * 10
	local offset = Vector(offsetInt * -1.6, offsetInt * -0.6)

	return offset
end

function mod:GetPrimaryActiveHudPosition(corner)
	if corner == 0 then
		return mod:GetTopLeftHudShift() + Vector(30, 1)
	elseif corner == 1 then
		return mod:GetTopRightHudShift() + Vector(Isaac.GetScreenWidth(), 0) + Vector(-30, -30)
	elseif corner == 2 then

	elseif corner == 3 then
		return mod:GetBottomRightHudShift() + mod:GetScreenVector() + Vector(-44, -38)
	end
end

function mod:GameHasUnlockBlockingSeed()
	local seeds = game:GetSeeds()
	for _, seed in pairs(mod.UnlockBlockingSeedEffects) do
		if seeds:HasSeedEffect(seed) then
			return true
		end
	end

	return false
end

function mod:GameHasPreStatPositionShifter()
	local difficultyShift 	= game.Difficulty ~= Difficulty.DIFFICULTY_NORMAL
	local destinationShift 	= game.Challenge ~= 0
	local illegalSeedShift 	= mod:GameHasUnlockBlockingSeed()

	return difficultyShift or destinationShift or illegalSeedShift
end

function mod:GameHasExpandedStatsHUD()
	local numRealPlayers = 0
	mod:ForAllPlayers(function(player)
		if not player.Parent then
			numRealPlayers = numRealPlayers + 1
		end
	end)

	return numRealPlayers > 1
end

function mod:GetResourceModifierMultiplier()
	local bethanyModifier = mod:GameHasPlayerType(PlayerType.PLAYER_BETHANY) and 1 or 0
	local taintedBethanyModifier = mod:GameHasPlayerType(PlayerType.PLAYER_BETHANY_B) and 1 or 0
	local taintedBlueBabyModifier = mod:GameHasPlayerType(PlayerType.PLAYER_BLUEBABY_B) and 1 or 0

	return bethanyModifier + taintedBethanyModifier + taintedBlueBabyModifier
end

function mod:GameHasPlayerType(...)
	for _, player in pairs(Isaac.FindByType(1)) do
		for _, playerType in pairs({...}) do
			if player:ToPlayer():GetPlayerType() == playerType then
				return true
			end
		end
	end
end

function mod:GetPlayerOfType(playerType, strict)
	for _, player in pairs(Isaac.FindByType(1)) do
		if player:ToPlayer():GetPlayerType() == playerType then return player:ToPlayer() end
	end

	if not strict then return Isaac.GetPlayer() end
end

function mod:GameHasBirthrightEffect(playerType)
	return mod:ForAllPlayers(function(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			return true
		end
	end, playerType)
end

function mod:GetNumNonStrawmanPlayers()
	local n = 0
	mod:ForAllPlayers(function(player)
		if not player.Parent then
			n = n + 1
		end
	end)

	return n
end

function mod:GameHadSeedEffect(test)
	if mod.GameSeedEffects then
		for _, effect in pairs(mod.GameSeedEffects) do
			if effect == test then
				return true
			end
		end
	end
end

function mod:EntityMatchesValues(entity, typ, var, sub)
	if not entity then return false end

	typ = typ or entity.Type
	var = var or entity.Variant
	sub = sub or entity.SubType

	return typ == entity.Type and var == entity.Variant and sub == entity.SubType
end

function mod:DamagePlayerInRadius(source, radius, amount, flags, cooldown)
	for _, player in pairs(Isaac.FindByType(1)) do
		if player.Position:Distance(source.Position) < radius + player.Size then
			player:TakeDamage(amount or 1, flags or 0, EntityRef(source), cooldown or 60)
		end
	end

	for _, heart in pairs(Isaac.FindByType(3, FamiliarVariant.ISAACS_HEART)) do
		if heart.Position:Distance(source.Position) < radius + heart.Size then
			heart:ToFamiliar():TakeDamage(amount or 1, flags and flags | DamageFlag.DAMAGE_ISSAC_HEART or DamageFlag.DAMAGE_ISSAC_HEART, EntityRef(source), cooldown or 60)
		end
	end
end

function mod:UniversalRemoveItemFromPools(item)
	mod:RemoveItemFromCustomItemPools(item)

	local itempool = game:GetItemPool()
	itempool:RemoveCollectible(item)
end

function mod:UniversalRemoveTrinketFromPools(trinket)
	mod:RemoveTrinketFromCustomItemPools(trinket)

	local itempool = game:GetItemPool()
	itempool:RemoveTrinket(trinket)
end

function mod:GetItemFromPool(pool, remove, rng)
	local itemPool = game:GetItemPool()
	local item = itemPool:GetCollectible(pool, remove, rng:Next())

	if remove then
		mod:UniversalRemoveItemFromPools(item)
	end

	return item
end

function mod:CanAffordPrice(player, price)
	if price > 0 then
		return price <= player:GetNumCoins()
	elseif price == PickupPrice.PRICE_SPIKES then
		return player:GetDamageCooldown() == 0
	elseif price == PickupPrice.PRICE_SOUL then
		return player:HasTrinket(TrinketType.TRINKET_YOUR_SOUL)
	elseif price == 0 or price == PickupPrice.PRICE_FREE then
		return true
	elseif price == PickupPrice.PRICE_ONE_HEART or price == PickupPrice.PRICE_TWO_HEARTS then
		return player:GetEffectiveMaxHearts() > 0
	elseif price == PickupPrice.PRICE_ONE_HEART_AND_TWO_SOULHEARTS or price == PickupPrice.PRICE_ONE_HEART_AND_ONE_SOUL_HEART then
		return player:GetSoulHearts() > 0 and player:GetEffectiveMaxHearts() > 0
	elseif price == PickupPrice.PRICE_THREE_SOULHEARTS or price == PickupPrice.PRICE_ONE_SOUL_HEART or price == PickupPrice.PRICE_TWO_SOUL_HEARTS then
		return player:GetSoulHearts() > 0
	end
end

function mod:PayPickupPrice(player, price, pickup)
	if price > 0 then
		player:AddCoins(-price)
	elseif price == PickupPrice.PRICE_SPIKES then
		player:TakeDamage(2, DamageFlag.DAMAGE_SPIKES | DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(pickup), 30)
	elseif price == PickupPrice.PRICE_SOUL then
		player:TryRemoveTrinket(TrinketType.TRINKET_YOUR_SOUL)
	end
end

function mod:WillPlayerBuyCollectible(player, pickup)
	return (
		pickup.Price ~= 0 and
		pickup.Wait == 0 and
		player.Variant == mod.PlayerVariant.PLAYER and
		player.ItemHoldCooldown == 0 and
		player:CanPickupItem() and
		not player:IsHoldingItem() and
		mod:CanAffordPrice(player, pickup.Price)
	)
end

function mod:WillPlayerBuyHeart(player, pickup)
	return (
		pickup.Price ~= 0 and
		player.Variant == mod.PlayerVariant.PLAYER and
		mod:CanAffordPrice(player, pickup.Price) and
		mod:CanPickHeart(player, pickup)
	)
end

function mod:WillPlayerBuyBattery(player, pickup)
	return (
		pickup.Price ~= 0 and
		player.Variant == mod.PlayerVariant.PLAYER and
		mod:CanAffordPrice(player, pickup.Price) and
		player:NeedsCharge()
	)
end

function mod:WillPlayerBuyPickup(player, pickup)
	if pickup.Variant == 100 then
		return mod:WillPlayerBuyCollectible(player, pickup)
	elseif pickup.Variant == 10 then
		return mod:WillPlayerBuyHeart(player, pickup)
	elseif pickup.Variant == 90 then
		return mod:WillPlayerBuyBattery(player, pickup)
	elseif mod:CanAffordPrice(player, pickup.Price) then
		return true
	end
end

function mod:GetHighestHeartContainerCount()
	local highest = 0
	mod:ForAllPlayers(function(player)
		highest = math.max(player:GetEffectiveMaxHearts(), highest)
	end)

	return highest
end

function mod:GetExpectedDevilDealPrice(collectible)
	local itemConfig = Isaac.GetItemConfig()
	local item = itemConfig:GetCollectible(collectible)

	local devilPrice = item.DevilPrice

	return -devilPrice
end

function mod:GetRealDevilDealPrice(collectible)
	local price = mod:GetExpectedDevilDealPrice(collectible)
	local greatestHealth = mod:GetHighestHeartContainerCount()

	if greatestHealth == 0 then
		price = PickupPrice.PRICE_THREE_SOULHEARTS
	elseif price == PickupPrice.PRICE_TWO_HEARTS and greatestHealth < 4 then
		price = PickupPrice.PRICE_ONE_HEART_AND_TWO_SOULHEARTS
	end

	if mod.PlayerHasJudasTongue and (price == PickupPrice.PRICE_TWO_HEARTS or PickupPrice.PRICE_ONE_HEART_AND_TWO_SOULHEARTS) then
		price = PickupPrice.PRICE_ONE_HEART
	end

	if mod:AnyPlayerHasTrinket(TrinketType.TRINKET_YOUR_SOUL) then
		price = PickupPrice.PRICE_SOUL
	end

	return price
end

function mod:ShouldEntityGetTearCollisionEffects(entity, tear)
	return (
		entity:ToNPC() and
		not entity:HasEntityFlags(EntityFlag.FLAG_ICE_FROZEN) and
		not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) --[[ and
		not tear:GetData().richer_TearEffectEntityBlacklist[entity.InitSeed] ]]
	)
end

function mod:ShouldEntityGetKnifeCollisionEffects(entity, knife)
	return (
		entity:ToNPC() and
		entity:Exists() and
		entity.EntityCollisionClass > 0 and
		entity.FrameCount > 1 and
		not entity:IsDead() and
		not entity:HasEntityFlags(EntityFlag.FLAG_ICE_FROZEN) and
		not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) --[[ and
		not knife:GetData().richer_TearEffectEntityBlacklist[entity.InitSeed] ]]
	)
end

function mod:ShouldPickupGetPickedByKnife(pickup)
	return (
		pickup:Exists() and
		pickup.EntityCollisionClass > 0
	)
end

function mod:DoesEntityMimicGridTearCollision(entity)
	return (
		entity.Type == 33 or
		entity.Type == 292 or
		entity.Type == 302
	)
end

--[[
function mod:ShouldTearSpawnPoofOnEntityCollision(tear, collider)
	if collider and mod:DoesEntityMimicGridTearCollision(collider) then
		return (
			not tear:HasTearFlags(TearFlags.TEAR_SPECTRAL)
		)
	else
		return (
			collider.Type ~= 3 and
			not collider:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) and
			not tear:HasTearFlags(TearFlags.TEAR_PIERCING) and
			not tear:HasTearFlags(TearFlags.TEAR_BELIAL) and
			not tear:HasTearFlags(TearFlags.TEAR_BOOGER) and
			not tear:HasTearFlags(TearFlags.TEAR_SPORE)
		)
	end
end
 ]]

function mod:EntitiesAreWithinRange(entity1, entity2, range)
	return entity1.Position:Distance(entity2.Position) - entity1.Size - entity2.Size < range
end

function mod:EntitiesHaveLineOfSight(entity1, entity2, mode)
	local room = game:GetRoom()
	return room:CheckLine(entity1.Position, entity2.Position, mode or 0)
end

function mod:GetNearestDirectionStringFromAngle(angle, horizontalOverride)
	if math.abs(angle) < 45 then
		return horizontalOverride or "Right"
	elseif math.abs(angle) > 135 then
		return horizontalOverride or "Left"
	elseif angle > 0 then
		return "Down"
	else
		return "Up"
	end
end

function mod:RevealRandomMapRoom(rng, displayFlag)
	displayFlag = displayFlag or 5
	if not rng then
		rng = RNG()
		rng:SetSeed(Random(), 42)
	end

	local level = game:GetLevel()
	local roomsList = level:GetRooms()
	local ultraSecretDescriptor
	local validRooms = {}

	for i = 1, #roomsList - 1 do
		local descriptor =  roomsList:Get(i)
		if descriptor.DisplayFlags & displayFlag ~= displayFlag then
			if descriptor.Data.Type == RoomType.ROOM_ULTRASECRET then
				ultraSecretDescriptor = descriptor
			else
				table.insert(validRooms, descriptor)
			end
		end
	end

	if #validRooms == 0 then
		if ultraSecretDescriptor then
			local variableDescriptor = game:GetLevel():GetRoomByIdx(ultraSecretDescriptor.SafeGridIndex)
			variableDescriptor.DisplayFlags = variableDescriptor.DisplayFlags | displayFlag
		end
	else
		local constDescriptor = validRooms[rng:RandomInt(#validRooms) + 1]
		local variableDescriptor = game:GetLevel():GetRoomByIdx(constDescriptor.SafeGridIndex)
		variableDescriptor.DisplayFlags = variableDescriptor.DisplayFlags | displayFlag
	end

	level:UpdateVisibility()
end

function mod:DoKnockoutPushback(entity, source, powerMultiplier)
	if not (entity:HasEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK) or entity:HasEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)) then
		local targetVelocity = (entity.Position - source.Position):Resized(24 * (powerMultiplier or 1))
		entity:AddVelocity(targetVelocity)
		entity:AddEntityFlags(EntityFlag.FLAG_KNOCKED_BACK)
		entity:AddConfusion(EntityRef(source), 45, false)
		sfx:Play(SoundEffect.SOUND_PUNCH)
	end
end

function mod:GetItemOfQuality(pool, qualityMinimum, rng)
	local itempool = game:GetItemPool()
	local config = Isaac.GetItemConfig()
	local collectible
	local configItem

	local highest
	local returnHighest = true

	for i = 1, 16 * qualityMinimum do
		collectible = itempool:GetCollectible(pool, false, rng:RandomInt(9e9))
		configItem = config:GetCollectible(collectible)

		if configItem.Quality >= qualityMinimum then
			returnHighest = false
			break
		elseif not highest or configItem.Quality >= config:GetCollectible(highest).Quality then
			highest = collectible
		end
	end

	if returnHighest then
		return highest or 0
	else
		mod:UniversalRemoveItemFromPools(collectible)
		return collectible
	end
end

--[[
mod.PLACEBO_CHARGES = {}
function mod:RegisterPlaceboCharge(card, charge)
	mod.PLACEBO_CHARGES[card] = charge
end

function mod:ChangePlaceboCharge(player, newCharge, slot, useflags)
	slot = slot or ActiveSlot.SLOT_PRIMARY
	useflags = useflags or UseFlag.USE_OWNED

	if useflags & UseFlag.USE_OWNED > 0 then
		local batteryCharge = player:GetBatteryCharge(slot)

		player:RemoveCollectible(CollectibleType.COLLECTIBLE_PLACEBO, false, slot)
		player:AddCollectible(CollectibleType.COLLECTIBLE_PLACEBO, 0, false, slot, newCharge)

		player:SetActiveCharge(math.min(newCharge, batteryCharge), slot)

		return {Discharge = false, ShowAnim = true}
	end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_, item, rng, player, flags, slot)
	local card = player:GetCard(0)

	if mod.PLACEBO_CHARGES[card] then
		player:UseCard(card, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC)

		local returnValue = mod:ChangePlaceboCharge(player, mod.PLACEBO_CHARGES[card], slot, flags)
		if returnValue then return returnValue end
	end
end, CollectibleType.COLLECTIBLE_PLACEBO)
 ]]

function mod:DespawnOptionsPartners(check)
	if check.OptionsPickupIndex > 0 then
		for _, pickup in pairs(Isaac.FindByType(5)) do
			pickup = pickup:ToPickup()

			if not mod:AreEntitiesSame(pickup, check) and pickup.OptionsPickupIndex == check.OptionsPickupIndex then
				Isaac.Spawn(1000, 15, 0, pickup.Position, Vector.Zero, nil)
				pickup:Remove()
			end
		end
	end
end

function mod:GetExpectedBrokenHeartsFromDamage(player)
	local playerType = player:GetPlayerType()

	if player:HasCollectible(CollectibleType.COLLECTIBLE_HEARTBREAK) then
		if mod:WillDamageBeFatal(player, 1, 0, true, true) then
			if playerType == PlayerType.PLAYER_KEEPER or playerType == PlayerType.PLAYER_KEEPER_B then
				return 1
			else
				return 2
			end
		end
	end

	return 0
end

function mod:WillDamageBeFatal(player, amount, flags, ignoreBerserk, ignoreHeartbreak, ignoreLost)
	if flags & (DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_FAKE) > 0 then
		return false
	end

	local effects = player:GetEffects()
	local playerType = player:GetPlayerType()
	local brokens = player:GetBrokenHearts()

	if not ignoreBerserk and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) then -- Option provided to ignore berserk for if your effect wants to proc on hitting 0 hp (e.g. F.O.P.)
		return false
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SHACKLES) and not effects:HasNullEffect(NullItemID.ID_SPIRIT_SHACKLES_DISABLED) then
		return false
	end

	if not ignoreHeartbreak and player:HasCollectible(CollectibleType.COLLECTIBLE_HEARTBREAK) then
		return brokens >= 12 - mod:GetExpectedBrokenHeartsFromDamage(player)
	end

	if not ignoreLost and (playerType == PlayerType.PLAYER_JACOB2_B or effects:HasNullEffect(NullItemID.ID_LOST_CURSE)) then
		return true
	end

	local bones = player:GetBoneHearts()
	local armour = player:GetSoulHearts()
	local blood = player:GetHearts() - player:GetRottenHearts()

	if (bones > 0 and armour > 0) or (armour > 0 and blood > 0) or (bones > 0 and blood > 0) or bones > 1 then
		return false
	elseif (armour > 0 and armour <= amount) or (blood > 0 and blood <= amount) or bones == 1 then
		return true
	end

	return false
end

function mod:GetGoodShootingJoystick(player)
	local returnValue = player:GetShootingJoystick()

    if player.ControllerIndex == 0 and Options.MouseControl and Input.IsMouseBtnPressed(0) then -- ControllerIndex 0 == Keyboard & Mouse
        returnValue = (Input.GetMousePosition(true) - player.Position)
    end

    return returnValue:Normalized()
end

function mod:IsPlayerMarkedFiring(player)
	return (
		player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) and
		mod:GetPlayerMarkedTarget(player)
	)
end

function mod:IsPlayerTryingToShoot(player)
	return (
		mod:GetGoodShootingJoystick(player):Length() > 0 or
		player:AreOpposingShootDirectionsPressed() or
		mod:IsPlayerMarkedFiring(player)
	)
end

function mod:GetPlayerFireVector(player)
	return mod.DirectionToVector[player:GetFireDirection()]
end

function mod:GetGoodFiringVector(player)
	if mod:IsPlayerMarkedFiring(player) or player:HasCollectible(CollectibleType.COLLECTIBLE_ANALOG_STICK) then
		return player:GetAimDirection()
	else
		return mod:GetPlayerFireVector(player)
	end
end

function mod:GetFamiliarShootingDirection(familiar) -- Return Values: (Vector) Fire Direction, (Bool) Override Movement Inheritance
	local player = familiar.Player
	local kingBabyTarget = mod:GetMyKingBabyTarget(familiar)

	if kingBabyTarget then
		return (kingBabyTarget.Position - familiar.Position):Normalized(), true
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) then
		return (mod:GetPlayerMarkedTarget(familiar.Player).Position - familiar.Position):Normalized(), true
	else
		return mod:GetPlayerFireVector(player) or mod:GetGoodShootingJoystick(player), false
	end
end

function mod:GetPlayerMarkedTarget(player, force)
	-- player:GetActiveWeaponEntity doesn't work for Marked :'(
	local data = player:GetData()
	if data.richer_MarkedTargetStorage and data.richer_MarkedTargetStorage:Exists() and not force then
		return data.richer_MarkedTargetStorage
	end

	local targets = Isaac.FindByType(1000, EffectVariant.TARGET)
	for _, target in pairs(targets) do
		if target.SpawnerEntity and target:ToEffect().State == 0 and GetPtrHash(target.SpawnerEntity) == GetPtrHash(player) then
			if player:GetAimDirection():GetAngleDegrees() == (target.Position - player.Position):GetAngleDegrees() then
				data.richer_MarkedTargetStorage = target
				return target
			end
		end
	end
end

function mod:GetMyKingBabyTarget(familiar) -- Modified version of a function by Erfly. Thanks Erfly!!
	local entity = familiar.Parent
	while entity do
		if entity.Type == 3 and entity.Variant == FamiliarVariant.KING_BABY then
			return entity.Target
		end

		entity = entity.Parent
	end
end

function mod:QuickCheckFamiliar(player, familiarVariant, itemID, subtype)
	player:CheckFamiliar(familiarVariant, mod:GetExpectedFamiliarNum(player, itemID), player:GetCollectibleRNG(itemID), mod:GetItem(itemID), subtype)
end

--[[
function mod:GetDummyNpc(position)
	local dummy = Isaac.Spawn(792, 1889, 0, position or Vector.Zero, Vector.Zero, nil):ToNPC()
	dummy:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
	return dummy
end
 ]]

function mod:GetGoodPlayerFireDirection(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) and mod:GetPlayerMarkedTarget(player) then
		return (mod:GetPlayerMarkedTarget(player).Position - player.Position):Normalized()
	else
		return mod:GetGoodShootingJoystick(player)
	end
end

function mod:TestForValidPath(start, target, dummyNpc, noRemove)
	dummyNpc = dummyNpc or mod:GetDummyNpc(start)
	dummyNpc.Position = start

	local canPath = dummyNpc.Pathfinder:HasPathToPos(target, true)
	if not noRemove then
		dummyNpc:Remove()
	end

	return canPath
end

function mod:GetSwingingKnifeHitboxScaler(knife)
	if knife.Variant == mod.KnifeVariant.BONE_SCYTHE then
		return 3
	end

	return 2
end

function mod:GetCapsulePositionRadius(knife)
	local player = knife.SpawnerEntity:ToPlayer()
	local scaler = mod:GetSwingingKnifeHitboxScaler(knife)
	local capsuleRadius = knife.Size * scaler * knife.SpriteScale.X
	local knifeVectorDirection = Vector(0, 1):Rotated(knife.SpriteRotation)
	local capsulePosition = knife.Position - knife.SpawnerEntity.Velocity + knifeVectorDirection * capsuleRadius

	return capsulePosition, capsuleRadius
end

function mod:EntityCollidesWithSwingingKnife(entity, knife)
	local position, radius = mod:GetCapsulePositionRadius(knife)
	return entity.Position:Distance(position) < entity.Size + radius
end

function mod:Benchmark(func, numTests)
	local time = Isaac.GetTime()

	for i = 1, numTests or 1000000 do
		func()
	end

	local timeDelta = Isaac.GetTime() - time
	print("Benchmark test took " .. timeDelta .. "ms for " .. (numTests and numTests or "1 million") .. " calls")
	print("That's " .. (timeDelta / (numTests or 1000000)) .. "ms per call")
end

local function swapAquarius(creep, skin)
	local sprite = creep:GetSprite()
	sprite:ReplaceSpritesheet(0, skin)
	sprite:LoadGraphics()
	sprite.Color = Color.Default
end

--[[
function mod:RecalculateAquariusSkin(effect)
	if mod:HasRicherTearFlags(effect, TearFlag) then
		swapAquarius(effect, AquariusSkin)
	end
end
 ]]

local reduce = 0
mod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.EARLY, function() reduce = 0 end, CacheFlag.CACHE_FIREDELAY)

function mod:GetTearsMultiplier(player, multiplierAmount)
	local playerType = player:GetPlayerType()
	local reduceModifer = 0
	reduce = reduce + 1
	multiplierAmount = multiplierAmount and 1 / multiplierAmount or 2

	if playerType == PlayerType.PLAYER_THEFORGOTTEN or playerType == PlayerType.PLAYER_THEFORGOTTEN_B then
		reduceModifer = 1
	end

	local fireDelayMultiplier = 1 + (multiplierAmount - 1) / (reduce + reduceModifer)
	return 1 / fireDelayMultiplier
end

function mod:IsQuestItem(itemId)
	return Isaac.GetItemConfig():GetCollectible(itemId):HasTags(ItemConfig.TAG_QUEST)
end

function mod:GetItemQuality(itemId)
	return Isaac.GetItemConfig():GetCollectible(itemId).Quality
end

function mod:GetItemConfigData(itemId, dataString)
	return Isaac.GetItemConfig():GetCollectible(itemId)[dataString]
end

function mod:GetRoomPool()
	local room = game:GetRoom()
	return math.max(0, game:GetItemPool():GetPoolForRoom(room:GetType(), room:GetAwardSeed()))
end

function mod:MorphCollectible(entity, targetItem, resetPrice, resetOptions)
	local optionsCache = entity.OptionsPickupIndex
	local waitCache = entity.Wait

	entity:Morph(5, 100, targetItem, not resetPrice, false, true)
	entity.Wait = waitCache

	if not resetOptions then
		entity.OptionsPickupIndex = optionsCache
	end

	if entity.Price > 0 then
		entity.ShopItemId = -1
	end
end

function mod:IsDimension(dimensionId)
	local level = game:GetLevel()
	local roomId = level:GetCurrentRoomIndex()

	return GetPtrHash(level:GetRoomByIdx(roomId, mod.DIMENSION.CURRENT)) == GetPtrHash(level:GetRoomByIdx(roomId, dimensionId))
end

function mod:IsDamageSacrificeSpikes(flags, source)
	return (
		source.Type == EntityType.ENTITY_NULL and
		source.Variant == GridEntityType.GRID_SPIKES and
		flags & DamageFlag.DAMAGE_SPIKES > 0 and
		game:GetRoom():GetType() == RoomType.ROOM_SACRIFICE
	)
end

function mod:IsDamageSanguineSpikes(player, flags, source)
	return (
		source.Type == EntityType.ENTITY_NULL and
		source.Variant == GridEntityType.GRID_SPIKES and
		flags & DamageFlag.DAMAGE_SPIKES > 0 and
		mod:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND) and
		game:GetRoom():GetType() == RoomType.ROOM_DEVIL and
		game:GetRoom():GetGridIndex(player.Position) == 67
	)
end

function mod:GrantNextSacrificePayout(spikes)
	spikes = spikes or game:GetRoom():GetGridEntity(67)

	if spikes then
		local rng = spikes:GetRNG()
		local level = game:GetLevel()
		local spawnPosition = spikes.Position + Vector(0, 80)

		if spikes.VarData < 2 then
			if Isaac.GetPlayer(0):GetNumBombs() == 0 and level:GetStateFlag(LevelStateFlag.STATE_SHOVEL_QUEST_TRIGGERED) then
				mod:SpawnNearPosition(5, 40, 1, spawnPosition)
			end

			if rng:RandomFloat() < 0.5 then
				mod:SpawnNearPosition(5, 20, 1, spawnPosition)
			end
		elseif spikes.VarData < 3 then
			if rng:RandomFloat() < 2/3 then
				level:AddAngelRoomChance(0.15)
				game:GetHUD():ShowFortuneText("You feel blessed!")
			end
		elseif spikes.VarData < 4 then
			if rng:RandomFloat() < 0.5 then
				mod:SpawnNearPosition(5, 50, 0, spawnPosition)
			end
		elseif spikes.VarData < 5 then
			if rng:RandomFloat() < 1/3 then
				for i = 1, 3 do
					mod:SpawnNearPosition(5, 20, 1, spawnPosition)
				end
			else
				level:AddAngelRoomChance(0.5)
				game:GetHUD():ShowFortuneText("You feel blessed!")
			end
		elseif spikes.VarData < 6 then
			if rng:RandomFloat() < 1/3 then
				level:InitializeDevilAngelRoom(true, false)
				Isaac.GetPlayer():UseCard(Card.CARD_JOKER, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
			else
				mod:SpawnNearPosition(5, 50, 0, spawnPosition)
			end
		elseif spikes.VarData < 7 then
			if game:GetDevilRoomDeals() > 0 and mod:IsItemAvailable(CollectibleType.COLLECTIBLE_REDEMPTION) and rng:RandomFloat() < 0.5 then
				mod:SpawnNearPosition(5, 100, CollectibleType.COLLECTIBLE_REDEMPTION, spawnPosition)
			else
				if rng:RandomFloat() < 1/3 then
					local item = game:GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL, true, rng:GetSeed())
					rng:Next()
					mod:SpawnNearPosition(5, 100, item, spawnPosition)
				else
					mod:SpawnNearPosition(5, 10, 3, spawnPosition)
				end
			end
		elseif spikes.VarData < 8 then
			Isaac.GetPlayer():UseCard(Card.CARD_TOWER, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
		elseif spikes.VarData < 9 then
			Isaac.Spawn(271, 0, 0, spawnPosition, Vector.Zero, nil)
		elseif spikes.VarData < 10 then
			if rng:RandomFloat() < 0.5 then
				for i = 1, 7 do
					mod:SpawnNearPosition(5, 10, 3, spawnPosition)
				end
			else
				for i = 1, 30 do
					mod:SpawnNearPosition(5, 20, 1, spawnPosition)
				end
			end
		elseif spikes.VarData < 11 then
			Isaac.Spawn(272, 0, 0, spawnPosition, Vector.Zero, nil)
		else
			if rng:RandomFloat() < 0.5 then
				game:StartStageTransition(false, 2, Isaac.GetPlayer())
			end
		end

		spikes.VarData = spikes.VarData + 1
	end
end

function mod:GrantSanguineBondPayout(player)
	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SANGUINE_BOND)
	local roll = rng:RandomFloat()
	local spikes = game:GetRoom():GetGridEntity(67)

	if roll < 0.35 then
		-- Nothing
	elseif roll < 0.68 then
		mod:IncrementCollectibleEffectNum(player, CollectibleType.COLLECTIBLE_SANGUINE_BOND)
	elseif roll < 0.83 then
		for i = 1, 6 do
			mod:SpawnNearPosition(5, 20, 1, spikes.Position)
		end
	elseif roll < 0.93 then
		for i = 1, 2 do
			mod:SpawnNearPosition(5, 10, 6, spikes.Position)
		end
	elseif roll < 0.98 then
		local item = game:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, true, rng:GetSeed())
		rng:Next()
		mod:SpawnNearPosition(5, 100, item, spikes.Position)
	else
		for i = 1, 3 do
			player:AddCollectible(CollectibleType.COLLECTIBLE_LORD_OF_THE_PIT)
		end

		for i = 1, 3 do
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_LORD_OF_THE_PIT, false, ActiveSlot.SLOT_PRIMARY, false)
		end
	end
end

function mod:SpawnNearPosition(typ, var, sub, position, velocity, spawner)
	local room = game:GetRoom()
	position = room:FindFreePickupSpawnPosition(position)

	return Isaac.Spawn(typ, var, sub, position, velocity or Vector.Zero, spawner or nil)
end

function mod:IsItemAvailable(itemId)
	return Isaac.GetItemConfig():GetCollectible(itemId):IsAvailable()
end

function mod:GetBombExplosionRadius(entityBomb) -- Thank you dataminers
	local radius
	local damage = entityBomb.ExplosionDamage

	if entityBomb:HasTearFlags(TearFlags.TEAR_GIGA_BOMB) then
		radius = 130
	elseif damage > 175 then
		radius = 105
	elseif damage > 140 then
		radius = 90
	else
		radius = 75
	end

	return radius * entityBomb.RadiusMultiplier
end

function mod:FullHeal(player)
	local bloodCharges = player:GetBloodCharge()
	player:AddHearts(100)

	if player:GetBloodCharge() ~= 0 then
		player:AddBloodCharge(bloodCharges + 12 - player:GetBloodCharge())
	end
end

function mod:HasActivePocketItem(player, item) -- Checks if the item is in ActiveSlot.SLOT_POCKET, and that no pills or cards occupy the "active" pocket slot
	return (
		player:GetActiveItem(ActiveSlot.SLOT_POCKET) == item and
		player:GetPill(0) == 0 and
		player:GetCard(0) == 0
	)
end

function mod:IsValueInTable(value, tbl)
	for _, entry in pairs(tbl) do
		if entry == value then
			return true
		end
	end
end

function mod:IsEntityInTable(tbl, entity)
	for _, entry in pairs(tbl) do
		if GetPtrHash(entry) == GetPtrHash(entity) then
			return true
		end
	end
end

function mod:BulkAppend(hostTable, appendTable)
	for _, entry in pairs(appendTable) do
		table.insert(hostTable, entry)
	end
end

function mod:IndexedBulkAppend(hostTable, appendTable)
	for _, entry in pairs(appendTable) do
		hostTable[entry[1]] = entry[2]
	end
end

function mod:DictionaryBulkAppend(hostTable, appendTable)
	for k, entry in pairs(appendTable) do
		hostTable[k] = entry
	end
end

function mod:RevealUltraSecretLocation()
	local level = game:GetLevel()
	local roomsList = level:GetRooms()

	for i = 0, #roomsList - 1 do
		local roomDesc = roomsList:Get(i)
		if roomDesc.Data and roomDesc.Data.Type == RoomType.ROOM_ULTRASECRET then
			local mutableDesc = level:GetRoomByIdx(roomDesc.SafeGridIndex)
			mutableDesc.DisplayFlags = mutableDesc.DisplayFlags | RoomDescriptor.DISPLAY_ICON
		end
	end

	level:UpdateVisibility()
end

function mod:GenerateCapsuleFromEntity(entity)
	local scaler = math.min(entity.SizeMulti.X, entity.SizeMulti.Y)
	local stretcher = math.max(entity.SizeMulti.X, entity.SizeMulti.Y)
	local trueRadius = entity.Size * scaler

	local stretchDirection = Vector.Zero
	if entity.SizeMulti.X > entity.SizeMulti.Y then stretchDirection = Vector(1, 0) end
	if entity.SizeMulti.Y > entity.SizeMulti.X then stretchDirection = Vector(0, 1) end

	local locusOffset = stretchDirection * (stretcher * entity.Size - trueRadius)

	return {
		Locus1 = entity.Position + locusOffset:Rotated(entity.SpriteRotation),
		Locus2 = entity.Position - locusOffset:Rotated(entity.SpriteRotation),
		Radius = trueRadius,
	}
end

function mod:DoEntitiesIntersect(entity1, entity2)
	return mod:SimulateCapsuleCapsuleCollision(
		mod:GenerateCapsuleFromEntity(entity1),
		mod:GenerateCapsuleFromEntity(entity2)
	)
end

function mod:SimulateCapsuleCapsuleCollision(capsule1, capsule2)
	local capsules = {capsule1, capsule2}

	for i, hostCapsule in pairs(capsules) do
		local testCapsule = capsules[i % 2 + 1]
		for _, point in pairs({testCapsule.Locus1, testCapsule.Locus2}) do
			local closestPoint = mod:GetClosestPointOnLine(point, hostCapsule.Locus1, hostCapsule.Locus2)
			local distance = mod:TruncateDecimals(closestPoint:Distance(point), 3)
			-- print("\nLine:", testCapsule.Locus1, testCapsule.Locus2, "\nPoint:", point, "\nClosest:", closestPoint, "\nDistance:", distance)

			if distance <= hostCapsule.Radius + testCapsule.Radius then
				return true
			end
		end
	end

	return false
end

function mod:GetClosestPointOnLine(testPosition, lineOrigin, lineEnd)
	local heading = lineEnd - lineOrigin
	local magnitude = heading:Length()
	heading:Normalize()

	local lhs = testPosition - lineOrigin
	local dot = lhs:Dot(heading)
	dot = mod:Bound(dot, 0, magnitude)
	return lineOrigin + heading * dot
end

function mod:TruncateDecimals(value, numDigits)
	local whole = math.floor(value)
	local totalDigits = string.len(tostring(whole)) + numDigits + 1
	local truncatedString = string.sub(tostring(value), 1,  totalDigits)
	return tonumber(truncatedString)
end

function mod:GetItemSlot(player, item)
	for slot = ActiveSlot.SLOT_PRIMARY, ActiveSlot.SLOT_POCKET do
		if player:GetActiveItem(slot) == item then
			return slot
		end
	end
end

function mod:PostCollectHeart()
	game:GetLevel():SetHeartPicked()
	game:ClearStagesWithoutHeartsPicked()
	game:SetStateFlag(GameStateFlag.STATE_HEART_BOMB_COIN_PICKED, true)
end

function mod:PostCollectCoin()
	game:SetStateFlag(GameStateFlag.STATE_HEART_BOMB_COIN_PICKED, true)
end

function mod:PostCollectBomb()
	game:SetStateFlag(GameStateFlag.STATE_HEART_BOMB_COIN_PICKED, true)
end

local textSplahes = {}
local defaultSplashColour = KColor(1, 1, 1, 1, 0, 0, 0)
local defaultSplashDuration = 60
local splashFadeSpeed = 6
local splashFont = Font()
splashFont:Load("font/luaminioutlined.fnt")

function mod:AddFlavourText(text, worldPosition, duration, delay, colour, font)
	table.insert(textSplahes, {
		Text = text,
		Position = worldPosition,
		Duration = duration or defaultSplashDuration,
		Colour = colour or defaultSplashColour,
		InitFrame = game:GetFrameCount() + (delay or 0),
		Font = font or splashFont,
	})
end

local function getFadeAlpha(timeDelta, duration)
	return math.min(1, duration / (4 * splashFadeSpeed) - (timeDelta - duration / 2)^2 / (duration * splashFadeSpeed))
	-- Thank you desmos <3
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	for i = #textSplahes, 1, -1 do
		local data = textSplahes[i]
		local timeDelta = game:GetFrameCount() - data.InitFrame

		if timeDelta > 0 then
			local room = game:GetRoom()
			local screenPosition = room:WorldToScreenPosition(data.Position)
			local colour = KColor(data.Colour.Red, data.Colour.Green, data.Colour.Blue, getFadeAlpha(timeDelta, data.Duration))
			data.Font:DrawString(data.Text, screenPosition.X, screenPosition.Y - timeDelta / 4, colour, 1, true)
		end

		if timeDelta >= data.Duration then
			table.remove(textSplahes, i)
		end
	end
end)

function mod:GetEffectiveMaxCharge(player, slot)
	local item = player:GetActiveItem(slot)
	if item then
		local configItem = mod:GetItem(item)
		local multiplier = 1

		if player:HasCollectible(CollectibleType.COLLECTIBLE_BATTERY) then
			multiplier = 2
		end

		return configItem.MaxCharges * multiplier, configItem.MaxCharges
	end
end

function mod:AddCharges(player, slot, numCharges) -- Returns bool: hitFullCharge
	local current = player:GetActiveCharge(slot) + player:GetBatteryCharge(slot)
	local chargeCap, capIncrement = mod:GetEffectiveMaxCharge(player, slot)
	local newCharge = mod:Bound(current + numCharges, 0, chargeCap)

	player:SetActiveCharge(newCharge, slot)
	game:GetHUD():FlashChargeBar(player, slot)
	return newCharge % capIncrement == 0 and newCharge ~= current
end

function mod:QuickSpawn(entityName, position)
	Isaac.Spawn(Isaac.GetEntityTypeByName(entityName), Isaac.GetEntityVariantByName(entityName), 0, position, Vector.Zero, nil)
end

local function countVisibleConnections(originIndex)
	local level = game:GetLevel()
	local connections = 0

	for _, index in pairs({originIndex - 1, originIndex + 1, originIndex - 13, originIndex + 13}) do
		local desc = level:GetRoomByIdx(index)
		if desc.Data and desc.Data.Type ~= RoomType.ROOM_SECRET and desc.Data.Type ~= RoomType.ROOM_SUPERSECRET then
			connections = connections + 1
		end
	end

	return connections
end

function mod:GetDeadEnd(rng)
	local deadEnds = {}
	local level = game:GetLevel()
	local roomsList = level:GetRooms()

	for i = 0, #roomsList - 1 do
		local desc = roomsList:Get(i)
		if desc.Data.Type == RoomType.ROOM_DEFAULT and desc.Data.Shape == RoomShape.ROOMSHAPE_1x1 and countVisibleConnections(desc.SafeGridIndex) == 1 then
			table.insert(deadEnds, desc)
		end
	end

	return deadEnds[rng:RandomInt(#deadEnds) + 1].SafeGridIndex
end

function mod:TeleportToDoorSlot(player, slot, force)
	if player:IsExtraAnimationFinished() or force then
		local offset = Vector(40, 0):Rotated(slot * 90)
		local base = game:GetRoom():GetDoorSlotPosition(slot)
		local targetPosition = base + offset

		player:StopExtraAnimation()
		player:GetData().richer_GenericTeleportTargetLocation = targetPosition
		player:AnimateTeleport(true)
		player.Velocity = Vector.Zero
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function(_, player)
	local data = player:GetData()
	if player:IsExtraAnimationFinished() and data.richer_GenericTeleportTargetLocation then
		player.Position = data.richer_GenericTeleportTargetLocation
		data.richer_GenericTeleportTargetLocation = nil
		player:AnimateTeleport(false)
		sfx:Play(SoundEffect.SOUND_HELL_PORTAL1)
	end
end)

local schedule = {}
function mod:Schedule(func, delay)
	table.insert(schedule, {
		Call = func,
		TimeToCall = game:GetFrameCount() + delay,
	})
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	for i = #schedule, 1, -1 do
		local data = schedule[i]
		if data.TimeToCall <= game:GetFrameCount() then
			data.Call()
			table.remove(schedule, i)
		end
	end
end)

function mod:SpawnEmptyItemPedestal(position, spawner)
	local pedestal = Isaac.Spawn(5, 100, 0, position, Vector.Zero, spawner):ToPickup()
	pedestal.SubType = 0
	pedestal:GetSprite():Play("Empty")
	pedestal.Touched = true
	pedestal:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
	pedestal:Update()

	return pedestal
end

function mod:PlayerHasEmptyActiveSlot(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_SCHOOLBAG) then
		return player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == 0
	else
		return player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == 0
	end
end

function mod:SimulateSpindownDice(currentId)
	local config = Isaac.GetItemConfig()

	repeat
		currentId = currentId - 1
	until currentId == 0 or (
		ItemConfig.Config.IsValidCollectible(currentId) and
		config:GetCollectible(currentId):IsAvailable() and
		not config:GetCollectible(currentId).Hidden
	)

	return currentId
end

function mod:FormatDuration(frames)
	local hours = math.floor(frames / 30 / 60 / 60)
	frames = frames - hours * 60 * 60 * 30
	hours = tostring(hours)
	if string.len(hours) == 1 then hours = "0" .. hours end

	local minutes = math.floor(frames / 30 / 60)
	frames = frames - minutes * 60 * 30
	minutes = tostring(minutes)
	if string.len(minutes) == 1 then minutes = "0" .. minutes end

	local seconds = math.floor(frames / 30)
	seconds = tostring(seconds)
	if string.len(seconds) == 1 then seconds = "0" .. seconds end

	return hours .. ":" .. minutes .. ":" .. seconds
end

function mod:RNG(seed, shiftIndex)
	local rng = RNG()
	rng:SetSeed(seed, shiftIndex or 35)
	return rng
end

mod.PhdEffectMap = {
	[PillEffect.PILLEFFECT_HEALTH_DOWN] = 		PillEffect.PILLEFFECT_HEALTH_UP,
	[PillEffect.PILLEFFECT_RANGE_DOWN] = 		PillEffect.PILLEFFECT_RANGE_UP,
	[PillEffect.PILLEFFECT_SPEED_DOWN] = 		PillEffect.PILLEFFECT_SPEED_UP,
	[PillEffect.PILLEFFECT_TEARS_DOWN] = 		PillEffect.PILLEFFECT_TEARS_UP,
	[PillEffect.PILLEFFECT_LUCK_DOWN] = 		PillEffect.PILLEFFECT_LUCK_UP,
	[PillEffect.PILLEFFECT_SHOT_SPEED_DOWN] = 	PillEffect.PILLEFFECT_SHOT_SPEED_UP,
	[PillEffect.PILLEFFECT_AMNESIA] = 			PillEffect.PILLEFFECT_SEE_FOREVER,
	[PillEffect.PILLEFFECT_QUESTIONMARK] =		PillEffect.PILLEFFECT_TELEPILLS,
	[PillEffect.PILLEFFECT_ADDICTED] =			PillEffect.PILLEFFECT_PERCS,
	[PillEffect.PILLEFFECT_IM_EXCITED] =		PillEffect.PILLEFFECT_IM_DROWSY,
	[PillEffect.PILLEFFECT_PARALYSIS] =			PillEffect.PILLEFFECT_PHEROMONES,
	[PillEffect.PILLEFFECT_RETRO_VISION] = 		PillEffect.PILLEFFECT_SEE_FOREVER,
	[PillEffect.PILLEFFECT_X_LAX] =				PillEffect.PILLEFFECT_SOMETHINGS_WRONG,
	[PillEffect.PILLEFFECT_BAD_TRIP] =			PillEffect.PILLEFFECT_BALLS_OF_STEEL,
}

function mod:GetPhdPill(effect)
	return mod.PhdEffectMap[effect] or effect
end

local rainbowFragments = {
	{Progress = 0, 		Colour = Color(255 / 255,   0 / 255,   4 / 255)},
	{Progress = 0.221, 	Colour = Color(255 / 255, 214 / 255,  47 / 255)},
	{Progress = 0.401, 	Colour = Color(251 / 255, 255 / 255,   6 / 255)},
	{Progress = 0.566, 	Colour = Color( 28 / 255, 255 / 255,  26 / 255)},
	{Progress = 0.699, 	Colour = Color( 44 / 255,  93 / 255, 255 / 255)},
	{Progress = 0.897,	Colour = Color(255 / 255,  25 / 255, 252 / 255)},
	{Progress = 1, 		Colour = Color(255 / 255,   0 / 255,   4 / 255)},
}

function mod:GetRainbowColour(progress) -- Progress is a float from 0-1
	progress = progress % 1

	local currentIndex = 1
	for i, data in pairs(rainbowFragments) do
		if data.Progress <= progress and rainbowFragments[i + 1].Progress > progress then
			currentIndex = i
			break
		end
	end

	local fragmentOne = rainbowFragments[currentIndex]
	local fragmentTwo = rainbowFragments[currentIndex + 1]
	local lerpPercent = (progress - fragmentOne.Progress) / (fragmentTwo.Progress - fragmentOne.Progress)
	return Color.Lerp(fragmentOne.Colour, fragmentTwo.Colour, lerpPercent)
end

function mod:DeepClone(toClone, cloneTo)
	local returnTable = cloneTo or {}

	for index, value in pairs(toClone) do
		if type(value) == "table" and index ~= "SpawnData" then -- :( Fiend Folio????
			returnTable[index] = mod:DeepClone(value)
		else
			returnTable[index] = value
		end
	end

	return returnTable
end

function mod:CloneEntityData(host, target)
	local hostData = host:GetData()
	local targetData = target:GetData()
	mod:DeepClone(hostData, targetData)
end

function mod:CloneColour(colour)
	return Color(
		colour.R,
		colour.G,
		colour.B,
		colour.A,
		colour.RO,
		colour.GO,
		colour.BO
	)
end

function mod:EdgeDistance(entity1, entity2)
	return entity1.Position:Distance(entity2.Position) - entity1.Size - entity2.Size
end

function mod:SanitiseTrinket(id)
	return id & TrinketType.TRINKET_ID_MASK
end

function mod:RandomVectorEX(length, randomiseToLength)
	if randomiseToLength then
		local lerp = Random() / 2^32
		length = length * lerp
	end

	return RandomVector():Resized(length)
end

function mod:AddBurnEx(target, player, duration, damage)
	if not target:HasEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS) then
		target:AddBurn(EntityRef(player), duration or 60, damage or player:GetTearPoisonDamage())
	end
end

function mod:AddPoisonEx(target, player, duration, damage)
	if not target:HasEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS) then
		target:AddPoison(EntityRef(player), duration or 60, damage or player:GetTearPoisonDamage())
	end
end

function mod:AddCharmEx(target, player, duration)
	if not target:HasEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS) then
		target:AddCharmed(EntityRef(player), duration or 150)
	end
end

function mod:AddConfusionEx(target, player, duration)
	if not target:HasEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS) then
		target:AddConfusion(EntityRef(player), duration or 90)
	end
end

function mod:SetFamiliarFireCooldown(familiar, delay)
	if familiar.Player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
		familiar.FireCooldown = math.floor(delay / 2)
	else
		familiar.FireCooldown = delay
	end
end



















local function clearCaches()
	mod.roomEntitiesCache = nil
	mod.roomPlayersCache = nil
	mod.isTakingDamage = nil
	mod.isTakingPenaltyDamage = nil
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, clearCaches)
mod:AddCallback(ModCallbacks.MC_POST_GAME_END, clearCaches)
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, clearCaches)