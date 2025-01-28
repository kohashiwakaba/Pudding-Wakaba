local shioriSpriteDatas = {}
local isc = _wakaba.isc

wakaba.HiddenItemManager:HideCostumes("WAKABA_BOS_PRIMARY")
wakaba.HiddenItemManager:HideCostumes("WAKABA_BOS_SECONDARY")

wakaba.ShioriSprite = Sprite()
wakaba.ShioriSprite:Load("gfx/book_of_shiori.anm2", true)
wakaba.ShioriSprite:SetFrame("Shiori", 0)

function wakaba:addShioriBuff(player, colllectibleType)
	player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
	if colllectibleType then
		player:GetData().wakaba.shioribuffs = player:GetData().wakaba.shioribuffs or {}
		player:GetData().wakaba.shioribuffs[colllectibleType] = (player:GetData().wakaba.shioribuffs[colllectibleType] or 0) + 1
	end
end

function wakaba:addShioriFloorBuff(player, colllectibleType)
	player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.BOOK_OF_SHIORI_FLOOR)
	if colllectibleType then
		player:GetData().wakaba.shiorifloorbuffs = player:GetData().wakaba.shiorifloorbuffs or {}
		player:GetData().wakaba.shiorifloorbuffs[colllectibleType] = (player:GetData().wakaba.shiorifloorbuffs[colllectibleType] or 0) + 1
	end
end

function wakaba:getShioriBuffs(player, colllectibleType)
	if colllectibleType and player:GetData().wakaba.shioribuffs then
		return player:GetData().wakaba.shioribuffs[colllectibleType] or 0
	end
	return player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
end

function wakaba:getShioriFloorBuffs(player, colllectibleType)
	if colllectibleType and player:GetData().wakaba.shiorifloorbuffs then
		return player:GetData().wakaba.shiorifloorbuffs[colllectibleType] or 0
	end
	return player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.BOOK_OF_SHIORI_FLOOR)
end

function wakaba:NewRoom_ResetShioriBuffs()
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		player:GetData().wakaba.shioribuffs = {}
	end)
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_ResetShioriBuffs)

function wakaba:NewFloor_ResetShioriBuffs()
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		player:GetData().wakaba.shiorifloorbuffs = {}
		if wakaba:IsLunatic() then
			player:GetData().wakaba.nextshioriflag = nil
		end
	end)
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewFloor_ResetShioriBuffs)

function wakaba:getShioriFlag(player)
	return player:GetData().wakaba.nextshioriflag
end

function wakaba:setShioriFlag(player, CollectibleType)
	player:GetData().wakaba.nextshioriflag = CollectibleType
end

function wakaba:Shiori_Bible(_, rng, player, useflag, slot, vardata)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
	wakaba:addShioriBuff(player)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_Bible, CollectibleType.COLLECTIBLE_BIBLE)

function wakaba:Shiori_Belial(_, rng, player, useflag, slot, vardata)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL, UseFlag.USE_NOANIM | UseFlag.USE_CARBATTERY)
	--wakaba:addShioriBuff(player)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_Belial, CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL)

---@param player EntityPlayer
function wakaba:Shiori_Necronomicon(_, rng, player, useflag, slot, vardata)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON, UseFlag.USE_NOANIM | UseFlag.USE_CARBATTERY)
	local entities = Isaac.GetRoomEntities()
	for _, entity in ipairs(entities) do
		if entity:IsEnemy() and not entity:IsDead() then
			if not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
				entity:AddFear(EntityRef(Player), 150)
			end
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_Necronomicon, CollectibleType.COLLECTIBLE_NECRONOMICON)

function wakaba:Shiori_BookofShadows(_, rng, player, useflag, slot, vardata)
	player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS)
	player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_BookofShadows, CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS)

function wakaba:Shiori_Anarchist(_, rng, player, useflag, slot, vardata)
	wakaba:addShioriBuff(player, CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_Anarchist, CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK)

function wakaba:Shiori_Revelations(_, rng, player, useflag, slot, vardata)
	wakaba:addShioriBuff(player)
	wakaba.HiddenItemManager:AddForFloor(player, CollectibleType.COLLECTIBLE_7_SEALS, -1, 2, "WAKABA_BOS_REVEL")
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_Revelations, CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS)

