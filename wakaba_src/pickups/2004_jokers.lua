local rng = wakaba.RNG
local isc = require("wakaba_src.libs.isaacscript-common")


function wakaba:UseCard_BlackJoker(_, player, flags)
	local hasBeast = wakaba:HasBeast()
	if hasBeast then
		local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, false)
		newItemConfig = Isaac.GetItemConfig():GetCollectible(newItem)
		player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle")
		wakaba:DisplayHUDItemText(player, "collectibles", newItem)
		player:QueueItem(newItemConfig)
		SFXManager():Play(SoundEffect.SOUND_POWERUP1)
	else
		local level = wakaba.G:GetLevel()
		level:InitializeDevilAngelRoom(false,true)
		wakaba.G:StartRoomTransition(-1,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_BlackJoker, wakaba.Enums.Cards.CARD_BLACK_JOKER)

function wakaba:UseCard_WhiteJoker(_, player, flags)
	local hasBeast = wakaba:HasBeast()
	if hasBeast then
		local newItem = wakaba.G:GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL, false)
		newItemConfig = Isaac.GetItemConfig():GetCollectible(newItem)
		player:AnimateCollectible(newItem, "Pickup", "PlayerPickupSparkle")
		wakaba:DisplayHUDItemText(player, "collectibles", newItem)
		player:QueueItem(newItemConfig)
		SFXManager():Play(SoundEffect.SOUND_POWERUP1)
	else
		local level = wakaba.G:GetLevel()
		level:InitializeDevilAngelRoom(true,false)
		wakaba.G:StartRoomTransition(-1,Direction.NO_DIRECTION,RoomTransitionAnim.TELEPORT,nil,-1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_WhiteJoker, wakaba.Enums.Cards.CARD_WHITE_JOKER)

function wakaba:UseCard_ColorJoker(_, player, flags)
	local targetBrokenHearts = ((player:GetHeartLimit() // 2) + player:GetBrokenHearts()) // 2
	if wakaba:IsLunatic() then
		player:AddBrokenHearts((player:GetHeartLimit() + player:GetBrokenHearts()) // 2)
	else
		if player:GetBrokenHearts() ~= targetBrokenHearts then
			player:AddBrokenHearts(-(player:GetBrokenHearts()-targetBrokenHearts))
		end
	end
	local s = wakaba.G:GetRoom():GetSpawnSeed()
	wakaba.G:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, nil, 0, s):ToPickup()
	wakaba.G:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, nil, 0, s):ToPickup()
	wakaba.G:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, wakaba.G:GetRoom():FindFreePickupSpawnPosition(player.Position, 40, true), Vector.Zero, nil, 0, s):ToPickup()
	for i = 1, 8 do
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.G:GetItemPool():GetCard(rng:Next(), false, true, false), Isaac.GetFreeNearPosition(Vector(player.Position.X + 30, player.Position.Y - 30), 0), Vector(0,0), nil)
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_ColorJoker, wakaba.Enums.Cards.CARD_COLOR_JOKER)
