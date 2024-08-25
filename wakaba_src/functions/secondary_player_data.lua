local isc = require("wakaba_src.libs.isaacscript-common")

-- TODO register secondary persistent player data
-- - [x] Lunar Stone
-- - [ ] Shiori Datas
-- - [x] Elixir of Life
-- - [x] Concentration
-- - [ ] Vintage Threat
-- - [x] Book of the Fallen
-- - [ ] Lunar Damocles
-- - [x] Challenge wb2
-- - [x] Wakaba's Nemesis
-- - [ ] Book of Shiori secondary

local rs = {
	run = {},
}
wakaba:saveDataManager("Wakaba secondary player data", rs)
wakaba.secondary_player_datas = rs

---@param player EntityPlayer
---@param entryKey string
function wakaba:hasPlayerDataEntry(player, entryKey)
	local playerIndex = tostring(isc:getPlayerIndex(player))
	rs.run[playerIndex] = rs.run[playerIndex] or {}
	local rd = rs.run[playerIndex]
	return rd[entryKey] ~= nil
end

---@param player EntityPlayer
---@param entryKey string
---@param count number
function wakaba:addPlayerDataCounter(player, entryKey, count)
	local playerIndex = tostring(isc:getPlayerIndex(player))
	rs.run[playerIndex] = rs.run[playerIndex] or {}
	local rd = rs.run[playerIndex]
	if rd[entryKey] and type(rd[entryKey]) == "number" then
		rs.run[playerIndex][entryKey] = rd[entryKey] + (count or 1)
	elseif not rd[entryKey] then
		rs.run[playerIndex][entryKey] = (count or 1)
	end
end

---@param player EntityPlayer
---@param entryKey string
---@param fallbackValue any
---@return any
function wakaba:getPlayerDataEntry(player, entryKey, fallbackValue)
	local playerIndex = tostring(isc:getPlayerIndex(player))
	rs.run[playerIndex] = rs.run[playerIndex] or {}
	return rs.run[playerIndex][entryKey] or fallbackValue
end

---@param player EntityPlayer
---@param entryKey string
---@param value any
function wakaba:setPlayerDataEntry(player, entryKey, value)
	local playerIndex = tostring(isc:getPlayerIndex(player))
	rs.run[playerIndex] = rs.run[playerIndex] or {}
	rs.run[playerIndex][entryKey] = value
end

---@param player EntityPlayer
---@param entryKey string
---@param value any
function wakaba:initPlayerDataEntry(player, entryKey, value)
	local playerIndex = tostring(isc:getPlayerIndex(player))
	rs.run[playerIndex] = rs.run[playerIndex] or {}
	local rd = rs.run[playerIndex]
	if not rd[entryKey] then
		rs.run[playerIndex][entryKey] = value
	end
end


---@param player EntityPlayer
---@param entryKey string
function wakaba:removePlayerDataEntry(player, entryKey)
	local playerIndex = tostring(isc:getPlayerIndex(player))
	rs.run[playerIndex] = rs.run[playerIndex] or {}
	rs.run[playerIndex][entryKey] = nil
end