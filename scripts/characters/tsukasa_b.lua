
local playerType = Isaac.GetPlayerTypeByName("TsukasaB", true)
local removed = false
local isWakabaContinue = true




--some mods force the players cache update to happen every frame, triggering costume application
--this prevents costume from being applied repeatedly
function wakaba:GetTsukasaCostume_b(player)
	--print("wakaba.costumecurrframe ",wakaba.costumecurrframe)
	if wakaba.costumecurrframe == 0 then
		wakaba.costumecurrframe = wakaba.costumecooldown
		player:AddNullCostume(wakaba.COSTUME_TSUKASA_B)
		player:AddNullCostume(14)
	end
end

--[[ if Poglite then
	local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakaba_pog.anm2")
	Poglite:AddPogCostume("TsukasaPog",playerType,pogCostume)
end ]]

--Costume currently not working in Knife Piece 2 area. Needs to be fixed.
function wakaba:PostTsukasaUpdate_b(player)
	if player:GetPlayerType() == wakaba.PLAYER_TSUKASA_B
	then
		--player:ResetDamageCooldown()
		if not (player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY)) then
			--player:AddCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY, 0, false, -1, 0)
		end
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
		if wakaba:IsFireTriggered(player) then
			data.wakaba.flashshifttrigger = wakaba.dashflags.FLASH_SHIFT_TSUKASA_B
			player:UseActiveItem(wakaba.COLLECTIBLE_FLASH_SHIFT, UseFlag.USE_OWNED | UseFlag.USE_CUSTOMVARDATA, -1)
		end 
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PostTsukasaUpdate_b)

--Broken Heart Rendering
function wakaba:PostTsukasaRender_b()
end
--wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.PostTsukasaRender)


function wakaba:TakeDamage_Tsukasa_b(entity, amount, flags, source, cooldown)
	-- If the player is Wakaba
	--print(entity.Type)
	local player = entity:ToPlayer()
	if player and player:GetPlayerType() == wakaba.PLAYER_TSUKASA_B then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then

		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_Tsukasa_b, EntityType.ENTITY_PLAYER)
--[[ 
function wakaba:TearUpdate_Tsukasa(tear)
	local parent = tear.SpawnerEntity
	if not parent or not parent:ToPlayer() then return end
	local player = parent:ToPlayer()
	if player:GetPlayerType() == wakaba.PLAYER_TSUKASA_B then
		local laser = player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection(), false, true, player, 1)
		tear:Remove()
		laser:SetMaxDistance(player.TearRange)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_Tsukasa)
 ]]

-- TearFlags.TEAR_ICE is not working due to bugs. Planned in next patch
local TsukasaChar_b = { 
    DAMAGE = 0.65,
    SPEED = 0.1,
    SHOTSPEED = 1.0,
    TEARRANGE = 0.0,
		TEARS = 1.2,
    LUCK = 0,
    FLYING = false,                                 
    TEARFLAG = TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_PERSISTENT,
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)  -- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}
 
function wakaba:onTsukasaCache_b(player, cacheFlag)
  if player:GetPlayerType() == wakaba.PLAYER_TSUKASA_B then
		--wakaba:GetTsukasaCostume_b(player)
    if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * TsukasaChar_b.DAMAGE
    end
    if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
        player.ShotSpeed = player.ShotSpeed * TsukasaChar_b.SHOTSPEED
    end
    if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
        player.TearRange = player.TearRange
    end
    if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
        player.MoveSpeed = player.MoveSpeed + TsukasaChar_b.SPEED
    end
    if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
        player.Luck = player.Luck + TsukasaChar_b.LUCK
    end
    if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and TsukasaChar_b.FLYING then
        player.CanFly = true
    end
    if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS) then
        player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, TsukasaChar_b.TEARS)
			else
        player.MaxFireDelay = player.MaxFireDelay * 1.5
			end
    end
    if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
        player.TearFlags = player.TearFlags | TsukasaChar_b.TEARFLAG
    end
    if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
        player.TearColor = TsukasaChar_b.TEARCOLOR
    end
	else
		if player:CanShoot() then
			player:TryRemoveNullCostume(14)
		end
		--player:TryRemoveNullCostume(wakaba.COSTUME_TSUKASA_B)
  end
	
end
 
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.onTsukasaCache_b)

--[[ function wakaba:TsukasaRoomInit()
	for i = 0, Game():GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetPlayerType() == wakaba.PLAYER_TSUKASA_B then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_TECHNOLOGY, UseFlag.USE_NOANIM | UseFlag.USE_NOCOSTUME, -1)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.TsukasaRoomInit) ]]

function wakaba:AfterTsukasaInit_b(player)
  local player = player or Isaac.GetPlayer()
	--print("Tsukasa event passed")
	if player:GetPlayerType() == playerType then
		if not wakaba.state.unlock.taintedtsukasa then
			CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievement_wakaba/achievement_locked.png")
			player:ChangePlayerType(wakaba.PLAYER_TSUKASA)
			wakaba:AfterTsukasaInit(player)
		else
			if wakaba.state.options.cp_wakaba_b then
				player:AddNullCostume(14)
				player:EvaluateItems()
			else
				wakaba.costumecurrframe = 0
				wakaba:GetTsukasaCostume_b(player)
			end
			local data = player:GetData()
			data.wakaba = data.wakaba or {}
			--[[ if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= wakaba.COLLECTIBLE_MURASAME and Game().Challenge == Challenge.CHALLENGE_NULL then
				player:SetPocketActiveItem(wakaba.COLLECTIBLE_MURASAME, ActiveSlot.SLOT_POCKET, true)
				player:SetActiveCharge(0, ActiveSlot.SLOT_POCKET)
			end ]]
		end
	end
end

function wakaba:PostTsukasaInit_b(player)
	if player:GetPlayerType() == playerType then
		wakaba.costumecurrframe = 0
		wakaba:GetTsukasaCostume_b(player)
	end
  if not isWakabaContinue then
		wakaba:AfterTsukasaInit_b(player)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostTsukasaInit_b)

function wakaba:TsukasaInit_b(continue)
  if (not continue) then
    isWakabaContinue = false
    wakaba:AfterTsukasaInit_b()
  end
	--wakaba:TsukasaRoomInit()
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.TsukasaInit_b)

function wakaba:TsukasaExit_b()
  isWakabaContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.TsukasaExit_b)

--[[ if Poglite then
	if wakaba.state.pog ~= nil then
		if wakaba.state.pog then
			-- Tsukasa POG
			local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakabapog.anm2")
			Poglite:AddPogCostume("TsukasaPog",playerType,pogCostume)
		else
			-- Origin POG
			local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakabapog.anm2")
			Poglite:AddPogCostume("TsukasaPog",playerType,pogCostume)
		end
	end
end ]]



