--[[ 도박런

]]

local pedestal_data = {
	run = {
		ascentSharedSeeds = {},
	},
	level = {
		wakabaPedestals = {},
	},
}
wakaba:saveDataManager("Wakaba Difficulty Run", pedestal_data)

local edfa = 0
local cpfa = 0

local function shouldCheckAscent()
	local room = wakaba.G:GetRoom()
	return room:GetType() == RoomType.ROOM_BOSS or room:GetType() == RoomType.ROOM_TREASURE
end

function wakaba:setGamblePedestalStatus(set, t, prevCount)
	local s = set and "1" or "0"
	local pedestals = wakaba:GetPedestals(true)
	if pedestals and (prevCount and (prevCount > 0 and #pedestals == prevCount) or #pedestals > 0) then
		for i, p in ipairs(pedestals) do
			local pickup = p.Pedestal
			pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)] = s
			if shouldCheckAscent() then
				pedestal_data.run.ascentSharedSeeds[wakaba:getPickupIndex(pickup)] = pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)]
			end
		end
		SFXManager():Play(SoundEffect.SOUND_THUMBSUP)
		if t == "ed" then
			edfa = 1
		elseif t == "cp" then
			cpfa = 1
		end
	else
		SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN)
		if t == "ed" then
			edfa = -1
		elseif t == "cp" then
			cpfa = -1
		end
	end
end

function wakaba:isGamblePedestalAllowed(pickup)
	local floorCheck = pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)]
	local ascentCheck = pedestal_data.run.ascentSharedSeeds[wakaba:getPickupIndex(pickup)]

	local isShop = pickup:IsShopItem()

	local canGetAll = (ascentCheck == "1" or floorCheck == "1")
	local canGetNonShop = not isShop and (ascentCheck == "2" or floorCheck == "2")

	return canGetAll or canGetNonShop
end

function wakaba:setUpDownPedestalStatus(pickup, result)
	pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)] = pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)] or {}
	pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)][tostring(result)] = true
	if shouldCheckAscent() then
		pedestal_data.run.ascentSharedSeeds[wakaba:getPickupIndex(pickup)] = pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)]
	end
end

function wakaba:isUpDownPedestalAllowed(pickup)
	if pickup.Touched then return true end
	local floorCheck = pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)]
	local ascentCheck = pedestal_data.run.ascentSharedSeeds[wakaba:getPickupIndex(pickup)]

	local allowed = (floorCheck and floorCheck[tostring(pickup.SubType)]) or (ascentCheck and ascentCheck[tostring(pickup.SubType)])

	local cycle = pickup:GetCollectibleCycle()
	for _, id in ipairs(cycle) do
		if (floorCheck or floorCheck[tostring(id)]) or (ascentCheck or ascentCheck[tostring(id)]) then
			allowed = true
			break
		end
	end

	return allowed
end

local isc = _wakaba.isc

local difficultyWidget = Sprite("gfx/ui/wakaba/wakaba_diff.anm2")

wakaba:AddPriorityCallback("DIFFLIB_MC_PRE_ADD_AFTERBIRTH_DIFFICULTIES", 1, function(_)
	if DifficultyManager then
		if DifficultyManager.GetDifficultyIdByName("Gamble") then
			DifficultyManager.ClearDifficulty("Gamble")
		end
		if DifficultyManager.GetDifficultyIdByName("UpDown") then
			DifficultyManager.ClearDifficulty("UpDown")
		end
		DifficultyManager.AddDifficulty("Gamble", difficultyWidget, Difficulty.DIFFICULTY_HARD)
		DifficultyManager.AddDifficulty("UpDown", difficultyWidget, Difficulty.DIFFICULTY_HARD)
	end
end)

