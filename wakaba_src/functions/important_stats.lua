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

local isc = _wakaba.isc

---comment
---@param player EntityPlayer
---@param cacheFlag CacheFlag
function wakaba:Cache_Important(player, cacheFlag)
	if cacheFlag  == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage * (1 + math.max((wakaba:getCustomStat(player, "damagemult") or 0), -0.75))

		local dcup = player:GetCollectibleNum(wakaba.Enums.Collectibles.D_CUP_ICECREAM) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.D_CUP_ICECREAM)
		if dcup > 0 then
			local mult = (0.36 * dcup) + (wakaba:IsLunatic() and 0 or 0.44)
			player.Damage = player.Damage * (1 + mult)
		end

		local neko = player:GetCollectibleNum(wakaba.Enums.Collectibles.NEKO_FIGURE) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.NEKO_FIGURE)
		if neko > 0 then
			local reduce = wakaba:IsLunatic() and 7 or 2
			player.Damage = player.Damage * (1 + (0.1 * (neko - reduce)))
		end
		if player:HasCollectible(wakaba.Enums.Collectibles.RIRAS_BENTO) then
			player.Damage = player.Damage * (1 + (0.04 * player:GetCollectibleNum(wakaba.Enums.Collectibles.RIRAS_BENTO)))
		end
		if wakaba:hasPlayerDataEntry(player, "lunargauge") and wakaba:hasPlayerDataEntry(player, "lunarregenrate") then
			local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.LUNAR_STONE)
			local serverMult = 1
			if wakaba:extraVal("tsukasaServerOffline") then
				serverMult = serverMult + 1.5
			end
			if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
				count = count + 1
			end
			if wakaba:extraVal("tsukasaAcceleration") then
				count = count + 1
				if wakaba:extraVal("tsukasaServerOffline") then
					serverMult = serverMult + 1
				end
			end
			if wakaba:getPlayerDataEntry(player, "lunarregenrate") >= 0 or wakaba:extraVal("tsukasaAcceleration") then
				player.Damage = player.Damage * (1 + (0.2 * count)) * serverMult
			else
				player.Damage = player.Damage * 0.85
			end
		end
		if player:HasTrinket(wakaba.Enums.Trinkets.RANGE_OS) then
			for i = 1, player:GetTrinketMultiplier(wakaba.Enums.Trinkets.RANGE_OS) do
				player.Damage = player.Damage * 2.25
			end
		end
	end
	if cacheFlag  == CacheFlag.CACHE_FIREDELAY then

		local mint = player:GetCollectibleNum(wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM)
		if mint > 0 then
			local mult = (0.16 * mint) + 0.84
			player.MaxFireDelay = wakaba:MultiplyTears(player.MaxFireDelay, 1 + mult)
		end
		if player:GetData().wakaba.minervacount > 0 then
			player.MaxFireDelay = wakaba:MultiplyTears(player.MaxFireDelay, wakaba:IsLunatic() and 1.6 or 2.3)
		end
		if wakaba:hasPlayerDataEntry(player, "lunargauge") and wakaba:hasPlayerDataEntry(player, "lunarregenrate") then
			local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.LUNAR_STONE)
			if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
				count = count + 1
			end
			if wakaba:getPlayerDataEntry(player, "lunarregenrate") >= 0 or wakaba:extraVal("tsukasaAcceleration") then
				player.MaxFireDelay = wakaba:MultiplyTears(player.MaxFireDelay, (1 + (0.2 * count)))
			else
				player.MaxFireDelay = wakaba:MultiplyTears(player.MaxFireDelay, 0.8)
			end
		end
	end
	if cacheFlag == CacheFlag.CACHE_RANGE then
		if wakaba:hasPlayerDataEntry(player, "lunargauge") and wakaba:hasPlayerDataEntry(player, "lunarregenrate") then
			local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.LUNAR_STONE)
			local bonus = wakaba:extraVal("lunarRange", 0)
			if player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
				count = count + 1
				local bonus = bonus + wakaba:extraVal("tsukasaLunarRange", 0)
			end
			if wakaba:getPlayerDataEntry(player, "lunarregenrate") >= 0 or wakaba:extraVal("tsukasaAcceleration") then
				player.TearRange = player.TearRange + (bonus * 40)
			end
		end
		if player:HasTrinket(wakaba.Enums.Trinkets.RANGE_OS) then
			for i = 1, player:GetTrinketMultiplier(wakaba.Enums.Trinkets.RANGE_OS) do
				player.TearRange = player.TearRange * 0.4
			end

			if player.TearRange > (6.5 * 40) then
				player.TearRange = (6.5 * 40)
			end
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
			local parLuck = 7
			if wakaba:IsLunatic() then
				parLuck = 3
			end
			parLuck = parLuck + (player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT) * 0.25) - 0.25
			if wakaba:extraVal("pendantMinLuck") then
				parLuck = parLuck + wakaba:extraVal("pendantMinLuck", 0)
			end
			if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
				if wakaba:extraVal("wakabaIsSmart") then
					parLuck = parLuck + 3
				end
			end
			player.Luck = math.max(player.Luck, parLuck)
		end
		if player:HasTrinket(wakaba.Enums.Trinkets.DARK_PENDANT, false) then
			if player.Luck > 0 then
				player.Luck = player.Luck * -1
			end
		end

		local leafTear = wakaba:getPlayerDataEntry(player, "leafTearLuck", 0)
		if leafTear < 0 then
			player.Luck = player.Luck + leafTear
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010721, wakaba.Cache_Important)