
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:CoinUpdate_EasterEgg(pickup)
	if pickup.SubType ~= wakaba.Enums.Coins.EASTER_EGG then return end
	
	if pickup:GetSprite():IsEventTriggered("DropSound") then
		SFXManager():Play(SoundEffect.SOUND_PENNYDROP, 1, 0, false, 1)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, wakaba.CoinUpdate_EasterEgg, PickupVariant.PICKUP_COIN)

function wakaba:CoinCollision_EasterEgg(pickup, collider)
	if pickup.SubType ~= wakaba.Enums.Coins.EASTER_EGG then return end
	
	if collider:ToPlayer() or
	   (collider:ToFamiliar() and (collider.Variant == FamiliarVariant.BUM_FRIEND or
							  collider.Variant == FamiliarVariant.BUMBO or
							  collider.Variant == FamiliarVariant.SUPER_BUM))
	then
		local sprite = pickup:GetSprite()
		if not (sprite:WasEventTriggered("DropSound") or sprite:IsPlaying("Idle")) then
			return false
		end

		local player = collider:ToPlayer()
		local familiar = collider:ToFamiliar()

		if player then
			player:AddCoins(1)
			player:AddCollectible(wakaba.Enums.Collectibles.EASTER_EGG)
		elseif familiar then
			familiar.Coins = familiar.Coins + 1
			if familiar.Player then
				familiar.Player:AddCollectible(wakaba.Enums.Collectibles.EASTER_EGG)
			end
		end
		--sfx:Play(SoundEffect.SOUND_CANDLE_LIGHT, 1, 0, false, 1)
		SFXManager():Play(SoundEffect.SOUND_SOUL_PICKUP, 1.3, 0, false, 1)

		wakaba:RemoveOtherOptionPickups(pickup)

		pickup.Velocity = Vector.Zero
		pickup.Touched = true
		pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
		sprite:Play("Collect", true)
		pickup:Die()
		
		Game():SetStateFlag(GameStateFlag.STATE_HEART_BOMB_COIN_PICKED, true)

		return true
	elseif collider.Type == EntityType.ENTITY_ULTRA_GREED or
				collider.Type == EntityType.ENTITY_BUMBINO
	then
		pickup.SubType = 1
		return
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, wakaba.CoinCollision_EasterEgg, PickupVariant.PICKUP_COIN)

function wakaba:Cache_EasterEgg(player, cacheFlag)
	local eecount = player:GetCollectibleNum(wakaba.Enums.Collectibles.EASTER_EGG)
	local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.EASTER_EGG)
	local chimaki = wakaba:hasChimaki(player)
	if cacheFlag & CacheFlag.CACHE_FAMILIARS == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		efcount = efcount <= 64 and efcount or 64
		if (eecount + efcount > 0) and not (chimaki and eecount >= 5) then
			count = 1
		end
		player:CheckFamiliar(wakaba.Enums.Familiars.EASTER_EGG, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.EASTER_EGG))
	end
end
wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_EasterEgg)

function wakaba:FamiliarInit_EasterEgg(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()
	familiar.FireCooldown = 3
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.FamiliarInit_EasterEgg, wakaba.Enums.Familiars.EASTER_EGG)

--[[ 
for i = 1, 2 do
	local variant = FamiliarVariant["MERN_"..i]
	mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, function(_, fam)
		fam:AddToOrbit(0)
	end, variant)

	mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, function(_, fam, other, low)
		if other:ToProjectile() and other:GetData().CharmedMernProj == fam.Index .. " " .. fam.InitSeed then
			return true
		elseif other:ToProjectile() then
			other:Die()
		end
	end, variant)
end ]]

local dirToStr = {
	[Direction.NO_DIRECTION] = "",
	[Direction.DOWN] = "Down",
	[Direction.UP] = "Up",
	[Direction.LEFT] = "Side",
	[Direction.RIGHT] = "Side",
}
local dirToVec = {
	[Direction.NO_DIRECTION] = Vector(0,0),
	[Direction.LEFT] = Vector(-1,0),
	[Direction.UP] = Vector(0,-1),
	[Direction.RIGHT] = Vector(1,0),
	[Direction.DOWN] = Vector(0,1)
}

