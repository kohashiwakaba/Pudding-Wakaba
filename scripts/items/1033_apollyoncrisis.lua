wakaba.BetterVoiding = {}

local BetterVoiding_ApollyonCrisis = nil

local flagsV = 0
local flagsPC = 0

function wakaba:tryAddBetterVoiding()
	if BetterVoiding then
		local BVIType = BetterVoiding.BetterVoidingItemType.TYPE_COLLECTIBLE
		local preVoidingColor = Color(0.11,0.11,0.11,0.9,0,0,0)
		flagsV = BetterVoiding.VoidingFlags.V_NEAREST_PAYABLE_PICKUP | BetterVoiding.VoidingFlags.V_ALL_FREE_PICKUPS
		flagsPC = BetterVoiding.PickupCategoryFlags.PC_PRICE_FREE | BetterVoiding.PickupCategoryFlags.PC_PRICE_HEARTS | BetterVoiding.PickupCategoryFlags.PC_PRICE_COINS | BetterVoiding.PickupCategoryFlags.PC_PRICE_SPIKES | BetterVoiding.PickupCategoryFlags.PC_TYPE_COLLECTIBLE
		BetterVoiding_ApollyonCrisis = BetterVoiding.betterVoidingItemConstructor(BVIType, wakaba.Enums.Collectibles.APOLLYON_CRISIS, true, flagsV, flagsPC, preVoidingColor)
		if BetterVoiding_ApollyonCrisis then
			--print("Better Voiding link for Apollyon Crisis")
			wakaba.BetterVoiding.ApollyonCrisis = BetterVoiding_ApollyonCrisis
			wakaba:RemoveCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.tryAddBetterVoiding)
		end
	end
end
-- Added this callback because Pudding and Wakaba is currently being loaded before Better Voiding mod
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.tryAddBetterVoiding)

if BetterVoiding then
	wakaba:tryAddBetterVoiding()
end


function wakaba:RemovePedestalIndex(includeShop)
	includeShop = includeShop or true
	local items = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
	if (#items == 0) then return nil end
	for i = 1, #items do
		local item = items[i]:ToPickup()
		if includeShop or not item:IsShopItem() then
			item.OptionsPickupIndex = 0
		end
	end
end
	
function wakaba:ItemUse_ApollyonCrisis(_, rng, player, useFlags, activeSlot, varData)
	if BetterVoiding_ApollyonCrisis then
		wakaba:RemovePedestalIndex(false)
		local pedestals = BetterVoiding.betterVoiding(BetterVoiding_ApollyonCrisis, player)
		for p, dist in pairs(pedestals) do
			--Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, p.SubType, player.Position, Vector.Zero, player):ToFamiliar()
			if (p.SubType == CollectibleType.COLLECTIBLE_VOID or p.SubType == CollectibleType.COLLECTIBLE_ABYSS or p.SubType == wakaba.Enums.Collectibles.APOLLYON_CRISIS) then
				p:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BREAKFAST, true, true, true)
			end
		end
		local prepedestals = wakaba:GetPedestals(false)
		if not prepedestals then
			Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, 0, player.Position, Vector.Zero, player):ToFamiliar():AddEntityFlags(EntityFlag.FLAG_DONT_OVERWRITE)
		end
		player:UseActiveItem(CollectibleType.COLLECTIBLE_VOID, 0, -1)
		--print(#readyForAbyss)
		for p, dist in pairs(pedestals) do
			--print("Abyss fly spawned!")
			Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, p.SubType, player.Position, Vector.Zero, player):ToFamiliar():AddEntityFlags(EntityFlag.FLAG_DONT_OVERWRITE)
		end
	else
		wakaba:RemovePedestalIndex(false)
		local pedestals = wakaba:GetPedestals(false)
		if not pedestals then 
			Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, 0, player.Position, Vector.Zero, player):ToFamiliar():AddEntityFlags(EntityFlag.FLAG_DONT_OVERWRITE)
		else
			for i, p in ipairs(pedestals) do
				Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, p.CollectibleType, player.Position, Vector.Zero, player):ToFamiliar():AddEntityFlags(EntityFlag.FLAG_DONT_OVERWRITE)
				if (p.CollectibleType == CollectibleType.COLLECTIBLE_VOID or p.CollectibleType == CollectibleType.COLLECTIBLE_ABYSS or p.CollectibleType == wakaba.Enums.Collectibles.APOLLYON_CRISIS) then
					p:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BREAKFAST, true, true, true)
				end
			end
		end
		player:UseActiveItem(CollectibleType.COLLECTIBLE_VOID, 0, -1)
	end
	
	if not (pedestals and useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.APOLLYON_CRISIS, "UseItem", "PlayerPickup")
	end

end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_ApollyonCrisis, wakaba.Enums.Collectibles.APOLLYON_CRISIS)

wakaba.BetterVoiding.ApollyonCrisis = BetterVoiding_ApollyonCrisis