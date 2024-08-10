--[[
	Cursed Trinkets (저주받은 장신구) - 장신구(Trinket)
	Retribution, TMTRAINER 전용
-- corrupted clover (방 입장 시 캐릭터 4방향으로 빛줄기)
-- dark pendant (최종 행운 마이너스)
-- broken necklace (적 눈물이 도그마화)
-- leaf needle (액티브 사용 시 헌혈 피해 반칸)
-- richer's hair (방 입장 시 캐릭터 바로 옆칸에 보라색 불)
-- rira's hair (방 입장 시 캐릭터 바로 옆칸에 흰 불)
-- spy eye (방 입장 시 공격키를 누르고 있으면 헌혈 피해)
-- faded mark (스나이퍼 저주)
-- neverlasting bunny (망각의 저주)
-- ribbon cage (요정의 저주)
-- rira's worst nightmare (Host를 Mobile Host로 변경)
-- masked shovel (피격 시 트랩도어 생성)
-- broken watch 2 (주기적으로 Broken Watch 상태 변경)
-- round and round (방 입장 시 방 중앙에 Stone Eye 생성)
-- gehenna rock (모든 poky류 장애물이 grudge로 변경)
-- broken murasame (획득 시 악마방/천사방 확률 0%)
-- lunatic crystal (소지 중인 신성한 보호막 모두 제거)
-- torn paper 2 (모든 트롤 폭탄이 슈퍼 황금 트롤폭탄으로 변경)
-- mini torizo (탄환이 캐릭터의 무적을 무시, 캐릭터에게 탄환이 닿아도 사라지지 않음)
-- grenade d20 (픽업이 때때로 폭발)
-- wakaba siren (상시 지진 효과, 이펙트만)
]]

local isc = require("wakaba_src.libs.isaacscript-common")

do -- Corrupted Clover
	function wakaba:Cursed_NewRoom_CorruptedClover()
		if wakaba.G:GetRoom():IsFirstVisit() then
			for num = 1, wakaba.G:GetNumPlayers() do
				local player = wakaba.G:GetPlayer(num - 1)
				if player:HasTrinket(wakaba.Enums.Trinkets.CORRUPTED_CLOVER) then
					for i = 0, 3 do
						local addPos = Vector.FromAngle(i * 90) * 48
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, player.Position + addPos, Vector.Zero, nil)
					end
				end
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.Cursed_NewRoom_CorruptedClover)
end

do -- Dark Pendant
	---@param player EntityPlayer
	---@param cacheFlag CacheFlag
	function wakaba:Cursed_Cache_DarkPendant(player, cacheFlag)
		if cacheFlag == CacheFlag.CACHE_LUCK then
			local num = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.DARK_PENDANT)
			player.Luck = player.Luck - num
		end
	end
	wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 0, wakaba.Cursed_Cache_DarkPendant)
end

do -- Broken Necklace
	---@param tear EntityProjectile
	function wakaba:Cursed_ProjectileUpdate_BrokenNecklace(tear)
		if wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.BROKEN_NECKLACE) then
			if not tear:HasProjectileFlags(ProjectileFlags.LASER_SHOT) then
				tear:AddProjectileFlags(ProjectileFlags.LASER_SHOT)
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, wakaba.Cursed_ProjectileUpdate_BrokenNecklace)
end

do -- Leaf Needle
	---@param player EntityPlayer
	function wakaba:Cursed_UseItem_LeafNeedle(_, rng, player, flags, slot, vardata)
		if player:HasTrinket(wakaba.Enums.Trinkets.LEAF_NEEDLE) then
			local num = player:GetTrinketMultiplier(wakaba.Enums.Trinkets.LEAF_NEEDLE)
			if flags & UseFlag.USE_OWNED > 0 or num > 1 then
				player:TakeDamage(1, DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 30)
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.Cursed_UseItem_LeafNeedle)
end

