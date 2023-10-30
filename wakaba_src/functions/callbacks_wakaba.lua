
local game = Game()

function wakaba.SetCallbackMatchTest(callbackID, func)
	local callbacks = Isaac.GetCallbacks(callbackID, true)
	setmetatable(callbacks, {
		__index = getmetatable(callbacks),
		__matchParams = func,
	})
end

---@enum WakabaCallbacks
---@display wakaba.Callback
wakaba.Callback = {

	ROOM_GENERATION = {},

	-- ---
	-- POST_GET_COLLECTIBLE
	-- ---
	-- Original callback code from bogdanrudyka
	--
	-- Called from POST_PEFFECT_UPDATE, when item quantity changed, and player picks it from the first time.
	--
	-- ---
	-- Parameters :
	-- - `EntityPlayer` - player that got an item.
	-- - `collectibleType` - Acquired collectible.
	-- ---
	POST_GET_COLLECTIBLE = {},

	-- ---
	-- RENDER_GLOBAL_FOUND_HUD
	-- ---
	-- Original code from Peachee(Planetarium chance), Xalum(Retribution)
	--
	-- Called from POST_RENDER, rendering Found HUD Elements
	--
	-- If returned value is a table that contains with both elements, HUD will render with character stats
	--
	--
	-- ---
	-- Returned values : Retruns with table with following elements
	-- - `Sprite` : `Sprite` - Sprite to render
	-- - `Text` : `String` - Text to render next to sprite
	-- - `TextColor`(optional) : `KColor` - Text to render next to sprite
	-- - `Skip`(optional) : `boolean` - Only available if Sprite, and Text isn't present. Return to shift HUD element offset by 1
	-- ---
	RENDER_GLOBAL_FOUND_HUD = {},

	ANY_WEAPON_FIRE = {},

	-- ---
	-- REAL_FIRE_TEAR
	-- ---
	-- Original code from Xalum(Retribution)
	--
	--
	--
	-- Parameters :
	-- - `EntityTear` - tear
	-- - `EntityPlayer` - player
	-- ---
	REAL_FIRE_TEAR = {},

	-- ---
	-- WISP_FIRE_TEAR
	-- ---
	-- Original code from Xalum(Retribution)
	--
	--
	--
	-- Parameters :
	-- - `EntityTear` - tear
	-- - `EntityFamiliar` - wisp
	-- - `CollectibleType` - itemID
	-- ---
	WISP_FIRE_TEAR = {},


	EVALUATE_WAKABA_TEARFLAG = {},


	-- ---
	-- PRE_SWING_BONE_CLUB
	-- ---
	-- Original code from Xalum(Retribution)
	--
	--
	--
	-- Parameters :
	-- - `EntityKnife` - club
	-- - `EntityPlayer` - player
	-- ---
	PRE_SWING_BONE_CLUB = {},

	-- ---
	-- POST_THROW_KNIFE
	-- ---
	-- Original code from Xalum(Retribution)
	--
	--
	--
	-- Parameters :
	-- - `EntityKnife` - knife
	-- - `EntityPlayer` - player
	-- ---
	POST_THROW_KNIFE = {},

	-- ---
	-- POST_CATCH_KNIFE
	-- ---
	-- Original code from Xalum(Retribution)
	--
	--
	--
	-- Parameters :
	-- - `EntityKnife` - knife
	-- - `EntityPlayer` - player
	-- ---
	POST_CATCH_KNIFE = {},

	-- ---
	-- APPLY_TEARFLAG_EFFECT
	-- ---
	-- Original code from Xalum(Retribution)
	--
	--
	--
	-- Parameters :
	-- - `EntityPlayer` - player
	-- ---
	APPLY_TEARFLAG_EFFECT = {},

	-- ---
	-- EVALUATE_DAMAGE_AMOUNT
	-- ---
	-- Original code from Xalum(Retribution)
	--
	-- Called from MC_ENTITY_TAKE_DMG with -20000 priority. Changes damage value taken. Doesn't affect if the damage doesn't allow Modifiers.
	--
	-- ---
	-- Parameters :
	-- - `EntityPlayer` - victim
	-- - `Float` - amount
	-- - `DamageFlag` - damage flags
	-- - `EnriryRef` - source
	-- - `Int` - cooldown
	-- ---
	-- Returned values :
	-- - `newAmount` : `EntityPlayer` - victim
	-- - `newFlags` : `DamageFlag` - new damage to be taken
	-- ---
	EVALUATE_DAMAGE_AMOUNT = {},

	-- ---
	-- TRY_NEGATE_DAMAGE
	-- ---
	-- Original code from Xalum(Retribution)
	--
	-- Called from MC_ENTITY_TAKE_DMG with -19000 priority. Sets whether the damage should be negated.
	--
	-- ---
	-- Parameters :
	-- - `EntityPlayer` - victim
	-- - `Float` - amount
	-- - `DamageFlag` - damage flags
	-- - `EnriryRef` - source
	-- - `Int` - cooldown
	-- ---
	-- Returned values :
	-- - `shouldNegateDamage` : `boolean` - victim
	-- ---
	TRY_NEGATE_DAMAGE = {},

	-- ---
	-- POST_TAKE_DAMAGE
	-- ---
	-- Original code from Xalum(Retribution)
	--
	-- Called from MC_ENTITY_TAKE_DMG with 20000 priority. Runs if player should take the damage.
	--
	-- ---
	-- Parameters :
	-- - `EntityPlayer` - victim
	-- - `Float` - amount
	-- - `DamageFlag` - damage flags
	-- - `EnriryRef` - source
	-- - `Int` - cooldown
	-- ---
	POST_TAKE_DAMAGE = {},

	-- Extra callbacks exclusive to Pudding & Wakaba

	-- ---
	-- PRE_GET_SHIORI_BOOKS
	-- ---
	-- Called right before Shiori's bookshelf is selected.
	--
	-- ---
	-- Parameters :
	-- - `EntityPlayer` - used player. Mostly Shiori.
	-- - `bookshelfFlags` - Bookshelf group to select.
	-- ---
	-- - Return `true|false` to set whether a book should be chosen.
	PRE_GET_SHIORI_BOOKS = {},
	POST_GET_SHIORI_BOOKS = {},

	-- ---
	-- PRE_EVALUATE_SOUL_OF_SHIORI
	-- ---
	-- Called from MC_USE_CARD, right player using Soul of Shiori.
	--
	-- ---
	-- Parameters :
	-- - `collectibleType` - used active item.
	-- - `EntityPlayer` - used player. Mostly Shiori.
	-- ---
	-- - Return non-nil values other than `false` will prevent the collectible to be selected.
	PRE_EVALUATE_SOUL_OF_SHIORI = {},
	-- ---
	-- PRE_CHANGE_SHIORI_EFFECT
	-- ---
	-- Called from MC_USE_ITEM, right before Shiori, or player with Book of Shiori uses an active item. returned values does NOT affect any callbacks from POST_ACTIVATE_SHIORI_EFFECT.
	--
	-- ---
	-- Parameters :
	-- - `collectibleType` - used active item.
	-- - `rng` - RNG from using item.
	-- - `EntityPlayer` - used player. Mostly Shiori.
	-- - `useflag` - UseFlags.
	-- - `activeSlot` - active slot that used from.
	-- - `vardata` - custom VarData from active item.
	-- ---
	-- - Return `true` to reset secondary Shiori effects. and skip all remaning callbacks
	-- - Return `false` to not change secondary Shiori effects. and skip all remaning callbacks
	-- - Return `collectbleType` to hijack secondary Shiori effects.
	PRE_CHANGE_SHIORI_EFFECT = {},
	-- ---
	-- POST_CHANGE_SHIORI_EFFECT
	-- ---
	-- Called from MC_USE_ITEM, right after Shiori, or player with Book of Shiori uses an active item. DOES affected from PRE_CHANGE_SHIORI_EFFECT returned values.
	--
	-- ---
	-- Parameters :
	-- - `collectibleType` - used active item.
	-- - `rng` - RNG from using item.
	-- - `EntityPlayer` - used player. Mostly Shiori.
	-- - `useflag` - UseFlags.
	-- - `activeSlot` - active slot that used from.
	-- - `vardata` - custom VarData from active item.
	POST_CHANGE_SHIORI_EFFECT = {},
	-- ---
	-- POST_CHANGE_SHIORI_EFFECT
	-- ---
	-- Called from MC_USE_ITEM, right after Shiori, or player with Book of Shiori uses an active item. Does NOT affected from PRE_CHANGE_SHIORI_EFFECT returned values.
	--
	-- ---
	-- Parameters :
	-- - `collectibleType` - used active item.
	-- - `rng` - RNG from using item.
	-- - `EntityPlayer` - used player. Mostly Shiori.
	-- - `useflag` - UseFlags.
	-- - `activeSlot` - active slot that used from.
	-- - `vardata` - custom VarData from active item.
	POST_ACTIVATE_SHIORI_EFFECT = {},

	-- ---
	-- PRE_EVALUATE_CRYSTAL_RESTOCK
	-- ---
	-- Called from isc.ModCallbackCustom.POST_SLOT_INIT, right before initializing Crystal Restock Machine for the first time.
	--
	-- ---
	-- Parameters :
	-- - `Entity` - crystal restock entity.
	--
	-- ---
	-- Returned values : Retruns with table with following elements
	-- - `ExtraCount` : `integer` - extra counts for rerolls
	-- - `SubType` : `CrystalRestockSubtype` - subType to change into
	PRE_EVALUATE_CRYSTAL_RESTOCK = {},

	-- ---
	-- PRE_EVALUATE_AQUA_TRINKET
	-- ---
	-- Called from MC_POST_PICKUP_INIT, right before initializing Aqua Trinkets should be set
	--
	-- ---
	-- Parameters :
	-- - `TrinketType` -
	--
	-- ---
	-- Returned values : Retruns with table with following elements
	-- - `shouldPreventAqua` : `boolean` -
	PRE_EVALUATE_AQUA_TRINKET = {},

	-- ---
	-- EVALUATE_CHIMAKI_COMMAND
	-- ---
	-- Called from MC_FAMILIAR_UPDATE, to choose which command to be used
	--
	-- ---
	-- Parameters :
	-- - `ChimakiCommandType` -
	--
	-- ---
	EVALUATE_CHIMAKI_COMMAND = {},

	-- ---
	-- CHIMAKI_COMMAND
	-- ---
	-- Called from MC_FAMILIAR_UPDATE, binded per command
	--
	-- ---
	-- Parameters :
	-- - `ChimakiCommandType` -
	--
	-- ---
	CHIMAKI_COMMAND = {},
}

