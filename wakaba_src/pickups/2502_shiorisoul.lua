local DreamCardChance = wakaba.state.silverchance
local rng = wakaba.RNG


local candidates = {}

local function randomchoice(t, rng) --Selects a random item from a table
	local keys = {}
	for key, value in pairs(t) do
			keys[#keys+1] = key --Store keys in another table
	end
	index = keys[rng:RandomInt(#keys) + 1]
	return t[index]
end

function wakaba:UseCard_SoulOfShiori(_, player, flags)
	local rng = player:GetCardRNG(wakaba.Enums.Cards.SOUL_SHIORI)
	local candidates = wakaba.bookofshiori
	local selected = -1
	local keys = {}
	for key, value in pairs(candidates) do
			keys[#keys+1] = key --Store keys in another table
	end
	while not (selected > 0 and not (wakaba.shioribookblacklisted[selected] and wakaba.shioribookblacklisted[selected][wakaba.bookstate.BOOKSHELF_SOUL_OF_SHIORI])) do
		--print(selected)
		selected = keys[rng:RandomInt(#keys) + 1]
	end
	wakaba:GetPlayerEntityData(player)
	player:GetData().wakaba.nextshioriflag = selected
	player:AddCacheFlags(CacheFlag.CACHE_ALL)
	player:EvaluateItems()

	player:AddHearts(4)
	SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)


end
wakaba:AddCallback(ModCallbacks.MC_USE_CARD, wakaba.UseCard_SoulOfShiori, wakaba.Enums.Cards.SOUL_SHIORI)

function wakaba:RuneTest(count)
	count = count or 200
	local itemp = wakaba.G:GetItemPool()
	for i = 1, count do
		local card = itemp:GetCard(wakaba.G:GetSeeds():GetNextSeed(), false, true, true)
		if card == wakaba.Enums.Cards.SOUL_SHIORI then print("Shiori detected")
		elseif card == wakaba.Enums.Cards.SOUL_WAKABA then print("Wakaba detected")
		else --print(card)
		end
	end
end