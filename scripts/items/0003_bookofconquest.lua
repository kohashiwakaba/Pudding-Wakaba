wakaba.COLLECTIBLE_BOOK_OF_CONQUEST = Isaac.GetItemIdByName("Book of Conquest")
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
wakaba.conquestready = {}
wakaba.conquestreadycount = 0
local bombcost, keycost = 0, 0
wakaba.eidHideInBattle = EID and EID.Config["HideInBattle"]

local function getNameEntity(entity)
	if not EID then return "Book of Conquest requires EID" end
	if not entity then return "No entity Found" end
	local entityType = entity.Type
	local entityVariant = entity.Variant
	local e = entityType .. "." .. entityVariant
	local eWithZero = string.gsub(e, "-1", "0")
	local name = EID.XMLEntityNames[e] or EID.XMLEntityNames[eWithZero] or e
	if name == e then return "(No name or modded)" end

	return name
end

function wakaba:SetConquestCharge(player, slot)
  if player == nil then return end
  local slot = slot or ActiveSlot.SLOT_PRIMARY
  local activeItem = player:GetActiveItem(slot)
  if activeItem <= 0 then return end
  local activeConfig = wakaba.itemConfig:GetCollectible(activeItem)
  if activeConfig == nil then return end
  local maxCharges = activeConfig.MaxCharges
  local chargeType = activeConfig.ChargeType
  if activeItem == wakaba.COLLECTIBLE_BOOK_OF_CONQUEST then
    if wakaba.killcount <= 160 then
      player:SetActiveCharge(200000, slot)
    else
      player:SetActiveCharge(0, slot)
    end
  end
end

function wakaba:PlayerUpdate_Conquest(player)
	if player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Shiori", false) 
	and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("ShioriB", true) 
	and player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_SHIORI)
	and player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_CONQUEST)
	then
    wakaba:SetConquestCharge(player, ActiveSlot.SLOT_PRIMARY)
    wakaba:SetConquestCharge(player, ActiveSlot.SLOT_SECONDARY)
    wakaba:SetConquestCharge(player, ActiveSlot.SLOT_POCKET)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Conquest)

function wakaba:ConquerEnemy(entity)
	entity:AddCharmed(EntityRef(player), -1)
	entity:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
	entity:GetData().wakaba = entity:GetData().wakaba or {}
	entity:GetData().wakaba.conquered = true
end

function wakaba:ItemUse_BookOfConquest(_, rng, player, useFlags, activeSlot, varData)
	if wakaba.killcount > 160 then
		SFXManager():Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
		return {Discharge = false}
	end
	if useFlags & UseFlag.USE_CARBATTERY == UseFlag.USE_CARBATTERY then return end 
	wakaba:GetPlayerEntityData(player)
	if not wakaba.conquestmode then
		if (player:GetPlayerType() == Isaac.GetPlayerTypeByName("Shiori", false) 
		or player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) 
		or player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_SHIORI))
		and useFlags & UseFlag.USE_VOID == 0
		and activeSlot ~= ActiveSlot.SLOT_POCKET2 then
			--Isaac.GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_PAUSE, UseFlag.USE_NOANIM)
			local entities = Isaac.FindInRadius(wakaba.GetGridCenter(), 2000, EntityPartition.ENEMY)
			for _, entity in ipairs(entities) do
				if entity:IsEnemy() 
				and not entity:IsInvincible()
				and not (wakaba:has_value(wakaba.conquestblacklist, entity.Type) or entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY))
				and not (entity:IsBoss() and wakaba:has_value(wakaba.conquestsegmentwhitelist, entity.Type) and entity.Parent)
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
			player:AnimateCollectible(wakaba.COLLECTIBLE_BOOK_OF_CONQUEST, "UseItem", "PlayerPickup")
			player:GetData().wakaba.conquestmode = true
			player:GetData().wakaba.conquestcursor = 1
			local hasbirthright = player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			local hascarbattery = player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY)
			local target = wakaba.conquestready[player:GetData().wakaba.conquestcursor].Entity
			player.Position = Isaac.GetFreeNearPosition(target.Position, 64)
			bombcost, keycost = wakaba:CalculateCost(target, hasbirthright, hascarbattery)
			wakaba.conquestcontrollerindex = player.ControllerIndex
			if EID then
				EID.Config["HideInBattle"] = false
			end
			wakaba.conquestmode = true
		else
			local entities = Isaac.FindInRadius(wakaba.GetGridCenter(), 2000, EntityPartition.ENEMY)
			for _, entity in ipairs(entities) do
				if entity:IsEnemy() 
				and not entity:IsInvincible()
				and (not entity:IsBoss() or (entity:IsBoss() and player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY)))
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
				player:AnimateCollectible(wakaba.COLLECTIBLE_BOOK_OF_CONQUEST, "UseItem", "PlayerPickup")
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
				player:AddWisp(wakaba.COLLECTIBLE_BOOK_OF_CONQUEST, player.Position)
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
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfConquest, wakaba.COLLECTIBLE_BOOK_OF_CONQUEST)

