local isc = require("wakaba_src.libs.isaacscript-common")

local richer_saved_recipies = {
	run = {

	},
}
wakaba:saveDataManager("PnW_CunningPaper", richer_saved_recipies)

local cunningCard = richer_saved_recipies.run

function wakaba:PlayerUpdate_CunningPaper(player)
	local playerIndex = isc:getPlayerIndex(player)
	if not cunningCard[playerIndex] or cunningCard[playerIndex] == Card.CARD_QUESTIONMARK then
		local itemPool = wakaba.G:GetItemPool()
		local seeds = wakaba.G:GetSeeds()
		local startSeed = seeds:GetStartSeed()
		local rng = RNG()
		rng:SetSeed(startSeed, 35)
		cunningCard[playerIndex] = itemPool:GetCard(rng:GetSeed(),false, false, false)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_CunningPaper)

local savedCard = nil

function wakaba:ItemUse_CunningPaper(item, rng, player, useFlags, activeSlot, varData)
	local playerIndex = isc:getPlayerIndex(player)
	local itemPool = wakaba.G:GetItemPool()
	local card = cunningCard[playerIndex]
	if useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY then
		player:UseCard(savedCard, UseFlag.USE_NOANNOUNCER | UseFlag.USE_CARBATTERY | UseFlag.USE_MIMIC | UseFlag.USE_NOHUD)
	else
		if card ~= Card.CARD_QUESTIONMARK then
			savedCard = cunningCard[playerIndex]
			player:UseCard(cunningCard[playerIndex], UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
		end
		local newCard = itemPool:GetCard(player:GetCollectibleRNG(wakaba.Enums.Collectibles.CUNNING_PAPER):Next(), false, false, false)
		cunningCard[playerIndex] = newCard
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_CunningPaper, wakaba.Enums.Collectibles.CUNNING_PAPER)

if EID then
	local function CunningPaperCondition(descObj)
		if not EID.InsideItemReminder then return false end
		if EID.holdTabPlayer == nil then return false end
		return descObj.ObjType == 5 and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE and descObj.ObjSubType == wakaba.Enums.Collectibles.CUNNING_PAPER
	end
	local function CunningPaperCallback(descObj)
		local player = EID.holdTabPlayer
		local playerIndex = isc:getPlayerIndex(player)
		local card = cunningCard[playerIndex]
		local demoDescObj = EID:getDescriptionObj(5, 300, card)
		descObj.Name = "{{Card"..card.."}} ".. demoDescObj.Name
		descObj.Description = demoDescObj.Description
		return descObj
	end
	EID:addDescriptionModifier("Wakaba Cunning Paper", CunningPaperCondition, CunningPaperCallback)
end
