
wakaba:RegisterPatch(0, "AstroItems", function() return (AstroItems ~= nil) end, function()
	wakaba:BulkAppend(wakaba.Weights.CloverChest, {
		{AstroItems.Collectible.AKASHIC_RECORDS, 1.00},
		-- {AstroItems.Collectible.AMAZING_CHAOS_SCROLL, 1.00}, -- Reshaken 아이템과 중복
		{AstroItems.Collectible.AQUARIUS_EX, 1.00},
		{AstroItems.Collectible.ARTIFACT_SANCTUM, 1.00},
		{AstroItems.Collectible.BACHELORS_DEGREE, 1.00},
		{AstroItems.Collectible.CANCER_EX, 1.00},
		{AstroItems.Collectible.CHAOS_DICE, 1.00},
		{AstroItems.Collectible.CLOVER, 1.00},
		{AstroItems.Collectible.CURSE_OF_ARAMATIR, 1.00},
		{AstroItems.Collectible.CYGNUS, 1.00},
		{AstroItems.Collectible.GALACTIC_MEDAL_OF_VALOR, 1.00},
		{AstroItems.Collectible.GEMINI_EX, 1.00},
		{AstroItems.Collectible.LANIAKEA_SUPERCLUSTER, 1.00},
		{AstroItems.Collectible.LIBRA_EX, 1.00},
		{AstroItems.Collectible.LUCKY_ROCK_BOTTOM, 1.00},
		{AstroItems.Collectible.PIRATE_MAP, 1.00},
		{AstroItems.Collectible.PISCES_EX, 1.00},
		{AstroItems.Collectible.PLATINUM_BULLET, 1.00},
		{AstroItems.Collectible.PTOLEMAEUS, 1.00},
		{AstroItems.Collectible.QUASAR, 1.00},
	})
	wakaba:BulkAppend(wakaba.Weights.ShioriValut, {
		{AstroItems.Collectible.ALTAIR, 0.20},
		{AstroItems.Collectible.AQUARIUS_EX, 1.00},
		{AstroItems.Collectible.ARIES_EX, 1.00},
		{AstroItems.Collectible.CANCER_EX, 1.00},
		{AstroItems.Collectible.CAPRICORN_EX, 1.00},
		{AstroItems.Collectible.CASIOPEA, 1.00},
		{AstroItems.Collectible.COMET, 1.00},
		{AstroItems.Collectible.CORVUS, 1.00},
		{AstroItems.Collectible.CURSE_OF_ARAMATIR, 1.00},
		{AstroItems.Collectible.CYGNUS, 1.00},
		{AstroItems.Collectible.DENEB, 1.00},
		{AstroItems.Collectible.GEMINI_EX, 1.00},
		{AstroItems.Collectible.LEO_EX, 1.00},
		{AstroItems.Collectible.LIBRA_EX, 1.00},
		{AstroItems.Collectible.PAVO, 1.00},
		{AstroItems.Collectible.PISCES_EX, 1.00},
		{AstroItems.Collectible.PROMETHEUS, 1.00},
		{AstroItems.Collectible.QUASAR, 1.00},
		{AstroItems.Collectible.RITE_OF_ARAMESIR, 1.00},
		{AstroItems.Collectible.SAGITTARIUS_EX, 1.00},
		{AstroItems.Collectible.SCORPIO_EX, 1.00},
		-- {AstroItems.Collectible.SINFUL_SPOILS_STRUGGLE, 1.00}, -- 도트 이미지 중복 문제로 제외
		{AstroItems.Collectible.STARLIT_PAPILLON, 1.00},
		{AstroItems.Collectible.TAURUS_EX, 1.00},
		{AstroItems.Collectible.VEGA, 1.00},
		{AstroItems.Collectible.VIRGO_EX, 1.00},
	})

	-- 와드 or 핑크 와드 소지 시 토끼 와드 영향권 범위 증가
	wakaba:AddCallback(wakaba.Callback.EVALUATE_RABBEY_WARD_POWER, function(_, player)
		if player:HasCollectible(AstroItems.Collectible.WARD) or player:HasCollectible(AstroItems.Collectible.PINK_WARD) then
			return
				math.max(player:GetCollectibleNum(AstroItems.Collectible.WARD), 0)
				+ math.max(player:GetCollectibleNum(AstroItems.Collectible.PINK_WARD), 0)
		end
	end)

	if EID then
		EID:AddSynergyConditional(wakaba.Enums.Collectibles.RABBEY_WARD, {
			AstroItems.Collectible.WARD,
			AstroItems.Collectible.PINK_WARD,
		}, "WakabaWardSynergyFrom", "WakabaWardSynergy")
	end

end)