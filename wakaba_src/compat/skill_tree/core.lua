
wakaba:RegisterPatch(0, "PST", function() return (PST ~= nil) end, function()
	do
		local itemConfig = Isaac.GetItemConfig()
		for _, itemID in pairs(wakaba.Enums.Collectibles) do
			local c = itemConfig:GetCollectible(itemID)
			if c then
				local h = c.AddMaxHearts
				if h and h > 0 then
					PST.heartUpItems[itemID] = h
				end
			end
		end
	end

	do
		PST.charNames[1 + wakaba.Enums.Players.WAKABA] = "Wakaba"
		PST.charNames[1 + wakaba.Enums.Players.SHIORI] = "Shiori"
		PST.charNames[1 + wakaba.Enums.Players.TSUKASA] = "Tsukasa"
		PST.charNames[1 + wakaba.Enums.Players.RICHER] = "Richer"
		PST.charNames[1 + wakaba.Enums.Players.RIRA] = "Rira"

		PST.charNames[1 + wakaba.Enums.Players.WAKABA_B] = "T. Wakaba"
		PST.charNames[1 + wakaba.Enums.Players.SHIORI_B] = "T. Shiori"
		PST.charNames[1 + wakaba.Enums.Players.TSUKASA_B] = "T. Tsukasa"
		PST.charNames[1 + wakaba.Enums.Players.RICHER_B] = "T. Richer"
		PST.charNames[1 + wakaba.Enums.Players.RIRA_B] = "T. Rira"
	end
end)