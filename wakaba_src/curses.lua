local isc = require("wakaba_src.libs.isaacscript-common")
local blackcandletrigger = false

if Isaac.GetCurseIdByName("Curse of Blight") > 0 then
	wakaba.curses.CURSE_OF_BLIGHT = 1 << (Isaac.GetCurseIdByName("Curse of Blight") - 1)
end

local function IsExtraRoom(idx)
	local isExtraRoom = false
	local room = wakaba.G:GetRoom()
	if  wakaba.G:IsPaused() or room:GetFrameCount() < 5 then
		return true
	end
	if SamaelMod then
		if SamaelMod.IsFragmentRoom and SamaelMod.IsDeathDealRoom then
			isExtraRoom = SamaelMod:IsFragmentRoom(idx) or SamaelMod:IsDeathDealRoom(idx)
		else
			isExtraRoom = wakaba.G:GetRoom():GetFrameCount() < 2
		end
	end
	return isExtraRoom
end

function wakaba:ShouldRemoveBlind()
	local returnVal
	wakaba:ForAllPlayers(function(player)
		if wakaba:HasBless(player)
		or wakaba:HasNemesis(player)
		or wakaba:HasShiori(player)
		or wakaba:hasLunarStone(player)
		or wakaba:hasElixir(player)
		or wakaba:hasRibbon(player)
		or wakaba:hasWaterFlame(player)
		or wakaba:hasChimaki(player)
		then
			returnVal = true
		end
	end)
	return returnVal
end

function wakaba:PostGetCollectible_BlackCandle(player, item)
	if isc:hasCurse(wakaba.curses.CURSE_OF_FLAMES) and not isc:anyPlayerIs(wakaba.Enums.Players.RICHER_B) then
		wakaba.G:GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_FLAMES)
	end
	if isc:hasCurse(wakaba.curses.CURSE_OF_FAIRY) then
		wakaba.G:GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_FAIRY)
	end
	if isc:hasCurse(wakaba.curses.CURSE_OF_SNIPER) then
		wakaba.G:GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_SNIPER)
	end
	if isc:hasCurse(wakaba.curses.CURSE_OF_AMNESIA) then
		wakaba.G:GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_AMNESIA)
	end
	if isc:hasCurse(wakaba.curses.CURSE_OF_MAGICAL_GIRL) then
		wakaba.G:GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_MAGICAL_GIRL)
	end
	if CURCOL and isc:hasCurse(wakaba.curses.CURSE_OF_BLIGHT) then
		wakaba.G:GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_BLIGHT)
	end
end
wakaba:AddCallback(wakaba.Callback.POST_GET_COLLECTIBLE, wakaba.PostGetCollectible_BlackCandle, CollectibleType.COLLECTIBLE_BLACK_CANDLE)

function wakaba:Curse_BlackCandleCheck(player)
	local curse = wakaba.G:GetLevel():GetCurses() 
	if player:GetPlayerType() == wakaba.Enums.Players.SHIORI
	and wakaba.runstate.currentshiorimode == wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR
	and wakaba.G.Challenge == Challenge.CHALLENGE_NULL
	and curse & wakaba.curses.CURSE_OF_SATYR ~= wakaba.curses.CURSE_OF_SATYR
	then
		wakaba.G:GetLevel():RemoveCurses(wakaba.G:GetLevel():GetCurses())
		wakaba.G:GetLevel():AddCurse(wakaba.curses.CURSE_OF_SATYR, false)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Curse_BlackCandleCheck)

