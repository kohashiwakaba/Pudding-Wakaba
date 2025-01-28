local isc = _wakaba.isc
function wakaba:NewRoom_DimensionCutter()
	if not wakaba.G:GetRoom():IsClear() then
		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if player:HasTrinket(wakaba.Enums.Trinkets.DIMENSION_CUTTER) then
				for i = 1, player:GetTrinketMultiplier(wakaba.Enums.Trinkets.DIMENSION_CUTTER) do
					local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.DIMENSION_CUTTER)
					local maxrate = wakaba.G:IsGreedMode() and wakaba.Enums.Constants.DIMENSION_CUTTER_GREED_MAX_RATE or wakaba.Enums.Constants.DIMENSION_CUTTER_RATE
					local luckrate = wakaba.G:IsGreedMode() and wakaba.Enums.Constants.DIMENSION_CUTTER_GREED_LUCK_RATE or 0
					local minrate = wakaba.G:IsGreedMode() and wakaba.Enums.Constants.DIMENSION_CUTTER_GREED_MIN_RATE or wakaba.Enums.Constants.DIMENSION_CUTTER_RATE

					local fl = rng:RandomFloat() * 100
					if wakaba:Roll(rng, player.Luck, minrate, luckrate, maxrate) then
						player:UseActiveItem(CollectibleType.COLLECTIBLE_DELIRIOUS, UseFlag.USE_NOANIM | UseFlag.USE_NOCOSTUME | UseFlag.USE_VOID, -1)
					end
				end
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_DimensionCutter)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.NewRoom_DimensionCutter)

function wakaba:TearCollision_DimensionCutter(tear, entity, low)
	if entity.Type == EntityType.ENTITY_DELIRIUM
	or entity.Type == EntityType.ENTITY_BEAST and entity.Variant == 0 then
		local spawner = tear.SpawnerEntity
		if spawner and spawner:ToPlayer() and spawner:ToPlayer():HasTrinket(wakaba.Enums.Trinkets.DIMENSION_CUTTER) then
			local dmg = spawner:ToPlayer().Damage * 10
			if dmg <= 339 then
				dmg = 339
			end

			entity:TakeDamage(dmg, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(tear), 0)
			return true
		end
	end
end


wakaba:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, wakaba.TearCollision_DimensionCutter, TearVariant.CHAOS_CARD)
