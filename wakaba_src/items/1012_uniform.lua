local usinguniform = false
local displayuniformslot = false
--wakaba.f:DrawString("droid",60,50,KColor(1,1,1,1,0,0,0),0,true) -- render string with loaded font on position 60x50y
local isc = require("wakaba_src.libs.isaacscript-common")

-- wakaba_compat_check : Fiend Folio
local isFFPill = {}
if FiendFolio then
  do
    for i = 1, #FiendFolio.FFPillColours do
      isFFPill[FiendFolio.FFPillColours[i]] = true
    end
  end
end


function wakaba:BlacklistUniform(pickuptype, effect)
	if pickuptype == "card" then
		if not wakaba:has_value(wakaba.Blacklists.Uniform.Cards, effect) then
			table.insert(wakaba.Blacklists.Uniform.Cards, effect)
		end
	elseif pickuptype == "pilleffect" or pickuptype == "pill" then
		if not wakaba:has_value(wakaba.Blacklists.Uniform.PillEffect, effect) then
			table.insert(wakaba.Blacklists.Uniform.PillEffect, effect)
		end
	elseif pickuptype == "pillcolor" then
		if not wakaba:has_value(wakaba.Blacklists.Uniform.PillColor, effect) then
			table.insert(wakaba.Blacklists.Uniform.PillColor, effect)
		end
	end
end

function wakaba:Render_Uniform()
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex) then
			if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == wakaba.Enums.Collectibles.UNIFORM then
				--print("Drop Button pressed.")
				local index = player:GetData().wakaba.uniform.cursor
				if index == nil then
					index = 1
				end
				index = index + 1
				if index > wakaba.Enums.Constants.WAKABA_UNIFORM_MAX_SLOTS then
					index = 1
				end
				player:GetData().wakaba.uniform.cursor = index
			end
		end
	end
end

