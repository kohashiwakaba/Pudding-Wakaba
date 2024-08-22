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
	roomWeight = (math.floor(roomWeight * 1000)) / 1000
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
	if wakaba.state.options.hudroomnumber > 0 and wakaba.state.options.hudroomnumber ~= 3 then

		local a = "RoomNameDisplay"
		local f = 0

		wakaba.globalHUDSprite:RemoveOverlay()
		local bunnyParfait = false
		wakaba:ForAllPlayers(function (player)---@param player EntityPlayer
			bunnyParfait = bunnyParfait or player:HasCollectible(wakaba.Enums.Collectibles.BUNNY_PARFAIT) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.BUNNY_PARFAIT)
		end)
		if bunnyParfait then
			wakaba.globalHUDSprite:SetFrame("BunnyParfait", roomNo % 5)
			a = "BunnyParfait"
			f = roomNo % 5
		else
			wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 0)
		end
		local room = Game():GetRoom()
		local loc = wakaba:getOptionValue("hud_roomno")
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = (wakaba.state.options.hudroomnumber == 2 and "No.:" or "")..roomNo,
			Location = loc,
			SpriteOptions = {
				Anim = a,
				Frame = f,
			},
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 101, function(_)
	if wakaba.state.options.hudroomname > 0 then

		local a = "RoomNameDisplay"
		local f = 1

		wakaba.globalHUDSprite:RemoveOverlay()
		local text = roomName
		if wakaba.state.options.hudroomnumber == 3 then
			local bunnyParfait = false
			wakaba:ForAllPlayers(function (player)---@param player EntityPlayer
				bunnyParfait = bunnyParfait or player:HasCollectible(wakaba.Enums.Collectibles.BUNNY_PARFAIT) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.BUNNY_PARFAIT)
			end)
			if bunnyParfait then
				wakaba.globalHUDSprite:SetFrame("BunnyParfait", roomNo % 5)
				a = "BunnyParfait"
				f = roomNo % 5
			else
				wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 1)
			end
			text = roomNo .. "-" .. text
		else
			wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 1)
		end
		if wakaba.state.options.hudroomname == 1 then
			local room = Game():GetRoom()
			local words = {}
			local offset = room:GetFrameCount() // 6
			for word in string.gmatch(text, '.') do --Split string into individual words
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
		local room = Game():GetRoom()
		local loc = wakaba:getOptionValue("hud_roomname")
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = text,
			Location = loc,
			SpriteOptions = {
				Anim = a,
				Frame = f,
			},
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 102, function(_)
	if wakaba.state.options.hudroomdiff == 3 then
		wakaba.globalHUDSprite:RemoveOverlay()
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 2)
		local room = Game():GetRoom()
		local loc = wakaba:getOptionValue("hud_roomdiff")
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = "D:"..roomDifficulty.."/W:"..roomWeight,
			Location = loc,
			SpriteOptions = {
				Anim = "RoomNameDisplay",
				Frame = 2,
			},
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 102, function(_)
	if wakaba.state.options.hudroomdiff > 0 and wakaba.state.options.hudroomdiff ~= 3 then
		wakaba.globalHUDSprite:RemoveOverlay()
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 2)
		local room = Game():GetRoom()
		local loc = wakaba:getOptionValue("hud_roomdiff")
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = (wakaba.state.options.hudroomdiff == 2 and "Diff:" or "")..roomDifficulty,
			Location = loc,
			SpriteOptions = {
				Anim = "RoomNameDisplay",
				Frame = 2,
			},
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 103, function(_)
	if wakaba.state.options.hudroomweight > 0 and wakaba.state.options.hudroomdiff ~= 3 then
		wakaba.globalHUDSprite:RemoveOverlay()
		wakaba.globalHUDSprite:SetFrame("RoomNameDisplay", 3)
		local room = Game():GetRoom()
		local loc = wakaba:getOptionValue("hud_roomweight")
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = (wakaba.state.options.hudroomweight == 2 and "Weight:" or "")..roomWeight,
			Location = loc,
			SpriteOptions = {
				Anim = "RoomNameDisplay",
				Frame = 3,
			},
		}
		return tab
	end
end)

local function leadingZero(val)
	if val<10 and val>=0 then
		return "0"..val
	end
	return val
end

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 1, function(_)
	if wakaba:getOptionValue("hudtimer") then
		wakaba.globalHUDSprite:RemoveOverlay()
		wakaba.globalHUDSprite:SetFrame("Timer", 0)
		local room = Game():GetRoom()
		local loc = wakaba:getOptionValue("hud_timer")
		local timerType = wakaba:getOptionValue("hudtimer")
		local timestring = ""

		local time = wakaba.G.TimeCounter
		local msecs= time%30
		local secs= math.floor(time/30)%60
		local mins= math.floor(time/30/60)%60
		local hours= math.floor(time/30/60/60)%24

		if timerType == 1 then
			timestring= leadingZero(hours)..":"..leadingZero(mins)..":"..leadingZero(secs).."."..leadingZero(math.floor(msecs * 3.33333))
			format = " 00:00:00.00"
		else
			timestring= leadingZero(hours)..":"..leadingZero(mins)..":"..leadingZero(secs)
			format = " 00:00:00"
		end

		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = timestring,
			Location = loc,
			SpriteOptions = {
				Anim = "Timer",
				Frame = 0,
			},
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 2, function(_)
	if wakaba:getOptionValue("hudsystimer") and os then
		wakaba.globalHUDSprite:RemoveOverlay()
		wakaba.globalHUDSprite:SetFrame("Timer", 1)
		local room = Game():GetRoom()
		local loc = wakaba:getOptionValue("hud_systimer")
		local timerType = wakaba:getOptionValue("hudsystimer")
		local timestring = os.date("%Y-%m-%d %H:%M:%S")

		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = timestring,
			Location = loc,
			SpriteOptions = {
				Anim = "Timer",
				Frame = 1,
			},
		}
		return tab
	end
end)