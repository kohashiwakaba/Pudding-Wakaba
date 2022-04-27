wakaba.ShioriSprite = Sprite()
wakaba.ShioriSprite:Load("gfx/book_of_shiori.anm2", true)
wakaba.ShioriSprite:SetFrame("Shiori", 0)

wakaba.bookofshiori = {
	[CollectibleType.COLLECTIBLE_BIBLE] = function(player, rng, useflag, slot, vardata)
		--print("Bible used")
		player:UseActiveItem(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
  	local dat = player:GetData().wakaba.shioribiblecount
  	player:GetData().wakaba.shioribiblecount = (dat and dat + 1) or 1
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_BIBLE
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] = function(player, rng, useflag, slot, vardata)
		--player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR, false, 1)
  	local dat = player:GetData().wakaba.shioribelialcount
  	player:GetData().wakaba.shioribelialcount = (dat and dat + 1) or 1
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_NECRONOMICON] = function(player, rng, useflag, slot, vardata)
		local laser = player:SpawnMawOfVoid(30)
		laser.CollisionDamage = player.Damage * 0.64
		laser.Radius = 40
		local laser2 = player:SpawnMawOfVoid(55)
		laser2.CollisionDamage = player.Damage * 0.64
		laser2.Radius = 80
		local laser3 = player:SpawnMawOfVoid(80)
		laser3.CollisionDamage = player.Damage * 0.64
		laser3.Radius = 120
		local laser4 = player:SpawnMawOfVoid(105)
		laser4.CollisionDamage = player.Damage * 0.64
		laser4.Radius = 160
		local laser5 = player:SpawnMawOfVoid(130)
		laser5.CollisionDamage = player.Damage * 0.64
		laser5.Radius = 200
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_NECRONOMICON
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS] = function(player, rng, useflag, slot, vardata)
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK] = function(player, rng, useflag, slot, vardata)
		--player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_PYROMANIAC, false, 1)
  	local dat = player:GetData().wakaba.shioritrollbombcount
  	player:GetData().wakaba.shioritrollbombcount = (dat and dat + 1) or 1
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS] = function(player, rng, useflag, slot, vardata)
  	local dat = player:GetData().wakaba.shiorirevelcount
  	player:GetData().wakaba.shiorirevelcount = (dat and dat + 1) or 1
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_BOOK_OF_SIN] = function(player, rng, useflag, slot, vardata)
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_BOOK_OF_SIN
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_MONSTER_MANUAL] = function(player, rng, useflag, slot, vardata)
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_MONSTER_MANUAL
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_TELEPATHY_BOOK] = function(player, rng, useflag, slot, vardata)
  	local dat = player:GetData().wakaba.shioridummycount
  	player:GetData().wakaba.shioridummycount = (dat and dat + 1) or 1
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_TELEPATHY_BOOK
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS] = function(player, rng, useflag, slot, vardata)
		Game():GetLevel():ApplyMapEffect()
		Game():GetLevel():ApplyCompassEffect(true)
		Game():GetLevel():ApplyBlueMapEffect()
		Game():GetLevel():RemoveCurses(LevelCurse.CURSE_OF_DARKNESS | LevelCurse.CURSE_OF_THE_LOST)
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_SATANIC_BIBLE] = function(player, rng, useflag, slot, vardata)
  	local dat = player:GetData().wakaba.shiorisatancount
  	player:GetData().wakaba.shiorisatancount = (dat and dat + 1) or 1
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_SATANIC_BIBLE
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD] = function(player, rng, useflag, slot, vardata)
		local bony = Isaac.Spawn(EntityType.ENTITY_BONY, -1, -1, Isaac.GetFreeNearPosition(player.Position, 32.0), Vector.Zero, player)
		local bony2 = Isaac.Spawn(EntityType.ENTITY_BONY, -1, -1, Isaac.GetFreeNearPosition(player.Position, 32.0), Vector.Zero, player)
		bony:AddCharmed(EntityRef(player), -1)
		bony2:AddCharmed(EntityRef(player), -1)
  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[CollectibleType.COLLECTIBLE_LEMEGETON] = function(player, rng, useflag, slot, vardata)
		local candidates = {}
		local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
		local randInt = player:GetCollectibleRNG(wakaba.COLLECTIBLE_BOOK_OF_SHIORI):RandomInt(10000)
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
			local e = candidates[player:GetCollectibleRNG(wakaba.COLLECTIBLE_BOOK_OF_SHIORI):RandomInt(#candidates) + 1]
			local wisp = e.Entity
			local item = wisp.SubType
			wisp:Kill()
			player:AddCollectible(item)
		end

  	player:GetData().wakaba.nextshioriflag = CollectibleType.COLLECTIBLE_LEMEGETON
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[wakaba.COLLECTIBLE_BOOK_OF_FORGOTTEN] = function(player, rng, useflag, slot, vardata)
  	local dat = player:GetData().wakaba.shioribonecount
  	player:GetData().wakaba.shioribonecount = (dat and dat + 1) or 1
  	player:GetData().wakaba.nextshioriflag = wakaba.COLLECTIBLE_BOOK_OF_FORGOTTEN
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[wakaba.COLLECTIBLE_BOOK_OF_FOCUS] = function(player, rng, useflag, slot, vardata)
  	local dat = player:GetData().wakaba.shiorifocuscount
  	player:GetData().wakaba.shiorifocuscount = (dat and dat + 1) or 1
  	player:GetData().wakaba.nextshioriflag = wakaba.COLLECTIBLE_BOOK_OF_FOCUS
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[wakaba.COLLECTIBLE_DECK_OF_RUNES] = function(player, rng, useflag, slot, vardata)
  	player:GetData().wakaba.nextshioriflag = wakaba.COLLECTIBLE_DECK_OF_RUNES
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[wakaba.COLLECTIBLE_MICRO_DOPPELGANGER] = function(player, rng, useflag, slot, vardata)
  	player:GetData().wakaba.nextshioriflag = wakaba.COLLECTIBLE_MICRO_DOPPELGANGER
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[wakaba.COLLECTIBLE_BOOK_OF_SILENCE] = function(player, rng, useflag, slot, vardata)
  	local dat = player:GetData().wakaba.shiorisilencecount
  	player:GetData().wakaba.shiorisilencecount = (dat and dat + 60) or 60
  	player:GetData().wakaba.nextshioriflag = wakaba.COLLECTIBLE_BOOK_OF_SILENCE
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
	[wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER] = function(player, rng, useflag, slot, vardata)
  	local dat = player:GetData().wakaba.shiorigrimcount
  	player:GetData().wakaba.shiorigrimcount = (dat and dat + 1) or 1
  	player:GetData().wakaba.nextshioriflag = wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end,
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

-- Example code to add additional Book of Shiori Interactions
-- wakaba:AddBookofShioriFunc(CollectibleType, function)
wakaba.BookofShiori_D6Plus = function(player, rng, useflag, slot, vardata)
	--print("Player", player:GetName(), "used D6 Plus")
end

wakaba:AddBookofShioriFunc(wakaba.COLLECTIBLE_D6_PLUS, wakaba.BookofShiori_D6Plus)

function wakaba:GameStart_BookOfShiori(iscont)
	--[[ if RepentancePlusMod then
		wakaba:AddBookofShioriFunc(CustomCollectibles.BOOK_OF_LEVIATHAN, function(player, rng, useflag, slot, vardata)
			player:GetData().wakaba.nextshioriflag = CustomCollectibles.BOOK_OF_LEVIATHAN
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		end)
		wakaba:AddBookofShioriFunc(CustomCollectibles.BOOK_OF_JUDGES, function(player, rng, useflag, slot, vardata)
			player:GetData().wakaba.nextshioriflag = CustomCollectibles.BOOK_OF_JUDGES
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		end)
	end ]]


end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.GameStart_BookOfShiori)

function wakaba:ItemUse_BookOfShiori(useditem, rng, player, useflag, slot, vardata)
  if wakaba:HasShiori(player) then
		if wakaba.bookofshiori ~= nil
		and wakaba.bookofshiori[useditem] ~= nil
		and useflag & UseFlag.USE_OWNED == UseFlag.USE_OWNED then
			wakaba.bookofshiori[useditem](player, rng, useflag, slot, vardata)
		end
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
	local alpha = wakaba.state.currentalpha / 100

	if wakaba:HasShiori(player) or player:GetData().wakaba.nextshioriflag then
		if wData.ShioriSprite == nil then 
			wData.ShioriSprite = wakaba.ShioriSprite
			wData.ShioriSprite.PlaybackSpeed = 0
		end
		wData.ShioriSprite.Color = Color(1,1,1,alpha,0,0,0)
		if (not player:GetData().wakaba.nextshioriflag) or player:GetData().wakaba.nextshioriflag <= 0 then
			wData.ShioriSprite:SetFrame("Shiori", 0)
		else
			local item = wakaba.itemConfig:GetCollectible(player:GetData().wakaba.nextshioriflag)
			wData.ShioriSprite:ReplaceSpritesheet(1, item.GfxFileName)
			wData.ShioriSprite:LoadGraphics()
			wData.ShioriSprite:SetFrame("Shiori", 1)
		end
		if Game():GetHUD():IsVisible() then
			wakaba.ShioriSprite:Render(Isaac.WorldToScreen(player.Position) + Vector(0,-56) - Game().ScreenShakeOffset, Vector(0,0), Vector(0,0))
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, wakaba.PlayerRender_BookofShiori)

