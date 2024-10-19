wakaba._ShioriData = {}

local playerType = wakaba.Enums.Players.SHIORI
local isShioriContinue = true

wakaba.SHIORI_BOOKMARK = Isaac.GetItemIdByName("Shiori's Red Bookmark")
wakaba.SHIORI_BOOKMARK2 = Isaac.GetItemIdByName("Shiori's Blue Bookmark")
wakaba.SHIORI_BOOKMARK3 = Isaac.GetItemIdByName("Shiori's Yellow Bookmark")

local isc = require("wakaba_src.libs.isaacscript-common")

local indicator = Sprite()
indicator:Load("gfx/ui/wakaba/shiori_book_indicator.anm2",true)
--wakaba.ShioriIndicator = indicator
wakaba._ShioriData.IndicatorSprite = indicator

-- wakaba.shioribookblacklisted
wakaba._ShioriData.BlacklistBook = {}
-- wakaba.shioriblacklisted
wakaba._ShioriData.BlacklistShiori = {
	[CollectibleType.COLLECTIBLE_BREATH_OF_LIFE] = true,
	[CollectibleType.COLLECTIBLE_ISAACS_TEARS] = true,
	[CollectibleType.COLLECTIBLE_SPIN_TO_WIN] = true,
}
-- wakaba.shioriwhitelisted
wakaba._ShioriData.WhitelistShiori = {
	[CollectibleType.COLLECTIBLE_ERASER] = true,
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = true,
}
wakaba._ShioriData.UnlockNeeded = {
	[wakaba.Enums.Collectibles.D6_PLUS] = true,
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = true,
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = true,
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = true,
	[wakaba.Enums.Collectibles.BALANCE] = true,
}

---@class WakabaCachedBooks
---@field ID CollectibleType
---@field Quality integer
---@field Tags ItemConfig
---@field CustomTags string
---@field ShopPrice integer
---@field DevilPrice integer


function wakaba:ModsLoaded_CacheBooks()
	if wakaba._ShioriData.CachedBooks then return end

	wakaba._ShioriData.CachedBooks = {} ---@type WakabaCachedBooks

	local itemConfig = Isaac.GetItemConfig()
	local collectibles = itemConfig:GetCollectibles()

	for i = 1, collectibles.Size do
		local config = itemConfig:GetCollectible(i)
		if (config) then
			local isBook = config:HasTags(ItemConfig.TAG_BOOK)
			local isActive = config.Type == ItemType.ITEM_ACTIVE
			if isBook and isActive and not config.Hidden then
				table.insert(wakaba._ShioriData.CachedBooks, {
					ID = i,
					Quality = config.Quality,
					Tags = config.Tags,
					CustomTags = (REPENTOGON and config:GetCustomTags()),
					ShopPrice = config.ShopPrice,
					DevilPrice = config.DevilPrice,
				})
			end
		end
	end

	if not REPENTOGON then
		wakaba:RemoveCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.ModsLoaded_CacheBooks)
	end
end

if REPENTOGON then
	wakaba:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, wakaba.ModsLoaded_CacheBooks)
else
	wakaba:AddPriorityCallback(ModCallbacks.MC_POST_PLAYER_INIT, -50000000, wakaba.ModsLoaded_CacheBooks)
end

function wakaba:BlacklistBook(item, bookstate)
	wakaba._ShioriData.BlacklistBook[item] = wakaba._ShioriData.BlacklistBook[item] or {}
	wakaba._ShioriData.BlacklistBook[item][bookstate] = true
end

