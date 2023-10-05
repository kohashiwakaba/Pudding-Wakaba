--[[ 
	Black Bean Mochi - 패시브(Passive)
	적 처치 시 폭발
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

local sprite = Sprite()
sprite:Load("gfx/ui/wakaba/ui_statusicons.anm2", true)
sprite:Play("Zipped")
wakaba:RegisterStatusEffect("ZIPPED", sprite)

---@param player EntityPlayer
local function shouldApplyZipped(player)
	local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI)
	local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI)

	local basicChance = 0.1
	local parLuck = 16
	local maxChance = 1 - basicChance

	local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck, parLuck, maxChance), count)
	return rng:RandomFloat() < chance
end

function wakaba:TearInit_BlackBeanMochi(tear)
	if tear.FrameCount < 1 and tear.Parent then
		local player = wakaba:getPlayerFromTear(tear)
		if player:HasCollectible(wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI) and shouldApplyZipped(player) then
			wakaba:AddRicherTearFlags(tear, wakaba.TearFlag.ZIPPED)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearInit_BlackBeanMochi)

wakaba:AddCallback(wakaba.Callback.APPLY_TEARFLAG_EFFECT, function(_, effectTarget, player, effectSource)
	if effectTarget:IsVulnerableEnemy() then
		wakaba:AddStatusEffect(effectTarget, wakaba.StatusEffect.ZIPPED, 90, player)
	end
end, wakaba.TearFlag.ZIPPED)

---@param npc EntityNPC
function wakaba:NPCDeath_BlackBeanMochi(npc)
	if npc:IsDead() and wakaba:HasStatusEffect(npc, wakaba.StatusEffect.ZIPPED) then
		local statusData = wakaba:HasStatusEffect(npc, wakaba.StatusEffect.ZIPPED)
		local player = statusData.Player
		if player then
			wakaba.G:BombExplosionEffects(npc.Position, 60, TearFlags.TEAR_NORMAL, Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR)
			print("Explode!")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_NPC_UPDATE, wakaba.NPCDeath_BlackBeanMochi)