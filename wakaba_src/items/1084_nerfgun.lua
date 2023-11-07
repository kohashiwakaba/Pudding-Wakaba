--[[ 
	Nerf Gun (너프 건) - 액티브(Active)
	공격방향으로 너프 샷을 여러 번 발사
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

wakaba:AddCallback(wakaba.Callback.APPLY_TEARFLAG_EFFECT, function(_, effectTarget, player, effectSource)
	if wakaba:CanApplyStatusEffect(effectTarget) then
		effectTarget:AddEntityFlags(EntityFlag.FLAG_WEAKNESS)
		wakaba:scheduleForUpdate(function()
			effectTarget:ClearEntityFlags(EntityFlag.FLAG_WEAKNESS)
		end, 150)
	end
end, wakaba.TearFlag.NERF)
