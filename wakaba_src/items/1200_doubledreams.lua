local isc = require("wakaba_src.libs.isaacscript-common")
--wakaba.f:DrawString("droid",60,50,KColor(1,1,1,1,0,0,0),0,true) -- render string with loaded font on position 60x50y
wakaba.ItemPoolType = {
	ItemPoolType.POOL_NULL,
	ItemPoolType.POOL_TREASURE ,
	ItemPoolType.POOL_SHOP ,
	ItemPoolType.POOL_BOSS,
	ItemPoolType.POOL_DEVIL ,
	ItemPoolType.POOL_ANGEL,
	ItemPoolType.POOL_SECRET,
	ItemPoolType.POOL_LIBRARY,
	ItemPoolType.POOL_GOLDEN_CHEST,
	ItemPoolType.POOL_RED_CHEST,
	ItemPoolType.POOL_CURSE ,
	ItemPoolType.POOL_CRANE_GAME ,
	ItemPoolType.POOL_PLANETARIUM ,
	ItemPoolType.POOL_BABY_SHOP ,
	24 , -- Ultra secret
}
wakaba.ItemPoolRoomType = {
	RoomType.ROOM_TREASURE,
	RoomType.ROOM_TREASURE ,
	RoomType.ROOM_SHOP ,
	RoomType.ROOM_BOSS,
	RoomType.ROOM_DEVIL ,
	RoomType.ROOM_ANGEL,
	RoomType.ROOM_SECRET,
	RoomType.ROOM_LIBRARY,
	RoomType.ROOM_CHEST,
	RoomType.ROOM_CURSE,
	RoomType.ROOM_CURSE ,
	RoomType.ROOM_CHEST ,
	RoomType.ROOM_PLANETARIUM ,
	RoomType.ROOM_SHOP ,
	RoomType.ROOM_ULTRASECRET ,
}
wakaba.ItemPoolName = {
	"Kohashi Wakaba - Default Pool",
	"Isaac Wakaba - Treasure Pool",
	"Greed Wakaba - Shop Pool",
	"Bully Wakaba - Boss Pool",
	"Sixth Wakaba - Devil Pool",
	"Halo Wakaba - Angel Pool",
	"Hidden Wakaba - Secret Pool",
	"Book Worm Wakaba - Library Pool",
	"Polaroid Wakaba - Valut/Golden Chest Pool",
	"Negative Wakaba - Red Chest Pool",
	"Cursed Wakaba - Curse Pool",
	"Gambler Wakaba - Crane Game Pool",
	"Solar Wakaba - Planetarium Pool",
	"Baby Wakaba - Baby Shop Pool",
	"Clare Wakaba - Ultra Secret Pool"
}


-- return the first integer index holding the value 
function AnIndexOf(t,val)
    for k,v in ipairs(t) do 
        if v == val then return k end
    end
end

function wakaba:GetNextPool(current)
	current = current + 1
	for i = current, #wakaba.ItemPoolType do
		local nextval = wakaba.ItemPoolType[i]
		if nextval ~= nil then return nextval end
	end
	return wakaba.ItemPoolType[1]
end


function wakaba:renderDreams()
	wakaba.hasdreams = false
  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS) then
			wakaba.hasdreams = true
		end
	end
	
	if wakaba.hasdreams
	and wakaba.G:GetHUD():IsVisible()
	then
		local ypos = 10
		local list = wakaba.ItemPoolType
		local pooltype = wakaba.runstate.dreampool
		local current = AnIndexOf(list, wakaba.runstate.dreampool)
		local poolname = wakaba.ItemPoolName[current]
		if wakaba.G:GetLevel():GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN == LevelCurse.CURSE_OF_THE_UNKNOWN then
			wakaba.f:DrawString("???", 20 - wakaba.G.ScreenShakeOffset.X, 5 - wakaba.G.ScreenShakeOffset.Y ,KColor(1,1,1,1,0,0,0),0,true)
		else
			wakaba.f:DrawString(pooltype .. " " .. poolname, 20 - wakaba.G.ScreenShakeOffset.X, 5 - wakaba.G.ScreenShakeOffset.Y ,KColor(1,1,1,1,0,0,0),0,true)
		end
		
		--Isaac.RenderText("Sample text", 155, 20, 1, 1, 1, 255)
	end
	if not wakaba.hasdreams then
		wakaba.runstate.dreampool = ItemPoolType.POOL_NULL
	end
	
	
