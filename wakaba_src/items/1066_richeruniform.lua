--[[ 
	Richer's Uniform (리셰쨩의 제복) - 액티브 - 4 rooms
	사용한 방에 따라 다른 효과 발동
	- 기본 : 그 방에서 리스톡머신 1회 발동

	- 시작방 : 최초 입장 시에 한해 Card Reading의 포탈 소환
	- 일반방/아레나 : 랜덤 적 하나를 석화 + 그 자리에서 폭발, 적이 없는 경우 니켈 소환
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
	- 도전방/보스도전방 : 
	- 책방 : 그 방의 책 효과를 흡수한 특수 카드를 소환
	- 희생방 : 희생 카운터를 6으로 설정 (5회차 이전인 가시가 있는 경우 체력 1칸을 소모하여 이전 보상을 전부 획득)
	- 악마방 : 최대 체력 3칸 거래가 필요한 3+ 퀄리티 아이템 소환
	- 천사방 : 
	- 보스러시 : 선택형 상태 제거
	- 레트로방 : 
	- 침대방 : 
	- 출구방 : 

	- 관측소(갓모드) : 가장 가까이에 있는 장신구 흡수
	- 썩은 보물방(Tainted Treasure) : 제시된 아이템을 소모하지 않고 해당 알트 아이템 획득
	- 버려진 천체관(안드로메다) : 해당 방을 리셰의 천체관으로 교체
	- 천체보스방(Heaven's Call) : 
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

local ribbon_data = {
	run = {
		pendingCurseImmunityCount = 0,
	},
	floor = {

	},
	room = {

	}
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
	local failed = false
	local room = wakaba.G:GetRoom()
	local roomType = room:GetType()

	if roomType == RoomType.ROOM_DEFAULT then

	elseif roomType == RoomType.ROOM_DEFAULT or roomType == RoomType.ROOM_BLUE then
		
	elseif roomType == RoomType.ROOM_SHOP then
		wakaba.HiddenItemManager:AddForRoom(player, CollectibleType.COLLECTIBLE_STEAM_SALE, -1, 1, "RICHER_UNIFORM")
	elseif roomType == RoomType.ROOM_ERROR then

	elseif roomType == RoomType.ROOM_TREASURE then

	elseif roomType == RoomType.ROOM_PLANETARIUM then

	elseif roomType == RoomType.ROOM_BOSS or roomType == RoomType.ROOM_MINIBOSS then

	elseif roomType == RoomType.ROOM_DEVIL then
		--local selected = 
		--local shopItem = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, selected, Isaac.GetFreeNearPosition(player.Position, 32), Vector.Zero, player):ToPickup()

	elseif roomType == RoomType.ROOM_ANGEL then
		player:AddSoulHearts(1)
		player:AddHearts(1)
		ribbon_data.run.pendingCurseImmunityCount = ribbon_data.run.pendingCurseImmunityCount + 1
	elseif roomType == RoomType.ROOM_SACRIFICE then
		local damagePlayer = false
		local spikes = isc:getGridEntities(GridEntityType.GRID_SPIKES)
		for i, spike in ipairs(spikes) do
			if spike.VarData < 5 then
				damagePlayer = true
			end
			spike.VarData = 5
			spike:Update()
		end
		if damagePlayer then
			player:TakeDamage()
		end
	elseif roomType == RoomType.ROOM_SECRET then

	elseif roomType == RoomType.ROOM_SUPERSECRET then

	elseif roomType == RoomType.ROOM_ULTRASECRET then

	elseif roomType == RoomType.ROOM_ARCADE then

	elseif roomType == RoomType.ROOM_CURSE then

	elseif roomType == RoomType.ROOM_CHALLENGE then

	elseif roomType == RoomType.ROOM_LIBRARY then

	elseif roomType == RoomType.ROOM_DUNGEON then

	elseif roomType == RoomType.ROOM_BOSSRUSH then

	elseif roomType == RoomType.ROOM_ISAACS or roomType == RoomType.ROOM_BARREN then

	elseif roomType == RoomType.ROOM_CHEST then

	elseif roomType == RoomType.ROOM_DICE then

	elseif roomType == RoomType.ROOM_BLACK_MARKET then

	elseif roomType == RoomType.ROOM_GREED_EXIT or roomType == RoomType.ROOM_SECRET_EXIT then

	elseif roomType == RoomType.ROOM_DEFAULT then

	elseif roomType == RoomType.ROOM_DEFAULT then

	elseif roomType == RoomType.ROOM_DEFAULT then

	elseif roomType == RoomType.ROOM_DEFAULT then
		
	else
		room:ShopRestockFull()
	end


	if not failed and not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(item, "UseItem", "PlayerPickup")
	end
  return {
		Discharge = discharge,
	}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_RicherUniform, wakaba.Enums.Collectibles.RICHERS_UNIFORM)
