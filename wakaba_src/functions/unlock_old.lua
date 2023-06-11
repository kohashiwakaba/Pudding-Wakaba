
function wakaba:PreUnlockCheck()
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_BEAST, -1, -1, false, false)) do
		hasBeast = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.PreUnlockCheck)

function wakaba:HasBeast()
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_BEAST, -1, -1, false, false)) do
		return true
	end
	return false
end

function wakaba:TestAchievement(id)
	CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite[id])
end



function wakaba:UnlockCheck(rng, spawnPosition)
	local haswakaba = false
	local hastaintedwakaba = false
	local hasshiori = false
	local hastaintedshiori = false
	local hastsukasa = false
	local hastaintedtsukasa = false
	local hasricher = false
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == wakaba.Enums.Players.WAKABA then
			haswakaba = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B then
			hastaintedwakaba = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
			hasshiori = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B then
			hastaintedshiori = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.TSUKASA then
			hastsukasa = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.TSUKASA_B then
			hastaintedtsukasa = true
		elseif player:GetPlayerType() == wakaba.Enums.Players.RICHER then
			hasricher = true
		end
	end
	local shouldShowPopup = Options.DisplayPopups and not wakaba.state.options.allowlockeditems

	local level = wakaba.G:GetLevel()
	local currentStage = level:GetAbsoluteStage()
	local currentStageType = level:GetStageType()
	local difficulty = wakaba.G.Difficulty
	local room = wakaba.G:GetRoom()
	local type1 = room:GetType()
	local bossID = room:GetBossID()
	if wakaba.G.Challenge == Challenge.CHALLENGE_NULL and wakaba.G:GetVictoryLap() <= 0 then
		if difficulty < 2 and type1 == RoomType.ROOM_DUNGEON then
			if currentStage == 13 and hasBeast then -- The Beast
				hasBeast = false
				if haswakaba and wakaba.state.unlock.returnpostage < 2 then
					wakaba.state.unlock.returnpostage = difficulty + 1
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.returnpostage)
					--CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.returnpostage)
				end
				if hastaintedwakaba and wakaba.state.unlock.nemesis < 2 then
					wakaba.state.unlock.nemesis = difficulty + 1
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.nemesis)
				end
				if hasshiori and wakaba.state.unlock.bookofthegod < 2 then
					wakaba.state.unlock.bookofthegod = difficulty + 1
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.bookofthegod)
				end
				if hastaintedshiori and wakaba.state.unlock.minervaaura < 2 then
					wakaba.state.unlock.minervaaura = difficulty + 1
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.minervaaura)
				end
				if hastsukasa and wakaba.state.unlock.magmablade < 2 then
					wakaba.state.unlock.magmablade = difficulty + 1
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.magmablade)
				end
				if hastaintedtsukasa and wakaba.state.unlock.elixiroflife < 2 then
					wakaba.state.unlock.elixiroflife = difficulty + 1
					table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.elixiroflife)
				end
				wakaba:CheckWakabaChecklist()
			end
		elseif type1 == RoomType.ROOM_BOSSRUSH then
			if haswakaba and wakaba.state.unlock.donationcard < 2 then
				wakaba.state.unlock.donationcard = difficulty + 1
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.dreamcard)
			end
			if hastaintedwakaba and wakaba.state.unlock.wakabasoul1 < 2 then wakaba.state.unlock.wakabasoul1 = difficulty + 1 end
			if hasshiori and wakaba.state.unlock.unknownbookmark < 2 then
				wakaba.state.unlock.unknownbookmark = difficulty + 1
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.unknownbookmark)
			end
			if hastaintedshiori and wakaba.state.unlock.shiorisoul1 < 2 then wakaba.state.unlock.shiorisoul1 = difficulty + 1 end
			if hastsukasa and wakaba.state.unlock.concentration < 2 then
				wakaba.state.unlock.concentration = difficulty + 1
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.concentration)
			end
			if hastaintedtsukasa and wakaba.state.unlock.tsukasasoul1 < 2 then wakaba.state.unlock.tsukasasoul1 = difficulty + 1 end
			wakaba:CheckWakabaChecklist()
		elseif type1 == RoomType.ROOM_BOSS then
			if difficulty < 2 then
				if currentStage ~= LevelStage.STAGE7 and (bossID == 8 or bossID == 25) then -- Mom's Heart
					if haswakaba and wakaba.state.unlock.clover < 2 then
						wakaba.state.unlock.clover = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.clover)
					end
					if hastaintedwakaba and wakaba.state.unlock.taintedwakabamomsheart < 2 then wakaba.state.unlock.taintedwakabamomsheart = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.hardbook < 2 then
						wakaba.state.unlock.hardbook = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.hardbook)
					end
					if hastaintedshiori and wakaba.state.unlock.taintedshiorimomsheart < 2 then wakaba.state.unlock.taintedshiorimomsheart = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.murasame < 2 then
						wakaba.state.unlock.murasame = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.murasame)
					end
					if hastaintedtsukasa and wakaba.state.unlock.taintedtsukasamomsheart < 2 then wakaba.state.unlock.taintedtsukasamomsheart = difficulty + 1 end
				elseif bossID == 39 and currentStage == LevelStage.STAGE5 then -- Isaac
					if haswakaba and wakaba.state.unlock.counter < 2 then
						wakaba.state.unlock.counter = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.counter)
					end
					if hastaintedwakaba and wakaba.state.unlock.bookofforgotten1 < 2 then wakaba.state.unlock.bookofforgotten1 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.shiorid6plus < 2 then
						wakaba.state.unlock.shiorid6plus = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.shiorid6plus)
					end
					if hastaintedshiori and wakaba.state.unlock.bookmarkbag1 < 2 then wakaba.state.unlock.bookmarkbag1 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.nasalover < 2 then
						wakaba.state.unlock.nasalover = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.nasalover)
					end
					if hastaintedtsukasa and wakaba.state.unlock.isaaccartridge1 < 2 then wakaba.state.unlock.isaaccartridge1 = difficulty + 1 end




				elseif bossID == 24 and currentStage == LevelStage.STAGE5 then -- Satan
					if haswakaba and wakaba.state.unlock.dcupicecream < 2 then
						wakaba.state.unlock.dcupicecream = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.dcupicecream)
					end
					if hastaintedwakaba and wakaba.state.unlock.bookofforgotten2 < 2 then wakaba.state.unlock.bookofforgotten2 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.bookoffocus < 2 then
						wakaba.state.unlock.bookoffocus = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookoffocus)
					end
					if hastaintedshiori and wakaba.state.unlock.bookmarkbag2 < 2 then wakaba.state.unlock.bookmarkbag2 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.beetlejuice < 2 then
						wakaba.state.unlock.beetlejuice = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.beetlejuice)
					end
					if hastaintedtsukasa and wakaba.state.unlock.isaaccartridge2 < 2 then wakaba.state.unlock.isaaccartridge2 = difficulty + 1 end




				elseif bossID == 40 and currentStage == LevelStage.STAGE6 then -- ???
					if haswakaba and wakaba.state.unlock.pendant < 2 then
						wakaba.state.unlock.pendant = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.pendant)
					end
					if hastaintedwakaba and wakaba.state.unlock.bookofforgotten3 < 2 then wakaba.state.unlock.bookofforgotten3 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.deckofrunes < 2 then
						wakaba.state.unlock.deckofrunes = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.deckofrunes)
					end
					if hastaintedshiori and wakaba.state.unlock.bookmarkbag3 < 2 then wakaba.state.unlock.bookmarkbag3 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.redcorruption < 2 then
						wakaba.state.unlock.redcorruption = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.redcorruption)
					end
					if hastaintedtsukasa and wakaba.state.unlock.isaaccartridge3 < 2 then wakaba.state.unlock.isaaccartridge3 = difficulty + 1 end




				elseif bossID == 54 and currentStage == LevelStage.STAGE6 then -- The Lamb
					if haswakaba and wakaba.state.unlock.revengefruit < 2 then
						wakaba.state.unlock.revengefruit = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.revengefruit)
					end
					if hastaintedwakaba and wakaba.state.unlock.bookofforgotten4 < 2 then wakaba.state.unlock.bookofforgotten4 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.grimreaperdefender < 2 then
						wakaba.state.unlock.grimreaperdefender = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.grimreaperdefender)
					end
					if hastaintedshiori and wakaba.state.unlock.bookmarkbag4 < 2 then wakaba.state.unlock.bookmarkbag4 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.powerbomb < 2 then
						wakaba.state.unlock.powerbomb = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.powerbomb)
					end
					if hastaintedtsukasa and wakaba.state.unlock.isaaccartridge4 < 2 then wakaba.state.unlock.isaaccartridge4 = difficulty + 1 end




				elseif bossID == 55 then -- Mega Satan
					if haswakaba and wakaba.state.unlock.whitejoker < 2 then
						wakaba.state.unlock.whitejoker = difficulty + 1
						--CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.whitejoker)
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.whitejoker)
					end
					if hastaintedwakaba and wakaba.state.unlock.cloverchest < 2 then
						wakaba.state.unlock.cloverchest = difficulty + 1
						--CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.cloverchest)
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.cloverchest)
					end
					if hasshiori and wakaba.state.unlock.bookoffallen < 2 then
						wakaba.state.unlock.bookoffallen = difficulty + 1
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.bookoffallen)
					end
					if hastaintedshiori and wakaba.state.unlock.shiorivalut < 2 then
						wakaba.state.unlock.shiorivalut = difficulty + 1
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.shiorivalut)
					end
					if hastsukasa and wakaba.state.unlock.plasmabeam < 2 then
						wakaba.state.unlock.plasmabeam = difficulty + 1
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.plasmabeam)
					end
					if hastaintedtsukasa and wakaba.state.unlock.easteregg < 2 then
						wakaba.state.unlock.easteregg = difficulty + 1
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.easteregg)
					end




				elseif bossID == 63 then -- Hush
					if haswakaba and wakaba.state.unlock.colorjoker < 2 then
						wakaba.state.unlock.colorjoker = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.colorjoker)
					end
					if hastaintedwakaba and wakaba.state.unlock.wakabasoul2 < 2 then wakaba.state.unlock.wakabasoul2 = difficulty + 1 end
					if hasshiori and wakaba.state.unlock.bookoftrauma < 2 then
						wakaba.state.unlock.bookoftrauma = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookoftrauma)
					end
					if hastaintedshiori and wakaba.state.unlock.shiorisoul2 < 2 then wakaba.state.unlock.shiorisoul2 = difficulty + 1 end
					if hastsukasa and wakaba.state.unlock.rangeos < 2 then
						wakaba.state.unlock.rangeos = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.rangeos)
					end
					if hastaintedtsukasa and wakaba.state.unlock.tsukasasoul2 < 2 then wakaba.state.unlock.tsukasasoul2 = difficulty + 1 end




				elseif bossID == 70 then -- Delirium
					if haswakaba and wakaba.state.unlock.wakabauniform < 2 then
						wakaba.state.unlock.wakabauniform = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.uniform)
					end
					if hastaintedwakaba and wakaba.state.unlock.eatheart < 2 then
						wakaba.state.unlock.eatheart = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.eatheart)
					end
					if hasshiori and wakaba.state.unlock.bookofsilence < 2 then
						wakaba.state.unlock.bookofsilence = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookofsilence)
					end
					if hastaintedshiori and wakaba.state.unlock.bookofconquest < 2 then
						wakaba.state.unlock.bookofconquest = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bookofconquest)
					end
					if hastsukasa and wakaba.state.unlock.newyearbomb < 2 then
						wakaba.state.unlock.newyearbomb = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.newyearbomb)
					end
					if hastaintedtsukasa and wakaba.state.unlock.flashshift < 2 then
						wakaba.state.unlock.flashshift = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.flashshift)
					end




				elseif bossID == 88 then -- Mother
					if haswakaba and wakaba.state.unlock.confessionalcard < 2 then
						wakaba.state.unlock.confessionalcard = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.confessionalcard)
					end
					if hastaintedwakaba and wakaba.state.unlock.bitcoin < 2 then
						wakaba.state.unlock.bitcoin = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.bitcoin)
					end
					if hasshiori and wakaba.state.unlock.vintagethreat < 2 then
						wakaba.state.unlock.vintagethreat = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.vintagethreat)
					end
					if hastaintedshiori and wakaba.state.unlock.ringofjupiter < 2 then
						wakaba.state.unlock.ringofjupiter = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.ringofjupiter)
					end
					if hastsukasa and wakaba.state.unlock.phantomcloak < 2 then
						wakaba.state.unlock.phantomcloak = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.phantomcloak)
					end
					if hastaintedtsukasa and wakaba.state.unlock.sirenbadge < 2 then
						wakaba.state.unlock.sirenbadge = difficulty + 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.sirenbadge)
					end




				end
				wakaba:CheckWakabaChecklist()
			elseif difficulty == 2 then
				if bossID == 62 or bossID == 71 then -- Ultra Greed
					if haswakaba and wakaba.state.unlock.secretcard < 2 then
						wakaba.state.unlock.secretcard = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.secretcard)
					end
					if hastaintedwakaba and wakaba.state.unlock.blackjoker < 1 then wakaba.state.unlock.blackjoker = 1 end
					if hasshiori and wakaba.state.unlock.magnetheaven < 2 then
						wakaba.state.unlock.magnetheaven = 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.magnetheaven)
					end
					if hastaintedshiori and wakaba.state.unlock.queenofspades < 1	then wakaba.state.unlock.queenofspades = 1 end
					if hastsukasa and wakaba.state.unlock.arcanecrystal < 2 then
						wakaba.state.unlock.arcanecrystal = 1
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.arcanecrystal)
					end
					if hastaintedtsukasa and wakaba.state.unlock.returntoken < 1	then wakaba.state.unlock.returntoken = 1 end




					wakaba:CheckWakabaChecklist()
				end
			elseif difficulty == 3 then
				if bossID == 62 or bossID == 71 then -- Ultra Greedier
					if haswakaba and wakaba.state.unlock.secretcard < 2 then
						wakaba.state.unlock.secretcard = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.secretcard)
					end
					if haswakaba and wakaba.state.unlock.cranecard < 2 then
						wakaba.state.unlock.cranecard = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.cranecard)
					end
					if hastaintedwakaba and wakaba.state.unlock.blackjoker < 2 then
						wakaba.state.unlock.blackjoker = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.blackjoker)
					end
					if hasshiori and wakaba.state.unlock.magnetheaven < 2 then
						wakaba.state.unlock.magnetheaven = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.magnetheaven)
					end
					if hasshiori and wakaba.state.unlock.determinationribbon < 2 then
						wakaba.state.unlock.determinationribbon = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.determinationribbon)
					end
					if hastaintedshiori and wakaba.state.unlock.queenofspades < 2 then
						wakaba.state.unlock.queenofspades = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.queenofspades)
					end
					if hastsukasa and wakaba.state.unlock.arcanecrystal < 2 then
						wakaba.state.unlock.arcanecrystal = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.arcanecrystal)
					end
					if hastsukasa and wakaba.state.unlock.questionblock < 2 then
						wakaba.state.unlock.questionblock = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.questionblock)
					end
					if hastaintedtsukasa and wakaba.state.unlock.returntoken < 2 then
						wakaba.state.unlock.returntoken = 2
						CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.returntoken)
					end




					wakaba:CheckWakabaChecklist()
				end
			end
		end
	elseif wakaba.G.Challenge ~= Challenge.CHALLENGE_NULL then
		if		 wakaba.G.Challenge == wakaba.challenges.CHALLENGE_ELEC and bossID == 6 then
			if not wakaba.state.unlock.eyeofclock then
				wakaba.state.unlock.eyeofclock = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.eyeofclock)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_PLUM and bossID == 63 then
			if not wakaba.state.unlock.plumy then
				wakaba.state.unlock.plumy = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.plumy)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_PULL and (bossID == 8 or bossID == 25) then
			if not wakaba.state.unlock.ultrablackhole then wakaba.state.unlock.ultrablackhole = true end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_MINE and (bossID == 8 or bossID == 25) then
			if not wakaba.state.unlock.delimiter then
				wakaba.state.unlock.delimiter = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.delimiter)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_GUPP and bossID == 88 then
			if not wakaba.state.unlock.nekodoll then
				wakaba.state.unlock.nekodoll = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.nekodoll)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DOPP and bossID == 63 then
			if not wakaba.state.unlock.microdoppelganger then
				wakaba.state.unlock.microdoppelganger = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.microdoppelganger)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DELI and bossID == 70 then
			if not wakaba.state.unlock.delirium then
				wakaba.state.unlock.delirium = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.delirium)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_SIST and bossID == 54 then
			if not wakaba.state.unlock.lilwakaba then
				wakaba.state.unlock.lilwakaba = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.lilwakaba)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DRAW and bossID == 40 then
			if not wakaba.state.unlock.lostuniform then
				wakaba.state.unlock.lostuniform = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.lostuniform)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_HUSH and bossID == 63 then
			if not wakaba.state.unlock.executioner then
				wakaba.state.unlock.executioner = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.executioner)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_APPL and bossID == 54 then
			if not wakaba.state.unlock.apollyoncrisis then
				wakaba.state.unlock.apollyoncrisis = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.apollyoncrisis)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE and bossID == 70 then
			if not wakaba.state.unlock.deliverysystem then
				wakaba.state.unlock.deliverysystem = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.deliverysystem)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_CALC and bossID == 55 then
			if not wakaba.state.unlock.calculation then
				wakaba.state.unlock.calculation = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.calculation)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_HOLD and bossID == 88 then
			if not wakaba.state.unlock.lilmao then
				wakaba.state.unlock.lilmao = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.lilmao)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_EVEN and bossID == 88 then
			if not wakaba.state.unlock.richerflipper then
				wakaba.state.unlock.richerflipper = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.richerflipper)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_RAND and bossID == 70 then
			if not wakaba.state.unlock.edensticky then
				wakaba.state.unlock.edensticky = true
				CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.edensticky)
			end
			wakaba:CheckWakabaChecklist()
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DRMS then
			if type1 == RoomType.ROOM_DUNGEON then
				if currentStage == 13 and hasBeast then -- The Beast
					hasBeast = false
					if not wakaba.state.unlock.doubledreams then
						wakaba.state.unlock.doubledreams = true
						table.insert(wakaba.state.pendingunlock, wakaba.achievementsprite.doubledreams)
					end
					wakaba:CheckWakabaChecklist()
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.UnlockCheck)

