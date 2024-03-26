--[[ 
	Bunny Parfait (토끼 파르페) - 패시브
	방 번호에 따라 랜덤 아이템 효과, 사망 시 전 방에서 리라로 부활
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

---@param player EntityPlayer
local function hasParfaitEffect(player)
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.parfaitcount = player:GetData().wakaba.parfaitcount or 0
	return player:HasCollectible(wakaba.Enums.Collectibles.BUNNY_PARFAIT) or player:GetData().wakaba.parfaitcount > 0
end

---@param player EntityPlayer
local function getParfaitEffectNum(player)
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.parfaitcount = player:GetData().wakaba.parfaitcount or 0
	return player:GetCollectibleNum(wakaba.Enums.Collectibles.BUNNY_PARFAIT) + player:GetData().wakaba.parfaitcount
end

function wakaba:NewRoom_BunnyParfait()
	local room = wakaba.G:GetRoom()
	local roomData = wakaba.G:GetLevel():GetCurrentRoomDesc().Data
	local roomNo = roomData.Variant
	local type = roomNo % 5
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if hasParfaitEffect(player) then
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
	if hasParfaitEffect(player) then
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			--player.TearFlags = player.TearFlags
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_BunnyParfait)

function wakaba:AfterRevival_BunnyParfait(player)
	player:GetData().wakaba.parfaitcount = (player:GetData().wakaba.parfaitcount or 0) + 1
	if player:GetPlayerType() == wakaba.Enums.Players.RIRA_B then
		player:AddSoulHearts(6)
	else
		player:ChangePlayerType(wakaba.Enums.Players.RIRA)
		wakaba:AfterRiraInit(player)
		--wakaba:GetRiraCostume(player)
		player:AddMaxHearts(-200)
		player:AddBoneHearts(-12)
		player:AddSoulHearts(-36)
		player:AddMaxHearts(6)
		player:AddHearts(6)
	end
	wakaba:scheduleForUpdate(function ()
		player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.BUNNY_PARFAIT, false, 1)
	end, 1)
	player:RemoveCollectible(wakaba.Enums.Collectibles.BUNNY_PARFAIT)
end

