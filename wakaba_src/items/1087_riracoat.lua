--[[
	Rira's Coat (리라의 코트) - 액티브(Active) : ?칸
	사용 시 휜 불 상태 돌입, 클리어 시 다음 방에서 흰 불 상태 해제 + 그 방에서 흰 불 생성
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_RiraCoat(usedItem, rng, player, useFlags, activeSlot, varData)

	local fireplacePos = wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true)
	Isaac.Spawn(EntityType.ENTITY_FIREPLACE, 4, 0, fireplacePos, Vector.Zero, nil)

	local effects = player:GetEffects()
	if not effects:HasNullEffect(NullItemID.ID_LOST_CURSE) then
		effects:AddNullEffect(NullItemID.ID_LOST_CURSE)
		SFXManager():Play(SoundEffect.SOUND_FIREDEATH_HISS)
		if not effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
			effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, true, 1)
		end
	end

	return {
		Discharge = true,
		Remove = false,
		ShowAnim = useFlags & UseFlag.USE_NOANIM == 0,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RiraCoat, wakaba.Enums.Collectibles.RIRAS_COAT)