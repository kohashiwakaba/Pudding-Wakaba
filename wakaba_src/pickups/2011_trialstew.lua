--[[
	Trial Stew (시련의 국물) - 카드, Blank Card 쿨타임 12칸
	사용 시 전체 체력을 반칸으로 깎고 Holy Mantle 보호막을 전부 제거, 액티브 아이템을 전부 완충(강제, Blank Card 제외)
	사용 시 연사 +1, 공격력 x2 (중첩 당 연사 +1, 공격력 +25%), 8중첩(타로천 11중첨)
	방 클리어 시 즉시 액티브 충전(시간제 제외), 중첩 1개분 해제
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
function wakaba:UseCard_TrialStew(_, player, flags)
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.trialstewtimer = 25
	player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW, true, 8)
	if flags & UseFlag.USE_CARBATTERY == 0 then
		player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS, -1)
		player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, -1)
		player:GetEffects():RemoveNullEffect(NullItemID.ID_HOLY_CARD, -1)
		if player:GetBoneHearts() > 0 then
			if player:GetPlayerType() ~= PlayerType.PLAYER_BETHANY_B then
				player:AddHearts(-2000)
			end
			if player:GetPlayerType() ~= PlayerType.PLAYER_BETHANY then
				player:AddSoulHearts(-2000)
			end
			player:AddBoneHearts(1 - player:GetBoneHearts())
		elseif player:GetMaxHearts() <= 0 then
			if player:GetPlayerType() ~= PlayerType.PLAYER_BETHANY_B then
				player:AddHearts(-2000)
			end
			player:AddSoulHearts(1 - player:GetSoulHearts())
		else
			if player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B then
				player:AddHearts(2 - player:GetHearts())
			else
				player:AddHearts(1 - player:GetHearts())
			end
			if player:GetPlayerType() ~= PlayerType.PLAYER_BETHANY then
				player:AddSoulHearts(-2000)
			end
		end
		for i = 0, 2 do
			if player:GetActiveItem(i) ~= CollectibleType.COLLECTIBLE_BLANK_CARD then
				player:FullCharge(i, true)
			end
		end
		if player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B then
			player:AddKeys(99)
		elseif Epiphany and player:GetPlayerType() == Epiphany.table_type_id["KEEPER"] then
			player:AddCoins(-999)
		end
	else
		player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW, true, 3)
	end
	wakaba.G:SetStateFlag(GameStateFlag.STATE_DONATION_SLOT_BLOWN, false)
	wakaba.G:SetStateFlag(GameStateFlag.STATE_DONATION_SLOT_JAMMED, false)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_TrialStew, wakaba.Enums.Cards.CARD_TRIAL_STEW)

function wakaba:Cache_TrialStew(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.TRIAL_STEW) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW) then
		local num = player:GetCollectibleNum(wakaba.Enums.Collectibles.TRIAL_STEW) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.TRIAL_STEW)
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (2 + (0.25 * (num - 1)))
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (num) * wakaba:getEstimatedTearsMult(player))
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_TrialStew)

function wakaba:PlayerUpdate_TrialStew(player)
	wakaba:GetPlayerEntityData(player)
	local data = player:GetData()
	if data.wakaba and data.wakaba.trialstewtimer and data.wakaba.trialstewtimer > 0 then
		if data.wakaba.trialstewtimer % 5 == 0 then
			SFXManager():Play(SoundEffect.SOUND_EXPLOSION_WEAK, 0.5)
		end
		data.wakaba.trialstewtimer = data.wakaba.trialstewtimer - 1
		if data.wakaba.trialstewtimer == 0 then
			data.wakaba.trialstewtimer = nil
		end
	end
	if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW) then
		for i = 0, 2 do
			local activeItem = player:GetActiveItem(i)
			if (player:HasCollectible(CollectibleType.COLLECTIBLE_9_VOLT) and (activeItem > 1) or (activeItem > 0))  then
				local itemConfig = Isaac.GetItemConfig()
				local activeConfig = itemConfig:GetCollectible(activeItem)
				if activeConfig then
					local maxCharges = activeConfig.MaxCharges
					local chargeType = activeConfig.ChargeType
					local currCharges = player:GetActiveCharge(i)
					if chargeType ~= ItemConfig.CHARGE_TIMED and currCharges > 0 and currCharges < (maxCharges * 2) then
						player:FullCharge(i, true)
					end
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_TrialStew)

function wakaba:RoomClear_TrialStew(rng, spawnPosition)
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		local playerEffects = player:GetEffects()
		if playerEffects:HasCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW) then
			playerEffects:RemoveCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW, 1)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_TrialStew)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.RoomClear_TrialStew)