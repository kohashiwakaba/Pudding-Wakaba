
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_MINE

if REPENTOGON then
	function wakaba:Challenge_PlayerUpdate_MineStuff_RGON(player)
		if wakaba.G.Challenge ~= c then return end
		if not player:CanShoot() then
			player:SetCanShoot(true)
		end
		player:EnableWeaponType(WeaponType.WEAPON_NOTCHED_AXE, true)
		for i = 1, 4 do
			local w = player:GetWeapon(i)
			if w and w:GetWeaponType() ~= WeaponType.WEAPON_NOTCHED_AXE then
				Isaac.DestroyWeapon(w)
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_MineStuff_RGON)
else
	function wakaba:Challenge_PlayerUpdate_MineStuff(player)
		if wakaba.G.Challenge ~= c then return end
		if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) ~= CollectibleType.COLLECTIBLE_NOTCHED_AXE then
			player:AddCollectible(CollectibleType.COLLECTIBLE_NOTCHED_AXE, 128, true, ActiveSlot.SLOT_PRIMARY, 0)
		end
		if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_NOTCHED_AXE then
			player:SetActiveCharge(128, ActiveSlot.SLOT_PRIMARY)
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_MineStuff)
end

function wakaba:Challenge_Cache_MineStuff(player, cacheFlag)
	if wakaba.G.Challenge == c then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 1.6
		end
		if cacheFlag == CacheFlag.CACHE_WEAPON then
			if REPENTOGON then
				player:EnableWeaponType(WeaponType.WEAPON_NOTCHED_AXE, true)
				local weapon = Isaac.CreateWeapon(WeaponType.WEAPON_NOTCHED_AXE, player)
				player:SetWeapon(weapon, 1)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Challenge_Cache_MineStuff)