do -- Shiori Blacklists
	-- Blacklist items for Shiori character
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.DOUBLE_DREAMS, wakaba.bookstate.BOOKSHELF_SHIORI)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN, wakaba.bookstate.BOOKSHELF_SHIORI)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY, wakaba.bookstate.BOOKSHELF_SHIORI)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.CLEAR_FILE, wakaba.bookstate.BOOKSHELF_SHIORI)

	-- Blacklist items for Hard Drop trinket
	wakaba:BlacklistBook(CollectibleType.COLLECTIBLE_HOW_TO_JUMP, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.BOOK_OF_SHIORI, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)

	-- Blacklist items for Unknown Bookmark, Maijima Mythology
	wakaba:BlacklistBook(CollectibleType.COLLECTIBLE_HOW_TO_JUMP, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.DOUBLE_DREAMS, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.BALANCE, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.CLEAR_FILE, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)

	-- Blacklist items for Soul of Shiori
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.D6_PLUS, wakaba.bookstate.BOOKSHELF_SOUL_OF_SHIORI)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.MICRO_DOPPELGANGER, wakaba.bookstate.BOOKSHELF_SOUL_OF_SHIORI)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.BOOK_OF_FOCUS, wakaba.bookstate.BOOKSHELF_SOUL_OF_SHIORI)
	wakaba:BlacklistBook(wakaba.Enums.Collectibles.BOOK_OF_SILENCE, wakaba.bookstate.BOOKSHELF_SOUL_OF_SHIORI)
end

function wakaba:getShioriBookCapacity()
	local extraCount = 0
	return wakaba.Enums.Constants.SHIORI_BOOKS + extraCount
end

function wakaba:resetShioriBookPool(player, force)
	if not (player and player:Exists()) then return end
	if player:GetPlayerType() == playerType and (force or wakaba.G.TimeCounter > 0) then
		if wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
			local data = player:GetData()
			data.wakaba.books = wakaba:getRandomBooks(player, wakaba.bookstate.BOOKSHELF_SHIORI, wakaba:getShioriBookCapacity())
			if force then
				player:SetPocketActiveItem(data.wakaba.books[1], ActiveSlot.SLOT_POCKET, true)
			else
				player:AddCollectible(data.wakaba.books[1], 0, false, ActiveSlot.SLOT_POCKET)
			end
			data.wakaba.bookindex = 1
		end
	end
end

---@param player EntityType
---@param bookState WakabaShioriBookState
---@return CollectibleType[]
function wakaba:getBooks(player, bookState)
	---@type CollectibleType[]
	local books = {}
	---@type WakabaShioriBookState
	local bookstate = bookstate or wakaba.bookstate.BOOKSHELF_SHIORI

	if bookstate == wakaba.bookstate.BOOKSHELF_SHIORI then
		if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DOPP then
			table.insert(books, wakaba.Enums.Collectibles.MICRO_DOPPELGANGER)
			return books
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_SLNT then
			table.insert(books, wakaba.Enums.Collectibles.BOOK_OF_SILENCE)
			return books
		end
	end

	if not wakaba._ShioriData.CachedBooks then
		wakaba:ModsLoaded_CacheBooks()
	end

	---@type WakabaCachedBooks[]
	local cachedBooks = wakaba:deepcopy(wakaba._ShioriData.CachedBooks)

	for _, e in ipairs(cachedBooks) do
		local v = Isaac.RunCallbackWithParam(wakaba.Callback.PRE_GET_SHIORI_BOOKS, e.ID, player, bookState, e.ID, e)
		if not v then
			table.insert(books, e.ID)
		end
	end

	return books
end

