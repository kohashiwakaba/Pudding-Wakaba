wakaba.COLLECTIBLE_DEJA_VU = Isaac.GetItemIdByName("Deja Vu")

--[[ 
function wakaba:CheckItemCandidates(player)
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		wakaba:GetPlayerEntityData(player)
		local DejaVuCandidates = {}
		local AlbireoCandidates = {}

		-- Item tables. Used Job mod as Reference.
		for itemId = 1, wakaba:GetMaxCollectibleID() do
			local targetItem = wakaba.ItemConfig:GetCollectible(itemId)
			
			if targetItem and not targetItem:HasTags(ItemConfig.TAG_QUEST)
			and (targetItem.Type == ItemType.ITEM_PASSIVE or targetItem.Type == ItemType.ITEM_FAMILIAR)
			then
				for i = 1, player:GetCollectibleNum(itemId) do
					DejaVuCandidates[#DejaVuCandidates + 1] = itemId
				end
			elseif targetItem and targetItem:HasTags(ItemConfig.TAG_STARS) then
				for i = 1, player:GetCollectibleNum(itemId) do
					AlbireoCandidates[#AlbireoCandidates + 1] = itemId
				end
			end
		end
		player:GetData().wakaba.DejaVuCandidates = DejaVuCandidates
		player:GetData().wakaba.AlbireoCandidates = AlbireoCandidates

	end
end ]]

function wakaba:NewRoom_DejaVu()
	if not Game():GetRoom():IsFirstVisit() then return end
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.COLLECTIBLE_DEJA_VU) then
			local chance = player:GetCollectibleRNG(wakaba.COLLECTIBLE_DEJA_VU):RandomInt(1000000)
			if chance <= 100000 then
				SFXManager():Play(SoundEffect.SOUND_MOM_VOX_EVILLAUGH)
				break
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_DejaVu)
