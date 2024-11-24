
wakaba:RegisterPatch(0, "CuerLib", function() return (CuerLib ~= nil) end, function()
	do
		local function EvaluateBlacklist(mod, id, config)
			wakaba._rerollPreNoClear = true
		end
		wakaba:AddCallback(CuerLib.Callbacks.CLC_EVALUATE_POOL_BLACKLIST, EvaluateBlacklist)
	end
end)