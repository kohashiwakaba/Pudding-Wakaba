wakaba.COLLECTIBLE_RETURN_POSTAGE = Isaac.GetItemIdByName("Return Postage")
local haspostage = 0


function wakaba:PostageUpdate()
	
	haspostage = 0
	
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.COLLECTIBLE_RETURN_POSTAGE, false) then
			haspostage = haspostage + player:GetCollectibleNum(wakaba.COLLECTIBLE_RETURN_POSTAGE)
		end
	end
	if haspostage > 0 then
		for i, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_NEEDLE, -1, -1)) do
			entity:AddCharmed(EntityRef(Isaac.GetPlayer()), -1)
		end
		for i, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_DUST, -1, -1)) do
			entity:AddCharmed(EntityRef(Isaac.GetPlayer()), -1)
		end
		for i, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_POLTY, -1, -1)) do
			entity:AddCharmed(EntityRef(Isaac.GetPlayer()), -1)
		end
		for i, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_MOMS_HAND, -1, -1)) do
			entity:AddCharmed(EntityRef(Isaac.GetPlayer()), -1)
		end
	end

end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostageUpdate)
--LagCheck

function wakaba:PostageAddCharm(entity)
	if haspostage > 0 then
		entitiy:AddCharmed(EntityRef(Isaac.GetPlayer()), -1)
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.PostageUpdate, EntityType.ENTITY_NEEDLE)
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.PostageUpdate, EntityType.ENTITY_DUST)
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.PostageUpdate, EntityType.ENTITY_POLTY)
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.PostageUpdate, EntityType.ENTITY_MOMS_HAND)
