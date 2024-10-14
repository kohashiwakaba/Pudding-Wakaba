--[[
	Kyoutarou Lover (쿄타로 러버) - 패밀리어
	안나 전용
	아이템 획득 시 색상 변경, 표시된 색상의 퀄리티만 표시
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")
---@param player EntityPlayer
---@return boolean
function wakaba:hasKyouchan(player)
	if not player then
		return false
	end
	if player:GetPlayerType() == wakaba.Enums.Players.ANNA then
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.KYOUTAROU_LOVER) then
		return true
	else
		return false
	end
end

---Check any player has Kyou Lover, or playing as Anna
---@return boolean hasKyou
---@return boolean onlyAnna
function wakaba:anyPlayerHasKyouchan()
	local hasKyou = false
	local onlyAnna = true
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i-1)
		hasKyou = hasKyou or (player.Variant == 0 and wakaba:hasKyouchan(player))
		onlyAnna = onlyAnna and player:GetPlayerType() == wakaba.Enums.Players.ANNA
	end
	return hasKyou, onlyAnna
end

function wakaba:Cache_KyouLover(player, cacheFlag)
	local hasitem = player:HasCollectible(wakaba.Enums.Collectibles.KYOUTAROU_LOVER)
	local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.KYOUTAROU_LOVER)
	local anna = (player:GetPlayerType() == wakaba.Enums.Players.ANNA) and 1 or 0
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 or anna > 0 then
			count = player:GetCollectibleNum(wakaba.Enums.Collectibles.KYOUTAROU_LOVER) + efcount + anna
		end
		player:CheckFamiliar(wakaba.Enums.Familiars.LIL_KYOUTAROU, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.KYOUTAROU_LOVER))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_KyouLover)

local function fireTearKyou(player, familiar, vector, rotation)
	local fData = familiar:GetData()
	local tear_vector = nil
	--local entity = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, Vector(familiar.Position.X, familiar.Position.Y), vector, familiar)
	local entity = familiar:FireProjectile(vector)
	tear = entity:ToTear()
	tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BACKSTAB

	local multiplier = 1
	if (player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS)) then
		multiplier = multiplier * 2
	end
	local tearDamage = 3.5
	tear.CollisionDamage = tearDamage * multiplier

	if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
		tear.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
	end

	return tear
end

function wakaba:initLilKyou(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()
	familiar.FireCooldown = 3

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")

end

function wakaba:updateLilKyou(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	local move_dir = player:GetMovementDirection()
	local sprite = familiar:GetSprite()
	local player_fire_direction = player:GetFireDirection()
	local autoaim = false

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
	else
		local tear_vector = wakaba.DIRECTION_VECTOR[player_fire_direction]:Normalized()
		sprite:Play(wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
		if familiar.FireCooldown <= 0 then
			fireTearKyou(player, familiar, tear_vector, 0)

			if player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
				familiar.FireCooldown = 5
			else
				familiar.FireCooldown = 11
			end
		end
	end

	familiar.FireCooldown = familiar.FireCooldown - 1
	if player:GetPlayerType() == PlayerType.PLAYER_LILITH and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		familiar:RemoveFromFollowers()
		familiar:GetData().BlacklistFromLilithBR = true -- to prevent conflict with using im_tem's code

		local dirVec = wakaba.DIRECTION_VECTOR[player:GetHeadDirection()]
		if player:AreControlsEnabled() and
		(		 Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
			or Input.IsMouseBtnPressed(0)
		) then
			dirVec = player:GetAimDirection()
		end
		local playerpos = player.Position
		local oldpos = familiar.Position
		local newpos = playerpos + dirVec:Resized(40)
		familiar.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length() * 0.4)

	else
		familiar:FollowParent()
	end
end

wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.initLilKyou, wakaba.Enums.Familiars.LIL_KYOUTAROU)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateLilKyou, wakaba.Enums.Familiars.LIL_KYOUTAROU)

function wakaba:GameStart_KyouLover(isContinue)
	if not isContinue then
		local seed = wakaba.G:GetSeeds():GetStartSeed()
		wakaba.state.annaquality = seed % 5
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.GameStart_KyouLover)

function wakaba:getItemFromAnyPool(decrease, seed, default)
	local itemPool = wakaba.G:GetItemPool()
	local newPool = itemPool:GetPoolForRoom(RoomType.ROOM_ERROR, seed)
	if (newPool < 0) then
		newPool = 0
	end
	return itemPool:GetCollectible(newPool, decrease, seed, default)
end

function wakaba:shiftAnnaQuality()
	local min = 0
	local max = 4
	if wakaba:AnyPlayerHasCollectible(CollectibleType.COLLECTIBLE_SACRED_ORB) then
		min = 2
	elseif wakaba:GameHasBirthrightEffect(wakaba.Enums.Players.ANNA) then
		min = 1
	end
	wakaba.state.annaquality = wakaba.state.annaquality + 1
	if wakaba.state.annaquality > max then
		wakaba.state.annaquality = min
	end
end

function wakaba:PostGetCollectible_KyouLover(player, item)
	local hasKyou, onlyAnna = wakaba:anyPlayerHasKyouchan()
	if not hasKyou or not wakaba.state.annaquality then return end
	if not isc:isQuestCollectible(item) then
		wakaba:shiftAnnaQuality()
	end
	if wakaba.state.annaquality == 0 and wakaba:GameHasBirthrightEffect(wakaba.Enums.Players.ANNA) then
		wakaba.state.annaquality = 1
	end
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_KyouLover)

function wakaba:Update_KyouLover()
	local hasKyou, onlyAnna = wakaba:anyPlayerHasKyouchan()
	if not onlyAnna then return end
	if not wakaba.state.annaquality then
		local seed = wakaba.G:GetSeeds():GetStartSeed()
		wakaba.state.annaquality = seed % 5
	end
	local pedestals = wakaba:GetPedestals(true)
	for i, p in ipairs(pedestals) do
		if not p.Pedestal.Touched and not isc:isQuestCollectible(p.CollectibleType) and p.Quality ~= wakaba.state.annaquality then
			local pickup = p.Pedestal ---@type EntityPickup
			local new = wakaba:getItemFromAnyPool(false, pickup.InitSeed, 25)
			pickup:ClearEntityFlags(EntityFlag.FLAG_ITEM_SHOULD_DUPLICATE)
			pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, new, true, true, false)
			Isaac.Spawn(1000, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, pickup)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_KyouLover)