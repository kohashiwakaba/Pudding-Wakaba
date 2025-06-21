
wakaba._DeadWispNotif = RegisterMod("Dead Wisp Notification", 1)

local eidmatchlang = {
	["en"] = "en",
	["es"] = "spa",
	["ru"] = "ru",
	["kr"] = "ko",
}
local deadwispprefix = {
	["en"] = "",
	["de"] = "",
	["es"] = "",
	["jp"] = "",
	["ru"] = "",
	["kr"] = "",
	["cn"] = "",
}
local deadwispsuffix = {
	["en"] = " is gone!",
	["de"] = " ist weg!",
	["es"] = " se ha ido!",
	["jp"] = " がなくなった!",
	["ru"] = " ушел!",
	["kr"] = " 위습이 사라졌다!",
	["cn"] = "不見了!",
}

local deadwisp = wakaba._DeadWispNotif
function deadwisp:GetStringfromLang(id, lang)
	lang = lang or "en"
	local eidlang = eidmatchlang[lang] or "en"
	local tempeidlang = EID.Config.Language
	if lang ~= "kr" and EID.Config.Language == "ko" then
		eidlang = "en"
	end
	EID.Config.Language = eidlang
	local str = 
			 (EID and EID:getObjectName(5, PickupVariant.PICKUP_COLLECTIBLE, id)) 
		or Isaac.GetItemConfig():GetCollectible(id).Name
	EID.Config.Language = tempeidlang
	return (deadwispprefix[lang] or deadwispprefix["en"]) .. str .. (deadwispsuffix[lang] or deadwispsuffix["en"])
end

function deadwisp:Notif(wisp)
	if wisp.Variant == FamiliarVariant.ITEM_WISP then
		local options = wakaba.state.options
		local wispp = wisp:ToFamiliar()
		local itemType = wisp.SubType
		local config = Isaac.GetItemConfig():GetCollectible(itemType)
		local hud = wakaba.G:GetHUD()
		--print(config and hud:IsVisible() and options.deadwispnotif)
		if config and hud:IsVisible() and options.deadwispnotif and wisp.HitPoints <= 0 then
			local str = deadwisp:GetStringfromLang(itemType, Options.Language)
			if str then
				hud:ShowItemText(deadwisp:GetStringfromLang(itemType, Options.Language), "", false)
			end
		end
	end
end
deadwisp:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, deadwisp.Notif, EntityType.ENTITY_FAMILIAR)


print("Dead Wisp Notification for Pudding and Wakaba Loaded")

