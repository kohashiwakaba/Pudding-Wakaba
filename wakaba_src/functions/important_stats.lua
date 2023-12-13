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

function wakaba:Cache_Important(player, cacheFlag)
	if cacheFlag  == CacheFlag.CACHE_DAMAGE then
		if player:HasCollectible(wakaba.Enums.Collectibles.RIRAS_BENTO) then
			player.Damage = player.Damage * (1.07 ^ player:GetCollectibleNum(wakaba.Enums.Collectibles.RIRAS_BENTO))
		end
	end
	if cacheFlag == CacheFlag.CACHE_LUCK then
		if player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_PENDANT) and player:GetPlayerType() ~= wakaba.Enums.Players.WAKABA_B then
			local pendantcnt = 0
			if player:GetData().wakaba and player:GetData().wakaba.PendantCandidates then
				pendantcnt = #player:GetData().wakaba.PendantCandidates
			end
			if player.Luck < 7 then
				player.Luck = 7
			end
			player.Luck = player.Luck + (0.35 * pendantcnt * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT))
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010721, wakaba.Cache_Important)