--[[
	Sakura Mont Blanc (사쿠라 몽블랑) - 패시브(Passive)
	적 처치 시 매혹 방귀
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

---@param npc EntityNPC
function wakaba:NPCDeath_SakuraMontBlanc(entity)

	if wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.SAKURA_MONT_BLANC) then
		local player
		local players = isc:getPlayersWithCollectible(wakaba.Enums.Collectibles.SAKURA_MONT_BLANC)
		local power = 0.8 + (wakaba:GetGlobalCollectibleNum(wakaba.Enums.Collectibles.SAKURA_MONT_BLANC) * 0.2)
		if #players > 0 then
			local rng = RNG()
			rng:SetSeed(entity.InitSeed, 35)
			player = players[rng:RandomInt(#players) + 1]
		else
			player = Isaac.GetPlayer()
		end
		local enemies = isc:getNPCs()
		for i, e in ipairs(enemies) do
			if wakaba:EntitiesAreWithinRange(entity, e, 85 * power) and not wakaba:isStatusBlacklisted(e) then
				if e:HasEntityFlags(EntityFlag.FLAG_ICE) then
					e.HitPoints = 0
					e:Update()
				elseif wakaba:isAquaInstakill(entity) then
					e:Kill()
				else
					wakaba:AddStatusEffect(e, wakaba.StatusEffect.AQUA, 300 * power, player)
				end
			end
		end
		wakaba.G:CharmFart(entity.Position, 85 * power, player)
		for i, e in ipairs(players) do
			e:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.SAKURA_MONT_BLANC)
			e:AddCacheFlags(CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE)
			e:EvaluateItems()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, wakaba.NPCDeath_SakuraMontBlanc)

function wakaba:Cache_SakuraMontBlanc(player, cacheFlag)
	local baseLimit = math.max(player:GetCollectibleNum(wakaba.Enums.Collectibles.SAKURA_MONT_BLANC), 1)
	local power = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.SAKURA_MONT_BLANC)
	power = math.min(power, 6 * baseLimit)
	if cacheFlag == CacheFlag.CACHE_FIREDELAY then
		player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, power * wakaba:getEstimatedTearsMult(player))
	end
	if cacheFlag == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage + (0.5 * power * wakaba:getEstimatedDamageMult(player))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_SakuraMontBlanc)