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

local recent

function wakaba:ItemUse_WaterFlame(_, rng, player, useFlags, activeSlot, varData)
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
		local playerIndex = isc:getPlayerIndex(player)
		local current = wakaba.TotalWisps[playerIndex]
		if #current.list == 0 then
			player:AnimateSad()
			return {
				Discharge = false,
				Remove = false,
				ShowAnim = false,
			}
		end
		if useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY then 

		else
			local wisp = current.list[current.index]
			recent = wisp.SubType
			wisp:Kill()
		end

		if recent then
			SFXManager():Play(SoundEffect.SOUND_POWERUP1)
			player:AddCollectible(recent)
			wakaba.G:GetHUD():ShowItemText(player, Isaac.GetItemConfig():GetCollectible(recent))
			player:AnimateCollectible(recent, "Pickup", "PlayerPickupSparkle")
		end

	else
		local collectibles = isc:getEntities(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
		local nearest = isc:getClosestEntityTo(player, collectibles, function(_, e) return isc:collectibleHasTag(e.SubType, ItemConfig.TAG_SUMMONABLE) end)
		if nearest then
			SFXManager():Play(SoundEffect.SOUND_POWERUP1)
			player:AddCollectible(pending.SubType)
			wakaba.G:GetHUD():ShowItemText(player, Isaac.GetItemConfig():GetCollectible(pending.SubType))
			player:AnimateCollectible(pending.SubType, "Pickup", "PlayerPickupSparkle")

			player:AddItemWisp(nearest.SubType, player.Position, true)
		else
			player:AnimateSad()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_WaterFlame, wakaba.Enums.Collectibles.WATER_FLAME)