local blackcandletrigger = false

if Isaac.GetCurseIdByName("Curse of Blight") > 0 then
	wakaba.curses.CURSE_OF_BLIGHT = 1 << (Isaac.GetCurseIdByName("Curse of Blight") - 1)
end

function wakaba:Update_refreshWispSize()
	if wakaba.wispupdaterequired then
		local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, -1, false, false)
		for i, e in ipairs(wisps) do
			if e.HitPoints > e.MaxHitPoints then
				e.MaxHitPoints = e.MaxHitPoints * 16
			end
			--print("Wisp", e.SubType, "Updated!")
		end
		local iwisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
		for i, e in ipairs(iwisps) do
			if e.HitPoints > e.MaxHitPoints then
				e.MaxHitPoints = e.MaxHitPoints * 16
			end
			--print("Item Wisp", e.SubType, "Updated!")
		end

	end
	
	wakaba.wispupdaterequired = false
end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_refreshWispSize)

function wakaba:Curse_BlackCandleCheck(player)
	local curse = Game():GetLevel():GetCurses() 
	if player:GetPlayerType() == wakaba.PLAYER_SHIORI
	and wakaba.state.currentshiorimode == wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR
	and Game().Challenge == Challenge.CHALLENGE_NULL
	and curse & wakaba.curses.CURSE_OF_SATYR ~= wakaba.curses.CURSE_OF_SATYR
	then
		Game():GetLevel():RemoveCurses(Game():GetLevel():GetCurses())
		Game():GetLevel():AddCurse(wakaba.curses.CURSE_OF_SATYR, false)
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) then
		if curse & wakaba.curses.CURSE_OF_FLAMES == wakaba.curses.CURSE_OF_FLAMES then
			Game():GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_FLAMES)
		end
		if CURCOL and curse & wakaba.curses.CURSE_OF_BLIGHT == wakaba.curses.CURSE_OF_BLIGHT then
			Game():GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_BLIGHT)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Curse_BlackCandleCheck)

function wakaba:Curse_Evaluate(curse)
	--if wakaba.curses.CURSE_OF_FLAMES <= 0 then return end
	--[[ print(wakaba.state.options.shiorimodes == wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR)
	print(Game():GetLevel():GetAbsoluteStage())
	print(Game().TimeCounter) ]]
	for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == wakaba.PLAYER_SHIORI
		and ((wakaba.state.options.shiorimodes == wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR and Game().TimeCounter == 0)
		or wakaba.state.currentshiorimode == wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR) then
			curse = wakaba.curses.CURSE_OF_SATYR
			return curse
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) then
			return curse
		end
		-- Not checking for blight here, since Pudding and Wakaba loads before Cursed Collection
		if wakaba:HasBless(player) or wakaba:HasNemesis(player) or wakaba:HasShiori(player) or wakaba:hasLunarStone(player) or wakaba:hasElixir(player) then
			if curse | LevelCurse.CURSE_OF_BLIND == LevelCurse.CURSE_OF_BLIND then
				curse = curse & ~LevelCurse.CURSE_OF_BLIND
			end
		end
		if wakaba:hasElixir(player) then
			if curse | LevelCurse.CURSE_OF_THE_UNKNOWN == LevelCurse.CURSE_OF_THE_UNKNOWN then
				curse = curse & ~LevelCurse.CURSE_OF_THE_UNKNOWN
			end
		end
	end
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
	if wakaba:HasBless(player) or wakaba:HasNemesis(player) or wakaba:HasShiori(player) or wakaba:hasLunarStone(player) or wakaba:hasElixir(player) then
		local curse = Game():GetLevel():GetCurses()
		if curse & LevelCurse.CURSE_OF_BLIND == LevelCurse.CURSE_OF_BLIND then
			Game():GetLevel():RemoveCurses(LevelCurse.CURSE_OF_BLIND)
		end
		if CURCOL and curse & wakaba.curses.CURSE_OF_BLIGHT == wakaba.curses.CURSE_OF_BLIGHT then
			Game():GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_BLIGHT)
		end
	end
	if wakaba:hasElixir(player) then
		local curse = Game():GetLevel():GetCurses()
		if curse & LevelCurse.CURSE_OF_THE_UNKNOWN == LevelCurse.CURSE_OF_THE_UNKNOWN then
			Game():GetLevel():RemoveCurses(LevelCurse.CURSE_OF_THE_UNKNOWN)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.Curse_PlayerRender)

