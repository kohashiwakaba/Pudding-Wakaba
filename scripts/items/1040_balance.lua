function wakaba:ItemUse_Balance(_, rng, player, useFlags, activeSlot, varData)
	if player:GetNumCoins() < 5 then
		if player:GetNumBombs() > player:GetNumKeys() then
			player:AddBombs(-1)
			player:AddKeys(1)
		elseif player:GetNumBombs() < player:GetNumKeys() then
			player:AddBombs(1)
			player:AddKeys(-1)
		else
			player:AddGoldenBomb()
			player:AddGoldenKey()
		end
	else
		player:AddCoins(-5)
		player:AddBombs(1)
		player:AddKeys(1)
	end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.BALANCE, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Balance, wakaba.Enums.Collectibles.BALANCE)