wakaba.SetCallbackMatchTest(wakaba.Callback.POST_GET_COLLECTIBLE, function(a, b) -- TMTRAINER makes ID=-1 items, which bypasses the old match test
	return not a or not b or a == b
end)

---comment
---@param player EntityPlayer
---@param count int
function wakaba:addNemesisCount(player, count, damageOnly)
	wakaba:GetPlayerEntityData(player)
	count = count or 1
	if count > 0 then
		player:GetData().wakaba.nemesisdmg = (player:GetData().wakaba.nemesisdmg or 0) + (10.8 * count)
		if not damageOnly then
			player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.WAKABAS_NEMESIS, false, count)
		end
	end

	player:AddCacheFlags(CacheFlag.CACHE_ALL - CacheFlag.CACHE_FAMILIARS)
	player:EvaluateItems()
end

--Legacy function
function wakaba.addPostItemGetFunction(self, _func, _item)
	wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, _func, _item)
end

--Post Get Collectible
function wakaba:playerItemsArrayInit(player)
	local data = player:GetData()
	data.w_heldItems = {}
	local itemSize = Isaac.GetItemConfig():GetCollectibles().Size - 1
	for item = 1, itemSize do
		data.w_heldItems[item] = 0
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.playerItemsArrayInit)

function wakaba:playerItemsArrayUpdate(player)
	if player:IsCoopGhost() then return end
	local data = player:GetData()
	local itemSize = Isaac.GetItemConfig():GetCollectibles().Size - 1
	local queuedItem = player.QueuedItem
	if data.w_heldItems then
		for item = 1, itemSize do
			local beforeHeld = queuedItem.Touched
			if (data.w_heldItems[item] < player:GetCollectibleNum(item, true)) then
				if player.FrameCount > 7 and not beforeHeld then --do not trigger on game continue. it still updates the count tho, so this allows us not to use savedata
					Isaac.RunCallbackWithParam(wakaba.Callback.POST_GET_COLLECTIBLE, item, player, item)
				end
				--increase by 1
				data.w_heldItems[item] = data.w_heldItems[item] + 1
			elseif (data.w_heldItems[item] > player:GetCollectibleNum(item, true)) then
				data.w_heldItems[item] = player:GetCollectibleNum(item, true)
			end
		end
	else
		--if not initialized for some reason
		--inventoryDataSet(player)
		data.w_heldItems = {}
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.playerItemsArrayUpdate)

