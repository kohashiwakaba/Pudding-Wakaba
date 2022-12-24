local isc = require("wakaba_src.libs.isaacscript-common")

local ribbon_data = {
	run = {
    hiddendata = {},
	},
}
wakaba:saveDataManager("Wakaba Hidden Items", ribbon_data)

--local loaded = false

wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GAME_EXIT, CallbackPriority.IMPORTANT, function ()
  ribbon_data.run.hiddendata = wakaba.HiddenItemManager:GetSaveData()
end)

wakaba:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, CallbackPriority.LATE, function (_, isContinued)
  if (isContinued) then
    wakaba.HiddenItemManager:LoadData(ribbon_data.run.hiddendata)
  end
end)
