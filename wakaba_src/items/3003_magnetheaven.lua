local maxMult = 0
wakaba.MagnetPlayer = nil ---@type EntityPlayer|EntityEffect
wakaba.MagnetChecker = nil ---@type EntityNPC
function wakaba:PostUpdate_MagnetHeaven()
	maxMult = 0
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		maxMult = math.max(maxMult, player:GetTrinketMultiplier(wakaba.Enums.Trinkets.MAGNET_HEAVEN))
	end)
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostUpdate_MagnetHeaven)

function wakaba:Update_MagnetHeaven()
	wakaba.MagnetPlayer = nil
	for i, e in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, wakaba.Enums.Effects.POWER_BOMB)) do
		if e.FrameCount > 45 then
			if e:GetSprite():IsFinished("Fading") then
				wakaba.MagnetPlayer = e
			end
		end
	end
	wakaba:ForAllPlayers(function (player)---@param player EntityPlayer
		if wakaba.MagnetPlayer then return end
		if Input.IsButtonPressed(Keyboard.KEY_RIGHT_SHIFT, player.ControllerIndex) or player:HasCollectible(wakaba.Enums.Trinkets.MAGNET_HEAVEN) then
			wakaba.MagnetPlayer = player
		end
	end)
	if wakaba.MagnetPlayer and wakaba.MagnetPlayer.Type == EntityType.ENTITY_PLAYER then
		if not wakaba.MagnetChecker then
			wakaba.MagnetChecker = Isaac.Spawn(EntityType.ENTITY_SHOPKEEPER, 0, 0, Vector.Zero, Vector.Zero, player):ToNPC()
			wakaba.MagnetChecker.Visible = false
			wakaba.MagnetChecker:AddEntityFlags(EntityFlag.FLAG_NO_QUERY)
			wakaba.MagnetChecker.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
			wakaba.MagnetChecker.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_NONE
		end
	elseif wakaba.MagnetChecker and wakaba.MagnetChecker:Exists() then
		wakaba.MagnetChecker:Remove()
		wakaba.MagnetChecker = nil
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_MagnetHeaven)

---@param pickup EntityPickup
function wakaba:PickupUpdate_MagnetHeaven_temp(pickup)
	if not pickup then return end
	if pickup:IsShopItem() then return end
	if not wakaba.MagnetPlayer then return end

	local ignoreObstructed = wakaba.MagnetPlayer.CanFly
	local shouldPull = false
	local magnetMode = wakaba.MagnetPlayer.Type == EntityType.ENTITY_EFFECT and "powerbomb" or "player"
	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.EVALUATE_MAGNET_HEAVEN)) do
		if not callback.Param or callback.Param == pickup.Variant then
			local evals = callback.Function(callback.Mod, callback.Param, wakaba.MagnetPlayer, pickup, wakaba.MagnetChecker, ignoreObstructed)
			if evals then
				if type(evals) == "boolean" then
					shouldPull = evals
				elseif type(evals) == "table" then
					shouldPull = evals.ShouldPull
					magnetMode = evals.MagnetMode
				end
			end
		end
	end

	if shouldPull then
		if pickup.Variant == PickupVariant.PICKUP_COIN and pickup.SubType == CoinSubType.COIN_STICKYNICKEL then
			pickup.SubType = CoinSubType.COIN_NICKEL
			--pickup = pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_NICKEL)
		end
	end
end

---@param pickupVar PickupVariant
---@param playerOrEffect EntityPlayer
---@param pickup EntityPickup
---@param checker EntityNPC
---@param ignoreObstructed boolean
function wakaba:MagnetCondition_MagnetHeaven(pickupVar, playerOrEffect, pickup, checker, ignoreObstructed)
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_MAGNET_HEAVEN, wakaba.MagnetCondition_MagnetHeaven)

function wakaba:PickupUpdate_MagnetHeaven(pickup)
	if not pickup then return end
	if pickup:IsShopItem() then return end
	local ismagnet = false
	local coinlimit = 99
	local pooplimit = 9
	local attplayer = nil
	local velocityMode = nil
	local isLast = false
	local allow = false

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
		if wakaba:IsGoldenItem(wakaba.Enums.Collectibles.POWER_BOMB, player) then
			pickup.OptionsPickupIndex = 0
		end
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
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_MagnetHeaven)


function wakaba.PickupInit_Magnet(pickup)
	if pickup.SubType == wakaba.Enums.Trinkets.MAGNET_HEAVEN and wakaba.state.unlock.magnetheaven <= 0 then
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.G:GetItemPool():GetTrinket())
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PickupInit_Magnet, PickupVariant.PICKUP_TRINKET)

function wakaba:NewRoom_MagnetHeaven()
	local room = wakaba.G:GetRoom()
	if maxMult >= 2 and not room:IsClear() then
		local duration = (maxMult - 1) * wakaba.Enums.Constants.MAGNET_HEAVEN_TIMER
		for _, entity in ipairs(Isaac.GetRoomEntities()) do
			local npc = entity:ToNPC()
			if npc and npc:IsEnemy() and npc.Type ~= EntityType.ENTITY_FIREPLACE then
				entity.Color = Color(0.6, 0.6, 0.6, 1)
				entity:AddEntityFlags(EntityFlag.FLAG_MAGNETIZED)
				local eff = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PULLING_EFFECT, 0, entity.Position, Vector.Zero, entity):ToEffect()
				eff.Parent = entity
				eff.Timeout = duration
				eff.LifeSpan = duration
				wakaba:scheduleForUpdate(function()
					if entity and entity:Exists() then
						entity.Color = Color(1, 1, 1, 1)
						entity:ClearEntityFlags(EntityFlag.FLAG_MAGNETIZED)
					end
					if eff and eff:Exists() then
						eff:Remove()
					end
				end, duration)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_MagnetHeaven)


---@param satan EntityNPC
local function Test_NPC3333(_, n)
	print(n:GetSprite().Color.R, n:GetSprite().Color.G, n:GetSprite().Color.B, n:GetSprite().Color.A, n:GetSprite().Color.RO, n:GetSprite().Color.GO, n:GetSprite().Color.BO)
end
--wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, Test_NPC3333)