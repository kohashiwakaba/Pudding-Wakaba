--[[
	Sweets Catalog (달콤달콤 카탈로그) - 액티브(Active / 6 rooms)
	리셰로 Isaac 처치
	사용 시 그 방에서 특정 무기 적용
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")
local collectible = wakaba.Enums.Collectibles.SWEETS_CATALOG
wakaba.HiddenItemManager:HideCostumes("RICHER_CATALOG2")

local pending_collectibles = {}
local last_type
local last_collectible
local last_success

wakaba.CatalogItems = {
	["TEMP"] = {
		Weight = 0, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_C_SECTION,
		},
		MainItem = CollectibleType.COLLECTIBLE_C_SECTION,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = false,
	},
	["KNIFE"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_MOMS_KNIFE,
		},
		MainItem = CollectibleType.COLLECTIBLE_MOMS_KNIFE,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["SPIRIT"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_SPIRIT_SWORD,
		},
		MainItem = CollectibleType.COLLECTIBLE_SPIRIT_SWORD,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["BRIM"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_BRIMSTONE,
			CollectibleType.COLLECTIBLE_BRIMSTONE,
		},
		MainItem = CollectibleType.COLLECTIBLE_BRIMSTONE,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["TECH"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_TECHNOLOGY,
		},
		MainItem = CollectibleType.COLLECTIBLE_TECHNOLOGY,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["FETUS"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_DR_FETUS,
		},
		MainItem = CollectibleType.COLLECTIBLE_DR_FETUS,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["EPIC"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_EPIC_FETUS,
		},
		MainItem = CollectibleType.COLLECTIBLE_EPIC_FETUS,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["SECTION"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_C_SECTION,
		},
		MainItem = CollectibleType.COLLECTIBLE_C_SECTION,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
	["RING"] = {
		Weight = 1, -- Chance to be appeared, set to 0 to prevent to be chosen
		Items = {
			CollectibleType.COLLECTIBLE_TECH_X,
		},
		MainItem = CollectibleType.COLLECTIBLE_TECH_X,
		Reserve = 0, -- reserve charges on use,
		RicherRecipe = true,
	},
}
local function TryCancelCatalog(player)
	local playerIndex = isc:getPlayerIndex(player)
	if player:GetData().wakaba.usingCatalog then
		player:GetData().wakaba.usingCatalog = false
		player:AnimateCollectible(collectible, "HideItem", "PlayerPickup")
	end
	if pending_collectibles[playerIndex] then
		pending_collectibles[playerIndex] = nil
	end
	if EID then
		EID:hidePermanentText()
	end
end

function wakaba:ItemUse_SweetsCatalog(_, rng, player, useFlags, activeSlot, varData)
	local playerIndex = isc:getPlayerIndex(player)
	local previewItem = wakaba.Enums.Collectibles.SWEETS_CATALOG

	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_EVEN and useFlags & UseFlag.USE_OWNED > 0 then
		if useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY then return end
		if not player:GetData().wakaba.usingCatalog then
			local collectibles = isc:getEntities(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
			local nearest = isc:getClosestEntityTo(player, collectibles, function(_, e) return not isc:isQuestCollectible(e.SubType) end)
			if nearest then
				player:GetData().wakaba.usingCatalog = true -- VERY IMPORTANT! Make the name of your GetData something more specific than "wakaba.usingCatalog" so that other mods don't overwrite it!!
				player:GetData().throwableActiveSlot = activeSlot -- store what slot the active item was used from (primary, secondary, or pocket?)
				player:AnimateCollectible(collectible, "LiftItem", "PlayerPickup")

				pending_collectibles[playerIndex] = nearest
			else
				player:AnimateSad()
			end
		else
			TryCancelCatalog(player)
		end
		return {Discharge = false, Remove = false, ShowAnim = false} -- stops the item from discharging unless something actually shoots out
	else
		if useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY then
			return
		end
		-- get random
		local catalog = wakaba.CatalogItems
		local totalweight = 0
		local tempCatalog = {}
		for k, v in pairs(catalog) do
			if v.Weight then
				v.Name = k
				totalweight = totalweight + v.Weight
				v.Range = totalweight
				table.insert(tempCatalog, v)
			end
		end

		local chosenVal = ""
		local prevRange = 0
		local val = rng:RandomFloat() * totalweight
		for i, v in ipairs(tempCatalog) do
			--print("calculating:",prevRange,"[",val,"]",v.Range,"/",totalweight,"max",v.Name)
			if val >= prevRange and val < v.Range then
				chosenVal = v.Name

				--print(chosenVal.." chosen, ranged", prevRange, "to", v.Range, "val:", val)
				break
			end
			prevRange = v.Range
		end
		--print("chosenVal:",chosenVal)


		if wakaba.CatalogItems[chosenVal] then
			previewItem = wakaba.CatalogItems[chosenVal].MainItem
			--print("CatalogItems found for:",chosenVal)
			wakaba.HiddenItemManager:Add(player, 1, -1, 1, "RICHER_CATALOG2")
			if wakaba.HiddenItemManager:GetStacks(player, "RICHER_CATALOG2") then
				wakaba.HiddenItemManager:RemoveAll(player, "RICHER_CATALOG2")
			end
			if player:GetPlayerType() == wakaba.Enums.Players.RICHER and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				for i, itemID in ipairs(wakaba.CatalogItems[chosenVal].Items) do
					wakaba.HiddenItemManager:Add(player, itemID, -1, 1, "RICHER_CATALOG2")
				end
			else
				for i, itemID in ipairs(wakaba.CatalogItems[chosenVal].Items) do
					wakaba.HiddenItemManager:AddForRoom(player, itemID, -1, 1, "RICHER_CATALOG2")
				end
			end
		end
	end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(previewItem or wakaba.Enums.Collectibles.SWEETS_CATALOG, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_SweetsCatalog, wakaba.Enums.Collectibles.SWEETS_CATALOG)

function wakaba:PlayerRender_Catalog(player)
	wakaba:GetPlayerEntityData(player)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.PlayerRender_Catalog)


function wakaba:PlayerUpdate_Catalog(player) -- Trigger throwable active upon shooting
	if player:GetData().wakaba.usingCatalog and player:GetFireDirection() ~= Direction.NO_DIRECTION then
		player:GetData().wakaba.usingCatalog = false
		local direction = player:GetFireDirection()
		if wakaba.G:GetRoom():IsMirrorWorld() then
			if direction == Direction.LEFT then
				direction = Direction.RIGHT
			elseif direction == Direction.RIGHT then
				direction = Direction.LEFT
			end
		end

		-- PLACE THE ACTUAL EFFECT OF YOUR THROWABLE ACTIVE HERE --
		local playerIndex = isc:getPlayerIndex(player)
		local pending = pending_collectibles[playerIndex]
		local quality = isc:getCollectibleQuality(pending.SubType)
		last_collectible = pending.SubType
		if direction == Direction.LEFT or direction == Direction.UP then
			last_type = 1
			if quality == 1 or quality == 3 then
				last_success = true
				SFXManager():Play(SoundEffect.SOUND_POWERUP3)
				player:AddCollectible(pending.SubType)
				wakaba:DisplayHUDItemText(player, "collectibles", pending.SubType)
				player:AnimateCollectible(pending.SubType, "Pickup", "PlayerPickupSparkle")
			else
				last_success = false
				player:AnimateSad()
			end
		elseif direction == Direction.RIGHT or direction == Direction.DOWN then
			last_type = 2
			if quality == 2 or quality == 4 then
				last_success = true
				SFXManager():Play(SoundEffect.SOUND_POWERUP3)
				player:AddCollectible(pending.SubType)
				wakaba:DisplayHUDItemText(player, "collectibles", pending.SubType)
				player:AnimateCollectible(pending.SubType, "Pickup", "PlayerPickupSparkle")
			else
				last_success = false
				player:AnimateSad()
			end
		end
		if pending and pending:Exists() then
			pending:ToPickup().OptionsPickupIndex = 720
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pending.Position, Vector.Zero, nil)
			pending:Remove()
		end

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
		--player:DischargeActiveItem(slot) -- Since the item was used successfully, actually discharge the item
		--player:AnimateCollectible(collectible, "HideItem", "PlayerPickup")

		-- prevent other players still holding catalog
		for num = 1, wakaba.G:GetNumPlayers() do
			local pl = wakaba.G:GetPlayer(num - 1)
			TryCancelCatalog(pl)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Catalog)

