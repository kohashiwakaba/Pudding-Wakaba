function wakaba:ItemUse_GrimreaperDefender(_, rng, player, useFlags, activeSlot, varData)

	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.grimreaper = true
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


function wakaba:NewRoom_GrimreaperDefender()
  for i = 0, Game():GetNumPlayers()-1 do
    local player = Isaac.GetPlayer(i)
		if player:GetData().wakaba then 
			player:GetData().wakaba.grimreaper = false
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_GrimreaperDefender)



function wakaba:AfterRevival_GrimreaperDefender(player)
	local wisp = wakaba:HasWisp(player, wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)
	if wisp then
		wisp:Kill()
	end
end