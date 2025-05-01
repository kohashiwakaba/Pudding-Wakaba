
wakaba:RegisterPatch(0, "Astro", function() return (Astro ~= nil) end, function()
	if Astro.IsFight then
		table.insert(wakaba.DamagePenaltyProtectionInvalidStr, "Astrobirth")
	end
	wakaba:BulkAppend(wakaba.CustomPool.CloverChest, {
		{Astro.Collectible.AKASHIC_RECORDS, 1.00},
		-- {Astro.Collectible.AMAZING_CHAOS_SCROLL, 1.00}, -- Reshaken 아이템과 중복
		{Astro.Collectible.AQUARIUS_EX, 1.00},
		{Astro.Collectible.ARTIFACT_SANCTUM, 1.00},
		{Astro.Collectible.BACHELORS_DEGREE, 1.00},
		{Astro.Collectible.CANCER_EX, 1.00},
		{Astro.Collectible.CHAOS_DICE, 1.00},
		{Astro.Collectible.CLOVER, 1.00},
		{Astro.Collectible.CURSE_OF_ARAMATIR, 1.00},
		{Astro.Collectible.CYGNUS, 1.00},
		{Astro.Collectible.GALACTIC_MEDAL_OF_VALOR, 1.00},
		{Astro.Collectible.GEMINI_EX, 1.00},
		{Astro.Collectible.LANIAKEA_SUPERCLUSTER, 1.00},
		{Astro.Collectible.LIBRA_EX, 1.00},
		{Astro.Collectible.LUCKY_ROCK_BOTTOM, 1.00},
		{Astro.Collectible.PIRATE_MAP, 1.00},
		{Astro.Collectible.PISCES_EX, 1.00},
		{Astro.Collectible.PLATINUM_BULLET, 1.00},
		{Astro.Collectible.PTOLEMAEUS, 1.00},
		{Astro.Collectible.QUASAR, 1.00},
	})
	wakaba:BulkAppend(wakaba.CustomPool.ShioriValut, {
		{Astro.Collectible.ALTAIR, 0.20},
		{Astro.Collectible.AQUARIUS_EX, 1.00},
		{Astro.Collectible.ARIES_EX, 1.00},
		{Astro.Collectible.CANCER_EX, 1.00},
		{Astro.Collectible.CAPRICORN_EX, 1.00},
		{Astro.Collectible.CASIOPEA, 1.00},
		{Astro.Collectible.COMET, 1.00},
		{Astro.Collectible.CORVUS, 1.00},
		{Astro.Collectible.CURSE_OF_ARAMATIR, 1.00},
		{Astro.Collectible.CYGNUS, 1.00},
		{Astro.Collectible.DENEB, 1.00},
		{Astro.Collectible.GEMINI_EX, 1.00},
		{Astro.Collectible.LEO_EX, 1.00},
		{Astro.Collectible.LIBRA_EX, 1.00},
		{Astro.Collectible.PAVO, 1.00},
		{Astro.Collectible.PISCES_EX, 1.00},
		{Astro.Collectible.PROMETHEUS, 1.00},
		{Astro.Collectible.QUASAR, 1.00},
		{Astro.Collectible.RITE_OF_ARAMESIR, 1.00},
		{Astro.Collectible.SAGITTARIUS_EX, 1.00},
		{Astro.Collectible.SCORPIO_EX, 1.00},
		-- {Astro.Collectible.SINFUL_SPOILS_STRUGGLE, 1.00}, -- 도트 이미지 중복 문제로 제외
		{Astro.Collectible.STARLIT_PAPILLON, 1.00},
		{Astro.Collectible.TAURUS_EX, 1.00},
		{Astro.Collectible.VEGA, 1.00},
		{Astro.Collectible.VIRGO_EX, 1.00},
	})

	wakaba.Blacklists.Pica2[Astro.Trinket.BLACK_MIRROR] = true
	wakaba.Blacklists.Pica2[Astro.Trinket.LAVA_HAND] = true

	-- 와드 or 핑크 와드 소지 시 토끼 와드 영향권 범위 증가
	wakaba:AddCallback(wakaba.Callback.EVALUATE_RABBEY_WARD_POWER, function(_, player)
		if player:HasCollectible(Astro.Collectible.WARD) or player:HasCollectible(Astro.Collectible.PINK_WARD) then
			return
				math.max(player:GetCollectibleNum(Astro.Collectible.WARD), 0)
				+ math.max(player:GetCollectibleNum(Astro.Collectible.PINK_WARD), 0)
		end
	end)

	-- 메이드 듀엣, My Moon My Man 둘 다 보유 시 My Moon이 우선 적용
	wakaba:AddCallback(wakaba.Callback.EVALUATE_MAID_DUET, function(_, player)
		if player:HasCollectible(Astro.Collectible.MY_MOON_MY_MAN) then
			return true
		end
	end)

	function wakaba:PenaltyProtection_Astro(player, amount, flags, source, countdown)
		if Astro.IsFight then
			return {
				Protect = false,
				Force = true,
			}
		end
	end
	wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_WAKABA_DAMAGE_PENALTY_PROTECTION, -100, wakaba.PenaltyProtection_Astro)

	if EID then
		EID:AddSynergyConditional(wakaba.Enums.Collectibles.RABBEY_WARD, {
			Astro.Collectible.WARD,
			Astro.Collectible.PINK_WARD,
		}, "WakabaWardSynergyFrom", "WakabaWardSynergy")
	end

end)

wakaba:RegisterPatch(0, "DAMO", function() return (DAMO ~= nil) end, function()
	table.insert(wakaba.DamagePenaltyProtectionInvalidStr, "Damo Run")
	function wakaba:PenaltyProtection_Damo(player, amount, flags, source, countdown)
		return {
			Protect = false,
			Force = true,
		}
	end
	wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_WAKABA_DAMAGE_PENALTY_PROTECTION, -100, wakaba.PenaltyProtection_Damo)
end)

wakaba:RegisterPatch(0, "QP", function() return (QP ~= nil and QP.Settings ~= nil) end, function()
	wakaba:AddPriorityCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, 2, function(_)
		if wakaba:getOptionValue("hudquickpick") then
			wakaba.globalHUDSprite:RemoveOverlay()
			wakaba.globalHUDSprite:SetFrame("QuickPick", 0)
			local room = Game():GetRoom()
			local loc = wakaba:getOptionValue("hud_quickpick")
			local timerType = wakaba:getOptionValue("hudquickpick")
			local string = "ON"
			local frame = 0

			if QP.Settings.isDisable then
				string = "OFF"
				frame = 1
			end

			local tab = {
				Sprite = wakaba.globalHUDSprite,
				Text = string,
				Location = loc,
				SpriteOptions = {
					Anim = "QuickPick",
					Frame = frame,
				},
			}
			return tab
		end
	end)
end)

wakaba:RegisterPatch(0, "EpicBeam", function() return (EpicBeam ~= nil) end, function()
	if EpicBeam.Quality5 then
		for k, v in pairs(wakaba.ExtendQuality) do
			table.insert(EpicBeam.Quality5, k)
		end
	end
end)