--[[
	Chewy Rolly Cake (츄잉 롤케이크) - 패시브(Passive)
	피격 시, 혹은 홀실 제거 시 그 방의 적 속도 감소, 캐릭터 이동속도 +0.3, 캐릭터 주변의 탄환 제거
 ]]
local isc = _wakaba.isc

---@param player EntityPlayer
---@param cacheFlag CacheFlag
function wakaba:Cache_ChewyRollyCake(player, cacheFlag)
	if player:GetPlayerType() == PlayerType.PLAYER_THELOST or player:GetPlayerType() == PlayerType.PLAYER_THELOST_B then
		if player:HasCollectible(wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE) then
			if cacheFlag == CacheFlag.CACHE_SPEED then
				player.MoveSpeed = player.MoveSpeed + (0.3 * player:GetCollectibleNum(wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE))
			end
		end
	elseif player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE) then
		if cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + 0.2 + (0.1 * player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE ,wakaba.Cache_ChewyRollyCake)

---@param player EntityPlayer
function wakaba:PostTakeDamage_ChewyRollyCake(player, amount, flags, source, cooldown)
	if player:HasCollectible(wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE) then
		player:UseActiveItem(wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE, UseFlag.USE_NOANIM)
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_ChewyRollyCake)


---@param player EntityPlayer
---@param useFlags UseFlag
function wakaba:UseItem_ChewyRollyCake(_, rng, player, useFlags, activeSlot, varData)
	local room = wakaba.G:GetRoom()
	room:SetBrokenWatchState(1)
	for i = 1, 5 do
		wakaba:scheduleForUpdate(function ()
			local entities = Isaac.FindInRadius(player.Position, 40 * i, EntityPartition.BULLET)
			for _, entity in ipairs(entities) do
				entity:Die()
			end
		end, 3 * i)
	end
	return {
		ShowAnim = useFlags & UseFlag.USE_NOANIM == 0,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_ChewyRollyCake, wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE)