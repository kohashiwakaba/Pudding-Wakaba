--[[
	Rira(리라)
	얌전해 보이지만 야한 여자아이
	확률적으로 침수 공격을 하며, 토끼를 데리고 다님
	로스트 상태에서 빨간하트 우선 차감 아이템 사용이나 헌혈 시에도 사망하지 않음(체력이 없으면 그대로 사망)
	생득권 : 항상 침수 공격이 나가며 ???
 ]]

local playerType = wakaba.Enums.Players.RIRA
local isRiraContinue = true

function wakaba:PostRiraUpdate(player)
	if player:GetPlayerType() == wakaba.Enums.Players.RIRA then
		wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_EVIL_CHARM, 1, "WAKABA_I_RIRA")
		wakaba.HiddenItemManager:CheckStack(player, CollectibleType.COLLECTIBLE_SOCKS, 1, "WAKABA_I_RIRA")
		wakaba:GetPlayerEntityData(player)
		local data = player:GetData()
	else
		if wakaba.HiddenItemManager:Has(player, CollectibleType.COLLECTIBLE_EVIL_CHARM, "WAKABA_I_RIRA") then
			wakaba.HiddenItemManager:RemoveStack(player, CollectibleType.COLLECTIBLE_EVIL_CHARM, "WAKABA_I_RIRA")
		end
		if wakaba.HiddenItemManager:Has(player, CollectibleType.COLLECTIBLE_SOCKS, "WAKABA_I_RIRA") then
			wakaba.HiddenItemManager:RemoveStack(player, CollectibleType.COLLECTIBLE_SOCKS, "WAKABA_I_RIRA")
		end
	end
end
--wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.PostRiraUpdate)

function wakaba:AlterPlayerDamage_Rira(player, amount, flags, source, countdown)
	if flags & (DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_FAKE) > 0 then return end
	--print(flags)
	--print((flags & DamageFlag.DAMAGE_RED_HEARTS > 0), (flags & DamageFlag.DAMAGE_INVINCIBLE > 0), (flags & DamageFlag.DAMAGE_NO_PENALTIES > 0), (flags & DamageFlag.DAMAGE_NOKILL > 0), (flags & DamageFlag.DAMAGE_FAKE > 0))
	if (player:GetPlayerType() == wakaba.Enums.Players.RIRA or player:GetPlayerType() == wakaba.Enums.Players.RIRA_B or player:HasTrinket(wakaba.Enums.Trinkets.RABBIT_PILLOW))
	and player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE)
	and not wakaba:WillDamageBeFatal(player, amount, flags, true, false, true) then
		if flags & (DamageFlag.DAMAGE_CURSED_DOOR | DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_IV_BAG | DamageFlag.DAMAGE_CHEST) > 0
		or wakaba:IsDamageSacrificeSpikes(flags, source)
		or wakaba:IsDamageSanguineSpikes(player, flags, source) then
			return amount, flags | DamageFlag.DAMAGE_NOKILL
		end
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, wakaba.AlterPlayerDamage_Rira)

local RiraChar = {
		DAMAGE = 0.16,
		SPEED = 0.0,
		SHOTSPEED = 1.05,
		TEARRANGE = 20,
		TEARS = 0,
		LUCK = 0,
		FLYING = false,
		TEARFLAG = TearFlags.TEAR_NORMAL,
		TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0)	-- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}

function wakaba:onRiraCache(player, cacheFlag)
	if player:GetPlayerType() == playerType then
		if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * RiraChar.DAMAGE
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				player.Damage = player.Damage * 1.3
			end
		end
		if cacheFlag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed * RiraChar.SHOTSPEED
		end
		if cacheFlag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + RiraChar.TEARRANGE
		end
		if cacheFlag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = (player.MoveSpeed * 0.5) + 0.5 + RiraChar.SPEED
		end
		if cacheFlag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + RiraChar.LUCK
		end
		if cacheFlag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING and RiraChar.FLYING then
			player.CanFly = true
		end
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = wakaba:TearsUp(player.MaxFireDelay, (RiraChar.TEARS * wakaba:getEstimatedTearsMult(player)))
			player.MaxFireDelay = wakaba:MultiplyTears(player.MaxFireDelay, 3.04)
		end
		if cacheFlag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | RiraChar.TEARFLAG
		end
		if cacheFlag & CacheFlag.CACHE_TEARCOLOR == CacheFlag.CACHE_TEARCOLOR then
			--player.TearColor = RiraChar.TEARCOLOR
		end
	end

end

wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 41010720, wakaba.onRiraCache)

function wakaba:Cache_RiraPositiveTears(player, cacheFlag)
	if player:GetPlayerType() == playerType then
		local effects = player:GetEffects()
		if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			local mult = 1
			if player:HasWeaponType(WeaponType.WEAPON_BOMBS) then
				if player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
					mult = mult * 4.3
				else
					mult = mult / 0.4
				end
			elseif player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) then
				mult = mult * 3
			elseif player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
				mult = mult * 4.3
			end

			if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) then
				mult = (mult / 2) * 3
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_EVES_MASCARA) then
				mult = (mult / 2) * 3
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
				mult = mult * 3
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_20_20) then
				mult = mult
			elseif player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE) or effects:HasCollectibleEffect(NullItemID.ID_REVERSE_HANGED_MAN) then
				mult = mult / 0.51
			elseif player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS) or player:HasCollectible(CollectibleType.COLLECTIBLE_MUTANT_SPIDER) then
				mult = mult / 0.42
			end
			player.MaxFireDelay = wakaba:MultiplyTears(player.MaxFireDelay, mult)
		end
	end
end
wakaba:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, -41010720, wakaba.Cache_RiraPositiveTears)

function wakaba:AfterRiraInit(player)
	player = player or Isaac.GetPlayer()
	if player:GetPlayerType() == playerType then
		player:SetPocketActiveItem(wakaba.Enums.Collectibles.NERF_GUN, ActiveSlot.SLOT_POCKET, true)
	end
end

function wakaba:PostRiraInit(player)
	if not isRiraContinue then
		wakaba:AfterRiraInit(player)
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, wakaba.PostRiraInit)

function wakaba:RiraInit(continue)
	if (not continue) then
		isRiraContinue = false
		wakaba:AfterRiraInit()
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.RiraInit)

function wakaba:RiraExit()
	isRiraContinue = true
end
wakaba:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, wakaba.RiraExit)