function wakaba:IsLudoTear(weapon, onlyTear)
	if not weapon then return false end
	if onlyTear and weapon.Type ~= EntityType.ENTITY_TEAR then return false end
	if not weapon.TearFlags then return false end

	return weapon:HasTearFlags(TearFlags.TEAR_LUDOVICO)
end

-- Real Fire Tear
-- Evaluate Wakaba Tearflag
function wakaba:TearUpdate_Callbacks(tear)
	local data = tear:GetData()
	if not data.calledWakabaFireTearCallbacks then
		if tear.FrameCount < 1 and tear.Parent then
			if tear.Parent.Type == 1 or (tear.Parent.Type == 3 and (tear.Parent.Variant == 80 or tear.Parent.Variant == 235 or tear.Parent.Variant == 240)) then
				local query = tear.Parent:ToFamiliar()
				local player = (query and query.Player or tear.Parent):ToPlayer()
				data.calledWakabaFireTearCallbacks = true
				Isaac.RunCallback(wakaba.Callback.REAL_FIRE_TEAR, tear, player)
				if tear:HasTearFlags(TearFlags.TEAR_LUDOVICO) and player then
					data.wakabaTearCheckPlayer = player
				end
			end
		elseif tear.FrameCount == 1 and tear.Parent then
			if tear.Parent.Type == 3 then
				if tear.Parent.Variant == 81 then
					Isaac.RunCallback(wakaba.Callback.REAL_FIRE_TEAR, tear, tear.Parent:ToFamiliar().Player)
					if tear:HasTearFlags(TearFlags.TEAR_LUDOVICO) and tear.Parent:ToFamiliar().Player then
						data.wakabaTearCheckPlayer = tear.Parent:ToFamiliar().Player
					end
				elseif tear.Parent.Variant == FamiliarVariant.WISP then
					Isaac.RunCallbackWithParam(wakaba.Callback.WISP_FIRE_TEAR, tear.Parent.SubType, tear, tear.Parent:ToFamiliar())
				end

				data.calledWakabaFireTearCallbacks = true
			end
		end
	elseif data.wakabaTearCheckPlayer and tear.FrameCount % 5 == 0 then
		data.wakaba_TearEffectEntityBlacklist = {}
		Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, tear, data.wakabaTearCheckPlayer)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_Callbacks)

