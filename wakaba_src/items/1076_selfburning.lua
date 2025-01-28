--[[
	Self Burning (셀프 버닝) - 액티브 : 스테이지 당 1회
	사용 시 탄횐을 제외한 모든 피격에 무적이 되며 접촉한 적에게 초당 1의 피해를 줌.
	탄환 피격 시 해제됨.
 ]]

local isc = _wakaba.isc

---@param player EntityPlayer
function wakaba:PlayerUpdate_SelfBurning(player)
	local wData = wakaba:GetPlayerEntityData(player)
	if wakaba:getPlayerDataEntry(player ,"selfburningcount", 0) > 0 or player:GetEffects():GetCollectibleEffect(wakaba.Enums.Collectibles.SELF_BURNING) then
		if not player:HasEntityFlags(EntityFlag.FLAG_BURN) then
			player:AddEntityFlags(EntityFlag.FLAG_BURN)
		end
		if player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.SELF_BURNING) > 25 then
			player:GetEffects():RemoveCollectibleEffect(wakaba.Enums.Collectibles.SELF_BURNING, -1)
			for i = 1, 2 do
				player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.SELF_BURNING)
			end
		end
		wakaba:addPlayerDataCounter(player, "selfburningtimer", -1)
		if wakaba:getPlayerDataEntry(player ,"selfburningtimer", 0) < 0 then
			if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:GetSoulCharge() > 0 then
				player:AddSoulCharge(-1)
			elseif player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B and player:GetBloodCharge() > 0 then
				player:AddBloodCharge(-1)
			elseif player:GetPlayerType() == PlayerType.PLAYER_BLUEBABY_B and player:GetPoopMana() > 0 then
				player:AddPoopMana(-1)
			elseif (player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B) and player:GetNumKeys() > 0 then
				player:AddKeys(-1)
			else
				local totalHearts = player:GetHearts() + player:GetSoulHearts() - player:GetRottenHearts()
				if totalHearts > 1 then
					if player:GetSoulHearts() > 0 then
						player:AddSoulHearts(-1)
					elseif player:GetHearts() - player:GetRottenHearts() > 0 then
						player:AddHearts(-1)
					end
				end
			end
			wakaba:setPlayerDataEntry(player, "selfburningtimer", wakaba.Enums.Constants.SELF_BURNING_DAMAGE_TIMER)
		end
	else
		if player:HasEntityFlags(EntityFlag.FLAG_BURN) then
			player:ClearEntityFlags(EntityFlag.FLAG_BURN)
		end
		wakaba:removePlayerDataEntry(player, "selfburningcount")
		wakaba:removePlayerDataEntry(player, "selfburningtimer")
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_SelfBurning)

---@param player EntityPlayer
function wakaba:ItemUse_SelfBurning(usedItem, rng, player, useFlags, activeSlot, varData)
	local hasItem = activeSlot == ActiveSlot.SLOT_POCKET2
	for i = 0, 2 do
		if player:GetActiveItem(i) == wakaba.Enums.Collectibles.SELF_BURNING then
			hasItem = true
		end
	end
	if not hasItem and useFlags & UseFlag.USE_VOID == 0 then return end
	if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.SELF_BURNING) then return end
	wakaba:addPlayerDataCounter(player, "selfburningcount", 1)
	wakaba:initPlayerDataEntry(player, "selfburningtimer", wakaba.Enums.Constants.SELF_BURNING_DAMAGE_TIMER)
	return {
		Discharge = true,
		Remove = false,
		ShowAnim = true,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_SelfBurning, wakaba.Enums.Collectibles.SELF_BURNING)

function wakaba:NewLevel_SelfBurning()
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		for i = 0, 2 do
			if player:GetActiveItem(i) == wakaba.Enums.Collectibles.SELF_BURNING then
				player:SetActiveCharge(1 + (player:HasCollectible(CollectibleType.COLLECTIBLE_BATTERY) and 1 or 0), i)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_SelfBurning)

---comment
---@param player EntityPlayer
function wakaba:PlayerCollision_SelfBurning(player, collider, low)
	if wakaba:getPlayerDataEntry(player ,"selfburningcount", 0) <= 0 and not player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.SELF_BURNING) then return end
	if player:GetDamageCooldown() > 0 then return end
	if collider:ToProjectile() then
		player:SetMinDamageCooldown(30)
		if wakaba:getPlayerDataEntry(player ,"selfburningcount", 0) > 0 then
			wakaba:addPlayerDataCounter(player, "selfburningcount", -1)
		else
			player:GetEffects():RemoveCollectibleEffect(wakaba.Enums.Collectibles.SELF_BURNING, -1)
		end
	elseif collider:ToNPC() then
		collider:TakeDamage(1, DamageFlag.DAMAGE_FIRE | DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(player), 3)
		player:SetMinDamageCooldown(1)
		player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
		return false
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, wakaba.PlayerCollision_SelfBurning)

function wakaba:NegateDamage_SelfBurning(player, amount, flag, source, countdownFrames)
	if wakaba:getPlayerDataEntry(player ,"selfburningcount", 0) > 0 or player:GetEffects():GetCollectibleEffect(wakaba.Enums.Collectibles.SELF_BURNING) then
		return false
	end
end
--wakaba:AddCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_SelfBurning)