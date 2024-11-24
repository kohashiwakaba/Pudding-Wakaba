
wakaba:RegisterPatch(0, "CuerLib", function() return (CuerLib ~= nil) end, function()
	do
		local function EvaluateBlacklist(mod, id, config)
			wakaba._rerollPreNoClear = true
		end
		wakaba:AddCallback(CuerLib.Callbacks.CLC_EVALUATE_POOL_BLACKLIST, EvaluateBlacklist)
	end
end)

wakaba:RegisterPatch(0, "Reverie", function() return (CuerLib ~= nil and Reverie ~= nil) end, function()
	do
		local THI = Reverie
		local FanOfTheDead = THI.Collectibles.FanOfTheDead

		function wakaba:PreEvalElixirType_Reverie(player, elixirType)
			if FanOfTheDead:CanRevive(player) then
				return "FanOfTheDead"
			end
		end
		wakaba:AddPriorityCallback(wakaba.Callback.PRE_EVALUATE_ELIXIR_TYPE, 22000, wakaba.PreEvalElixirType_Reverie)

		function wakaba:PostEvalElixirType_Reverie(player, elixirType)
			if FanOfTheDead:CanRevive(player) then
				wakaba:setPlayerDataEntry(player, "elixirmaxfanlives", math.max(wakaba:getPlayerDataEntry(player, "elixirmaxfanlives", 0), FanOfTheDead:GetLives(player)))
			end
		end
		wakaba:AddPriorityCallback(wakaba.Callback.POST_EVALUATE_ELIXIR_TYPE, 22000, wakaba.PostEvalElixirType_Reverie)

		function wakaba:PreElixirRecover_Reverie(player, elixirType, recoverType)
			if elixirType and elixirType == "FanOfTheDead" then
				return "FanOfTheDead"
			end
		end
		wakaba:AddPriorityCallback(wakaba.Callback.PRE_ELIXIR_RECOVER, 2000, wakaba.PreElixirRecover_Reverie)

		function wakaba:PostElixirRecover_Reverie(player, elixirType, recoverType)
			if recoverType == "FanOfTheDead" then
				local data = player:GetData()
				local savedSoulCap = wakaba:getPlayerDataEntry(player, "elixirmaxfanlives", 0)
				if FanOfTheDead:GetLives(player) < savedSoulCap then
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
					FanOfTheDead:AddLives(player, 1)
					data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN
				end
			end
		end
		wakaba:AddPriorityCallback(wakaba.Callback.POST_ELIXIR_RECOVER, 2000, wakaba.PostElixirRecover_Reverie)
		function wakaba:AlterPlayerDamage_Elixir_Reverie(player, amount, flags, source, countdown)
			if wakaba:hasElixir(player) and player:HasCollectible(FanOfTheDead.Item) and FanOfTheDead:CanRevive(player) then
				local data = player:GetData()
				data.wakaba.elixircooldown = wakaba.Enums.Constants.ELIXIR_MAX_COOLDOWN_DMG
				wakaba:addPlayerDataCounter(player, "elixirfandamagedcount", 1)
				wakaba:setPlayerDataEntry(player, "skipelixirdmgcheck", true)
				FanOfTheDead:AddLives(player, -1)
				if wakaba:IsDamageSanguineSpikes(player, flags, source) or wakaba:getPlayerDataEntry(player, "elixirfandamagedcount", 0) >= 3 then
					if wakaba:getPlayerDataEntry(player, "elixirmaxfanlives", 0) > 0 then
						wakaba:addPlayerDataCounter(player, "elixirmaxfanlives", -1)
					end
					wakaba:setPlayerDataEntry(player, "elixirfandamagedcount", 0)
				end
				if flags & DamageFlag.DAMAGE_CURSED_DOOR > 0 then
					wakaba:IncrementCollectibleEffectNum(player, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, false , 20)
				elseif not wakaba:IsLunatic() then
					wakaba:IncrementCollectibleEffectNum(player, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE, false , 2)
				end
				return amount, flags | DamageFlag.DAMAGE_NOKILL
			end
		end
		wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, -100, wakaba.AlterPlayerDamage_Elixir_Reverie)
	end
end)