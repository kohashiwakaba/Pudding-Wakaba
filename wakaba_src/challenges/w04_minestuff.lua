
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_MINE

if true then -- TODO change to not REPENTOGON if finished
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
else
	-- change main weapon as knotched axe
end

function wakaba:Challenge_Cache_MineStuff(player, cacheFlag)
	if wakaba.G.Challenge == c then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 1.6
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Challenge_Cache_MineStuff)