function wakaba:render32()

  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex) then
			if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == wakaba.Enums.Collectibles.UNIFORM then
				--print("Drop Button pressed.")
				local index = player:GetData().wakaba.uniform.cursor
				if index == nil then
					index = 1
				end
				index = index + 1
				if index > wakaba.Enums.Constants.WAKABA_UNIFORM_MAX_SLOTS then
					index = 1
				end
				player:GetData().wakaba.uniform.cursor = index
				--print("Current Index = .", index)
				--print("Selected Type = .", player:GetData().wakaba.uniform.items[index].type)
				--print("Selected Card/Pill = .", player:GetData().wakaba.uniform.items[index].cardpill)
			end
		end
	end
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		--if Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex)
		if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM, true)
		and wakaba.G:GetHUD():IsVisible()
		then
			local alpha = wakaba.runstate.currentalpha / 100
			local scale = wakaba.state.options.uniformscale / 100
			local ypos = 10
			local eidstring = ""
			local preservedslotstate = false
			local itemConfig = Isaac.GetItemConfig()
			for i,item in pairs(player:GetData().wakaba.uniform.items) do
				local c = ""
				if player:GetData().wakaba.uniform.cursor == i then
					c = "> "
					eidstring = eidstring .. "#{{CoinHeart}} {{ColorGold}}"
				else
					eidstring = eidstring .. "#{{Blank}} "
				end
				ypos = 10 + (10 * tonumber(i))
				ypos = ypos - wakaba.G.ScreenShakeOffset.Y
				--print("using ", item.cardpill)
				if item.type == "card" then
				--print("cardname ", wakaba.cardname[item.cardpill][2])
					--Isaac.RenderText(c .. wakaba.cardname[item.cardpill][2], 155, ypos, 1, 1, 1, 255)
					local str = (EID and EID:getObjectName(5, PickupVariant.PICKUP_TAROTCARD, item.cardpill)) or itemConfig:GetCard(item.cardpill).Name
					eidstring = eidstring .. "{{Card" .. item.cardpill .. "}} " .. str
					if player:GetData().wakaba.uniform.cursor == i then
						preservedslotstate = true
					end
				elseif item.type == "pill" then
					if wakaba.G:GetItemPool():IsPillIdentified(item.cardpill) then
						local str = (EID and EID:getObjectName(5, PickupVariant.PICKUP_PILL, item.cardpill)) or itemConfig:GetPillEffect(item.pilleffect).Name
						if item.pilleffect == 14 then
							str = "Gold Pill"
						end
						--eidstring = eidstring .. "{{Pill" .. item.cardpill .. "}} "
						if item.cardpill > 2048 then
							str = str .. "[!]"
							eidstring = eidstring .. "{{Pill" .. item.cardpill-2048 .. "}} {{ColorYellow}}" .. str
						else
							eidstring = eidstring .. "{{Pill" .. item.cardpill .. "}} " ..str
						end
						--Isaac.RenderText(c .. wakaba.pillname[item.pilleffect + 1][2], 155, ypos, 1, 1, 1, 255)
					else
						eidstring = eidstring .. "{{Pill" .. item.cardpill .. "}}{{WakabaUniformUnknownPill}}"
					end
					if player:GetData().wakaba.uniform.cursor == i then
						preservedslotstate = true
					end
				else
					eidstring = eidstring .. "{{WakabaUniformEmpty}}"
				end
			end
			if EID then
				if Input.IsActionPressed(ButtonAction.ACTION_MAP, player.ControllerIndex) then
					displayuniformslot = true
					local demoDescObj = EID:getDescriptionObj(5, 100, wakaba.Enums.Collectibles.UNIFORM)
					local unistr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].uniform) or wakaba.descriptions["en_us"].uniform
					--demoDescObj.ObjVariant = 350
					local prefix = unistr.changeslot .. " : {{ButtonRT}}"
					eidstring = "#{{CustomTransformation}} {{ColorGray}}" .. player:GetName() .. "(Player " .. player.ControllerIndex+1 .. ")#" .. prefix .. eidstring
					eidstring = eidstring .. "#" .. unistr.use
					if preservedslotstate and (player:GetCard(0) ~= 0 or player:GetPill(0) ~= 0) then
						eidstring = eidstring .. "#" .. unistr.useprefix .. player:GetData().wakaba.uniform.cursor .. unistr.usesubfix
					elseif preservedslotstate and (player:GetCard(0) == 0 and player:GetPill(0) == 0) then
						eidstring = eidstring .. "#" .. unistr.pullprefix .. player:GetData().wakaba.uniform.cursor .. unistr.pullsubfix
					elseif not preservedslotstate and (player:GetCard(0) ~= 0 or player:GetPill(0) ~= 0) then
						eidstring = eidstring .. "#" .. unistr.pushprefix .. player:GetData().wakaba.uniform.cursor .. unistr.pushsubfix
					else
					end
					eidstring = eidstring:gsub("{{WakabaUniformEmpty}}",unistr.empty)
					eidstring = eidstring:gsub("{{WakabaUniformUnknownPill}}",unistr.unknownpill)
					demoDescObj.Description = eidstring
					EID:displayPermanentText(demoDescObj)
				elseif displayuniformslot then
					EID:hidePermanentText()
					displayuniformslot = false
				end
			end
			--Isaac.RenderText("Sample text", 155, 20, 1, 1, 1, 255)
		end
	end

end


