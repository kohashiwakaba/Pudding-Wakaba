local charDatas = {
	[wakaba.Enums.Players.WAKABA] = {
		Name = "Wakaba",
		--UnlockLink = "wakaba",
		MainDesc = {
			en_us = {

			},
			ko_kr = {
				
			}
		}
		Entries = {
			"gfx/ui/wakaba/char_datas/wakaba_1.png", -- Basis stats
			"gfx/ui/wakaba/char_datas/wakaba_2.png", -- Trivia
			"gfx/ui/wakaba/char_datas/wakaba_3.png", -- Blessing 1
			"gfx/ui/wakaba/char_datas/wakaba_4.png", -- Blessing 2
			"gfx/ui/wakaba/char_datas/wakaba_5.png", -- Unlock overview
			"gfx/ui/wakaba/char_datas/wakaba_6.png", -- Misc
		},
	},
}


----------------------------------------------------------------------------------------------------
-- 
-- DeadInfinity for making the original version of this for Fiend Folio
-- Connor for Samael ver.
local game = wakaba.G
local dssmod = wakaba.DSS_MOD
--local charGroups = {}
local charGroups = charDatas

local arrow = Sprite()
arrow:Load("gfx/ui/contentmanager/group_icons/arrow_icon.anm2", true)

local achievementLockedSprite = Sprite()
achievementLockedSprite:Load("gfx/ui/contentmanager/achievement.anm2", false)
achievementLockedSprite:ReplaceSpritesheet(0, "gfx/contentmanager/nothing.png")
achievementLockedSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
achievementLockedSprite:LoadGraphics()

local achievementTooltipSprites = {
	Shadow = "gfx/ui/contentmanager/group_note/menu_achievement_shadow.png",
	Back = "gfx/ui/contentmanager/group_note/menu_achievement_back.png",
	Face = "gfx/ui/contentmanager/group_note/menu_achievement_face.png",
	Border = "gfx/ui/contentmanager/group_note/menu_achievement_border.png",
	Mask = "gfx/ui/contentmanager/group_note/menu_achievement_mask.png",
}

for k, v in pairs(achievementTooltipSprites) do
	local sprite = Sprite()
	sprite:Load("gfx/ui/contentmanager/group_note/menu_achievement.anm2", false)
	sprite:ReplaceSpritesheet(0, v)
	sprite:LoadGraphics()
	achievementTooltipSprites[k] = sprite
end


local displayIndexToScale = {
	[0] = Vector(1, 1),
	[1] = Vector(0.75, 0.75),
	[2] = Vector(0.5, 0.5),
	[3] = Vector(0, 0),
	[4] = Vector(0, 0)
}

local displayIndexToColor = {
	[0] = lib.NullColor,
	[1] = Color(0.9, 0.9, 0.9, 1, 0, 0, 0),
	[2] = Color(0.8, 0.8, 0.8, 1, 0, 0, 0),
	[3] = Color(0.8, 0.8, 0.8, 0, 0, 0, 0),
	[4] = Color(0, 0, 0, 0, 0, 0, 0)
}

local displayIndexToYPos = {
	[0] = -50,
	[1] = -40,
	[2] = -30,
	[3] = -20,
	[4] = 5000
}




local wakabadirectory = wakaba.DSS_DIRECTORY

