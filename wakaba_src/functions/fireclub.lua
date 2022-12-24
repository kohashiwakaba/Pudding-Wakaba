--[[ 
Fire Club function by J.D
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")
wakaba.scanforclub = false
local clubTargetParents = {

}
local clubScales = {

}

function wakaba:FireClub(player, direction, options, targetParent, scale)
	if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) and player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN and player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN_B then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_NOTCHED_AXE)
		wakaba:scheduleForUpdate(function()
			player:UseActiveItem(CollectibleType.COLLECTIBLE_NOTCHED_AXE)
		end, 0)
	end
	local playerData = wakaba:GetPlayerEntityData(player)
	playerData.clubOptions = options
	clubScales[tostring(isc:getPlayerIndex(player))] = scale
	if targetParent then
		clubTargetParents[tostring(isc:getPlayerIndex(player))] = targetParent
	end

	if direction then
		player:GetData().wakaba_InputHook = wakaba.directiontoshootdirection[direction]
	else
		player:GetData().wakaba_InputHook = -1
	end
	player:SetShootingCooldown(0)
	wakaba.scanforclub = true
end

wakaba.directiontoshootdirection = {
	[Direction.LEFT] = ButtonAction.ACTION_SHOOTLEFT,
	[Direction.UP] = ButtonAction.ACTION_SHOOTUP,
	[Direction.RIGHT] = ButtonAction.ACTION_SHOOTRIGHT,
	[Direction.DOWN] = ButtonAction.ACTION_SHOOTDOWN
}

wakaba:AddCallback(ModCallbacks.MC_INPUT_ACTION, function(_, entity, hook, action)
	if wakaba.scanforclub then
		if entity and entity:GetData().wakaba_InputHook and action == entity:GetData().wakaba_InputHook and entity:ToPlayer() then
			return true
		end
	end
end, InputHook.IS_ACTION_PRESSED)

wakaba:AddCallback(ModCallbacks.MC_INPUT_ACTION, function(_, entity, hook, action)
	if wakaba.scanforclub then
		if entity and entity:GetData().wakaba_InputHook and action == entity:GetData().wakaba_InputHook and entity:ToPlayer() then
			return 2
		end
	end
end, InputHook.GET_ACTION_VALUE)

wakaba:AddCallback(ModCallbacks.MC_POST_KNIFE_INIT, function(_, knife)
	if knife.Variant == 9 then
		if knife.SubType == 4 then
			local player = wakaba:getPlayerFromKnife(knife)
			if wakaba.scanforclub then
				if player:GetData().wakaba_InputHook and knife.Position:Distance(player.Position) < 20 then
					local playerData = wakaba:GetPlayerEntityData(player)
					local playerIndex = tostring(isc:getPlayerIndex(player))
					local options = playerData.clubOptions or wakaba.ClubOptions.General
					knife:GetData().wakaba_customclub = true
					knife:GetData().wakaba_customcluboptions = playerData.clubOptions
					local knifeOptions = knife:GetData().wakaba_customcluboptions
					knife:AddTearFlags(knifeOptions.tearFlags or TearFlags.TEAR_NORMAL)
					if knifeOptions.knifeGfx then
						knife:GetSprite():Load(knifeOptions.knifeGfx,true)
					end
					if knifeOptions.collisionMulti then
						knife.Scale = knife.Scale * knifeOptions.sizeMulti
						knife:SetSize(knife.Scale, Vector(knifeOptions.collisionMulti, knifeOptions.collisionMulti), 2)
					end
					if clubTargetParents[playerIndex] then
						knife.Parent = clubTargetParents[playerIndex]
						clubTargetParents[playerIndex] = nil
					end
					if clubScales[playerIndex] then
						knife.Scale = clubScales[playerIndex]
						clubScales[playerIndex] = nil
					end

					player:GetData().wakaba_grabbedclub = knife
					wakaba.scanforclub = false
					playerData.clubOptions = nil
					player:GetData().wakaba_InputHook = nil
					knife.Variant = knifeOptions.knifeVariant or 11 --Setting the variant to 1 (bone club) prevents it from breaking rocks
				end
			elseif player:GetData().wakaba_grabbedclub and player:GetData().wakaba_grabbedclub:Exists() then
				knife.Variant = (knife:GetData().wakaba_customcluboptions and knife:GetData().wakaba_customcluboptions.knifeVariant) or 11
			end
		elseif wakaba.scanforclub then
			knife.Visible = false
		end
	end
end)

--For testing!
--[[ wakaba:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, function(_, tear)
	local player = wakaba:GetPlayerFromTear(tear)
	tear:Remove()
	wakaba:FireClub(player, player:GetFireDirection())
end) ]]