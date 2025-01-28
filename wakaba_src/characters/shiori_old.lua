
local playerType = Isaac.GetPlayerTypeByName("Shiori", false)
wakaba.SHIORI_BOOKMARK = Isaac.GetItemIdByName("Shiori's Red Bookmark")
wakaba.SHIORI_BOOKMARK2 = Isaac.GetItemIdByName("Shiori's Blue Bookmark")
wakaba.SHIORI_BOOKMARK3 = Isaac.GetItemIdByName("Shiori's Yellow Bookmark")
local removed = false
local collectibleCount
local costumeEquipped
local isShioriContinue = true
local iskeyinit = false
local isc = _wakaba.isc

local indicator = Sprite()
indicator:Load("gfx/ui/wakaba/shiori_book_indicator.anm2",true)
wakaba.ShioriIndicator = indicator

wakaba.shioriconsume = {
	[CollectibleType.COLLECTIBLE_BIBLE] = -1,
	[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] = -1,
	[CollectibleType.COLLECTIBLE_NECRONOMICON] = -1,
	[CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS] = -1,
	[CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK] = -1,
	[CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS] = -1,
	[CollectibleType.COLLECTIBLE_BOOK_OF_SIN] = -1,
	[CollectibleType.COLLECTIBLE_TELEPATHY_BOOK] = -1,
	[CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS] = -1,
	[CollectibleType.COLLECTIBLE_SATANIC_BIBLE] = -1,
	[CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD] = -1,
	[CollectibleType.COLLECTIBLE_LEMEGETON] = -1,
}
wakaba.shioribookblacklisted = {}
wakaba.shioriblacklisted = {
	CollectibleType.COLLECTIBLE_BREATH_OF_LIFE,
	CollectibleType.COLLECTIBLE_ISAACS_TEARS,
	CollectibleType.COLLECTIBLE_SPIN_TO_WIN,
}
wakaba.shioriwhitelisted = {
	CollectibleType.COLLECTIBLE_ERASER,
	wakaba.Enums.Collectibles.BOOK_OF_TRAUMA,
	wakaba.Enums.Collectibles.BOOK_OF_SILENCE,
}
wakaba.bookcache = {}

function wakaba:BlacklistBook(item, bookstate)
	wakaba.shioribookblacklisted[item] = wakaba.shioribookblacklisted[item] or {}
	wakaba.shioribookblacklisted[item][bookstate] = true
end

-- Blacklist items for Shiori character
wakaba:BlacklistBook(wakaba.Enums.Collectibles.DOUBLE_DREAMS, wakaba.bookstate.BOOKSHELF_SHIORI)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN, wakaba.bookstate.BOOKSHELF_SHIORI)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY, wakaba.bookstate.BOOKSHELF_SHIORI)

-- Blacklist items for Hard Drop trinket
wakaba:BlacklistBook(CollectibleType.COLLECTIBLE_HOW_TO_JUMP, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.BOOK_OF_SHIORI, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)

-- Blacklist items for Unknown Bookmark, Maijima Mythology
wakaba:BlacklistBook(CollectibleType.COLLECTIBLE_HOW_TO_JUMP, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.DOUBLE_DREAMS, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.BALANCE, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)

-- Blacklist items for Soul of Shiori
wakaba:BlacklistBook(wakaba.Enums.Collectibles.D6_PLUS, wakaba.bookstate.BOOKSHELF_SOUL_OF_SHIORI)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.MICRO_DOPPELGANGER, wakaba.bookstate.BOOKSHELF_SOUL_OF_SHIORI)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.BOOK_OF_FOCUS, wakaba.bookstate.BOOKSHELF_SOUL_OF_SHIORI)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.BOOK_OF_SILENCE, wakaba.bookstate.BOOKSHELF_SOUL_OF_SHIORI)