function wakaba:Curse_Evaluate(curse)
	local skip = false
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if wakaba.curses.CURSE_OF_SATYR > 0 
		and player:GetPlayerType() == wakaba.Enums.Players.SHIORI
		and ((wakaba.state.options.shiorimodes == wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR and wakaba.G.TimeCounter == 0)
		or wakaba.runstate.currentshiorimode == wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR) then
			curse = curse | wakaba.curses.CURSE_OF_SATYR
			skip = true
			goto wakabaCurseSkip
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) then
			skip = true
			goto wakabaCurseSkip
		end
		if player:GetPlayerType() == wakaba.Enums.Players.RICHER and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			skip = true
			goto wakabaCurseSkip
		end
		-- Not checking for blight here, since Pudding and Wakaba loads before Cursed Collection
		if wakaba:ShouldRemoveBlind() then
			if isc:hasCurse(LevelCurse.CURSE_OF_BLIND) then
				curse = isc:removeFlag(curse, LevelCurse.CURSE_OF_BLIND)
			end
		end
		if wakaba:hasElixir(player) then
			if isc:hasCurse(LevelCurse.CURSE_OF_THE_UNKNOWN) then
				curse = isc:removeFlag(curse, LevelCurse.CURSE_OF_THE_UNKNOWN)
			end
		end
		if player:HasCollectible(wakaba.Enums.Collectibles.RED_CORRUPTION) then
			curse = isc:removeFlag(curse, LevelCurse.CURSE_OF_THE_LOST | wakaba.curses.CURSE_OF_FAIRY)
		end
		if player:HasCollectible(wakaba.Enums.Collectibles.FIREFLY_LIGHTER) then
			curse = isc:removeFlag(curse, LevelCurse.CURSE_OF_DARKNESS)
		end
		if wakaba:hasRibbon(player) then
			if isc:hasCurse(LevelCurse.CURSE_OF_DARKNESS) then
				curse = isc:removeFlag(curse, LevelCurse.CURSE_OF_DARKNESS)
				curse = isc:addFlag(curse, wakaba.curses.CURSE_OF_SNIPER)
			end
			if isc:hasCurse(LevelCurse.CURSE_OF_THE_LOST) then
				curse = isc:removeFlag(curse, LevelCurse.CURSE_OF_THE_LOST)
				curse = isc:addFlag(curse, wakaba.curses.CURSE_OF_FAIRY)
			end
			if isc:hasCurse(LevelCurse.CURSE_OF_MAZE) then
				curse = isc:removeFlag(curse, LevelCurse.CURSE_OF_MAZE)
				curse = isc:addFlag(curse, wakaba.curses.CURSE_OF_AMNESIA)
			end
			if isc:hasCurse(LevelCurse.CURSE_OF_THE_UNKNOWN) then
				curse = isc:removeFlag(curse, LevelCurse.CURSE_OF_THE_UNKNOWN)
				curse = isc:addFlag(curse, wakaba.curses.CURSE_OF_MAGICAL_GIRL)
			end
		end
		if not skip and wakaba.runstate.pendingCurseImmunityCount > 0 and curse & ~wakaba.curses.CURSE_OF_SATYR > 0 then
			Isaac.DebugString("[wakaba] Curse "..curse.." found! Preventing from Richer's Uniform...")
			wakaba.runstate.pendingCurseImmunityCount = wakaba.runstate.pendingCurseImmunityCount - 1
			curse = isc:removeFlag(curse, curse & ~wakaba.curses.CURSE_OF_SATYR)
			skip = true
			goto wakabaCurseSkip
		end

	end
	::wakabaCurseSkip::
	if skip then return curse end
	if wakaba.curses.CURSE_OF_FLAMES <= LevelCurse.CURSE_OF_GIANT or wakaba.state.options.flamescurserate == 0 then return curse end
	if wakaba.state.options.flamesoverride then
		local newflamescurserate = wakaba.state.options.flamescurserate * 1
		newflamescurserate = newflamescurserate / 6 -- Base curse rate 
		local rng = wakaba.RNG
		local rng = rng:RandomFloat() * 100
		if newflamescurserate >= rng then
			return wakaba.curses.CURSE_OF_FLAMES
		end
	elseif curse == LevelCurse.CURSE_NONE then
		local newflamescurserate = wakaba.state.options.flamescurserate * 1
		newflamescurserate = newflamescurserate / 3 -- Base curse rate 
		newflamescurserate = newflamescurserate / (LevelCurse.NUM_CURSES - 3) -- Curse selection rate
		local rng = wakaba.RNG
		local rng = rng:RandomFloat() * 100
		if newflamescurserate >= rng then
			return wakaba.curses.CURSE_OF_FLAMES
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, wakaba.Curse_Evaluate)


