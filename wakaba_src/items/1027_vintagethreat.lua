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

function wakaba:PlayerUpdate_VintageThreat(player)
	wakaba:GetPlayerEntityData(player)
	if player:HasCollectible(wakaba.Enums.Collectibles.VINTAGE_THREAT, true) then
		if Input.IsButtonTriggered((wakaba.state.options.vintagetriggerkey or Keyboard.KEY_9), 0) then
			wakaba:AfterRevival_VintageThreat(player)
		end
	end
	if player:GetData().wakaba.vintagethreatremovecnt and player:GetData().wakaba.vintagethreatremovecnt > 0 then
		player:RemoveCollectible(wakaba.Enums.Collectibles.VINTAGE_THREAT)
		player:GetData().wakaba.vintagethreatremovecnt = player:GetData().wakaba.vintagethreatremovecnt - 1
	end
	if player:IsDead() and (player:GetSprite():GetAnimation() == "Death" or player:GetSprite():GetAnimation() == "LostDeath") and player:GetData().wakaba.vintagethreat then
		--player:GetData().wakaba.vintagegameover = true
	end
	if player:GetData().wakaba.vintagegameover then
		if player:IsDead() and not player:HasCurseMistEffect() then
			player:AddCurseMistEffect()
		end
		if player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
			player:GetEffects():RemoveNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE, -1)
		end
		if (player:GetSprite():GetAnimation() == "Death" or player:GetSprite():GetAnimation() == "LostDeath") and player:IsExtraAnimationFinished() then
			MusicManager():Play(Music.MUSIC_JINGLE_GAME_OVER, Options.MusicVolume)
			MusicManager():Queue(Music.MUSIC_GAME_OVER)
			wakaba.G:End(1)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_VintageThreat, 0)

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
		and (player:GetPlayerType() == wakaba.Enums.Players.SHIORI and data.books and data.books[data.bookindex] == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER) then
		else
			player:RemoveCollectible(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)
			for i = 1, player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE) do
				player:RemoveCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE)
			end
			wakaba.G:ShakeScreen(10)
			local mantlebreak = Isaac.Spawn(EntityType.ENTITY_EFFECT, 16, 11, familiar.Position, Vector.Zero, familiar)
			local skull = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DEATH_SKULL, 0, Vector(player.Position.X, player.Position.Y - 50), Vector.Zero, player)
			local halo = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 9, player.Position - Vector(0, 22), Vector.Zero, player)
			SFXManager():Play(SoundEffect.SOUND_TOOTH_AND_NAIL, 1, 0, false, 1.1, 0)
			SFXManager():Play(SoundEffect.SOUND_HOLY_MANTLE)
			SFXManager():Play(SoundEffect.SOUND_DEATH_CARD)
			SFXManager():Play(SoundEffect.SOUND_STATIC)
			familiar:Remove()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_VintageThreat, FamiliarVariant.DAMOCLES)


function wakaba:AlterPlayerDamage_Vintage(entity, amount, flags, source, countdown)
	local Source = source.Entity
	local player = entity:ToPlayer()
	if player then
		if player:GetData().wakaba.vintagethreat then
			local shouldNotFall = Isaac.RunCallback(wakaba.Callback.EVALUATE_VINTAGE_DAMOCLES, player, flags)
			if not shouldNotFall then
				player:GetData().wakaba.vintagekill = true
			end
		end
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, -39999, wakaba.AlterPlayerDamage_Vintage)

function wakaba:EvaluateVintage_Main(player, flags)
	if flags & DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS > 0 then
		return true
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_VINTAGE_DAMOCLES, -39999, wakaba.EvaluateVintage_Main)

function wakaba:DEBUG_FallDamocles()
	local entities = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.DAMOCLES, -1, false, false)
	for i, e in ipairs(entities) do
		local fam = e:ToFamiliar()
		if fam then
			fam.State = 2
		end
	end
end

-- quick lua commands to fall damocles immediately
--[[
l local entities = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.DAMOCLES, -1, false, false); for i, e in ipairs(entities) do local fam = e:ToFamiliar() if fam then fam.State = 2 end end end;
 ]]


if EID then
	local function VintageCondition(descObj)
		if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and descObj.ObjSubType == wakaba.Enums.Collectibles.VINTAGE_THREAT then
			return true
		end
		return false
	end
	local function VintageCallback(descObj)
		local append = EID:getDescriptionEntry("WakabaVintageHotkey") or EID:getDescriptionEntryEnglish("WakabaVintageHotkey")
		descObj.Name = "{{ColorRed}}"..descObj.Name.."{{CR}}"
		EID:appendToDescription(descObj, "!!! ".. append:gsub("{1}", InputHelper.KeyboardToString[wakaba.state.options.vintagetriggerkey]) .. "{{CR}}")
		return descObj
	end
	EID:addDescriptionModifier("Wakaba Vintage Hotkey", VintageCondition, VintageCallback)
end