-- Blacklist items for Shiori character
wakaba:BlacklistBook(wakaba.Enums.Collectibles.DOUBLE_DREAMS, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
wakaba:BlacklistBook(wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
wakaba:BlacklistBook(CollectibleType.COLLECTIBLE_LEMEGETON, wakaba.bookstate.BOOKSHELF_PURE_SHIORI)

function wakaba:GetBookItems(bookstate)
	local isShiori = false
	local config = Isaac.GetItemConfig()
	local maxID = wakaba:GetMaxCollectibleID()
	local books = {}
	local bookstate = bookstate or wakaba.bookstate.BOOKSHELF_SHIORI
	wakaba:getUnlockState()
	if bookstate == wakaba.bookstate.BOOKSHELF_SHIORI then
		if wakaba.G.Challenge == wakaba.challenges.CHALLENGE_DOPP then
			table.insert(books,wakaba.Enums.Collectibles.MICRO_DOPPELGANGER)
			return books
		elseif wakaba.G.Challenge == wakaba.challenges.CHALLENGE_SLNT then
			table.insert(books,wakaba.Enums.Collectibles.BOOK_OF_SILENCE)
			return books
		end
	end

	for i = 1, maxID do
		local item = config:GetCollectible(i)
		if item ~= nil and item:HasTags(ItemConfig.TAG_BOOK)
		and not item.Hidden
		then
			local isQualityMet = true
			--wakaba.FLog("debugShiori","Checking Book -	" .. item.Name .. "...")
			if bookstate == wakaba.bookstate.BOOKSHELF_SHIORI
			or bookstate == wakaba.bookstate.BOOKSHELF_PURE_SHIORI
			or (bookstate == wakaba.bookstate.BOOKSHELF_AKASIC_RECORDS and isQualityMet)
			then
				if item.Type == ItemType.ITEM_ACTIVE then
					if item.ID == wakaba.Enums.Collectibles.D6_PLUS then
						if wakaba.state.unlock.shiorid6plus > 0 then
							table.insert(books,item.ID)
							wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
						end
					elseif item.ID == wakaba.Enums.Collectibles.MICRO_DOPPELGANGER then
						if wakaba:unlockCheck(item.ID) then
							table.insert(books,item.ID)
							wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
						end
					elseif item.ID == wakaba.Enums.Collectibles.BOOK_OF_CONQUEST then
						if wakaba:unlockCheck(item.ID) then
							table.insert(books,item.ID)
							wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
						end
					elseif item.ID == wakaba.Enums.Collectibles.ISEKAI_DEFINITION then
						if wakaba:unlockCheck(item.ID) then
							table.insert(books,item.ID)
							wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
						end
					elseif item.ID == wakaba.Enums.Collectibles.BALANCE then
						if wakaba:unlockCheck(item.ID) then
							table.insert(books,item.ID)
							wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
						end
					elseif wakaba.shioribookblacklisted[item.ID] then
						if wakaba.shioribookblacklisted[item.ID][bookstate] == true then
							-- Do nothing
							wakaba.FLog("debugShiori","Book " .. item.Name .. " Blacklisted")
						else
							table.insert(books,item.ID)
							wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
						end
					else
						table.insert(books,item.ID)
						wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
					end
				end
			elseif bookstate == wakaba.bookstate.BOOKSHELF_HARD_BOOK then
				if wakaba:unlockCheck(item.ID) then
					if wakaba.shioribookblacklisted[item.ID] and wakaba.shioribookblacklisted[item.ID][bookstate] then

					else
						table.insert(books,item.ID)
						wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
					end
				end
			elseif bookstate == wakaba.bookstate.BOOKSHELF_SHIORI_DROP then
				if wakaba:unlockCheck(item.ID) then
					if (wakaba.shioribookblacklisted[item.ID] and wakaba.shioribookblacklisted[item.ID][bookstate]) or wakaba:has_value(wakaba.runstate.shioridropped, item.ID) then
						-- Do nothing
					else
						table.insert(books,item.ID)
						wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
					end
				end
			elseif bookstate == wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK then
				if item.Type == ItemType.ITEM_ACTIVE then
					if wakaba.shioribookblacklisted[item.ID] then
						if wakaba.shioribookblacklisted[item.ID][bookstate] then
							-- Do nothing
						else
							table.insert(books,item.ID)
							wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
						end
					else
						table.insert(books,item.ID)
						wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
					end
				end
			else
				if wakaba:unlockCheck(item.ID) then
					table.insert(books,item.ID)
					wakaba.FLog("debugShiori","Book " .. item.Name .. " Inserted")
				end
			end
		end
	end

	return books
end

function wakaba:GetRandomBook(bookstate, player, number)
	local books = wakaba:GetBookItems(bookstate)
	player = player or Isaac.GetPlayer()
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

function wakaba:GetShioriCostume(player)
	if wakaba.costumecurrframe == 0 then
		wakaba.costumecurrframe = wakaba.costumecooldown
		player:AddNullCostume(wakaba.COSTUME_SHIORI)
	end
end

--[[ if Poglite then
	local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/wakaba_pog.anm2")
	Poglite:AddPogCostume("ShioriPog",playerType,pogCostume)
end ]]

--Costume currently not working in Knife Piece 2 area. Needs to be fixed.
function wakaba:PostShioriUpdate()

end
--wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.PostShioriUpdate)

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
		if keys > 0 and wakaba:has_value(wakaba.shioriwhitelisted, item) then
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

function wakaba:updateShiori(player)
	if player:GetPlayerType() == playerType and wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
		local data = player:GetData()
		pdata = data.wakaba
		if Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex) then
			if player:GetPill(0) == 0 and player:GetCard(0) == 0 then
				data.wakaba.books = data.wakaba.books or wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_SHIORI)
				if #data.wakaba.books > 0 then
					data.wakaba.bookindex = data.wakaba.bookindex or 1
					player:RemoveCollectible(pdata.books[pdata.bookindex], false, ActiveSlot.SLOT_POCKET, true)
					if Input.IsActionPressed(ButtonAction.ACTION_MAP, player.ControllerIndex) then
						pdata.bookindex = pdata.bookindex - 1
					else
						pdata.bookindex = pdata.bookindex + 1
					end
					if pdata.bookindex > #pdata.books then
						pdata.bookindex = 1
					end
					if pdata.bookindex < 1 then
						pdata.bookindex = #pdata.books
					end
					--player:SetPocketActiveItem(pdata.books[pdata.bookindex], ActiveSlot.SLOT_POCKET, true)
					player:AddCollectible(pdata.books[pdata.bookindex], 0, false, ActiveSlot.SLOT_POCKET)
					--local keys = player:GetNumKeys()
					--wakaba:SetShioriCharge(player, keys, ActiveSlot.SLOT_POCKET)
				end
			end
		end

		if wakaba.runstate.currentshiorimode == wakaba.shiorimodes.SHIORI_COLLECTOR then
			local active = player:GetActiveItem(ActiveSlot.SLOT_PRIMARY)
			if active > 0 then
				local config = Isaac.GetItemConfig():GetCollectible(active)
				if config and config:HasTags(ItemConfig.TAG_BOOK) and not (wakaba.shioribookblacklisted[active] and wakaba.shioribookblacklisted[active][wakaba.bookstate.BOOKSHELF_SHIORI]) then
					player:RemoveCollectible(active, true, ActiveSlot.SLOT_PRIMARY, false)
					local pData = player:GetData()
					table.insert(pData.wakaba.books, active)
					player:GetData().wakaba.bookindex = #pData.wakaba.books
					player:AddCollectible(active, 0, false, ActiveSlot.SLOT_POCKET)
					--player:SetPocketActiveItem(active, ActiveSlot.SLOT_POCKET, true)
				end
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.updateShiori)


