--[[
	Clear File (클리어 파일) - 액티브(Active) - ? rooms
	- REPENTOGON 전용
	- 사용 시 선택한 패시브 중 하나와 받침대 패시브 하나를 교체
]]
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_ClearFile(item, rng, player, useFlags, activeSlot, varData)
	if REPENTOGON then
		local historyList = player:GetHistory():GetCollectiblesHistory()
		local count = math.min((#historyList * 0.5) // 1, 30)
		for i, history in ipairs(historyList) do
			local cType = history:GetItemID()
			if cType > 0 and player:HasCollectible(cType, true) then
			end
		end
	else
	end
end

wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_ClearFile, wakaba.Enums.Collectibles.CLEAR_FILE)