wakaba.Weights.ShioriSins = {
	{{EntityType.ENTITY_SLOTH, 0}, 1.00},
	{{EntityType.ENTITY_LUST, 0}, 1.00},
	{{EntityType.ENTITY_WRATH, 0}, 1.00},
	{{EntityType.ENTITY_GLUTTONY, 0}, 1.00},
	{{EntityType.ENTITY_GREED, 0}, 1.00},
	{{EntityType.ENTITY_ENVY, 0}, 1.00},
	{{EntityType.ENTITY_PRIDE, 0}, 1.00},

	{{EntityType.ENTITY_SLOTH, 1}, 0.25},
	{{EntityType.ENTITY_LUST, 1}, 0.25},
	{{EntityType.ENTITY_WRATH, 1}, 0.25},
	{{EntityType.ENTITY_GLUTTONY, 1}, 0.25},
	{{EntityType.ENTITY_GREED, 1}, 0.25},
	{{EntityType.ENTITY_ENVY, 1}, 0.25},
	{{EntityType.ENTITY_PRIDE, 1}, 0.25},
}

function wakaba:Shiori_Sin(_, rng, player, useflag, slot, vardata)
	local r = RNG()
	r:SetSeed(rng:GetSeed(), 35)
	local s = rng:RandomFloat()
	if s < 0.5 then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_SIN, UseFlag.USE_NOANIM | UseFlag.USE_CARBATTERY)
	else
		local randomEntity = isc:getRandomFromWeightedArray(wakaba.Weights.ShioriSins, r)
		local tp = randomEntity[1]
		local vr = randomEntity[2] or 0
		local st = randomEntity[3] or 0
		local sin = Isaac.Spawn(tp, vr, st, player.Position, Vector.Zero, player):ToNPC()
		sin:AddEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_CHARM)
	end

end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_Sin, CollectibleType.COLLECTIBLE_BOOK_OF_SIN)

function wakaba:Shiori_MonsterManual(_, rng, player, useflag, slot, vardata)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_MONSTER_MANUAL, UseFlag.USE_NOANIM | UseFlag.USE_CARBATTERY)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_MonsterManual, CollectibleType.COLLECTIBLE_MONSTER_MANUAL)

function wakaba:Shiori_TelepathyBook(_, rng, player, useflag, slot, vardata)
	wakaba:addShioriBuff(player)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_TelepathyBook, CollectibleType.COLLECTIBLE_TELEPATHY_BOOK)

function wakaba:Shiori_BookofSecrets(_, rng, player, useflag, slot, vardata)
	wakaba.G:GetLevel():ApplyMapEffect()
	wakaba.G:GetLevel():ApplyCompassEffect(true)
	wakaba.G:GetLevel():ApplyBlueMapEffect()
	wakaba.G:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_DARKNESS | LevelCurse.CURSE_OF_THE_LOST)
	wakaba.G:GetLevel():RemoveCurses(wakaba.curses.CURSE_OF_SNIPER | wakaba.curses.CURSE_OF_FAIRY)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_BookofSecrets, CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS)

function wakaba:Shiori_SatanicBible(_, rng, player, useflag, slot, vardata)
	wakaba:addShioriBuff(player)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_SatanicBible, CollectibleType.COLLECTIBLE_SATANIC_BIBLE)

function wakaba:Shiori_BookofTheDead(_, rng, player, useflag, slot, vardata)
	local bony = Isaac.Spawn(EntityType.ENTITY_BONY, -1, -1, Isaac.GetFreeNearPosition(player.Position, 32.0), Vector.Zero, player)
	local bony2 = Isaac.Spawn(EntityType.ENTITY_BONY, -1, -1, Isaac.GetFreeNearPosition(player.Position, 32.0), Vector.Zero, player)
	bony:AddCharmed(EntityRef(player), -1)
	bony2:AddCharmed(EntityRef(player), -1)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_BookofTheDead, CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD)

