local rtReplaced = false
function wakaba:GameStart_RetributionCompat()
	if Retribution and not rtReplaced then
		wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_Magnet, Retribution.PICKUPS.SPOILS_COIN)

		rtReplaced = true
	end
end