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

function wakaba:PreEvalElixirType(player, elixirType)
	if (player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B) then
		return "Keeper"
	elseif wakaba:IsLost(player) then
		return "Lost"
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.PRE_EVALUATE_ELIXIR_TYPE, 20000, wakaba.PreEvalElixirType)

function wakaba:PostEvalElixirType(player, elixirType)
	if elixirType and (elixirType == "Keeper" or elixirType == "Lost") then
		return
	else
		if player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN then -- Do this again to check non-red hearts character
			wakaba:setPlayerDataEntry(player, "elixirmaxsoulhearts", math.max(wakaba:getPlayerDataEntry(player, "elixirmaxsoulhearts", 0), player:GetSoulHearts()))
		end
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.POST_EVALUATE_ELIXIR_TYPE, 20000, wakaba.PostEvalElixirType)

function wakaba:PreElixirRecover(player, elixirType, recoverType)
	local savedSoulCap = wakaba:getPlayerDataEntry(player, "elixirmaxsoulhearts", 0)
	if REPENTOGON then
		if player:GetHealthType() == HealthType.SOUL then
			return "Soul"
		end
	else
		if player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B
		or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B
		or player:GetPlayerType() == wakaba.Enums.Players.RICHER_B
		then
			return "Soul"
		elseif not isc:canCharacterHaveRedHearts(player:GetPlayerType()) then
			return "Soul"
		end
	end

	if (not elixirType or elixirType == "Red") and savedSoulCap > 0 then
		return "Soul"
	end

end
wakaba:AddPriorityCallback(wakaba.Callback.PRE_ELIXIR_RECOVER, 0, wakaba.PreElixirRecover)

function wakaba:PostElixirRecover(player, elixirType, recoverType)
	local data = player:GetData()
	local savedSoulCap = wakaba:getPlayerDataEntry(player, "elixirmaxsoulhearts", 0)

	if recoverType == "Lost" then
		if player:AreControlsEnabled() and not player:IsDead() and player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) == 0 then
			SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
			player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD | UseFlag.USE_NOHUD)
			data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_KEEPER
		end
	elseif recoverType == "Keeper" then
		if player:GetHearts() < player:GetMaxHearts() then
			SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
			player:AddHearts(1)
			data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_KEEPER
		end
	elseif elixirType == "Soul" or recoverType == "Soul" then
		local availableMaxSoul
		if elixirType and elixirType == "Soul" then
			availableMaxSoul = math.min(player:GetHeartLimit() - player:GetEffectiveMaxHearts(), savedSoulCap)
		else
			availableMaxSoul = math.min(player:GetHeartLimit() - player:GetMaxHearts() - (player:GetBoneHearts() * 2), savedSoulCap)
		end
		if (player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN and player:GetSoulHearts() < availableMaxSoul) then
			SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
			player:AddSoulHearts(1)
			data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN
		end
	elseif (not elixirType or elixirType == "Red") or (not recoverType or recoverType == "Red") then
		if player:CanPickRedHearts() then
			SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
			player:AddHearts(1)
			data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN
		end
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.POST_ELIXIR_RECOVER, 20000, wakaba.PostElixirRecover)

function wakaba:PlayerUpdate_Elixir(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if wakaba:hasElixir(player) then
		wakaba:initPlayerDataEntry(player, "elixirdonationcount", 0)
		wakaba:initPlayerDataEntry(player, "elixirsouldamagedcount", 0)
		local elixirType, recoverType
		local cooldownTime = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN

		for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.PRE_EVALUATE_ELIXIR_TYPE)) do
			local newType = callbackData.Function(callbackData.Mod, player, elixirType)
			if newType then
				elixirType = newType
			end
		end
		Isaac.RunCallback(wakaba.Callback.POST_EVALUATE_ELIXIR_TYPE, player, elixirType)
		player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
		if player:GetSprite():GetAnimation() ~= "Death" and player:GetSprite():GetAnimation() ~= "LostDeath" then
			if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.ELIXIR_OF_LIFE) then
				player:SetMinDamageCooldown(1)
			else
				player:ResetDamageCooldown()
			end
		end
		data.wakaba.elixircooldown = data.wakaba.elixircooldown or wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN
		if not player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS) then
			if data.wakaba.elixircooldown > 0 then
				data.wakaba.elixircooldown = data.wakaba.elixircooldown - 1
			elseif data.wakaba.elixircooldown == -1 then
				-- do nothing
			else
				recoverType = elixirType
				for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.PRE_ELIXIR_RECOVER)) do
					local recoverType = callbackData.Function(callbackData.Mod, player, elixirType or "", recoverType)
					if newType then
						recoverType = newType
					end
				end
				Isaac.RunCallback(wakaba.Callback.POST_ELIXIR_RECOVER, player, elixirType, recoverType)
			end
		end
	else
		wakaba:removePlayerDataEntry(player, "elixirdonationcount")
		wakaba:removePlayerDataEntry(player, "elixirsouldamagedcount")
		wakaba:removePlayerDataEntry(player, "elixirmaxsoulhearts")
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Elixir)

