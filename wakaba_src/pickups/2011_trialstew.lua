--[[ 
	Trial Stew (시련의 국물) - 카드, Blank Card 쿨타임 12칸
	사용 시 전체 체력을 반칸으로 깎고 Holy Mantle 보호막을 전부 제거, 액티브 아이템을 전부 완충(강제, Blank Card 제외)
	방 3개 클리어까지 하트 줍기 불가능 및 Holy Card 사용 불가, 
	사용 직후 하트나 Holy Mantle 보호막이 채워지기 전까지 연사 +8, 공격력 x2 (중첩 당 연사 +1, 공격력 +25%)
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
function wakaba:UseCard_TrialStew(_, player, flags)
	--player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW)
	player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, -1)
	player:GetEffects():RemoveNullEffect(NullItemID.ID_HOLY_CARD, -1)
	for i = 1, 3 do
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
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_TrialStew, wakaba.Enums.Cards.CARD_VALUT_RIFT)

function wakaba:Cache_TrialStew(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.TRIAL_STEW) or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW) then
		local num = player:GetCollectibleNum(wakaba.Enums.Collectibles.TRIAL_STEW) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.TRIAL_STEW)
		local totalHearts = isc:getPlayerHearts(player)
		if Epiphany and player:GetPlayerType() == Epiphany.table_type_id["KEEPER"] then
			totalHearts = player:GetCoins() // 20
		end
		local totalShields = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) + player:GetEffects():GetNullEffectNum(NullItemID.ID_HOLY_CARD)
		if totalHearts + totalShields == 1 then
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage * (2 + (0.25 * (num - 1)))
			end
			if cacheFlag == CacheFlag.CACHE_FIREDELAY then
				player.MaxFireDelay = player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 7 + num)
			end
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_TrialStew)