function wakaba:Shiori_Lemegeton(_, rng, player, useflag, slot, vardata)
	local candidates = {}
	local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
	local randInt = player:GetCollectibleRNG(wakaba.Enums.Collectibles.BOOK_OF_SHIORI):RandomInt(10000)
	for i, e in ipairs(wisps) do
		if e.SpawnerEntity.Index == player.Index then
			haswisp = true
			local item = e.SubType
			local config = Isaac.GetItemConfig():GetCollectible(item)
			if config and (config.Type == ItemType.ITEM_PASSIVE or config.Type == ItemType.ITEM_FAMILIAR) then
				table.insert(candidates, EntityRef(e))
			end
		end
	end
	local threshold = 1000
	threshold = threshold + (125 * #candidates)
	if #candidates >= 23 then
		threshold = 10000
	end

	if #candidates > 0 and randInt < threshold then
		local e = candidates[player:GetCollectibleRNG(wakaba.Enums.Collectibles.BOOK_OF_SHIORI):RandomInt(#candidates) + 1]
		local wisp = e.Entity
		local item = wisp.SubType
		wisp:Kill()
		player:AddCollectible(item)
	end

end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_Lemegeton, CollectibleType.COLLECTIBLE_LEMEGETON)

function wakaba:Shiori_BookofForgotten(_, rng, player, useflag, slot, vardata)
	wakaba:addShioriBuff(player)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_BookofForgotten, wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN)

function wakaba:PreShiori_BookofFocus(_, rng, player, useflag, slot, vardata)
	-- Book of Focus disables secondary Shiori effect
	return true
end
wakaba:AddCallback(wakaba.Callback.PRE_CHANGE_SHIORI_EFFECT, wakaba.PreShiori_BookofFocus, wakaba.Enums.Collectibles.BOOK_OF_FOCUS)

function wakaba:Shiori_BookofFocus(_, rng, player, useflag, slot, vardata)
	wakaba:addShioriBuff(player, wakaba.Enums.Collectibles.BOOK_OF_FOCUS)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_BookofFocus, wakaba.Enums.Collectibles.BOOK_OF_FOCUS)

function wakaba:Shiori_BottleofRunes(_, rng, player, useflag, slot, vardata)

end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_BottleofRunes, wakaba.Enums.Collectibles.DECK_OF_RUNES)

function wakaba:Shiori_MicroDoppelganger(_, rng, player, useflag, slot, vardata)

end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_MicroDoppelganger, wakaba.Enums.Collectibles.MICRO_DOPPELGANGER)

function wakaba:PreShiori_BookofSilence(_, rng, player, useflag, slot, vardata)
	-- Book of Silence disables secondary Shiori effect
	return true
end
wakaba:AddCallback(wakaba.Callback.PRE_CHANGE_SHIORI_EFFECT, wakaba.PreShiori_BookofSilence, wakaba.Enums.Collectibles.BOOK_OF_SILENCE)

function wakaba:Shiori_BookofSilence(_, rng, player, useflag, slot, vardata)
	wakaba:addShioriBuff(player, wakaba.Enums.Collectibles.BOOK_OF_SILENCE)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_BookofSilence, wakaba.Enums.Collectibles.BOOK_OF_SILENCE)

function wakaba:Shiori_GrimreaperDefender(_, rng, player, useflag, slot, vardata)
	wakaba:addShioriBuff(player)
end
wakaba:AddCallback(wakaba.Callback.POST_ACTIVATE_SHIORI_EFFECT, wakaba.Shiori_GrimreaperDefender, wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)


wakaba.bookofshiori = {
}
wakaba.pickupvars = {
	PickupVariant.PICKUP_HEART,
	PickupVariant.PICKUP_COIN,
	PickupVariant.PICKUP_KEY,
	PickupVariant.PICKUP_BOMB,
	PickupVariant.PICKUP_CHEST,
	PickupVariant.PICKUP_GRAB_BAG,
	PickupVariant.PICKUP_PILL,
	PickupVariant.PICKUP_LIL_BATTERY,
	PickupVariant.PICKUP_TAROTCARD,
	PickupVariant.PICKUP_TRINKET,
}

wakaba.shioritearblacklist = {
	TearVariant.BOBS_HEAD,
	TearVariant.CHAOS_CARD,
	TearVariant.BALLOON_BRIMSTONE,
	TearVariant.BALLOON_BOMB,
	TearVariant.KEY,
	TearVariant.KEY_BLOOD,
	TearVariant.ERASER,
}

function wakaba:AddBookofShioriFunc(book, func)
	wakaba.bookofshiori[book] = func
end

function wakaba:ItemUse_BookOfShiori(useditem, rng, player, useflag, slot, vardata)
	if wakaba:HasShiori(player) then
		if slot == ActiveSlot.SLOT_POCKET and player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES)
		and useditem ~= CollectibleType.COLLECTIBLE_LEMEGETON then
			player:AddWisp(useditem, player.Position, false, false)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_BookOfShiori)

