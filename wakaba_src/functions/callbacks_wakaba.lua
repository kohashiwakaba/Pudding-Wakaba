
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
}

wakaba.SetCallbackMatchTest(wakaba.Callback.POST_GET_COLLECTIBLE, function(a, b) -- TMTRAINER makes ID=-1 items, which bypasses the old match test
	return not a or not b or a == b
end)

function wakaba:addNemesisDamage(player, count)
	count = count or 1
	player:GetData().wakaba.nemesisdmg = (player:GetData().wakaba.nemesisdmg or 0) + (10.8 * count)
	
	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
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
		flags & DamageFlag.DAMAGE_NO_MODIFIERS == 0 and
		not (
			player:HasCollectible(CollectibleType.COLLECTIBLE_WAFER) or
			player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER)
		)
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
--[[ 
		if wakaba.IsDamageSacrificeSpikes(flags, source) then
			local grid = game:GetRoom():GetGridEntityFromPos(entity.Position)
			wakaba.GrantNextSacrificePayout(grid)
		end

		if wakaba.IsDamageSanguineSpikes(player, flags, source) then
			wakaba.GrantSanguineBondPayout(player)
		end
		 ]]
	end
end

if CustomHealthAPI and CustomHealthAPI.Mod.Version < 0.946 then
	wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, postTakeDamage, EntityType.ENTITY_PLAYER)
else
	wakaba:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, 20000, postTakeDamage, EntityType.ENTITY_PLAYER)
end
