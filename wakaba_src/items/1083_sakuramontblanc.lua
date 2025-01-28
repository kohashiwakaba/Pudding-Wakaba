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
			if wakaba:EntitiesAreWithinRange(entity, e, 85 * power) then
				if e:HasEntityFlags(EntityFlag.FLAG_ICE) then
					e.HitPoints = 0
					e:Update()
				elseif wakaba:isAquaInstakill(entity) then
					e:Kill()
				else
					wakaba.Status:AddStatusEffect(e, StatusEffectLibrary.StatusFlag.wakaba_ZIPPED, 300 * power, EntityRef(player))
				end
			end
		end
		local fart = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART, 0, entity.Position, Vector.Zero, player):ToEffect()
		fart.Color = wakaba.Colors.AQUA_FART_COLOR
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
		local mod = 4 / 6
		player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, power * mod * wakaba:getEstimatedTearsMult(player))
	end
	if cacheFlag == CacheFlag.CACHE_DAMAGE then
		local mod = 1 / 6
		player.Damage = player.Damage + (power * mod * wakaba:getEstimatedDamageMult(player))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_SakuraMontBlanc)