local playerType = 30


--[[ function wakaba:inputcheckDreams(entity, hook, action)

end ]]

--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.inputcheckDreams, InputHook.IS_ACTION_TRIGGERED)

function wakaba:PlayerUpdate_EdenNote(player)
	wakaba:GetPlayerEntityData(player)
	if player:GetData().wakaba.edencharge and player:GetData().wakaba.prevcharge then
		player:SetActiveCharge(player:GetData().wakaba.prevcharge, ActiveSlot.SLOT_POCKET)
		player:GetData().wakaba.prevcharge = nil
		player:GetData().wakaba.edencharge = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_EdenNote)

function wakaba:ItemUse_EdenNote(_, rng, player, useFlags, activeSlot, varData)
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_RAND then return end
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.prevcharge = player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) + player:GetBatteryCharge(ActiveSlot.SLOT_PRIMARY)
	player:RemoveCollectible(wakaba.Enums.Collectibles.EDEN_STICKY_NOTE)
	player:AddCollectible(player:GetActiveItem(ActiveSlot.SLOT_PRIMARY), prevcharge, false, ActiveSlot.SLOT_POCKET, 0)
	player:RemoveCollectible(player:GetActiveItem(ActiveSlot.SLOT_PRIMARY), true, ActiveSlot.SLOT_PRIMARY, true)
	player:AddCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.EDEN_STICKY_NOTE, "UseItem", "PlayerPickup")
	end
	SFXManager():Play(SoundEffect.SOUND_MIRROR_ENTER)
	SFXManager():Play(SoundEffect.SOUND_MIRROR_EXIT)
	player:GetData().wakaba.edencharge = true
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_EdenNote, wakaba.Enums.Collectibles.EDEN_STICKY_NOTE)
