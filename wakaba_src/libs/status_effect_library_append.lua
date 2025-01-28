local mod = wakaba
local game = wakaba.G
mod.StatusEffectBlacklist = {
	{EntityType.ENTITY_FIREPLACE},
	{EntityType.ENTITY_MOVABLE_TNT},
}

function mod:isStatusBlacklisted(entity)
	for _, dict in ipairs(wakaba.StatusEffectBlacklist) do
		if entity.Type == dict[1] then
			if not dict[2] or entity.Variant == dict[2] then
				if not dict[3] or entity.SubType == dict[3] then
					return true
				end
			end
		end
	end
end

---@param ent Entity
---@param statusEffect StatusFlag
---@param customData table
function wakaba:Status_PreAddEffect(ent, statusEffect, customData)
	return ent:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) or mod:isStatusBlacklisted(ent)
end

wakaba.Status.Callbacks.AddCallback(wakaba.Status.Callbacks.ID.PRE_ADD_ENTITY_STATUS_EFFECT, wakaba.Status_PreAddEffect)