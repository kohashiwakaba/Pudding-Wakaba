--[[
  Revelation utilities
  changed 'REVEL' naming into 'wakaba' to prevent confusion
 ]]

local SpikeState = {
	SPIKE_ON = 0,
	SPIKE_OFF = 1,
}

function wakaba:VectorToGrid(x, y, width)
	width = width or wakaba.G:GetRoom():GetGridWidth()
	return math.floor(width + 1 + (x + width * y))
end

---@param index integer
---@param width? integer
---@return number x
---@return number y
function wakaba:GridToVector(index, width)
	width = width or wakaba.G:GetRoom():GetGridWidth()
	return (index % width) - 1, (math.floor(index / width)) - 1
end

function wakaba:IsAnimOn(sprite, anmName)
	if not sprite then
			error("IsAnimOn: sprite nil", 2)
	elseif not anmName then
			error("IsAnimOn: anmName nil", 2)
	end
	return sprite:IsPlaying(anmName) or sprite:IsFinished(anmName)
end

function wakaba:SkipAnimFrames(sprite, frame)
	for i = 1, frame do
		sprite:Update()
	end
end

function wakaba:AnimateWalkFrameSpeed(sprite, vel, walkAnims, flipWhenRight, noFlip, idleAnim, minSpd, maxSpd)
	local x,y = math.abs(vel.X), math.abs(vel.Y)
	if x > 0.01 or y > 0.01 then
		local frame = 0
		if sprite:IsPlaying(walkAnims) then
			frame = sprite:GetFrame() + 1
		end
		sprite.FlipX = (x < 0)
		if not sprite:IsPlaying(walkAnims) then
			sprite:Play(walkAnims, true)
			if frame > 0 then
				wakaba:SkipAnimFrames(sprite, frame)
			end
		end
		sprite.PlaybackSpeed = wakaba:Lerp(minSpd or 0.5, maxSpd or 1, math.min(1, vel:LengthSquared() / 4 ))
	else
		if idleAnim then
			sprite:Play(idleAnim, true)
			sprite.PlaybackSpeed = 1
		elseif sprite:GetFrame() == 0 then
			sprite.PlaybackSpeed = 0
		end
	end
end

local function GridDistanceSquared(indexA, indexB)
	local room = wakaba.G:GetRoom()
	if not (indexA and indexB) then
		error("got nil values:" .. tostring(indexA) .. " and " .. tostring(indexB) .. "", 2)
	end
	return room:GetGridPosition(indexA):DistanceSquared(room:GetGridPosition(indexB))
end

