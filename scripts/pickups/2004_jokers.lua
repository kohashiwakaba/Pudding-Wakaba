local JokerChance = wakaba.state.silverchance
local origAngelChance = wakaba.state.angelchance
local rng = wakaba.RNG
local black = false
local white = false




function wakaba:onUseCard2004b(_, player, flags)
	local hasBeast = wakaba:HasBeast()
	if hasBeast then
		local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, false)
		newItemConfig = Isaac.GetItemConfig():GetCollectible(newItem)
		player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle")
		wakaba.G:GetHUD():ShowItemText(newItemConfig.Name, newItemConfig.Description, false)
		player:QueueItem(newItemConfig)
		SFXManager():Play(SoundEffect.SOUND_POWERUP1)
	else
		local level = wakaba.G:GetLevel()
		level:InitializeDevilAngelRoom(false,true)
		wakaba.G:StartRoomTransition(-1,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2004b, wakaba.Enums.Cards.CARD_BLACK_JOKER)
function wakaba:onUseCard2004w(_, player, flags)
	local hasBeast = wakaba:HasBeast()
	if hasBeast then
		local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL, false)
		newItemConfig = Isaac.GetItemConfig():GetCollectible(newItem)
		player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle")
		wakaba.G:GetHUD():ShowItemText(newItemConfig.Name, newItemConfig.Description, false)
		player:QueueItem(newItemConfig)
		SFXManager():Play(SoundEffect.SOUND_POWERUP1)
	else
		local level = wakaba.G:GetLevel()
		level:InitializeDevilAngelRoom(true,false)
		wakaba.G:StartRoomTransition(-1,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2004w, wakaba.Enums.Cards.CARD_WHITE_JOKER)
function wakaba:onUseCard2004c(_, player, flags)
	if player:GetBrokenHearts() ~= 6 then
		player:AddBrokenHearts(-(player:GetBrokenHearts()-6))
	end
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector(0,0), nil)
	for i = 1, 8 do
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.G:GetItemPool():GetCard(rng:Next(), false, true, false), Isaac.GetFreeNearPosition(Vector(player.Position.X + 30, player.Position.Y - 30), 0), Vector(0,0), nil)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2004c, wakaba.Enums.Cards.CARD_COLOR_JOKER)


function wakaba:onUpdate2004()
	local blackcount = 0
	local whitecount = 0
	local duality = false
  for i = 1, wakaba.G:GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		if pl:GetCard(0) == wakaba.Enums.Cards.CARD_BLACK_JOKER or pl:GetCard(1) == wakaba.Enums.Cards.CARD_BLACK_JOKER then
			blackcount = blackcount + 1
		end
		if pl:GetCard(0) == wakaba.Enums.Cards.CARD_WHITE_JOKER or pl:GetCard(1) == wakaba.Enums.Cards.CARD_WHITE_JOKER then
			whitecount = whitecount + 1
		end
		if pl:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then
			duality = true
		end
	end
	
	if blackcount > 0 then black = true else black = false end
	if whitecount > 0 then white = true else white = false end

	if not duality then
		if black and not white then
			--[[ if wakaba.G:GetDevilRoomDeals() < 1 then
				wakaba.G:AddDevilRoomDeal()
			end ]]
			if wakaba.G:GetLevel():GetAngelRoomChance() > 0 then
				wakaba.G:GetLevel():AddAngelRoomChance(-wakaba.G:GetLevel():GetAngelRoomChance())
			end
		elseif white and not black then
			if wakaba.G:GetLevel():GetAngelRoomChance() < 1 then
				wakaba.G:GetLevel():AddAngelRoomChance(1 - wakaba.G:GetLevel():GetAngelRoomChance())
			end
		end
	end

end
--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.onUpdate2004)

function wakaba:onGetCard2004(rng, currentCard, playing, runes, onlyRunes)
	if not onlyRunes and currentCard == wakaba.Enums.Cards.CARD_BLACK_JOKER then
		if wakaba.state.unlock.blackjoker < 1 then
			return Card.CARD_JOKER
		end
	elseif not onlyRunes and currentCard == wakaba.Enums.Cards.CARD_WHITE_JOKER then
		if wakaba.state.unlock.whitejoker < 1 then
			return Card.CARD_JOKER
		end
	elseif not onlyRunes and currentCard == wakaba.Enums.Cards.CARD_COLOR_JOKER then
		if wakaba.state.unlock.colorjoker < 1 then
			return Card.CARD_JOKER
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_CARD, wakaba.onGetCard2004)


function wakaba:openJokerDevilAngelRoom(rng, pos)
	if wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSS
	and wakaba.G:GetLevel():CanSpawnDevilRoom() then
		if not white and black then
			wakaba.G:GetLevel():InitializeDevilAngelRoom(false, true)
			--print("devil room")
		elseif white and not black then
			wakaba.G:GetLevel():InitializeDevilAngelRoom(true, false)
			--print("angel room")
		end
	end
	
end
--wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.openJokerDevilAngelRoom)
