local mod = wakaba
local game = Game()

--callback
local postItemFunctions = {
	item = {},
	func = {}
}
function mod.addPostItemGetFunction(self, _func, _item)
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
	data.w_heldItems = {}
	local itemSize = Isaac.GetItemConfig():GetCollectibles().Size - 1
	for item = 1, itemSize do
		data.w_heldItems[item] = 0
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.playerItemsArrayInit)

--execute
function mod:playerItemsArrayUpdate(player)
	local data = player:GetData()
	local itemSize = Isaac.GetItemConfig():GetCollectibles().Size - 1
  local queuedItem = player.QueuedItem
	if data.w_heldItems then
		for item = 1, itemSize do
      local beforeHeld = queuedItem.Touched
			if (data.w_heldItems[item] < player:GetCollectibleNum(item, true)) then
				if player.FrameCount > 7 and not beforeHeld then --do not trigger on game continue. it still updates the count tho, so this allows us not to use savedata
					for i=1, #postItemFunctions.item do
						if postItemFunctions.item[i] == item or postItemFunctions.item[i] == -1 then
							postItemFunctions.func[i](self, player, item)
						end
					end
				end
				--increase by 1
				data.w_heldItems[item] = data.w_heldItems[item] + 1
			elseif (data.w_heldItems[item] > player:GetCollectibleNum(item, true)) then
				data.w_heldItems[item] = player:GetCollectibleNum(item, true)
			end
		end
	else
		--if not initialized for some reason
		--inventoryDataSet(player)
    data.w_heldItems = {}
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.playerItemsArrayUpdate)