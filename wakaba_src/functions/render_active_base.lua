-- Active item Render
-- From Fiend Folio, Made by Sanio (Sanio#5230), Modified by Connor

local renderActive = {}

local function GetScreenBottomRight()
	local hudOffset = Options.HUDOffset
	local offset = Vector(-hudOffset * 16, -hudOffset * 6)

	return Vector(Isaac.GetScreenWidth(), Isaac.GetScreenHeight()) + offset
end

local function GetScreenBottomLeft()
	local hudOffset = Options.HUDOffset
	local offset = Vector(hudOffset * 22, -hudOffset * 6)

	return Vector(0, Isaac.GetScreenHeight()) + offset
end

local function GetScreenTopRight()
	local hudOffset = Options.HUDOffset
	local offset = Vector(-hudOffset * 24, hudOffset * 12)
	
	return Vector(Isaac.GetScreenWidth(), 0) + offset
end

local function GetScreenTopLeft()
	local hudOffset = Options.HUDOffset
	local offset = Vector(hudOffset * 20, hudOffset * 12)

	return Vector.Zero + offset
end

local function GetActiveSlots(player, itemID)
	local slots = {}
	for i = 0, 3 do
		local activeItem = player:GetActiveItem(i)
		if not itemID or itemID == activeItem then
			table.insert(slots, i)
		end
	end
	return slots
end

local function GetAllMainPlayers()
	local mainPlayers = {}
	for i = 0, Game():GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		-- Make sure this player isn't the non-main twin, or an item-related spawned-in player like strawman.
		if player and player:Exists() and GetPtrHash(player:GetMainTwin()) == GetPtrHash(player)
				and (not player.Parent or player.Parent.Type ~= EntityType.ENTITY_PLAYER) then
			table.insert(mainPlayers, player)
		end
	end
	return mainPlayers
end

local function IsJudasBirthrightActive(player)
	local playerType = player:GetPlayerType()
	return (playerType == PlayerType.PLAYER_JUDAS or playerType == PlayerType.PLAYER_BLACKJUDAS) and
		player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
end

local function GetBookState(player)
	local hasVirtues = player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES)
	local hasBelial = IsJudasBirthrightActive(player)
	local bookState = (hasVirtues and hasBelial) and 2 or
		(hasVirtues or hasBelial) and 1 or 0

	return bookState
end

local numHUDPlayers = 1

