
local isc = require("wakaba_src.libs.isaacscript-common")


function wakaba:NewRoom_Bishop()
	local room = wakaba.G:GetRoom()
	if not room:IsFirstVisit() then return end
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.lakeroomcnt = player:GetData().wakaba.lakeroomcnt or 0
		for i = 1, player:GetCollectibleNum(wakaba.Enums.Collectibles.SEE_DES_BISCHOFS) do
			player:GetData().wakaba.lakeroomcnt = player:GetData().wakaba.lakeroomcnt + 1
			if player:GetData().wakaba.lakeroomcnt >= 4 then
				player:AddWisp(0, player.Position)
				player:GetData().wakaba.lakeroomcnt = 0
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_Bishop)

function wakaba:AfterRevival_LakeOfBishop(player)
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.bypassunlock = true
	player:ChangePlayerType(wakaba.Enums.Players.TSUKASA_B)
	wakaba:AfterTsukasaInit_b(player)
	wakaba:GetTsukasaCostume_b(player) 
	player:AddMaxHearts(6-player:GetMaxHearts())
	player:AddBoneHearts(-12)
	player:AddSoulHearts(-36)
	player:AddHearts(6)
	player:RemoveCollectible(wakaba.Enums.Collectibles.SEE_DES_BISCHOFS)
end


function wakaba:Cache_JarOfClover(player, cacheFlag)
  if player:HasCollectible(wakaba.Enums.Collectibles.JAR_OF_CLOVER) 
	or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.JAR_OF_CLOVER)
	then
		local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.JAR_OF_CLOVER) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.JAR_OF_CLOVER)
    if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			local gameTimer = wakaba.G:GetFrameCount()
			local luck = gameTimer / 3600
      player.Luck = player.Luck + (count * luck)
    end
  end
end
 
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_JarOfClover)

function wakaba:PEffectUpdate_JarofClover(player)
  if player:HasCollectible(wakaba.Enums.Collectibles.JAR_OF_CLOVER) 
	or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.JAR_OF_CLOVER)
	then
		local gameTimer = wakaba.G:GetFrameCount()
		if gameTimer % 15 == 0 then
			player:AddCacheFlags(CacheFlag.CACHE_LUCK)
			player:EvaluateItems()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PEffectUpdate_JarofClover)

function wakaba:AfterRevival_JarOfClover(player)
	if player:GetPlayerType() == wakaba.Enums.Players.WAKABA_B then
		player:AddBlackHearts(6)
	else
		player:ChangePlayerType(wakaba.Enums.Players.WAKABA)
		wakaba:AfterWakabaInit(player)
		wakaba:GetWakabaCostume(player) 
		player:AddMaxHearts(4-player:GetMaxHearts())
		player:AddBoneHearts(-12)
		player:AddSoulHearts(-36)
		player:AddHearts(4)
	end
	player:RemoveCollectible(wakaba.Enums.Collectibles.JAR_OF_CLOVER)
end

 

function wakaba:AfterRevival_CaramellaPancake(player)
	if true --[[ player:GetPlayerType() ~= wakaba.Enums.Players.RICHER_B ]] then
		player:ChangePlayerType(wakaba.Enums.Players.RICHER)
		wakaba:AfterRicherInit(player)
		wakaba:GetRicherCostume(player) 
		player:AddMaxHearts(-200)
		player:AddBoneHearts(-12)
		player:AddSoulHearts(-36)
		player:AddMaxHearts(4)
		player:AddHearts(4)
		player:AddSoulHearts(2)
	end
	player:RemoveCollectible(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE)
end


