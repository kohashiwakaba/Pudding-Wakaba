wakaba.COLLECTIBLE_QUESTION_BLOCK = Isaac.GetItemIdByName("Question Block")

function wakaba:ItemUse_QuestionBlock(_, rng, player, useFlags, activeSlot, varData)
	pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
  local discharge = true

  local chance = rng:RandomInt(1000000)
  if pData.wakaba.qblockcnt or chance <= 250000 then
    player:AddCoins(1)
    SFXManager():Play(SoundEffect.SOUND_PENNYPICKUP, 1, 0, false, 1)
    if not pData.wakaba.qblockcnt then
      pData.wakaba.qblockcnt = 10
    else
      pData.wakaba.qblockcnt = pData.wakaba.qblockcnt - 1
      if pData.wakaba.qblockcnt == 0 then
        pData.wakaba.qblockcnt = nil
      else
        discharge = false
      end
    end
  elseif chance <= 500000 then
    local newMachinePos = Game():GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM) then
      local pool = ItemPoolType.POOL_NULL
      if wakaba:HasJudasBr(player) then
        pool = ItemPoolType.POOL_DEVIL
      end
      Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Game():GetItemPool():GetCollectible(pool, true), newMachinePos, Vector(0,0), nil)
    else
      Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM, newMachinePos, Vector(0,0), nil)
    end
    SFXManager():Play(SoundEffect.SOUND_1UP, 1, 0, false, 1)
  else
    player:AddCoins(1)
    SFXManager():Play(SoundEffect.SOUND_PENNYPICKUP, 1, 0, false, 1)
  end

	if discharge and player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) and not wakaba:HasWisp(player, wakaba.COLLECTIBLE_QUESTION_BLOCK) then
		player:AddWisp(wakaba.COLLECTIBLE_QUESTION_BLOCK, player.Position, true, false)
	end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.COLLECTIBLE_QUESTION_BLOCK, "UseItem", "PlayerPickup")
	end
  return {Discharge = discharge}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_QuestionBlock, wakaba.COLLECTIBLE_QUESTION_BLOCK)

function wakaba:TakeDmg_QuestionBlock(entity, amount, flag, source, countdownFrames)
	if not (flag & DamageFlag.DAMAGE_NO_PENALTIES == DamageFlag.DAMAGE_NO_PENALTIES or flag & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS)
	then
		local player = entity:ToPlayer()
		--Double check just in case
    if not player:HasCollectible(wakaba.COLLECTIBLE_QUESTION_BLOCK) then return end
		if (flag & DamageFlag.DAMAGE_NO_PENALTIES == DamageFlag.DAMAGE_NO_PENALTIES or flag & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS) then return end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM) then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
    elseif not player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) then
      player:UseCard(Card.CARD_SOUL_LOST, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER)
      return false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_QuestionBlock, EntityType.ENTITY_PLAYER)




function wakaba:AfterRevival_QuestionBlock(player)
	local wisp = wakaba:HasWisp(player, wakaba.COLLECTIBLE_QUESTION_BLOCK)
	if wisp then
		wisp:Kill()
	end
end