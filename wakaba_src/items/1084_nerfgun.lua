--[[ 
	Nerf Gun (너프 건) - 액티브(Active)
	공격방향으로 너프 샷을 여러 번 발사
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")
local collectible = wakaba.Enums.Collectibles.NERF_GUN

---comment
---@param player EntityPlayer
---@param direction Vector
local function FireNerfShot(player, direction, dirOffset, launchSpeed)
	if direction:Length() < 1e-3 then
		direction = Vector(1.0, 0.0)
	end
	dirOffset = dirOffset or Vector.Zero
	launchSpeed = launchSpeed or 17.6
	local normalizedinput = direction:Normalized()
	local velocity = normalizedinput * launchSpeed + player:GetTearMovementInheritance(normalizedinput * launchSpeed) + dirOffset

	local tear = player:FireTear(player.Position + Vector(0, -6), velocity, false, true, false)
	tear:ChangeVariant(TearVariant.CUPID_BLUE)
	tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PIERCING
	tear.Scale = tear.Scale - 0.2
	wakaba:AddRicherTearFlags(tear, wakaba.TearFlag.NERF)

	local trail = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SPRITE_TRAIL, 0, player.Position, Vector.Zero, nil):ToEffect()
	trail:FollowParent(tear) -- parents the trail to another entity and makes it follow it around
	trail.MinRadius = 0.08 -- fade rate, lower values yield a longer trail
	trail:GetSprite().Color = Color(0.14, 0.1, 0.7, 1, 0, 0, 0.3) -- sets the color of the trail
	--trail:SetTimeout(20)
	trail:Update()
	trail:GetData().w_trail = true
	trail:GetData().w_parent = tear
end

---@param parent EntityTear
local function getPositionOffset(parent, scale)
	local angle = parent.Velocity:Normalized() * 2
	local height = parent.FallingAcceleration * parent.FallingSpeed
	local offset = parent.PositionOffset + angle * scale + Vector(0, height / 2)
	return offset
end

-- Trail offset from Bullet Trails mod
---@param trail EntityEffect
function wakaba:TrailUpdate_NerfGun(trail)
	if trail:GetData().w_parent then
		local parent = trail:GetData().w_parent
		if parent:Exists() then
			trail.ParentOffset = getPositionOffset(parent, trail.SpriteScale.Y)
		else
			trail:Remove()
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, wakaba.TrailUpdate_NerfGun, EffectVariant.SPRITE_TRAIL)

local function addNerfPendingCount(player)
	player:GetData().wakaba.pendingNerfGunCount = (player:GetData().wakaba.pendingNerfGunCount or 0) + 5
end

local function TryCancelNerfGun(player)
	if player:GetData().wakaba.usingNerfGun then
		player:GetData().wakaba.usingNerfGun = false
		player:GetData().wakaba.pendingNerfGunCount = 0
		player:AnimateCollectible(collectible, "HideItem", "PlayerPickup")
	end
end

wakaba:AddCallback(wakaba.Callback.APPLY_TEARFLAG_EFFECT, function(_, effectTarget, player, effectSource)
	if wakaba:CanApplyStatusEffect(effectTarget) then
		effectTarget:AddEntityFlags(EntityFlag.FLAG_WEAKNESS)
		wakaba:scheduleForUpdate(function()
			effectTarget:ClearEntityFlags(EntityFlag.FLAG_WEAKNESS)
		end, 150)
	end
end, wakaba.TearFlag.NERF)

function wakaba:UseItem_NerfGun(_, rng, player, useFlags, activeSlot, varData)
	if useFlags & UseFlag.USE_CARBATTERY == 0 then
		if not player:GetData().wakaba.usingNerfGun then
			player:GetData().wakaba.usingNerfGun = true -- VERY IMPORTANT! Make the name of your GetData something more specific than "wakaba.usingNerfGun" so that other mods don't overwrite it!!
			player:GetData().throwableActiveSlot = activeSlot -- store what slot the active item was used from (primary, secondary, or pocket?)
			addNerfPendingCount(player)
			player:AnimateCollectible(collectible, "LiftItem", "PlayerPickup")
		else
			TryCancelNerfGun(player)
		end
	else
		addNerfPendingCount(player)
	end
	if wakaba:IsGoldenItem(collectible) then
		addNerfPendingCount(player)
	end
	return {Discharge = false, Remove = false, ShowAnim = false} -- stops the item from discharging unless something actually shoots out
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.UseItem_NerfGun, wakaba.Enums.Collectibles.NERF_GUN)

function wakaba:PlayerUpdate_NerfGun(player) -- Trigger throwable active upon shooting
	if player:GetData().wakaba.usingNerfGun and player:GetAimDirection():Length() > 1e-3 then
		player:GetData().wakaba.usingNerfGun = false
		local direction = player:GetAimDirection()
		-- PLACE THE ACTUAL EFFECT OF YOUR THROWABLE ACTIVE HERE --
		local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.NERF_GUN)
		for i = 1, player:GetData().wakaba.pendingNerfGunCount do
			local x = (rng:RandomFloat() * 4) - 2
			local y = (rng:RandomFloat() * 4) - 2
			local speed = (rng:RandomFloat() * 4) + 15
			local randomOffset = Vector(x,y)
			FireNerfShot(player, direction, (i == 1 and Vector.Zero or randomOffset), speed)
		end

		local slot = player:GetData().throwableActiveSlot
		if slot == ActiveSlot.SLOT_PRIMARY then -- Prevent possible cheese with Schoolbag
			if player:GetActiveItem(slot) ~= collectible then
				slot = ActiveSlot.SLOT_SECONDARY
			else
				if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) < Isaac.GetItemConfig():GetCollectible(collectible).MaxCharges then
					slot = ActiveSlot.SLOT_SECONDARY
				end
			end
		end
		player:DischargeActiveItem(slot) -- Since the item was used successfully, actually discharge the item
		player:AnimateCollectible(collectible, "HideItem", "PlayerPickup")
		player:GetData().wakaba.pendingNerfGunCount = 0
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PlayerUpdate_NerfGun)

function wakaba:PostTakeDamage_NerfGun(player, _, _, _, _) -- Terminate the holding up of your throwable active upon taking damage. This function can be omitted if you want, but I added it to be closer to vanilla behavior.
	TryCancelNerfGun(player)
end
wakaba:AddCallback(wakaba.Callback.POST_TAKE_DAMAGE, wakaba.PostTakeDamage_NerfGun)

function wakaba:NewRoom_NerfGun() -- Terminate the holding up of your throwable active upon entering a new room. This function can also be omitted if you want.
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		TryCancelNerfGun(player)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_NerfGun)