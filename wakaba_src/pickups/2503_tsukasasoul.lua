local isc = _wakaba.isc

local damo_data = {
	run = {

	},
	room = {

	}
}
wakaba:saveDataManager("Lunar Damocles", damo_data)

if not wakaba.Flags.stackableDamocles then return end

function wakaba:UseCard_SoulOfTsukasa(_, player, flags)
	--local rng = player:GetCardRNG(wakaba.Enums.Cards.SOUL_TSUKASA)
	player:AddCollectible(wakaba.Enums.Collectibles.LUNAR_DAMOCLES)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_SoulOfTsukasa, wakaba.Enums.Cards.SOUL_TSUKASA)


function wakaba:PostTakeDamage_LunarDamocles(player, amount, flags, source, cooldown)
	if player:HasCollectible(wakaba.Enums.Collectibles.LUNAR_DAMOCLES)
	and flags & DamageFlag.DAMAGE_RED_HEARTS ~= DamageFlag.DAMAGE_RED_HEARTS
	and flags & DamageFlag.DAMAGE_NO_PENALTIES ~= DamageFlag.DAMAGE_NO_PENALTIES then
		if not player:HasCurseMistEffect() then
			local data = player:GetData()
			data.wakaba.lunardamotriggered = true
		end
	end
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_LunarDamocles)

function wakaba:GetDamoclesTimer(collectibleNum, familiar, framesPerCheck, dropChance)
	if not familiar then return end
	framesPerCheck = framesPerCheck or 4
	dropChance = dropChance or 10000
	collectibleNum = collectibleNum or 1
	dropChance = dropChance // collectibleNum
	local rng = RNG()
	rng:SetSeed(familiar.InitSeed, 35)
	local dropcounter = 0
	local dropThisFrame = false
	while not dropThisFrame do
		dropcounter = dropcounter + framesPerCheck
		local randomNum = rng:RandomInt(dropChance)
		--wakaba.Log("Damocles Test".. dropcounter .. " " .. randomNum .. " " .. dropChance)
		if randomNum == 0 then
			dropThisFrame = true
		end
	end
	--print("Lunar Damocles DropCounter:",dropcounter)
	return dropcounter
end



function wakaba:FamiliarInit_LunarDamocles(familiar)
	if not damo_data.run[tostring(familiar.InitSeed)] then
		damo_data.run[tostring(familiar.InitSeed)] = {}
		if familiar.Player then
			damo_data.run[tostring(familiar.InitSeed)].Player = isc:getPlayerIndex(familiar.Player)
		end
	end
	--familiar.IsDelayed = true
	--familiar:AddToDelayed()
	local sprite = familiar:GetSprite()
	sprite:Play("Idle")
	if damo_data.run[tostring(familiar.InitSeed)].triggered then
		sprite:ReplaceSpritesheet(0, "gfx/familiar/lunar_damocles_danger.png")
		sprite:LoadGraphics()
	end

end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.FamiliarInit_LunarDamocles, wakaba.Enums.Familiars.LUNAR_DAMOCLES)

function wakaba:Cache_LunarDamocles(player, cacheFlag)
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.Enums.Collectibles.LUNAR_DAMOCLES)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.LUNAR_DAMOCLES)
		efcount = efcount <= 64 and efcount or 64
		if hasitem or efcount > 0 then
			count = 1
		end
		player:CheckFamiliar(wakaba.Enums.Familiars.LUNAR_DAMOCLES, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.LUNAR_DAMOCLES))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_LunarDamocles)


function wakaba:FamiliarRender_LunarDamocles(familiar)
	if damo_data.run[tostring(familiar.InitSeed)] then
		local newpos = familiar.Player.Position
		local oldpos = familiar.Position
		familiar.Position = newpos
		familiar.Velocity = familiar.Player.Velocity
		--familiar.Velocity = (newpos - oldpos)
		--familiar.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length())
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, wakaba.FamiliarRender_LunarDamocles, wakaba.Enums.Familiars.LUNAR_DAMOCLES)

function wakaba:FamiliarUpdate_LunarDamocles(familiar)
	--familiar:MoveDelayed(0)
	if not damo_data.run[tostring(familiar.InitSeed)] then return end
	local damoData = damo_data.run[tostring(familiar.InitSeed)]

	local sprite = familiar:GetSprite()
	if sprite:IsFinished("Idle") then sprite:Play("Idle2") end
	if sprite:IsFinished("Idle2") then sprite:Play("Idle3") end
	if sprite:IsFinished("Idle3") then sprite:Play("Idle") end

	if not familiar.Player then return end
	if not familiar.Player:GetData().wakaba then return end

	local player = familiar.Player
	local data = player:GetData().wakaba

	if sprite:IsEventTriggered("Hit") then
		player:GetEffects():AddCollectibleEffect(wakaba.Enums.Collectibles.LUNAR_DAMOCLES)
		player:RemoveCollectible(wakaba.Enums.Collectibles.LUNAR_DAMOCLES)

		local collectibles = wakaba:getCurrentCollectibles(player, false, true)
		local collectibleCount = #collectibles
		local removedCollectibles = 0
		local removedItems = {

		}
		local collectiblesToRemove = collectibleCount // 2
		local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.LUNAR_DAMOCLES)
		while removedCollectibles < collectiblesToRemove do
			local TargetIndex = rng:RandomInt(#collectibles) + 1
			local targetItem = collectibles[TargetIndex]
			if not isc:isQuestCollectible(targetItem) then
				player:RemoveCollectible(targetItem)
				removedCollectibles = removedCollectibles + 1
				table.remove(collectibles, TargetIndex)
			end
		end
		data.lunardamotriggered = nil
		damo_data.run[tostring(familiar.InitSeed)] = nil
		player:TakeDamage(1, DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_INVINCIBLE, EntityRef(player), 0)
		SFXManager():Play(SoundEffect.SOUND_DEATH_BURST_SMALL)
		SFXManager():Play(SoundEffect.SOUND_DEATH_CARD)
		SFXManager():Play(SoundEffect.SOUND_MEATY_DEATHS)
		SFXManager():Play(SoundEffect.SOUND_BLACK_POOF)
		wakaba.G:ShakeScreen(15)
	end

	if not player:HasCurseMistEffect() and (data.lunardamotriggered or damoData.triggered) then
		if damoData.timer then
			damoData.timer = damoData.timer - 1
			--print("Lunar Damocles current:",damoData.timer)
			if damoData.timer < 0 and not sprite:IsPlaying("Fall") then
				sprite:Play("Fall", true)
				--data.lunardamotriggered = nil
			end
		else
			sprite:ReplaceSpritesheet(0, "gfx/familiar/lunar_damocles_danger.png")
			sprite:LoadGraphics()
			damoData.triggered = true
			damoData.timer = wakaba:GetDamoclesTimer(player:GetCollectibleNum(wakaba.Enums.Collectibles.LUNAR_DAMOCLES), familiar, 4, 2500)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_LunarDamocles, wakaba.Enums.Familiars.LUNAR_DAMOCLES)

function wakaba:TestLunarDamocles()
	local player = EID.player
	local data = player:GetData().wakaba
	data.lunardamotriggered = true

end

local function LunarDamoCount()
	local damoclesCount = 0
	local damoData = damo_data.run
	for damoSeed, data in pairs (damoData) do
		if data then
			damoclesCount = damoclesCount + 1
		end
	end
	return damoclesCount
end
CCO.DamoclesAPI.AddDamoclesCallback(LunarDamoCount)