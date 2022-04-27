wakaba.COLLECTIBLE_MICRO_DOPPELGANGER = Isaac.GetItemIdByName("Micro Doppelganger")

function wakaba:ItemUse_MicroDoppelganger(_, rng, player, useFlags, activeSlot, varData)
	player:AddMinisaac(player.Position)
	if Game().Challenge ~= wakaba.challenges.CHALLENGE_DOPP then
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
		player:AnimateCollectible(wakaba.COLLECTIBLE_MICRO_DOPPELGANGER, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_MicroDoppelganger, wakaba.COLLECTIBLE_MICRO_DOPPELGANGER)
