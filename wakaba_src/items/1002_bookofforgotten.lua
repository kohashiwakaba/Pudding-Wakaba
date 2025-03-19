function wakaba:ItemUse_BookOfForgotten(_, rng, player, useFlags, activeSlot, varData)
  for i = 1, wakaba.G:GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		SFXManager():Play(SoundEffect.SOUND_BONE_HEART, 1, 0, false, 1)
		if wakaba:HasJudasBr(pl) then
			pl:AddBlackHearts(2)
		else
			pl:AddBoneHearts(1)
		end
  end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfForgotten, wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN)



