
local isc = require("wakaba_src.libs.isaacscript-common")
wakaba.HiddenItemManager:HideCostumes("WAKABA_DUALITY")

function wakaba:getDevilAngelStatus()
	local bless = false
	local nemesis = false
	local murasame = false
	local duality = false
	local wdreams = false
	local wakababr = false
	local jokers = false
	for i = 1, wakaba.G:GetNumPlayers() do
		local pl = Isaac.GetPlayer(i - 1)
		if wakaba:HasBless(pl, true, true) then
			bless = true
		end
		if pl:GetPlayerType() == wakaba.Enums.Players.WAKABA and pl:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			wakababr = true
		end
		if wakaba:HasMurasame(pl) then
			murasame = true
		end
		if wakaba:HasNemesis(pl, true, true) then
			nemesis = true
		end
		if pl:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_DREAMS) or pl:HasCollectible(wakaba.Enums.Collectibles.DOUBLE_INVADER) then
			wdreams = true
		end
		if pl:GetCard(0) == wakaba.Enums.Cards.CARD_BLACK_JOKER or pl:GetCard(1) == wakaba.Enums.Cards.CARD_BLACK_JOKER then
			nemesis = true
			jokers = true
		end
		if pl:GetCard(0) == wakaba.Enums.Cards.CARD_WHITE_JOKER or pl:GetCard(1) == wakaba.Enums.Cards.CARD_WHITE_JOKER then
			bless = true
			jokers = true
		end
		if pl:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then
			duality = true
		end
	end

	local result = {
		Blessing = bless,
		Nemesis = nemesis,
		Murasame = murasame,
		Duality = duality,
		WDreams = wdreams,
		WakabaBR = wakababr,
		Jokers = jokers,
	}

	return result

end

function wakaba:resetDevilAngelStatus()
	local game = wakaba.G
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	local CurStage = level:GetAbsoluteStage()
	local CurRoom = level:GetCurrentRoomIndex()
	if room:IsFirstVisit() and isc:inStartingRoom() then
		wakaba.state.isbossopened = false
	end
	if wakaba.G:GetLevel():GetRoomByIdx(-1,-1).VisitedCount > 0 then
		wakaba.state.isbossopened = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.resetDevilAngelStatus)

function wakaba:openDevilAngelRoom(rng, pos)
	local currentStage = wakaba.G:GetLevel():GetAbsoluteStage()
	local effectiveStage = isc:getEffectiveStage()
	local status = wakaba:getDevilAngelStatus()
	local bless = status.Blessing
	local nemesis = status.Nemesis
	local murasame = status.Murasame
	local duality = status.Duality
	local wdreams = status.WDreams
	local wakababr = status.WakabaBR
	if not wdreams and wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSS
	and ((bless and nemesis) or wakababr or (murasame and effectiveStage >= 2 and effectiveStage <= 8 and not isc:onAscent()))
	and not wakaba.G:GetLevel():CanSpawnDevilRoom() then
		if (currentStage <= LevelStage.STAGE1_1 or currentStage > LevelStage.STAGE4_2) then
			--wakaba.G:GetLevel():DisableDevilRoom()
		end

		wakaba.G:GetRoom():TrySpawnDevilRoomDoor(true, true)
	end

	if not wdreams and not duality and wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSS and wakaba.G:GetLevel():GetRoomByIdx(-1,-1).VisitedCount==0 then
		wakaba.state.isbossopened = true
		local dealdoor=nil
		local doorcount=0
		for i=0,8 do
			if wakaba.G:GetRoom():GetDoor(i) and wakaba.G:GetRoom():GetDoor(i).TargetRoomIndex==-1 then
				dealdoor=wakaba.G:GetRoom():GetDoor(i)
				doorcount=doorcount+1
			end
		end
		if dealdoor then
			if bless and not nemesis then
				wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data=nil
				wakaba.G:GetLevel():InitializeDevilAngelRoom(true, false)
				if dealdoor.TargetRoomType == RoomType.ROOM_DEVIL then
					--SFXManager():Play(SoundEffect.SOUND_SATAN_ROOM_APPEAR)
					dealdoor:SetRoomTypes(1,RoomType.ROOM_ANGEL)
				end
			elseif not (bless or murasame) and nemesis then
				wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data=nil
				wakaba.G:GetLevel():InitializeDevilAngelRoom(false, true)
				if dealdoor.TargetRoomType == RoomType.ROOM_ANGEL then
					SFXManager():Play(SoundEffect.SOUND_SATAN_ROOM_APPEAR)
					dealdoor:SetRoomTypes(1,RoomType.ROOM_DEVIL)
				end
			else
				wakaba.G:GetLevel():InitializeDevilAngelRoom(false, false)
			end
		end

	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.openDevilAngelRoom)

local forceDealRoom = false
local origDealRoomData
local tempDealRoomData
function wakaba:checkTempDevilAngelRoomStats()
	forceDealRoom = false
	local status = wakaba:getDevilAngelStatus()
	local bless = status.Blessing
	local nemesis = status.Nemesis
	local murasame = status.Murasame
	local duality = status.Duality
	local jokers = status.Jokers
	local currentroom = wakaba.G:GetRoom()
	local currentroomtype = currentroom:GetType()

	if not duality and not wakaba.state.isbossopened then
		if currentroomtype == RoomType.ROOM_SACRIFICE then
			forceDealRoom = true
		end
		local conf = Isaac.FindByType(5, PickupVariant.PICKUP_REDCHEST, -1, false, false)
		if #conf > 0 then
			forceDealRoom = true
		end
		if jokers then forceDealRoom = true end

		if forceDealRoom then
			local dealroom = wakaba.G:GetLevel():GetRoomByIdx(-1,-1)
			if dealroom and dealroom.VisitedCount <= 0 then
				origDealRoomData = dealroom.Data
			end
			if bless and not nemesis then
				wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data=nil
				wakaba.G:GetLevel():InitializeDevilAngelRoom(true, false)
			elseif not (bless or murasame) and nemesis then
				wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data=nil
				wakaba.G:GetLevel():InitializeDevilAngelRoom(false, true)
			end
		else
			if origDealRoomData then
				--wakaba.G:GetLevel():GetRoomByIdx(-1,-1).Data = origDealRoomData
			end
		end

	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.checkTempDevilAngelRoomStats)


