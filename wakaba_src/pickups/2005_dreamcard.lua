wakaba.dreamcardused = false
local DreamCardChance = wakaba.state.silverchance
local rng = wakaba.RNG

function wakaba:onUseCard2005(_, player, flags)
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, Isaac.GetFreeNearPosition(Vector(player.Position.X + 30, player.Position.Y - 30), 0), Vector(0,0), nil)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2005, wakaba.Enums.Cards.CARD_DREAM_CARD)