function wakaba:ItemUse_Shiori(useditem, rng, player, useflag, slot, vardata)
	if wakaba.shioriblacklisted[useditem] then return end
	if useflag | UseFlag.USE_VOID == UseFlag.USE_VOID then return end
	if slot == ActiveSlot.SLOT_POCKET2 then return end
	if (player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B) and slot ~= -1 then
		local item = Isaac.GetItemConfig():GetCollectible(useditem)
		local charge = REPENTOGON and wakaba:GetCalculatedMaidMaxCharges(player, useditem) or item.MaxCharges
		local chargeType = item.chargeType
		local consume = charge
		if useditem == wakaba.Enums.Collectibles.BOOK_OF_CONQUEST then return end
		if ((item.ChargeType == ItemConfig.CHARGE_TIMED or item.ChargeType == ItemConfig.CHARGE_SPECIAL)
		and not wakaba:has_value(wakaba.shioriwhitelisted, useditem)) then
			if player:GetActiveCharge(slot) + player:GetBatteryCharge(slot) >= charge then
				return
			else
				consume = 1
			end
		end
		if wakaba:has_value(wakaba.shioriwhitelisted, useditem) then
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
			local data = player:GetData()
			data.wakaba = data.wakaba or {}
			data.wakaba.books = wakaba:GetRandomBook(wakaba.bookstate.BOOKSHELF_SHIORI, player)
			if wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
				player:AddCollectible(data.wakaba.books[1], 0, false, ActiveSlot.SLOT_POCKET)
				--player:SetPocketActiveItem(data.wakaba.books[1], ActiveSlot.SLOT_POCKET, true)
			end
		else
			player:AddKeys(-consume)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_Shiori)


