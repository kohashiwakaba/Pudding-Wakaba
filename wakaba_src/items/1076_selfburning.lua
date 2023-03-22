--[[ 
	Self Burning (셀프 버닝) - 액티브 : 스테이지 당 1회
	사용 시 탄횐을 제외한 모든 피격에 무적이 되며 접촉한 적에게 초당 1의 피해를 줌.
	탄환 피격 시 해제됨.
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")


function wakaba:ItemUse_SelfBurning(usedItem, rng, player, useFlags, activeSlot, varData)	
	return {
		Discharge = true,
		Remove = false,
		ShowAnim = true,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_SelfBurning, wakaba.Enums.Collectibles.SELF_BURNING)

function wakaba:NewLevel_RedCorruption()
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		for i = 0, 2 do
			if player:GetActiveItem(i) == wakaba.Enums.Collectibles.SELF_BURNING then
				player:SetActiveCharge(1 + (player:HasCollectible(CollectibleType.COLLECTIBLE_BATTERY and 1 or 0)), i)
			end
		end
	end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_RedCorruption)

function wakaba:PlayerCollision_SirenBadge(player, collider, low)
	if not player:GetEffects():GetCollectibleEffect(wakaba.Enums.Collectibles.SELF_BURNING) then return end
	if player:GetDamageCooldown() > 0 then return end
	if collider:ToProjectile() then
		player:GetEffects():RemoveCollectibleEffect(wakaba.Enums.Collectibles.SELF_BURNING)
	else
		player:SetMinDamageCooldown(1)
		player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
		return true
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, wakaba.PlayerCollision_SirenBadge)