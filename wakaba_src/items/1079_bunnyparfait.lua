--[[ 
	Bunny Parfait (토끼 파르페) - 패시브
	방 번호에 따라 랜덤 아이템 효과, 사망 시 전 방에서 리라로 부활
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")


function wakaba:NewRoom_BunnyParfait()
	local room = wakaba.G:GetRoom()
	local roomData = wakaba.G:GetLevel():GetCurrentRoomDesc().Data
	local roomNo = roomData.Variant
	local type = roomNo % 5
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.BUNNY_PARFAIT) then
			if type == 0 then
				wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_SPOON_BENDER, -1, 1, "WAKABA_BUNNY_PARFAIT")
			elseif type == 1 then
				wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_CRICKETS_BODY, -1, 1, "WAKABA_BUNNY_PARFAIT")
			elseif type == 2 then
				wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_ROTTEN_TOMATO, -1, 1, "WAKABA_BUNNY_PARFAIT")
			elseif type == 3 then
				wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_HOLY_LIGHT, -1, 1, "WAKABA_BUNNY_PARFAIT")
			elseif type == 4 then
				wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_JACOBS_LADDER, -1, 1, "WAKABA_BUNNY_PARFAIT")
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_BunnyParfait)

function wakaba:Cache_BunnyParfait(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.BUNNY_PARFAIT) then
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			--player.TearFlags = player.TearFlags
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_BunnyParfait)