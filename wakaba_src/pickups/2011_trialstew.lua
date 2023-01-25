--[[ 
	Trial Stew (시련의 국물) - 카드, Blank Card 쿨타임 12칸
	사용 시 전체 체력을 반칸으로 깎고 Holy Mantle 보호막을 전부 제거, 액티브 아이템을 전부 완충(강제, Blank Card 제외)
	방 3개 클리어까지 하트 줍기 불가능 및 Holy Card 사용 불가, 
	사용 직후 하트나 Holy Mantle 보호막이 채워지기 전까지 연사 +8, 공격력 x2 (중첩 당 연사 +1, 공격력 +25%)
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
function wakaba:UseCard_TrialStew(_, player, flags)
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.trialstewtimer = 25
	player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW)
	if flags & UseFlag.USE_CARBATTERY == 0 then
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
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_TrialStew, wakaba.Enums.Cards.CARD_TRIAL_STEW)

function wakaba:Cache_TrialStew(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.TRIAL_STEW) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW) then
		local num = player:GetCollectibleNum(wakaba.Enums.Collectibles.TRIAL_STEW) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.TRIAL_STEW)
		local redHearts = player:GetHearts() - player:GetRottenHearts()
		local soulHearts = player:GetSoulHearts()
		local boneHearts = player:GetBoneHearts()
		local totalHearts = redHearts + soulHearts + boneHearts
		if Epiphany and player:GetPlayerType() == Epiphany.table_type_id["KEEPER"] then
			totalHearts = player:GetCoins() // 20
		end
		local mantleConuts = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) + player:GetEffects():GetNullEffectNum(NullItemID.ID_HOLY_CARD)

		local target = 1
		if player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B then
			target = 2
		end

		if totalHearts + mantleConuts <= target then
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage * (2 + (0.25 * (num - 1)))
			end
			if cacheFlag == CacheFlag.CACHE_FIREDELAY then
				player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 7 + num)
			end
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
		local redHearts = player:GetHearts() - player:GetRottenHearts()
		local soulHearts = player:GetSoulHearts()
		local boneHearts = player:GetBoneHearts()
		local mantleConuts = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) + player:GetEffects():GetNullEffectNum(NullItemID.ID_HOLY_CARD)
		if redHearts + soulHearts + boneHearts + mantleConuts > 1 then
			player:GetEffects():RemoveCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW, -1)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_TrialStew)