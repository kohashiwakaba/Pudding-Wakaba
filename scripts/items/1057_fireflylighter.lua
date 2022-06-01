wakaba.COLLECTIBLE_FIREFLY_LIGHTER = Isaac.GetItemIdByName("Firefly Lighter")


function wakaba:NewRoom_FireflyLighter()

	local level = Game():GetLevel()
	local room = Game():GetRoom()
	local currentRoom = level:GetCurrentRoom()
	local currentRoomDesc = level:GetRoomByIdx(level:GetCurrentRoomIndex())
	local currentRoomType = currentRoom:GetType()
	if currentRoomDesc.VisitedCount > 1 then return end

  for i = 0, Game():GetNumPlayers()-1 do
    local player = Isaac.GetPlayer(i)
		if player:HasCollectible(wakaba.COLLECTIBLE_FIREFLY_LIGHTER) then
			currentRoomDesc.NoReward = false
			for i = 1, 120 do
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.WISP, 0, Game():GetRoom():GetRandomPosition(1), Vector(0,0), player):SetColor(Color(0, 1, 1, 1, 0, 0, 0), 2000, 1, false, false)
			end
			--[[ if currentRoomDesc.Flags & RoomDescriptor.FLAG_PITCH_BLACK == RoomDescriptor.FLAG_PITCH_BLACK then
			end ]]
		end
  end

end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_FireflyLighter)

 
function wakaba:PlayerUpdate_FireflyLighter(player)
	if player:HasCollectible(wakaba.COLLECTIBLE_FIREFLY_LIGHTER) then
		local level = Game():GetLevel()
		local currentRoomDesc = level:GetRoomByIdx(level:GetCurrentRoomIndex())
		if currentRoomDesc.NoReward then
			currentRoomDesc.NoReward = false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_FireflyLighter)

function wakaba:Cache_FireflyLighter(player, cacheFlag)
	if player:HasCollectible(wakaba.COLLECTIBLE_FIREFLY_LIGHTER) then
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + (1 * player:GetCollectibleNum(wakaba.COLLECTIBLE_FIREFLY_LIGHTER))
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (80 * player:GetCollectibleNum(wakaba.COLLECTIBLE_FIREFLY_LIGHTER))
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE , wakaba.Cache_FireflyLighter)