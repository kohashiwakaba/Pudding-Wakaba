wakaba.COLLECTIBLE_ANTI_BALANCE = Isaac.GetItemIdByName("Anti Balance")

function wakaba:PlayerUpdate_AntiBalance(player)
	local hasAnti = false
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.COLLECTIBLE_ANTI_BALANCE) or player:GetEffects():HasCollectibleEffect(wakaba.COLLECTIBLE_ANTI_BALANCE) then
			hasAnti = true
		end
	end
	if not hasAnti then return end
	for i = 0, 3 do
		local pillColour = player:GetPill(i)
		local holdingHorsePill = pillColour & PillColor.PILL_GIANT_FLAG > 0
		if pillColour > 0 and not holdingHorsePill then
			player:SetPill(i, pillColour | PillColor.PILL_GIANT_FLAG)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_AntiBalance)


function wakaba:PickupInit_AntiBalance(pickup)
	local hasAnti = false
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.COLLECTIBLE_ANTI_BALANCE) or player:GetEffects():HasCollectibleEffect(wakaba.COLLECTIBLE_ANTI_BALANCE) then
			hasAnti = true
		end
	end
	if not hasAnti then return end
	local pillColour = pickup.SubType
	if pillColour & PillColor.PILL_GIANT_FLAG == 0 then
		local newPill = pickup:Morph(pickup.Type, pickup.Variant, pickup.SubType | PillColor.PILL_GIANT_FLAG, true, true, false)
		--newPill:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.PickupInit_AntiBalance, PickupVariant.PICKUP_PILL)

