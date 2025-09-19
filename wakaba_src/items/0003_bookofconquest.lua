wakaba.conquestmode = false
wakaba.conquestcontrollerindex = nil
wakaba.nearestenemy = nil
wakaba.conquestcooltime = 0
wakaba.conquestblacklist = {
	EntityType.ENTITY_MOM,
	EntityType.ENTITY_MOMS_HEART,
	EntityType.ENTITY_ISAAC,
	EntityType.ENTITY_SATAN,
	EntityType.ENTITY_MEGA_SATAN,
	EntityType.ENTITY_MEGA_SATAN_2,
	EntityType.ENTITY_THE_LAMB,
	EntityType.ENTITY_HUSH,
	EntityType.ENTITY_DELIRIUM,
	EntityType.ENTITY_ULTRA_GREED,
	EntityType.ENTITY_MOTHER,
	EntityType.ENTITY_DOGMA,
	EntityType.ENTITY_BEAST,
	EntityType.ENTITY_FIREPLACE,
	EntityType.ENTITY_MOVABLE_TNT,
	EntityType.ENTITY_GIDEON,
	EntityType.ENTITY_HORNFEL,
	EntityType.ENTITY_VISAGE,
	--EntityType.ENTITY_PIN,
	EntityType.ENTITY_ROTGUT,
	--EntityType.ENTITY_LARRYJR,
	--EntityType.ENTITY_RAG_MEGA,
	EntityType.ENTITY_SHOPKEEPER,
	EntityType.ENTITY_BOMB_GRIMACE,
}
wakaba.conquestsegmentwhitelist = {
	EntityType.ENTITY_PIN,
	EntityType.ENTITY_LARRYJR,
	EntityType.ENTITY_CHUB,
}

wakaba.conqueredSeed = {

}

wakaba:AddPriorityCallback(ModCallbacks.MC_PRE_GAME_EXIT, CallbackPriority.IMPORTANT, function()
	wakaba.conquestmode = false
	if EID then
		EID.Config["HideInBattle"] = wakaba.eidHideInBattle
		EID:hidePermanentText()
	end
end)

wakaba.conquestready = {}
wakaba.conquestreadycount = 0
local bombcost, keycost = 0, 0
wakaba.eidHideInBattle = EID and EID.Config["HideInBattle"]
local camPos

local function getNameEntity(entity)
	if not EID then return "Book of Conquest requires EID" end
	if not entity then return "No entity Found" end
	local entityType = entity.Type
	local entityVariant = entity.Variant
	local entitySubtype = entity.SubType
	local name = EID:GetEntityXMLName(entityType, entityVariant, entitySubtype)
	if name == e then return "(No name or modded)" end

	return name
end

function wakaba:GetMaxConquestCount(player)
	if wakaba:IsLunatic() then
		return 40
	end
	return 160
end

function wakaba:SetConquestCharge(player, slot)
  if player == nil then return end
  local slot = slot or ActiveSlot.SLOT_PRIMARY
  local activeItem = player:GetActiveItem(slot)
  if activeItem <= 0 then return end
	local itemConfig = Isaac.GetItemConfig()
  local activeConfig = itemConfig:GetCollectible(activeItem)
  if activeConfig == nil then return end
  local maxCharges = activeConfig.MaxCharges
  local chargeType = activeConfig.ChargeType
  if activeItem == wakaba.Enums.Collectibles.BOOK_OF_CONQUEST then
    if wakaba.killcount <= wakaba:GetMaxConquestCount(player) then
      player:SetActiveCharge(200000, slot)
    else
      player:SetActiveCharge(0, slot)
    end
  end
end

function wakaba:PlayerUpdate_Conquest(player)
	if player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Shiori", false)
	and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("ShioriB", true)
	and player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
	and player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST)
	then
    wakaba:SetConquestCharge(player, ActiveSlot.SLOT_PRIMARY)
    wakaba:SetConquestCharge(player, ActiveSlot.SLOT_SECONDARY)
    wakaba:SetConquestCharge(player, ActiveSlot.SLOT_POCKET)
	end
	if player:IsDead() and wakaba.conquestmode then
		wakaba.conquestmode = false
		if EID then
			EID.Config["HideInBattle"] = wakaba.eidHideInBattle
			EID:hidePermanentText()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Conquest)

