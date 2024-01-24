local isc = require("wakaba_src.libs.isaacscript-common")

local valut_data = {
	run = {
		ascentSharedSeeds = {},
	},
	floor = {
		cachedRewards = {},
		anotherfortunepedestals = {},
	},
	room = {

	}
}
wakaba:saveDataManager("Shiori Valut", valut_data)
wakaba.slotdatas = valut_data

function wakaba:convertSlotMachines(entype, var, subtype, grindex, seed)
	if wakaba:IsEntryUnlocked("shiorivalut") and entype == EntityType.ENTITY_SLOT and (var == 1 or var == 3) then -- 4 is beggar; rip enums
		local rand = wakaba.RNG
		rand:SetSeed(rand:Next(),1)
		local ran = rand:RandomFloat()
		if ran < wakaba.state.options.fortunereplacechance / 100 then
			return {EntityType.ENTITY_SLOT, wakaba.Enums.Slots.SHIORI_VALUT, 0}
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, wakaba.convertSlotMachines)

local function shouldCheckAscent()
	local room = wakaba.G:GetRoom()
	return room:GetType() == RoomType.ROOM_BOSS or room:GetType() == RoomType.ROOM_TREASURE
end

function wakaba:getShioriValutPrice(collectible, rng)
	local config = Isaac.GetItemConfig()
	local item = config:GetCollectible(collectible)
	if item and item:IsCollectible() then
		local quality = item.Quality
		local devilPrice = item.DevilPrice
		local shioriPrice = (quality + 2) * devilPrice
		return shioriPrice
	end
	return 12
end

---@param chest Entity | EntitySlot
---@return table
function wakaba:getValutRewards(slot)
	if valut_data.floor.cachedRewards[slot.InitSeed] then
		return valut_data.floor.cachedRewards[slot.InitSeed]
	end

	local rng = RNG()
	rng:SetSeed(slot.InitSeed, 35)
	local itemID = wakaba:GetItemFromWakabaPools("ShioriValut", false, slot.InitSeed)
	local rewards = {
		item = itemID,
		price = wakaba:getShioriValutPrice(itemID, rng),
	}
	valut_data.floor.cachedRewards[slot.InitSeed] = rewards
	return rewards
end

function wakaba:SlotInit_ShioriValut(slot)
	if slot.GridCollisionClass ~= GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
		local sprite = slot:GetSprite()
		local rng = RNG()
		rng:SetSeed(slot.InitSeed, 35)
		local slotData = wakaba:getValutRewards(slot)
		local itemgfx = isc:getCollectibleGfxFilename(slotData.item)
		local pricegfx = "gfx/items/slots/wakaba_shiorivalut_price/".. slotData.price .. ".png"
		if isc:hasCurse(LevelCurse.CURSE_OF_BLIND) then
			itemgfx = isc:getCollectibleGfxFilename(0)
		end
		sprite:Play("Idle")
		sprite:ReplaceSpritesheet(2, itemgfx)
		sprite:ReplaceSpritesheet(5, pricegfx)
		sprite:LoadGraphics()
	end
end
wakaba:AddCallback(wakaba.Callback.SLOT_INIT, wakaba.SlotInit_ShioriValut, wakaba.Enums.Slots.SHIORI_VALUT)

