wakaba.CustomHurtSound = {
	[wakaba.Enums.Players.RICHER] = wakaba.Enums.SoundEffects.RICHER_HURT,
	[wakaba.Enums.Players.RICHER_B] = wakaba.Enums.SoundEffects.RICHER_HURT,
}
wakaba.CustomDeathSound = {
	[wakaba.Enums.Players.RICHER] = wakaba.Enums.SoundEffects.RICHER_DEATH,
	[wakaba.Enums.Players.RICHER_B] = wakaba.Enums.SoundEffects.RICHER_DEATH,
}

local hurtReplace = {
	SoundEffect.SOUND_ISAAC_HURT_GRUNT,
}
local deathReplace = {
	SoundEffect.SOUND_ISAACDIES,
}
local sfx = SFXManager()

local checkType = PlayerType.PLAYER_ISAAC

function wakaba:TakeDamage_CustomSound(player)
	checkType = player:ToPlayer():GetPlayerType()
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_CustomSound, EntityType.ENTITY_PLAYER)

function wakaba:TakeDamage_CustomSound_LostSoul(soul)
	if soul.Variant == FamiliarVariant.LOST_SOUL then
		checkType = PlayerType.PLAYER_ISAAC
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_CustomSound, EntityType.ENTITY_FAMILIAR)

---@param collectibleType CollectibleType
---@param rng RNG
---@return SoundEffect
function wakaba:getCustomHurtSound(collectibleType, rng)
	local sound = wakaba.CustomHurtSound[collectibleType]
	if type(sound) == "table" and #sound > 0 then
		rng = rng or player:GetCollectibleRNG(wakaba.Enums.Collectibles.EASTER_EGG)
		local target = sound[rng:RandomInt(#sound) + 1]
	end
	return sound
end

---@param collectibleType CollectibleType
---@param rng RNG
---@return SoundEffect
function wakaba:getCustomDeathSound(collectibleType, rng)
	local sound = wakaba.CustomDeathSound[collectibleType]
	if type(sound) == "table" and #sound > 0 then
		rng = rng or player:GetCollectibleRNG(wakaba.Enums.Collectibles.EASTER_EGG)
		local target = sound[rng:RandomInt(#sound) + 1]
	end
	return sound
end

---@param player EntityPlayer
function wakaba:PlayerRender_CustomItemSound(player)
	if not player:IsItemQueueEmpty() and checkForCustomSound then
		local queue = player.QueuedItem.Item
		if queue:IsCollectible() and wakaba.CustomItemSound[queue.ID] then
			for _, sound in ipairs(soundToReplace) do
				if sfx:IsPlaying(sound) then
					sfx:Stop(sound)
					sfx:Play(wakaba:getCustomSound(queue.ID))
					break
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.PlayerRender_CustomItemSound)

function wakaba:Update_CustomItemSound()
	local hitSound = wakaba:getCustomHurtSound(checkType)
	local deathSound = wakaba:getCustomDeathSound(checkType)
	if hitSound or deathSound then
		if hitSound and sfx:IsPlaying(SoundEffect.SOUND_ISAAC_HURT_GRUNT) then
			sfx:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
			sfx:Play(hitSound)
		end
		if deathSound then
			wakaba:scheduleForUpdate(function ()
				if sfx:IsPlaying(SoundEffect.SOUND_ISAACDIES) then
					sfx:Stop(SoundEffect.SOUND_ISAACDIES)
					sfx:Play(deathSound)
				end
			end, 16)
		end
	end
	checkType = PlayerType.PLAYER_ISAAC
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Update_CustomItemSound)