local curralpha = wakaba.state.options.uniformalpha / 100

function wakaba:PlayerRender_BookofShiori(player)
	wakaba:GetPlayerEntityData(player)
	local wData = player:GetData().wakaba
	local alpha = wakaba.runstate.currentalpha / 100

	local playerIndex = isc:getPlayerIndex(player)

	if wakaba:HasShiori(player) or wakaba:getShioriFlag(player) then
		shioriSpriteDatas[playerIndex] = shioriSpriteDatas[playerIndex] or {}
		if shioriSpriteDatas[playerIndex].ShioriSprite == nil then
			shioriSpriteDatas[playerIndex].ShioriSprite = wakaba.ShioriSprite
			shioriSpriteDatas[playerIndex].ShioriSprite.PlaybackSpeed = 0
		end
		shioriSpriteDatas[playerIndex].ShioriSprite.Color = Color(1,1,1,alpha,0,0,0)
		if (not wakaba:getShioriFlag(player)) or wakaba:getShioriFlag(player) <= 0 then
			shioriSpriteDatas[playerIndex].ShioriSprite:SetFrame("Shiori", 0)
		else
			local itemConfig = Isaac.GetItemConfig()
			local item = itemConfig:GetCollectible(wakaba:getShioriFlag(player))
			shioriSpriteDatas[playerIndex].ShioriSprite:ReplaceSpritesheet(1, item.GfxFileName)
			shioriSpriteDatas[playerIndex].ShioriSprite:LoadGraphics()
			shioriSpriteDatas[playerIndex].ShioriSprite:SetFrame("Shiori", 1)
		end
		if wakaba.G:GetHUD():IsVisible() then
			wakaba.ShioriSprite:Render(Isaac.WorldToScreen(player.Position) + Vector(0,-56) - wakaba.G.ScreenShakeOffset, Vector(0,0), Vector(0,0))
		end
	else
		shioriSpriteDatas[playerIndex] = nil
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.PlayerRender_BookofShiori)

function wakaba:Cache_BookofShiori(player, cacheFlag)
	if not player:GetData().wakaba then return end
	local current = wakaba:getShioriFlag(player)
	local buffs = wakaba:getShioriBuffs(player)

	if current == CollectibleType.COLLECTIBLE_BIBLE then
		if buffs > 0 then
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage * (1.2 * (buffs + 1))
			end
			if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
				player.ShotSpeed = player.ShotSpeed * 0.8
			end
			if cacheFlag == CacheFlag.CACHE_TEARFLAG then
				player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING
			end
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_GLOW
		end
	elseif current == CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS then
		if buffs > 0 then
			if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			end
		end
	elseif current == CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL then
		if buffs > 0 then
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				--player.Damage = player.Damage + ((1.5 * (buffs + 1)) * wakaba:getEstimatedDamageMult(player))
			end
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING | TearFlags.TEAR_BELIAL
		end
	elseif current == CollectibleType.COLLECTIBLE_NECRONOMICON then
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			--player.TearFlags = player.TearFlags | TearFlags.TEAR_ROCK
		end
	elseif current == CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS then
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_SHIELDED
		end
	elseif current == CollectibleType.COLLECTIBLE_TELEPATHY_BOOK then
		if buffs > 0 then
			if cacheFlag == CacheFlag.CACHE_TEARFLAG then
				player.TearFlags = player.TearFlags | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_CONTINUUM
			end
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING
		end
	elseif current == CollectibleType.COLLECTIBLE_SATANIC_BIBLE then
		local floorBuffs = wakaba:getShioriFloorBuffs(player, CollectibleType.COLLECTIBLE_SATANIC_BIBLE)
		if floorBuffs > 0 then
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + ((1.0 * (floorBuffs + 1)) * wakaba:getEstimatedDamageMult(player))
			end
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_GROW | TearFlags.TEAR_FEAR
		end
	elseif current == wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN then
		if buffs > 0 then
			if cacheFlag == CacheFlag.CACHE_TEARFLAG then
				player.TearFlags = player.TearFlags | TearFlags.TEAR_BONE
			end
		end
	elseif current == CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK then
		if buffs > 0 then
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_EXPLOSIVE
		end
	elseif current == CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS then
		if buffs > 0 then
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			--player.TearFlags = player.TearFlags | TearFlags.TEAR_BAIT
		end
	elseif current == CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD then
		if buffs > 0 then
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING
		end
	elseif current == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 0.6
		end
		if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed * 3
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			if player.MaxFireDelay < -0.33 then
				player.MaxFireDelay = -0.99
			elseif player.MaxFireDelay < 0 then
				player.MaxFireDelay = player.MaxFireDelay * 3
			else
				player.MaxFireDelay = player.MaxFireDelay / 3
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_BookofShiori)