function wakaba:ConquerEnemy(entity)
	entity:AddCharmed(EntityRef(player), -1)
	entity:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
	entity:GetData().wakaba = entity:GetData().wakaba or {}
	entity:GetData().wakaba.conquered = true
	wakaba.conqueredSeed[tostring(entity.InitSeed)] = true
end

function wakaba:ItemUse_BookOfConquest(_, rng, player, useFlags, activeSlot, varData)
	if wakaba.killcount > wakaba:GetMaxConquestCount(player) then
		SFXManager():Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
		return {Discharge = false}
	end
	if (wakaba:IsLunatic() or not wakaba:ShioriHasBook(player, wakaba.Enums.Collectibles.BOOK_OF_CONQUEST)) and wakaba.killcount > 40 then
		SFXManager():Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
		return {Discharge = false}
	end
	if useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY then return end
	wakaba:GetPlayerEntityData(player)
	if not wakaba.conquestmode then
		if (player:GetPlayerType() == Isaac.GetPlayerTypeByName("Shiori", false)
		or player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true)
		or player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_SHIORI))
		and useFlags & UseFlag.USE_VOID == 0
		and activeSlot ~= ActiveSlot.SLOT_POCKET2 then
			--Isaac.GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_PAUSE, UseFlag.USE_NOANIM)
			local entities = Isaac.FindInRadius(wakaba.GetGridCenter(), 2000, EntityPartition.ENEMY)
			local canConquerBosses = true
			for _, entity in ipairs(entities) do
				if entity:IsEnemy()
				and not entity:IsInvincible()
				and not (wakaba:has_value(wakaba.conquestblacklist, entity.Type) or entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY))
				and not (entity:IsBoss() and wakaba:has_value(wakaba.conquestsegmentwhitelist, entity.Type) and entity.Parent)
				and not (entity:IsBoss() and not canConquerBosses)
				then
					--table.insert(wakaba.conquestready, EntityRef(entity))
					table.insert(wakaba.conquestready, EntityRef(entity))
				end
			end
			wakaba.conquestreadycount = #wakaba.conquestready
			if wakaba.conquestreadycount <= 0 then
				player:AnimateSad()
				return {Discharge = false}
			end
			player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST, "UseItem", "PlayerPickup")
			player:GetData().wakaba.conquestmode = true
			player:GetData().wakaba.conquestcursor = 1
			local hasbirthright = player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			local hascarbattery = player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY) or wakaba:IsGoldenItem(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST, player)
			local target = wakaba.conquestready[player:GetData().wakaba.conquestcursor].Entity
			if REPENTOGON then
				camPos = target.Position
			else
				player.Position = Isaac.GetFreeNearPosition(target.Position, 64)
			end
			bombcost, keycost = wakaba:CalculateCost(target, hasbirthright, hascarbattery)
			wakaba.conquestcontrollerindex = player.ControllerIndex
			if EID then
				EID.Config["HideInBattle"] = false
			end
			wakaba.conquestmode = true
		else
			local hascarbattery = player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY) or wakaba:IsGoldenItem(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST, player)
			local entities = Isaac.FindInRadius(wakaba.GetGridCenter(), 2000, EntityPartition.ENEMY)
			for _, entity in ipairs(entities) do
				if entity:IsEnemy()
				and not entity:IsInvincible()
				and (not entity:IsBoss() or (entity:IsBoss() and hascarbattery))
				and not wakaba:has_value(wakaba.conquestblacklist, entity.Type)
				then
					entity:AddCharmed(EntityRef(player), -1)
					entity.HitPoints = entity.MaxHitPoints * 10
					local childentity = entity.Child
					wakaba:ConquerEnemy(entity)
					while childentity do
						wakaba:ConquerEnemy(childentity)
						childentity = childentity.Child
					end
					local entities = Isaac.FindInRadius(entity.Position, 2000, EntityPartition.ENEMY)
					for i, e in ipairs(entities) do
						if GetPtrHash(entity) ~= GetPtrHash(e) then
							if e.SpawnerEntity and GetPtrHash(e.SpawnerEntity) == GetPtrHash(entity) then
								if wakaba:has_value(wakaba.conquestsegmentwhitelist, e.Type) then
									wakaba:ConquerEnemy(e)
								else
									e:Die()
								end
							end
						end
					end
				end
			end
			wakaba:CalculateMinervaCost()
			SFXManager():Play(SoundEffect.SOUND_ANGEL_BEAM, 1, 0, false, 1)
			if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
				player:AnimateCollectible(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST, "UseItem", "PlayerPickup")
			end
		end
	else
		if wakaba.conquestcontrollerindex ~= player.ControllerIndex then
			SFXManager():Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
			return {Discharge = false}
		end
		--Isaac.GetPlayer():UseActiveItem(CollectibleType.COLLECTIBLE_PAUSE, UseFlag.USE_NOANIM)
		local conquestcursor = player:GetData().wakaba.conquestcursor
		target = wakaba.conquestready[conquestcursor]
		if target ~= nil then
			if bombcost > 0 and player:GetNumBombs() < bombcost then
				SFXManager():Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
				return
			end
			if keycost > 0 and player:GetNumKeys() < keycost then
				SFXManager():Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
				return
			end
			player:AddBombs(-bombcost)
			player:AddKeys(-keycost)
			local childentity = target.Entity.Child
			wakaba:ConquerEnemy(target.Entity)
			while childentity do
				wakaba:ConquerEnemy(childentity)
				childentity = childentity.Child
			end
			local entities = Isaac.FindInRadius(target.Position, 2000, EntityPartition.ENEMY)
			for i, e in ipairs(entities) do
				if GetPtrHash(target) ~= GetPtrHash(e) then
					if e.SpawnerEntity and GetPtrHash(e.SpawnerEntity) == GetPtrHash(target.Entity) then
						if wakaba:has_value(wakaba.conquestsegmentwhitelist, e.Type) then
							wakaba:ConquerEnemy(e)
						else
							e:Die()
						end
					end
				end
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) then
				player:AddWisp(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST, player.Position)
			end
			SFXManager():Play(SoundEffect.SOUND_ANGEL_BEAM, 1, 0, false, 1)
			--wakaba:initSingleCrack(player, target.Position)
			--[[ if player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true)
			and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then

			end ]]

			local entities = Isaac.GetRoomEntities()
			for _, entity in ipairs(entities) do
				entity:ClearEntityFlags(EntityFlag.FLAG_FREEZE)
			end
		end
		wakaba:CalculateMinervaCost()
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.conquestmode = false
		player:GetData().wakaba.conquestcursor = nil
		wakaba.conquestready = {}
		wakaba.conquestreadycount = 0
		bombcost, keycost = 0, 0
		wakaba.conquestcooltime = 15
		player:SetMinDamageCooldown(60)
		if EID then
			EID.Config["HideInBattle"] = wakaba.eidHideInBattle
			EID:hidePermanentText()
		end
		wakaba.conquestmode = false
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfConquest, wakaba.Enums.Collectibles.BOOK_OF_CONQUEST)

