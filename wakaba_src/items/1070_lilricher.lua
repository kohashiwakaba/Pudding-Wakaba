--[[ 
	Lil Richer (리틀 리셰) - 패밀리어(Familiar) - 유니크
	지형 관통, 특수 유도 눈물 발사
	방 클리어 시마다 액티브 게이지 추가 충전
	완충 시 최대 16회분까지 보존	
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

local richer_saved_recipies = {
	run = {

	},
}
wakaba:saveDataManager("PnW_LilRicher", richer_saved_recipies)

local richerCharges = richer_saved_recipies.run

local function fireTearRicher(player, familiar, vector, rotation)
	local fData = familiar:GetData()
	local tear_vector = nil
	--local entity = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, Vector(familiar.Position.X, familiar.Position.Y), vector, familiar)
	local entity = familiar:FireProjectile(vector)
	tear = entity:ToTear()
	--tear:ChangeVariant(TearVariant.FETUS)
	tear.Scale = 0.9
	tear.TearFlags = TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_FETUS
	--tear.FallingSpeed = 0
	--tear.FallingAcceleration = -0.1

	local multiplier = 1
	if (player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS)) then
		multiplier = multiplier * 2
	end
	tearDamage = 4
	tear.CollisionDamage = tearDamage * multiplier
	tear.Color = Color(0.82, 0.8, 0.96, 1, 0, 0, 0)
	
	if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
		tear.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
	end

	return tear
end

function wakaba:FamiliarInit_LilRicher(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")
	
end

function wakaba:FamiliarUpdate_LilRicher(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	local move_dir = player:GetMovementDirection()
	local sprite = familiar:GetSprite()
	local player_fire_direction = player:GetFireDirection()
	local autoaim = false

	local playerIndex = isc:getPlayerIndex(player)
	richerCharges[playerIndex] = richerCharges[playerIndex] or 0

	if familiar.RoomClearCount > 0 then
		richerCharges[playerIndex] = richerCharges[playerIndex] + familiar.RoomClearCount
		familiar.RoomClearCount = 0
	end

	if richerCharges[playerIndex] > 0 then
		for i = 0, 2 do
			if player:NeedsCharge(i) then
				while player:NeedsCharge(i) and richerCharges[playerIndex] > 0 do
					isc:addCharge(player, i, 1)
					richerCharges[playerIndex] = richerCharges[playerIndex] - 1
				end
			end
		end
		if richerCharges[playerIndex] > 16 then
			richerCharges[playerIndex] = 16
		end
	end

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
		if familiar.FireCooldown <= 0 then
			familiar.FireCooldown = 0
		end
	else
		sprite:Play(wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
		if familiar.FireCooldown <= 0 then
			local tear_vector = wakaba.DIRECTION_VECTOR[player_fire_direction]:Normalized()
			sprite:Play(wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
			if familiar.FireCooldown <= 0 then
				fireTearRicher(player, familiar, tear_vector, 0)
				if player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
					familiar.FireCooldown = 15
				else
					familiar.FireCooldown = 30
				end
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

function wakaba:FamiliarRender_LilRicher(familiar)
  if wakaba.G:GetRoom():GetRenderMode() == RenderMode.RENDER_WATER_REFLECT then return end
	local player = familiar.Player

	local playerIndex = isc:getPlayerIndex(player)
	richerCharges[playerIndex] = richerCharges[playerIndex] or 0
	
	if wakaba.G:GetHUD():IsVisible() and Options.ChargeBars and richerCharges[playerIndex] > 0 then
		local fpos = Isaac.WorldToScreen(familiar.Position) + Vector(1, -11) + Vector(8, -8)
		local boxwidth = 0
		local center = true
		local charges = richerCharges[playerIndex]
		if wakaba.state.options.leftchargebardigits then
			fpos = Isaac.WorldToScreen(familiar.Position) + Vector(-18, -11) + Vector(8, -8)
			boxwidth = 1
			center = false
		end
		wakaba.cf:DrawStringScaledUTF8("x" .. charges, fpos.X, fpos.Y, 1.0, 1.0, KColor(1,1,1,1.0,0,0,0), boxwidth ,center)
	end
end

function wakaba:Cache_LilRicher(player, cacheFlag)
	if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.Enums.Collectibles.LIL_RICHER)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.LIL_RICHER)
		if hasitem or efcount > 0 then
			count = 1
		end
		player:CheckFamiliar(wakaba.Enums.Familiars.LIL_RICHER, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.LIL_RICHER))
	end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_LilRicher)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.FamiliarInit_LilRicher, wakaba.Enums.Familiars.LIL_RICHER)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_LilRicher, wakaba.Enums.Familiars.LIL_RICHER)
wakaba:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, wakaba.FamiliarRender_LilRicher, wakaba.Enums.Familiars.LIL_RICHER)