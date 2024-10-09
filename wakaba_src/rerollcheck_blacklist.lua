local isc = require("wakaba_src.libs.isaacscript-common")
wakaba.tempRoomBlacklist = {}
wakaba._rerollBlacklist = false

local loopCount = 0
function wakaba:preRollCheck(itemPoolType, decrease, seed)
	wakaba.Log("Prepare reroll - pool " .. itemPoolType .. " / seed " ..seed .. " / loopCount " .. loopCount)
	loopCount = loopCount + 1
	local callbacks = Isaac.GetCallbacks(wakaba.Callback.PRE_WAKABA_REROLL)
	for _, callback in pairs(callbacks) do
		local result = callback.Function(mod, pool, decrease, seed, loopCount)
		if result then
			loopCount = loopCount - 1
			return result
		end
	end
	loopCount = loopCount - 1
end
wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, -1, wakaba.preRollCheck)

function wakaba:PreReroll_RiraBento(itemPoolType, decrease, seed, loopCount)
	if loopCount <= 1 and not wakaba.fullreroll and wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.RIRAS_BENTO) then
		wakaba.Log("Hijack pool from rira's bento - pool " .. itemPoolType .. " / seed " ..seed .. " / loopCount " .. loopCount)
		return wakaba.Enums.Collectibles.RIRAS_BENTO
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.PRE_WAKABA_REROLL, 0, wakaba.PreReroll_RiraBento)

function wakaba:PreReroll_DejaVu(itemPoolType, decrease, seed, loopCount)
	if loopCount <= 1 and not wakaba.fullreroll and wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.DEJA_VU) then
		wakaba.Log("Hijack pool from deja vu - pool " .. itemPoolType .. " / seed " ..seed .. " / loopCount " .. loopCount)
		local candidates = wakaba:ReadDejaVuCandidates()
		if seed % 4 == 0 then
			local rng2 = RNG()
			rng2:SetSeed(seed, 35)
			local TargetIndex = rng2:RandomInt(#candidates) + 1
			local sel = candidates[TargetIndex]
			pool:AddRoomBlacklist(sel)
			return sel
		end
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.PRE_WAKABA_REROLL, 0, wakaba.PreReroll_DejaVu)

function wakaba:PreReroll_DoubleDreams(itemPoolType, decrease, seed, loopCount)
	if loopCount <= 1 and wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS) and (wakaba.runstate.dreampool ~= ItemPoolType.POOL_NULL and wakaba.runstate.dreampool ~= itemPoolType) then
		wakaba.Log("Hijack pool from double dreams - pool " .. itemPoolType .. " / seed " ..seed .. " / loopCount " .. loopCount)
		return wakaba.G:GetItemPool():GetCollectible(wakaba.runstate.dreampool, decrease, seed)
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.PRE_WAKABA_REROLL, 0, wakaba.PreReroll_DoubleDreams)

function wakaba:PreReroll_WinterAlbireo(itemPoolType, decrease, seed, loopCount)
	if loopCount <= 1 and wakaba:IsValidWakabaRoom(nil, wakaba.RoomTypes.WINTER_ALBIREO) then
		local level = wakaba.G:GetLevel()
		local stage = level:GetAbsoluteStage()
		local stageType = level:GetStageType()
		local pool
		if wakaba.G:IsGreedMode() then
			stage = level:GetStage()
			if stage % 2 ~= 0 and itemPoolType ~= ItemPoolType.POOL_GREED_TREASURE then
				pool = ItemPoolType.POOL_GREED_TREASURE
			end
		else
			if stage <= LevelStage.STAGE4_2 then
				if stage % 2 ~= 0 and itemPoolType == ItemPoolType.POOL_PLANETARIUM then
					pool = ItemPoolType.POOL_TREASURE
				end
			elseif stage == LevelStage.STAGE4_3 and (itemPoolType == ItemPoolType.POOL_PLANETARIUM or itemPoolType == ItemPoolType.POOL_TREASURE) then
				pool = ItemPoolType.POOL_SECRET
			elseif stage == LevelStage.STAGE5 and (itemPoolType == ItemPoolType.POOL_PLANETARIUM or itemPoolType == ItemPoolType.POOL_TREASURE) then
				if stageType == StageType.STAGETYPE_ORIGINAL then
					pool = ItemPoolType.POOL_DEVIL
				else
					pool = ItemPoolType.POOL_ANGEL
				end
			end
		end
		if pool then
			wakaba.Log("Hijack pool from winter albireo - pool " .. itemPoolType .. " / seed " ..seed .. " / loopCount " .. loopCount)
			return wakaba.G:GetItemPool():GetCollectible(pool, decrease, seed)
		end
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.PRE_WAKABA_REROLL, 0, wakaba.PreReroll_WinterAlbireo)

