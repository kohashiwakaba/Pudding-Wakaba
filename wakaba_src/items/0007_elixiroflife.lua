local isc = require("wakaba_src.libs.isaacscript-common")


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

local function getElixirPower(player)
	local power = 0
	if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
		power = 1
	end
	return power + player:GetCollectibleNum(wakaba.Enums.Collectibles.ELIXIR_OF_LIFE)
end

function wakaba:PlayerUpdate_Elixir(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if wakaba:hasElixir(player) then
		local keeperSkipped = false
		if (player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B) or wakaba:IsLost(player) then
			keeperSkipped = true
			goto KeeperSkip
		end
		if player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN then -- Do this again to check non-red hearts character
			data.wakaba.elixirmaxsoulhearts = data.wakaba.elixirmaxsoulhearts or 0
			data.wakaba.elixirmaxsoulhearts = data.wakaba.elixirmaxsoulhearts >= player:GetSoulHearts() and data.wakaba.elixirmaxsoulhearts or player:GetSoulHearts()
		end
		::KeeperSkip::
		player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
		if player:GetSprite():GetAnimation() ~= "Death" and player:GetSprite():GetAnimation() ~= "LostDeath" then
			if data.wakaba.elixirinvframes and data.wakaba.elixirinvframes >= 0 then
				--player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
				data.wakaba.elixirinvframes = data.wakaba.elixirinvframes - 1
			elseif not keeperSkipped then
				--player:ClearEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
				local power = math.max(getElixirPower(player) + (wakaba.G.Difficulty % 2), 1)
				if player.FrameCount % power == 0 then
					player:ResetDamageCooldown()
				else
					player:SetMinDamageCooldown(1)
				end
			end
		end
		data.wakaba.elixircooldown = data.wakaba.elixircooldown or wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN
		if not player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS) then
			local isSoulCharacter = Isaac.RunCallback(wakaba.Callback.EVALUATE_ELIXIR_SOUL_RECOVER, player) ~= nil
			local availableMaxSoul
			if isSoulCharacter then
				availableMaxSoul = math.min(player:GetHeartLimit() - player:GetEffectiveMaxHearts(), (data.wakaba.elixirmaxsoulhearts or 0))
			else
				availableMaxSoul = math.min(player:GetHeartLimit() - player:GetBoneHearts(), (data.wakaba.elixirmaxsoulhearts or 0))
			end
			if data.wakaba.elixircooldown > 0 then
				data.wakaba.elixircooldown = data.wakaba.elixircooldown - 1
			elseif data.wakaba.elixircooldown == -1 then
				-- do nothing
			elseif wakaba:IsLost(player) then
				if player:AreControlsEnabled() and not player:IsDead() and player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) == 0 then
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
					player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD | UseFlag.USE_NOHUD)
					data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_KEEPER
				end
			elseif player:CanPickRedHearts() and not isSoulCharacter then
				SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
				player:AddHearts(1)
				data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN
			elseif (player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN and player:GetSoulHearts() < availableMaxSoul) then
				SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
				player:AddSoulHearts(1)
				data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN
			elseif (player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B) and player:GetHearts() < player:GetMaxHearts() then
				SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
				player:AddHearts(1)
				data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_KEEPER
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

function wakaba:PostTakeDamage_Elixir(player, amount, flags, source, cooldown)
	if wakaba:hasElixir(player) and player:GetSprite():GetAnimation() ~= "Death" and player:GetSprite():GetAnimation() ~= "LostDeath" then
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
		data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_DMG
		local donationThreshold = 3 + getElixirPower(player)
		local soulThreshold = 1 + getElixirPower(player)
		if (player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B) or wakaba:IsLost(player) then
			data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_KEEPER // math.min(math.max(getElixirPower(player), 1), 6)
		end
		if (source.Type == EntityType.ENTITY_SLOT and source.Variant == 2)
		or (source.Type == EntityType.ENTITY_SLOT and source.Variant == 5)
		or (source.Type == EntityType.ENTITY_SLOT and source.Variant == 15)
		or (source.Type == EntityType.ENTITY_SLOT and source.Variant == 17)
		or flags & DamageFlag.DAMAGE_IV_BAG == DamageFlag.DAMAGE_IV_BAG
		then
			data.wakaba.elixirblooddonationcooldown = data.wakaba.elixirblooddonationcooldown or 0
			data.wakaba.elixirblooddonationcooldown = data.wakaba.elixirblooddonationcooldown + 1
			if data.wakaba.elixirblooddonationcooldown >= donationThreshold then
				if player:GetBoneHearts() > 0 then
					player:AddBoneHearts(-1)
				elseif player:GetMaxHearts() > 0 then
					player:AddMaxHearts(-2)
				elseif data.wakaba.elixirmaxsoulhearts > 0 then
					data.wakaba.elixirmaxsoulhearts = data.wakaba.elixirmaxsoulhearts - 2
				end
				data.wakaba.elixirblooddonationcooldown = 0
			end
		elseif player:GetSoulHearts() > 0 then
			data.wakaba.elixirsouldamagecooldown = data.wakaba.elixirsouldamagecooldown or 0
			data.wakaba.elixirsouldamagecooldown = data.wakaba.elixirsouldamagecooldown + 1
			if wakaba:IsDamageSanguineSpikes(player, flags, source) or data.wakaba.elixirsouldamagecooldown >= soulThreshold then
				if data.wakaba.elixirmaxsoulhearts > 0 then
					data.wakaba.elixirmaxsoulhearts = data.wakaba.elixirmaxsoulhearts - 2
				end
				data.wakaba.elixirsouldamagecooldown = 0
			end
		end
		if flags & DamageFlag.DAMAGE_CURSED_DOOR > 0 then
			data.wakaba.elixirinvframes = 20
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_Elixir)

function wakaba:ElixirSoulRecover_Elixir(player)
	if REPENTOGON then
		if player:GetHealthType() == HealthType.SOUL then
			return true
		end
	else
		if player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B
		or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B
		or player:GetPlayerType() == wakaba.Enums.Players.RICHER_B
		or not isc:canCharacterHaveRedHearts(player:GetPlayerType())
		then
			return true
		end
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_ELIXIR_SOUL_RECOVER, wakaba.ElixirSoulRecover_Elixir)

local priceToSoulCount = {
	[PickupPrice.PRICE_ONE_HEART_AND_ONE_SOUL_HEART] = 2,
	[PickupPrice.PRICE_ONE_HEART_AND_TWO_SOULHEARTS] = 4,
	[PickupPrice.PRICE_ONE_SOUL_HEART] = 2,
	[PickupPrice.PRICE_TWO_SOUL_HEARTS] = 4,
	[PickupPrice.PRICE_THREE_SOULHEARTS] = 6,
}
function wakaba:PickupPurchase_Elixir(pickup, player, price)
	if wakaba:hasElixir(player) then
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
		local soulsToReduce = priceToSoulCount[price]
		if soulsToReduce then
			if data.wakaba.elixirmaxsoulhearts > 0 then
				data.wakaba.elixirmaxsoulhearts = data.wakaba.elixirmaxsoulhearts - soulsToReduce
			end
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_PURCHASE_PICKUP, wakaba.PickupPurchase_Elixir)