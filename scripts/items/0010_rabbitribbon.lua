

function wakaba:hasRibbon(player)
	if not player then 
		return false 
	end
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER then
    return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.RABBIT_RIBBON) then
		return true
	elseif player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.RABBIT_RIBBON) then
		return true
	else
		return false
	end
end

-- Darkness : Brimstone, Range +8, Shotspeed +1
-- Labyrinth : Speed min 1.7
-- Lost : Mercurius, Speed min 1.7
-- Unknown : 
-- Cursed : Holy Mantle Shield
-- Maze : 