---Generate path using A* algorithm between two grid indices
---@param startIndex integer
---@param targetIndex integer
---@param validCollisions? table
---@return table|boolean path
---@return integer? pathLength
function wakaba:GeneratePathAStar(startIndex, targetIndex, validCollisions)
	local room = wakaba.G:GetRoom()
	local gridCollisions = {}
	local lengthScores = {} -- How many steps from Start to Index
	local combinedScores = {} -- Estimated distance from Index to Target + lengthScore
	validCollisions = validCollisions or {GridCollisionClass.COLLISION_NONE}
	for i = 0, room:GetGridSize() - 1 do
		local coll = room:GetGridCollision(i)
		if wakaba:has_value(validCollisions, coll) then
			gridCollisions[i] = 0
		else
			gridCollisions[i] = 1
		end

		lengthScores[i] = 999999999
		combinedScores[i] = 999999999
	end

	local width = room:GetGridWidth()

	lengthScores[startIndex] = 0 -- 0 steps between startIndex and startIndex
	combinedScores[startIndex] = GridDistanceSquared(startIndex, targetIndex)

	local processedIndices = {}
	local indicesToCheck = {startIndex}

	local path = {}

	local foundPath, pathLength
	while #indicesToCheck > 0 do
		local checkIndex -- Grid index whose neighbors will be checked, try to select the one closest to the target
		local indexOfCheckIndex -- index in the indicesToCheck table of checkIndex
		local bestCombinedScore = 999999999
		for i, ind in ipairs(indicesToCheck) do
			if combinedScores[ind] < bestCombinedScore then
				checkIndex = ind
				indexOfCheckIndex = i
				bestCombinedScore = combinedScores[ind]
			end
		end

		if checkIndex == targetIndex then
			foundPath = true
			pathLength = bestCombinedScore
			break
		end

		table.remove(indicesToCheck, indexOfCheckIndex)
		processedIndices[checkIndex] = true

		local adjacentIndices = {
			checkIndex - 1,
			checkIndex + 1,
			checkIndex - width,
			checkIndex + width
		}

		for _, index in ipairs(adjacentIndices) do
			if not processedIndices[index] and gridCollisions[index] == 0 then
				local lengthScore = lengthScores[checkIndex] + 1
				local alreadyFound
				for _, ind in ipairs(indicesToCheck) do
					if ind == index then
						alreadyFound = true
						break
					end
				end
				if not alreadyFound or lengthScore < lengthScores[index] then
					indicesToCheck[#indicesToCheck + 1] = index
					path[index] = checkIndex
					lengthScores[index] = lengthScore
					combinedScores[index] = lengthScore + GridDistanceSquared(index, targetIndex)
				end
			end
		end
	end

	if foundPath then
		local pathReturn = {}
			local backwardPath = {}
		local current = targetIndex
		while path[current] do
			backwardPath[#backwardPath + 1] = current
			current = path[current]
		end
			for i = #backwardPath, 1, -1 do
				pathReturn[#pathReturn + 1] = backwardPath[i]
			end
		return pathReturn, pathLength
	else
		return false
	end
end


function wakaba:IsGridPassable(i, ground, general, ignorePits, fireIndices, room) -- fireIndices doubles as ignoreFires if set to true
	room = room or wakaba.G:GetRoom()
	local collision = room:GetGridCollision(i)
	if ground then
			if collision ~= 0 and (not ignorePits or collision ~= GridEntityType.GRID_PIT) then
					return false
			elseif not ignorePits then
					local grid = room:GetGridEntity(i)
					if grid
					and (grid.Desc.Type == GridEntityType.GRID_SPIKES or grid.Desc.Type == GridEntityType.GRID_SPIKES_ONOFF)
					and grid.State ~= SpikeState.SPIKE_OFF then
							return false
					end
			end
	end

	if general then
			if collision == GridCollisionClass.COLLISION_WALL or collision == GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
					return false
			end
--[[
			if fireIndices ~= true then
					if not fireIndices then
							for _, fire in ipairs(wakaba.G:GetRoom()Fires) do
									if fire.HitPoints > 1 and room:GetGridIndex(fire.Position) == i then
											return false
									end
							end
					elseif fireIndices[i] then
							return false
					end
			end ]]
	end

	return true
end

function wakaba:GetGridIndicesInRadius(pos, radius, room)
		room = room or wakaba.G:GetRoom()
		local width = room:GetGridWidth()
		local topLeft = room:GetGridIndex(room:GetClampedPosition(pos + Vector(-radius, -radius), 0))
		local bottomRight = room:GetGridIndex(room:GetClampedPosition(pos + Vector(radius, radius), 0))
		local minX, minY = wakaba:GridToVector(topLeft, width)
		local maxX, maxY = wakaba:GridToVector(bottomRight, width)

		local indices = {}

		for x = minX, maxX do
				for y = minY, maxY do
						local index = wakaba:VectorToGrid(x, y, width)
						if x ~= minX and x ~= maxX and y ~= minY and y ~= maxY then
								indices[#indices + 1] = index
						else
								local gridPos = room:GetGridPosition(index)
								if gridPos:DistanceSquared(pos) < (20 + radius) ^ 2 then
										indices[#indices + 1] = index
								end
						end
				end
		end

		return indices
end

function wakaba:CheckLine(posA, posB, radius, ground, general, ignorePits, ignoreFires)
		local room = wakaba.G:GetRoom()
		local diff = posB - posA
		local distance = diff:Length()
		local normal = diff / distance
		local numChecks = math.ceil(distance / radius)
		local checkedIndices = {}

		local fireIndices = false
		--[[ if general and not ignoreFires then
				fireIndices = {}
				for _, fire in ipairs(roomfires) do
						if fire.HitPoints > 1 then
								fireIndices[wakaba.G:GetRoom():GetGridIndex(fire.Position)] = true
						end
				end
		end ]]

		for i = 1, numChecks do
				local check = posA + (normal * radius * i)
				if not room:IsPositionInRoom(check, 0) then
						return false, check
				end

				local indices = wakaba:GetGridIndicesInRadius(check, radius, room)
				local collides = false
				for _, index in ipairs(indices) do
						if not checkedIndices[index] then
								checkedIndices[index] = true
								if not wakaba:IsGridPassable(index, ground, general, ignorePits, ignoreFires or fireIndices, room) then
										collides = true
										break
								end
						end
				end

				if collides then
						return false, check
				end
		end

		return true
end

---Makes entity follow the path, adding velocity/friction accordingly
---@param entity Entity
---@param speed number
---@param path table<integer, integer>
---@param useDirect? boolean @If the movement should be towards the first grid with free line check
---@param friction? number @default: entity.Friction
---@param ground? boolean @default: true
---@param general? boolean @default: true
---@param ignorePits? boolean
---@param ignoreFires? boolean
---@param reset? boolean @reset state of path following
---@return boolean done
function wakaba:FollowPath(entity, speed, path, useDirect, friction, ground, general, ignorePits, ignoreFires, reset)
		if ground == nil then ground = true end
		if general == nil then general = true end

		if #path == 0 then
			error("FollowPath error: empty path", 2)
		end

	local data = entity:GetData()
		if not data.PathIndex or reset then
				data.PathIndex = 1
		end

	if useDirect then
		local pathIndex
		for i = #path, data.PathIndex, -1 do
			local index = path[i]
			if wakaba:CheckLine(entity.Position, wakaba.G:GetRoom():GetGridPosition(index), 20, ground, general, ignorePits, ignoreFires) then
				pathIndex = i
				break
			end
		end

		if pathIndex then
			data.PathIndex = pathIndex
		end
	end

	local index = path[data.PathIndex]
		local currentIndex = wakaba.G:GetRoom():GetGridIndex(entity.Position)

		local done = false

	if index == currentIndex then
		data.PathIndex = data.PathIndex + 1
		if data.PathIndex >= #path then
			data.PathIndex = #path
			done = true
		end

		index = path[data.PathIndex]
	end

--	wakaba:DebugToString({path, "Index", index, "Length", #path, "PathIndex", data.PathIndex})

	if not index then
		error("Tried to follow nil index in path: pathIndex = " .. tostring(data.PathIndex))
	end

	local pos = wakaba.G:GetRoom():GetGridPosition(index)

	friction = friction or entity.Friction
	entity.Velocity = entity.Velocity * friction + (pos - entity.Position):Resized(speed)

	return done
end