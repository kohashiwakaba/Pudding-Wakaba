-- Todos : Add weight values for EID Bag of Crafting

if EID then
	if EIDKR then
		print("Pudding and Wakaba no longer supports EID Korean. Use Original External Item Descriptions mod.")
	else

		wakaba.TextOffset = {
			[wakaba.Enums.Players.RICHER_B] = wakaba.Enums.Constants.RICHER_B_HUD_OFFSET,
		}

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
		}
--[[
		wakaba.EIDBlankCardCooldowns = {
			-- Blank Card
			[wakaba.Enums.Cards.CARD_CRANE_CARD] = 5,
			[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = 4,
			[wakaba.Enums.Cards.CARD_BLACK_JOKER] = 2,
			[wakaba.Enums.Cards.CARD_WHITE_JOKER] = 2,
			[wakaba.Enums.Cards.CARD_COLOR_JOKER] = 6,
			[wakaba.Enums.Cards.CARD_DREAM_CARD] = 8,
			[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = 1,
			[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = 8,
		}
		wakaba.EIDClearRuneCooldowns = {
			-- Clear Rune
			[wakaba.Enums.Cards.SOUL_WAKABA] = 8,
			[wakaba.Enums.Cards.SOUL_WAKABA2] = 8,
			[wakaba.Enums.Cards.SOUL_SHIORI] = 6,
		}
		wakaba.EIDPlaceboCooldowns = {
			-- Placebo
			[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP] = 12,
			[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = 4,
			[wakaba.Enums.Pills.ALL_STATS_UP] = 12,
			[wakaba.Enums.Pills.ALL_STATS_DOWN] = 4,
			[wakaba.Enums.Pills.TROLLED] = 2,
			[wakaba.Enums.Pills.TO_THE_START] = 2,
			[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = 2,
			[wakaba.Enums.Pills.SOCIAL_DISTANCE] = 1,
		} ]]

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
			if descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and descObj.ObjSubType == wakaba.Enums.Collectibles.SWEETS_CATALOG then
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

		local collectiblesCheck = {
			wakaba.Enums.Collectibles.WAKABAS_BLESSING,
			wakaba.Enums.Collectibles.WAKABAS_NEMESIS,
			wakaba.Enums.Collectibles.BOOK_OF_SHIORI,
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
			wakaba.Enums.Players.WAKABA,
			wakaba.Enums.Players.WAKABA_B,
			wakaba.Enums.Players.SHIORI,
			wakaba.Enums.Players.SHIORI_B,
		}
		local collectiblesOwned = {}
		local hasPlayer = {}

		function wakaba:UpdateWakabaDescriptions()
			EID._currentMod = "Pudding and Wakaba"
			EID:addEntity(wakaba.INVDESC_TYPE_CURSE, -1, -1, "Curses")
			EID:setModIndicatorName("Pudding & Wakaba")
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
					if not itemdesc.targetMod then
						EID._currentMod = "Pudding and Wakaba"
					elseif itemdesc.targetMod ~= EID._currentMod then
						EID._currentMod = itemdesc.targetMod
					end
					EID:addCollectible(itemID, itemdesc.description, itemdesc.itemName, lang)
					if lang == "en_us" and itemdesc.transformations then
						EID:assignTransformation("collectible", itemID, itemdesc.transformations)
					end
					if itemdesc.carBattery then
						EID.descriptions[lang].carBattery[itemID] = itemdesc.carBattery
					end
					if itemdesc.wisp then
						--EID.descriptions[lang].bookOfVirtuesWisps[itemID] = itemdesc.wisp
					end
					if itemdesc.abyss then
						--EID.descriptions[lang].abyssSynergies[itemID] = itemdesc.abyss
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
					EID:addTrinket(itemID, itemdesc.description, itemdesc.itemName, lang)
					if lang == "en_us" and itemdesc.transformations then
						EID:assignTransformation("trinket", itemID, itemdesc.transformations)
					end
				end
				for itemID, appendText in pairs(wakabaDescTables.goldtrinkets) do
					EID.descriptions[lang].goldenTrinketEffects[itemID] = { appendText[1], appendText[2], appendText[3] }
				end
				for playerType, birthrightdesc in pairs(wakabaDescTables.birthright) do
					EID:addBirthright(playerType, birthrightdesc.description, birthrightdesc.playerName, lang)
				end
				for cardid, carddesc in pairs(wakabaDescTables.cards) do
					if not carddesc.targetMod then
						EID._currentMod = "Pudding and Wakaba"
					elseif carddesc.targetMod ~= EID._currentMod then
						EID._currentMod = carddesc.targetMod
					end
					EID:addCard(cardid, carddesc.description, carddesc.itemName, lang)
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
					EID:addPill(pillid, pilldesc.description, pilldesc.itemName, lang)
				end
				--EID:addHorsePill doesn't exist lol
				--EID:updateDescriptionsViaTable(wakabaDescTables.horsepills, EID.descriptions[lang].horsepills)
				--[[ for pillid, pilldesc in pairs(wakabaDescTables.horsepills) do
					EID:addPill(pillid+2048, pilldesc.description, pilldesc.itemName, lang, pilldesc.mimiccharge, pilldesc.class)
				end ]]
				if wakabaDescTables.conditionals then
					local conDescTables = wakabaDescTables.conditionals
					if conDescTables.collectibles then
						for itemID, wcd in pairs(conDescTables.collectibles) do
							local conditionalEntry = "5.100."..tostring(itemID)
							if lang == "en_us" then
								EID.DescriptionConditions[conditionalEntry] = {}
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
						for itemID, itemdesc in pairs(conDescTables.trinkets) do
							local conditionalEntry = "5.350."..tostring(itemID)
							if lang == "en_us" then
								EID.DescriptionConditions[conditionalEntry] = {
									func = itemdesc.func,
									vars = itemdesc.vars,
									type = itemdesc.type,
									modifierText = itemdesc.modifierText,
								}
							end
							EID.descriptions[lang].ConditionalDescs[conditionalEntry] = itemdesc.desc
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
								}
							end
							EID.descriptions[lang].ConditionalDescs[conditionalEntry] = itemdesc.desc
						end
					end
				end
				EID._currentMod = "Pudding and Wakaba"
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
					local description = wakabaBuff.description
					local iconStr = "#{{Collectible" .. wakaba.Enums.Collectibles.BOOK_OF_SHIORI .. "}} {{ColorBookofShiori}}"
					EID:appendToDescription(descObj, iconStr.. description .. "{{CR}}")
				end
				return descObj
			end
			--EID:addDescriptionModifier("Wakaba Last Pool", LastPoolCondition, LastPoolCallback)

			EID:addDescriptionModifier("Book of Shiori", ShioriBookCondition, ShioriBookCallback)
			EID:addDescriptionModifier("Better Voiding detection", BetterVoidingCondition, BetterVoidingCallback)
			EID:addDescriptionModifier("Sweets Catalog", CatalogCondition, CatalogCallback)
			EID:addDescriptionModifier("Shiori's Valut", ValutCondition, ValutCallback)

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
			str = str .. "#{{Player"..wakaba.Enums.Players.WAKABA.."}} "
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
			str = str .. "#{{Player"..wakaba.Enums.Players.WAKABA_B.."}} "
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
			str = str .. "#{{Player"..wakaba.Enums.Players.SHIORI.."}} "
			str = str .. getmarkup(wakaba.state.unlock.hardbook) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlock.shiorid6plus) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlock.bookoffocus) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlock.deckofrunes) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlock.grimreaperdefender) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.unknownbookmark) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.bookoftrauma) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.bookoffallen) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofsilence) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.determinationribbon) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.vintagethreat) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofthegod) .. "{{Beast}}"
			str = str .. getboolup(wakaba.state.unlock.bookofshiori) .. "{{VictoryLap}}"
			str = str .. "#{{Player"..wakaba.Enums.Players.SHIORI_B.."}} "
			str = str .. getmarkup(wakaba.state.unlock.taintedshiorimomsheart) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlock.bookmarkbag1) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlock.bookmarkbag2) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlock.bookmarkbag3) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlock.bookmarkbag4) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.shiorisoul1) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.shiorisoul2) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.shiorivalut) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.bookofconquest) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.queenofspades) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.ringofjupiter) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.minervaaura) .. "{{Beast}}"
			str = str .. "#{{Player"..wakaba.Enums.Players.TSUKASA.."}} "
			str = str .. getmarkup(wakaba.state.unlock.murasame) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlock.nasalover) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlock.beetlejuice) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlock.redcorruption) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlock.powerbomb) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.concentration) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.rangeos) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.plasmabeam) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.newyearbomb) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.questionblock) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.phantomcloak) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.magmablade) .. "{{Beast}}"
			str = str .. getboolup(wakaba.state.unlock.lunarstone) .. "{{VictoryLap}}"
			str = str .. "#"..getboolup(wakaba.state.unlock.taintedtsukasa) .. "{{Player"..wakaba.Enums.Players.TSUKASA_B.."}} "
			str = str .. getmarkup(wakaba.state.unlock.taintedtsukasamomsheart) .. "{{MomsHeart}}"
			str = str .. getmarkup(wakaba.state.unlockisaaccartridge1) .. "{{Isaac}}"
			str = str .. getmarkup(wakaba.state.unlockisaaccartridge2) .. "{{Satan}}"
			str = str .. getmarkup(wakaba.state.unlockisaaccartridge3) .. "{{BlueBaby}}"
			str = str .. getmarkup(wakaba.state.unlockisaaccartridge4) .. "{{TheLamb}}"
			str = str .. getmarkup(wakaba.state.unlock.tsukasasoul1) .. "{{Timer}}"
			str = str .. getmarkup(wakaba.state.unlock.tsukasasoul2) .. "{{Hush}}"
			str = str .. getmarkup(wakaba.state.unlock.maplesyrup) .. "{{MegaSatan}}"
			str = str .. getmarkup(wakaba.state.unlock.flashshift) .. "{{Delirium}}"
			str = str .. getmarkup(wakaba.state.unlock.returntoken) .. "{{GreedMode}}"
			str = str .. getmarkup(wakaba.state.unlock.sirenbadge) .. "{{Mother}}"
			str = str .. getmarkup(wakaba.state.unlock.elixiroflife) .. "{{Beast}}"
			str = str .. "#{{Trophy}} "
			str = str .. getboolup(wakaba.state.unlock.eyeofclock) .. "{{Collectible"..wakaba.Enums.Collectibles.EYE_OF_CLOCK.."}}"
			str = str .. getboolup(wakaba.state.unlock.plumy) .. "{{Collectible"..wakaba.Enums.Collectibles.PLUMY.."}}"
			str = str .. getboolup(wakaba.state.unlock.delimiter) .. "{{Trinket"..wakaba.Enums.Trinkets.DELIMITER.."}}"
			str = str .. getboolup(wakaba.state.unlock.nekodoll) .. "{{Collectible"..wakaba.Enums.Collectibles.NEKO_FIGURE.."}}"
			str = str .. getboolup(wakaba.state.unlock.microdoppelganger) .. "{{Collectible"..wakaba.Enums.Collectibles.MICRO_DOPPELGANGER.."}}"
			str = str .. getboolup(wakaba.state.unlock.delirium) .. "{{Trinket"..wakaba.Enums.Trinkets.DIMENSION_CUTTER.."}}"
			str = str .. getboolup(wakaba.state.unlock.lilwakaba) .. "{{Collectible"..wakaba.Enums.Collectibles.LIL_WAKABA.."}}"
			str = str .. getboolup(wakaba.state.unlock.lostuniform) .. "{{Player31}}"
			str = str .. getboolup(wakaba.state.unlock.executioner) .. "{{Collectible"..wakaba.Enums.Collectibles.EXECUTIONER.."}}"
			str = str .. getboolup(wakaba.state.unlock.apollyoncrisis) .. "{{Collectible"..wakaba.Enums.Collectibles.APOLLYON_CRISIS.."}}"
			str = str .. getboolup(wakaba.state.unlock.deliverysystem) .. "{{Collectible"..wakaba.Enums.Collectibles.ISEKAI_DEFINITION.."}}"
			str = str .. getboolup(wakaba.state.unlock.calculation) .. "{{Collectible"..wakaba.Enums.Collectibles.BALANCE.."}}"
			str = str .. getboolup(wakaba.state.unlock.lilmao) .. "{{Collectible"..wakaba.Enums.Collectibles.LIL_MAO.."}}"
			str = str .. getboolup(wakaba.state.unlock.richerflipper) .. "{{Collectible"..wakaba.Enums.Collectibles.RICHERS_FLIPPER.."}}"
			str = str .. getboolup(wakaba.state.unlock.edensticky) .. "{{Collectible"..wakaba.Enums.Collectibles.EDEN_STICKY_NOTE.."}}"
			str = str .. getboolup(wakaba.state.unlock.doubledreams) .. "{{Collectible"..wakaba.Enums.Collectibles.DOUBLE_DREAMS.."}}"

			return str
		end

		function wakaba:RenderWakabaAchievement()
			if wakaba.G:GetFrameCount() > wakaba.unlockdisplaytimer and wakaba.G:GetFrameCount() < (wakaba.unlockdisplaytimer + 10*30) then
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
		--[[ function wakaba:RenderWakabaDebug()
			if wakaba.G:GetFrameCount() > wakaba.unlockdisplaytimer and wakaba.G:GetFrameCount() < (wakaba.unlockdisplaytimer + 10*30) then
				local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
				demoDescObj.Name = "{{Player"..Isaac.GetPlayerTypeByName("Wakaba", false).."}} Pudding & Wakaba - 한글 설명 디버그용"
				demoDescObj.Description = "#가나다라마바사아자차카타파하"
				.."#보는 내는 보내는 같이, 것이다. 자신과 이상은 방지하는 가슴에 만천하의 뿐이다. 듣기만 모래뿐일 위하여서 피어나는 가슴에 인생의 방지하는 어디 원대하고, 있는가? 간에 청춘의 열락의 굳세게 사랑의 아니한 착목한는 위하여서. 남는 속잎나고, 보이는 이상 이 심장은 풍부하게 그들은 것이다. 생생하며, 두손을 보내는 말이다. 지혜는 되는 찬미를 피는 부패뿐이다. 고동을 그들은 불어 있다. 따뜻한 풍부하게 인도하겠다는 이상 것은 이상이 교향악이다. 무엇을 그들의 열락의 그들을 구하지 불어 같은 구하기 못할 듣는다. 소담스러운 충분히 얼음과 쓸쓸하랴?"
				.."#어디 착목한는 이상은 무한한 봄바람을 못할 튼튼하며, 이것이다. 사람은 만천하의 무엇을 뼈 이상을 교향악이다. 그들은 전인 인류의 석가는 것이다. 물방아 위하여서 이상의 것이다. 이것이야말로 눈에 뭇 행복스럽고 구하지 눈이 청춘 것이다. 튼튼하며, 무한한 희망의 바로 없으면, 그와 간에 무엇을 길지 것이다. 봄날의 것이다.보라, 되는 예가 가지에 만천하의 설산에서 것이다. 무엇을 때까지 든 눈이 옷을 꽃이 위하여서, 할지니, 것이다.보라, 사막이다. 크고 우리 인간이 얼음과 청춘이 어디 앞이 듣는다."
				.."#고동을 어디 얼음 용기가 길지 더운지라 사막이다. 끓는 창공에 시들어 가는 관현악이며, 그림자는 커다란 아름다우냐? 이상의 미묘한 위하여, 발휘하기 대고, 끝에 어디 풀이 것이다.보라, 황금시대다. 피는 모래뿐일 낙원을 부패뿐이다. 바이며, 새 이상은 있으랴? 위하여서, 소금이라 바이며, 심장은 구하지 뛰노는 것이다. 없는 따뜻한 무엇을 우리 품으며, 불어 쓸쓸하랴? 그들은 웅대한 피고, 산야에 때문이다. 많이 그와 쓸쓸한 운다."
				EID:displayPermanentText(demoDescObj)
				checkedWakabaAchievement = true
			elseif checkedWakabaAchievement then
				wakaba:RemoveCallback(ModCallbacks.MC_POST_RENDER, wakaba.RenderWakabaAchievement)
				EID:hidePermanentText()
				wakaba.eidunlockstr = ""
				checkedWakabaAchievement = false
			end
		end ]]
		--wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.RenderWakabaAchievement)

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
			for playerID, itemdesc in pairs(descTable.birthright) do
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
				if descTable.birthright[playerType] and i_queueNow[initSeed]:IsCollectible() and i_queueLastFrame[initSeed] == nil then
					local itemName = descTable.birthrightName
					local queueDesc = descTable.birthright[playerType].queueDesc or i_queueNow[initSeed].Description
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

function wakaba:EIDPos()
	if wakaba.G:GetFrameCount() < 1 or not EID.player or EID.player.FrameCount < 1 or not EID.player:Exists() then return end
	local target_offset_y=0
	local player_type = EID.player:GetPlayerType()
	if wakaba.TextOffset[player_type] then
		target_offset_y=math.max(wakaba.TextOffset[player_type] or 0)
	end
	if target_offset_y > 0 then
		EID:addTextPosModifier("Pudding n Wakaba Pos", Vector(0,target_offset_y))
	else
		EID:removeTextPosModifier("Pudding n Wakaba Poss")
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER,wakaba.EIDPos)


