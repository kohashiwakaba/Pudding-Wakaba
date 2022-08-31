wakaba.CARD_BLACK_JOKER = Isaac.GetCardIdByName("wakaba_Black Joker")
wakaba.CARD_WHITE_JOKER = Isaac.GetCardIdByName("wakaba_White Joker")
wakaba.CARD_COLOR_JOKER = Isaac.GetCardIdByName("wakaba_Color Joker")
local JokerChance = wakaba.state.silverchance
local origAngelChance = wakaba.state.angelchance
local rng = wakaba.RNG
local black = false
local white = false




function wakaba:onUseCard2004b(_, player, flags)
	local hasBeast = wakaba:HasBeast()
	if hasBeast then
		local newItem = Game():GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, false)
		newItemConfig = Isaac.GetItemConfig():GetCollectible(newItem)
		player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle")
		Game():GetHUD():ShowItemText(newItemConfig.Name, newItemConfig.Description, false)
		player:QueueItem(newItemConfig)
		SFXManager():Play(SoundEffect.SOUND_POWERUP1)
	else
		local level = Game():GetLevel()
		level:InitializeDevilAngelRoom(false,true)
		Game():StartRoomTransition(-1,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2004b, wakaba.CARD_BLACK_JOKER)
function wakaba:onUseCard2004w(_, player, flags)
	local hasBeast = wakaba:HasBeast()
	if hasBeast then
		local newItem = Game():GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL, false)
		newItemConfig = Isaac.GetItemConfig():GetCollectible(newItem)
		player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle")
		Game():GetHUD():ShowItemText(newItemConfig.Name, newItemConfig.Description, false)
		player:QueueItem(newItemConfig)
		SFXManager():Play(SoundEffect.SOUND_POWERUP1)
	else
		local level = Game():GetLevel()
		level:InitializeDevilAngelRoom(true,false)
		Game():StartRoomTransition(-1,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2004w, wakaba.CARD_WHITE_JOKER)
function wakaba:onUseCard2004c(_, player, flags)
	if player:GetBrokenHearts() ~= 6 then
		player:AddBrokenHearts(-(player:GetBrokenHearts()-6))
	end
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, Game():GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, Game():GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, Game():GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector(0,0), nil)
	for i = 1, 8 do
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Game():GetItemPool():GetCard(rng:Next(), false, true, false), Isaac.GetFreeNearPosition(Vector(player.Position.X + 30, player.Position.Y - 30), 0), Vector(0,0), nil)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2004c, wakaba.CARD_COLOR_JOKER)


function wakaba:onUpdate2004()
	local blackcount = 0
	local whitecount = 0
	local duality = false
  for i = 1, Game():GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		if pl:GetCard(0) == wakaba.CARD_BLACK_JOKER or pl:GetCard(1) == wakaba.CARD_BLACK_JOKER then
			blackcount = blackcount + 1
		end
		if pl:GetCard(0) == wakaba.CARD_WHITE_JOKER or pl:GetCard(1) == wakaba.CARD_WHITE_JOKER then
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
			--[[ if Game():GetDevilRoomDeals() < 1 then
				Game():AddDevilRoomDeal()
			end ]]
			if Game():GetLevel():GetAngelRoomChance() > 0 then
				Game():GetLevel():AddAngelRoomChance(-Game():GetLevel():GetAngelRoomChance())
			end
		elseif white and not black then
			if Game():GetLevel():GetAngelRoomChance() < 1 then
				Game():GetLevel():AddAngelRoomChance(1 - Game():GetLevel():GetAngelRoomChance())
			end
		end
	end

end
--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.onUpdate2004)

function wakaba:onGetCard2004(rng, currentCard, playing, runes, onlyRunes)
	if not onlyRunes and currentCard == wakaba.CARD_BLACK_JOKER then
		if wakaba.state.unlock.blackjoker < 1 then
			return Card.CARD_JOKER
		end
	elseif not onlyRunes and currentCard == wakaba.CARD_WHITE_JOKER then
		if wakaba.state.unlock.whitejoker < 1 then
			return Card.CARD_JOKER
		end
	elseif not onlyRunes and currentCard == wakaba.CARD_COLOR_JOKER then
		if wakaba.state.unlock.colorjoker < 1 then
			return Card.CARD_JOKER
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_CARD, wakaba.onGetCard2004)


function wakaba:openJokerDevilAngelRoom(rng, pos)
	if Game():GetRoom():GetType() == RoomType.ROOM_BOSS
	and Game():GetLevel():CanSpawnDevilRoom() then
		if not white and black then
			Game():GetLevel():InitializeDevilAngelRoom(false, true)
			--print("devil room")
		elseif white and not black then
			Game():GetLevel():InitializeDevilAngelRoom(true, false)
			--print("angel room")
		end
	end
	
end
--wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.openJokerDevilAngelRoom)