function wakaba:UnlockConvert(playerType)
	if playerType == Isaac.GetPlayerTypeByName("Wakaba", false) then
	elseif playerType == Isaac.GetPlayerTypeByName("WakabaB", true) then
	end
end

wakaba.validtainted = {
	wakaba.Enums.Players.WAKABA,
	wakaba.Enums.Players.WAKABA_B,
	wakaba.Enums.Players.SHIORI,
	wakaba.Enums.Players.SHIORI_B,
	wakaba.Enums.Players.TSUKASA,
	wakaba.Enums.Players.TSUKASA_B,
	wakaba.Enums.Players.RICHER,
	wakaba.Enums.Players.RICHER_B,
}
wakaba.taintedsprite = {
	[wakaba.Enums.Players.WAKABA] = "gfx/characters/costumes/character_wakabab.png",
	[wakaba.Enums.Players.WAKABA_B] = "gfx/characters/costumes/character_wakaba.png",
	[wakaba.Enums.Players.SHIORI] = "gfx/characters/costumes/character_shiorib.png",
	[wakaba.Enums.Players.SHIORI_B] = "gfx/characters/costumes/character_shiori.png",
	[wakaba.Enums.Players.TSUKASA] = "gfx/characters/costumes/character_tsukasab.png",
	[wakaba.Enums.Players.TSUKASA_B] = "gfx/characters/costumes/character_tsukasa.png",
	[wakaba.Enums.Players.RICHER] = "gfx/characters/costumes/character_richerb.png",
	[wakaba.Enums.Players.RICHER_B] = "gfx/characters/costumes/character_richer.png",
}


