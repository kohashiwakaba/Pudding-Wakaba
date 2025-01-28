local isc = _wakaba.isc
wakaba.concentrationmodes = {
	NORMAL = 1,
	LOW_HEALTH = 2,
	LOW_LUNAR = 3,
}
wakaba.concentrationspeed = {
	[wakaba.concentrationmodes.NORMAL] = 50,
	[wakaba.concentrationmodes.LOW_HEALTH] = 30,
	[wakaba.concentrationmodes.LOW_LUNAR] = 40,
}


function wakaba:hasConcentration(player)
	if not player then
		return false
	end
	if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
    return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.CONCENTRATION) then
		return true
	else
		return false
	end
end
local function IsConcentrationButtonHeld(player)
	if not player then
		return
	end
	if Input.IsActionPressed(wakaba.state.options.concentrationcontroller, player.ControllerIndex) then return true end
	if Input.IsButtonPressed(wakaba.state.options.concentrationkeyboard, player.ControllerIndex) then return true end
end


---@param player EntityPlayer
function wakaba:ChargeBarUpdate_Concentration(player)
	if not wakaba:getRoundChargeBar(player, "Concentration") then
		local sprite = Sprite()
		sprite:Load("gfx/chargebar_concentration.anm2", true)

		wakaba:registerRoundChargeBar(player, "Concentration", {
			Sprite = sprite,
		}):UpdateSpritePercent(-1)
	end
	local chargeBar = wakaba:getRoundChargeBar(player, "Concentration")
	if wakaba:hasConcentration(player) and IsConcentrationButtonHeld(player) and not player:GetData().wakaba.concentrationtriggered then
		local current = player:GetData().wakaba.concentrationframes or 0
		local maxval = 6000
		chargeBar:UpdateSprite(current, 0, maxval)
		chargeBar:UpdateText(wakaba:getPlayerDataEntry(player, "concentrationcount", 0), "-", "")
	else
		chargeBar:UpdateSpritePercent(-1)
		chargeBar:UpdateText("")
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.ChargeBarUpdate_Concentration)

local tempUsedCount = -1
local function getConcentrationSpeed(speedType, usedCount)
	-- par : 6000, maxCount : 300
	speedType = speedType or wakaba.concentrationmodes.NORMAL
	local speedreduce = usedCount or 0
	speedreduce = math.min(speedreduce, wakaba.Enums.Constants.MAX_CONCENTRATION_SPEED_THRESHOLD)
	local initialSpeed = wakaba.concentrationspeed[speedType] or 50
	local midSpeed = initialSpeed - (speedreduce * 2)
	local finalSpeed = midSpeed
	if midSpeed < 10 then
		midSpeed = 10
		finalSpeed = midSpeed - (speedreduce * 0.03)
	end
	if wakaba:extraVal("tsukasaIntervention") then
		finalSpeed = finalSpeed * 2.4
	end
	if tempUsedCount ~= usedCount then
		wakaba.Log("Concentration speed : initial:", initialSpeed, "mid:", midSpeed, "final:", finalSpeed)
		tempUsedCount = usedCount
	end
	return finalSpeed
end

