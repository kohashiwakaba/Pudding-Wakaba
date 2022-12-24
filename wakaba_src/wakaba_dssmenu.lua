
local save = wakaba.state

local dssmod = RegisterMod("Dead Sea Scrolls (Pudding and Wakaba)", 1)
local game = Game()
local sfx = SFXManager()
local dssmenu = DeadSeaScrollsMenu

local mfdat = {}
mfdat['a'] = {0,4,7,11};   mfdat['b'] = {1,4,8,12};   mfdat['c'] = {2,4,7,10};
mfdat['d'] = {3,4,8,12};   mfdat['e'] = {4,4,7,10};   mfdat['f'] = {5,4,6,9};
mfdat['g'] = {6,5,8,12};   mfdat['h'] = {7,4,8,11};   mfdat['i'] = {8,1,3,4};
mfdat['j'] = {9,4,7,11};   mfdat['k'] = {10,4,6,9};   mfdat['l'] = {11,4,8,10};
mfdat['m'] = {12,5,8,13};  mfdat['n'] = {13,4,8,10};  mfdat['o'] = {14,5,10,12};
mfdat['p'] = {15,4,7,10};  mfdat['q'] = {16,5,9,13};  mfdat['r'] = {17,4,7,10};
mfdat['s'] = {18,4,6,10};  mfdat['t'] = {19,4,7,10};  mfdat['u'] = {20,4,7,13};
mfdat['v'] = {21,5,8,13};  mfdat['w'] = {22,5,11,16}; mfdat['x'] = {23,4,6,12};
mfdat['y'] = {24,4,7,10};  mfdat['z'] = {25,4,6,9};   mfdat['0'] = {26,4,8,12};
mfdat['1'] = {27,4,8,10};  mfdat['2'] = {28,4,8,10};  mfdat['3'] = {29,4,8,10};
mfdat['4'] = {30,4,7,10};  mfdat['5'] = {31,4,8,9};   mfdat['6'] = {32,4,8,10};
mfdat['7'] = {33,4,8,10};  mfdat['8'] = {34,4,8,9};   mfdat['9'] = {35,4,8,9};
mfdat["'"] = {36,1,2,3};   mfdat['"'] = {37,3,4,5};   mfdat[':'] = {38,1,3,4};
mfdat['/'] = {39,3,6,8};	 mfdat['.'] = {40,1,2,4};  	mfdat[','] = {41,2,3,4};
mfdat['!'] = {42,2,4,6};   mfdat['?'] = {43,3,6,8};	  mfdat['['] = {44,2,4,6};
mfdat[']'] = {45,2,4,6};   mfdat['('] = {44,2,4,6};   mfdat[')'] = {45,2,4,6};
mfdat['$'] = {46,4,6,8};	 mfdat['C'] = {47,5,6,8};   mfdat['+'] = {48,5,6,8};
mfdat['-'] = {49,4,6,10};   mfdat['X'] = {50,5,6,8};   mfdat['D'] = {51,5,6,8};
mfdat['%'] = {52,4,6,8}; 	 mfdat['_'] = {54,2,4,5};		mfdat[' '] = {54,4,6,8};
mfdat['='] = {53,5,8,12};

local menusounds = {
  Pop2 = {Sound = Isaac.GetSoundIdByName("deadseascrolls_pop"), PitchVariance = .1},
  Pop3 = {Sound = Isaac.GetSoundIdByName("deadseascrolls_pop"), Pitch = .8, PitchVariance = .1},
  Open = {Sound = Isaac.GetSoundIdByName("deadseascrolls_whoosh"), Volume = .5, PitchVariance = .1},
  Close = {Sound = Isaac.GetSoundIdByName("deadseascrolls_whoosh"), Volume = .5, Pitch = .8, PitchVariance = .1}
}

local PlaySound
PlaySound = function(...) -- A simpler method to play sounds, allows ordered or paired tables.
    local args = {...}

    for i = 1, 6 do -- table.remove won't work to move values down if values inbetween are nil
        if args[i] == nil then
            args[i] = -1111
        else
            allNil = false
        end
    end

    local npc, tbl

    if type(args[1]) == "userdata" and args[1].Type then
        npc = args[1]:ToNPC()
        table.remove(args, 1)
    end

    if type(args[1]) == "table" then
        tbl = args[1]
        table.remove(args, 1)
        if type(tbl[1]) == "table" then
            for _, sound in ipairs(tbl) do
                if npc then
                    PlaySound(npc, sound)
                else
                    PlaySound(sound)
                end
            end

            return
        end
    elseif args[1] == -1111 then
        return
    end

    local soundArgs = {}
    for i, v in ipairs(args) do
        if v == -1111 then
            args[i] = nil
        end

        soundArgs[i] = args[i]
    end

    if tbl then
        if #tbl > 0 then
            soundArgs = tbl
        else
            soundArgs = {tbl.Sound, tbl.Volume, tbl.Delay, tbl.Loop, tbl.Pitch}
        end

        -- If there are any remaining args after npc and table are removed, they override volume, delay, loop, and pitch
        for i = 1, 4 do
            if args[i] ~= nil then
                soundArgs[i + 1] = args[i]
            end
        end
    end

    soundArgs[2] = soundArgs[2] or 1
    soundArgs[3] = soundArgs[3] or 0
    soundArgs[4] = soundArgs[4] or false
    soundArgs[5] = soundArgs[5] or 1

    if tbl and tbl.PitchVariance then
        local variance = math.random()
        if tbl.NegativeVariance then
            variance = variance - 0.5
        end

        soundArgs[5] = soundArgs[5] + variance * tbl.PitchVariance
    end

    if npc then
        npc:PlaySound(table.unpack(soundArgs))
    else
        sfx:Play(table.unpack(soundArgs))
    end
end

local function getScreenBottomRight()
    return game:GetRoom():GetRenderSurfaceTopLeft() * 2 + Vector(442,286)
end

local function getScreenCenterPosition()
    return getScreenBottomRight() / 2
end

local function approach(aa, bb, cc)
	cc = cc or 1
	if bb > aa then
		return math.min(aa + cc, bb)
	elseif bb < aa then
		return math.max(aa - cc, bb)
	else
		return bb
	end
end

local function Lerp(aa, bb, cc)
    return (aa + (bb - aa) * cc)
end

local function SafeKeyboardTriggered(key, controllerIndex)
    return Input.IsButtonTriggered(key, controllerIndex) and not Input.IsButtonTriggered(key % 32, controllerIndex)
end

local function SafeKeyboardPressed(key, controllerIndex)
    return Input.IsButtonPressed(key, controllerIndex) and not Input.IsButtonPressed(key % 32, controllerIndex)
end

local inputButtonNames = {
    [-1] = "none",

    [0] = "dpad left",
    [1] = "dpad right",
    [2] = "dpad up",
    [3] = "dpad down",
    [4] = "action down",
    [5] = "action right",
    [6] = "action left",
    [7] = "action up",
    [8] = "left bumper",
    [9] = "left trigger",
    [10] = "left stick",
    [11] = "right bumper",
    [12] = "right trigger",
    [13] = "right stick",
    [14] = "select",
    [15] = "start",

    [Keyboard.KEY_KP_0] = "numpad 0",
    [Keyboard.KEY_KP_1] = "numpad 1",
    [Keyboard.KEY_KP_2] = "numpad 2",
    [Keyboard.KEY_KP_3] = "numpad 3",
    [Keyboard.KEY_KP_4] = "numpad 4",
    [Keyboard.KEY_KP_5] = "numpad 5",
    [Keyboard.KEY_KP_6] = "numpad 6",
    [Keyboard.KEY_KP_7] = "numpad 7",
    [Keyboard.KEY_KP_8] = "numpad 8",
    [Keyboard.KEY_KP_9] = "numpad 9",
    [Keyboard.KEY_KP_DECIMAL] = "numpad decimal",
    [Keyboard.KEY_KP_DIVIDE] = "numpad divide",
    [Keyboard.KEY_KP_MULTIPLY] = "numpad multiply",
    [Keyboard.KEY_KP_SUBTRACT] = "numpad subtract",
    [Keyboard.KEY_KP_ADD] = "numpad add",
    [Keyboard.KEY_KP_ENTER] = "numpad enter",
    [Keyboard.KEY_KP_EQUAL] = "numpad equal",
}

for k, v in pairs(Keyboard) do
    if not inputButtonNames[v] then
        local name = string.sub(k, 5)
        name = name:gsub("_", " ")
        name = name:lower()
        inputButtonNames[v] = name
    end
end

