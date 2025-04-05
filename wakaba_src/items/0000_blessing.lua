local isc = _wakaba.isc

local removesatanwisp = false
local valuesupdated = false
wakaba.runstate.eatheartused = false
local roomsexplored = {}
--player:GetPlayerType() == playerType
local nemesiscollectiblenum = 0

local ignorelist = {}
local hidelist = {}
local duped = {}
function wakaba:onNemesisCache(player, cacheFlag)
	if (wakaba:HasNemesis(player) or (not player:IsItemQueueEmpty() and player.QueuedItem.Item.ID == wakaba.Enums.Collectibles.WAKABA_DUALITY))
	and not player:HasCurseMistEffect()
	and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_RAND
	then
		wakaba:GetPlayerEntityData(player)
		local nemesisdmg = wakaba:getPlayerDataEntry(player, "nemesisdmg", 0)
		local collectibleNum = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
		local nemesiscount = player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_NEMESIS) + player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABA_DUALITY)
		if player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				nemesiscount = 0
			else
				nemesiscount = nemesiscount + 1
			end
		else
			nemesiscount = 0
		end
		if player:HasCollectible(wakaba.Enums.Collectibles.WAKABA_DUALITY) then
			nemesiscount = 0
		end
		local statpenalties = 1 - (collectibleNum * 0.01) -- 1 - 0.27 = 0.63
		local tearspenalies = collectibleNum
		if statpenalties <= 0 then
			statpenalties = 0.01
			tearspenalies = 99
		end
		local statbounses = 1
		local nemesisbonuses = nemesisdmg / 3

		if nemesisbonuses > 0 then
			if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + (nemesisbonuses * wakaba:getEstimatedDamageMult(player))
			end
		end
		if nemesiscount > 0 then
			if wakaba.G.Difficulty == Difficulty.DIFFICULTY_HARD or wakaba.G.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
				if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
					player.ShotSpeed = player.ShotSpeed - (collectibleNum * 0.02)
				end
				if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
					player.TearRange = player.TearRange - (collectibleNum * 4)
					if player.TearRange < 200 then
						player.TearRange = 200
					end
				end
				if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
					player.MoveSpeed = player.MoveSpeed - (collectibleNum * 0.01)
				end
				if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
					player.Luck = player.Luck - (collectibleNum * 0.2)
				end
				if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
					--local tearsdecrease = player.MaxFireDelay / statpenalties
					--print(player.MaxFireDelay, tearsdecrease)
					--player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (player.MaxFireDelay * -0.63))
					for i = 1, collectibleNum do
						if player.MaxFireDelay < 0 then
							player.MaxFireDelay = player.MaxFireDelay + 0.01
						else
							player.MaxFireDelay = player.MaxFireDelay + 0.05
						end
					end
				end
			else
				if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
					player.ShotSpeed = player.ShotSpeed * statpenalties
				end
				if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
					player.TearRange = player.TearRange * statpenalties
				end
				if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
					player.MoveSpeed = player.MoveSpeed * statpenalties
				end
				if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
					player.Luck = player.Luck * statpenalties
				end
				if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
					--local tearsdecrease = player.MaxFireDelay / statpenalties
					--print(player.MaxFireDelay, tearsdecrease)
					--player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (player.MaxFireDelay * -0.63))
					if player.MaxFireDelay < 0 then
						player.MaxFireDelay = player.MaxFireDelay * statpenalties
					else
						player.MaxFireDelay = player.MaxFireDelay / statpenalties
					end
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onNemesisCache)

