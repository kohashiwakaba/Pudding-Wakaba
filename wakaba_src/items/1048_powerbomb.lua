local sfx = SFXManager()

function wakaba:UsePowerBomb(player, position)
  player = player or Isaac.GetPlayer()
  position = position or player.Position
  local bombs = 5
  local explosion = Isaac.Spawn(EntityType.ENTITY_EFFECT, wakaba.Enums.Effects.POWER_BOMB, 0, position, Vector.Zero, nil):ToEffect()
  explosion:GetData().wakaba = {}
  explosion:GetData().wakaba.damage = bombs
  sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_EXPLOSION)
  sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_LOOP, 1, 2, true)
end

function wakaba:EffectInit_PowerBomb(effect)
  local effectsprite = effect:GetSprite()
  effectsprite.Scale = Vector(3, 3)
end
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, wakaba.EffectInit_PowerBomb, wakaba.Enums.Effects.POWER_BOMB)

function wakaba:EffectUpdate_PowerBomb(effect)
  effect:GetData().wakaba = effect:GetData().wakaba or {}
  local damage = effect:GetData().wakaba.damage or 5
  local state = 0
  local effectsprite = effect:GetSprite()
  if effectsprite:IsFinished("Explode") then
    local room = wakaba.G:GetRoom()
    for i = 0, room:GetGridSize() do
      if room:GetGridEntity(i) then
        if room:GetGridEntity(i):GetType() == GridEntityType.GRID_DOOR then
          local door = room:GetGridEntity(i):ToDoor()
          door:TryBlowOpen(true, effect)
          if door:IsLocked() or (door.TargetRoomType == RoomType.ROOM_CHALLENGE)then
            door:TryUnlock(Isaac.GetPlayer(), true)
          end
        end
        room:GetGridEntity(i):Destroy()
      end
    end
    effectsprite:Play("Exploding")
    effectsprite:Update()
  elseif effectsprite:IsFinished("Exploding") then
    --sfx:Play(SoundEffect.SOUND_REVERSE_EXPLOSION)
    sfx:Stop(wakaba.Enums.SoundEffects.POWER_BOMB_LOOP)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_1)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_2)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_3)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_4)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_5)
    effectsprite:Play("Fading")
    effectsprite:Update()
  elseif effectsprite:IsPlaying("Fading") then
    --local scalept = ((48 - effectsprite:GetFrame()) / 48) * 3
    --effectsprite.Scale = Vector(scalept, scalept)
    --effectsprite:Update()
  elseif effectsprite:IsFinished("Fading") then
    effect:Remove()
  end
  local enemies = Isaac.FindInRadius(effect.Position, 1600, EntityPartition.ENEMY)
  for i, entity in pairs(enemies) do
    if entity:IsEnemy() then
      --print("Enemy Taking Damage")
      entity:TakeDamage(damage * 0.4, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(effect), 0)
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_PowerBomb, wakaba.Enums.Effects.POWER_BOMB)

function wakaba:NewRoom_PowerBomb()
  if sfx:IsPlaying(wakaba.Enums.SoundEffects.POWER_BOMB_LOOP) then
    sfx:Stop(wakaba.Enums.SoundEffects.POWER_BOMB_LOOP)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_1)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_2)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_3)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_4)
    sfx:Play(wakaba.Enums.SoundEffects.POWER_BOMB_AFTER_EXPLOSION_5)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_PowerBomb)

function wakaba:EffectRender_PowerBomb(effect)
  if sfx:IsPlaying(SoundEffect.SOUND_UNLOCK00) then
    sfx:Stop(SoundEffect.SOUND_UNLOCK00)
  end
  local effectsprite = effect:GetSprite()
  if effectsprite:IsPlaying("Fading") then
    local scalept = ((48 - effectsprite:GetFrame()) / 48) * 3
    effectsprite.Scale = Vector(scalept, scalept)
    effectsprite:Update()
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_RENDER, wakaba.EffectRender_PowerBomb, wakaba.Enums.Effects.POWER_BOMB)

function wakaba:ItemUse_PowerBomb(_, rng, player, useFlags, activeSlot, varData)

  wakaba:UsePowerBomb(player, player.Position)
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.POWER_BOMB, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_PowerBomb, wakaba.Enums.Collectibles.POWER_BOMB)
