--[[
	Maid Duet (메이드 듀엣) - 패시브(Passive)
	리라로 Beast 처치
	*** 키를 눌러 현재 소지 중인 액티브 슬롯과 카드/알약 슬롯을 서로 교체
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

wakaba.Blacklists.MaidDuet = {
	[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL_PASSIVE] = true,
	[CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES] = true,
	[CollectibleType.COLLECTIBLE_D_INFINITY] = true,
}
if not REPENTOGON then
	wakaba.Blacklists.MaidDuet[CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS] = true
	wakaba.Blacklists.MaidDuet[CollectibleType.COLLECTIBLE_JAR_OF_WISPS] = true
end
wakaba.Blacklists.MaidDuetCharges = {
	[CollectibleType.COLLECTIBLE_EVERYTHING_JAR] = true,
	[CollectibleType.COLLECTIBLE_WOODEN_NICKEL] = true,
}

wakaba.Blacklists.MaidDuetPlayers = {
	[PlayerType.PLAYER_CAIN_B] = true,
	[wakaba.Enums.Players.SHIORI] = true,
}

---@param player EntityPlayer
local function canUseMaidDuet(player, force)
	local active1 = player:GetActiveItem(ActiveSlot.SLOT_PRIMARY)
	local active2 = player:GetActiveItem(ActiveSlot.SLOT_POCKET)
	local extraCond = Isaac.RunCallback(wakaba.Callback.EVALUATE_MAID_DUET, player)
	return active1 > 0
		and not wakaba.Blacklists.MaidDuet[active1]
		and not wakaba.Blacklists.MaidDuet[active2]
		and not extraCond
		and (force or not player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.MAID_DUET))
end

---@param player EntityPlayer
wakaba:AddCallback(wakaba.Callback.EVALUATE_MAID_DUET, function(_, player)
	if wakaba.Blacklists.MaidDuetPlayers[player:GetPlayerType()] then
		return true
	end
end)

---@param player EntityPlayer
function wakaba:PlayerUpdate_MaidDuet(player)
	if not player:HasCollectible(wakaba.Enums.Collectibles.MAID_DUET) then return end
	if player.ControlsEnabled then
		--TODO 설정 가능 옵션으로 교체
		if (player.ControllerIndex == 0 and Input.IsButtonTriggered(Keyboard.KEY_8, player.ControllerIndex))
		or (player.ControllerIndex > 0 and Controller and Input.IsButtonPressed(Controller.STICK_RIGHT, player.ControllerIndex) and Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex)) then
			if canUseMaidDuet(player) then
				local duetPower = player:GetCollectibleNum(wakaba.Enums.Collectibles.MAID_DUET)
				local config = Isaac.GetItemConfig()

				local firstActive = player:GetActiveItem(ActiveSlot.SLOT_PRIMARY)
				local firstConfig = config:GetCollectible(firstActive)
				local firstCharge = player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) + player:GetBatteryCharge(ActiveSlot.SLOT_PRIMARY)

				local extraFirstCharge = 0
				if firstConfig:IsCollectible() then
					if firstConfig.ChargeType == ItemConfig.CHARGE_TIMED then
						extraFirstCharge = (firstConfig.MaxCharges * (duetPower - 1)) // 10
					elseif firstConfig.ChargeType == ItemConfig.CHARGE_TIMED then
						extraFirstCharge = duetPower - 1
					end
				end


				local secondActive = player:GetActiveItem(ActiveSlot.SLOT_POCKET)
				local secondCharge = 0
				local extraSecondCharge = 0
				if secondActive ~= 0 then
					local secondConfig = config:GetCollectible(secondActive)
					secondCharge = player:GetActiveCharge(ActiveSlot.SLOT_POCKET) + player:GetBatteryCharge(ActiveSlot.SLOT_POCKET)
					if secondConfig:IsCollectible() then
						if secondConfig.ChargeType == ItemConfig.CHARGE_TIMED then
							extraSecondCharge = (secondConfig.MaxCharges * (duetPower - 1)) // 10
						elseif secondConfig.ChargeType == ItemConfig.CHARGE_TIMED then
							extraSecondCharge = duetPower - 1
						end
					end
				end

				isc:setActiveItem(player, firstActive, ActiveSlot.SLOT_POCKET, firstCharge + extraFirstCharge)
				isc:setActiveItem(player, secondActive, ActiveSlot.SLOT_PRIMARY, secondCharge + extraSecondCharge)

				SFXManager():Play(SoundEffect.SOUND_DIVINE_INTERVENTION)

				player:AnimateCollectible(wakaba.Enums.Collectibles.MAID_DUET, "HideItem")
				player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.MAID_DUET)
			else
				SFXManager():Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_MaidDuet)

-- TODO 패밀리어 기능으로 교체
function wakaba:RoomClear_MaidDuet()
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.MAID_DUET) then
			player:GetEffects():RemoveCollectibleEffect(wakaba.Enums.Collectibles.MAID_DUET, -1)
		end
	end)
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.RoomClear_MaidDuet)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.RoomClear_MaidDuet)

if EID then
	local HotkeyToString = {}
	for key,num in pairs(Keyboard) do
		local keyString = key
		local keyStart, keyEnd = string.find(keyString, "KEY_")
		keyString = string.sub(keyString, keyEnd+1, string.len(keyString))
		keyString = string.gsub(keyString, "_", " ")
		HotkeyToString[num] = keyString
	end
	--convert controller enum to buttons
	local ControllerToString = { [0] = "{{ButtonDLeft}}", "{{ButtonDRight}}", "{{ButtonDUp}}", "{{ButtonDDown}}",
	"{{ButtonA}}", "{{ButtonB}}", "{{ButtonX}}", "{{ButtonY}}", "{{ButtonLB}}", "{{ButtonLT}}", "{{ButtonLStick}}",
	"{{ButtonRB}}", "{{ButtonRT}}", "{{ButtonRStick}}", "{{ButtonSelect}}", "{{ButtonMenu}}" }

	local function CaramellaCondition(descObj)
		if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE then
			return true
		end
		return false
	end
	local function CaramellaCallback(descObj)
		if descObj.ObjSubType == wakaba.Enums.Collectibles.MAID_DUET then
			local controllerEnabled = #wakaba:getAllMainPlayers() > 0
			local maidKey = HotkeyToString[Keyboard.KEY_8]
			local maidButton = controllerEnabled and ControllerToString[ButtonAction.ACTION_DROP]

			local append = ""
			if maidKey and maidButton then
				append = append .. maidKey .. "/{{ButtonLStick}}+" .. maidButton
			else
				append = append .. (maidKey or maidButton)
			end
			descObj.Description = descObj.Description:gsub("{wakaba_md1}", append)
		elseif wakaba:has_value(wakaba.Blacklists.MaidDuet, descObj.ObjSubType) then
			local append = EID:getDescriptionEntry("MaidDuetBlacklisted") or EID:getDescriptionEntryEnglish("MaidDuetBlacklisted")
			descObj.Description = descObj.Description .. "#" .. append
		end
		return descObj
	end
	EID:addDescriptionModifier("Wakaba Maid Duet", CaramellaCondition, CaramellaCallback)
end