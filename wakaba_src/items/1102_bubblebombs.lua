--[[
	Bubble Bombs (물방울 폭탄) - 패시브(Passive)
	- 폭탄 +5
	- 폭탄이 확률적으로 약화 or 침수 상태이상
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

---@param player EntityPlayer
local function shouldApplyAqua(player, rng)
	rng = rng or player:GetCollectibleRNG(wakaba.Enums.Collectibles.BUBBLE_BOMBS)
	local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.BUBBLE_BOMBS)
	local charmBonus = wakaba:getTeardropCharmBonus(player)

	local basicChance = 0.2
	local parLuck = 22
	local maxChance = 1 - basicChance

	local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck + charmBonus, parLuck, maxChance), count)
	return rng:RandomFloat() < chance
end

---@param bomb EntityBomb
function wakaba:BombUpdate_BubbleBombs(bomb)
	if bomb.Type == EntityType.ENTITY_BOMB and bomb.SpawnerType == EntityType.ENTITY_PLAYER and bomb.Variant ~= BombVariant.BOMB_TROLL then
		local player = bomb.SpawnerEntity:ToPlayer()
		local data = bomb:GetData()
		if (not data.w_bubbleTried or data.w_isBubbleBomb) and player and player:HasCollectible(wakaba.Enums.Collectibles.BUBBLE_BOMBS) then
			data.w_bubbleTried = true
			local sprite = bomb:GetSprite()
			local rng = RNG()
			rng:SetSeed(bomb.InitSeed, 35)
			if data.w_isBubbleBomb or not bomb.IsFetus or (bomb.IsFetus and shouldApplyAqua(player, rng)) then
				data.w_isBubbleBomb = true
				if not data.w_gfxOverridden and not (bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB)) and
				(bomb.Variant == BombVariant.BOMB_NORMAL or bomb.Variant == BombVariant.BOMB_MR_MEGA or bomb.Variant == BombVariant.BOMB_SMALL) then
					if player:HasGoldenBomb() then
						sprite:ReplaceSpritesheet(0, "gfx/items/pickups/bombs/costumes/wakaba_aquabomb_gold.png")
					else
						sprite:ReplaceSpritesheet(0, "gfx/items/pickups/bombs/costumes/wakaba_aquabomb.png")
					end
					sprite:LoadGraphics()
					bomb.Color = wakaba.Colors.AQUA_WEAPON_COLOR
					data.w_gfxOverridden = true
				end
				if sprite:IsPlaying("Explode") then
					wakaba:ActivateBubbleBomb(bomb, player)
				end
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, wakaba.BombUpdate_BubbleBombs)

---@param effect EntityEffect
function wakaba:EffectUpdate_Missile_BubbleBombs(effect)
	if not effect.SpawnerEntity then
		return
	end
	local player = effect.SpawnerEntity:ToPlayer()
	local sprite = effect:GetSprite()
	if player:HasCollectible(wakaba.Enums.Collectibles.BUBBLE_BOMBS) then
		if sprite:IsFinished("Falling") then
			wakaba:ActivateBubbleBomb(effect, player)
		end
		if effect.Variant == EffectVariant.SMALL_ROCKET then
			sprite:ReplaceSpritesheet(0, "gfx/effects/wakaba_aquamissile_small.png")
		else
			sprite:ReplaceSpritesheet(0, "gfx/effects/wakaba_aquamissile.png")
		end
		effect:GetData().wakaba_ExplosionColor = wakaba.Colors.AQUA_WEAPON_COLOR
		sprite:LoadGraphics()
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_Missile_BubbleBombs, EffectVariant.ROCKET)
--wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_Missile_BubbleBombs, EffectVariant.SMALL_ROCKET)

---@param bomb EntityBomb|EntityEffect
---@param player EntityPlayer
function wakaba:ActivateBubbleBomb(bomb, player)
	local explosion = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION)
	for _, boom in pairs(explosion) do
		local sprite = boom:GetSprite()
		local frame = sprite:GetFrame()
		if frame < 3 then
			local size = boom.SpriteScale.X
			local nearby = Isaac.FindInRadius(boom.Position, 75*size)
			for _, e in pairs(nearby) do
				if e:IsVulnerableEnemy() and not wakaba:isStatusBlacklisted(e) then
					if e:HasEntityFlags(EntityFlag.FLAG_ICE) then
						e.HitPoints = 0
						e:Update()
					elseif wakaba:isAquaInstakill(e) then
						e:Kill()
					else
						wakaba:AddStatusEffect(e, wakaba.StatusEffect.AQUA, 150, player)
					end
				end
			end
		end
	end
end