function wakaba:getRandomBooks(player, bookState, number)
	player = player or Isaac.GetPlayer()
	local books = wakaba:getBooks(player, bookState)
	number = number or 1
	local newbook = {}
	for i = 1, number do
		local rng = player:GetCollectibleRNG(wakaba.SHIORI_BOOKMARK)
		local pos = rng:RandomInt(#books) + 1
		local randbook = books[pos]
		table.insert(newbook, randbook)
		table.remove(books, pos)
	end
	return newbook
end

wakaba:AddCallback(wakaba.Callback.PRE_GET_SHIORI_BOOKS, function(_, player, bookState, collectibleType, e)
	local c = wakaba.Enums.Collectibles
	wakaba.Log("PRE_GET_SHIORI_BOOKS", player, bookState, collectibleType, e)
	if bookState == wakaba.bookstate.BOOKSHELF_SHIORI then
		if wakaba._ShioriData.UnlockNeeded[collectibleType] and not wakaba:unlockCheck(collectibleType) then return true end
		if wakaba._ShioriData.BlacklistBook[collectibleType] and wakaba._ShioriData.BlacklistBook[collectibleType][bookState] then return true end
	else
		if not wakaba:unlockCheck(collectibleType) then return true end
		if wakaba._ShioriData.BlacklistBook[collectibleType] and wakaba._ShioriData.BlacklistBook[collectibleType][bookState] then return true end
	end
end)

function wakaba:ShioriHasBook(player, item)
	if player:HasCollectible(item, true) then return true end
	local books = player:GetData().wakaba and player:GetData().wakaba.books
	if books and type(books) == "table" then
		if wakaba:has_value(books, item) then
			return true
		end
	end
end


---@param player EntityPlayer
---@param slot ActiveSlot
---@param item CollectibleType
---@param keys integer
---@param charge integer
---@param conf ItemConfigItem
function wakaba:ShioriCharge_Shiori(player, slot, item, keys, charge, conf)
	if not conf then return end
	local maxCharges = conf.MaxCharges
	local chargeType = conf.ChargeType
	if chargeType == ItemConfig.CHARGE_TIMED or chargeType == ItemConfig.CHARGE_SPECIAL then
		if keys > 0 and wakaba:has_value(wakaba._ShioriData.WhitelistShiori, item) then
			return chargeType == ItemConfig.CHARGE_TIMED and 1000000 or charge
		else
			return true
		end
	elseif item == wakaba.Enums.Collectibles.BOOK_OF_CONQUEST then
		return wakaba.killcount <= 160 and 200000 or 0
	elseif item == CollectibleType.COLLECTIBLE_BLANK_CARD and player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.TRIAL_STEW) then
		return 0
	elseif player:GetPlayerType() == wakaba.Enums.Players.SHIORI and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		local reqconsume = maxCharges // 2
		return charge + (maxCharges - reqconsume)
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_SHIORI_CHARGE, 19999, wakaba.ShioriCharge_Shiori)

---@param player EntityPlayer
function wakaba:PlayerEffectUpdate_Shiori(player)
	if player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B then
		local itemConfig = Isaac.GetItemConfig()
		if player:HasGoldenKey() then
			player:RemoveGoldenKey()
			player:AddKeys(6)
		end
		local keys = player:GetNumKeys()
		for i = 0, 2 do
			local charge = keys
			for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.EVALUATE_SHIORI_CHARGE)) do
				if not callback.Param or callback.Param == i then
					local item = player:GetActiveItem(i)
					local activeConfig = itemConfig:GetCollectible(item)
					local origin = player:GetActiveCharge(i) + player:GetBatteryCharge(i)
					local newCharge = callback.Function(callback.Mod, player, i, item, keys, charge, activeConfig, origin)

					if newCharge == true then
						charge = false
						break
					elseif newCharge then
						charge = newCharge
					end
				end
			end
			if type(charge) ~= "boolean" then
				player:SetActiveCharge(charge, i)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerEffectUpdate_Shiori)

function wakaba:PlayerUpdate_Shiori(player)
	if player:GetPlayerType() == playerType and wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
		local data = player:GetData()
		pdata = data.wakaba
		local shift = 0
		if Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex) then
			if Input.IsActionPressed(ButtonAction.ACTION_MAP, player.ControllerIndex) then
				shift = -1
			else
				shift = 1
			end
		end

		if shift == 0 then return end
		if player:GetPill(0) == 0 and player:GetCard(0) == 0 then
			data.wakaba.books = data.wakaba.books or wakaba:getBooks(player, wakaba.bookstate.BOOKSHELF_SHIORI)
			if #data.wakaba.books > 0 then
				data.wakaba.bookindex = data.wakaba.bookindex or 1
				player:RemoveCollectible(pdata.books[pdata.bookindex], false, ActiveSlot.SLOT_POCKET, true)
				pdata.bookindex = pdata.bookindex + shift
				if pdata.bookindex > #pdata.books then
					pdata.bookindex = 1
				elseif pdata.bookindex < 1 then
					pdata.bookindex = #pdata.books
				end
				player:AddCollectible(pdata.books[pdata.bookindex], 0, false, ActiveSlot.SLOT_POCKET)
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_Shiori)

