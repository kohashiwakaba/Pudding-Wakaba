wakaba.TearFlag = {
	EXECUTE = 1 << 0, -- Tear applies the Execute status effect (used for Executioner)
	AQUA = 1 << 1, -- Tear applies Aqua status effect (used for Rira)
	ZIPPED = 1 << 2, -- Tear applies Zipped status effect (used for Black Bean Mochi)
	NERF = 1 << 3, -- Tear applies Weakness status effect (used for Nerf Gun)
	STATIC = 1 << 4, -- Tear emits Dogma lasers (used for Richer's Necklace)
	FLOOD = 1 << 5, -- Tear applies Flood status effect (used for ???)
}


wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, function(_, explosion)
	if explosion.SpawnerEntity and explosion.SpawnerType == EntityType.ENTITY_EFFECT and explosion.SpawnerVariant == EffectVariant.ROCKET then
		local rocket = explosion.SpawnerEntity
		print(rocket:GetData().wakaba_ExplosionColor)
		explosion:GetData().wakaba_ExplosionColor = rocket:GetData().wakaba_ExplosionColor
	end
end, EffectVariant.BOMB_EXPLOSION)

wakaba:AddCallback(ModCallbacks.MC_POST_EFFECT_RENDER, function(_, explosion)
	if explosion.FrameCount <= 0 then
		explosion.Color = explosion:GetData().wakaba_ExplosionColor or explosion.Color
	end
end, EffectVariant.BOMB_EXPLOSION)