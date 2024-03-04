
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.challenges.CHALLENGE_BIKE
local tp = wakaba.Enums.Players.WAKABA
wakaba.ChallengeParams.TargetCharacters[c] = tp

---@param player EntityPlayer
function wakaba:Challenge_PlayerInit_DeliverySystem(player)
	if wakaba.G.Challenge ~= c then return end
  player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_ANIMA_SOLA, ActiveSlot.SLOT_POCKET, true)
  player:GetData().wakaba.pendingesauspawn = true
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.Challenge_PlayerInit_DeliverySystem)


function wakaba:Challenge_GameStart_DeliverySystem(continue)
	if wakaba.G.Challenge ~= c then return end
	local player = Isaac.GetPlayer()
	if continue then
		local esau = Isaac.Spawn(EntityType.ENTITY_DARK_ESAU, 0, -1, wakaba:GetGridCenter(), Vector.Zero, player)
		esau:AddEntityFlags(EntityFlag.FLAG_NO_DEATH_TRIGGER)
		esau.CollisionDamage = esau.CollisionDamage * 3
		esau:Update()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.Challenge_GameStart_DeliverySystem)

function wakaba:preUseItem_Challenge_DeliverySystem(_, rng, player, flags, slot, vardata)
	if wakaba.G.Challenge == c then
		local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
		for i, e in ipairs(entities) do
			e:ClearEntityFlags(EntityFlag.FLAG_FRIENDLY)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.preUseItem_Challenge_DeliverySystem, CollectibleType.COLLECTIBLE_ANIMA_SOLA)


function wakaba:Challenge_NewRoom_DeliverySystem()
	if wakaba.G.Challenge ~= c then return end
  local game = wakaba.G
  local room = wakaba.G:GetRoom()
  local level = wakaba.G:GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
	local type1 = room:GetType()

  local hasEsau = false
  local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
  for i, e in ipairs(entities) do
    --e:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
    hasEsau = true
  end
  if room:IsFirstVisit() and isc:inStartingRoom() then
    for i = 1, wakaba.G:GetNumPlayers() do
      local player = Isaac.GetPlayer(i - 1)
      wakaba:GetPlayerEntityData(player)
      player:GetData().wakaba.pendingesauspawn = true
      player:GetData().wakaba.minervacount = 7
      player:GetData().wakaba.minervadeathcount = 100
    end
  else
    local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
    for i, e in ipairs(entities) do
      e.Position = Isaac.GetPlayer().Position
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.Challenge_NewRoom_DeliverySystem)

function wakaba:Challenge_PlayerUpdate_DeliverySystem(player)
	if wakaba.G.Challenge ~= c then return end

  local game = wakaba.G
  local room = wakaba.G:GetRoom()
  local level = wakaba.G:GetLevel()
  local CurStage = level:GetAbsoluteStage()
  local CurRoom = level:GetCurrentRoomIndex()
  wakaba:GetPlayerEntityData(player)
  if player:GetData().wakaba.pendingesauspawn and not wakaba.G:IsPaused() then
    player:GetData().wakaba.pendingesauspawn = false
    local esau = Isaac.Spawn(EntityType.ENTITY_DARK_ESAU, 0, -1, wakaba:GetGridCenter(), Vector.Zero, player)
    esau:AddEntityFlags(EntityFlag.FLAG_NO_DEATH_TRIGGER)
    esau.CollisionDamage = esau.CollisionDamage * 3
    esau:Update()
  end
  player:GetData().wakaba.minervadeathcount = player:GetData().wakaba.minervadeathcount or 600
  if room:IsFirstVisit() and isc:inStartingRoom() then
    player:GetData().wakaba.minervacount = 7
    player:GetData().wakaba.minervadeathcount = 600
  elseif player:GetData().wakaba.minervacount > 0 then
    if player:GetData().wakaba.minervadeathcount < 600 then
      player:GetData().wakaba.minervadeathcount = player:GetData().wakaba.minervadeathcount + 12
      if player:GetData().wakaba.minervadeathcount > 600 then
        player:GetData().wakaba.minervadeathcount = 600
      end
    end
  else
    if player:GetData().wakaba.minervadeathcount > 0 then
      if player:AreControlsEnabled() then
        player:GetData().wakaba.minervadeathcount = player:GetData().wakaba.minervadeathcount - 1
      end
    else
      player:TakeDamage(1,0,EntityRef(player),0)
      player:Die()
      if player:WillPlayerRevive() then
        player:GetData().wakaba.minervadeathcount = 600
      end
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.Challenge_PlayerUpdate_DeliverySystem)

function wakaba:Challenge_Cache_DeliverySystem(player, cacheFlag)
	if wakaba.G.Challenge == c then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			local totaldamage = 1
			for num = 1, wakaba.G:GetNumPlayers() do
				local tp = wakaba.G:GetPlayer(num - 1)
				totaldamage = totaldamage + (tp.Damage / 16)
			end
			local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
			for i, e in ipairs(entities) do
				e.CollisionDamage = totaldamage
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Challenge_Cache_DeliverySystem)


function wakaba:NegateDamage_Challenge_DeliverySystem(player, amount, flags, source, countdownFrames)
	if wakaba.G.Challenge == c then
		if player:GetData().wakaba
		and player:GetData().wakaba.minervadeathcount > 0 then
			if not (
				flags & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS
				and flags & DamageFlag.DAMAGE_IV_BAG == DamageFlag.DAMAGE_IV_BAG
				and flags & DamageFlag.DAMAGE_INVINCIBLE == DamageFlag.DAMAGE_INVINCIBLE
			) then
				return false
			end
		end
	end
end
wakaba:AddCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_Challenge_DeliverySystem)

function wakaba:DeliveryOnDamage(source, newDamage, newFlags)
	local returndata = {}
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_BIKE then
		local collisionMultiplier = source.Entity.CollisionDamage
		returndata.newDamage = newDamage * collisionMultiplier
		returndata.sendNewDamage = true
		returndata.newFlags = newFlags | DamageFlag.DAMAGE_IGNORE_ARMOR | DamageFlag.DAMAGE_CLONES
	end
	return returndata
end


---@param player EntityPlayer
function wakaba:Challenge_ChargeBarUpdate_DeliverySystem(player)
	if wakaba.G.Challenge ~= c then return end
  if not wakaba:getRoundChargeBar(player, "DeliveryMinerva") then
    local sprite = Sprite()
    sprite:Load("gfx/chargebar_clover.anm2", true)

    wakaba:registerRoundChargeBar(player, "DeliveryMinerva", {
      Sprite = sprite,
    }):UpdateSpritePercent(-1)
  end
  local chargeBar = wakaba:getRoundChargeBar(player, "DeliveryMinerva")

  local current = player:GetData().wakaba.minervadeathcount or 600
  local count = (current // 6) / 10
  local currval = pcurrent ~= wakaba.Enums.Constants.PONY_COOLDOWN and count or -1
  local percent = ((current / 600) * 100) // 1
  if player:IsDead() then
    chargeBar:UpdateSpritePercent(-1)
    chargeBar:UpdateText("")
  else
    chargeBar:UpdateSpritePercent(percent)
    chargeBar:UpdateText(currval)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Challenge_ChargeBarUpdate_DeliverySystem)


function wakaba:Challenge_Update_DeliverySystem()
	if wakaba.G.Challenge ~= c then return end
  local hasEsau = false
  local entities = Isaac.FindByType(EntityType.ENTITY_DARK_ESAU, 0, -1, false, false)
  for i, e in ipairs(entities) do
    hasEsau = true
    if e:IsDead() then

    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Challenge_Update_DeliverySystem)