function wakaba:PreReroll_BossChallengeFix(itemPoolType, decrease, seed, loopCount)
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	if loopCount <= 1 and wakaba.runstate.dreampool == ItemPoolType.POOL_NULL then
		if room:GetType() == RoomType.ROOM_BOSS then
			if itemPoolType == ItemPoolType.POOL_BOSS then
				if room:GetBossID() == 23 then
					wakaba.Log("Hijack pool from fix - pool " .. itemPoolType .. " / seed " ..seed .. " / loopCount " .. loopCount)
					return wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, decrease, seed)
				end
			end
		elseif room:GetType() == RoomType.ROOM_TREASURE then
			if itemPoolType == ItemPoolType.POOL_TREASURE then
				if level:GetCurrentRoomDesc().Flags & RoomDescriptor.FLAG_DEVIL_TREASURE > 0 then
					wakaba.Log("Hijack pool from fix - pool " .. itemPoolType .. " / seed " ..seed .. " / loopCount " .. loopCount)
					return wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, decrease, seed)
				end
			end
		elseif room:GetType() == RoomType.ROOM_CHALLENGE then
			if itemPoolType == ItemPoolType.POOL_TREASURE then
				if level:HasBossChallenge() then
					wakaba.Log("Hijack pool from fix - pool " .. itemPoolType .. " / seed " ..seed .. " / loopCount " .. loopCount)
					return wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_BOSS, decrease, seed)
				end
			end
		end
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.PRE_WAKABA_REROLL, 0, wakaba.PreReroll_BossChallengeFix)

function wakaba:newRollCheck(itemPoolType, decrease, seed)
	if not wakaba._blacklistCleared then
		local bypassEntireReroll = Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_COLLECTIBLE_REROLL, nil, itemPoolType, decrease, seed)
		if bypassEntireReroll then return end

		local rerollProps = {
			fullReroll = false,
			allowActives = true,
		}

		local itemPool = wakaba.G:GetItemPool()
		itemPool:ResetRoomBlacklist()

		for _, id in ipairs(wakaba.tempRoomBlacklist) do
			itemPool:AddRoomBlacklist(id)
		end

		for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.EVALUATE_WAKABA_COLLECTIBLE_REROLL_PROPS)) do
			local newRerollProps = callbackData.Function(callbackData.Mod, rerollProps, itemPoolType, decrease, seed)

			if newRerollProps then
				rerollProps = newRerollProps
			end
		end

		local itemConfig = Isaac.GetItemConfig()
		local collectibles = itemConfig:GetCollectibles()

		for i = 1, collectibles.Size do
			local config = itemConfig:GetCollectible(i);
			if (config) then
				local callbacks = Isaac.GetCallbacks(wakaba.Callback.WAKABA_COLLECTIBLE_REROLL_BLACKLIST)
				for _, callback in ipairs(callbacks) do
					if (callback.Function(callback.Mod, i, config, rerollProps, itemPoolType, decrease, seed)) then
						itemPool:AddRoomBlacklist(i)
						break
					end
				end
			end
		end
		wakaba._blacklistCleared = true
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, 0, wakaba.newRollCheck)

