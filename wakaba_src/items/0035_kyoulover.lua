--[[ 
	Kyoutarou Lover (쿄타로 러버) - 패밀리어
	안나 전용
	아이템 획득 시 색상 변경, 표시된 색상의 퀄리티만 표시
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:GameStart_KyouLover(isContinue)
	if not isContinue then
		local seed = wakaba.G:GetSeeds():GetStartSeed()
		wakaba.state.annaquality = seed % 5
	end
end

function wakaba:shiftAnnaQuality()
	local min = 0
	local max = 4
	if wakaba:GameHasBirthrightEffect(wakaba.Enums.Players.ANNA) then
		min = 1
	end
	wakaba.state.annaquality = wakaba.state.annaquality + 1
	if wakaba.state.annaquality > max then
		wakaba.state.annaquality = min
	end
end

function wakaba:PostGetCollectible_KyouLover(player, item)
	if (wakaba.state.annaquality == wakaba:GetItemQuality(item)) and not isc:isQuestCollectible(item) then
		wakaba:shiftAnnaQuality()
	end
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_KyouLover)