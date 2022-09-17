wakaba.state.currentlibraryindex = 0

function wakaba:HasShiori(player)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Shiori", false) then
    return true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) then
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_SHIORI) then
		return true
	else
		return false
	end
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
	local level = Game():GetLevel()
	local room = Game():GetRoom()
	if true --[[ level:GetStartingRoomIndex() == level:GetCurrentRoomIndex() and room:IsFirstVisit() ]] then
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_SHIORI)then
				local books = wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
				if #books < 1 then
					books = wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_HARD_BOOK)
				end
				local selected = books[wakaba.RNG:RandomInt(#books) + 1]
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, selected, Isaac.GetFreeNearPosition(room:GetGridPosition(102), 32.0), Vector.Zero, player)
				table.insert(wakaba.state.shioridropped, selected)
				Game():GetItemPool():RemoveCollectible(selected)
			elseif player:GetPlayerType() == wakaba.PLAYER_SHIORI
			and (wakaba.state.currentshiorimode == wakaba.shiorimodes.SHIORI_COLLECTOR and Game().TimeCounter > 0) then
				local books = wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_SHIORI)
				if #books < 1 then
					books = wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_HARD_BOOK)
				end
				if Game().TimeCounter > 0 then
					for i = #books, 1, -1 do
						if wakaba:has_value(player:GetData().wakaba.books, books[i]) then
							table.remove(books, i)
						end
					end
				end
				local selected = books[wakaba.RNG:RandomInt(#books) + 1]
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, selected, Isaac.GetFreeNearPosition(room:GetGridPosition(102), 32.0), Vector.Zero, player)
				table.insert(wakaba.state.shioridropped, selected)
				Game():GetItemPool():RemoveCollectible(selected)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_BookOfShiori)

function wakaba:BookofShioriUpdate()
	local shioricount = 0
	local taintedshioricount = 0
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if wakaba:HasShiori(player) then
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