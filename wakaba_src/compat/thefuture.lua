local ttReplaced = false
function wakaba:GameStart_TheFutureCompat()
	if TheFuture then
		local mod = TheFuture
		if not ttReplaced then
			TheFuture.ModdedCharacterDialogue["Wakaba"] = {
				"looks like you had a long bad time",
				"believe in your heart",
				"maybe you will have a good time for now on",
				"good luck in the future!",
			}
			TheFuture.ModdedTaintedCharacterDialogue["WakabaB"] = {
				"OH NOES!",
			}
			TheFuture.ModdedCharacterDialogue["Shiori"] = {
				"oh what an unfamiliar guest",
				"i guess you know a lot of knowledge",
				"but future is a full of black that you don't know",
				"i hope you learned yourself in the future",
			}
			TheFuture.ModdedTaintedCharacterDialogue["ShioriB"] = {
				"INTRUDER ALERT",
				"you are not supposed to be here",
				"i know the body is not yours",
				"please say hello to them",
			}
			TheFuture.ModdedCharacterDialogue["Tsukasa"] = {
				"your invincible body has to be come to the end",
				"from time to time",
				"nasa... your most precious person, right?",
				"i hope this timeline is the last recovery",
			}
			TheFuture.ModdedTaintedCharacterDialogue["TsukasaB"] = {
				"do you still challenging for mindless goals?",
				"give up now",
			}
			TheFuture.ModdedCharacterDialogue["Richer"] = {
				"it never rains, but it pours",
				"a good medicine tasted bitter",
				"walls have rabbit ears",
				"wait, you also have rabbit ears!",
			}
			TheFuture.ModdedTaintedCharacterDialogue["RicherB"] = {
				"you smell like bakery",
				"i wanna eat you",
			}

		end
	end
	ttReplaced = true
end