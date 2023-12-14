--[[
	Sakura Capsule (벛꽃 캡슐) - 패시브(Passive)
	리라로 Mother 처치
	사망 시 스테이지를 리셋 후 부활 (체력 4칸, 리셋한 스테이지에서는 비활성화, 리셋 후 스테이지를 한번 더 진행해야 부활 재활성화)
	부활하지 않은 다음 스테이지 진입 시 각 종류별 픽업 1개씩 생성
	(히든) 최초 획득 시 Gulp 알약 할당
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:NewLevel_SakuraCapsule()
	local room = wakaba.G:GetRoom()
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		local effects = player:GetEffects()
		if effects:GetCollectibleEffectNum(wakaba.Enums.Collectibles.SAKURA_CAPSULE) <= 1 then
			local power = player:GetCollectibleNum(wakaba.Enums.Collectibles.SAKURA_CAPSULE)
			for _ = 1, power do
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 0, room:FindFreePickupSpawnPosition(player.Position, 0), Vector.Zero, nil)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, room:FindFreePickupSpawnPosition(player.Position, 0), Vector.Zero, nil)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 0, room:FindFreePickupSpawnPosition(player.Position, 0), Vector.Zero, nil)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, room:FindFreePickupSpawnPosition(player.Position, 0), Vector.Zero, nil)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, 0, room:FindFreePickupSpawnPosition(player.Position, 0), Vector.Zero, nil)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 0, room:FindFreePickupSpawnPosition(player.Position, 0), Vector.Zero, nil)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, 0, room:FindFreePickupSpawnPosition(player.Position, 0), Vector.Zero, nil)
			end
		end
		effects:RemoveCollectibleEffect(wakaba.Enums.Collectibles.SAKURA_CAPSULE, 1)
	end)
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_SakuraCapsule)

---comment
---@param player EntityPlayer
---@param item CollectibleType
function wakaba:PostGetCollectible_SakuraCapsule(player, item)
	local pool = wakaba.G:GetItemPool()
	local hasGulp = false
	for i = 1, PillColor.NUM_STANDARD_PILLS - 1 do
		if pool:GetPillEffect(i) == PillEffect.PILLEFFECT_GULP then
			hasGulp = true
			pool:IdentifyPill(i)
			break
		end
	end
	if not hasGulp then
		local color = pool:ForceAddPillEffect(PillEffect.PILLEFFECT_GULP)
		pool:IdentifyPill(color)
	end
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_SakuraCapsule, wakaba.Enums.Collectibles.SAKURA_CAPSULE)