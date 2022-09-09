local mod = wakaba
local game = Game()

--callback
local postItemFunctions = {
	item = {},
	func = {}
}
function mod:addPostItemGetFunction(_func, _item)
	local id = #postItemFunctions.item+1
	if _item then
		postItemFunctions.item[id] = _item
	else
		postItemFunctions.item[id] = -1
	end
	postItemFunctions.func[id] = _func
end

--on player init
function mod:playerItemsArrayInit(player)
	local data = player:GetData()
	data.heldItems = {}
	local itemSize = Isaac.GetItemConfig():GetCollectibles().Size - 1
	for item = 1, itemSize do
		data.heldItems[item] = 0
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.playerItemsArrayInit)

--execute
function mod:playerItemsArrayUpdate(player)
	local data = player:GetData()
	local itemSize = Isaac.GetItemConfig():GetCollectibles().Size - 1
	if data.heldItems then
		for item = 1, itemSize do
			if (data.heldItems[item] < player:GetCollectibleNum(item, true)) then
				if player.FrameCount > 7 then --do not trigger on game continue. it still updates the count tho, so this allows us not to use savedata
					for i=1, #postItemFunctions.item do
						if postItemFunctions.item[i] == item or postItemFunctions.item[i] == -1 then
							postItemFunctions.func[i](player, item)
						end
					end
				end
				--increase by 1
				data.heldItems[item] = data.heldItems[item] + 1
			elseif (data.heldItems[item] > player:GetCollectibleNum(item, true)) then
				data.heldItems[item] = player:GetCollectibleNum(item, true)
			end
		end
	else
		--if not initialized for some reason
		--inventoryDataSet(player)
    data.heldItems = {}
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.playerItemsArrayUpdate)