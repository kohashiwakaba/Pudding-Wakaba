wakaba.COLLECTIBLE_CONCENTRATION = Isaac.GetItemIdByName("Concentration")
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
	if player:GetPlayerType() == wakaba.PLAYER_TSUKASA then
    return true
	elseif player:HasCollectible(wakaba.COLLECTIBLE_CONCENTRATION) then
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


function wakaba:PlayerUpdate_Concentration(player)
	if wakaba:hasConcentration(player) then
		if not wakaba.sprites.ConcentrationSprite then
			wakaba.sprites.ConcentrationSprite = Sprite()
			wakaba.sprites.ConcentrationSprite:Load("gfx/chargebar_concentration.anm2", true)
			wakaba.sprites.ConcentrationSprite.Color = Color(1,1,1,1)
		end
		if not wakaba.sprites.ConcentrationDangerSprite then
			wakaba.sprites.ConcentrationDangerSprite = Sprite()
			wakaba.sprites.ConcentrationDangerSprite:Load("gfx/chargebar_concentration_heart.anm2", true)
			wakaba.sprites.ConcentrationDangerSprite.Color = Color(1,0.2,0.2,1)
		end
		if not wakaba.sprites.ConcentrationLunarSprite then
			wakaba.sprites.ConcentrationLunarSprite = Sprite()
			wakaba.sprites.ConcentrationLunarSprite:Load("gfx/chargebar_concentration_lunar.anm2", true)
			wakaba.sprites.ConcentrationLunarSprite.Color = Color(0.4,0.2,1,1)
		end

		wakaba:GetPlayerEntityData(player)
    local data = player:GetData()
		local chargeno = wakaba:GetChargeBarIndex(player, "Concentration")
		local chargestate = wakaba:GetChargeState(player, "Concentration")
		if IsConcentrationButtonHeld(player) and not data.wakaba.concentrationtriggered then
			if not data.wakaba.concentrationframes or data.wakaba.concentrationframes < 0 then
				local mode = wakaba.concentrationmodes.NORMAL
				if wakaba:hasLunarStone(player) and data.wakaba.lunargauge <= 100000 then
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
			local speedreduce = data.wakaba.concentrationcount or 0
			if speedreduce > 0 then
				speedreduce = speedreduce > 10 and 10 or speedreduce
			end
			data.wakaba.concentrationframes = (not data.wakaba.concentrationtriggered and data.wakaba.concentrationframes and data.wakaba.concentrationframes > 0 and data.wakaba.concentrationframes) or 6000
			data.wakaba.concentrationframes = data.wakaba.concentrationframes - (wakaba.concentrationspeed[data.wakaba.concentrationmode] - (speedreduce * 2))

			if data.wakaba.concentrationframes <= 5000 then
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
				for i = 0, 2 do
					local item = Isaac.GetItemConfig():GetCollectible(player:GetActiveItem(i))
					if player:GetActiveItem(i) > 0 and item then
						local charge = item.MaxCharges
						local chargeType = item.chargeType
						if item.ChargeType == ItemConfig.CHARGE_TIMED or item.ChargeType == ItemConfig.CHARGE_SPECIAL then
							charge = 1
						end
						chargecnt = chargecnt + charge
						if player:GetPlayerType() == wakaba.PLAYER_SHIORI or player:GetPlayerType() == wakaba.PLAYER_SHIORI_B then
							player:AddKeys(charge)
						end
					end
				end
				local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 1, Vector(player.Position.X, player.Position.Y - 65), Vector.Zero, nil):ToEffect()
				notif.DepthOffset = player.DepthOffset + 5
				SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE, 2, 0, false, 1)

				if data.wakaba.concentrationmode == wakaba.concentrationmodes.LOW_LUNAR then
					data.wakaba.lunargauge = 200000 + player:GetHearts() * 10000
					data.wakaba.lunarregenrate = 0
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
				data.wakaba.concentrationcount = (data.wakaba.concentrationcount and data.wakaba.concentrationcount + chargecnt) or chargecnt
				player:AddCacheFlags(CacheFlag.CACHE_RANGE)
				player:EvaluateItems()
				data.wakaba.concentrationframes = 0
				data.wakaba.concentrationtriggered = true
			end

			if chargestate then
				chargestate.CurrentValue = player:GetData().wakaba.concentrationframes
				chargestate.Count = data.wakaba.concentrationcount or 0
			else
				chargestate = {
					Index = chargeno,
					Profile = "Concentration",
					IncludeFinishAnim = true,
					Sprite = wakaba.sprites.ConcentrationSprite,
					MaxValue = 6000,
					MinValue = 0,
					CurrentValue = data.wakaba.concentrationframes or 6000,
					Count = data.wakaba.concentrationcount or 0,
					CountPrefix = "-",
					Reverse = false,
				}
				if data.wakaba.concentrationmode == wakaba.concentrationmodes.LOW_HEALTH then
					chargestate.Sprite = wakaba.sprites.ConcentrationDangerSprite
				elseif data.wakaba.concentrationmode == wakaba.concentrationmodes.LOW_LUNAR then
					chargestate.Sprite = wakaba.sprites.ConcentrationLunarSprite
				end
			end
			wakaba:SetChargeBarData(player, chargeno, chargestate)
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
			if (chargestate and IsConcentrationButtonHeld(player) and data.wakaba.concentrationtriggered)
			or (chargestate and data.wakaba.concentrationframes and data.wakaba.concentrationframes > 0) then
				data.wakaba.concentrationframes = nil
				chargestate.CurrentValue = player:GetData().wakaba.concentrationframes
				wakaba:SetChargeBarData(player, chargeno, chargestate)
			end
			if chargestate and data.wakaba.chargestate[chargeno].checkremove then
				wakaba:RemoveChargeBarData(player, wakaba:GetChargeBarIndex(player, "Concentration"))
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Concentration)

function wakaba.RoomClear_Concentration()
	for i = 0, Game():GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
    local data = player:GetData()
		wakaba:GetPlayerEntityData(player)
		if data.wakaba.concentrationcount and data.wakaba.concentrationcount > 0 then
			data.wakaba.concentrationcount = data.wakaba.concentrationcount - 1
			player:AddCacheFlags(CacheFlag.CACHE_RANGE)
			player:EvaluateItems()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_Concentration)

function wakaba:TakeDamage_Concentration(entity, amount, flags, source, cooldown)
	local player = entity:ToPlayer()
	if flags and flags & DamageFlag.DAMAGE_CLONES ~= DamageFlag.DAMAGE_CLONES and wakaba:hasConcentration(player) then
    local data = player:GetData()
		if data.wakaba.concentrationframes and data.wakaba.concentrationframes <= 5000 then
			flags = flags | DamageFlag.DAMAGE_CLONES
      player:TakeDamage(amount, flags, source, cooldown)
			data.wakaba.concentrationtriggered = true
		end
	end
end

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


function wakaba:PickupCollision_Concentration(pickup, collider, low)
  if collider:ToPlayer() then
    local player = collider:ToPlayer()
		if wakaba:hasConcentration(player) then
			return false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PickupCollision_Concentration, PickupVariant.PICKUP_LIL_BATTERY)


function wakaba:Cache_Concentration(player, cacheFlag)
	if player:GetData().wakaba and player:GetData().wakaba.concentrationcount then
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (36 * 1.5) + (4 * player:GetData().wakaba.concentrationcount)
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_Concentration)
