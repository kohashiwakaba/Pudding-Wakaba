
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
	-- Called from POST_PEFFECT_UPDATE, when item quantity changed, and player picks it from the first time.
	-- - `EntityPlayer` - player that got an item.
	-- - `collectibleType` - Acquired collectible.
	-- ---
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
			print(k)
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
