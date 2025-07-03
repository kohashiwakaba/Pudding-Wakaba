local isc = _wakaba.isc

local restock_data = {
	run = {
		ascentSharedSeeds = {},
	},
	level = {
	},
	room = {
	}
}
wakaba:saveDataManager("Crystal Restock", restock_data)
wakaba.restockdatas = restock_data

function wakaba:GetCrystalRestockData(slot)
	if wakaba:RoomShouldCheckAscent() then
		return restock_data.run[tostring(slot.InitSeed)]
	else
		return restock_data.level[tostring(slot.InitSeed)]
	end
end

function wakaba:SetRestockValue(slot, entry, value)
	if wakaba:RoomShouldCheckAscent() then
		restock_data.run[tostring(slot.InitSeed)][entry] = value
	else
		restock_data.level[tostring(slot.InitSeed)][entry] = value
	end
end

function wakaba:InitCrystalRestock(slot)
	if slot.GridCollisionClass ~= GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
		local sprite = slot:GetSprite()
		local rng = RNG()
		rng:SetSeed(slot.InitSeed, 35)
		if not wakaba:GetCrystalRestockData(slot) then
			local extraCount = 0
			for _, callback in ipairs(Isaac.GetCallbacks(wakaba.Callback.PRE_EVALUATE_CRYSTAL_RESTOCK)) do
				local evals = callback.Function(callback.Mod, callback.Param)
				if evals then
					extraCount = extraCount + evals.extraCount
				end
			end
			if wakaba:IsLunatic() then
				extraCount = extraCount - 1
			end
			local reservedPos = Vector(slot.Position.X, slot.Position.Y)
			if wakaba:RoomShouldCheckAscent() then
				restock_data.run[tostring(slot.InitSeed)] = {
					restockType = slot.Variant,
					restockCount = (wakaba.Enums.CrystalRestockTypes[slot.SubType] or 3) + extraCount,
					reservedX = reservedPos.X,
					reservedY = reservedPos.Y,
					dead = false,
				}
			else
				restock_data.level[tostring(slot.InitSeed)] = {
					restockType = slot.Variant,
					restockCount = (wakaba.Enums.CrystalRestockTypes[slot.SubType] or 3) + extraCount,
					reservedX = reservedPos.X,
					reservedY = reservedPos.Y,
					dead = false,
				}
			end
			sprite:Play("Idle")
		end
		slot:AddEntityFlags(EntityFlag.FLAG_NO_REWARD | EntityFlag.FLAG_NO_KNOCKBACK | EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_NO_DEATH_TRIGGER)
		local restockData = wakaba:GetCrystalRestockData(slot)
		if restockData.dead then
			slot:Remove()
		end
	end
end
wakaba:AddCallback(wakaba.Callback.SLOT_INIT, wakaba.InitCrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)

function wakaba:convertRestockMachines(entype, var, subtype, grindex, seed)
	if wakaba:IsEntryUnlocked("crystalrestock") and entype == EntityType.ENTITY_SLOT and var == 10 then
		local rand = wakaba.RNG
		rand:SetSeed(rand:Next(),1)
		local ran = rand:RandomFloat()
		if ran < wakaba:getOptionValue("crystalrestockchance") / 100 then
			return {EntityType.ENTITY_SLOT, wakaba.Enums.Slots.CRYSTAL_RESTOCK, 0}
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, wakaba.convertRestockMachines)


function wakaba:SlotCollision_CrystalRestock(slot, player)
	if REPENTOGON then
		player = player:ToPlayer()
		if not player then return end
	end
	if (slot:GetSprite():GetAnimation() == "Idle") and not slot:GetSprite():IsOverlayPlaying("CoinInsert") and player:GetNumCoins() >= 5 then
		local restockData = wakaba:GetCrystalRestockData(slot)
		if not restockData.dead then
			if REPENTOGON and player:HasCollectible(wakaba.Enums.Collectibles.PRESTIGE_PASS) then
			else
			player:AddCoins(-5)
			end
			--restockData.restockCount = restockData.restockCount - 1
			slot:GetSprite():PlayOverlay("CoinInsert")
		end
	end
end
wakaba:AddCallback(wakaba.Callback.SLOT_COLLISION, wakaba.SlotCollision_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)

function wakaba:SlotUpdate_CrystalRestock(slot)
	local restockData = wakaba:GetCrystalRestockData(slot)
	local slotSprite = slot:GetSprite()

	if restockData.restockCount > 0 and slotSprite:IsOverlayFinished("CoinInsert") then
		slotSprite:RemoveOverlay()
		slotSprite:Play("Initiate")
		SFXManager():Play(SoundEffect.SOUND_COIN_SLOT, 1.0, 0, false, 1.0)
		wakaba:SetRestockValue(slot, "restockCount", restockData.restockCount - 1)
		wakaba.G:GetRoom():ShopRestockFull()
		if restockData.restockCount == 0 then
			slot.GridCollisionClass = 5
		end
	end
	if slotSprite:IsFinished("Initiate") then
		slotSprite:Play("Idle")
	end

	if slot.GridCollisionClass == 5 then
		wakaba:RemoveDefaultPickup(slot)
		if restockData.restockCount > 0 then
			wakaba:SetRestockValue(slot, "restockCount", restockData.restockCount - 1)
			wakaba.G:GetRoom():ShopRestockFull()
			if restockData.restockCount > 0 then
				local new = wakaba.G:Spawn(EntityType.ENTITY_SLOT, slot.Variant, slot.Position, Vector.Zero, slot.SpawnerEntity, slot.SubType, slot.InitSeed)
				local newSprite = new:GetSprite()
				newSprite:Play("Initiate")
				slot:Remove()
			end
		elseif restockData.restockCount <= 0 and not restockData.dead then
			wakaba:SetRestockValue(slot, "dead", true)
			SFXManager():Play(SoundEffect.SOUND_BOSS1_EXPLOSIONS)
			SFXManager():Play(SoundEffect.SOUND_MIRROR_BREAK)
			local explosion = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, slot.Position, Vector.Zero, nil)
			wakaba.G:BombExplosionEffects(slot.Position, 0, TearFlags.TEAR_NORMAL, Color.Default, nil, 0.00001, false, false, 0)
			slot:GetSprite():Play("Death")
			slot:ClearEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK | EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
		end
	end

end

wakaba:AddCallback(wakaba.Callback.SLOT_UPDATE, wakaba.SlotUpdate_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)

function wakaba:DoEntitiesOverlap(entity1, entity2)
	return entity1.Position:Distance(entity2.Position) <= entity1.Size + entity2.Size
end

function wakaba:RemoveDefaultPickup(slot)
	for i = 4, 5 do
		for _, entity in pairs(Isaac.FindByType(i)) do
			if wakaba:DoEntitiesOverlap(entity, slot) and entity.FrameCount <= 1 then
				entity:Remove()
			end
		end
	end
end