function wakaba:PlayerUpdate_BookofShiori(player)
	if player:GetData().wakaba then
		local nextflag = wakaba:getShioriFlag(player)

		if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS then
			wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_ROTTEN_TOMATO, 1, "WAKABA_BOS_SECONDARY")
		elseif nextflag == CollectibleType.COLLECTIBLE_SATANIC_BIBLE then
			wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_DARK_MATTER, 1, "WAKABA_BOS_SECONDARY")
		elseif nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS then
			wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_LOST_CONTACT, 1, "WAKABA_BOS_SECONDARY")
		elseif nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD then
			wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_DEATHS_TOUCH, 1, "WAKABA_BOS_SECONDARY")
		elseif nextflag == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER then
			wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_SPIRIT_SWORD, 1, "WAKABA_BOS_SECONDARY")
			wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_MOMS_KNIFE, 1, "WAKABA_BOS_SECONDARY")
		elseif nextflag == wakaba.Enums.Collectibles.ISEKAI_DEFINITION then

		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_BookofShiori)

function wakaba:KnifeUpdate_BookofShiori(knife)
	if not knife.Parent then return end
	if not knife.Parent:ToPlayer() then return end
	if not knife.Parent:ToPlayer():GetData().wakaba then return end
	local player = knife.Parent:ToPlayer()
	local sprite = knife:GetSprite()
	local nextflag = wakaba:getShioriFlag(player)
	local isgrim = player:GetData().wakaba.shiorigrimreaper

	if nextflag == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER then
		sprite:ReplaceSpritesheet(0,"gfx/grimreapersword.png")
		sprite:ReplaceSpritesheet(1,"gfx/grimreapersword.png")
		if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) then
			return
		end
		sprite:LoadGraphics()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, wakaba.KnifeUpdate_BookofShiori)

function wakaba:TearInit_BookofShiori(tear)
	if tear ~= nil
	and tear.SpawnerEntity ~= nil
	then
		if tear.SpawnerType == EntityType.ENTITY_PLAYER then
			local player = tear.SpawnerEntity:ToPlayer()
			if player == nil then return end
			if not player:GetData().wakaba then return end
			local luck = math.max(0, player.Luck)
			local random = wakaba.RNG:RandomFloat() * 100
			local nextflag = wakaba:getShioriFlag(player)
			if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS
			and random <= (5 + (2.5 * luck)) then
				tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LIGHT_FROM_HEAVEN
				tear:GetData().wakabaInit = true
				tear:GetData().wakabaTearFlag = TearFlags.TEAR_LIGHT_FROM_HEAVEN
			end
			if not wakaba:has_value(wakaba.shioritearblacklist, tear.Variant) then
				--if nextflag == CollectibleType.COLLECTIBLE_NECRONOMICON then tear:ChangeVariant(TearVariant.ROCK) end
				--if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS then tear:ChangeVariant(TearVariant.LOST_CONTACT) end
				--if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD then tear:ChangeVariant(TearVariant.SCHYTHE) end
				--if nextflag == CollectibleType.COLLECTIBLE_SATANIC_BIBLE then tear:ChangeVariant(TearVariant.DARK_MATTER) end
				if nextflag == wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN then tear:ChangeVariant(TearVariant.BONE) end
				if nextflag == wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER then tear:ChangeVariant(TearVariant.SCHYTHE) end
			end
		elseif tear.SpawnerType == EntityType.ENTITY_FAMILIAR then

			local familiar = tear.SpawnerEntity:ToFamiliar()
			local player = familiar.Player
			if player ~= nil and player:GetData().wakaba ~= nil then
				--local player = spawner:ToPlayer()
				local luck = math.max(0, player.Luck)
				local random = wakaba.RNG:RandomFloat() * 100
				local nextflag = wakaba:getShioriFlag(player)
				if nextflag == CollectibleType.COLLECTIBLE_MONSTER_MANUAL then

					if not tear:GetData().wakabaoriginitdmg then
						tear:GetData().wakabaoriginitdmg = tear.CollisionDamage
					end
					tear.CollisionDamage = tear:GetData().wakabaoriginitdmg * 3
					--tear.CollisionDamage = tear.CollisionDamage * 4
				end
				if nextflag == wakaba.Enums.Collectibles.MICRO_DOPPELGANGER and familiar.Variant == FamiliarVariant.MINISAAC then
					tear:AddTearFlags(player.TearFlags)
				end

			end
		end
	end

