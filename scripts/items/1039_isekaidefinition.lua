wakaba.COLLECTIBLE_ISEKAI_DEFINITION = Isaac.GetItemIdByName("Isekai Definition")

function wakaba:FamiliarUpdate(familiar)
	local isholding1 = familiar.Player and familiar.Player:HasCollectible(wakaba.COLLECTIBLE_ISEKAI_DEFINITION)
	local isholding2 = familiar.Parent and familiar.Parent:ToPlayer() and familiar.Parent:HasCollectible(wakaba.COLLECTIBLE_ISEKAI_DEFINITION)

	if isholding1 or isholding2 then
		if familiar.HitPoints <= 60 then
			familiar.HitPoints = familiar.HitPoints + (0.25 / 15)
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate, FamiliarVariant.BLOOD_BABY)

function wakaba:ItemUse_Isekai(_, rng, player, useFlags, activeSlot, varData)
	local chance = rng:RandomFloat() * 10000
	if 50 >= chance and not wakaba:HasBeast() then
		local pentagram = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HERETIC_PENTAGRAM, 0, player.Position, Vector.Zero, player):ToEffect()
		pentagram.Parent = player
		pentagram:FollowParent(player)
		pentagram:GetSprite().PlaybackSpeed = 2.2
    local color = Color(1, 1, 1, 1, 1, 0, 1)
    color:SetColorize(0.7, 0, 1, 1)
    local sprite = pentagram:GetSprite()
    pentagram.Color = color
		pentagram:SetColor(Color(0.5, 0, 1, 1, 1, 0, 1), 200, 2, true, false)
		player:UseActiveItem(CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE)
	else
		if wakaba:HasJudasBr(player) then
			local clot = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY, 2, player.Position, Vector.Zero, player):ToFamiliar()
		else
			local clot = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY, 1, player.Position, Vector.Zero, player):ToFamiliar()
		end
		SFXManager():Play(SoundEffect.SOUND_DOGMA_BRIMSTONE_SHOOT, 0.4, 0, false, 1.65)

		local clots = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY, -1)
		for i, p in ipairs(clots) do
			p.HitPoints = p.HitPoints + 5
			local pentagram = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HERETIC_PENTAGRAM, 0, p.Position, Vector.Zero, player):ToEffect()
			pentagram.Parent = p
			pentagram:FollowParent(p)
			pentagram:GetSprite().Scale = Vector(0.2, 0.25)
			pentagram:GetSprite().PlaybackSpeed = 2.2
		end

		if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
			player:AnimateCollectible(wakaba.COLLECTIBLE_ISEKAI_DEFINITION, "UseItem", "PlayerPickup")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Isekai, wakaba.COLLECTIBLE_ISEKAI_DEFINITION)