local IndexedPlayers = {
	[1] = {
		PlayerPtr = nil,
		ScreenPos = function(player, slot)
			if player:GetPlayerType() ~= PlayerType.PLAYER_JACOB and (slot == ActiveSlot.SLOT_POCKET or slot == ActiveSlot.SLOT_POCKET2) then
				return GetScreenBottomRight()
			end
			return GetScreenTopLeft()
		end,
		Offset = {
			[ActiveSlot.SLOT_PRIMARY] = Vector(4, 0),
			[ActiveSlot.SLOT_SECONDARY] = Vector(-5, 0),
		},
		PocketOffset = {
			[0] = Vector(-36, -30),
			[1] = Vector(-20, -37),
			[2] = Vector(-20, -47),
			[3] = Vector(-20, -57),
		},
		JacobPocketOffset = {
			[0] = Vector(-13, 23),
			[1] = Vector(3, 16),
			[2] = Vector(3, 6),
			[3] = Vector(3, -4),
		},
	},
	[2] = {
		PlayerPtr = nil,
		ScreenPos = function() return GetScreenTopRight() end,
		Offset = {
			[ActiveSlot.SLOT_PRIMARY] = Vector(-155, 0),
			[ActiveSlot.SLOT_SECONDARY] = Vector(-164, 0),
		},
		PocketOffset = {
			[0] = Vector(-171, 26),
			[1] = Vector(-152, 35.5),
			[2] = Vector(-152, 33),
			[3] = Vector(-152, 30.5),
		},
	},
	[3] = {
		PlayerPtr = nil,
		ScreenPos = function() return GetScreenBottomLeft() end,
		Offset = {
			[ActiveSlot.SLOT_PRIMARY] = Vector(14, -39),
			[ActiveSlot.SLOT_SECONDARY] = Vector(5, -39),
		},
		PocketOffset = {
			[0] = Vector(-2, -13),
			[1] = Vector(17, -3.5),
			[2] = Vector(17, -6),
			[3] = Vector(17, -8.5),
		},
	},
	[4] = {
		PlayerPtr = nil,
		ScreenPos = function() return GetScreenBottomRight() end,
		Offset = {
			[ActiveSlot.SLOT_PRIMARY] = Vector(-163, -39),
			[ActiveSlot.SLOT_SECONDARY] = Vector(-172, -39),
		},
		PocketOffset = {
			[0] = Vector(-179, -13),
			[1] = Vector(-160, -3.5),
			[2] = Vector(-160, -6),
			[3] = Vector(-160, -8.5),
		},
	},
	-- (Player 1's Esau)
	[5] = {
		PlayerPtr = nil,
		ScreenPos = function() return GetScreenBottomRight() end,
		Offset = {
			[ActiveSlot.SLOT_PRIMARY] = Vector(-36, -39),
			[ActiveSlot.SLOT_SECONDARY] = Vector(-10, -39),
		},
		PocketOffset = {
			[0] = Vector(-31, -62),
			[1] = Vector(-15, -69),
			[2] = Vector(-15, -79),
			[3] = Vector(-15, -89),
		},
	},
}

local function GetIndexedPlayer(i)
	if not IndexedPlayers[i] then return end
	local player = IndexedPlayers[i].PlayerPtr and IndexedPlayers[i].PlayerPtr.Ref and IndexedPlayers[i].PlayerPtr.Ref:ToPlayer()
	if not player or not player:Exists() then
		IndexedPlayers[i].PlayerPtr = nil
		return nil
	end
	return player
end

local function GetChargebarOffset(player, slot)
	if GetPtrHash(player:GetMainTwin()) ~= GetPtrHash(player) then
		return (slot == ActiveSlot.SLOT_SECONDARY) and Vector(38, 17) or Vector(0, 17)
	end
	return (slot == ActiveSlot.SLOT_SECONDARY) and Vector(-2, 17) or Vector(34, 17)
end

local stuffToRender = {
	--[[ -------- EXAMPLE --------
	{
		ItemID = Isaac.GetItemIdByName("MyItem"),
		Anm2Filename = "gfx/render_myitem.anm2",
		StartFrame = 0,
		Update = function(player, activeSlot, params)
			params.Sprite:SetFrame("anim", 4)
		end,
		Condition = function(player, activeSlot) --If you want to make a condition for it to render at all
			return true
		end
	},
	]]
}

function renderActive:Add(tab)
	if not tab.Sprite then
		tab.Sprite = Sprite()
		tab.Sprite:Load(tab.Anm2Filename, true)
		tab.Sprite:Play(tab.Animation or tab.Sprite:GetDefaultAnimation(), true)
		tab.Sprite:SetFrame(tab.Animation or tab.Sprite:GetDefaultAnimation(), tab.StartFrame or 0)
	end
	tab.Offset = tab.Offset or Vector.Zero
	if tab.RenderAbove == nil then
		tab.RenderAbove = true
	end
	table.insert(stuffToRender, tab)
	return tab
end

-- Pause menu state tracking.
local PAUSE_STATES = {
	UNPAUSED = {
		[ButtonAction.ACTION_PAUSE] = "RESUME",
		[ButtonAction.ACTION_MENUBACK] = "RESUME",
		[Keyboard.KEY_GRAVE_ACCENT] = "IN_CONSOLE",
	},
	UNPAUSING = {},
	OPTIONS = {
		[ButtonAction.ACTION_PAUSE] = "UNPAUSING",
		[ButtonAction.ACTION_MENUBACK] = "UNPAUSING",
		[ButtonAction.ACTION_MENUCONFIRM] = "IN_OPTIONS",
		[ButtonAction.ACTION_MENUDOWN] = "RESUME",
		[ButtonAction.ACTION_MENUUP] = "EXIT",
		[Keyboard.KEY_GRAVE_ACCENT] = "UNPAUSING",
	},
	RESUME = {
		[ButtonAction.ACTION_PAUSE] = "UNPAUSING",
		[ButtonAction.ACTION_MENUBACK] = "UNPAUSING",
		[ButtonAction.ACTION_MENUCONFIRM] = "UNPAUSING",
		[ButtonAction.ACTION_MENUDOWN] = "EXIT",
		[ButtonAction.ACTION_MENUUP] = "OPTIONS",
		[Keyboard.KEY_GRAVE_ACCENT] = "UNPAUSING",
	},
	EXIT = {
		[ButtonAction.ACTION_PAUSE] = "UNPAUSING",
		[ButtonAction.ACTION_MENUBACK] = "UNPAUSING",
		[ButtonAction.ACTION_MENUDOWN] = "OPTIONS",
		[ButtonAction.ACTION_MENUUP] = "RESUME",
		[Keyboard.KEY_GRAVE_ACCENT] = "UNPAUSING",
	},
	IN_OPTIONS = {
		Ignore = ButtonAction.ACTION_PAUSE,
		[ButtonAction.ACTION_MENUBACK] = "OPTIONS",
		[Keyboard.KEY_GRAVE_ACCENT] = "UNPAUSING",
	},
	IN_CONSOLE = {
		[ButtonAction.ACTION_PAUSE] = "IN_CONSOLE",
		[ButtonAction.ACTION_MENUBACK] = "UNPAUSED",
	},
}

local wasPausedLastFrame = false
local currentPauseState = "UNPAUSED"

local function UpdatePauseTrackingState()
	local isPaused = Game():IsPaused()
	local pausedLastFrame = wasPausedLastFrame
	wasPausedLastFrame = isPaused
	
	if not Game():IsPaused() then
		currentPauseState = "UNPAUSED"
		currentAnim = nil
		return
	elseif currentPauseState == "UNPAUSED" and pausedLastFrame then
		return
	end
	
	local cid = Game():GetPlayer(0).ControllerIndex
	
	if PAUSE_STATES[currentPauseState].Ignore and Input.IsActionTriggered(PAUSE_STATES[currentPauseState].Ignore, cid) then
		return
	end
	
	for buttonAction, state in pairs(PAUSE_STATES[currentPauseState]) do
		if type(buttonAction) == "number" and (Input.IsActionTriggered(buttonAction, cid) or Input.IsButtonTriggered(buttonAction, cid)) then
			currentPauseState = state
			return
		end
	end
end

-- Darkens sprite colors to align with pause state, etc.
local function UpdateSpriteColor(playerIndex, activeSlot, params)
	local sprite = params.Sprite
	
	if not params.FadeData then
		params.FadeData = {}
	end
	if not params.FadeData[activeSlot] then
		params.FadeData[activeSlot] = {}
	end
	local fadeData = params.FadeData[activeSlot]
	
	local target
	if currentPauseState == "UNPAUSED" or currentPauseState == "UNPAUSING" or UNINTRUSIVEPAUSEMENU then
		target = 1.0
	else
		target = 0.5
	end
	
	-- J&E's pocket items fade out unless the swap key is held.
	local player = GetIndexedPlayer(playerIndex)
	if player and ((playerIndex == 1 and player:GetPlayerType() == PlayerType.PLAYER_JACOB) or playerIndex == 5)
			and (activeSlot == ActiveSlot.SLOT_POCKET or activeSlot == ActiveSlot.SLOT_POCKET2) ~= Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex) then
		target = target * 0.5
	end
	
	local speed = 0.1
	if currentPauseState == "UNPAUSING" then
		speed = 0.03
	end
	
	local alreadyUpdated = (fadeData.LastUpdate == Isaac.GetFrameCount())
	local current = fadeData.Value or 1.0
	local new = current
	if not alreadyUpdated and target > current then
		new = math.min(current + speed, target)
	elseif not alreadyUpdated and target < current then
		new = math.max(current - speed, target)
	else
		new = current
	end
	fadeData.Value = new
	fadeData.LastUpdate = Isaac.GetFrameCount()
	
	if params.Color then
		if new >= 1.0 then
			sprite.Color = params.Color
		else
			local colorCopy = Color.Lerp(params.Color, Color(0,0,0,params.Color.A), 0)
			colorCopy:SetTint(0,0,0, colorCopy.A)
			sprite.Color = Color.Lerp(params.Color, colorCopy, 1 - new)
		end
	else
		sprite.Color = Color(new, new, new, 1.0)
	end
