local isc = require("wakaba_src.libs.isaacscript-common")

local restock_data = {
	run = {
	},
	floor = {
	},
	room = {
	}
}
wakaba:saveDataManager("Crystal Restock", restock_data)
wakaba.restockdatas = restock_data

function wakaba:InitCrystalRestock(slot)
	if slot.GridCollisionClass ~= GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER and not slot:GetSprite():IsPlaying("Broken") then
		local sprite = slot:GetSprite()
		local rng = RNG()
		rng:SetSeed(slot.InitSeed, 35)
		if not restock_data.floor[tostring(slot.InitSeed)] then
			local reservedPos = Vector(slot.Position.X, slot.Position.Y)
			restock_data.floor[tostring(slot.InitSeed)] = {
				restockType = slot.Variant,
				restockCount = wakaba.Enums.CrystalRestockTypes[slot.SubType] or 3,
				reservedX = reservedPos.X,
				reservedY = reservedPos.Y,
			}
			sprite:Play("Idle")
		end
		slot:AddEntityFlags(EntityFlag.FLAG_NO_REWARD)
	end
end
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_SLOT_INIT, wakaba.InitCrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)

function wakaba:convertRestockMachines(entype, var, subtype, grindex, seed)
	if --[[ wakaba.state.unlock.crystalrestock > 0 and  ]] entype == EntityType.ENTITY_SLOT and var == 10 then
		local rand = wakaba.RNG
		rand:SetSeed(rand:Next(),1)
		local ran = rand:RandomFloat()
		if ran < wakaba.state.options.fortunereplacechance / 100 then
			return {EntityType.ENTITY_SLOT, wakaba.Enums.Slots.CRYSTAL_RESTOCK, 0}
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, wakaba.convertRestockMachines)


function wakaba:SlotCollision_CrystalRestock(slot, player)
	if slot:GetSprite():IsPlaying("Idle") and not slot:GetSprite():IsOverlayPlaying("CoinInsert") and not slot:GetSprite():IsOverlayFinished("CoinInsert") and player:GetNumCoins() >= 5 then
		local restockData = restock_data.floor[tostring(slot.InitSeed)]
		player:AddCoins(-5)
		--restockData.restockCount = restockData.restockCount - 1
		slot:GetSprite():PlayOverlay("CoinInsert")
	end
end
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_SLOT_COLLISION, wakaba.SlotCollision_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)

function wakaba:SlotUpdate_CrystalRestock(slot)
	local restockData = restock_data.floor[tostring(slot.InitSeed)]
	local slotSprite = slot:GetSprite()
	--print(slotSprite:GetAnimation())
	if restockData.restockCount > 0 and slotSprite:IsOverlayFinished("CoinInsert") then
		slotSprite:RemoveOverlay()
		SFXManager():Play(SoundEffect.SOUND_COIN_SLOT, 1.0, 0, false, 1.0)
		restockData.restockCount = restockData.restockCount - 1
		wakaba.G:GetRoom():ShopRestockFull()
	end
	if slot.GridCollisionClass == GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
		if not (slotSprite:IsPlaying("Death") or slotSprite:IsFinished("Death") or slotSprite:IsPlaying("Broken") or slotSprite:IsFinished("Broken")) then
			slot:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(slot), 0)
			slot:GetSprite():Play("Death")
		end
	end
	if slotSprite:IsPlaying("Death") or slotSprite:IsFinished("Death") or slotSprite:IsPlaying("Broken") or slotSprite:IsFinished("Broken") then
		if not restockData.deathFrame or restockData.deathFrame == 1 then
			--print(restockData.deathFrame)
			restockData.deathFrame = slot.FrameCount
		end
	end
	
	
	if restockData.restockCount <= 0 and not (slotSprite:IsPlaying("Death") or slotSprite:IsFinished("Death") or slotSprite:IsPlaying("Broken") or slotSprite:IsFinished("Broken")) then
		SFXManager():Play(SoundEffect.SOUND_BOSS1_EXPLOSIONS)
		SFXManager():Play(SoundEffect.SOUND_MIRROR_BREAK)
		local explosion = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, slot.Position, Vector.Zero, nil)
		wakaba.G:BombExplosionEffects(slot.Position, 0, TearFlags.TEAR_NORMAL, Color.Default, nil, 0.00001, false, false, 0)
		slot:GetSprite():Play("Death")
	end
