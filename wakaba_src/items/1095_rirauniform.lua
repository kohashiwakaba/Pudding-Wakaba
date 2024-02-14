--[[
	Rira's Uniform (리라의 제복) - 패시브(Passive)
	- 모든 피격에 대한 패널티 방어
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

---@param item CollectibleType
---@param rng RNG
---@param player EntityPlayer
---@param useFlags UseFlag
---@param activeSlot ActiveSlot
---@param varData integer
function wakaba:ItemUse_RiraUniform(item, rng, player, useFlags, activeSlot, varData)
	local discharge = true
	local remove = false
	local useAnim = false

	if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_ASTRAL_PROJECTION) then
		discharge = false
		goto skipRiraUniform
	end

	local clearFlag = false

	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	local currentRoomDesc = level:GetRoomByIdx(level:GetCurrentRoomIndex())
	if room:IsClear() then
		clearFlag = true
		if not currentRoomDesc.NoReward then
			currentRoomDesc.NoReward = true
		end
		room:SetClear(false)
	end

	wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_ASTRAL_PROJECTION, 150, 1, "WAKABA_RIRA_UNIFORM")
	player:TakeDamage(1, DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_FAKE, EntityRef(player), 60)
	player:TakeDamage(1, DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_FAKE, EntityRef(player), 60)
	wakaba:scheduleForUpdate(function()
		local effects = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, 10)
		for _, e in ipairs(effects) do
			if e.Position:DistanceSquared(player.Position) <= 60 ^ 2 then
				wakaba.Log("Forgotten Soul form Rira Uniform found, removing...")
				e:Remove()
			end
		end
		local effects2 = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.HAEMO_TRAIL)
		for _, e in ipairs(effects2) do
			if e.Position:DistanceSquared(player.Position) <= 60 ^ 2 then
				wakaba.Log("Haemo trail form Rira Uniform found, removing...")
				e:Remove()
			end
		end
		if clearFlag then
			currentRoomDesc.NoReward = false
		end
	end, 1)
	wakaba:scheduleForUpdate(function()
		player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_ASTRAL_PROJECTION, 2)
	end, 150)
	::skipRiraUniform::

	return {
		Discharge = discharge,
		Remove = remove,
		ShowAnim = showAnim,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RiraUniform, wakaba.Enums.Collectibles.RIRAS_UNIFORM)