---@param player EntityPlayer
function wakaba:PlayerUpdate_GambleRun(player)
	if not DifficultyManager then return end

	if DifficultyManager.GetDifficulty() == "Gamble" then

		local extraLeft = wakaba:getOptionValue("gdkey")
		local extraRight = wakaba:getOptionValue("gpkey")
		local extraLeftCont = Keyboard.KEY_6
		local extraRightCont = Keyboard.KEY_7

		local lastUsed = player:GetData().w_lastGambleUsed
		local lastCount = player:GetData().w_lastGambleCount

		if lastUsed then
			wakaba:setGamblePedestalStatus(lastUsed == "cp", lastUsed, lastCount)
		end

		player:GetData().w_lastGambleUsed = nil
		player:GetData().w_lastGambleCount = nil

		local shift = 0
		local currFrame = wakaba.G:GetFrameCount()
		if currFrame > wakaba._keyPressFrame then
			if Input.IsButtonTriggered(extraLeft, 0)
				or Input.IsButtonTriggered(extraLeftCont, player.ControllerIndex)
			then
				player:UseActiveItem(CollectibleType.COLLECTIBLE_ETERNAL_D6, UseFlag.USE_NOANIM | UseFlag.USE_VOID)
				wakaba._keyPressFrame = currFrame
				return
			end
			if Input.IsButtonTriggered(extraRight, 0)
				or Input.IsButtonTriggered(extraRightCont, player.ControllerIndex)
			then
				player:UseActiveItem(CollectibleType.COLLECTIBLE_CROOKED_PENNY, UseFlag.USE_NOANIM | UseFlag.USE_VOID)
				wakaba._keyPressFrame = currFrame
				return
			end
		end
	elseif wakaba:hasShifter(player) then

	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_GambleRun)

function wakaba:UseItem_GambleRun(useditem, rng, player, useflag, slot, vardata)
	if not DifficultyManager then return end
	if DifficultyManager.GetDifficulty() == "Gamble" then
		local pedestals = wakaba:GetPedestals(true)
		if useditem == CollectibleType.COLLECTIBLE_ETERNAL_D6 then
			player:GetData().w_lastGambleUsed = "ed"
			player:GetData().w_lastGambleCount = #pedestals
			player:AnimateCollectible(useditem, "HideItem", "PlayerPickup")
		elseif useditem == CollectibleType.COLLECTIBLE_CROOKED_PENNY then
			player:GetData().w_lastGambleUsed = "cp"
			player:GetData().w_lastGambleCount = #pedestals
			player:AnimateCollectible(useditem, "HideItem", "PlayerPickup")
		elseif useditem == CollectibleType.COLLECTIBLE_DIPLOPIA then
			wakaba:setGamblePedestalStatus(true)
			player:AnimateCollectible(useditem, "HideItem", "PlayerPickup")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.UseItem_GambleRun, CollectibleType.COLLECTIBLE_ETERNAL_D6)
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.UseItem_GambleRun, CollectibleType.COLLECTIBLE_CROOKED_PENNY)
wakaba:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, wakaba.UseItem_GambleRun, CollectibleType.COLLECTIBLE_DIPLOPIA)

function wakaba:PickupCollision_GambleRun(pickup, colliders, low)
	if isc:inDeathCertificateArea() or isc:inGenesisRoom() or not DifficultyManager then return end
	if pickup.Touched then return end
	if DifficultyManager.GetDifficulty() == "Gamble" and not wakaba:isGamblePedestalAllowed(pickup) then
		local id = pickup.SubType
		local config = Isaac.GetItemConfig():GetCollectible(id)
		if not config or not config:HasTags(ItemConfig.TAG_QUEST) then
			return pickup:IsShopItem()
		end
	elseif wakaba:hasShifter() and not wakaba:isUpDownPedestalAllowed(pickup) then
		local id = pickup.SubType
		local config = Isaac.GetItemConfig():GetCollectible(id)
		if not config or not config:HasTags(ItemConfig.TAG_QUEST) then
			return pickup:IsShopItem()
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, CallbackPriority.IMPORTANT, wakaba.PickupCollision_GambleRun, PickupVariant.PICKUP_COLLECTIBLE)

function wakaba:PostRestock_GambleRun(partial)
	if not DifficultyManager then return end
	if DifficultyManager.GetDifficulty() == "Gamble" then
		local pedestals = wakaba:GetPedestals(true)
		for i, p in ipairs(pedestals) do
			local pickup = p.Pedestal ---@type EntityPickup
			if not (partial and pickup.FrameCount > 0) and (pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)] == "1") then
				pedestal_data.level.wakabaPedestals[wakaba:getPickupIndex(pickup)] = "2"
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RESTOCK_SHOP, wakaba.PostRestock_GambleRun)

