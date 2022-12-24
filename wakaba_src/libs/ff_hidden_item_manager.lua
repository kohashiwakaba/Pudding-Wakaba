local mod = wakaba
local game = Game()
local sfx = SFXManager()
local isc = require("wakaba_src.libs.isaacscript-common")

local wispCache = {}
local itemIcons = {}

local wisp_data = {
	run = {

	},
	floor = {

	},
	room = {

	}
}
wakaba:saveDataManager("Hidden Item Datas", wisp_data)
--wakaba.wispdata = wisp_data


-- Savedata for which hiddens are currently active.
local function GetHiddenData(player)
	local data = player:GetData().wakaba
	if not data.HiddenData then
		data.HiddenData = {}
	end
	return data.HiddenData
end

-- Savedata which stores the InitSeeds of item wisps spawned from hiddens are expected to still exist.
-- Helps take advantage of the fact that item wisps maintain their InitSeed after quit+continue.
local function GetHiddenWispRefs()
	local data = wisp_data.run
	if not data.HiddenWisps then
		data.HiddenWisps = {}
	end
	return data.HiddenWisps
end

local function InitializeHiddenItemWisp(wisp)
	wisp:AddEntityFlags(EntityFlag.FLAG_NO_QUERY | EntityFlag.FLAG_NO_REWARD)
	wisp:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
	wisp.Visible = false
	wisp:RemoveFromOrbit()
	wisp:GetData().isWakabaHiddenWisp = true
	wispCache[wisp.InitSeed] = wisp
end

function mod:hiddenItemPlayerUpdate(player)
	local itemConfig = Isaac.GetItemConfig()
	
	local wispRefs = GetHiddenWispRefs()
	local activeHiddens = GetHiddenData(player)
	
	for key, data in pairs(activeHiddens) do
		if data.Duration and data.Duration > 0 then
			data.Duration = data.Duration - 1
		end
		if not data.Duration or data.Duration == 0 then
			local itemsRemoved = false
			
			for wispKey, itemID in pairs(data.Wisps) do
				wispRefs[wispKey] = nil
				if player:HasCollectible(itemID) then
					itemsRemoved = true
				end
			end
			
			activeHiddens[key] = nil
			
			if itemsRemoved then
				sfx:Play(SoundEffect.SOUND_THUMBS_DOWN)
				game:GetHUD():ShowItemText("Your free trial has expired")
			end
		end
	end
end


---------- Item wisp handling ----------

function mod:hiddenItemWispInit(wisp)
	if not wisp:GetData().isWakabaHiddenWisp and GetHiddenWispRefs()[""..wisp.InitSeed] then
		-- This wisp isn't marked as a hidden wisp, but there's supposed to be a hidden wisp with this InitSeed.
		-- Most likely, we've quit and continued a run. Re-initialize this as a hidden wisp and hide it.
		if wispCache[wisp.InitSeed] and wispCache[wisp.InitSeed]:Exists() and wispCache[wisp.InitSeed]:GetData().isWakabaHiddenWisp then
			-- Nevermind, found the existing wisp. (Likely Bazarus Moment.)
			wisp:Remove()
			return
		end
		InitializeHiddenItemWisp(wisp)
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.hiddenItemWispInit, FamiliarVariant.ITEM_WISP)

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(_, continuing)
	for _, wisp in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP)) do
		mod:hiddenItemWispInit(wisp:ToFamiliar())
	end
end)

function mod:hiddenItemWispUpdate(wisp)
	local data = wisp:GetData()
	
	if not data.isWakabaHiddenWisp then return end
	
	wisp.Position = Vector(-100, -50)
	wisp.Velocity = kZeroVector
	
	if not GetHiddenWispRefs()[""..wisp.InitSeed] then
		-- This hidden wisp should no longer exist.
		if wisp.Player and wisp.SubType == CollectibleType.COLLECTIBLE_MARS then
			wisp.Player:TryRemoveNullCostume(NullItemID.ID_MARS)
		end
		wisp:Remove()
		wisp:Kill()
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.hiddenItemWispUpdate, FamiliarVariant.ITEM_WISP)

-- Disables collisions for hidden wisps.
function mod:hiddenItemWispCollision(wisp)
	if wisp:GetData().isWakabaHiddenWisp then
		return true
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, mod.hiddenItemWispCollision, FamiliarVariant.ITEM_WISP)

-- Prevents hidden wisps from taking damage.
function mod:hiddenItemWispDamage(entity, damage, damageFlags, damageSourceRef, damageCountdown)
	if entity and entity.Type == EntityType.ENTITY_FAMILIAR and entity.Variant == FamiliarVariant.ITEM_WISP and entity:GetData().isWakabaHiddenWisp then
		return false
	end
	
	if damageSourceRef.Type == EntityType.ENTITY_FAMILIAR and damageSourceRef.Variant == FamiliarVariant.ITEM_WISP
			and damageSourceRef.Entity and damageSourceRef.Entity:GetData().isWakabaHiddenWisp then
		return false
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.hiddenItemWispDamage)

-- Prevents hidden wisps from firing tears with book of virtues.
function mod:hiddenItemWispTears(tear)
	if tear.SpawnerEntity and tear.SpawnerEntity.Type == EntityType.ENTITY_FAMILIAR
			and tear.SpawnerEntity.Variant == FamiliarVariant.ITEM_WISP
			and (tear.SpawnerEntity:GetData().isWakabaHiddenWisp or tear.SpawnerEntity:GetData().preventWispFiring) then
		tear:Remove()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, mod.hiddenItemWispTears)



















