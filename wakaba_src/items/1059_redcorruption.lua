local isc = _wakaba.isc
local baseChance = wakaba.Enums.Constants.RED_CORRUPTION_BASE_CHANCE
local parLuck = wakaba.Enums.Constants.RED_CORRUPTION_PAR_LUCK


function wakaba:UpdateRoomDisplayFlags(initroomdesc)
	local level = wakaba.G:GetLevel()
	local roomdesc = level:GetRoomByIdx(initroomdesc.GridIndex)
	local roomdata = roomdesc.Data
	if level:GetRoomByIdx(roomdesc.GridIndex).DisplayFlags then
		if level:GetRoomByIdx(roomdesc.GridIndex) ~= level:GetCurrentRoomDesc().GridIndex then
			if roomdata then
				if level:GetStateFlag(LevelStateFlag.STATE_FULL_MAP_EFFECT) then
					roomdesc.DisplayFlags = 111
				elseif roomdata.Type ~= RoomType.ROOM_DEFAULT and roomdata.Type ~= RoomType.ROOM_SECRET and roomdata.Type ~= RoomType.ROOM_SUPERSECRET and roomdata.Type ~= RoomType.ROOM_ULTRASECRET and level:GetStateFlag(LevelStateFlag.STATE_COMPASS_EFFECT) then
					roomdesc.DisplayFlags = 111
				elseif roomdata and level:GetStateFlag(LevelStateFlag.STATE_BLUE_MAP_EFFECT) and (roomdata.Type == RoomType.ROOM_SECRET or roomdata.Type == RoomType.ROOM_SUPERSECRET) then
					roomdesc.DisplayFlags = 111
				elseif level:GetStateFlag(LevelStateFlag.STATE_MAP_EFFECT) then
					roomdesc.DisplayFlags = 001
				else
					roomdesc.DisplayFlags = 0
				end
			end
		end
	end
end

function wakaba:NewLevel_RedCorruption()
	local game = wakaba.G
	local level = game:GetLevel()
	local rng = RNG()
	rng:SetSeed(level:GetDungeonPlacementSeed(), 35)
	if level:GetAbsoluteStage() == LevelStage.STAGE4_3 or level:GetAbsoluteStage() == LevelStage.STAGE8 then return end
	local corruptionPower = 0
	local totalLuck = 0
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		corruptionPower = corruptionPower + player:GetCollectibleNum(wakaba.Enums.Collectibles.RED_CORRUPTION)
		totalLuck = totalLuck + math.max(-5, player.Luck)
	end)
	local blacklisted = {}

	local function isBlacklisted(gridIndex, doorSlot)
		for _, entry in ipairs(blacklisted) do
			if entry[1] == gridIndex and entry[2] == doorSlot then
				return true
			end
		end
	end
	if corruptionPower > 0 and not game:IsGreedMode() then
		local iterationCount = wakaba:IsLunatic() and 0 or 1
		local candidates = {}
		for i = 0, iterationCount do
			wakaba.Log("Corruption begin : Take", i)
			candidates = {}
			for i=0,168 do
				local roomDesc = level:GetRoomByIdx(i)
				if roomDesc.Data
				and (roomDesc.Data.Shape == RoomShape.ROOMSHAPE_1x1)
				and (roomDesc.Data.Type ~= RoomType.ROOM_DEFAULT)
				and (roomDesc.Data.Type ~= RoomType.ROOM_BOSS)
				and (roomDesc.Data.Type ~= RoomType.ROOM_ULTRASECRET)
				then
					table.insert(candidates, i)
				end
			end
			for _, e in ipairs(candidates) do
				for d = 0, 3 do
					if not isBlacklisted(e, d) and isc:isDoorSlotValidAtGridIndexForRedRoom(d, e) then
						local chance = wakaba:StackChance(baseChance + wakaba:LuckBonus(totalLuck, parLuck, 1 - baseChance), corruptionPower)
						local res = rng:RandomFloat()
						local success = false
						if res < chance then
							success = level:MakeRedRoomDoor(e, d)
							if success then
								table.insert(blacklisted, {e, d})
							end
						end
						wakaba.Log("Corruption loc :", e, "/ slot :", d, "/ chance :", wakaba:Round(chance, 0.001), "/ result :", wakaba:Round(res, 0.001), "/ success :", success)
					end
				end
			end
		end
		wakaba.Log("Corruption end")
		level:UpdateVisibility()
		for i=0,168 do
			local roomDesc = level:GetRoomByIdx(i)
			if roomDesc.Data then
				if (roomDesc.Data.Type > 1) then
					roomDesc.DisplayFlags = 111
					if (roomDesc.Data.Type ~= RoomType.ROOM_BOSS) then
						roomDesc.Flags = roomDesc.Flags | RoomDescriptor.FLAG_RED_ROOM
					end
					if MinimapAPI then
						local mRoom = MinimapAPI:GetRoomByIdx(roomDesc.GridIndex)
						if mRoom then
							mRoom.Color = Color(1,0.25,0.25,1,0,0,0)
							if not mRoom.Descriptor then
								mRoom.Descriptor = roomDesc
							end
						end
					end
				else
					if roomDesc.Flags & RoomDescriptor.FLAG_RED_ROOM == RoomDescriptor.FLAG_RED_ROOM then
						roomDesc.Flags = roomDesc.Flags ~ RoomDescriptor.FLAG_RED_ROOM
					end
					wakaba:UpdateRoomDisplayFlags(roomDesc)
					if MinimapAPI then
						local mRoom = MinimapAPI:GetRoomByIdx(roomDesc.GridIndex)
						if mRoom then
							mRoom.Color = nil
							if not mRoom.Descriptor then
								mRoom.Descriptor = roomDesc
							end
						end
					end
				end
			end
		end
		level:UpdateVisibility()
		if MinimapAPI then
			MinimapAPI:LoadDefaultMap()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_RedCorruption)


function wakaba:PostGetCollectible_RedCorruption(player, item)
	local game = wakaba.G
	local level = game:GetLevel()
	level:ApplyCompassEffect()
	if game:IsGreedMode() then
		level:ApplyBlueMapEffect()
	end
	level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST | wakaba.curses.CURSE_OF_FAIRY)
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_RedCorruption, wakaba.Enums.Collectibles.RED_CORRUPTION)