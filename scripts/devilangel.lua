
function wakaba:getDevilAngelStatus()
	local bless = false
	local nemesis = false
	local murasame = false
	local duality = false
	local wdreams = false
	local wakababr = false
  local jokers = false
  for i = 1, Game():GetNumPlayers() do
    local pl = Isaac.GetPlayer(i - 1)
		if wakaba:HasBless(pl) then
			bless = true
		end
		if pl:GetPlayerType() == wakaba.PLAYER_WAKABA and pl:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			wakababr = true
		end
		if wakaba:HasMurasame(pl) then
			murasame = true
		end
		if wakaba:HasNemesis(pl) then
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
  local game = Game()
  local room = Game():GetRoom()
  local level = Game():GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
  local StartingRoom = 84
	if room:IsFirstVisit() and CurRoom == StartingRoom then
		wakaba.state.isbossopened = false
	end
  if Game():GetLevel():GetRoomByIdx(-1,-1).VisitedCount > 0 then
    wakaba.state.isbossopened = true
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.resetDevilAngelStatus)

function wakaba:openDevilAngelRoom(rng, pos)
  local currentStage = Game():GetLevel():GetAbsoluteStage()
  local status = wakaba:getDevilAngelStatus()
	local bless = status.Blessing
	local nemesis = status.Nemesis
	local murasame = status.Murasame
	local duality = status.Duality
	local wdreams = status.WDreams
	local wakababr = status.WakabaBR
  if not wdreams and Game():GetRoom():GetType() == RoomType.ROOM_BOSS and ((bless and nemesis) or wakababr) and not Game():GetLevel():CanSpawnDevilRoom() then
    if (currentStage <= LevelStage.STAGE1_1 or currentStage > LevelStage.STAGE4_2) then
      --Game():GetLevel():DisableDevilRoom()
    end

    Game():GetRoom():TrySpawnDevilRoomDoor(true, true)
  end

	if not wdreams and not duality and Game():GetRoom():GetType() == RoomType.ROOM_BOSS and Game():GetLevel():GetRoomByIdx(-1,-1).VisitedCount==0 then
    wakaba.state.isbossopened = true
		local dealdoor=nil
		local doorcount=0
		for i=0,8 do
			if Game():GetRoom():GetDoor(i) and Game():GetRoom():GetDoor(i).TargetRoomIndex==-1 then
				dealdoor=Game():GetRoom():GetDoor(i)
				doorcount=doorcount+1
			end
		end
    if dealdoor then
      if bless and not nemesis then
        Game():GetLevel():GetRoomByIdx(-1,-1).Data=nil
        Game():GetLevel():InitializeDevilAngelRoom(true, false)
        if dealdoor.TargetRoomType == RoomType.ROOM_DEVIL then
          --SFXManager():Play(SoundEffect.SOUND_SATAN_ROOM_APPEAR)
          dealdoor:SetRoomTypes(1,RoomType.ROOM_ANGEL)
        end
      elseif not (bless or murasame) and nemesis then
        Game():GetLevel():GetRoomByIdx(-1,-1).Data=nil
        Game():GetLevel():InitializeDevilAngelRoom(false, true)
        if dealdoor.TargetRoomType == RoomType.ROOM_ANGEL then
          SFXManager():Play(SoundEffect.SOUND_SATAN_ROOM_APPEAR)
          dealdoor:SetRoomTypes(1,RoomType.ROOM_DEVIL)
        end
      else
        Game():GetLevel():InitializeDevilAngelRoom(false, false)
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
  local currentroom = Game():GetRoom()
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
      local dealroom = Game():GetLevel():GetRoomByIdx(-1,-1)
      if dealroom and dealroom.VisitedCount <= 0 then
        origDealRoomData = dealroom.Data
      end
	    if bless and not nemesis then
	    	Game():GetLevel():GetRoomByIdx(-1,-1).Data=nil
	    	Game():GetLevel():InitializeDevilAngelRoom(true, false)
	    elseif not (bless or murasame) and nemesis then
	    	Game():GetLevel():GetRoomByIdx(-1,-1).Data=nil
	    	Game():GetLevel():InitializeDevilAngelRoom(false, true)
	    end
    else
      if origDealRoomData then
        --Game():GetLevel():GetRoomByIdx(-1,-1).Data = origDealRoomData
      end
    end

  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.checkTempDevilAngelRoomStats)


function wakaba:NewRoom_DevilAngel()
  local room = Game():GetRoom()
  local level = Game():GetLevel()
  local currentstage = level:GetAbsoluteStage()
  local currentroomtype = room:GetType()
	if ((currentroomtype == RoomType.ROOM_BOSS and (not level:CanSpawnDevilRoom() or level:IsDevilRoomDisabled()))
    or ((currentstage == LevelStage.STAGE4_3 or currentstage == LevelStage.STAGE8) and level:GetCurrentRoomIndex() == 84)
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

    if not wdreams and ((bless and nemesis) or wakababr) then
      --print("try")
      if murasame or (bless and nemesis) then
		    if Game():GetLevel():GetAngelRoomChance() <= 0 then
		    	Game():GetLevel():AddAngelRoomChance((Game():GetLevel():GetAngelRoomChance() * -1) + 0.00001)
		    end
      end
      if bless and not nemesis then
        Game():GetLevel():AddAngelRoomChance(1 - Game():GetLevel():GetAngelRoomChance())
      elseif nemesis and not bless then
        Game():GetLevel():AddAngelRoomChance(Game():GetLevel():GetAngelRoomChance() * -1)
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
		Game():GetLevel():SetStateFlag(LevelStateFlag.STATE_REDHEART_DAMAGED, false)
		Game():GetRoom():SetRedHeartDamage(false)
		Game():SetLastDevilRoomStage(LevelStage.STAGE_NULL)
		if Game():GetLevel():GetAngelRoomChance() <= 0 then
			Game():GetLevel():AddAngelRoomChance((Game():GetLevel():GetAngelRoomChance() * -1) + 0.00001)
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER , wakaba.blessnemesisrender)

function wakaba:DreamsPostLevel()
  local status = wakaba:getDevilAngelStatus()
  local wdreams = status.WDreams
	if wdreams then
    Game():GetLevel():DisableDevilRoom()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.DreamsPostLevel)
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.DreamsPostLevel)

--[[ function wakaba:NewLevel_PrepareOverrideDevilAngel()
  local level = Game():GetLevel()
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