function wakaba:PlayerUpdate_Nemesis(player)
	local newItem = wakaba.Enums.Collectibles.WAKABA_DUALITY
	local newItemConfig = Isaac.GetItemConfig():GetCollectible(newItem) -- Define combined item
	local newName = newItemConfig.Name
	local newDesc = newItemConfig.Description
	if Options.Language ~= "en" then
		local descTable = wakaba.descriptions[wakaba.LanguageMap[Options.Language]]
		if descTable then
			newName = descTable.collectibles[newItem].itemName or newName
			newDesc = descTable.collectibles[newItem].queueDesc or newDesc
		end
	end
	--[[
		In order to combine two items, You must check 3 conditions
		0. If the combined item should not be in Death Certificate rooms, Item pools, or Spindown Dice, then you must add 'hidden="true"' for the combined item in items.xml.
		1. player has item A -> player:HasCollectible(itemID.A, true) << MUST SET 'IgnoreModifiers' ARGUMENT (the second one) AS 'true'
		2. player's queue is not empty -> not player:IsItemQueueEmpty()
		3. player is holding item B -> player.QueuedItem.Item.ID == itemID.B
	]]
	-- In this example, wakaba:HasBless(player) checks whether player has Wakaba's Blessing(item A), or the character is Wakaba
	-- You would normally use player:HasCollectible(itemID.A, true) for item check. AGAIN, MUST SET 'IgnoreModifiers' ARGUMENT AS 'true'
	if wakaba:HasBless(player) and not player:IsItemQueueEmpty() and player.QueuedItem.Item.ID == wakaba.Enums.Collectibles.WAKABAS_NEMESIS then
		local newItemConfig = Isaac.GetItemConfig():GetCollectible(wakaba.Enums.Collectibles.WAKABA_DUALITY) -- Define combined item
		if player:FlushQueueItem() then -- Skip current queued item animation, This will add item B in Isaac's inventory.
			player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle") -- Manually animate pickup animation
			wakaba:DisplayHUDItemText(player, "collectibles", wakaba.Enums.Collectibles.WAKABA_DUALITY) -- Show item name and descriptions to HUD
			player:QueueItem(newItemConfig) -- Queue combined item. Finishing animation will add the combined one.
		end
		-- Then remove both items which were supposed to be combined. Must call after player:FlushQueueItem() is called
		player:RemoveCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING)
		player:RemoveCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
	elseif wakaba:HasNemesis(player) and not player:IsItemQueueEmpty() and player.QueuedItem.Item.ID == wakaba.Enums.Collectibles.WAKABAS_BLESSING then
		local newItemConfig = Isaac.GetItemConfig():GetCollectible(wakaba.Enums.Collectibles.WAKABA_DUALITY)
		if player:FlushQueueItem() then
			player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle")
			wakaba:DisplayHUDItemText(player, "collectibles", wakaba.Enums.Collectibles.WAKABA_DUALITY)
			player:QueueItem(newItemConfig)
		end
		player:RemoveCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING)
		player:RemoveCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
	elseif wakaba:HasBless(player) and player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS, true) then
		player:RemoveCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING)
		player:RemoveCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
		player:AddCollectible(newItem)
	elseif wakaba:HasNemesis(player) and player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING, true) then
		player:RemoveCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING)
		player:RemoveCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
		player:AddCollectible(newItem)
	end

	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.currItemNum = player:GetData().wakaba.currItemNum or 0
	--[[ player:GetData().wakaba.tempbless = player:GetData().wakaba.tempbless or false

	if not player:IsItemQueueEmpty() and player.QueuedItem.Item.ID == wakaba.Enums.Collectibles.WAKABAS_BLESSING then
		player:GetData().wakaba.tempbless = true
	end
	if player:GetData().wakaba.tempbless and player:IsExtraAnimationFinished() then
		wakaba:AddBlessDevilRoomChance(player)
		player:GetData().wakaba.tempbless = false
	end ]]

	if player:HasCollectible(wakaba.Enums.Collectibles.DEJA_VU) --[[ or player:HasCollectible(wakaba.Enums.Collectibles.WINTER_ALBIREO) ]] then
		if player:GetCollectibleCount() ~= player:GetData().wakaba.dejavuItemNum and not player:IsHoldingItem() then
			player:GetData().wakaba.dejavuItemNum = player:GetCollectibleCount()
			wakaba:CheckItemCandidates(player)
			player:AddCacheFlags(CacheFlag.CACHE_ALL - CacheFlag.CACHE_FAMILIARS)
			player:EvaluateItems()
		end
	end
	if player:GetPlayerType() ~= PlayerType.PLAYER_THELOST_B and player:GetData().wakaba.tryactivateblessmantle then

		if player:GetHearts() + player:GetSoulHearts() <= 2 then
			for i = 1, wakaba:GetBlessNum(player) do
				player:UseActiveItem(CollectibleType.COLLECTIBLE_HOLY_MANTLE, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER)
			end
			player:GetData().wakaba.blessmantle = true
		end
		player:GetData().wakaba.tryactivateblessmantle = nil
	end


	if wakaba:HasNemesis(player)
	then
		local writableRoomDesc = wakaba.G:GetLevel():GetRoomByIdx(-1)
		if writableRoomDesc then
			if writableRoomDesc.SurpriseMiniboss then
				--print("writableRoomDesc.SurpriseMiniboss")
			end
			writableRoomDesc.SurpriseMiniboss = false
		end

		player:GetData().wakaba.nemesisupdatedelay = player:GetData().wakaba.nemesisupdatedelay or 0

		local currItemNum = player:GetData().wakaba.nemesiscollectiblenum
		if player:GetData().wakaba.nemesisupdatedelay > 0 then
			if player:AreControlsEnabled() and not player:HasCurseMistEffect() then
				player:GetData().wakaba.nemesisupdatedelay = player:GetData().wakaba.nemesisupdatedelay - 1
			end
		else
			if wakaba:getPlayerDataEntry(player, "nemesisdmg", 0) > 0 then
				if wakaba:getPlayerDataEntry(player, "nemesisdmg") > 90 then
					wakaba:setPlayerDataEntry(player, "nemesisdmg", 90)
				end
				wakaba:addPlayerDataCounter(player, "nemesisdmg", -0.1)
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
				player:EvaluateItems()
			end
			if player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				player:GetData().wakaba.nemesisupdatedelay = 40
			else
				player:GetData().wakaba.nemesisupdatedelay = 8
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Nemesis)