end

local function AddActivePlayers(i, player)

	IndexedPlayers[i].PlayerPtr = EntityPtr(player)
	
	if i == 1 and player:GetOtherTwin()
			and player:GetOtherTwin():GetPlayerType() == PlayerType.PLAYER_ESAU
			and not GetIndexedPlayer(5) then
		IndexedPlayers[5].PlayerPtr = EntityPtr(player:GetOtherTwin())
	end
end

-- If the number of players changes, or a player "transforms" into another (Bazarus/EsauJr) then
-- we should remap the player's hud slots just in case.
local function ShouldRefreshPlayers(players)
	if #players ~= numHUDPlayers or (Game():GetFrameCount() == 0 and GetIndexedPlayer(1)) then
		return true
	end

	for i=1, 5 do
		local actualPlayer = players[i]
		local indexedPlayer = GetIndexedPlayer(i)

		-- Checking for stuff like Bazarus or Esau Jr turning a player into another, seperate player.
		if actualPlayer and indexedPlayer and actualPlayer.InitSeed ~= indexedPlayer.InitSeed then
			return true
		end
	end
end

function renderActive:UpdatePlayers()
	local players = GetAllMainPlayers()

	if ShouldRefreshPlayers(players) then
		numHUDPlayers = #players
		for i = 1, 5 do
			IndexedPlayers[i].PlayerPtr = nil
		end
	end

	for i = 1, 4 do
		if players[i] and not GetIndexedPlayer(i) then
			AddActivePlayers(i, players[i])
		end
	end
