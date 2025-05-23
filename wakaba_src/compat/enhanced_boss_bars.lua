
wakaba:RegisterPatch(0, "HPBars", function() return (HPBars ~= nil) end, function()
	do
		local tSprite = Sprite()
		tSprite:Load("gfx/ui/wakaba/ui_statusicons.anm2", true)

		HPBars.StatusEffects["Zipped_wakaba"] = {
			sprite = tSprite,
			condition = function(entity)
				return entity and wakaba.Status:HasStatusEffect(entity, wakaba.Status.StatusFlag.wakaba_ZIPPED)
			end,
			animation = "Zipped",
			frame = 0,
		}
		HPBars.StatusEffects["Aqua_wakaba"] = {
			sprite = tSprite,
			condition = function(entity)
				return entity and wakaba.Status:HasStatusEffect(entity, wakaba.Status.StatusFlag.wakaba_AQUA)
			end,
			animation = "Aqua",
			frame = 0,
		}
	end
end)