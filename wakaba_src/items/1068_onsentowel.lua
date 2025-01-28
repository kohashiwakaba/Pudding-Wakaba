local isc = _wakaba.isc

local function canActivateOnsenTowel(player)
	return player:HasCollectible(wakaba.Enums.Collectibles.ONSEN_TOWEL)	or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.ONSEN_TOWEL)
end

local function getOnsenTowelMultiplier(player)
	return player:GetCollectibleNum(wakaba.Enums.Collectibles.ONSEN_TOWEL)	or player:GetEffects():GetCollectibleEffecNum(wakaba.Enums.Collectibles.ONSEN_TOWEL)
end



function wakaba:Update_OnsenTowel()
	local frameCount = wakaba.G:GetFrameCount()
	if frameCount % (30 * 60) == 0 then
		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if canActivateOnsenTowel(player) then
				local activated = false
				local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.ONSEN_TOWEL)
				for i = 1, getOnsenTowelMultiplier(player) do
					local random = rng:RandomFloat() * 100
					if random <= (wakaba:IsLunatic() and 10 or 45) then
						player:AddSoulHearts(1)
						activated = true
					end
				end
				if activated then
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
					local notif = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 4, Vector(player.Position.X, player.Position.Y - 65), Vector.Zero, nil):ToEffect()
				end
			end
		end
	end

end
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_OnsenTowel)