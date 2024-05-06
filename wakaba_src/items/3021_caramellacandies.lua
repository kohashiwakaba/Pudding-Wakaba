--[[
	Caramella Candies (카라멜라 캔디) - 장신구
	클리어하지 않은 방 최초 입장 시 카라멜라 멤버 파리 소환
	- 리셰 : 1~2마리
	- 리라 : 1~2마리
	- 시엘 : 0마리
	- 코론 : 1~2마리
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:NewRoom_CaramellaCandies()
	local room = wakaba.G:GetRoom()
	if room:IsFirstVisit() and not room:IsClear() then
		wakaba:ForAllPlayers(function (player)---@param player EntityPlayer
			if player:HasTrinket(wakaba.Enums.Trinkets.CANDY_OF_RICHER) then
				local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.CANDY_OF_RICHER)
				local count = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.CANDY_OF_RICHER)
				local chance = rng:RandomFloat()
				count = chance < 0.5 and count + 1 or count
				for i = 1, count do
					wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.RICHER, nil, nil, true)
				end
			end
			if player:HasTrinket(wakaba.Enums.Trinkets.CANDY_OF_RIRA) then
				local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.CANDY_OF_RIRA)
				local count = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.CANDY_OF_RIRA)
				local chance = rng:RandomFloat()
				count = chance < 0.5 and count + 1 or count
				for i = 1, count do
					wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.RIRA, nil, nil, true)
				end
			end
			if player:HasTrinket(wakaba.Enums.Trinkets.CANDY_OF_CIEL) then
				local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.CANDY_OF_CIEL)
				local count = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.CANDY_OF_CIEL)
				for i = 1, count do
					wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.CIEL, nil, nil, true)
				end
			end
			if player:HasTrinket(wakaba.Enums.Trinkets.CANDY_OF_KORON) then
				local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.CANDY_OF_KORON)
				local count = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.CANDY_OF_KORON)
				local chance = rng:RandomFloat()
				count = chance < 0.5 and count + 1 or count
				for i = 1, count do
					wakaba:SpawnCaramellaFly(player, wakaba.Enums.Flies.KORON, nil, nil, true)
				end
			end
			-- TODO
			if player:HasTrinket(wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG) then
				local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG)
				local count = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG)
			end
		end)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_CaramellaCandies)
