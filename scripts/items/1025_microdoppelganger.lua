function wakaba:ItemUse_MicroDoppelganger(_, rng, player, useFlags, activeSlot, varData)
	player:AddMinisaac(player.Position)
	if wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_DOPP then
		player:AddMinisaac(player.Position)
		player:AddMinisaac(player.Position)
		player:AddMinisaac(player.Position)
		player:AddMinisaac(player.Position)
		player:AddMinisaac(player.Position)
		player:AddMinisaac(player.Position)
		player:AddMinisaac(player.Position)
		player:AddMinisaac(player.Position)
		player:AddMinisaac(player.Position)
	end
	if not (player:GetPlayerType() == Isaac.GetPlayerTypeByName("Shiori", false) or player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true)) then
		player:AddMinisaac(player.Position)
		player:AddMinisaac(player.Position)
	end
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.MICRO_DOPPELGANGER, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_MicroDoppelganger, wakaba.Enums.Collectibles.MICRO_DOPPELGANGER)