if EID then
	wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_Uniform)
	local function UniformCondition(descObj)
		if not EID.InsideItemReminder then return false end
		if EID.holdTabPlayer == nil then return false end
		return descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and descObj.ObjSubType == wakaba.Enums.Collectibles.UNIFORM
	end

	local function UniformCallback(descObj)
		local player = EID.holdTabPlayer
		local unistr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].uniform) or wakaba.descriptions["en_us"].uniform
		local eidstring = ""
		local preservedslotstate = false
		local itemConfig = Isaac.GetItemConfig()
		for i,item in pairs(player:GetData().wakaba.uniform.items) do
			if i > wakaba.Enums.Constants.WAKABA_UNIFORM_MAX_SLOTS then
				goto wakabaUniformEIDSkip
			end
			do
				local c = ""
				if player:GetData().wakaba.uniform.cursor == i then
					c = "> "
					eidstring = eidstring .. "#{{CoinHeart}} {{ColorGold}}"
				else
					eidstring = eidstring .. "#{{Blank}} "
				end
				if item.type == "card" then
					local str = (EID and EID:getObjectName(5, PickupVariant.PICKUP_TAROTCARD, item.cardpill)) or itemConfig:GetCard(item.cardpill).Name
					eidstring = eidstring .. "{{Card" .. item.cardpill .. "}} " .. str
					if player:GetData().wakaba.uniform.cursor == i then
						preservedslotstate = true
					end
				elseif item.type == "pill" then
					if wakaba.G:GetItemPool():IsPillIdentified(item.cardpill) then
						local str = (EID and EID:getObjectName(5, PickupVariant.PICKUP_PILL, item.cardpill)) or itemConfig:GetPillEffect(item.pilleffect).Name
						if item.pilleffect == 14 then
							str = "Gold Pill"
						end
						if item.cardpill > 2048 then
							str = str .. "[!]"
							eidstring = eidstring .. "{{Pill" .. item.cardpill-2048 .. "}} {{ColorYellow}}" .. str
						else
							eidstring = eidstring .. "{{Pill" .. item.cardpill .. "}} " ..str
						end
					else
						eidstring = eidstring .. "{{Pill" .. item.cardpill .. "}}{{WakabaUniformUnknownPill}}"
					end
					if player:GetData().wakaba.uniform.cursor == i then
						preservedslotstate = true
					end
				else
					eidstring = eidstring .. "{{WakabaUniformEmpty}}"
				end
			end
			::wakabaUniformEIDSkip::
		end
		--demoDescObj.ObjVariant = 350
		local prefix = unistr.changeslot .. " : {{ButtonRT}}"
		local playerID = player:GetPlayerType()
		eidstring = "#"..(EID:getIcon("Player"..playerID) ~= EID.InlineIcons["ERROR"] and "{{Player"..playerID.."}}" or "{{CustomTransformation}}").." {{ColorGray}}" .. player:GetName() .. "(Player " .. player.ControllerIndex+1 .. ")#" .. prefix .. eidstring
		eidstring = eidstring .. "#" .. unistr.use
		--[[ if preservedslotstate and (player:GetCard(0) ~= 0 or player:GetPill(0) ~= 0) then
			eidstring = eidstring .. "#" .. unistr.useprefix .. player:GetData().wakaba.uniform.cursor .. unistr.usesubfix
		elseif preservedslotstate and (player:GetCard(0) == 0 and player:GetPill(0) == 0) then
			eidstring = eidstring .. "#" .. unistr.pullprefix .. player:GetData().wakaba.uniform.cursor .. unistr.pullsubfix
		elseif not preservedslotstate and (player:GetCard(0) ~= 0 or player:GetPill(0) ~= 0) then
			eidstring = eidstring .. "#" .. unistr.pushprefix .. player:GetData().wakaba.uniform.cursor .. unistr.pushsubfix
		else
		end ]]
		eidstring = eidstring:gsub("{{WakabaUniformEmpty}}",unistr.empty)
		eidstring = eidstring:gsub("{{WakabaUniformUnknownPill}}",unistr.unknownpill)
		descObj.Description = eidstring
		return descObj
	end

	local function UniformCondition_CardPill(descObj)
		if EID.InsideItemReminder then return false end
		if not descObj.Entity then return false end
		if not (descObj.ObjType == 5 and (descObj.ObjVariant == PickupVariant.PICKUP_TAROTCARD or descObj.ObjVariant == PickupVariant.PICKUP_PILL)) then return false end

		local player = EID.player
		local isCard = descObj.ObjVariant == PickupVariant.PICKUP_TAROTCARD
		local isPill = descObj.ObjVariant == PickupVariant.PICKUP_PILL
		local isShopItem = descObj.Entity:ToPickup():IsShopItem()

		isCard = isCard and not wakaba:has_value(wakaba.Blacklists.Uniform.Cards, descObj.ObjSubType)

		isPill = isPill and not wakaba:has_value(wakaba.Blacklists.Uniform.PillColor, descObj.ObjSubType & PillColor.PILL_COLOR_MASK)
		isPill = isPill and not wakaba:has_value(wakaba.Blacklists.Uniform.PillEffect, wakaba.G:GetItemPool():GetPillEffect(descObj.ObjSubType, player))

		return (isCard or isPill) and not isShopItem
	end

	local function UniformCallback_CardPill(descObj)
		local player = EID.player
		local unistr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].uniform) or wakaba.descriptions["en_us"].uniform
		local eidstring = ""
		for _, player in ipairs(EID.coopAllPlayers) do
			if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM) then
				local playerID = player:GetPlayerType()
				local birthrightDesc = EID:getDescriptionEntry("birthright", playerID+1)
				local playerName = birthrightDesc and birthrightDesc[1] or player:GetName()
				local playerStr = "" .. (EID:getIcon("Player"..playerID) ~= EID.InlineIcons["ERROR"] and "{{Player"..playerID.."}}" or "") .. ""..playerName..""

				descObj.Description =
					descObj.Description
					.. "#{{Collectible"..wakaba.Enums.Collectibles.UNIFORM.."}} "
					.. unistr.pickupprefix
					.. playerStr
					.. unistr.pickupmidfix
					.. player:GetData().wakaba.uniform.cursor
					.. unistr.pickupsubfix
			end
		end
		return descObj
	end


	--EID:addDescriptionModifier("Wakaba's Uniform", UniformCondition, UniformCallback)
	EID:addDescriptionModifier("Wakaba's Uniform_CardPill", UniformCondition_CardPill, UniformCallback_CardPill)
