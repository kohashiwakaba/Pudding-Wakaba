--[[
	Lil Rira (리틀 리라) - 패밀리어(Familiar) - 유니크
	리라로 Ultra Greedier 처치
	지형 관통, 특수 유도 눈물 발사
	액티브 아이템 충전량을 흡수하여 공격력 (or 랜덤 스탯) 증가
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")
local c = wakaba.Enums.Constants
local sfx = SFXManager()

local rira_saved_recipies = {
	run = {

	},
}
wakaba:saveDataManager("PnW_LilRira", rira_saved_recipies)

local riraCharges = rira_saved_recipies.run

---@param player EntityPlayer
---@param count? integer
---@param ignoreMax? boolean
---@return integer
function wakaba:addRiraDamage(player, count, ignoreMax)
	count = count or 1

	local playerIndex = isc:getPlayerIndex(player)
	rira_saved_recipies.run[playerIndex] = riraCharges[playerIndex] or 0

	rira_saved_recipies.run[playerIndex] = math.max(riraCharges[playerIndex] + count, 0)

	return riraCharges[playerIndex]
end

---@param activeItem any
---@param rng any
---@param player any
---@param flags any
---@param slot any
---@param vardata any
function wakaba:UseItem_LilRira(activeItem, rng, player, flags, slot, vardata)
	if flags & UseFlag.USE_OWNED == 0 then return end
	wakaba:setPlayerDataEntry(player, "LilRiraLastItem", activeItem)
	wakaba:setPlayerDataEntry(player, "LilRiraLastSlot", slot)
end
wakaba:AddPriorityCallback(ModCallbacks.MC_USE_ITEM, CallbackPriority.LATE, wakaba.UseItem_LilRira)

---@param familiar EntityFamiliar
---@param player EntityPlayer
---@param activeItem CollectibleType
function wakaba:tryAddLilRiraDamageByItem(familiar, player, activeItem, charges)
	if not activeItem then return end
	if activeItem ~= 0 then
		local config = Isaac.GetItemConfig():GetCollectible(activeItem)
		local maxCharges = charges or config.MaxCharges
		if maxCharges == 0 then return end
		--local charges = player:GetActiveCharge(activeSlot) + player:GetBatteryCharge(activeSlot)
		local chargeType = config.ChargeType
		if chargeType == ItemConfig.CHARGE_TIMED then
			familiar.Coins = familiar.Coins + maxCharges
		elseif (chargeType == ItemConfig.CHARGE_NORMAL and maxCharges == 1 and player:HasCollectible(CollectibleType.COLLECTIBLE_9_VOLT)) then
			familiar.Coins = familiar.Coins + (15 * 15)
		else
			familiar.Hearts = familiar.Hearts + maxCharges
		end
	end
end

---@param familiar EntityFamiliar
---@param player EntityPlayer
---@param activeSlot ActiveSlot
function wakaba:tryDetectChargeChange(familiar, player, activeSlot)
	if not activeSlot or activeSlot == -1 then return end
	local playerIndex = isc:getPlayerIndex(player)
	local activeItem = player:GetActiveItem(activeSlot)
	if activeItem ~= 0 then
		local charges = REPENTOGON and player:GetActiveMaxCharge(activeSlot)
		wakaba:tryAddLilRiraDamageByItem(familiar, player, activeItem, charges)
	end
end

local function fireTearRira(player, familiar, vector, rotation)
	local fData = familiar:GetData()
	local tear_vector = nil
	--local entity = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, Vector(familiar.Position.X, familiar.Position.Y), vector, familiar)
	local entity = familiar:FireProjectile(vector)
	tear = entity:ToTear()
	--tear:ChangeVariant(TearVariant.FETUS)
	tear.Scale = 0.9
	tear.TearFlags = TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_FETUS
	--tear.FallingSpeed = 0
	--tear.FallingAcceleration = -0.1

	local multiplier = 1
	if (player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS)) then
		multiplier = multiplier * 2
	end
	tearDamage = 4
	tear.CollisionDamage = tearDamage * multiplier

	if player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
		tear.Color = Color(0.3, 0.15, 0.37, 1, 0.2, 0.02, 0.37)
	end

	return tear
end

function wakaba:FamiliarInit_LilRira(familiar)
	familiar.IsFollower = true
	familiar:AddToFollowers()

	local sprite = familiar:GetSprite()
	sprite:Play("IdleDown")

end

