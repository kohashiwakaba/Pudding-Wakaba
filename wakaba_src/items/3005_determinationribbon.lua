

function wakaba:AlterPlayerDamage_DeterminationRibbon(player, amount, flags, source, countdown)
	if player:HasTrinket(wakaba.Enums.Trinkets.DETERMINATION_RIBBON) and wakaba.WillDamageBeFatal(player, amount, flags) then
    local data = player:GetData()
		data.wakaba.trydropribbon = true
		return 1, flags | DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_NO_MODIFIERS
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, wakaba.AlterPlayerDamage_DeterminationRibbon)

function wakaba:PostTakeDamage_DeterminationRibbon(player, amount, flags, source, cooldown)
	if player:HasTrinket(wakaba.Enums.Trinkets.DETERMINATION_RIBBON) and player:GetTrinketMultiplier(wakaba.Enums.Trinkets.DETERMINATION_RIBBON) < 5 then
    local data = player:GetData()
		if data.wakaba.trydropribbon then
			local chance = player:GetTrinketRNG(wakaba.Enums.Trinkets.DETERMINATION_RIBBON):RandomInt(1000000)
			local threshold = 80000
			if wakaba.G.Difficulty == Difficulty.DIFFICULTY_NORMAL or wakaba.G.Difficulty == Difficulty.DIFFICULTY_GREED then
				threshold = threshold / 4
			end
			if player:GetTrinketMultiplier(wakaba.Enums.Trinkets.DETERMINATION_RIBBON) > 0 then
				threshold = threshold / player:GetTrinketMultiplier(wakaba.Enums.Trinkets.DETERMINATION_RIBBON)
			end
			--print(chance, threshold)
			if chance < threshold then
				--player:DropTrinket(player.Position, false)
				player:TryRemoveTrinket(wakaba.Enums.Trinkets.DETERMINATION_RIBBON)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.Enums.Trinkets.DETERMINATION_RIBBON, wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, nil)
				player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
			end
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_DeterminationRibbon)