function wakaba:PostTakeDamage_Catalog(player, _, _, _, _) -- Terminate the holding up of your throwable active upon taking damage. This function can be omitted if you want, but I added it to be closer to vanilla behavior.
	TryCancelCatalog(player)
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_Catalog)

function wakaba:NewRoom_Catalog() -- Terminate the holding up of your throwable active upon entering a new room. This function can also be omitted if you want.
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		TryCancelCatalog(player)
	end
	last_type = nil
	last_collectible = nil
	last_success = nil
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Catalog)

if EID then
	local function EvenOddCondition(descObj)
		return wakaba.G.Challenge == wakaba.challenges.CHALLENGE_EVEN
			and descObj.ObjType == 5
			and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE
			and descObj.ObjSubType == wakaba.Enums.Collectibles.SWEETS_CATALOG
	end
	local function EvenOddCallback(descObj)
		descObj.Description = EID:getDescriptionEntry("SweetsChallenge")
		return descObj
	end
	EID:addDescriptionModifier("Wakaba Challenge Even Odd", EvenOddCondition, EvenOddCallback)
end

function wakaba:Render_Catalog()
	local hasCatalog = false
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetData().wakaba and player:GetData().wakaba.usingCatalog then
			hasCatalog = true
			break
		end
	end
	if hasCatalog then
		local demoDescObj = EID:getDescriptionObj(5, 100, wakaba.Enums.Collectibles.SWEETS_CATALOG)
		demoDescObj.Description = EID:getDescriptionEntry("SweetsFlipFlop")
		EID:displayPermanentText(demoDescObj)
	elseif last_collectible and last_type and last_success ~= nil then
		local demoDescObj = EID:getDescriptionObj(5, 100, last_collectible)
		local qtext = ""
		local text = "{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}} "
		if last_type == 1 then
			qtext = "{{Quality1}}or{{Quality3}}"
		elseif last_type == 2 then
			qtext = "{{Quality2}}or{{Quality4}}"
		end
		if last_success == true then
			text = text .. EID:getDescriptionEntry("SweetsChallengeSuccess") .. qtext .. "={{Quality" .. isc:getCollectibleQuality(last_collectible) .. "}}{{CR}}"
		elseif last_success == false then
			text = text .. EID:getDescriptionEntry("SweetsChallengeFailed") .. qtext .. "≠{{Quality" .. isc:getCollectibleQuality(last_collectible) .. "}}{{CR}}"
		end
		demoDescObj.Description = text .. "#" .. demoDescObj.Description
		EID:displayPermanentText(demoDescObj)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_Catalog)