function wakaba:MantleBreak_Elixir(player, prevCount, nextCount)
	if wakaba:hasElixir(player) and wakaba:IsLost(player) then
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
		wakaba:IncrementCollectibleEffectNum(player, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, false , 15)
		data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_KEEPER
	end
end
wakaba:AddCallback(wakaba.Callback.POST_MANTLE_BREAK, wakaba.MantleBreak_Elixir)

function wakaba:PostTakeDamage_Elixir(player, amount, flags, source, cooldown)
	if wakaba:hasElixir(player) and player:GetSprite():GetAnimation() ~= "Death" and player:GetSprite():GetAnimation() ~= "LostDeath" then
		if wakaba:getPlayerDataEntry(player, "skipelixirdmgcheck") then
			wakaba:removePlayerDataEntry(player, "skipelixirdmgcheck")
			return
		end
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
		data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_DMG
		local donationThreshold = 3 + getElixirPower(player)
		local soulThreshold = 2 + getElixirPower(player)
		if (player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B) or wakaba:IsLost(player) then
			wakaba:IncrementCollectibleEffectNum(player, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, false , 15)
			data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_KEEPER // math.min(math.max(getElixirPower(player), 1), 6)
		end
		if (source.Type == EntityType.ENTITY_SLOT and source.Variant == 2)
		or (source.Type == EntityType.ENTITY_SLOT and source.Variant == 5)
		or (source.Type == EntityType.ENTITY_SLOT and source.Variant == 15)
		or (source.Type == EntityType.ENTITY_SLOT and source.Variant == 17)
		or flags & DamageFlag.DAMAGE_IV_BAG == DamageFlag.DAMAGE_IV_BAG
		then
			wakaba:addPlayerDataCounter(player, "elixirdonationcount", 1)
			if wakaba:getPlayerDataEntry(player, "elixirdonationcount") >= donationThreshold then
				if player:GetBoneHearts() > 0 then
					player:AddBoneHearts(-1)
				elseif player:GetMaxHearts() > 0 then
					player:AddMaxHearts(-2)
				elseif wakaba:getPlayerDataEntry(player, "elixirmaxsoulhearts", 0) > 0 then
					wakaba:addPlayerDataCounter(player, "elixirmaxsoulhearts", -2)
				end
				wakaba:setPlayerDataEntry(player, "elixirdonationcount", 0)
			end
		elseif player:GetSoulHearts() > 0 then
			wakaba:addPlayerDataCounter(player, "elixirsouldamagedcount", 1)
			if wakaba:IsDamageSanguineSpikes(player, flags, source) or wakaba:getPlayerDataEntry(player, "elixirsouldamagedcount", 0) >= soulThreshold then
				if wakaba:getPlayerDataEntry(player, "elixirmaxsoulhearts", 0) > 0 then
					wakaba:addPlayerDataCounter(player, "elixirmaxsoulhearts", -2)
				end
				wakaba:setPlayerDataEntry(player, "elixirsouldamagedcount", 0)
			end
		end
		if flags & DamageFlag.DAMAGE_CURSED_DOOR > 0 then
			wakaba:IncrementCollectibleEffectNum(player, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, false , 20)
		elseif not wakaba:IsLunatic() then
			wakaba:IncrementCollectibleEffectNum(player, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, false , 2)
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_Elixir)

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
			if wakaba:getPlayerDataEntry(player, "elixirmaxsoulhearts", 0) > 0 then
				wakaba:addPlayerDataCounter(player, "elixirmaxsoulhearts", soulsToReduce * -1)
			end
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_PURCHASE_PICKUP, wakaba.PickupPurchase_Elixir)