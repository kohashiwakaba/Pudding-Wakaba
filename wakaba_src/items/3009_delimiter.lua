function wakaba:NewRoom_Delimiter()
	if wakaba.G:GetRoom():IsFirstVisit() then
		local room = wakaba.G:GetRoom()
		local delimitermultiplier = 0
		local priorRNG
		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if player:HasTrinket(wakaba.Enums.Trinkets.DELIMITER) then
				delimitermultiplier = delimitermultiplier + player:GetTrinketMultiplier(wakaba.Enums.Trinkets.DELIMITER)
				if not priorRNG then
					priorRNG = player:GetTrinketRNG(wakaba.Enums.Trinkets.DELIMITER)
				end
			end
		end
		if delimitermultiplier > 0 then
			for i = 0, room:GetGridSize() do
				local rock = room:GetGridEntity(i)
				if rock and rock:GetType() == GridEntityType.GRID_ROCK then
					if delimitermultiplier > 1 and priorRNG then
						local chance = priorRNG:RandomFloat() * 10000
						if (45 + (15 * delimitermultiplier)) <= chance then
							rock:SetType(GridEntityType.GRID_ROCKT)
						end
					end
				end
				if rock then 
					if (rock:GetType() == GridEntityType.GRID_ROCKT 
					--or rock:GetType() == GridEntityType.GRID_ROCK_SS
					or rock:GetType() == GridEntityType.GRID_ROCK_GOLD
					) then
						rock:Destroy()
					elseif rock:GetType() == GridEntityType.GRID_PILLAR
					or rock:GetType() == GridEntityType.GRID_ROCKB then
						rock:SetType(GridEntityType.GRID_ROCK)
						rock:GetSprite():SetFrame("normal", priorRNG:RandomInt(3))
						rock:GetSprite():Update()
					elseif rock:GetType() == GridEntityType.GRID_ROCK_SPIKED then
						rock:SetType(GridEntityType.GRID_ROCK)
						rock:GetSprite():SetAnimation("spiked_retracted", false)
						rock:GetSprite():Update()
					end
				end 
			end
		end
	end
end

wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_ROOM, CallbackPriority.IMPORTANT, wakaba.NewRoom_Delimiter)