end

wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.renderDreams)

function wakaba:ItemUse_Dreams(_, rng, player, useFlags, activeSlot, varData)
	if (useFlags & UseFlag.USE_OWNED == UseFlag.USE_OWNED)
	and not (useFlags & UseFlag.USE_VOID == UseFlag.USE_VOID) then
		local list = wakaba.ItemPoolType
		local current = AnIndexOf(list, wakaba.runstate.dreampool)
		wakaba.runstate.dreampool = wakaba:GetNextPool(current)
		wakaba.runstate.dreamroom = wakaba.ItemPoolRoomType[AnIndexOf(list, wakaba.runstate.dreampool)]
		SFXManager():Play(SoundEffect.SOUND_MIRROR_ENTER)
		SFXManager():Play(SoundEffect.SOUND_MIRROR_EXIT)
	else
		local dreamcard = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_DREAM_CARD, Isaac.GetFreeNearPosition(player.Position, 0.0), Vector(0,0), nil):ToPickup()
	end
	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS, "UseItem", "PlayerPickup")
	end
	return {Discharge = false}
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Dreams, wakaba.Enums.Collectibles.DOUBLE_DREAMS)


function wakaba:dreamsUpdate(player)
	if wakaba.hasdreams then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_CHAOS, true) then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_CHAOS)
			local dreamcard = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_DREAM_CARD, Isaac.GetFreeNearPosition(player.Position, 0.0), Vector(0,0), nil):ToPickup()
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_GOAT_HEAD, true) then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_GOAT_HEAD)
			local dreamcard = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_DREAM_CARD, Isaac.GetFreeNearPosition(player.Position, 0.0), Vector(0,0), nil):ToPickup()
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_EUCHARIST, true) then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_EUCHARIST)
			local dreamcard = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_DREAM_CARD, Isaac.GetFreeNearPosition(player.Position, 0.0), Vector(0,0), nil):ToPickup()
		end
		local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
		for i, e in ipairs(wisps) do
			if e.SubType == CollectibleType.COLLECTIBLE_CHAOS or e.SubType == CollectibleType.COLLECTIBLE_EUCHARIST or e.SubType == CollectibleType.COLLECTIBLE_GOAT_HEAD then
				e:Kill()
				local dreamcard = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_DREAM_CARD, Isaac.GetFreeNearPosition(player.Position, 0.0), Vector(0,0), nil):ToPickup()
				--dreamcard:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, CollectibleType.CARD_DREAM_CARD, false, false, true)
			end
		end

	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.dreamsUpdate)


function wakaba:dreamsCardBonus(rng, spawnPosition)
	--local randomInt = rng:RandomInt(100)
	
	local border = 800
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DRMS then
		border = border * 2
	end

  for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS) then
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.DOUBLE_DREAMS)
			local randomnum = rng:RandomInt(10000)
			wakaba:GetPlayerEntityData(player)
			player:GetData().wakaba.dreamstack = player:GetData().wakaba.dreamstack or 0
			player:GetData().wakaba.dreamstack = player:GetData().wakaba.dreamstack + 800
			if wakaba:HasJudasBr(player) then
				player:GetData().wakaba.dreamstack = player:GetData().wakaba.dreamstack + 400
			end
			if randomnum <= border or player:GetData().wakaba.dreamstack >= 10000 then
				local dreamcard = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, wakaba.Enums.Cards.CARD_DREAM_CARD, Isaac.GetFreeNearPosition(player.Position, 0.0), Vector(0,0), nil):ToPickup()
				player:GetData().wakaba.dreamstack = 0
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.dreamsCardBonus)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.dreamsCardBonus)
