wakaba.KNIFE_FLASH_SHIFT = 4101
wakaba.SUBTYPE_FLASH_SHIFT = 4101
local flashcooldown = 8
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:hasFlashShift(player)
	if not player then
		return false
	end
	if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
    return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.FLASH_SHIFT) then
		return true
	else
		return false
	end
end

function wakaba:getFlashShiftTimer(player)
	local timer = 0
	if player:GetData().wakaba and player:GetData().wakaba.fstimer then
		timer =  player:GetData().wakaba.fstimer
	end
	return timer
end

function wakaba:getMaxFlashShiftTimer(player)
	local maxval = (120 * player.MaxFireDelay / 7) // 1
	if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
		maxval = (120 * player.MaxFireDelay / 15) // 1
	end
	return maxval
end

function wakaba:getFlashShiftCounter(player)
	return player:GetData().wakaba and player:GetData().wakaba.fscounter or 0
end

---@param player EntityPlayer
function wakaba:ChargeBarUpdate_FlashShift(player)
	if not wakaba:getRoundChargeBar(player, "FlashShift") then
		local sprite = Sprite()
		sprite:Load("gfx/chargebar_flashshift.anm2", true)

		wakaba:registerRoundChargeBar(player, "FlashShift", {
			Sprite = sprite,
		}):UpdateSpritePercent(-1)
	end
	local chargeBar = wakaba:getRoundChargeBar(player, "FlashShift")
	if wakaba:getFlashShiftTimer(player) > 0 then
		local current = wakaba:getFlashShiftTimer(player)
		local maxval = wakaba:getMaxFlashShiftTimer(player)
		chargeBar:UpdateSprite(current, 0, maxval)
		chargeBar:UpdateText(wakaba:getFlashShiftCounter(player), "x", "")
	else
		chargeBar:UpdateSpritePercent(-1)
		chargeBar:UpdateText("")
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.ChargeBarUpdate_FlashShift)

function wakaba:PlayerUpdate_FlashShift(player)
	pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
	if wakaba:hasFlashShift(player) then
		local maxval = wakaba:getMaxFlashShiftTimer(player)

		if not pData.wakaba.fscounter then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_NEPTUNUS) then
				pData.wakaba.fscounter = 5
			else
				pData.wakaba.fscounter = 3
			end
		end
		if pData.wakaba.fseffecttimer and pData.wakaba.fseffecttimer <= 0 then
			local trails = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.SPRITE_TRAIL, -1)
			for i, trail in ipairs(trails) do
				if trail:GetData().wakaba and trail:GetData().wakaba.flashshift then
					if trail.Parent and GetPtrHash(trail.Parent) == GetPtrHash(player) then
						trail.Parent = nil
					end
				end
			end
		elseif pData.wakaba.fseffecttimer then
			player:SetColor(Color(1,1,1,0,0,0,0), 3, 1, true, true)
			pData.wakaba.fseffecttimer = pData.wakaba.fseffecttimer - 1

		end
		if pData.wakaba.fsfrictiontimer and pData.wakaba.fsfrictiontimer <= 0 then
			if pData.wakaba.fsfriction <= 1.0 then
				player.Friction = 1.0
			else
				player.Friction = pData.wakaba.fsfriction
			end
			pData.wakaba.fsfriction = nil
			pData.wakaba.fsfrictiontimer = nil
		elseif pData.wakaba.fsfrictiontimer then
			pData.wakaba.fsfrictiontimer = pData.wakaba.fsfrictiontimer - 1
		end
		--print(pData.wakaba.fstimer and pData.wakaba.fstimer, (120 * player.MaxFireDelay / 15) // 1)
		if pData.wakaba.fstimer and pData.wakaba.fstimer >= maxval then
			pData.wakaba.fstimer = nil
			if player:HasCollectible(CollectibleType.COLLECTIBLE_NEPTUNUS) then
				pData.wakaba.fscounter = 5
			else
				pData.wakaba.fscounter = 3
			end
			SFXManager():Play(wakaba.Enums.SoundEffects.AEION_CHARGE)
			local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 1, Vector(player.Position.X, player.Position.Y - 65), Vector.Zero, nil):ToEffect()
		elseif pData.wakaba.fstimer then
			pData.wakaba.fstimer = pData.wakaba.fstimer + 1
		end
	else
		pData.wakaba.fstimer = nil
		pData.wakaba.fscounter = nil
		if pData.wakaba.fsfrictiontimer then
			pData.wakaba.fsfrictiontimer = pData.wakaba.fsfrictiontimer - 1
			if pData.wakaba.fsfrictiontimer <= 0 then
				pData.wakaba.fsfriction = nil
				pData.wakaba.fsfrictiontimer = nil
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_FlashShift)