end

wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_SLOT_UPDATE, wakaba.SlotUpdate_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)



function wakaba:ExplosionUpdate_CrystalRestock(effect)
	if effect.FrameCount == 2 then
		local slots = Isaac.FindByType(EntityType.ENTITY_SLOT, wakaba.Enums.Slots.CRYSTAL_RESTOCK, -1, false, true)
		for _, slot in ipairs(slots) do
			local restockData = restock_data.floor[tostring(slot.InitSeed)]
			--print(restockData.deathFrame, slot.FrameCount-15)
			if restockData.deathFrame and restockData.deathFrame >= slot.FrameCount - 15 then
				local distance = slot.Position:Distance(effect.Position)
				--print(restockData.restockCount)
				if restockData.restockCount > 0 and distance < 120 and distance > 25 then
					wakaba.G:GetRoom():ShopRestockFull()
					local newSlot = wakaba.G:Spawn(EntityType.ENTITY_SLOT, slot.Variant, Vector(restockData.reservedX, restockData.reservedY), Vector.Zero, nil, slot.SubType, slot.InitSeed)
					local newRestockData = restock_data.floor[tostring(slot.InitSeed)]
					newRestockData.restockCount = newRestockData.restockCount - 1
					newRestockData.deathFrame = 1
					newSlot:GetSprite():Play("Initiate")
					slot:Remove()
				end
			end
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, CallbackPriority.LATE, wakaba.ExplosionUpdate_CrystalRestock, EffectVariant.BOMB_EXPLOSION)


function wakaba:PickupUpdate_CrystalRestock(pickup)
	if (pickup.Type == EntityType.ENTITY_BOMB or (pickup.Type == EntityType.ENTITY_PICKUP and not pickup:IsShopItem() and pickup.Variant ~= 100))
	and pickup.FrameCount < 9 and pickup.FrameCount < Game():GetRoom():GetFrameCount() then
		local slots = Isaac.FindByType(EntityType.ENTITY_SLOT, wakaba.Enums.Slots.CRYSTAL_RESTOCK, -1, false, true)
		for _, slot in ipairs(slots) do
			local restockData = restock_data.floor[tostring(slot.InitSeed)]
			local distance = slot.Position:Distance(pickup.Position)
			if restockData.restockCount > 0 and distance < 25 then
				if restockData.deathFrame and restockData.deathFrame >= slot.FrameCount - 15 then
					pickup:Remove()
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.PickupUpdate_CrystalRestock)
wakaba:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, wakaba.PickupUpdate_CrystalRestock, BombSubType.BOMB_TROLL)
wakaba:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, wakaba.PickupUpdate_CrystalRestock, BombSubType.BOMB_GOLDEN)


function wakaba:SlotDestroyed_CrystalRestock(slot)
	local restockData = restock_data.floor[tostring(slot.InitSeed)]
	if restockData.restockCount > 0 then
		restockData.restockCount = restockData.restockCount - 1
		wakaba.G:GetRoom():ShopRestockFull()
		wakaba.G:Spawn(EntityType.ENTITY_SLOT, slot.Variant, slot.Position, Vector.Zero, nil, slot.SubType, slot.InitSeed)
		slot:Remove()
	else
		if not (slot:GetSprite():IsPlaying("Death") or slot:GetSprite():IsPlaying("Broken")) then
			--slot:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(slot), 0)
			slot:GetSprite():Play("Broken")
		end
	end
end
--wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_SLOT_DESTROYED, wakaba.SlotDestroyed_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)