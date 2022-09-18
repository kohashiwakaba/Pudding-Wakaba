local usinguniform = false
local displayuniformslot = false
--wakaba.f:DrawString("droid",60,50,KColor(1,1,1,1,0,0,0),0,true) -- render string with loaded font on position 60x50y


--[[
wakaba.state.uniform[player] = {
	cursor = i,
	items = {
		i = {type, cardpill}, -- example
		1 = {type = card, cardpill = Card.CARD_NULL},
		2 = {type = pill, pilleffect = PillEffect.PILLEFFECT_NULL, cardpill = PillColor.PILL_GIANT_FLAG},
		3 = {type = nil, cardpill = nil},
		4 = {type = nil, cardpill = nil},
		5 = {type = nil, cardpill = nil},
	}
}
]]

-- wakaba_compat_check : Fiend Folio
local isFFPill = {}
if FiendFolio then
  do
    for i = 1, #FiendFolio.FFPillColours do
      isFFPill[FiendFolio.FFPillColours[i]] = true
    end
  end
end

function wakaba:inputcheck32(entity, hook, action)
	
end

--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.inputcheck32, InputHook.IS_ACTION_TRIGGERED)


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
				if index > 5 then
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
			local alpha = wakaba.state.currentalpha / 100
			local scale = wakaba.state.options.uniformscale / 100
			local ypos = 10
			local eidstring = ""
			local preservedslotstate = false
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
					local str = (EID and EID:getObjectName(5, PickupVariant.PICKUP_TAROTCARD, item.cardpill)) or wakaba.itemConfig:GetCard(item.cardpill).Name
					eidstring = eidstring .. "{{Card" .. item.cardpill .. "}} " .. str
					if player:GetData().wakaba.uniform.cursor == i then
						preservedslotstate = true
					end
				elseif item.type == "pill" then
					if wakaba.G:GetItemPool():IsPillIdentified(item.cardpill) then
						local str = (EID and EID:getObjectName(5, PickupVariant.PICKUP_PILL, item.cardpill)) or wakaba.itemConfig:GetPillEffect(item.pilleffect).Name
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

wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.render32)

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

function wakaba:ItemUse_Uniform(_, rng, player, useFlags, activeSlot, varData)
	if (useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY)
	or (useFlags & UseFlag.USE_VOID == UseFlag.USE_VOID) 
	or (useFlags & UseFlag.USE_MIMIC == UseFlag.USE_MIMIC) 
	or (useFlags & UseFlag.USE_OWNED ~= UseFlag.USE_OWNED) 
	then 
		usinguniform = true
		wakaba:useUniform(player)
		return 
	end
	local discharge = false
	local err = 0
	local index = player:GetData().wakaba.uniform.cursor
	local item = player:GetData().wakaba.uniform.items[index]
	local oldItemType = player:GetData().wakaba.uniform.items[index].type
	local oldItemData = player:GetData().wakaba.uniform.items[index].cardpill
	local card = player:GetCard(0)
	local pill = player:GetPill(0)
	--print("card ", card, "pill ", pill)
