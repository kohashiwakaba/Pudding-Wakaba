local t = wakaba.Enums.Pills

wakaba.encyclopediadesc.desc.pills = {

}

for k, v in pairs(wakaba.descriptions["en_us"].pills) do
	Encyclopedia.AddPill({
		Class = class,
		ModName = class,
		ID = k,
		Desc = "",
		WikiDesc = Encyclopedia.EIDtoWiki(v.description),
		Color = 9,
	})
end