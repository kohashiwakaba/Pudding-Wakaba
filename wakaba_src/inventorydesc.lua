

wakaba.INVDESC_TYPE_PLAYER = -997
wakaba.INVDESC_TYPE_CURSE = -998
wakaba.INVDESC_VARIANT = -1

wakaba._InventoryDesc = RegisterMod("Inventory Descriptions", 1)
--[[ 

	Inventory Descriptions
	List of datas and functions

	- add player note:
	INVDESC:AddPlayerNote(playertype, description, language, playericon)

	- add curse description:
	INVDESC:AddCurse(curseid, cursename, cursedescription, curseicon, language)

	- link collectible for character:
	- some collectibles does not show for some characters, like Lazarus' rags, or Incubus for Lilith
	- This function will link starting items for character if the character technically does not have item
	INVDESC:LinkCollectibleForCharacter(playerType, collectibleType)

	- add blacklist for collectible
	INVDESC:AddCollectibleBlacklist(collectibleType)

	- remove blacklist for collectible
	INVDESC:RemoveCollectibleBlacklist(collectibleType)

 ]]

wakaba._InventoryDesc.defaultItems = {
	[PlayerType.PLAYER_LAZARUS] = {CollectibleType.COLLECTIBLE_LAZARUS_RAGS},
	[PlayerType.PLAYER_LAZARUS2] = {CollectibleType.COLLECTIBLE_ANEMIC},
	--[PlayerType.PLAYER_THELOST] = {CollectibleType.COLLECTIBLE_HOLY_MANTLE},
	[PlayerType.PLAYER_LILITH] = {CollectibleType.COLLECTIBLE_INCUBUS},
	[PlayerType.PLAYER_SAMSON_B] = {CollectibleType.COLLECTIBLE_BERSERK},
	[PlayerType.PLAYER_AZAZEL_B] = {CollectibleType.COLLECTIBLE_HEMOPTYSIS},
	[PlayerType.PLAYER_LILITH_B] = {CollectibleType.COLLECTIBLE_GELLO},
}
wakaba._InventoryDesc.collectibleBlacklist = {
}

function wakaba:LinkCollectibleForCharacter(playerType, collectibleType)
	if not playerType or not collectibleType then return end
	if not wakaba._InventoryDesc.defaultItems[playerType] then
		wakaba._InventoryDesc.defaultItems[playerType] = {}
	end
	if not wakaba:has_value(wakaba._InventoryDesc.defaultItems[playerType], collectibleType) then
		table.insert(	wakaba._InventoryDesc.defaultItems[playerType], collectibleType)
	end
end

local idesc = wakaba._InventoryDesc
INVDESC = {}
idesc.BackgroundSprite = Sprite()
idesc.BackgroundSprite:Load("gfx/ui/wakaba_idesc_menu.anm2", true)
idesc.BackgroundSprite:SetFrame("Idle",0)

idesc.IconBgSprite = Sprite()
idesc.IconBgSprite:Load("gfx/ui/wakaba_idesc_menu.anm2", true)
idesc.IconBgSprite:SetFrame("ItemIcon",0)


function INVDESC:LinkCollectibleForCharacter(playerType, collectibleType)
	wakaba:LinkCollectibleForCharacter(playerType, collectibleType)
end
function INVDESC:AddCollectibleBlacklist(collectibleType)
	if not collectibleType then return end
	if not wakaba:has_value(wakaba._InventoryDesc.collectibleBlacklist, collectibleType) then
		table.insert(wakaba._InventoryDesc.collectibleBlacklist, collectibleType)
	end
end
function INVDESC:RemoveCollectibleBlacklist(collectibleType)
	if not collectibleType then return end
	for i = 1, #wakaba._InventoryDesc.collectibleBlacklist do
		if wakaba._InventoryDesc.collectibleBlacklist[i] == collectibleType then
			table.remove(wakaba._InventoryDesc.collectibleBlacklist, i)
		end
	end
end

INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.WAKABA, wakaba.Enums.Collectibles.WAKABAS_BLESSING)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.WAKABA_B, wakaba.Enums.Collectibles.WAKABAS_NEMESIS)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.SHIORI, wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.SHIORI_B, wakaba.Enums.Collectibles.BOOK_OF_SHIORI)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.SHIORI_B, wakaba.Enums.Collectibles.MINERVA_AURA)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.TSUKASA, wakaba.Enums.Collectibles.LUNAR_STONE)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.TSUKASA, wakaba.Enums.Collectibles.CONCENTRATION)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.TSUKASA_B, wakaba.Enums.Collectibles.FLASH_SHIFT)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.TSUKASA_B, wakaba.Enums.Collectibles.ELIXIR_OF_LIFE)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.TSUKASA_B, wakaba.Enums.Collectibles.MURASAME)
INVDESC:LinkCollectibleForCharacter(wakaba.Enums.Players.RICHER, wakaba.Enums.Collectibles.RABBIT_RIBBON)


local offset = (REPENTANCE and Options.HUDOffset) or 1
local inputready = true

idesc.state = {
	showList = false,
	maxCollectibleID = Isaac.GetItemConfig():GetCollectibles().Size - 1,
	maxTrinketID = Isaac.GetItemConfig():GetTrinkets().Size - 1,
	lists = {
		playernotes = {},
		items = {},
		curses = {},
		collectibles = {},
		lemegetonwisps = {},
		trinkets = {},
		cards = {},
		pills = {},
	},
	listprops = {
		screenx = EID:getScreenSize().X, 
		screeny = EID:getScreenSize().Y,
		max = 1,
		current = 1,
		offset = 0,
	},
	savedtimer = nil,
}


local function getMaxCurseId(curse)
	local maxloop = 0
	while curse > 0 do
		maxloop = maxloop + 1
		curse = curse // 2
	end
	return maxloop
end


function wakaba:TestCollectibles(min, max)
	local items = {}
	for i = min, max do
		local config = Isaac.GetItemConfig()
		if config:GetCollectible(i) then
			table.insert(items, {
				type = 5,
				variant = 100,
				subtype = i,
			})
		end
	end
	idesc.state.showList = true
	local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
	idesc.state.listprops.screenx = x
	idesc.state.listprops.screeny = y

	idesc.state.lists.items = items
	--idesc.state.lists.cards = cards
	--idesc.state.lists.pills = pills

	idesc.state.listprops.max = #items

end

function wakaba:TestTrinkets(min, max)
	local items = {}
	for i = min, max do
		local config = Isaac.GetItemConfig()
		if config:GetTrinket(i) then
			table.insert(items, {
				type = 5,
				variant = 350,
				subtype = i,
			})
		end
	end
	idesc.state.showList = true
	local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
	idesc.state.listprops.screenx = x
	idesc.state.listprops.screeny = y

	idesc.state.lists.items = items
	--idesc.state.lists.cards = cards
	--idesc.state.lists.pills = pills

	idesc.state.listprops.max = #items

end

function wakaba:TestCards(min, max)
	local items = {}
	for i = min, max do
		local config = Isaac.GetItemConfig()
		if config:GetCard(i) then
			table.insert(items, {
				type = 5,
				variant = 300,
				subtype = i,
			})
		end
	end
	idesc.state.showList = true
	local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
	idesc.state.listprops.screenx = x
	idesc.state.listprops.screeny = y

	idesc.state.lists.items = items
	--idesc.state.lists.cards = cards
	--idesc.state.lists.pills = pills

	idesc.state.listprops.max = #items

end

