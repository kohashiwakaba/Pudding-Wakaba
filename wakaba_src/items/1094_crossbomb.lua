--[[
	Cross Bomb (크로스 밤) - 패시브(Passive)
	와카바 챌린지 17번 (The Floor is Lava) 클리어
	캐릭터의 폭탄 폭발을 기준 4방향으로 3칸씩 추가 폭발
	추가 폭발은 캐릭터 자해 없음
 ]]
local isc = _wakaba.isc


---@param player EntityPlayer
local function shouldApplyCross(player, rng)
	rng = rng or player:GetCollectibleRNG(wakaba.Enums.Collectibles.CROSS_BOMB)
	local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.CROSS_BOMB)
	local charmBonus = wakaba:getTeardropCharmBonus(player)

	local basicChance = 0.3
	local parLuck = 30
	local maxChance = 1 - basicChance

	local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck + charmBonus, parLuck, maxChance), count)
	return rng:RandomFloat() < chance
end

---@param bomb EntityBomb
function wakaba:BombUpdate_CrossBomb(bomb)
	if bomb.Type == EntityType.ENTITY_BOMB and bomb.SpawnerType == EntityType.ENTITY_PLAYER and bomb.Variant ~= BombVariant.BOMB_TROLL then
		local player = bomb.SpawnerEntity:ToPlayer()
		local data = bomb:GetData()
		if (not data.w_crossTried or data.w_isCrossBomb) and player and player:HasCollectible(wakaba.Enums.Collectibles.CROSS_BOMB) then
			data.w_crossTried = true
			local sprite = bomb:GetSprite()
			local rng = RNG()
			rng:SetSeed(bomb.InitSeed, 35)
			if data.w_isCrossBomb or not bomb.IsFetus or (bomb.IsFetus and shouldApplyCross(player, rng)) then
				data.w_isCrossBomb = true
				if not data.w_gfxOverridden and not (bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB)) and
				(bomb.Variant == BombVariant.BOMB_NORMAL or bomb.Variant == BombVariant.BOMB_MR_MEGA or bomb.Variant == BombVariant.BOMB_SMALL) then
					if player:HasGoldenBomb() then
						--sprite:ReplaceSpritesheet(0, "gfx/items/pickups/bombs/costumes/wakaba_crossbomb_gold.png")
					else
						--sprite:ReplaceSpritesheet(0, "gfx/items/pickups/bombs/costumes/wakaba_crossbomb.png")
					end
					sprite:LoadGraphics()
					data.w_gfxOverridden = true
				end
				if sprite:IsPlaying("Explode") then
					wakaba:ActivateCrossBomb(bomb, player)
				end
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, wakaba.BombUpdate_CrossBomb)

---@param effect EntityEffect
function wakaba:EffectUpdate_Missile_CrossBomb(effect)
	if not effect.SpawnerEntity then
		return
	end
	local player = effect.SpawnerEntity:ToPlayer()
	local sprite = effect:GetSprite()
	if player:HasCollectible(wakaba.Enums.Collectibles.CROSS_BOMB) then
		if sprite:IsFinished("Falling") then
			wakaba:ActivateCrossBomb(effect, player)
		end
		if effect.Variant == EffectVariant.SMALL_ROCKET then
			--sprite:ReplaceSpritesheet(0, "gfx/effects/wakaba_aquamissile_small.png")
		else
			--sprite:ReplaceSpritesheet(0, "gfx/effects/wakaba_aquamissile.png")
		end
		--effect:GetData().wakaba_ExplosionColor = wakaba.Colors.AQUA_WEAPON_COLOR
		--sprite:LoadGraphics()
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_Missile_CrossBomb, EffectVariant.ROCKET)
--wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_Missile_CrossBomb, EffectVariant.SMALL_ROCKET)

local bombRoomNo = 0

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	bombRoomNo = bombRoomNo + 1
end)

local bombRot = {
	[0] = Vector(0, -40),
	[1] = Vector(40, 0),
	[2] = Vector(0, 40),
	[3] = Vector(-40, 0),
}

---@param bomb EntityBomb|EntityEffect
---@param player EntityPlayer
function wakaba:ActivateCrossBomb(bomb, player)
	local explosion = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION)
	for _, boom in pairs(explosion) do
		local crossCount = (player and player:GetCollectibleNum(wakaba.Enums.Collectibles.CROSS_BOMB) + 2) or 3
		local sprite = boom:GetSprite()
		local frame = sprite:GetFrame()
		if frame < 3 then
			for i = 1, crossCount do
				boom:GetData().wakaba_crossbomb = true
				wakaba:scheduleForUpdate(function ()
					local saved = bombRoomNo + 0
					local current = bombRoomNo
					if saved ~= current then return end
					for k = 0, 3 do
						wakaba.G:BombExplosionEffects(
							boom.Position + (bombRot[k] * i),
							10,
							TearFlags.TEAR_NORMAL,
							Color.Default,
							player,
							0.4,
							false,
							false,
							DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR
						)
					end
				end, (4 * i))
			end
		end
	end
end