function wakaba:NewRoom_BookofShiori()
  for i = 0, Game():GetNumPlayers()-1 do
    local player = Isaac.GetPlayer(i)
		if player:GetData().wakaba then
			player:GetData().wakaba.shioribiblecount = 0 -- The Bible
			player:GetData().wakaba.shioribelialcount = 0
			player:GetData().wakaba.shioridummycount = 0
			player:GetData().wakaba.shioritrollbombcount = 0
			player:GetData().wakaba.shioribonecount = 0

			if Game():GetLevel():GetCurrentRoomIndex() == Game():GetLevel():GetStartingRoomIndex() 
			and Game():GetRoom():IsFirstVisit() then
				player:GetData().wakaba.shiorirevelcount = 0 -- Book of Revelations
				player:GetData().wakaba.shiorisatancount = 0
			end

			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_BookofShiori)


function wakaba:Cache_BookofShiori(player, cacheFlag)
	if not player:GetData().wakaba then return end
	local nextflag = player:GetData().wakaba.nextshioriflag 

	local bible = player:GetData().wakaba.shioribiblecount or 0
	local revel = player:GetData().wakaba.shiorirevelcount or 0
	local belial = player:GetData().wakaba.shioribelialcount or 0
	local dummy = player:GetData().wakaba.shioridummycount or 0
	local satan = player:GetData().wakaba.shiorisatancount or 0
	local bone = player:GetData().wakaba.shioribonecount or 0
	local troll = player:GetData().wakaba.shioritrollbombcount or 0
  if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
		if bible > 0 then player.Damage = player.Damage * (1.2 * (bible + 1)) end
		if belial > 0 then player.Damage = player.Damage + (1.5 * (belial + 1)) end
		if satan > 0 then player.Damage = player.Damage + (1.0 * (satan + 1)) end
    if nextflag == wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER then player.Damage = player.Damage * 0.6 end
  end
  if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
    if bible > 0 then player.ShotSpeed = player.ShotSpeed * 0.8 end
    if nextflag == wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER then player.ShotSpeed = player.ShotSpeed * 3 end
  end
  --[[ if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
    player.TearHeight = player.TearHeight - ShioriChar.TEARHEIGHT
    player.TearFallingSpeed = player.TearFallingSpeed + ShioriChar.TEARFALLINGSPEED
  end ]]
  if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
    --[[ player.MoveSpeed = player.MoveSpeed + ShioriChar.SPEED ]]
  end
  if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
    --[[ player.Luck = player.Luck + ShioriChar.LUCK ]]
  end
  --[[ if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and ShioriChar.FLYING then
    player.CanFly = true
  end ]]
  if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
    --[[ player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, ShioriChar.TEARS) ]]
    if nextflag == wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER then
			if player.MaxFireDelay < -0.33 then
				player.MaxFireDelay = -0.99
			elseif player.MaxFireDelay < 0 then
				player.MaxFireDelay = player.MaxFireDelay * 3 
			else
				player.MaxFireDelay = player.MaxFireDelay / 3 
			end
		end
  end
  if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
		if dummy > 0 then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_CONTINUUM end
		
    if nextflag == CollectibleType.COLLECTIBLE_BIBLE then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING | TearFlags.TEAR_GLOW end
    if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING | TearFlags.TEAR_BELIAL end
		if nextflag == CollectibleType.COLLECTIBLE_NECRONOMICON then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_ROCK end
		if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_SHIELDED end
		if nextflag == CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_EXPLOSIVE end
		if nextflag == CollectibleType.COLLECTIBLE_TELEPATHY_BOOK then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING | TearFlags.TEAR_JACOBS end
		if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_BAIT end
    if nextflag == CollectibleType.COLLECTIBLE_SATANIC_BIBLE then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_GROW | TearFlags.TEAR_FEAR end
		if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING end
    if nextflag == wakaba.COLLECTIBLE_BOOK_OF_FORGOTTEN then 
			player.TearFlags = player.TearFlags | TearFlags.TEAR_BONE end
  end
  if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
    --[[ player.TearColor = ShioriChar.TEARCOLOR ]]
  end
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local seven = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_7_SEALS)
		if revel > 0 then player:CheckFamiliar(FamiliarVariant.LIL_HARBINGERS, (revel * 2) + seven, player:GetCollectibleRNG(wakaba.COLLECTIBLE_BOOK_OF_SHIORI)) end
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_BookofShiori)