function idesc:SetCurrentItemLists()
	local playernotes = {}
	local items = {}
	local currCurse = wakaba.G:GetLevel():GetCurses()
	local curses = {}
	local collectibles = {}
	local lemegetonwisps = {}
	local trinkets = {}
	local cards = {}
	local pills = {}
	local currItemNo = 1
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local playerType = player:GetPlayerType()
		if not wakaba:has_value(playernotes, playerType) then
			table.insert(playernotes, playerType)
			table.insert(items, {
				type = wakaba.INVDESC_TYPE_PLAYER,
				variant = wakaba.INVDESC_VARIANT,
				subtype = playerType,
			})
		end
	end
	for curseId = 0, getMaxCurseId(currCurse) do
		if 1 << curseId & currCurse > 0 then
			table.insert(curses, 1 << curseId)
			table.insert(items, {
				type = wakaba.INVDESC_TYPE_CURSE,
				variant = wakaba.INVDESC_VARIANT,
				subtype = 1 << curseId,
			})
		end
	end
	for i = 0, wakaba.G:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		for i = 0, 3 do
			local activeId = player:GetActiveItem(i)
			if activeId > 0 and not wakaba:has_value(collectibles, activeId) then
				table.insert(collectibles, activeId)
				table.insert(items, {
					type = 5,
					variant = 100,
					subtype = activeId,
				})
			end
		end
		for i = 0, 3 do
			local cardId = player:GetCard(i)
			if cardId > 0 and not wakaba:has_value(cards, cardId) then
				table.insert(cards, cardId)
				table.insert(items, {
					type = 5,
					variant = 300,
					subtype = cardId,
				})
			end
		end
		for i = 0, 3 do
			local pillId = player:GetPill(i)
			if pillId > 0 and not wakaba:has_value(pills, pillId) then
				table.insert(pills, pillId)
				table.insert(items, {
					type = 5,
					variant = 70,
					subtype = pillId,
				})
			end
		end

	end
	for itemId = 1, Isaac.GetItemConfig():GetCollectibles().Size - 1 do
		for i = 0, wakaba.G:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local playerType = player:GetPlayerType()
			if not wakaba:has_value(collectibles, itemId) 
			and not wakaba:has_value(wakaba._InventoryDesc.collectibleBlacklist, itemId)
			and (player:HasCollectible(itemId, true) or (wakaba._InventoryDesc.defaultItems[playerType] and wakaba:has_value(wakaba._InventoryDesc.defaultItems[playerType], itemId))) then
				table.insert(collectibles, itemId)
				table.insert(items, {
					type = 5,
					variant = 100,
					subtype = itemId,
				})
			end
		end
	end
	for itemId = 1, Isaac.GetItemConfig():GetTrinkets().Size - 1 do
		for i = 0, wakaba.G:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			if not wakaba:has_value(trinkets) and player:HasTrinket(itemId) then
				table.insert(trinkets, itemId)
				table.insert(items, {
					type = 5,
					variant = 350,
					subtype = itemId,
				})
			end
		end
	end
	local wisps = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, -1, false, false)
	for i, e in ipairs(wisps) do
		if not wakaba:has_value(collectibles, e.SubType) 
		and not wakaba:has_value(lemegetonwisps, e.SubType) 
		and not wakaba:has_value(wakaba._InventoryDesc.collectibleBlacklist, e.SubType)
		then
			table.insert(lemegetonwisps, e.SubType)
			table.insert(items, {
				type = 5,
				variant = 100,
				subtype = e.SubType,
				lemegeton = true,
			})
		end
	end

	idesc.state.lists.items = items
	--idesc.state.lists.cards = cards
	--idesc.state.lists.pills = pills

	idesc.state.listprops.max = #items


end

local function getListCount()
	local x = EID:getScreenSize().X
	local y = EID:getScreenSize().Y
	local validcount = math.ceil((y - offset * 72) / ((EID.lineHeight + 1) * 2))
	return validcount
end

