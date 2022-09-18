function wakaba:PickupUpdate_Magnet(pickup)
	if not pickup then return end
	if pickup:IsShopItem() then return end
	local ismagnet = false
	local coinlimit = 99
	local pooplimit = 9
	local attplayer = nil
	
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if not attplayer and player:GetPlayerType() ~= PlayerType.PLAYER_CAIN_B and player:HasTrinket(wakaba.Enums.Trinkets.MAGNET_HEAVEN, false) then
			ismagnet = true
			attplayer = player
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_DEEP_POCKETS) then
			coinlimit = 999
		end
		if player:GetPlayerType() == PlayerType.PLAYER_XXX_B and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			pooplimit = 29
		end
		if pickup.Variant == PickupVariant.PICKUP_COIN and player:GetNumCoins() >= coinlimit then return end
		if pickup.Variant == PickupVariant.PICKUP_BOMB and player:GetNumBombs() >= 99 then return end
		if pickup.Variant == PickupVariant.PICKUP_KEY and player:GetNumKeys() >= 99 then return end
		if pickup.Variant == PickupVariant.PICKUP_POOP and player:GetPoopMana() >= pooplimit then return end
	end
	if not attplayer or not ismagnet then return end

	if pickup.Variant == PickupVariant.PICKUP_COIN and pickup.SubType == CoinSubType.COIN_STICKYNICKEL then
		pickup = pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_NICKEL)
	end
	local playerpos = attplayer.Position
	local oldpos = pickup.Position
	pickup.Velocity = (playerpos - oldpos):Normalized():Resized((playerpos - oldpos):Length() * 0.4)

end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_Magnet, PickupVariant.PICKUP_COIN)
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_Magnet, PickupVariant.PICKUP_KEY)
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_Magnet, PickupVariant.PICKUP_BOMB)
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_Magnet, PickupVariant.PICKUP_GRAB_BAG)
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_Magnet, PickupVariant.PICKUP_POOP)


function wakaba.PickupInit_Magnet(pickup)
	if pickup.SubType == wakaba.Enums.Trinkets.MAGNET_HEAVEN and wakaba.state.unlock.magnetheaven <= 0 then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.G:GetItemPool():GetTrinket())
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PickupInit_Magnet, PickupVariant.PICKUP_TRINKET)


