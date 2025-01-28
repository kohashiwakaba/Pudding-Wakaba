--[[
	Kuromi Card (쿠로미 카드) - 장신구
	액티브 아이템 사용 시 확률적으로 충전량 보존 or 일회성 미소멸
 ]]

local isc = _wakaba.isc

function wakaba:UseItem_KuromiCard(item, rng, player, useFlags, activeSlot, varData)
	if player:GetTrinketMultiplier(wakaba.Enums.Trinkets.KUROMI_CARD) > 0 then
		local removeChance = 1
		for i = 1, math.min(player:GetTrinketMultiplier(wakaba.Enums.Trinkets.KUROMI_CARD), 5) do
			removeChance = removeChance - 0.1
		end
		if rng:RandomFloat() < removeChance then
			player:TryRemoveTrinket(wakaba.Enums.Trinkets.KUROMI_CARD)
		end
		return {
			Discharge = false,
			Remove = false,
			ShowAnim = true,
		}
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_KuromiCard)