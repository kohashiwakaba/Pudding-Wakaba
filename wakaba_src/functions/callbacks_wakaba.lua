
local mod = wakaba

function mod.SetCallbackMatchTest(callbackID, func)
	local callbacks = Isaac.GetCallbacks(callbackID, true)
	setmetatable(callbacks, {
		__index = getmetatable(callbacks),
		__matchParams = func,
	})
end

---@enum WakabaCallbacks
---@display wakaba.Callback
wakaba.Callback = {

	--
	POST_GET_COLLECTIBLE = {},

	-- Extra callbacks exclusive to Pudding & Wakaba


	-- ---
	-- PRE_GET_SHIORI_BOOKS
	-- ---
	-- Called right before Shiori's bookshelf is selected.
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
	-- - `collectibleType` - used active item.
	-- - `EntityPlayer` - used player. Mostly Shiori.
	-- ---
	-- - Return non-nil values other than `false` will prevent the collectible to be selected.
	PRE_EVALUATE_SOUL_OF_SHIORI = {},
	-- ---
	-- PRE_CHANGE_SHIORI_EFFECT
	-- ---
	-- Called from MC_USE_ITEM, right before Shiori, or player with Book of Shiori uses an active item. returned values does NOT affect any callbacks from POST_ACTIVATE_SHIORI_EFFECT.
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
	-- - `collectibleType` - used active item.
	-- - `rng` - RNG from using item.
	-- - `EntityPlayer` - used player. Mostly Shiori.
	-- - `useflag` - UseFlags.
	-- - `activeSlot` - active slot that used from.
	-- - `vardata` - custom VarData from active item.
	POST_ACTIVATE_SHIORI_EFFECT = {},
}

mod.SetCallbackMatchTest(mod.Callback.POST_GET_COLLECTIBLE, function(a, b) -- TMTRAINER makes ID=-1 items, which bypasses the old match test
	return not a or not b or a == b
end)

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
			candidates.[callback.Param] = true
		end
	end
	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT)) do
		if callback.Param then
			candidates.[callback.Param] = true
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
			table.insert(newCandidates)
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
