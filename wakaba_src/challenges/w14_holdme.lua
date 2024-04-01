
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_HOLD

function wakaba:Challenge_PlayerUpdate_HoldMe(player)
	if wakaba.G.Challenge ~= c then return end
	wakaba.HiddenItemManager:CheckStack(player, wakaba.Enums.Collectibles.LIL_MAO, 1, "WAKABA_CHALLENGES")
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_HoldMe)

function wakaba:Challenge_PreReroll_HoldMe(itemPoolType, decrease, seed)
	if wakaba.G.Challenge == c then
		return wakaba.Enums.Collectibles.CLOVER_SHARD
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, -18000, wakaba.Challenge_PreReroll_HoldMe)

function wakaba:UseItem_Challenge_Recall(_, rng, player, flags, slot, vardata)
	if wakaba.G.Challenge == c then
		if player:IsHoldingItem() then
			return {Discharge = false}
		end
		local maos = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.CUBE_BABY, wakaba.SUBTYPE_LIL_MAO)
		for i, f in ipairs(maos) do
			local mao = f:ToFamiliar()
			if mao and mao.Player then
				mao:GetData().wakaba.recall = 0
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_Challenge_Recall, CollectibleType.COLLECTIBLE_RECALL)