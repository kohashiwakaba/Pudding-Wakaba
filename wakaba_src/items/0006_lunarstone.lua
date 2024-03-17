local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:hasLunarStone(player, includeDead)
	if not player then
		return false
	end
	includeDead = includeDead or false
	if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA and (includeDead or not (player:IsDead() and not player:WillPlayerRevive())) then
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.LUNAR_STONE) then
		return true
	else
		return false
	end
end

-- MC_POST_PEFFECT_UPDATE doesn't run while in death. changing into MC_POST_PLAYER_UPDATE and do frame count check instead
---@param player EntityPlayer
function wakaba:ChargeBarUpdate_LunarStone(player)
	if not wakaba:getRoundChargeBar(player, "LunarGauge") then
		local sprite = Sprite()
		sprite:Load("gfx/chargebar_lunarstone.anm2", true)

		wakaba:registerRoundChargeBar(player, "LunarGauge", {
			Sprite = sprite,
		})
	end
	local chargeBar = wakaba:getRoundChargeBar(player, "LunarGauge")
	if player.FrameCount % 2 == 0 then
		if wakaba:hasLunarStone(player, false) then
			local percent = player:GetData().wakaba.lunargauge and ((player:GetData().wakaba.lunargauge // 1000) / 10) or 100
			chargeBar:UpdateSpritePercent(percent // 1)
			chargeBar:UpdateText(percent, "", "%")
		else
			chargeBar:UpdateSpritePercent(-1)
			chargeBar:UpdateText("")
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.ChargeBarUpdate_LunarStone)

function wakaba:getMaxLunarGauge(player)
	local max = 1000000
	if wakaba:hasLunarStone(player) then
		if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			max = max + 1000000
		end
	end
	return max
end

function wakaba:getCurrentLunarGauge(player)
	local data = player:GetData()
	if player.FrameCount > 7 then
		return player:GetData().wakaba.lunargauge
	end
	return 1000000
end

function wakaba:setCurrentLunarGauge(player, amount)
	if player.FrameCount > 7 then
		player:GetData().wakaba.lunargauge = amount
	end
end

function wakaba:addCurrentLunarGauge(player, amount)
	if player.FrameCount > 7 then
		player:GetData().wakaba.lunargauge = (player:GetData().wakaba.lunargauge or 1000000) + amount
	end
end

function wakaba:getLunarGaugeSpeed(player)
	local data = player:GetData()
	if player.FrameCount > 7 then
		return player:GetData().wakaba.lunarregenrate
	end
	return 0
end

function wakaba:setLunarGaugeSpeed(player, amount)
	if player.FrameCount > 7 then
		player:GetData().wakaba.lunarregenrate = amount
	end
end

local function getLunaPower(player)
	if player then
		return player:GetEffects():GetNullEffectNum(NullItemID.ID_LUNA)
	end
end

function wakaba:PlayerUpdate_LunarStone(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if data.wakaba.extralives and data.wakaba.extralives > player:GetExtraLives() then
		wakaba:AfterRevival_LunarStone(player)
	end

	if wakaba:hasLunarStone(player) and not data.wakaba.nolunarrefill then
		data.wakaba.lunargauge = data.wakaba.lunargauge or 1000000
		data.wakaba.lunarregenrate = data.wakaba.lunarregenrate or 0
		data.wakaba.lunargastimeout = data.wakaba.lunargastimeout or 0
		if player:AreControlsEnabled() then
			if wakaba:getLunarGaugeSpeed(player) >= 0 then
				data.wakaba.lunargastimeout = 0
				wakaba:setCurrentLunarGauge(player, wakaba:getCurrentLunarGauge(player) + wakaba:getLunarGaugeSpeed(player))
			elseif wakaba:getLunarGaugeSpeed(player) < 0 then
				if player:GetPlayerType() ~= PlayerType.PLAYER_KEEPER
				and player:GetPlayerType() ~= PlayerType.PLAYER_KEEPER_B
				and (wakaba:getLunarGaugeSpeed(player) < (player:GetHearts() * -1))
				and player:CanPickSoulHearts()
				then
					wakaba:setCurrentLunarGauge(player, wakaba:getCurrentLunarGauge(player) + math.min(wakaba:getLunarGaugeSpeed(player) + (player:GetTrinketMultiplier(TrinketType.TRINKET_FRAGMENTED_CARD) * 8) + player:GetEffects():GetNullEffectNum(NullItemID.ID_SOL) * 10000 + player:GetHearts(), 0))
				end
				data.wakaba.lunargastimeout = data.wakaba.lunargastimeout + 1
				if data.wakaba.lunargastimeout >= 15 then
					data.wakaba.lunargastimeout = 0
					local e = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SMOKE_CLOUD, 0, player.Position, Vector.Zero, player):ToEffect()
					e:GetData().wakaba = e:GetData().wakaba or {}
					e:GetData().wakaba.lunarstone = true
					e:SetTimeout(40)
					--local color = Color(1, 1, 1, 0.3, 1, 1, 1)
					--color:SetColorize(0.8, 0, 1, 0.2)
					--e:SetColor(color, 30, 0, true, true)
				end
			end
		end
		if wakaba:getCurrentLunarGauge(player) > wakaba:getMaxLunarGauge(player) then
			wakaba:setCurrentLunarGauge(player, wakaba:getMaxLunarGauge(player))
		end

		if data.wakaba.lunargauge then
			if data.wakaba.lunargauge > 0 then
				data.wakaba.lastlunacount = data.wakaba.lastlunacount or 0
				if player:HasCollectible(CollectibleType.COLLECTIBLE_LUNA) then
					if data.wakaba.lastlunacount ~= getLunaPower(player) then
						if data.wakaba.lastlunacount < getLunaPower(player) then
							data.wakaba.lunargauge = data.wakaba.lunargauge + 100000
							wakaba:setLunarGaugeSpeed(player, wakaba:getLunarGaugeSpeed(player) + 8)
						end
						data.wakaba.lastlunacount = getLunaPower(player)
					end
				end
			else
				if player:HasCollectible(wakaba.Enums.Collectibles.LUNAR_STONE) then
					player:RemoveCollectible(wakaba.Enums.Collectibles.LUNAR_STONE)
					wakaba.G:GetRoom():MamaMegaExplosion(player.Position)
					SFXManager():Play(SoundEffect.SOUND_MIRROR_BREAK)
					if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
						data.wakaba.lunargauge = data.wakaba.lunargauge + 500000
					else
						data.wakaba.lunargauge = nil
						data.wakaba.lunarregenrate = nil
					end
				elseif not player:HasCollectible(wakaba.Enums.Collectibles.LUNAR_STONE) and player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
					data.wakaba.nolunarrefill = true
					local revivaldata = wakaba:CanRevive(player)
					if --[[ not player:WillPlayerRevive() and ]] revivaldata and revivaldata.ID == wakaba.Enums.Collectibles.LUNAR_STONE then
						--print("Lunar remains")
						--data.wakaba.lunargauge = -50000
						if not player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
							player:GetEffects():AddNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
						end
						wakaba:PlayDeathAnimationWithRevival(player, revivaldata.ID)
						wakaba:AddPostRevive(player, revivaldata.PostRevival)
					elseif player:HasCollectible(CollectibleType.COLLECTIBLE_1UP) then
						data.wakaba.extralives = player:GetExtraLives()
						data.wakaba.tsukasa1up = 1000000
					elseif player:HasCollectible(CollectibleType.COLLECTIBLE_DEAD_CAT) then
						data.wakaba.extralives = player:GetExtraLives()
						data.wakaba.tsukasa1up = 300000
					elseif player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_CHILD) then
						data.wakaba.extralives = player:GetExtraLives()
						data.wakaba.tsukasa1up = 200000
					elseif not player:WillPlayerRevive() and revivaldata then
						--print("Wakaba Revival remains")
						if not player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
							player:GetEffects():AddNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
						end
						wakaba:PlayDeathAnimationWithRevival(player, revivaldata.ID)
						wakaba:AddPostRevive(player, revivaldata.PostRevival)
					else
						--player:Die()
						data.wakaba.lunargauge = nil
						data.wakaba.lunarregenrate = nil
					end
					wakaba.G:GetRoom():MamaMegaExplosion(player.Position)
					SFXManager():Play(SoundEffect.SOUND_MIRROR_BREAK)
					player:Die()
				end
				data.wakaba.lunargauge = nil
				data.wakaba.lunarregenrate = nil
			end
		end
	else
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
		data.wakaba.lunargauge = nil
		data.wakaba.lunarregenrate = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_LunarStone)