-- Any Weapon Fire
wakaba:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, function(_, tear)
	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if player then
		Isaac.RunCallback(wakaba.Callback.ANY_WEAPON_FIRE, player)
		Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, tear, player)
	end
end)

wakaba:AddCallback(ModCallbacks.MC_POST_LASER_INIT, function(_, laser)
	local var = laser.Variant
	if var == 4 or var == 7 or var == 8 or var == 13 then -- Pride, Tractor Beam, Circle of Protection and Beast Lasers
		return
	end

	if laser.SpawnerEntity and laser.SpawnerEntity.Type == EntityType.ENTITY_PLAYER and var == 2 and laser.SubType == 0 then
		local familiars = Isaac.FindInRadius(laser.Position, 0.000001, EntityPartition.FAMILIAR)
		for _,familiar in ipairs(familiars) do
			if familiar.Variant == FamiliarVariant.FINGER then
				return
			end
		end
	end

	local player = nil
	if laser.SpawnerEntity and laser.SpawnerEntity:ToPlayer() then
		player = laser.SpawnerEntity:ToPlayer()
	elseif laser.SpawnerEntity and laser.SpawnerEntity:ToFamiliar() and laser.SpawnerEntity:ToFamiliar().Player then
		local familiar = laser.SpawnerEntity:ToFamiliar()

		if familiar.Variant == FamiliarVariant.INCUBUS or familiar.Variant == FamiliarVariant.SPRINKLER or
			familiar.Variant == FamiliarVariant.TWISTED_BABY or familiar.Variant == FamiliarVariant.BLOOD_BABY or
			familiar.Variant == FamiliarVariant.UMBILICAL_BABY or familiar.Variant == FamiliarVariant.CAINS_OTHER_EYE 
		then
			player = familiar.Player
		else
			return
		end
	else
		return
	end
	Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, laser, player)
