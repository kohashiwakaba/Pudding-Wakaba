-- Modified Donation card code originally by Gateguy
-- Currently unused



wakaba.Enums.Cards.CARD_DONATION_CARD = Isaac.GetCardIdByName("Silver Donation Card")
wakaba.Enums.Cards.CARD_VIP_DONATION_CARD = Isaac.GetCardIdByName("VIP Donation Card")
local SilverCardChance = wakaba.state.silverchance
local VIPCardChance = wakaba.state.vipchance
local animation = "gfx/donationcarddrop.anm2"
local animation_vip = "gfx/donationcarddrop_vip.anm2"

local usedCardInThisRoom = false
local player
local isGreedMode
local numCoinsDonated
local oldNumCoinsDonated
local numCoins
local oldNumCoins

if EID then
	local t = ""
	t = t .. "Spawns/unjams a donation machine"
  EID:addCard(wakaba.Enums.Cards.CARD_DONATION_CARD, t)
	
	local p = ""
	p = p .. "Spawns/unjams a donation machine"
	p = p .. "#Spawns a penny which allows free coin donations for the current room"
  EID:addCard(wakaba.Enums.Cards.CARD_VIP_DONATION_CARD, p)
	
	if EIDKR then

		local tk = ""
		tk = tk .. "/머리/ 기부 기계를 소환합니다."
		tk = tk .. "/머리/ 기부 기계가 이미 존재할 경우 고장난 기부 기계를 되돌립니다."
		tk = tk .. "/머리/ 그리드 모드에서는 그리드 기계가 소환됩니다."
		EID:addCard(wakaba.Enums.Cards.CARD_DONATION_CARD, tk, "Silver Donation Card", "ko_kr", "은색 기부 카드")
		
		local pk = ""
		pk = pk .. "/머리/ 기부 기계를 소환합니다."
		pk = pk .. "/머리/ 기부 기계가 이미 존재할 경우 고장난 기부 기계를 되돌립니다."
		pk = pk .. "/머리/ 그리드 모드에서는 그리드 기계가 소환됩니다."
		pk = pk .. "/머리/ 동전 하나가 소환됩니다. 소환된 동전을 획득할 경우 무한정 기부할 수 있습니다."
		pk = pk .. "/머리/ 무한 기부는 다른 방으로 이동 시 해제됩니다."
		EID:addCard(wakaba.Enums.Cards.CARD_VIP_DONATION_CARD, pk, "VIP Donation Card", "ko_kr", "VIP 기부 카드")
	else
		local donationCardSprite = Sprite()
		donationCardSprite:Load("gfx/eid_cardfronts.anm2", true)
		EID:addIcon("Card"..wakaba.Enums.Cards.CARD_DONATION_CARD, "Cards", 0, 9, 9, -1, 0, donationCardSprite)
		EID:addIcon("Card"..wakaba.Enums.Cards.CARD_VIP_DONATION_CARD, "Cards", 1, 9, 9, -1, 0, donationCardSprite)
	end
	
end



function wakaba:onStart2001()
	player = Isaac.GetPlayer()
	isGreedMode = Game():IsGreedMode()
	numCoinsDonated = 0
	oldNumCoinsDonated = numCoinsDonated
	numCoins = player:GetNumCoins()
	oldNumCoins = numCoins

	if Game():GetFrameCount() == 0 then
		wakaba.state.totalNumCoinsDonated = 0
		wakaba.state.minDonationLimit = 0
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.onStart2001)



function wakaba:onUpdate2001()
	if usedCardInThisRoom then
		if isGreedMode and Game():GetLevel():GetStage() == 7 and Game():GetRoom():IsClear() then
			-- numCoinsDonated = Game():GetDonationModGreed() -- doesn't work in the API
			numCoins = player:GetNumCoins()
			if numCoins < oldNumCoins then
				numCoinsDonated = numCoinsDonated + (oldNumCoins - numCoins)
			end
		else
			numCoinsDonated = Game():GetDonationModAngel()
		end
		if numCoinsDonated > oldNumCoinsDonated then
			player:AddCoins(numCoinsDonated - oldNumCoinsDonated)
			wakaba.state.totalNumCoinsDonated = wakaba.state.totalNumCoinsDonated + (numCoinsDonated - oldNumCoinsDonated)
			checkForJam()
		end
		oldNumCoinsDonated = numCoinsDonated
		oldNumCoins = numCoins
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.onUpdate2001)

