--[[
	Rira's Bento (리라의 도시락) - 패시브(Passive)
	리라로 Lamb 격파
	올스탯, 이후 등장하는 모든 아이템이 리라의 도시락으로 변경
	체력이 높을수록 공격력 배율 증가
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

---comment
---@param player EntityPlayer
---@param cacheFlag CacheFlag
function wakaba:Cache_RiraBento(player, cacheFlag)
	if player:HasCollectible(wakaba.Enums.Collectibles.RIRAS_BENTO) then
		local power = player:GetCollectibleNum(wakaba.Enums.Collectibles.RIRAS_BENTO)
		if cacheFlag  == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + (0.04 * power)
		end
		if cacheFlag  == CacheFlag.CACHE_DAMAGE then
			local heartPower = math.max((player:GetHearts() * 5) + (player:GetSoulHearts() * 5), 0)
			player.Damage = player.Damage * (heartPower * 0.1 * wakaba:getEstimatedDamageMult(player))
			--player.Damage = player.Damage * (1.02 ^ power)
		end
		if cacheFlag  == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, 0.35 * power * wakaba:getEstimatedTearsMult(player))
		end
		if cacheFlag  == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (20 * power)
		end
		if cacheFlag  == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + (0.4 * power)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_RiraBento)