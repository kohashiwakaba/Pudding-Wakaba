local modNameList = {
	"Pudding & Wakaba",
	"Wakaba-chan",
	"Richer-chan",
	"Kyuu~!",
}
local modNameListKorean = {
	"Pudding & Wakaba",
	"리셰의 푸딩",
	"와카바쨩",
	"뀨~!",
	"부끄부끄 리라",
	"말랑말랑 리셰",
}
if EID then
	table.insert(EID.TextReplacementPairs, {">>>", "{{ArrowGrayRight}}"})
	table.insert(EID.TextReplacementPairs, {"↕", "{{ArrowUpDown}}"})
end

wakaba.DamagePenaltyProtectionItems = {
	wakaba.Enums.Collectibles.WAKABAS_BLESSING,
	wakaba.Enums.Collectibles.MINERVA_AURA,
	wakaba.Enums.Collectibles.LUNAR_STONE,
	wakaba.Enums.Collectibles.RABBIT_RIBBON,
	wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER,
	wakaba.Enums.Collectibles.RICHERS_BRA,
}
wakaba.DamagePenaltyProtectionInvalidStr = {}

wakaba.HotkeyToString = {}
for key,num in pairs(Keyboard) do
	local keyString = key
	local keyStart, keyEnd = string.find(keyString, "KEY_")
	keyString = string.sub(keyString, keyEnd+1, string.len(keyString))
	keyString = string.gsub(keyString, "_", " ")
	wakaba.HotkeyToString[num] = keyString
end

wakaba.HotkeyToString[Keyboard.KEY_LEFT_BRACKET] = "["
wakaba.HotkeyToString[Keyboard.KEY_RIGHT_BRACKET] = "]"
wakaba.HotkeyToString[Keyboard.KEY_COMMA] = ","
wakaba.HotkeyToString[Keyboard.KEY_PERIOD] = "."

--convert controller enum to buttons
local ControllerToString = { [0] = "{{ButtonDLeft}}", "{{ButtonDRight}}", "{{ButtonDUp}}", "{{ButtonDDown}}",
"{{ButtonA}}", "{{ButtonB}}", "{{ButtonX}}", "{{ButtonY}}", "{{ButtonLB}}", "{{ButtonLT}}", "{{ButtonLStick}}",
"{{ButtonRB}}", "{{ButtonRT}}", "{{ButtonRStick}}", "{{ButtonSelect}}", "{{ButtonMenu}}" }

