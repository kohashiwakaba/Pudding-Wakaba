wakaba.COLLECTIBLE_WAKABAS_BLESSING = Isaac.GetItemIdByName("Wakaba's Blessing")
wakaba.COLLECTIBLE_WAKABAS_NEMESIS = Isaac.GetItemIdByName("Wakaba's Nemesis")
wakaba.COLLECTIBLE_WAKABA_DUALITY = Isaac.GetItemIdByName("Wakaba Duality")
local removesatanwisp = false
local valuesupdated = false
wakaba.state.eatheartused = false
local roomsexplored = {}
--player:GetPlayerType() == playerType
local nemesiscollectiblenum = 0

local origAngelChance = wakaba.state.angelchance

function wakaba:AddDevilRoomChance(count, player)
	player = player or Isaac.GetPlayer()
	wakaba:CleanupSatanWisps(player)
	for i = 1, count do
		local wisp = player:AddWisp(CollectibleType.COLLECTIBLE_SATANIC_BIBLE, Vector(-300, -300), false, true)
		Isaac.DebugString("[wakaba]Wisp Added!")
		wisp:GetData().wakabatemp = true
	end
end

function wakaba:CleanupSatanWisps(player)
	local wispcount = 0
	local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, CollectibleType.COLLECTIBLE_SATANIC_BIBLE, false, false)
	for i, wisp in ipairs(wisps) do
		if wisp:GetData().wakabatemp then
			if not player or (GetPtrHash(wisp:ToFamiliar().Player) == GetPtrHash(player)) then
				--Isaac.DebugString("[wakaba]Wisp Removed!")
				wispcount = wispcount + 1
				wisp:Remove()
			end
		end
	end
	return wispcount
end

