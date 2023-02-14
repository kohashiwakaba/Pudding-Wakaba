local isc = require("wakaba_src.libs.isaacscript-common")
local collectible = wakaba.Enums.Collectibles.WATER_FLAME

local flames = {}

function wakaba:hasWaterFlame(player)
	if not player then 
		return false 
	end
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
    return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.WATER_FLAME) then
		return true
	else
		return false
	end
end

function wakaba:ItemUse_WaterFlame(_, rng, player, useFlags, activeSlot, varData)
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B and activeSlot == ActiveSlot.SLOT_POCKET then

	else
		
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_WaterFlame, wakaba.Enums.Collectibles.WATER_FLAME)