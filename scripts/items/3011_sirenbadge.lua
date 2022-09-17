function wakaba:PlayerCollision_SirenBadge(player, collider, low)
	if not player:HasTrinket(wakaba.Enums.Trinkets.SIREN_BADGE) then return end
	if player:GetDamageCooldown() > 0 then return end
	if collider:ToNPC() then 
		player:SetMinDamageCooldown(1)
		player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
		return true
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, wakaba.PlayerCollision_SirenBadge)