wakabadirectory.wakabainfos = {
	format = {
		Panels = {
			{
				Panel = {
					StartAppear = function(panel)
						dssmod.playSound(dssmod.menusounds.Open)
						panel.AppearFrame = 0
						panel.Idle = false
					end,
					UpdateAppear = function(panel)
						if panel.SpriteUpdateFrame then
							panel.AppearFrame = panel.AppearFrame + 1
							if panel.AppearFrame >= 10 then
								panel.AppearFrame = nil
								panel.Idle = true
								return true
							end
						end
					end,
					StartDisappear = function(panel)
						dssmod.playSound(dssmod.menusounds.Close)
						panel.DisappearFrame = 0
					end,
					UpdateDisappear = function(panel)
						if panel.SpriteUpdateFrame then
							panel.DisappearFrame = panel.DisappearFrame + 1
							if panel.DisappearFrame >= 11 then
								return true
							end
						end
					end,
					RenderBack = function(panel, panelPos, tbl)
						local anim, frame = "Idle", 0
						if panel.AppearFrame then
							anim, frame = "AppearVert", panel.AppearFrame
						elseif panel.DisappearFrame then
							anim, frame = "DisappearVert", panel.DisappearFrame
						end

						if panel.ShiftFrame then
							panel.ShiftFrame = panel.ShiftFrame + 1
							if panel.ShiftFrame > panel.ShiftLength then
								panel.ShiftLength = nil
								panel.ShiftFrame = nil
								panel.ShiftDirection = nil
							end
						end

						local item = wakabadirectory.wakabainfos
						local group = charGroups[item.characterselected]
						local numAchievements = #group.Achievements

						local displayedAchievements = {}

						local displayedCount = 7 - 1
						for i = -(displayedCount / 2), displayedCount / 2, 1 do
							local listIndex = #displayedAchievements + 1
							local indexOffset = 0
							local shiftPercent
							if panel.ShiftFrame then
								shiftPercent = panel.ShiftFrame / panel.ShiftLength
								indexOffset = ((1 - shiftPercent) * panel.ShiftDirection)
							end

							local percent = ((listIndex + indexOffset) - 1) / displayedCount
							local xPos = lib.Lerp(-280, 280, percent)

							local scale = displayIndexToScale[math.abs(i)]
							local color = displayIndexToColor[math.abs(i)]
							local yPos = displayIndexToYPos[math.abs(i)]
							if shiftPercent then
								local shiftedScale = displayIndexToScale[math.abs(i + panel.ShiftDirection)]
								scale = lib.Lerp(shiftedScale, scale, shiftPercent)
								local shiftedColor = displayIndexToColor[math.abs(i + panel.ShiftDirection)]
								color = Color.Lerp(shiftedColor, color, shiftPercent)
								local shiftedY = displayIndexToYPos[math.abs(i + panel.ShiftDirection)]
								yPos = lib.Lerp(shiftedY, yPos, shiftPercent)
							end

							local index = (((item.selectedingroup[group.Name] + i) - 1) % numAchievements) + 1
							local achievement = group.Achievements[index]
							displayedAchievements[#displayedAchievements + 1] = {
								Achievement = achievement.Achievement,
								Position = Vector(xPos, yPos),
								Scale = scale,
								Color = color
							}
						end

						table.sort(displayedAchievements, function(a, b)
							return a.Position.Y > b.Position.Y
						end)

						for _, display in ipairs(displayedAchievements) do
							local achievement = display.Achievement
							local useSprite = achievement.Sprite
							if not achievement.Unlocked then
								useSprite = achievementLockedSprite
							end

							useSprite:SetFrame(anim, frame)
							useSprite.Scale = display.Scale
							useSprite.Color = display.Color
							useSprite:Render(panelPos + display.Position + Vector(0, 30), Vector.Zero, Vector.Zero)
						end
					end,
					HandleInputs = function(panel, input, item, itemswitched, tbl)
						if not itemswitched then
							local menuinput = input.menu
							local rawinput = input.raw
							if rawinput.left > 0 or rawinput.right > 0 then
								local group = charGroups[item.characterselected]
								local name = group.Name
								local numAchievements = #group.Achievements


								local change
								if not panel.ShiftFrame then
									local usingInput, setChange
									if rawinput.right > 0 then
										usingInput = rawinput.right
										setChange = 1
									elseif rawinput.left > 0 then
										usingInput = rawinput.left
										setChange = -1
									end

									local shiftLength = 10
									if usingInput >= 88 then
										shiftLength = 7
									end

									if (usingInput == 1 or (usingInput >= 18 and usingInput % (shiftLength + 1) == 0)) then
										change = setChange
										panel.ShiftLength = shiftLength
									end
								end

								if change then
									panel.ShiftFrame = 0
									panel.ShiftDirection = change
									item.selectedingroup[name] = ((item.selectedingroup[name] + change -  1) % numAchievements) + 1
									dssmod.playSound(dssmod.menusounds.Pop3)
								end
							elseif menuinput.down or menuinput.up then
								local change
								if menuinput.down then
									change = 1
								elseif menuinput.up then
									change = -1
								end

								if change then
									local done = false
									while not done do
										item.characterselected = ((item.characterselected + change - 1) % #charGroups) + 1
										local group = charGroups[item.characterselected]
										if not group.DisplayIf or group.DisplayIf() then
											done = true
										end
									end

									dssmod.playSound(dssmod.menusounds.Pop2)
								end
							end
						end
					end
				},
				Offset = Vector.Zero,
				Color = lib.NullColor
			},
			{
				Panel = {
					Sprites = achievementTooltipSprites,
					Bounds = {-115, -22, 115, 22},
					Height = 44,
					TopSpacing = 2,
					BottomSpacing = 0,
					DefaultFontSize = 2,
					DrawPositionOffset = Vector(2, 2),
					Draw = function(panel, pos, item, tbl)
						local drawings = {}
						local group = charGroups[item.characterselected]
						if item.selectedingroup[group.Name] then
							local achievementDat = group.Achievements[item.selectedingroup[group.Name]]
							local achievement = achievementDat.Achievement

							-- Split the name string if its too long.
							local name = achievement.Name
							local name2
							if not achievement.Unlocked then
								name = "locked!"
							elseif string.len(name) > 22 then
								name, name2 = lib.SplitStringInHalf(name)
							end

							local buttons = {
								{str = "- " .. achievementDat.Group .. " -", fsize = 1},
								{str = name, fsize = 2},
							}

							if name2 and name2 ~= "" then
								table.insert(buttons, {str = " "..name2, fsize = 2})
								for _, sprite in pairs(achievementTooltipSprites) do
									sprite.Scale = Vector(1, 1.15)
									sprite.Offset = Vector(0, 3)
								end
							else
								for _, sprite in pairs(achievementTooltipSprites) do
									sprite.Scale = Vector(1, 1)
									sprite.Offset = Vector(0, 0)
								end
							end

							-- Split the tooltip if its too long.
							local tooltip1 = achievement.Tooltip
							local tooltip2
							if string.len(tooltip1) > 40 then
								tooltip1, tooltip2 = lib.SplitStringInHalf(tooltip1)
							end

							if tooltip1 ~= "" then
								table.insert(buttons, {str = tooltip1, fsize = 1})
							end

							if tooltip2 and tooltip2 ~= "" then
								table.insert(buttons, {str = " "..tooltip2, fsize = 1})
							end

							if achievement.ViewerTooltip then
								for _, str in ipairs(achievement.ViewerTooltip) do
									table.insert(buttons, {str = str, fsize = 1})
								end
							end

							local drawItem = {
								valign = -1,
								buttons = buttons
							}
							drawings = dssmod.generateMenuDraw(drawItem, drawItem.buttons, pos, panel.Panel)
						end

						if group then
							if group.Icon then
								table.insert(drawings, {type = "spr", pos = Vector(-96, 1), sprite = group.Icon, noclip = true, root = pos, usemenuclr = true})
							end
							table.insert(drawings, {type = "spr", pos = Vector(-96, -14), anim = "Idle", frame = 0, sprite = arrow, noclip = true, root = pos, usemenuclr = true})
							table.insert(drawings, {type = "spr", pos = Vector(-96, 16), anim = "Idle", frame = 1, sprite = arrow, noclip = true, root = pos, usemenuclr = true})
						end

						for i, drawing in ipairs(drawings) do
							dssmod.drawMenu(tbl, drawing)
						end
					end,
					DefaultRendering = true
				},
				Offset = Vector(0, 100),
				Color = 1
			}
		}
	},
	generate = function(item, tbl)
		charGroups = {}
		local groupsRef = {}
		for character, charData in pairs(charGroups) do
			if not groupsRef[character] then
				local groupTab = {
					Name = charData.Name,
					Tag = charData.Name,
					Achievements = {},
					UnlockGroupId = ContentManager.UnlockGroupId[group] or 0,
				}
			end
		end
		
		for class, subCatalog in pairs(ContentManager.CATALOG) do
			for key, itemData in pairs(subCatalog) do
				local unlockData = itemData.Unlockable
				if unlockData then
					local group = unlockData.Group
					if not group or group == "" then
						group = ContentManager.MiscUnlockGroup
					end
					if not groupsRef[group] then
						local groupTab = {
							Name = group,
							Tag = group,
							Achievements = {},
							UnlockGroupId = ContentManager.UnlockGroupId[group] or 0,
						}
						local sprite = Sprite()
						sprite:Load("gfx/ui/contentmanager/group_icons/group_icon.anm2", false)
						sprite:ReplaceSpritesheet(0, ContentManager.UnlockGroupIcons[group] or "gfx/ui/contentmanager/group_icons/icon_misc.png")
						sprite:LoadGraphics()
						sprite:SetFrame("Idle", 0)
						groupTab.Icon = sprite
						table.insert(charGroups, groupTab)
						groupsRef[group] = groupTab
						item.selectedingroup[group] = 1
					end
					local sprite = Sprite()
					sprite:Load("gfx/ui/contentmanager/achievement.anm2", true)
					sprite:ReplaceSpritesheet(2, unlockData.AchievementGraphic)
					sprite:LoadGraphics()
					sprite:Play("Idle", true)
					local achievement = {
						Name = string.lower(itemData.Name),
						Sprite = sprite,
						Unlocked = unlockData.Unlocked,
						--Tooltip = {string.lower(unlockData.UnlockConditions.Desc or "empty")},
						--Tooltip = lib.SplitDssString(unlockData.UnlockConditions.Desc or "???", 30),
						--Tooltip = lib.StrSplit(unlockData.UnlockConditions.Desc or "???"),
						Tooltip = string.lower(unlockData.UnlockConditions.Desc) or "???",
					}
					table.insert(groupsRef[group].Achievements, {
						Achievement = achievement,
						Group = group,
						InternalID = itemData.CatalogID,
					})
				end
			end
		end
		
		table.sort(charGroups, function(a,b)
			if a.UnlockGroupId < 1 or b.UnlockGroupId < 1 then
				return a.UnlockGroupId > b.UnlockGroupId
			end
			return a.UnlockGroupId < b.UnlockGroupId
		end)
		
		for _, achGroup in pairs(charGroups) do
			table.sort(achGroup.Achievements, function(a,b)
				return a.InternalID < b.InternalID
			end)
		end
	end,
	characterselected = 1,
	selectedingroup = {}
}





















----------------------------------------------------------------------------------------------------