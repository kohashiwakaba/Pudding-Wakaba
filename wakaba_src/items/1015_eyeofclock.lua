local laserRot1 = 0
local laserRot2 = 0
local laserRot3 = 0
local lasers = {}
local sublasers = {}
local lasertimer = {}

local isc = require("wakaba_src.libs.isaacscript-common")

local function fireTechClock(player)
	local multiplier = (0.5 * player:GetCollectibleNum(wakaba.Enums.Collectibles.EYE_OF_CLOCK))
	local laser = player:FireTechXLaser(player.Position, Vector.Zero, 0.02, nil, multiplier)
	--local laser = Isaac.Spawn(EntityType.ENTITY_LASER, LaserVariant.THIN_RED, LaserSubType.LASER_SUBTYPE_RING_PROJECTILE, player.Position, Vector.Zero, player):ToLaser()
	laser.CollisionDamage = player.Damage * multiplier
  --laser.Variant = 2
  laser.SubType = 3
	--laser.Parent = player
	--laser.TearFlags = player.TearFlags
	laser.DisableFollowParent = true
	laser:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
	--laser:Update()
	return laser
end

local function fireTechClock_Sub(player, parentLaser, direction)
	local multiplier = (0.16 * player:GetCollectibleNum(wakaba.Enums.Collectibles.EYE_OF_CLOCK))
	local laser = player:FireTechLaser(parentLaser.Position, LaserOffset.LASER_BRIMSTONE_OFFSET, direction, false, false, player, multiplier)
	--laser.CollisionDamage = 1
	laser:AddTearFlags(TearFlags.TEAR_SPECTRAL)
  --laser.Variant = 2
  --laser.SubType = 3
	laser.Parent = player
	laser:SetTimeout(30)
	laser.TearFlags = player.TearFlags
	laser.DisableFollowParent = true
	laser:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
	return laser
end


local function calculateLength(player, r, i)

	local x, y = player.Position.X, player.Position.Y
  local angle = i * math.pi / 180
  local ptx, pty = x + r * math.cos( angle ), y + r * math.sin( angle )
	return Vector(ptx, pty)
end

---@param player EntityPlayer
local function eraseLasers(player)
	local pi = tostring(isc:getPlayerIndex(player))
	for i, laser in pairs(lasers[pi]) do
		if laser:Exists() then
			laser:Die()
		end
	end
	for i, laser in pairs(sublasers[pi]) do
		if laser:Exists() then
			laser:Die()
		end
	end
	lasers[pi] = {}
	sublasers[pi] = {}
	lasertimer[pi] = 0
end

---@param player EntityPlayer
---@param index integer
local function getLaserRotationAngle(player, index)
	local frame = player.FrameCount
	local angle = 0
	if index == 1 then
		angle = frame % 360
	elseif index == 2 then
		local no = frame * -2.45
		local floating = no - (no % 1)
		angle = ((no % 1) % 360) + floating
	elseif index == 3 then
		local no = frame * 3.9
		local floating = no - (no % 1)
		angle = ((no % 1) % 360) + floating
	end
	return angle
end

---@param player EntityPlayer
function wakaba:PlayerUpdate_EyeOfClock(player)
	local pi = tostring(isc:getPlayerIndex(player))
	if player:HasCollectible(wakaba.Enums.Collectibles.EYE_OF_CLOCK) then
		lasers[pi] = lasers[pi] or {}
		sublasers[pi] = sublasers[pi] or {}
		lasertimer[pi] = lasertimer[pi] or 0
		local shootInput = player:GetShootingInput()
		if shootInput:Length() < 0.1 then
			shootInput = player:GetShootingJoystick()
		end
		if shootInput:Length() < 0.1 and Input.IsMouseBtnPressed(Mouse.MOUSE_BUTTON_1) then
			local mousePos = Input.GetMousePosition(false)
			if Game():GetRoom():IsMirrorWorld() then
				mousePos = Vector(Isaac.GetScreenWidth() * Isaac.GetScreenPointScale() - mousePos.X, mousePos.Y)
			end
			mousePos = Isaac.ScreenToWorld(mousePos)
			shootInput = mousePos - player.Position
		end
		if shootInput:Length() < 0.1 and (
			Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
		or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
		or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
		or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
		) then
			shootInput = wakaba.DIRECTION_VECTOR[player:GetHeadDirection()]
		end
		if shootInput:Length() > 0.1 then
			if lasertimer[pi] < 0 then
				lasertimer[pi] = 0
			end
			lasertimer[pi] = lasertimer[pi] + 1
			for i = 1, 3 do
				if lasertimer[pi] > (120 * (i - 1)) then
					if not lasers[pi][i] or not lasers[pi][i]:Exists() then
						lasers[pi][i] = fireTechClock(player)
						lasers[pi][i].Radius = math.max(math.min((i + 1) * 10.0), 0.001)
					end
					local laser = lasers[pi][i]
					if not sublasers[pi][i] or not sublasers[pi][i]:Exists() then
						sublasers[pi][i] = fireTechClock_Sub(player, laser, shootInput)
					end
					local sublaser = sublasers[pi][i]
					local laserPos = calculateLength(player, 20 + (15.0 * i), getLaserRotationAngle(player, i))
					laser.Position = laserPos
					laser:SetTimeout(30)
					sublaser.Position = laserPos
					sublaser:SetTimeout(30)
					sublaser.AngleDegrees = shootInput:GetAngleDegrees()
				end
			end
		elseif player:IsExtraAnimationFinished() then
			if lasertimer[pi] > 0 then
				lasertimer[pi] = 0
			end
			lasertimer[pi] = lasertimer[pi] - 1
			if lasertimer[pi] < 3 then
				eraseLasers(player)
			end
		end
	else
		lasers[pi] = nil
		sublasers[pi] = nil
		lasertimer[pi] = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_EyeOfClock)