function wakaba:ItemUse_Shiori(useditem, rng, player, useflag, slot, vardata)
	if wakaba._ShioriData.BlacklistShiori[useditem] then return end
	if useflag | UseFlag.USE_VOID == UseFlag.USE_VOID then return end
	if slot == ActiveSlot.SLOT_POCKET2 then return end
	if (player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B) and slot ~= -1 then
		local item = Isaac.GetItemConfig():GetCollectible(useditem)
		local charge = REPENTOGON and wakaba:GetCalculatedMaidMaxCharges(player, useditem) or item.MaxCharges
		local chargeType = item.chargeType
		local consume = charge
		if useditem == wakaba.Enums.Collectibles.BOOK_OF_CONQUEST then return end
		if (item.ChargeType == ItemConfig.CHARGE_TIMED or item.ChargeType == ItemConfig.CHARGE_SPECIAL)
		and not wakaba._ShioriData.WhitelistShiori[useditem] then
			if player:GetActiveCharge(slot) + player:GetBatteryCharge(slot) >= charge then
				return
			else
				consume = 1
			end
		end
		if wakaba._ShioriData.WhitelistShiori[useditem] then
			consume = 1
		end
		consume = math.max(consume - wakaba:GetMinimumPreservedCharge(player, useditem), 1)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			if player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
				consume = consume // 2
			elseif player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B then
				consume = math.max(consume - 1, 1)
			end
		end
		if player:GetPlayerType() == wakaba.Enums.Players.SHIORI and wakaba:extraVal("shioriSatyr") then
			wakaba:resetShioriBookPool(player)
		else
			player:AddKeys(-consume)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Shiori)


function wakaba:PickupCollision_Shiori(pickup, collider, low)
	if collider:ToPlayer() ~= nil then
		local player = collider:ToPlayer()
		if (player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B) then
			if pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY then
				if player:GetNumKeys() < 99 and not player:IsHoldingItem() then
					if pickup.SubType == BatterySubType.BATTERY_NORMAL then
						if player:GetNumCoins() < pickup.Price then
							return true
						end
						player:AddKeys(3)
					elseif pickup.SubType == BatterySubType.BATTERY_MICRO then
						if player:GetNumCoins() < pickup.Price then
							return true
						end
						player:AddKeys(1)
					elseif pickup.SubType == BatterySubType.BATTERY_MEGA then
						if player:GetNumCoins() < pickup.Price then
							return true
						end
						player:AddKeys(5)
					elseif pickup.SubType == BatterySubType.BATTERY_GOLDEN then
						if player:GetNumCoins() < pickup.Price then
							return true
						end
						player:AddKeys(10)
						player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(pickup), 0)
					end
					--pickup:GetSprite():Play("Collect", true)
					local itemConfig = Isaac.GetItemConfig()
					local bookitem = itemConfig:GetCollectible(player:GetActiveItem(ActiveSlot.SLOT_POCKET))
					local primaryitem = itemConfig:GetCollectible(player:GetActiveItem(ActiveSlot.SLOT_PRIMARY))
					local secondaryitem = itemConfig:GetCollectible(player:GetActiveItem(ActiveSlot.SLOT_SECONDARY))
					if bookitem ~= nil and bookitem.MaxCharges ~= 0 and bookitem.ChargeType ~= ItemConfig.CHARGE_SPECIAL then
						player:SetActiveCharge(0, ActiveSlot.SLOT_POCKET)
					elseif primaryitem ~= nil and primaryitem.MaxCharges ~= 0 and primaryitem.ChargeType ~= ItemConfig.CHARGE_SPECIAL then
						player:SetActiveCharge(0, ActiveSlot.SLOT_PRIMARY)
					elseif secondaryitem ~= nil and secondaryitem.MaxCharges ~= 0 and secondaryitem.ChargeType ~= ItemConfig.CHARGE_SPECIAL then
						player:SetActiveCharge(0, ActiveSlot.SLOT_SECONDARY)
					else
						local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 1, Vector(player.Position.X, player.Position.Y - 75), Vector.Zero, nil):ToEffect()
						--notif:FollowParent(player)
						notif.DepthOffset = player.DepthOffset + 5
						SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE, 2, 0, false, 1)
						if pickup:IsShopItem() then
							if pickup.Price == PickupPrice.PRICE_SPIKES then
								player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(pickup), 0)
							end
							pickup:Remove()
							return true
						else
							pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
							pickup:GetSprite():Play("Collect", true)
							pickup:PlayPickupSound()
							pickup:Die()
							return true
						end
						--pickup:Remove()
					end
				end
			elseif pickup.Variant == PickupVariant.PICKUP_HEART then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_ALABASTER_BOX) and player:GetNumKeys() < 12 then
					if pickup.SubType == HeartSubType.HEART_SOUL then
						player:AddKeys(2)
					elseif pickup.SubType == HeartSubType.HEART_HALF_SOUL then
						player:AddKeys(1)
					end
				end
			elseif pickup.Variant == PickupVariant.PICKUP_KEY then
				if pickup.SubType == KeySubType.KEY_CHARGED then
					player:AddKeys(3)
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PickupCollision_Shiori)