if wakaba.curses.CURSE_OF_FLAMES > LevelCurse.CURSE_OF_GIANT then
	function wakaba:PlayerUpdate_Curse(player)
		if wakaba.curses.CURSE_OF_FLAMES <= 0 then return end
		local curse = Game():GetLevel():GetCurses() 
		if curse & wakaba.curses.CURSE_OF_FLAMES == wakaba.curses.CURSE_OF_FLAMES
		--[[ and (Game():GetRoom():GetType() == RoomType.ROOM_CHALLENGE or Game():GetRoom():GetType() == RoomType.ROOM_BOSSRUSH) ]] then
			if not player:IsItemQueueEmpty() and player.QueuedItem.Item:IsCollectible() then
				local heldItem = player.QueuedItem.Item
				if heldItem:HasTags(ItemConfig.TAG_QUEST) or heldItem.ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
					return
				end
				SFXManager():Stop(SoundEffect.SOUND_CHOIR_UNLOCK)
				SFXManager():Stop(SoundEffect.SOUND_POWERUP1)
				SFXManager():Stop(SoundEffect.SOUND_POWERUP2)
				SFXManager():Stop(SoundEffect.SOUND_POWERUP3)
				SFXManager():Stop(SoundEffect.SOUND_DEVILROOM_DEAL)
				if player:FlushQueueItem() then
					player:RemoveCollectible(heldItem.ID)
					local familiar
					if heldItem:HasTags(ItemConfig.TAG_SUMMONABLE) then
						familiar = player:AddItemWisp(heldItem.ID, player.Position, true)
						--Game():GetHUD():ShowItemText(player, heldItem.ID)
					else
						familiar = player:AddWisp(heldItem.ID, player.Position, true, false)
						Game():GetHUD():ShowItemText("Oh no...", "", false)
					end
					if familiar then
						familiar.Parent = collider
						familiar.Player = player
						familiar.CollisionDamage = familiar.CollisionDamage * 16
						familiar.MaxHitPoints = familiar.MaxHitPoints * 16
						familiar.HitPoints = familiar.MaxHitPoints
					end
		
					Game():GetLevel():UpdateVisibility()
					player:AnimateSad()
				end
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_Curse)
	
	function wakaba:Curse_PickupCollision(pickup, collider, low)
		if wakaba.curses.CURSE_OF_FLAMES <= 0 then return end
		if Game():GetRoom():GetType() == RoomType.ROOM_CHALLENGE then return end
		if Game():GetRoom():GetType() == RoomType.ROOM_BOSSRUSH then return end
		if not collider:ToPlayer() then return end
		local curse = Game():GetLevel():GetCurses() 
		if curse & wakaba.curses.CURSE_OF_FLAMES == wakaba.curses.CURSE_OF_FLAMES then
			local id = pickup.SubType
			if id == 0 then return end
			local config = Isaac.GetItemConfig():GetCollectible(id)
			if config.Type ~= ItemType.ITEM_ACTIVE then return end
			if not (config:HasTags(ItemConfig.TAG_QUEST) or id == CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				local player = collider:ToPlayer()
				if pickup.Wait > 0 then return false end
				if pickup:IsShopItem() then
					if pickup.Price > 0 then
						if player:GetNumCoins() >= pickup.Price then
							player:AddCoins(pickup.Price * -1)
							--[[ if wakaba.kud_wafu then
							else
								SFXManager():Play(SoundEffect.SOUND_POWERUP3)
							end ]]
						else
							return true
						end
					elseif pickup.Price < 0 then
						local maxHearts = player:GetEffectiveMaxHearts()
						local maxRedHearts = player:GetMaxHearts()
						local maxSoulHearts = player:GetSoulHearts()
						if pickup.Price == PickupPrice.PRICE_ONE_HEART then
							if maxHearts >= 2 then
								if maxRedHearts < 2 then
									player:AddBoneHearts(-1)
								else
									player:AddMaxHearts(-2, true)
								end
							else
								return true
							end
						elseif pickup.Price == PickupPrice.PRICE_TWO_HEARTS then
							if maxHearts >= 4 then
								if maxRedHearts < 4 then
									player:AddBoneHearts(-2)
								elseif maxRedHearts < 2 then
									player:AddBoneHearts(-1)
									player:AddMaxHearts(-2, true)
								else
									player:AddMaxHearts(-4, true)
								end
							else
								return true
							end
						elseif pickup.Price == PickupPrice.PRICE_THREE_SOULHEARTS then
							if maxSoulHearts >= 6 then
								player:AddSoulHearts(-6, true)
							else
								return true
							end
						elseif pickup.Price == PickupPrice.PRICE_ONE_HEART_AND_TWO_SOULHEARTS then
							if maxHearts >= 2 and maxSoulHearts >= 4 then
								player:AddSoulHearts(-4, true)
								if maxRedHearts < 2 then
									player:AddBoneHearts(-1)
								else
									player:AddMaxHearts(-2, true)
								end
							else
								return true
							end
						end
					end
	
				end
				local familiar
				if config:HasTags(ItemConfig.TAG_SUMMONABLE) then
					--print(player, player.Index)
					familiar = player:AddItemWisp(id, player.Position, true)
					Game():GetHUD():ShowItemText(player, config)
				else
					familiar = player:AddWisp(id, player.Position, true, false)
					Game():GetHUD():ShowItemText("Oh no...", "", false)
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
					--[[ if Game():GetRoom():GetType() == RoomType.ROOM_CHALLENGE or Game():GetRoom():GetType() == RoomType.ROOM_BOSSRUSH then
						Game():GetRoom():SetAmbushDone(false)
					end ]]
					Game():GetLevel():UpdateVisibility()
					player:AnimateSad()
				end
	
				return true
			end
		end
	end
	
	wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.Curse_PickupCollision, PickupVariant.PICKUP_COLLECTIBLE)
	
	
end
