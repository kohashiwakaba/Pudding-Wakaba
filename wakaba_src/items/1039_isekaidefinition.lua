local isc = _wakaba.isc

function wakaba:GetMaxIsekaiClots()
	return wakaba:IsLunatic() and wakaba.Enums.Constants.MAX_ISEKAI_CLOTS_LUNATIC or wakaba.Enums.Constants.MAX_ISEKAI_CLOTS
end


function wakaba:ItemUse_Isekai(item, rng, player, useFlags, activeSlot, varData)
	local isGolden = wakaba:IsGoldenItem(item)
	local fam = isc:getPlayerFamiliars(player)
	local count = 0
	for _,f in ipairs(fam) do
		if f.Variant == FamiliarVariant.BLOOD_BABY then
			if f.SubType == isc.BloodClotSubType.RED_NO_SUMPTORIUM then
				count = count + 1
			elseif isGolden and f.SubType == isc.BloodClotSubType.GOLD then
				count = count + 1
			end
		end
	end
	local base = wakaba.Enums.Constants.ISEKAI_CERTIFICATE_CHANCE
	base = (base + (wakaba.Enums.Constants.ISEKAI_OVER_CLOT_BONUS * (count - wakaba:GetMaxIsekaiClots() + 1)))
	if wakaba:HasShiori(player) then
		base = base + wakaba.Enums.Constants.ISEKAI_SHIORI_BONUS
	end
	if isGolden then
		base = base + wakaba.Enums.Constants.ISEKAI_SHIORI_BONUS
	end

	local chance = rng:RandomFloat() * 10000
	if not isc:inDeathCertificateArea() and base >= chance and not wakaba:HasBeast() then
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
		if count < wakaba:GetMaxIsekaiClots() then
			if isGolden then
				local clot = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY, isc.BloodClotSubType.GOLD, player.Position, Vector.Zero, player):ToFamiliar()
			else
				local clot = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY, isc.BloodClotSubType.RED_NO_SUMPTORIUM, player.Position, Vector.Zero, player):ToFamiliar()
			end
		end

		SFXManager():Play(SoundEffect.SOUND_DOGMA_BRIMSTONE_SHOOT, 0.4, 0, false, 1.65)
		local clots = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY, -1)
		for i, p in ipairs(clots) do
			if count < wakaba:GetMaxIsekaiClots() then
				p.HitPoints = p.HitPoints + 5
			elseif p.HitPoints < p.MaxHitPoints then
				p.HitPoints = p.MaxHitPoints
			end
			local pentagram = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HERETIC_PENTAGRAM, 0, p.Position, Vector.Zero, player):ToEffect()
			pentagram.Parent = p
			pentagram:FollowParent(p)
			pentagram:GetSprite().Scale = Vector(0.2, 0.25)
			pentagram:GetSprite().PlaybackSpeed = 2.2
		end

		if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
			player:AnimateCollectible(wakaba.Enums.Collectibles.ISEKAI_DEFINITION, "UseItem", "PlayerPickup")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Isekai, wakaba.Enums.Collectibles.ISEKAI_DEFINITION)
