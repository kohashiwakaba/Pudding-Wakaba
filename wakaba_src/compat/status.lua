
wakaba:RegisterPatch(0, "StatusEffectLibrary", function() return (StatusEffectLibrary ~= nil) end, function()
	do
		wakaba.Status = StatusEffectLibrary
	end
end)