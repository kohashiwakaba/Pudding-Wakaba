

if REPENTOGON then
	---@param dirVec Vector
	---@param fireAmount integer
	---@param owner Entity
	---@param weapon Weapon
	function wakaba:TriggerWeaponFire_RevengeFruit(dirVec, fireAmount, owner, weapon)
		local player = owner:ToPlayer()
		if not player then return end
		if player:HasCollectible(wakaba.Enums.Collectibles.REVENGE_FRUIT) then
			wakaba:RevengeRing(player)
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_TRIGGER_WEAPON_FIRED, wakaba.TriggerWeaponFire_RevengeFruit)
else
	function wakaba:WeaponFire_RevengeFruit(player)
		if player:HasCollectible(wakaba.Enums.Collectibles.REVENGE_FRUIT) then
			wakaba:RevengeRing(player)
		end
	end
	wakaba:AddCallback(wakaba.Callback.ANY_WEAPON_FIRE, wakaba.WeaponFire_RevengeFruit)
end

function wakaba:TryRevengeFruit(player)
	local luck = player.Luck
	local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.REVENGE_FRUIT)
	local count = player:GetCollectibleNum(wakaba.Enums.Collectibles.REVENGE_FRUIT)
	local charmBonus = 0 --wakaba:getTeardropCharmBonus(player)

	local basicChance = 0.05
	local parLuck = 39
	local maxChance = 0.2 - basicChance

	local chance = wakaba:StackChance(basicChance + wakaba:LuckBonus(player.Luck + charmBonus, parLuck, maxChance), count)
	return count > 0 and rng:RandomFloat() < chance
end

---@param player EntityPlayer
function wakaba:RevengeRing(player)
	if wakaba:TryRevengeFruit(player) then
		player:SpawnMawOfVoid(20 + (player:GetCollectibleNum(wakaba.Enums.Collectibles.REVENGE_FRUIT) * 10))
	end
end