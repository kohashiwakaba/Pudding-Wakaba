local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:Cache_Important(player, cacheFlag)
  if cacheFlag == CacheFlag.CACHE_LUCK then
    if player:HasCollectible(wakaba.Enums.Collectibles.WAKABAS_PENDANT) and player:GetPlayerType() ~= wakaba.Enums.Players.WAKABA_B then
			local pendantcnt = 0
			if player:GetData().wakaba and player:GetData().wakaba.PendantCandidates then
				pendantcnt = #player:GetData().wakaba.PendantCandidates
			end
      if wakaba:HasBless(player) then
        if player.Luck < 10 then
          player.Luck = 10
        end
        player.Luck = player.Luck + (0.15 * pendantcnt * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT))
      else
        if player.Luck < 7 then
          player.Luck = 7
        end
        player.Luck = player.Luck + (0.35 * pendantcnt * player:GetCollectibleNum(wakaba.Enums.Collectibles.WAKABAS_PENDANT))
      end
    end
  end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010721, wakaba.Cache_Important)