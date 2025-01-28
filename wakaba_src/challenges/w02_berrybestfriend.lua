
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_PLUM

function wakaba:Challenge_PlayerUpdate_BerryBestFriend(player)
	if wakaba.G.Challenge ~= c then return end
	wakaba.HiddenItemManager:CheckStack(player, wakaba.Enums.Collectibles.PLUMY, 1, "WAKABA_CHALLENGES")
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_BerryBestFriend)

function wakaba:Challenge_PreReroll_BerryBestFriend(itemPoolType, decrease, seed)
	if wakaba.G.Challenge == c then
		if wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSS then
			if wakaba.G:GetLevel():GetAbsoluteStage() == 2 then
				return CollectibleType.COLLECTIBLE_CUPIDS_ARROW
			elseif wakaba.G:GetLevel():GetAbsoluteStage() == 4 then
				return CollectibleType.COLLECTIBLE_JACOBS_LADDER
			elseif wakaba.G:GetLevel():GetAbsoluteStage() == 6 then
				return CollectibleType.COLLECTIBLE_SPOON_BENDER
			end
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, -18000, wakaba.Challenge_PreReroll_BerryBestFriend)