function wakaba:PrePickupCollision_Shiori(pickup, collider, low)
	if not collider:ToPlayer() then return end
	local player = collider:ToPlayer()
	local sprite = pickup:GetSprite()
	if player:GetPlayerType() == wakaba.Enums.Players.SHIORI
	or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B
	then
		if pickup:IsShopItem() and (not wakaba:canAffordPickup(player, pickup) or not player:IsExtraAnimationFinished()) then
			return true
		elseif sprite:IsPlaying("Collect") then
			return true
		elseif pickup.Wait > 0 then
			return not sprite:IsPlaying("Idle")
		elseif sprite:WasEventTriggered("DropSound") or sprite:IsPlaying("Idle") or sprite:GetAnimation() == "Idle" then
			if pickup.Price == PickupPrice.PRICE_SPIKES then
				local tookDamage = player:TakeDamage(2, DamageFlag.DAMAGE_SPIKES | DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(nil), 30)
				if not tookDamage then
					return pickup:IsShopItem()
				end
			end
			if pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY then
				if player:GetNumKeys() < 99 then
					player:AddKeys(wakaba.Enums.ShioriBatteries[pickup.SubType] or 3)
					if not pickup:IsShopItem() then
						local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 1, Vector(player.Position.X, player.Position.Y - 75), Vector.Zero, nil):ToEffect()
						--notif:FollowParent(player)
						notif.DepthOffset = player.DepthOffset + 5
						SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE, 2, 0, false, 1)
					end
					if pickup.SubType == BatterySubType.BATTERY_GOLDEN then
						player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(pickup), 0)
					end
				else
					return pickup:IsShopItem()
				end
			elseif pickup.Variant == PickupVariant.PICKUP_KEY then
				if pickup.SubType == KeySubType.KEY_CHARGED then
					if player:GetNumKeys() < 99 then
						player:AddKeys(3)
					else
						return pickup:IsShopItem()
					end
				end
			elseif pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE and wakaba.runstate.currentshiorimode == wakaba.shiorimodes.SHIORI_PURE_BODY then

				local itemID = pickup.SubType
				local config = Isaac.GetItemConfig():GetCollectible(itemID)
				if itemID > 0 and config and not config:HasTags(ItemConfig.TAG_QUEST) then


					if pickup:IsShopItem() then
						wakaba:PurchasePickup(player, pickup)
					end
					for i = 1, 8 + (config.Quality * 2) do
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, pickup.Position, wakaba.RandomVelocity(), nil)
					end
					player:AnimateSad()
					pickup:Die()
					return false
				end
			end
			wakaba:RemoveOtherOptionPickups(pickup)


			if pickup:IsShopItem() and pickup.Price ~= PickupPrice.PRICE_FREE then
				wakaba:PurchasePickup(player, pickup)
				pickup:GetData().wakaba_purchased = true
				return true
			elseif not pickup:GetData().wakaba_purchased then
				sprite:Play("Collect", true)
				pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
				pickup:Die()
			end

		else
			--return false
		end
	end