function wakaba:postRollCheck(_, selected, _, decrease, _)
	if decrease then
		table.insert(wakaba.tempRoomBlacklist, selected)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, wakaba.postRollCheck)

wakaba:AddCallback(wakaba.Callback.EVALUATE_WAKABA_COLLECTIBLE_REROLL, function(_, selected, itemPoolType, decrease, seed)
	local shouldSkip =
		wakaba.G:GetFrameCount() == 0
		or seed == 1
		or (selected and selected <= 0)
		or (LibraryExpanded and LibraryExpanded:IsLibraryCertificateRoom())
		or wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
	if shouldSkip then return true end
end)

---@param item CollectibleType
---@param itemConfig ItemConfigItem
---@param itemPoolType ItemPoolType
---@param decrease boolean
---@param seed integer
wakaba:AddCallback(wakaba.Callback.WAKABA_COLLECTIBLE_REROLL_BLACKLIST, function(_, item, itemConfig, rerollProps, itemPoolType, decrease, seed)
end)

wakaba:AddCallback(wakaba.Callback.EVALUATE_WAKABA_COLLECTIBLE_REROLL_PROPS, function(_, rerollProps, itemPoolType, decrease, seed, isCustom)
	--local estimatedPlayerCount = 0
	wakaba:ForAllPlayers(function (player) ---@param player EntityPlayer
		if player.Variant == 0 then
			local pData = player:GetData()
			--estimatedPlayerCount = estimatedPlayerCount + 1
			rerollProps.IsaacCartridge = rerollProps.IsaacCartridge or player:HasTrinket(wakaba.Enums.Trinkets.ISAAC_CARTRIDGE) or (player:GetPlayerType() == wakaba.Enums.Players.TSUKASA and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT))
			rerollProps.AftCartridge = rerollProps.AftCartridge or player:HasTrinket(wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE)
			rerollProps.RepCartridge = rerollProps.RepCartridge or player:HasTrinket(wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE)
			rerollProps.DejaVu = rerollProps.DejaVu or player:HasCollectible(wakaba.Enums.Collectibles.DEJA_VU)
			rerollProps.NekoFigure = rerollProps.NekoFigure or player:HasCollectible(wakaba.Enums.Collectibles.NEKO_FIGURE)
			rerollProps.SacredOrb = rerollProps.SacredOrb or player:HasCollectible(CollectibleType.COLLECTIBLE_SACRED_ORB)
			rerollProps.WaterFlame = rerollProps.WaterFlame or (player:HasCollectible(wakaba.Enums.Collectibles.WATER_FLAME) or player:GetPlayerType() == wakaba.Enums.Players.RICHER_B)
			rerollProps.DoubleDreams = rerollProps.DoubleDreams or player:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS)
			rerollProps.WakabaBlessing = rerollProps.WakabaBlessing or player:GetPlayerType() == wakaba.Enums.Players.WAKABA or player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING)
			rerollProps.WakabaNemesis = rerollProps.WakabaNemesis or player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B or player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
			if pData.wakaba and pData.wakaba.eatheartused then
				rerollProps.eatHeartUsed = true
				rerollProps.eatHeartQuality = math.max((rerollProps.eatHeartQuality or 0), (pData.wakaba.eatheartquality or 0))
			end
		end
	end)
	rerollProps.fullReroll = wakaba.fullreroll
	rerollProps.allowActives = (wakaba.roomstate.allowactives == nil or wakaba.fullreroll ~= nil) and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_EVEN
	if rerollProps.DoubleDreams and not isCustom then
		rerollProps.GoldenDoubleDreams = wakaba:IsGoldenItem(wakaba.Enums.Collectibles.DOUBLE_DREAMS)
	end
	return rerollProps
end)

