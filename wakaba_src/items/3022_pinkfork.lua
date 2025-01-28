--[[
	Pink Fork (핑크 포크) - 장신구
	1칸 이상의 피해를 받으면 피해량의 절반만큼의 소울하트 회복
 ]]

local isc = _wakaba.isc

if REPENTOGON then
	---@param entity Entity
	---@param damage number
	---@param flags DamageFlag
	---@param source EntityRef
	---@param countdown integer
	function wakaba:PostTakeDamage_PinkFork(entity, damage, flags, source, countdown)
		local player = entity:ToPlayer()
		if not (player and player:HasTrinket(wakaba.Enums.Trinkets.PINK_FORK)) then return end
		if damage < 2 then return end
		local conv = damage // 2
		local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 4, Vector(player.Position.X, player.Position.Y - 95), Vector.Zero, nil):ToEffect()
		player:AddSoulHearts(conv)
	end
	--wakaba:AddCallback(ModCallbacks.MC_POST_ENTITY_TAKE_DMG, wakaba.PostTakeDamage_PinkFork)

	---@param player EntityPlayer
	---@param amount integer
	---@param healthType AddHealthType
	function wakaba:PreAddHealth_PinkFork(player, amount, healthType, _)
		if player:HasTrinket(wakaba.Enums.Trinkets.PINK_FORK) and amount >= 2 then
			local count = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.PINK_FORK)
			wakaba:addCustomStat(player, "damage", 0.2 * count)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
			return amount - 1
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_ADD_HEARTS, wakaba.PreAddHealth_PinkFork, AddHealthType.SOUL)
	wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_ADD_HEARTS, wakaba.PreAddHealth_PinkFork, AddHealthType.BLACK)
end