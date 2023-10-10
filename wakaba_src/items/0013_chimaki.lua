--[[ 
	Chimaki (치마키) - 패밀리어 (유니크)
	리라로 하드 모드 체크리스트 달성
	Blind 저주 면역, 다양한 방면으로 캐릭터 보조
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:RoomGen_Chimaki_BossDoor()
	local level = wakaba.G:GetLevel()
	if level:GetAbsoluteStage() == LevelStage.STAGE6 then
		local roomData = isc:getRoomDataForTypeVariant(RoomType.ROOM_BOSS, 42000)
		local writeableRoom = level:GetRoomByIdx(-14, -1)
		local writeablePrevRoom = level:GetRoomByIdx(-3, -1)
		writeableRoom.Data = roomData
		writeableRoom.SpawnSeed = writeablePrevRoom.SpawnSeed
		writeableRoom.DecorationSeed = writeablePrevRoom.DecorationSeed
		writeableRoom.AwardSeed = writeablePrevRoom.AwardSeed
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_LEVEL, CallbackPriority.EARLY, wakaba.RoomGen_Chimaki_BossDoor)

function wakaba:RoomClear_Chimaki_BossDoor(rng, spawnPosition)
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	local bossID = room:GetBossID()
	if level:GetAbsoluteStage() == LevelStage.STAGE6 and (bossID == 40 or bossID == 54) and room:IsClear() then
		--room:TrySpawnMegaSatanRoomDoor(true)
		room:TrySpawnBlueWombDoor(true, true, true)
		local doors = isc:getDoorsToRoomIndex(-8)
		for _, door in ipairs(doors) do
			door.TargetRoomIndex = -14
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_Chimaki_BossDoor)
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_ROOM, CallbackPriority.EARLY, wakaba.RoomClear_Chimaki_BossDoor)