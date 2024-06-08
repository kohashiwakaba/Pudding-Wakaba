
---@param player EntityPlayer
wakaba:AddCallback(ModCallbacks.MC_PRE_TRIGGER_PLAYER_DEATH, function(_, player)
	local data = player:GetData().wakaba
	local revivalData = wakaba:CanRevive(player)
	--local playerIndex = tostring(isc:getPlayerIndex(player))
	if revivalData then
		player:Revive()
		if not revivalData.CurrentRoom and not isc:inBeastRoom() then
			wakaba.G:StartRoomTransition(wakaba.G:GetLevel():GetLastRoomDesc().SafeGridIndex, -1, 0, player)
		end
		if revivalData.PostRevival then
			revivalData.PostRevival(player)
		end
		wakaba:scheduleForUpdate(function()
			player:AnimateCollectible(revivalData.ID)
		end, 3)
	end
end)