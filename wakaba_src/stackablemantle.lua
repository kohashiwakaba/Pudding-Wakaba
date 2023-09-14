
wakaba._StackableHolyMantle = RegisterMod("Stackable Holy Mantle", 1)

local mantlemod = wakaba._StackableHolyMantle
local function activeShieldForPlayer(player, count)
	for i = 1, count do
		player:UseActiveItem(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
	end
end
function mantlemod:activeShield()
	if Game():GetRoom():GetFrameCount() ~= 1 then return end
	local hasbeast = false
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_BEAST, -1, -1, false, false)) do
		hasbeast = wakaba.state.options.beastblanket and true
	end
	for num = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(num - 1)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.totalmantlecount = player:GetData().wakaba.totalmantlecount or 0
		local holycardcount = player:GetData().wakaba.holycardused or 0
		local mantlecount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
		local blanketcount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BLANKET)
		if wakaba.state.options.stackablemantle ~= 0 and mantlecount > wakaba.state.options.stackablemantle then
			mantlecount = wakaba.state.options.stackablemantle
		end
		if wakaba.state.options.stackableholycard ~= 0 and holycardcount > wakaba.state.options.stackableholycard then
			holycardcount = wakaba.state.options.stackableholycard
		end
		if wakaba.state.options.stackablemantle >= 0 then
			activeShieldForPlayer(player, mantlecount)
		end
		if wakaba.state.options.stackableholycard >= 0 then
			activeShieldForPlayer(player, holycardcount)
			player:GetData().wakaba.updateholycard = true
		end
		if wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSS or hasbeast then
			if wakaba.state.options.stackableblanket ~= 0 and blanketcount > wakaba.state.options.stackableblanket then
				blanketcount = wakaba.state.options.stackableblanket
			end
			if wakaba.state.options.stackableblanket >= 0 then
				local count = blanketcount
				if wakaba.G:GetRoom():GetType() == RoomType.ROOM_BOSS then
					blanketcount = blanketcount - 1
				end
				--activeShieldForPlayer(player, blanketcount)
				if StageAPI and not wakaba.G:GetRoom():IsClear() then
					player:GetData().wakaba.pendingblanket = mantlecount + holycardcount + blanketcount - 1
				else
					activeShieldForPlayer(player, blanketcount)
				end
			end
		end
		--[[ local mantle = player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
		if mantle ~= nil then
			player:GetData().wakaba.totalmantlecount = mantle.Count
			print(mantle.Count)
		end ]]
	end
end
mantlemod:AddCallback(ModCallbacks.MC_POST_UPDATE, mantlemod.activeShield)

function mantlemod:activeShieldForLevel(curse)
	for num = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(num - 1)
		wakaba:GetPlayerEntityData(player)
		player:GetData().wakaba.pendingmantlestack = true
		if player:HasTrinket(TrinketType.TRINKET_WOODEN_CROSS) then
			player:GetData().wakaba.activatewoodencross = true
		end
	end
end
mantlemod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, mantlemod.activeShieldForLevel)
--mantlemod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mantlemod.activeShieldForLevel)


function mantlemod:activeDogma(npc)
	if not wakaba.state.options.dogmablanket then return end
	if npc.Variant == 0 then
		for num = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(num - 1)
			local blanketcount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BLANKET)
			if wakaba.state.options.stackableblanket ~= 0 and blanketcount > wakaba.state.options.stackableblanket then
				blanketcount = wakaba.state.options.stackableblanket
			end
			if wakaba.state.options.stackableblanket >= 0 then
				for i = 1, blanketcount do
					player:UseActiveItem(CollectibleType.COLLECTIBLE_HOLY_MANTLE, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER)
				end
			end
			local mantle = player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
			if mantle ~= nil then
				player:GetData().wakaba.totalmantlecount = mantle.Count
			end
		end
	end
