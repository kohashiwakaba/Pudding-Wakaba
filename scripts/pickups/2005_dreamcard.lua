wakaba.dreamcardused = false
local DreamCardChance = wakaba.state.silverchance
local rng = wakaba.RNG

function wakaba:onUseCard2005(_, player, flags)
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, Isaac.GetFreeNearPosition(Vector(player.Position.X + 30, player.Position.Y - 30), 0), Vector(0,0), nil)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2005, wakaba.Enums.Cards.CARD_DREAM_CARD)

function wakaba:onGetCard2005(rng, currentCard, playing, runes, onlyRunes)
	local hasDreams = false
	for num = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(num - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS) then
			hasDreams = true
		end
	end
	if not onlyRunes and currentCard == wakaba.Enums.Cards.CARD_DREAM_CARD then
		if not hasDreams and wakaba.state.unlock.donationcard < 1 then
			return Card.CARD_JOKER
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_CARD, wakaba.onGetCard2005)

