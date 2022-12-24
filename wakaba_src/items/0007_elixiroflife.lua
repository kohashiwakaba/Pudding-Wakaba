wakaba.elixirmaxcooldown = 16
wakaba.elixirmaxcooldowndamage = 50


function wakaba:hasElixir(player)
	if not player then 
		return false 
	end
	if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B and not (player:IsDead() and not player:WillPlayerRevive()) then
    return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.ELIXIR_OF_LIFE) then
		return true
	else
		return false
	end
end


function wakaba:PlayerUpdate_Elixir(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if wakaba:hasElixir(player) then
		if player:GetMaxHearts() < 2 and not data.wakaba.elixirtempcheck then
			player:AddMaxHearts(2)
			data.wakaba.elixirtempcheck = true
		end
		if player:GetMaxHearts() < 2 and (data.wakaba.elixirtempcheck or data.wakaba.elixirnonredhearts) then -- Do this again to check non-red hearts character
			data.wakaba.elixirnonredhearts = true
			data.wakaba.elixirmaxsoulhearts = data.wakaba.elixirmaxsoulhearts or 0
			data.wakaba.elixirmaxsoulhearts = data.wakaba.elixirmaxsoulhearts >= player:GetSoulHearts() and data.wakaba.elixirmaxsoulhearts or player:GetSoulHearts()
		end
		if (player:GetEffectiveMaxHearts() >= 2 and player:GetSoulHearts() > 0) and not data.wakaba.elixirnonredhearts then
			player:AddSoulHearts(-2)
			player:AddBoneHearts(1)
		end
		player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
		if player:GetSprite():GetAnimation() ~= "Death" and player:GetSprite():GetAnimation() ~= "LostDeath" then
			if data.wakaba.elixirinvframes and data.wakaba.elixirinvframes >= 0 then
				--player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
				data.wakaba.elixirinvframes = data.wakaba.elixirinvframes - 1
			else
				--player:ClearEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
				if wakaba.G.Difficulty == Difficulty.DIFFICULTY_NORMAL or wakaba.G.Difficulty == Difficulty.DIFFICULTY_GREED then
					if player.FrameCount % 2 == 0 then
						player:ResetDamageCooldown()
					else
						player:SetMinDamageCooldown(1)
					end
				else
					player:ResetDamageCooldown()
				end
			end
		end
		data.wakaba.elixircooldown = data.wakaba.elixircooldown or wakaba.elixirmaxcooldown
		if not player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS) then
			if data.wakaba.elixircooldown > 0 then
				data.wakaba.elixircooldown = data.wakaba.elixircooldown - 1
			elseif data.wakaba.elixircooldown == -1 then
				-- do nothing
			elseif wakaba:IsLost(player) then
				local thresholdmantlecount = wakaba.state.options.stackableholycard <= 5 and wakaba.state.options.stackableholycard or 5
				if player:AreControlsEnabled() and not player:IsDead() and player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) < thresholdmantlecount then
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
					player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD | UseFlag.USE_NOHUD)
					data.wakaba.elixircooldown = wakaba.elixirmaxcooldown
				end
			elseif (player:GetEffectiveMaxHearts() < 2 and not player:CanPickRedHearts() and player:GetSoulHearts() < 6) or (data.wakaba.elixirmaxsoulhearts and player:GetSoulHearts() < data.wakaba.elixirmaxsoulhearts) then
				SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
				player:AddSoulHearts(1)
				data.wakaba.elixircooldown = wakaba.elixirmaxcooldown
			elseif player:CanPickRedHearts() then
				SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
				player:AddHearts(1)
				data.wakaba.elixircooldown = wakaba.elixirmaxcooldown
			elseif (player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B) and player:GetHearts() < player:GetMaxHearts() then
				SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
				player:AddHearts(1)
				data.wakaba.elixircooldown = wakaba.elixirmaxcooldown
			end
		end
	else
		if data.wakaba.elixirinvframes and data.wakaba.elixirinvframes >= 0 then
			--player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
			data.wakaba.elixirinvframes = data.wakaba.elixirinvframes - 1
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Elixir)

function wakaba:TakeDamage_Elixir(entity, amount, flags, source, cooldown)
	if not entity:ToPlayer() then return end
	local player = entity:ToPlayer()
	if wakaba:hasElixir(player) and player:GetSprite():GetAnimation() ~= "Death" and player:GetSprite():GetAnimation() ~= "LostDeath" then
		wakaba:GetPlayerEntityData(player)
    local data = player:GetData()
		data.wakaba.elixircooldown = wakaba.elixirmaxcooldowndamage
		if (source.Type == EntityType.ENTITY_SLOT and source.Variant == 2)
		or (source.Type == EntityType.ENTITY_SLOT and source.Variant == 5)
		or (source.Type == EntityType.ENTITY_SLOT and source.Variant == 15)
		or (source.Type == EntityType.ENTITY_SLOT and source.Variant == 17)
		or flags & DamageFlag.DAMAGE_IV_BAG == DamageFlag.DAMAGE_IV_BAG
		then
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.ELIXIR_OF_LIFE)
			local chance = rng:RandomInt(1000000)
			if chance <= 350000 then
				player:AddMaxHearts(-2)
			end
		end
	end
end
