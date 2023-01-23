local eidmatchlang = {
	["en"] = "en_us",
	["es"] = "spa",
	["ru"] = "ru",
	["kr"] = "ko_kr",
}

local maijamastring = {
	["en"] = "Myth of Maijima",
	["de"] = "Mythos von Maijima",
	["es"] = "mito de Maijima",
	["jp"] = "マイジマの神話",
	["ru"] = "миф о майдзиме",
	["kr"] = "마이지마 전설",
	["cn"] = "舞島的神話",
}

function wakaba:Display_Maijima(player)
	if player:GetData().wakaba and player:GetData().wakaba.pendingmaijima then
		local tempstring = ""
		for i, e in ipairs(player:GetData().wakaba.pendingmaijima) do
			if tempstring ~= "" then
				tempstring = tempstring .. " & "
			end
			tempstring = tempstring .. e
		end
		wakaba.G:GetHUD():ShowItemText(maijamastring[Options.Language or "en"], tempstring, false)
		player:GetData().wakaba.pendingmaijima = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Display_Maijima)


function wakaba:ItemUse_Maijima(_, rng, player, useFlags, activeSlot, varData)
	local books = wakaba.runstate.cachedmaijimabooks
	if books then
		wakaba:GetPlayerEntityData(player)
		local subrandom = wakaba.RNG:RandomInt(#books) + 1
		local selected = books[subrandom]
		if selected == wakaba.Enums.Collectibles.DOUBLE_DREAMS then
			player:UseCard(wakaba.Enums.Cards.CARD_DREAM_CARD, 0 | UseFlag.USE_NOHUD)
		else
			player:UseActiveItem(selected, UseFlag.USE_VOID, -1)
		end
		player:GetData().wakaba.pendingmaijima = player:GetData().wakaba.pendingmaijima or {}
		local lang = Options.Language or "en"
		local eidlang = eidmatchlang[lang] or "en_us"
		local tempeidlang = EID.Config.Language
		if lang ~= "kr" and EID.Config.Language == "ko_kr" then
			eidlang = "en_us"
		end
		EID.Config.Language = eidlang
		local bookstring = 
				 (EID and EID:getObjectName(5, PickupVariant.PICKUP_COLLECTIBLE, selected)) 
			or Isaac.GetItemConfig():GetCollectible(selected).Name
		table.insert(player:GetData().wakaba.pendingmaijima, bookstring)
		EID.Config.Language = tempeidlang
		if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
			player:AnimateCollectible(wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY, "UseItem", "PlayerPickup")
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Maijima, wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY)