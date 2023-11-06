
local isc = require("wakaba_src.libs.isaacscript-common")

wakaba.ExecutionerBlacklistEntities = {
	{EntityType.ENTITY_DOGMA},
	{EntityType.ENTITY_VISAGE},
	{EntityType.ENTITY_MOTHER},
	{EntityType.ENTITY_MOMS_HEART},
}

local function isExecutionerBlacklisted(entity)
	for _, dict in ipairs(wakaba.ExecutionerBlacklistEntities) do
		if entity.Type == dict[1] then
			if not dict[2] or entity.Variant == dict[2] then
				if not dict[3] or entity.SubType == dict[3] then
					return true
				end
			end
		end
	end
end

---@param player EntityPlayer
local function shouldApplyExecute(player)
	local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.EXECUTIONER)
	local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.EXECUTIONER)
	local charmBonus = wakaba:getTeardropCharmBonus(player) + (player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.EXECUTIONER))

	local basicChance = 0.0075
	local parLuck = 117
	local maxChance = 0.1 - basicChance

	local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck + charmBonus, parLuck, maxChance), count)
	return count > 0 and rng:RandomFloat() < chance
end

local function shouldApplySwordExecute(player)
	return player and player.Type == EntityType.ENTITY_PLAYER and player:HasCollectible(wakaba.Enums.Collectibles.EXECUTIONER) and shouldApplyExecute(player)
end

local function tryEraseEnemy(effectTarget, isBoss)
	if isExecutionerBlacklisted(effectTarget) then return end
	if isBoss then
		local wisp = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.ERASER, 0, effectTarget.Position, Vector.Zero, Isaac.GetPlayer())
		wisp.Visible = false
		wisp.CollisionDamage = 1000
		wakaba:scheduleForUpdate(function()
			wisp:Remove()
		end, 2)
	else
		local wisp = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, CollectibleType.COLLECTIBLE_ERASER, effectTarget.Position, Vector.Zero, Isaac.GetPlayer())
		wisp.Visible = false
		wakaba:scheduleForUpdate(function()
			wisp:Remove()
		end, 2)
	end
end

function wakaba:EvalTearFlag_Executioner(weapon, player, effectTarget)
	if player:HasCollectible(wakaba.Enums.Collectibles.EXECUTIONER) then
		if shouldApplyExecute(player) then
			if weapon then
				wakaba:AddRicherTearFlags(weapon, wakaba.TearFlag.EXECUTE)
			elseif not effectTarget:IsBoss() then
				tryEraseEnemy(effectTarget, true)
			end
		elseif weapon and wakaba:IsLudoTear(weapon, true) then
			wakaba:ClearRicherTearFlags(weapon, wakaba.TearFlag.EXECUTE)
		end
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_WAKABA_TEARFLAG, wakaba.EvalTearFlag_Executioner)

wakaba:AddCallback(wakaba.Callback.APPLY_TEARFLAG_EFFECT, function(_, effectTarget, player, effectSource)
	if effectTarget:IsBoss() then

	else
		tryEraseEnemy(effectTarget, true)
	end
end, wakaba.TearFlag.EXECUTE)


function wakaba:TakeDmg_Executioner(entity, amount, flag, source, countdownFrames)
	if isExecutionerBlacklisted(entity) then return end
	if (entity:IsBoss() and wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.EXECUTIONER))
	or (source.Entity and wakaba:HasRicherTearFlags(source.Entity, wakaba.TearFlag.EXECUTE))
	or (source.Entity and source.Type == EntityType.ENTITY_PLAYER and shouldApplySwordExecute(source.Entity:ToPlayer())) -- Spirit Sword
	then
		if source.Type == EntityType.ENTITY_TEAR and source.Variant == TearVariant.ERASER then
			
		elseif entity:IsBoss() and entity.HitPoints <= amount then
			entity.HitPoints = amount + 10
			tryEraseEnemy(entity, true)
			--return false
		elseif not entity:IsBoss() then
			tryEraseEnemy(entity, true)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_Executioner)