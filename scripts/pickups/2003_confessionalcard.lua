wakaba.CARD_CONFESSIONAL_CARD = Isaac.GetCardIdByName("wakaba_Confessional Card")
local animation = "gfx/confessionalcarddrop.anm2"
local ConfessionalCardChance = wakaba.state.silverchance

local usedCardInThisRoom = false
local player


function wakaba:onUseCard2003(_, player, flags)
	local newMachinePos = Game():GetRoom():FindFreePickupSpawnPosition(player.Position, 45, true)
	local machineVariant = 17
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, newMachinePos, Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_SLOT, machineVariant, 0, newMachinePos, Vector(0,0), nil)
	SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.onUseCard2003, wakaba.CARD_CONFESSIONAL_CARD)

function wakaba:onGetCard2003(rng, currentCard, playing, runes, onlyRunes)
	local randomInt = rng:RandomInt(ConfessionalCardChance)
	if not onlyRunes and currentCard == wakaba.CARD_CONFESSIONAL_CARD then
		if wakaba.state.unlock.confessionalcard < 1 then
			return Game():GetItemPool():GetCard(rng:Next(), playing, runes, onlyRunes)
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_GET_CARD, wakaba.onGetCard2003)