---@param selected CollectibleType
---@param selectedItemConf ItemConfigItem
---@param itemPoolType ItemPoolType
---@param decrease boolean
---@param seed integer
wakaba:AddCallback(wakaba.Callback.WAKABA_COLLECTIBLE_REROLL_BLACKLIST, function(_, selected, selectedItemConf, rerollProps, itemPoolType, decrease, seed, isCustom)

	-- Full Reroll Check
	if rerollProps.fullReroll then
		if wakaba.Blacklists.FullReroll[selected] then
			wakaba.Log("Blacklisted item", selected, "from full reroll")
			return true
		end
	end

	-- Unlock Check
	if not wakaba:unlockCheck(selected) then
		wakaba.Log("Blacklisted item", selected, "from unlock check")
		return true
	end

	-- Active Check
	if selectedItemConf.Type == ItemType.ITEM_ACTIVE and not rerollProps.allowActives then
		wakaba.Log("Blacklisted item", selected, "from active check")
		return true
	end

	if selected ~= CollectibleType.COLLECTIBLE_BIRTHRIGHT then
		-- Isaac Cartridge
		do
			local isModded = selected > CollectibleType.COLLECTIBLE_MOMS_RING
			if rerollProps.RepCartridge then
				--wakaba.Log("Blacklisted item", selected, "from repentance cartridge")
				if isModded then
					return true
				end
			elseif rerollProps.AftCartridge then
				if (selected > CollectibleType.COLLECTIBLE_MOMS_SHOVEL and not isModded) or selected == CollectibleType.COLLECTIBLE_CLEAR_RUNE then
					--wakaba.Log("Blacklisted item", selected, "from afterbirth cartridge")
					return true
				end
			elseif rerollProps.IsaacCartridge then
				--wakaba.Log("Blacklisted item", selected, "from isaac cartridge")
				if (selected >= CollectibleType.COLLECTIBLE_DIPLOPIA and not isModded) or selected == CollectibleType.COLLECTIBLE_CLEAR_RUNE then
					return true
				end
			end
		end
		-- Quality Check
		-- Wakaba's Blessing, Nemesis
		do
			local quality = selectedItemConf.Quality
			if rerollProps.eatHeartUsed then
				if quality < rerollProps.eatHeartQuality then
					--wakaba.Log("Blacklisted item", selected, "from eat heart")
					return true
				end
			elseif rerollProps.NekoFigure and wakaba.G:GetRoom():GetType() == RoomType.ROOM_ULTRASECRET then
				if quality < 3 then
					--wakaba.Log("Blacklisted item", selected, "from neko figure")
					return true
				end
			elseif not rerollProps.eatHeartUsed and rerollProps.WakabaNemesis and not rerollProps.WakabaBlessing and not rerollProps.SacredOrb then
				if wakaba:IsLunatic() and quality >= 3 or (quality >= 4 or (quality == 3 and seed % 2 == 0)) then
					--wakaba.Log("Blacklisted item", selected, "from wakaba's nemesis")
					return true
				end
			elseif not rerollProps.eatHeartUsed and rerollProps.WakabaBlessing and not rerollProps.WakabaNemesis and not rerollProps.SacredOrb then
				if wakaba:IsLunatic() and quality <= 0 or quality <= 1 then
					--wakaba.Log("Blacklisted item", selected, "from wakaba's blessing")
					return true
				end
			elseif rerollProps.DoubleDreams and rerollProps.GoldenDoubleDreams then
				if quality == 0 then
					--wakaba.Log("Blacklisted item", selected, "from double dreams")
					return true
				end
			end
		end
	end

	-- Winter Albireo
	if rerollProps.WaterFlame then
		wakaba.Log("Blacklisted item", selected, "from water-flame")
		if selectedItemConf.Type ~= ItemType.ITEM_ACTIVE and not isc:collectibleHasTag(selected, ItemConfig.TAG_SUMMONABLE) then return true end
	end
end)

function wakaba:newRollCooltime()
	wakaba._blacklistCleared = false
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.newRollCooltime)

function wakaba:newRollRoom()
	wakaba.fullreroll = false
	if not wakaba._blacklistCleared then
		wakaba.tempRoomBlacklist = {}
		wakaba._blacklistCleared = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.newRollRoom)