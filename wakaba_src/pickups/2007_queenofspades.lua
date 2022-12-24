local spawncowntdown = -1
local pos = nil

function wakaba:UseCard_QueenofSpades(_, player, flags)
	local random = player:GetCardRNG(wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES):RandomInt(23) + 3
	pos = player.Position
	spawncowntdown = random
	--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.SpawnKeys_QueenofSpades)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_QueenofSpades, wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES)

function wakaba:SpawnKeys_QueenofSpades()
	if spawncowntdown > 0 then
		spawncowntdown = spawncowntdown - 1
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, Isaac.GetFreeNearPosition(pos, 32), Vector.Zero, nil)
	end
	--wakaba:RemoveCallback(ModCallbacks.MC_POST_UPDATE, wakaba.SpawnKeys_QueenofSpades)
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.SpawnKeys_QueenofSpades)
--LagCheck
