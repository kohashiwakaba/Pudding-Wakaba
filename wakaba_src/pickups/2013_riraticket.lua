--[[
	Rira Ticket (리라 티켓) - 카드, Blank Card 쿨타임 4칸
	사용 시 부서진하트를 뼈하트 or 소울하트로 변경
	장신구가 없을 경우 뼈하트, 있을 경우 장신구 흡수 + 소울하트
 ]]

local isc = _wakaba.isc

---@param player EntityPlayer
---@param flags UseFlag
function wakaba:UseCard_RiraTicket(_, player, flags)
	wakaba:GetPlayerEntityData(player)
	local broken = math.max(player:GetBrokenHearts(), 0)
	if broken > 0 then
		player:AddBrokenHearts(-1)
	end
	local trinket1 = player:GetTrinket(0)
	local trinket2 = player:GetTrinket(1)
	if trinket1 > 0 or trinket2 > 0 then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM | UseFlag.USE_VOID, -1)
		player:AddSoulHearts(2)
	elseif broken > 0 then
		player:AddBoneHearts(1)
	else
		player:AddHearts(2)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_RiraTicket, wakaba.Enums.Cards.CARD_RIRA_TICKET)