function wakaba:NPCDeath_Shiori(entity)
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if (player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B) then
			local data = player:GetData()
			data.wakaba = data.wakaba or {}
			data.wakaba.enemieskilled = data.wakaba.enemieskilled or 0
			if player:HasCollectible(CollectibleType.COLLECTIBLE_JUMPER_CABLES) then
				data.wakaba.enemieskilled = data.wakaba.enemieskilled + 1
				if data.wakaba.enemieskilled >= 15 then
					data.wakaba.enemieskilled = data.wakaba.enemieskilled - 15
					player:AddKeys(1)
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, wakaba.NPCDeath_Shiori)


function wakaba:TakeDamage_Shiori(entity, amount, flags, source, countdown)
	if entity.Type ~= EntityType.ENTITY_PLAYER
	then
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
			if ((player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B) and player:HasCollectible(CollectibleType.COLLECTIBLE_4_5_VOLT))
			--or (player:GetPlayerType() == Isaac.GetPlayerTypeByName("ShioriB", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_4_5_VOLT))
			then
				local data = player:GetData()
				data.wakaba = data.wakaba or {}
				data.wakaba.currdamage = data.wakaba.currdamage or 0
				local increase = amount
				if amount > entity.HitPoints then
					increase = entity.HitPoints
				end
				data.wakaba.currdamage = data.wakaba.currdamage + increase
				local border = 40 + (20 * wakaba.G:GetLevel():GetAbsoluteStage())
				if data.wakaba.currdamage >= border then
					data.wakaba.currdamage = data.wakaba.currdamage - border
					player:AddKeys(1)
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.TakeDamage_Shiori)


function wakaba:NewLevel_Shiori()
	for i = 1, wakaba.G:GetNumPlayers() do
		wakaba:resetShioriBookPool(Isaac.GetPlayer(i - 1))
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_Shiori)