local ignorelist = {}
local hidelist = {}
local duped = {}
function wakaba:onNemesisCache(player, cacheFlag)
  if (wakaba:HasNemesis(player) or (not player:IsItemQueueEmpty() and player.QueuedItem.Item.ID == wakaba.COLLECTIBLE_WAKABA_DUALITY))
	and Game().Challenge ~= wakaba.challenges.CHALLENGE_RAND 
	then
		wakaba:GetPlayerEntityData(player)
		local nemesisdmg = player:GetData().wakaba.nemesisdmg or 0
		local collectibleNum = player:GetCollectibleCount()
		local nemesiscount = player:GetCollectibleNum(wakaba.COLLECTIBLE_WAKABAS_NEMESIS) + player:GetCollectibleNum(wakaba.COLLECTIBLE_WAKABA_DUALITY)
		if player:GetPlayerType() == wakaba.PLAYER_WAKABA_B then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				nemesiscount = 0
			else
				nemesiscount = nemesiscount + 1
				collectibleNum = collectibleNum - 1
			end
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
        player.Damage = player.Damage + nemesisbonuses
    	end
		end
		if nemesiscount > 0 then
			if Game().Difficulty == Difficulty.DIFFICULTY_HARD or Game().Difficulty == Difficulty.DIFFICULTY_GREEDIER then
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
	local newItem = wakaba.COLLECTIBLE_WAKABA_DUALITY
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
	if wakaba:HasBless(player) and not player:IsItemQueueEmpty() and player.QueuedItem.Item.ID == wakaba.COLLECTIBLE_WAKABAS_NEMESIS then
		local newItemConfig = Isaac.GetItemConfig():GetCollectible(wakaba.COLLECTIBLE_WAKABA_DUALITY) -- Define combined item
		if player:FlushQueueItem() then -- Skip current queued item animation, This will add item B in Isaac's inventory.
			player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle") -- Manually animate pickup animation
			Game():GetHUD():ShowItemText(newName, newDesc, false) -- Show item name and descriptions to HUD
			player:QueueItem(newItemConfig) -- Queue combined item. Finishing animation will add the combined one.
		end
		-- Then remove both items which were supposed to be combined. Must call after player:FlushQueueItem() is called
		player:RemoveCollectible(wakaba.COLLECTIBLE_WAKABAS_BLESSING)
		player:RemoveCollectible(wakaba.COLLECTIBLE_WAKABAS_NEMESIS)
	elseif wakaba:HasNemesis(player) and not player:IsItemQueueEmpty() and player.QueuedItem.Item.ID == wakaba.COLLECTIBLE_WAKABAS_BLESSING then
		local newItemConfig = Isaac.GetItemConfig():GetCollectible(wakaba.COLLECTIBLE_WAKABA_DUALITY)
		if player:FlushQueueItem() then
			player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle")
			Game():GetHUD():ShowItemText(newName, newDesc, false)
			player:QueueItem(newItemConfig)
		end
		player:RemoveCollectible(wakaba.COLLECTIBLE_WAKABAS_BLESSING)
		player:RemoveCollectible(wakaba.COLLECTIBLE_WAKABAS_NEMESIS)
	elseif wakaba:HasBless(player) and player:HasCollectible(wakaba.COLLECTIBLE_WAKABAS_NEMESIS, true) then
		player:RemoveCollectible(wakaba.COLLECTIBLE_WAKABAS_BLESSING)
		player:RemoveCollectible(wakaba.COLLECTIBLE_WAKABAS_NEMESIS)
		player:AddCollectible(newItem)
	elseif wakaba:HasNemesis(player) and player:HasCollectible(wakaba.COLLECTIBLE_WAKABAS_BLESSING, true) then
		player:RemoveCollectible(wakaba.COLLECTIBLE_WAKABAS_BLESSING)
		player:RemoveCollectible(wakaba.COLLECTIBLE_WAKABAS_NEMESIS)
		player:AddCollectible(newItem)
	end

	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.currItemNum = player:GetData().wakaba.currItemNum or 0
	--[[ player:GetData().wakaba.tempbless = player:GetData().wakaba.tempbless or false

	if not player:IsItemQueueEmpty() and player.QueuedItem.Item.ID == wakaba.COLLECTIBLE_WAKABAS_BLESSING then
		player:GetData().wakaba.tempbless = true
	end
	if player:GetData().wakaba.tempbless and player:IsExtraAnimationFinished() then
		wakaba:AddBlessDevilRoomChance(player)
		player:GetData().wakaba.tempbless = false
	end ]]
	
	if player:HasCollectible(wakaba.COLLECTIBLE_DEJA_VU) --[[ or player:HasCollectible(wakaba.COLLECTIBLE_WINTER_ALBIREO) ]] then
		if player:GetCollectibleCount() ~= player:GetData().wakaba.dejavuItemNum and not player:IsHoldingItem() then
			player:GetData().wakaba.dejavuItemNum = player:GetCollectibleCount()
			wakaba:CheckItemCandidates(player)
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		end
	end
	if player:GetPlayerType() ~= PlayerType.PLAYER_THELOST_B and player:GetData().wakaba.blessmantlenum and player:GetData().wakaba.blessmantlenum > 0 then
		for i = 1, player:GetData().wakaba.blessmantlenum do
			player:UseActiveItem(CollectibleType.COLLECTIBLE_HOLY_MANTLE, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER)
		end
		player:GetData().wakaba.blessmantlenum = nil
	end


	if wakaba:HasNemesis(player)
	then
		local writableRoomDesc = Game():GetLevel():GetRoomByIdx(-1)
		if writableRoomDesc then
			if writableRoomDesc.SurpriseMiniboss then
				print("writableRoomDesc.SurpriseMiniboss")
			end
			writableRoomDesc.SurpriseMiniboss = false
		end

		player:GetData().wakaba.nemesisupdatedelay = player:GetData().wakaba.nemesisupdatedelay or 0


		player:GetData().wakaba.nemesisdmg = player:GetData().wakaba.nemesisdmg or 0
		local currItemNum = player:GetData().wakaba.nemesiscollectiblenum
		if player:GetData().wakaba.nemesisupdatedelay > 0 then
			if player:AreControlsEnabled() then
				player:GetData().wakaba.nemesisupdatedelay = player:GetData().wakaba.nemesisupdatedelay - 1
			end
		else
			if player:GetData().wakaba.nemesisdmg > 0 then
				if player:GetData().wakaba.nemesisdmg > 90 then
					player:GetData().wakaba.nemesisdmg = 90
				end
				player:GetData().wakaba.nemesisdmg = player:GetData().wakaba.nemesisdmg - 0.1
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
				player:EvaluateItems()
			end
			if player:GetPlayerType() == wakaba.PLAYER_WAKABA_B and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
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
	local AlbireoCandidates = {}
	local PendantCandidates = {}

	-- Item tables. Used Job mod as Reference.
	for itemId = 1, wakaba:GetMaxCollectibleID() do
		local targetItem = wakaba.ItemConfig:GetCollectible(itemId)
		
		if targetItem and not targetItem:HasTags(ItemConfig.TAG_QUEST)
		and (targetItem.Type == ItemType.ITEM_PASSIVE or targetItem.Type == ItemType.ITEM_FAMILIAR)
		and itemId ~= wakaba.COLLECTIBLE_DEJA_VU
		then
			for i = 1, player:GetCollectibleNum(itemId) do
				DejaVuCandidates[#DejaVuCandidates + 1] = itemId
			end
		elseif targetItem and targetItem:HasTags(ItemConfig.TAG_STARS) then
			for i = 1, player:GetCollectibleNum(itemId) do
				AlbireoCandidates[#AlbireoCandidates + 1] = itemId
			end
		elseif targetItem and (targetItem.CacheFlags & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK) then
			for i = 1, player:GetCollectibleNum(itemId) do
				PendantCandidates[#PendantCandidates + 1] = itemId
			end
		end
	end
	player:GetData().wakaba.DejaVuCandidates = DejaVuCandidates
	player:GetData().wakaba.AlbireoCandidates = AlbireoCandidates
	player:GetData().wakaba.PendantCandidates = PendantCandidates
end

function wakaba:ReadDejaVuCandidates()
	local TotalDejaVuCandidates = {}
  for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetData().wakaba and player:GetData().wakaba.DejaVuCandidates then
			local DejaVuItems = player:GetData().wakaba.DejaVuCandidates
			if #DejaVuItems > 0 then
				for i = 1, #DejaVuItems do
					TotalDejaVuCandidates[#TotalDejaVuCandidates + 1] = DejaVuItems[i]
				end
			end
		end
	end
	return TotalDejaVuCandidates
end

function wakaba:ShouldRemoveIndex()
	local level = Game():GetLevel()
	local room = Game():GetRoom()

	if wakaba.state.options.blessnemesisindexed 
	then return false end

	if room:GetType() == RoomType.ROOM_TREASURE
	and level:GetAbsoluteStage() == LevelStage.STAGE1_1
	and not Game():GetStateFlag(GameStateFlag.STATE_BACKWARDS_PATH)
	and wakaba.state.options.firsttreasureroomindexed
	then return false end
	
	if level:GetStartingRoomIndex() == level:GetCurrentRoomIndex() 
	and level:GetAbsoluteStage() == LevelStage.STAGE1_1 
	and wakaba.state.options.startingroomindexed
	then return false end

	return true
end

function wakaba:HasBless(player, includeWakaba)
	includeWakaba = includeWakaba or true
	if includeWakaba and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Wakaba", false) then
    return true
	elseif player:HasCollectible(wakaba.COLLECTIBLE_WAKABAS_BLESSING) or player:HasCollectible(wakaba.COLLECTIBLE_WAKABA_DUALITY) then
		return true
	else
		return false
	end
end

function wakaba:GetBlessNum(player, includeWakaba)
	includeWakaba = includeWakaba or true
	local r = 0
	if includeWakaba and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Wakaba", false) then
		r = r + 1
	end
	return r + player:GetCollectibleNum(wakaba.COLLECTIBLE_WAKABAS_BLESSING) + player:GetCollectibleNum(wakaba.COLLECTIBLE_WAKABA_DUALITY)
end

function wakaba:ReEvaluateNemesisStats(player)
	wakaba:GetPlayerEntityData(player)
	if player:GetCollectibleCount() ~= player:GetData().wakaba.currItemNum and not player:IsHoldingItem() then
		player:GetData().wakaba.currItemNum = player:GetCollectibleCount()
		player:GetData().wakaba.nemesisdmg = player:GetData().wakaba.nemesisdmg or 0
		player:GetData().wakaba.nemesisdmg = player:GetData().wakaba.nemesisdmg + 10.8
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end
end

function wakaba:HasNemesis(player, includeWakaba)
	includeWakaba = includeWakaba or true
	if includeWakaba and player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) then
		wakaba:ReEvaluateNemesisStats(player)
    return true
	elseif player:HasCollectible(wakaba.COLLECTIBLE_WAKABAS_NEMESIS) or player:HasCollectible(wakaba.COLLECTIBLE_WAKABA_DUALITY) then
		wakaba:ReEvaluateNemesisStats(player)
		return true
	else
		return false
	end
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
		if Game():GetRoom():GetDoor(i) and Game():GetRoom():GetDoor(i).TargetRoomIndex==-1 then
			dealdoor=Game():GetRoom():GetDoor(i)
			doorcount=doorcount+1
		end
	end
end



wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	local level = Game():GetLevel()
	local room = Game():GetRoom()
  ignorelist = {}
  hidelist = {}  
	
	local bless = false
	local nemesis = false
	local duality = false
  for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.blessmantle = nil
		if wakaba:HasBless(player) then
			bless = true
			if player:GetHearts() + player:GetSoulHearts() + player:GetBoneHearts() - player:GetRottenHearts() <= 2 then
				--print("Holy Mantle for Wakaba's Blessing activated")
				if Game():GetRoom():GetType() == RoomType.ROOM_BOSS and StageAPI and not Game():GetRoom():IsClear() then
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
	and not Game().Challenge == wakaba.challenges.CHALLENGE_RAND then
		if wakaba.state.hasbless and not wakaba.state.hasnemesis then
			level:InitializeDevilAngelRoom(true, false)
		elseif not wakaba.state.hasbless and wakaba.state.hasnemesis then
			level:InitializeDevilAngelRoom(false, true)
		end
	end ]]
	
	
  if room:IsFirstVisit() then
    local items = Isaac.FindByType(5, 100, -1, false, false)
    for i, e in ipairs(items) do
			if (wakaba.state.hasbless and wakaba.state.hasnemesis) and wakaba:ShouldRemoveIndex() then
				e:ToPickup().OptionsPickupIndex = 0
			end
    end
		wakaba.state.spent = false
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
	local blesscount = 0
	local nemesiscount = 0
	local wakababrcount = 0
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if wakaba:HasBless(player) then
			blesscount = blesscount + 1
		end
		if wakaba:HasNemesis(player) then
			nemesiscount = nemesiscount + 1
		end
		if wakaba:TaintedWakabaBirthright(player) then
			wakababrcount = wakababrcount + 1
		end
	end
	if blesscount > 0 then wakaba.state.hasbless = true else wakaba.state.hasbless = false end
	if nemesiscount > 0 then wakaba.state.hasnemesis = true else wakaba.state.hasnemesis = false end
	if wakababrcount > 0 then haswakababr_b = true else haswakababr_b = false end

	--collectible
	
	local items = Isaac.FindByType(5, 100, -1, false, false)
	for i, e in ipairs(items) do
		if wakaba.state.hasbless and wakaba.state.hasnemesis then
			if wakaba:ShouldRemoveIndex()  then
				e:ToPickup().OptionsPickupIndex = 0
			end
		elseif (wakaba.state.hasbless or wakaba.state.hasnemesis) and (e.SubType == CollectibleType.COLLECTIBLE_POLAROID or e.SubType == CollectibleType.COLLECTIBLE_NEGATIVE) then
			e:ToPickup().OptionsPickupIndex = 0
		end
	end
	
	--collectible end
	if wakaba.state.hasbless and not wakaba.state.hasnemesis then
		if Game():GetLevel():GetAngelRoomChance() < 1 then
			Game():GetLevel():AddAngelRoomChance(1 - Game():GetLevel():GetAngelRoomChance())
		end
		--[[ if Game():GetDevilRoomDeals() > 0 then
			Game():AddDevilRoomDeal(-Game():GetDevilRoomDeals())
		end ]]
	elseif not wakaba.state.hasbless and wakaba.state.hasnemesis then
		if Game():GetDevilRoomDeals() < 1 then
			Game():AddDevilRoomDeal()
		end
		if Game():GetLevel():GetAngelRoomChance() > 0 then
			Game():GetLevel():AddAngelRoomChance(-Game():GetLevel():GetAngelRoomChance())
		end
	end

	
	--[[ if removesatanwisp then
		
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			wakaba:CleanupContinueSatanWisps(_, player)
		end
	end ]]
	
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.blessnemesis)
--LagCheck


