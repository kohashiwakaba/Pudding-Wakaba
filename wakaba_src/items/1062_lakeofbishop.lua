
local isc = require("wakaba_src.libs.isaacscript-common")

---@param player EntityPlayer
local function hasCaramellaEffect(player, itemID, revivalEntry)
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba[revivalEntry] = player:GetData().wakaba[revivalEntry] or 0
	return player:HasCollectible(itemID) or player:GetData().wakaba[revivalEntry] > 0
end

---@param player EntityPlayer
local function getCaramellaEffectNum(player, itemID, revivalEntry)
	player:GetData().wakaba[revivalEntry] = player:GetData().wakaba[revivalEntry] or 0
	return player:GetCollectibleNum(itemID) + player:GetData().wakaba[revivalEntry]
end

function wakaba:NewRoom_Bishop()
	local room = wakaba.G:GetRoom()
	if not room:IsFirstVisit() then return end
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.lakeroomcnt = player:GetData().wakaba.lakeroomcnt or 0
		for i = 1, getCaramellaEffectNum(player, wakaba.Enums.Collectibles.SEE_DES_BISCHOFS, "bishopcount") do
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
	player:GetData().wakaba.bishopcount = (player:GetData().wakaba.bishopcount or 0) + 1
	player:ChangePlayerType(wakaba.Enums.Players.TSUKASA_B)
	wakaba:AfterTsukasaInit_b(player)
	wakaba:GetTsukasaCostume_b(player)
	player:AddMaxHearts(6-player:GetMaxHearts())
	player:AddBoneHearts(-12)
	player:AddSoulHearts(-36)
	player:AddHearts(6)
	wakaba:scheduleForUpdate(function ()
		player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.SEE_DES_BISCHOFS, false, 1)
	end, 1)
	player:RemoveCollectible(wakaba.Enums.Collectibles.SEE_DES_BISCHOFS)
end


function wakaba:Cache_JarOfClover(player, cacheFlag)
  if hasCaramellaEffect(player, wakaba.Enums.Collectibles.JAR_OF_CLOVER, "jarclovercount") then
		local count = getCaramellaEffectNum(player, wakaba.Enums.Collectibles.JAR_OF_CLOVER, "jarclovercount")
    if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			local gameTimer = wakaba.G:GetFrameCount()
			local luck = gameTimer / 3600
      player.Luck = player.Luck + (count * luck)
    end
  end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_JarOfClover)

function wakaba:PEffectUpdate_JarofClover(player)
  if hasCaramellaEffect(player, wakaba.Enums.Collectibles.JAR_OF_CLOVER, "jarclovercount") then
		local gameTimer = wakaba.G:GetFrameCount()
		if gameTimer % 15 == 0 then
			player:AddCacheFlags(CacheFlag.CACHE_LUCK)
			player:EvaluateItems()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PEffectUpdate_JarofClover)

function wakaba:AfterRevival_JarOfClover(player)
	player:GetData().wakaba.jarclovercount = (player:GetData().wakaba.jarclovercount or 0) + 1
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
	wakaba:scheduleForUpdate(function ()
		player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.JAR_OF_CLOVER, false, 1)
	end, 1)
	player:RemoveCollectible(wakaba.Enums.Collectibles.JAR_OF_CLOVER)
end



function wakaba:AfterRevival_CaramellaPancake(player)
	player:GetData().wakaba.caramellacount = (player:GetData().wakaba.caramellacount or 0) + 1
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
		player:AddSoulHearts(6)
	else
		player:ChangePlayerType(wakaba.Enums.Players.RICHER)
		wakaba:AfterRicherInit(player)
		--wakaba:GetRicherCostume(player)
		player:AddMaxHearts(-200)
		player:AddBoneHearts(-12)
		player:AddSoulHearts(-36)
		player:AddMaxHearts(4)
		player:AddHearts(4)
		player:AddSoulHearts(2)
	end
	wakaba:scheduleForUpdate(function ()
		player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE, false, 1)
	end, 1)
	player:RemoveCollectible(wakaba.Enums.Collectibles.CARAMELLA_PANCAKE)
end


---@param player EntityPlayer
function wakaba:AfterRevival_SakuraCapsule(player)
	player:AddMaxHearts(-200)
	player:AddBoneHearts(-12)
	player:AddSoulHearts(-36)
	player:AddMaxHearts(8)
	player:AddHearts(8)
	player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.SAKURA_CAPSULE, false, 2)
	player:SetMinDamageCooldown(30)
	wakaba.G:GetRoom():MamaMegaExplosion(player.Position)
	wakaba:scheduleForUpdate(function ()
		player:AnimateLightTravel()
		player:UseActiveItem(CollectibleType.COLLECTIBLE_FORGET_ME_NOW, UseFlag.USE_NOANIM)
	end, 15)
end