function wakaba:PickupUpdate_Shiori(pickup)
	if isc:anyPlayerIs(wakaba.Enums.Players.SHIORI) or isc:anyPlayerIs(wakaba.Enums.Players.SHIORI_B) then
		if pickup:IsShopItem() then
			-- Pickup Price modification from Retribution, need to move to common functions though....
			local persistentData = wakaba:GetPersistentPickupData(pickup)

			if persistentData then
				persistentData.discount = persistentData.discount or 0

				if persistentData.updateDefaultPrice then
					persistentData.updateDefaultPrice = false
					pickup.AutoUpdatePrice = true
					pickup:Update()
					return
				elseif persistentData.updatePrice then
					if persistentData.discount > 0 then
						local oldPrice = pickup.Price
						pickup.Price = math.max(pickup.Price - persistentData.discount, 0)

						if pickup.Price == 0 and oldPrice ~= 0 then
							pickup.Price = PickupPrice.PRICE_FREE
						end

						pickup.AutoUpdatePrice = false
						persistentData.didModifyPrice = true
					elseif persistentData.didModifyPrice then
						pickup.AutoUpdatePrice = true
						persistentData.didModifyPrice = false
					end

					persistentData.updatePrice = false
				end
			end
			-- Pickup Price modification end

			if pickup.Variant == PickupVariant.PICKUP_KEY and pickup.SubType == KeySubType.KEY_NORMAL then
				if pickup.SubType == KeySubType.KEY_DOUBLEPACK then
					persistentData.discount = 3
					persistentData.updatePrice = true
				elseif pickup.SubType == KeySubType.KEY_GOLDEN then
					persistentData.discount = 5
					persistentData.updatePrice = true
				elseif pickup.SubType == KeySubType.KEY_NORMAL then
					pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_DOUBLEPACK, true, true, true)
					persistentData.discount = 3
					persistentData.updatePrice = true
				end
			elseif pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY then
				pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_GOLDEN, true, true, true)
				persistentData.discount = 5
				persistentData.updatePrice = true
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_Shiori)

local ShioriChar = {
	DAMAGE = 0.5,
	SPEED = 0.0,
	SHOTSPEED = 1.0,
	TEARRANGE = 30,
	TEARS = 0.27,
	LUCK = 1,
	FLYING = false,
	TEARFLAG = TearFlags.TEAR_TURN_HORIZONTAL,
	TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)	-- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}

function wakaba:onShioriCache(player, cacheFlag)
	if player:GetPlayerType() == playerType then
		--wakaba:GetShioriCostume(player)
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * ShioriChar.DAMAGE
		end
		if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed * ShioriChar.SHOTSPEED
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + ShioriChar.TEARRANGE
		end
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + ShioriChar.SPEED
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + ShioriChar.LUCK
		end
		if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and ShioriChar.FLYING then
			player.CanFly = true
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (ShioriChar.TEARS * wakaba:getEstimatedTearsMult(player)))
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | ShioriChar.TEARFLAG
		end
		if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
			--player.TearColor = ShioriChar.TEARCOLOR
		end
	else
		player:TryRemoveNullCostume(wakaba.COSTUME_SHIORI)
	end

end

wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010720, wakaba.onShioriCache)

---@param player EntityPlayer
function wakaba:AfterShioriInit(player)
	player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		local data = player:GetData()
		data.wakaba = data.wakaba or {}

		wakaba:resetShioriBookPool(player, true)

		data.wakaba.bookindex = data.wakaba.bookindex or 1
		data.wakaba.currdamage = data.wakaba.currdamage or 0
		data.wakaba.enemieskilled = data.wakaba.enemieskilled or 0
		data.wakaba.nextshioriflag = data.wakaba.nextshioriflag or 0
		if REPENTOGON then
			player:IncrementPlayerFormCounter(PlayerForm.PLAYERFORM_BOOK_WORM, 9)
		else
			if not player:HasCollectible(wakaba.SHIORI_BOOKMARK) then player:AddCollectible(wakaba.SHIORI_BOOKMARK) end
			if not player:HasCollectible(wakaba.SHIORI_BOOKMARK2) then player:AddCollectible(wakaba.SHIORI_BOOKMARK2) end
			if not player:HasCollectible(wakaba.SHIORI_BOOKMARK3) then player:AddCollectible(wakaba.SHIORI_BOOKMARK3) end
		end
	end
end


function wakaba:PostShioriInit(player)
	if player:GetPlayerType() == playerType then
		--wakaba:GetShioriCostume(player)
	end
	if not isShioriContinue then
		wakaba:AfterShioriInit(player)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostShioriInit)