local function GetInputtedButtons(controllerIndex, press)
    local func = Input.IsButtonTriggered
    if press then
        func = Input.IsButtonPressed
    end

    local inputs = {}
    for i = 0, 15 do
        if func(i, controllerIndex) then
            inputs[#inputs + 1] = i
        end
    end

    for name, key in pairs(Keyboard) do
        if func(key, controllerIndex) and not func(key % 32, controllerIndex) then
            inputs[#inputs + 1] = key
        end
    end

    return inputs
end

local menuinput
local function InitializeInput()
    if not menuinput then
        menuinput = {
            raw = {
                up = -100, down = -100, left = -100, right = -100,
            },
            menu = {
                up = false, down = false, left = false, right = false,
                toggle = false, confirm = false, back = false, keybinding = false
            },
            reading = false,
        }
    end
end

function dssmod.getInput(pnum)
    local player = Isaac.GetPlayer(pnum)

    InitializeInput()

    local input = menuinput
    local indx = player.ControllerIndex

    local raw = input.raw
    local menu = input.menu
    if not game:IsPaused() then
        local moveinput = player:GetMovementInput()
        local moveinputang = moveinput:GetAngleDegrees()
        local digitalmovedir = math.floor(4 + (moveinputang + 45) / 90) % 4
        local movelen = moveinput:Length()

        if (movelen > .3 and digitalmovedir == 0) or
        SafeKeyboardPressed(Keyboard.KEY_RIGHT, indx) or SafeKeyboardPressed(Keyboard.KEY_D, indx) then
            raw.right = math.max(raw.right, 0) + 1
        else
            raw.right = math.max(-100, math.min(1, raw.right) - 1)
        end

        if (movelen > .3 and digitalmovedir) == 1 or
        SafeKeyboardPressed(Keyboard.KEY_DOWN, indx) or SafeKeyboardPressed(Keyboard.KEY_S, indx) then
            raw.down = math.max(raw.down, 0) + 1
        else
            raw.down = math.max(-100, math.min(1, raw.down) - 1)
        end
        if (movelen > .3 and digitalmovedir) == 2 or
        SafeKeyboardPressed(Keyboard.KEY_LEFT, indx) or SafeKeyboardPressed(Keyboard.KEY_A, indx) then
            raw.left = math.max(raw.left, 0) + 1
        else
            raw.left = math.max(-100, math.min(1, raw.left) - 1)
        end
        if (movelen > .3 and digitalmovedir) == 3 or
        SafeKeyboardPressed(Keyboard.KEY_UP, indx) or SafeKeyboardPressed(Keyboard.KEY_W, indx) then
            raw.up = math.max(raw.up, 0) + 1
        else
            raw.up = math.max(-100, math.min(1, raw.up) - 1)
        end

        local dssmenu = DeadSeaScrollsMenu
        local ctog = dssmenu.GetGamepadToggleSetting() or 1

        local baseKey, safeKey = Keyboard.KEY_C, Keyboard.KEY_F1

        --toggle
        menu.toggle = SafeKeyboardTriggered(baseKey, indx) or
                      SafeKeyboardTriggered(safeKey, indx) or
                      SafeKeyboardTriggered(safeKey, 0) or
                      SafeKeyboardTriggered(safeKey, 1) or
                      SafeKeyboardTriggered(safeKey, 2) or
                      SafeKeyboardTriggered(safeKey, 3) or
                      SafeKeyboardTriggered(safeKey, 4) or
                      (ctog <= 2 and Input.IsButtonTriggered(10, indx)) or
                      ((ctog == 1 or ctog == 3) and Input.IsButtonTriggered(13, indx)) or
                      (ctog == 4 and Input.IsButtonTriggered(10, indx) and Input.IsButtonPressed(13, indx)) or
                      (ctog == 4 and Input.IsButtonTriggered(13, indx) and Input.IsButtonPressed(10, indx)) or
                      (ctog == 5 and Input.IsButtonTriggered(14, indx)) or
                      (ctog == 6 and Input.IsButtonPressed(12, indx) and Input.IsButtonTriggered(14, indx))

        --confirm
        menu.confirm = SafeKeyboardTriggered(Keyboard.KEY_ENTER, indx) or
                       SafeKeyboardTriggered(Keyboard.KEY_SPACE, indx) or
                       SafeKeyboardTriggered(Keyboard.KEY_E, indx) or
                       Input.IsButtonTriggered(4, indx) or
                       Input.IsButtonTriggered(7, indx)

        --back
        menu.back = SafeKeyboardTriggered(Keyboard.KEY_BACKSPACE, indx) or
                    SafeKeyboardTriggered(Keyboard.KEY_Q, indx) or
                    SafeKeyboardTriggered(Keyboard.KEY_C, indx) or
                    Input.IsButtonTriggered(5, indx) or
                    Input.IsButtonTriggered(6, indx)

        --directions
        menu.up = raw.up == 1 or (raw.up >= 18 and raw.up % 6 == 0)
        menu.down = raw.down == 1 or (raw.down >= 18 and raw.down % 6 == 0)
        menu.left = raw.left == 1 or (raw.left >= 18 and raw.left % 6 == 0)
        menu.right = raw.right == 1 or (raw.right >= 18 and raw.right % 6 == 0)

        menu.keybind = nil
        if menu.keybinding then
            menu.toggle = false
            menu.confirm = false
            menu.back = false
            menu.up = false
            menu.down = false
            menu.left = false
            menu.right = false
            local buttons = GetInputtedButtons(indx)
            if #buttons == 1 then
                menu.keybind = buttons[1]
            end
        end
    end
end

function dssmod.setOption(variable, setting, button, item, directorykey)
	if setting then
        if variable then
            directorykey.Settings[variable] = setting
            directorykey.SettingsChanged = true
        end

        if button and button.changefunc then
            button.changefunc(button, item)
        end
	end
end

local function hsvToRgb(h, s, v, a) --credit EmmanuelOga
  local r, g, b

  local i = math.floor(h * 6);
  local f = h * 6 - i;
  local p = v * (1 - s);
  local q = v * (1 - f * s);
  local t = v * (1 - (1 - f) * s);

  i = i % 6

  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end

  return Color(r, g, b, a, 0, 0, 0)
end

local function bselToXY(bsel, gridx, buttons)
    local x, y = 1, 1
    local bselX, bselY
    local maxX = {}
    for i, button in ipairs(buttons) do
        if i == bsel then
            bselX, bselY = x, y
        end

        if i == #buttons then
            maxX[y] = x
            return bselX, bselY, maxX, y
        end

        local prevX = x
        x = x + (button.fullrow and gridx or 1)
        if x > gridx then
            maxX[y] = prevX
            y = y + 1
            x = 1
        end
    end
end

local function xyToBsel(x, y, gridx, buttons)
    local x2, y2 = 1, 1
    for i, button in ipairs(buttons) do
        if x2 == x and y2 == y then
            return i
        end

        x2 = x2 + (button.fullrow and gridx or 1)
        if x2 > gridx then
            y2 = y2 + 1
            x2 = 1
        end
    end
end

local menuroots = {
    main = {
        offset = Vector(-42, 10),
        titleoffset = Vector(0, -74), -- (0, -74)
        bounds = {-86, -62, 86, 79}, -- min X, min Y, max X, max Y
        height = 141,
        topspacing = 16,
        bottomspacing = 0,
        scrollersymX = -94,
        scrollersymYTop = -46,
        scrollersymYBottom = 78
    },
    tooltip = {
        offset = Vector(132, 6),
        --bounds = {-59, -52, 58, 64},
        topspacing = 0,
        bottomspacing = 0,
        height = 118
    }
}

local fontspacers = {8, 12, 16}

local ErrTab = {"[", "e", "r", "r", "o", "r"}

local function getMenuStringLength(str, fsize)
	str = string.lower(str)
    fsize = fsize + 1
    local length = 0
    local chr = {}
	
    for i = 1, string.len(str) do
        local sub = string.sub(str, i, i)
		
		if not mfdat[sub] then
			for _, v in ipairs(ErrTab) do
				local len = mfdat[v][fsize]
				table.insert(chr, {v, length})
				length = length + len + 1
			end
			
			sub = "]"
		end
		
        local len = mfdat[sub][fsize]
        table.insert(chr, {sub, length})
        length = length + len + 1
    end

    return length, chr
end

function dssmod.generateDynamicSet(base, selected, fsize, clr, shine, nocursor)
    local dssmenu = DeadSeaScrollsMenu
    local menupal = dssmenu.GetPalette()
    local rainbow = menupal.Rainbow
    fsize = base.fsize or fsize or 2
    local clr1 = menupal[2]
    local clr2 = menupal[3]
    local useclr = base.clr or clr or 2
    useclr = menupal[useclr]
    local shine = base.shine or shine

    local height = 0
    local width = {} -- since buttons are arranged vertically, only the widest part of the button should count for width

    local dynamicset = {type = 'dynamicset', set = {}, pos = g.ZeroV}

    local modules = {}
    if base.strpair then
        local part = base.strpair[1]
        modules[#modules + 1] = {type = 'str', str = part.str, height = 0, halign = -1, color = useclr, alpha = part.alpha, shine = shine}

        local part = base.strpair[2]
        modules[#modules + 1] = {type = 'str', str = part.str, halign = 1, color = clr2, alpha = part.alpha, shine = shine, select = false}
    elseif base.str then
        modules[#modules + 1] = {type = 'str', str = base.str, halign = base.halign, color = useclr, alpha = 1, shine = shine}

        if base.substr then
            local subsize = base.substr.size or math.max(1, fsize - 1)
            modules[#modules + 1] = {type = 'str', str = base.substr.str, size = subsize, color = clr2, alpha = base.substr.alpha or .8, shine = shine, pos = Vector(0, -2), select = false}
        end
    elseif base.strset then
        for i, str in ipairs(base.strset) do
            local newstr = {type = 'str', str = str}
            if i ~= 1 then
                newstr.select = false
            end

            modules[#modules + 1] = newstr
        end
    elseif base.spr then
        modules[#modules + 1] = {type = 'spr', fontcolor = useclr, sprite = base.spr.sprite, center = base.spr.center, centerx = base.spr.centerx, centery = base.spr.centery, width = base.spr.width, height = base.spr.height, float = base.spr.float, shadow = base.spr.shadow, invisible = base.spr.invisible, scale = base.spr.scale}
    end

    if base.variable or base.setting then
        local sizedown = math.max(1, fsize - 1)
        local setting = {type = 'str', settingscursor = not base.keybind, size = sizedown, color = clr2, alpha = .8, shine = shine, pos = Vector(0, -2), select = false}
        setting.min = base.min
        setting.max = base.max
        setting.setting = base.setting
        if base.slider then
            setting.slider = true
            setting.increment = base.increment
            setting.str = ''
            for i = 1, math.ceil(base.max / base.increment) do
                setting.str = setting.str..'i'
            end
        elseif base.choices then
            setting.choices = #base.choices
            setting.str = base.choices[base.setting]
        elseif base.max then
            setting.str = (base.pref or '')..base.setting..(base.suf or '')
        elseif base.keybind then
            if base.keybinding then
                setting.str = '[awaiting input]'
            else
                setting.str = '[' .. inputButtonNames[base.setting] .. ']'
            end
        end

        modules[#modules + 1] = setting
    end

    for _, module in ipairs(modules) do
        if module.type == 'str' then
            if module.size == nil then module.size = fsize end
            if module.height == nil then module.height = fontspacers[module.size] end

            local length, chr = getMenuStringLength(module.str, module.size)
            module.len = length
            module.chr = chr
            width[#width + 1] = length
        else
            width[#width + 1] = module.width
        end

        if module.nocursor == nil then module.nocursor = nocursor end
        if module.colorselect == nil then module.colorselect = base.colorselect end
        if module.select == nil then module.select = selected end
        if module.usemenuclr == nil then module.usemenuclr = base.usemenuclr end
        if module.usecolorize == nil then module.usecolorize = base.usecolorize end
        if module.palcolor == nil then module.palcolor = base.palcolor end
        if module.cursoroff == nil then module.cursoroff = base.cursoroff end

        height = height + module.height
        module.rainbow = rainbow or nil
        table.insert(dynamicset.set, module)
    end

    dynamicset.width = math.max(table.unpack(width))
    dynamicset.height = height

    if base.fullrow then dynamicset.fullrow = true end

    return dynamicset
end

function dssmod.generateMenuDraw(item, scenter, input, root, tbl)
    local dssmenu = DeadSeaScrollsMenu
    local menupal = dssmenu.GetPalette()
    local rainbow = menupal.Rainbow

    local drawings = {}
    local mroot = menuroots[root]
    local valign = item.valign or 0
    local halign = item.halign or 0
    local fsize = item.fsize or 3
    local spacers = {8, 12, 16}
    local spacer = spacers[fsize]
    local nocursor = (item.nocursor or item.scroller)
    local width = 82
    local seloff = 0

    local dynamicset = {
        type = 'dynamicset',
        set = {},
        valign = valign,
        halign = halign,
        width = width,
        height = 0,
        pos = g.ZeroV,
        centeritems = item.centeritems
    }

    if item.gridx then
        dynamicset.gridx = item.gridx
        dynamicset.widest = 0
        dynamicset.highest = 0
    end

    --buttons
    local bsel = item.bsel
    if item.buttons then
        for i, btn in ipairs(item.buttons) do
            if not btn.forcenodisplay then
                local btnset = dssmod.generateDynamicSet(btn, bsel == i, fsize, item.clr, item.shine, nocursor)

                if dynamicset.widest then
                    if btnset.width > dynamicset.widest then
                        dynamicset.widest = btnset.width
                    end
                end

                if dynamicset.highest then
                    if btnset.height > dynamicset.highest then
                        dynamicset.highest = btnset.height
                    end
                end

                table.insert(dynamicset.set, btnset)

                dynamicset.height = dynamicset.height + btnset.height

                if bsel == i then
                    seloff = dynamicset.height - btnset.height / 2
                end
            end
        end
    end

    --tooltip
    if item.strset or item.strpair or item.str or item.spr then
        local itemset = dssmod.generateDynamicSet(item)
        dynamicset.height = dynamicset.height + itemset.height
        table.insert(dynamicset.set, itemset)
    end

    if dynamicset.gridx then
        dynamicset.height = 0

        local gridx, gridy = 1, 1
        local rowDrawings = {}
        for i, drawing in ipairs(dynamicset.set) do
            if drawing.fullrow then
                if #rowDrawings > 0 then
                    rowDrawings = {}
                    gridy = gridy + 1
                end

                gridx = math.ceil(dynamicset.gridx / 2)
                drawing.halign = -2
            end

            drawing.gridxpos = gridx
            drawing.gridypos = gridy

            rowDrawings[#rowDrawings + 1] = drawing

            local highestInRow, widestInRow, bselInRow
            for _, rowDrawing in ipairs(rowDrawings) do
                if not highestInRow or rowDrawing.height > highestInRow then
                    highestInRow = rowDrawing.height
                end

                if not widestInRow or rowDrawing.width > widestInRow then
                    widestInRow = rowDrawing.width
                end

                bselInRow = bselInRow or rowDrawing.bselinrow or bsel == i
            end

            for _, rowDrawing in ipairs(rowDrawings) do
                rowDrawing.highestinrow = highestInRow
                rowDrawing.widestinrow = widestInRow
                rowDrawing.bselinrow = bselInRow
            end

            gridx = gridx + 1
            if gridx > dynamicset.gridx or i == #dynamicset.set or drawing.fullrow or (dynamicset.set[i + 1] and dynamicset.set[i + 1].fullrow) then
                dynamicset.height = dynamicset.height + highestInRow
                if bselInRow then
                    seloff = dynamicset.height - highestInRow / 2
                end

                rowDrawings = {}
                gridy = gridy + 1
                gridx = 1
            end
        end
    end

    local yOffset = -(dynamicset.height / 2)

    if mroot.bounds then
        if yOffset < mroot.bounds[2] + mroot.topspacing then
            yOffset = mroot.bounds[2] + mroot.topspacing
        end
    end

    if item.scroller then
        item.scroll = item.scroll or 0
        if input.down then
            item.scroll = item.scroll + 16
        elseif input.up then
            item.scroll = item.scroll - 16
        end

        local halfheight = dynamicset.height / 2
        item.scroll = math.max(mroot.height / 2, math.min(item.scroll, dynamicset.height - mroot.height / 2))
        --item.scroll = math.min(math.max(item.scroll, 80), height - 48)
        seloff = item.scroll
    end

    if dynamicset.height > 16 * 7 then
        seloff = -seloff + mroot.height / 2
        seloff = math.max(-dynamicset.height + mroot.height - mroot.bottomspacing, math.min(0, seloff))
        if item.vscroll then
            item.vscroll = Lerp(item.vscroll, seloff, .2)
        else
            item.vscroll = seloff
        end
        dynamicset.pos = Vector(0, item.vscroll)
    end

    dynamicset.pos = dynamicset.pos + Vector(0, yOffset) --+ Vector(0, 64 * valign)
    table.insert(drawings, dynamicset)

    --scroll indicator
    if item.scroller and item.scroll then
        local jumpy = (game:GetFrameCount() % 20) / 10
        if item.scroll > mroot.height / 2 then
            local sym = {type = 'sym', frame = 9, pos = Vector(mroot.scrollersymX, mroot.scrollersymYTop - jumpy)}
            table.insert(drawings, sym)
        end

        if item.scroll < dynamicset.height - mroot.height / 2 then
            local sym = {type = 'sym', frame = 10, pos = Vector(mroot.scrollersymX, mroot.scrollersymYBottom + jumpy)}
            table.insert(drawings, sym)
        end
    end

    --title
    if item.title then
        local title = {type = 'str', str = item.title, size = 3, color = menupal[3], pos = mroot.titleoffset, halign = 0, underline = true, bounds = false}
        title.rainbow = rainbow or nil
        table.insert(drawings, title)
    end

    for _, drawing in ipairs(drawings) do
        if drawing.bounds == nil then drawing.bounds = mroot.bounds end
        if drawing.root == nil then drawing.root = scenter + mroot.offset end
    end

    return drawings
end

function dssmod.renderText(tab)
	local dssmenu = DeadSeaScrollsMenu
	local tbl = dssmenu.OpenedMenu
	local dtype = tab.type
	local scale = tab.scale or Vector(1, 1)
	local root = tab.root or getScreenCenterPosition()
	local pos = tab.pos or g.ZeroV
	local mpos = Isaac.WorldToScreen(Input.GetMousePosition(true)) * 2
    local dssmenu = DeadSeaScrollsMenu
    local uispr
	if tbl then
		uispr = tbl.MenuSprites or dssmenu.GetDefaultMenuSprites()
	else
		uispr = dssmenu.GetDefaultMenuSprites()
	end
	local font = uispr.Font
	local menupal = dssmenu.GetPalette()
	local update = tab.update or false
	local alpha = tab.alpha or 1
	local color = tab.color or (tab.sprite and not tab.usemenuclr and Color(1, 1, 1, 1, 0, 0, 0)) or menupal[tab.palcolor or 2]
    local fontcolor = tab.fontcolor or color
    local shine = tab.shine or 0
    local bottomcutoff = false
	if tab.rainbow then
		color = hsvToRgb((pos.Y % 256) / 255, 1, 1, 1)
	end

    if tab.colorselect and not tab.select then
        alpha = alpha / 2
    end

	color = Color(color.R, color.G, color.B, alpha, shine, shine, shine)
    if tab.usecolorize then
        local r, g, b = color.R, color.G, color.B
        color = Color(1, 1, 1, alpha, shine, shine, shine)
        color:SetColorize(r, g, b, 1)
    end

    fontcolor = Color(color.R, color.G, color.B, alpha, shine, shine, shine)
	local fnames = {'12', '16', '24'}
	local scaler = {8, 12, 16}
	
	tab.size = tab.size or 1
	tab.str = tab.str or 'nostring'
	tab.halign = tab.halign or 0
	tab.valign = tab.valign or 0

	local str = tab.str
	local idx = tab.size + 1
	if not tab.chr or not tab.len then
		tab.len, tab.chr = getMenuStringLength(str, tab.size)
	end

	--drawing string
	local fname = fnames[tab.size]
	local myscale = scaler[tab.size]
	font.Color = fontcolor
	font.Scale = scale
	local xoff = ((tab.halign == 0 and tab.len / -2) or (tab.halign == 1 and tab.len * -1) or 0) + ((tab.parentwidth or 82) * tab.halign)
	if tab.halign == -2 then
		xoff = 0
	end

	local yoff = ((tab.valign == 0 and -.5) or (tab.valign == 1 and -1) or 0) * (myscale)
	if tab.valign == -2 then
		yoff = 0
	end

	local clipt = 0
	local clipb = 0
	local usepos = pos + Vector(xoff, yoff)

	local wtf = tab.size == 1 and -8 or tab.size == 2 and -4 or 0
	if tab.bounds then
		clipt = math.min(math.max(0, tab.bounds[2] - (usepos.Y)), myscale) -- myscale
		clipb = math.min(math.max(0, (usepos.Y + wtf) - tab.bounds[4]), myscale)
	end
	
	for i, chr in ipairs(tab.chr) do
		local fpos = usepos + Vector(chr[2], 0)
		if tab.slider then
			local iii = math.ceil(tab.max / tab.increment)
			if i > iii * (tab.setting / tab.max) then
				font.Color = Color(color.R, color.G, color.B, tab.alpha / 2, 0, 0, 0)
			end
		end

		if (not tab.bounds) or (clipt < myscale and clipb < myscale) then
			if tab.hintletter then
				if tab.hintletter == chr[1] then
					font.Color = Color(color.R, color.G, color.B, alpha * 0.83, 0, 0, 0)
				else
					font.Color = Color(color.R, color.G, color.B, alpha, 0, 0, 0)
				end
			end
			
			font:SetFrame(fname, mfdat[chr[1] ][1])
			font:Render(root + fpos, Vector(0, clipt), Vector(0, clipb))
		end
	end
end

local OldTimer
local OverwrittenPause = false
local AddedPauseCallback = false
function overridePause(player, hook, action)
	if not AddedPauseCallback then return nil end

	if OverwrittenPause then
		OverwrittenPause = false
		AddedPauseCallback = false
		return
	end

	if action == ButtonAction.ACTION_SHOOTRIGHT then
		OverwrittenPause = true
		for _, ember in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.FALLING_EMBER, -1)) do
			ember:Remove()
		end
		if REPENTANCE then
			for _, rain in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.RAIN_DROP, -1)) do
				rain:Remove()
			end
		end
		return 0.75
	end
end
dssmod:AddCallback(ModCallbacks.MC_INPUT_ACTION, overridePause, InputHook.IS_ACTION_PRESSED)

function freezeGame(unfreeze)
	if unfreeze then
		OldTimer = nil
		if not AddedPauseCallback then
			AddedPauseCallback = true
		end
	else
		if not OldTimer then
			OldTimer = game.TimeCounter
		end
		if REPENTANCE then
			Isaac.GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_PAUSE, UseFlag.USE_NOANIM)
		else
			Isaac.GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_PAUSE, false, false, true, false, 0)
		end
		game.TimeCounter = OldTimer
	end
end

function dssmod.drawMenu(tbl, tab)
	local dtype = tab.type
	local scale = tab.scale or Vector(1, 1)
	local root = tab.root or getScreenCenterPosition()
	local pos = tab.pos or Vector(0, 0)
	local mpos = Isaac.WorldToScreen(Input.GetMousePosition(true)) * 2
    local dssmenu = DeadSeaScrollsMenu
    local uispr = tbl.MenuSprites or dssmenu.GetDefaultMenuSprites()
	local font = uispr.Font
	local menuspr = uispr.Face
	local menupal = dssmenu.GetPalette()
	local update = tab.update or false
	local alpha = tab.alpha or 1
	local color = tab.color or (tab.sprite and not tab.usemenuclr and Color(1, 1, 1, 1, 0, 0, 0)) or menupal[tab.palcolor or 2]
    local fontcolor = tab.fontcolor or color
    local shine = tab.shine or 0
    local bottomcutoff = false
	if tab.rainbow then
		color = hsvToRgb((pos.Y % 256) / 255, 1, 1, 1)
	end

    if tab.colorselect and not tab.select then
        alpha = alpha / 2
    end

	color = Color(color.R, color.G, color.B, alpha, shine, shine, shine)
    if tab.usecolorize then
        local r, g, b = color.R, color.G, color.B
        color = Color(1, 1, 1, alpha, shine, shine, shine)
        color:SetColorize(r, g, b, 1)
    end

    fontcolor = Color(color.R, color.G, color.B, alpha, shine, shine, shine)
	local fnames = {'12', '16', '24'}
	local scaler = {8, 12, 16}

    local selectCursorPos
    local settingsCursorXPlace

	if dtype == 'dot' then
		menuspr.Color = color
		menuspr:SetFrame("Sym", 6)
		menuspr:Render(root + pos, Vector(0, 0), Vector(0, 0))
	elseif dtype == 'sym' then
		menuspr.Color = color
		menuspr:SetFrame("Sym", tab.frame or 6)
		menuspr:Render(root + pos, Vector(0, 0), Vector(0, 0))
	elseif dtype == 'spr' then
		local uspr = tab.sprite
        local floaty = 0
        if tab.float then
            floaty = Vector(0, tab.float[1]):Rotated((game:GetFrameCount() * tab.float[2]) % 360)
            floaty = floaty.Y
        end

        if (tab.center or tab.centerx) and tab.width then
            pos = pos - Vector(tab.width / 2 * scale.X, 0)
        end

        if (tab.center or tab.centery) and tab.height then
            pos = pos - Vector(0, tab.height / 2 * scale.Y)
        end

        pos = pos + Vector(0, floaty)

        local clipt = 0
        local clipb = 0
        if tab.bounds then
            clipt = math.min(math.max(0, tab.bounds[2] - pos.Y))
            clipb = math.min(math.max(0, (pos.Y + tab.height - 16) - tab.bounds[4]))
        end

        if clipt + clipb >= tab.height then
            bottomcutoff = clipb >= tab.height
        else
    		uspr.Scale = scale
    		if tab.shadow then
    			uspr.Color = Color(0, 0, 0, alpha / 2, 0, 0, 0)
    			uspr:Render(root + pos + scale, Vector(0, clipt), Vector(0, clipb))
    		end

            if not tab.invisible then
          		uspr.Color = color
          		uspr:Render(root + pos, Vector(0, clipt), Vector(0, clipb))
            end
        end

        selectCursorPos = pos + Vector(-12, tab.height / 2 * scale.Y)
	elseif dtype == 'str' then
		tab.size = tab.size or 1
		tab.str = tab.str or 'nostring'
		tab.halign = tab.halign or 0
		tab.valign = tab.valign or 0

		local str = tab.str
		local idx = tab.size + 1
        if not tab.chr or not tab.len then
            tab.len, tab.chr = getMenuStringLength(str, tab.size)
        end

		--drawing string
		local fname = fnames[tab.size]
		local myscale = scaler[tab.size]
		font.Color = fontcolor
		font.Scale = scale
		local xoff = ((tab.halign == 0 and tab.len / -2) or (tab.halign == 1 and tab.len * -1) or 0) + ((tab.parentwidth or 82) * tab.halign)
        if tab.halign == -2 then
            xoff = 0
        end

        local yoff = ((tab.valign == 0 and -.5) or (tab.valign == 1 and -1) or 0) * (myscale)
        if tab.valign == -2 then
            yoff = 0
        end

		local clipt = 0
		local clipb = 0
		local usepos = pos + Vector(xoff, yoff)

		local wtf = tab.size == 1 and -8 or tab.size == 2 and -4 or 0
		if tab.bounds then
			clipt = math.min(math.max(0, tab.bounds[2] - (usepos.Y)), myscale) -- myscale
			clipb = math.min(math.max(0, (usepos.Y + wtf) - tab.bounds[4]), myscale)
		end

        if clipt + clipb >= myscale then
            bottomcutoff = clipb >= myscale
        else
    		for i, chr in ipairs(tab.chr) do
    			local fpos = usepos + Vector(chr[2], 0)
                if tab.slider then
                    local iii = math.ceil(tab.max / tab.increment)
                    if i > iii * (tab.setting / tab.max) then
                        font.Color = Color(color.R, color.G, color.B, tab.alpha / 2, 0, 0, 0)
                    end
                end

    			if (not tab.bounds) or (clipt < myscale and clipb < myscale) then
                    if tab.hintletter then
                        if tab.hintletter == chr[1] then
                            font.Color = Color(color.R, color.G, color.B, alpha * 0.83, 0, 0, 0)
                        else
                            font.Color = Color(color.R, color.G, color.B, alpha, 0, 0, 0)
                        end
                    end

    				font:SetFrame(fname, mfdat[chr[1] ][1])
    				font:Render(root + fpos, Vector(0, clipt), Vector(0, clipb))
    			end
    		end

    		--underline
    		if tab.underline then
    			menuspr:SetFrame("Sym", 0)
    			menuspr.Color = fontcolor
    			menuspr:Render(root + pos + Vector(0, 16), Vector(0, 0), Vector(0, 0))
    		end
        end

        selectCursorPos = pos + Vector(xoff - 12, 3 - tab.size)
        if tab.size == 1 then
            selectCursorPos = pos + Vector(xoff - 6, 1 - tab.size)
        end

        settingsCursorXPlace = math.max(40, -xoff + 10)
	elseif dtype == 'dynamicset' then
		local yy = 0

        if tab.gridx and tab.centeritems then
            yy = yy + tab.highest / 2
        end

		for i, drawing in ipairs(tab.set) do
			drawing.root = root
			drawing.bounds = tab.bounds

            if tab.gridx then
                local totalwidth = tab.gridx * drawing.widestinrow
                local x = drawing.gridxpos - 1
                local xPos = (-totalwidth / 2) + Lerp(0, totalwidth - drawing.widestinrow, x / (tab.gridx - 1))
                drawing.pos = (drawing.pos or Vector(0, 0)) + pos + Vector(xPos, yy)

                if tab.centeritems then
                    local widthdiff = drawing.widestinrow - drawing.width
                    local heightdiff = drawing.highestinrow - drawing.height
                    drawing.pos = drawing.pos + Vector(widthdiff / 2 + drawing.width / 2, -heightdiff / 2 - drawing.height / 2)
                end

                if tab.set[i + 1] and tab.set[i + 1].gridypos > drawing.gridypos then
                    yy = yy + drawing.highestinrow
                end
            else
    			drawing.pos = (drawing.pos or Vector(0, 0)) + pos + Vector(0, yy)
                yy = yy + (drawing.height or 16)
            end

            drawing.halign = drawing.halign or tab.halign
			drawing.width = drawing.width or tab.width or 82
            drawing.parentwidth = tab.parentwidth or tab.width or drawing.width or 82
		end

		local yo = 0--(((tab.valign or -1) + 1) * yy) / -2

		for i, drawing in ipairs(tab.set) do
			drawing.pos = drawing.pos + Vector(0, yo)
			if dssmod.drawMenu(tbl, drawing) then -- returns true if cutoff
                return true
            end
		end
	end

    -- draw selected / choice arrows
    --selected
    if tab.select and not tab.nocursor and selectCursorPos then
        if tab.size == 1 then
            menuspr:SetFrame("Sym", 2)
        else
            menuspr:SetFrame("Sym", 1)
        end

        if tab.cursoroff then
            selectCursorPos = selectCursorPos + tab.cursoroff
        end

        menuspr.Color = fontcolor

        local clipt = math.min(math.max(0, tab.bounds[2] - (selectCursorPos.Y - 8)), 16)
        local clipb = math.min(math.max(0, (selectCursorPos.Y - 8) - tab.bounds[4]), 16)
        menuspr:Render(root + selectCursorPos, Vector(0, clipt), Vector(0, clipb))
    end

    -- choices
    if tab.settingscursor and settingsCursorXPlace then
        menuspr.Color = fontcolor
        if (tab.choices and tab.setting > 1) or (tab.max and tab.setting > (tab.min or 0)) then
            menuspr:SetFrame("Sym", 8)

            local sympos = pos + Vector(-settingsCursorXPlace, -1)
            local clipt = math.min(math.max(0, tab.bounds[2] - (sympos.Y - 8)), 16)
            local clipb = math.min(math.max(0, (sympos.Y - 8) - tab.bounds[4]), 16)
            menuspr:Render(root + sympos, Vector(0, clipt), Vector(0, clipb))
        end

        if (tab.choices and tab.setting < tab.choices) or (tab.max and tab.setting < tab.max) then
            menuspr:SetFrame("Sym", 7)

            local sympos = pos + Vector(settingsCursorXPlace, -1)
            local clipt = math.min(math.max(0, tab.bounds[2] - (sympos.Y - 8)), 16)
            local clipb = math.min(math.max(0, (sympos.Y - 8) - tab.bounds[4]), 16)
            menuspr:Render(root + sympos, Vector(0, clipt), Vector(0, clipb))
        end
    end

	freezeGame()
	
    if bottomcutoff then
        return true
    end
end

local enteredCode = "" -- Used by the cheats menu.
local BackspaceTimer = -15
function dssmod.runMenu(tbl)
    local directory = tbl.Directory
    local directorykey = tbl.DirectoryKey
    local scenter = getScreenCenterPosition()

    local dssmenu = DeadSeaScrollsMenu
    local uispr = tbl.MenuSprites or dssmenu.GetDefaultMenuSprites()
    local menuspr = {uispr.Shadow, uispr.Back, uispr.Face, uispr.Border}
    local menumask = uispr.Mask
    local font = uispr.Font

	local menupal = dssmenu.GetPalette()
	local rainbow = menupal.Rainbow
	local root1 = scenter + Vector(-42, 10)
	local root2 = scenter + Vector(132, 6)
	
	if ModConfigMenu and ModConfigMenu.IsVisible then
		ModConfigMenu.CloseConfigMenu()
	end

    -- initialize sprites
    directorykey.Idle = false
	if not directorykey.Init then
		for i = 1, 4 do
			menuspr[i]:Play("Dissapear") --(sic)
			menuspr[i]:SetLastFrame()
            menuspr[i]:Stop()
		end

        if not directorykey.OpenAnimation then
            directorykey.Idle = true
            directorykey.MaskAlpha = 0
        end

		directorykey.Init = true
	end

    --background sprite
    if directorykey.OpenAnimation then
        directorykey.OpenAnimation = false
        for i = 1, 4 do
            menuspr[i]:Play("Appear", true)
        end
    end

    if directorykey.CloseAnimation then
        directorykey.MaskAlpha = approach(directorykey.MaskAlpha, 1, .25)
        directorykey.Item = directory[directorykey.Main]
        directorykey.Path = {}

        if directorykey.MaskAlpha == 1 then
            directorykey.CloseAnimation = false
            for i = 1, 4 do
                menuspr[i]:Play("Dissapear", true)
            end
        end
    end

    if tbl.Exiting and not directorykey.CloseAnimation and not menuspr[3]:IsPlaying("Dissapear") then
        tbl.Exiting = nil
        return
    elseif not menuspr[3]:IsPlaying("Appear") and not menuspr[3]:IsPlaying("Dissapear") then
        for i = 1, 4 do
            menuspr[i]:Play("Idle")
        end

        if not tbl.Exiting then
            directorykey.MaskAlpha = approach(directorykey.MaskAlpha, 0, .25)
            directorykey.Idle = true
        end
    end

	menuspr[2].Color = menupal[1]
	menuspr[3].Color = menupal[1]
	for i = 1, 3 do
		menuspr[i]:Render(root1, Vector(0, 0), Vector(0, 0))
		menuspr[i]:Update()
	end
    menuspr[4]:Render(root1, Vector(0, 0), Vector(0, 0))
    menuspr[4]:Update()

    if directorykey.Idle then
    	--INTERACTION
    	local item = directorykey.Item
        local itemswitched = false

        if item ~= directorykey.PreviousItem then
            itemswitched = true

            if item.generate then
                item.generate(item, tbl)
            end

            directorykey.PreviousItem = item
        end

        if item.update then
            item.update(item, tbl)
        end

        local input = menuinput.menu
    	local buttons = item.buttons
    	local pages = item.pages
    	local bsel = item.bsel or 1
    	local psel = item.psel or 1
    	local action = false
        local func = nil
        local changefunc = nil
        local prevbutton = nil
    	local dest = false
    	local button = false
    	local draw = true
        local allnosel = false

    	--buttons
    	if buttons and #buttons > 0 then
    		--button selection
    		item.bsel = math.min((item.bsel or 1), #buttons)

            allnosel = true
            for i, button in ipairs(buttons) do
                if button.display ~= nil or button.displayif then
                    if button.display == false or (button.displayif and not button.displayif(button, item, tbl)) then
                        button.nosel = true
                        button.forcenodisplay = true
                    elseif button.forcenodisplay then
                        button.nosel = nil
                        button.forcenodisplay = nil
                    end
                end

                if not button.forcenodisplay and button.generate and itemswitched then
                    button.generate(button, item, tbl)
                end

                if not button.nosel then
                    if allnosel and item.bsel < i then -- select the first selectable button if the currently selected button isn't selectable ex 1
                        item.bsel = i
                    end

                    allnosel = false
                end
            end

            local prevbsel = item.bsel
            if buttons[item.bsel].changefunc then
                prevbutton = buttons[item.bsel]
                changefunc = buttons[item.bsel].changefunc
            end

			if allnosel then
				item.bsel = 1
			elseif item.gridx then
				local firstLoop = true
				local tryKeepX, tryKeepY
				while buttons[item.bsel].nosel or firstLoop do
					local x, y, maxX, maxY = bselToXY(item.bsel, item.gridx, buttons)
					--[[
					local x = ((item.bsel - 1) % item.gridx) + 1
					local y = math.ceil(item.bsel / item.gridx)
					local maxY = math.ceil(#buttons / item.gridx)
					local maxX = ((#buttons - 1) % item.gridx) + 1 -- on maxY]]
					if tryKeepX then
						x = tryKeepX
						tryKeepX = nil
					end

					if tryKeepY then
						y = tryKeepY
						tryKeepY = nil
					end

					if input.up then
						y = y - 1
					elseif input.down then
						y = y + 1
					elseif input.left then
						x = x - 1
					elseif input.right then
						x = x + 1
					end

					local prevX, prevY = x, y

					if y < 1 then
						y = maxY
					elseif y > maxY then
						y = 1
					end

					maxX = maxX[y]
					if x < 1 then
						x = maxX
					elseif x > maxX then
						if input.down or input.up then
							x = maxX
						else
							x = 1
						end
					end

					item.bsel = xyToBsel(x, y, item.gridx, buttons)
					if buttons[item.bsel].nosel then
						if input.up or input.down then
							tryKeepX = prevX
						elseif input.left or input.right then
							tryKeepY = prevY
						end
					end

					--(y - 1) * item.gridx + x
					firstLoop = nil
				end
			else
				if input.up then
					item.bsel = ((item.bsel - 2) % #buttons) + 1
					while item.buttons[item.bsel].nosel do
						item.bsel = ((item.bsel - 2) % #buttons) + 1
					end
				elseif input.down or item.buttons[item.bsel].nosel then
					item.bsel = (item.bsel % #buttons) + 1
					while item.buttons[item.bsel].nosel do
						item.bsel = (item.bsel % #buttons) + 1
					end
				end
			end

    		bsel = item.bsel
            if bsel == prevbsel then
                prevbutton = nil
                changefunc = nil
            end

    		dest = directory[buttons[bsel].dest]
    		button = item.buttons[bsel]

    		--button confirmation
			if input.confirm and not itemswitched and not allnosel then
				if button then
					if button.action then
						action = button.action
					end

					if button.func then
						func = button.func
					end
				end

				if dest then
					table.insert(directorykey.Path, item)
					directorykey.Item = dest
				end
			end

    		--button choice selection
    		if (button.variable or button.setting) and not allnosel then
    			if button.choices then
    				button.setting = button.setting or 1
    				if (input.right or input.dright) and button.setting < #button.choices then
    					button.setting = button.setting + 1
    					sfx:Play(SoundEffect.SOUND_PLOP, 1, 0, false, .9 + (.2 * (#button.choices / (#button.choices - (button.setting - 1)))))
    					dssmod.setOption(button.variable, button.setting, button, directorykey.Item, directorykey)
    				elseif (input.left or input.dleft) and button.setting > 1 then
    					button.setting = button.setting - 1
    					sfx:Play(SoundEffect.SOUND_PLOP, 1, 0, false, .9 + (.2 * (#button.choices / (#button.choices - (button.setting - 1)))))
    					dssmod.setOption(button.variable, button.setting, button, directorykey.Item, directorykey)
    				elseif input.confirm then
    					button.setting = (button.setting % #button.choices) + 1
    					sfx:Play(SoundEffect.SOUND_PLOP, 1, 0, false, .9 + (.2 * (#button.choices / (#button.choices - (button.setting - 1)))))
    					dssmod.setOption(button.variable, button.setting, button, directorykey.Item, directorykey)
    				end
    			elseif button.max then
    				local inc, min, max = button.increment or 1, button.min or 0, button.max
    				local pop = false
    				button.setting = button.setting or 0
    				if (input.right or input.dright or input.confirm) then
    					if button.setting < max then
    						button.setting = math.min(button.setting + inc, max)
    						pop = true
    					elseif input.confirm then
    						button.setting = button.min or 0
    						pop = true
    					end
    				elseif (input.left or input.dleft) and button.setting > min then
    					button.setting = math.max(button.setting - inc, min)
    					pop = true
    				end

    				if pop then
    					dssmod.setOption(button.variable, button.setting, button, directorykey.Item, directorykey)
    					sfx:Play(SoundEffect.SOUND_PLOP, 1, 0, false, .9 + (.2 * (button.setting / button.max)))
    				end
                elseif button.keybind then
                    if input.keybinding then
                        if input.keybind then
                            if (input.keybind == Keyboard.KEY_ESCAPE or input.keybind == Keyboard.KEY_BACKSPACE) and button.setting ~= -1 then
                                input.keybind = -1
                            end

                            button.setting = input.keybind
                            dssmod.setOption(button.variable, button.setting, button, directorykey.Item, directorykey)
                            input.keybinding = nil
                            button.keybinding = nil
                        end
                    elseif input.confirm then
                        button.keybinding = true
                        input.keybinding = true
                    end
    			end
    		end
    	end

    	--pages
		if pages and pages > 0 then
			item.psel = math.min((item.psel or 1), pages)
			if input.left then
				item.psel = ((item.psel - 2) % pages) + 1
			elseif input.right then
				item.psel = (item.psel % pages) + 1
			end
			psel = item.psel
		end

        --BUTTON FUNCTIONS
        if func then
            func(button, directorykey.Item)
        end

        if changefunc then
            changefunc(prevbutton, directorykey.Item)
        end

    	--drawing
    	if draw then
            local drawings = dssmod.generateMenuDraw(item, scenter, input, "main", tbl)

            local tooltip = item.tooltip
            if button and button.tooltip then
                tooltip = button.tooltip
            end

            if tooltip then
                local drawings2 = dssmod.generateMenuDraw(tooltip, scenter, input, "tooltip")
                for _, drawing in ipairs(drawings2) do
                    drawings[#drawings + 1] = drawing
                end
            end

    		--draw
    		for i, drawing in ipairs(drawings) do
    			dssmod.drawMenu(tbl, drawing)
    		end
    	end

        --menu regressing
		if string.len(enteredCode) == 0 then
			if (input.back or input.toggle) and not itemswitched then
				if #directorykey.Path > 0 then
					directorykey.Item = directorykey.Path[#directorykey.Path]
					directorykey.Path[#directorykey.Path] = nil
				elseif not directorykey.PreventClosing then
					dssmenu.CloseMenu()
				end
			end
		end

        --BUTTON ACTIONS
        if action then
            if action == 'resume' then
                dssmenu.CloseMenu(true)
            elseif action == "openmenu" then
                dssmenu.OpenMenu(button.menu)
            end
        end
    end

    --border
    --menuspr[4]:Render(root1, Vector(0, 0), Vector(0, 0))
    --menuspr[4]:Update()

    --fade mask
    if directorykey.Idle and directorykey.MaskAlpha > 0 then
        local useclr = menupal[1]
        menumask.Color = Color(useclr.R, useclr.G, useclr.B, directorykey.MaskAlpha, 0, 0, 0)
        menumask:Play("Idle", true)
        menumask:Render(root1, Vector(0, 0), Vector(0, 0))
    end
end

function dssmod.checkMenu()
    if not menuinput then
        return false
    end

	local input = menuinput.menu
	if not input then
		return false
	end

    local dssmenu = DeadSeaScrollsMenu
    if input.toggle and not dssmenu.IsOpen() then
        if dssmenu.IsMenuSafe() then
            if dssmenu.MenuCount <= 2 then
                for k, menu in pairs(dssmenu.Menus) do -- this is non-specific to simplify copying, less to swap
                    if k ~= "Menu" then
                        dssmenu.OpenMenu(k)
                    end
                end
            else
                dssmenu.OpenMenu("Menu")
            end
        else
            sfx:Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, .75, 0, false, 1.5)
        end
    end

    if dssmenu.OpenedMenu then
        if dssmenu.ExitingMenu and not dssmenu.OpenedMenu.Exiting then
            dssmenu.ExitingMenu = nil
            dssmenu.OpenedMenu = nil
        else
            dssmenu.OpenedMenu.Run(dssmenu.OpenedMenu)
        end
    else
        dssmenu.ExitingMenu = nil
    end
end

-- MOD-SPECIFIC VERSION OF CORE HANDLING STARTS HERE
local HiddenDescs = false
function dssmod.openMenu(tbl, openedFromNothing)
    if openedFromNothing then
        tbl.DirectoryKey.OpenAnimation = true
    end

    tbl.DirectoryKey.PreviousItem = nil

    for k, item in pairs(tbl.Directory) do
        if item.buttons then
            for _, button in ipairs(item.buttons) do
                if button.load then
                    local setting = button.load(button, item, tbl)
                    button.setting = setting
                    if button.variable then
                        tbl.DirectoryKey.Settings[button.variable] = setting
                    end
                end
            end
        end
    end
	
	if EID then
		HiddenDescs = EID.isHidden
		EID.isHidden = true
	end
end

function dssmod.closeMenu(tbl, fullClose, noAnimate)
    if fullClose and not noAnimate then
        tbl.Exiting = true
        tbl.DirectoryKey.CloseAnimation = true
    end

    tbl.DirectoryKey.Path = {}
    tbl.DirectoryKey.Main = 'main'
    tbl.DirectoryKey.PreventClosing = false
    tbl.DirectoryKey.Item = tbl.Directory[tbl.DirectoryKey.Main]

    if tbl.DirectoryKey.SettingsChanged then
        tbl.DirectoryKey.SettingsChanged = false
        for k, item in pairs(tbl.Directory) do
            if item.buttons then
                for _, button in ipairs(item.buttons) do
                    if button.store and button.variable then
                        button.store(tbl.DirectoryKey.Settings[button.variable] or button.setting, button, item, tbl)
                    end
                end
            end
        end
    end
	
	-- Unpausing the game.
	freezeGame(true)
	if EID then EID.isHidden = HiddenDescs end
end

--POST RENDER
local function isMenuCore()
    return DeadSeaScrollsMenu.CoreMod == "Pudding and Wakaba"
end

local displayedDSSMenuMsg = false

function dssmod:post_render()
    local dssmenu = DeadSeaScrollsMenu
    local isCore = isMenuCore()
    if isCore or dssmenu.IsOpen() then
        dssmod.getInput(0)
    end

    if not isCore and dssmenu then -- If not in control of certain settings, be sure to store them!
        save.dss_menu.HudOffset = dssmenu.GetHudOffsetSetting()
    end
	
	if displayedDSSMenuMsg == false then displayedDSSMenuMsg = 120 end
	
	if isCore and displayedDSSMenuMsg ~= true then
		if type(displayedDSSMenuMsg) ~= "number" then return end
		
		if displayedDSSMenuMsg <= 0 then
			displayedDSSMenuMsg = true
		else
			local RenderPos = getScreenBottomRight()
			local str = "Press [C] or both Joysticks to open DSS Menu."
			local strColor = KColor(1, 1, 0, (math.min(displayedDSSMenuMsg, 60)/60) * 0.5)
			
			g.TempestaFont:DrawString(str, (RenderPos.X / 2) - (g.TempestaFont:GetStringWidthUTF8(str) / 2), RenderPos.Y - 42, strColor, 0, true)
			
			if (not game:IsPaused())
			and game:GetRoom():GetFrameCount() > 0
			and Isaac.GetFrameCount() % 2 == 0
			then
				displayedDSSMenuMsg = displayedDSSMenuMsg - 1
			end
		end
	end
end
dssmod:AddCallback(ModCallbacks.MC_POST_RENDER, dssmod.post_render)

local dssCoreIncluded = 1
if not dssmenu or (dssmenu.CoreVersion < dssCoreIncluded) then
    if dssmenu then
        dssmenu.RemoveCallbacks()
    else
        dssmenu = {Menus = {}}
    end

    dssmenu.CoreVersion = dssCoreIncluded
    dssmenu.CoreMod = "Pudding and Wakaba"
    DeadSeaScrollsMenu = dssmenu
end

-- These buttons will be included in this mod's menu if it is the only active menu, or in the global menu if it exists and this mod is managing it
local function sharedButtonDisplayCondition(button, item, tbl)
    return tbl.Name == "Menu" or DeadSeaScrollsMenu.MenuCount <= 2
end

local hudOffsetButton = {
    str = 'hud offset',
    increment = 1, max = 10,
    variable = "HudOffset",
    slider = true,
    setting = 0,
    load = function() -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        return save.dss_menu.HudOffset or 0
    end,
    store = function(var) -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        save.dss_menu.HudOffset = var
    end,
    displayif = sharedButtonDisplayCondition,
    tooltip = {strset = {'be sure to', 'match the', 'setting', 'in the', 'pause menu'}}
}

local gamepadToggleButton = {
    str = 'gamepad toggle',
    choices = {'either stick', 'left stick', 'right stick', 'both sticks', '[select]', '[rt] + [select]'},
    variable = 'ControllerToggle',
    tooltip = {strset = {'to open', 'and close', 'this menu with', 'a controller','','[f1] always', 'works'}},
    setting = 1,
    load = function() -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        return save.dss_menu.MenuControllerToggle or 1
    end,
    store = function(var) -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        save.dss_menu.MenuControllerToggle = var
    end,
    displayif = sharedButtonDisplayCondition
}

local paletteButton = {
    str = 'menu palette',
    variant = "MenuPalette",
    setting = 1,
    load = function() -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        return save.dss_menu.MenuPalette or 1
    end,
    store = function(var) -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        save.dss_menu.MenuPalette = var
    end,
    changefunc = function(button) -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        save.dss_menu.MenuPalette = button.setting
    end,
    displayif = sharedButtonDisplayCondition,
    generate = function(button, item, tbl)
        local dssmenu = DeadSeaScrollsMenu
        if not button.generated or button.generated ~= #dssmenu.Palettes then
            button.setting = math.min(button.setting, #dssmenu.Palettes)
            button.generated = #dssmenu.Palettes
            button.choices = {}
            for _, palette in ipairs(dssmenu.Palettes) do
                button.choices[#button.choices + 1] = palette.Name
            end
        end
    end
}

local menuOpenToolTip = {strset = {'toggle menu', '', 'keyboard:', '[c] or [f1]', '','controller:', 'press analog'}, fsize = 2}
if isMenuCore() then
    if not dssmenu.Palettes then
        dssmenu.Palettes = {}
    end

    if not dssmenu.ExistingPalettes then
        dssmenu.ExistingPalettes = {}
    end

    if not dssmenu.Menus then
        dssmenu.Menus = {}
    end

    function dssmenu.AddPalettes(palettes)
        for _, palette in ipairs(palettes) do
            if not dssmenu.ExistingPalettes[palette.Name] then
                dssmenu.ExistingPalettes[palette.Name] = true

                for i, color in ipairs(palette) do
                    palette[i] = Color(color[1] / 255, color[2] / 255, color[3] / 255, 1, 0, 0, 0)
                end

                dssmenu.Palettes[#dssmenu.Palettes + 1] = palette
            end
        end
    end

    dssmenu.AddPalettes({
        {
            Name = "classic",
            {199, 178, 154}, -- Back
            {54, 47, 45}, -- Text
            {94, 57, 61}, -- Highlight Text
        },
        {
            Name = "soy milk",
            {255, 237, 206},
            {134, 109, 103},
            {73, 56, 67},
        },
        {
            Name = "phd",
            {224, 208, 208},
            {84, 43, 39},
            {118, 66, 72},
        },
        {
            Name = "faded polaroid",
            {219, 199, 188},
            {111, 81, 63},
            {86, 29, 37},
        },
        {
            Name = "missing page 2",
            {178, 112, 110},
            {40, 0, 0},
            {63, 13, 18},
        },
        {
            Name = "???",
            {77, 98, 139},
            {29, 36, 52},
            {156, 200, 205},
        },
        {
            Name = "succubus",
            {51, 51, 51},
            {12, 12, 12},
            {81, 10, 22},
        },
        {
            Name = "birthright",
            {214, 186, 155},
            {38, 30, 22},
            {112, 7, 0},
        },
        {
            Name = "impish",
            {170, 142, 214},
            {47, 34, 68},
            {56, 3, 6},
        },
        {
            Name = "queasy",
            {87, 125, 73},
            {32, 38, 28},
            {56, 55, 23},
        },
        {
            Name = "fruitcake",
            Rainbow = true,
            {243, 226, 226},
            {54, 47, 45},
            {64, 57, 50},
        },
        {
            Name = "delirious",
            {255, 255, 255},
            {254, 240, 53},
            {139, 104, 104},
        },
        {
            Name = "searing",
            {255, 255, 255},
            {117, 120, 125},
            {114, 137, 218},
        },
    })

    function dssmenu.GetPalette() -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        if dssmenu.Palettes[save.dss_menu.MenuPalette or 1] then
            return dssmenu.Palettes[save.dss_menu.MenuPalette or 1]
        else
            return dssmenu.Palettes[1]
        end
    end

    function dssmenu.GetHudOffsetSetting() -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        return save.dss_menu.HudOffset or 0
    end

    function dssmenu.GetGamepadToggleSetting() -- SWAP SAVE DATA FUNCS WHEN INCLUDING MENU IN ANOTHER MOD
        return save.dss_menu.MenuControllerToggle or 1
    end

    function dssmenu.GetDefaultMenuSprites()
        if not dssmenu.MenuSprites then
            dssmenu.MenuSprites = {
                Shadow = Sprite(),
                Back = Sprite(),
                Face = Sprite(),
                Mask = Sprite(),
                Border = Sprite(),
                Font = Sprite()
            }

            dssmenu.MenuSprites.Back:Load("gfx/ui/deadseascrolls/menu_back.anm2", true)
            dssmenu.MenuSprites.Face:Load("gfx/ui/deadseascrolls/menu_face.anm2", true)
            dssmenu.MenuSprites.Mask:Load("gfx/ui/deadseascrolls/menu_mask.anm2", true)
            dssmenu.MenuSprites.Border:Load("gfx/ui/deadseascrolls/menu_border.anm2", true)
            dssmenu.MenuSprites.Font:Load("gfx/ui/deadseascrolls/menu_font.anm2", true)
            dssmenu.MenuSprites.Shadow:Load("gfx/ui/deadseascrolls/menu_shadow.anm2", true)
        end

        return dssmenu.MenuSprites
    end

    function dssmenu.IsMenuSafe()
		if ModConfigMenu and ModConfigMenu.Visible then return false end
	
        local roomHasDanger = false
    	for _, entity in pairs(Isaac.GetRoomEntities()) do
    		if ((entity:IsActiveEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY)) and entity:IsVulnerableEnemy()) -- Extra check to not cuck the menu at random.
    		or entity.Type == EntityType.ENTITY_PROJECTILE
    		or entity.Type == EntityType.ENTITY_BOMBDROP then
    			roomHasDanger = true
    			break
    		end
    	end

    	if game:GetRoom():IsClear() and not roomHasDanger then
    		return true
    	end

    	return false
    end

    local dssdirectory = {
        main = {
            title = 'dead sea scrolls',
            buttons = {
                {str = 'resume game', action = 'resume'},
                {str = 'menu settings', dest = 'menusettings'}
            },
            tooltip = menuOpenToolTip
        },
        menusettings = {
            title = 'menu settings',
            buttons = {
                hudOffsetButton,
                gamepadToggleButton,
                paletteButton
            },
            tooltip = menuOpenToolTip
        }
    }
    local dssdirectorykey = {
    	Item = dssdirectory.main,
        Main = 'main',
    	Idle = false,
    	MaskAlpha = 1,
        Settings = {},
        SettingsChanged = false,
    	Path = {},
    }

    function dssmenu.AddMenu(name, tbl)
        tbl.Name = name
        if not dssmenu.Menus[name] then
            dssmenu.MenuCount = (dssmenu.MenuCount or 0) + 1

            if name ~= "Menu" then
                dssdirectory.main.buttons[#dssdirectory.main.buttons + 1] = {str = name, action = "openmenu", menu = name}
            end
        end

        dssmenu.Menus[name] = tbl
    end

    if dssmenu.Menus then
        for k, v in pairs(dssmenu.Menus) do
            if k ~= "Menu" then
                dssdirectory.main.buttons[#dssdirectory.main.buttons + 1] = {str = k, action = "openmenu", menu = k}
            end
        end
    end

    local openCalledRecently
    function dssmenu.OpenMenu(name)
        openCalledRecently = true

        local openFromNothing = not dssmenu.OpenedMenu
        if not openFromNothing then
            if dssmenu.OpenedMenu.Close then
                dssmenu.OpenedMenu.Close(dssmenu.OpenedMenu, false, true, true)
            end
        end

        dssmenu.OpenedMenu = dssmenu.Menus[name]

        if dssmenu.OpenedMenu.Open then
            dssmenu.OpenedMenu.Open(dssmenu.OpenedMenu, openFromNothing)
        end
    end

    function dssmenu.CloseMenu(fullClose, noAnimate)
        local shouldFullClose = fullClose or dssmenu.MenuCount <= 2 or dssmenu.OpenedMenu.Name == "Menu"
        if dssmenu.OpenedMenu and dssmenu.OpenedMenu.Close then
            dssmenu.OpenedMenu.Close(dssmenu.OpenedMenu, shouldFullClose, noAnimate)
        end

        if not shouldFullClose and dssmenu.OpenedMenu and dssmenu.OpenedMenu.Name ~= "Menu" then
            dssmenu.OpenMenu("Menu")
        elseif dssmenu.OpenedMenu then
            if noAnimate or not dssmenu.OpenedMenu.Exiting then -- support for animating menus out
                dssmenu.OpenedMenu = nil
            else
                dssmenu.ExitingMenu = true
            end
        end
    end

    function dssmenu.IsOpen()
        return dssmenu.OpenedMenu and not dssmenu.OpenedMenu.Exiting
    end

    function dssmod:DisablePlayerControlsInMenu(player)
        local open = dssmenu.IsOpen()
        if open and player.ControlsEnabled then
            player:GetData().MenuDisabledControls = true
            player.ControlsEnabled = false
        elseif not open and player:GetData().MenuDisabledControls then
            player:GetData().MenuDisabledControls = nil
            player.ControlsEnabled = true
        end
    end

    dssmod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, dssmod.DisablePlayerControlsInMenu)

    function dssmod:CheckMenuOpen()
        openCalledRecently = false
        dssmod.checkMenu()
    end

    dssmod:AddCallback(ModCallbacks.MC_POST_RENDER, dssmod.CheckMenuOpen)

    function dssmod:CloseMenuOnGameStart()
        if not openCalledRecently and dssmenu.IsOpen() then
            dssmenu.CloseMenu(true, true)
        end
    end

    dssmod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, dssmod.CloseMenuOnGameStart)

    function dssmenu.RemoveCallbacks()
        dssmod:RemoveCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, dssmod.DisablePlayerControlsInMenu)
        dssmod:RemoveCallback(ModCallbacks.MC_POST_RENDER, dssmod.CheckMenuOpen)
        dssmod:RemoveCallback(ModCallbacks.MC_POST_GAME_STARTED, dssmod.CloseMenuOnGameStart)
    end

    dssmenu.AddMenu("Menu", {Run = dssmod.runMenu, Open = dssmod.openMenu, Close = dssmod.closeMenu, Directory = dssdirectory, DirectoryKey = dssdirectorykey})

    DeadSeaScrollsMenu = dssmenu
end

-- Common code ends




















local menu_dir = {}
--[[ local cheatSlot = helper.RegisterSprite("gfx/ui/cheat_selector.anm2", "Slot")
local cheatSlotFace = helper.RegisterSprite("gfx/ui/cheat_selector.anm2", "Slot", 0, "gfx/ui/cheat_selector_face.png")
local cheatSlotOutline = helper.RegisterSprite("gfx/ui/cheat_selector.anm2", "Slot", 0, "gfx/ui/cheat_selector_outline.png")
local arrows = helper.RegisterSprite("gfx/ui/job_arrows.anm2", "Up", 0) ]]

local TooltipVecs = {
	RightPageOffset = Vector(132, 6),
	TextOffset = Vector(2, 0),
	TextOffsetSmall = Vector(1, 0),
	
	Vec54 = Vector(0, 54),
	Vec44 = Vector(0, 44),
	Vec42 = Vector(0, 42),
	Vec40 = Vector(0, 40),
	Vec36 = Vector(0, 36),
	Vec34 = Vector(0, 34),
	Vec32 = Vector(0, 32),
	Vec30 = Vector(0, 30),
	Vec28 = Vector(0, 28),
	Vec24 = Vector(0, 24),
	Vec22 = Vector(0, 22),
	Vec20 = Vector(0, 20),
	Vec18 = Vector(0, 18),
	Vec16 = Vector(0, 16),
	Vec15 = Vector(0, 15),
	Vec12 = Vector(0, 12),
	Vec9 = Vector(0, 9),
	Vec8 = Vector(0, 8),
	Vec4 = Vector(0, 4),
	
	Vec10X = Vector(10, 0),
	Vec20X = Vector(20, 0),
	Vec24X = Vector(24, 0),
	Vec26X = Vector(26, 0),
	Vec36X = Vector(36, 0),
	Vec45X = Vector(45, 0),
	Vec48X = Vector(48, 0),
}

local enabledInputCallback = false
local function inputHandler(_, player, hook, action)
	if not enabledInputCallback then return end

	if action == ButtonAction.ACTION_MENUBACK
	or action == ButtonAction.ACTION_PAUSE
	or action == ButtonAction.ACTION_RESTART
	or action == ButtonAction.ACTION_FULLSCREEN
	or action == ButtonAction.ACTION_MUTE then
		return false
	end
end
dssmod:AddCallback(ModCallbacks.MC_INPUT_ACTION, inputHandler, InputHook.IS_ACTION_TRIGGERED)

local ValidKeys = {
	[Keyboard.KEY_0] = "0",
	[Keyboard.KEY_1] = "1",
	[Keyboard.KEY_2] = "2",
	[Keyboard.KEY_3] = "3",
	[Keyboard.KEY_4] = "4",
	[Keyboard.KEY_5] = "s",
	[Keyboard.KEY_6] = "6",
	[Keyboard.KEY_7] = "7",
	[Keyboard.KEY_8] = "8",
	[Keyboard.KEY_9] = "9",
	[Keyboard.KEY_A] = "a",
	[Keyboard.KEY_B] = "b",
	[Keyboard.KEY_C] = "c",
	[Keyboard.KEY_D] = "d",
	[Keyboard.KEY_E] = "e",
	[Keyboard.KEY_F] = "f",
	[Keyboard.KEY_G] = "g",
	[Keyboard.KEY_H] = "h",
	[Keyboard.KEY_I] = "1",
	[Keyboard.KEY_J] = "j",
	[Keyboard.KEY_K] = "k",
	[Keyboard.KEY_L] = "l",
	[Keyboard.KEY_M] = "m",
	[Keyboard.KEY_N] = "n",
	[Keyboard.KEY_O] = "0",
	[Keyboard.KEY_P] = "p",
	[Keyboard.KEY_Q] = "q",
	[Keyboard.KEY_R] = "r",
	[Keyboard.KEY_S] = "s",
	[Keyboard.KEY_T] = "t",
	[Keyboard.KEY_U] = "v",
	[Keyboard.KEY_V] = "v",
	[Keyboard.KEY_W] = "w",
	[Keyboard.KEY_X] = "x",
	[Keyboard.KEY_Y] = "y",
	[Keyboard.KEY_Z] = "z",
	[Keyboard.KEY_KP_0] = "0",
	[Keyboard.KEY_KP_1] = "1",
	[Keyboard.KEY_KP_2] = "2",
	[Keyboard.KEY_KP_3] = "3",
	[Keyboard.KEY_KP_4] = "4",
	[Keyboard.KEY_KP_5] = "s",
	[Keyboard.KEY_KP_6] = "6",
	[Keyboard.KEY_KP_7] = "7",
	[Keyboard.KEY_KP_8] = "8",
	[Keyboard.KEY_KP_9] = "9",
}

local extraData = {
	main = {
		slot = 1,
		scroll = 1,
	},
	tainted = {
		slot = 1,
		scroll = 1,
	},
}

local objData = {
	main = {
		slot = 1,
		scroll = 1,
	},
	tainted = {
		slot = 1,
		scroll = 1,
	},
}

local randomData = {
	main = {
		slot = 1,
		scroll = 1,
	},
	tainted = {
		slot = 1,
		scroll = 1,
	},
}

local navTimer = 0

local function fitTextToWidth(str, fsize, textboxWidth)
    local formatedLines = {}
    local curLength = 0
    local text = ""
	
    for word in string.gmatch(str, "([^%s]+)") do
        local wordLength = getMenuStringLength(word, fsize)

        if curLength + wordLength <= textboxWidth or curLength < 12 then
            text = text .. word .. " "
            curLength = curLength + wordLength
        else
            table.insert(formatedLines, text)
            text = word .. " "
            curLength = wordLength
        end
    end
    table.insert(formatedLines, text)
    return formatedLines
end

local function useCheatInput()
	local CenterV = getScreenCenterPosition()
	local TargetV = CenterV + TooltipVecs.RightPageOffset
	local paused = game:IsPaused()
	local cheatLen = string.len(enteredCode)
	
	dssmod.renderText({str = "Use your keyboard to", size = 2, pos = g.ZeroV - TooltipVecs.Vec36 - TooltipVecs.Vec45X})
	dssmod.renderText({str = "type in a cheat code", size = 2, pos = g.ZeroV - TooltipVecs.Vec24 - TooltipVecs.Vec45X})
	dssmod.renderText({str = "Press Enter to submit", size = 2, pos = g.ZeroV - TooltipVecs.Vec45X})
	
	dssmod.renderText({str = string.sub(enteredCode, 1, 8), halign = -1, size = 3, palcolor = 3, pos = TooltipVecs.Vec32})
	dssmod.renderText({str = string.sub(enteredCode, 9, 16), halign = -1, size = 3, palcolor = 3, pos = TooltipVecs.Vec54})
	dssmod.renderText({str = "- - - -", halign = -1, size = 3, pos = TooltipVecs.Vec32 + TooltipVecs.Vec8})
	dssmod.renderText({str = "- - - -", halign = -1, size = 3, pos = TooltipVecs.Vec54 + TooltipVecs.Vec8})
	
	if paused then return end
	
	for key, chr in pairs(ValidKeys) do
		if Input.IsButtonTriggered(key, 0)
		and cheatLen < 16
		then
			Isaac.GetPlayer(0):GetData().LastResetPress = 0
			enteredCode = enteredCode .. chr .. " "
		end
	end
	
	if Input.IsButtonPressed(Keyboard.KEY_BACKSPACE, 0) then
		if BackspaceTimer == -14 or (BackspaceTimer > 0 and BackspaceTimer % 5 == 0) then
			enteredCode = string.sub(enteredCode, 1, cheatLen - 2)
		end
		BackspaceTimer = BackspaceTimer + 1
	else
		BackspaceTimer = -15
	end
	
	if Input.IsButtonTriggered(Keyboard.KEY_ENTER, 0) then
		local code = string.upper(enteredCode)
		local tab = cheats.Codes[code]
		
		if tab then
			local Target = "PlayerJob" .. (tab.Tainted and "_B" or "")
			
			if tab.Type == "GreedMode" then
				if not tab.Tainted then
					CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/job achievements/" .. enums.AchievementGraphics[Target].GreedMode .. ".png")
				end
				CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/job achievements/" .. enums.AchievementGraphics[Target].Greedier .. ".png")
			else
				CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/job achievements/" .. enums.AchievementGraphics[Target][tab.Type] .. ".png")
			end
			
			if not tab.Tainted then
				if tab.Type == "Satan" then
					CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/job achievements/achievement.whack_a_mole.png")
				elseif tab.Type == "Tainted" then
					CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/job achievements/achievement.haunted.png")
				end
			end
			
			if type(save.UnlockData[Target][tab.Type]) == "table" then
				save.UnlockData[Target][tab.Type].Unlock = true
				save.UnlockData[Target][tab.Type].Hard = true
			else
				save.UnlockData[Target][tab.Type] = true
				
				if tab.Type == "PolNegPath" then
					save.UnlockData[Target].Isaac.Unlock = true
					save.UnlockData[Target].Isaac.Hard = true
					save.UnlockData[Target].Satan.Unlock = true
					save.UnlockData[Target].Satan.Hard = true
					save.UnlockData[Target].BlueBaby.Unlock = true
					save.UnlockData[Target].BlueBaby.Hard = true
					save.UnlockData[Target].Lamb.Unlock = true
					save.UnlockData[Target].Lamb.Hard = true
				elseif tab.Type == "SoulPath" then
					save.UnlockData[Target].BossRush.Unlock = true
					save.UnlockData[Target].BossRush.Hard = true
					save.UnlockData[Target].Hush.Unlock = true
					save.UnlockData[Target].Hush.Hard = true
				end
			end
			
			enabledInputCallback = false
		elseif code == "D 1 C K B A L L " then
			CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/job achievements/achievement.you_dingus.png", 120)
			g.sound:Play(SoundEffect.SOUND_DERP, 1, 0, false, 1)
		elseif code == "G V L L 1 B L E " then
			CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/job achievements/achievement.absolute_buffon.png", 180)
			g.sound:Play(SoundEffect.SOUND_HAPPY_RAINBOW, 1, 0, false, 1)
		else
			g.sound:Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
		end
		
		enteredCode = ""
	end
end

local function rendeExtraTooltip(item, locked)
	local TargetV = TooltipVecs.RightPageOffset + Vector(0, -56)
	local CenterV = getScreenCenterPosition()
	local Offset = 0
	local DescTab = item.Desc and fitTextToWidth(locked and "???" or item.Desc, 1, 92)
	
	if item.Desc then
		Offset = Offset + ((#DescTab - 1) * 9)
	end
	
	-- Render
	Offset = math.max(0, (95 - Offset) / 2)
	TargetV = TargetV + Vector(0, Offset)
	
	if item.Desc then
		for i, text in ipairs(DescTab) do
			dssmod.renderText({str = text, size = locked and 3 or 1, pos = TargetV + TooltipVecs.TextOffsetSmall})
			
			if i < #DescTab then
				TargetV = TargetV + TooltipVecs.Vec9
			end
		end
	end
end
--[[ 
local function updateBSideJob(disable)
	if not disable then
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job then
				player:TryRemoveNullCostume(costumes.Job)
				player:AddNullCostume(costumes.Job_2)
				
				player:RemoveCollectible(items.BookofDespair)
				player:SetPocketActiveItem(items.BookofWisdom, ActiveSlot.SLOT_POCKET, false)
			end
		end
		
		if Poglite then
			Poglite:AddPogCostume("JobPog", players.Job, costumes.JobPog_2, costumes.Job_2)
		end
	else
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job then
				player:TryRemoveNullCostume(costumes.Job_2)
				player:AddNullCostume(costumes.Job)
				
				player:RemoveCollectible(items.BookofWisdom)
				player:RemoveCollectible(items.BookofWisdomOn)
				player:RemoveCollectible(items.BookofWisdomLock)
				g.ItemPool:RemoveCollectible(items.BookofDespair)
				
				if not save.extras.main.PocketBook.Active then
					player:AddCollectible(items.BookofDespair, 3)
				else
					player:SetPocketActiveItem(items.BookofDespair, ActiveSlot.SLOT_POCKET, false)
				end
			end
		end
		
		if Poglite then
			Poglite:AddPogCostume("JobPog", players.Job, costumes.JobPog, costumes.Job)
		end
	end
end

local function updateBirthrightJob(disable)
	if not disable then
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job then
				player:AddCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			end
		end
	else
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job then
				player:RemoveCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			end
		end
	end
end

local function updateJobPocketBook(disable)
	if not disable then
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job
			and not save.extras.main.BSide.Active
			then
				player:RemoveCollectible(items.BookofDespair, 3)
				player:SetPocketActiveItem(items.BookofDespair, ActiveSlot.SLOT_POCKET, false)
			end
		end
	else
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job
			and not save.extras.main.BSide.Active
			then
				player:RemoveCollectible(items.BookofDespair, 3)
				player:AddCollectible(items.BookofDespair, 3)
			end
		end
	end
end

local function updateBSideTaintedJob(disable)
	if not disable then
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job_B then
				player:TryRemoveNullCostume(costumes.Job_B)
				player:TryRemoveNullCostume(costumes.Job_B2)
				
				player:RemoveCollectible(items.DeusCustodia)
				player:SetPocketActiveItem(items.SanctiPoenas, ActiveSlot.SLOT_POCKET, false)
				
			end
		end
		
		if Poglite then
			Poglite:AddPogCostume("JobPog_B", players.Job_B, costumes.JobPog_B, costumes.Job_B)
		end
	else
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job_B then
				player:AddNullCostume(costumes.Job_B)
				player:AddNullCostume(costumes.Job_B2)
				
				g.ItemPool:RemoveCollectible(items.SanctiPoenas)
				player:SetPocketActiveItem(items.DeusCustodia, ActiveSlot.SLOT_POCKET, false)
			end
		end
		
		if Poglite then
			Poglite:AddPogCostume("JobPog_B", players.Job_B, costumes.JobPog_B)
		end
	end
end

local function updateBirthrightTaintedJob(disable)
	if not disable then
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job_B then
				player:AddCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			end
		end
	else
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
		
			if player:GetPlayerType() == players.Job_B then
				player:RemoveCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			end
		end
	end
end
 ]]
--[[  
local function useExtrasMenu(tainted)
	local CenterV = getScreenCenterPosition()
	local TooltipV = CenterV + TooltipVecs.RightPageOffset
	local BoxV = CenterV + TooltipVecs.Vec36X - TooltipVecs.Vec40
	local paused = game:IsPaused()
	local target = (tainted and "tainted" or "main")
	local navData = extraData[target]
	local data = save.extras[target]
	local points = save.extras.points
	local extras = cheats.Extras[target]
	local menupal = dssmenu.GetPalette()
	cheatSlot.Color = menupal[1]
    cheatSlotOutline.Color = menupal[3]
	cheatSlotFace.Color = menupal[1]
	
	navData.slot = math.min(navData.slot, #extras)
	navData.scroll = math.min(navData.scroll, #extras - 4)
	
	local ArrowDown = navData.scroll + 4 < #extras
	local ArrowUp = navData.scroll > 1
	if ArrowDown and ArrowUp then
		arrows:Play("Both", false)
	elseif ArrowDown then
		arrows:Play("Down", false)
	elseif ArrowUp then
		arrows:Play("Up", false)
	else
		arrows:Play("None", false)
	end
	arrows:Update()
	arrows:Render(CenterV + Vector(-42, 10), g.ZeroV, g.ZeroV)
	
	local mainV = g.ZeroV - TooltipVecs.Vec48X - TooltipVecs.Vec42
	local subV = g.ZeroV - TooltipVecs.Vec48X - TooltipVecs.Vec32
	local Offset = TooltipVecs.Vec24
	local currentEntry
	
	dssmod.renderText({str = "Total Points: " .. points, halign = 1, size = 2, palcolor = 3, pos = mainV + TooltipVecs.Vec4 + TooltipVecs.Vec10X})
		
	local canEnableExtras = false
	
	if g.game:GetLevel():GetStage() == LevelStage.STAGE1_1
	and g.game:GetLevel():GetCurrentRoomIndex() == 84
	and g.game:GetRoom():IsFirstVisit()
	then
		canEnableExtras = true
	end
		
	for i = navData.scroll, math.min(#extras, navData.scroll + 4) do
		local locked = false
		local entry = extras[i]
		dssmod.renderText({str = entry.Name, halign = -1, size = 2, pos = mainV + Offset})
		
		if not data[entry.Title].Owned then
			dssmod.renderText({str = "Cost: " .. entry.Cost .. " points", halign = -1, size = 1, palcolor = 3, pos = subV + Offset})
		end
		
		if data[entry.Title].Owned then
			if data[entry.Title].Enabled then
				cheatSlot:Play("Enabled", true)
				cheatSlotFace:Play("Enabled", true)
				cheatSlotOutline:Play("Enabled", true)
			else
				cheatSlot:Play("Slot", true)
				cheatSlotFace:Play("Slot", true)
				cheatSlotOutline:Play("Slot", true)
			end
		else
			locked = true
			cheatSlot:Play("Locked", true)
			cheatSlotFace:Play("Locked", true)
			cheatSlotOutline:Play("Locked", true)
		end
		
		if data[entry.Title].Enabled == data[entry.Title].Active then
			cheatSlot.Color = menupal[1]
			cheatSlotFace.Color = menupal[1]
		else
			cheatSlot.Color = Color(menupal[3].R, menupal[3].G, menupal[3].B, 0.5)
			cheatSlotFace.Color = Color(menupal[3].R, menupal[3].G, menupal[3].B, 0.5)
		end
		
		cheatSlot:Render(BoxV + Offset, g.ZeroV, g.ZeroV)
		cheatSlotFace:Render(BoxV + Offset, g.ZeroV, g.ZeroV)
		
		if i == navData.slot then
			cheatSlotOutline:Render(BoxV + Offset, g.ZeroV, g.ZeroV)
			currentEntry = entry
			
			rendeExtraTooltip(entry, locked)
		end
		
		Offset = Offset + TooltipVecs.Vec24
	end
	
	if paused then return end
	
	local input = menuinput.menu
	if navTimer > 0 then
		if menuinput.raw.down <= 0
		and menuinput.raw.up <= 0
		then
			navTimer = 0
		else
			navTimer = navTimer - 1
		end
	end
	
	if input.down and navTimer <= 0 then
		if navData.slot < #extras then
			navData.slot = navData.slot + 1
			
			if navData.slot == #extras then
				navTimer = 30
			end
		else
			navData.slot = 1
			navData.scroll = 1
		end
		
		if navData.slot - 4 > navData.scroll then
			navData.scroll = navData.scroll + 1
		end
		
		g.sound:Play(SoundEffect.SOUND_CHARACTER_SELECT_RIGHT, 0.75, 0, false, 0.7)
	elseif input.up and navTimer <= 0 then
		if navData.slot > 1 then
			navData.slot = navData.slot - 1
			
			if navData.slot == 1 then
				navTimer = 30
			end
		else
			navData.slot = #extras
			navData.scroll = #extras - 4
		end
		
		if navData.slot < navData.scroll then
			navData.scroll = navData.scroll - 1
		end
		
		g.sound:Play(SoundEffect.SOUND_CHARACTER_SELECT_LEFT, 0.75, 0, false, 0.7)
	end
	
	if input.confirm then
		if (not data)
		or (not data[currentEntry.Title])
		then
			g.sound:Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
			return
		end
	
		if not data[currentEntry.Title].Owned then
			if points >= currentEntry.Cost then
				data[currentEntry.Title].Owned = true
				data[currentEntry.Title].Enabled = true
				
				if canEnableExtras then
					data[currentEntry.Title].Active = data[currentEntry.Title].Enabled
				end
				
				save.extras.points = points - currentEntry.Cost
				g.sound:Play(SoundEffect.SOUND_CASH_REGISTER, 1, 0, false, 1)
			else
				g.sound:Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
			end
		else
			data[currentEntry.Title].Enabled = not data[currentEntry.Title].Enabled
			
			if canEnableExtras then
				data[currentEntry.Title].Active = data[currentEntry.Title].Enabled
				
				if target == "main" then
					if currentEntry.Title == "BSide" then
						if data[currentEntry.Title].Active then
							updateBSideJob()
						else
							updateBSideJob(true)
						end
					elseif currentEntry.Title == "Birthright" then
						if data[currentEntry.Title].Active then
							updateBirthrightJob()
						else
							updateBirthrightJob(true)
						end
					elseif currentEntry.Title == "PocketBook" then
						if data[currentEntry.Title].Active then
							updateJobPocketBook()
						else
							updateJobPocketBook(true)
						end
					end
				else
					if currentEntry.Title == "BSide" then
						if data[currentEntry.Title].Active then
							updateBSideTaintedJob()
						else
							updateBSideTaintedJob(true)
						end
					elseif currentEntry.Title == "Birthright" then
						if data[currentEntry.Title].Active then
							updateBirthrightTaintedJob()
						else
							updateBirthrightTaintedJob(true)
						end
					end
				end
			end
			
			g.sound:Play(SoundEffect.SOUND_PLOP, 1, 0, false, 1)
		end
		
		eid.UpdateEIDDescs()
		encyclopedia.UpdateEncyclopediaDescs()
	end
end

local function eitherExtrasUnlocked()
	return save.UnlockData.PlayerJob.FullCompletion.Unlock or save.UnlockData.PlayerJob_B.FullCompletion.Unlock
end
local function jobExtrasUnlocked()
	return save.UnlockData.PlayerJob.FullCompletion.Unlock
end
local function tJobExtrasUnlocked()
	return save.UnlockData.PlayerJob_B.FullCompletion.Unlock
end
local function bothExtrasUnlocked()
	return save.UnlockData.PlayerJob.FullCompletion.Unlock and save.UnlockData.PlayerJob_B.FullCompletion.Unlock
end

local function updateExtras()
	if not eitherExtrasUnlocked() then
		dssmod.renderText({str = "100% either post-it to unlock.", size = 2, pos = Vector(-44, 0)})
	end
end
 ]]
local collectorStrings = {
	[tostring(ItemPoolType.POOL_TREASURE)] = "Treasure",
	[tostring(ItemPoolType.POOL_SHOP)] = "Shop",
	[tostring(ItemPoolType.POOL_BOSS)] = "Boss",
	[tostring(ItemPoolType.POOL_DEVIL)] = "Devil",
	[tostring(ItemPoolType.POOL_ANGEL)] = "Angel",
	[tostring(ItemPoolType.POOL_SECRET)] = "Secret",
	[tostring(ItemPoolType.POOL_LIBRARY)] = "Library",
	[tostring(ItemPoolType.POOL_CURSE)] = "Curse",
	[tostring(ItemPoolType.POOL_PLANETARIUM)] = "Planetarium",
}
local gluttonStrings = {
	[tostring(CollectibleType.COLLECTIBLE_LUNCH)] = "Lunch",
	[tostring(CollectibleType.COLLECTIBLE_DINNER)] = "Dinner",
	[tostring(CollectibleType.COLLECTIBLE_DESSERT)] = "Dessert",
	[tostring(CollectibleType.COLLECTIBLE_BREAKFAST)] = "Breakfast",
	[tostring(CollectibleType.COLLECTIBLE_ROTTEN_MEAT)] = "Rotten Meat",
	[tostring(CollectibleType.COLLECTIBLE_SNACK)] = "Snack",
	[tostring(CollectibleType.COLLECTIBLE_MIDNIGHT_SNACK)] = "Midn. Snack",
	[tostring(CollectibleType.COLLECTIBLE_SUPPER)] = "Supper",
}
local function useObjectivesMenu(tainted)
	local CenterV = getScreenCenterPosition()
	local TooltipV = CenterV + TooltipVecs.RightPageOffset
	local BoxV = CenterV + TooltipVecs.Vec36X - TooltipVecs.Vec36
	local paused = game:IsPaused()
	local target = (tainted and "tainted" or "main")
	local navData = objData[target]
	local data = save.objectives[target]
	local points = save.extras.points
	local objectives = cheats.Objectives[target]
	local menupal = dssmenu.GetPalette()
	cheatSlot.Color = menupal[1]
    cheatSlotFace.Color = menupal[1]
    cheatSlotOutline.Color = menupal[3]
	
	navData.slot = math.min(navData.slot, #objectives)
	navData.scroll = math.min(navData.scroll, #objectives - 3)
	
	local ArrowDown = navData.scroll + 4 < #objectives
	local ArrowUp = navData.scroll > 1
	if ArrowDown and ArrowUp then
		arrows:Play("Both", false)
	elseif ArrowDown then
		arrows:Play("Down", false)
	elseif ArrowUp then
		arrows:Play("Up", false)
	else
		arrows:Play("None", false)
	end
	arrows:Update()
	arrows:Render(CenterV + Vector(-42, 10), g.ZeroV, g.ZeroV)
	
	local mainV = g.ZeroV - TooltipVecs.Vec48X - TooltipVecs.Vec42
	local subV = g.ZeroV - TooltipVecs.Vec48X - TooltipVecs.Vec32
	local subV2 = g.ZeroV - TooltipVecs.Vec48X - TooltipVecs.Vec24
	local Offset = TooltipVecs.Vec24
	local currentEntry
	
	dssmod.renderText({str = "Total Points: " .. points, halign = 1, size = 2, palcolor = 3, pos = mainV + TooltipVecs.Vec4 + TooltipVecs.Vec10X})
		
	for i = navData.scroll, math.min(#objectives, navData.scroll + 3) do
		local entry = objectives[i]
		dssmod.renderText({str = entry.Name, halign = -1, size = 2, pos = mainV + Offset})
		
		if data[entry.Title].Finished then
			dssmod.renderText({str = "Completion: Finished!", halign = -1, size = 1, palcolor = 3, pos = subV2 + Offset - TooltipVecs.Vec4})
		else
			local progString = data[entry.Title].Progress .. " / " .. (entry.Target or 1)
			dssmod.renderText({str = "Reward: " .. entry.Reward .. " points", halign = -1, size = 1, palcolor = 3, pos = subV + Offset})
			
			if entry.Title == "TheCollector" then
				if Isaac.GetFrameCount() % 60 > 30 then
					local tObj = data.TheCollector
					local randomTab = {}
					
					for i, v in pairs(tObj.Special) do
						if v == false then
							randomTab[#randomTab + 1] = i
						end
					end
					
					local rng = RNG()
					rng:SetSeed(math.ceil(Isaac.GetFrameCount() / 60), 35)
					local targetIndex = rng:RandomInt(#randomTab) + 1
					local targetPool = collectorStrings[randomTab[targetIndex]]
					progString = progString .. " : " .. targetPool
				else
					progString = progString .. " :"
				end
			elseif entry.Title == "Glutton" then
				if Isaac.GetFrameCount() % 60 > 30 then
					local tObj = data.Glutton
					local randomTab = {}
					
					for i, v in pairs(tObj.Special) do
						if v == false then
							randomTab[#randomTab + 1] = i
						end
					end
					
					local rng = RNG()
					rng:SetSeed(math.ceil(Isaac.GetFrameCount() / 60), 35)
					local targetIndex = rng:RandomInt(#randomTab) + 1
					local targetFood = gluttonStrings[randomTab[targetIndex]]
					progString = progString .. " : " .. targetFood
				else
					progString = progString .. " :"
				end
			end
			
			dssmod.renderText({str = "Completion: " .. progString, halign = -1, size = 1, palcolor = 3, pos = subV2 + Offset})
		end
		
		
		if data[entry.Title].Finished then
			cheatSlot:Play("Enabled", true)
			cheatSlotFace:Play("Enabled", true)
			cheatSlotOutline:Play("Enabled", true)
		else
			cheatSlot:Play("Slot", true)
			cheatSlotFace:Play("Slot", true)
			cheatSlotOutline:Play("Slot", true)
		end
		
		cheatSlot:Render(BoxV + Offset, g.ZeroV, g.ZeroV)
		cheatSlotFace:Render(BoxV + Offset, g.ZeroV, g.ZeroV)
		
		if i == navData.slot then
			cheatSlotOutline:Render(BoxV + Offset, g.ZeroV, g.ZeroV)
			currentEntry = entry
			
			rendeExtraTooltip(entry)
		end
		
		Offset = Offset + TooltipVecs.Vec30
	end
	
	if paused then return end
	
	local input = menuinput.menu
	if navTimer > 0 then
		if menuinput.raw.down <= 0
		and menuinput.raw.up <= 0
		then
			navTimer = 0
		else
			navTimer = navTimer - 1
		end
	end
	
	if input.down and navTimer <= 0 then
		if navData.slot < #objectives then
			navData.slot = navData.slot + 1
			
			if navData.slot == #objectives then
				navTimer = 30
			end
		else
			navData.slot = 1
			navData.scroll = 1
		end
		
		if navData.slot - 3 > navData.scroll then
			navData.scroll = navData.scroll + 1
		end
		
		g.sound:Play(SoundEffect.SOUND_CHARACTER_SELECT_RIGHT, 0.75, 0, false, 0.7)
	elseif input.up and navTimer <= 0 then
		if navData.slot > 1 then
			navData.slot = navData.slot - 1
			
			if navData.slot == 1 then
				navTimer = 30
			end
		else
			navData.slot = #objectives
			navData.scroll = #objectives - 3
		end
		
		if navData.slot < navData.scroll then
			navData.scroll = navData.scroll - 1
		end
		
		g.sound:Play(SoundEffect.SOUND_CHARACTER_SELECT_LEFT, 0.75, 0, false, 0.7)
	end
end

local function useRandomizerMenu(tainted)
	local CenterV = getScreenCenterPosition()
	local TooltipV = CenterV + TooltipVecs.RightPageOffset
	local BoxV = CenterV + TooltipVecs.Vec36X - TooltipVecs.Vec40
	local paused = game:IsPaused()
	local target = (tainted and "tainted" or "main")
	local navData = randomData[target]
	local data = save.extras[target]
	local ogExtras = cheats.Extras[target]
	local menupal = dssmenu.GetPalette()
	cheatSlot.Color = menupal[1]
    cheatSlotOutline.Color = menupal[3]
	cheatSlotFace.Color = menupal[1]
	
	local extras = {}
	for i, extra in ipairs(ogExtras) do
		if data[extra.Title].Owned then
			extras[#extras + 1] = {
				Title = extra.Title,
				Name = extra.Name,
				Desc = "Toggle to randomize this extra at the start of the run.",
				Randomize = data[extra.Title].Randomize or false,
			}
		end
	end
	
	if #extras == 0 then
		if tainted then
			dssmod.renderText({str = "Buy any T-Job extras first.", size = 2, pos = Vector(-44, 0)})
		else
			dssmod.renderText({str = "Buy any Job extras first.", size = 2, pos = Vector(-44, 0)})
		end
		return
	end
	
	navData.slot = math.min(navData.slot, math.max(1, #extras))
	navData.scroll = math.min(navData.scroll, math.max(1, #extras - 4))
	
	local ArrowDown = navData.scroll + 4 < #extras
	local ArrowUp = navData.scroll > 1
	if ArrowDown and ArrowUp then
		arrows:Play("Both", false)
	elseif ArrowDown then
		arrows:Play("Down", false)
	elseif ArrowUp then
		arrows:Play("Up", false)
	else
		arrows:Play("None", false)
	end
	arrows:Update()
	arrows:Render(CenterV + Vector(-42, 10), g.ZeroV, g.ZeroV)
	
	local mainV = g.ZeroV - TooltipVecs.Vec48X - TooltipVecs.Vec42
	local subV = g.ZeroV - TooltipVecs.Vec48X - TooltipVecs.Vec32
	local Offset = TooltipVecs.Vec24
	local currentEntry
	
	local frmCount = (game:GetFrameCount() % 240) + 1
	local mainStr
	
	if frmCount < 110 then
		mainStr = "Tired of choosing?"
	elseif frmCount >= 120
	and frmCount < 230
	then
		mainStr = "Randomize!"
	else
		mainStr = ""
	end
	
	dssmod.renderText({str = mainStr, halign = 1, size = 2, palcolor = 3, pos = mainV + TooltipVecs.Vec4 + TooltipVecs.Vec10X})
		
	for i = navData.scroll, math.min(#extras, navData.scroll + 4) do
		local entry = extras[i]
		dssmod.renderText({str = entry.Name, halign = -1, size = 2, pos = mainV + Offset})
				
		if data[entry.Title].Randomize then
			cheatSlot:Play("Enabled", true)
			cheatSlotFace:Play("Enabled", true)
			cheatSlotOutline:Play("Enabled", true)
		else
			cheatSlot:Play("Slot", true)
			cheatSlotFace:Play("Slot", true)
			cheatSlotOutline:Play("Slot", true)
		end
		
		cheatSlot:Render(BoxV + Offset, g.ZeroV, g.ZeroV)
		cheatSlotFace:Render(BoxV + Offset, g.ZeroV, g.ZeroV)
		
		if i == navData.slot then
			cheatSlotOutline:Render(BoxV + Offset, g.ZeroV, g.ZeroV)
			currentEntry = entry
			
			rendeExtraTooltip(entry)
		end
		
		Offset = Offset + TooltipVecs.Vec24
	end
	
	if paused then return end
	
	local input = menuinput.menu
	if navTimer > 0 then
		if menuinput.raw.down <= 0
		and menuinput.raw.up <= 0
		then
			navTimer = 0
		else
			navTimer = navTimer - 1
		end
	end
	
	if input.down and navTimer <= 0 then
		if navData.slot < #extras then
			navData.slot = navData.slot + 1
			
			if navData.slot == #extras then
				navTimer = 30
			end
		else
			navData.slot = 1
			navData.scroll = 1
		end
		
		if navData.slot - 4 > navData.scroll then
			navData.scroll = navData.scroll + 1
		end
		
		g.sound:Play(SoundEffect.SOUND_CHARACTER_SELECT_RIGHT, 0.75, 0, false, 0.7)
	elseif input.up and navTimer <= 0 then
		if navData.slot > 1 then
			navData.slot = navData.slot - 1
			
			if navData.slot == 1 then
				navTimer = 30
			end
		else
			navData.slot = #extras
			navData.scroll = math.max(1, #extras - 4)
		end
		
		if navData.slot < navData.scroll then
			navData.scroll = navData.scroll - 1
		end
		
		g.sound:Play(SoundEffect.SOUND_CHARACTER_SELECT_LEFT, 0.75, 0, false, 0.7)
	end
	
	if input.confirm then
		if (not data)
		or (not data[currentEntry.Title])
		then
			g.sound:Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
			return
		end
		
		currentEntry.Randomize = not currentEntry.Randomize
		data[currentEntry.Title].Randomize = currentEntry.Randomize
		
		g.sound:Play(SoundEffect.SOUND_PLOP, 1, 0, false, 1)
	end
end


-- Post-It Note

local Offset = Vector(-27, -27)
local PostIt = helper.RegisterSprite("gfx/ui/completion_widget.anm2")
local PostIt2 = helper.RegisterSprite("gfx/ui/trophy_completion.anm2")
PostIt.PlaybackSpeed = 0
PostIt2.PlaybackSpeed = 0
local function completionRender(vOffset, Notes, Type)
	local TargetV = getScreenCenterPosition() + vOffset
	if Notes.MomsHeart.Unlock then
		if Notes.MomsHeart.Hard then
			PostIt:SetLayerFrame(1, 2)
		else
			PostIt:SetLayerFrame(1, 1)
		end
	else
		PostIt:SetLayerFrame(1, 0)
	end
	
	if Notes.Isaac.Unlock then
		if Notes.Isaac.Hard then
			PostIt:SetLayerFrame(2, 2)
		else
			PostIt:SetLayerFrame(2, 1)
		end
	else
		PostIt:SetLayerFrame(2, 0)
	end
	
	if Notes.Satan.Unlock then
		if Notes.Satan.Hard then
			PostIt:SetLayerFrame(3, 2)
		else
			PostIt:SetLayerFrame(3, 1)
		end
	else
		PostIt:SetLayerFrame(3, 0)
	end
	
	if Notes.BossRush.Unlock then
		if Notes.BossRush.Hard then
			PostIt:SetLayerFrame(4, 2)
		else
			PostIt:SetLayerFrame(4, 1)
		end
	else
		PostIt:SetLayerFrame(4, 0)
	end
	
	if Notes.BlueBaby.Unlock then
		if Notes.BlueBaby.Hard then
			PostIt:SetLayerFrame(5, 2)
		else
			PostIt:SetLayerFrame(5, 1)
		end
	else
		PostIt:SetLayerFrame(5, 0)
	end
	
	if Notes.Lamb.Unlock then
		if Notes.Lamb.Hard then
			PostIt:SetLayerFrame(6, 2)
		else
			PostIt:SetLayerFrame(6, 1)
		end
	else
		PostIt:SetLayerFrame(6, 0)
	end
	
	if Notes.MegaSatan.Unlock then
		if Notes.MegaSatan.Hard then
			PostIt:SetLayerFrame(7, 2)
		else
			PostIt:SetLayerFrame(7, 1)
		end
	else
		PostIt:SetLayerFrame(7, 0)
	end
	
	if Notes.GreedMode.Unlock then
		if Notes.GreedMode.Hard then
			PostIt:SetLayerFrame(8, 2)
		else
			PostIt:SetLayerFrame(8, 1)
		end
	else
		PostIt:SetLayerFrame(8, 0)
	end
	
	if Notes.Hush.Unlock then
		if Notes.Hush.Hard then
			PostIt:SetLayerFrame(9, 2)
		else
			PostIt:SetLayerFrame(9, 1)
		end
	else
		PostIt:SetLayerFrame(9, 0)
	end
	
	if Notes.Mother.Unlock then
		if Notes.Mother.Hard then
			PostIt:SetLayerFrame(10, 2)
		else
			PostIt:SetLayerFrame(10, 1)
		end
	else
		PostIt:SetLayerFrame(10, 0)
	end
	
	if Notes.Beast.Unlock then
		if Notes.Beast.Hard then
			PostIt:SetLayerFrame(11, 2)
		else
			PostIt:SetLayerFrame(11, 1)
		end
	else
		PostIt:SetLayerFrame(11, 0)
	end
	
	if Notes.WhackAMole
	or Notes.Haunted
	then
		PostIt2:SetLayerFrame(1, 1)
	else
		PostIt2:SetLayerFrame(1, 0)
	end
	
	if Notes.Delirium.Unlock then
		if Notes.Delirium.Hard then
			PostIt2:SetLayerFrame(0, 2)
		else
			PostIt2:SetLayerFrame(0, 1)
		end
	else
		PostIt2:SetLayerFrame(0, 0)
	end
	
	local TaintedMod = Type == "a" and 0 or 3
	if Notes.Delirium.Unlock then
		if Notes.Delirium.Hard then
			PostIt:SetLayerFrame(0, 2 + TaintedMod)
			PostIt2:SetLayerFrame(0, 2 + TaintedMod)
		else
			PostIt:SetLayerFrame(0, 1 + TaintedMod)
			PostIt2:SetLayerFrame(0, 1 + TaintedMod)
		end
	else
		PostIt:SetLayerFrame(0, 0 + TaintedMod)
		PostIt2:SetLayerFrame(0, 0 + TaintedMod)
	end
	
	PostIt:Update()
	PostIt:Render(TargetV + Offset, g.ZeroV, g.ZeroV)
	PostIt2:Update()
	PostIt2:Render(TargetV + Offset, g.ZeroV, g.ZeroV)
end

menu_dir = {
    main = {
        title = 'Pudding and Wakaba',
		generate = function()
			if enabledInputCallback then
				enabledInputCallback = false
				BackspaceTimer = -15
				enteredCode = ""
			end
		end,
        buttons = {
            {str = 'resume game', action = 'resume'},
            {str = 'settings', dest = 'settings'},
            {str = '', fsize = 2, nosel = true},
			{str = 'post-its', dest = 'completion'},
			{str = 'extras', dest = 'extras'},
			{str = 'cheat codes', dest = 'cheatCodes'},
            {str = '', fsize = 2, nosel = true},
			{str = 'credits', dest = 'credits'},
            {str = '', fsize = 2, nosel = true},
         --   {str = '', fsize = 2, nosel = true},
        },
        tooltip = menuOpenToolTip
    },
    settings = {
        title = 'settings',
        buttons = {
            gamepadToggleButton,
            paletteButton,
        },
        tooltip = menuOpenToolTip
    },
	completion = {
		title = "post-its",
		buttons = {},
		update = function(item, tbl)
			completionRender(g.ZeroV + Vector(-89, 20), save.UnlockData.PlayerJob, "a")
			completionRender(g.ZeroV + Vector(15, 20), save.UnlockData.PlayerJob_B, "b")
		end,
        tooltip = menuOpenToolTip
	},
	extras = {
		title = "extras",
		buttons = {
			{str = '', fsize = 2, nosel = true, displayif = eitherExtrasUnlocked},
			{str = 'Information', dest = 'information', displayif = eitherExtrasUnlocked},
			{str = 'Warning', dest = 'warning', displayif = eitherExtrasUnlocked},
			{str = '', fsize = 2, nosel = true, displayif = eitherExtrasUnlocked},
			{str = 'Extra Randomizer', dest = 'randomizer', displayif = eitherExtrasUnlocked},
			{str = '', fsize = 2, nosel = true, displayif = eitherExtrasUnlocked},
			{str = 'Job Extras', dest = 'extras_m', displayif = jobExtrasUnlocked},
			{str = 'Job Objectives', dest = 'challenges_m', displayif = jobExtrasUnlocked},
			{str = '', fsize = 2, nosel = true, displayif = jobExtrasUnlocked},
			{str = 'T-Job Extras', dest = 'extras_t', displayif = tJobExtrasUnlocked},
			{str = 'T-Job Objectives', dest = 'challenges_t', displayif = tJobExtrasUnlocked},
			{str = '', fsize = 2, nosel = true, displayif = tJobExtrasUnlocked},
			{str = '', fsize = 2, nosel = true, displayif = eitherExtrasUnlocked},
		},
		update = function(item, tbl)
			updateExtras()
		end,
        tooltip = menuOpenToolTip
	},
	information = {
		title = "Information",
		fsize = 2,
		nocursor = true,
		scroller = true,
        buttons = {
			{str = ''},
			{str = 'So, you finally unlocked', clr = 3},
			{str = 'extras? Neat!', clr = 3},
			{str = ''},
			{str = 'This is pretty much where'},
			{str = 'the mod stops being'},
			{str = 'vanilla focused in favor'},
			{str = 'of some extremely wacky'},
			{str = '"fun extras".', clr = 3},
			{str = ''},
			{str = 'Extras are an'},
			{str = 'unlockable feature that'},
			{str = 'basically doubles the'},
			{str = 'content of the mod.'},
			{str = ''},
			{str = 'Complete challenges in'},
			{str = 'the objectives menu'},
			{str = 'to earn points.'},
			{str = ''},
			{str = 'Use these points to'},
			{str = 'unlock extras in the'},
			{str = 'appropiate menus.'},
			{str = ''},
			{str = 'Extras can be used to'},
			{str = 'enable Tainted versions'},
			{str = "of the mod's items"},
			{str = 'and much more!'},
			{str = ''},
			{str = 'Use the Randomizer menu', clr = 3},
			{str = 'to randomly enable or'},
			{str = 'disable any extras at'},
			{str = 'the start of the run'},
			{str = 'for extra variety!'},
			{str = ''},
			{str = 'Upon enabling any extras'},
			{str = 'the Encyclopedia and EID', clr = 3},
			{str = 'descriptions for the mod'},
			{str = 'will be updated to match'},
			{str = "the enabled extras."},
			{str = ''},
		},
		tooltip = menuOpenToolTip
	},
	warning = {
		title = "Warning",
		fsize = 2,
		nocursor = true,
		scroller = true,
        buttons = {
	--		{str = ''},
			{str = 'Extras in the mod'},
			{str = 'can only be enabled'},
			{str = 'in the starting room', clr = 3},
			{str = 'of the run!', clr = 3},
			{str = ''},
			{str = 'Changing extras at'},
			{str = 'any other point of'},
			{str = 'the run will not have'},
			{str = 'them enter in effect'},
			{str = 'until you restart.'},
			{str = ''},
		},
		tooltip = menuOpenToolTip
	},
	randomizer = {
		title = "extra randomizer",
		buttons = {
			{str = '', fsize = 2, nosel = true, displayif = eitherExtrasUnlocked},
			{str = '', fsize = 2, nosel = true, displayif = eitherExtrasUnlocked},
			{str = 'Job Randomizer', dest = 'randomizer_m', displayif = jobExtrasUnlocked},
			{str = '', fsize = 2, nosel = true, displayif = jobExtrasUnlocked},
			{str = 'T-Job Randomizer', dest = 'randomizer_t', displayif = tJobExtrasUnlocked},
			{str = '', fsize = 2, nosel = true, displayif = tJobExtrasUnlocked},
		},
        tooltip = menuOpenToolTip
	},
	randomizer_m = {
		title = "extra randomizer",
		buttons = {},
		update = function(item, tbl)
			useRandomizerMenu()
		end,
	},
	randomizer_t = {
		title = "extra randomizer",
		buttons = {},
		update = function(item, tbl)
			useRandomizerMenu(true)
		end,
	},
	extras_m = {
		title = "extras",
		buttons = {},
		update = function(item, tbl)
			useExtrasMenu()
		end,
	},
	extras_t = {
		title = "extras",
		buttons = {},
		update = function(item, tbl)
			useExtrasMenu(true)
		end,
	},
	challenges_m = {
		title = "objectives",
		buttons = {},
		update = function(item, tbl)
			useObjectivesMenu()
		end,
	},
	challenges_t = {
		title = "objectives",
		buttons = {},
		update = function(item, tbl)
			useObjectivesMenu(true)
		end,
	},
	cheatCodes = {
		title = "cheat codes",
		buttons = {},
		generate = function()
			if not enabledInputCallback then
				enabledInputCallback = true
			end
		end,
		update = function(item, tbl)
			useCheatInput()
		end,
        tooltip = menuOpenToolTip
	},
	credits = {
        title = 'credits',
        fsize = 1,
        buttons = {
			{str = "dev team", nosel = true}
		}
    },
}

local credits = {
    {"agentcucco", "lead coder", tooltip = {"Bootleg", "Kilburn"}},
    {"moddedpan", "lead artist", tooltip = {"Bootleg", "Edmund"}},
    {"klester", "artist"},
    {"deorion", "job's costumes"},
    "",
    "special thanks to",
    "",
    {"mistajub", "trailer music/tester"},
    {"im_tem", "a certain shader"},
    {"deadinfinity", "coding help"},
    {"fer", "tester"},
    {"robby shenanigans", "tester"},
    {"kars", "tester"},
    {"leafea barrett", "tester"},
    {"rdnator555", "tester"},
    {"surrealdude", "funny easter egg"},
	"",
	"",
}

for _, credit in ipairs(credits) do
    if type(credit) == "string" then
        menu_dir.credits.buttons[#menu_dir.credits.buttons + 1] = {str = credit, nosel = true}
    else
        for i, part in ipairs(credit) do
            if i ~= 1 then
                if i == 2 then
                    local button = {strpair = {{str = credit[1]}, {str = part}}}
                    if credit.tooltip then
                        if type(credit.tooltip) == "string" then
                            credit.tooltip = {credit.tooltip}
                        end
                        button.tooltip = {strset = credit.tooltip}
                    end
                    menu_dir.credits.buttons[#menu_dir.credits.buttons + 1] = button
                else
                    menu_dir.credits.buttons[#menu_dir.credits.buttons + 1] = {strpair = {{str = ''}, {str = part}}, nosel = true}
                end
            end
        end
    end
end

local j_directorykey = {
    Item = menu_dir.main,
    Main = 'main',
    Idle = false,
    MaskAlpha = 1,
    Settings = {},
    SettingsChanged = false,
    Path = {},
}

dssmenu.AddMenu("Job Modpack", {
	Run = dssmod.runMenu,
	Open = dssmod.openMenu,
	Close = dssmod.closeMenu,
	Directory = menu_dir,
	DirectoryKey = j_directorykey,
})

dssmod.GetPalette = dssmenu.GetPalette
return dssmod