end
--wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PrePickupCollision_Shiori)


function wakaba:PostShioriPickupCollision(pickup, collider, low)
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
			elseif pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE
			and wakaba.runstate.currentshiorimode == wakaba.shiorimodes.SHIORI_PURE_BODY
			and player:GetPlayerType() == wakaba.Enums.Players.SHIORI then
				if pickup.Wait > 0 then return false end
				local itemID = pickup.SubType
				local config = Isaac.GetItemConfig():GetCollectible(itemID)
				if itemID > 0 and config and not config:HasTags(ItemConfig.TAG_QUEST) then

					if pickup:IsShopItem() then
						if pickup.Price > 0 then
							if player:GetNumCoins() >= pickup.Price then
								player:AddCoins(pickup.Price * -1)
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


					for i = 1, 8 + (config.Quality * 2) do
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, pickup.Position, wakaba.RandomVelocity(), nil)
						player:AnimateSad()
						pickup:Remove()
					end
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.PostShioriPickupCollision)

function wakaba:PostNPCDeathShiori(entity)
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
wakaba:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, wakaba.PostNPCDeathShiori)

function wakaba:PreTakeDamageShiori(entity, amount, flags, source, countdown)
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
wakaba:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, wakaba.PreTakeDamageShiori)

function wakaba:PreRoomClearShiori(rng, spawnPosition)
	local hasshiori = false
	local shioriluck = 0
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if (player:GetPlayerType() == wakaba.Enums.Players.SHIORI or player:GetPlayerType() == wakaba.Enums.Players.SHIORI_B) then
			hasshiori = true
			shioriluck = shioriluck + player.Luck
			local rng = wakaba.PickupRNG
			local randomNum = rng:RandomFloat()
			randomNum = randomNum * 100
			local minNum = 50
			minNum = minNum + (shioriluck * 4)
			if randomNum <= minNum then
				player:AddKeys(1)
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, wakaba.PreRoomClearShiori)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_GREED_MODE_WAVE, wakaba.PreRoomClearShiori)

function wakaba:getShioriBookCapacity()
	local extraCount = 0
	return wakaba.Enums.Constants.SHIORI_BOOKS + extraCount
end

function wakaba:NewLevel_Shiori()
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == playerType
		and (wakaba.runstate.currentshiorimode == wakaba.shiorimodes.SHIORI_AKASIC_RECORDS and wakaba.G.TimeCounter > 0) then
			if wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
				local data = player:GetData()
				data.wakaba.books = wakaba:GetRandomBook(wakaba.bookstate.BOOKSHELF_AKASIC_RECORDS, player, wakaba:getShioriBookCapacity())
				--player:SetPocketActiveItem(data.wakaba.books[1], ActiveSlot.SLOT_POCKET, true)
				player:AddCollectible(data.wakaba.books[1], 0, false, ActiveSlot.SLOT_POCKET)
				data.wakaba.bookindex = 1
			end
		end
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

