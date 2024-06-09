--[[ function wakaba:NewRoom_StarReversal()
	local room = wakaba.G:GetRoom()
	for i = 0, wakaba.G:GetNumPlayers() -1 do
		if player:HasTrinket(wakaba.Enums.Trinkets.STAR_REVERSAL) then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_PLANETARIUM), Isaac.GetFreeNearPosition(room:GetCenterPos(), 40.0), Vector.Zero, nil)
			player:RemoveTrinket(wakaba.Enums.Trinkets.STAR_REVERSAL)
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_StarReversal) ]]

local sfx = SFXManager()

local function shouldActivateReversal()
	local room = wakaba.G:GetRoom()
	return room:GetType() == RoomType.ROOM_TREASURE or wakaba:IsValidWakabaRoom(Game():GetLevel():GetCurrentRoomDesc(), wakaba.RoomTypes.WINTER_ALBIREO)
end

function wakaba:PickupUpdate_StarReversal(trinket)
	if trinket.SubType % 32768 ~= wakaba.Enums.Trinkets.STAR_REVERSAL or trinket.Touched ~= true then return end
	local sprite = trinket:GetSprite()
	local room = wakaba.G:GetRoom()
	if shouldActivateReversal() then
		if sprite:IsEventTriggered("DropSound") then
			--local newPos = Isaac.GetFreeNearPosition(trinket.Position, 40.0)
			if trinket.SubType > 32768 then
				sfx:Play(SoundEffect.SOUND_SOUL_PICKUP, 1, 0, false, 1)
				for i = 1, 2 do
					local newPos = Isaac.GetFreeNearPosition(trinket.Position, 40.0)
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_PLANETARIUM), newPos, Vector.Zero, nil)
				end
				trinket:Remove()
			else
				sfx:Play(SoundEffect.SOUND_SOUL_PICKUP, 1, 0, false, 1)
				local newPos = Isaac.GetFreeNearPosition(trinket.Position, 40.0)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_PLANETARIUM), newPos, Vector.Zero, nil)
				trinket:Remove()
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_StarReversal, PickupVariant.PICKUP_TRINKET)

function wakaba:PlayerUpdate_StarReversal(player)
	if not player:IsHoldingItem() and wakaba:PlayerHasSmeltedTrinket(player, wakaba.Enums.Trinkets.STAR_REVERSAL, true) then
		local room = wakaba.G:GetRoom()
		if Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex) and shouldActivateReversal() then
			local oldTrinketCount = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.STAR_REVERSAL)
			player:TryRemoveTrinket(wakaba.Enums.Trinkets.STAR_REVERSAL)
			local newTrinketCount = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.STAR_REVERSAL)
			for i = 1, (oldTrinketCount - newTrinketCount) do
				sfx:Play(SoundEffect.SOUND_SOUL_PICKUP, 1, 0, false, 1)
				local newPos = room:FindFreePickupSpawnPosition(player.Position)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_PLANETARIUM), newPos, Vector.Zero, nil)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_StarReversal)