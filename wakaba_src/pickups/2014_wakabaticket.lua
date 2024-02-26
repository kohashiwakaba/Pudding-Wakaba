--[[
	Wakaba Ticket (와카바 티켓) - 카드, Blank Card 쿨타임 8칸
	뒤집힌 와카바로 Mega Satan 처치
	사용 시 행운의 와카바 상자와 불운의 와카바 상자를 1개씩 소환 (선택형)
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

---@param player EntityPlayer
---@param flags UseFlag
function wakaba:UseCard_RiraTicket(_, player, flags)
	wakaba:GetPlayerEntityData(player)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_RiraTicket, wakaba.Enums.Cards.CARD_RIRA_TICKET)