function wakaba:CalculateCost(entity, hasbirthright, hascarbattery)
	if wakaba:has_value(wakaba.conquestblacklist, entity) then
		return false
	end
	hasbirthright = hasbirthright or false
	hascarbattery = hascarbattery or false
	local bombdelimiter = 50 -- 1 bomb per 35 hp
	local keydelimiter = 25 -- 1 key per 12 hp
	if Game().Difficulty == Difficulty.DIFFICULTY_HARD or Game().Difficulty == Difficulty.DIFFICULTY_GREEDIER then
		bombdelimiter = 42
		keydelimiter = 18
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
	local hasconquest = false
	local alpha = wakaba.state.currentalpha
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:HasCollectible(wakaba.COLLECTIBLE_BOOK_OF_CONQUEST) then
			hasconquest = true
		end
	end
	local entities = Isaac.FindInRadius(wakaba.GetGridCenter(), 2000, EntityPartition.ENEMY)
	for _, entity in ipairs(entities) do
		
		if entity:GetData().wakaba and entity:GetData().wakaba.conquered then
			entity:AddCharmed(EntityRef(player), -1)
			entity:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
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

	if hasconquest and Game():GetHUD():IsVisible() then
		local o = wakaba:GetScreenSize()
		local c = wakaba:GetScreenCenter()
		local x, y = wakaba.hudoffset(10, c.X - 25, 0, "topleft")
		if Game().Challenge == wakaba.challenges.CHALLENGE_CALC then
			wakaba.pickupdisplaySptite:SetFrame("Idle", wakaba.pickupSpriteIndex.BROKEN)
			wakaba.pickupdisplaySptite:Render(Vector(x - 16, y) - Game().ScreenShakeOffset, Vector(0,0), Vector(0,0))
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
			wakaba.pickupdisplaySptite:Render(Vector(x - 16, y) - Game().ScreenShakeOffset, Vector(0,0), Vector(0,0))
			wakaba.pickupdisplaySptite.Color = Color(1,1,1,1,0,0,0)
			wakaba.f:DrawString(math.floor(wakaba.killcount) .. "/160", x, y ,KColor(1,1,1,1,0,0,0),0,true)
		end
	end

	if wakaba.conquestmode then
		local conqstr = (EID and wakaba.descriptions[EID:getLanguage()] and wakaba.descriptions[EID:getLanguage()].bookofconquest) or wakaba.descriptions["en_us"].bookofconquest
		local eidstring = "#"..conqstr.selectstr..": {{ButtonX}}/{{ButtonB}}"
		eidstring = eidstring .."#"..conqstr.selectenemy..": {{ColorBookofConquest}}{{{SelectedEnemy}}}"
		eidstring = eidstring .."#!!! "..conqstr.selectreq.." :"
		local entities = Isaac.GetRoomEntities()
		for _, entity in ipairs(entities) do
			entity:AddEntityFlags(EntityFlag.FLAG_FREEZE)
		end
		--Isaac.GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_PAUSE, UseFlag.USE_NOANIM)
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			local hasbirthright = player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			local hascarbattery = player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY)
			local iscontrolling = wakaba.conquestcontrollerindex == player.ControllerIndex

			if player:GetData().wakaba and player:GetData().wakaba.conquestmode then
				if Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
				or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
				or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
				or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
				then
					for _, entity in ipairs(entities) do
						entity:ClearEntityFlags(EntityFlag.FLAG_FREEZE)
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
					player.Position = Isaac.GetFreeNearPosition(target.Position, 64)
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
					player.Position = Isaac.GetFreeNearPosition(target.Position, 64)
					bombcost, keycost = wakaba:CalculateCost(target, hasbirthright, hascarbattery)
				end
				player.Velocity = Vector.Zero
				--print("cursor", conquestcursor)
				target = player:GetData().wakaba.conquestcursor and wakaba.conquestready[player:GetData().wakaba.conquestcursor] and wakaba.conquestready[player:GetData().wakaba.conquestcursor].Entity
				--print(target.Type, (target.Parent and target.Parent.Type), (target.Child and target.Child.Type))
				local s = "+" .. player:GetData().wakaba.conquestcursor .. "/" ..wakaba.conquestreadycount
				wakaba.f:DrawStringScaledUTF8(s, Isaac.WorldToScreen(player.Position).X - Game().ScreenShakeOffset.X, Isaac.WorldToScreen(player.Position).Y - Game().ScreenShakeOffset.Y, 1, 1, KColor(1,1,1,1,0,0,0),0,true)
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
					eidstring = eidstring .. " " .. (player:GetNumKeys() < keycost and "{{ColorRed}}" or "") .. math.floor(keycost // 1) .. "{{Key}}{{CR}}"
					if bombcost > 0 then
						wakaba.pickupdisplaySptite:SetFrame("Idle", wakaba.pickupSpriteIndex.BOMB)
						wakaba.pickupdisplaySptite:Render(Vector(Isaac.WorldToScreen(target.Position).X - 13, Isaac.WorldToScreen(target.Position).Y - 35) - Game().ScreenShakeOffset, Vector(0,0), Vector(0,0))
						wakaba.f:DrawStringScaledUTF8("x" .. player:GetNumBombs() .. "/" .. (bombcost // 1), Isaac.WorldToScreen(target.Position).X - Game().ScreenShakeOffset.X, Isaac.WorldToScreen(target.Position).Y - 35 - Game().ScreenShakeOffset.Y, 1, 1, bcolor,0,true)
						eidstring = eidstring .. " + " .. (player:GetNumBombs() < bombcost and "{{ColorRed}}" or "") .. math.floor(bombcost // 1) .. "{{Bomb}}"
					end
					wakaba.pickupdisplaySptite:SetFrame("Idle", wakaba.pickupSpriteIndex.KEY)
					wakaba.pickupdisplaySptite:Render(Vector(Isaac.WorldToScreen(target.Position).X - 13, Isaac.WorldToScreen(target.Position).Y - 25) - Game().ScreenShakeOffset, Vector(0,0), Vector(0,0))
					wakaba.f:DrawStringScaledUTF8("x" .. player:GetNumKeys() .. "/" .. (keycost // 1), Isaac.WorldToScreen(target.Position).X - Game().ScreenShakeOffset.X, Isaac.WorldToScreen(target.Position).Y - 25 - Game().ScreenShakeOffset.Y, 1, 1, kcolor,0,true)
					
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
			local demoDescObj = EID:getDescriptionObj(5, 100, wakaba.COLLECTIBLE_BOOK_OF_CONQUEST)
			demoDescObj.Description = eidstring
			EID:displayPermanentText(demoDescObj)
		end
	else
		
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_BookOfConquest)

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