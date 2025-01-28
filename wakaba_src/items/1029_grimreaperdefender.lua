local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:ItemUse_GrimreaperDefender(item, rng, player, useFlags, activeSlot, varData)
	local isGolden = wakaba:IsGoldenItem(item)

	wakaba:GetPlayerEntityData(player)
	player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER)
	player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_OWNED | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
	SFXManager():Play(SoundEffect.SOUND_DEATH_CARD)
	SFXManager():Play(SoundEffect.SOUND_STATIC)
	local skull = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DEATH_SKULL, 0, Vector(player.Position.X, player.Position.Y - 50), Vector.Zero, player)
	skull:GetData().wakaba = {}

	if isGolden then
		player:UseCard(Card.CARD_DEATH, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) and not wakaba:HasWisp(player, wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER) then
		player:AddWisp(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER, player.Position, true, false)
	end

	if not (useFlags & UseFlag.USE_NOANIM == UseFlag.USE_NOANIM) then
		player:AnimateCollectible(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER, "UseItem", "PlayerPickup")
	end
end
wakaba:AddCallback(ModCallbacks.MC_USE_ITEM, wakaba.ItemUse_GrimreaperDefender, wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)

function wakaba:AfterRevival_GrimreaperDefender(player)
	local wisp = wakaba:HasWisp(player, wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)
	if wisp then
		wisp:Kill()
	end
end

function wakaba:AlterPlayerDamage_GrimreaperDefender(player, amount, flags, source, countdown)
	if player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER) then
		if wakaba:WillDamageBeFatal(player, amount, flags, false, false, false) then
			player:GetEffects():RemoveCollectibleEffect(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)
		end
		return amount, flags | DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_NO_MODIFIERS | DamageFlag.DAMAGE_NO_PENALTIES
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, wakaba.AlterPlayerDamage_GrimreaperDefender)


-- Register HUD Helper for Tainted Rira
HudHelper.RegisterHUDElement({
	Name = "wakaba_GrimReaper",
	Priority = HudHelper.Priority.LOWEST,
	---@param player EntityPlayer
	---@param playerHUDIndex integer
	---@param hudLayout HUDLayout
	---@param position Vector
	Condition = function(player, playerHUDIndex, hudLayout, position)
		if isc:hasCurse(LevelCurse.CURSE_OF_THE_UNKNOWN) then return false end
		return player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER)
	end,
	---@param player EntityPlayer
	---@param playerHUDIndex integer
	---@param hudLayout HUDLayout
	---@param position Vector
	OnRender = function(player, playerHUDIndex, hudLayout, position, maxColumns)
		local spr = wakaba.WakabaHealthSprite
		spr:SetFrame("GrimReaper", 0)
		spr:Render(position)
	end,
	--PreRenderCallback = true
}, HudHelper.HUDType.HEALTH)