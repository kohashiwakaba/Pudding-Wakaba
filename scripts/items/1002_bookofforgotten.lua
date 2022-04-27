wakaba.COLLECTIBLE_BOOK_OF_FORGOTTEN = Isaac.GetItemIdByName("Book of Forgotten")

function wakaba.ItemUse_BookOfForgotten()
  for i = 1, Game():GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		local hasBless = wakaba:HasBless(pl)
		SFXManager():Play(SoundEffect.SOUND_BONE_HEART, 1, 0, false, 1)
		if wakaba:HasJudasBr(pl) then
			pl:AddBlackHearts(6)
		else
			pl:AddBoneHearts(3)
		end
		pl:AddHearts(114) -- Theorically 57 is max heart containers
  end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfForgotten, wakaba.COLLECTIBLE_BOOK_OF_FORGOTTEN)



