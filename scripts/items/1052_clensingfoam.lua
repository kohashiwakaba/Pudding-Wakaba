wakaba.COLLECTIBLE_CLENSING_FOAM = Isaac.GetItemIdByName("Clensing Foam")


function wakaba:PEffectUpdate_ClensingFoam(player)
  local radius = 60
  local multi = 1
  if Game():GetRoom():HasWater() then
    radius = 2000
    multi = 0.12
  end
  if player:HasCollectible(wakaba.COLLECTIBLE_CLENSING_FOAM) then
    local entities = Isaac.FindInRadius(player.Position, radius, EntityPartition.ENEMY)
    for _, entity in ipairs(entities) do
      if entity:IsEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
        local multiplier = (1 + player:GetCollectibleNum(wakaba.COLLECTIBLE_CLENSING_FOAM)) * multi
        local length = 15
        if entity:IsBoss() then
          multiplier = multiplier * 3
          length = 60
        end
        entity:AddPoison(EntityRef(player), length, player.Damage * multiplier)
        if entity:ToNPC() then
          if not entity:IsBoss() and entity:ToNPC():IsChampion() then
            local previousNPC = entity:ToNPC()
            Isaac.Spawn(previousNPC.Type, previousNPC.Variant, previousNPC.SubType, previousNPC.Position, previousNPC.Velocity, previousNPC.Parent)
            previousNPC:Remove()
          end
        end
      end
    end

  end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PEffectUpdate_ClensingFoam)