do -- Richer's Hair, Rira's Hair
	function wakaba:Cursed_NewRoom_RicherRiraHair()
		local room = wakaba.G:GetRoom()
		if not room:IsFirstVisit() then return end
		local hasRicherHair = false
		local hasRiraHair = false
		for num = 1, wakaba.G:GetNumPlayers() do
			local player = wakaba.G:GetPlayer(num - 1)
			if player:HasTrinket(wakaba.Enums.Trinkets.RICHERS_HAIR) then
				hasRicherHair = true
			end
			if player:HasTrinket(wakaba.Enums.Trinkets.RIRAS_HAIR) then
				hasRiraHair = true
			end
		end
		if not (hasRicherHair or hasRiraHair) then return end
		local entrySlot
		local distance = 9e9
		local player = Isaac.GetPlayer()

		for i = 0, 7 do
			local door = room:GetDoor(i)
			if door and door.Position:Distance(player.Position) < distance then
				distance = door.Position:Distance(player.Position)
				entrySlot = i
			end
		end

		local directionOffset = Vector.FromAngle(90 * entrySlot) * 80
		local tilePosition = wakaba:GridAlignPosition(room:GetDoor(entrySlot).Position + directionOffset)
		local gridIndex = room:GetGridIndex(tilePosition)

		if room:GetGridEntity(gridIndex) ~= nil then
			room:RemoveGridEntity(gridIndex, 0, false)
		end
		if hasRiraHair then
			Isaac.Spawn(33, 4, 0, tilePosition, Vector.Zero, nil)
		end
		if hasRicherHair then
			Isaac.Spawn(33, 3, 0, tilePosition, Vector.Zero, nil)
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.Cursed_NewRoom_RicherRiraHair)
end

do -- Spy Eye
	function wakaba:Cursed_NewRoom_SpyEye()
		if wakaba.G:GetRoom():IsFirstVisit() then
			for num = 1, wakaba.G:GetNumPlayers() do
				local player = wakaba.G:GetPlayer(num - 1)
				if player:HasTrinket(wakaba.Enums.Trinkets.SPY_EYE) then
					local joystick = player:GetShootingJoystick()
					local input = player:GetShootingInput()
					local direction = player:GetFireDirection()
					if Input.IsMouseBtnPressed(MouseButton.LEFT)
					or (joystick:Length() > 0)
					or (direction ~= Direction.NO_DIRECTION)
					then
						player:TakeDamage(1, DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 30)
					end
				end
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.Cursed_NewRoom_SpyEye)
end

do -- Faded Mark
	wakaba:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, function(_, curseMask)
		if wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.FADED_MARK) then
			return curseMask | wakaba.curses.CURSE_OF_SNIPER
		end
	end)
end

do -- Neverlasting Bunny
	wakaba:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, function(_, curseMask)
		if wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.NEVERLASTING_BUNNY) then
			return curseMask | wakaba.curses.CURSE_OF_AMNESIA
		end
	end)
end

do -- Ribbon Cage
	wakaba:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, function(_, curseMask)
		if wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.RIBBON_CAGE) then
			return curseMask | wakaba.curses.CURSE_OF_FAIRY
		end
	end)
end

do -- Rira's worst nightmare
	function wakaba:Cursed_preEntitySpawn_RiraNightmare(type, variant, subType, pos, velocity, spawner, seed)
		local player = wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.RIRAS_WORST_NIGHTMARE)
		if player
		and (
			type == EntityType.ENTITY_HOST
			or type == EntityType.ENTITY_MOBILE_HOST
			or type == EntityType.ENTITY_FLESH_MOBILE_HOST
		)
		then
			return {EntityType.ENTITY_FLOATING_HOST, 0, 0, seed}
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, wakaba.Cursed_preEntitySpawn_RiraNightmare)
end

do -- Masked Shovel
	function wakaba:Cursed_PostTakeDamage_MaskedShovel(player, amount, flags, source, cooldown)
		if player:HasTrinket(wakaba.Enums.Trinkets.MASKED_SHOVEL) then
			local power =
				Retribution and Retribution.GetCursedTrinketPower(player, wakaba.Enums.Trinkets.MASKED_SHOVEL)
				or player:GetTrinketMultiplier(wakaba.Enums.Trinkets.MASKED_SHOVEL)
			local room = wakaba.G:GetRoom()
			local gridPos = room:GetGridIndex(player.Position)
			if power > 1 then
				room:SpawnGridEntity(gridPos, GridEntityType.GRID_TRAPDOOR, 1, 1, 1)
			else
				room:SpawnGridEntity(gridPos, GridEntityType.GRID_TRAPDOOR, 0, 1, 0)
			end
		end
	end
	wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.Cursed_PostTakeDamage_MaskedShovel)

end

