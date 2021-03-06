wakaba.TRINKET_DELIMITER = Isaac.GetTrinketIdByName("Delimiter")


function wakaba:NewRoom_Delimiter()
	if Game():GetRoom():IsFirstVisit() then
		local room = Game():GetRoom()
		local delimitermultiplier = 0
		local priorRNG
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if player:HasTrinket(wakaba.TRINKET_DELIMITER) then
				delimitermultiplier = delimitermultiplier + player:GetTrinketMultiplier(wakaba.TRINKET_DELIMITER)
				if not priorRNG then
					priorRNG = player:GetTrinketRNG(wakaba.TRINKET_DELIMITER)
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
					or rock:GetType() == GridEntityType.GRID_ROCK_SS
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

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Delimiter)