else
	wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.render32)
end



function wakaba:PlayerEffect_Uniform(player)
	if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM) then
		if wakaba.G.Difficulty == Difficulty.DIFFICULTY_NORMAL or wakaba.G.Difficulty == Difficulty.DIFFICULTY_GREED then
			if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == wakaba.Enums.Collectibles.UNIFORM and player:NeedsCharge(ActiveSlot.SLOT_PRIMARY) then
				player:FullCharge(ActiveSlot.SLOT_PRIMARY)
			end
			if player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == wakaba.Enums.Collectibles.UNIFORM and player:NeedsCharge(ActiveSlot.SLOT_SECONDARY) then
				player:FullCharge(ActiveSlot.SLOT_SECONDARY)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerEffect_Uniform)

function wakaba:ItemUse_Uniform(usedItem, rng, player, useFlags, activeSlot, varData)
	local discharge = true
	if (useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY)
	or (useFlags & UseFlag.USE_VOID == UseFlag.USE_VOID)
	or (useFlags & UseFlag.USE_MIMIC == UseFlag.USE_MIMIC)
	or (useFlags & UseFlag.USE_OWNED ~= UseFlag.USE_OWNED)
	then
		usinguniform = true
		wakaba:useUniform(player)
		goto WakabaUniformUseSkip
	end
	do
		local err = 0
		local index = player:GetData().wakaba.uniform.cursor
		local item = player:GetData().wakaba.uniform.items[index]
		local oldItemType = player:GetData().wakaba.uniform.items[index].type
		local oldItemData = player:GetData().wakaba.uniform.items[index].cardpill
		local pickups = isc:getEntities(EntityType.ENTITY_PICKUP)
		local nearest = isc:getClosestEntityTo(player, pickups,
			function(_, e)
				local isCard = e.Variant == PickupVariant.PICKUP_TAROTCARD
				local isPill = e.Variant == PickupVariant.PICKUP_PILL
				local isShopItem = e:ToPickup():IsShopItem()

				isCard = isCard and not wakaba:has_value(wakaba.Blacklists.Uniform.Cards, e.SubType)

				isPill = isPill and not wakaba:has_value(wakaba.Blacklists.Uniform.PillColor, e.SubType & PillColor.PILL_COLOR_MASK)
				isPill = isPill and not wakaba:has_value(wakaba.Blacklists.Uniform.PillEffect, wakaba.G:GetItemPool():GetPillEffect(e.SubType, player))

				return (isCard or isPill) and not isShopItem
			end
		)
		local tempPickupVariant = nearest and nearest.Variant
		local tempPickupSubType = nearest and nearest.SubType
		local eraseOld = false
		if oldItemType == "pill" then
			local dummyPickup = (nearest and nearest:ToPickup()) or Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, Vector(320,280), Vector(0,0), nil):ToPickup()
			local newPickup = dummyPickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, oldItemData, false, true, true)
			eraseOld = true
		elseif oldItemType == "card" then
			local dummyPickup = (nearest and nearest:ToPickup()) or Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, Vector(320,280), Vector(0,0), nil):ToPickup()
			local newPickup = dummyPickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, oldItemData, false, true, true)
			eraseOld = true
		elseif nearest then
			nearest:Remove()
		end

		if eraseOld then
			player:GetData().wakaba.uniform.items[index].type = nil
			player:GetData().wakaba.uniform.items[index].cardpill = nil
			player:GetData().wakaba.uniform.items[index].pilleffect = nil
		end

		if tempPickupVariant == PickupVariant.PICKUP_TAROTCARD then
			player:GetData().wakaba.uniform.items[index].type = "card"
			player:GetData().wakaba.uniform.items[index].cardpill = tempPickupSubType
			player:GetData().wakaba.uniform.items[index].pilleffect = nil
		elseif tempPickupVariant == PickupVariant.PICKUP_PILL then
			player:GetData().wakaba.uniform.items[index].type = "pill"
			player:GetData().wakaba.uniform.items[index].cardpill = tempPickupSubType
			player:GetData().wakaba.uniform.items[index].pilleffect = wakaba.G:GetItemPool():GetPillEffect(tempPickupSubType, player)
		end

		if tempPickupVariant or oldItemType then
			player:AnimateCollectible(wakaba.Enums.Collectibles.UNIFORM, "UseItem", "PlayerPickup")
			SFXManager():Play(SoundEffect.SOUND_GOLDENBOMB)
		else
			player:AnimateSad()
			discharge = false
		end
		if wakaba:IsGoldenItem(usedItem) then
			discharge = false
		end
	end
	::WakabaUniformUseSkip::
	return {Discharge = discharge}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Uniform, wakaba.Enums.Collectibles.UNIFORM)

