wakaba.COLLECTIBLE_SEE_DES_BISCHOFS = Isaac.GetItemIdByName("See des Bischofs")
wakaba.COLLECTIBLE_JAR_OF_CLOVER = Isaac.GetItemIdByName("Jar of Clover")
wakaba.COLLECTIBLE_CARAMELLA_PANCAKE = Isaac.GetItemIdByName("Caramella Pancake")

function wakaba:AfterRevival_LakeOfBishop(player)
	player:ChangePlayerType(wakaba.PLAYER_TSUKASA_B)
	wakaba:AfterTsukasaInit_b(player)
	wakaba:GetTsukasaCostume_b(player) 
	player:AddMaxHearts(6-player:GetMaxHearts())
	player:AddBoneHearts(-12)
	player:AddSoulHearts(-36)
	player:AddHearts(6)
	player:RemoveCollectible(wakaba.COLLECTIBLE_SEE_DES_BISCHOFS)
end

function wakaba:AfterRevival_JarOfClover(player)
	if player:GetPlayerType() == wakaba.PLAYER_WAKABA_B then
		player:AddBlackHearts(6)
	else
		player:ChangePlayerType(wakaba.PLAYER_WAKABA)
		wakaba:AfterWakabaInit(player)
		wakaba:GetWakabaCostume(player) 
		player:AddMaxHearts(4-player:GetMaxHearts())
		player:AddBoneHearts(-12)
		player:AddSoulHearts(-36)
		player:AddHearts(4)
	end
	player:RemoveCollectible(wakaba.COLLECTIBLE_JAR_OF_CLOVER)
end

 
--[[ 
function wakaba:AfterRevival_CaramellaPancake(player)
	if player:GetPlayerType() ~= wakaba.PLAYER_RICHER_B then
		player:ChangePlayerType(wakaba.PLAYER_RICHER)
		wakaba:AfterRicherInit(player)
		wakaba:GetRicherCostume(player) 
		player:AddMaxHearts(-200)
		player:AddBoneHearts(-12)
		player:AddSoulHearts(-36)
		player:AddMaxHearts(6)
		player:AddHearts(6)
	end
	player:RemoveCollectible(wakaba.COLLECTIBLE_CARAMELLA_PANCAKE)
end
 ]]

