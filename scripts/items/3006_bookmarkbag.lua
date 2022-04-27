wakaba.TRINKET_BOOKMARK_BAG = Isaac.GetTrinketIdByName("Bookmark Bag")


function wakaba:NewRoom_BookmarkBag()
	if Game():GetRoom():IsFirstVisit() then
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if player:HasTrinket(wakaba.TRINKET_BOOKMARK_BAG) then
				local books = wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_SHIORI)
				if books and #books > 0 then
					local rng2 = player:GetTrinketRNG(wakaba.TRINKET_BOOKMARK_BAG)
					local subrandom = rng2:RandomInt(#books) + 1
					local selected = books[subrandom]
					player:SetPocketActiveItem(selected, ActiveSlot.SLOT_POCKET2, true)
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_BookmarkBag)