function wakaba:PlayerUpdate_Concentration(player)
	if wakaba:hasConcentration(player) then
		wakaba:initPlayerDataEntry(player, "concentrationcount", 0)
		wakaba:GetPlayerEntityData(player)
    local data = player:GetData()
		local count = wakaba:getPlayerDataEntry(player, "concentrationcount")
		if IsConcentrationButtonHeld(player) and not data.wakaba.concentrationtriggered then
			if count > wakaba.Enums.Constants.MAX_CONCENTRATION_COUNT then return end
			if wakaba:IsLunatic() or (player:GetPlayerType() == wakaba.Enums.Players.TSUKASA and not player:HasCollectible(wakaba.Enums.Collectibles.CONCENTRATION) and not wakaba:extraVal("tsukasaConcentration")) then
				if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.CONCENTRATION) or count > wakaba.Enums.Constants.MAX_CONCENTRATION_COUNT_TSUKASA then return end
			end
			if not data.wakaba.concentrationframes or data.wakaba.concentrationframes < 0 then
				local mode = wakaba.concentrationmodes.NORMAL
				if wakaba:hasLunarStone(player) and wakaba:getPlayerDataEntry(player , "lunargauge", 1000000) <= 100000 then
					mode = wakaba.concentrationmodes.LOW_LUNAR
				elseif not wakaba:hasLunarStone(player) and player:GetHearts() + player:GetSoulHearts() < 6 then
					mode = wakaba.concentrationmodes.LOW_HEALTH
				elseif player:GetHearts() < 6 and player:CanPickRedHearts() then
					mode = wakaba.concentrationmodes.LOW_HEALTH
				end
				data.wakaba.concentrationmode = mode
				SFXManager():Play(SoundEffect.SOUND_LIGHTBOLT_CHARGE, 2, 0, false, 0.5)
			else
			end
			data.wakaba.concentrationframes = (not data.wakaba.concentrationtriggered and data.wakaba.concentrationframes and data.wakaba.concentrationframes > 0 and data.wakaba.concentrationframes) or 6000
			data.wakaba.concentrationframes = data.wakaba.concentrationframes - getConcentrationSpeed(data.wakaba.concentrationmode, count)

			if data.wakaba.concentrationframes <= 5000 then
				wakaba.G.TimeCounter = wakaba.G.TimeCounter + (count // 3)
				if player:GetSprite():GetAnimation() ~= "DeathTeleport" and player:GetSprite():GetAnimation() ~= "Appear" then
					player:PlayExtraAnimation("DeathTeleport")
				elseif player:GetSprite():GetAnimation() == "Appear" then
					player:PlayExtraAnimation("Appear")
				end
				if player:GetSprite():GetAnimation() == "DeathTeleport" and (player:GetSprite():GetFrame() >= 20 or player:IsExtraAnimationFinished()) then
					player:PlayExtraAnimation("Appear")
				end
			end
			if data.wakaba.concentrationframes <= 0 then
				local chargecnt = 0
				player:FullCharge(ActiveSlot.SLOT_PRIMARY, false)
				player:FullCharge(ActiveSlot.SLOT_SECONDARY, false)
				player:FullCharge(ActiveSlot.SLOT_POCKET, false)
				player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.CONCENTRATION)
				for i = 0, 2 do
					local item = Isaac.GetItemConfig():GetCollectible(player:GetActiveItem(i))
					if player:GetActiveItem(i) > 0 and item then
						local charge = item.MaxCharges
						local chargeType = item.chargeType
						if item.ChargeType == ItemConfig.CHARGE_TIMED or item.ChargeType == ItemConfig.CHARGE_SPECIAL then
							charge = 1
						end
						chargecnt = chargecnt + charge
						if player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B then
							player:AddKeys(charge)
						end
					end
				end
				local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 1, Vector(player.Position.X, player.Position.Y - 65), Vector.Zero, nil):ToEffect()
				notif.DepthOffset = player.DepthOffset + 5
				SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE, 2, 0, false, 1)

				if data.wakaba.concentrationmode == wakaba.concentrationmodes.LOW_LUNAR then
					wakaba:setCurrentLunarGauge(player, 200000 + player:GetHearts() * 10000)
					wakaba:setPlayerDataEntry(player, "lunarregenrate", 0)
					local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 4, Vector(player.Position.X, player.Position.Y - 95), Vector.Zero, nil):ToEffect()
					notif.DepthOffset = player.DepthOffset + 5
					SFXManager():Play(SoundEffect.SOUND_HOLY, 2, 0, false, 1)
					SFXManager():Play(SoundEffect.SOUND_STATIC, 2, 0, false, 1)
					--SFXManager():Play(SoundEffect.SOUND_LIGHTBOLT_CHARGE, 2, 0, false, 1, 1)
				end

				if data.wakaba.concentrationmode == wakaba.concentrationmodes.LOW_HEALTH then
					if player:GetHearts() < 6 then
						player:AddHearts(6 - player:GetHearts())
					end
					if player:GetEffectiveMaxHearts() < 6 then
						player:AddSoulHearts(6 - player:GetEffectiveMaxHearts())
					end
					local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, Vector(player.Position.X, player.Position.Y - 95), Vector.Zero, nil):ToEffect()
					notif.DepthOffset = player.DepthOffset + 5
					SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE, 2, 0, false, 1)
				end
				if chargecnt == 0 then chargecnt = 1 end
				wakaba:addPlayerDataCounter(player, "concentrationcount", chargecnt)
				player:AddCacheFlags(CacheFlag.CACHE_RANGE)
				player:EvaluateItems()
				data.wakaba.concentrationframes = 0
				data.wakaba.concentrationtriggered = true
			end
		else
			if SFXManager():IsPlaying(SoundEffect.SOUND_LIGHTBOLT_CHARGE) then
				SFXManager():Stop(SoundEffect.SOUND_LIGHTBOLT_CHARGE)
			end
			if player:GetSprite():GetAnimation() == "DeathTeleport" then
				player:PlayExtraAnimation("Appear")
			end
			if not IsConcentrationButtonHeld(player) then
				data.wakaba.concentrationtriggered = nil
			end
			data.wakaba.concentrationmode = nil
			if (IsConcentrationButtonHeld(player) and data.wakaba.concentrationtriggered)
			or (data.wakaba.concentrationframes and data.wakaba.concentrationframes > 0) then
				data.wakaba.concentrationframes = nil
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Concentration)

