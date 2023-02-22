local isc = require("wakaba_src.libs.isaacscript-common")

local function canActivateSuccubusBlanket(player)
	return player:HasCollectible(wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)	or player:GetEffects():HasCollectibleEffect(wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)
end

local function getSuccubusBlanketMultiplier(player)
	return player:GetCollectibleNum(wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)	or player:GetEffects():GetCollectibleEffecNum(wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)
end



function wakaba:Update_SuccubusBlanket()
	local frameCount = wakaba.G:GetFrameCount()
	if frameCount % (30 * 60) == 0 then
		for i = 1, wakaba.G:GetNumPlayers() do
			local player = Isaac.GetPlayer(i - 1)
			if canActivateSuccubusBlanket(player) then
				local activated = false
				local rng = player:GetCollectibleRNG(wakaba.Enums.Collectibles.SUCCUBUS_BLANKET)
				for i = 1, getSuccubusBlanketMultiplier(player) do
					local random = rng:RandomFloat() * 100
					if random <= 45 then
						player:AddBlackHearts(1)
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
wakaba:AddCallback(ModCallbacks.MC_POST_UPDATE, wakaba.Update_SuccubusBlanket)