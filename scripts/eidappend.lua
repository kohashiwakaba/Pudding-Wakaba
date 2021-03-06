-- Todos : Add weight values for EID Bag of Crafting

if EID then
  if EIDKR then
		print("Pudding and Wakaba no longer supports EID Korean. Use Original External Item Descriptions mod.")
  else

		wakaba.TargetIcons = Sprite()
		wakaba.TargetIcons:Load("gfx/ui/eid_wakaba_bosses.anm2", true)

		wakaba.CardSprite = Sprite()
		wakaba.CardSprite:Load("gfx/eid_cardfronts.anm2", true)
		wakaba.CardSpriteFrames = {
			[wakaba.CARD_CRANE_CARD] = 2,
			[wakaba.CARD_CONFESSIONAL_CARD] = 3,
			[wakaba.CARD_BLACK_JOKER] = 4,
			[wakaba.CARD_WHITE_JOKER] = 5,
			[wakaba.CARD_COLOR_JOKER] = 6,
			[wakaba.CARD_DREAM_CARD] = 8,
			[wakaba.CARD_UNKNOWN_BOOKMARK] = 9,
			[wakaba.CARD_QUEEN_OF_SPADES] = 11,
			[wakaba.SOUL_WAKABA] = 7,
			[wakaba.SOUL_WAKABA2] = 12,
			[wakaba.SOUL_SHIORI] = 10,
			--[wakaba.SOUL_TSUKASA] = 13,
			[wakaba.CARD_RETURN_TOKEN] = 14,
		}
		wakaba.PlayerIconSprite = Sprite()
		wakaba.PlayerIconSprite:Load("gfx/ui/eid_wakaba_players.anm2", true)
		wakaba.PlayerSpriteAnimName = {
			[wakaba.PLAYER_WAKABA] = "Wakaba",
			[wakaba.PLAYER_WAKABA_B] = "WakabaB",
			[wakaba.PLAYER_SHIORI] = "Shiori",
			[wakaba.PLAYER_SHIORI_B] = "ShioriB",
			[wakaba.PLAYER_TSUKASA] = "Tsukasa",
			[wakaba.PLAYER_TSUKASA_B] = "TsukasaB",
		}

		wakaba.EIDBlankCardCooldowns = {
			-- Blank Card
			[wakaba.CARD_CRANE_CARD] = 6,
			[wakaba.CARD_CONFESSIONAL_CARD] = 4,
			[wakaba.CARD_BLACK_JOKER] = 2,
			[wakaba.CARD_WHITE_JOKER] = 2,
			[wakaba.CARD_COLOR_JOKER] = 6,
			[wakaba.CARD_DREAM_CARD] = 12,
			[wakaba.CARD_UNKNOWN_BOOKMARK] = 1,
			[wakaba.CARD_QUEEN_OF_SPADES] = 12,
		}
		wakaba.EIDClearRuneCooldowns = {
			-- Clear Rune
			[wakaba.SOUL_WAKABA] = 12,
			[wakaba.SOUL_WAKABA2] = 12,
			[wakaba.SOUL_SHIORI] = 8,
		}
		wakaba.EIDPlaceboCooldowns = {
			-- Placebo
			[wakaba.PILL_DAMAGE_MULTIPLIER_UP] = 12,
			[wakaba.PILL_DAMAGE_MULTIPLIER_DOWN] = 4,
			[wakaba.PILL_ALL_STATS_UP] = 12,
			[wakaba.PILL_ALL_STATS_DOWN] = 4,
			[wakaba.PILL_TROLLED] = 2,
			[wakaba.PILL_TO_THE_START] = 2,
			[wakaba.PILL_EXPLOSIVE_DIARRHEA_2] = 2,
			[wakaba.PILL_SOCIAL_DISTANCE] = 1,
			[wakaba.PILL_FLAME_PRINCESS] = 12,
			[wakaba.PILL_FIREY_TOUCH] = 6,
		}

		function wakaba:getWakabaDesc(entries, id)
			lang = EID:getLanguage() or "en_us"
	  	local entrytables = wakaba.descriptions[lang] or wakaba.descriptions["en_us"]
			if id then
				if entrytables[entries] then
					return entrytables[entries][id]
				end
			else
				return entrytables[entries]
			end
		end

    table.insert(EID.TextReplacementPairs, {"{{WakabaBless}}","{{Collectible" .. wakaba.COLLECTIBLE_WAKABAS_BLESSING .. "}}"})
    table.insert(EID.TextReplacementPairs, {"{{WakabaNemesis}}","{{Collectible" .. wakaba.COLLECTIBLE_WAKABAS_NEMESIS .. "}}"})
    table.insert(EID.TextReplacementPairs, {"{{Shiori}}","{{Collectible" .. wakaba.COLLECTIBLE_BOOK_OF_SHIORI .. "}}"})
    table.insert(EID.TextReplacementPairs, {"{{Judasbr}}","{{Collectible" .. CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL .. "}}"})
    table.insert(EID.TextReplacementPairs, {"{{WakabaBlankCard}}","{{Collectible" .. CollectibleType.COLLECTIBLE_CLEAR_RUNE .. "}}"})
    table.insert(EID.TextReplacementPairs, {"{{WakabaPlacebo}}","{{Collectible" .. CollectibleType.COLLECTIBLE_PLACEBO .. "}}"})
    table.insert(EID.TextReplacementPairs, {"{{WakabaClearRune}}","{{Collectible" .. CollectibleType.COLLECTIBLE_CLEAR_RUNE .. "}}"})

    EID:addColor("ColorWakabaBless", KColor(0.827, 0.831, 0.992, 1))
    EID:addColor("ColorSoul", KColor(0.827, 0.831, 0.992, 1))
    EID:addColor("ColorWakabaNemesis", KColor(0.921, 0.6, 0.603, 1))
    EID:addColor("ColorBookofShiori", KColor(0.462, 0.474, 0.937, 1))
    EID:addColor("ColorBoCLight", KColor(1, 0.537, 0.867, 1))
    EID:addColor("ColorBocDark", KColor(0.941, 0.357, 0.69, 1))
		EID.InlineIcons["IconRedTint"] = function(_)
			EID._NextIconModifier = function(sprite)
				sprite.Color = Color(1, 1, 1, EID.Config["Transparency"] * 0.5, 0.8, 0, 0)
			end
			return {"Blank", 0, 0, 0}
		end
		EID.InlineIcons["IconBlack"] = function(_)
			EID._NextIconModifier = function(sprite)
				sprite.Color = Color(0, 0, 0, EID.Config["Transparency"] * 1, 0, 0, 0)
			end
			return {"Blank", 0, 0, 0}
		end
    EID:addColor("ColorBookofConquest", nil, function(_)
			local maxAnimTime = 80
			local animTime = Game():GetFrameCount() % maxAnimTime
			local c = EID.InlineColors
			local colors = {c["ColorBoCLight"], c["ColorBocDark"]}
			local colorFractions = (maxAnimTime - 1) / #colors
			local subAnm = math.floor(animTime / (colorFractions + 1)) + 1
			local primaryColorIndex = subAnm % (#colors + 1)
			if primaryColorIndex == 0 then
				primaryColorIndex = 1
			end
			local secondaryColorIndex = (subAnm + 1) % (#colors + 1)
			if secondaryColorIndex == 0 then
				secondaryColorIndex = 1
			end
			return EID:interpolateColors(
				colors[primaryColorIndex],
				colors[secondaryColorIndex],
				(animTime % (colorFractions + 1)) / colorFractions
			)
		end)
		
	  -- Handle Wakaba description addition
	  local function WakabaCondition(descObj)
	  	if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
	  		return false
	  	end
	  	for i = 0,Game():GetNumPlayers() - 1 do
	  		local player = Isaac.GetPlayer(i)
	  		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Wakaba", false) then
	  			return true
	  		end
	  	end
	  	return false
	  end
  
	  local function WakabaCallback(descObj)
	  	local wakabaBuff = wakaba:getWakabaDesc("wakaba", descObj.ObjSubType)
	  	if wakabaBuff then
        local description = wakabaBuff.description
	  		local iconStr = "#{{Player"..wakaba.PLAYER_WAKABA.."}} {{ColorWakabaBless}}"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end

	  -- Handle Tainted Wakaba description addition
	  local function WakabaCondition_b(descObj)
	  	if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
	  		return false
	  	end
	  	for i = 0,Game():GetNumPlayers() - 1 do
	  		local player = Isaac.GetPlayer(i)
	  		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("WakabaB", true) then
	  			return true
	  		end
	  	end
	  	return false
	  end
  
	  local function WakabaCallback_b(descObj)
	  	local wakabaBuff = wakaba:getWakabaDesc("wakaba_b", descObj.ObjSubType)
	  	if wakabaBuff then
        local description = wakabaBuff.description
	  		local iconStr = "#{{Player"..wakaba.PLAYER_WAKABA_B.."}} {{ColorWakabaNemesis}}"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end

	  -- Handle Wakaba's Blessing description addition
	  local function BlessingCondition(descObj)
	  	if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
	  		return false
	  	end
	  	for i = 0,Game():GetNumPlayers() - 1 do
	  		local player = Isaac.GetPlayer(i)
	  		if wakaba:HasBless(player) then
	  			return true
	  		end
	  	end
	  	return false
	  end
  
	  local function BlessingCallback(descObj)
	  	local wakabaBuff = wakaba:getWakabaDesc("bless", descObj.ObjSubType)
	  	if wakabaBuff then
        local description = wakabaBuff.description
	  		local iconStr = "#{{Collectible" .. wakaba.COLLECTIBLE_WAKABAS_BLESSING .. "}} {{ColorWakabaBless}}"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end

	  -- Handle Wakaba's Nemesis description addition
	  local function NemesisCondition(descObj)
	  	if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
	  		return false
	  	end
	  	for i = 0,Game():GetNumPlayers() - 1 do
	  		local player = Isaac.GetPlayer(i)
	  		if wakaba:HasNemesis(player) then
	  			return true
	  		end
	  	end
	  	return false
	  end
  
	  local function NemesisCallback(descObj)
	  	local wakabaBuff = wakaba:getWakabaDesc("nemesis", descObj.ObjSubType)
	  	if wakabaBuff then
        local description = wakabaBuff.description
	  		local iconStr = "#{{Collectible" .. wakaba.COLLECTIBLE_WAKABAS_NEMESIS .. "}} {{ColorWakabaNemesis}}"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end

	  -- Handle Book of Shiori description addition
	  local function ShioriCondition(descObj)
	  	if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
	  		return false
	  	end
	  	for i = 0,Game():GetNumPlayers() - 1 do
	  		local player = Isaac.GetPlayer(i)
	  		if player:GetPlayerType() == wakaba.PLAYER_SHIORI then
	  			return true
	  		end
	  	end
	  	return false
	  end
  
	  local function ShioriCallback(descObj)
	  	local wakabaBuff = wakaba:getWakabaDesc("shiori", descObj.ObjSubType)
	  	if wakabaBuff then
        local description = wakabaBuff.description
	  		local iconStr = "#{{Player"..wakaba.PLAYER_SHIORI.."}} {{ColorBookofShiori}}"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end

	  -- Handle Book of Shiori description addition
	  local function ShioriCondition_b(descObj)
	  	if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
	  		return false
	  	end
	  	for i = 0,Game():GetNumPlayers() - 1 do
	  		local player = Isaac.GetPlayer(i)
	  		if player:GetPlayerType() == wakaba.PLAYER_SHIORI_B then
	  			return true
	  		end
	  	end
	  	return false
	  end
  
	  local function ShioriCallback_b(descObj)
	  	local wakabaBuff = wakaba:getWakabaDesc("shiori_b", descObj.ObjSubType)
	  	if wakabaBuff then
        local description = wakabaBuff.description
	  		local iconStr = "#{{Player"..wakaba.PLAYER_SHIORI_B.."}} {{ColorBookofShiori}}"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end
		
	  -- Handle Book of Shiori description addition
	  local function ShioriBookCondition(descObj)
	  	if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
	  		return false
	  	end
	  	for i = 0,Game():GetNumPlayers() - 1 do
	  		local player = Isaac.GetPlayer(i)
	  		if wakaba:HasShiori(player) then
	  			return true
	  		end
	  	end
	  	return false
	  end
  
	  local function ShioriBookCallback(descObj)
	  	local wakabaBuff = wakaba:getWakabaDesc("bookofshiori", descObj.ObjSubType)
	  	if wakabaBuff then
        local description = wakabaBuff.description
	  		local iconStr = "#{{Collectible" .. wakaba.COLLECTIBLE_BOOK_OF_SHIORI .. "}} {{ColorBookofShiori}}"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end

	  -- Handle Judas + Birthright description addition
	  local function JudasCondition(descObj)
	  	if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
	  		return false
	  	end
	  	for i = 0,Game():GetNumPlayers() - 1 do
	  		local player = Isaac.GetPlayer(i)
	  		if wakaba:HasJudasBr(player) then
	  			return true
	  		end
	  	end
	  	return false
	  end
  
	  local function JudasCallback(descObj)
	  	local wakabaBuff = wakaba:getWakabaDesc("belial", descObj.ObjSubType)
	  	if wakabaBuff then
        local description = wakabaBuff.description
	  		local iconStr = "#{{Collectible" .. CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL .. "}} {{ColorWakabaNemesis}}"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end


	  -- Handle Horse Pills of Pudding and Wakaba description
	  local function WakabaPillCondition(descObj)
	  	if descObj.ObjType == 5 or descObj.ObjVariant == PickupVariant.PICKUP_PILL and descObj.SubType > 2048 then
	  		return true
	  	end
	  	return false
	  end
  
	  --[[ local function WakabaPillCallback(descObj)
			--print(EID:getAdjustedSubtype(descObj.ObjType, descObj.ObjVariant, descObj.ObjSubType), descObj.ObjSubType)

			local subtype = EID:getAdjustedSubtype(descObj.ObjType, descObj.ObjVariant, descObj.ObjSubType) - 1
			if subtype >= wakaba.minpillno and subtype <= wakaba.maxpillno then
				local desc = wakaba.wikidesc[subtype + 65535]
				if desc then
					descObj.Description = desc
				end
				return descObj
			end
	  end ]]
	  -- Handle Cards of Pudding and Wakaba description
	  local function WakabaTarotCardCondition(descObj)
	  	if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_TAROTCARD then
				if EID:PlayersHaveCollectible(CollectibleType.COLLECTIBLE_TAROT_CLOTH) then
					return true
				end
	  	end
	  	return false
	  end

	  local function WakabaTarotCardCallback(descObj)
	  	local wakabaBuff = wakaba:getWakabaDesc("tarotcloth", descObj.ObjSubType)
			local subtype = EID:getAdjustedSubtype(descObj.ObjType, descObj.ObjVariant, descObj.ObjSubType) - 1
	  	if wakabaBuff ~= nil then
        local description = wakabaBuff.description
	  		local iconStr = "#{{Collectible" .. CollectibleType.COLLECTIBLE_TAROT_CLOTH .. "}} "
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end
  
	  -- Handle Better Voiding description addition
	  local function BetterVoidingCondition(descObj)
	  	if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
	  		return false
	  	end
	  	if BetterVoiding then
				return true
			end
	  	return false
	  end
  
	  local function BetterVoidingCallback(descObj)
	  	local betterVoidingBuff = wakaba.eidextradesc.bettervoiding[descObj.ObjSubType]
	  	if betterVoidingBuff ~= nil then
        local description = (betterVoidingBuff[EID:getLanguage()] or betterVoidingBuff.en_us)
	  		local iconStr = "#!!! Better Voiding detected!#"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
	  	end
	  	return descObj
	  end
		
		-- Handle Bingeeater description addition
		local function BingeeaterCondition(descObj)
			if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
				return false
			end
			if EID:PlayersHaveCollectible(CollectibleType.COLLECTIBLE_BINGE_EATER) then
				return true
			end
			return false
		end

		local function BingeeaterCallback(descObj)
			local wakabaBuff = wakaba:getWakabaDesc("bingeeater", descObj.ObjSubType)
			if wakabaBuff then
				local description = wakabaBuff.description
				local iconStr = "#{{Collectible" .. CollectibleType.COLLECTIBLE_BINGE_EATER .. "}} "
				EID:appendToDescription(descObj, iconStr..description:gsub("#",iconStr) .. "{{CR}}")
			end
			return descObj
		end

		-- Handle Book of Virtues description addition
		local function BookOfVirtuesCondition(descObj)
			if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
				return false
			end
			if EID:PlayersHaveCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) then
				return true
			end
			return false
		end

		local function BookOfVirtuesCallback(descObj)
			local wakabaBuff = wakaba:getWakabaDesc("bookofvirtues", descObj.ObjSubType)
			if wakabaBuff then
				local description = wakabaBuff.description
				local iconStr = "#{{Collectible" .. CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES .. "}} "
				EID:appendToDescription(descObj, iconStr..description:gsub("#",iconStr) .. "{{CR}}")
			end
			return descObj
		end
		
		-- Handle Abyss description addition
		local function AbyssCondition(descObj)
			if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
				return false
			end
			if EID:PlayersHaveCollectible(CollectibleType.COLLECTIBLE_ABYSS) then
				return true
			end
			return false
		end
		
		local function AbyssCallback(descObj)
			local wakabaBuff = wakaba:getWakabaDesc("abyss", descObj.ObjSubType)
			if wakabaBuff then
				local description = wakabaBuff.description
	  		local iconStr = "#{{Collectible" .. CollectibleType.COLLECTIBLE_ABYSS .. "}} {{ColorRed}}"
	  		EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
			end
			return descObj
		end

		local collectiblesCheck = {
			wakaba.COLLECTIBLE_WAKABAS_BLESSING,
			wakaba.COLLECTIBLE_WAKABAS_NEMESIS,
			wakaba.COLLECTIBLE_BOOK_OF_SHIORI,
			CollectibleType.COLLECTIBLE_BINGE_EATER, 
			CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES,
			CollectibleType.COLLECTIBLE_TAROT_CLOTH, 
			CollectibleType.COLLECTIBLE_BLANK_CARD, 
			CollectibleType.COLLECTIBLE_CLEAR_RUNE, 
			CollectibleType.COLLECTIBLE_PLACEBO, 
			CollectibleType.COLLECTIBLE_FALSE_PHD, 
			CollectibleType.COLLECTIBLE_ABYSS,
		}
		local playersCheck = {
			wakaba.PLAYER_WAKABA,
			wakaba.PLAYER_WAKABA_B,
			wakaba.PLAYER_SHIORI,
			wakaba.PLAYER_SHIORI_B,
		}
		local collectiblesOwned = {}
		local hasPlayer = {}

		local function EIDWakabaConditions(descObj)
			-- currently, only pickup descriptions have modifiers
			if descObj.ObjType ~= 5 then return false end

			-- recheck the players' owned collectibles periodically, not every frame
			if Game():GetFrameCount() % 10 == 0 then
				local numPlayers = Game():GetNumPlayers()
				local players = {}; for i = 0, numPlayers - 1 do players[i] = Isaac.GetPlayer(i) end
				for _,v in ipairs(playersCheck) do
					hasPlayer[v] = false
					for i = 0, numPlayers - 1 do
						if players[i]:GetPlayerType() == v then
							hasPlayer[v] = true
							break
						end
					end
				end
				for _,v in ipairs(collectiblesToCheck) do
					collectiblesOwned[v] = false
					for i = 0, numPlayers - 1 do
						if players[i]:HasCollectible(v) then
							collectiblesOwned[v] = true
							break
						end
					end
				end
				-- Birthright Book of Belial
				collectiblesOwned[59] = false
				for i = 0, numPlayers - 1 do
					local playerType = players[i]:GetPlayerType()
					if (playerType == PlayerType.PLAYER_JUDAS or playerType == PlayerType.PLAYER_BLACKJUDAS) and players[i]:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
						collectiblesOwned[59] = true
						break
					end
				end
			end
	
			local callbacks = {}


			-- Collectible Pedestal Callbacks
			if descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE then
				if hasPlayer[wakaba.PLAYER_WAKABA] then table.insert(callbacks, WakabaCallback) end
				if hasPlayer[wakaba.PLAYER_WAKABA_B] then table.insert(callbacks, WakabaCallback_b) end
				if hasPlayer[wakaba.PLAYER_SHIORI] then table.insert(callbacks, ShioriCallback) end
				if hasPlayer[wakaba.PLAYER_SHIORI_B] then table.insert(callbacks, ShioriCallback_b) end


				if collectiblesOwned[664] then table.insert(callbacks, BingeeaterCallback) end

				if collectiblesOwned[wakaba.COLLECTIBLE_WAKABAS_BLESSING] then table.insert(callbacks, BlessingCallback) end
				if collectiblesOwned[wakaba.COLLECTIBLE_WAKABAS_NEMESIS] then table.insert(callbacks, NemesisCallback) end
				if collectiblesOwned[wakaba.COLLECTIBLE_BOOK_OF_SHIORI] then table.insert(callbacks, ShioriBookCallback) end


				if collectiblesOwned[59] then table.insert(callbacks, JudasCallback) end
				if collectiblesOwned[584] then table.insert(callbacks, BookOfVirtuesCallback) end
				if collectiblesOwned[706] then table.insert(callbacks, AbyssCallback) end

			-- Card / Rune Callbacks
			elseif descObj.ObjVariant == PickupVariant.PICKUP_TAROTCARD then
				if collectiblesOwned[451] then table.insert(callbacks, WakabaTarotCardCallback) end

				--if collectiblesOwned[286] and not blankCardHidden[descObj.ObjSubType] and descObj.ObjSubType <= 80 then table.insert(callbacks, BlankCardCallback) end
				--if collectiblesOwned[263] and runeIDs[descObj.ObjSubType] then table.insert(callbacks, ClearRuneCallback) end
			-- Pill Callbacks
			elseif descObj.ObjVariant == PickupVariant.PICKUP_PILL then
				--if collectiblesOwned[654] then table.insert(callbacks, FalsePHDCallback) end

				--if collectiblesOwned[348] then table.insert(callbacks, PlaceboCallback) end
			-- Trinket Callbacks
			elseif descObj.ObjVariant == PickupVariant.PICKUP_TRINKET then
				-- Golden Trinket / Mom's Box
				--[[ isGolden = (descObj.ObjSubType > TrinketType.TRINKET_GOLDEN_FLAG)
				hasBox = collectiblesOwned[439]
				if isGolden or hasBox then table.insert(callbacks, GoldenTrinketCallback) end ]]
			end

			return callbacks
		end

		function wakaba:UpdateWakabaDescriptions()
			EID._currentMod = "Pudding and Wakaba"
			EID:addEntity(wakaba.INVDESC_TYPE_CURSE, -1, -1, "Curses")
			EID:setModIndicatorName("Pudding & Wakaba")
			EID:setModIndicatorIcon("Player"..wakaba.PLAYER_WAKABA.."", true)
			for cardid, carddata in pairs(wakaba.descriptions["en_us"].cards) do
				if carddata.mimiccharge then
					EID:addCardMetadata(cardid, carddata.mimiccharge, carddata.isrune)
				end
			end
			for pillid, pilldata in pairs(wakaba.descriptions["en_us"].pills) do
				EID:addPillMetadata(pillid, pilldata.mimiccharge, pilldata.class)
			end
			for card, frame in pairs(wakaba.CardSpriteFrames) do
				EID:addIcon("Card"..card, "Cards", frame, 9, 9, -1, 0, wakaba.CardSprite)
			end
			for playerType, anim in pairs(wakaba.PlayerSpriteAnimName) do
				EID:addIcon("Player"..playerType, anim, 0, 12, 12, -1, 1, wakaba.PlayerIconSprite)
			end
			EID:addIcon("WakabaCurseFlames", "EID_Curses", 0, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaCurseSatyr", "EID_Curses", 10, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseFlames", "EID_Curses", 1, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseDarkness", "EID_Curses", 2, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseLabyrinth", "EID_Curses", 3, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseLost", "EID_Curses", 4, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseUnknown", "EID_Curses", 5, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseCursed", "EID_Curses", 6, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseMaze", "EID_Curses", 7, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseBlind", "EID_Curses", 8, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseGiant", "EID_Curses", 9, 12, 11, -1, 0, wakaba.MiniMapAPISprite)

			EID:addIcon("Beast", "Destination", 0, 17, 16, 0, -2, wakaba.TargetIcons)
			EID:addIcon("BeastSmall", "Destination", 1, 13, 9, 0, 1, wakaba.TargetIcons)

			EID.MarkupSizeMap["{{Beast}}"] = "{{BeastSmall}}"

			--[[ if Sewn_API then -- no support for multilang sadly
				for familiar, famdesc in pairs(wakaba.descriptions["en_us"].sewnupgrade) do
					Sewn_API:AddFamiliarDescription(familiar, famdesc.super, famdesc.ultra)
				end
			end ]]
			for lang, wakabaDescTables in pairs(wakaba.descriptions) do
				--print(lang)
				for itemID, itemdesc in pairs(wakabaDescTables.collectibles) do
					EID:addCollectible(itemID, itemdesc.description, itemdesc.itemName, lang)
					if lang == "en_us" and itemdesc.transformations then
						EID:assignTransformation("collectible", itemID, itemdesc.transformations)
					end
				end
				for itemID, itemdesc in pairs(wakabaDescTables.trinkets) do
					EID:addTrinket(itemID, itemdesc.description, itemdesc.itemName, lang)
					if lang == "en_us" and itemdesc.transformations then
						EID:assignTransformation("trinket", itemID, itemdesc.transformations)
					end
				end
				for playerType, birthrightdesc in pairs(wakabaDescTables.birthright) do
					EID:addBirthright(playerType, birthrightdesc.description, birthrightdesc.playerName, lang)
				end
				for cardid, carddesc in pairs(wakabaDescTables.cards) do
					EID:addCard(cardid, carddesc.description, carddesc.itemName, lang)
				end
				for pillid, pilldesc in pairs(wakabaDescTables.pills) do
					EID:addPill(pillid, pilldesc.description, pilldesc.itemName, lang)
				end
				--EID:addHorsePill doesn't exist lol
				EID:updateDescriptionsViaTable(wakabaDescTables.horsepills, EID.descriptions[lang].horsepills)
				--[[ for pillid, pilldesc in pairs(wakabaDescTables.horsepills) do
					EID:addPill(pillid+2048, pilldesc.description, pilldesc.itemName, lang, pilldesc.mimiccharge, pilldesc.class)
				end ]]
				for _, entitydesc in pairs(wakabaDescTables.entities) do
					EID:addEntity(entitydesc.type, entitydesc.variant, entitydesc.subtype, entitydesc.name, entitydesc.description, lang)
				end
				for playertype, playerdesc in pairs(wakabaDescTables.playernotes) do
					EID:addEntity(wakaba.INVDESC_TYPE_PLAYER, wakaba.INVDESC_VARIANT, playertype, playerdesc.name, playerdesc.description, lang)
				end
				for curseid, cursedesc in pairs(wakabaDescTables.curses) do
					EID:addEntity(wakaba.INVDESC_TYPE_CURSE, wakaba.INVDESC_VARIANT, curseid, cursedesc.name, cursedesc.description, lang)
				end
				if CURCOL and wakabaDescTables.cursesappend and wakabaDescTables.cursesappend.CURCOL then
					for curseid, cursedesc in pairs(wakabaDescTables.cursesappend.CURCOL) do
						EID:addEntity(wakaba.INVDESC_TYPE_CURSE, wakaba.INVDESC_VARIANT, curseid, cursedesc.name, cursedesc.description, lang)
						wakabaDescTables.curses[curseid] = wakabaDescTables.cursesappend.CURCOL[curseid]
					end
				end
				-- Curses for Furtherance will be removed
				--[[ if further and wakabaDescTables.cursesappend and wakabaDescTables.cursesappend.further then
					for curseid, cursedesc in pairs(wakabaDescTables.cursesappend.further) do
						EID:addEntity(-998, -1, curseid, cursedesc.description, cursedesc.name, lang)
						wakaba.descriptions[desclang].curses[curseid] = wakabaDescTables.cursesappend.further[curseid]
					end
				end ]]
				if Sewn_API then
					for familiar, famdesc in pairs(wakabaDescTables.sewnupgrade) do
						Sewn_API:AddFamiliarDescription(familiar, famdesc.super, famdesc.ultra, nil, famdesc.name, lang)
					end
				end
			end

			for curseid, cursedesc in pairs(wakaba.descriptions["en_us"].curses) do
				EID:AddIconToObject(wakaba.INVDESC_TYPE_CURSE, wakaba.INVDESC_VARIANT, curseid, cursedesc.icon)
			end


			EID:addDescriptionModifier("Wakaba", WakabaCondition, WakabaCallback)
			EID:addDescriptionModifier("Tainted Wakaba", WakabaCondition_b, WakabaCallback_b)
			EID:addDescriptionModifier("Wakaba's Blessing", BlessingCondition, BlessingCallback)
			EID:addDescriptionModifier("Wakaba's Nemesis", NemesisCondition, NemesisCallback)
			EID:addDescriptionModifier("Shiori", ShioriCondition, ShioriCallback)
			EID:addDescriptionModifier("Tainted Shiori", ShioriCondition_b, ShioriCallback_b)

			EID:addDescriptionModifier("Book of Shiori", ShioriBookCondition, ShioriBookCallback)
			EID:addDescriptionModifier("Wakaba Judas Birthright", JudasCondition, JudasCallback)
			EID:addDescriptionModifier("Wakaba Binge Eater", BingeeaterCondition, BingeeaterCallback)
			EID:addDescriptionModifier("Wakaba Book of Virtues", BookOfVirtuesCondition, BookOfVirtuesCallback)
			EID:addDescriptionModifier("Wakaba Abyss", AbyssCondition, AbyssCallback)
			EID:addDescriptionModifier("Wakaba Tarot Cloth", WakabaTarotCardCondition, WakabaTarotCardCallback)
			EID:addDescriptionModifier("Better Voiding detection", BetterVoidingCondition, BetterVoidingCallback)
	
			
			--EID:addDescriptionModifier("Pudding and Wakaba", EIDWakabaConditions, nil)
			wakaba:ReplaceEIDBagWeight()
			
			EID._currentMod = "Pudding and Wakaba_reserved"
		end

		--wakaba:UpdateWakabaDescriptions()
	  --EID:addDescriptionModifier("Wakaba's Horse Pills", WakabaPillCondition, WakabaPillCallback)
		
		local checkedWakabaAchievement = false

		local function getmarkup(val)
			if val == 2 then 
				return "{{IconRedTint}}"
			elseif val == 1 then 
				return "" 
			else 
				return "{{IconBlack}}"
			end
		end

		local function getboolup(val)
			if val then 
				return ""
			else 
				return "{{IconBlack}}"
			end
		end
		
		function wakaba:CheckWakabaAchievementString()
			local str = "#Colored:Normal/Red:Hard"
			-- Wakaba
			str = str .. "#{{Player"..wakaba.PLAYER_WAKABA.."}} "
			str = str .. getmarkup(wakaba.state.unlock.clover) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlock.counter) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlock.dcupicecream) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlock.pendant) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlock.revengefruit) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.donationcard) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.colorjoker) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.whitejoker) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.wakabauniform) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.cranecard) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.confessionalcard) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.returnpostage) .. "{{Beast}}"
			str = str .. getboolup(wakaba.state.unlock.blessing) .. "{{VictoryLap}}"
			str = str .. "#{{Player"..wakaba.PLAYER_WAKABA_B.."}} "
			str = str .. getmarkup(wakaba.state.unlock.taintedwakabamomsheart) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofforgotten1) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofforgotten2) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofforgotten3) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofforgotten4) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.wakabasoul1) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.wakabasoul2) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.cloverchest) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.eatheart) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.blackjoker) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.bitcoin) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.nemesis) .. "{{Beast}}"
			str = str .. "#{{Player"..wakaba.PLAYER_SHIORI.."}} "
			str = str .. getmarkup(wakaba.state.unlock.hardbook) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlock.shiorid6plus) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlock.bookoffocus) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlock.deckofrunes) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlock.grimreaperdefender) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.unknownbookmark) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofgatling) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.bookoffallen) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofsilence) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.determinationribbon) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.bookoftheking) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofthegod) .. "{{Beast}}"
			str = str .. getboolup(wakaba.state.unlock.bookofshiori) .. "{{VictoryLap}}"
			str = str .. "#{{Player"..wakaba.PLAYER_SHIORI_B.."}} "
			str = str .. getmarkup(wakaba.state.unlock.taintedshiorimomsheart) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlock.bookmarkbag1) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlock.bookmarkbag2) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlock.bookmarkbag3) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlock.bookmarkbag4) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.shiorisoul1) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.shiorisoul2) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.librarycard) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofconquest) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.queenofspades) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.ringofjupiter) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.minervaaura) .. "{{Beast}}"
			str = str .. "#{{Player"..wakaba.PLAYER_TSUKASA.."}} "
			str = str .. getmarkup(wakaba.state.unlock.murasame) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlock.nasalover) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlock.beetlejuice) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlock.totalcorruption) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlock.powerbomb) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.concentration) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.rangesystem) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.beam) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.newyearbomb) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.questionblock) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.phantomcloak) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.hydra) .. "{{Beast}}"
			str = str .. getboolup(wakaba.state.unlock.lunarstone) .. "{{VictoryLap}}"
			str = str .. "#"..getboolup(wakaba.state.unlock.taintedtsukasa) .. "{{Player"..wakaba.PLAYER_TSUKASA_B.."}} "
			str = str .. getmarkup(wakaba.state.unlock.taintedtsukasamomsheart) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlockisaaccartridge1) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlockisaaccartridge2) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlockisaaccartridge3) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlockisaaccartridge4) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.tsukasasoul1) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.tsukasasoul2) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.maplesyrup) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.flashshift) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.returncard) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.sirenbadge) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.elixiroflife) .. "{{Beast}}"
			str = str .. "#{{Trophy}} "
			str = str .. getboolup(wakaba.state.unlock.eyeofclock) .. "{{Collectible"..wakaba.COLLECTIBLE_EYE_OF_CLOCK.."}}"
			str = str .. getboolup(wakaba.state.unlock.plumy) .. "{{Collectible"..wakaba.COLLECTIBLE_PLUMY.."}}"
			str = str .. getboolup(wakaba.state.unlock.delimiter) .. "{{Trinket"..wakaba.TRINKET_DELIMITER.."}}"
			str = str .. getboolup(wakaba.state.unlock.nekodoll) .. "{{Collectible"..wakaba.COLLECTIBLE_NEKO_FIGURE.."}}"
			str = str .. getboolup(wakaba.state.unlock.microdoppelganger) .. "{{Collectible"..wakaba.COLLECTIBLE_MICRO_DOPPELGANGER.."}}"
			str = str .. getboolup(wakaba.state.unlock.delirium) .. "{{Trinket"..wakaba.TRINKET_DIMENSION_CUTTER.."}}"
			str = str .. getboolup(wakaba.state.unlock.lilwakaba) .. "{{Collectible"..wakaba.COLLECTIBLE_LIL_WAKABA.."}}"
			str = str .. getboolup(wakaba.state.unlock.lostuniform) .. "{{Player31}}"
			str = str .. getboolup(wakaba.state.unlock.executioner) .. "{{Collectible"..wakaba.COLLECTIBLE_EXECUTIONER.."}}"
			str = str .. getboolup(wakaba.state.unlock.apollyoncrisis) .. "{{Collectible"..wakaba.COLLECTIBLE_APOLLYON_CRISIS.."}}"
			str = str .. getboolup(wakaba.state.unlock.deliverysystem) .. "{{Collectible"..wakaba.COLLECTIBLE_ISEKAI_DEFINITION.."}}"
			str = str .. getboolup(wakaba.state.unlock.calculation) .. "{{Collectible"..wakaba.COLLECTIBLE_BALANCE.."}}"
			str = str .. getboolup(wakaba.state.unlock.lilmao) .. "{{Collectible"..wakaba.COLLECTIBLE_LIL_MAO.."}}"
			str = str .. getboolup(wakaba.state.unlock.edensticky) .. "{{Collectible"..wakaba.COLLECTIBLE_EDEN_STICKY_NOTE.."}}"
			str = str .. getboolup(wakaba.state.unlock.doubledreams) .. "{{Collectible"..wakaba.COLLECTIBLE_DOUBLE_DREAMS.."}}"

			return str
		end
		
		function wakaba:RenderWakabaAchievement()
			if Game():GetFrameCount() > wakaba.unlockdisplaytimer and Game():GetFrameCount() < (wakaba.unlockdisplaytimer + 10*30) then
				local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
				demoDescObj.Name = "{{Player"..Isaac.GetPlayerTypeByName("Wakaba", false).."}} Pudding & Wakaba - completion mark status"
				demoDescObj.Description = wakaba.eidunlockstr
				EID:displayPermanentText(demoDescObj)
				checkedWakabaAchievement = true
			elseif checkedWakabaAchievement then
				wakaba:RemoveCallback(ModCallbacks.MC_POST_RENDER, wakaba.RenderWakabaAchievement)
				EID:hidePermanentText()
				wakaba.eidunlockstr = ""
				checkedWakabaAchievement = false
			end
		end
		function wakaba:RenderWakabaDebug()
			if Game():GetFrameCount() > wakaba.unlockdisplaytimer and Game():GetFrameCount() < (wakaba.unlockdisplaytimer + 10*30) then
				local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
				demoDescObj.Name = "{{Player"..Isaac.GetPlayerTypeByName("Wakaba", false).."}} Pudding & Wakaba - ?????? ?????? ????????????"
				demoDescObj.Description = "#??????????????????????????????????????????"
				.."#?????? ?????? ????????? ??????, ?????????. ????????? ????????? ???????????? ????????? ???????????? ?????????. ????????? ???????????? ???????????? ???????????? ????????? ????????? ???????????? ?????? ????????????, ?????????? ?????? ????????? ????????? ????????? ????????? ????????? ???????????? ????????????. ?????? ????????????, ????????? ?????? ??? ????????? ???????????? ????????? ?????????. ????????????, ????????? ????????? ?????????. ????????? ?????? ????????? ?????? ???????????????. ????????? ????????? ?????? ??????. ????????? ???????????? ?????????????????? ?????? ?????? ????????? ???????????????. ????????? ????????? ????????? ????????? ????????? ?????? ?????? ????????? ?????? ?????????. ??????????????? ????????? ????????? ?????????????"
				.."#?????? ???????????? ????????? ????????? ???????????? ?????? ????????????, ????????????. ????????? ???????????? ????????? ??? ????????? ???????????????. ????????? ?????? ????????? ????????? ?????????. ????????? ???????????? ????????? ?????????. ?????????????????? ?????? ??? ??????????????? ????????? ?????? ?????? ?????????. ????????????, ????????? ????????? ?????? ?????????, ?????? ?????? ????????? ?????? ?????????. ????????? ?????????.??????, ?????? ?????? ????????? ???????????? ???????????? ?????????. ????????? ????????? ??? ?????? ?????? ?????? ????????????, ?????????, ?????????.??????, ????????????. ?????? ?????? ????????? ????????? ????????? ?????? ?????? ?????????."
				.."#????????? ?????? ?????? ????????? ?????? ???????????? ????????????. ?????? ????????? ????????? ?????? ???????????????, ???????????? ????????? ???????????????? ????????? ????????? ?????????, ???????????? ??????, ?????? ?????? ?????? ?????????.??????, ???????????????. ?????? ???????????? ????????? ???????????????. ?????????, ??? ????????? ?????????? ????????????, ???????????? ?????????, ????????? ????????? ????????? ?????????. ?????? ????????? ????????? ?????? ?????????, ?????? ????????????? ????????? ????????? ??????, ????????? ????????????. ?????? ?????? ????????? ??????."
				EID:displayPermanentText(demoDescObj)
				checkedWakabaAchievement = true
			elseif checkedWakabaAchievement then
				wakaba:RemoveCallback(ModCallbacks.MC_POST_RENDER, wakaba.RenderWakabaAchievement)
				EID:hidePermanentText()
				wakaba.eidunlockstr = ""
				checkedWakabaAchievement = false
			end
		end
		--wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.RenderWakabaAchievement)


  end
end