function wakaba:useUniform(player)
	local flag = UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC | UseFlag.USE_NOANIM | UseFlag.USE_NOHUD
	for i,item in pairs(player:GetData().wakaba.uniform.items) do
		--local index = tonumber(string.sub(i, 5, 5))
		if item.type == "card" then
			--print("using card ", item.cardpill)
			player:UseCard(item.cardpill, flag)
			if wakaba:HasJudasBr(player) then
				player:UseCard(Card.CARD_DEVIL, flag)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) then
				player:AddWisp(wakaba.Enums.Collectibles.UNIFORM, player.Position)
			end
		elseif item.type == "pill" then
			--print("using pill", item.pilleffect)
			local replacedPillEffect = item.pilleffect
			if FiendFolio and item.pilleffect == FiendFolio.ITEM.PILL.FF_UNIDENTIFIED then
				local pill = item.cardpill
				pill = pill % 2048
				FiendFolio.savedata.run.IdentifiedRunPills = FiendFolio.savedata.run.IdentifiedRunPills or {}
				if not FiendFolio.savedata.run.IdentifiedRunPills[tostring(pill)] then
					FiendFolio.savedata.run.IdentifiedRunPills[tostring(pill)] = true
				end

				local pillreplaced = 1
				if FiendFolio.savedata.run.PillCopies and FiendFolio.savedata.run.PillCopies[tostring(pill)] then
					pillreplaced = FiendFolio.savedata.run.PillCopies[tostring(pill)]
				end

				local itempool = wakaba.G:GetItemPool()
				replacedPillEffect = itempool:GetPillEffect(pillreplaced, player)
				-- check again
				if item.pilleffect == FiendFolio.ITEM.PILL.FF_UNIDENTIFIED then
					player:GetData().wakaba.uniform.items[i].pilleffect = replacedPillEffect
				end
			end
			if wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.ANTI_BALANCE) and item.cardpill < PillColor.PILL_GIANT_FLAG then
				item.cardpill = item.cardpill | PillColor.PILL_GIANT_FLAG
			end
			player:GetData().wakaba_currentPill = item.cardpill
			player:UsePill(replacedPillEffect, item.cardpill, flag)
			if wakaba:HasJudasBr(player) then
				player:UseCard(Card.CARD_DEVIL, flag)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) then
				player:AddWisp(wakaba.Enums.Collectibles.UNIFORM, player.Position)
			end
		end
	end
	player:GetData().wakaba_currentPill = player:GetData().wakaba_reservedPill
	player:GetData().wakaba_reservedPill = nil
	usinguniform = false
end

function wakaba:usePocket32(cardpill, player, flags)
	if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM) and flags & UseFlag.USE_NOHUD ~= UseFlag.USE_NOHUD then
		player:GetData().wakaba_reservedPill = player:GetData().wakaba_currentPill
		usinguniform = true
		wakaba:useUniform(player)
	end
end

wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.usePocket32)
wakaba:AddCallback(ModCallbacks.MC_USE_PILL, wakaba.usePocket32)


