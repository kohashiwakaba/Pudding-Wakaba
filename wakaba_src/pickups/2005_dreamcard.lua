wakaba.dreamcardused = false
local DreamCardChance = wakaba.state.silverchance
local rng = wakaba.RNG

function wakaba:onUseCard2005(_, player, flags)
	local s = wakaba.G:GetRoom():GetSpawnSeed()
	wakaba.G:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Isaac.GetFreeNearPosition(Vector(player.Position.X + 30, player.Position.Y - 30), 0), Vector.Zero, nil, 0, s):ToPickup()
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2005, wakaba.Enums.Cards.CARD_DREAM_CARD)

