wakaba.SLOT_ANOTHER_FORTUNE = Isaac.GetEntityVariantByName("Another Fortune Machine")
wakaba.afspool = {
	BLEND_HEART = 89,
	CARD = 55,
	RUNE = 26,
	GOLDEN_TRINKET = 11,
	DICE_SHARD = 48,
	JOKER = 37,
	STAR_ITEM = 22,
}
--[[ options used : 
	fortunereplaceoptions
]]
if EID then
	local t = ""
	t = t .. "{{Key}} Requires 5 Keys to activate"
	t = t .. "#{{Warning}} Bumping into the Machine spawns one of followings :"
	t = t .. "#{{BlendedHeart}} {{ColorSilver}}Blended Heart"
	t = t .. "#{{Card}} {{ColorSilver}}Random Card"
	t = t .. "#{{Card49}} {{ColorSilver}}Dice Shard"
	t = t .. "#{{Card31}} {{ColorSilver}}Joker"
	t = t .. "#{{Rune}} {{ColorSilver}}Random Rune"
	t = t .. "#{{Trinket}} {{ColorSilver}}Golden Trinket"
	t = t .. "#{{PlanetariumChance}} {{ColorSilver}}Star-related collectible"
	t = t .. "#{{Warning}} Spawning 5 (3 in Hard Mode) or more times has high chance to explode"
	--EID:addEntity(EntityType.ENTITY_SLOT, wakaba.SLOT_ANOTHER_FORTUNE, 0, "Shiori's Another Fortune Machine", t, "en_us")
	
end


function wakaba:NewLevel_ResetAnotherFortuneData()
  wakaba.state.anotherfortunerolled = {}
  wakaba.state.anotherfortunepedestals = {}
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_ResetAnotherFortuneData)



local function getAFReward(rand)
	local pool = wakaba.afspool
	local totalWeight = 0
	for k,v in pairs(pool) do
		totalWeight = totalWeight + v
	end
	--print(rand)
	if rand % totalWeight < pool.BLEND_HEART then
		return pool.BLEND_HEART
	elseif rand % totalWeight < pool.BLEND_HEART + pool.CARD then
		return pool.CARD
	elseif rand % totalWeight < pool.BLEND_HEART + pool.CARD + pool.JOKER then
		return pool.JOKER
	elseif rand % totalWeight < pool.BLEND_HEART + pool.CARD + pool.JOKER + pool.DICE_SHARD then
		return pool.DICE_SHARD
	elseif rand % totalWeight < pool.BLEND_HEART + pool.CARD + pool.JOKER + pool.DICE_SHARD + pool.RUNE then
		return pool.RUNE
	elseif rand % totalWeight < pool.BLEND_HEART + pool.CARD + pool.JOKER + pool.DICE_SHARD + pool.RUNE + pool.GOLDEN_TRINKET then
		return pool.GOLDEN_TRINKET
	else
		return pool.STAR_ITEM
	end
end

function wakaba:PlayerCollision_AnotherFortune(player, slot, low)
	if slot.Type == EntityType.ENTITY_SLOT and slot.Variant == wakaba.SLOT_ANOTHER_FORTUNE then
		if slot:GetSprite():IsPlaying("Idle") and player:GetNumKeys() >= 5 then
			player:AddKeys(-5)
			wakaba:RollSlot_AnotherFortune(slot, player)
			
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, wakaba.PlayerCollision_AnotherFortune)




function wakaba:ResetFortuneStatus()
	
	local slots = Isaac.FindByType(EntityType.ENTITY_SLOT, wakaba.SLOT_ANOTHER_FORTUNE)
	for _, slot in pairs(slots) do
		slot:GetSprite():Play("Idle")
	end
end