local function resetList()
	idesc.state.showList = false
	idesc.state.listprops.screenx = x
	idesc.state.listprops.screeny = y
	idesc.state.listprops.offset = 0
	idesc.state.listprops.current = 1
	idesc.state.listprops.max = 1
	EID:hidePermanentText()
	for i=0, wakaba.G:GetNumPlayers()-1 do

		local player = Isaac.GetPlayer(i)
		local data = player:GetData()

		--enable player controls
		if data.InvDescPlayerPosition then
			data.InvDescPlayerPosition = nil
		end
		if data.InvDescPlayerControlsDisabled then
			player.ControlsEnabled = true
			data.InvDescPlayerControlsDisabled = false
		end
		if idesc.state.savedtimer then
			idesc.state.savedtimer = nil
		end

	end
end

local function onUpdate(player)
	if wakaba.state.options.listkey == -1 then return end
	if not inputready then 
		inputready = true
		return 
	end
	if Input.IsButtonTriggered(wakaba.state.options.listkey, 0) then
		inputready = false
		if Isaac.CountBosses() > 0 or Isaac.CountEnemies() > 0 then
			return
		end
		idesc:SetCurrentItemLists()
		if idesc.state.listprops.max <= 0 then
			return
		end
		idesc.state.showList = not idesc.state.showList
		local x,y = EID:getScreenSize().X, EID:getScreenSize().Y
		idesc.state.listprops.screenx = x
		idesc.state.listprops.screeny = y
		if idesc.state.showList then
			idesc.state.savedtimer = wakaba.G.TimeCounter
		else
			resetList()
		end
	end
	if idesc.state.showList then
		if Input.IsButtonTriggered(Keyboard.KEY_ESCAPE, 0) or Input.IsActionTriggered(ButtonAction.ACTION_PAUSE, 0) then
			resetList()
			return
		end
		local listcount = getListCount()
		local listprops = idesc.state.listprops
		if Input.IsActionTriggered(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex or 0) then
			inputready = false
			idesc.state.listprops.current = listprops.current - 1
			if listprops.current - listprops.offset < 2 and listprops.offset > 0 then
				idesc.state.listprops.offset = listprops.offset - 1
			end
			if listprops.current <= 0 then
				idesc.state.listprops.current = listprops.max
				idesc.state.listprops.offset = (listprops.max - listcount) > 0 and listprops.max - listcount or 0
			end
		elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex or 0) then
			inputready = false
			idesc.state.listprops.current = listprops.current - listcount
			idesc.state.listprops.offset = listprops.offset - listcount
			if listprops.offset < 0 then
				idesc.state.listprops.offset = 0
			end
			if listprops.current <= 0 then
				idesc.state.listprops.current = 1
				idesc.state.listprops.offset = 0
			end
		elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex or 0) then
			inputready = false
			idesc.state.listprops.current = listprops.current + 1
			if listprops.current - listprops.offset > (listcount - 2) and listprops.max - listprops.offset > listcount then
				idesc.state.listprops.offset = listprops.offset + 1
			end
			if listprops.current > listprops.max then
				idesc.state.listprops.current = 1
				idesc.state.listprops.offset = 0
			end
		elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex or 0) and (listprops.current + listcount) < listprops.max then
			inputready = false
			idesc.state.listprops.current = listprops.current + listcount
			idesc.state.listprops.offset = listprops.offset + listcount
			if listprops.max - listprops.offset < listcount then
				idesc.state.listprops.current = listprops.current - (listcount - (listprops.max - listprops.offset))
				idesc.state.listprops.offset = listprops.max - listcount
			end
			if listprops.current > listprops.max then
				idesc.state.listprops.current = listprops.max
				idesc.state.listprops.offset = listprops.max - listcount
			end
		end
	end
end
idesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, onUpdate)

local function isDiff(x, y, x2, y2)
	if math.ceil(x / 1) ~= math.ceil(x2 / 1) then
		return true
	end
	if math.ceil(y / 1) ~= math.ceil(y2 / 1) then
		return true
	end
	return false
end


