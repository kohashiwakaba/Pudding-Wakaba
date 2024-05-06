local flags = wakaba.Flags

function wakaba.Log(...)
	local str = ""
	if not flags.debugCore then
		return
	end
	str = "[wakaba] " .. str
	local sa = {...}
	for i = 1, #sa do
		sa[i] = tostring(sa[i])
	end
	str = str .. table.concat(sa, " ")
	if flags.debugLogs then
		Isaac.DebugString(str)
	end
	if flags.debugConsole then
		print(str)
	end
end

function wakaba.FLog(flagName, ...)
	if flags[flagName] then
		wakaba.Log(...)
	end
end