function wakaba:EffectUpdate_LunarStone(effect)
	if effect:GetData().wakaba and effect:GetData().wakaba.lunarstone then
		local alpha = (effect.FrameCount < 15 and effect.FrameCount) or 15
		local alpha2 = alpha * (effect.Timeout < 10 and (effect.Timeout / 10) or 1) / 120
		--print(alpha, alpha2)
		local color = Color(1, 1, 1, alpha2, 0.95, 0.75, 1)
		color:SetColorize(0.2, 0, 1, 1)
		effect:SetColor(color, 1, 0, false, true)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_LunarStone, EffectVariant.SMOKE_CLOUD)

function wakaba:AlterPlayerDamage_LunarStone(player, amount, flags, source, cooldown)
	if wakaba:hasLunarStone(player) then
		local data = player:GetData()
		if flags & DamageFlag.DAMAGE_RED_HEARTS ~= DamageFlag.DAMAGE_RED_HEARTS
		and flags & DamageFlag.DAMAGE_NO_PENALTIES ~= DamageFlag.DAMAGE_NO_PENALTIES then
			data.wakaba.reducelunargauge = true
		else
			if wakaba:WillDamageBeFatal(player, amount, flags) then
				data.wakaba.reducelunargauge = true
				data.wakaba.nolunarreduction = true
			end
		end
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, -40000, wakaba.AlterPlayerDamage_LunarStone)