function wakaba.RoomClear_Concentration()
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
    local data = player:GetData()
		wakaba:GetPlayerEntityData(player)
		if wakaba:getPlayerDataEntry(player, "concentrationcount", 0) > 0 then
			wakaba:addPlayerDataCounter(player, "concentrationcount", -1)
			player:AddCacheFlags(CacheFlag.CACHE_RANGE)
			player:EvaluateItems()
		end
		player:GetEffects():RemoveCollectibleEffect(wakaba.Enums.Collectibles.CONCENTRATION, -1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_Concentration)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.RoomClear_Concentration)

function wakaba:AlterPlayerDamage_Concentration(player, amount, flags, source, cooldown)
	if wakaba:hasConcentration(player) then
    local data = player:GetData()
		if data.wakaba.concentrationframes and data.wakaba.concentrationframes <= 5000 then
			return amount * 2
		end
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, wakaba.AlterPlayerDamage_Concentration)

function wakaba:PostTakeDamage_Concentration(player, amount, flags, source, cooldown)
	if wakaba:hasConcentration(player) then
    local data = player:GetData()
		if data.wakaba.concentrationframes and data.wakaba.concentrationframes <= 5000 then
			data.wakaba.concentrationtriggered = true
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_Concentration)

function wakaba:Input_Concentration(entity, hook, action)
	if not entity then return end
	if not entity:GetData().wakaba then return end
	local data = entity:GetData()
	if data.wakaba.concentrationframes and data.wakaba.concentrationframes <= 5000 then
    if hook == InputHook.GET_ACTION_VALUE then
      if action == ButtonAction.ACTION_LEFT
			or action == ButtonAction.ACTION_RIGHT
			or action == ButtonAction.ACTION_UP
			or action == ButtonAction.ACTION_DOWN
			or action == ButtonAction.ACTION_BOMB
			or action == ButtonAction.ACTION_ITEM
			or action == ButtonAction.ACTION_PILLCARD
			then
      	return 0
      end
    end
	end
end
wakaba:AddCallback(ModCallbacks.MC_INPUT_ACTION, wakaba.Input_Concentration)

function wakaba:Cache_Concentration(player, cacheFlag)
	if wakaba:hasPlayerDataEntry(player, "concentrationcount") then
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (36 * 1.5) + (4 * wakaba:getPlayerDataEntry(player, "concentrationcount"))
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Concentration)
