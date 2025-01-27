-- make effect callback to single callback
local sfx = SFXManager()

wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)

	-- Epic Fetus
	if effect.Variant == EffectVariant.ROCKET then
		local player = effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer()
		if player then
			if not effect:Exists() then
				Isaac.RunCallback(wakaba.Callback.ANY_WEAPON_FIRE, player)
			elseif effect.FrameCount == 1 then
				Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, effect, player)
			end

			-- cross bomb, bubble bombs
			local sprite = effect:GetSprite()
			if sprite:IsFinished("Falling") then
				if player:HasCollectible(wakaba.Enums.Collectibles.CROSS_BOMB) then
					wakaba:ActivateCrossBomb(effect, player)
				end
				if player:HasCollectible(wakaba.Enums.Collectibles.BUBBLE_BOMBS) then
					wakaba:ActivateBubbleBomb(effect, player)
				end
			end
			if player:HasCollectible(wakaba.Enums.Collectibles.BUBBLE_BOMBS) then
				sprite:ReplaceSpritesheet(0, "gfx/effects/wakaba_aquamissile.png")
				effect:GetData().wakaba_ExplosionColor = wakaba.Colors.AQUA_WEAPON_COLOR
				sprite:LoadGraphics()
			end
		end
	end

	-- Epic Fetus Forgotten
	if effect.Variant == EffectVariant.SMALL_ROCKET then
		if not effect:Exists() then
			local player = effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer()
			if player then
				--Isaac.RunCallback(wakaba.Callback.ANY_WEAPON_FIRE, player)
				Isaac.RunCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, effect, player)

				-- cross bomb, bubble bombs
				local sprite = effect:GetSprite()
				if sprite:IsFinished("Falling") then
					if player:HasCollectible(wakaba.Enums.Collectibles.CROSS_BOMB) then
						wakaba:ActivateCrossBomb(effect, player)
					end
					if player:HasCollectible(wakaba.Enums.Collectibles.BUBBLE_BOMBS) then
						wakaba:ActivateBubbleBomb(effect, player)
					end
				end
				if player:HasCollectible(wakaba.Enums.Collectibles.BUBBLE_BOMBS) then
					sprite:ReplaceSpritesheet(0, "gfx/effects/wakaba_aquamissile_small.png")
					effect:GetData().wakaba_ExplosionColor = wakaba.Colors.AQUA_WEAPON_COLOR
					sprite:LoadGraphics()
				end
			end
		end
	end

	-- Minerva's Aura
	if effect.Variant == EffectVariant.HALLOWED_GROUND then
		local data = effect:GetData()
		local wdata = data.wakaba
		if not wdata then return end
		if not wdata == "minerva" then return end
		if not effect.Parent then return end
		local psti = wakaba:getstoredindex(effect.Parent:ToPlayer())
		if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
			psti = 1
		end
		effect.Timeout = 108000000
		effect.LifeSpan = 108000000
		for _, ent in ipairs(Isaac.FindInRadius(effect.Position, 88, EntityPartition.FAMILIAR)) do
			if ent.Variant ~= FamiliarVariant.ITEM_WISP
				or not (
					(wakaba.curses.CURSE_OF_FLAMES > 0 and isc:hasCurse(wakaba.curses.CURSE_OF_FLAMES))
					or
					(effect.Parent:ToPlayer() ~= nil and effect.Parent:ToPlayer():GetPlayerType() == wakaba.Enums.Players.RICHER_B )
				)
			then
				if ent.HitPoints < (ent.MaxHitPoints * 2) then
					ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 1, 1, true, false)
					ent.HitPoints = ent.HitPoints + (ent.MaxHitPoints * 0.04)
					if ent.HitPoints > (ent.MaxHitPoints * 2) then
						ent.HitPoints = (ent.MaxHitPoints * 2)
					end
				else
					ent:SetColor(Color(1, 1, 1, 1, 0.2, 0.4, 0.1), 1, 1, true, false)
				end
			end
		end
		for _, ent in ipairs(Isaac.FindInRadius(effect.Position, 88, EntityPartition.ENEMY)) do
			if ent:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
				--ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 1, 1, true, false)
				if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
					if ent.HitPoints < (ent.MaxHitPoints * 2) then
						ent.HitPoints = ent.HitPoints + (ent.MaxHitPoints * 0.04)
						if ent.HitPoints > (ent.MaxHitPoints * 2) then
							ent.HitPoints = (ent.MaxHitPoints * 2)
						end
					else
					end
				elseif effect.Parent:ToPlayer() ~= nil
				and effect.Parent:ToPlayer():GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true)
				and effect.Parent:ToPlayer():HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
				then
					if ent.HitPoints < (ent.MaxHitPoints * 3) then
						ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 1, 1, true, false)
						ent.HitPoints = ent.HitPoints + (ent.MaxHitPoints * 0.32)
						if ent.HitPoints > (ent.MaxHitPoints * 3) then
							ent.HitPoints = (ent.MaxHitPoints * 3)
						end
					else
						ent:SetColor(Color(1, 1, 1, 1, 0.2, 0.4, 0.1), 1, 1, true, false)
					end
				else
					if ent.HitPoints < (ent.MaxHitPoints * 2) then
						ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 1, 1, true, false)
						ent.HitPoints = ent.HitPoints + (ent.MaxHitPoints * 0.04)
						if ent.HitPoints > (ent.MaxHitPoints * 2) then
							ent.HitPoints = (ent.MaxHitPoints * 2)
						end
					else
						ent:SetColor(Color(1, 1, 1, 1, 0.2, 0.4, 0.1), 1, 1, true, false)
					end
				end
			end
		end

		--88 for radius
		for i, ent in ipairs(Isaac.FindInRadius(effect.Position, 2000, EntityPartition.PLAYER)) do
			local distance = math.sqrt(((effect.Position.X - ent.Position.X) ^ 2) + ((effect.Position.Y - ent.Position.Y) ^ 2))
			ent:GetData().wakaba = ent:GetData().wakaba or {}
			ent:GetData().wakaba.minervalevel = ent:GetData().wakaba.minervalevel or {}
			ent:GetData().wakaba.minervalevel[psti] = ent:GetData().wakaba.minervalevel[psti] or {}
			local sti = wakaba:getstoredindex(ent:ToPlayer())

			--print(ent:ToPlayer():GetName(), effect.Parent:ToPlayer().ControllerIndex , ent:ToPlayer().ControllerIndex, effect.Parent:ToPlayer().ControllerIndex == ent:ToPlayer().ControllerIndex)
			if (effect.Parent ~= nil and effect.Parent:ToPlayer() ~= nil) or wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
				if	wakaba.G.Challenge ~= wakaba.challenges.CHALLENGE_BIKE
				and GetPtrHash(effect.Parent:ToPlayer()) == GetPtrHash(ent:ToPlayer())
				and (effect.Parent:ToPlayer():GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true)
				and not effect.Parent:ToPlayer():HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT))
				then
					ent:GetData().wakaba.minervalevel[psti][sti] = 0
					--ent:GetData().wakaba.minervacount = 0
				elseif distance <= 88 then
					if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
						ent:GetData().wakaba.insideminerva = true
						ent:GetData().wakaba.minervacount = 5
						if (ent:ToPlayer() and not ent:ToPlayer():GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_CAMO_UNDIES)) then
							ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
						end
					else
						ent:GetData().wakaba.minervalevel[psti][sti] = wakaba:auraCount(effect.Parent:ToPlayer())
						ent:GetData().wakaba.insideminerva = true
						if effect.Parent:ToPlayer() ~= nil
						and effect.Parent:ToPlayer():GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true)
						and effect.Parent:ToPlayer():HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
						then
							ent:GetData().wakaba.minervacount = 7
							ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
							if (ent:ToPlayer() and not ent:ToPlayer():GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_CAMO_UNDIES)) then
								ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
							end
						else
							ent:GetData().wakaba.minervacount = 5
							ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
							if (ent:ToPlayer() and not ent:ToPlayer():GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_CAMO_UNDIES)) then
								ent:SetColor(Color(1, 1, 1, 1, 0.4, 0.1, 0.2), 5, 1, true, false)
							end
						end
					end
				else
					ent:GetData().wakaba.minervalevel[psti][sti] = 0
					ent:GetData().wakaba.insideminerva = false
				end
			end
		end
	end

	-- Lunar Stone Cloud
	if effect.Variant == EffectVariant.SMOKE_CLOUD then
		if effect:GetData().wakaba and effect:GetData().wakaba.lunarstone then
			local alpha = (effect.FrameCount < 15 and effect.FrameCount) or 15
			local alpha2 = alpha * (effect.Timeout < 10 and (effect.Timeout / 10) or 1) / 120
			--print(alpha, alpha2)
			local color = Color(1, 1, 1, alpha2, 0.95, 0.75, 1)
			color:SetColorize(0.2, 0, 1, 1)
			effect:SetColor(color, 1, 0, false, true)
		end
	end

	-- chimaki blue flame
	if effect.Variant == EffectVariant.BLUE_FLAME then
		local parent = effect:GetData().wakaba_chimakiBFParent --- @type EntityRef
		if parent and parent.Entity then
			if effect.FrameCount % 5 == 0 then
				local player = parent.Entity:ToPlayer()
				for _, enemy in ipairs(Isaac.FindInRadius(effect.Position, effect.Size, EntityPartition.ENEMY)) do
					if enemy:IsVulnerableEnemy() then
						enemy:TakeDamage(player.Damage * 4, not wakaba:IsLunatic() and DamageFlag.DAMAGE_IGNORE_ARMOR or 0, parent, 0)
					end
				end
			end
			for _, proj in ipairs(Isaac.FindInRadius(effect.Position, effect.Size, EntityPartition.BULLET)) do
				proj:Remove()
			end
		end
	end

	-- Caramella pancake laser detection
	if effect.Variant == EffectVariant.LASER_IMPACT then
		local laserEndpoint = effect
		if laserEndpoint.SpawnerEntity and laserEndpoint.SpawnerEntity.Type == EntityType.ENTITY_LASER then
			local laser = laserEndpoint.SpawnerEntity
			local var = laser.Variant
			local subt = laser.SubType
			local player = isc:getPlayerFromEntity(laser)
			if (var == 1 and subt == 3) or var == 5 or var == 12 then
			elseif player and player:HasWeaponType(WeaponType.WEAPON_LUDOVICO_TECHNIQUE) then
			elseif player and laser.FrameCount % 6 == 0 then
				if hasCaramellaEffect(player) then
					local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.RIRA)
					if #flies < 10 then
						wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.RIRA)
					end
				end
			end
		end
	end

	-- Caramella pancake epic fetus
	if effect.Variant == EffectVariant.TARGET then
		local player = isc:getPlayerFromEntity(effect)
		if effect.FrameCount % 10 == 0 and player and hasCaramellaEffect(player) and player:HasWeaponType(WeaponType.WEAPON_ROCKETS) then
			local flies = wakaba:GetCaramellaFlies(player, wakaba.Enums.Flies.CIEL)
			if #flies < 10 then
				wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.CIEL, player.Damage * 10, effect.Position, true)
			end
		end
	end

	-- power bomb
	if effect.Variant == wakaba.Enums.Effects.POWER_BOMB then
		effect:GetData().wakaba = effect:GetData().wakaba or {}
		local damage = effect:GetData().wakaba.damage or 5
		local isGolden = wakaba:IsGoldenItem(wakaba.Enums.Collectibles.POWER_BOMB)
		if isGolden then damage = damage * 2 end
		local state = 0
		local effectsprite = effect:GetSprite()
		if effect.FrameCount % 8 == 0 then
			Game():MakeShockwave(effect.Position, 0.008 + 0.004 * (effect.FrameCount / 4), 0.002 * (effect.FrameCount / 2), 100)
		end
		if sfx:IsPlaying(SoundEffect.SOUND_EXPLOSION_WEAK) then
			sfx:Stop(SoundEffect.SOUND_EXPLOSION_WEAK)
		end
		if effectsprite:IsFinished("Explode") then
			local room = wakaba.G:GetRoom()
			for i = 0, room:GetGridSize() do
				if room:GetGridEntity(i) then
					if room:GetGridEntity(i):GetType() == GridEntityType.GRID_DOOR then
						local door = room:GetGridEntity(i):ToDoor()
						door:TryBlowOpen(true, effect)
						if door:IsLocked() or (door.TargetRoomType == RoomType.ROOM_CHALLENGE)then
							door:TryUnlock(Isaac.GetPlayer(), true)
						end
					end
					room:GetGridEntity(i):Destroy()
				end
			end
			wakaba.G:BombExplosionEffects(Vector(-2000, -2000), 0, TearFlags.TEAR_NORMAL, Color.Default, nil, 0, true, false, DamageFlag.DAMAGE_EXPLOSION)
			if isGolden then
				room:TurnGold()
			end
			effectsprite:Play("Exploding")
			effectsprite:Update()
		elseif effectsprite:IsFinished("Exploding") then
			--sfx:Play(SoundEffect.SOUND_REVERSE_EXPLOSION)
			sfx:Stop(wakaba.Enums.SoundEffects.POWER_BOMB_LOOP)
			sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_1)
			sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_2)
			sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_3)
			sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_4)
			sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_5)
			effectsprite:Play("Fading")
			effectsprite:Update()
		elseif effectsprite:IsPlaying("Fading") then
			--local scalept = ((48 - effectsprite:GetFrame()) / 48) * 3
			--effectsprite.Scale = Vector(scalept, scalept)
			--effectsprite:Update()
		elseif effectsprite:IsFinished("Fading") then
			effect:Remove()
		end
		local enemies = Isaac.FindInRadius(effect.Position, 1600, EntityPartition.ENEMY)
		for i, entity in pairs(enemies) do
			if entity:IsEnemy() then
				--print("Enemy Taking Damage")
				entity:TakeDamage(damage * 0.4, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(effect), 0)
			end
		end
	end

	-- effect trail
	if effect.Variant == EffectVariant.SPRITE_TRAIL then
		-- nerf gun
		if trail:GetData().w_parent then
			local parent = trail:GetData().w_parent
			if parent:Exists() then
				trail.ParentOffset = getPositionOffset(parent, trail.SpriteScale.Y)
			else
				trail:Remove()
			end
		end
	end

	if effect.Variant == EffectVariant.ROCKET then
	end

end)