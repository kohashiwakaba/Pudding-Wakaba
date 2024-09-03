--[[

Dynamic Boss Health
보스의 체력 배율 아래 요인으로 결정

 - 시작 아이템 퀄리티
 -- 0 : x1.0
 -- 1 : x1.025
 -- 2 : x1.075
 -- 3 : x1.15
 -- 4 : x1.25
 -- 5 : x2.5 (rgon + 리쉐이큰 모드 한정)
 -- 6 : x3.0 (rgon + 리쉐이큰 모드 한정)

 - 총 아이템 개수
 --   0 : x1.00
 --  10 : x1.05
 --  20 : x1.10
 --  50 : x1.25
 -- 100 : x1.50

 - 소지 중인 아이템 퀄리티 총합
 --  40 : x2.0
 --  80 : x3.0
 -- 120 : x4.0

 - 보스방 진입 시점 공격력 x 연사
 --  30 : x1.0
 --  60 : x1.25
 --  90 : x1.5

 - (와카바 모드 한정) 다모클레스 시작 여부
 -- 없음 : x1.0
 -- 일반 : x3.0
 -- 루나 : x3.0
 -- 빈티지 : x2.5

]]

if REPENTOGON then
	---@param player EntityPlayer
	function wakaba:PostGetCollectible_FirstItem(type, charge, firstTime, slot, varData, player)
		if wakaba:hasPlayerDataEntry(player, "FirstQuality") then return end
		local timer = wakaba.G:GetFrameCount()
		if timer > 5 then
			local c = Isaac.GetItemConfig():GetCollectible(type)
			if c then
				wakaba:setPlayerDataEntry(player, "FirstQuality", c.Quality)
			else
				wakaba:setPlayerDataEntry(player, "FirstQuality", 0)
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, wakaba.PostGetCollectible_FirstItem)
end

---@param entry string | EntityNPC | table
---@return number
function wakaba:getBossHealthFactor(entry)
	local finalMultiplier = 1

	local startQuality = 0
	local totalItems = 0
	local totalQuality = 0
	local totalDamage = 0

	local c = Isaac.GetItemConfig()

	for num = 1, wakaba.G:GetNumPlayers() do
		local player = wakaba.G:GetPlayer(num - 1)
		local items = 0
		local quality = 0
		if REPENTOGON then
			local col = player:GetCollectiblesList()
			for itemID, num in pairs(col) do
				local ic = c:GetCollectible(itemID)
				if ic then
					items = items + num
					quality = quality + (num * (ic.Quality ^ 2))
				end
			end
		else
		end
		if REPENTOGON then
			startQuality = 4
		else
			startQuality = math.max(wakaba:getPlayerDataEntry(player, "FirstQuality", 0) , startQuality)
		end
		totalItems = math.max(items, totalItems)
		totalQuality = math.max(quality, totalQuality)
		totalDamage = math.max(player.Damage, totalDamage)
	end

	-- 시작 퀄리티 :
	local startQualityMult = (-0.0026 * (startQuality ^ 3)) + (0.0675 * (startQuality ^ 2))  + (0.0247 * (startQuality ^ 1)) + 1
	if startQuality <= 4 then
		startQualityMult = startQualityMult - 1
		startQualityMult = startQualityMult * 0.25
		startQualityMult = startQualityMult + 1
	end
	wakaba.Log("Dynamic boss health - startQualityMult", startQualityMult)

	-- 총합 퀄리티
	local qualityMult = ((totalQuality / 40) + 1)
	wakaba.Log("Dynamic boss health - qualityMult", qualityMult)

	-- 총합 아이템 개수
	local itemsMult = ((totalItems / 200) + 1) ^ 1.6
	wakaba.Log("Dynamic boss health - itemsMult", itemsMult)

	-- 최종 대미지
	totalDamage = math.max(totalDamage - 30, 0)
	local damageMult = ((totalDamage / 30) + 1) ^ 2
	wakaba.Log("Dynamic boss health - damageMult", damageMult)

	finalMultiplier = startQualityMult * qualityMult * itemsMult * damageMult

	return finalMultiplier
end