function wakaba:CheckItemCandidates(player)
	wakaba:GetPlayerEntityData(player)
	local DejaVuCandidates = {}

	-- Item tables. Used Job mod as Reference.
	for itemId = 1, wakaba:GetMaxCollectibleID() do
		local targetItem = wakaba.ItemConfig:GetCollectible(itemId)

		if targetItem and not targetItem:HasTags(ItemConfig.TAG_QUEST)
		and (targetItem.Type == ItemType.ITEM_PASSIVE or targetItem.Type == ItemType.ITEM_FAMILIAR)
		and itemId ~= wakaba.Enums.Collectibles.DEJA_VU
		then
			for i = 1, player:GetCollectibleNum(itemId, true) do
				DejaVuCandidates[#DejaVuCandidates + 1] = itemId
			end
		end
	end
	player:GetData().wakaba.DejaVuCandidates = DejaVuCandidates
end

function wakaba:ReadDejaVuCandidates(onlySummonable)
	local TotalDejaVuCandidates = {}
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetData().wakaba and player:GetData().wakaba.DejaVuCandidates then
			local DejaVuItems = player:GetData().wakaba.DejaVuCandidates
			if #DejaVuItems > 0 then
				for i = 1, #DejaVuItems do
					if not onlySummonable or wakaba:ItemHasTags(ItemConfig.TAG_SUMMONABLE) then
						table.insert(TotalDejaVuCandidates, DejaVuItems[i])
					end
				end
			end
		end
	end
	return TotalDejaVuCandidates
end

function wakaba:ShouldRemoveIndex()
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()

	if isc:inDeathCertificateArea() then return false end

	if wakaba.state.options.blessnemesisindexed
	then return false end

	if room:GetType() == RoomType.ROOM_TREASURE
	and level:GetAbsoluteStage() == LevelStage.STAGE1_1
	and not wakaba.G:GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH)
	and wakaba.state.options.firsttreasureroomindexed
	then return false end

	if level:GetStartingRoomIndex() == level:GetCurrentRoomIndex()
	and level:GetAbsoluteStage() == LevelStage.STAGE1_1
	and wakaba.state.options.startingroomindexed
	then return false end

	return true
end

