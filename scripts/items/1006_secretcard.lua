wakaba.COLLECTIBLE_SECRET_CARD = Isaac.GetItemIdByName("Secret Card")
local enemycount = 0
local damaged = false


local forcoins = 0
function wakaba:update26()
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:HasCollectible(wakaba.COLLECTIBLE_SECRET_CARD) and not Game():IsGreedMode() then
	  forcoins = 1
	else
	  forcoins = 0
	end
	if player:HasCollectible(wakaba.COLLECTIBLE_WAKABAS_BLESSING) and forcoins == 1 then
	  forcoins = 2
	end
	if player:HasCollectible(wakaba.COLLECTIBLE_SECRET_CARD) and Game():IsGreedMode() then
	
  	local items = Isaac.FindByType(5, 20, 1, false, false)
  	for i, e in ipairs(items) do
  	   e:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 4, true)
  	end
	
	end
  end
  if forcoins == 2 and Isaac.GetPlayer(0):GetNumCoins() < 22 then
	Isaac.GetPlayer(0):AddCoins(22 - Isaac.GetPlayer(0):GetNumCoins())
  end
end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.update26)
--LagCheck


wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
  damaged = false
  for i = 1, Game():GetNumPlayers() do
  local player = Isaac.GetPlayer(i - 1)
  if Game():GetRoom():IsFirstVisit() and player:HasCollectible(wakaba.COLLECTIBLE_SECRET_CARD) and not Game():IsGreedMode() then
    enemycount = RNG():RandomInt(4) * player:GetCollectibleNum(wakaba.COLLECTIBLE_SECRET_CARD)
		if enemycount == 0 then
			enemycount = 1
		end
  end
  
  end
end)

function wakaba:DmgFlagSecretCard(entity, amount, flag, source, countdownFrames)
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.COLLECTIBLE_SECRET_CARD) then
			if source ~= nil 
			and not (flag & DamageFlag.DAMAGE_FAKE == DamageFlag.DAMAGE_FAKE) 
			and not (flag & DamageFlag.DAMAGE_NO_PENALTIES == DamageFlag.DAMAGE_NO_PENALTIES)
			and not (flag & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS)
			and not (flag & DamageFlag.DAMAGE_CURSED_DOOR == DamageFlag.DAMAGE_CURSED_DOOR)
			then
				damaged = true
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , wakaba.DmgFlagSecretCard, EntityType.ENTITY_PLAYER)

function wakaba:roomClearSecretCard()
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.COLLECTIBLE_SECRET_CARD) then
			if not damaged then
				enemycount = enemycount * 2
			end
			player:AddCoins(enemycount)
			enemycount = 0
		end
  end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.roomClearSecretCard)

