--[[ 
	Richer's Flipper (리셰의 반전기) - 액티브(Active) - 3 rooms
	사용 시 카드/알약 및 폭탄/열쇠를 반전
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_RicherFlipper(_, rng, player, useFlags, activeSlot, varData)
	local judaschance = rng:RandomFloat() * 10000
	if judaschance >= 5000 and wakaba:HasJudasBr(player) then
		player:AddCard(Card.RUNE_BLACK)
	else
		player:AddCard(wakaba.G:GetItemPool():GetCard(rng:Next(), false, true, true))
	end
	if judaschance >= 9000 and wakaba:HasJudasBr(player) then
		player:UseCard(Card.RUNE_BLACK, UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOANIM | UseFlag.USE_NOHUD)
	end
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.DECK_OF_RUNES, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RicherFlipper, wakaba.Enums.Collectibles.DECK_OF_RUNES)