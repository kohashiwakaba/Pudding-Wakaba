local isc = require("wakaba_src.libs.isaacscript-common")
local replacedPills = {}

function wakaba:ItemUse_Beetlejuice(item, rng, player, useFlags, activeSlot, varData)
	local isGolden = wakaba:IsGoldenItem(item)
	local game = wakaba.G
	local room = game:GetRoom()
	pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
	local failed = false 
  local discharge = true
	local pool = wakaba.G:GetItemPool()
	--local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.BEETLEJUICE)
	local count = 8
	if FiendFolio then count = 20 end
	for i = 1, count do
		local pillEffectCandidates = Isaac.GetItemConfig():GetPillEffects()
		local replacedPillEffect = -1
		while replacedPillEffect == -1 or replacedPills[replacedPillEffect] do
			replacedPillEffect = Isaac.GetItemConfig():GetPillEffect(rng:RandomInt(pillEffectCandidates.Size)).ID
		end
		local newPill = pool:ForceAddPillEffect(replacedPillEffect)
		pool:IdentifyPill(newPill)
		replacedPills[replacedPillEffect] = true
		if i == 1 then
			if isGolden then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, PillColor.PILL_GOLD | PillColor.PILL_GIANT_FLAG, room:FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, nil)
			else
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, newPill, room:FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, nil)
			end
		end
	end
	if not failed then
		SFXManager():Play(SoundEffect.SOUND_GOLDENBOMB)
	end
	if not failed and not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(item, "UseItem", "PlayerPickup")
	end
	replacedPills = {}
  return {Discharge = discharge}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Beetlejuice, wakaba.Enums.Collectibles.BEETLEJUICE)


function wakaba:RoomClearAwards_Beetlejuice(rng, spawnPosition)
	local border = 800
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.BEETLEJUICE) then
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.BEETLEJUICE)
			local randomnum = rng:RandomInt(4000)
			wakaba:GetPlayerEntityData(player)
			player:GetData().wakaba.beetlestack = player:GetData().wakaba.beetlestack or 0
			player:GetData().wakaba.beetlestack = player:GetData().wakaba.beetlestack + 800
			if randomnum <= border or player:GetData().wakaba.beetlestack >= 4000 then
				local pill = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, 0, Isaac.GetFreeNearPosition(spawnPosition, 40.0), Vector(0,0), nil):ToPickup()
				player:GetData().wakaba.beetlestack = 0
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClearAwards_Beetlejuice)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.RoomClearAwards_Beetlejuice)

function wakaba:PostGetCollectible_Beetlejuice(player, item)
	local game = wakaba.G
	local room = game:GetRoom()
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, 0, room:FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, nil)
	
	local pool = game:GetItemPool()
	for i = 1, 13 do
		if not pool:IsPillIdentified(i) then
			pool:IdentifyPill(i)
		end
	end
	if FiendFolio then
		for i = 1, #FiendFolio.FFPillColours do
				FiendFolio.savedata.run.IdentifiedRunPills = FiendFolio.savedata.run.IdentifiedRunPills or {}
				FiendFolio.savedata.run.IdentifiedRunPills[tostring(FiendFolio.FFPillColours[i])] = true
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_Beetlejuice, wakaba.Enums.Collectibles.BEETLEJUICE)