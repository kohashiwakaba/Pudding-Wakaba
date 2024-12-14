--[[
	Tainted Rira(뒤집힌 리라)
	야릇한 리퀴드
	- 최대 체력 = 소울하트 보정, REPENTOGON 적용 시 체력 상한 24칸으로 증가
	- 토끼 와드가 주변에 없으면 지속적으로 체력 감소
	- 모든 기초 픽업을 소울하트로 변환 (폐기)
	- 모든 장신구가 아쿠아 장신구로 등장
	- 모든 보물방이 '리라의 야릇한 보물방'으로 교체됨
	-- 모든 보물방에 적용 가능, 해당 방은 아이템 대신 아쿠아 장신구가 등장
	토끼 와드
	- 사용 시 맵 기준 반경 2칸까지 아쿠아 버프 적용
	- 아쿠아 버프가 적용된 방은 리라의 체력 감소 방지
	- 아쿠아 버프 적용 강도에 따라 연사 증가
	클리너 (REPENTOGON 한정)
	- Hush, Chest, Dark Room, Beast, Corpse 시작 방에서 클리너 소환
	- 접촉 시 '기본 무기'를 눈물로 변경


	추가 고유능력 : Aquaris(물병자리)
	생득권 : 체력 감소 해제, Rabbey Ward 사용 시 가장 가까운 아이템 복사
 ]]


local playerType = wakaba.Enums.Players.RIRA_B
local isRiraContinue = true

local isc = require("wakaba_src.libs.isaacscript-common")
if not REPENTOGON then
	wakaba:registerCharacterHealthConversion(wakaba.Enums.Players.RIRA_B, isc.HeartSubType.SOUL)
end

wakaba.__taintedriraptcolor = {0.7, 1, 1.6}
wakaba.__taintedriraptscale = 1.2

---@param player EntityPlayer
function wakaba:PlayerUpdate_RiraB(player)
	if not player or player:GetPlayerType() ~= playerType then return end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then return end
	if not wakaba:IsDimension(0) then return end
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	local rabbeyPower = wakaba:getRabbeyWardPower(level:GetCurrentRoomIndex(), true)
	local wData = wakaba:GetPlayerEntityData(player)
	if rabbeyPower > 0 then
		wakaba:removePlayerDataEntry(player, "rabbeyburningtimer")
	else
		if (wakaba.G:GetFrameCount() % 4) < 1 then
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.RABBEY_WARD)
			local ba = player.SpriteScale
			local da = Vector(player.PositionOffset.X / ba.X, player.PositionOffset.Y / ba.Y) -- REP_PLUS WHY
			local offset = (Vector(0, -28) + da) * ba
			--local xd = (RandomVector() * 7)
			local xd = wakaba:RandomCenteredVelocity(rng, 7)
			local effect = Isaac.Spawn(1000, 111, 0, player.Position + offset + xd, xd / 1.5, player):ToEffect()
			local efsprite = effect:GetSprite()
			local efcolor = Color(1,1,1,0.65)
			efcolor:SetOffset(wakaba.__taintedriraptcolor[1], wakaba.__taintedriraptcolor[2], wakaba.__taintedriraptcolor[3])
			efsprite.Color = efcolor
			efsprite.Scale = efsprite.Scale * wakaba.__taintedriraptscale
		end
		wakaba:initPlayerDataEntry(player, "rabbeyburningtimer", wakaba.Enums.Constants.SELF_BURNING_DAMAGE_TIMER)
		wakaba:addPlayerDataCounter(player, "rabbeyburningtimer", -1)
		if wakaba:getPlayerDataEntry(player ,"rabbeyburningtimer", 0) < 0 then
			if player:GetSoulHearts() > 1 then
				player:AddSoulHearts(-1)
			end
			wakaba:setPlayerDataEntry(player, "rabbeyburningtimer", wakaba.Enums.Constants.SELF_BURNING_DAMAGE_TIMER)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_RiraB)


function wakaba:PostGetCollectible_Rira_b(player, item)
	if not player or player:GetPlayerType() ~= wakaba.Enums.Players.RIRA_B then return end
	player:AddSoulHearts(player:GetSoulHearts() * -1)
	player:AddMaxHearts(2)
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_Rira_b, CollectibleType.COLLECTIBLE_DEAD_CAT)

local RiraChar = {
	DAMAGE = 1,
	SPEED = 0.0,
	SHOTSPEED = 1.05,
	TEARRANGE = 0,
	TEARS = 0,
	LUCK = 0,
	FLYING = false,
	TEARFLAG = TearFlags.TEAR_NORMAL,
	TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)	-- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}

function wakaba:onRiraCache_b(player, cacheFlag)
	if player:GetPlayerType() == playerType then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * RiraChar.DAMAGE
		end
		if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed * RiraChar.SHOTSPEED
		end
		if cacheFlag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + RiraChar.TEARRANGE
		end
		if cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = (player.MoveSpeed * 0.5) + 0.5 + RiraChar.SPEED
		end
		if cacheFlag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + RiraChar.LUCK
		end
		if cacheFlag == CacheFlag.CACHE_FLYING and RiraChar.FLYING then
			player.CanFly = true
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (RiraChar.TEARS * wakaba:getEstimatedTearsMult(player)))
			player.MaxFireDelay = wakaba:MultiplyTears(player.MaxFireDelay, 1)
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | RiraChar.TEARFLAG
		end
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			--player.TearColor = RiraChar.TEARCOLOR
		end
	end
end

wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, -200, function(_, player, cacheFlag)
	if player:GetPlayerType() == playerType then
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			--player.TearColor = RiraChar.TEARCOLOR
			player.TearColor = wakaba.Colors.AQUA_WEAPON_COLOR
		end
	end
end)

wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010720, wakaba.onRiraCache_b)

function wakaba:AfterRiraInit_b(player)
	player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.RABBEY_WARD, ActiveSlot.SLOT_POCKET, true)
	end
end

function wakaba:PostRiraInit_b(player)
	if not isRiraContinue then
		wakaba:AfterRiraInit_b(player)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostRiraInit_b)

function wakaba:RiraInit_b(continue)
	if (not continue) then
		isRiraContinue = false
		wakaba:AfterRiraInit_b()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.RiraInit_b)

function wakaba:RiraExit_b()
	isRiraContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.RiraExit_b)