end

wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, wakaba.TearInit_BookofShiori)

function wakaba:TearUpdate_BookofShiori(tear)
	--local tearData = tear:GetData().wakabaInit
	--if tearData == nil then return end
	if tear ~= nil
	and tear.SpawnerEntity ~= nil
	then
		if tear:GetData().wakabaTearFlag then
			tear.TearFlags = tear.TearFlags | tear:GetData().wakabaTearFlag
		else
			if tear.SpawnerType == EntityType.ENTITY_FAMILIAR then
				local familiar = tear.SpawnerEntity:ToFamiliar()
				if familiar and (familiar.Player or familiar.SpawnerEntity:ToPlayer()) then
					--local player = spawner:ToPlayer()
					local player = familiar.Player or familiar.SpawnerEntity:ToPlayer()
					local luck = math.max(0, player.Luck)
					local random = wakaba.RNG:RandomFloat() * 100
					local nextflag = wakaba:getShioriFlag(player)
					if nextflag == CollectibleType.COLLECTIBLE_MONSTER_MANUAL then

						if not tear:GetData().wakabaorigdmg then
							tear:GetData().wakabaorigdmg = tear.CollisionDamage
						end
						tear.CollisionDamage = tear:GetData().wakabaorigdmg * 3
						--tear.CollisionDamage = tear.CollisionDamage * 4
					end
					if nextflag == wakaba.Enums.Collectibles.MICRO_DOPPELGANGER and familiar.Variant == FamiliarVariant.MINISAAC then
						tear:AddTearFlags(player.TearFlags)
					end
				end
				tear:GetData().wakabaInit = true
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_BookofShiori)
wakaba:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, wakaba.TearUpdate_BookofShiori)

function wakaba:ProjectileUpdate_BookofShiori(tear)

	for i = 0, wakaba.G:GetNumPlayers()-1 do
		local player = Isaac.GetPlayer(i)
		if player:GetData().wakaba then
			local silences = wakaba:getShioriBuffs(player, wakaba.Enums.Collectibles.BOOK_OF_SILENCE)
			local silence = player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.BOOK_OF_SILENCE)
			if silences > 0 and silence then
				tear:Remove()
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, wakaba.ProjectileUpdate_BookofShiori)

function wakaba:FamiliarUpdate_BookofShiori(familiar)
	local familiarData = familiar:GetData().wakabaInit
	if familiar.Variant == FamiliarVariant.BLUE_FLY or familiar.Variant == FamiliarVariant.BLUE_SPIDER then
		return
	end
	if not familiarData and familiar.FrameCount > 0 then
		local player = familiar.Player
		if player ~= nil then
			--local player = spawner:ToPlayer()
			local luck = math.max(0, player.Luck)
			local random = wakaba.RNG:RandomFloat() * 100
			if not player:GetData().wakaba then return end
			local nextflag = wakaba:getShioriFlag(player)
			if nextflag == CollectibleType.COLLECTIBLE_MONSTER_MANUAL then
				if not familiar:GetData().wakabaorigdmg then
					familiar:GetData().wakabaorigdmg = familiar.CollisionDamage
				end
				familiar.CollisionDamage = familiar:GetData().wakabaorigdmg * 3
				--familiar:GetData().wakabaInit = true
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_BookofShiori)

function wakaba:NPCDeath_BookofShiori(entity)
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetData().wakaba then
			local luck = math.max(0, player.Luck)
			local random = entity:GetDropRNG():RandomFloat() * 100
			local nextflag = wakaba:getShioriFlag(player)
			if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_SIN
			and random <= 1.2 then
				local subrandom = wakaba.RNG:RandomInt(#wakaba.pickupvars) + 1
				Isaac.Spawn(EntityType.ENTITY_PICKUP, wakaba.pickupvars[subrandom], 0, Isaac.GetFreeNearPosition(entity.Position, 0.0), Vector.Zero, player)
			end
			if nextflag == CollectibleType.COLLECTIBLE_LEMEGETON
			and random <= (4 + (0.25 * luck)) then
				wakaba:HealWisps(player, 1)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, wakaba.NPCDeath_BookofShiori)

