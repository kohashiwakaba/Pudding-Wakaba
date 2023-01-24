function wakaba:AfterRevival_VintageThreat(player)
	--print("AfterVThreatInit")
	local data = player:GetData()
	data.wakaba = data.wakaba or {}
	--player:RemoveCollectible(wakaba.Enums.Collectibles.VINTAGE_THREAT)
	local Poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector.Zero, player):ToEffect()
	Poof.SpriteScale = Vector(1.5, 1.5)
	player:ChangePlayerType(wakaba.Enums.Players.SHIORI_B)
	wakaba:AfterShioriInit_b(player)
	wakaba:GetShioriCostume_b(player) 
	wakaba:initAura(player)
	wakaba.G:GetRoom():MamaMegaExplosion(player.Position)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS, UseFlag.USE_NOANIM)
	player:AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
	player:AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
	player:AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
	player:AddCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)

	player:AddMaxHearts(-24)
	player:AddBoneHearts(-12)
	player:AddSoulHearts(-24)
	player:AddBlackHearts(99)
	player:AddKeys(-99)

	data.wakaba.vintagethreat = true
	data.wakaba.vintagethreatremovecnt = 1
end

function wakaba:PlayerUpdate_VintageThreat()
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		wakaba:GetPlayerEntityData(player)
		if player:GetData().wakaba.vintagethreatremovecnt and player:GetData().wakaba.vintagethreatremovecnt > 0 then
			player:RemoveCollectible(wakaba.Enums.Collectibles.VINTAGE_THREAT)
			player:GetData().wakaba.vintagethreatremovecnt = player:GetData().wakaba.vintagethreatremovecnt - 1
		end
		if player:IsDead() and (player:GetSprite():GetAnimation() == "Death" or player:GetSprite():GetAnimation() == "LostDeath") and player:GetData().wakaba.vintagethreat then
			--player:GetData().wakaba.vintagegameover = true
		end
		if player:GetData().wakaba.vintagegameover and (player:GetSprite():GetAnimation() == "Death" or player:GetSprite():GetAnimation() == "LostDeath") and player:IsExtraAnimationFinished() then
			MusicManager():Play(Music.MUSIC_JINGLE_GAME_OVER, Options.MusicVolume)
			MusicManager():Queue(Music.MUSIC_GAME_OVER)
			wakaba.G:End(1)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PlayerUpdate_VintageThreat)
--LagCheck
--[[ 
function wakaba:TakeDmg_VintageThreat(entity, amount, flag, source, countdownFrames)
	if entity.Type == EntityType.ENTITY_PLAYER
	and not (flag & DamageFlag.DAMAGE_NO_PENALTIES == DamageFlag.DAMAGE_NO_PENALTIES)
	then
		local player = entity:ToPlayer()
		if not player:GetData().wakaba or (flag & DamageFlag.DAMAGE_NO_PENALTIES == DamageFlag.DAMAGE_NO_PENALTIES) then return end
		if player:GetData().wakaba.vintagethreat then
			print(flag)
			player:GetData().wakaba.vintagekill = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_VintageThreat)
 ]]
function wakaba:FamiliarUpdate_VintageThreat(familiar)
	if not familiar.Player then return end
	local player = familiar.Player
	local data = player:GetData().wakaba

	if data and data.vintagethreat then
		if not familiar:GetData().vintagethreat then
			familiar:GetSprite():ReplaceSpritesheet(0, "gfx/familiar/vintage_damocles.png")
			familiar:GetSprite():LoadGraphics()
			familiar:GetData().vintagethreat = true
		end
		if player:GetData().wakaba.vintagekill == true then
			familiar.State = 2
			player:GetData().wakaba.vintagekill = false
			player:GetData().wakaba.vintagegameover = true
		end
	elseif player:HasCollectible(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER) and familiar.State == 2 then
		if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) ~= wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER
		and player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) ~= wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER
		and player:GetActiveItem(ActiveSlot.SLOT_POCKET2) ~= wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER
		and not (player:GetPlayerType() == wakaba.Enums.Players.SHIORI and data.books and data.books[data.bookindex] == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER) then
		else
			player:RemoveCollectible(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
			wakaba.G:ShakeScreen(10)
			local mantlebreak = Isaac.Spawn(EntityType.ENTITY_EFFECT, 16, 11, familiar.Position, Vector.Zero, familiar)
			local skull = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DEATH_SKULL, 0, Vector(player.Position.X, player.Position.Y - 50), Vector.Zero, player)
			local halo = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 9, player.Position - Vector(0, 22), Vector.Zero, player)
			SFXManager():Play(SoundEffect.SOUND_TOOTH_AND_NAIL, 1, 0, false, 1.1, 0)
			SFXManager():Play(SoundEffect.SOUND_HOLY_MANTLE)
			SFXManager():Play(SoundEffect.SOUND_DEATH_CARD)
			SFXManager():Play(SoundEffect.SOUND_STATIC)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_VintageThreat, FamiliarVariant.DAMOCLES)

function wakaba:DEBUG_FallDamocles()
	local entities = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.DAMOCLES, -1, false, false)
	for i, e in ipairs(entities) do
		local fam = e:ToFamiliar()
		if fam then
			fam.State = 2
		end
	end
end