function wakaba:TakeDmg_BlessNemesis(player, amount, flag, source, countdownFrames)
	player = player:ToPlayer()
	if player and player:GetPlayerType() ~= PlayerType.PLAYER_THELOST_B and wakaba:HasBless(player) and not player:GetData().wakaba.blessmantle then
		if player:GetHearts() + player:GetSoulHearts() + player:GetBoneHearts() - player:GetRottenHearts() <= (2 + amount) then
			player:GetData().wakaba.blessmantlenum = wakaba:GetBlessNum(player)
			player:GetData().wakaba.blessmantle = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.TakeDmg_BlessNemesis, EntityType.ENTITY_PLAYER)


function wakaba:pickupinit(pickup)
	local haslost = false
	local steamcount = 0
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		--[[ if player:GetPlayerType() == 10
		or player:GetPlayerType() == 31
		or player:GetPlayerType() == 39
		then
			haslost = true
		end ]]
		if player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE) then
			steamcount = steamcount + 1
		end
	end
	
	if wakaba.state.hasnemesis then
		if Game():GetRoom():GetType() == RoomType.ROOM_DEVIL and pickup:IsShopItem() and pickup.Price ~= -1000 then
			pickup.Price = 12 -- Discount at least once
			for i = 0, steamcount do
				pickup.Price = pickup.Price // 2
			end
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.pickupinit)
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.pickupinit)

