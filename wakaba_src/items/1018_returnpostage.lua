local haspostage = 0

wakaba.PostageConquerEntities = {
	{EntityType.ENTITY_NEEDLE},
	{EntityType.ENTITY_DUST},
	{EntityType.ENTITY_POLTY},
	{EntityType.ENTITY_MOMS_HAND},
}

wakaba.PostageRemovalEntities = {
	{EntityType.ENTITY_ETERNALFLY},
}

local function isPostageEntity(entity)
	for _, dict in ipairs(wakaba.PostageConquerEntities) do
		if entity.Type == dict[1] then
			if not dict[2] or entity.Variant == dict[2] then
				if not dict[3] or entity.SubType == dict[3] then
					return true
				end
			end
		end
	end
end

local function isPostageRemoval(entity)
	for _, dict in ipairs(wakaba.PostageRemovalEntities) do
		if entity.Type == dict[1] then
			if not dict[2] or entity.Variant == dict[2] then
				if not dict[3] or entity.SubType == dict[3] then
					return true
				end
			end
		end
	end
end

function wakaba:NPCUpdate_Postage(entity)

	if wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.RETURN_POSTAGE) then
		local player
		local players = isc:getPlayersWithCollectible(wakaba.Enums.Collectibles.RETURN_POSTAGE)
		if #players > 0 then
			local rng = RNG()
			rng:SetSeed(entity.InitSeed, 35)
			player = players[rng:RandomInt(#players) + 1]
		else
			player = Isaac.GetPlayer()
		end
		if isPostageRemoval(entity) then
			entity:Remove()
		elseif isPostageEntity(entity) then
			entity:AddCharmed(EntityRef(player), -1)
		end
		
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_NPC_INIT, wakaba.NPCUpdate_Postage)
--LagCheck

function wakaba:PostageAddCharm(entity)
	if haspostage > 0 then
		entitiy:AddCharmed(EntityRef(Isaac.GetPlayer()), -1)
	end
end
