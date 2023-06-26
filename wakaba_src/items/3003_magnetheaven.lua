function wakaba:PickupUpdate_Magnet(pickup)
	if not pickup then return end
	if pickup:IsShopItem() then return end
	local ismagnet = false
	local coinlimit = 99
	local pooplimit = 9
	local attplayer = nil
	local velocityMode = nil
	local isLast = false
	local allow = true

	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if not attplayer and player:GetPlayerType() ~= PlayerType.PLAYER_CAIN_B and player:HasTrinket(wakaba.Enums.Trinkets.MAGNET_HEAVEN, false) then
			ismagnet = true
			attplayer = player
			velocityMode = "magnet"
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_DEEP_POCKETS) then
			coinlimit = 999
		end
		if player:GetPlayerType() == PlayerType.PLAYER_XXX_B and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			pooplimit = 29
		end
		if pickup.Variant == PickupVariant.PICKUP_COIN and player:GetNumCoins() < coinlimit then allow = true end
		if Retribution and pickup.Variant == Retribution.PICKUPS.SPOILS_COIN and player:GetNumCoins() < coinlimit then allow = true end
		if pickup.Variant == PickupVariant.PICKUP_BOMB and player:GetNumBombs() < 99 then allow = true end
		if pickup.Variant == PickupVariant.PICKUP_KEY and player:GetNumKeys() < 99 then allow = true end
		if pickup.Variant == PickupVariant.PICKUP_POOP and player:GetPoopMana() < pooplimit then allow = true end
		if pickup.Variant == PickupVariant.PICKUP_GRAB_BAG then allow = true end
	end
	if not attplayer or not ismagnet then
		for i, e in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, wakaba.Enums.Effects.POWER_BOMB)) do
			if not attplayer and not ismagnet and e.FrameCount > 45 then
				ismagnet = true
				attplayer = e
				velocityMode = "powerbomb"
				if e:GetSprite():IsFinished("Fading") then
					isLast = true
				end
			end
		end

		for _, entry in ipairs(wakaba.Magnet.PB) do
			if type(entry) == "function" then
				if entry(pickup) then allow = true end
			else
				if pickup.Variant == e[1] and (pickup.SubType == e[2] or e[2] == -1) then allow = true end
			end
		end

	end
	if not attplayer or not ismagnet or not allow then return end

	if pickup.Variant == PickupVariant.PICKUP_COIN and pickup.SubType == CoinSubType.COIN_STICKYNICKEL then
		pickup = pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_NICKEL)
	end
	local playerpos = attplayer.Position
	local oldpos = pickup.Position
	if velocityMode == "powerbomb" then
		pickup.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_NONE
		pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
		if (playerpos - oldpos):Length() > 500 then
			pickup.Velocity = (playerpos - oldpos):Normalized():Resized(100)
		elseif (playerpos - oldpos):Length() > 200 then
			pickup.Velocity = (playerpos - oldpos):Normalized():Resized(40)
		elseif (playerpos - oldpos):Length() > 40 then
			pickup.Velocity = (playerpos - oldpos):Normalized():Resized(20)
			pickup.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
		else
			pickup.Velocity = Vector.Zero
			pickup.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
			pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
		end
	else
		pickup.Velocity = (playerpos - oldpos):Normalized():Resized((playerpos - oldpos):Length() * 0.4)
		pickup.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_Magnet)


function wakaba.PickupInit_Magnet(pickup)
	if pickup.SubType == wakaba.Enums.Trinkets.MAGNET_HEAVEN and wakaba.state.unlock.magnetheaven <= 0 then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.G:GetItemPool():GetTrinket())
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PickupInit_Magnet, PickupVariant.PICKUP_TRINKET)