end
mantlemod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mantlemod.activeDogma, EntityType.ENTITY_DOGMA)

function mantlemod:checkCurrentHolyCard(player)
	--[[ if player:GetData().wakaba.istransition and not player:GetSprite():IsPlaying("Appear") then
		player:GetData().wakaba.pendingmantlestack = true
	end ]]
	--print(wakaba.G:GetRoom():GetFrameCount())
	wakaba:GetPlayerEntityData(player)
	if wakaba.G:GetRoom():GetFrameCount() > 0 and player:GetData().wakaba.pendingblanket and player:GetData().wakaba.pendingblanket > 0 then
		--print("Activating for Blanket")
		activeShieldForPlayer(player, player:GetData().wakaba.pendingblanket)
		player:GetData().wakaba.pendingblanket = nil
	end
	if wakaba.G:GetRoom():GetFrameCount() > 0 and player:GetData().wakaba.pendingblessmantle and player:GetData().wakaba.pendingblessmantle > 0 then
		--print("Activating for Blanket")
		activeShieldForPlayer(player, player:GetData().wakaba.pendingblessmantle)
		player:GetData().wakaba.pendingblessmantle = nil
	end
	local holycardcount = player:GetData().wakaba.holycardused or 0
	--print("Checking Matle Stack", player:GetData().wakaba.pendingmantlestack, wakaba.G:IsPaused(), wakaba.G:GetRoom():GetFrameCount())
	if wakaba.G:GetRoom():GetFrameCount() > 0 and player:GetData().wakaba.pendingmantlestack and not wakaba.G:IsPaused() then
		--print("Activate for new floor")
		if wakaba.state.options.stackableholycard >= 0 then
			--print("Activating Holy Card", holycardcount)
			activeShieldForPlayer(player, holycardcount)
			player:GetData().wakaba.updateholycard = true
		end
		player:GetData().wakaba.pendingmantlestack = false
	end
	if player:GetData().wakaba.activatewoodencross then
		if player:GetTrinketMultiplier(TrinketType.TRINKET_WOODEN_CROSS) >= 1 then
			for i = 1, player:GetTrinketMultiplier(TrinketType.TRINKET_WOODEN_CROSS) do
				player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
				--player:UseActiveItem(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
			end
		end
		--player:GetData().wakaba.isholycard = true
		player:GetData().wakaba.activatewoodencross = false
	end
	if wakaba.G:GetRoom():GetFrameCount() <= 2 and player:GetData().wakaba.updateholycard then 
		local mantle = player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
		if mantle ~= nil then
			player:GetData().wakaba.totalmantlecount = mantle.Count
			--print(mantle.Count)
		end
		player:GetData().wakaba.updateholycard = false
		return 
	end










	local totalmantlecount = player:GetData().wakaba.totalmantlecount or 0
	local currentMantleCount = 0
	local mantle = player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
	if mantle ~= nil then
		currentMantleCount = mantle.Count
	end
	
	player:GetData().wakaba.istransition = false
	if player:GetSprite():IsPlaying("Trapdoor") or player:GetSprite():IsPlaying("LightTravel") or player:GetSprite():IsPlaying("Appear") then
		player:GetData().wakaba.istransition = true
	end
	if wakaba.G:GetRoom():GetFrameCount() > 0 and currentMantleCount ~= totalmantlecount and currentMantleCount < totalmantlecount and not player:GetData().wakaba.istransition then
		
		if player:GetData().wakaba.holycardused then
			if player:GetData().wakaba.isholycard or player:GetData().wakaba.holycardused > 0 then
				if player:GetData().wakaba.isholycard then
					--print("Holy Card Wear off")
					player:GetData().wakaba.isholycard = false
				else
					player:GetData().wakaba.holycardused = player:GetData().wakaba.holycardused - 1
				end
			end
		end
		player:GetData().wakaba.totalmantlecount = currentMantleCount
	elseif currentMantleCount ~= totalmantlecount then
		player:GetData().wakaba.totalmantlecount = currentMantleCount
	end

	if player:GetSprite():IsFinished("Appear") and player:GetData().wakaba.istransition then
		player:GetData().wakaba.istransition = false
	end

--[[ 
	if player:GetData().wakaba.holycardused then
		if player:GetData().wakaba.holycardused > 0 then










			if player:GetData()["mantleAmounts"] ~= nil then
					if effects ~= player:GetData()["mantleAmounts"] then
							if effects < player:GetData()["mantleAmounts"] and not newRoom then
									
									if player:GetPlayerType() == 10 then
											player:SetMinDamageCooldown(frameConfig["lost"])
									elseif player:GetPlayerType() == 31 then
											player:SetMinDamageCooldown(frameConfig["blost"])
									else
											player:SetMinDamageCooldown(frameConfig["default"])
									end
									
							end
							player:GetData()["mantleAmounts"] = effects
					end
			else
					player:GetData()["mantleAmounts"] = effects
			end

		end
	end
 ]]

end

mantlemod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mantlemod.checkCurrentHolyCard)

