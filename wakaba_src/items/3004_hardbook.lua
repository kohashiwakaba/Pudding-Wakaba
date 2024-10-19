function wakaba:PostTakeDamage_HardBook(player, amount, flags, source, countdown)
	if player:HasTrinket(wakaba.Enums.Trinkets.HARD_BOOK) then
		wakaba:tryDropHardBook(player)
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_HardBook)

function wakaba:NegateDamage_HardBook(player, amount, flags, source, countdown)
	if player:HasTrinket(wakaba.Enums.Trinkets.HARD_BOOK) and wakaba:IsLost(player) then
		wakaba:tryDropHardBook(player)
		player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
		return false
	end
end
wakaba:AddCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_HardBook)

function wakaba:tryDropHardBook(player)
	local random = player:GetTrinketRNG(wakaba.Enums.Trinkets.HARD_BOOK):RandomInt(100)
	if wakaba.G:GetRoom():GetType() == RoomType.ROOM_SACRIFICE or wakaba:IsLost(player) then
		random = 0
	end
	if random <= 5 then
		local oldTrinketCount = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.HARD_BOOK)
		player:TryRemoveTrinket(wakaba.Enums.Trinkets.HARD_BOOK)
		local newTrinketCount = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.HARD_BOOK)
		local spawnedBooks = {}
		for i = 1, (oldTrinketCount - newTrinketCount) do
			local books = wakaba:getBooks(player, wakaba.bookstate.BOOKSHELF_HARD_BOOK)
			local selected = books[player:GetTrinketRNG(wakaba.Enums.Trinkets.HARD_BOOK):RandomInt(#books) + 1]
			while(wakaba:has_value(spawnedBooks, selected)) do
				selected = books[player:GetTrinketRNG(wakaba.Enums.Trinkets.HARD_BOOK):RandomInt(#books) + 1]
			end
			table.insert(spawnedBooks, selected)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, selected, wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, player)
			wakaba.G:GetItemPool():RemoveCollectible(selected)
		end
	end
end