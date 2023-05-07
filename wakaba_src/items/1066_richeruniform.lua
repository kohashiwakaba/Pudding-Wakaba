--[[ 
	Richer's Uniform (리셰쨩의 제복) - 액티브 - 4 rooms
	사용한 방에 따라 다른 효과 발동
	- 기본 : 그 방에서 리스톡머신 1회 발동, Blind 저주 제거

	- 시작방 : 최초 입장 시에 한해 Card Reading의 포탈 소환
	- 일반방/아레나 : 그 방의 적을 2회 약화
	- 보물방 : 
	- 천체관 : 
	- 상점 : 그 방에서 할인
	- 블랙마켓 : 그 상점을 재입고
	- 보스방/미니보스방 : 그 방에서 미네르바 오라(공격력/연사 증가 + 유도) 발동
	- 에러방 : 그 방의 액티브/패시브와 같이 시작 방으로 텔레포트
	- 비밀방 : 
	- 일급비밀방 : 
	- 특급비밀방 : 
	- 오락실 : 랜덤 슬롯머신 소환 + 그 방에서 Lucky Foot 효과 발동
	- 저주방 : 체력 한칸을 소모하여 빨간 상자 소환
	- 도전방/보스도전방 : 그 방의 픽업 및 아이템을 복사
	- 책방 : 그 방의 책 효과를 흡수한 특수 카드를 소환
	- 희생방 : 희생 카운터를 6으로 설정 (5회차 이전인 가시가 있는 경우 체력 1칸을 소모하여 이전 보상을 전부 획득)
	- 악마방 : 최대 체력 2칸 거래가 필요한 3+ 퀄리티 아이템 소환
	- 천사방 : 빨간하트, 소울하트를 반칸씩 회복, 저주 방어 횟수 추가
	- 보스러시 : 선택형 상태 제거
	- 레트로방 : 
	- 침대방 : 
	- 출구방 : 

	- 비스트방 : 도그마 지급 (일회용)

	- 관측소(갓모드) : 가장 가까이에 있는 장신구 흡수
	- 썩은 보물방(Tainted Treasure) : 제시된 아이템을 소모하지 않고 해당 알트 아이템 획득
	- 버려진 천체관(안드로메다) : 해당 방을 리셰의 천체관으로 교체
	- 천체보스방(Heaven's Call) : 
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

local ribbon_data = {
	run = {
		storedPickups = {},
	},
}
wakaba:saveDataManager("Richer Uniform", ribbon_data)

---@param item CollectibleType
---@param rng RNG
---@param player EntityPlayer
---@param useFlags UseFlag
---@param activeSlot ActiveSlot
---@param varData integer
function wakaba:ItemUse_RicherUniform(item, rng, player, useFlags, activeSlot, varData)
	pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
  local discharge = true
	local remove = false
	local useAnim = false

	local failed = false
	local level = wakaba.G:GetLevel()
	local room = wakaba.G:GetRoom()
	local roomType = room:GetType()
	local sfx = SFXManager()
	local RECOMMENDED_SHIFT_IDX = 35

	if isc:inBeastRoom() then
		player:AddCollectible(CollectibleType.COLLECTIBLE_DOGMA)
		remove = true
	elseif not wakaba.G:IsGreedMode() and isc:inStartingRoom() and level:GetAbsoluteStage() ~= LevelStage.STAGE8 then
		local hasTreasureRoom = isc:levelHasRoomType(RoomType.ROOM_TREASURE)
		local f = 0
		if hasTreasureRoom then
			f = rng:RandomInt(2)+1
		else
			f = rng:RandomInt(3)
		end
		Isaac.Spawn(1000, 161, f-1, room:FindFreePickupSpawnPosition(player.Position + Vector(40, 40)), Vector(0,0), nil)
		sfx:Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
	elseif roomType == RoomType.ROOM_DEFAULT or roomType == RoomType.ROOM_BLUE then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_D10, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_VOID, -1)
		player:UseActiveItem(CollectibleType.COLLECTIBLE_D10, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_VOID, -1)
	elseif roomType == RoomType.ROOM_SHOP then
		wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_STEAM_SALE, -1, 1, "RICHER_UNIFORM")
	elseif roomType == RoomType.ROOM_ERROR then
		local pickups = Isaac.FindByType(EntityType.ENTITY_PICKUP)
		for _, pickup in ipairs(pickups) do
			table.insert(ribbon_data.run.storedPickups, {
				Type = EntityType.ENTITY_PICKUP, 
				Variant = pickup.Variant, 
				SubType = pickup.SubType,
				X = pickup.Position.X,
				Y = pickup.Position.Y,
				Seed = pickup.InitSeed,
			})
		end
		player:UseCard(Card.CARD_FOOL, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
	elseif roomType == RoomType.ROOM_TREASURE then
		player:UseCard(Card.CARD_SOUL_EDEN, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
	elseif roomType == RoomType.ROOM_PLANETARIUM then
		player:UseCard(Card.RUNE_PERTHRO, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
	elseif roomType == RoomType.ROOM_BOSS or roomType == RoomType.ROOM_MINIBOSS then
		player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.MINERVA_AURA)
	elseif roomType == RoomType.ROOM_DEVIL then
		wakaba.runstate.rerollquality["0"] = false
		wakaba.runstate.rerollquality["1"] = false
		wakaba.runstate.rerollquality["2"] = false
		local shopItem = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(player.Position, 32), Vector.Zero, player):ToPickup()
		shopItem.Price = PickupPrice.PRICE_TWO_HEARTS
		shopItem.AutoUpdatePrice = false
		wakaba.runstate.rerollquality["0"] = nil
		wakaba.runstate.rerollquality["1"] = nil
		wakaba.runstate.rerollquality["2"] = nil
	elseif roomType == RoomType.ROOM_ANGEL then
		player:AddSoulHearts(1)
		player:AddHearts(1)
		local curse = level:GetCurses() & ~wakaba.curses.CURSE_OF_SATYR
		if curse > 0 then
			player:UseCard(Card.RUNE_DAGAZ, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
		else
			wakaba.runstate.pendingCurseImmunityCount = wakaba.runstate.pendingCurseImmunityCount + 1
		end
	elseif roomType == RoomType.ROOM_SACRIFICE then
		local damagePlayer = false
		local spikes = isc:getGridEntities(GridEntityType.GRID_SPIKES)
		for i, spike in ipairs(spikes) do
			if spike.VarData < 5 then
				damagePlayer = true
			end
			spike.VarData = 5
			local state = spike:GetSaveState()
			local roomRng = RNG()
			roomRng:SetSeed(state.VariableSeed, RECOMMENDED_SHIFT_IDX)
			state.VariableSeed = roomRng:Next()
			spike:Update()
		end
		if damagePlayer then
			player:TakeDamage(2, DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 60)
		end
	--[[ elseif roomType == RoomType.ROOM_SECRET then ]]

	--[[ elseif roomType == RoomType.ROOM_SUPERSECRET then ]]

	--[[ elseif roomType == RoomType.ROOM_ULTRASECRET then ]]

	elseif roomType == RoomType.ROOM_ARCADE then
		player:UseCard(Card.CARD_WHEEL_OF_FORTUNE, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
		wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_LUCKY_FOOT, -1, 1, "RICHER_UNIFORM")
	elseif roomType == RoomType.ROOM_CURSE then
		player:TakeDamage(2, DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 60)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_REDCHEST, -1, room:FindFreePickupSpawnPosition(player.Position + Vector(40, 0)), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_REDCHEST, -1, room:FindFreePickupSpawnPosition(player.Position + Vector(-40, 0)), Vector(0,0), nil)
	elseif roomType == RoomType.ROOM_CHALLENGE then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_DIPLOPIA, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_VOID, -1)
	--[[ elseif roomType == RoomType.ROOM_LIBRARY then ]]

	--[[ elseif roomType == RoomType.ROOM_DUNGEON then ]]

	elseif roomType == RoomType.ROOM_BOSSRUSH then
		local pickups = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
		for _, pickup in ipairs(pickups) do
			pickup:ToPickup().OptionsPickupIndex = 0
		end
	--[[ elseif roomType == RoomType.ROOM_ISAACS or roomType == RoomType.ROOM_BARREN then ]]

	elseif roomType == RoomType.ROOM_CHEST then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LOCKEDCHEST, -1, room:FindFreePickupSpawnPosition(player.Position + Vector(40, 0)), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LOCKEDCHEST, -1, room:FindFreePickupSpawnPosition(player.Position + Vector(0, 40)), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LOCKEDCHEST, -1, room:FindFreePickupSpawnPosition(player.Position + Vector(-40, 0)), Vector(0,0), nil)
	--[[ elseif roomType == RoomType.ROOM_DICE then ]]

	--[[ elseif roomType == RoomType.ROOM_BLACK_MARKET then ]]
		
	--[[ elseif roomType == RoomType.ROOM_GREED_EXIT or roomType == RoomType.ROOM_SECRET_EXIT then ]]
		
	else
		room:ShopRestockFull()
	end


	if not failed and not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(item, "UseItem", "PlayerPickup")
	end
  return {
		Discharge = discharge,
		Remove = remove,
		ShowAnim = showAnim,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RicherUniform, wakaba.Enums.Collectibles.RICHERS_UNIFORM)

