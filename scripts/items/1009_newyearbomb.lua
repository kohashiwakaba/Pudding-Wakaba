wakaba.COLLECTIBLE_NEW_YEAR_BOMB = Isaac.GetItemIdByName("New Year's Eve Bomb")


function wakaba:NewRoom_NewYearBomb()
	if Game():GetRoom():IsFirstVisit() then
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if player:GetPlayerType() == PlayerType.PLAYER_BLUEBABY_B and player:HasCollectible(wakaba.COLLECTIBLE_NEW_YEAR_BOMB) then
				player:AddPoopMana(2)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_NewYearBomb)

function wakaba:newYearBombDamage(target, damage, flags, source, cooldown)
	if source.Entity ~= nil and (flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION) and target.Type ~= EntityType.ENTITY_PLAYER then
		if source.Entity.SpawnerEntity ~= nil then
			local player = source.Entity.SpawnerEntity:ToPlayer()
			--print(player:HasCollectible(wakaba.COLLECTIBLE_NEW_YEAR_BOMB))
			if player ~= nil and player:HasCollectible(wakaba.COLLECTIBLE_NEW_YEAR_BOMB) then
				if not Game():HasHallucination() then
					Game():ShowHallucination(30)
				end
				target.HitPoints = 1
				return false
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.newYearBombDamage)

