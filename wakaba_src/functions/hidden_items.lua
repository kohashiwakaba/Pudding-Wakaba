local isc = require("wakaba_src.libs.isaacscript-common")

local inRun = false

local ribbon_data = {
	run = {
    hiddendata = {},
	},
}
wakaba:saveDataManager("Wakaba Hidden Items", ribbon_data)

function wakaba:LoadHiddenItemData2()
  if inRun then return end
  inRun = true
  if wakaba.G:GetFrameCount() > 0 then
    wakaba.HiddenItemManager:LoadData(ribbon_data.run.hiddendata)
  end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_PLAYER_INIT, CallbackPriority.LATE, wakaba.LoadHiddenItemData2)

--local loaded = false
function wakaba:SaveHiddenItemData()
  ribbon_data.run.hiddendata = wakaba.HiddenItemManager:GetSaveData()
  inRun = false
end

wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GAME_EXIT, CallbackPriority.IMPORTANT, wakaba.SaveHiddenItemData)

