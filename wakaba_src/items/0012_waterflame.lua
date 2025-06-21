local isc = _wakaba.isc
local collectible = wakaba.Enums.Collectibles.WATER_FLAME

local flames = {}

local wandSprite = Sprite()
wandSprite:Load("gfx/ui/wakaba/waterflame_mask.anm2", false)
wandSprite:ReplaceSpritesheet(0, "gfx/ui/wakaba/empty_placeholder.png")
wandSprite:LoadGraphics()
wandSprite:Play("Idle", true)

local function canDisplayWaterFlame(player)
	local playerIndex = isc:getPlayerIndex(player)
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
		local current = wakaba.TotalWisps[playerIndex]
		if current and #current.list > 0 then
			local wisp = current.list[current.index]
			itemID = wisp.SubType
			return itemID
		end
	else
		local collectibles = isc:getEntities(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
		local nearest = isc:getClosestEntityTo(player, collectibles, function(_, e) return isc:collectibleHasTag(e.SubType, ItemConfig.TAG_SUMMONABLE) end)
		return nearest and nearest.SubType
	end
end

wakaba:addActiveRender({
	Sprite = wandSprite,
	Offset = Vector(16, 30),
	RenderAbove = true,
	Condition = function(player, activeSlot)
		local data = player:GetData().wakaba
		local item = player:GetActiveItem(activeSlot)
		if item ~= wakaba.Enums.Collectibles.WATER_FLAME then return false end

		return canDisplayWaterFlame(player) ~= nil and not player:HasCurseMistEffect()
	end,
	Update = function(player, slot, data)
		local playerIndex = isc:getPlayerIndex(player)
		if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
			local current = wakaba.TotalWisps[playerIndex]
			if #current.list > 0 then
				local wisp = current.list[current.index]
				itemID = wisp.SubType
				local conf = Isaac.GetItemConfig():GetCollectible(itemID)
				if conf then
					local spr = data.Sprite
					spr:ReplaceSpritesheet(0, conf.GfxFileName)
					spr:LoadGraphics()
				end
			end
		else
			local collectibles = isc:getEntities(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
			local nearest = isc:getClosestEntityTo(player, collectibles, function(_, e) return isc:collectibleHasTag(e.SubType, ItemConfig.TAG_SUMMONABLE) end)
			if nearest then
				local conf = Isaac.GetItemConfig():GetCollectible(nearest.SubType)
				if conf then
					local spr = data.Sprite
					spr:ReplaceSpritesheet(0, conf.GfxFileName)
					spr:LoadGraphics()
				end
			end
		end
	end,
})

function wakaba:hasWaterFlame(player)
	if not player then
		return false
	end
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.WATER_FLAME) then
		return true
	else
		return false
	end
end

local recent

function wakaba:ItemUse_WaterFlame(_, rng, player, useFlags, activeSlot, varData)
	local discharge = false
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
		local playerIndex = isc:getPlayerIndex(player)
		local current = wakaba.TotalWisps[playerIndex]
		if #current.list == 0 then
			player:AnimateSad()
			return {
				Discharge = false,
				Remove = false,
				ShowAnim = false,
			}
		end
		if useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY then

		else
			local wisp = current.list[current.index]
			recent = wisp.SubType
			wisp:Kill()
		end

		if recent then
			if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_SSRC then
				wakaba:addPlayerDataCounter(player, "flamecnt", -1)
			end
			SFXManager():Play(SoundEffect.SOUND_POWERUP1)
			player:AddCollectible(recent)
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and useFlags & UseFlag.USE_CARBATTERY ~= UseFlag.USE_CARBATTERY then
				player:AddCollectible(recent)
			end
			wakaba:DisplayHUDItemText(player, "collectibles", recent)
			player:AnimateCollectible(recent, "Pickup", "PlayerPickupSparkle")
		end

	else
		local collectibles = isc:getEntities(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
		local nearest = isc:getClosestEntityTo(player, collectibles, function(_, e) return isc:collectibleHasTag(e.SubType, ItemConfig.TAG_SUMMONABLE) end)
		if nearest then
			SFXManager():Play(SoundEffect.SOUND_POWERUP1)
			--player:AddCollectible(nearest.SubType)
			wakaba:DisplayHUDItemText(player, "collectibles", nearest.SubType)
			--player:AnimateCollectible(nearest.SubType, "Pickup", "PlayerPickupSparkle")

			player:AddItemWisp(nearest.SubType, player.Position, true)
			player:AddItemWisp(nearest.SubType, player.Position, true)
			player:AnimateCollectible(nearest.SubType, "HideItem", "PlayerPickup")
		else
			player:AnimateSad()
			return {
				Discharge = false,
				Remove = false,
				ShowAnim = false,
			}
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_WaterFlame, wakaba.Enums.Collectibles.WATER_FLAME)


if EID then
	local function WFCondition(descObj)
		if not EID.InsideItemReminder then return false end
		if EID.holdTabPlayer == nil then return false end
		if EID.holdTabPlayer:GetPlayerType() ~= wakaba.Enums.Players.RICHER_B then return false end
		return descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and descObj.ObjSubType == wakaba.Enums.Collectibles.WATER_FLAME
	end
	local function WFCallback(descObj)
		local player = EID.holdTabPlayer
		local wfstr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].waterflame) or wakaba.descriptions["en"].waterflame
		local eidstring = ""

		local playerIndex = isc:getPlayerIndex(player)
		local current = wakaba.TotalWisps[playerIndex]
		if #current.list > 0 then
			local wisp = current.list[current.index]
			itemID = wisp.SubType
			local demoDescObj = EID:getDescriptionObj(5, 100, itemID)
			if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_SSRC then
				if wakaba:getPlayerDataEntry(player, "flamecnt", 0) == 0 then
					descObj.Description = "{{ColorError}}"..wfstr.supersensitivefinal
				else
					descObj.Name = "{{ColorOrange}}"..wfstr.supersensitiveprefix.. wakaba:getPlayerDataEntry(player, "flamecnt", 0) .. " >{{ColorEIDObjName}}".. "{{Collectible"..itemID.."}} " .. demoDescObj.Name
					descObj.Description = demoDescObj.Description
				end
			else
				descObj.Name = wfstr.titleprefix .. " >".. "{{Collectible"..itemID.."}} " .. demoDescObj.Name
				descObj.Description = demoDescObj.Description
			end
		else
			descObj.Description = wfstr.taintedricher
			if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_SSRC then
				if wakaba:getPlayerDataEntry(player, "flamecnt", 0) == 0 then
					descObj.Description = "{{ColorError}}"..wfstr.supersensitivefinal
				else
					descObj.Description = descObj.Description .. "#{{ColorOrange}}"..wfstr.supersensitiveprefix..wakaba:getPlayerDataEntry(player, "flamecnt", 0).."{{CR}}"
				end
			end
		end
		return descObj
	end

	EID:addDescriptionModifier("Tainted Richer Water-Flame", WFCondition, WFCallback)
end