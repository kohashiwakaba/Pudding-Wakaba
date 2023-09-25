--[[
	Richer's Report Card (리셰의 성적표) - 장신구
	행운 +5, 중첩 당 추가 행운 +2.5, 패널티 피격 시 행운 -0.5, 스테이지 진입 시 초기화
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:NewLevel_RicherReportCard()
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		player:GetEffects():RemoveTrinketEffect(wakaba.Enums.Trinkets.REPORT_CARD, -1)
	end)
end
wakaba:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, wakaba.NewLevel_RicherReportCard)

---@param player EntityPlayer
function wakaba:PostTakeDamage_RicherReportCard(player, amount, flags, source, cooldown)
	if player:HasTrinket(wakaba.Enums.Trinkets.REPORT_CARD)
	and flags & (DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS) <= 0 then
		SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN)
		player:GetEffects():AddTrinketEffect(wakaba.Enums.Trinkets.REPORT_CARD, 1)
		player:AddCacheFlags(CacheFlag.CACHE_LUCK)
		player:EvaluateItems()
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_RicherReportCard)

---@param player EntityPlayer
function wakaba:Cache_RicherReportCard(player, cacheFlag)
	if cacheFlag == CacheFlag.CACHE_LUCK then
		local num = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.REPORT_CARD)
		if num > 0 then
			local base = wakaba.Enums.Constants.REPORT_CARD_BASE_LUCK + (num * wakaba.Enums.Constants.REPORT_CARD_EXTRA_LUCK)
			local penalties = player:GetEffects():GetTrinketEffectNum(wakaba.Enums.Trinkets.REPORT_CARD)
			local finalLuck = math.max(0, base - (penalties * 0.5))
			player.Luck = player.Luck + finalLuck
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_RicherReportCard)