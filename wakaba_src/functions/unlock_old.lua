
function wakaba:PreUnlockCheck()
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_BEAST, -1, -1, false, false)) do
		hasBeast = true
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.PreUnlockCheck)

function wakaba:HasBeast()
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_BEAST, -1, -1, false, false)) do
		return true
	end
	return false
end

function wakaba:UnlockConvert(playerType)
	if playerType == Isaac.GetPlayerTypeByName("Wakaba", false) then
	elseif playerType == Isaac.GetPlayerTypeByName("WakabaB", true) then
	end
end

wakaba.validtainted = {
	wakaba.Enums.Players.WAKABA,
	wakaba.Enums.Players.WAKABA_B,
	wakaba.Enums.Players.SHIORI,
	wakaba.Enums.Players.SHIORI_B,
	wakaba.Enums.Players.TSUKASA,
	wakaba.Enums.Players.TSUKASA_B,
	wakaba.Enums.Players.RICHER,
	wakaba.Enums.Players.RICHER_B,
	wakaba.Enums.Players.RIRA,
	wakaba.Enums.Players.RIRA_B,
}
wakaba.taintedsprite = {
	[wakaba.Enums.Players.WAKABA] = "gfx/characters/costumes/character_wakabab.png",
	[wakaba.Enums.Players.WAKABA_B] = "gfx/characters/costumes/character_wakaba.png",
	[wakaba.Enums.Players.SHIORI] = "gfx/characters/costumes/character_shiorib.png",
	[wakaba.Enums.Players.SHIORI_B] = "gfx/characters/costumes/character_shiori.png",
	[wakaba.Enums.Players.TSUKASA] = "gfx/characters/costumes/character_tsukasab.png",
	[wakaba.Enums.Players.TSUKASA_B] = "gfx/characters/costumes/character_tsukasa.png",
	[wakaba.Enums.Players.RICHER] = "gfx/characters/costumes/character_richerb.png",
	[wakaba.Enums.Players.RICHER_B] = "gfx/characters/costumes/character_richer.png",
	[wakaba.Enums.Players.RIRA] = "gfx/characters/costumes/character_rirab.png",
	[wakaba.Enums.Players.RIRA_B] = "gfx/characters/costumes/character_rira.png",
}


--[[
	Tainted Character unlock code from AgentCucco(Job)
	Normally, the player is defined through for i = 0, wakaba.G:GetNumPlayers() -1 , then Isaac.GetPlayer(i).
	But this function used Isaac.GetPlayer(0) on purpose as Tainted unlock only works for first player even with vanilla characters.
 ]]
function wakaba:Effect_TaintedWakabaReady()
	local player = Isaac.GetPlayer(0)
	wakaba:GetPlayerEntityData(player)
	local ptype = Isaac.GetPlayer(0):GetPlayerType()

	if wakaba:has_value(wakaba.validtainted, ptype) and not player:GetData().wakaba.taintedtouched then
		if wakaba.G:GetLevel():GetCurrentRoomDesc().Data.Name == "Closet L" then
			local ents = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
			local ents2 = Isaac.FindByType(EntityType.ENTITY_SHOPKEEPER)
			if #ents + #ents2 > 0 then
				for _, e in ipairs(ents) do
					--local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, e.Position, Vector.Zero, player)
					e:Remove()
				end
				for _, e in ipairs(ents2) do
					--local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, e.Position, Vector.Zero, player)
					e:Remove()
				end
			end
			local tents = Isaac.FindByType(EntityType.ENTITY_SLOT, 14)
			if #tents > 0 then
				for _, e in ipairs(tents) do
					if wakaba.runstate.lockedcharacter then
						e:Remove()
					else
						local sprite = e:GetSprite()
						local edata = e:GetData()
						if edata.wakaba and edata.wakaba.tready then
							if sprite:IsFinished("PayPrize") then
								player:GetData().wakaba.taintedtouched = true
								if not wakaba.state.unlock.taintedtsukasa and edata.wakaba.ptype and edata.wakaba.ptype == wakaba.Enums.Players.TSUKASA then
									wakaba.state.unlock.taintedtsukasa = true
									if REPENTOGON then
										Isaac.GetPersistentGameData():TryUnlock(wakaba.RepentogonUnlocks.taintedtsukasa)
									else
										CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.taintedtsukasa)
									end
								elseif not wakaba.state.unlock.taintedricher and edata.wakaba.ptype and edata.wakaba.ptype == wakaba.Enums.Players.RICHER then
									wakaba.state.unlock.taintedricher = true
									if REPENTOGON then
										Isaac.GetPersistentGameData():TryUnlock(wakaba.RepentogonUnlocks.taintedricher)
									else
										CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.taintedricher)
									end
								elseif not wakaba.state.unlock.taintedrira and edata.wakaba.ptype and edata.wakaba.ptype == wakaba.Enums.Players.RIRA then
									wakaba.state.unlock.taintedrira = true
									if REPENTOGON then
										Isaac.GetPersistentGameData():TryUnlock(wakaba.RepentogonUnlocks.taintedrira)
									else
										CCO.AchievementDisplayAPI.PlayAchievement(wakaba.achievementsprite.taintedrira)
									end
								else
									for i = 0, wakaba.G:GetNumPlayers() - 1 do
										Isaac.GetPlayer(i):AddCollectible(CollectibleType.COLLECTIBLE_INNER_CHILD)
									end
								end
							end
						end
						edata.wakaba = edata.wakaba or {}
						edata.wakaba.tready = true
						edata.wakaba.ptype = ptype
						sprite:ReplaceSpritesheet(0, wakaba.taintedsprite[ptype])
						sprite:LoadGraphics()
					end
				end
			elseif not wakaba.runstate.lockedcharacter then
				local ne = Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, wakaba.G:GetRoom():GetCenterPos(), Vector.Zero, nil)
				ne:GetData().wakaba = {}
				ne:GetData().wakaba.tready = true
				ne:GetData().wakaba.ptype = ptype
				ne:GetSprite():ReplaceSpritesheet(0, wakaba.taintedsprite[ptype])
				ne:GetSprite():LoadGraphics()
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, wakaba.Effect_TaintedWakabaReady)