function wakaba:SlotUpdate_ShioriValut(slot)
	if slot:GetSprite():IsFinished("CoinInsert") then slot:GetSprite():Play("Initiate") end
	if slot:GetSprite():IsFinished("Initiate") then slot:GetSprite():Play("Wiggle") end
	--if slot:GetSprite():IsFinished("Wiggle") then slot:GetSprite():Play("Prize") end
	if slot:GetSprite():IsFinished("Death") then slot:GetSprite():Play("Broken") end
	if slot:GetSprite():IsPlaying("Wiggle") then
			slot:GetData().prizethreshold = slot:GetData().prizethreshold or 20
			if slot:GetData().prizethreshold then
				if slot:GetData().prizethreshold > 0 then
					slot:GetData().prizethreshold = slot:GetData().prizethreshold - 1
				elseif slot:GetData().prizethreshold <= 0 then
					slot:GetSprite():Play("Prize")
					SFXManager():Play(SoundEffect.SOUND_THUMBSUP, 1.0, 0, false, 1.0)
					slot:GetData().prizethreshold = nil
				end
			end
	end
	if slot:GetSprite():IsFinished("Prize") then
		--SFXManager():Play(SoundEffect.SOUND_THUMBSUP, 1.0, 0, false, 1.0)
	end
	if slot:GetSprite():IsEventTriggered("Explosion") then
		slot:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(slot), 0)
		local explosion = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, slot.Position, Vector.Zero, nil)
		--wakaba.G:BombExplosionEffects(slot.Position, 0, TearFlags.TEAR_NORMAL, Color.Default, nil, 1, false, false, 0)
	end
	if slot:GetSprite():IsEventTriggered("Prize") then
		local currentRoomIndex = isc:getRoomListIndex()
		if not valut_data.floor.anotherfortunepedestals[currentRoomIndex] then
			valut_data.floor.anotherfortunepedestals[currentRoomIndex] = {}
		end
		local rewards = wakaba:getValutRewards(slot)
		local itemID = rewards.item
		local item = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemID, slot.Position, Vector.Zero, nil):ToPickup()
		item:ClearEntityFlags(EntityFlag.FLAG_APPEAR)

		item:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png")
		item:GetSprite():SetOverlayFrame("Alternates", 1)
		item:GetSprite():LoadGraphics()
		table.insert(valut_data.floor.anotherfortunepedestals[currentRoomIndex], wakaba:getPickupIndex(item))
		if shouldCheckAscent() then
			valut_data.run.ascentSharedSeeds[wakaba:getPickupIndex(item)] = true
		end
		item.Wait = 10
		slot:Remove()
		SFXManager():Play(SoundEffect.SOUND_SLOTSPAWN, 1.0, 0, false, 1.0)
	end
	if slot.GridCollisionClass == GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
		if not (slot:GetSprite():IsPlaying("Death") or slot:GetSprite():IsPlaying("Broken")) then
			slot:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(slot), 0)
			slot:GetSprite():Play("Broken")
		end
	end
end
wakaba:AddCallback(wakaba.Callback.SLOT_UPDATE, wakaba.SlotUpdate_ShioriValut, wakaba.Enums.Slots.SHIORI_VALUT)

function wakaba:SlotCollision_ShioriValut(slot, player)
	if REPENTOGON then
		player = player:ToPlayer()
		if not player then return end
	end
	if slot:GetSprite():IsPlaying("Idle") then
		local valueData = wakaba:getValutRewards(slot)
		local price = valueData.price
		if player:GetNumKeys() >= price then
			player:AddKeys(price * -1)
			wakaba:RollSlot_ShioriValut(slot, player)
		end
	end
end
wakaba:AddCallback(wakaba.Callback.SLOT_COLLISION, wakaba.SlotCollision_ShioriValut, wakaba.Enums.Slots.SHIORI_VALUT)

function wakaba:ReplaceValutLate2(pickup)
	local room = wakaba.G:GetRoom()
	if room:GetFrameCount() < 2 then return end
	wakaba:ReplaceValutLate(pickup)
end
function wakaba:ReplaceValutLate(pickup)
	local currentRoomIndex = isc:getRoomListIndex()
	local floorCheck = valut_data.floor.anotherfortunepedestals[currentRoomIndex] ~= nil and wakaba:has_value(valut_data.floor.anotherfortunepedestals[currentRoomIndex], wakaba:getPickupIndex(pickup))
	local ascentCheck = shouldCheckAscent() and valut_data.run.ascentSharedSeeds[wakaba:getPickupIndex(pickup)] ~= nil
	if not (floorCheck or ascentCheck) then return end
	pickup:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png")
	pickup:GetSprite():SetOverlayFrame("Alternates", 1)
	pickup:GetSprite():LoadGraphics()
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, wakaba.ReplaceValutLate2, PickupVariant.PICKUP_COLLECTIBLE)
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_PICKUP_INIT_LATE, wakaba.ReplaceValutLate, PickupVariant.PICKUP_COLLECTIBLE)


function wakaba:RollSlot_ShioriValut(slot, player)
	--print("Touched!")
	--print(slot.GridCollisionClass)
	slot:GetSprite():Play("CoinInsert")
	SFXManager():Play(SoundEffect.SOUND_COIN_SLOT, 1.0, 0, false, 1.0)
	SFXManager():Play(SoundEffect.SOUND_KEY_DROP0, 1.0, 0, false, 1.0)
end

function wakaba:TearUpdate_ShioriValut(tear)
	local ents = Isaac.FindInRadius(tear.Position, 12)
	for i, slot in ipairs(ents) do
		if slot.Type == EntityType.ENTITY_SLOT and slot.Variant == wakaba.Enums.Slots.SHIORI_VALUT then
			local player = tear.SpawnerEntity
			if player and player:ToPlayer() then
				player = player:ToPlayer()
			else
				player = Isaac.GetPlayer()
			end


			if slot:GetSprite():IsPlaying("Idle") and player:GetNumKeys() >= 3 then
				wakaba:RollSlot_ShioriValut(slot, player)
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_ShioriValut, TearVariant.KEY)
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_ShioriValut, TearVariant.KEY_BLOOD)