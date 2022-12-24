
-- STEP by STEP example for creating a new role.

-- This file will show you how to create a role for Tainted Stranger, from your own mod
-- (you need to be familiar with mod creation to understand how to use it, this file cannot be used as is). 

-- First, you need to create an MC_POST_GAME_STARTED callback to a function, for example :


-- Or use your own function.
-- Then, in the called function, add the function that will create the role: 


--[[ THSTR.AddCustomRole() arguments :

	- argument 1 : name of the role (ex: "Steve")
	- argument 2 : the hearts, must be a string, each number indicating the number of hearts of a certain type :
				red_hearts, soul hearts, black hearts, bone hearts, broken hearts
				ex : "00300" -> 3 black hearts
				ex : "11111" -> one of each kind
				ex : "60000" -> 6 red hearts
	- argument 3 : the speed of the character (defaut : 1.0)
	- argument 4 : the tear delay, frames between shots (defaut : 10)
	- argument 5 : the damage per tear (defaut 3.5)
	- argument 6 : the speed of the tears (defaut : 1.0)
	- argument 7 : the luck (defaut : 0)
	- argument 8 : the price in Boss Token to play with the role (or 0 if you want to play it for free)
	- argument 9 (optional) : if set to 1, the role can't earn Boss Token (for really easy roles)
--]]

-- You can now play with your role, after selecting Tainted Stranger in the game !
-- But wait ! the character doesn't have any item ! Let's try to fix it !

-- You can add pickups and items with the next function : THSTR.AddCustomPickupItems()

--[[ THSTR.AddCustomPickupItems() arguments :
	- argument 1 : number of coins
	- argument 2 : number of bombs
	- argument 3 : number of keys
	- argument 4 : first item to give to the role
	- argument 5 : second item
	- argument 6 : third item

	In the example above, 147 is the ID of the Notched Axe.
	Put 0 if you don't want to give so many items.

	You can add your own modded item, just add the ID of your item as argument.
	If you're adding an active item and want it to be displayed in the pocket (lower right), add 2000 to the number.
	(ex: the Bible with an ID of 33 will be 2033)

	To give a trinket, add 3000 to the number (ex : Pinky  Eye have an ID of 30, to give it you must put 3030)
	If you want the trinket to become a passive item, add 4000 instead (4030 for the Pinky eye to be absorbed)
--]]

-- Finally, the costumes can be added with this function :

--[[ THSTR.AddCustomCostume({1,2,3})
	There is only one argument but it consists of several numbers
	between {}, separated by commas.
	You can add as many costumes as you want, the numbers being the IDs of the corresponding items.
	To add a Null Costume, you must add 2000 to this number.
	WARNING !
	If your custom costume must be added with AddNullCostume, add 2000 to the ID of the costume,
	but if it is linked to the item, just add the ID of the item !

	THSTR.AddCustomCostume({1}) -- add the Sad Onion costume
	THSTR.AddCustomCostume({2005}) -- add the Guppy costume (Guppy ID is 5, it's a null costume)
	THSTR.AddCustomCostume({2000 + myCostume}) -- the variable containing your modded costume (Null costumes only)
]]

--[[ function wakaba:GameStart_NotWakaba(fromsave)
	if TheStrangerRole ~= nil then -- Test if "The Stranger" mod is active

		THSTR.AddCustomRole("Not Wakaba", "11116", 1.0, 10, 4.0, 0.9, 2, 16)
		THSTR.AddCustomPickupItems(5, 0, 0, CollectibleType.COLLECTIBLE_DEEP_POCKETS, wakaba.Enums.Collectibles.SECRET_CARD, TrinketType.TRINKET_SILVER_DOLLAR + 4000)
		THSTR.AddCustomCostume({wakaba.COSTUME_NOT_WAKABA+2000})

		if wakaba.state.unlock.wakabauniform > 0 then
			THSTR.AddCustomRole("Gacha Time!", "00010", 1.0, 8, 4.2, 1.0, 0, 10, 1)
			THSTR.AddCustomPickupItems(0, 0, 0, wakaba.Enums.Collectibles.UNIFORM, CollectibleType.COLLECTIBLE_RUNE_BAG, CollectibleType.COLLECTIBLE_BOOSTER_PACK)
			THSTR.AddCustomCostume({CollectibleType.COLLECTIBLE_LUNA})
		end

		if wakaba.state.unlock.deliverysystem then
			THSTR.AddCustomRole("Slime Summoner", "21000", 1.0, 7, 3.5, 1.0, 0, 12)
			THSTR.AddCustomPickupItems(3, 0, 0, wakaba.Enums.Collectibles.ISEKAI_DEFINITION + 2000)
			THSTR.AddCustomCostume({CollectibleType.COLLECTIBLE_SAD_ONION, CollectibleType.COLLECTIBLE_SPIRIT_SHACKLES})
		end

	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.GameStart_NotWakaba) ]]


-- That's all ! You can now create as many role as you want ! Have fun !