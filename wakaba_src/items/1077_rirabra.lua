--[[ 
	Rira's Bra (리라의 브래지어) - 액티브 : 4칸
	사용 시 그 방에서 랜덤 눈물 효과(3달러 지폐와 동일), 상태이상에 걸린 적에게 추가 피해
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_RiraBra(usedItem, rng, player, useFlags, activeSlot, varData)

	wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_3_DOLLAR_BILL, -1, 1, "WAKABA_RIRAS_BRA")

	return {
		Discharge = true,
		Remove = false,
		ShowAnim = true,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RiraBra, wakaba.Enums.Collectibles.RIRAS_BRA)

function wakaba:HasStatusEffects(entity)
	if not entity then return false end
	local hasEffect = false
	for _, flag in ipairs(wakaba.Checks.VanillaStatusEffects) do
		hasEffect = hasEffect or entity:HasEntityFlags(flag)
		if hasEffect then 
			break 
		end
	end

	for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.EVALUATE_RIRA_BRA)) do
		local returnedFlag = callback.Function(callback.Mod, entity)
		if returnedFlag ~= nil and returnedFlag ~= false then
			hasEffect = true
		end
	end
	return hasEffect
end

function wakaba:RiraBra_FiendFolio(entity)
	local hasEffect = false
	local data = entity:GetData()
	if FiendFolio then
		--hasEffect = hasEffect or (data.hasFFStatusIcon ~= nil)
		hasEffect = hasEffect or (data.FFDoomCountdown ~= nil)
		hasEffect = hasEffect or (data.FFBerserkDuration ~= nil)
		hasEffect = hasEffect or (data.FFBruiseInstances ~= nil and #data.FFBruiseInstances > 0)
		hasEffect = hasEffect or (data.FFDoomDuration ~= nil and data.FFDoomDuration > 0)
		hasEffect = hasEffect or (data.FFDrowsyDuration ~= nil and data.FFDrowsyDuration > 0)
		hasEffect = hasEffect or (data.FFSleepDuration ~= nil and data.FFSleepDuration > 0)
		hasEffect = hasEffect or (data.FFBleedDuration ~= nil and data.FFBleedDuration > 0)
		hasEffect = hasEffect or (data.FFSewnDuration ~= nil and data.FFSewnDuration > 0)
		hasEffect = hasEffect or (data.FFMultiEuclideanDuration ~= nil and data.FFMultiEuclideanDuration > 0)
	end
	return hasEffect
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_RIRA_BRA, wakaba.RiraBra_FiendFolio)

function wakaba:RiraBra_Basic(entity)
	local data = entity:GetData()
	for index, statusData in pairs(data.wakaba_StatusEffectData) do
		return true
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_RIRA_BRA, wakaba.RiraBra_Basic)

function wakaba:RiraBraOnDamage(source, entity, data, newDamage, newFlags)
	local returndata = {}
	local num = 0
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		num = num + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.RIRAS_BRA)
	end
	local hasStopWatch = wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_STOP_WATCH)
	if num > 0 and (wakaba:HasStatusEffects(entity) or hasStopWatch) then
		if hasStopWatch then 
			num = num + 1 
		end
		returndata.newDamage = newDamage * (1 + (num * 0.2))
		returndata.sendNewDamage = true
		--returndata.newFlags = newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR | DamageFlag.DAMAGE_CLONES
	end
	return returndata
end