--[[
	Tainted Character unlock code from AgentCucco(Job)
	Normally, the player is defined through for i = 0, wakaba.G:GetNumPlayers() -1 , then Isaac.GetPlayer(i).
	But this function used Isaac.GetPlayer(0) on purpose as Tainted unlock only works for first player even with vanilla characters.
 ]]
function wakaba:Effect_TaintedWakabaReady()
	local player = Isaac.GetPlayer(0)
	wakaba:GetPlayerEntityData(player)
	local ptype = Isaac.GetPlayer(0):GetPlayerType()

	if wakaba:has_value(wakaba.validtainted, ptype) and not player:GetData().wakaba.taintedtouched then
		if wakaba.G:GetLevel():GetCurrentRoomDesc().Data.Name == "Closet L" then
			local ents = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
			local ents2 = Isaac.FindByType(EntityType.ENTITY_SHOPKEEPER)
			if #ents + #ents2 > 0 then
				for _, e in ipairs(ents) do
					--local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, e.Position, Vector.Zero, player)
					e:Remove()
				end
				for _, e in ipairs(ents2) do
					--local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, e.Position, Vector.Zero, player)
					e:Remove()
				end
			end
			local tents = Isaac.FindByType(EntityType.ENTITY_SLOT, 14)
			if #tents > 0 then
				for _, e in ipairs(tents) do
					if wakaba.runstate.lockedcharacter then
						e:Remove()
					else
						local sprite = e:GetSprite()
						local edata = e:GetData()
						if edata.wakaba and edata.wakaba.tready then
							if sprite:IsFinished("PayPrize") then
								player:GetData().wakaba.taintedtouched = true
								if not wakaba.state.unlock.taintedtsukasa and edata.wakaba.ptype and edata.wakaba.ptype == wakaba.Enums.Players.TSUKASA then
									wakaba.state.unlock.taintedtsukasa = true
									CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.taintedtsukasa)
									wakaba:CheckWakabaChecklist()
								elseif not wakaba.state.unlock.taintedricher and edata.wakaba.ptype and edata.wakaba.ptype == wakaba.Enums.Players.RICHER then
									wakaba.state.unlock.taintedricher = true
									CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.taintedricher)
									wakaba:CheckWakabaChecklist()
								else
									for i = 0, wakaba.G:GetNumPlayers() - 1 do
										Isaac.GetPlayer(i):AddCollectible(CollectibleType.COLLECTIBLE_INNER_CHILD)
									end
								end
							end
						end
						edata.wakaba = edata.wakaba or {}
						edata.wakaba.tready = true
						edata.wakaba.ptype = ptype
						sprite:ReplaceSpritesheet(0, wakaba.taintedsprite[ptype])
						sprite:LoadGraphics()
					end
				end
			elseif not wakaba.runstate.lockedcharacter then
				local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, wakaba.G:GetRoom():GetCenterPos(), Vector.Zero, nil)
				ne:GetData().wakaba = {}
				ne:GetData().wakaba.tready = true
				ne:GetData().wakaba.ptype = ptype
				ne:GetSprite():ReplaceSpritesheet(0, wakaba.taintedsprite[ptype])
				ne:GetSprite():LoadGraphics()
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Effect_TaintedWakabaReady)
