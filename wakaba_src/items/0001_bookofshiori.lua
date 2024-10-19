wakaba.state.currentlibraryindex = 0
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:HasShiori(player, includeShiori, includeTLaz)
	if player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
    return true
	elseif player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B then
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_SHIORI) then
		return true
	--[[ elseif includeTLaz and wakaba:isTLaz(player) then
		local tLaz = wakaba:getFlippedForm(player)
		if tLaz:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_SHIORI)then
			return true
		end ]]
	end
	return false
end

function wakaba:HasTaintedShiori(player)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) then
    return true
	--[[ elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) then
		return true ]]
	else
		return false
	end
end

function wakaba:NewLevel_BookOfShiori()
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	if true --[[ level:GetStartingRoomIndex() == level:GetCurrentRoomIndex() and room:IsFirstVisit() ]] then
		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_SHIORI)then
				local books = wakaba:getBooks(player, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
				if #books < 1 then
					books = wakaba:getBooks(player, wakaba.bookstate.BOOKSHELF_HARD_BOOK)
				end
				local selected = books[wakaba.RNG:RandomInt(#books) + 1]
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, selected, Isaac.GetFreeNearPosition(room:GetGridPosition(102), 32.0), Vector.Zero, player)
				table.insert(wakaba.runstate.shioridropped, selected)
				wakaba.G:GetItemPool():RemoveCollectible(selected)
			end
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_BookOfShiori)


function wakaba:RoomGen_BookOfShiori()
	if wakaba.G:IsGreedMode() then return end
	local players = isc:getPlayersWithCollectible(wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
	local fallbackPlayer = wakaba:GetPlayerOfType(wakaba.Enums.Players.SHIORI, true)
	local level = wakaba.G:GetLevel()
	if level:GetAbsoluteStage() == LevelStage.STAGE4_3 or level:GetAbsoluteStage() >= LevelStage.STAGE6 then return end
	if #players == 0 then
		-- TODO
		if --[[ not certain node is allocated ]] true then
			return
		end
	end
	if not wakaba.G:GetLevel():IsAscent() then
		local player = (#players > 0 and players[1]) or fallbackPlayer
		local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
		local s = {}
		table.insert(s, {RoomType.ROOM_LIBRARY, isc:getRandomInt(wakaba.RoomIDs.MIN_SHIORI_LIBRARY_ROOM_ID, wakaba.RoomIDs.MAX_SHIORI_LIBRARY_ROOM_ID, rng)})
		return s
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.ROOM_GENERATION, CallbackPriority.EARLY - 1, wakaba.RoomGen_BookOfShiori)

function wakaba:BookofShioriUpdate()
	local shioricount = 0
	local taintedshioricount = 0
  for i = 1, wakaba.G:GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if wakaba:HasShiori(player, true, true) then
			shioricount = shioricount + 1
		end
		if wakaba:HasTaintedShiori(player) then
			taintedshioricount = taintedshioricount + 1
		end
	end
	if shioricount > 0 then wakaba.hasshiori = true else wakaba.hasshiori = false end
	if taintedshioricount > 0 then wakaba.hastaintedshiori = true else wakaba.hastaintedshiori = false end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE , wakaba.BookofShioriUpdate)
--LagCheck