function wakaba:HasBless(player, includeWakaba, includeTLaz)
	includeWakaba = includeWakaba or true
	if includeWakaba and player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING) or player:HasCollectible(wakaba.Enums.Collectibles.WAKABA_DUALITY) then
		return true
	elseif includeTLaz and wakaba:isTLaz(player) then
		local tLaz = wakaba:getFlippedForm(player)
		if tLaz:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_BLESSING) or tLaz:HasCollectible(wakaba.Enums.Collectibles.WAKABA_DUALITY) then
			return true
		end
	end
	return false
end

function wakaba:GetBlessNum(player, includeWakaba, includeTLaz)
	includeWakaba = includeWakaba or true
	local r = 0
	if includeWakaba and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Wakaba", false) then
		r = r + 1
	end
	return r + player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_BLESSING) + player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABA_DUALITY)
end

function wakaba:ReEvaluateNemesisStats(player, item)
	if wakaba:HasNemesis(player) and item and item ~= 0 then
		local config = Isaac.GetItemConfig():GetCollectible(item)
		wakaba:addNemesisCount(player, 1, config:HasTags(ItemConfig.TAG_QUEST))
	end
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.ReEvaluateNemesisStats)

function wakaba:HasNemesis(player, includeWakaba, includeTLaz)
	includeWakaba = includeWakaba or true
	if includeWakaba and player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) then
		--wakaba:addNemesisCount(player, 0)
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS) or player:HasCollectible(wakaba.Enums.Collectibles.WAKABA_DUALITY) then
		--wakaba:addNemesisCount(player, 0)
		return true
	elseif includeTLaz and wakaba:isTLaz(player) then
		local tLaz = wakaba:getFlippedForm(player)
		if tLaz:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_NEMESIS) or tLaz:HasCollectible(wakaba.Enums.Collectibles.WAKABA_DUALITY) then
			return true
		end
	end
	return false
end

function wakaba:TaintedWakabaBirthright(player)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		return true
	else
		return false
	end
end


function wakaba:updateDevilAngelRoomDoor(rng, pos)
	local dealdoor=nil
	local doorcount=0
	for i=0,8 do
		if wakaba.G:GetRoom():GetDoor(i) and wakaba.G:GetRoom():GetDoor(i).TargetRoomIndex==-1 then
			dealdoor=wakaba.G:GetRoom():GetDoor(i)
			doorcount=doorcount+1
		end
	end
end



wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	ignorelist = {}
	hidelist = {}

	local bless = false
	local nemesis = false
	local duality = false
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.blessmantle = nil
		if wakaba:HasBless(player) then
			bless = true
			if player:GetHearts() + player:GetSoulHearts() <= 2 then
				player:GetData().wakaba.blessmantle = true
				--print("Holy Mantle for Wakaba's Blessing activated")
				if wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSS and StageAPI and not wakaba.G:GetRoom():IsClear() then
					player:GetData().wakaba.pendingblessmantle = wakaba:GetBlessNum(player)
				elseif player:GetPlayerType() ~= PlayerType.PLAYER_THELOST_B then
					for i = 1, wakaba:GetBlessNum(player) do
						player:UseActiveItem(CollectibleType.COLLECTIBLE_HOLY_MANTLE, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER)
					end
				end
			end
		end
		if wakaba:HasNemesis(player) then
			nemesis = true
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then
			duality = true
		end
	end

	--[[ if not duality
	and room:GetType() == RoomType.ROOM_BOSS
	and not wakaba.G.Challenge == wakaba.challenges.CHALLENGE_RAND then
		if wakaba.runstate.hasbless and not wakaba.runstate.hasnemesis then
			level:InitializeDevilAngelRoom(true, false)
		elseif not wakaba.runstate.hasbless and wakaba.runstate.hasnemesis then
			level:InitializeDevilAngelRoom(false, true)
		end
	end ]]


	if room:IsFirstVisit() then
		local items = Isaac.FindByType(5, 100, -1, false, false)
		for i, e in ipairs(items) do
			if (wakaba.runstate.hasbless and wakaba.runstate.hasnemesis) and wakaba:ShouldRemoveIndex() then
				e:ToPickup().OptionsPickupIndex = 0
			end
		end
		wakaba.runstate.spent = false
	end

