
local isc = _wakaba.isc
local c = wakaba.challenges.CHALLENGE_APPL
local tp = wakaba.Enums.Players.WAKABA
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_ApollyonCrisis(player)
	if wakaba.G.Challenge ~= c then return end
  if wakaba:Challenge_IsFirstInit(player) then
    Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, wakaba.Enums.Collectibles.WAKABAS_BLESSING, player.Position, Vector.Zero, player):ToFamiliar()
    Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ABYSS_LOCUST, wakaba.Enums.Collectibles.WAKABAS_NEMESIS, player.Position, Vector.Zero, player):ToFamiliar()
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_ApollyonCrisis)


function wakaba:Challenge_Cache_ApollyonCrisis(player, cacheFlag)
	if wakaba.G.Challenge == c then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * (((30 / (player.MaxFireDelay + 1)) / 8) * (player.ShotSpeed * 0.8) + 1)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Challenge_Cache_ApollyonCrisis)

function wakaba:Challenge_PickupCollision_ApollyonCrisis(pickup, colliders, low)
	if wakaba.G.Challenge ~= c then return end
  local id = pickup.SubType
  local config = Isaac.GetItemConfig():GetCollectible(id)
  if not config or not (config:HasTags(ItemConfig.TAG_QUEST) or id == CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
    local player = Isaac.GetPlayer()
    if pickup:IsShopItem() and player:GetNumCoins() >= pickup.Price then
      player:AddCoins(pickup.Price * -1)
      if wakaba.kud_wafu then
      else
        SFXManager():Play(SoundEffect.SOUND_POWERUP3)
      end
      pickup.Price = 0
    end
    return pickup:IsShopItem()
  end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.Challenge_PickupCollision_ApollyonCrisis, PickupVariant.PICKUP_COLLECTIBLE)