function wakaba:Curse_PlayerRender(player)
	local curse = wakaba.G:GetLevel():GetCurses()
	if wakaba:ShouldRemoveBlind() then
		if curse & LevelCurse.CURSE_OF_BLIND == LevelCurse.CURSE_OF_BLIND then
			wakaba.G:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_BLIND)
		end
		if CURCOL and curse & wakaba.curses.CURSE_OF_BLIGHT == wakaba.curses.CURSE_OF_BLIGHT then
			wakaba.G:GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_BLIGHT)
		end
	end
	if wakaba:hasElixir(player) then
		local curse = wakaba.G:GetLevel():GetCurses()
		if curse & LevelCurse.CURSE_OF_THE_UNKNOWN == LevelCurse.CURSE_OF_THE_UNKNOWN then
			wakaba.G:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_THE_UNKNOWN)
		end
	end
	-- Force add curse for Black Candle/Sol
	if wakaba.curses.CURSE_OF_SATYR > LevelCurse.CURSE_OF_GIANT and player:GetPlayerType() == wakaba.Enums.Players.SHIORI and wakaba.runstate.currentshiorimode == wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR and not isc:hasCurse(wakaba.curses.CURSE_OF_SATYR) then
		wakaba.G:GetLevel():AddCurse(wakaba.curses.CURSE_OF_SATYR, false)
	end
	if player:GetPlayerType() == wakaba.Enums.Players.RICHER and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		wakaba.G:GetLevel():RemoveCurses(127 - (LevelCurse.CURSE_OF_LABYRINTH | LevelCurse.CURSE_OF_THE_CURSED))
	elseif wakaba.runstate.pendingCurseImmunityCount > 0 and curse & ~(LevelCurse.CURSE_OF_LABYRINTH | wakaba.curses.CURSE_OF_SATYR) > 0 and not IsExtraRoom() then
		Isaac.DebugString("[wakaba] Curse "..curse.." found! Preventing from Richer's Uniform...")
		wakaba.runstate.pendingCurseImmunityCount = wakaba.runstate.pendingCurseImmunityCount - 1
		wakaba.G:GetLevel():RemoveCurses(curse & ~(LevelCurse.CURSE_OF_LABYRINTH | wakaba.curses.CURSE_OF_SATYR))
	elseif wakaba:hasRibbon(player) and wakaba.curses.CURSE_OF_FLAMES > LevelCurse.CURSE_OF_GIANT then
		if isc:hasCurse(LevelCurse.CURSE_OF_DARKNESS) then
			wakaba.G:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_DARKNESS)
			wakaba.G:GetLevel():AddCurse(wakaba.curses.CURSE_OF_SNIPER, false)
		end
		if isc:hasCurse(LevelCurse.CURSE_OF_THE_LOST) and not IsExtraRoom() then
			wakaba.G:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_THE_LOST)
			wakaba.G:GetLevel():AddCurse(wakaba.curses.CURSE_OF_FAIRY, false)
		end
		if isc:hasCurse(LevelCurse.CURSE_OF_MAZE) then
			wakaba.G:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_MAZE)
			wakaba.G:GetLevel():AddCurse(wakaba.curses.CURSE_OF_AMNESIA, false)
		end
		if isc:hasCurse(LevelCurse.CURSE_OF_THE_UNKNOWN) then
			wakaba.G:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_THE_UNKNOWN)
			wakaba.G:GetLevel():AddCurse(wakaba.curses.CURSE_OF_MAGICAL_GIRL, false)
		end
	end
	if player:HasCollectible(wakaba.Enums.Collectibles.FIREFLY_LIGHTER) then
		wakaba.G:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_DARKNESS | wakaba.curses.CURSE_OF_SNIPER)
	end
	if player:HasCollectible(wakaba.Enums.Collectibles.RED_CORRUPTION) and not IsExtraRoom() then
		wakaba.G:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_THE_LOST | wakaba.curses.CURSE_OF_FAIRY)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Curse_PlayerRender)

