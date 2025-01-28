--[[
	Flip Card (플립 카드) - 카드, Blank Card 쿨타임 4칸
	뒤집힌 리라로 Ultra Greedier 처치
	소지/사용 시 Flip 효과 발동
 ]]

local isc = _wakaba.isc

---@param player EntityPlayer
---@param flags UseFlag
function wakaba:UseCard_FlipCard(_, player, flags)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_FLIP, UseFlag.USE_NOANIM | UseFlag.USE_OWNED, -1)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_FlipCard, wakaba.Enums.Cards.CARD_FLIP)


function wakaba:PlayerUpdate_FlipCard(player)
	if wakaba:HasCard(player, wakaba.Enums.Cards.CARD_FLIP) then
		wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_FLIP, 1, "WAKABA_FLIP_CARD")
	else
		if wakaba.HiddenItemManager:Has(player, CollectibleType.COLLECTIBLE_FLIP, "WAKABA_FLIP_CARD") then
			wakaba.HiddenItemManager:RemoveStack(player, CollectibleType.COLLECTIBLE_FLIP, "WAKABA_FLIP_CARD")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_FlipCard)