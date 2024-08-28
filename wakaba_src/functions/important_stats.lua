--[[
	와카바 모드 공격력 배율 서순 (위쪽일수록 많은 아이템에 배수 적용)
	- Rira's Bento
	- 캐릭터 배수
	- Lunar Stone
	- Rabbit Ribbon (Curse of Sniper)
	- D-Cup Ice Cream
	- Revenge Fruit (non-tears)
	- Book of the God
	- Book of the Fallen
	- Arcane Crystal
	- Advanced Crystal
	- Mystic Crystal
	- Phantom Cloak (Belial)
	- Double Invader
	- Crisis Boost
	- Magma Blade (non-tears)
	- Kanae Lens
	- Ring of Jupiter
	- Range OS
	- Trial Stew
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

---comment
---@param player EntityPlayer
---@param cacheFlag CacheFlag
function wakaba:Cache_Important(player, cacheFlag)
	if cacheFlag  == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage * (1 + (wakaba:getCustomStat(player, "damagemult") or 0))
		if player:HasCollectible(wakaba.Enums.Collectibles.RIRAS_BENTO) then
			player.Damage = player.Damage * (1 + (0.04 * player:GetCollectibleNum(wakaba.Enums.Collectibles.RIRAS_BENTO)))
		end
		if player:HasTrinket(wakaba.Enums.Trinkets.RANGE_OS) then
			for i = 1, player:GetTrinketMultiplier(wakaba.Enums.Trinkets.RANGE_OS) do
				player.Damage = player.Damage * 2.25
			end
		end
	end
	if cacheFlag  == CacheFlag.CACHE_FIREDELAY then
		if player:GetData().wakaba.minervacount > 0 then
			player.MaxFireDelay = wakaba:MultiplyTears(player.MaxFireDelay, wakaba:IsLunatic() and 1.6 or 2.3)
		end
	end
	if cacheFlag == CacheFlag.CACHE_RANGE then
		if player:HasTrinket(wakaba.Enums.Trinkets.RANGE_OS) then
			for i = 1, player:GetTrinketMultiplier(wakaba.Enums.Trinkets.RANGE_OS) do
				player.TearRange = player.TearRange * 0.4
			end
		end

		if player.TearRange > (6.5 * 40) then
			player.TearRange = (6.5 * 40)
		end
	end
	if cacheFlag == CacheFlag.CACHE_LUCK then
		if player:HasTrinket(wakaba.Enums.Trinkets.CLOVER, false) then
			player.Luck = player.Luck * 2
			if player.Luck < 0 then
				player.Luck = player.Luck * -1
			end
		end
		if player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_PENDANT) and player:GetPlayerType() ~= wakaba.Enums.Players.WAKABA_B then
			if wakaba:IsLunatic() then
				player.Luck = math.max(player.Luck, 3)
			else
				local pendantcnt = 0
				if player:GetData().wakaba and player:GetData().wakaba.PendantCandidates then
					pendantcnt = #player:GetData().wakaba.PendantCandidates
				end
				player.Luck = math.max(player.Luck, 7)
				player.Luck = player.Luck + (0.35 * pendantcnt * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT))
			end
		end
		if player:HasTrinket(wakaba.Enums.Trinkets.DARK_PENDANT, false) then
			if player.Luck > 0 then
				player.Luck = player.Luck * -1
			end
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010721, wakaba.Cache_Important)