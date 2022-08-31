--wakaba.COLLECTIBLE_POWER_BOMB = Isaac.GetItemIdByName("Power Bomb")
wakaba.EFFECT_POWER_BOMB = Isaac.GetEntityVariantByName("Wakaba Power Bomb Explosion")

function wakaba:UsePowerBomb(player, position, bombs)
  player = player or Isaac.GetPlayer()
  position = position or player.Position
  bombs = bombs or player:GetNumBombs()
  local explosion = Isaac.Spawn(EntityType.ENTITY_EFFECT, wakaba.EFFECT_POWER_BOMB, 0, position, Vector.Zero, player):ToEffect()
  explosion:GetData().wakaba = {}
  explosion:GetData().wakaba.damage = bombs
end

function wakaba:EffectInit_PowerBomb(effect)
end

function wakaba:EffectUpdate_PowerBomb(effect)
  effect:GetData().wakaba = effect:GetData().wakaba or {}
  local damage = effect:GetData().wakaba.damage or 5
  local state = 0
  local effectsprite = effect:GetSprite()
  if effectsprite:IsFinished("Explode") then
    local room = Game():GetRoom()
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
    SFXManager():Play(SoundEffect.SOUND_REVERSE_EXPLOSION)
    effectsprite:Play("Fading")
    effectsprite:Update()
  elseif effectsprite:IsPlaying("Fading") then
    local scalept = ((16 - effectsprite:GetFrame()) / 16)
    effectsprite.Scale = Vector(scalept, scalept)
    effectsprite:Update()
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
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.EffectUpdate_PowerBomb, wakaba.EFFECT_POWER_BOMB)

function wakaba:ItemUse_PowerBomb(_, rng, player, useFlags, activeSlot, varData)

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.COLLECTIBLE_POWER_BOMB, "UseItem", "PlayerPickup")
	end
end
--wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_PowerBomb, wakaba.COLLECTIBLE_POWER_BOMB)
