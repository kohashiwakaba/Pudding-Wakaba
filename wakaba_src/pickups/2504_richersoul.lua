local sfx = SFXManager()
local isc = _wakaba.isc

---@param player EntityPlayer
function wakaba:UseCard_SoulOfRicher(_, player, flags)
	wakaba.HiddenItemManager:AddForRoom(player, wakaba.Enums.Collectibles.WATER_FLAME, 1, 1, "WAKABA_SOUL_OF_RICHER")
	local count = wakaba.Enums.Constants.SOUL_OF_RICHER_WISP_COUNT
	if flags & UseFlag.USE_MIMIC > 0 then count = wakaba.Enums.Constants.SOUL_OF_RICHER_WISP_COUNT_CLEAR_RUNE end
	wakaba.__RicherSoul = true
	for i = 1, count do
		player:UseActiveItem(CollectibleType.COLLECTIBLE_LEMEGETON, UseFlag.USE_NOANIM)
	end
	wakaba.__RicherSoul = false
	sfx:Play(SoundEffect.SOUND_SOUL_PICKUP, 1, 0, false, 1)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_SoulOfRicher, wakaba.Enums.Cards.SOUL_RICHER)
--[[
---@param player EntityPlayer
function wakaba:UseCard_SoulOfRicher2(_, player, flags)
	local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, -1, false, false)
	local haswisp = false
	local wispcnt = 0
	for i, e in ipairs(wisps) do
		if e.SpawnerEntity.Index == player.Index then
			if wispcnt * 2 > multiplier * #wisps then break end
			haswisp = true
			e.HitPoints = e.MaxHitPoints
			if isHorse then
				e.HitPoints = e.MaxHitPoints * 3
			end
		end
	end
	local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
	for i, e in ipairs(wisps) do
		if e.SpawnerEntity.Index == player.Index then
			haswisp = true
			local item = e.SubType
			local config = Isaac.GetItemConfig():GetCollectible(item)
			if config and (config.Type == ItemType.ITEM_PASSIVE or config.Type == ItemType.ITEM_FAMILIAR) then
				e:Kill()
				player:AddCollectible(item)
				if isHorse then
					player:AddCollectible(item)
				end
			else
				e.HitPoints = e.MaxHitPoints
				if isHorse then
					e.HitPoints = e.MaxHitPoints * 3
				end
			end
		else
			e.HitPoints = e.MaxHitPoints
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_SoulOfRicher2, wakaba.Enums.Cards.SOUL_RICHER2)
 ]]