function wakaba:NewRoom_DevilAngel()
	local room = wakaba.G:GetRoom()
	local level = wakaba.G:GetLevel()
	local currentstage = level:GetAbsoluteStage()
	local effectiveStage = isc:getEffectiveStage()
	local currentroomtype = room:GetType()
	if ((currentroomtype == RoomType.ROOM_BOSS and (not level:CanSpawnDevilRoom() or level:IsDevilRoomDisabled()))
		or ((currentstage == LevelStage.STAGE4_3 or currentstage == LevelStage.STAGE8) and isc:inStartingRoom())
	)
	and room:IsClear() then
		local status = wakaba:getDevilAngelStatus()
		local bless = status.Blessing
		local nemesis = status.Nemesis
		local murasame = status.Murasame
		local duality = status.Duality
		local jokers = status.Jokers
		local wdreams = status.WDreams
		local wakababr = status.WakabaBR

		if not wdreams
		and (
			(bless and nemesis)
			or wakababr
			or (murasame and effectiveStage >= 2 and effectiveStage <= 8 and not isc:onAscent())
		)
		then
			--print("try")
			if murasame or (bless and nemesis) then
				if wakaba.G:GetLevel():GetAngelRoomChance() <= 0 then
					wakaba.G:GetLevel():AddAngelRoomChance((wakaba.G:GetLevel():GetAngelRoomChance() * -1) + 0.00001)
				end
			end
			if bless and not nemesis then
				wakaba.G:GetLevel():AddAngelRoomChance(1 - wakaba.G:GetLevel():GetAngelRoomChance())
			elseif nemesis and not bless then
				wakaba.G:GetLevel():AddAngelRoomChance(wakaba.G:GetLevel():GetAngelRoomChance() * -1)
			end
			room:TrySpawnDevilRoomDoor(false, true)
		end

	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_DevilAngel)

function wakaba:blessnemesisrender()
	local status = wakaba:getDevilAngelStatus()
	local bless = status.Blessing
	local nemesis = status.Nemesis
	local wdreams = status.WDreams
	local wakababr = status.WakabaBR
	if not wdreams and ((bless and nemesis) or wakababr) then
		if not REPENTOGON then
			wakaba.G:GetLevel():SetStateFlag(LevelStateFlag.STATE_REDHEART_DAMAGED, false)
			wakaba.G:GetRoom():SetRedHeartDamage(false)
			wakaba.G:SetLastDevilRoomStage(LevelStage.STAGE_NULL)
		end
		if wakaba.G:GetLevel():GetAngelRoomChance() <= 0 then
			wakaba.G:GetLevel():AddAngelRoomChance((wakaba.G:GetLevel():GetAngelRoomChance() * -1) + 0.00001)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER , wakaba.blessnemesisrender)

function wakaba:DreamsPostLevel(player)
	local status = wakaba:getDevilAngelStatus()
	local wdreams = status.WDreams
	local murasame = status.Murasame
	local bless = status.Blessing
	local nemesis = status.Nemesis
	if wdreams then
		if not REPENTOGON then
			wakaba.G:GetLevel():DisableDevilRoom()
		end
		if player then
			if wakaba.HiddenItemManager:Has(player, CollectibleType.COLLECTIBLE_DUALITY, "WAKABA_DUALITY") then
				wakaba.HiddenItemManager:RemoveStack(player, CollectibleType.COLLECTIBLE_DUALITY, "WAKABA_DUALITY")
			end
			if wakaba.HiddenItemManager:Has(player, CollectibleType.COLLECTIBLE_EUCHARIST, "WAKABA_PILLS") then
				wakaba.HiddenItemManager:RemoveStack(player, CollectibleType.COLLECTIBLE_EUCHARIST, "WAKABA_PILLS")
			end
		end
	else
		if player then
			if not (murasame or (bless and nemesis)) then
				if wakaba.HiddenItemManager:Has(player, CollectibleType.COLLECTIBLE_DUALITY, "WAKABA_DUALITY") then
					wakaba.HiddenItemManager:RemoveStack(player, CollectibleType.COLLECTIBLE_DUALITY, "WAKABA_DUALITY")
				end
				return
			end
			if player:HasCurseMistEffect() then
				return
			end
			wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_DUALITY, 1, "WAKABA_DUALITY")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.DreamsPostLevel)
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.DreamsPostLevel)

--[[ function wakaba:NewLevel_PrepareOverrideDevilAngel()
	local level = wakaba.G:GetLevel()
	level:InitializeDevilAngelRoom(true, false)
	local overrideDevilAngelRoomDesc = level:GetRoomByIdx(-1)
	level:GetRoomByIdx(wakaba.roomoverride.angelroom,-1) = overrideDevilAngelRoomDesc
	level:GetRoomByIdx(-1,-1).Data=nil
	level:InitializeDevilAngelRoom(false, true)
	overrideDevilAngelRoomDesc = level:GetRoomByIdx(-1)
	level:GetRoomByIdx(wakaba.roomoverride.devilroom,-1) = overrideDevilAngelRoomDesc
	level:GetRoomByIdx(-1,-1).Data=nil
end ]]
--wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_PrepareOverrideDevilAngel)