function wakaba:ShioriInit(continue)
	if (not continue) then
		isShioriContinue = false
		wakaba:AfterShioriInit()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.ShioriInit)

function wakaba:ShioriExit()
	isShioriContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.ShioriExit)

function wakaba:getShioriBooks(player)
	if not player or player:GetPlayerType() ~= playerType then return end
	local data = player:GetData()
	if data.wakaba then
		return data.wakaba.books
	end
end

local cachedColors = {}

function wakaba:resetShioriCachedColorIndicators()
	cachedColors = {}
end

function wakaba:getItemColor(id, forceRefresh)
	local config = Isaac.GetItemConfig()
	local collectible = config:GetCollectible(id)
	if collectible then
		if cachedColors[id] and not forceRefresh then
			return cachedColors[id]
		end
		local r = {1.0, 1.0}
		local g = {1.0, 1.0}
		local b = {1.0, 1.0}
		local spriteSheet = collectible.GfxFileName

		local collectibleSprite = Sprite()
		collectibleSprite:Load("gfx/005.100_collectible.anm2", false)
		collectibleSprite:ReplaceSpritesheet(1,spriteSheet)
		collectibleSprite:LoadGraphics()
		collectibleSprite:SetFrame("Idle", 0)
		for i = -2,2,2 do
			for j = -40,0,8 do
				local qcolor = collectibleSprite:GetTexel(Vector(i,j),Vector(0,0),1,1)
				if qcolor.Red > 0 then table.insert(r, qcolor.Red) end
				if qcolor.Green > 0 then table.insert(g, qcolor.Green) end
				if qcolor.Blue > 0 then table.insert(b, qcolor.Blue) end
			end
		end
		--[[ local str = ""
		for _, e in ipairs(r) do
			str = str .. ", " .. e
		end
		print(str)
		str = ""
		for _, e in ipairs(g) do
			str = str .. ", " .. e
		end
		print(str)
		str = ""
		for _, e in ipairs(b) do
			str = str .. ", " .. e
		end
		print(str) ]]
		local color = Color(wakaba:getMedian(r), wakaba:getMedian(g), wakaba:getMedian(b))
		table.insert(cachedColors, color)
		return color
	end
	return Color.Default
end

function wakaba:Render_ShioriIndicator()
	if not wakaba.G:GetHUD():IsVisible()
	or wakaba.G:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD)
	or wakaba.G.Challenge ~= Challenge.CHALLENGE_NULL then
		return
	end
	for i, playerInfo in ipairs(wakaba:getIndexedPlayers()) do
		local player = wakaba:getIndexedPlayer(i)
		if player and player:GetPlayerType() == playerType then
			local list = wakaba:getShioriBooks(player)
			if list then
				local pos = playerInfo.ScreenPos(player, ActiveSlot.SLOT_POCKET) + playerInfo.PocketOffset[0]
				local size
				if i == 1 then
					size = 1
				else
					size = 0.5
				end
				indicator.Color = Color.Default
				indicator:SetFrame("Right", 0)
				indicator:Render(pos + Vector(-1, 0))
				indicator:SetFrame("Left", 0)
				indicator:Render(pos + Vector((-4 * (#list + 1)), 0))
				for s, id in ipairs(list) do
					local config = Isaac.GetItemConfig()
					local collectible = config:GetCollectible(id)
					--local color = wakaba:getItemColor(id)
					--indicator.Color = color
					indicator:SetFrame("Single", 1 + collectible.Quality)
					indicator:Render(pos + Vector(-4 * s, 0))
				end
				indicator.Color = Color(1,1,1,0.4)
				local current = player:GetData().wakaba.bookindex or 1
				indicator:SetFrame("Single_Select", wakaba.G:GetFrameCount() % 45)
				indicator:Render(pos + Vector(-4 * current, 0))
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_RENDER, wakaba.Render_ShioriIndicator)