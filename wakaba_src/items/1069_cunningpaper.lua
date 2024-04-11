local isc = require("wakaba_src.libs.isaacscript-common")

local cunning_data = {
	run = {

	},
}
wakaba:saveDataManager("PnW_CunningPaper", cunning_data)

local cunningCard = cunning_data.run
wakaba.cunningPaperData = cunningCard

function wakaba:PlayerUpdate_CunningPaper(player)
	local playerIndex = isc:getPlayerIndex(player)
	if not cunningCard[playerIndex] or cunningCard[playerIndex] == Card.CARD_QUESTIONMARK then
		local itemPool = wakaba.G:GetItemPool()
		local seeds = wakaba.G:GetSeeds()
		local startSeed = seeds:GetStartSeed()
		local rng = RNG()
		rng:SetSeed(startSeed, 35)
		cunning_data.run[playerIndex] = itemPool:GetCard(rng:GetSeed(),false, false, false)
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
		cunning_data.run[playerIndex] = newCard
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_CunningPaper, wakaba.Enums.Collectibles.CUNNING_PAPER)

