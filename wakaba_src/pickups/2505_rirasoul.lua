local sfx = SFXManager()
local isc = require("wakaba_src.libs.isaacscript-common")

local spawncount = wakaba.Enums.Constants.SOUL_OF_RIRA_AQUA_TRINKET_COUNT
local clearcount = wakaba.Enums.Constants.SOUL_OF_RIRA_AQUA_TRINKET_COUNT_CLEAR_RUNE

---@param player EntityPlayer
function wakaba:UseCard_SoulOfRira(_, player, flags)
  local count = flags & UseFlag.USE_MIMIC > 0 and clearcount or spawncount
  for i = 1, spawncount do
    local vec = wakaba:RandomVectorEX(2) ---@type Vector
    vec = vec + vec:Normalized()
		local aqua = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, wakaba.G:GetItemPool():GetTrinket(), player.Position, vec, nil):ToPickup()
		wakaba:TryTurnAquaTrinket(aqua)
  end
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_SoulOfRira, wakaba.Enums.Cards.SOUL_RIRA)