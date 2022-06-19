wakaba.TRINKET_HARD_BOOK = Isaac.GetTrinketIdByName("Hard Book")

function wakaba:PreTakeDamage_HardBook(entity, amount, flags, source, countdown)
	if entity.Type == EntityType.ENTITY_PLAYER then
		local player = entity:ToPlayer()
		if player:HasTrinket(wakaba.TRINKET_HARD_BOOK) then
			local random = wakaba.RNG:RandomInt(100)
			if Game():GetRoom():GetType() == RoomType.ROOM_SACRIFICE or wakaba:IsLost(player) then
				random = 0
			end
			if random <= 5 then
				local oldTrinketCount = player:GetTrinketMultiplier(wakaba.TRINKET_HARD_BOOK)
				player:TryRemoveTrinket(wakaba.TRINKET_HARD_BOOK)
				local newTrinketCount = player:GetTrinketMultiplier(wakaba.TRINKET_HARD_BOOK)
				local spawnedBooks = {}
				for i = 1, (oldTrinketCount - newTrinketCount) do
					local books = wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_HARD_BOOK)
					local selected = books[player:GetTrinketRNG(wakaba.TRINKET_HARD_BOOK):RandomInt(#books) + 1]
					while(wakaba:has_value(spawnedBooks, selected)) do
						selected = books[player:GetTrinketRNG(wakaba.TRINKET_HARD_BOOK):RandomInt(#books) + 1]
					end
					table.insert(spawnedBooks, selected)
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, selected, Game():GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, player)
					Game():GetItemPool():RemoveCollectible(selected)
				end
				if wakaba:IsLost(player) then
					player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
					return false
				end
			end
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.PreTakeDamage_HardBook)