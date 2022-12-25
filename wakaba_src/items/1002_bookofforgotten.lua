function wakaba:ItemUse_BookOfForgotten(_, rng, player, useFlags, activeSlot, varData)
  for i = 1, wakaba.G:GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		local hasBless = wakaba:HasBless(pl)
		SFXManager():Play(SoundEffect.SOUND_BONE_HEART, 1, 0, false, 1)
		if wakaba:HasJudasBr(pl) then
			pl:AddBlackHearts(2)
		else
			pl:AddBoneHearts(1)
		end
		if pl:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
			pl:AddHearts(6) -- Theorically 57 is max heart containers
		else
			pl:AddHearts(114) -- Theorically 57 is max heart containers
		end
  end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfForgotten, wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN)



