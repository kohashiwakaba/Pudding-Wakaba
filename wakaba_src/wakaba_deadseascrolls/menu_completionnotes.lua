return {
	title = "completion notes",
	nocursor = true,
	buttons = {
		{str = ""},
		{str = ""},
		{str = ""},
		{str = ""},
		{str = ""},

		--{str = "", nosel = true},
		--{str = "", nosel = true},
		{str = "", nosel = true},
		{str = "", nosel = true},
		{str = "", fsize = 2, nosel = true},

		{
			str = "current character : wakaba",
			nosel = true,
			fsize = 1,

			displayif = function(_, item)
				return item.bsel == 1
			end,
		},
		{
			str = "current character : shiori",
			nosel = true,
			fsize = 1,

			displayif = function(_, item)
				return item.bsel == 2
			end,
		},
		{
			str = "current character : tsukasa",
			nosel = true,
			fsize = 1,

			displayif = function(_, item)
				return item.bsel == 3
			end,
		},
		{
			str = "current character : richer",
			nosel = true,
			fsize = 1,

			displayif = function(_, item)
				return item.bsel == 4
			end,
		},
		{
			str = "current character : rira",
			nosel = true,
			fsize = 1,

			displayif = function(_, item)
				return item.bsel == 5
			end,
		},
	},

	postrender = function(item, tbl)
		if item.bsel < 1 then item.bsel = 5 end
		if item.bsel > 5 then item.bsel = 1 end
		--[[ if item.bsel == 5 then end ]]
		local centre = getScreenCenterPosition()
		local renderDataset = completionCharacterSets[item.bsel]
		local offsets = {NOTE1_RENDER_OFFSET, NOTE2_RENDER_OFFSET}
		if #renderDataset == 1 then offsets = {NOTE3_RENDER_OFFSET} end

		for index, renderData in pairs(renderDataset) do
			if renderData.IsUnlocked() then
				local dataset = wakaba:GetCompletionNoteLayerDataFromPlayerType(renderData.PlayerID)
				for index, value in pairs(dataset) do
					completionNoteSprite:SetLayerFrame(index, value)
				end
				completionHead:SetFrame(renderData.HeadName, 0)

				completionNoteSprite:Render(centre + offsets[index], Vector.Zero, Vector.Zero)
				completionHead:Render(centre + offsets[index] + Vector(30, 85), Vector.Zero, Vector.Zero)
			else
				completionHead:SetFrame(renderData.HeadName, 1)
				completionHead:Render(centre + offsets[index] + Vector(30, 85), Vector.Zero, Vector.Zero)

				completionDoor:SetFrame(renderDataset[index - 1].HeadName, 0)
				completionDoor:Render(centre + offsets[index], Vector.Zero, Vector.Zero)
			end
		end
	end,
}