function mantlemod:HolyCardUsed(card, player, flags)
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.holycardused = player:GetData().wakaba.holycardused or 0
	player:GetData().wakaba.isholycard = player:GetData().wakaba.isholycard or false
	if not player:GetData().wakaba.isholycard then
		player:GetData().wakaba.isholycard = true
	else
		if not (wakaba.state.options.stackableholycard ~= 0 and player:GetData().wakaba.holycardused >= wakaba.state.options.stackableholycard - 1) then
			player:GetData().wakaba.holycardused = player:GetData().wakaba.holycardused + 1
			player:UseActiveItem(CollectibleType.COLLECTIBLE_HOLY_MANTLE, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER)
		end
	end
end

mantlemod:AddCallback(ModCallbacks.MC_USE_CARD, mantlemod.HolyCardUsed, Card.CARD_HOLY)


function mantlemod:HolyCardCountRender(player)
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.istransition = player:GetData().wakaba.istransition or false

	if player:GetSprite():IsPlaying("Trapdoor") or player:GetSprite():IsPlaying("LightTravel") or player:GetSprite():IsPlaying("Appear") then
		player:GetData().wakaba.istransition = true
	end

	player:GetData().wakaba.holycardused = player:GetData().wakaba.holycardused or 0
	player:GetData().wakaba.isholycard = player:GetData().wakaba.isholycard or false
	--[[ 
	local v = Isaac.WorldToScreen(player.Position) + Vector(0,16) - wakaba.G.ScreenShakeOffset
	local s = "X"
	if player:GetData().wakaba.isholycard then
		s = "V"
	end
	local i = "X"
	if player:GetData().wakaba.istransition then
		i = "V"
	end
	local p = player:GetData().wakaba.holycardused .. " " .. s
	wakaba.f:DrawString(i, v.X, v.Y - 10 ,KColor(1,1,1,1,0,0,0),0,true)
	wakaba.f:DrawString(p, v.X, v.Y ,KColor(1,1,1,1,0,0,0),0,true)
	wakaba.f:DrawString(player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) .. " " .. player:GetData().wakaba.totalmantlecount, v.X, v.Y + 10 ,KColor(1,1,1,1,0,0,0),0,true)
 ]]
end
mantlemod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, mantlemod.HolyCardCountRender)


function mantlemod:HolyCardContinue()
	for num = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(num - 1)
		wakaba:GetPlayerEntityData(player)
		--player:GetData().wakaba.pendingmantlestack = true
		--print("Game Continue")
		--print(player:GetData().wakaba.pendingmantlestack)
		--player:GetData().wakaba.istransition = true
	end
end
mantlemod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mantlemod.HolyCardContinue)

print("Stackable Holy Mantle for Pudding and Wakaba Loaded")

-- For Debug
