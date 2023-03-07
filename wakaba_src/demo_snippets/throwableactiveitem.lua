-- Note: "collectible" is the subtype of the custom item you want to make a throwable active. Use the enum you create from Isaac.GetItemIdByName() for it.

local game = Game()

function mod:onItemUse(_, _, player, useFlags, slot, _)
    if useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY then return end
    if not player:GetData().usingThrowableActive then
        player:GetData().usingThrowableActive = true -- VERY IMPORTANT! Make the name of your GetData something more specific than "usingThrowableActive" so that other mods don't overwrite it!!
        player:GetData().throwableActiveSlot = slot -- store what slot the active item was used from (primary, secondary, or pocket?)
        player:AnimateCollectible(collectible, "LiftItem", "PlayerPickup")
    else
        player:GetData().usingThrowableActive = false
        player:AnimateCollectible(collectible, "HideItem", "PlayerPickup")
    end
    return {Discharge = false, Remove = false, ShowAnim = false} -- stops the item from discharging unless something actually shoots out
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onItemUse, collectible)

function mod:postPEffectUpdate(player) -- Trigger throwable active upon shooting
    if player:GetData().usingThrowableActive and player:GetFireDirection() ~= Direction.NO_DIRECTION then
        player:GetData().usingThrowableActive = false

        -- PLACE THE ACTUAL EFFECT OF YOUR THROWABLE ACTIVE HERE --

        local slot = player:GetData().throwableActiveSlot
        if slot == ActiveSlot.SLOT_PRIMARY then -- Prevent possible cheese with Schoolbag
            if player:GetActiveItem(slot) ~= collectible then
                slot = ActiveSlot.SLOT_SECONDARY
            else
                if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) < Isaac.GetItemConfig():GetCollectible(collectible).MaxCharges then
                    slot = ActiveSlot.SLOT_SECONDARY
                end
            end
        end
        player:DischargeActiveItem(slot) -- Since the item was used successfully, actually discharge the item
        player:AnimateCollectible(collectible, "HideItem", "PlayerPickup")
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.postPEffectUpdate)

function mod:entityTakeDmg(entity, _, _, _, _) -- Terminate the holding up of your throwable active upon taking damage. This function can be omitted if you want, but I added it to be closer to vanilla behavior.
    local player = entity:ToPlayer()
    if not player then return end
    
    if player:GetData().usingThrowableActive then
        player:GetData().usingThrowableActive = false
        player:AnimateCollectible(collectible, "HideItem", "PlayerPickup")
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.entityTakeDmg)

function mod:postNewRoom() -- Terminate the holding up of your throwable active upon entering a new room. This function can also be omitted if you want.
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player:GetData().usingThrowableActive then
            player:GetData().usingThrowableActive = false
            player:AnimateCollectible(collectible, "HideItem", "PlayerPickup")
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.postNewRoom)

-- Code by Aeronaut