do -- Broken Watch 2
	function wakaba:Cursed_Update_BrokenWatch2()
		if wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.BROKEN_WATCH_2) then
			local room = wakaba.G:GetRoom()
			if room:GetFrameCount() % 3 == 0 then
				local seed = math.max(Isaac.GetFrameCount(), 1)
				local rng = RNG()
				rng:SetSeed(seed, 35)
				local state = rng:RandomInt(3)
				room:SetBrokenWatchState(state)
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Cursed_Update_BrokenWatch2)
end

do -- Round and Round
	function wakaba:Cursed_NewRoom_RoundAndRound()
		if true then
			for num = 1, wakaba.G:GetNumPlayers() do
				local player = wakaba.G:GetPlayer(num - 1)
				if player:HasTrinket(wakaba.Enums.Trinkets.ROUND_AND_ROUND) then
					local room = wakaba.G:GetRoom()
					local addPos = room:GetCenterPos()
					Isaac.Spawn(EntityType.ENTITY_STONE_EYE, 0, 0, addPos, Vector.Zero, nil)
					break
				end
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.Cursed_NewRoom_RoundAndRound)
end

do -- Gehenna Rock
	function wakaba:Cursed_preEntitySpawn_GehennaRock(type, variant, subType, pos, velocity, spawner, seed)
		local player = wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.GEHENNA_ROCK)
		if player
		and (
			type == EntityType.ENTITY_POKY
			or
			type == EntityType.ENTITY_WALL_HUGGER
		)
		then
			return {EntityType.ENTITY_GRUDGE, 0, 0, seed}
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, wakaba.Cursed_preEntitySpawn_GehennaRock)
end

do -- Broken Murasame
	-- functions are in compat
end

do -- Lunatic Crystal
	---@param player EntityPlayer
	function wakaba:Cursed_PlayerUpdate_LunaticCrystal(player)
		if player:HasTrinket(wakaba.Enums.Trinkets.LUNATIC_CRYSTAL) then
			player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, -1)
			player:GetEffects():RemoveNullEffect(NullItemID.ID_HOLY_CARD, -1)
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.Cursed_PlayerUpdate_LunaticCrystal)
end

do -- Torn Paper 2
	function wakaba:Cursed_preEntitySpawn_TornPaper2(type, variant, subType, pos, velocity, spawner, seed)
		local player = wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.TORN_PAPER_2)
		if player and type == EntityType.ENTITY_BOMB
		and (variant == BombVariant.BOMB_TROLL or (variant == BombVariant.BOMB_SUPERTROLL and subType ~= 41))
		then
			return {EntityType.ENTITY_BOMB, BombVariant.BOMB_SUPERTROLL, 41, seed}
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, wakaba.Cursed_preEntitySpawn_TornPaper2)
end

do -- Mini Torizo Statue

end

do -- Grenade D20
	---@param pickup EntityPickup
	function wakaba:Cursed_PickupUpdate_GrenadeD20(pickup)
		local player = wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.GRENADE_D20)
		if not player then return end
		local t = pickup.InitSeed % 10
		local s = pickup.DropSeed % 300
		t = (t * 6) + 15 + s
		if pickup.FrameCount >= t then
			local flag = DamageFlag.DAMAGE_EXPLOSION
			Game():BombExplosionEffects(pickup.Position, 100, TearFlags.TEAR_NORMAL, Color.Default, pickup, 1, true, true, flag)
			pickup:Remove()
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.Cursed_PickupUpdate_GrenadeD20, PickupVariant.PICKUP_COIN)
	wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.Cursed_PickupUpdate_GrenadeD20, PickupVariant.PICKUP_BOMB)
	wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.Cursed_PickupUpdate_GrenadeD20, PickupVariant.PICKUP_GRAB_BAG)
	wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.Cursed_PickupUpdate_GrenadeD20, PickupVariant.PICKUP_HEART)
	wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.Cursed_PickupUpdate_GrenadeD20, PickupVariant.PICKUP_KEY)
	wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.Cursed_PickupUpdate_GrenadeD20, PickupVariant.PICKUP_LIL_BATTERY)
	wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.Cursed_PickupUpdate_GrenadeD20, PickupVariant.PICKUP_POOP)
end

do -- Wakaba Siren
	function wakaba:Cursed_Update_WakabaSiren()
		if wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.WAKABA_SIREN) then
			wakaba.G:ShakeScreen(15)
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Cursed_Update_WakabaSiren)
end

do -- Reserved

end

do -- Reserved

end

do -- Reserved

end

do -- Reserved

end

do -- Reserved

end

do -- Reserved

end