function wakaba:onUseCard2001(_, player, flags)
	-- Donate_____() doesn't actually donate; it just changes the amount the Game() thinks you "donated" on the current floor
	local newMachinePos = Isaac.GetFreeNearPosition(Vector(player.Position.X + 30, player.Position.Y - 30), 0)
	usedCardInThisRoom = true
	wakaba.state.minDonationLimit = wakaba.state.totalNumCoinsDonated + 5
	checkForJam()
	local donMachineInRoom = false
	local machineVariant = 8
	if isGreedMode then
		machineVariant = 11
	end
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_SLOT, machineVariant, -1, false, false)) do
		donMachineInRoom = true
		break
	end
	if not donMachineInRoom then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, newMachinePos, Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_SLOT, machineVariant, 0, newMachinePos, Vector(0,0), nil)
		SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2001, wakaba.Enums.Cards.CARD_DONATION_CARD)

function wakaba:onUseCardVIP2001(_, player, flags)
	-- Donate_____() doesn't actually donate; it just changes the amount the Game() thinks you "donated" on the current floor
	local newMachinePos = Isaac.GetFreeNearPosition(Vector(player.Position.X + 30, player.Position.Y - 30), 0)
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 1, Isaac.GetFreeNearPosition(Vector(player.Position.X + 20*math.random(-1,1), player.Position.Y + 20*math.random(-1,1)), 0), Vector(0,0), nil):ToPickup()
	usedCardInThisRoom = true
	wakaba.state.minDonationLimit = wakaba.state.totalNumCoinsDonated + 5
	checkForJam()
	local donMachineInRoom = false
	local machineVariant = 8
	if isGreedMode then
		machineVariant = 11
	end
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_SLOT, machineVariant, -1, false, false)) do
		donMachineInRoom = true
		break
	end
	if not donMachineInRoom then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, newMachinePos, Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_SLOT, machineVariant, 0, newMachinePos, Vector(0,0), nil)
		SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCardVIP2001, wakaba.Enums.Cards.CARD_VIP_DONATION_CARD)

function checkForJam()
	if (Game():GetStateFlag(GameStateFlag.STATE_DONATION_SLOT_JAMMED) or Game():GetStateFlag(GameStateFlag.STATE_GREED_SLOT_JAMMED)) and wakaba.state.totalNumCoinsDonated < wakaba.state.minDonationLimit then
		Game():SetStateFlag(GameStateFlag.STATE_DONATION_SLOT_JAMMED, false)
		Game():SetStateFlag(GameStateFlag.STATE_GREED_SLOT_JAMMED, false)
		local machineVariant = 8
		if isGreedMode then
			machineVariant = 11
		end
		for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_SLOT, machineVariant, -1, false, false)) do
			local machinePos = entity.Position
			entity:Remove()
			Isaac.Spawn(EntityType.ENTITY_SLOT, machineVariant, 0, machinePos, Vector(0,0), nil)
		end
	end
end

function wakaba:onNewRoom2001()
	usedCardInThisRoom = false

	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_SLOT, 8, -1, false, false)) do
		currRoomHasDonationMachine = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.onNewRoom2001)


function wakaba:onGetCard2001(rng, currentCard, playing, runes, onlyRunes)
	if not onlyRunes and currentCard ~= Card.CARD_CHAOS and currentCard ~= Card.CARD_HOLY_CARD and Game().Challenge == Challenge.CHALLENGE_NULL then
		local vipRandomInt = rng:RandomInt(VIPCardChance)
		local randomInt = rng:RandomInt(SilverCardChance)
		if wakaba.state.unlock.donationcard > 0 and vipRandomInt == 1 then
			return wakaba.Enums.Cards.CARD_VIP_DONATION_CARD
		elseif wakaba.state.unlock.donationcard < 1 and currentCard == wakaba.Enums.Cards.CARD_VIP_DONATION_CARD then
			return wakaba.Enums.Cards.CARD_DONATION_CARD
		elseif randomInt == 1 then
			return wakaba.Enums.Cards.CARD_DONATION_CARD
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_GET_CARD, wakaba.onGetCard2001)
