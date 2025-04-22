local function TryOpenChallengeDoor()
	for i = 0, DoorSlot.NUM_DOOR_SLOTS do
		local doorR = wakaba.G:GetRoom():GetDoor(i)
		if doorR then
			if doorR.TargetRoomType == RoomType.ROOM_CHALLENGE then
				doorR:TryUnlock(Isaac.GetPlayer(), true)
			end
		end
	end
end

local function TryOpenQuestDoor()
	for i = 0, DoorSlot.NUM_DOOR_SLOTS do
		local doorR = wakaba.G:GetRoom():GetDoor(i)
		if doorR then
			if doorR.TargetRoomIndex == -7
			or doorR.TargetRoomIndex == -10
			then
				doorR:TryUnlock(Isaac.GetPlayer(), true)
			end
		end
	end
end

function wakaba:NewRoom_PhantomCloak()
	for num = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(num - 1)
		pData = player:GetData()
		if pData.wakaba and pData.wakaba.phantomcloak and pData.wakaba.phantomcloak.active then
			TryOpenChallengeDoor()
			if wakaba:IsGoldenItem(wakaba.Enums.Collectibles.PHANTOM_CLOAK, player) then
				TryOpenQuestDoor()
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_PhantomCloak)


---@param player EntityPlayer
function wakaba:ChargeBarUpdate_PhantomCloak(player)
	if not wakaba:getRoundChargeBar(player, "PhantomCloak") then
		local sprite = Sprite()
		sprite:Load("gfx/chargebar_phantomcloak.anm2", true)

		wakaba:registerRoundChargeBar(player, "PhantomCloak", {
			Sprite = sprite,
		}):UpdateSpritePercent(-1)
	end
	local chargeBar = wakaba:getRoundChargeBar(player, "PhantomCloak")
	local phantom = player:GetData().wakaba.phantomcloak
	if phantom and phantom.timer and phantom.timer > 1 then
		local timer = phantom.timer
		local count = ((phantom.timer // 12) / 10)
		chargeBar:UpdateSprite(timer, 0, 12000)
		chargeBar:UpdateText(count, "", "%")
	else
		chargeBar:UpdateSpritePercent(-1)
		chargeBar:UpdateText("")
	end

	if REPENTOGON then
		for i = 0, 2 do
			if player:GetActiveItem(i) == wakaba.Enums.Collectibles.PHANTOM_CLOAK then
				player:SetActiveCharge(player:GetData().wakaba and player:GetData().wakaba.phantomcloak and player:GetData().wakaba.phantomcloak.timer or 12000, i)
			end
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.ChargeBarUpdate_PhantomCloak)

local function canRefillCloak(player, data)
	if not wakaba:getOptionValue("phantomcloakhearts") then

	elseif player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
		local totalHearts = player:GetHearts() + player:GetSoulCharge()
		if totalHearts > 1 then
			return true, player:GetSoulCharge()
		end
	elseif player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
		local totalHearts = player:GetSoulHearts() + player:GetBloodCharge()
		if totalHearts > 1 then
			return true, player:GetBloodCharge()
		end
	else
		local totalHearts = player:GetHearts() + player:GetSoulHearts() - player:GetRottenHearts()
		if totalHearts > 1 then
			return true, player:GetSoulHearts()
		end
	end
	return false, -1
end

local function isHoldingCloak(player)
	for i = 0, 2 do
		if player:GetActiveItem(i) == wakaba.Enums.Collectibles.PHANTOM_CLOAK then
			return true
		end
	end
end

function wakaba:PlayerUpdate_PhantomCloak(player)
	pData = player:GetData()
	pData.wakaba = pData.wakaba or {}
	if pData.wakaba.phantomcloak then
		if pData.wakaba.phantomcloak.active then
			if pData.wakaba.phantomcloak.timer and pData.wakaba.phantomcloak.timer > 1 then
				player:SetColor(Color(1, 1, 1, 0.3, 0.03, 0, 0.1), 2, 1, true, false)
				if not player:HasEntityFlags(EntityFlag.FLAG_NO_TARGET) then
					player:AddEntityFlags(EntityFlag.FLAG_NO_TARGET)
				end
				pData.wakaba.phantomcloak.timer = pData.wakaba.phantomcloak.timer - 1
				if wakaba:IsMoving(player) then
					pData.wakaba.phantomcloak.timer = pData.wakaba.phantomcloak.timer - 20
				end
				if wakaba:IsFiring(player) then
					pData.wakaba.phantomcloak.timer = pData.wakaba.phantomcloak.timer - 27
				end
			end
			if pData.wakaba.phantomcloak.timer and pData.wakaba.phantomcloak.timer <= 1 then
				local canUse, counter = canRefillCloak(player, pData)
				if canUse and isHoldingCloak(player) then
					if counter > 0 then
						if player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
							player:AddSoulCharge(-1)
						elseif player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
							player:AddBloodCharge(-1)
						else
							player:AddSoulHearts(-1)
						end
					else
						if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
							player:AddSoulHearts(-1)
						else
							player:AddHearts(-1)
						end
					end
					pData.wakaba.phantomcloak.timer = (12000 * 0.3)
				else
					pData.wakaba.phantomcloak.active = false
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector(0,0), nil)
					SFXManager():Play(SoundEffect.SOUND_BLACK_POOF)
					player:ClearEntityFlags(EntityFlag.FLAG_NO_TARGET)
					player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_TEARFLAG)
					player:EvaluateItems()
				end
			end
		else
			if pData.wakaba.phantomcloak.timer and pData.wakaba.phantomcloak.timer < 12000 then
				if wakaba:IsMoving(player) then
					pData.wakaba.phantomcloak.timer = pData.wakaba.phantomcloak.timer + 65
				end
				if wakaba:IsFiring(player) then
					pData.wakaba.phantomcloak.timer = pData.wakaba.phantomcloak.timer + 87
				end
			elseif pData.wakaba.phantomcloak.timer and pData.wakaba.phantomcloak.timer >= 12000 then
				pData.wakaba.phantomcloak.timer = nil
				SFXManager():Play(wakaba.Enums.SoundEffects.AEION_CHARGE)
				local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 1, Vector(player.Position.X, player.Position.Y - 65), Vector.Zero, nil):ToEffect()
			end
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_PhantomCloak)

