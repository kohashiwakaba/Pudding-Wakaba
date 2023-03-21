--[[ 
	Pow/MOd Block (POW/MOd 블록) - 액티브 : 기타
	사용 시 폭탄 2개를 소모하여 지상의 적에게 280(POW)/공중의 적에게 320(MOd) 분산 피해
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_PowMod(usedItem, rng, player, useFlags, activeSlot, varData)
	if player:GetActiveItem(activeSlot) == wakaba.Enums.Collectibles.POW_BLOCK
	or player:GetActiveItem(activeSlot) == wakaba.Enums.Collectibles.MOD_BLOCK
	then
		player:AddBombs(-2)
	end

	local tempNpcs = isc:getNPCs()
	local targetNpcs = {}
	for _, entity in ipairs(tempNpcs) do
		if usedItem == wakaba.Enums.Collectibles.POW_BLOCK and not entity:IsFlying() then
			table.insert(targetNpcs, entity)
		elseif usedItem == wakaba.Enums.Collectibles.MOD_BLOCK and entity:IsFlying() then
			table.insert(targetNpcs, entity)
		end
	end
	wakaba.G:ShakeScreen(10)
	local targetDamage = 320
	if usedItem == wakaba.Enums.Collectibles.POW_BLOCK then
		targetDamage = 275
		if #targetNpcs > 0 then
			targetDamage = targetDamage / targetNpcs
		end
	elseif usedItem == wakaba.Enums.Collectibles.MOD_BLOCK then
		targetDamage = 333
		if #targetNpcs > 0 then
			targetDamage = targetDamage / targetNpcs
		end
	end

	for _, entity in ipairs(targetNpcs) do
		entity:TakeDamage(targetDamage, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_CRUSH | DamageFlag.DAMAGE_IGNORE_ARMOR, player, 0)
	end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(usedItem, "HideItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_PowMod, wakaba.Enums.Collectibles.POW_BLOCK)
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_PowMod, wakaba.Enums.Collectibles.MOD_BLOCK)