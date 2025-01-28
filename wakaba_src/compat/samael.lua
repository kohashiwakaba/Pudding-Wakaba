
local isc = _wakaba.isc

wakaba:RegisterPatch(0, "SamaelMod", function() return (SamaelMod ~= nil) end, function()
	do
		wakaba:BlacklistUniform("card", SamaelMod.ITEMS.DENIAL_DICE)
	end
end)
