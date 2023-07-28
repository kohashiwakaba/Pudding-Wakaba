local GAME = Game()

local updateSprite

local CHARGE_METER_ANIMATIONS = {
	NONE = "",
	CHARGING = "Charging",
	START_CHARGED = "StartCharged",
	CHARGED = "Charged",
	DISAPPEAR = "Disappear"
}

local ANIMATIONS_LAST_FRAME = {
	CHARGING = 100,
	START_CHARGED = 11,
	CHARGED = 5,
	DISAPPEAR = 8
}

---@param sprite Sprite
---@param charge integer
local function returnToCharging(sprite, charge)
	sprite:SetAnimation(CHARGE_METER_ANIMATIONS.CHARGING)
	updateSprite(sprite, charge, CHARGE_METER_ANIMATIONS.CHARGING, -1)
end

---@param sprite Sprite
---@param charge integer
local function stopCharging(sprite, charge)
	sprite:SetAnimation(CHARGE_METER_ANIMATIONS.DISAPPEAR)
	updateSprite(sprite, charge, CHARGE_METER_ANIMATIONS.DISAPPEAR, -1)
end

local updateSpriteJumpTable = {
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.NONE] = function(sprite, charge, frame)
		if charge == -1 then return end

		returnToCharging(sprite, charge)
	end,
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.CHARGING] = function(sprite, charge, frame)
		if charge == -1 then
			stopCharging(sprite, charge)
			return
		end

		if frame == ANIMATIONS_LAST_FRAME.CHARGING then
			sprite:SetAnimation(CHARGE_METER_ANIMATIONS.START_CHARGED)
			updateSprite(sprite, charge, CHARGE_METER_ANIMATIONS.START_CHARGED, -1)
			return
		end

		sprite:SetFrame(charge)
	end,
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.START_CHARGED] = function(sprite, charge, frame)
		if charge == -1 then
			stopCharging(sprite, charge)
			return
		end

		if charge ~= ANIMATIONS_LAST_FRAME.CHARGING then
			returnToCharging(sprite, charge)
			return
		end

		if frame == ANIMATIONS_LAST_FRAME.START_CHARGED then
			sprite:SetAnimation(CHARGE_METER_ANIMATIONS.CHARGED)
			updateSprite(sprite, charge, CHARGE_METER_ANIMATIONS.CHARGED, -1)
			return
		end

		sprite:SetFrame(frame + 1)
	end,
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.CHARGED] = function(sprite, charge, frame)
		if charge == -1 then
			stopCharging(sprite, charge)
			return
		end

		if charge ~= ANIMATIONS_LAST_FRAME.CHARGING then
			returnToCharging(sprite, charge)
			return
		end

		if frame == ANIMATIONS_LAST_FRAME.CHARGED then
			sprite:SetFrame(0)
			return
		end

		sprite:SetFrame(frame + 1)
	end,
	---@param sprite Sprite
	---@param charge integer
	---@param frame? integer
	[CHARGE_METER_ANIMATIONS.DISAPPEAR] = function(sprite, charge, frame)
		if charge ~= -1 then
			returnToCharging(sprite, charge)
			return
		end

		if frame == ANIMATIONS_LAST_FRAME.DISAPPEAR then return end

		sprite:SetFrame(frame + 1)
	end
}

---@param sprite Sprite
---@param charge integer
---@param animation? string
---@param frame? integer
updateSprite = function(sprite, charge, animation, frame)
	animation = animation or sprite:GetAnimation()
	frame = frame or sprite:GetFrame()
	updateSpriteJumpTable[animation](sprite, charge, frame)
end

---@class ChargeMeter
---@field Sprite Sprite
local ChargeMeter = {}
---@param charge integer
function ChargeMeter:Update(charge)
	updateSprite(self.Sprite, charge)
end
---@param position Vector
---@param offset Vector
function ChargeMeter:RenderOnWorld(position, offset)
	local renderPosition = Isaac.WorldToScreen(position) + offset - GAME.ScreenShakeOffset
	self.Sprite:Render(renderPosition)
end
---@param position Vector
function ChargeMeter:RenderOnScreen(position)
	local renderPosition = position - GAME.ScreenShakeOffset
	self.Sprite:Render(renderPosition)
end

ChargeMeter__Mt = {
	__index = ChargeMeter,
	__newindex = function()
		error("Can't edit or add members to a read-only object.", 2)
	end
}

---@param anm2 string
---@param spriteSheet? string
---@return ChargeMeter
function NewChargeMeter(anm2, spriteSheet)
	local sprite = Sprite()
	local useDefaultSpriteSheet = spriteSheet == nil
	sprite:Load(anm2, useDefaultSpriteSheet)
	if useDefaultSpriteSheet then return setmetatable({Sprite = sprite}, ChargeMeter__Mt) end

	local layers = sprite:GetLayerCount()
	for i = 1, layers do
		---@diagnostic disable-next-line: param-type-mismatch
		sprite:ReplaceSpritesheet(i, spriteSheet)
	end
	sprite:LoadGraphics()

	return setmetatable({Sprite = sprite}, ChargeMeter__Mt)
end

return NewChargeMeter