function wakaba:ShootEasterEggTear(position, vector, spawner, dmg)
	local isSuperpositioned = wakaba:isSuperpositionedPlayer(spawner.Player)
	local hasBffs = spawner.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS)
	local tear = Isaac.Spawn(2, 0, 0, position, vector, spawner):ToTear()
	tear:GetData().wakaba = tear:GetData().wakaba or {}
	tear:GetData().wakaba.isEasterEggTear = true

	local tcolor = Color(1, 1, 1, 1, 0, 0, 0)
	tcolor:SetColorize(wakaba.RGB.R/255,wakaba.RGB.G/255,wakaba.RGB.B/255, 1)
	local ntcolor = Color.Lerp(tear.Color, tcolor, 0.88)
	ntcolor.A = ntcolor.A * 0.8

	tear.Color = ntcolor

	tear.CollisionDamage = dmg
	tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING | TearFlags.TEAR_SPECTRAL

	local sprite = tear:GetSprite()
	--sprite:Load("gfx/009.005_corn projectile.anm2", true)

	--corn.FallingSpeed = -15
	--corn.FallingAcceleration = 1
	--corn.Color = Color(1,0.8,0,1,0,0,0)

	if isSuperpositioned then
		local tearcolor = Color.Lerp(tear.Color, Color(1,1,1,1,0,0,0), 0)
		tearcolor.A = tearcolor.A / 4

		tear.CollisionDamage = tear.CollisionDamage / 4
		tear.Color = tearcolor
	end
	return tear
end


function wakaba:FamiliarUpdate_EasterEgg(familiar)
	--local off = EntityFamiliar.GetOrbitDistance(0)
	--local val = math.sin(math.rad(familiar.FrameCount) * 8)
	--local dist = off:Length() + (val ^ 2 + 0.5) * 20
	--familiar.OrbitDistance = off:Resized(dist)
  --  familiar.OrbitSpeed = -familiar.OrbitSpeed
	--familiar.Velocity = familiar:GetOrbitPosition(familiar.Player.Position - familiar.Player.Velocity) - familiar.Position

	local p = familiar.Player
	local d = familiar:GetData()
	local s = familiar:GetSprite()
	local dir = p:GetFireDirection()
	local animdir = dirToStr[dir]
	d.animpre = d.animpre or "Float"
	d.cooldown = d.cooldown or 0
	local cnt = p:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.EASTER_EGG)
	local damage = cnt
	local newcooldown = 30 - (damage // 4)
	if p:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
		newcooldown = newcooldown // 2
	end
	if cnt >= 5 then
		damage = damage + 5
	else
		damage = ((damage - 1) / 5) + 1
	end
	if newcooldown < 1 then newcooldown = 1 end

	if not (p:GetFireDirection() == Direction.NO_DIRECTION) and d.cooldown - familiar.FrameCount <= 0 then
		d.animpre = "FloatShoot"
		d.cooldown = familiar.FrameCount + newcooldown
		s.FlipX = dir == Direction.LEFT
		wakaba:ShootEasterEggTear(familiar.Position, dirToVec[dir]:Resized(11), familiar, damage + 2.5)
	end

	if d.animpre == "Float" then
		local shootInput = p:GetFireDirection()
		if shootInput == Direction.NO_DIRECTION then
			animdir = "Down"
		end
		s.FlipX = dir == Direction.LEFT
	end

	s:SetFrame(d.animpre..animdir, familiar.FrameCount % 15)

	if d.animpre == "FloatShoot" and d.cooldown - familiar.FrameCount <= 50 then
		d.animpre = "Float"
	end
	if p:GetPlayerType() == PlayerType.PLAYER_LILITH and p:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		familiar:RemoveFromFollowers()
		familiar:GetData().BlacklistFromLilithBR = true -- to prevent conflict with using im_tem's code
		
		local dirVec = wakaba.DIRECTION_VECTOR[p:GetHeadDirection()]
		if p:AreControlsEnabled() and
		(		 Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, p.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, p.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, p.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, p.ControllerIndex)
			or Input.IsMouseBtnPressed(0)
		) then
			dirVec = p:GetAimDirection()
		end
		local ppos = p.Position
		local oldpos = familiar.Position
		local newpos = ppos + dirVec:Resized(40)
		familiar.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length() * 0.4)

	else
		familiar:FollowParent()
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_EasterEgg, wakaba.Enums.Familiars.EASTER_EGG)

function wakaba:FamiliarRender_EasterEgg(familiar)
	
	local sprite = familiar:GetSprite()
	local tcolor = Color(1, 1, 1, 1, 0, 0, 0)
	tcolor:SetColorize(wakaba.RGB.R/255,wakaba.RGB.G/255,wakaba.RGB.B/255, 0.42)
	local ntcolor = Color.Lerp(tcolor, tcolor, 0.5)
	ntcolor.A = 0.2

	sprite.Color = ntcolor
end
wakaba:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, wakaba.FamiliarRender_EasterEgg, wakaba.Enums.Familiars.EASTER_EGG)