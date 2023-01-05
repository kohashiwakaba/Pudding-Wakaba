function wakaba:ItemUse_GrimreaperDefender(_, rng, player, useFlags, activeSlot, varData)
	wakaba:GetPlayerEntityData(player)
	player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER)
	player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
	SFXManager():Play(SoundEffect.SOUND_DEATH_CARD)
	SFXManager():Play(SoundEffect.SOUND_STATIC)
	local skull = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DEATH_SKULL, 0, Vector(player.Position.X, player.Position.Y - 50), Vector.Zero, player)
	skull:GetData().wakaba = {}

	if player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) and not wakaba:HasWisp(player, wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER) then
		player:AddWisp(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER, player.Position, true, false)
	end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_GrimreaperDefender, wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)

function wakaba:AfterRevival_GrimreaperDefender(player)
	local wisp = wakaba:HasWisp(player, wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)
	if wisp then
		wisp:Kill()
	end
end