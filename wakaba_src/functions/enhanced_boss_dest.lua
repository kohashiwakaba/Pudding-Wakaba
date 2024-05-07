--[[
	Enhanced Boss Dest
	게임 시작 시 랜덤 보스 설정
	보스 체력 설정
 ]]

local bossTables = {
	["BlueBaby"] = 0,
	["Lamb"] = 1,
	["MegaSatan"] = 2,
	["Delirium"] = 3,
	["Mother"] = 4,
	["Greed"] = 5,
	["Beast"] = 6,
}

function wakaba:GetBossDestinationData()
	local skip = false
	local bossData = {
		Boss = nil,
		Quality = nil,
	}
	for _, callbackData in pairs(Isaac.GetCallbacks(wakaba.Callback.BOSS_DESTINATION)) do
		local newData = callbackData.Function(callbackData.Mod)
		if type(newData) == "boolean" and newData == false then
			skip = true
			break
		elseif type(newData) == "table" and newData ~= nil then
			bossData.Boss = newData.Boss or bossData.Boss
			bossData.Quality = newData.Quality or bossData.Quality
		end
	end
	if skip then
		return false
	else
		return bossData
	end
end

wakaba:AddCallback(wakaba.Callback.BOSS_DESTINATION, function()
	return {
		Boss = wakaba.runstate.bossdest,
		Quality = wakaba.runstate.startquality,
	}
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, -2, function(_)
	local bossData = wakaba:GetBossDestinationData()
	if not bossData or type(bossData) ~= "table" or not bossData.Boss or not bossTables[bossData.Boss] then return end
	wakaba.globalHUDSprite:SetFrame("BossDestination", bossTables[bossData.Boss])
	local text = bossData.Text or bossData.Boss
	if bossData.Quality and type(bossData.Quality) == "number" then
		wakaba.globalHUDSprite:SetOverlayFrame("QualityFlag", bossData.Quality)
		text = "Q".. bossData.Quality .."|"..text
	end
	local tab = {
		Sprite = wakaba.globalHUDSprite,
		Text = text
	}
	return tab
end)