end)

function wakaba:blessDetectD6(usedItem, rng)
	if usedItem == CollectibleType.COLLECTIBLE_D6
	or usedItem == CollectibleType.COLLECTIBLE_D100
	then
		wakaba.pedestalreroll = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.blessDetectD6)

function wakaba:blessDetectD6Card(usedCard)
	if usedCard == Card.RUNE_PERTHRO
	or usedCard == Card.CARD_DICE_SHARD
	or usedCard == Card.CARD_SOUL_EDEN
	then
		wakaba.pedestalreroll = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.blessDetectD6Card)

function wakaba:blessnemesis()
	local hasWakabaJB = false
	local blesscount = 0
	local nemesiscount = 0
	local wakababrcount = 0
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == wakaba.Enums.Players.WAKABA and wakaba:extraVal("wakabaJaebol") then
			hasWakabaJB = true
		end
		if wakaba:HasBless(player, true, true) then
			blesscount = blesscount + 1
		end
		if wakaba:HasNemesis(player, true, true) then
			nemesiscount = nemesiscount + 1
		end
		if wakaba:TaintedWakabaBirthright(player) then
			wakababrcount = wakababrcount + 1
		end
	end
	if blesscount > 0 then wakaba.runstate.hasbless = true else wakaba.runstate.hasbless = false end
	if nemesiscount > 0 then wakaba.runstate.hasnemesis = true else wakaba.runstate.hasnemesis = false end
	if wakababrcount > 0 then haswakababr_b = true else haswakababr_b = false end

	--collectible

	if not isc:inDeathCertificateArea() then
		local items = Isaac.FindByType(5, 100, -1, false, false)
		for i, e in ipairs(items) do
			if wakaba.runstate.hasbless and wakaba.runstate.hasnemesis then
				if wakaba:ShouldRemoveIndex()	then
					e:ToPickup().OptionsPickupIndex = 0
				end
			elseif (wakaba.runstate.hasbless or wakaba.runstate.hasnemesis) and (e.SubType == CollectibleType.COLLECTIBLE_POLAROID or e.SubType == CollectibleType.COLLECTIBLE_NEGATIVE) then
				e:ToPickup().OptionsPickupIndex = 0
			elseif hasWakabaJB then
				e:ToPickup().OptionsPickupIndex = 0
			end
		end
	end

	--collectible end
	if wakaba.runstate.hasbless and not wakaba.runstate.hasnemesis then
		if wakaba.G:GetLevel():GetAngelRoomChance() < 1 then
			wakaba.G:GetLevel():AddAngelRoomChance(1 - wakaba.G:GetLevel():GetAngelRoomChance())
		end
		--[[ if wakaba.G:GetDevilRoomDeals() > 0 then
			wakaba.G:AddDevilRoomDeal(-wakaba.G:GetDevilRoomDeals())
		end ]]
	elseif not wakaba.runstate.hasbless and wakaba.runstate.hasnemesis then
		if wakaba.G:GetDevilRoomDeals() < 1 then
			wakaba.G:AddDevilRoomDeal()
		end
		if wakaba.G:GetLevel():GetAngelRoomChance() > 0 then
			wakaba.G:GetLevel():AddAngelRoomChance(-wakaba.G:GetLevel():GetAngelRoomChance())
		end
	end


	--[[ if removesatanwisp then

		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			wakaba:CleanupContinueSatanWisps(_, player)
		end
	end ]]

end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.blessnemesis)
--LagCheck


function wakaba:PostTakeDamage_BlessNemesis(player, amount, flag, source, countdownFrames)
	if player:GetPlayerType() ~= PlayerType.PLAYER_THELOST_B and wakaba:HasBless(player) and not player:GetData().wakaba.blessmantle then
		player:GetData().wakaba.tryactivateblessmantle = true
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_BlessNemesis)


