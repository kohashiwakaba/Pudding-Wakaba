wakaba.CompatManager = {
	Applied = false,
	Patches = {},
	PatchesApplied = {},
}

--wakaba.Callback.APPLY_PATCH_GAME_START = "WakabaCallbacks.APPLY_PATCH_GAME_START"
--wakaba.Callback.APPLY_PATCH_NEW_LEVEL = "WakabaCallbacks.APPLY_PATCH_NEW_LEVEL"

---@function
---@param type integer
---@param modName string
---@param exFunc function
---@param patchFunc function
---@param ignoreLoadCheck? boolean
function wakaba:RegisterPatch(type, modName, exFunc, patchFunc, ignoreLoadCheck)
	table.insert(wakaba.CompatManager.Patches,
		{
			modName = modName,
			type = type,
			exFunc = exFunc,
			patchFunc = patchFunc,
			ignoreLoadCheck = ignoreLoadCheck,
			loaded = false,
		}
	)
end

function wakaba:ApplyCompat()
	for _, patch in pairs(wakaba.CompatManager.Patches) do
		if not patch.type or patch.type == 0 then
			local exist
			if patch.exFunc and type(patch.exFunc) == "function" then
				exist = patch.exFunc()
			end
			if not exist then
				exist = _G[patch.modName]
			end
	
			if exist and (patch.ignoreLoadCheck or not patch.loaded) then
				local loaded = patch.patchFunc()
				if loaded == nil then loaded = true end
				patch.loaded = loaded
				wakaba.FLog("Patch", "Compat patch for mod", patch.modName, "complete")
			end
		end
	end

	wakaba.CompatManager.Applied = true
end

function wakaba:NewLevel_ApplyCompat()
	for _, patch in pairs(wakaba.CompatManager.Patches) do
		if patch.type and patch.type == 1 then
			local exist
			if patch.exFunc and type(patch.exFunc) == "function" then
				exist = patch.exFunc()
			end
			if not exist then
				exist = _G[patch.modName]
			end
	
			if exist and (patch.ignoreLoadCheck or not patch.loaded) then
				local loaded = patch.patchFunc()
				if loaded == nil then loaded = true end
				patch.loaded = loaded
				wakaba.FLog("Patch", "Compat patch for mod", patch.modName, "complete")
			end
		end
	end
end

do
	include('wakaba_src.compat.stageapi')
	include('wakaba_src.compat.fiendfolio')
	include('wakaba_src.compat.retribution')
	include('wakaba_src.compat.epiphany')
	include('wakaba_src.compat.samael')
	include('wakaba_src.compat.taintedtreasure')
	include('wakaba_src.compat.thefuture')
	include('wakaba_src.compat.sacred_dreams')
	include('wakaba_src.compat.reshaken_v1')
	include('wakaba_src.compat.astro')
end

if REPENTOGON then
	wakaba:AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, wakaba.ApplyCompat)
else
	wakaba:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, CallbackPriority.LATE, wakaba.ApplyCompat)
end

wakaba:AddPriorityCallback(ModCallbacks.MC_POST_NEW_LEVEL, CallbackPriority.LATE, wakaba.NewLevel_ApplyCompat)