wakaba.COLLECTIBLE_LUNAR_STONE = Isaac.GetItemIdByName("Lunar Stone")

function wakaba:hasLunarStone(player, includeDead)
	if not player then 
		return false 
	end
	includeDead = includeDead or false
	local sti = wakaba:getstoredindex(player)
	if player:GetPlayerType() == wakaba.PLAYER_TSUKASA and (includeDead or not (player:IsDead() and not player:WillPlayerRevive())) then
    return true
	elseif player:HasCollectible(wakaba.COLLECTIBLE_LUNAR_STONE) then
		return true
	else
		return false
	end
end


function wakaba:PlayerUpdate_LunarStone(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if data.wakaba.extralives and data.wakaba.extralives > player:GetExtraLives() then
		wakaba:AfterRevival_LunarStone(player)
	end

	if wakaba:hasLunarStone(player) and not data.wakaba.nolunarrefill then
		--player:ResetDamageCooldown()
		data.wakaba.lunargauge = data.wakaba.lunargauge or 1000000
		data.wakaba.lunarregenrate = data.wakaba.lunarregenrate or 0
		data.wakaba.lunargastimeout = data.wakaba.lunargastimeout or 0
		--[[ if wakaba:IsHeartDifferent(player) then
			wakaba:RemoveRegisteredHeart(player)
			data.wakaba.lunargauge = data.wakaba.lunargauge or 1000000
			data.wakaba.lunargauge = data.wakaba.lunargauge - 40000
			data.wakaba.lunarregenrate = data.wakaba.lunarregenrate or 0
			if data.wakaba.lunarregenrate >= 0 then
				data.wakaba.lunarregenrate = -25
			else
				data.wakaba.lunarregenrate = data.wakaba.lunarregenrate - 5
			end
			SFXManager():Play(SoundEffect.SOUND_GLASS_BREAK, 2, 0, false, 1)
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		end ]]
		if wakaba:IsHeartEmpty(player) and not wakaba:IsPlayerDying(player) then
			if player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B then
				player:AddMaxHearts(2)
				player:AddHearts(2)
			else
				player:AddSoulHearts(1)
			end
		end
		if player:AreControlsEnabled() then
			if data.wakaba.lunarregenrate >= 0 then
				data.wakaba.lunargastimeout = 0
				data.wakaba.lunargauge = data.wakaba.lunargauge + data.wakaba.lunarregenrate
			elseif data.wakaba.lunarregenrate < 0 then
				if player:GetPlayerType() ~= PlayerType.PLAYER_KEEPER 
				and player:GetPlayerType() ~= PlayerType.PLAYER_KEEPER_B
				and (data.wakaba.lunarregenrate < (player:GetHearts() * -1)) 
				and player:CanPickSoulHearts()
				then
					data.wakaba.lunargauge = data.wakaba.lunargauge + data.wakaba.lunarregenrate + player:GetHearts()
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
		if (player:GetEffectiveMaxHearts() >= 2 and player:GetSoulHearts() > 0) or player:GetSoulHearts() > 2
		then
			if data.wakaba.lunarregenrate < 0
			or ((player:GetPlayerType() == wakaba.PLAYER_TSUKASA and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)) and data.wakaba.lunargauge < 2000000) 
			or ((player:GetPlayerType() == wakaba.PLAYER_TSUKASA and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)) and data.wakaba.lunargauge < 1000000) 
			or ((player:GetPlayerType() ~= wakaba.PLAYER_TSUKASA) and data.wakaba.lunargauge < 1000000) 
			then
				data.wakaba.lunargauge = data.wakaba.lunargauge + 30000
				if data.wakaba.lunarregenrate < 0 then
					data.wakaba.lunarregenrate = 0
				end
				data.wakaba.lunarregenrate = data.wakaba.lunarregenrate + 85
				player:AddSoulHearts(-1)
				player:AddCacheFlags(CacheFlag.CACHE_ALL)
				player:EvaluateItems()
			end
		elseif player:GetEffectiveMaxHearts() > 16 then
			if player:GetBoneHearts() > 0 then
				player:AddBoneHearts(-1)
			else
				player:AddMaxHearts(-2)
			end
		end
		if (player:GetPlayerType() == wakaba.PLAYER_TSUKASA and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)) and data.wakaba.lunargauge > 2000000 then
			data.wakaba.lunargauge = 2000000
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		elseif not (player:GetPlayerType() == wakaba.PLAYER_TSUKASA and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)) and data.wakaba.lunargauge > 1000000 then
			data.wakaba.lunargauge = 1000000
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		end

		if data.wakaba.lunargauge then
			if data.wakaba.lunargauge > 0 then
			else
				if player:HasCollectible(wakaba.COLLECTIBLE_LUNAR_STONE) then
					player:RemoveCollectible(wakaba.COLLECTIBLE_LUNAR_STONE)
					data.wakaba.lunargauge = nil
					data.wakaba.lunarregenrate = nil
				elseif not player:HasCollectible(wakaba.COLLECTIBLE_LUNAR_STONE) and player:GetPlayerType() == wakaba.PLAYER_TSUKASA then
					data.wakaba.nolunarrefill = true
					local revivaldata = wakaba:CanRevive(player)
					if not player:WillPlayerRevive() and revivaldata then
						print("Lunar remains")
						data.wakaba.lunargauge = -50000
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
					else
						--player:Die()
						data.wakaba.lunargauge = nil
						data.wakaba.lunarregenrate = nil
					end
					player:Die()
					if data.wakaba.chargestate[wakaba:GetChargeBarIndex(player, "LunarGauge")].checkremove then
						wakaba:RemoveChargeBarData(player, wakaba:GetChargeBarIndex(player, "LunarGauge"))
					end
				end
				data.wakaba.lunargauge = nil
				data.wakaba.lunarregenrate = nil
			end
			wakaba:SetLunarChargeBar(player)
		end
	else
		wakaba:GetPlayerEntityData(player)
    local data = player:GetData()
		data.wakaba.lunargauge = nil
		data.wakaba.lunarregenrate = nil
		if data.wakaba.chargestate
		and wakaba:GetChargeState(player, "LunarGauge") then
			if data.wakaba.chargestate[wakaba:GetChargeBarIndex(player, "LunarGauge")] then
				wakaba:RemoveChargeBarData(player, wakaba:GetChargeBarIndex(player, "LunarGauge"))
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_LunarStone)