local function canUseFlashShift(player, data)
	if data.wakaba.fscounter and data.wakaba.fscounter > 0 then
		return true, true, data.wakaba.fscounter
	elseif player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
	elseif not wakaba:getOptionValue("flashshifthearts") then
	elseif player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
		local totalHearts = player:GetHearts() + player:GetSoulCharge()
		if totalHearts > 1 then
			return true, false, player:GetSoulCharge()
		end
	elseif player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
		local totalHearts = player:GetSoulHearts() + player:GetBloodCharge()
		if totalHearts > 1 then
			return true, false, player:GetBloodCharge()
		end
	else
		local totalHearts = player:GetHearts() + player:GetSoulHearts() - player:GetRottenHearts()
		if totalHearts > 1 then
			return true, false, player:GetSoulHearts()
		end
	end
	return false, false, -1
end

function wakaba:ItemUse_FlashShift(item, rng, player, useFlags, activeSlot, varData)
	if useFlags & UseFlag.USE_CARBATTERY > 0 then return end
	local pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
	local canUse, isCounterRemain, counter = canUseFlashShift(player, pData)
	if player:GetMovementDirection() ~= Direction.NO_DIRECTION and canUse then
		if not isCounterRemain then
			if counter > 0 then
				if player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
					player:AddSoulCharge(-1)
				elseif player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
					player:AddBloodCharge(-1)
				else
					player:AddSoulHearts(-1)
				end
			else
				if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
					player:AddSoulHearts(-1)
				else
					player:AddHearts(-1)
				end
			end
		end
		--player:UseActiveItem(CollectibleType.COLLECTIBLE_MARS, UseFlag.USE_NOANIM | UseFlag.USE_NOCOSTUME, -1)
		local isGolden = wakaba:IsGoldenItem(item)

		local trail = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SPRITE_TRAIL, 0, player.Position, Vector.Zero, nil):ToEffect()
		trail:GetData().wakaba = {}
		trail:GetData().wakaba.flashshift = true
		trail:FollowParent(player) -- parents the trail to another entity and makes it follow it around
		if isGolden then
			trail:GetSprite().Color = Color(1, 0.8, 0.6, 0.5) -- sets the color of the trail
		else
			trail:GetSprite().Color = Color(0.9, 0.8, 1, 0.5) -- sets the color of the trail
		end
		trail.MinRadius = 0.05 -- fade rate, lower values yield a longer trail
		trail:SetTimeout(20)
		trail:Update()

		local oldpos = player.Position + Vector.Zero
		local direction = player:GetMovementDirection()
		if pData.wakaba.flashshifttrigger and pData.wakaba.flashshifttrigger & wakaba.dashflags.FLASH_SHIFT_TSUKASA_B == wakaba.dashflags.FLASH_SHIFT_TSUKASA_B and player:GetFireDirection() ~= Direction.NO_DIRECTION then
			direction = player:GetFireDirection()
		end
		local dirVec = wakaba.DIRECTION_VECTOR[direction]
		player.Velocity = dirVec:Resized(player.MoveSpeed + 1)
		--player.Position = newpos
		--trail.Position = newpos
		if not pData.wakaba.fsfriction then
			--player.Friction = (8.0 + ((player.TearRange / 40) - 5.0)) * player.ShotSpeed * player.MoveSpeed
			--player.Friction = 8.0
			player.Friction = (8.0 + (((player.TearRange / 40) - 5.0) / 8)) * (1 + ((1 - player.ShotSpeed) / 32)) * (1 + ((1 - player.MoveSpeed) / 16))
		end
		pData.wakaba.fsfriction = 1.0
		pData.wakaba.fsfrictiontimer = 3
		pData.wakaba.fseffecttimer = 15
		if isGolden then
			wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_MIDAS_TOUCH, 15, 1, "WAKABA_GOLDEN_FLASH_SHIFT")
		end

		local ents = Isaac.FindInRadius(player.Position, (player.TearRange / 6.5), EntityPartition.BULLET | EntityPartition.TEAR | EntityPartition.ENEMY | EntityPartition.PICKUP)
		for i, ent in ipairs(ents) do
			--ent:TakeDamage(player.Damage * 3, 0, EntityRef(player), 0)
		end
		if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B or player:HasCollectible(wakaba.Enums.Collectibles.MURASAME) then
			SFXManager():Play(SoundEffect.SOUND_KNIFE_PULL)
			local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, wakaba.Enums.Familiars.MURASAME, -1)
			for i, e in ipairs(familiars) do
				local familiar = e:ToFamiliar()
				if familiar and GetPtrHash(familiar.Player) == GetPtrHash(player) then
					if isc:inMirrorRoom() then
						local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, wakaba.Enums.Effects.MURASAME_SHIFT, 0, player.Position, Vector.Zero, player):ToEffect()
						effect:GetSprite():Play("Swing", true)
						effect:FollowParent(player)
						effect.LifeSpan = 11
						effect.SpriteRotation = dirVec:GetAngleDegrees() - 90
					elseif player:HasWeaponType(WeaponType.WEAPON_SPIRIT_SWORD) then
						wakaba:FireClub(player, player:GetFireDirection(), wakaba.ClubOptions.FlashMurasameSpirit, familiar, 8)
					elseif player:HasWeaponType(WeaponType.WEAPON_KNIFE) then
						wakaba:FireClub(player, player:GetFireDirection(), wakaba.ClubOptions.FlashMurasameKnife, familiar, 6)
					else
						wakaba:FireClub(player, player:GetFireDirection(), wakaba.ClubOptions.FlashMurasame, familiar, 4)
					end

					local fData = familiar:GetData()
					familiar:GetData().wakaba = familiar:GetData().wakaba or {}
					fData.wakaba.dashcountdown = 15
					fData.wakaba.dashvector = dirVec
					fData.wakaba.dashdirection = direction
					if fData.wakaba.murasametear and fData.wakaba.murasametear:Exists() then
						fData.wakaba.murasametear:Remove()
					end
					if fData.wakaba.murasameknife and fData.wakaba.murasameknife:Exists() then
						fData.wakaba.murasameknife:Remove()
					end
					if fData.wakaba.murasamelaser and fData.wakaba.murasamelaser:Exists() then
						fData.wakaba.murasamelaser:Remove()
					end
					if fData.wakaba.murasamexlaser and fData.wakaba.murasamexlaser:Exists() then
						fData.wakaba.murasamexlaser:Remove()
					end
					if fData.wakaba.murasamebrlaser and fData.wakaba.murasamebrlaser:Exists() then
						fData.wakaba.murasamebrlaser:Remove()
					end
					fData.wakaba.murasametear = nil
					fData.wakaba.murasameknife = nil
					fData.wakaba.murasamelaser = nil
					fData.wakaba.murasamexlaser = nil
					fData.wakaba.murasamebrlaser = nil
				end
			end
		end
		if pData.wakaba.fscounter > 0 then
			pData.wakaba.fscounter = pData.wakaba.fscounter - 1
		end
		SFXManager():Play(SoundEffect.SOUND_HELL_PORTAL1)
		player:SetMinDamageCooldown(20)
		wakaba:SetCollectibleEffectNum(player, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, false, 20)
		pData.wakaba.flashshifttrigger = nil
		if not pData.wakaba.fstimer then
			pData.wakaba.fstimer = 0
		end
	end
	--[[ if not pData.wakaba.fstimer then
		pData.wakaba.fstimer = 0
	end ]]
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_FlashShift, wakaba.Enums.Collectibles.FLASH_SHIFT)


function wakaba:Input_FlashShift(entity, hook, action)
	if not entity then return end
	if not entity:GetData().wakaba then return end
	local data = entity:GetData()
	if data.wakaba.fsfriction then
    if hook == InputHook.GET_ACTION_VALUE then
      if action == ButtonAction.ACTION_LEFT
			or action == ButtonAction.ACTION_RIGHT
			or action == ButtonAction.ACTION_UP
			or action == ButtonAction.ACTION_DOWN
			then
      	return 0
      end
    end
	end
end
wakaba:AddCallback(ModCallbacks.MC_INPUT_ACTION, wakaba.Input_FlashShift)


function wakaba:TakeDmg_FlashShift_Wisp(wisp, amount, flag, source, countdown)
	if wisp.Variant == FamiliarVariant.ITEM_WISP
	or wisp.Variant == FamiliarVariant.WISP then
		local player = wisp:ToFamiliar().Player
		local pData = player:GetData()
		if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.ELIXIR_OF_LIFE) then
			return false
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_FlashShift_Wisp, EntityType.ENTITY_FAMILIAR)
