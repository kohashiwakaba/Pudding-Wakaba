if UniqueItemsAPI then
	UniqueItemsAPI.RegisterMod("Pudding and Wakaba")
	local path = "gfx/items/collectibles/birthright/"

	for _, playerName in ipairs(wakaba.Enums.UniqueItemsAppend) do
		UniqueItemsAPI.RegisterCharacter(playerName, false)
		UniqueItemsAPI.AddCharacterItem({
			PlayerType = Isaac.GetPlayerTypeByName(playerName, false),
			ItemID = CollectibleType.COLLECTIBLE_BIRTHRIGHT,
			ItemSprite = path .. string.lower(playerName) .. "_birthright.png"
		})
	end
	for _, playerName in ipairs(wakaba.Enums.UniqueItemsAppendTainted) do
		UniqueItemsAPI.RegisterCharacter(playerName.."B", true)
		UniqueItemsAPI.AddCharacterItem({
			PlayerType = Isaac.GetPlayerTypeByName(playerName.."B", true),
			ItemID = CollectibleType.COLLECTIBLE_BIRTHRIGHT,
			ItemSprite = path .. string.lower(playerName) .. "_b_birthright.png"
		})
	end
end