function wakaba:TakeDmg_BookofShiori(entity, amount, flag, source, countdownFrames)
	if entity.Type ~= EntityType.ENTITY_PLAYER
	and entity.Type ~= EntityType.ENTITY_FAMILIAR
	then
		local entityData = entity:GetData().wakaba
		local player = nil
		if
			(source ~= nil
			and source.Entity ~= nil
			and source.Entity.SpawnerEntity ~= nil
			and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER )
		then
			player = source.Entity.SpawnerEntity:ToPlayer()
		elseif
			(source ~= nil
			and source.Type == EntityType.ENTITY_PLAYER)
		then
			player = source.Entity:ToPlayer()
		end


		if player ~= nil then
			if not (flag & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES) then
				if not player:GetData().wakaba then return end
				local nextflag = wakaba:getShioriFlag(player)
				local buffs = wakaba:getShioriBuffs(player)
				local focuses = wakaba:getShioriBuffs(player, wakaba.Enums.Collectibles.BOOK_OF_FOCUS)
				local isnotmoving = player:GetData().wakaba.isnotmoving or false
				local ischanged = false
				if focuses > 0 and isnotmoving and not (flag & DamageFlag.DAMAGE_IGNORE_ARMOR == DamageFlag.DAMAGE_IGNORE_ARMOR) then
					flag = flag | DamageFlag.DAMAGE_IGNORE_ARMOR
					ischanged = true
				end
				if nextflag == CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK and buffs > 0 then
					amount = amount * 2
					ischanged = true
				end
				if nextflag == wakaba.Enums.Collectibles.DECK_OF_RUNES then
					local random = wakaba.RNG:RandomFloat() * 100
					if random <= 1.6 then
						flag = flag | DamageFlag.DAMAGE_SPAWN_RUNE
					end
					amount = amount * 2
					ischanged = true
				end
				if ischanged then
					flag = flag | DamageFlag.DAMAGE_CLONES
					entity:TakeDamage(amount, flag, source, countdownFrames)
					return false
				end
			end
		end
	elseif entity.Type == EntityType.ENTITY_FAMILIAR
	and entity:ToFamiliar() ~= nil
	and not (flag & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES)
	then
		local player = entity:ToFamiliar().Player
		if player ~= nil then
			if not player:GetData().wakaba then return end
			local nextflag = wakaba:getShioriFlag(player)
			if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DOPP
			and entity.Variant == FamiliarVariant.MINISAAC then
				return false
			end
			if nextflag == wakaba.Enums.Collectibles.MICRO_DOPPELGANGER
			and entity.Variant == FamiliarVariant.MINISAAC then
				flag = flag | DamageFlag.DAMAGE_CLONES
				entity:TakeDamage(0.008, flag, source, countdownFrames)
				return false
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_BookofShiori)


function wakaba:NegateDamage_BookOfShiori(player, amount, flags, source, countdown)
	local nextflag = wakaba:getShioriFlag(player)
	local troll = wakaba:getShioriBuffs(player, CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK)
	if (troll > 0 or nextflag == CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK)
	and flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION
	then
		return false
	end
end
wakaba:AddCallback(wakaba.Callback.TRY_NEGATE_DAMAGE, wakaba.NegateDamage_BookOfShiori)

function wakaba:updateDopp(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	if not player:GetData().wakaba then return end
	local nextflag = wakaba:getShioriFlag(player)
	if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DOPP
	or nextflag == wakaba.Enums.Collectibles.MICRO_DOPPELGANGER then
		familiar:PickEnemyTarget(230, 13, 1, Vector.Zero, 180)
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateDopp, wakaba.MINISAAC)


function wakaba:WeaponFire_BookOfShiori(player)
	if player:GetData().wakaba then
		local nextflag = wakaba:getShioriFlag(player)
		if nextflag == CollectibleType.COLLECTIBLE_NECRONOMICON then
			local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
			local rand = rng:RandomFloat()
			local chance = 0.06
			if rand < chance then
				wakaba:SpawnPurgatoryGhost(player, rng)
			end
		end
	end
end
wakaba:AddCallback(wakaba.Callback.ANY_WEAPON_FIRE, wakaba.WeaponFire_BookOfShiori)