function wakaba:RevealItemImage(pickup, offset)
	pickup:GetData().wakaba = pickup:GetData().wakaba or {}

	local itemData = Isaac.GetItemConfig():GetCollectible(pickup.SubType)
	if not pickup:GetData().wakaba.removequestion
	and pickup.SubType > 0 and itemData then
		local hasbless = false
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if wakaba:HasBless(player) or wakaba:HasNemesis(player) or wakaba:HasShiori(player) then
				hasbless = true
			end
		end
		if hasbless and Game():GetRoom():GetType() == RoomType.ROOM_TREASURE and Game().Challenge ~= wakaba.challenges.CHALLENGE_RAND then
			local sprite = pickup:GetSprite()
			
			sprite:ReplaceSpritesheet(1, itemData.GfxFileName)
			sprite:LoadGraphics()
			pickup:GetData().wakaba.removequestion = true
			pickup:GetData().EID_DontHide = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, wakaba.RevealItemImage, PickupVariant.PICKUP_COLLECTIBLE)

function wakaba:GetCard_Nemesis(rng, currentCard, playing, runes, onlyRunes)
	local hasnemesis = false
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if wakaba:HasNemesis(player) then
			hasnemesis = true
		end
	end
	local randomInt = rng:RandomInt(1000000)
	if hasnemesis and currentCard ~= Card.CARD_HOLY then
		if Game().Difficulty == Difficulty.DIFFICULTY_NORMAL and randomInt <= 250000 then
			return Card.CARD_CRACKED_KEY
		elseif Game().Difficulty == Difficulty.DIFFICULTY_HARD and randomInt <= 115000 then
			return Card.CARD_CRACKED_KEY
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_GET_CARD, wakaba.GetCard_Nemesis)

--[[ function wakaba:OnGameExit_BlessNemesis(shouldSave)
	removesatanwisp = true
end

wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.OnGameExit_BlessNemesis)


function wakaba:Init_BlessNemesis(continue)
	removesatanwisp = true
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.Init_BlessNemesis) ]]