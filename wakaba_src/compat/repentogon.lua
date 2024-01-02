wakaba.FamiliarPriority = {
	[wakaba.Enums.Familiars.LIL_WAKABA] = 8,
	[wakaba.Enums.Familiars.LIL_MOE] = FollowerPriority.DEFAULT,
	[wakaba.Enums.Familiars.LIL_SHIVA] = 8,
	[wakaba.Enums.Familiars.EASTER_EGG] = 9,
	[wakaba.Enums.Familiars.LIL_RICHER] = FollowerPriority.DEFENSIVE,
	[wakaba.Enums.Familiars.LIL_RIRA] = FollowerPriority.DEFENSIVE,
}


local function SyncRepentogonMarks(playerType)
	if not REPENTOGON or not playerType then return end

	print("[wakaba] Trying to register Repentogon completion marks for ", playerType)
	Isaac.SetCompletionMarks({
		PlayerType = playerType,
		MomsHeart = wakaba:GetUnlockValuesFromBoss(playerType, "Heart"),
		Isaac = wakaba:GetUnlockValuesFromBoss(playerType, "Isaac"),
		Satan = wakaba:GetUnlockValuesFromBoss(playerType, "Satan"),
		BossRush = wakaba:GetUnlockValuesFromBoss(playerType, "BossRush"),
		BlueBaby = wakaba:GetUnlockValuesFromBoss(playerType, "BlueBaby"),
		Lamb = wakaba:GetUnlockValuesFromBoss(playerType, "Lamb"),
		MegaSatan = wakaba:GetUnlockValuesFromBoss(playerType, "MegaSatan"),
		UltraGreed = wakaba:GetUnlockValuesFromBoss(playerType, "Greed"),
		Hush = wakaba:GetUnlockValuesFromBoss(playerType, "Hush"),
		Delirium = wakaba:GetUnlockValuesFromBoss(playerType, "Delirium"),
		Mother = wakaba:GetUnlockValuesFromBoss(playerType, "Mother"),
		Beast = wakaba:GetUnlockValuesFromBoss(playerType, "Beast"),
	})
end

function wakaba:Repentogon_SyncCompletionMarks()
	for _, playerType in pairs(wakaba.Enums.Players) do
		if wakaba:has_value(wakaba.PlayersToCheckMarks, playerType) then
			SyncRepentogonMarks(playerType)
		end
	end
end

wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GAME_EXIT, CallbackPriority.IMPORTANT, wakaba.Repentogon_SyncCompletionMarks)

function wakaba:Repentogon_GetPriority(familiar)
	if wakaba.FamiliarPriority[familiar.Variant] then
		return wakaba.FamiliarPriority[familiar.Variant]
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_FOLLOWER_PRIORITY, wakaba.Repentogon_GetPriority)


---comment
---@param player EntityPlayer
---@param limit int
---@param isKeeper boolean
function wakaba:Repentogon_HandleWakabaHealth(player, limit, isKeeper)
	if player:GetData().wakaba and player:GetData().wakaba.shioriangel then
		return math.max(24, limit)
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		return math.min(8, limit)
	else
		return math.min(6, limit)
	end
end
wakaba:RemoveCallback(ModCallbacks.MC_POST_UPDATE, wakaba.HandleWakabaHealth)
wakaba:AddCallback(ModCallbacks.MC_PLAYER_GET_HEART_LIMIT, wakaba.Repentogon_HandleWakabaHealth, wakaba.Enums.Players.WAKABA)

-- Negate Damage to Repentogon callbacks
wakaba:RemoveCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_TaintedWakabaBirthright)
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, wakaba.NegateDamage_TaintedWakabaBirthright)

wakaba:RemoveCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_BookOfShiori)
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, wakaba.NegateDamage_BookOfShiori)

wakaba:RemoveCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_Minerva)
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, wakaba.NegateDamage_Minerva)

wakaba:RemoveCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_SelfBurning)
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, wakaba.NegateDamage_SelfBurning)