function wakaba:Update_AnotherFortune()
	local slots = Isaac.FindByType(EntityType.ENTITY_SLOT, wakaba.SLOT_ANOTHER_FORTUNE)
	for _, slot in pairs(slots) do
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
					slot:GetData().prizethreshold = nil
				end
			end
		end
		if slot:GetSprite():IsFinished("Prize") then
			local threshold = 5
			local exploderate = 20
			local exploderatemultiplier = 1
			if wakaba.G.Difficulty == Difficulty.DIFFICULTY_HARD or wakaba.G.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
				threshold = 3
				exploderate = 30
				exploderatemultiplier = 2
			end 
			if slot:GetData().wakabacount >= threshold then
				local finalexplodechance = exploderate + (slot:GetData().wakabacount * exploderatemultiplier)
				--print(slot:GetData().explodechance, finalexplodechance)
				if (slot:GetData().explodechance * 100) >= finalexplodechance then
					slot:GetSprite():Play("Death")
					slot.GridCollisionClass = GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER
				else
					slot:GetSprite():Play("Idle")
				end
			elseif not (slot:GetSprite():IsPlaying("Death") or slot:GetSprite():IsPlaying("Broken")) then
				slot:GetSprite():Play("Idle")
			end
		end
		if slot:GetSprite():IsEventTriggered("Explosion") then
			slot:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(slot), 0)
			wakaba.G:BombExplosionEffects(slot.Position, 0, TearFlags.TEAR_NORMAL, Color.Default, nil, 1, false, false, 0)
		end
		if slot:GetSprite():IsEventTriggered("Prize") then
			--[[ 
				wakaba.afspool = {
					BLEND_HEART = 20,
					CARD = 20,
					RUNE = 10,
					GOLDEN_TRINKET = 10,
					DICE_SHARD = 20,
					JOKER = 20,
				} ]]
			local rewardflag = getAFReward(slot:GetDropRNG():Next())
			--Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_LUCKYPENNY, chest.Position, wakaba.RandomVelocity(), nil)
			if rewardflag == wakaba.afspool.BLEND_HEART then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLENDED, slot.Position, wakaba.RandomVelocity(), nil)
			elseif rewardflag == wakaba.afspool.CARD then
				local selected = wakaba.G:GetItemPool():GetCard(slot:GetDropRNG():Next(), true, false, false)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, selected, slot.Position, wakaba.RandomVelocity(), nil)
			elseif rewardflag == wakaba.afspool.RUNE then
				local selected = wakaba.G:GetItemPool():GetCard(slot:GetDropRNG():Next(), false, true, true)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, selected, slot.Position, wakaba.RandomVelocity(), nil)
			elseif rewardflag == wakaba.afspool.GOLDEN_TRINKET then
				local selected = wakaba.G:GetItemPool():GetTrinket() | TrinketType.TRINKET_GOLDEN_FLAG
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, selected, slot.Position, wakaba.RandomVelocity(), nil)
			elseif rewardflag == wakaba.afspool.DICE_SHARD then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_DICE_SHARD, slot.Position, wakaba.RandomVelocity(), nil)
			elseif rewardflag == wakaba.afspool.JOKER then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_JOKER, slot.Position, wakaba.RandomVelocity(), nil)
			elseif rewardflag == wakaba.afspool.STAR_ITEM then
				local candidates = wakaba:GetCandidatesByTag(ItemConfig.TAG_STARS)
				local entry = slot:GetDropRNG():RandomInt(#candidates) + 1
				local item = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, candidates[entry], slot.Position, Vector.Zero, nil):ToPickup()

				item:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png") 
				item:GetSprite():SetOverlayFrame("Alternates", 1)
				item:GetSprite():LoadGraphics()

				table.insert(wakaba.state.anotherfortunepedestals, item.InitSeed)
				item.Wait = 10
				wakaba.G:BombExplosionEffects(slot.Position, 0, TearFlags.TEAR_NORMAL, Color.Default, nil, 1, false, false, 0)
				slot:Remove()
			end

			SFXManager():Play(SoundEffect.SOUND_SLOTSPAWN, 1.0, 0, false, 1.0)
		end
		if slot.GridCollisionClass == GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
			if not (slot:GetSprite():IsPlaying("Death") or slot:GetSprite():IsPlaying("Broken")) then
				slot:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(slot), 0)
				slot:GetSprite():Play("Broken")
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_AnotherFortune)
--LagCheck

