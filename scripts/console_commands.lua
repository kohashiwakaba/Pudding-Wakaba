-- This one is cheat codes or check unlock status when no Encyclopedia or MCM is applied.

-- Not finished

function wakaba:ConsoleCommands(cmd, param)
	-- Reload Wakaba Status : Debug only 
	if cmd == "reloadwakabastatus" then
	end
	-- Global Wakaba commands
	if cmd == "wakaba" then
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("Pudding and Wakaba Commands help")
		print("wakaba - Display this help.")
		print("wakaba_alpha - Display opacity for Pudding and Wakaba items.")
		--[[ print("wakaba_scale - Display font scale for Pudding and Wakaba items.")
		print("wakaba_curseoverride - Choose whether Curse of Flames priotizes over other curses.")
		print("wakaba_cursechance - Sets rate of getting Curse of Flames.")
		if Poglite then
			print("wakaba_pog - Display POG for Pudding and Wakaba items.")
		end
		print("wakaba_character - Settings for Pudding and Wakaba characters.") ]]
		print("wakaba_unlockstats - Show Unlock status for Pudding and Wakaba. Requires EID")
		print("wakaba_cheat - Unlock everything for certain character.")
		--[[ print("wakaba_unlockn - Same as wakaba_unlock, but does not show achievement papers.")
		
		print("wakaba_reset - Reset unlock status for certain character.") ]]

		print("[Press Page Up or Page Down for scroll]")
		--[[ if param == "help" or param == "?" then
			print("Wakaba Commands - ")
			print("wakaba wakaba - Check unlock status for Wakaba.")
			print("wakaba twakaba - Check unlock status for Tainted Wakaba.")
			print("wakaba shiori - Check unlock status for Shiori.")
			print("wakaba tshiori - Check unlock status for Tainted Shiori.")
		else
		end ]]
	end
	-- Wakaba character settings
	if cmd == "wakaba_character" then
		if wakaba.state.unlock.edensticky and param == "teden" then
			if wakaba.state.options.edensticky then
				wakaba.state.options.edensticky = false
				print("Sticky Note for T.Eden disabled.")
				wakaba:save(true)
			else
				wakaba.state.options.edensticky = true
				print("Sticky Note for T.Eden enabled.")
				wakaba:save(true)
			end
		elseif wakaba.state.unlock.lostuniform and param == "tlost" then
			if wakaba.state.options.lostuniform then
				wakaba.state.options.lostuniform = false
				print("Wakaba's Uniform for T.Lost disabled.")
				wakaba:save(true)
			else
				wakaba.state.options.lostuniform = true
				print("Wakaba's Uniform for T.Lost enabled.")
				wakaba:save(true)
			end
		elseif param == "startingroom" then
			if wakaba.state.options.startingroomindexed then
				wakaba.state.options.startingroomindexed = false
				print("Wakaba Duality's ability for taking all selection items in Starting room is enabled.")
				wakaba:save(true)
			else
				wakaba.state.options.startingroomindexed = true
				print("Wakaba Duality's ability for taking all selection items is Starting room disabled.")
				wakaba:save(true)
			end
		elseif param == "firsttreasure" then
			if wakaba.state.options.firsttreasureroomindexed then
				wakaba.state.options.firsttreasureroomindexed = false
				print("Wakaba Duality's ability for taking all selection items in first Treasure room is enabled.")
				wakaba:save(true)
			else
				wakaba.state.options.firsttreasureroomindexed = true
				print("Wakaba Duality's ability for taking all selection items is first Treasure room disabled.")
				wakaba:save(true)
			end
		elseif param == "removeindex" then
			if wakaba.state.options.blessnemesisindexed then
				wakaba.state.options.blessnemesisindexed = false
				print("Wakaba Duality's ability for taking all selection items is enabled.")
				wakaba:save(true)
			else
				wakaba.state.options.blessnemesisindexed = true
				print("Wakaba Duality's ability for taking all selection items is disabled.")
				wakaba:save(true)
			end
		else
			print("Wakaba Character settings - ")
			if wakaba.state.unlock.edensticky then
				print("wakaba_character teden - Toggle settings for Sticky Note for T.Eden.")
			end
			if wakaba.state.unlock.lostuniform then
				print("wakaba_character tlost - Toggle settings for Wakaba's Uniform for T.Lost.")
			end
			print("wakaba_character startingroom - Toggle behavior whether Wakaba Duality ignore Starting Room.")
			print("wakaba_character firsttreasure - Toggle behavior whether Wakaba Duality ignore First Treasure Room.")
			print("wakaba_character removeindex - Toggle behavior whether Wakaba Duality to apply remove index ability.")
		end
	end
	-- Wakaba curses settings
	if cmd == "wakaba_alpha" then
		if tonumber(param) then
			local dest = 100
			if tonumber(param) > 100 then
				dest = 100
			elseif tonumber(param) < 0 then
				dest = 0
			else
				dest = tonumber(param)
			end
			wakaba.state.options.uniformalpha = dest
			wakaba:save(true)
		else
			print("Alpha render setting for Book of Shiori icon")
			print("Please enter valid number (0 ~ 100) for set Book of Shiori effect indicators.")
		end
	end
	-- Wakaba unlock status
	if EID and cmd == "wakaba_unlockstats" then
		wakaba.unlockdisplaytimer = wakaba.G:GetFrameCount()
		wakaba.eidunlockstr = wakaba:CheckWakabaAchievementString()
		wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.RenderWakabaAchievement)
		print("Exit the console and Pudding and Wakaba unlock status will be displayed on EID for 10 seconds.")
	end
	if EID and cmd == "wakaba_debugkr" then
		wakaba.unlockdisplaytimer = wakaba.G:GetFrameCount()
		wakaba.eidunlockstr = wakaba:CheckWakabaAchievementString()
		wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.RenderWakabaDebug)
		print("Exit the console and Pudding and Wakaba unlock status will be displayed on EID for 10 seconds.")
	end
	-- Wakaba unlock cheats
	if cmd == "wakaba_cheat" then
		if param == "wakaba" then
			wakaba:unlockWakaba(true)
		elseif param == "wakaba_b" then
			wakaba:unlockTaintedWakaba(true)
		elseif param == "shiori" then
			wakaba:unlockShiori(true)
		elseif param == "shiori_b" then
			wakaba:unlockTaintedShiori(true)
		elseif param == "challenge" then
			wakaba:unlockChallenge(true)
		elseif param == "all" then
			wakaba:unlockWakaba(true)
			wakaba:unlockTaintedWakaba(true)
			wakaba:unlockShiori(true)
			wakaba:unlockTaintedShiori(true)
			wakaba:unlockChallenge(true)
		else
			print("")
			print("")
			print("")
			print("")
			print("")
			print("")
			print("Unlock cheats for Pudding and Wakaba")
			print("This command is for the people who wants to cheat unlocks for several reason (erased data, or having no time to play)")
			print("Note that unlock papers will NOT being appeared")
			print("")
			print("wakaba_cheat wakaba - Unlock all Wakaba unlocks")
			print("wakaba_cheat wakaba_b - Unlock all Tainted Wakaba unlocks")
			print("wakaba_cheat shiori - Unlock all Shiori unlocks")
			print("wakaba_cheat shiori_b - Unlock all Tainted Shiori unlocks")
			print("wakaba_cheat challenge - Unlock all Challenge unlocks")
			print("wakaba_cheat all - Unlock all above")
		end
	end

end

wakaba:AddCallback(ModCallbacks.MC_EXECUTE_CMD, wakaba.ConsoleCommands)