---@param familiar EntityFamiliar
function wakaba:FamiliarUpdate_LilRira(familiar)
	local fData = familiar:GetData()
	local player = familiar.Player
	local move_dir = player:GetMovementDirection()
	local sprite = familiar:GetSprite()
	local player_fire_direction = player:GetFireDirection()
	local autoaim = false

	local lastSlot = wakaba:getPlayerDataEntry(player, "LilRiraLastSlot")
	if lastSlot then
		if player:NeedsCharge(lastSlot) then
			local lastItem = wakaba:getPlayerDataEntry(player, "LilRiraLastItem")
			wakaba.Log("Lil Rira charge usage detected from slot", lastSlot, ", item", lastItem, "! adding to damage...")
			wakaba:tryDetectChargeChange(familiar, player, lastSlot)
			wakaba:removePlayerDataEntry(player, "LilRiraLastItem")
			wakaba:removePlayerDataEntry(player, "LilRiraLastSlot")
		end
	end

	if familiar.Coins > 0 then
		local timedCharges = familiar.Coins
		local dmgToAdd = timedCharges / 1800
		wakaba.Log("Lil Rira adding damage from timed active :", dmgToAdd)
		wakaba:addRiraDamage(player, dmgToAdd)
		--riraCharges[playerIndex] = (riraCharges[playerIndex] or 0) + dmgToAdd

		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
		familiar.Coins = 0
	end

	if familiar.Hearts > 0 then
		local charges = familiar.Hearts
		wakaba.Log("Lil Rira adding damage from normal active :", charges)
		--riraCharges[playerIndex] = (riraCharges[playerIndex] or 0) + charges
		wakaba:addRiraDamage(player, charges)

		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
		familiar.Hearts = 0
	end

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(wakaba.DIRECTION_FLOAT_ANIM[move_dir], false)
		if familiar.FireCooldown <= 0 then
			familiar.FireCooldown = 0
		end
	else
		sprite:Play(wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
		if familiar.FireCooldown <= 0 then
			local tear_vector = wakaba.DIRECTION_VECTOR[player_fire_direction]:Normalized()
			sprite:Play(wakaba.DIRECTION_SHOOT_ANIM[player_fire_direction], false)
			if not autoaim and mark then
				tear_vector = Vector(mark.Position.X - familiar.Position.X, mark.Position.Y - familiar.Position.Y):Normalized()
			end
			if familiar.FireCooldown <= 0 then
				fireTearRira(player, familiar, tear_vector, 0)
				if player:HasTrinket(TrinketType.TRINKET_FORGOTTEN_LULLABY) then
					familiar.FireCooldown = c.LIL_RICHER_BASIC_COOLDOWN // 2
				else
					familiar.FireCooldown = c.LIL_RICHER_BASIC_COOLDOWN
				end
			end
		end
	end
	familiar.FireCooldown = familiar.FireCooldown - 1
	if player:GetPlayerType() == PlayerType.PLAYER_LILITH and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		familiar:RemoveFromFollowers()
		familiar:GetData().BlacklistFromLilithBR = true -- to prevent conflict with using im_tem's code

		local dirVec = wakaba.DIRECTION_VECTOR[player:GetHeadDirection()]
		if player:AreControlsEnabled() and
		(		 Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
			or Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
			or Input.IsMouseBtnPressed(0)
		) then
			dirVec = player:GetAimDirection()
		end
		local playerpos = player.Position
		local oldpos = familiar.Position
		local newpos = playerpos + dirVec:Resized(40)
		familiar.Velocity = (newpos - oldpos):Normalized():Resized((newpos - oldpos):Length() * 0.4)

	else
		familiar:FollowParent()
	end
end

function wakaba:Cache_LilRira(player, cacheFlag)
	if cacheFlag == CacheFlag.CACHE_DAMAGE then
		local power = player:GetCollectibleNum(wakaba.Enums.Collectibles.LIL_RIRA) + player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.LIL_RIRA)
		if power >= 0 then
			local playerIndex = isc:getPlayerIndex(player)
			riraPower = riraCharges[playerIndex] or 0

			player.Damage = player.Damage + (0.05 * riraPower * power * wakaba:getEstimatedDamageMult(player))
		end
	elseif cacheFlag == CacheFlag.CACHE_FAMILIARS then
		local count = 0
		local hasitem = player:HasCollectible(wakaba.Enums.Collectibles.LIL_RIRA)
		local efcount = player:GetEffects():GetCollectibleEffectNum(wakaba.Enums.Collectibles.LIL_RIRA)
		if hasitem or efcount > 0 then
			count = 1
		end
		player:CheckFamiliar(wakaba.Enums.Familiars.LIL_RIRA, count, player:GetCollectibleRNG(wakaba.Enums.Collectibles.LIL_RIRA))
	end
end

wakaba:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, wakaba.Cache_LilRira)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, wakaba.FamiliarInit_LilRira, wakaba.Enums.Familiars.LIL_RIRA)
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, wakaba.FamiliarUpdate_LilRira, wakaba.Enums.Familiars.LIL_RIRA)