function wakaba:SetLunarChargeBar(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if not wakaba.sprites.LunarChargeSprite then
		wakaba.sprites.LunarChargeSprite = Sprite()
		wakaba.sprites.LunarChargeSprite:Load("gfx/chargebar_lunarstone.anm2", true)
		wakaba.sprites.LunarChargeSprite.Color = Color(1,1,1,1)
	end

	local chargeno = wakaba:GetChargeBarIndex(player, "LunarGauge")
	local chargestate = wakaba:GetChargeState(player, "LunarGauge")
	local percent = data.wakaba.lunargauge and ((data.wakaba.lunargauge // 1000) / 10) or nil
	if chargestate then
		chargestate.Count = wakaba.state.options.lunarpercent and percent or nil
		chargestate.CurrentValue = player:GetData().wakaba.lunargauge
		chargestate.Sprite = wakaba.sprites.LunarChargeSprite
	else
		chargestate = {
			Index = chargeno,
			Profile = "LunarGauge",
			IncludeFinishAnim = true,
			Sprite = wakaba.sprites.LunarChargeSprite,
			MaxValue = 1000000,
			MinValue = 1,
			CurrentValue = data.wakaba.lunargauge or 0,
			Count = wakaba.state.options.lunarpercent and percent or nil,
			CountSubfix = "%",
			Reverse = true,
		}
	end
	wakaba:SetChargeBarData(player, chargeno, chargestate)
end

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

function wakaba:TakeDamage_LunarStone(entity, amount, flags, source, cooldown)
	-- If the player is Wakaba
	--print(entity.Type)
	local player = entity:ToPlayer()
	if wakaba:hasLunarStone(player)	then
		wakaba:RegisterHeart(player)
	end
end
--wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_LunarStone, EntityType.ENTITY_PLAYER)


function wakaba:PlayerRender_LunarStone(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if wakaba:hasLunarStone(player) and data.wakaba.lunargauge and Game():GetHUD():IsVisible() then
		local x = Isaac.WorldToScreen(player.Position).X - 5 - Game().ScreenShakeOffset.X
		local y = Isaac.WorldToScreen(player.Position).Y - 60 - Game().ScreenShakeOffset.Y
		wakaba.f:DrawString(((data.wakaba.lunargauge // 1000) / 10), x, y ,KColor(0.9,0.8,1,1,0,0,0),0,true)
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.PlayerRender_LunarStone)

function wakaba:Cache_LunarStone(player, cacheFlag)
  if wakaba:hasLunarStone(player) then
		local count = player:GetCollectibleNum(wakaba.COLLECTIBLE_LUNAR_STONE)
		if player:GetPlayerType() == wakaba.PLAYER_TSUKASA then
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
	if Game():GetRoom():GetType() == RoomType.ROOM_BOSS then
		for i = 0, Game():GetNumPlayers() - 1 do
			local player = Game():GetPlayer(i)
			if wakaba:hasLunarStone(player) then
				wakaba:GetPlayerEntityData(player)
				local data = player:GetData()
				if data.wakaba.lunargauge < 1000000 then
					data.wakaba.lunargauge = 1000000
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_LunarStone)


function wakaba:AfterRevival_LunarStone(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if data.wakaba.nolunarrefill then
		data.wakaba.nolunarrefill = nil
	end
	if data.wakaba.tsukasa1up then
		data.wakaba.lunargauge = data.wakaba.tsukasa1up
		data.wakaba.tsukasa1up = nil
		wakaba:SetLunarChargeBar(player)
	end
end