end)

wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, function(_, laserEndpoint)
	if laserEndpoint.SpawnerEntity and laserEndpoint.SpawnerEntity.Type == EntityType.ENTITY_LASER then
		local laser = laserEndpoint.SpawnerEntity
		local var = laser.Variant
		local subt = laser.SubType
		if (var == 1 and subt == 3) or var == 5 or var == 12 then -- Maw of the Void, Revelation and Montezuma's Revenge lasers
			-- do nothing
		else
			local endpointData = laserEndpoint:GetData()
			local laserData = laser:GetData()

			--Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, laser, player, nil, true)
		end
	end
end, EffectVariant.LASER_IMPACT)

wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, function(_, brimball)
	local player = nil
	if brimball.SpawnerEntity and brimball.SpawnerEntity:ToPlayer() then
		player = brimball.SpawnerEntity:ToPlayer()
	else
		return
	end

	--Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, laser, player, nil, true)
end, EffectVariant.BRIMSTONE_BALL)

wakaba:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, function(_, laser)
	local player = laser.SpawnerEntity and laser.SpawnerEntity:ToPlayer()
	if player then
		if laser.FrameCount == 1 then
			Isaac.RunCallback(wakaba.Callback.ANY_WEAPON_FIRE, player)
			Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, laser, player)
		elseif not laser.OneHit then
			Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, laser, player)
		end
	end
end)

wakaba:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, function(_, bomb)
	if bomb.FrameCount == 1 and bomb.IsFetus then
		local player = bomb.SpawnerEntity and bomb.SpawnerEntity:ToPlayer()
		if player then
			Isaac.RunCallback(wakaba.Callback.ANY_WEAPON_FIRE, player)
			Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, bomb, player)
		end
	end
end)

wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, function(_, knife)
	local player = knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer()

	if player then
		if wakaba:IsKnifeSwingable(knife) then
			if knife.Variant ~= wakaba.KnifeVariant.BAG_OF_CRAFTING and knife.Variant ~= wakaba.KnifeVariant.TECH_SWORD then -- Tech sword procs through LASER_INIT
				if wakaba:IsKnifeSwinging(knife) then
					local sprite = knife:GetSprite()
					local pass

					if knife.Variant == wakaba.KnifeVariant.SPIRIT_SWORD then
						pass = sprite:IsEventTriggered("SwingEnd")
					else
						pass = sprite:GetFrame() == 8
					end

					if pass then
						Isaac.RunCallback(wakaba.Callback.ANY_WEAPON_FIRE, player)
						--Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, knife, player)
					end
				end
			end
		else
			local data = knife:GetData()
			if data.flyinglastframe and not knife:IsFlying() then
				Isaac.RunCallback(wakaba.Callback.ANY_WEAPON_FIRE, player)
				--Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, knife, player)
			end

			data.flyinglastframe = knife:IsFlying()
		end
	end