if EID then
	if EIDKR then
		print("Pudding and Wakaba no longer supports EID Korean. Use Original External Item Descriptions mod.")
	else

		wakaba.TargetIcons = Sprite()
		wakaba.TargetIcons:Load("gfx/ui/eid_wakaba_bosses.anm2", true)

		wakaba.CardSprite = Sprite()
		wakaba.CardSprite:Load("gfx/eid_cardfronts.anm2", true)
		wakaba.CardSpriteFrames = {
			[wakaba.Enums.Cards.CARD_CRANE_CARD] = 2,
			[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = 3,
			[wakaba.Enums.Cards.CARD_BLACK_JOKER] = 4,
			[wakaba.Enums.Cards.CARD_WHITE_JOKER] = 5,
			[wakaba.Enums.Cards.CARD_COLOR_JOKER] = 6,
			[wakaba.Enums.Cards.CARD_DREAM_CARD] = 8,
			[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = 9,
			[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = 11,
			[wakaba.Enums.Cards.SOUL_WAKABA] = 7,
			[wakaba.Enums.Cards.SOUL_WAKABA2] = 12,
			[wakaba.Enums.Cards.SOUL_SHIORI] = 10,
			[wakaba.Enums.Cards.SOUL_TSUKASA] = 13,
			[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = 14,
			[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = 15,
			[wakaba.Enums.Cards.CARD_VALUT_RIFT] = 16,
			[wakaba.Enums.Cards.CARD_TRIAL_STEW] = 17,
			[wakaba.Enums.Cards.SOUL_RICHER] = 18,
			[wakaba.Enums.Cards.CARD_RICHER_TICKET] = 19,
			[wakaba.Enums.Cards.CARD_RIRA_TICKET] = 20,
			[wakaba.Enums.Cards.CARD_FLIP] = 21,
			[wakaba.Enums.Cards.SOUL_RIRA] = 22,
		}
		wakaba.PlayerIconSprite = Sprite()
		wakaba.PlayerIconSprite:Load("gfx/ui/eid_wakaba_players.anm2", true)
		wakaba.PlayerSpriteAnimName = {
			[wakaba.Enums.Players.WAKABA] = "Wakaba",
			[wakaba.Enums.Players.WAKABA_B] = "WakabaB",
			[wakaba.Enums.Players.SHIORI] = "Shiori",
			[wakaba.Enums.Players.SHIORI_B] = "ShioriB",
			[wakaba.Enums.Players.TSUKASA] = "Tsukasa",
			[wakaba.Enums.Players.TSUKASA_B] = "TsukasaB",
			[wakaba.Enums.Players.RICHER] = "Richer",
			[wakaba.Enums.Players.RICHER_B] = "RicherB",
			[wakaba.Enums.Players.RIRA] = "Rira",
			[wakaba.Enums.Players.RIRA_B] = "RiraB",
			[wakaba.Enums.Players.ANNA] = "Anna",
		}

		function wakaba:getWakabaDesc(entries, id)
			lang = EID:getLanguage() or "en_us"
			local entrytables = wakaba.descriptions[lang] or wakaba.descriptions["en_us"]
			if id then
				if entrytables[entries] then
					return entrytables[entries][id]
				else
					entrytables = wakaba.descriptions["en_us"]
					if entrytables[entries] then
						return entrytables[entries][id]
					end
				end
			else
				return entrytables[entries]
			end
		end

		table.insert(EID.TextReplacementPairs, {"{{WakabaBless}}","{{Collectible" .. wakaba.Enums.Collectibles.WAKABAS_BLESSING .. "}}"})
		table.insert(EID.TextReplacementPairs, {"{{WakabaNemesis}}","{{Collectible" .. wakaba.Enums.Collectibles.WAKABAS_NEMESIS .. "}}"})
		table.insert(EID.TextReplacementPairs, {"{{Shiori}}","{{Collectible" .. wakaba.Enums.Collectibles.BOOK_OF_SHIORI .. "}}"})
		table.insert(EID.TextReplacementPairs, {"{{Judasbr}}","{{Collectible" .. CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL .. "}}"})
		table.insert(EID.TextReplacementPairs, {"{{WakabaBlankCard}}","{{Collectible" .. CollectibleType.COLLECTIBLE_CLEAR_RUNE .. "}}"})
		table.insert(EID.TextReplacementPairs, {"{{WakabaPlacebo}}","{{Collectible" .. CollectibleType.COLLECTIBLE_PLACEBO .. "}}"})
		table.insert(EID.TextReplacementPairs, {"{{WakabaClearRune}}","{{Collectible" .. CollectibleType.COLLECTIBLE_CLEAR_RUNE .. "}}"})


		-- Function for handling colors that fade between multiple different colors (rainbow, gold, tarot cloth purple)
		local function SwagColors(colors, maxAnimTime)
			maxAnimTime = maxAnimTime or 80
			local animTime = Game():GetFrameCount() % maxAnimTime
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
		end

		EID:addColor("ColorWakabaBless", KColor(0.827, 0.831, 0.992, 1))
		EID:addColor("ColorSoul", KColor(0.827, 0.831, 0.992, 1))
		EID:addColor("ColorWakabaNemesis", KColor(0.921, 0.6, 0.603, 1))
		EID:addColor("ColorBookofShiori", KColor(0.462, 0.474, 0.937, 1))
		EID:addColor("ColorBoCLight", KColor(1, 0.537, 0.867, 1))
		EID:addColor("ColorBocDark", KColor(0.941, 0.357, 0.69, 1))
		EID.InlineIcons["IconRedTint"] = function(_)
			EID._NextIconModifier = function(sprite)
				sprite.Color = Color(1, 1, 1, EID.Config["Transparency"] * 0.5, 0.8, -1.5, -1.5)
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
			local c = EID.InlineColors
			return SwagColors({c["ColorBoCLight"], c["ColorBocDark"]})
		end)
		EID:addColor("ColorRicher", nil, function(_)
			return SwagColors({KColor(0.6, 0.74, 0.88, 1), KColor(0.31, 0.26, 0.49, 1), KColor(0.21, 0.16, 0.3, 1)})
		end)
		EID:addColor("ColorRira", nil, function(_)
			return SwagColors({KColor(1, 0.74, 0.76, 1), KColor(0.87, 0.42, 0.57, 1), KColor(0.76, 0.28, 0.57, 1)})
		end)
		EID:addColor("ColorCiel", nil, function(_)
			return SwagColors({KColor(1, 0.74, 0.49, 1), KColor(0.4, 0.2, 0, 1), KColor(1, 0.91, 0.79, 1)})
		end)
		EID:addColor("ColorKoron", nil, function(_)
			return SwagColors({KColor(0.75, 0.66, 0.87, 1), KColor(0.5, 0.37, 0.55, 1), KColor(0.22, 0.11, 0.25, 1)})
		end)

		EID.NoRedHeartsPlayerIDs[wakaba.Enums.Players.WAKABA_B] = true
		EID.NoRedHeartsPlayerIDs[wakaba.Enums.Players.SHIORI_B] = true
		EID.NoRedHeartsPlayerIDs[wakaba.Enums.Players.RICHER_B] = true
		EID.NoRedHeartsPlayerIDs[wakaba.Enums.Players.RIRA_B] = true

		local function LastPoolCondition(descObj)
			if EID.InsideItemReminder then return false end
			if not descObj.Entity then return false end
			return descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE
		end

		local function LastPoolCallback(descObj)
			local ddstr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].doubledreams) or wakaba.descriptions["en_us"].doubledreams
			local current = wakaba.G:GetItemPool():GetLastPool()
			local currentPoolData = wakaba.VanillaPoolDatas[current]
			descObj.Description = "{{ColorSilver}}"..ddstr.lastpool.. ": " ..(currentPoolData.Icon or "{{SuperSecretRoom}}") .. "" .. (ddstr[(currentPoolData.StringID or "Default")] or "???").."{{CR}}#"..descObj.Description
			return descObj
		end

		-- Handle Horse Pills of Pudding and Wakaba description
		local function WakabaPillCondition(descObj)
			if descObj.ObjType == 5 or descObj.ObjVariant == PickupVariant.PICKUP_PILL and descObj.SubType > 2048 then
				return true
			end
			return false
		end

		local function ValutCondition(descObj)
			if EID.Config["DisplayCraneInfo"]
			and descObj.ObjType == 6
			and descObj.ObjVariant == wakaba.Enums.Slots.SHIORI_VALUT
			and not (descObj.Entity:GetSprite():IsPlaying("Death") or descObj.Entity:GetSprite():IsPlaying("Broken"))
			and wakaba:getValutRewards(descObj.Entity) then
				return true
			end
			return false
		end

		local function ValutCallback(descObj)
			local entity = descObj.Entity
			local collectibleID = wakaba:getValutRewards(entity).item
			descriptionObj = EID:getDescriptionObj(5, 100, collectibleID)
			if EID:getEntityData(entity, "EID_DontHide") ~= true then
				if (EID:hasCurseBlind() and EID.Config["DisableOnCurse"]) or (wakaba.G.Challenge == Challenge.CHALLENGE_APRILS_FOOL and EID.Config["DisableOnAprilFoolsChallenge"]) then
					descriptionObj = { Description = "QuestionMark", Entity = entity}
				end
			end
			return descriptionObj
		end

		local function CatalogCondition(descObj)
			if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_EVEN then
				return false
			end
			if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and descObj.ObjSubType == wakaba.Enums.Collectibles.SWEETS_CATALOG then
				return true
			end
			if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_TAROTCARD and descObj.ObjSubType == wakaba.Enums.Cards.CARD_RICHER_TICKET then
				return true
			end
			return false
		end

		local function CatalogCallback(descObj)
			local availableCatalogItems = wakaba.CatalogItems
			if availableCatalogItems then
				local description = ""
				for k,v in pairs(availableCatalogItems) do
					if v.Weight > 0 then
						description = description .. "{{Collectible".. v.MainItem .. "}} "
					end
				end
				local iconStr = "#!!! "
				EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
			end
			return descObj
		end

		table.insert(EID.collectiblesToCheck, wakaba.Enums.Collectibles.APOLLYON_CRISIS)

		local collectiblesOwned = {}
		local hasPlayer = {}

		function wakaba:UpdateWakabaDescriptions(lunaticOnly)

			local gmName = modNameList[(Isaac.GetTime() % #modNameList)+1]
			local gmkName = modNameListKorean[(Isaac.GetTime() % #modNameListKorean)+1]

			local nameToUse = EID:getLanguage() == "ko_kr" and gmkName or gmName
			if wakaba.Flags.disableRandomEIDModNames then
				nameToUse = "Pudding & Wakaba"
			end
			local currentVerName = ""
			if REPENTANCE_PLUS then
				currentVerName = "[R+]"
			elseif REPENTOGON then
				currentVerName = "[RGON]"
			elseif REPENTANCE then
				currentVerName = "[REP]"
			end

			EID._currentMod = "Pudding and Wakaba"
			EID:addEntity(wakaba.INVDESC_TYPE_CURSE, -1, -1, "Curses")
			EID:setModIndicatorName(nameToUse .. currentVerName)
			EID:setModIndicatorIcon(REPENTOGON and "WakabaModRgon" or "WakabaMod", true)
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

			for id, dataTable in pairs(wakaba.GoldenTrinketData) do
				EID:addGoldenTrinketTable(id, dataTable)
			end


			EID:addIcon("WakabaCurseFlames", "EID_Curses", 0, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaCurseSatyr", "EID_Curses", 10, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaCurseSniper", "EID_Curses", 11, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaCurseAmnesia", "EID_Curses", 12, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaCurseFairy", "EID_Curses", 13, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaCurseMagicalGirl", "EID_Curses", 14, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseFlames", "EID_Curses", 1, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseDarkness", "EID_Curses", 2, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseLabyrinth", "EID_Curses", 3, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseLost", "EID_Curses", 4, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseUnknown", "EID_Curses", 5, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseCursed", "EID_Curses", 6, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseMaze", "EID_Curses", 7, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseBlind", "EID_Curses", 8, 12, 11, -1, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaAntiCurseGiant", "EID_Curses", 9, 12, 11, -1, 0, wakaba.MiniMapAPISprite)

			EID:addIcon("WakabaMod", "EID_Icons", 0, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaModRgon", "EID_Icons", 1, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("CrystalRestock", "EID_Icons", 2, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("CloverChest", "EID_Icons", 3, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("ShioriValut", "EID_Icons", 4, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("RicherPlanetarium", "EID_Icons", 5, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaModCheat", "EID_Icons", 6, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaModHidden", "EID_Icons", 7, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaModLunatic", "EID_Icons", 8, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)

			EID:addIcon("WakabaAqua", "EID_Icons", 9, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaZip", "EID_Icons", 10, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaBlueFlame", "EID_Icons", 11, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)

			EID:addIcon("WakabaStarYellow", "EID_Icons", 12, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaStarGray", "EID_Icons", 13, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaStarAqua", "EID_Icons", 14, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("WakabaStarPink", "EID_Icons", 15, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)

			EID:addIcon("AquaTrinket", "EID_Icons", 14, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)

			EID:addIcon("RiraTreasure", "EID_Icons", 16, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("AquaTreasure", "EID_Icons", 17, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)

			EID:addIcon("ShioriPrimary", "EID_Icons", 18, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("ShioriSecondary", "EID_Icons", 19, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("ShioriSecDel", "EID_Icons", 20, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			EID:addIcon("Quality5", "Quality", 0, 10, 10, 0, 0, wakaba.MiniMapAPISprite)
			EID:addIcon("Quality6", "Quality", 1, 10, 10, 0, 0, wakaba.MiniMapAPISprite)

			for i = 0, 9 do
				EID:addIcon("WakabaUp"..i, "EID_Up", i, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
				EID:addIcon("WakabaDown"..i, "EID_Down", i, 11, 11, -1.5, -1.5, wakaba.MiniMapAPISprite)
			end

			--EID:addIcon("Beast", "Destination", 0, 17, 16, 0, -2, wakaba.TargetIcons)
			--EID:addIcon("BeastSmall", "Destination", 1, 13, 9, 0, 1, wakaba.TargetIcons)

			--EID.MarkupSizeMap["{{Beast}}"] = "{{BeastSmall}}"

			--[[ if Sewn_API then -- no support for multilang sadly
				for familiar, famdesc in pairs(wakaba.descriptions["en_us"].sewnupgrade) do
					Sewn_API:AddFamiliarDescription(familiar, famdesc.super, famdesc.ultra)
				end
			end ]]
			for lang, wakabaDescTables in pairs(wakaba.descriptions) do
				--print(lang)
				for itemID, itemdesc in pairs(wakabaDescTables.collectibles) do
					if not itemdesc.targetMod then
						EID._currentMod = "Pudding and Wakaba"
					elseif itemdesc.targetMod ~= EID._currentMod then
						EID._currentMod = itemdesc.targetMod
					end
					local desc = wakaba:IsLunatic() and itemdesc.lunatic or itemdesc.description
					EID:addCollectible(itemID, desc, itemdesc.itemName, lang)
					if lang == "en_us" and itemdesc.transformations then
						EID:assignTransformation("collectible", itemID, itemdesc.transformations)
					end
					if lang == "en_us" and itemdesc.LuckFormula then
						EID.LuckFormulas["5.100."..itemID] = itemdesc.LuckFormula
					end
					if itemdesc.duplicate ~= nil then
						if lang == "en_us" and not _wakaba["__descInsertedCore"] then
							wakaba.Log("adding wakaba dip cond", lang, itemID)
							if type(itemdesc.duplicate) == "boolean" and itemdesc.duplicate == false then
								EID:AddSelfConditional({itemID}, "No Effect (Copies)")
							else
								EID:AddSelfConditional({itemID}, "Copies")
							end
						end
						if type(itemdesc.duplicate) == "string" then
							EID.descriptions[lang].ConditionalDescs["5.100."..itemID.." (Copies)"] = itemdesc.duplicate
						end
					end
					if itemdesc.carBattery then
						EID.descriptions[lang].carBattery[itemID] = itemdesc.carBattery
					end
					if itemdesc.wisp then
						--EID.descriptions[lang].bookOfVirtuesWisps[itemID] = itemdesc.wisp
					end
					if itemdesc.bffs then
						EID.descriptions[lang].BFFSSynergies["5.100."..itemID] = itemdesc.bffs
					end
					if itemdesc.belial then
						EID.descriptions[lang].bookOfBelialBuffs[itemID] = itemdesc.belial
					end
					if itemdesc.binge then
						EID.descriptions[lang].bingeEaterBuffs[itemID] = itemdesc.binge
					end
				end
				for itemID, itemdesc in pairs(wakabaDescTables.trinkets) do
					if not itemdesc.targetMod then
						EID._currentMod = "Pudding and Wakaba"
					elseif itemdesc.targetMod ~= EID._currentMod then
						EID._currentMod = itemdesc.targetMod
					end
					local desc = wakaba:IsLunatic() and itemdesc.lunatic or itemdesc.description
					EID:addTrinket(itemID, desc, itemdesc.itemName, lang)
					if lang == "en_us" and itemdesc.transformations then
						EID:assignTransformation("trinket", itemID, itemdesc.transformations)
					end
					if lang == "en_us" and itemdesc.LuckFormula then
						EID.LuckFormulas["5.350."..itemID] = itemdesc.LuckFormula
					end
				end
				for itemID, appendText in pairs(wakabaDescTables.goldtrinkets) do
					EID.descriptions[lang].goldenTrinketEffects[itemID] = { appendText[1], appendText[2], appendText[3] }
				end
				for playerType, chardesc in pairs(wakabaDescTables.characters) do
					-- EID Character desc
					if EID.descriptions[lang].CharacterInfo then
						local csdesc = wakaba:IsLunatic() and chardesc.shortLunatic or chardesc.shortDesc
						EID:addCharacterInfo(playerType, csdesc, chardesc.playerName, lang)
					else
						wakaba.Log("EID.descriptions["..lang.."].CharacterInfo does not exist! skipping...")
					end
					-- Invdesc Character Desc
					local cldesc = wakaba:IsLunatic() and chardesc.detailedLunatic or chardesc.detailedDesc
					EID:addEntity(wakaba.INVDESC_TYPE_PLAYER, wakaba.INVDESC_VARIANT, playerType, chardesc.playerName, cldesc, lang)
					-- Birthright Desc
					local brdesc = wakaba:IsLunatic() and chardesc.birthrightLunatic or chardesc.birthright
					EID:addBirthright(playerType, brdesc, chardesc.playerName, lang)
				end
				for cardid, carddesc in pairs(wakabaDescTables.cards) do
					if not carddesc.targetMod then
						EID._currentMod = "Pudding and Wakaba"
					elseif carddesc.targetMod ~= EID._currentMod then
						EID._currentMod = carddesc.targetMod
					end
					local desc = wakaba:IsLunatic() and carddesc.lunatic or carddesc.description
					EID:addCard(cardid, desc, carddesc.itemName, lang)
					if carddesc.tarot then
						EID.descriptions[lang].tarotClothBuffs[cardid] = carddesc.tarot
					end
				end
				for pillid, pilldesc in pairs(wakabaDescTables.pills) do
					if not pilldesc.targetMod then
						EID._currentMod = "Pudding and Wakaba"
					elseif pilldesc.targetMod ~= EID._currentMod then
						EID._currentMod = pilldesc.targetMod
					end
					local desc = wakaba:IsLunatic() and pilldesc.lunatic or pilldesc.description
					EID:addPill(pillid, desc, pilldesc.itemName, lang)
					if pilldesc.horse then
						local desc = wakaba:IsLunatic() and pilldesc.horselunatic or pilldesc.horse
						EID:addHorsePill(pillid, desc, pilldesc.itemName, lang)
					end
				end
				if lang == "en_us" then
					for itemid, locustTable in pairs(wakabaDescTables.locusts) do
						if not EID.XMLLocusts[itemid] then
							EID.XMLLocusts[itemid] = {
								locustTable.amount or 1,
								locustTable.scale or 1,
								locustTable.speed or 1,
								locustTable.locustFlags1 or {-1},
								locustTable.locustFlags2 or {-1},
								locustTable.locustFlags3 or {-1},
								locustTable.tearFlags1 or {-1},
								locustTable.tearFlags2 or {-1},
								locustTable.tearFlags3 or {-1},
								locustTable.procChance1 or 1,
								locustTable.procChance2 or 1,
								locustTable.procChance3 or 1,
								locustTable.damageMultiplier1 or 1,
								locustTable.damageMultiplier2 or 1
							}
						end
					end
				end
				if not _wakaba["condInserted_"..lang] and wakabaDescTables.conditionals then
					local conDescTables = wakabaDescTables.conditionals
					if conDescTables.collectibles then
						for itemID, wcd in pairs(conDescTables.collectibles) do
							local conditionalEntry = "5.100."..tostring(itemID)
							if lang == "en_us" then
								EID.DescriptionConditions[conditionalEntry] = EID.DescriptionConditions[conditionalEntry] or {}
							end
							if #wcd == 0 then wcd = {wcd} end
							for _, itemdesc in ipairs(wcd) do
								local subEntry = "5.100."..tostring(itemID)
								if itemdesc.modifierText then
									subEntry = conditionalEntry .. " (" .. itemdesc.modifierText .. ")"
								end
								if lang == "en_us" then
									table.insert(EID.DescriptionConditions[conditionalEntry], {
										func = itemdesc.func,
										vars = itemdesc.vars,
										type = itemdesc.type,
										modifierText = itemdesc.modifierText,
										layer = itemdesc.layer or 1,
									})
								end
								-- TODO EID version check
								if not EID.descriptions[lang].ConditionalDescs then
									EID.descriptions[lang].ConditionalDescs = {}
								end
								EID.descriptions[lang].ConditionalDescs[subEntry] = itemdesc.desc
							end
						end
					end
					if conDescTables.trinkets then
						for itemID, wcd in pairs(conDescTables.trinkets) do
							local conditionalEntry = "5.350."..tostring(itemID)
							if lang == "en_us" then
								EID.DescriptionConditions[conditionalEntry] = EID.DescriptionConditions[conditionalEntry] or {}
							end
							if #wcd == 0 then wcd = {wcd} end
							for _, itemdesc in ipairs(wcd) do
								local subEntry = "5.350."..tostring(itemID)
								if itemdesc.modifierText then
									subEntry = conditionalEntry .. " (" .. itemdesc.modifierText .. ")"
								end
								if lang == "en_us" then
									table.insert(EID.DescriptionConditions[conditionalEntry], {
										func = itemdesc.func,
										vars = itemdesc.vars,
										type = itemdesc.type,
										modifierText = itemdesc.modifierText,
										layer = itemdesc.layer or 0,
									})
								end
								-- TODO EID version check
								if not EID.descriptions[lang].ConditionalDescs then
									EID.descriptions[lang].ConditionalDescs = {}
								end
								EID.descriptions[lang].ConditionalDescs[subEntry] = itemdesc.desc
							end
						end
					end
					if conDescTables.cards then
						for itemID, itemdesc in pairs(conDescTables.cards) do
							local conditionalEntry = "5.300."..tostring(itemID)
							if lang == "en_us" then
								EID.DescriptionConditions[conditionalEntry] = {
									func = itemdesc.func,
									vars = itemdesc.vars,
									type = itemdesc.type,
									modifierText = itemdesc.modifierText,
									layer = itemdesc.layer or 0,
								}
							end
							EID.descriptions[lang].ConditionalDescs[conditionalEntry] = itemdesc.desc
						end
					end
					if conDescTables.entities then
						for conditionalEntry, wcd in pairs(conDescTables.entities) do
							if lang == "en_us" then
								EID.DescriptionConditions[conditionalEntry] = {}
							end
							if #wcd == 0 then wcd = {wcd} end
							for _, itemdesc in ipairs(wcd) do
								local subEntry = conditionalEntry
								if itemdesc.modifierText then
									subEntry = conditionalEntry .. " (" .. itemdesc.modifierText .. ")"
								end
								if lang == "en_us" then
									table.insert(EID.DescriptionConditions[conditionalEntry], {
										func = itemdesc.func,
										vars = itemdesc.vars,
										type = itemdesc.type,
										modifierText = itemdesc.modifierText,
										layer = itemdesc.layer or 0,
									})
								end
								-- TODO EID version check
								if not EID.descriptions[lang].ConditionalDescs then
									EID.descriptions[lang].ConditionalDescs = {}
								end
								EID.descriptions[lang].ConditionalDescs[subEntry] = itemdesc.desc
							end
						end
					end
				end
				_wakaba["condInserted_"..lang] = true
				if not _wakaba["condInserted_global"] then
					EID:AddSynergyConditional(wakaba.Enums.Collectibles.VINTAGE_THREAT, wakaba.DamagePenaltyProtectionItems, "WakabaVintageInvalidates", "WakabaVintageInvalidated")

					_wakaba["condInserted_global"] = true
				end
				EID._currentMod = "Pudding and Wakaba"
				for _, entitydesc in pairs(wakabaDescTables.entities) do
					local desc = wakaba:IsLunatic() and entitydesc.lunatic or entitydesc.description
					EID:addEntity(entitydesc.type, entitydesc.variant, entitydesc.subtype, entitydesc.name, desc, lang)
				end
				for uniformType, uniformDesc in pairs(wakabaDescTables.richeruniform) do
					if uniformType == "default" then uniformType = 0 end
					local desc = uniformDesc
					local icon, _, name, actualDesc = string.match(desc, "({{.-}}) ({{.-}})(.-)#(.+)")
					icon = icon:gsub("%{{(.*)}}", "%1")
					EID:addEntity(-996, 0, uniformType, name, actualDesc, lang)
					EID:AddIconToObject(-996, 0, uniformType, icon)
				end
				for playertype, playerdesc in pairs(wakabaDescTables.playernotes) do
					if not playerdesc._fromCharDesc then
						local desc = wakaba:IsLunatic() and playerdesc.lunatic or playerdesc.description
						EID:addEntity(wakaba.INVDESC_TYPE_PLAYER, wakaba.INVDESC_VARIANT, playertype, playerdesc.name, desc, lang)
					end
				end
				for curseid, cursedesc in pairs(wakabaDescTables.curses) do
					local desc = wakaba:IsLunatic() and cursedesc.lunatic or cursedesc.description
					EID:addEntity(wakaba.INVDESC_TYPE_CURSE, wakaba.INVDESC_VARIANT, curseid, cursedesc.name, desc, lang)
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
				if lang == "en_us" then
					_wakaba["__descInsertedCore"] = true
				end
			end
			if lunaticOnly then return end

			for curseid, cursedesc in pairs(wakaba.descriptions["en_us"].curses) do
				EID:AddIconToObject(wakaba.INVDESC_TYPE_CURSE, wakaba.INVDESC_VARIANT, curseid, cursedesc.icon)
			end



			-- Handle Book of Shiori description addition
			local function ShioriBookCondition(descObj)
				if descObj.ObjType ~= 5 or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
					return false
				end
				for i = 0,wakaba.G:GetNumPlayers() - 1 do
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
					local primary = wakabaBuff.primary
					if primary and primary ~= "" then
						local iconStr = "#{{ShioriPrimary}} "
						EID:appendToDescription(descObj, iconStr.. primary)
					end
					local secondary = wakabaBuff.secondary
					if secondary and secondary ~= "" then
						local iconStr = "#{{ShioriSecondary}} "
						EID:appendToDescription(descObj, iconStr.. secondary)
					end

					local description = wakabaBuff.description
					if description and description ~= "" then
						local iconStr = "#"
						EID:appendToDescription(descObj, iconStr.. description)
					end
				end
				return descObj
			end
			--EID:addDescriptionModifier("Wakaba Last Pool", LastPoolCondition, LastPoolCallback)

			-- Handle Apollyon Crisis description addition
			local function ApcCond(descObj)
				if descObj.ObjType ~= 5 then return false end
				EID:CheckPlayersCollectibles()
				local callbacks = {}
				if descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE then
					if EID.collectiblesOwned[wakaba.Enums.Collectibles.APOLLYON_CRISIS] then
						EID.collectiblesOwned[706] = EID.collectiblesOwned[wakaba.Enums.Collectibles.APOLLYON_CRISIS]
						if EID.Config["DisplayVoidStatInfo"] then
							EID.collectiblesOwned[477] = EID.collectiblesOwned[wakaba.Enums.Collectibles.APOLLYON_CRISIS]
						end
					end
				end
				return callbacks
			end

			EID:addDescriptionModifier("Book of Shiori", ShioriBookCondition, ShioriBookCallback)
			EID:addDescriptionModifier("Sweets Catalog", CatalogCondition, CatalogCallback)
			EID:addDescriptionModifier("Shiori's Valut", ValutCondition, ValutCallback)
			--EID:addDescriptionModifier("Apollyon Crisis", ApcCond)



			local function CaramellaCondition(descObj)
				if descObj.Description and (
						descObj.Description:find("{wakaba_extra_left}")
						or descObj.Description:find("{wakaba_extra_right}")
						or descObj.Description:find("{wakaba_extra_dleft}")
						or descObj.Description:find("{wakaba_extra_dright}")
					) then
					return true
				end
				return false
			end
			local function CaramellaCallback(descObj)
				local left = wakaba:getOptionValue("exl")
				local right = wakaba:getOptionValue("exr")
				local dleft = wakaba:getOptionValue("gdkey")
				local dright = wakaba:getOptionValue("gpkey")

				local controllerEnabled = #wakaba:getAllMainPlayers() > 0
				local leftKey = wakaba.HotkeyToString[left]
				local rightKey = wakaba.HotkeyToString[right]
				local dleftKey = wakaba.HotkeyToString[dleft]
				local drightKey = wakaba.HotkeyToString[dright]
				--local leftButton = controllerEnabled and ControllerToString[ButtonAction.ACTION_DROP]

				descObj.Description = descObj.Description:gsub("{wakaba_extra_left}", leftKey)
				descObj.Description = descObj.Description:gsub("{wakaba_extra_right}", rightKey)
				descObj.Description = descObj.Description:gsub("{wakaba_extra_dleft}", dleftKey)
				descObj.Description = descObj.Description:gsub("{wakaba_extra_dright}", drightKey)
				return descObj
			end
			EID:addDescriptionModifier("Wakaba Extra Keys", CaramellaCondition, CaramellaCallback)

			local function DmgProtectionInvalidCond(descObj)
				if not wakaba.DamagePenaltyProtectionInvalidStr or #wakaba.DamagePenaltyProtectionInvalidStr == 0 then return false end
				if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and wakaba:has_value(wakaba.DamagePenaltyProtectionItems, descObj.ObjSubType) then
					return descObj.ObjSubType ~= wakaba.Enums.Collectibles.RICHERS_BRA
				end
				return false
			end
			local function DmgProtectionInvalidCall(descObj)
				local append = EID:getDescriptionEntry("WakabaDmgProtectionInvalid") or EID:getDescriptionEntryEnglish("WakabaDmgProtectionInvalid")
				EID:appendToDescription(descObj, "#!!! ".. append)
				for _, a in ipairs(wakaba.DamagePenaltyProtectionInvalidStr) do
					EID:appendToDescription(descObj, "#>>> ".. a)
				end
				return descObj
			end
			EID:addDescriptionModifier("Wakaba Damage Protection invalidation", DmgProtectionInvalidCond, DmgProtectionInvalidCall)

			EID._currentMod = "Pudding and Wakaba_reserved"
		end

	end
end

wakaba.LanguageMap = {
	["en"] = "en_us",
	["jp"] = "ja_jp",
	["es"] = "spa",
	["de"] = "de",
	["ru"] = "ru",
	["kr"] = "ko_kr",
	["zh"] = "zh_cn",
}
wakaba.Blacklists.NameLocalization = {
	function() return DaRules ~= nil end,
}
local languageMap = wakaba.LanguageMap

local i_queueLastFrame = {}
local i_queueNow = {}
function wakaba:RegisterLegacyItemNames()

wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player) ---@param player EntityPlayer
	if Options.Language == "en" then return end
	local descTable = wakaba.descriptions[languageMap[Options.Language]]
	if not descTable then return end

	local initSeed = tostring(player.InitSeed)

	i_queueNow[initSeed] = player.QueuedItem.Item
	if (i_queueNow[initSeed] ~= nil) then
		if i_queueNow[initSeed].ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
			local playerType = player:GetPlayerType()
			for playerID, itemdesc in pairs(descTable.characters) do
				if (playerType == playerID and i_queueNow[initSeed]:IsCollectible() and i_queueLastFrame[initSeed] == nil) then
					local itemName = descTable.birthrightName
					local queueDesc = itemdesc.queueDesc or i_queueNow[initSeed].Description
					wakaba.G:GetHUD():ShowItemText(itemName, queueDesc)
					goto skipExtra
				end
			end

			::skipExtra::
		else
			for itemID, itemdesc in pairs(descTable.collectibles) do
				if (i_queueNow[initSeed].ID == itemID and i_queueNow[initSeed]:IsCollectible() and i_queueLastFrame[initSeed] == nil) then
					local itemName = itemdesc.itemName or i_queueNow[initSeed].Name
					local queueDesc = itemdesc.queueDesc or i_queueNow[initSeed].Description
					wakaba.G:GetHUD():ShowItemText(itemName, queueDesc)
					goto skipExtra
				end
			end

			::skipExtra::
		end
	end
	i_queueLastFrame[initSeed] = i_queueNow[initSeed]
end)


local t_queueLastFrame = {}
local t_queueNow = {}
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player) ---@param player EntityPlayer
	if Options.Language == "en" then return end
	local descTable = wakaba.descriptions[languageMap[Options.Language]]
	if not descTable then return end

	local initSeed = tostring(player.InitSeed)

	t_queueNow[initSeed] = player.QueuedItem.Item
	if (t_queueNow[initSeed] ~= nil) then
		for itemID, itemdesc in pairs(descTable.trinkets) do
			if (t_queueNow[initSeed].ID == itemID and t_queueNow[initSeed]:IsTrinket() and t_queueLastFrame[initSeed] == nil) then
				local itemName = itemdesc.itemName or t_queueNow[initSeed].Name
				local queueDesc = itemdesc.queueDesc or t_queueNow[initSeed].Description
				wakaba.G:GetHUD():ShowItemText(itemName, queueDesc)
				goto skipExtra
			end
		end

		::skipExtra::
	end
	t_queueLastFrame[initSeed] = t_queueNow[initSeed]
end)

end
function wakaba:RegisterBirthrightLegacyItemNames()
	wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player) ---@param player EntityPlayer
		if Options.Language == "en" then return end
		local descTable = wakaba.descriptions[languageMap[Options.Language]]
		if not descTable then return end

		local initSeed = tostring(player.InitSeed)

		i_queueNow[initSeed] = player.QueuedItem.Item
		if (i_queueNow[initSeed] ~= nil) then
			if i_queueNow[initSeed].ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
				local playerType = player:GetPlayerType()
				if descTable.characters[playerType] and i_queueNow[initSeed]:IsCollectible() and i_queueLastFrame[initSeed] == nil then
					local itemName = descTable.birthrightName
					local queueDesc = descTable.characters[playerType].queueDesc or i_queueNow[initSeed].Description
					wakaba.G:GetHUD():ShowItemText(itemName, queueDesc)
				end
			end
		end
		i_queueLastFrame[initSeed] = i_queueNow[initSeed]
	end)
end

if not REPENTOGON then
	wakaba:RegisterLegacyItemNames()
end
