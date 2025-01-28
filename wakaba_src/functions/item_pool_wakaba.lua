-- main unlock related functions mixed from Fiend Folio, Retribution

local game = Game()
local isc = _wakaba.isc

local local_item_pools = {
	run = {}
}
wakaba:saveDataManager("wakaba item pools", local_item_pools)
wakaba.CurrentCustomPool = local_item_pools.run

wakaba.CustomPoolNames = {
	"CloverChest",
	"ShioriValut",
}

wakaba:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, 20000, function (_, isContinue)
	if not isContinue then
		wakaba:GenerateWakabaPools()
	end
end)

function wakaba:GenerateWakabaPools()
	local config = Isaac.GetItemConfig()
	for _, poolName in ipairs(wakaba.CustomPoolNames) do
		if wakaba.Weights[poolName] then
			wakaba.CurrentCustomPool[poolName] = wakaba:DeepClone(wakaba.Weights[poolName])
		end
	end
end

function wakaba:GetItemFromWakabaPools(poolName, decrease, seed)
	if wakaba.CurrentCustomPool[poolName] then

		local pool = wakaba.G:GetItemPool()
		local level = wakaba.G:GetLevel()
		local room = wakaba.G:GetRoom()
		local config = Isaac.GetItemConfig()

		wakaba.state.rerollloopcount = wakaba.state.rerollloopcount or 0

		local rerollProps = {
			qualityChance = {
				[0] = 1,
				[1] = 1,
				[2] = 1,
				[3] = 1,
				[4] = 1,
			},
			allowActives = true,
		}
		for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.EVALUATE_WAKABA_COLLECTIBLE_REROLL_PROPS)) do
			local newRerollProps = callbackData.Function(callbackData.Mod, rerollProps, selected, nil, decrease, seed, true)

			if newRerollProps then
				rerollProps = newRerollProps
			end
		end

		for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.POST_EVALUATE_WAKABA_COLLECTIBLE_REROLL_PROPS)) do
			local newRerollProps = callbackData.Function(callbackData.Mod, rerollProps, selected, nil, decrease, seed, true)

			if newRerollProps then
				rerollProps = newRerollProps
			end
		end

		local isPassed = false
		local selected = nil
		local selectedIndex = nil
		local nextRng = RNG()
		nextRng:SetSeed(seed, 35)
		while not isPassed and wakaba.state.rerollloopcount <= wakaba.state.options.rerollbreakfastthreshold do
			selectedIndex = isc:getRandomIndexFromWeightedArray(wakaba.CurrentCustomPool[poolName], nextRng:Next()) + 1
			if selectedIndex then
				wakaba.state.rerollloopcount = wakaba.state.rerollloopcount + 1
				selected = wakaba.CurrentCustomPool[poolName][selectedIndex][1]
				local selectedItemConf = config:GetCollectible(selected)
				if decrease then
					table.remove(wakaba.CurrentCustomPool[poolName], selectedIndex)
				end
				isPassed = not Isaac.RunCallback(wakaba.Callback.WAKABA_COLLECTIBLE_REROLL, rerollProps, selected, selectedItemConf, nil, decrease, seed, true)
				local str_ispassed = (isPassed and "passed") or "not passed"
				wakaba.Log("Rerolling items - #" .. wakaba.state.rerollloopcount .. ", Item No." .. selected .. " is " ..str_ispassed)
			else
				selected = pool:GetCollectible(ItemPoolType.POOL_TREASURE, false, seed)
				break
			end
		end
		wakaba.state.rerollloopcount = 0
		return selected

	end
end