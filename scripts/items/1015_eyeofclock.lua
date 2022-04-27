wakaba.COLLECTIBLE_EYE_OF_CLOCK = Isaac.GetItemIdByName("Eye of Clock")
local laserRot1 = 0
local laserRot2 = 0
local laserRot3 = 0
local lasers = {}
local sublasers = {}

local function fireTechClock(player)
	local multiplier = (0.4 * player:GetCollectibleNum(wakaba.COLLECTIBLE_EYE_OF_CLOCK))
	local laser = player:FireTechXLaser(player.Position, Vector.Zero, 0.02, nil, multiplier)
	laser.CollisionDamage = 1
  laser.Variant = 2
  laser.SubType = 3
	laser.Parent = player
	laser.TearFlags = player.TearFlags
	laser.DisableFollowParent = true
	return laser
end

local function fireTechClock_Sub(player, laser, direction)
	local multiplier = (0.25 * player:GetCollectibleNum(wakaba.COLLECTIBLE_EYE_OF_CLOCK))
	local laser = player:FireTechLaser(laser.Position, LaserOffset.LASER_BRIMSTONE_OFFSET, direction, false, false, player, multiplier)
	laser.CollisionDamage = 1
	laser:AddTearFlags(TearFlags.TEAR_SPECTRAL)
  --laser.Variant = 2
  --laser.SubType = 3
	laser.Parent = player
	laser:SetTimeout(30)
	laser.TearFlags = player.TearFlags
	laser.DisableFollowParent = true
	return laser
end


local function calculateLength(player, r, i)
	
	local x, y = player.Position.X, player.Position.Y
  local angle = i * math.pi / 180
  local ptx, pty = x + r * math.cos( angle ), y + r * math.sin( angle )
	return Vector(ptx, pty)
end

local function initLasers(player)
	local sti = wakaba:getstoredindex(player)
	if lasers[sti] == nil then
		lasers[sti] = {}
	end
	lasers[sti][1] = fireTechClock(player)
	lasers[sti][1].Radius = math.max(math.min(20.0), 0.001)
	lasers[sti][2] = fireTechClock(player)
	lasers[sti][2].Radius = math.max(math.min(30.0), 0.001)
	lasers[sti][3] = fireTechClock(player)
	lasers[sti][3].Radius = math.max(math.min(50.0), 0.001)
end


function wakaba:pUpdate35(player)
	if player:HasCollectible(wakaba.COLLECTIBLE_EYE_OF_CLOCK) then
		local sti = wakaba:getstoredindex(player)
		if lasers[sti] == nil then
			lasers[sti] = {}
			initLasers(player)
		end
		if sublasers[sti] == nil then
			sublasers[sti] = {}
		end
		if lasers[sti][1] ~= nil then
			lasers[sti][1].Position = calculateLength(player, 40.0, laserRot1)
		end
		if lasers[sti][2] ~= nil then
			lasers[sti][2].Position = calculateLength(player, 80.0, laserRot2)
		end
		if lasers[sti][3] ~= nil then
			lasers[sti][3].Position = calculateLength(player, 120.0, laserRot3)
		end
		if Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
		or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
		or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
		or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex) then
			if lasers[sti][1] ~= nil then
				if sublasers[sti][1] and sublasers[sti][1]:Exists() then
					sublasers[sti][1].Position = lasers[sti][1].Position
					sublasers[sti][1]:SetTimeout(30)
					sublasers[sti][1].AngleDegrees = wakaba.DIRECTION_ANGLE[player:GetFireDirection()]
				else
					sublasers[sti][1] = fireTechClock_Sub(player, lasers[sti][1], wakaba.DIRECTION_VECTOR[player:GetFireDirection()])
				end
			end
			if lasers[sti][2] ~= nil then
				if sublasers[sti][2] and sublasers[sti][2]:Exists() then
					sublasers[sti][2].Position = lasers[sti][2].Position
					sublasers[sti][2]:SetTimeout(30)
					sublasers[sti][2].AngleDegrees = wakaba.DIRECTION_ANGLE[player:GetFireDirection()]
				else
					sublasers[sti][2] = fireTechClock_Sub(player, lasers[sti][2], wakaba.DIRECTION_VECTOR[player:GetFireDirection()])
				end
			end
			if lasers[sti][3] ~= nil then
				if sublasers[sti][3] and sublasers[sti][3]:Exists() then
					sublasers[sti][3].Position = lasers[sti][3].Position
					sublasers[sti][3]:SetTimeout(30)
					sublasers[sti][3].AngleDegrees = wakaba.DIRECTION_ANGLE[player:GetFireDirection()]
				else
					sublasers[sti][3] = fireTechClock_Sub(player, lasers[sti][3], wakaba.DIRECTION_VECTOR[player:GetFireDirection()])
				end
			end
		else
			if sublasers[sti][1] then
				sublasers[sti][1]:Die()
				sublasers[sti][1] = nil
			end
			if sublasers[sti][2] then
				sublasers[sti][2]:Die()
				sublasers[sti][2] = nil
			end
			if sublasers[sti][3] then
				sublasers[sti][3]:Die()
				sublasers[sti][3] = nil
			end
		end
	
	else
		if lasers[sti] ~= nil then
			if lasers[sti][1] ~= nil then
				lasers[sti][1]:Die()
			end
			if lasers[sti][2] ~= nil then
				lasers[sti][2]:Die()
			end
			if lasers[sti][3] ~= nil then
				lasers[sti][3]:Die()
			end
			lasers[sti] = nil
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.pUpdate35)

function wakaba:newRoom35()
	
	for num = 1, Game():GetNumPlayers() do
		local player = Game():GetPlayer(num)
		local sti = wakaba:getstoredindex(player)
		if player:HasCollectible(wakaba.COLLECTIBLE_EYE_OF_CLOCK) then
			initLasers(player)
		elseif sti ~= nil then
			lasers[sti] = nil
		end
	end
	
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.newRoom35)

function wakaba:update35()
	laserRot1 = laserRot1 + 1
	laserRot2 = laserRot2 - 2.45
	laserRot3 = laserRot3 + 3.9
	if laserRot1 >= 360 then
		laserRot1 = laserRot1 - 360
	end
	if laserRot2 < 0 then
		laserRot2 = laserRot2 + 360
	end
	if laserRot3 >= 360 then
		laserRot3 = laserRot3 - 360
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.update35)
--LagCheck