function wakaba:InitFortuneMachines()
	local slots = Isaac.FindByType(EntityType.ENTITY_SLOT, wakaba.SLOT_ANOTHER_FORTUNE)
	for _,slot in pairs(slots) do
		if slot.GridCollisionClass ~= GridCollisionClass.COLLISION_WALL_EXCEPT_PLAYER then
			slot:GetSprite():Play("Idle")
		end
		--[[ if wakaba.state.anotherfortunerolled[slot.InitSeed] then
			slot:GetData() = wakaba.state.anotherfortunerolled[slot.InitSeed]
		end ]]
	end
  local pedestals = Isaac.FindByType(5, 100, -1)
  for i, entity in ipairs(pedestals) do
    if wakaba:has_value(wakaba.state.anotherfortunepedestals, entity.InitSeed) then
      entity:GetSprite():ReplaceSpritesheet(5, "gfx/items/wakaba_altars.png") 
      entity:GetSprite():SetOverlayFrame("Alternates", 1)
      entity:GetSprite():LoadGraphics()
    end
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.InitFortuneMachines)


function wakaba:convertSlotMachines(entype, var, subtype, grindex, seed)
	if wakaba.state.unlock.librarycard > 0 and entype == EntityType.ENTITY_SLOT and (var == 1 or var == 3) then -- 4 is beggar; rip enums
		local rand = wakaba.RNG
		rand:SetSeed(rand:Next(),1)
		local ran = rand:RandomFloat()
		if ran < wakaba.state.options.fortunereplacechance / 100 then
			return {EntityType.ENTITY_SLOT, wakaba.SLOT_ANOTHER_FORTUNE, 0}
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, wakaba.convertSlotMachines)


function wakaba:RollSlot_AnotherFortune(slot, player)
	--print("Touched!")
	--print(slot.GridCollisionClass)
	slot:GetSprite():Play("Initiate")
	local wakabachance = slot:GetDropRNG():RandomFloat()
	local explodechance = slot:GetDropRNG():RandomFloat()
	slot:GetData().wakabacount = slot:GetData().wakabacount or 0
	slot:GetData().wakabacount = slot:GetData().wakabacount + 1
	slot:GetData().wakabachance = wakabachance
	slot:GetData().explodechance = explodechance
	SFXManager():Play(SoundEffect.SOUND_COIN_SLOT, 1.0, 0, false, 1.0)
	SFXManager():Play(SoundEffect.SOUND_KEY_DROP0, 1.0, 0, false, 1.0)
end

function wakaba:TearUpdate_AnotherFortune(tear)
	local ents = Isaac.FindInRadius(tear.Position, 12)
	for i, slot in ipairs(ents) do
		if slot.Type == EntityType.ENTITY_SLOT and slot.Variant == wakaba.SLOT_ANOTHER_FORTUNE then
			local player = tear.SpawnerEntity
			if player and player:ToPlayer() then
				player = player:ToPlayer()
			else
				player = player.GetPlayer()
			end
	
			
			if slot:GetSprite():IsPlaying("Idle") and player:GetNumKeys() >= 5 then
				wakaba:RollSlot_AnotherFortune(slot, player)
			end
		end
	end
end

wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_AnotherFortune, TearVariant.KEY)
wakaba:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, wakaba.TearUpdate_AnotherFortune, TearVariant.KEY_BLOOD)




function wakaba:PlayerUpdate_AnotherFortune(player)
	local ents = Isaac.FindInRadius(player.Position, 12)
	for i, slot in ipairs(ents) do
		if slot.Type == EntityType.ENTITY_SLOT and slot.Variant == wakaba.SLOT_ANOTHER_FORTUNE then
			if slot:GetSprite():IsPlaying("Idle") and player:GetNumKeys() >= 5 then
				player:AddKeys(-5)
				wakaba:RollSlot_AnotherFortune(slot, player)
				
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_AnotherFortune)