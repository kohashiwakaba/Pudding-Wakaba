--[[ 
	Broken Toolbox (망가진 잡동사니 상자) - 패시브
	1초마다 픽업 드랍, 방 안에 픽업이 15개 이상 있으면 모든 픽업이 증발 및 폭발
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

---@param entity Entity
---@param isRira boolean
local function ToolboxExplode(entity, isRira)
	local flag = DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_IGNORE_ARMOR
	Game():BombExplosionEffects(entity.Position, 100, TearFlags.TEAR_NORMAL, Color.Default, entity, 1, true, isRira, flag)
end

function wakaba:Update_BrokenToolbox()
	local room = wakaba.G:GetRoom()
	local count = isc:getTotalPlayerCollectibles(wakaba.Enums.Collectibles.BROKEN_TOOLBOX)
	if not room:IsClear() and count > 0 and room:GetFrameCount() > 0 and room:GetFrameCount() % 30 == 0 then
		local threshold = count * 15
		local pickups = isc:getEntities(EntityType.ENTITY_PICKUP)
		local pickupCount = #pickups
		if pickupCount >= threshold then
			-- Damage for Tainted Rira / 알트 리라의 경우 폭발 시 자해 패널티 추가, 이외 캐릭터의 경우 픽업 폭발에 면역
			local players = isc:getPlayersWithCollectible(wakaba.Enums.Collectibles.BROKEN_TOOLBOX)
			for _, player in ipairs(players) do
				player:SetMinDamageCooldown(2)
				ToolboxExplode(player, false)
			end
			--[[ local riraPlayers = isc:getPlayersOfType()
			for _, player in ipairs(riraPlayers) do
				ToolboxExplode(player, true)
			end ]]
			for _, pickup in ipairs(pickups) do
				if pickup.Variant ~= PickupVariant.PICKUP_BIGCHEST 
				and pickup.Variant ~= PickupVariant.PICKUP_TROPHY then
					ToolboxExplode(pickup, false)
					pickup:Remove()
				end
			end
		else
			local players = isc:getPlayersWithCollectible(wakaba.Enums.Collectibles.BROKEN_TOOLBOX)
			for _, player in ipairs(players) do
				Isaac.Spawn(EntityType.ENTITY_PICKUP, 0, isc.PickupNullSubType.EXCLUDE_COLLECTIBLES, player.Position, Vector.Zero, player)
			end
			--[[ local riraPlayers = isc:getPlayersOfType()
			for _, player in ipairs(riraPlayers) do
				Isaac.Spawn(EntityType.ENTITY_PICKUP, 0, isc.PickupNullSubType.EXCLUDE_COLLECTIBLES, player.Position, Vector.Zero, player)
			end ]]
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_BrokenToolbox)


function wakaba:Update_BrokenToolbox()
	local count = isc:getTotalPlayerCollectibles(wakaba.Enums.Collectibles.BROKEN_TOOLBOX)
	if count > 0 then
		for _, pickup in ipairs(pickups) do
			if pickup.Variant ~= PickupVariant.PICKUP_BIGCHEST 
			and pickup.Variant ~= PickupVariant.PICKUP_TROPHY then
				ToolboxExplode(pickup, false)
				pickup:Remove()
			end
		end
		local players = isc:getPlayersWithCollectible(wakaba.Enums.Collectibles.BROKEN_TOOLBOX)
		for _, player in ipairs(players) do
			player:SetMinDamageCooldown(2)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_BrokenToolbox)