function wakaba:PNPCUpdate_PhantomCloak(npc)
	if not npc:IsEnemy() then return end
	local target = npc:GetPlayerTarget()
	npc:GetData().wakaba = npc:GetData().wakaba or {}
	pData = target:GetData()
	if pData.wakaba and pData.wakaba.phantomcloak and pData.wakaba.phantomcloak.active then
		npc:GetData().wakaba.clocked = true
		npc:AddEntityFlags(EntityFlag.FLAG_CONFUSION)
		if target:ToPlayer() and wakaba:HasShiori(target:ToPlayer()) then
			npc:AddEntityFlags(EntityFlag.FLAG_SLOW)
		end
		--return true
	elseif npc:GetData().wakaba.clocked then
		npc:GetData().wakaba.clocked = false
		npc:ClearEntityFlags(EntityFlag.FLAG_CONFUSION | EntityFlag.FLAG_SLOW)
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, wakaba.PNPCUpdate_PhantomCloak)

function wakaba:ItemUse_PhantomCloak(item, rng, player, useFlags, activeSlot, varData)
	pData = player:GetData()
	if not pData.wakaba.phantomcloak or not pData.wakaba.phantomcloak.timer then
		pData.wakaba.phantomcloak = pData.wakaba.phantomcloak or {}
		pData.wakaba.phantomcloak.timer = 12000
		pData.wakaba.phantomcloak.active = true
		player:AddEntityFlags(EntityFlag.FLAG_NO_TARGET)
		TryOpenChallengeDoor()
		if wakaba:IsGoldenItem(item, player) then
			TryOpenQuestDoor()
		end
		--[[ if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
			player:AnimateCollectible(wakaba.Enums.Collectibles.PHANTOM_CLOAK, "UseItem", "PlayerPickup")
		end ]]
		if wakaba:HasJudasBr(player) then
			SFXManager():Play(SoundEffect.SOUND_DEVIL_CARD)
		end
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector(0,0), nil)
		SFXManager():Play(SoundEffect.SOUND_ANGEL_WING)
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_TEARFLAG)
		player:EvaluateItems()
	elseif pData.wakaba.phantomcloak and pData.wakaba.phantomcloak.active and useFlags & UseFlag.USE_CARBATTERY == 0 then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector(0,0), nil)
		SFXManager():Play(SoundEffect.SOUND_BLACK_POOF)
		pData.wakaba.phantomcloak.active = false
		player:ClearEntityFlags(EntityFlag.FLAG_NO_TARGET)
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_TEARFLAG)
		player:EvaluateItems()
	end

end

wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_PhantomCloak, wakaba.Enums.Collectibles.PHANTOM_CLOAK)


function wakaba:Cache_PhantomCloak(player, cacheFlag)
	if not player:GetData().wakaba then return end
	if not wakaba:HasShiori(player) then return end
	pData = player:GetData()
	if pData.wakaba.phantomcloak and pData.wakaba.phantomcloak.active then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 1.25
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING | TearFlags.TEAR_BELIAL
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_PhantomCloak)