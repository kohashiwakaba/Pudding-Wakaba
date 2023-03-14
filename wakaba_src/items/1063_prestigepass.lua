local isc = require("wakaba_src.libs.isaacscript-common")

local finalBossID = {
	isc.BossID.MOMS_HEART,
	isc.BossID.ISAAC,
	isc.BossID.BLUE_BABY,
	isc.BossID.SATAN,
	isc.BossID.THE_LAMB,
	isc.BossID.MEGA_SATAN,
	isc.BossID.ULTRA_GREED,
	isc.BossID.HUSH,
	isc.BossID.DELIRIUM,
	isc.BossID.MOTHER,
	isc.BossID.MAUSOLEUM_MOMS_HEART,
	isc.BossID.DOGMA,
	isc.BossID.BEAST,
}

local function isFinalBossRoom(room)
	for i, bossid in ipairs(finalBossID) do
		if room:GetBossID() == bossid then return true end
	end
	return false
end

function wakaba:RoomClearAwards_PrestigePass(rng, pos)
  local currentStage = wakaba.G:GetLevel():GetAbsoluteStage()
	local room = wakaba.G:GetRoom()
	if room:GetType() == RoomType.ROOM_BOSS and not isFinalBossRoom(room) then
		for i = 1, isc:getTotalPlayerCollectibles(wakaba.Enums.Collectibles.PRESTIGE_PASS) do
			local freeSpawnPos = room:FindFreePickupSpawnPosition(Vector(120, 120))
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, freeSpawnPos, Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_SLOT, wakaba.Enums.Slots.CRYSTAL_RESTOCK, 3, freeSpawnPos, Vector.Zero, nil)
			SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClearAwards_PrestigePass)

local allowdRestockRoomType = {
	RoomType.ROOM_ANGEL,
	RoomType.ROOM_BLACK_MARKET,
	RoomType.ROOM_DEVIL,
	RoomType.ROOM_PLANETARIUM,
	RoomType.ROOM_SECRET,
	RoomType.ROOM_ULTRASECRET,
}
function wakaba:NewRoom_PrestigePass()
  local room = wakaba.G:GetRoom()
  local level = wakaba.G:GetLevel()
  local currentstage = level:GetAbsoluteStage()
  local currentroomtype = room:GetType()
	if (wakaba:has_value(allowdRestockRoomType, currentroomtype)
    or (currentstage == LevelStage.STAGE6 and isc:inStartingRoom())
  )
  and room:IsFirstVisit() then
		for i = 1, isc:getTotalPlayerCollectibles(wakaba.Enums.Collectibles.PRESTIGE_PASS) do
			local freeSpawnPos = room:FindFreePickupSpawnPosition(Vector(120, 120))
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, freeSpawnPos, Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_SLOT, isc.SlotVariant.SHOP_RESTOCK_MACHINE, 0, freeSpawnPos, Vector.Zero, nil)
			SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_PrestigePass)