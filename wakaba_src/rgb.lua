--Total credit to patczuch, creator of the RGB Tainted Apollyon mod!

local redChangeAmount = 1
local greenChangeAmount = 1
local blueChangeAmount = 1
local colorsToCycle = { { 0, 0, 0 }, { 255, 255, 255 } }
local currentColor = 1
local rgb = true
local rgbSpeed = 10
local setR = 0
local setG = 0
local setB = 0
local defaultCycle = true
local lastDefaultCycle = false
local refresh = false

function wakaba:cycleRGB()
	if defaultCycle then
		if wakaba.RGB.R > 0 and wakaba.RGB.B == 0 then
			wakaba.RGB.R = wakaba.RGB.R - 1
			wakaba.RGB.G = wakaba.RGB.G + 1
		end
		if wakaba.RGB.G > 0 and wakaba.RGB.R == 0 then
			wakaba.RGB.G = wakaba.RGB.G - 1
			wakaba.RGB.B = wakaba.RGB.B + 1
		end
		if wakaba.RGB.B > 0 and wakaba.RGB.G == 0 then
			wakaba.RGB.R = wakaba.RGB.R + 1
			wakaba.RGB.B = wakaba.RGB.B - 1
		end
		currentColor = 1
	else
		if wakaba.RGB.R > colorsToCycle[currentColor][1] then
			wakaba.RGB.R = wakaba.RGB.R - redChangeAmount
		end
		if wakaba.RGB.R < colorsToCycle[currentColor][1] then
			wakaba.RGB.R = wakaba.RGB.R + redChangeAmount
		end
		if wakaba.RGB.G > colorsToCycle[currentColor][2] then
			wakaba.RGB.G = wakaba.RGB.G - greenChangeAmount
		end
		if wakaba.RGB.G < colorsToCycle[currentColor][2] then
			wakaba.RGB.G = wakaba.RGB.G + greenChangeAmount
		end
		if wakaba.RGB.B > colorsToCycle[currentColor][3] then
			wakaba.RGB.B = wakaba.RGB.B - blueChangeAmount
		end
		if wakaba.RGB.B < colorsToCycle[currentColor][3] then
			wakaba.RGB.B = wakaba.RGB.B + blueChangeAmount
		end

		if (math.floor(wakaba.RGB.R) == colorsToCycle[currentColor][1] and math.floor(wakaba.RGB.G) == colorsToCycle[currentColor][2] and math.floor(wakaba.RGB.B) == colorsToCycle[currentColor][3]) or refresh then
			local prevColor = currentColor
			currentColor = currentColor + 1
			if #colorsToCycle < currentColor then
				currentColor = 1
			end
			redChangeAmount = math.abs(colorsToCycle[currentColor][1] - colorsToCycle[prevColor][1]) / 255
			greenChangeAmount = math.abs(colorsToCycle[currentColor][2] - colorsToCycle[prevColor][2]) / 255
			blueChangeAmount = math.abs(colorsToCycle[currentColor][3] - colorsToCycle[prevColor][3]) / 255
			refresh = false
		end
	end
end

function wakaba:Render_RGB()
	if defaultCycle ~= lastDefaultCycle then
		if defaultCycle then
			wakaba.RGB.R = 255
			wakaba.RGB.G = 0
			wakaba.RGB.B = 0
		else
			wakaba.RGB.R = colorsToCycle[currentColor][1]
			wakaba.RGB.G = colorsToCycle[currentColor][2]
			wakaba.RGB.B = colorsToCycle[currentColor][3]
		end
	end
	lastDefaultCycle = defaultCycle
	if rgbSpeed < 0 and wakaba.game:GetFrameCount() % -(rgbSpeed - 1) == 0 then
		wakaba:cycleRGB()
	elseif rgbSpeed > 0 then
		for i = 1, rgbSpeed do
			wakaba:cycleRGB()
		end
	end
end
