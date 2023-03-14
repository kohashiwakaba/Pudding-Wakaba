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
	if slot.GridCollisionClass ~= GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
		local sprite = slot:GetSprite()
		local rng = RNG()
		rng:SetSeed(slot.InitSeed, 35)
		if not restock_data.floor[tostring(slot.InitSeed)] then
			restock_data.floor[tostring(slot.InitSeed)] = {
				restockType = slot.Variant,
				restockCount = wakaba.Enums.CrystalRestockTypes[slot.SubType] or 3,
			}
		end
		slot:AddEntityFlags(EntityFlag.FLAG_NO_REWARD)
		sprite:Play("Idle")
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
	if restockData.restockCount > 0 and slot:GetSprite():IsOverlayFinished("CoinInsert") then
		slot:GetSprite():RemoveOverlay()
		SFXManager():Play(SoundEffect.SOUND_COIN_SLOT, 1.0, 0, false, 1.0)
		restockData.restockCount = restockData.restockCount - 1
		wakaba.G:GetRoom():ShopRestockFull()
	end
	if restockData.restockCount <= 0 and not (slot:GetSprite():IsPlaying("Death") or slot:GetSprite():IsPlaying("Broken")) then
		slot:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(slot), 0)
		wakaba.G:BombExplosionEffects(slot.Position, 0, TearFlags.TEAR_NORMAL, Color.Default, nil, 0.0001, false, false, 0)
	end
end

wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_SLOT_UPDATE, wakaba.SlotUpdate_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)

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
wakaba:AddCallbackCustom(isc.ModCallbackCustom.POST_SLOT_DESTROYED, wakaba.SlotDestroyed_CrystalRestock, wakaba.Enums.Slots.CRYSTAL_RESTOCK)