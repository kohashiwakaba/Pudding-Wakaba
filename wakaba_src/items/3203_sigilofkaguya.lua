--[[
	Sigil of Kaguya (카구야의 인장) - 장신구
	TR 츠카사로 4보스 처치
	15초마다 16%의 확률로 Crack the Sky 액티브 발동 (행운 34일 때 100%)
	현재 방이 클리어되지 않은 상태에서만 발동
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

---@param player EntityPlayer
function wakaba:PlayerUpdate_SigilOfKaguya(player)
	local room = wakaba.G:GetRoom()
	local effects = player:GetEffects()
	if player:HasTrinket(wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA) and wakaba.G:GetFrameCount() % (30 * 15) == 0 then
		local rng = player:GetTrinketRNG(wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA)
		local count = 1
		local charmBonus = 0

		local basicChance = 0.16
		local parLuck = 34
		local maxChance = 1 - basicChance
		local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck + charmBonus, parLuck, maxChance), count)
		if rng:RandomFloat() < chance then
			effects:AddTrinketEffect(wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA, false, player:GetTrinketMultiplier(wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA))
		end
	end
	if not room:IsClear() and effects:HasTrinketEffect(wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA) and not effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_CRACK_THE_SKY) then
		effects:RemoveTrinketEffect(wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA, 1)
		effects:AddTrinketEffect(CollectibleType.COLLECTIBLE_CRACK_THE_SKY, 1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_SigilOfKaguya)