function wakaba:PostTakeDamage_LunarStone(player, amount, flags, source, cooldown)
	local data = player:GetData()
	if wakaba:hasLunarStone(player)	and data.wakaba.reducelunargauge then
		wakaba:addCurrentLunarGauge(player, -40000)
		--print("Lunar Reduced!")

		if wakaba:getCurrentLunarGauge(player) < 0 then
			--print("Lunar zero, killing...")
			local stones = player:GetCollectibleNum(wakaba.Enums.Collectibles.LUNAR_STONE)

			if stones == 0 and player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
				local revivaldata = wakaba:CanRevive(player)
				local hasLaz = false
				for i = 0, 3 do
					if player:GetCard(i) == Card.CARD_SOUL_LAZARUS then
						hasLaz = true
						break
					end
				end
				player:Die()
				if not hasLaz and not revivaldata and player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
					player:GetEffects():RemoveNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
				end
			end
		else
			if not player:GetEffects():HasNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE) then
				player:GetEffects():AddNullEffect(NullItemID.ID_LAZARUS_SOUL_REVIVE)
			end
		end
		if not data.wakaba.nolunarreduction then
			if wakaba:getLunarGaugeSpeed(player) >= 0 then
				wakaba:setLunarGaugeSpeed(player, -25)
			else
				wakaba:setLunarGaugeSpeed(player, wakaba:getLunarGaugeSpeed(player) -5)
			end
		end
		SFXManager():Play(SoundEffect.SOUND_GLASS_BREAK, 2, 0, false, 1)
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
		data.wakaba.nolunarreduction = false
		data.wakaba.reducelunargauge = false
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_LunarStone)

function wakaba:Cache_LunarStone(player, cacheFlag)
	if wakaba:hasLunarStone(player) then
		local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.LUNAR_STONE)
		if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
			count = count + 1
		end
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
		if data.wakaba.lunargauge and data.wakaba.lunarregenrate then
			if data.wakaba.lunarregenrate >= 0 then
				local bonus = (data.wakaba.lunargauge / 2500000) + 1
				if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
					player.Damage = player.Damage + player.Damage * (bonus) * (count ^ 2)
				end
				if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
					if player.MaxFireDelay >= 0 then
						player.MaxFireDelay = player.MaxFireDelay / bonus
					else
						player.MaxFireDelay = player.MaxFireDelay * (bonus * 0.25)
					end
				end
			else
				if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
					player.Damage = player.Damage + player.Damage * 0.85
				end
				if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
					if player.MaxFireDelay >= 0 then
						player.MaxFireDelay = player.MaxFireDelay * 1.1
					else
						player.MaxFireDelay = player.MaxFireDelay * 0.8
					end
				end
			end
		end

		--[[ if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
			player.TearColor = newTearColor
		end ]]
	end

end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_LunarStone)


function wakaba:RoomClear_LunarStone(rng, pos)
	local roomType = wakaba.G:GetRoom():GetType()
	wakaba:ForAllPlayers(function (player)---@param player EntityPlayer
		if wakaba:hasLunarStone(player) then
			wakaba:GetPlayerEntityData(player)
			local data = player:GetData()
			if data.wakaba.lunargauge and data.wakaba.lunargauge < wakaba:getMaxLunarGauge(player) then
				if roomType == RoomType.ROOM_BOSS or roomType == RoomType.ROOM_BOSSRUSH then
					data.wakaba.lunargauge = wakaba:getMaxLunarGauge(player)
					wakaba:setLunarGaugeSpeed(player, 0)
				else
					data.wakaba.lunargauge = data.wakaba.lunargauge + 30000
					wakaba:setLunarGaugeSpeed(player, wakaba:getLunarGaugeSpeed(player) + 4)
				end
			end
		end
	end)
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_LunarStone)

function wakaba:NewLevel_LunarStone()
	local lunarStoneNum = wakaba:GetGlobalCollectibleNum(wakaba.Enums.Collectibles.LUNAR_STONE) + wakaba:GetGlobalPlayerTypeNum(wakaba.Enums.Players.TSUKASA)
	if lunarStoneNum > 0 then
		local room = wakaba.G:GetRoom()
		for i = 1, lunarStoneNum do
			local spawnPos = room:GetCenterPos()
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEAVEN_LIGHT_DOOR, 1, spawnPos, Vector.Zero, nil)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_LunarStone)

function wakaba:AfterRevival_LunarStone(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if data.wakaba.nolunarrefill then
		data.wakaba.nolunarrefill = nil
	end
	if data.wakaba.tsukasa1up then
		data.wakaba.lunargauge = data.wakaba.tsukasa1up
		data.wakaba.tsukasa1up = nil
		data.wakaba.nolunarrefill = nil
	end
end
