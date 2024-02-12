--[[
	Richer Ticket (리셰 티켓) - 카드, Blank Card 쿨타임 8칸
	사용 시 Sweets Catalog 효과 발동
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

---@param player EntityPlayer
---@param flags UseFlag
function wakaba:UseCard_RicherTicket(_, player, flags)
	wakaba:GetPlayerEntityData(player)
	player:UseActiveItem(wakaba.Enums.Collectibles.SWEETS_CATALOG, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_RicherTicket, wakaba.Enums.Cards.CARD_RICHER_TICKET)