--[[
	if card ~= 0 and pill == 0 then
		player:GetData().wakaba.uniform.items[index].type = "card"
		player:GetData().wakaba.uniform.items[index].cardpill = card
		player:GetData().wakaba.uniform.items[index].pilleffect = nil
	elseif card == 0 and pill ~= 0 then
		player:GetData().wakaba.uniform.items[index].type = "pill"
		player:GetData().wakaba.uniform.items[index].cardpill = pill
		player:GetData().wakaba.uniform.items[index].pilleffect = wakaba.G:GetItemPool():GetPillEffect(pill, player)
	elseif card == 0 and pill == 0 then
		player:GetData().wakaba.uniform.items[index].type = nil
		player:GetData().wakaba.uniform.items[index].cardpill = nil
		player:GetData().wakaba.uniform.items[index].pilleffect = nil
	end
]]
	--[[
	print("Old Type = .", oldItemType) 
	print("Old Card/Pill = .", oldItemData) 
	
	print("Saved Index = .", index) 
	print("Saved Type = .", player:GetData().wakaba.uniform.items[index].type) 
	if player:GetData().wakaba.uniform.items[index].type == "pill" then
		print("Saved Card/Pill = .", player:GetData().wakaba.uniform.items[index].pilleffect) 
	else
		print("Saved Card/Pill = .", player:GetData().wakaba.uniform.items[index].cardpill) 
	end
	]]
	if oldItemType ~= nil then
		if player:GetActiveItem(ActiveSlot.SLOT_POCKET) > 0 then
			if oldItemType == "card" then
				if player:GetCard(0) == 0 and not (index == 1 and player:GetCard(0) == Card.CARD_WILD) then --Handle PocketActiveItem check
					if player:GetCard(1) == 0 and not (index == 1 and player:GetCard(1) == Card.CARD_WILD) then
						player:SetCard(1,oldItemData)
					elseif player:GetCard(2) == 0 and not (index == 1 and player:GetCard(2) == Card.CARD_WILD) then
						player:SetCard(2,oldItemData)
					else
						err = err + 1
					end
				elseif not (index == 1 and player:GetCard(0) == Card.CARD_WILD) then
					player:SetCard(0,oldItemData)
				else
					err = err + 1
				end
			elseif oldItemType == "pill" then
				if player:GetPill(0) == 0 then --Handle PocketActiveItem check
					if player:GetPill(1) == 0 then
						player:SetPill(1,oldItemData)
					elseif player:GetPill(2) == 0 then
						player:SetPill(2,oldItemData)
					else
						err = err + 1
					end
				else
					player:SetPill(0,oldItemData)
				end
			end
		else
			if oldItemType == "card" then
				if index == 1 and player:GetCard(0) == Card.CARD_WILD then
					err = err + 1
				else
					player:SetCard(0,oldItemData)
				end
			elseif oldItemType == "pill" then
				player:SetPill(0,oldItemData)
			end
		end
	elseif player:GetActiveItem(ActiveSlot.SLOT_POCKET) > 0 then
		if (card ~= 0 and not (index == 1 and card == Card.CARD_WILD)) and pill == 0 then
			player:SetCard(0,0)
		elseif card == 0 and pill ~= 0 then
			player:SetPill(0,0)
		else
			err = err + 1
		end
	elseif index == 1 and card == Card.CARD_WILD then
		err = err + 1
	else
		player:SetCard(0,0)
	end
	if err <= 0 then
		if card ~= 0 and pill == 0 then
			player:GetData().wakaba.uniform.items[index].type = "card"
			player:GetData().wakaba.uniform.items[index].cardpill = card
			player:GetData().wakaba.uniform.items[index].pilleffect = nil
		elseif card == 0 and pill ~= 0 then
			player:GetData().wakaba.uniform.items[index].type = "pill"
			player:GetData().wakaba.uniform.items[index].cardpill = pill
			player:GetData().wakaba.uniform.items[index].pilleffect = wakaba.G:GetItemPool():GetPillEffect(pill, player)
		elseif card == 0 and pill == 0 then
			player:GetData().wakaba.uniform.items[index].type = nil
			player:GetData().wakaba.uniform.items[index].cardpill = nil
			player:GetData().wakaba.uniform.items[index].pilleffect = nil
		end
	end
	if err > 0 then
		player:AnimateSad()
		--SFXManager():Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ)
	elseif card ~= 0 or pill ~= 0 or oldItemType ~= nil then
		player:AnimateCollectible(wakaba.Enums.Collectibles.UNIFORM, "UseItem", "PlayerPickup")
		SFXManager():Play(SoundEffect.SOUND_GOLDENBOMB)
		discharge = true
	end
	if wakaba.G.Difficulty == Difficulty.DIFFICULTY_NORMAL or wakaba.G.Difficulty == Difficulty.DIFFICULTY_GREED then
		discharge = false
	end
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
			player:UsePill(replacedPillEffect, item.cardpill, flag)
			if wakaba:HasJudasBr(player) then
				player:UseCard(Card.CARD_DEVIL, flag)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) then
				player:AddWisp(wakaba.Enums.Collectibles.UNIFORM, player.Position)
			end
		end
	end
	usinguniform = false
end

function wakaba:usePocket32(cardpill, player, flags)
	if player:HasCollectible(wakaba.Enums.Collectibles.UNIFORM) and flags & UseFlag.USE_NOHUD ~= UseFlag.USE_NOHUD then
		usinguniform = true
		wakaba:useUniform(player)
	end
end

wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.usePocket32)
wakaba:AddCallback(ModCallbacks.MC_USE_PILL, wakaba.usePocket32)