function wakaba:PickupRender_GambleRun(pickup, offset)
	if isc:inDeathCertificateArea() or isc:inGenesisRoom() or not DifficultyManager then return end
	if (DifficultyManager.GetDifficulty() == "Gamble" and not wakaba:isGamblePedestalAllowed(pickup))
	or (wakaba:hasShifter() and not wakaba:isUpDownPedestalAllowed(pickup)) then
		local pickupData = pickup:GetData()
		local sprite = pickup:GetSprite()
		local id = pickup.SubType
		local config = Isaac.GetItemConfig():GetCollectible(id)
		if not config or not config:HasTags(ItemConfig.TAG_QUEST) then
			if not pickupData.wakaba_tempTint then
				pickupData.wakaba_tempTint = sprite.Color
			end
			local tcolor = Color(1, 1, 1, 0.5, 0, 0, 0)
			sprite.Color = tcolor
		else
			if pickupData.wakaba_tempTint then
				local oldColor = pickupData.wakaba_tempTint
				local newColor = Color(oldColor.R, oldColor.G, oldColor.B, oldColor.A, oldColor.RO, oldColor.GO, oldColor.BO)
				newColor:Reset()
				sprite.Color = newColor
				pickupData.wakaba_tempTint = nil
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, wakaba.PickupRender_GambleRun, PickupVariant.PICKUP_COLLECTIBLE)


---@param selected CollectibleType
---@param selectedItemConf ItemConfigItem
---@param itemPoolType ItemPoolType
---@param decrease boolean
---@param seed integer
wakaba:AddCallback(wakaba.Callback.WAKABA_COLLECTIBLE_REROLL_BLACKLIST, function(_, selected, selectedItemConf, rerollProps, itemPoolType, decrease, seed, isCustom)
	if not DifficultyManager then return end
	if DifficultyManager.GetDifficulty() == "Gamble" or wakaba:hasShifter() then
		if wakaba.Blacklists.GambleRun[selected] then
			wakaba.Log("Blacklisted item", selected, "from gamble run")
			return true
		end
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, -90, function(_)
	if not DifficultyManager then return end
	if DifficultyManager.GetDifficulty() == "Gamble" then
		local k = wakaba:getOptionValue("gpkey") or Keyboard.KEY_7
		wakaba.globalHUDSprite:RemoveOverlay()
		wakaba.globalHUDSprite:SetFrame("Gamble", 0)
		local room = Game():GetRoom()
		local string = "["..wakaba.HotkeyToString[k].."]"
		local frame = 0
		local textColor = KColor(1, 1, 1, 0.5, 0, 0, 0)
		if cpfa > 0 then
			textColor = KColor(1 - cpfa, 1, 1 - cpfa, 0.5, 0, 0, 0)
			cpfa = cpfa - 0.04
		elseif cpfa < 0 then
			textColor = KColor(1, 1 + cpfa, 1 + cpfa, 0.5, 0, 0, 0)
			cpfa = cpfa + 0.04
		end

		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = string,
			TextColor = textColor,
			--Location = loc,
			SpriteOptions = {
				Anim = "Gamble",
				Frame = frame,
			},
		}
		return tab
	end
end)

wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, -89, function(_)
	if not DifficultyManager then return end
	if DifficultyManager.GetDifficulty() == "Gamble" then
		local k = wakaba:getOptionValue("gdkey") or Keyboard.KEY_6
		wakaba.globalHUDSprite:RemoveOverlay()
		wakaba.globalHUDSprite:SetFrame("Gamble", 1)
		local room = Game():GetRoom()
		local string = "["..wakaba.HotkeyToString[k].."]"
		local frame = 1
		local textColor = KColor(1, 1, 1, 0.5, 0, 0, 0)
		if edfa > 0 then
			textColor = KColor(1 - edfa, 1, 1 - edfa, 0.5, 0, 0, 0)
			edfa = edfa - 0.04
		elseif edfa < 0 then
			textColor = KColor(1, 1 + edfa, 1 + edfa, 0.5, 0, 0, 0)
			edfa = edfa + 0.04
		end

		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = string,
			TextColor = textColor,
			--Location = loc,
			SpriteOptions = {
				Anim = "Gamble",
				Frame = frame,
			},
		}
		return tab
	end
end)