if wakaba.curses.CURSE_OF_FLAMES > LevelCurse.CURSE_OF_GIANT then
	function wakaba:PlayerUpdate_Curse(player)
		if isc:inDeathCertificateArea() or isc:inGenesisRoom() then return end
		if wakaba.curses.CURSE_OF_FLAMES <= 0 then return end
		local curse = wakaba.G:GetLevel():GetCurses() 
		local isTaintedRicher = false
		local onlyTaintedRicher = true
		for i, player in ipairs(wakaba:getAllMainPlayers()) do
			if player:GetPlayerType() == wakaba.Enums.Players.RICHER_B then
				isTaintedRicher = true
			else
				onlyTaintedRicher = false
			end
		end
		if curse & wakaba.curses.CURSE_OF_FLAMES == wakaba.curses.CURSE_OF_FLAMES or isTaintedRicher then
			if not player:IsItemQueueEmpty() and player.QueuedItem.Item:IsCollectible() then
				local heldItem = player.QueuedItem.Item
				if not heldItem:HasTags(ItemConfig.TAG_SUMMONABLE) 
				or heldItem:HasTags(ItemConfig.TAG_QUEST) 
				or heldItem.ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT 
				then
					return
				end
				SFXManager():Stop(SoundEffect.SOUND_CHOIR_UNLOCK)
				SFXManager():Stop(SoundEffect.SOUND_POWERUP1)
				SFXManager():Stop(SoundEffect.SOUND_POWERUP2)
				SFXManager():Stop(SoundEffect.SOUND_POWERUP3)
				SFXManager():Stop(SoundEffect.SOUND_DEVILROOM_DEAL)
				if isc:dequeueItem(player) then
					--player:RemoveCollectible(heldItem.ID)
					local familiar
					familiar = player:AddItemWisp(heldItem.ID, player.Position, true)
					if familiar then
						familiar.Parent = collider
						familiar.Player = player
						if not isTaintedRicher and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
							familiar.HitPoints = familiar.MaxHitPoints * 2
						end
					end
		
					wakaba.G:GetLevel():UpdateVisibility()
					player:AnimateSad()
				end
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Curse)
--[[ 	
	function wakaba:Curse_PickupCollision(pickup, collider, low)
		if wakaba.curses.CURSE_OF_FLAMES <= 0 then return end
		if wakaba.G:GetRoom():GetType() == RoomType.ROOM_CHALLENGE then return end
		if wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSSRUSH then return end
		if not collider:ToPlayer() then return end
		local curse = wakaba.G:GetLevel():GetCurses() 
		if curse & wakaba.curses.CURSE_OF_FLAMES == wakaba.curses.CURSE_OF_FLAMES then
			local id = pickup.SubType
			if id == 0 then return end
			local config = Isaac.GetItemConfig():GetCollectible(id)
			if not (config.Type ~= ItemType.ITEM_ACTIVE) then return end
			if not (config:HasTags(ItemConfig.TAG_QUEST) or id == CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				local player = collider:ToPlayer()
				if pickup.Wait > 0 then return false end
				if pickup:IsShopItem() then
					if wakaba:CanPurchasePickup(player, pickup) then
						wakaba:PurchasePickup(player, pickup)
					end
				end
				local familiar
				if config:HasTags(ItemConfig.TAG_SUMMONABLE) then
					--print(player, player.Index)
					familiar = player:AddItemWisp(id, player.Position, true)
					wakaba.G:GetHUD():ShowItemText(player, config)
				else
					familiar = player:AddWisp(id, player.Position, true, false)
					wakaba.G:GetHUD():ShowItemText("Oh no...", "", false)
				end
				if familiar then
					familiar.Parent = collider
					familiar.Player = player
					familiar.CollisionDamage = familiar.CollisionDamage * 16
					familiar.MaxHitPoints = familiar.MaxHitPoints * 16
					familiar.HitPoints = familiar.MaxHitPoints
	
					pickup.Touched = true
					local index = pickup.OptionsPickupIndex
					local ents = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1)
					if index ~= 0 then
						for i, e in ipairs(ents) do
							if e:ToPickup() and e:ToPickup().OptionsPickupIndex == index then
								local Poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, e.Position, Vector.Zero, e):ToEffect()
								e:Remove()
							end
						end
					else
						local Poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, pickup):ToEffect()
						pickup:Remove()
					end
					wakaba.G:GetLevel():UpdateVisibility()
					player:AnimateSad()
				end
	
				return true
			end
		end
	end
	
	wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.Curse_PickupCollision, PickupVariant.PICKUP_COLLECTIBLE)
	 ]]
	
end