end

-- Returns which pocket slot a pocket active is in, or nil if none is held.
-- We can determine which slots contain actives, but if two pocket actives
-- are held, we cannot tell which is which. So unfortunately, this function
-- will just assume that the first active item it finds is SLOT_POCKET, and
-- that the second is SLOT_POCKET2.
local function GetPocketSlotForActiveSlot(player, activeSlot)
	if activeSlot ~= ActiveSlot.SLOT_POCKET and activeSlot ~= ActiveSlot.SLOT_POCKET2 then
		return
	end
	if player:GetActiveItem(activeSlot) == 0 then
		return 0
	end
	
	local twoPocketActives = player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= 0 and player:GetActiveItem(ActiveSlot.SLOT_POCKET2) ~= 0
	local foundFirstActive = false
	
	for i=0, player:GetMaxPocketItems()-1 do
		if player:GetCard(i) == 0 and player:GetPill(i) == 0 then
			-- No card or pill in this slot, so it must be an active item.
			
			-- If both actives are present, assume the first one we find is SLOT_POCKET,
			-- because we have no known way of actually checking that yet.
			if foundFirstActive or not twoPocketActives or activeSlot == ActiveSlot.SLOT_POCKET then
				return i
			end
			foundFirstActive = true
		end
	end
	
	return 0
end

function renderActive:RenderActiveItem(renderAbove)
	if not Game():GetHUD():IsVisible() then return end

	for i = 1, #IndexedPlayers do
		local playerInfo = IndexedPlayers[i]
		local player = GetIndexedPlayer(i)

		if player then
			for _, params in pairs(stuffToRender) do
				if params.RenderAbove == renderAbove and (not params.ItemID or player:HasCollectible(params.ItemID)) then
					local slots = GetActiveSlots(player, params.ItemID)
					for k = 1, #slots do
						local activeSlot = slots[k]
						if ((params.Condition == nil) or (params.Condition ~= nil and params.Condition(player, activeSlot) == true)) then
							if params.Update then
								params.Update(player, activeSlot, params)
							end
							local pos = playerInfo.ScreenPos(player, activeSlot)
							local size
							if activeSlot == ActiveSlot.SLOT_POCKET or activeSlot == ActiveSlot.SLOT_POCKET2 then
								local pocketSlot = GetPocketSlotForActiveSlot(player, activeSlot)
								if i == 1 and player:GetPlayerType() == PlayerType.PLAYER_JACOB then
									pos = pos + playerInfo.JacobPocketOffset[pocketSlot]
								else
									pos = pos + playerInfo.PocketOffset[pocketSlot]
								end
								if i == 1 or i == 5 then
									size = pocketSlot == 0 and 1 or 0.5
								else
									size = pocketSlot == 0 and 0.5 or 0.25
								end
							else
								pos = pos + playerInfo.Offset[activeSlot]
								size = activeSlot == ActiveSlot.SLOT_PRIMARY and 1 or 0.5
							end
							local bookOffset = activeSlot == ActiveSlot.SLOT_PRIMARY and GetBookState(player) > 0 and -4 or 0
							UpdateSpriteColor(i, activeSlot, params)
							params.Sprite.Scale = Vector(size, size)
							local offset = Vector(params.Offset.X, params.Offset.Y + bookOffset)
							if params.IsChargeBar then
								offset = offset + GetChargebarOffset(player, activeSlot)
							end
							params.Sprite.Offset = offset * size
							local topLeftClamp = params.TopLeftClamp or Vector.Zero
							local bottomRightClamp = params.BottomRightClamp or Vector.Zero
							params.Sprite:Render(pos, topLeftClamp, bottomRightClamp)
						end
					end
				end
			end
		end
	end
end

--MC_POST_RENDER
function renderActive:OnRender()
	renderActive:UpdatePlayers()
	UpdatePauseTrackingState()
	renderActive:RenderActiveItem(false)
end

--MC_GET_SHADER_PARAMS
--Call this on a blank shader that renders above HUD
function renderActive:OnGetShaderParams()
	renderActive:RenderActiveItem(true)
end

--MC_POST_UPDATE
function renderActive:OnUpdate()
	for _, params in pairs(stuffToRender) do
		params.Sprite:Update()
	end
end

function renderActive:ResetOnGameStart()
	for i = 1, 4 do
		IndexedPlayers[i].PlayerPtr = nil
	end
end

return renderActive