function wakaba:pickupinit(pickup)
	local haslost = false
	local steamcount = 0
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		--[[ if player:GetPlayerType() == 10
		or player:GetPlayerType() == 31
		or player:GetPlayerType() == 39
		then
			haslost = true
		end ]]
		if player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE) or player:HasTrinket(TrinketType.TRINKET_JUDAS_TONGUE) then
			steamcount = steamcount + 1
		end
	end

	if isc:anyPlayerIs(wakaba.Enums.Players.WAKABA_B) and not (isc:anyPlayerIs(PlayerType.PLAYER_KEEPER) or isc:anyPlayerIs(PlayerType.PLAYER_KEEPER_B)) then
		if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE and pickup:IsShopItem() and pickup.Price ~= -1000 then
			local player = isc:getClosestPlayer(pickup.Position) or Isaac.GetPlayer()
			local config = Isaac.GetItemConfig():GetCollectible(pickup.SubType)
			local devilPrice = config and config.DevilPrice or 1
			if steamcount > 0 or devilPrice == 1 then
				if player:GetEffectiveMaxHearts() > 0 and player:GetSoulHearts() < 2 then
					pickup.Price = PickupPrice.PRICE_ONE_HEART
				else
					pickup.Price = PickupPrice.PRICE_ONE_SOUL_HEART
				end
			else
				if player:GetEffectiveMaxHearts() >= 4 and player:GetSoulHearts() < 2 then
					pickup.Price = PickupPrice.PRICE_TWO_HEARTS
				elseif player:GetEffectiveMaxHearts() >= 2 and player:GetSoulHearts() < 4 then
					pickup.Price = PickupPrice.PRICE_ONE_HEART_AND_ONE_SOUL_HEART
				else
					pickup.Price = PickupPrice.PRICE_TWO_SOUL_HEARTS
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.pickupinit)
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.pickupinit)

function wakaba:RevealItemImage(pickup, offset)
	pickup:GetData().wakaba = pickup:GetData().wakaba or {}

	local itemData = Isaac.GetItemConfig():GetCollectible(pickup.SubType)
	if not wakaba.G:GetSeeds():HasSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_BLIND)
	and not (wakaba.G:GetSeeds():IsCustomRun() and isc:hasCurse(LevelCurse.CURSE_OF_BLIND))
	and not pickup:GetData().wakaba.removequestion
	and pickup.SubType > 0 and itemData then
		if wakaba:ShouldRemoveBlind() and wakaba.G:GetRoom():GetType() == RoomType.ROOM_TREASURE and wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_RAND then
			local sprite = pickup:GetSprite()

			sprite:ReplaceSpritesheet(1, itemData.GfxFileName)
			sprite:LoadGraphics()
			pickup:GetData().wakaba.removequestion = true
			pickup:GetData().EID_DontHide = true
		end
	elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_EVEN and itemData and itemData:HasTags(ItemConfig.TAG_QUEST) then
		local sprite = pickup:GetSprite()

		sprite:ReplaceSpritesheet(1, itemData.GfxFileName)
		sprite:LoadGraphics()
		pickup:GetData().wakaba.removequestion = true
		pickup:GetData().EID_DontHide = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, wakaba.RevealItemImage, PickupVariant.PICKUP_COLLECTIBLE)

function wakaba:PenaltyProtection_BlessNemesis(player, amount, flags, source, countdown)
	if not wakaba:IsLunatic() and (wakaba:HasBless(player, true) or wakaba:HasNemesis(player, true) or wakaba:hasLunarStone(player)) then
		return {
			Protect = true,
			Override = true,
		}
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_WAKABA_DAMAGE_PENALTY_PROTECTION, wakaba.PenaltyProtection_BlessNemesis)

function wakaba:BlessNemesisDamage(source, target, data, newDamage, newFlags)
	local returndata = {}
	local passed = false
	wakaba:ForAllPlayers(function(player)
		passed = passed or wakaba:HasNemesis(player)
	end)
	if passed then
		returndata.sendNewDamage = true
		if wakaba:IsLunatic() then
			returndata.newDamage = newDamage * 1.15
		else
			returndata.newFlags = newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR
		end
	end
	return returndata
end