--[[
  Retribtion status effect utilities from Xalum
 ]]

local mod = wakaba
local game = wakaba.G

local defaultMetadata = {
	CanStack = false,
}

mod.StatusEffect = {}
mod.StatusMetadata = {}

local function GetRegisteredNumStatusEffects()
	local count = 0
	local effects = mod.StatusEffect
	for name, index in pairs(effects) do
		count = count + 1
	end
	return count
end

function mod:RegisterStatusEffect(statusName, spriteObject, metadata)
	local index = GetRegisteredNumStatusEffects() + 1
	mod.StatusEffect[statusName] = index
	mod.StatusMetadata[index] = metadata or defaultMetadata

	spriteObject:SetLastFrame()
	mod.StatusMetadata[index].Sprite = spriteObject
	mod.StatusMetadata[index].AnimationName = spriteObject:GetAnimation()
	mod.StatusMetadata[index].AnimationLength = spriteObject:GetFrame() + 1
	return index
end

function mod:CanApplyStatusEffect(npcTarget)
	local data = npcTarget:GetData()
	return (
		npcTarget and
		npcTarget:IsVulnerableEnemy() and
		not npcTarget:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) and
		not npcTarget:HasEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS) and
		not data.wakaba_StatusCooldown
	)
end

function mod:AddStatusCooldown(npcTarget, duration, force)
	local data = npcTarget:GetData()
	if not force and data.wakaba_StatusCooldown then return end
	duration = duration or (8 * 15)
	data.wakaba_StatusCooldown = npcTarget.FrameCount + duration
end

function mod:AddStatusEffect(npcTarget, statusType, duration, player)
	local data = npcTarget:GetData()
	local secondHandMultiplier = mod:GetGlobalTrinketMultiplier(TrinketType.TRINKET_SECOND_HAND)

	data.wakaba_StatusEffectData = data.wakaba_StatusEffectData or {}
	data.wakaba_StatusEffectData[statusType] = data.wakaba_StatusEffectData[statusType] or {}

	if mod.StatusMetadata[statusType].CanStack then -- Not gonna be done until Retribution needs one like this

	else
		local currentExpirey = data.wakaba_StatusEffectData[statusType].ExpireyFrame
		data.wakaba_StatusEffectData[statusType].ExpireyFrame = math.max(currentExpirey or npcTarget.FrameCount, npcTarget.FrameCount + (duration * (1 + secondHandMultiplier)))
		if player then
			data.wakaba_StatusEffectData[statusType].Player = player
		end
	end
end

function mod:HasStatusEffect(npcTarget, statusType)
	local data = npcTarget:GetData()

	if statusType then
		return (
			data.wakaba_StatusEffectData and
			data.wakaba_StatusEffectData[statusType]
		)
	else
		return (
			data.wakaba_StatusEffectData and
			#data.wakaba_StatusEffectData > 0
		)
	end
end

local function shouldRenderStatusSymbol(npcTarget)
	local renderMode = game:GetRoom():GetRenderMode()
	return mod:HasStatusEffect(npcTarget) and (
		renderMode == RenderMode.RENDER_NORMAL or
		renderMode == RenderMode.REDNER_ABOVE_WATER
	)
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, function(_, npc)
	local data = npc:GetData()
	if data.wakaba_StatusCooldown and data.wakaba_StatusCooldown <= npc.FrameCount then
		data.wakaba_StatusCooldown = nil
	end
end)

mod:AddCallback(ModCallbacks.MC_POST_NPC_RENDER, function(_, npc)
	if not shouldRenderStatusSymbol(npc) then return end

	local data = npc:GetData()
	local numStatuses = #data.wakaba_StatusEffectData
	local initialRenderPosition = Isaac.WorldToScreen(npc.Position) + npc.SpriteOffset + Vector(0, -32)
	local multiStatusOffset = Vector(-8, 0) * math.max(0, numStatuses - 1)

	for index, statusData in pairs(data.wakaba_StatusEffectData) do
		local metadata = mod.StatusMetadata[index]
		local renderPosition = initialRenderPosition + multiStatusOffset + Vector(16, 0) * (index - 1)
		local colourIntensity = 1

		if metadata.EntityColor then
			npc.Color = metadata.EntityColor
		end

		if metadata.CanStack then -- Not gonna be done until Retribution needs one like this

		else
			local expireDelta = statusData.ExpireyFrame - npc.FrameCount
			if expireDelta < 10 and expireDelta % 2 == 0 then
				colourIntensity = 0
			end

			local animName = metadata.AnimationName or "Idle"

			metadata.Sprite:SetFrame(animName, npc.FrameCount % metadata.AnimationLength)
			metadata.Sprite.Color = Color(1, 1, 1, colourIntensity)
			metadata.Sprite:Render(renderPosition)

			if statusData.ExpireyFrame <= npc.FrameCount then
				npc.Color = Color(1, 1, 1, 1)
				data.wakaba_StatusEffectData[index] = nil
			end
		end
	end
end)