end)

wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)
	local player = effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer()
	if player then
		if not effect:Exists() then
			Isaac.RunCallback(wakaba.Callback.ANY_WEAPON_FIRE, player)
		elseif effect.FrameCount == 1 then
			Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, effect, player)
		end
	end
end, EffectVariant.ROCKET) -- Epic Fetus

wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)
	if not effect:Exists() then
		local player = effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer()
		if player then
			--Isaac.RunCallback(wakaba.Callback.ANY_WEAPON_FIRE, player)
			Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, effect, player)
		end
	end
end, EffectVariant.SMALL_ROCKET) -- Epic Fetus Forgotten


local function isKnifeVariantValidForEffects(variant)
	return (
		variant == wakaba.KnifeVariant.BONE_CLUB or
		variant == wakaba.KnifeVariant.BONE_SCYTHE or
		variant == wakaba.KnifeVariant.SPIRIT_SWORD or
		variant == wakaba.KnifeVariant.TECH_SWORD or
		variant == wakaba.KnifeVariant.DONKEY_JAWBONE
	)
end


wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, function(_, knife)
	if knife.SpawnerEntity and knife.SpawnerEntity.Type <= 3 and isKnifeVariantValidForEffects(knife.Variant) and wakaba:IsKnifeSwinging(knife) then
		local frame = knife:GetSprite():GetFrame()
		local player = knife.SpawnerEntity:ToPlayer() or knife.SpawnerEntity:ToFamiliar().Player

		if frame == 0 then
			Isaac.RunCallback(wakaba.Callback.PRE_SWING_BONE_CLUB, knife, player)
			Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, knife, player)
		end

		if frame > 1 and frame < 9 then
			local data = knife:GetData()
			data.wakaba_TearEffectEntityBlacklist = data.wakaba_TearEffectEntityBlacklist or {}

			wakaba:ForAllEntities(function(entity)
				if wakaba:EntityCollidesWithSwingingKnife(entity, knife) then
					if wakaba:ShouldEntityGetKnifeCollisionEffects(entity, knife) then
						data.wakaba_TearEffectEntityBlacklist[entity.InitSeed] = true

						for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.APPLY_TEARFLAG_EFFECT)) do
							if wakaba:HasRicherTearFlags(knife, callbackData.Param) then
								local newEntity = callbackData.Function(callbackData.Mod, entity, player, knife)

								if newEntity then
									entity = newEntity
								end
							end
						end
					end
--[[
					if entity:ToPickup() and shouldKnifeParentPickPickups(knife.SpawnerEntity) and wakaba.ShouldPickupGetPickedByKnife(entity) then
						if Isaac.RunCallbackWithParam(wakaba.Callback.TRY_PICK_PICKUP, entity.Variant, entity:ToPickup(), player, knife) then
							entity.Velocity = Vector.Zero
						end
					end
					 ]]

					--Isaac.RunCallbackWithParam(wakaba.Callback.MISC_BONE_CLUB_COLLISION, entity.Type, entity, player, knife)
				end
			end)
		end
	end
end, 4)