function wakaba:NewRoom_RicherUniform()
	if #ribbon_data.run.storedPickups > 0 then
		for i, e in ipairs(ribbon_data.run.storedPickups) do
			wakaba.G:Spawn(e.Type, e.Variant, Vector(e.X, e.Y), Vector.Zero, nil, e.SubType, e.Seed)
		end
		ribbon_data.run.storedPickups = {}
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_RicherUniform)

if EID then
	local function RicherUniformCondition(descObj)
		if not EID.InsideItemReminder then return false end
		if EID.holdTabPlayer == nil then return false end
		return descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and descObj.ObjSubType == wakaba.Enums.Collectibles.RICHERS_UNIFORM
	end
	local function RicherUniformCallback(descObj)
		local level = wakaba.G:GetLevel()
		local room = wakaba.G:GetRoom()
		local roomType = room:GetType()
		local appendDesc = ""
		local descTable = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].richeruniform) or wakaba.descriptions["en_us"].richeruniform
		if isc:inBeastRoom() then
			appendDesc = descTable.beast
		elseif not wakaba.G:IsGreedMode() and isc:inStartingRoom() and level:GetAbsoluteStage() ~= LevelStage.STAGE8 then
			appendDesc = descTable.startroom
		elseif roomType == RoomType.ROOM_DEFAULT or roomType == RoomType.ROOM_BLUE then
			appendDesc = descTable.regular
		elseif roomType == RoomType.ROOM_SHOP then
			appendDesc = descTable.shop
		elseif roomType == RoomType.ROOM_ERROR then
			appendDesc = descTable.error
		elseif roomType == RoomType.ROOM_TREASURE then
			appendDesc = descTable.treasure
		elseif roomType == RoomType.ROOM_PLANETARIUM then
			appendDesc = descTable.planetarium
		elseif roomType == RoomType.ROOM_BOSS or roomType == RoomType.ROOM_MINIBOSS then
			appendDesc = descTable.boss
		elseif roomType == RoomType.ROOM_DEVIL then
			appendDesc = descTable.devil
		elseif roomType == RoomType.ROOM_ANGEL then
			appendDesc = descTable.angel
		elseif roomType == RoomType.ROOM_SACRIFICE then
			appendDesc = descTable.sacrifice
		--[[ elseif roomType == RoomType.ROOM_SECRET then ]]
	
		--[[ elseif roomType == RoomType.ROOM_SUPERSECRET then ]]
	
		--[[ elseif roomType == RoomType.ROOM_ULTRASECRET then ]]
	
		elseif roomType == RoomType.ROOM_ARCADE then
			appendDesc = descTable.arcade
		elseif roomType == RoomType.ROOM_CURSE then
			appendDesc = descTable.curse
		elseif roomType == RoomType.ROOM_CHALLENGE then
			appendDesc = descTable.challenge
		--[[ elseif roomType == RoomType.ROOM_LIBRARY then ]]
	
		--[[ elseif roomType == RoomType.ROOM_DUNGEON then ]]
	
		elseif roomType == RoomType.ROOM_BOSSRUSH then
			appendDesc = descTable.bossrush
		--[[ elseif roomType == RoomType.ROOM_ISAACS or roomType == RoomType.ROOM_BARREN then ]]
	
		elseif roomType == RoomType.ROOM_CHEST then
			appendDesc = descTable.chestroom
		--[[ elseif roomType == RoomType.ROOM_DICE then ]]
	
		--[[ elseif roomType == RoomType.ROOM_BLACK_MARKET then ]]
			
		--[[ elseif roomType == RoomType.ROOM_GREED_EXIT or roomType == RoomType.ROOM_SECRET_EXIT then ]]
			
		else
			appendDesc = descTable.default
		end

		descObj.Description = appendDesc
		return descObj
	end
	EID:addDescriptionModifier("Wakaba Richer Uniform", RicherUniformCondition, RicherUniformCallback)
end