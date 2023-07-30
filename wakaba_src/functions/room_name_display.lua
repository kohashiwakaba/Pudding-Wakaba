local roomNo = ""
local roomName = ""
local roomDifficulty = ""
local roomWeight = ""
local roomSubType = ""

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function (_)
	local data = Game():GetLevel():GetCurrentRoomDesc().Data
	if(Game():GetLevel():GetCurrentRoomDesc().SurpriseMiniboss) then
		data = Game():GetLevel():GetCurrentRoomDesc().OverrideData
	end

	roomName = data.Name
	roomNo = data.Variant
	roomSubType = data.Subtype
	roomWeight = data.InitialWeight
	roomDifficulty = data.Difficulty or data.Weight

	if StageAPI then
		local currentRoom = StageAPI.GetCurrentRoom()
		if currentRoom and currentRoom.Layout then
			data = currentRoom.Layout
			roomName = currentRoom.Layout.Name
		end
	end
end)



wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 100, function(_)
	if true then
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 0)
		local room = Game():GetRoom()
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = roomSubType.."/"..roomNo,
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 101, function(_)
	if true then
		local text = roomName
		if EID and EID:isDisplayingText() then
			text = "..."
		end
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 1)
		local room = Game():GetRoom()
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = text,
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 102, function(_)
	if true then
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 2)
		local room = Game():GetRoom()
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = roomDifficulty,
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 103, function(_)
	if true then
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 3)
		local room = Game():GetRoom()
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = roomWeight,
		}
		return tab
	end
end)