function wakaba:AfterShioriInit(player)
	player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		local data = player:GetData()
		data.wakaba = data.wakaba or {}
		if wakaba.state.options.shiorimodes == wakaba.shiorimodes.SHIORI_LIBRARIAN then
			data.wakaba.books = wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_SHIORI)
			if player:GetActiveItem(ActiveSlot.SLOT_POCKET) <= 0 and wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
				player:SetPocketActiveItem(data.wakaba.books[1], ActiveSlot.SLOT_POCKET, true)
				--player:AddCollectible(data.wakaba.books[1], 0, false, ActiveSlot.SLOT_POCKET)
			end
		elseif wakaba.state.options.shiorimodes == wakaba.shiorimodes.SHIORI_COLLECTOR then
			data.wakaba.books = wakaba:GetRandomBook(wakaba.bookstate.BOOKSHELF_SHIORI, player)
			if wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
				player:SetPocketActiveItem(data.wakaba.books[1], ActiveSlot.SLOT_POCKET, true)
				--player:AddCollectible(data.wakaba.books[1], 0, false, ActiveSlot.SLOT_POCKET)
			end
		elseif wakaba.state.options.shiorimodes == wakaba.shiorimodes.SHIORI_AKASIC_RECORDS then
			data.wakaba.books = wakaba:GetRandomBook(wakaba.bookstate.BOOKSHELF_AKASIC_RECORDS, player, wakaba:getShioriBookCapacity())
			if player:GetActiveItem(ActiveSlot.SLOT_POCKET) <= 0 and wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
				player:SetPocketActiveItem(data.wakaba.books[1], ActiveSlot.SLOT_POCKET, true)
				--player:AddCollectible(data.wakaba.books[1], 0, false, ActiveSlot.SLOT_POCKET)
			end
		elseif wakaba.state.options.shiorimodes == wakaba.shiorimodes.SHIORI_PURE_BODY then
			data.wakaba.books = wakaba:GetBookItems(wakaba.bookstate.BOOKSHELF_PURE_SHIORI)
			if player:GetActiveItem(ActiveSlot.SLOT_POCKET) <= 0 and wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
				player:SetPocketActiveItem(data.wakaba.books[1], ActiveSlot.SLOT_POCKET, true)
				--player:AddCollectible(data.wakaba.books[1], 0, false, ActiveSlot.SLOT_POCKET)
			end
		elseif wakaba.state.options.shiorimodes == wakaba.shiorimodes.SHIORI_MINERVA then
			data.wakaba.books = {}
		elseif wakaba.state.options.shiorimodes == wakaba.shiorimodes.SHIORI_CURSE_OF_SATYR then
			data.wakaba.books = wakaba:GetRandomBook(wakaba.bookstate.BOOKSHELF_SHIORI, player)
			if wakaba.G.Challenge == Challenge.CHALLENGE_NULL then
				player:SetPocketActiveItem(data.wakaba.books[1], ActiveSlot.SLOT_POCKET, true)
				--player:AddCollectible(data.wakaba.books[1], 0, false, ActiveSlot.SLOT_POCKET)
			end
		end



		data.wakaba.bookindex = data.wakaba.bookindex or 1
		data.wakaba.currdamage = data.wakaba.currdamage or 0
		data.wakaba.enemieskilled = data.wakaba.enemieskilled or 0
		data.wakaba.nextshioriflag = data.wakaba.nextshioriflag or 0
		wakaba.FLog("debugShiori","Adding bookmakrs")
		if not player:HasCollectible(wakaba.SHIORI_BOOKMARK) then player:AddCollectible(wakaba.SHIORI_BOOKMARK) end
		if not player:HasCollectible(wakaba.SHIORI_BOOKMARK2) then player:AddCollectible(wakaba.SHIORI_BOOKMARK2) end
		if not player:HasCollectible(wakaba.SHIORI_BOOKMARK3) then player:AddCollectible(wakaba.SHIORI_BOOKMARK3) end

		if not player:HasTrinket(TrinketType.TRINKET_OLD_CAPACITOR, false) then
			player:AddTrinket(TrinketType.TRINKET_OLD_CAPACITOR)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM, -1)
		end
		if wakaba.G:IsGreedMode() and not player:HasTrinket(TrinketType.TRINKET_FLAT_PENNY, false) then
			player:AddTrinket(TrinketType.TRINKET_FLAT_PENNY)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM, -1)
		end


		if wakaba.state.options.cp_wakaba then
			player:EvaluateItems()
			--player:ClearCostumes()
		else
			--wakaba:GetShioriCostume(player)
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
	if Poglite then
		if wakaba.state.pog ~= nil then
			if wakaba.state.pog then
				-- Shiori POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/shiorisosig.anm2")
				Poglite:AddPogCostume("ShioriPog",playerType,pogCostume)
			else
				-- Origin POG
				local pogCostume = Isaac.GetCostumeIdByPath("gfx/characters/shioripog.anm2")
				Poglite:AddPogCostume("ShioriPog",playerType,pogCostume)
			end
		end
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