-- Post Throw Knife
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, function(_, knife)
	if knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer() then
		local data = knife:GetData()
		local isFlying = knife:IsFlying()

		if isFlying then
			local isReturning = data.wakaba_LastFrameDistance and data.wakaba_LastFrameDistance > knife.Position:Distance(knife.SpawnerEntity.Position)

			if not data.wakaba_LastFrameWasFlying then
				Isaac.RunCallback(wakaba.Callback.POST_THROW_KNIFE, knife, knife.SpawnerEntity:ToPlayer())
				Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, knife, knife.SpawnerEntity:ToPlayer())
			end

			if isReturning and not data.wakaba_LastFrameWasReturning then
				data.wakaba_TearEffectEntityBlacklist = {}
				data.wakaba_KnifeIsReturning = true
			end

			data.wakaba_LastFrameWasReturning = isReturning
		elseif data.wakaba_LastFrameWasFlying then
			Isaac.RunCallback(wakaba.Callback.POST_CATCH_KNIFE, knife, knife.SpawnerEntity:ToPlayer())
			wakaba:WipeRicherTearFlags(knife)
			data.wakaba_TearEffectEntityBlacklist = {}
			data.wakaba_KnifeIsReturning = false
		end

		data.wakaba_LastFrameWasFlying = isFlying
		data.wakaba_LastFrameDistance = knife.Position:Distance(knife.SpawnerEntity.Position)
	end
end, 0)

wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, function(_, knife)
	if knife.FrameCount == 0 and knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer() then
		Isaac.RunCallback(wakaba.Callback.POST_THROW_KNIFE, knife, knife.SpawnerEntity:ToPlayer())
		Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, knife, knife.SpawnerEntity:ToPlayer())
	end
end, 1)

wakaba:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, function(_, knife, collider)
	if knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer() then
		local data = knife:GetData()
		data.wakaba_TearEffectEntityBlacklist = data.wakaba_TearEffectEntityBlacklist or {}
		if not wakaba:ShouldEntityGetKnifeCollisionEffects(collider, knife) then return end

		for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.APPLY_TEARFLAG_EFFECT)) do
			if wakaba:HasRicherTearFlags(knife, callbackData.Param) then
				local newEntity = callbackData.Function(callbackData.Mod, collider, knife.SpawnerEntity:ToPlayer(), knife)

				if newEntity then
					collider = newEntity
				end
			end
		end

		data.wakaba_TearEffectEntityBlacklist[collider.InitSeed] = true
	end
end, 0)

-- Apply Wakaba TearFlags manually
function wakaba:ApplyWakabaTearParams(entity, player)
	player = player or entity.SpawnerEntity:ToPlayer()
	if player then
		Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, entity, player)
	end
end













--Shiori callbacks
local function hasShioriCallbacks(collectibleType)
	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.PRE_CHANGE_SHIORI_EFFECT)) do
		if callback.Param == collectibleType then
			return true
		end
	end
	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.POST_CHANGE_SHIORI_EFFECT)) do
		if callback.Param == collectibleType then
			return true
		end
	end
	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT)) do
		if callback.Param == collectibleType then
			return true
		end
	end
end

function wakaba:getSoulofShioriCandidates()
	local candidates = {}

	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.POST_CHANGE_SHIORI_EFFECT)) do
		if callback.Param then
			candidates[callback.Param] = true
		end
	end
	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT)) do
		if callback.Param then
			candidates[callback.Param] = true
		end
	end

	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.PRE_CHANGE_SHIORI_EFFECT)) do
		if callback.Param then
			local returnedFlag = callback.Function(callback.Mod, callback.Param)
			if returnedFlag then
				candidates[callback.Param] = false
			else
				candidates[callback.Param] = true
			end
		end
	end

	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.PRE_EVALUATE_SOUL_OF_SHIORI)) do
		if callback.Param then
			local returnedFlag = callback.Function(callback.Mod, callback.Param)
			if returnedFlag or (candidates[callback.Param] and candidates[callback.Param] == false) then
				candidates[callback.Param] = false
			else
				candidates[callback.Param] = true
			end
		end
	end

	local newCandidates = {}
	for k, v in pairs(candidates) do
		if v then
			--print(k)
			table.insert(newCandidates, k)
		end
	end

	return newCandidates
end

wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, function(_, useditem, rng, player, useflag, slot, vardata)
	if wakaba:HasShiori(player) and useflag & UseFlag.USE_OWNED == UseFlag.USE_OWNED then
		local config = Isaac.GetItemConfig():GetCollectible(useditem)
		if config then
			local prevFlag = player:GetData().wakaba.nextshioriflag
			local nextFlag = useditem
			for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.PRE_CHANGE_SHIORI_EFFECT)) do
				local returnedFlag = nextFlag
				if not callback.Param or callback.Param == useditem then
					returnedFlag = callback.Function(callback.Mod, useditem, useditem, rng, player, useflag, slot, vardata)
				end
				if returnedFlag ~= nil then
					if type(returnedFlag) == "boolean" then
						if returnedFlag == true then
							nextFlag = nil
						else
							nextFlag = prevFlag
						end
						break
					elseif type(returnedFlag) == "number" and Isaac.GetItemConfig():GetCollectible(returnedFlag) then
						nextFlag = returnedFlag
					end
				end
			end
			if nextFlag == nil or hasShioriCallbacks(nextFlag) then
				player:GetData().wakaba.nextshioriflag = nextFlag
			end
			if nextFlag ~= nil then
				Isaac.RunCallbackWithParam(wakaba.Callback.POST_CHANGE_SHIORI_EFFECT, nextFlag, nextFlag, rng, player, useflag, slot, vardata)
			end
			Isaac.RunCallbackWithParam(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, useditem, useditem, rng, player, useflag, slot, vardata)
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		end
	end
end)

-- Player Damage Evaluation
local noRecursion
local didModifyDamage

-- Evaluate Damage Amount
local function canModifyDamageAmount(player, flags)
	return (
		flags & DamageFlag.DAMAGE_NO_MODIFIERS == 0
	)
end

local function shouldDamageAmoundHalved(player)
	return (
		player:HasCollectible(CollectibleType.COLLECTIBLE_WAFER) or
		player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER)
	)
end

wakaba:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, -20000, function(_, entity, amount, flags, source, cooldown)
	if not noRecursion then
		didModifyDamage = false

		if canModifyDamageAmount(entity:ToPlayer(), flags) then
			local somethingChanged = false

			for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT)) do
				local newAmount, newFlags = callbackData.Function(callbackData.Mod, entity:ToPlayer(), amount, flags, source, cooldown)

				if newAmount and newAmount ~= amount then
					amount = newAmount
					somethingChanged = true
				end

				if newFlags and newFlags ~= 0 then
					flags = newFlags
					somethingChanged = true
				end

				if flags & DamageFlag.DAMAGE_NO_MODIFIERS > 0 then
					break
				end
			end

			if somethingChanged then
				didModifyDamage = true

				noRecursion = true
				entity:TakeDamage(amount, flags, source, cooldown)
				noRecursion = false

				return false
			end
		end
	end
end, EntityType.ENTITY_PLAYER)

-- Try Negate Damage
wakaba:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, -19000, function(_, entity, amount, flags, source, cooldown)
	return Isaac.RunCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, entity:ToPlayer(), amount, flags, source, cooldown)
end, EntityType.ENTITY_PLAYER)

-- Post Take Damage
local function postTakeDamage(_, entity, amount, flags, source, cooldown)
	Isaac.RunCallback(wakaba.Callback.POST_TAKE_DAMAGE, entity:ToPlayer(), amount, flags, source, cooldown)

	if didModifyDamage then
		if wakaba:IsDamageSacrificeSpikes(flags, source) then
			local grid = game:GetRoom():GetGridEntityFromPos(entity.Position)
			wakaba:GrantNextSacrificePayout(grid)
		end

		if wakaba:IsDamageSanguineSpikes(player, flags, source) then
			wakaba:GrantSanguineBondPayout(player)
		end
	end
end

if CustomHealthAPI and CustomHealthAPI.Mod.Version < 0.946 then
	wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, postTakeDamage, EntityType.ENTITY_PLAYER)
else
	wakaba:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, 20000, postTakeDamage, EntityType.ENTITY_PLAYER)
end