local function onRender()
	if ModConfigMenu and ModConfigMenu.IsVisible then
		resetList()
		return
	end

	if Encyclopedia and DeadSeaScrollsMenu.IsOpen() then
		resetList()
		return
	end

	if idesc.state.showList and not EID.CachingDescription then

		for i=0, wakaba.G:GetNumPlayers()-1 do

			local player = Isaac.GetPlayer(i)
			local data = player:GetData()

			--freeze players and disable their controls
			player.Velocity = Vector(0,0)

			if not data.InvDescPlayerPosition then
				data.InvDescPlayerPosition = player.Position
			end
			player.Position = data.InvDescPlayerPosition
			if not data.InvDescPlayerControlsDisabled then
				player.ControlsEnabled = false
				data.InvDescPlayerControlsDisabled = true
			end

			--disable toggling revelations menu
			if data.input and data.input.menu and data.input.menu.toggle then
				data.input.menu.toggle = false
			end

		end

		local validcount = getListCount()
		local listprops = idesc.state.listprops
		local x, y = EID:getScreenSize().X, EID:getScreenSize().Y
		local x2, y2 = idesc.state.listprops.screenx, idesc.state.listprops.screeny
		if isDiff(x, y, x2, y2) then
			if listprops.current - listprops.offset > validcount then
				idesc.state.listprops.offset = listprops.offset + (listprops.current - listprops.offset - validcount + 2)
				if listprops.offset + validcount > listprops.max then
					idesc.state.listprops.offset = listprops.max - validcount
				end
			end

			--idesc.state.showList = false
			--idesc.state.listprops.screenx = x
			--idesc.state.listprops.screeny = y
			--idesc.state.listprops.offset = 0
			--idesc.state.listprops.current = 1
			--idesc.state.listprops.max = 1
			--EID:hidePermanentText()
			--return
		end
		--idesc.BackgroundSprite:Render(Vector(x, y) / 2, Vector(0,0), Vector(0,0))
		local currentcursor = 1
		local currentlist = {}
		local desc = nil
		for i = 1, validcount do
			currentlist[i] = idesc.state.lists.items[listprops.offset + i]
			if listprops.offset + i == listprops.current then
				currentcursor = i
				desc = EID:getDescriptionObj(currentlist[i].type, currentlist[i].variant, currentlist[i].subtype, nil, (currentlist[i].type == 5 and currentlist[i].variant == 100 and currentlist[i].subtype == CollectibleType.COLLECTIBLE_BIRTHRIGHT))
				if currentlist[i].type == wakaba.INVDESC_TYPE_PLAYER then
					lang = EID:getLanguage() or "en_us"
					local entrytables = wakaba.descriptions[lang] and wakaba.descriptions[lang].playernotes or wakaba.descriptions["en_us"].playernotes
					if entrytables[currentlist[i].subtype] then
						local playerID = currentlist[i].subtype
						local entry = entrytables[currentlist[i].subtype]
						local icon = (entry.icon and "{{"..entry.icon.."}}") or (EID:getIcon("Player"..playerID) ~= EID.InlineIcons["ERROR"] and "{{Player"..playerID.."}}" or "{{CustomTransformation}}")
						desc.Name = icon.." "..entry.name
						desc.Description = entry.description
					else
						local entry = entrytables[-666]
						desc.Name = entry.name
					end
				elseif currentlist[i].type == wakaba.INVDESC_TYPE_CURSE then
					lang = EID:getLanguage() or "en_us"
					local entrytables = wakaba.descriptions[lang] and wakaba.descriptions[lang].curses or wakaba.descriptions["en_us"].curses
					if not entrytables[currentlist[i].subtype] then
						desc = EID:getDescriptionObj(currentlist[i].type, currentlist[i].variant, -1)
					end
				end
			end
		end
		EID:renderString("Current item list("..listprops.current.."/"..listprops.max..")", Vector(x - wakaba.state.options.listoffset, 36-(EID.lineHeight*2)) - Vector(offset * 10, offset * -10), Vector(1,1), EID:getNameColor())
		EID:renderString("Press ".. wakaba.KeyboardToString[wakaba.state.options.listkey].." again to exit", Vector(x - wakaba.state.options.listoffset, 36-EID.lineHeight) - Vector(offset * 10, offset * -10), Vector(1,1), EID:getNameColor())
		if true --[[ not Input.IsActionPressed(ButtonAction.ACTION_MAP, EID.player.ControllerIndex) ]] then
			for i, v in pairs(currentlist) do
				local obj = EID:getDescriptionObj(v.type, v.variant, v.subtype, nil, false)
				local extIcon = nil
				if v.type == wakaba.INVDESC_TYPE_PLAYER then
					lang = EID:getLanguage() or "en_us"
					local entrytables = wakaba.descriptions[lang] and wakaba.descriptions[lang].playernotes or wakaba.descriptions["en_us"].playernotes
					if entrytables[currentlist[i].subtype] then
						local playerID = currentlist[i].subtype
						local entry = entrytables[currentlist[i].subtype]
						obj.Name = entry.name
						extIcon = (entry.icon and "{{"..entry.icon.."}}") or (EID:getIcon("Player"..playerID) ~= EID.InlineIcons["ERROR"] and "{{Player"..playerID.."}}" or "{{CustomTransformation}}")
					else
						local entry = entrytables[-666]
						obj.Name = entry.name
						extIcon = "{{CustomTransformation}}"
					end
				elseif v.type == wakaba.INVDESC_TYPE_CURSE then
					lang = EID:getLanguage() or "en_us"
					local entrytables = wakaba.descriptions[lang] and wakaba.descriptions[lang].curses or wakaba.descriptions["en_us"].curses
					if not entrytables[currentlist[i].subtype] then
						obj = EID:getDescriptionObj(v.type, v.variant, -1)
					end
				end

				local height = EID.lineHeight
				local renderpos = Vector(x - wakaba.state.options.listoffset, 36 + ((i-1) * (height + 1) * 2)) - Vector(offset * 10, offset * -10)
				local iconrenderpos = renderpos + Vector(-23, ((height + 0) / 2) - 4)
				local qtextrenderpos = renderpos + Vector(-33, (height / 2) + 1)
				local textrenderpos = renderpos + Vector(0, 1)
				local isModded = obj.ModName
				local modIcon = isModded and EID.ModIndicator[obj.ModName] and EID.ModIndicator[obj.ModName].Icon
				local color = i == currentcursor and EID:getColor("{{ColorGold}}", EID:getNameColor()) or EID:getNameColor()
				local frameno = v.lemegeton and wakaba.state.options.lemegetonicon or wakaba.state.options.idleicon
				frameno = i == currentcursor and wakaba.state.options.selicon or frameno
				idesc.IconBgSprite.Scale = Vector(EID.Scale / 3, EID.Scale / 3)
				idesc.IconBgSprite.Color = Color(1, 1, 1, EID.Config["Transparency"], 0, 0, 0)
				if v.type == wakaba.INVDESC_TYPE_PLAYER and extIcon then
					idesc.IconBgSprite:SetFrame("ItemIcon",frameno)
					idesc.IconBgSprite:Render(iconrenderpos, Vector(0,0), Vector(0,0))
					EID:renderString(extIcon, renderpos + Vector(-16.5, (height / 2) + 1), Vector(1,1), color)
				elseif v.type == wakaba.INVDESC_TYPE_CURSE then
					idesc.IconBgSprite:SetFrame("ItemIcon",frameno)
					idesc.IconBgSprite:Render(iconrenderpos, Vector(0,0), Vector(0,0))
					EID:renderInlineIcons({{obj.Icon,0}}, renderpos.X - 18, renderpos.Y + ( (height / 2) + 1))
				elseif v.variant == 100 then
					if REPENTANCE and EID.Config["ShowQuality"] then
						local quality = tonumber(EID.itemConfig:GetCollectible(tonumber(v.subtype)).Quality)
						frameno = (i ~= currentcursor and not v.lemegeton and wakaba.state.options["q"..quality.."icon"]) or frameno
						idesc.IconBgSprite:SetFrame("ItemIcon",frameno)
						idesc.IconBgSprite:Render(iconrenderpos, Vector(0,0), Vector(0,0))
						EID:renderString("{{Quality"..quality.."}}", qtextrenderpos, Vector(1,1), color)
					end
					EID:renderInlineIcons({{obj.Icon,0}}, renderpos.X - 18, renderpos.Y + ( (height / 2) + 1))
				elseif v.variant == 350 or v.variant == 300 or v.variant == 70 then
					idesc.IconBgSprite:SetFrame("ItemIcon",frameno)
					idesc.IconBgSprite:Render(iconrenderpos, Vector(0,0), Vector(0,0))
					EID:renderInlineIcons({{obj.Icon,0}}, renderpos.X - 18, renderpos.Y + ( (height / 2) + 1))
				end
				local curName = obj.Name
				curName = v.lemegeton and "{{Collectible"..CollectibleType.COLLECTIBLE_LEMEGETON.."}} "..curName or curName
				
				if EID.Config["TranslateItemName"] ~= 2 then
					local prevLanguage = EID.Config["Language"]
					local curLanguage = EID:getLanguage()
					if curLanguage ~= "en_us" then
						EID.Config["Language"] = "en_us"
						local englishName = desc.PermanentTextEnglish or EID:getObjectName(v.type, v.variant, v.subtype)
						if v.type == wakaba.INVDESC_TYPE_PLAYER then
							if wakaba.descriptions["en_us"].playernotes[v.subtype] then
								englishName = wakaba.descriptions["en_us"].playernotes[v.subtype].name
							else
								englishName = ""
							end
						elseif v.type == wakaba.INVDESC_TYPE_CURSE then
							if wakaba.descriptions["en_us"].curses[v.subtype] then
								englishName = wakaba.descriptions["en_us"].curses[v.subtype].name
							else
								englishName = ""
							end
						end
						EID.Config["Language"] = prevLanguage
						if EID.Config["TranslateItemName"] == 1 then
							curName = englishName
						elseif EID.Config["TranslateItemName"] == 3 and curName ~= englishName then
							curName = curName.." ("..englishName..")"
						end
					end
				end
				EID:renderString(curName, textrenderpos + Vector(0, isModded and 0 or (EID.lineHeight / 2)), Vector(1,1), color)
				if isModded and obj.ModName and EID.ModIndicator[obj.ModName] and EID.ModIndicator[obj.ModName].Name then
					local rst = ""
					rst = rst .. "{{"..EID.Config["ModIndicatorTextColor"].."}}" .. EID.ModIndicator[obj.ModName].Name
					if modIcon then
						rst = rst .. "{{".. EID.ModIndicator[obj.ModName].Icon .."}}"
					end
					EID:renderString(rst, textrenderpos + Vector(0, EID.lineHeight + 1), Vector(1,1), EID:getTextColor())
				end
			end
		end
		if desc then
			EID:displayPermanentText(desc)
		end
	else
	end
end
idesc:AddCallback(ModCallbacks.MC_POST_RENDER, onRender)

function idesc.InputAction(_, entity, inputHook, buttonAction)
	if wakaba.state.options.listkey == -1 then return end
	
	if idesc.state.showList and idesc.state.savedtimer then
		wakaba.G.TimeCounter = idesc.state.savedtimer
	elseif idesc.state.savedtimer then 
		idesc.state.savedtimer = nil
	end

	if idesc.state.showList and buttonAction ~= ButtonAction.ACTION_FULLSCREEN and buttonAction ~= ButtonAction.ACTION_CONSOLE and buttonAction ~= wakaba.state.options.listkey then

		if inputHook == InputHook.IS_ACTION_PRESSED or inputHook == InputHook.IS_ACTION_TRIGGERED then
			return false
		else
			return 0
		end

	end

end
idesc:AddCallback(ModCallbacks.MC_INPUT_ACTION, idesc.InputAction)





print("Inventory Description for Pudding and Wakaba Loaded")

