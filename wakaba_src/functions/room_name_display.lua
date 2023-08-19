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
	if wakaba.state.options.hudroomnumber > 0 then
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 0)
		local room = Game():GetRoom()
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = (wakaba.state.options.hudroomnumber == 2 and "No.:" or "")..roomNo,
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 101, function(_)
	if wakaba.state.options.hudroomname > 0 then
		local text = roomName
		if wakaba.state.options.hudroomname == 1 then
			local room = Game():GetRoom()
			local words = {}
			local offset = room:GetFrameCount() // 6
			for word in string.gmatch(roomName, '.') do --Split string into individual words
				words[#words+1] = word;
			end
			if #words > 14 then
				words[#words+1] = " "
				words[#words+1] = "*"
				words[#words+1] = "*"
				words[#words+1] = "*"
				words[#words+1] = " "

				offset = offset % #words
				local renderText = ""
				for i = 1, 14 do
					local word = words[i+offset]
					if not word then
						word = words[i+offset-#words]
					end
					renderText = renderText .. word
				end
				text = renderText
			end

		elseif wakaba.state.options.hudroomname == 3 then
			text = "Name:"..text
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
	if wakaba.state.options.hudroomdiff > 0 then
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 2)
		local room = Game():GetRoom()
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = (wakaba.state.options.hudroomdiff == 2 and "Difficulty:" or "")..roomDifficulty,
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 103, function(_)
	if wakaba.state.options.hudroomweight > 0 then
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 3)
		local room = Game():GetRoom()
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = (wakaba.state.options.hudroomweight == 2 and "Weight:" or "")..roomWeight,
		}
		return tab
	end
end)