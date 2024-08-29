local isc = require("wakaba_src.libs.isaacscript-common")

---@param player EntityPlayer
wakaba:AddCallback(ModCallbacks.MC_PRE_TRIGGER_PLAYER_DEATH, function(_, player)
	local level = wakaba.G:GetLevel()
	local data = player:GetData().wakaba
	local revivalData = wakaba:CanRevive(player)
	--local playerIndex = tostring(isc:getPlayerIndex(player))
	if revivalData then
		player:Revive()
		local lastIndex = wakaba.G:GetLevel():GetLastRoomDesc().SafeGridIndex
		if not revivalData.CurrentRoom and not isc:inBeastRoom() then
			local room = wakaba.G:GetRoom()

			local enterDoorIndex = level.EnterDoor
			if enterDoorIndex == -1 or room:GetDoor(enterDoorIndex) == nil or level:GetCurrentRoomIndex() == level:GetPreviousRoomIndex() then
				wakaba.G:StartRoomTransition(level:GetCurrentRoomIndex(), Direction.NO_DIRECTION, RoomTransitionAnim.MAZE)
			else
				local enterDoor = room:GetDoor(enterDoorIndex)
				local targetRoomIndex = enterDoor.TargetRoomIndex
				local targetRoomDirection = enterDoor.Direction

				level.LeaveDoor = -1 -- api why
				wakaba.G:StartRoomTransition(lastIndex, targetRoomDirection, RoomTransitionAnim.MAZE)
			end
		else
			player:SetMinDamageCooldown(150)
		end
		if revivalData.PostRevival then
			revivalData.PostRevival(player)
		end
		wakaba:scheduleForUpdate(function()
			player:AnimateCollectible(revivalData.ID)
		end, 3)
	end
end)