function wakaba:CalculateCost(entity, hasbirthright, hascarbattery)
	if wakaba:has_value(wakaba.conquestblacklist, entity) then
		return false
	end
	hasbirthright = hasbirthright or false
	hascarbattery = hascarbattery or false
	local bombdelimiter = 45 -- 1 bomb per 35 hp
	local keydelimiter = 25 -- 1 key per 12 hp
	if wakaba.G.Difficulty == Difficulty.DIFFICULTY_HARD or wakaba.G.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
		bombdelimiter = 30
		keydelimiter = 10
	end
	if hasbirthright then
		bombdelimiter = bombdelimiter + 16
		keydelimiter = keydelimiter + 6
	end
	if hascarbattery then
		bombdelimiter = bombdelimiter + 16
	end
	local basecost = entity.MaxHitPoints
	local bombcost = 0
	local keycost = 0
	if entity:IsBoss() then
		bombcost = basecost // bombdelimiter
		if bombcost <= 0 then
			bombcost = 1
		end
	end
	keycost = basecost // keydelimiter
	if keycost <= 0 then
		keycost = 1
	end

	return bombcost, keycost

end

function wakaba:Render_BookOfConquest()
	local room = wakaba.G:GetRoom()
	local hasconquest = false
	local alpha = wakaba.runstate.currentalpha
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST) then
			hasconquest = true
		end
	end
	local entities = Isaac.FindInRadius(wakaba.GetGridCenter(), 2000, EntityPartition.ENEMY)
	for _, entity in ipairs(entities) do

		if entity.Type == EntityType.ENTITY_PITFALL and entity.SpawnerEntity and wakaba.conqueredSeed[tostring(entity.SpawnerEntity.InitSeed)] then
			entity:Remove()
		end

		if entity:GetData().wakaba and entity:GetData().wakaba.conquered then
			entity:AddCharmed(EntityRef(player), -1)
			entity:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
		elseif wakaba.conqueredSeed[tostring(entity.InitSeed)] and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			--print(entity.Type, "!!!")
			entity:AddCharmed(EntityRef(player), -1)
		elseif entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			--[[ if entity:IsBoss() and not entity:HasEntityFlags(EntityFlag.FLAG_PERSISTENT) then
				entity:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
			end ]]
			if entity.Type == EntityType.ENTITY_RAGLING and entity.Variant == 1 then
				entity.Parent = nil
				entity.SpawnerEntity = nil
			end
		end
	end