function wakaba:PlayerUpdate_BookofShiori(player)
	if player:GetData().wakaba then
		local silence = player:GetData().wakaba.shiorisilencecount or 0
		local nextflag = player:GetData().wakaba.nextshioriflag 
		local isgrim = player:GetData().wakaba.shiorigrimreaper
		if silence > 0 then
			player:GetData().wakaba.shiorisilencecount = player:GetData().wakaba.shiorisilencecount - 1
		end
		if nextflag == wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER and not isgrim then 
			player:AddCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD)
			player:AddCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE)
			player:GetData().wakaba.shiorigrimreaper = true
		end
		if isgrim and nextflag ~= wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD)
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE)
			player:GetData().wakaba.shiorigrimreaper = false
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
	local nextflag = player:GetData().wakaba.nextshioriflag 
	local isgrim = player:GetData().wakaba.shiorigrimreaper

  if isgrim and nextflag == wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER then
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
			local luck = player.Luck
			local random = wakaba.RNG:RandomFloat() * 100
			local nextflag = player:GetData().wakaba.nextshioriflag
			if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS 
			and random <= (20 + (2 * luck)) then
				tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LIGHT_FROM_HEAVEN 
				tear:GetData().wakabaInit = true
				tear:GetData().wakabaTearFlag = TearFlags.TEAR_LIGHT_FROM_HEAVEN 
			end
			if not wakaba:has_value(wakaba.shioritearblacklist, tear.Variant) then
				if nextflag == CollectibleType.COLLECTIBLE_NECRONOMICON then tear:ChangeVariant(TearVariant.ROCK) end
				if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS then tear:ChangeVariant(TearVariant.LOST_CONTACT) end
				if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD then tear:ChangeVariant(TearVariant.SCHYTHE) end
				if nextflag == CollectibleType.COLLECTIBLE_SATANIC_BIBLE then tear:ChangeVariant(TearVariant.DARK_MATTER) end
				if nextflag == wakaba.COLLECTIBLE_BOOK_OF_FORGOTTEN then tear:ChangeVariant(TearVariant.BONE) end
				if nextflag == wakaba.COLLECTIBLE_GRIMREAPER_DEFENDER then tear:ChangeVariant(TearVariant.SCHYTHE) end
			end
		elseif tear.SpawnerType == EntityType.ENTITY_FAMILIAR then
			
			local familiar = tear.SpawnerEntity:ToFamiliar()
			local player = familiar.Player
			if player ~= nil and player:GetData().wakaba ~= nil then
				--local player = spawner:ToPlayer()
				local luck = player.Luck
				local random = wakaba.RNG:RandomFloat() * 100
				local nextflag = player:GetData().wakaba.nextshioriflag 
				if nextflag == CollectibleType.COLLECTIBLE_MONSTER_MANUAL then

					if not tear:GetData().wakabaoriginitdmg then
						tear:GetData().wakabaoriginitdmg = tear.CollisionDamage
					end
					tear.CollisionDamage = tear:GetData().wakabaoriginitdmg * 3
					--tear.CollisionDamage = tear.CollisionDamage * 4
				end
				if nextflag == wakaba.COLLECTIBLE_MICRO_DOPPELGANGER and familiar.Variant == FamiliarVariant.MINISAAC then
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
					local luck = player.Luck
					local random = wakaba.RNG:RandomFloat() * 100
					local nextflag = player:GetData().wakaba.nextshioriflag 
					if nextflag == CollectibleType.COLLECTIBLE_MONSTER_MANUAL then

						if not tear:GetData().wakabaorigdmg then
							tear:GetData().wakabaorigdmg = tear.CollisionDamage
						end
						tear.CollisionDamage = tear:GetData().wakabaorigdmg * 3
						--tear.CollisionDamage = tear.CollisionDamage * 4
					end
					if nextflag == wakaba.COLLECTIBLE_MICRO_DOPPELGANGER and familiar.Variant == FamiliarVariant.MINISAAC then
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

  for i = 0, Game():GetNumPlayers()-1 do
    local player = Isaac.GetPlayer(i)
		if player:GetData().wakaba then
			local nextflag = player:GetData().wakaba.nextshioriflag 
			local silence = player:GetData().wakaba.shiorisilencecount or 0
			if nextflag == wakaba.COLLECTIBLE_BOOK_OF_SILENCE and silence > 0 then
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
			local luck = player.Luck
			local random = wakaba.RNG:RandomFloat() * 100
			if not player:GetData().wakaba then return end 
			local nextflag = player:GetData().wakaba.nextshioriflag 
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
  for i = 1, Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetData().wakaba then
			local luck = player.Luck
			local random = wakaba.RNG:RandomFloat() * 100
			if not player:GetData().wakaba then return end 
			local nextflag = player:GetData().wakaba.nextshioriflag
			if nextflag == CollectibleType.COLLECTIBLE_BOOK_OF_SIN 
			and random <= (10 + (0.75 * luck)) then
				local subrandom = wakaba.RNG:RandomInt(#wakaba.pickupvars) + 1
				Isaac.Spawn(EntityType.ENTITY_PICKUP, wakaba.pickupvars[subrandom], 0, Isaac.GetFreeNearPosition(entity.Position, 0.0), Vector.Zero, player)
			end
			if nextflag == CollectibleType.COLLECTIBLE_LEMEGETON 
			and random <= (10 + (0.75 * luck)) then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, 0, Isaac.GetFreeNearPosition(entity.Position, 0.0), Vector.Zero, player)
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
				local nextflag = player:GetData().wakaba.nextshioriflag
				local focus = player:GetData().wakaba.shiorifocuscount or 0
				local troll = player:GetData().wakaba.shioritrollbombcount or 0
				local isnotmoving = player:GetData().wakaba.isnotmoving or false
				local ischanged = false
				if focus > 0 and isnotmoving and not (flag & DamageFlag.DAMAGE_IGNORE_ARMOR == DamageFlag.DAMAGE_IGNORE_ARMOR) then
					flag = flag | DamageFlag.DAMAGE_IGNORE_ARMOR
					ischanged = true
				end
				if troll > 0 then
					local random = wakaba.RNG:RandomFloat() * 100
					if random <= (8 + (player.Luck * 1.1)) then
						flag = flag | DamageFlag.DAMAGE_SPAWN_BLACK_HEART
					end
					amount = amount * 2
					ischanged = true
				end
				if nextflag == wakaba.COLLECTIBLE_DECK_OF_RUNES then
					local random = wakaba.RNG:RandomFloat() * 100
					if random <= (8 + (player.Luck * 0.6 )) then
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

	elseif entity.Type == EntityType.ENTITY_PLAYER
	and not (flag & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES)
	then
		local player = entity:ToPlayer()
		if not player:GetData().wakaba then return end
		local nextflag = player:GetData().wakaba.nextshioriflag
	
		local troll = player:GetData().wakaba.shioritrollbombcount or 0
		if (troll > 0 or nextflag == CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK)
		and flag & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION
		then
			return false
		end
		
	elseif entity.Type == EntityType.ENTITY_FAMILIAR
	and entity:ToFamiliar() ~= nil
	and not (flag & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES)
	then
		local player = entity:ToFamiliar().Player
		if player ~= nil then
			if not player:GetData().wakaba then return end 
			local nextflag = player:GetData().wakaba.nextshioriflag 
			if Game().Challenge == wakaba.challenges.CHALLENGE_DOPP
			and entity.Variant == FamiliarVariant.MINISAAC then
				return false
			end
			if nextflag == wakaba.COLLECTIBLE_MICRO_DOPPELGANGER 
			and entity.Variant == FamiliarVariant.MINISAAC then
				flag = flag | DamageFlag.DAMAGE_CLONES
				entity:TakeDamage(0.008, flag, source, countdownFrames)
				return false
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDmg_BookofShiori)

function wakaba:updateDopp(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	if not player:GetData().wakaba then return end 
	local nextflag = player:GetData().wakaba.nextshioriflag 
	if Game().Challenge == wakaba.challenges.CHALLENGE_DOPP
	or nextflag == wakaba.COLLECTIBLE_MICRO_DOPPELGANGER then
		familiar:PickEnemyTarget(230, 13, 1, Vector.Zero, 180)
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.updateDopp, wakaba.MINISAAC)

