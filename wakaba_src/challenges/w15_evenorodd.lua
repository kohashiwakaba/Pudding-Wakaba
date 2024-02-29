
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_EVEN
local tp = wakaba.Enums.Players.RICHER
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_EvenOrOdd(player)
	if wakaba.G.Challenge ~= c then return end
  wakaba.G:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_MARKED)
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_EvenOrOdd)

function wakaba:Challenge_PlayerUpdate_EvenOrOdd(player)
  if wakaba.G.Challenge ~= c then return end
  if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.Enums.Collectibles.SWEETS_CATALOG then
    player:SetPocketActiveItem(wakaba.Enums.Collectibles.SWEETS_CATALOG, ActiveSlot.SLOT_POCKET, true)
  end
  if not REPENTOGON then
		player:SetActiveCharge(12, ActiveSlot.SLOT_POCKET)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_PlayerUpdate_EvenOrOdd)

function wakaba:Challenge_PickupCollision_EvenOrOdd(pickup, colliders, low)
	if wakaba.G.Challenge == c then
		local id = pickup.SubType
		local config = Isaac.GetItemConfig():GetCollectible(id)
		if not config or not config:HasTags(ItemConfig.TAG_QUEST) then
			return pickup:IsShopItem()
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.Challenge_PickupCollision_EvenOrOdd, PickupVariant.PICKUP_COLLECTIBLE)