--[[
	if hasconquest and wakaba.G:GetHUD():IsVisible() then
		local o = wakaba:GetScreenSize()
		local c = wakaba:GetScreenCenter()
		local x, y = wakaba.hudoffset(10, c.X - 25, 0, "topleft")
		if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_CALC then
			wakaba.pickupdisplaySptite:SetFrame("Idle", wakaba.pickupSpriteIndex.BROKEN)
			wakaba.pickupdisplaySptite:Render(Vector(x - 16, y) - wakaba.G.ScreenShakeOffset, Vector(0,0), Vector(0,0))
			wakaba.pickupdisplaySptite.Color = Color(1,1,1,1,0,0,0)
			local color = KColor(1,1,1,1,0,0,0)
			if wakaba.killcount >= 60 then
				color = KColor(1,0.2,0.2,1,0,0,0)
			end
			local res = (100 - math.floor(wakaba.killcount))
			if res <= 0 then res = 0 end
			wakaba.f:DrawString(res .. "/100", x, y ,color,0,true)
		else
			wakaba.pickupdisplaySptite:SetFrame("Idle", wakaba.pickupSpriteIndex.RED_HEART)
			wakaba.pickupdisplaySptite:Render(Vector(x - 16, y) - wakaba.G.ScreenShakeOffset, Vector(0,0), Vector(0,0))
			wakaba.pickupdisplaySptite.Color = Color(1,1,1,1,0,0,0)
			wakaba.f:DrawString(math.floor(wakaba.killcount) .. "/160", x, y ,KColor(1,1,1,1,0,0,0),0,true)
		end
	end
 ]]
	if wakaba.conquestmode then
		local isGolden = wakaba:IsGoldenItem(wakaba.Enums.Collectibles.BOOK_OF_CONQUEST)
		local conqstr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].bookofconquest) or wakaba.descriptions["en_us"].bookofconquest
		local eidstring = "#"..conqstr.selectstr..": {{ButtonX}}/{{ButtonB}}"
		eidstring = eidstring .."#"..conqstr.selectenemy..": {{ColorBookofConquest}}{{{SelectedEnemy}}}"
		eidstring = eidstring .."#!!! "..conqstr.selectreq.." :"
		if REPENTOGON then
			room:SetPauseTimer(2)
		else
			local entities = Isaac.GetRoomEntities()
			for _, entity in ipairs(entities) do
				entity:AddEntityFlags(EntityFlag.FLAG_FREEZE)
			end
		end
		--Isaac.GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_PAUSE, UseFlag.USE_NOANIM)
		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			local hasbirthright = player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			local hascarbattery = player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY) or isGolden
			local iscontrolling = wakaba.conquestcontrollerindex == player.ControllerIndex

			if player:GetData().wakaba and player:GetData().wakaba.conquestmode then
				if Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
				or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
				or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
				or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
				then
					if not REPENTOGON then
						for _, entity in ipairs(entities) do
							entity:ClearEntityFlags(EntityFlag.FLAG_FREEZE)
						end
					end
					player:GetData().wakaba.conquestmode = false
					player:GetData().wakaba.conquestcursor = nil
					wakaba.conquestready = {}
					wakaba.conquestreadycount = 0
					bombcost, keycost = 0, 0
					if EID then
						EID.Config["HideInBattle"] = wakaba.eidHideInBattle
						EID:hidePermanentText()
					end
					wakaba.conquestmode = false
					return
				end
				local target = nil
				--player:GetData().wakaba.conquestcursor = player:GetData().wakaba.conquestcursor or 0
				local conquestcursor = player:GetData().wakaba.conquestcursor
				if (Input.IsActionTriggered(ButtonAction.ACTION_LEFT, player.ControllerIndex) or Input.IsActionTriggered(ButtonAction.ACTION_UP, player.ControllerIndex)) and iscontrolling then
					SFXManager():Play(SoundEffect.SOUND_CHARACTER_SELECT_LEFT, 1, 0, false, 1)
					while (not target or target:IsDead()) do
						player:GetData().wakaba.conquestcursor = player:GetData().wakaba.conquestcursor - 1
						if player:GetData().wakaba.conquestcursor <= 0 then
							player:GetData().wakaba.conquestcursor = wakaba.conquestreadycount
						end
						target = wakaba.conquestready[player:GetData().wakaba.conquestcursor].Entity
					end
					if REPENTOGON then
						camPos = target.Position
					else
						player.Position = Isaac.GetFreeNearPosition(target.Position, 64)
					end
					bombcost, keycost = wakaba:CalculateCost(target, hasbirthright, hascarbattery)
				elseif (Input.IsActionTriggered(ButtonAction.ACTION_RIGHT, player.ControllerIndex) or Input.IsActionTriggered(ButtonAction.ACTION_DOWN, player.ControllerIndex)) and iscontrolling then
					SFXManager():Play(SoundEffect.SOUND_CHARACTER_SELECT_RIGHT, 1, 0, false, 1)
					while (not target or target:IsDead()) do
						player:GetData().wakaba.conquestcursor = player:GetData().wakaba.conquestcursor + 1
						if player:GetData().wakaba.conquestcursor > wakaba.conquestreadycount then
							player:GetData().wakaba.conquestcursor = 1
						end
						target = wakaba.conquestready[player:GetData().wakaba.conquestcursor].Entity
					end
					if REPENTOGON then
						camPos = target.Position
					else
						player.Position = Isaac.GetFreeNearPosition(target.Position, 64)
					end
					bombcost, keycost = wakaba:CalculateCost(target, hasbirthright, hascarbattery)
				end
				player.Velocity = Vector.Zero
				--print("cursor", conquestcursor)
				target = player:GetData().wakaba.conquestcursor and wakaba.conquestready[player:GetData().wakaba.conquestcursor] and wakaba.conquestready[player:GetData().wakaba.conquestcursor].Entity
				--print(target.Type, (target.Parent and target.Parent.Type), (target.Child and target.Child.Type))
				local s = "+" .. player:GetData().wakaba.conquestcursor .. "/" ..wakaba.conquestreadycount
				wakaba.f:DrawStringScaledUTF8(s, Isaac.WorldToScreen(player.Position).X - wakaba.G.ScreenShakeOffset.X, Isaac.WorldToScreen(player.Position).Y - wakaba.G.ScreenShakeOffset.Y, 1, 1, KColor(1,1,1,1,0,0,0),0,true)
				if target ~= nil then
					local canConquer = true
					eidstring = string.gsub(eidstring, "{{{SelectedEnemy}}}", getNameEntity(target))
					--eidstring = eidstring .. "# {{ColorPink}}"..target.Name.."{{CR}}"
					local bcolor, kcolor = KColor(1,1,1,1,0,0,0), KColor(1,1,1,1,0,0,0)
					if player:GetNumBombs() < bombcost then
						bcolor = KColor(1,0,0,1,0,0,0)
						canConquer = false
					end
					if player:GetNumKeys() < keycost then
						kcolor = KColor(1,0,0,1,0,0,0)
						canConquer = false
					end
					if player:GetNumKeys() < keycost then
						eidstring = eidstring .. " " .. "{{ColorRed}}" .. math.floor(keycost // 1) .. "{{Key}}{{CR}}"
					elseif isGolden then
						eidstring = eidstring .. " " .. "{{ColorGold}}" .. math.floor(keycost // 1) .. "{{Key}}{{CR}}"
					else
						eidstring = eidstring .. " " .. math.floor(keycost // 1) .. "{{Key}}{{CR}}"
					end
					if bombcost > 0 then
						wakaba.pickupdisplaySptite:SetFrame("Idle", wakaba.pickupSpriteIndex.BOMB)
						wakaba.pickupdisplaySptite:Render(Vector(Isaac.WorldToScreen(target.Position).X - 13, Isaac.WorldToScreen(target.Position).Y - 35) - wakaba.G.ScreenShakeOffset, Vector(0,0), Vector(0,0))
						wakaba.f:DrawStringScaledUTF8("x" .. player:GetNumBombs() .. "/" .. (bombcost // 1), Isaac.WorldToScreen(target.Position).X - wakaba.G.ScreenShakeOffset.X, Isaac.WorldToScreen(target.Position).Y - 35 - wakaba.G.ScreenShakeOffset.Y, 1, 1, bcolor,0,true)
						if player:GetNumBombs() < bombcost then
							eidstring = eidstring .. " " .. "{{ColorRed}}" .. math.floor(bombcost // 1) .. "{{Bomb}}{{CR}}"
						elseif isGolden then
							eidstring = eidstring .. " " .. "{{ColorGold}}" .. math.floor(bombcost // 1) .. "{{Bomb}}{{CR}}"
						else
							eidstring = eidstring .. " " .. math.floor(bombcost // 1) .. "{{Bomb}}{{CR}}"
						end
					end
					wakaba.pickupdisplaySptite:SetFrame("Idle", wakaba.pickupSpriteIndex.KEY)
					wakaba.pickupdisplaySptite:Render(Vector(Isaac.WorldToScreen(target.Position).X - 13, Isaac.WorldToScreen(target.Position).Y - 25) - wakaba.G.ScreenShakeOffset, Vector(0,0), Vector(0,0))
					wakaba.f:DrawStringScaledUTF8("x" .. player:GetNumKeys() .. "/" .. (keycost // 1), Isaac.WorldToScreen(target.Position).X - wakaba.G.ScreenShakeOffset.X, Isaac.WorldToScreen(target.Position).Y - 25 - wakaba.G.ScreenShakeOffset.Y, 1, 1, kcolor,0,true)

					if target:IsBoss() then
						eidstring = eidstring .. "#!!! {{ColorCyan}}"..conqstr.selectboss.."{{CR}}"
					end

					if canConquer then
						eidstring = eidstring .. "#!!! "..conqstr.selectconq..""
					else
						eidstring = eidstring .. "#!!! {{ColorError}}"..conqstr.selecterr..""
					end
					eidstring = eidstring .. "#"..conqstr.selectexit..""

					target:SetColor(Color(1, 1, 1, 1, 0.3, 0.2, 0.7), 1, 1, true, false)
				end
			end
		end
		if EID then
			local demoDescObj = EID:getDescriptionObj(5, 100, wakaba.Enums.Collectibles.BOOK_OF_CONQUEST)
			demoDescObj.Description = eidstring
			EID:displayPermanentText(demoDescObj)
		end
	else

	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_BookOfConquest)

if REPENTOGON then
	function wakaba:Camera_Conquest()
		if wakaba.conquestmode and camPos then
			local room = wakaba.G:GetRoom()
			--print(camPos, room:GetRenderScrollOffset())
			if Options.CameraStyle == 1 then
				room:GetCamera():SetFocusPosition(camPos)
			else
				room:GetCamera():SnapToPosition(camPos)
			end
		end
	end
	--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Camera_Conquest)
	wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Camera_Conquest)
end

function wakaba:Update_BookOfConquest()
	if wakaba.conquestcooltime > 0 then
		wakaba.conquestcooltime = wakaba.conquestcooltime - 1
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Update_BookOfConquest)

function wakaba:TakeDmg_BookOfConquest(entity, amount, flag, source, countdownFrames)
	if wakaba.conquestmode or wakaba.conquestcooltime > 0 then return false end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_BookOfConquest)


function wakaba:NewRoom_BookOfConquest()
	local entities = Isaac.FindInRadius(wakaba.GetGridCenter(), 5000, EntityPartition.ENEMY)
	for _, entity in ipairs(entities) do
		--[[ if entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			if entity:IsBoss() and not entity:HasEntityFlags(EntityFlag.FLAG_PERSISTENT) then
				entity:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
			end
			entity.Position = Isaac.GetPlayer().Position
		else ]]if entity:GetData().wakaba and entity:GetData().wakaba.conquered then
			entity:AddCharmed(EntityRef(player), -1)
			entity:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
			entity.Position = Isaac.GetPlayer().Position
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_BookOfConquest)

function wakaba:preEntitySpawn_Conquest(type, variant, subType, pos, velocity, spawner, seed)
	if type == EntityType.ENTITY_BOMB or type == EntityType.ENTITY_PITFALL then
		--[[ print(type, variant, subType, seed)
		if spawner then
			print(type, variant, subType, seed, spawner.Type, spawner.InitSeed, spawner.DropSeed)
			print(wakaba.conqueredSeed[tostring(spawner.InitSeed)])
		end ]]
		if spawner and wakaba.conqueredSeed[tostring(spawner.InitSeed)] then
			wakaba.conqueredSeed[tostring(seed)] = true
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, wakaba.preEntitySpawn_Conquest)

function wakaba:NewLevel_Conquest()
	wakaba.conqueredSeed = {}
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_Conquest)

function wakaba:HUD_BookOfConquest()
	local hasConquest = false
	wakaba:ForAllPlayers(function(player)
		if player.FrameCount > 7 then
			hasConquest = hasConquest or wakaba:ShioriHasBook(player, wakaba.Enums.Collectibles.BOOK_OF_CONQUEST)
		end
	end)
	if hasConquest then
		wakaba.globalHUDSprite:RemoveOverlay()
		wakaba.globalHUDSprite:SetFrame("BookOfConquest", 0)
		local loc = wakaba:getOptionValue("hud_conquest")
		local tab = {
			Sprite = wakaba.globalHUDSprite,
			Text = math.floor(wakaba.killcount) .. "/" .. wakaba:GetMaxConquestCount(),
			Location = loc,
			SpriteOptions = {
				Anim = "BookOfConquest",
				Frame = 0,
				OverlayAnim = nil,
				OverlayFrame = nil,
			},
		}
		if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_CALC then
			wakaba.globalHUDSprite:SetFrame("BookOfConquest", 1)
			if wakaba.killcount >= 60 then
				tab.TextColor = KColor(1,0.2,0.2,1,0,0,0)
			end
			local res = (100 - math.floor(wakaba.killcount))
			if res <= 0 then res = 0 end
			tab.Text = res .. "/100"
		end
		return tab
	end
end
wakaba:AddCallback(wakaba.Callback.RENDER_GLOBAL_FOUND_HUD, wakaba.HUD_BookOfConquest)